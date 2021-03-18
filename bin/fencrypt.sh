#!/bin/bash
declare -r PASSFILE=${HOME}"/.linpass"
declare -i EXIT_OK=0
declare -i PASSFILE_ERR=101
declare -i GPGMISSING_ERR=102
declare -i FILEMISSING_ERR=103
declare -i INPUTNOTAFILE_ERR=104
declare -i SHREDMISSING_ERR=105
declare -r GPG=$( command -v gpg )
declare -r SHRED=$( command -v shred )

function fencrypt() {
    #check gpg installation - exit 102
    if [ ! -x ${GPG} ];then
        echo "Missing gpg command"
        return ${GPGMISSING_ERR}
    fi

    #check shred command - exit 105
    if [ ! -x ${SHRED} ];then
        echo "Missing shred command"
        return ${SHREDMISSING_ERR}
    fi

    #check input parameter - exit 103
    if [ $# -eq 0 ];then
        echo "Missing input file (as a parameter)"
        return ${FILEMISSING_ERR}
    fi
    
    # declaring assets
    i_file=${1}
    o_file="${1}.gpg"

    # start reading input
    echo "Reading ${i_file}..."

    #check input is a file - exit 104
    if [ ! -f ${i_file} ];then
        echo "Input parameter is not a file"
        return ${INPUTNOTAFILE_ERR}
    fi

    #check .mypass exists - exit 101 
    if [ ! -f ${PASSFILE} ];then
        echo "Missing password file ${PASSFILE}"
        return ${PASSFILE_ERR}
    fi

    # encryption
    echo "Encrypting file." 
    echo "Waiting for password..."
    ${GPG} --output "${o_file}" --passphrase $( cat ${PASSFILE} ) --symmetric ${i_file}

    echo "Deleting clean file..."
    ${SHRED} -zvu -n 3 ${i_file}

    echo -e "Written ${o_file}.\nOperation completed!"
    return ${EXIT_OK}
}

fencrypt ${1}
    