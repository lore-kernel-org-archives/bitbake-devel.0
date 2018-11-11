Return-Path: <stefanb.linux@gmail.com>
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com
	[209.85.161.45])
	by mail.openembedded.org (Postfix) with ESMTP id EB25A6C0C3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Nov 2018 21:04:12 +0000 (UTC)
Received: by mail-yw1-f45.google.com with SMTP id z72-v6so3698998ywa.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Nov 2018 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=nd9FLnSVx8T4bJAtHkAqGe2a17bL9vgM847tRayp0Zg=;
	b=PxsJ0mJySpkyhb3bNZ4gZ0x5Q9Qnoie0Bj5o1ISJcX4vraffEn1OI9SmX+/ySUgFRw
	p03YLdwIIpAqHSSycxyUQGesTBHSzUfsLt/M8tHfYpxi6Bh/bQKyyMIAfgMa5FAgBb85
	J19tW4v1eFdR8a9Hi3D25U0sKWwiYfIlLc/dTyT+fhhd61USmljxQd+91lfBHSQW1Pzr
	5Q6NrImqpnpEWTJPgXCtx/km+bb2gl2D4whZWZZxbOVv7obInRiAIgT4Js+lnaibmOO1
	o/zjwPyWPobq37Q6uJqyZWl1OCCYleQXA5IV/1cTwZEbP+gHKxjg3dDMz5NLB+WW/itd
	JbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=nd9FLnSVx8T4bJAtHkAqGe2a17bL9vgM847tRayp0Zg=;
	b=FLZVIrKVERtJyMXvHsZahJ2hO5YsRHM6ePd6W/IPV4nQzOxbccDx6T1FxaR8Xc0j6/
	MBnmHKj9yapvnvN5L3ZiD4PB2QXxv90NFJ2WfHQEyz1m2ladowRa2gNggGn0ZtkVyIqC
	UYGNE+18Q8JxEgW0vokEkyJQSmU3WrBzq/Tiq3RW/380Ywu7BGrQUNzjuPG92paZIdeH
	KKAGVIP4+D+GA8wDo3Z6Kcn6F89lUPBiu0sB3rnmkgdokSVak7rsop1uHVA0Tc9Cj/pQ
	LYYtrYE2EOLw+gyxADp4+f0jiuUs1JXD+iHIjpyqVSIh4mS6JWsQVRxcBp6w3gJpR8a3
	jzRg==
X-Gm-Message-State: AGRZ1gJDW6s4IbzRVvixgec6RgDi9T3n5vWDsZU3M2v8Resg6fGKw2YU
	YdNsZSL9/xYNqub26hLnD3C+HD+wMXtUvgFw8Qfy7PcC
X-Google-Smtp-Source: AJdET5eHLLArJbpBkSSy6YgHSRWPuKQMRXYWxfNTvTduEJPFXxGlUZPf8GyiJ/lFSEq2m+bcOp0yEYfYUhLu4TdG4vw=
X-Received: by 2002:a81:498a:: with SMTP id
	w132-v6mr16264877ywa.232.1541970252882; 
	Sun, 11 Nov 2018 13:04:12 -0800 (PST)
MIME-Version: 1.0
From: Stefan Bigler <stefanb.linux@gmail.com>
Date: Sun, 11 Nov 2018 22:04:01 +0100
Message-ID: <CAJPUqK0xt0taHyNP9g_1H4tv3+tsdzeYwvODhOxw1WugfqpGfQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Mon, 12 Nov 2018 14:55:35 +0000
Subject: gitsm fetching fails
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 11 Nov 2018 21:04:13 -0000
Content-Type: multipart/alternative; boundary="0000000000002d6699057a69ed75"

--0000000000002d6699057a69ed75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
I'm updating from rocko to thud and recognized, that my projects with
git-submodules cannot be fetched anymore.
I tried to debug the fetch task, but I failed. I did a small example you
should have access and it should be easy to reproduce, the repo should be
public.
The recipe works fine with rocko but fails with the latest master branch of
poky.
I'm using gitlab for my repos. When I use https it works also with thud,
only when *ssh* is used then it fails.
Below you find the recipe, the console output and the important part of the
log.do_fetch
I hope somebody can give me a hint.
Thanks and Regards
Stefan

Here the recipe for https and shh
-----------------------
SUMMARY =3D "git submodule test"
DESCRIPTION =3D "recipe to test git submodule fetching"
SECTION =3D "testing"
LICENSE =3D "GPLv2"
LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dfcb02dc552a041dee27e4b85c7396067=
"

# fetching module and submodule with https -> works
#SRC_URI =3D "gitsm://
gitlab.com/gitsm/gitsm-test.git;branch=3Daccess-https;protocol=3Dhttps"
#SRCREV    =3D "db15957a23abb6b8bc8ca1dc948a7bd6ef18b6f3"

