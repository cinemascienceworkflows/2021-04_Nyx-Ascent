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
module load cuda/10.1.168 
module load cmake/3.14.2
    # to match spack build of ascent
# module load cuda/10.1.243 
# module load cmake/3.14.2
# module load hdf5/1.8.18

# Commits
# NYX_COMMIT=20.04-494-g694daae
# 21.07
NYX_BRANCH=21.07
# AMREX_COMMIT=20.07-45-g6f2e60118
# 20.11
# AMREX_COMMIT=43f112fe4b9deda918f3d3961d2979e124d0645d

mkdir $PACKAGEDIR 
pushd $PACKAGEDIR

# AMREX
# git clone --branch development https://github.com/AMReX-Codes/amrex.git
# pushd amrex
# git checkout $AMREX_COMMIT
# popd

# NYX
# git clone --branch development https://github.com/AMReX-Astro/Nyx.git
git clone --recursive https://github.com/AMReX-Astro/Nyx.git --branch $NYX_BRANCH 
# pushd Nyx
# git checkout $NYX_COMMIT
# popd

pushd Nyx/subprojects/sundials

mkdir builddir 
mkdir instdir
INSTALL_PREFIX=$(pwd)/instdir

ASCENT=$(spack find -p ascent)
ASCENT_INSTALL_DIR=${ASCENT##* }

cd builddir
cmake \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}  \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
    -DCMAKE_C_COMPILER=$(which gcc)  \
    -DCMAKE_CXX_COMPILER=$(which g++)   \
    -DCMAKE_CUDA_HOST_COMPILER=$(which g++)    \
    -DEXAMPLES_INSTALL_PATH=${INSTALL_PREFIX}/examples \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CUDA_FLAGS="-DSUNDIALS_DEBUG_CUDA_LASTERROR" \
    -DSUNDIALS_BUILD_PACKAGE_FUSED_KERNELS=ON \
    -DCMAKE_C_FLAGS_RELEASE="-O3 -DNDEBUG" \
    -DCMAKE_CXX_FLAGS_RELEASE="-O3 -DNDEBUG"  \
    -DCUDA_ENABLE=ON  \
    -DMPI_ENABLE=OFF  \
    -DOPENMP_ENABLE=ON   \
    -DF2003_INTERFACE_ENABLE=OFF   \
    -DSUNDIALS_INDEX_SIZE:INT=32   \
    -DCUDA_ARCH=sm_70 ../

make -j8 \
        ASCENT_HOME=$ASCENT_INSTALL_DIR

make install -j8

cd ../../../../
 
# Build using the makefile which sets up ascent and the version of sundials build above

cd Nyx/Exec/LyA

module load cuda/10.1.168 
module load gcc/6.4.0

make -j12 \
	-f GNUmakefile.summit \
	SUNDIALS_ROOT=$(pwd)/../../subprojects/sundials/instdir \
        ASCENT_HOME=$ASCENT_INSTALL_DIR


# echo "--------------------------------------------------"
# echo "PTN: ASCENT_INSTALL_DIR $ASCENT_INSTALL_DIR"
# echo "--------------------------------------------------"

popd
popd
popd


