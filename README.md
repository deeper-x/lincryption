# lincryption

File encyption and decription in oneline


Setup:

```sh
echo "mypassword" ${HOME}/.mypass
chmod +x fencrypt.sh
chmod +x fdecrypt.sh
export PATH=${PATH}:$(pwd)
```

Usage:
```sh
#ENCRYPTION:
fencrypt.sh <input_file>

#DECRYPTION - TODO:
fdecrypt.sh <input_file>
```


TODO - batch version, with no password prompt