# fetching module and submodule with ssh -> fails
SRC_URI =3D "gitsm://
git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh"
SRCREV    =3D "5e400c09b7aff9bfdc2aabbb2d1cd07b94fdafec"

PV =3D "1.0+git${SRCPV}"
S =3D "${WORKDIR}/git/"

inherit cmake


Here the console:
-----------------------
Build Configuration:
BB_VERSION           =3D "1.40.0"
BUILD_SYS            =3D "x86_64-linux"
NATIVELSBSTRING      =3D "universal"
TARGET_SYS           =3D "arm-poky-linux-gnueabi"
MACHINE              =3D "beaglebone-yocto"
DISTRO               =3D "poky"
DISTRO_VERSION       =3D "2.6"
TUNE_FEATURES        =3D "arm armv7a vfp neon callconvention-hard cortexa8"
TARGET_FPU           =3D "hard"
meta
meta-poky
meta-yocto-bsp       =3D "master:eddff2b361928e88e3628ebc22a1a0ebb119e01b"

Initialising tasks: 100%
|##########################################################################=
###########################################################################=
###################|
Time: 0:00:00
Sstate summary: Wanted 6 Found 0 Missed 6 Current 72 (0% match, 92%
complete)
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
WARNING: gitsm-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: Failed to fetch
URL gitsm://git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3D=
ssh,
attempting MIRRORS if available
ERROR: gitsm-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: The URL:
'gitsm:Bigler/gitsm-test-submodule.git;protocol=3Dgit@gitlab.com;name=3Dlib=
;bareclone=3D1;nocheckout=3D1;nobranch=3D1'
is invalid and cannot be interpreted
ERROR: gitsm-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: Fetcher failure
for URL: 'gitsm://
git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh'. Unable=
 to
fetch URL from any source.
ERROR: gitsm-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: Function failed:
base_do_fetch
ERROR: Logfile of failure stored in:
/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-l=
inux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/temp/log.do_fetch.2846=
8
ERROR: Task
(/opt/yocto/poky/thud/poky-fetch-gitsm/meta-poky/recipes-testing/gitsm-test=
/gitsm-test_git.bb:do_fetch)
failed with exit code '1'
NOTE: Tasks Summary: Attempted 465 tasks of which 464 didn't need to be
rerun and 1 failed.

Summary: 1 task failed:

/opt/yocto/poky/thud/poky-fetch-gitsm/meta-poky/recipes-testing/gitsm-test/=
gitsm-test_git.bb:
do_fetch
Summary: There was 1 WARNING message shown.
Summary: There were 3 ERROR messages shown, returning a non-zero exit code.

Here the log (sorry it is long):
-------------------------------------
DEBUG: Executing python function clean_recipe_sysroot
DEBUG: Python function clean_recipe_sysroot finished
DEBUG: Executing python function extend_recipe_sysroot
NOTE: Direct dependencies are []
NOTE: Installed into sysroot: []
NOTE: Skipping as already exists in sysroot: []
DEBUG: Python function extend_recipe_sysroot finished
DEBUG: Executing python function do_fetch
DEBUG: Executing python function base_do_fetch
DEBUG: Trying PREMIRRORS
DEBUG: For url ['gitsm', 'gitlab.com', '/gitsm/gitsm-test.git', 'git', '',
OrderedDict([('branch', 'master'), ('protocol', 'ssh')])] comparing ['bzr',
'.*', '/.*', '', '', OrderedDict()] to ['http', 'downloads.yoctoproject.org=
',
'/mirror/sources/', '', '', OrderedDict()]
....
DEBUG: Fetching
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz
using command '/usr/bin/env wget -t 2 -T 30 --passive-ftp
--no-check-certificate -P
/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads '
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz
''
DEBUG: Fetcher accessed the network with the command /usr/bin/env wget -t 2
-T 30 --passive-ftp --no-check-certificate -P
/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads '
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz
'
DEBUG: Running export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b8=
0485356e847617a9c3d615be850af";
export SSH_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export
PATH=3D"/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/=
arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work=
/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0=
/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/=
build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC=
+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/git=
sm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/p=
oky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/hosttools";
export HOME=3D"/home/stefan"; /usr/bin/env wget -t 2 -T 30 --passive-ftp
--no-check-certificate -P
/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads '
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz'
--progress=3Ddot -v
--2018-11-11 20:32:40--
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz
Resolving downloads.yoctoproject.org (downloads.yoctoproject.org)...
198.145.29.63
Connecting to downloads.yoctoproject.org
(downloads.yoctoproject.org)|198.145.29.63|:80...
connected.
HTTP request sent, awaiting response... 404 Not Found
2018-11-11 20:32:41 ERROR 404: Not Found.

