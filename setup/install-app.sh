# build and install the application

PACKAGE="NYX"
# make a lower case version of the package 
PACKAGEDIR=`echo "$PACKAGE" | awk '{print tolower($0)}'`

echo "--------------------------------------------------"
echo "PTN: building $PACKAGE"
echo "--------------------------------------------------"

pushd $PANTHEON_WORKFLOW_DIR

# set up spack
# . spack/share/spack/setup-env.sh

module load gcc/6.4.0
module load cuda/10.2.89
    # to match spack build of ascent
# module load cuda/10.1.243 
# module load cmake/3.14.2
# module load hdf5/1.8.18

# Commits
NYX_COMMIT=20.04-494-g694daae
AMREX_COMMIT=20.07-45-g6f2e60118

mkdir $PACKAGEDIR 
pushd $PACKAGEDIR

# AMREX
git clone --branch development https://github.com/AMReX-Codes/amrex.git
pushd amrex
git checkout $AMREX_COMMIT
popd

# NYX
git clone --branch development https://github.com/AMReX-Astro/Nyx.git
pushd Nyx
git checkout $NYX_COMMIT
popd

pushd Nyx/Exec/LyA

    # this does not work
ASCENT=$(spack find -p ascent)
ASCENT_INSTALL_DIR=${ASCENT##* }


echo "--------------------------------------------------"
echo "PTN: ASCENT_INSTALL_DIR $ASCENT_INSTALL_DIR"
echo "--------------------------------------------------"

make -j12  \
        USE_CUDA=TRUE \
        USE_ASCENT_INSITU=TRUE \
        COMP=gnu \
        NO_HYDRO=TRUE \
        USE_HEATCOOL=FALSE \
        ASCENT_HOME=$ASCENT_INSTALL_DIR
popd
popd
popd
