# xwing-overlay

This is my personal overlay

Stuf I need, stuff I test…

The preferred way to sync this repository is using rsync (either manual or layman install). The rsync version has the advantage to be cleanned from distfiles and specific files not needed by portage, and it comes with portage metadata. It’s updated every hour from git, so it’s perfectly fine considering my own commit rate.

## Install

### Manually

```
$ cat <<EOF > /etc/portage/repos.conf/xwing.conf
[xwing]
priority = 50
location = /var/db/repos/xwing
sync-type = rsync
sync-uri = rsync://gentoo.xwing.info/xwing-overlay
auto-sync = yes
EOF
```

### With layman

```
$ layman -a xwing
```

### Clone

You can clone the repository, **BUT**:
* it comes with the binary distfiles (LFS) you do not need
* it has no metadata

```
$ git clone https://git.xwing.info/casta/portage.git
```