DEBUG: Mirror fetch failure for url
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz
(original url: gitsm://
git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh)
DEBUG: Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b8=
0485356e847617a9c3d615be850af";
export SSH_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export
PATH=3D"/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/=
arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work=
/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0=
/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/=
build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC=
+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/git=
sm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/p=
oky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/hosttools";
export HOME=3D"/home/stefan"; /usr/bin/env wget -t 2 -T 30 --passive-ftp
--no-check-certificate -P
/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads '
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz'
--progress=3Ddot -v failed with exit code 8, output:
--2018-11-11 20:32:40--
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz
Resolving downloads.yoctoproject.org (downloads.yoctoproject.org)...
198.145.29.63
Connecting to downloads.yoctoproject.org
(downloads.yoctoproject.org)|198.145.29.63|:80...
connected.
HTTP request sent, awaiting response... 404 Not Found
2018-11-11 20:32:41 ERROR 404: Not Found.


DEBUG: Trying Upstream
DEBUG: Fetcher accessed the network with the command LANG=3DC git -c
core.fsyncobjectfiles=3D0 clone --bare --mirror ssh://
git@gitlab.com/gitsm/gitsm-test.git
/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads/git2/gitlab.com.gitsm=
.gitsm-test.git
--progress
DEBUG: Running export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b8=
0485356e847617a9c3d615be850af";
export SSH_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export
PATH=3D"/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/=
arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work=
/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0=
/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/=
build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC=
+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/git=
sm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/p=
oky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/hosttools";
export HOME=3D"/home/stefan"; LANG=3DC git -c core.fsyncobjectfiles=3D0 clo=
ne
--bare --mirror ssh://git@gitlab.com/gitsm/gitsm-test.git
/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads/git2/gitlab.com.gitsm=
.gitsm-test.git
--progress
Cloning into bare repository
'/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads/git2/gitlab.com.gits=
m.gitsm-test.git'...
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (10/10), done.
remote: Total 12 (delta 2), reused 0 (delta 0)
Receiving objects: 100% (12/12), 7.75 KiB | 0 bytes/s, done.
Resolving deltas: 100% (2/2), done.
Checking connectivity... done.
DEBUG: Running export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b8=
0485356e847617a9c3d615be850af";
export SSH_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export
PATH=3D"/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/=
arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work=
/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0=
/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/=
build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC=
+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/git=
sm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/p=
oky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/hosttools";
export HOME=3D"/home/stefan"; git -c core.fsyncobjectfiles=3D0 branch
--contains 5e400c09b7aff9bfdc2aabbb2d1cd07b94fdafec --list master 2>
/dev/null | wc -l
DEBUG: Running export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b8=
0485356e847617a9c3d615be850af";
export SSH_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export
PATH=3D"/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/=
arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work=
/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0=
/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/=
build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC=
+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/git=
sm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/p=
oky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/hosttools";
export HOME=3D"/home/stefan"; git -c core.fsyncobjectfiles=3D0 branch
--contains 5e400c09b7aff9bfdc2aabbb2d1cd07b94fdafec --list master 2>
/dev/null | wc -l
DEBUG: Running export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b8=
0485356e847617a9c3d615be850af";
export SSH_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export
PATH=3D"/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/=
arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work=
/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0=
/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/=
build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC=
+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/git=
sm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/p=
oky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/hosttools";
export HOME=3D"/home/stefan"; git -c core.fsyncobjectfiles=3D0 show
5e400c09b7aff9bfdc2aabbb2d1cd07b94fdafec:.gitmodules
DEBUG: Running export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b8=
0485356e847617a9c3d615be850af";
export SSH_AUTH_SOCK=3D"/run/user/1000/keyring/ssh"; export
PATH=3D"/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/=
x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/=
arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work=
/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0=
/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/=
build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC=
+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/git=
sm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/p=
oky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/hosttools";
export HOME=3D"/home/stefan"; git -c core.fsyncobjectfiles=3D0 ls-tree -z -=
d
5e400c09b7aff9bfdc2aabbb2d1cd07b94fdafec lib
WARNING: Failed to fetch URL gitsm://
git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh, attempt=
ing
MIRRORS if available
DEBUG: The URL: 'gitsm:Bigler/gitsm-test-submodule.git;protocol=3D
git@gitlab.com;name=3Dlib;bareclone=3D1;nocheckout=3D1;nobranch=3D1' is inv=
alid and
cannot be interpreted
DEBUG: Trying MIRRORS
DEBUG: For url ['gitsm', 'gitlab.com', '/gitsm/gitsm-test.git', 'git', '',
OrderedDict([('branch', 'master'), ('protocol', 'ssh')])] comparing ['ftp',
'.*', '/.*', '', '', OrderedDict()] to ['http', 'downloads.yoctoproject.org=
',
'/mirror/sources/', '', '', OrderedDict()]
...
DEBUG: For url ['gitsm', 'gitlab.com', '/gitsm/gitsm-test.git', 'git', '',
OrderedDict([('branch', 'master'), ('protocol', 'ssh')])] comparing ['git',
'.*', '/.*', '', '', OrderedDict()] to ['git', 'HOST', '/PATH', '', '',
OrderedDict([('protocol', 'https')])]
ERROR: The URL: 'gitsm:Bigler/gitsm-test-submodule.git;protocol=3D
git@gitlab.com;name=3Dlib;bareclone=3D1;nocheckout=3D1;nobranch=3D1' is inv=
alid and
cannot be interpreted
ERROR: Fetcher failure for URL: 'gitsm://
git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh'. Unable=
 to
