# lincryption

File encyption and decription in oneline


Setup:

```sh
echo "mypassword" ${HOME}/.linpass
chmod +x bin/fencrypt.sh
chmod +x bin/fdecrypt.sh
export PATH=${PATH}:$(pwd)/bin
```

Usage:
```sh
#ENCRYPTION:
fencrypt.sh <input_file>

#DECRYPTION - TODO:
fdecrypt.sh <input_file>
```


TODO - batch version, with no password prompt