# build and install the application

PACKAGE="NYX"
# make a lower case version of the package 
PACKAGEDIR=`echo "$PACKAGE" | awk '{print tolower($0)}'`

echo "--------------------------------------------------"
echo "PTN: building $PACKAGE"
echo "--------------------------------------------------"

pushd $PANTHEON_WORKFLOW_DIR
pushd $PACKAGEDIR

module load gcc/6.4.0
module load cuda/10.1.168 
module load cmake/3.14.2

ASCENT=$(spack find -p ascent)
ASCENT_INSTALL_DIR=${ASCENT##* }

# Build using the makefile which sets up ascent and the version of sundials build above
pushd Nyx/Exec/LyA

module load cuda/10.1.168 
module load gcc/6.4.0

make -j12 \
	-f GNUmakefile.summit \
	SUNDIALS_ROOT=$(pwd)/../../subprojects/sundials/instdir \
        ASCENT_HOME=$ASCENT_INSTALL_DIR

popd
popd
popd