fetch URL from any source.
DEBUG: Python function base_do_fetch finished
DEBUG: Python function do_fetch finished
ERROR: Function failed: base_do_fetch

--0000000000002d6699057a69ed75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div>Hi <br></div><div>I&#39;m updating from roc=
ko to thud and recognized, that my projects with git-submodules cannot be f=
etched anymore.</div><div>I tried to debug the fetch task, but I failed. I =
did a small example you should have access and it should be easy to reprodu=
ce, the repo should be public.<br></div><div>The recipe works fine with roc=
ko but fails with the latest master branch of poky.</div><div>I&#39;m using=
 gitlab for my repos. When I use https it works also with thud, only when *=
ssh* is used then it fails.</div><div>Below you find the recipe, the consol=
e output and the important part of the log.do_fetch<br></div><div>I hope so=
mebody can give me a hint.</div><div>Thanks and Regards</div><div>Stefan<br=
></div><div><br></div><div>Here the recipe for https and shh<br></div><div>=
-----------------------<br></div><div>SUMMARY =3D &quot;git submodule test&=
quot;<br>DESCRIPTION =3D &quot;recipe to test git submodule fetching&quot;<=
br>SECTION =3D &quot;testing&quot;<br>LICENSE =3D &quot;GPLv2&quot;<br>LIC_=
FILES_CHKSUM =3D &quot;file://COPYING;md5=3Dfcb02dc552a041dee27e4b85c739606=
7&quot;<br><br># fetching module and submodule with https -&gt; works<br>#S=
RC_URI =3D &quot;gitsm://<a href=3D"http://gitlab.com/gitsm/gitsm-test.git;=
branch=3Daccess-https;protocol=3Dhttps">gitlab.com/gitsm/gitsm-test.git;bra=
nch=3Daccess-https;protocol=3Dhttps</a>&quot;<br>#SRCREV=C2=A0=C2=A0=C2=A0 =
=3D &quot;db15957a23abb6b8bc8ca1dc948a7bd6ef18b6f3&quot;<br><br># fetching =
module and submodule with ssh -&gt; fails<br>SRC_URI =3D &quot;gitsm://<a h=
ref=3D"http://git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=
=3Dssh">git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh<=
/a>&quot;<br>SRCREV=C2=A0=C2=A0=C2=A0 =3D &quot;5e400c09b7aff9bfdc2aabbb2d1=
cd07b94fdafec&quot;<br><br>PV =3D &quot;1.0+git${SRCPV}&quot;<br>S =3D &quo=
t;${WORKDIR}/git/&quot;<br><br>inherit cmake<br><br></div><div><br></div><d=
iv>Here the console:</div><div>-----------------------</div><div>Build Conf=
iguration:<br>BB_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D &quot;1.40.0&quot;<br>BUILD_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;x86_64-linux&quot;<br>NATIVE=
LSBSTRING=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;universal&quot;<br>TARGET=
_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;=
arm-poky-linux-gnueabi&quot;<br>MACHINE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;beaglebone-yocto&quot;=
<br>DISTRO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D &quot;poky&quot;<br>DISTRO_VERSION=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D &quot;2.6&quot;<br>TUNE_FEATURES=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;arm armv7a vfp neon callconvention-ha=
rd cortexa8&quot;<br>TARGET_FPU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D &quot;hard&quot;<br>meta=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>m=
eta-poky=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
<br>meta-yocto-bsp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &quot;master:edd=
ff2b361928e88e3628ebc22a1a0ebb119e01b&quot;<br><br>Initialising tasks: 100%=
 |#########################################################################=
