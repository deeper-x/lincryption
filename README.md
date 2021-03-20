# lincryption

Bash utility for file encryption/decryption, with just two commands. 
It's as simple as

```sh
# ENCRYPT
$ fencrypt input_file.bla
# DECRYPT
$ fdecrypt input_file.bla.gpg
```

Requirements:
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
echo "mypassword" > ${HOME}/.linpass
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

### TODO
1. scan for all files in input directory
2. check for input file extensions