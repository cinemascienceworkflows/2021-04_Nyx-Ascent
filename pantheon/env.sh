# ----------------------------------------------------------------------
# Pantheon environment file
# ----------------------------------------------------------------------

source bootstrap.env


# read values from pantheon file
export PANTHEON_PROJECT=`awk '/project_name/{print $NF}' pantheon/pantheon.yaml` 
export PANTHEON_WORKFLOW_ID=`awk '/workflow_name/{for (i=2; i<NF; i++) printf $i "_"; if (NF >= 2) print $NF; }' pantheon/pantheon.yaml` 
    # create the job id - a lower case version of the workflow id
export PANTHEON_WORKFLOW_JID=`echo "$PANTHEON_WORKFLOW_ID" | awk '{print tolower($0)}'`
export PANTHEON_POST_JID=${PANTHEON_WORKFLOW_JID}_post
export PANTHEON_APP=`awk '/workflow_app/{print $NF}' pantheon/pantheon.yaml`
export PANTHEON_CDB=`awk '/workflow_cinema-db/{print $NF}' pantheon/pantheon.yaml`
export PANTHEON_VERSION=`awk '/pantheon_version/{print $NF}' pantheon/pantheon.yaml`

# this instance's directories
export PANTHEON_PATH=$PANTHEON_BASE_PATH/pantheon
export PANTHEON_PROJECT_DIR=$PANTHEON_PATH/$PANTHEON_PROJECT
export PANTHEON_WORKFLOW_DIR=$PANTHEON_PROJECT_DIR/$PANTHEON_WORKFLOW_ID
export PANTHEON_RUN_DIR=$PANTHEON_WORKFLOW_DIR/results
export PANTHEON_DATA_DIR=$PANTHEON_WORKFLOW_DIR/data

# add to the path
# export PATH=$PANTHEON_WORKFLOW_DIR:$PATH
    # add local spack to the path
export PATH=$PANTHEON_WORKFLOW_DIR/spack/bin:$PATH

# print out the environment
echo ----------------------------------------------------------------------
echo Pantheon Environment
echo ----------------------------------------------------------------------
echo PANTHEON_VERSION.....: $PANTHEON_VERSION
echo PANTHEON_PROJECT.....: $PANTHEON_PROJECT
echo PANTHEON_PATH........: $PANTHEON_PATH
echo PANTHEON_PROJECT_DIR.: $PANTHEON_PROJECT_DIR
echo PANTHEON_WORKFLOW_DIR: $PANTHEON_WORKFLOW_DIR
echo PANTHEON_RUN_DIR.....: $PANTHEON_RUN_DIR
echo PANTHEON_DATA_DIR....: $PANTHEON_DATA_DIR
echo PANTHEON_WORKFLOW_ID.: $PANTHEON_WORKFLOW_ID
echo PANTHEON_WORKFLOW_JID: $PANTHEON_WORKFLOW_JID
echo PANTHEON_POST_JID....: $PANTHEON_POST_JID
echo PANTHEON_APP.........: $PANTHEON_APP
echo PANTHEON_CDB.........: $PANTHEON_CDB
echo ----------------------------------------------------------------------