###########################################################################=
####################| Time: 0:00:00<br>Sstate summary: Wanted 6 Found 0 Mis=
sed 6 Current 72 (0% match, 92% complete)<br>NOTE: Executing SetScene Tasks=
<br>NOTE: Executing RunQueue Tasks<br>WARNING: gitsm-test-1.0+gitAUTOINC+5e=
400c09b7-r0 do_fetch: Failed to fetch URL gitsm://<a href=3D"http://git@git=
lab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh">git@gitlab.com=
/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh</a>, attempting MIRROR=
S if available<br>ERROR: gitsm-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: =
The URL: &#39;gitsm:Bigler/gitsm-test-submodule.git;protocol=3D<a href=3D"m=
ailto:git@gitlab.com">git@gitlab.com</a>;name=3Dlib;bareclone=3D1;nocheckou=
t=3D1;nobranch=3D1&#39; is invalid and cannot be interpreted<br>ERROR: gits=
m-test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: Fetcher failure for URL: &#39=
;gitsm://<a href=3D"http://git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmas=
ter;protocol=3Dssh">git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;pro=
tocol=3Dssh</a>&#39;. Unable to fetch URL from any source.<br>ERROR: gitsm-=
test-1.0+gitAUTOINC+5e400c09b7-r0 do_fetch: Function failed: base_do_fetch<=
br>ERROR: Logfile of failure stored in: /opt/yocto/poky/thud/poky-fetch-git=
sm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTO=
INC+5e400c09b7-r0/temp/log.do_fetch.28468<br>ERROR: Task (/opt/yocto/poky/t=
hud/poky-fetch-gitsm/meta-poky/recipes-testing/gitsm-test/gitsm-test_git.bb=
:do_fetch) failed with exit code &#39;1&#39;<br>NOTE: Tasks Summary: Attemp=
ted 465 tasks of which 464 didn&#39;t need to be rerun and 1 failed.<br><br=
>Summary: 1 task failed:<br>=C2=A0 /opt/yocto/poky/thud/poky-fetch-gitsm/me=
ta-poky/recipes-testing/gitsm-test/gitsm-test_git.bb:do_fetch<br>Summary: T=
here was 1 WARNING message shown.<br>Summary: There were 3 ERROR messages s=
hown, returning a non-zero exit code.<br></div><div><div><br></div><div>Her=
e the log (sorry it is long):</div><div>-----------------------------------=
--</div><div>DEBUG: Executing python function clean_recipe_sysroot<br>DEBUG=
: Python function clean_recipe_sysroot finished<br>DEBUG: Executing python =
function extend_recipe_sysroot<br>NOTE: Direct dependencies are []<br>NOTE:=
 Installed into sysroot: []<br>NOTE: Skipping as already exists in sysroot:=
 []<br>DEBUG: Python function extend_recipe_sysroot finished<br>DEBUG: Exec=
uting python function do_fetch<br>DEBUG: Executing python function base_do_=
fetch<br>DEBUG: Trying PREMIRRORS<br>DEBUG: For url [&#39;gitsm&#39;, &#39;=
<a href=3D"http://gitlab.com">gitlab.com</a>&#39;, &#39;/gitsm/gitsm-test.g=
it&#39;, &#39;git&#39;, &#39;&#39;, OrderedDict([(&#39;branch&#39;, &#39;ma=
ster&#39;), (&#39;protocol&#39;, &#39;ssh&#39;)])] comparing [&#39;bzr&#39;=
, &#39;.*&#39;, &#39;/.*&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()] to [&=
#39;http&#39;, &#39;<a href=3D"http://downloads.yoctoproject.org">downloads=
.yoctoproject.org</a>&#39;, &#39;/mirror/sources/&#39;, &#39;&#39;, &#39;&#=
39;, OrderedDict()]<br>....</div><div>DEBUG: Fetching <a href=3D"http://dow=
nloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gitsm-test.git=
.tar.gz">http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.g=
itsm.gitsm-test.git.tar.gz</a> using command &#39;/usr/bin/env wget -t 2 -T=
 30 --passive-ftp --no-check-certificate -P /opt/yocto/poky/thud/poky-fetch=
