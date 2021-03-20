#!/bin/bash
set -o nounset

# var declaration
declare -r OK_CONTENT="success"
declare -r ROOT_DIR="./assets"
declare -i FILE_NAME=${RANDOM}
declare -r TEST_DEC_FILE="${FILE_NAME}.txt"
declare -r TEST_ENC_FILE="${FILE_NAME}.txt.gpg"
declare -r DEC_PATH="${ROOT_DIR}/${TEST_DEC_FILE}"
declare -r ENC_PATH="${ROOT_DIR}/${TEST_ENC_FILE}"
declare -r SUCCESS_MSG="SUCCESS"
declare -r FAIL_MSG="ERROR"

# exit status
declare -i TEST_OK=0
declare -i CREATION_FILE_ERR=101
declare -i TEST_FAILS=102

function test {
    # STEP 1: creating test file
    echo ${OK_CONTENT} > ${DEC_PATH}

    # STEP 2: running encryption
    bash -x fencrypt ${DEC_PATH}

    # STEP 3: running decryption
    bash -x fdecrypt ${ENC_PATH}

    # STEP 4: check for file content
    content=$( cat ${DEC_PATH} )

    # STEP 5: delete test files
    cleanup

    # STEP 6: status check
    if [[ ${OK_CONTENT} == ${content} ]];then
        return ${TEST_OK}
    else
        return ${TEST_FAILS}
    fi
}

# default file test clean up 
function cleanup { 
    rm -f ${DEC_PATH}
    rm -f ${ENC_PATH}
}

# run test    
test

# check result
echo -n "Test result:"
if [ $? -eq 0 ];then
    echo ${SUCCESS_MSG}
else
    echo ${FAIL_MSG}
fi