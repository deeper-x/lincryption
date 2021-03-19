# lincryption

Bash utility for file encryption/decryption.
Lincryption simply reads your private 

Setup:
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
Encrypting file.
Waiting for password...
Deleting clean file...
/usr/bin/shred: assets/demo.txt: pass 1/4 (random)...
/usr/bin/shred: assets/demo.txt: pass 2/4 (random)...
/usr/bin/shred: assets/demo.txt: pass 3/4 (random)...
/usr/bin/shred: assets/demo.txt: pass 4/4 (000000)...
/usr/bin/shred: assets/demo.txt: removing
/usr/bin/shred: assets/demo.txt: renamed to assets/00000000
/usr/bin/shred: assets/00000000: renamed to assets/0000000
/usr/bin/shred: assets/0000000: renamed to assets/000000
/usr/bin/shred: assets/000000: renamed to assets/00000
/usr/bin/shred: assets/00000: renamed to assets/0000
/usr/bin/shred: assets/0000: renamed to assets/000
/usr/bin/shred: assets/000: renamed to assets/00
/usr/bin/shred: assets/00: renamed to assets/0
/usr/bin/shred: assets/demo.txt: removed
Written assets/demo.txt.gpg.
Operation completed!

#ENCRYPTION VERIFICATION
$ ls assets/demo.txt.gpg 
assets/demo.txt.gpg
$ file assets/demo.txt.gpg 
assets/demo.txt.gpg: GPG symmetrically encrypted data (AES256 cipher)
```

Usage - Decryption:
```sh
#DECRYPTION
$ fdecrypt assets/demo.txt.gpg 
Reading assets/demo.txt.gpg...
Decrypting file.
Waiting for password...
gpg: AES256 encrypted data
gpg: encrypted with 1 passphrase
Deleting encrypted file...
/usr/bin/shred: assets/demo.txt.gpg: pass 1/4 (random)...
/usr/bin/shred: assets/demo.txt.gpg: pass 2/4 (random)...
/usr/bin/shred: assets/demo.txt.gpg: pass 3/4 (random)...
/usr/bin/shred: assets/demo.txt.gpg: pass 4/4 (000000)...
/usr/bin/shred: assets/demo.txt.gpg: removing
/usr/bin/shred: assets/demo.txt.gpg: renamed to assets/000000000000
/usr/bin/shred: assets/000000000000: renamed to assets/00000000000
/usr/bin/shred: assets/00000000000: renamed to assets/0000000000
/usr/bin/shred: assets/0000000000: renamed to assets/000000000
/usr/bin/shred: assets/000000000: renamed to assets/00000000
/usr/bin/shred: assets/00000000: renamed to assets/0000000
/usr/bin/shred: assets/0000000: renamed to assets/000000
/usr/bin/shred: assets/000000: renamed to assets/00000
/usr/bin/shred: assets/00000: renamed to assets/0000
/usr/bin/shred: assets/0000: renamed to assets/000
/usr/bin/shred: assets/000: renamed to assets/00
/usr/bin/shred: assets/00: renamed to assets/0
/usr/bin/shred: assets/demo.txt.gpg: removed
Written assets/demo.txt.
Operation completed!

#READING DECRYPTED DATA
$ ls assets/
demo.txt
$ cat assets/demo.txt 
hello, my secret data!
```