-gitsm/build/downloads &#39;<a href=3D"http://downloads.yoctoproject.org/mi=
rror/sources/git2_gitlab.com.gitsm.gitsm-test.git.tar.gz">http://downloads.=
yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gitsm-test.git.tar.gz=
</a>&#39;&#39;<br>DEBUG: Fetcher accessed the network with the command /usr=
/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate -P /opt/yocto=
/poky/thud/poky-fetch-gitsm/build/downloads &#39;<a href=3D"http://download=
s.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gitsm-test.git.tar.=
gz">http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.=
gitsm-test.git.tar.gz</a>&#39;<br>DEBUG: Running export PSEUDO_DISABLED=3D1=
; export DBUS_SESSION_BUS_ADDRESS=3D&quot;unix:abstract=3D/tmp/dbus-O1awmP2=
O9l,guid=3D1b80485356e847617a9c3d615be850af&quot;; export SSH_AUTH_SOCK=3D&=
quot;/run/user/1000/keyring/ssh&quot;; export PATH=3D&quot;/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/op=
t/yocto/poky/thud/poky-fetch-gitsm/scripts:/opt/yocto/poky/thud/poky-fetch-=
gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitA=
UTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi:/=
opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-li=
nux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot/usr/bin/=
crossscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8h=
f-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sy=
sroot-native/usr/sbin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/=
cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/=
recipe-sysroot-native/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/t=
mp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c=
09b7-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/thud/poky-fetch-gitsm/bu=
ild/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5=
e400c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/poky/thud/poky-fetch-gits=
m/bitbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/hosttools&quo=
t;; export HOME=3D&quot;/home/stefan&quot;; /usr/bin/env wget -t 2 -T 30 --=
passive-ftp --no-check-certificate -P /opt/yocto/poky/thud/poky-fetch-gitsm=
/build/downloads &#39;<a href=3D"http://downloads.yoctoproject.org/mirror/s=
ources/git2_gitlab.com.gitsm.gitsm-test.git.tar.gz">http://downloads.yoctop=
roject.org/mirror/sources/git2_gitlab.com.gitsm.gitsm-test.git.tar.gz</a>&#=
39; --progress=3Ddot -v<br>--2018-11-11 20:32:40--=C2=A0 <a href=3D"http://=
downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gitsm-test.=
git.tar.gz">http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.co=
m.gitsm.gitsm-test.git.tar.gz</a><br>Resolving <a href=3D"http://downloads.=
yoctoproject.org">downloads.yoctoproject.org</a> (<a href=3D"http://downloa=
ds.yoctoproject.org">downloads.yoctoproject.org</a>)... 198.145.29.63<br>Co=
nnecting to <a href=3D"http://downloads.yoctoproject.org">downloads.yoctopr=
oject.org</a> (<a href=3D"http://downloads.yoctoproject.org">downloads.yoct=
oproject.org</a>)|198.145.29.63|:80... connected.<br>HTTP request sent, awa=
iting response... 404 Not Found<br>2018-11-11 20:32:41 ERROR 404: Not Found=
.<br><br>DEBUG: Mirror fetch failure for url <a href=3D"http://downloads.yo=
ctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gitsm-test.git.tar.gz">=
http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gits=
m-test.git.tar.gz</a> (original url: gitsm://<a href=3D"http://git@gitlab.c=
om/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh">git@gitlab.com/gits=
m/gitsm-test.git;branch=3Dmaster;protocol=3Dssh</a>)<br>DEBUG: Fetcher fail=
ure: Fetch command export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDR=
ESS=3D&quot;unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b80485356e847617a9=
c3d615be850af&quot;; export SSH_AUTH_SOCK=3D&quot;/run/user/1000/keyring/ss=
h&quot;; export PATH=3D&quot;/opt/yocto/poky/thud/poky-fetch-gitsm/build/tm=
p/sysroots-uninative/x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-g=
itsm/scripts:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8h=
f-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sy=
sroot-native/usr/bin/arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch=
-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+git=
AUTOINC+5e400c09b7-r0/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/t=
hud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gits=
m-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:=
/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-l=
inux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/=
sbin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-p=
oky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-na=
tive/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/=
thud/poky-fetch-gitsm/build/tmp/hosttools&quot;; export HOME=3D&quot;/home/=
stefan&quot;; /usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certifi=
cate -P /opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads &#39;<a href=
=3D"http://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.=
gitsm-test.git.tar.gz">http://downloads.yoctoproject.org/mirror/sources/git=
2_gitlab.com.gitsm.gitsm-test.git.tar.gz</a>&#39; --progress=3Ddot -v faile=
d with exit code 8, output:<br>--2018-11-11 20:32:40--=C2=A0 <a href=3D"htt=
p://downloads.yoctoproject.org/mirror/sources/git2_gitlab.com.gitsm.gitsm-t=
est.git.tar.gz">http://downloads.yoctoproject.org/mirror/sources/git2_gitla=
b.com.gitsm.gitsm-test.git.tar.gz</a><br>Resolving <a href=3D"http://downlo=
ads.yoctoproject.org">downloads.yoctoproject.org</a> (<a href=3D"http://dow=
nloads.yoctoproject.org">downloads.yoctoproject.org</a>)... 198.145.29.63<b=
r>Connecting to <a href=3D"http://downloads.yoctoproject.org">downloads.yoc=
toproject.org</a> (<a href=3D"http://downloads.yoctoproject.org">downloads.=
yoctoproject.org</a>)|198.145.29.63|:80... connected.<br>HTTP request sent,=
 awaiting response... 404 Not Found<br>2018-11-11 20:32:41 ERROR 404: Not F=
ound.<br><br><br>DEBUG: Trying Upstream<br>DEBUG: Fetcher accessed the netw=
ork with the command LANG=3DC git -c core.fsyncobjectfiles=3D0 clone --bare=
 --mirror ssh://<a href=3D"http://git@gitlab.com/gitsm/gitsm-test.git">git@=
gitlab.com/gitsm/gitsm-test.git</a> /opt/yocto/poky/thud/poky-fetch-gitsm/b=
uild/downloads/git2/gitlab.com.gitsm.gitsm-test.git --progress<br>DEBUG: Ru=
nning export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRESS=3D&quot;u=
nix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b80485356e847617a9c3d615be850af=
&quot;; export SSH_AUTH_SOCK=3D&quot;/run/user/1000/keyring/ssh&quot;; expo=
rt PATH=3D&quot;/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/sysroots-un=
inative/x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/scripts:=
/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-l=
inux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/=
usr/bin/arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gitsm/build/=
tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400=
c09b7-r0/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud/poky-fetc=
h-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gi=
tAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/poky/thud/=
poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-te=
st/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/opt/yocto/po=
ky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/=
gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbin:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/bin:/opt=
/yocto/poky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/hosttools&quot;; export HOME=3D&quot;/home/stefan&quot;;=
 LANG=3DC git -c core.fsyncobjectfiles=3D0 clone --bare --mirror ssh://<a h=
