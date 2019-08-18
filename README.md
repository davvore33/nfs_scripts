# NFS Encrypted Scritps
## A small utility to open and close easily an encrypted file on your nfs (or whatever remote mounted folder)

# How does it work

Please add your "keyfile" in the project root to let the suite work

As you can see in file `open.sh` I assume that you're mounting your remote folder in `/mnt/nas`,
I'm also going to use `dm_name` as mapped name after opening the sec folder
```
nas_mountp="/mnt/nas"
dm_name="dm_nas"
keyfile_path="./keyfile"
secpartition_path="$nas_mountp/sec"
```

## How to create the needed files

I'm referring to the Archwiki:

- keyfile

I've created it using `dd if=/dev/urandom of=./keyfile bs=1kB count=1`, this will give you a keyfile of 1000B

- sec

which is the encrypted file, I've created it following this steps

```
dd if=/dev/zero of=./sec bs=2MB count=51200
cryptosetup lucksFormat --key-file ./keyfile ./sec
```

Than you should also create the needed folders
