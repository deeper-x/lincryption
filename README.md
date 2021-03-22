# Lin Cryption - AES256

Bash utility for AES256 file encryption/decryption, based on GnuPG (GPG) and shred (bash coreutils).

It's as simple as:
```sh
# ENCRYPT - create myfile.txt.gpg 
$ fencrypt myfile.txt

# DECRYPT - create myfile.txt
$ fdecrypt myfile.txt.gpg
```
No esoterics flags, no low-level complications: just 2 commands, encrypt & decrypt.

It can be used in:
1. DevOps / batch scripts
2. external software, consuming its interfaces ```fencrypt <filename>``` and ```fdecrypt <filename>``` 
3. CLI interactive sessions (e.g. handling docs with private/sensitive data stored in non-secure directories)
4. GUIs / Desktop Environments, e.g. setting file associations or "Open with..." (extension .gpg -> fdecrypt, etc..)  

System requirements:
```sh
$ bash --version
GNU bash, version 5.0.17(1)-release (x86_64-pc-linux-gnu)

$ gpg --version
gpg (GnuPG) 2.2.20
libgcrypt 1.8.5

$ shred --version
shred (GNU coreutils) 8.32
```

First setup:
```sh
#STEP 1: configuring key, we're about to use symmetric encryption
echo "DUMMYP4SSWD" > ${HOME}/.linpass
chmod 0400 ${HOME}/.linpass

#STEP 2: making bins executable
chmod +x bin/fencrypt
chmod +x bin/fdecrypt

#STEP 3: making bins available
export PATH=${PATH}:$(pwd)/bin
```

Usage - Encryption:
```sh
#ENCRYPTION:
$ fencrypt assets/demo.txt 
Reading assets/demo.txt...
File encryption...success
Cleanin up...success
Result: assets/demo.txt.gpg.
```

Usage - Decryption:
```sh
#DECRYPTION
$ fdecrypt assets/demo.txt.gpg 
Reading assets/demo.txt.gpg...
Decrypting file...
gpg: AES256 encrypted data
gpg: encrypted with 1 passphrase
Cleaning up...
Result: assets/demo.txt

#READING DECRYPTED DATA
$ ls assets/
demo.txt
$ cat assets/demo.txt 
hello, my secret data!
```

Test:
```sh
$ bash test.sh 
+ set -o nounset
+ declare -r PASSFILE=/home/deeper-x/.linpass
+ declare -r SUCCESS_MSG=success
+ declare -r FAILURE_MSG=failed
++ command -v gpg
+ declare -r GPG=/usr/bin/gpg
++ command -v shred
+ declare -r SHRED=/usr/bin/shred
+ declare -i EXIT_OK=0
+ declare -i PASSFILE_ERR=101
+ declare -i GPGMISSING_ERR=102
+ declare -i FILEMISSING_ERR=103
+ declare -i INPUTNOTAFILE_ERR=104
+ declare -i SHREDMISSING_ERR=105
+ declare -i ENC_GENERIC_ERR=106
+ declare -i DEL_GENERIC_ERR=107
+ main ./assets/28887.txt
+ '[' '!' -x /usr/bin/gpg ']'
+ '[' '!' -x /usr/bin/shred ']'
+ '[' 1 -eq 0 ']'
+ i_file=./assets/28887.txt
+ o_file=./assets/28887.txt.gpg
+ echo 'Reading ./assets/28887.txt...'
Reading ./assets/28887.txt...
+ '[' '!' -f ./assets/28887.txt ']'
+ '[' '!' -f /home/deeper-x/.linpass ']'
+ echo -n 'File encryption...'
File encryption...++ cat /home/deeper-x/.linpass
+ /usr/bin/gpg --batch --output ./assets/28887.txt.gpg --passphrase DUMMYP4SSWD --symmetric ./assets/28887.txt
+ '[' 0 -eq 0 ']'
+ echo success
success
+ echo -n 'Cleaning up...'
Cleaning up...+ /usr/bin/shred -zu -n 3 ./assets/28887.txt
+ '[' 0 -eq 0 ']'
+ echo success
success
+ echo 'Encrypted file: ./assets/28887.txt.gpg.'
Encrypted file: ./assets/28887.txt.gpg.
+ return 0
+ set -o nounset
+ declare -r PASSFILE=/home/deeper-x/.linpass
+ declare -r SUCCESS_MSG=success
+ declare -r FAILURE_MSG=failed
++ command -v gpg
+ declare -r GPG=/usr/bin/gpg
++ command -v shred
+ declare -r SHRED=/usr/bin/shred
+ declare -i EXIT_OK=0
+ declare -i PASSFILE_ERR=101
+ declare -i GPGMISSING_ERR=102
+ declare -i FILEMISSING_ERR=103
+ declare -i INPUTNOTAFILE_ERR=104
+ declare -i SHREDMISSING_ERR=105
+ declare -i DEC_GENERIC_ERR=106
+ declare -i DEL_GENERIC_ERR=107
+ main ./assets/28887.txt.gpg
+ '[' '!' -x /usr/bin/gpg ']'
+ '[' 1 -eq 0 ']'
+ i_file=./assets/28887.txt.gpg
+ o_file=./assets/28887.txt
+ echo 'Reading ./assets/28887.txt.gpg...'
Reading ./assets/28887.txt.gpg...
+ '[' '!' -f ./assets/28887.txt.gpg ']'
+ '[' '!' -f /home/deeper-x/.linpass ']'
+ echo 'Decrypting file...'
Decrypting file...
++ cat /home/deeper-x/.linpass
+ /usr/bin/gpg --output ./assets/28887.txt --passphrase DUMMYP4SSWD --decrypt --batch ./assets/28887.txt.gpg
gpg: AES256 encrypted data
gpg: encrypted with 1 passphrase
+ '[' 0 -eq 0 ']'
+ echo success
success
+ echo -n 'Cleaning up...'
Cleaning up...+ /usr/bin/shred -zu -n 3 ./assets/28887.txt.gpg
+ '[' 0 -eq 0 ']'
+ echo success
success
+ echo 'Decrypted file: ./assets/28887.txt'
Decrypted file: ./assets/28887.txt
+ return 0
Test result:SUCCESS
```

### TODO
1. scan for all files in input directory
2. check for input file extensions



Ref:
1. https://www.gnu.org/software/bash/
2. https://man7.org/linux/man-pages/man1/shred.1.html
3. https://linux.die.net/man/1/gpg