ref=3D"http://git@gitlab.com/gitsm/gitsm-test.git">git@gitlab.com/gitsm/git=
sm-test.git</a> /opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads/git2/=
gitlab.com.gitsm.gitsm-test.git --progress<br>Cloning into bare repository =
&#39;/opt/yocto/poky/thud/poky-fetch-gitsm/build/downloads/git2/gitlab.com.=
gitsm.gitsm-test.git&#39;...<br>remote: Enumerating objects: 12, done.=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>remote: Counting objects: 100% =
(12/12), done.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>remote: Compre=
ssing objects: 100% (10/10), done.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 <br>remote: Total 12 (delta 2), reused 0 (delta 0)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <br>Receiving objects: 100% (12/12), 7.75 KiB | 0 byt=
es/s, done.<br>Resolving deltas: 100% (2/2), done.<br>Checking connectivity=
... done.<br>DEBUG: Running export PSEUDO_DISABLED=3D1; export DBUS_SESSION=
_BUS_ADDRESS=3D&quot;unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b80485356=
e847617a9c3d615be850af&quot;; export SSH_AUTH_SOCK=3D&quot;/run/user/1000/k=
eyring/ssh&quot;; export PATH=3D&quot;/opt/yocto/poky/thud/poky-fetch-gitsm=
/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/opt/yocto/poky/thud/pok=
y-fetch-gitsm/scripts:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/=
cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/=
recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi:/opt/yocto/poky/thud/p=
oky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-tes=
t/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot/usr/bin/crossscripts:/opt/yoc=
to/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnu=
eabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/sbin=
:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-=
linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native=
/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-ne=
on-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroo=
t-native/sbin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8=
hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-s=
ysroot-native/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yo=
cto/poky/thud/poky-fetch-gitsm/build/tmp/hosttools&quot;; export HOME=3D&qu=
ot;/home/stefan&quot;; git -c core.fsyncobjectfiles=3D0 branch --contains 5=
e400c09b7aff9bfdc2aabbb2d1cd07b94fdafec --list master 2&gt; /dev/null | wc =
-l<br>DEBUG: Running export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_AD=
DRESS=3D&quot;unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b80485356e847617=
a9c3d615be850af&quot;; export SSH_AUTH_SOCK=3D&quot;/run/user/1000/keyring/=
ssh&quot;; export PATH=3D&quot;/opt/yocto/poky/thud/poky-fetch-gitsm/build/=
tmp/sysroots-uninative/x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch=
-gitsm/scripts:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa=
8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-=
sysroot-native/usr/bin/arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fet=
ch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+g=
itAUTOINC+5e400c09b7-r0/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky=
/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gi=
tsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/y=
octo/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-g=
nueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bi=
n:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky=
-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-nativ=
e/sbin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon=
-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-=
native/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/pok=
y/thud/poky-fetch-gitsm/build/tmp/hosttools&quot;; export HOME=3D&quot;/hom=
e/stefan&quot;; git -c core.fsyncobjectfiles=3D0 branch --contains 5e400c09=
b7aff9bfdc2aabbb2d1cd07b94fdafec --list master 2&gt; /dev/null | wc -l<br>D=
EBUG: Running export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRESS=
=3D&quot;unix:abstract=3D/tmp/dbus-O1awmP2O9l,guid=3D1b80485356e847617a9c3d=
615be850af&quot;; export SSH_AUTH_SOCK=3D&quot;/run/user/1000/keyring/ssh&q=
uot;; export PATH=3D&quot;/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/s=
ysroots-uninative/x86_64-linux/usr/bin:/opt/yocto/poky/thud/poky-fetch-gits=
m/scripts:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-n=
eon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysro=
ot-native/usr/bin/arm-poky-linux-gnueabi:/opt/yocto/poky/thud/poky-fetch-gi=
tsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUT=
OINC+5e400c09b7-r0/recipe-sysroot/usr/bin/crossscripts:/opt/yocto/poky/thud=
/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-t=
est/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/sbin:/opt/yocto/=
poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-gnueab=
i/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/usr/bin:/op=
t/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linu=
x-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-native/sbi=
n:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky=
-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot-nativ=
e/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/bitbake/bin:/opt/yocto/poky/thu=
d/poky-fetch-gitsm/build/tmp/hosttools&quot;; export HOME=3D&quot;/home/ste=
fan&quot;; git -c core.fsyncobjectfiles=3D0 show 5e400c09b7aff9bfdc2aabbb2d=
1cd07b94fdafec:.gitmodules<br>DEBUG: Running export PSEUDO_DISABLED=3D1; ex=
port DBUS_SESSION_BUS_ADDRESS=3D&quot;unix:abstract=3D/tmp/dbus-O1awmP2O9l,=
guid=3D1b80485356e847617a9c3d615be850af&quot;; export SSH_AUTH_SOCK=3D&quot=
;/run/user/1000/keyring/ssh&quot;; export PATH=3D&quot;/opt/yocto/poky/thud=
/poky-fetch-gitsm/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/opt/yo=
cto/poky/thud/poky-fetch-gitsm/scripts:/opt/yocto/poky/thud/poky-fetch-gits=
m/build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOI=
NC+5e400c09b7-r0/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi:/opt/=
yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-neon-poky-linux-=
gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroot/usr/bin/cros=
sscripts:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cortexa8hf-ne=
on-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/recipe-sysroo=
t-native/usr/sbin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/work/cort=
exa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7-r0/reci=
pe-sysroot-native/usr/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/w=
ork/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400c09b7=
-r0/recipe-sysroot-native/sbin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/=
tmp/work/cortexa8hf-neon-poky-linux-gnueabi/gitsm-test/1.0+gitAUTOINC+5e400=
c09b7-r0/recipe-sysroot-native/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/bi=
tbake/bin:/opt/yocto/poky/thud/poky-fetch-gitsm/build/tmp/hosttools&quot;; =
export HOME=3D&quot;/home/stefan&quot;; git -c core.fsyncobjectfiles=3D0 ls=
-tree -z -d 5e400c09b7aff9bfdc2aabbb2d1cd07b94fdafec lib<br>WARNING: Failed=
 to fetch URL gitsm://<a href=3D"http://git@gitlab.com/gitsm/gitsm-test.git=
;branch=3Dmaster;protocol=3Dssh">git@gitlab.com/gitsm/gitsm-test.git;branch=
=3Dmaster;protocol=3Dssh</a>, attempting MIRRORS if available<br>DEBUG: The=
 URL: &#39;gitsm:Bigler/gitsm-test-submodule.git;protocol=3D<a href=3D"mail=
to:git@gitlab.com">git@gitlab.com</a>;name=3Dlib;bareclone=3D1;nocheckout=
=3D1;nobranch=3D1&#39; is invalid and cannot be interpreted<br>DEBUG: Tryin=
g MIRRORS<br>DEBUG: For url [&#39;gitsm&#39;, &#39;<a href=3D"http://gitlab=
.com">gitlab.com</a>&#39;, &#39;/gitsm/gitsm-test.git&#39;, &#39;git&#39;, =
&#39;&#39;, OrderedDict([(&#39;branch&#39;, &#39;master&#39;), (&#39;protoc=
ol&#39;, &#39;ssh&#39;)])] comparing [&#39;ftp&#39;, &#39;.*&#39;, &#39;/.*=
&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()] to [&#39;http&#39;, &#39;<a h=
ref=3D"http://downloads.yoctoproject.org">downloads.yoctoproject.org</a>&#3=
9;, &#39;/mirror/sources/&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()]<br>.=
..</div><div>DEBUG: For url [&#39;gitsm&#39;, &#39;<a href=3D"http://gitlab=
.com">gitlab.com</a>&#39;, &#39;/gitsm/gitsm-test.git&#39;, &#39;git&#39;, =
&#39;&#39;, OrderedDict([(&#39;branch&#39;, &#39;master&#39;), (&#39;protoc=
ol&#39;, &#39;ssh&#39;)])] comparing [&#39;git&#39;, &#39;.*&#39;, &#39;/.*=
&#39;, &#39;&#39;, &#39;&#39;, OrderedDict()] to [&#39;git&#39;, &#39;HOST&=
#39;, &#39;/PATH&#39;, &#39;&#39;, &#39;&#39;, OrderedDict([(&#39;protocol&=
#39;, &#39;https&#39;)])]<br>ERROR: The URL: &#39;gitsm:Bigler/gitsm-test-s=
ubmodule.git;protocol=3D<a href=3D"mailto:git@gitlab.com">git@gitlab.com</a=
>;name=3Dlib;bareclone=3D1;nocheckout=3D1;nobranch=3D1&#39; is invalid and =
cannot be interpreted<br>ERROR: Fetcher failure for URL: &#39;gitsm://<a hr=
ef=3D"http://git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=
=3Dssh">git@gitlab.com/gitsm/gitsm-test.git;branch=3Dmaster;protocol=3Dssh<=
/a>&#39;. Unable to fetch URL from any source.<br>DEBUG: Python function ba=
se_do_fetch finished<br>DEBUG: Python function do_fetch finished<br>ERROR: =
Function failed: base_do_fetch<br><br></div><div><br></div></div></div></di=
v></div></div></div></div>

--0000000000002d6699057a69ed75--
