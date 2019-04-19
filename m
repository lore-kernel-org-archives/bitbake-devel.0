Return-Path: <chadg@videx.com>
X-Greylist: delayed 1801 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 19 Apr 2019 18:13:44 UTC
Received: from mail.videx.com (unknown [65.122.251.43])
	by mail.openembedded.org (Postfix) with ESMTP id E3FBA7CEBC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Apr 2019 18:13:44 +0000 (UTC)
X-Footer: dmlkZXguY29t
Received: from [65.122.251.41] ([65.122.251.41])
	(authenticated user chadg@videx.com) by mail.videx.com with ESMTPSA
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Apr 2019 10:43:44 -0700
Date: Fri, 19 Apr 2019 10:43:44 -0700
X-User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:66.0) Gecko/20100101
	Firefox/66.0
Message-ID: <917454045-31000@mail.videx.com>
X-Priority: 3
Importance: Normal
MIME-Version: 1.0
From: Chad Gibeaut <chadg@videx.com>
To: bitbake-devel@lists.openembedded.org
Reply-To: Chad Gibeaut <chadg@videx.com>
Subject: QA Error for DB
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
X-List-Received-Date: Fri, 19 Apr 2019 18:13:45 -0000
Content-Type: multipart/alternative; boundary="=-JT9yIXTKNflcfVPNBCp9"

--=-JT9yIXTKNflcfVPNBCp9
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable


=20
I am building images=28yocto=2Cbitbake=2Cbusybox=29 for two differnt karo=
  SOM=27s=2E  Both of the configuration files are the same =28including my=
 own  software=29=20
One build fails during the QA portion of the build process on the  recipe f=
or the Berkeley DB from Oracle=2E I am not even sure what is  requiring thi=
s=2C but something does=2E  ERROR=3A db-6=2E0=2E30-r0 do=5Fpackage=5Fqa=3A=
 QA Issue=3A non -dev/-dbg/nativesdk- package contains symlink =2Eso=3A db=
 path =27work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/packages-=
split/db/usr/lib/libdb-6=2Eso=27 =5Bdev-so=5D
ERROR=3A db-6=2E0=2E30-r0 do=5Fpackage=5Fqa=3A QA run found fatal errors=2E=
 Please consider fixing them=2E
ERROR=3A db-6=2E0=2E30-r0 do=5Fpackage=5Fqa=3A Function failed=3A do=5Fpack=
age=5Fqa
ERROR=3A Logfile of failure stored in=3A /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
temp/log=2Edo=5Fpackage=5Fqa=2E1270
ERROR=3A Task 2138 =28/home/test/karo/fsl-community-bsp=5F5011/sources/poky=
/meta/recipes-support/db/db=5F6=2E0=2E30=2Ebb=2C do=5Fpackage=5Fqa=29 faile=
d with exit code =271=27
=20
In the folder the error mentions is the =2Eso file along with a link back t=
o that same so file minus the minor version=2E  -rwxr-xr-x 2 test test 1=2E=
1M Apr  9 12=3A23 libdb-6=2E0=2Eso
lrwxrwxrwx 1 test test   12 Apr  9 12=3A24 libdb-6=2Eso -=3E libdb-6=2E0=2E=
so
=20
This linked file is being created during the build at some point  =28removi=
ng the linked file or even the whole build directory and  rerunning results=
 in the same issue=29 =20
I think I could probably find a way to disable the QA check=2C but  thats n=
ot ideal since something requires this and I dont like having to  disable c=
hecks for production code=2E =20
The Error log file mentioned in the error is here=3A
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----ERROR Log-------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------------
 DEBUG=3A Executing python function sstate=5Ftask=5Fprefunc
DEBUG=3A Python function sstate=5Ftask=5Fprefunc finished
DEBUG=3A Executing python function do=5Fpackage=5Fqa
NOTE=3A DO PACKAGE QA
DEBUG=3A Executing python function read=5Fsubpackage=5Fmetadata
DEBUG=3A Python function read=5Fsubpackage=5Fmetadata finished
NOTE=3A Package db skipping QA tests=3A =5B=27dev-soalready-stripped=27=5D=

NOTE=3A Checking Package=3A db
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db/usr/lib/libdb-6=2E0=2Eso
ERROR=3A QA Issue=3A non -dev/-dbg/nativesdk- package contains symlink =2Es=
o=3A db path =27work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/pa=
ckages-split/db/usr/lib/libdb-6=2Eso=27 =5Bdev-so=5D
NOTE=3A Checking Package=3A db-bin
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fstat
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fdeadlock
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Freplicate
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Flog=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fupgrade
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fprintlog
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Farchive
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fhotbackup
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fdump
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fload
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fcheckpoint
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Frecover
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Ftuner
NOTE=3A Checking Package=3A db-staticdev
NOTE=3A Checking Package=3A db-dev
NOTE=3A Package db-cxx skipping QA tests=3A =5B=27dev-so=27=5D
NOTE=3A Checking Package=3A db-cxx
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-cxx/usr/lib/libdb=5Fcxx-6=2E0=2Eso
NOTE=3A Checking Package=3A db-doc
NOTE=3A Checking Package=3A db-dbg
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fstat
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fdeadlock
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Freplicate
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Flog=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fupgrade
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fprintlog
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Farchive
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fhotbackup
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fdump
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fload
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fcheckpoint
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Frecover
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Ftuner
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/lib/=2Edebug/libdb=5Fcxx-6=2E0=2Eso
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/lib/=2Edebug/libdb-6=2E0=2Eso
NOTE=3A Checking Package=3A db-locale
ERROR=3A QA run found fatal errors=2E Please consider fixing them=2E
DEBUG=3A Python function do=5Fpackage=5Fqa finished
ERROR=3A Function failed=3A do=5Fpackage=5Fqa
=20
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----ERROR   Log-----------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------------
And the busy box recipe is below=28from the repo somewhere=29=2E There is s=
ome  mention in there about dev so files=2C but Im not sure if that might b=
e  the issue or even what changes might need to be made then=2E=20







---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----BB File---------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------=20



=23 Version 6 of the Berkeley DB from Oracle =28formerly Sleepycat=29
=23
=23 At present this package only installs the DB code
=23 itself =28shared libraries=2C =2Ea in the dev package=29=2C
=23 documentation and headers=2E
=23
=23 The headers have the same names as those as v3
=23 of the DB=2C only one version can be used *for dev*
=23 at once - DB3 and DB6 can both be installed on the
=23 same system at the same time if really necessary=2E
SECTION =3D =22libs=22
SUMMARY =3D =22Berkeley Database v6=22
HOMEPAGE =3D =22http=3A//www=2Eoracle=2Ecom/technetwork/database/database-t=
echnologies/berkeleydb/overview/index=2Ehtml=22
LICENSE =3D =22AGPL-3=2E0=22
VIRTUAL=5FNAME =3F=3D =22virtual/db=22
RCONFLICTS=5F=24=7BPN=7D =3D =22db3=22

=23 Note=2C when upgraded to 6=2E1=2Ex=2C a patch in RPM will need to be re=
moved to activate db 6=2E1 support=2E

SRC=5FURI =3D =22http=3A//download=2Eoracle=2Ecom/berkeley-db/db-=24=7BPV=
=7D=2Etar=2Egz=22
SRC=5FURI +=3D =22file=3A//arm-thumb-mutex=5Fdb5=2Epatch=3Bpatchdir=3D=2E=
=2E =5C
            file=3A//fix-parallel-build=2Epatch =5C
            file=3A//Makefile-let-libso=5Ftarget-depend-on-bt=5Frec=2Epatch=
 =5C
            file=3A//Makefile-let-libdb-6=2E0=2Ela-depend-os=5Fmap=2El=2Epa=
tch=3Bpatchdir=3D=2E=2E =5C
           =22

SRC=5FURI=5Bmd5sum=5D =3D =22ad28eb86ad3203b5422844db179c585b=22
SRC=5FURI=5Bsha256sum=5D =3D =22608e4b1cf390e9bf54c0ef00c5bd9ca76d36e2261b9=
f4d33d54516f3f6a20fd2=22

=23 Exclude NC versions which lack AES encryption
UPSTREAM=5FCHECK=5FREGEX =3D =22db-=28=3FP=3Cpver=3E=5Cd+=5C=2E=5Cd+=28=5C=
=2E=5Cd+=29=3F=29=2Etar=22
UPSTREAM=5FCHECK=5FURI =3D =22http=3A//www=2Eoracle=2Ecom/technetwork/produ=
cts/berkeleydb/downloads/index-082944=2Ehtml=22

LIC=5FFILES=5FCHKSUM =3D =22file=3A//=2E=2E/LICENSE=3Bmd5=3D1ec8b0b17cc3151=
3fe35ab10716f8490=22

inherit autotools

=23 Put virtual/db in any appropriate provider of a
=23 relational database=2C use it as a dependency in
=23 place of a specific db and use=3A
=23
=23 PREFERRED=5FPROVIDER=5Fvirtual/db
=23
=23 to select the correct db in the build =28distro=29 =2Econf
PROVIDES +=3D =22=24=7BVIRTUAL=5FNAME=7D=22

=23 bitbake isn=27t quite clever enough to deal with sleepycat=2C
=23 the distribution sits in the expected directory=2C but all
=23 the builds must occur from a sub-directory=2E  The following
=23 persuades bitbake to go to the right place
S =3D =22=24=7BWORKDIR=7D/db-=24=7BPV=7D/dist=22
B =3D =22=24=7BWORKDIR=7D/db-=24=7BPV=7D/build=5Funix=22
SPDX=5FS =3D =22=24=7BWORKDIR=7D/db-=24=7BPV=7D=22

=23 The executables go in a separate package - typically there
=23 is no need to install these unless doing real database
=23 management on the system=2E
inherit lib=5Fpackage

PACKAGES =3D+ =22=24=7BPN=7D-cxx=22
FILES=5F=24=7BPN=7D-cxx =3D =22=24=7Blibdir=7D/*cxx*so=22


=23 The dev package has the =2Eso link =28as in db3=29 and the =2Ea=27s -=

=23 it is therefore incompatible =28cannot be installed at the
=23 same time=29 as the db3 package
=23 sort out the =2Eso since they do version prior to the =2Eso
SOLIBS =3D =22-6*=2Eso=22
FILES=5FSOLIBSDEV =3D =22=24=7Blibdir=7D/libdb=2Eso =24=7Blibdir=7D/libdb=
=5Fcxx=2Eso=22

=23configuration - set in local=2Econf to override
=23 All the --disable-* options replace --enable-smallbuild=2C which breaks=
 a bunch of stuff =28eg=2E postfix=29
DB6=5FCONFIG =3F=3D =22--enable-o=5Fdirect --disable-cryptography --disable=
-queue --disable-replication --disable-verify --disable-compat185 --disable=
-sql=22

EXTRA=5FOECONF =3D =22=24=7BDB6=5FCONFIG=7D --enable-shared --enable-cxx --=
with-sysroot=22

=23 Override the MUTEX setting here=2C the POSIX library is
=23 the default - =22POSIX/pthreads/library=22=2E
=23 Don=27t ignore the nice SWP instruction on the ARM=3A
=23 These enable the ARM assembler mutex code
ARM=5FMUTEX =3D =22--with-mutex=3DARM/gcc-assembly=22
MUTEX =3D =22=22
MUTEX=5Farm =3D =22=24=7BARM=5FMUTEX=7D=22
MUTEX=5Farmeb =3D =22=24=7BARM=5FMUTEX=7D=22
EXTRA=5FOECONF +=3D =22=24=7BMUTEX=7D=22
EXTRA=5FOEMAKE=5Fclass-target =3D =22LIBTOOL=3D=24=7BSTAGING=5FBINDIR=5FCRO=
SS=7D/=24=7BHOST=5FSYS=7D-libtool=22

=23 Cancel the site stuff - it=27s set for db3 and destroys the
=23 configure=2E
CONFIG=5FSITE =3D =22=22
do=5Fconfigure=28=29 =7B
    gnu-configize --force =24=7BS=7D
    export STRIP=3D=22true=22
    oe=5Frunconf
=7D

do=5Fcompile=5Fprepend=28=29 =7B
    sed -i -e =27s=7Chardcode=5Finto=5Flibs=3Dyes=7Chardcode=5Finto=5Flibs=
=3Dno=7C=27 =5C
        =24=7BB=7D/libtool
=7D

do=5Finstall=5Fappend=28=29 =7B
    mkdir -p =24=7BD=7D/=24=7Bincludedir=7D/db60
    mv =24=7BD=7D/=24=7Bincludedir=7D/db=2Eh =24=7BD=7D/=24=7Bincludedir=7D=
/db60/=2E
    mv =24=7BD=7D/=24=7Bincludedir=7D/db=5Fcxx=2Eh =24=7BD=7D/=24=7Binclude=
dir=7D/db60/=2E
    ln -s db60/db=2Eh =24=7BD=7D/=24=7Bincludedir=7D/db=2Eh
    ln -s db60/db=5Fcxx=2Eh =24=7BD=7D/=24=7Bincludedir=7D/db=5Fcxx=2Eh

    =23 The docs end up in /usr/docs - not right=2E
    if test -d =22=24=7BD=7D/=24=7Bprefix=7D/docs=22
    then
        mkdir -p =22=24=7BD=7D/=24=7Bdatadir=7D=22
        test ! -d =22=24=7BD=7D/=24=7Bdocdir=7D=22 =7C=7C rm -rf =22=24=7BD=
=7D/=24=7Bdocdir=7D=22
        mv =22=24=7BD=7D/=24=7Bprefix=7D/docs=22 =22=24=7BD=7D/=24=7Bdocdir=
=7D=22
    fi

    chown -R root=3Aroot =24=7BD=7D
=7D

INSANE=5FSKIP=5F=24=7BPN=7D =3D =22dev-so=22
INSANE=5FSKIP=5F=24=7BPN=7D-cxx =3D =22dev-so=22

BBCLASSEXTEND =3D =22native nativesdk=22
    =20


Thanks=2C
Chad


Cyberlock=2C Inc=2E =7C Videx=2C Inc=2E =7C 1105 NE Circle Blvd=2E =7C Corv=
allis=2C OR 97330 =7C =28541=29 738-5500
This email is intended only for the addressee=28s=29 and may include materi=
al that is privileged=2C confidential=2C and protected from disclosure=2E N=
o contract is intended=2E =C2=A92019 Videx=2C Inc=2E

--=-JT9yIXTKNflcfVPNBCp9
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=3Chtml=3E=3Chead=3E=3C/head=3E=3Cbody=3E=3Cdiv class=3D=22post-text=22 ite=
mprop=3D=22text=22=3E

=3Cp=3EI am building images=28yocto=2Cbitbake=2Cbusybox=29 for two differnt=
 karo=20
SOM=27s=2E  Both of the configuration files are the same =28including my ow=
n=20
software=29=3C/p=3E

=3Cp=3EOne build fails during the QA portion of the build process on the=20=

recipe for the Berkeley DB from Oracle=2E I am not even sure what is=20
requiring this=2C but something does=2E =3C/p=3E

=3Cpre=3E=3Ccode=3EERROR=3A db-6=2E0=2E30-r0 do=5Fpackage=5Fqa=3A QA Issue=
=3A non -dev/-dbg/nativesdk- package contains symlink =2Eso=3A db path =27w=
ork/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/packages-split/db/u=
sr/lib/libdb-6=2Eso=27 =5Bdev-so=5D
ERROR=3A db-6=2E0=2E30-r0 do=5Fpackage=5Fqa=3A QA run found fatal errors=2E=
 Please consider fixing them=2E
ERROR=3A db-6=2E0=2E30-r0 do=5Fpackage=5Fqa=3A Function failed=3A do=5Fpack=
age=5Fqa
ERROR=3A Logfile of failure stored in=3A /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
temp/log=2Edo=5Fpackage=5Fqa=2E1270
ERROR=3A Task 2138 =28/home/test/karo/fsl-community-bsp=5F5011/sources/poky=
/meta/recipes-support/db/db=5F6=2E0=2E30=2Ebb=2C do=5Fpackage=5Fqa=29 faile=
d with exit code =271=27
=3C/code=3E=3C/pre=3E

=3Cp=3EIn the folder the error mentions is the =2Eso file along with a link=
 back to that same so file minus the minor version=2E =3C/p=3E

=3Cpre=3E=3Ccode=3E-rwxr-xr-x 2 test test 1=2E1M Apr  9 12=3A23 libdb-6=2E0=
=2Eso
lrwxrwxrwx 1 test test   12 Apr  9 12=3A24 libdb-6=2Eso -=26gt=3B libdb-6=
=2E0=2Eso
=3C/code=3E=3C/pre=3E

=3Cp=3EThis linked file is being created during the build at some point=20=

=28removing the linked file or even the whole build directory and=20
rerunning results in the same issue=29 =3C/p=3E

=3Cp=3EI think I could probably find a way to disable the QA check=2C but=
=20
thats not ideal since something requires this and I dont like having to=20=

disable checks for production code=2E =3C/p=3E

=3Cp=3EThe Error log file mentioned in the error is here=3A=3C/p=3E=3Cp=3E-=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----ERROR Log--------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------=3Cbr=3E=3C/p=3E

=3Cpre=3E=3Ccode=3EDEBUG=3A Executing python function sstate=5Ftask=5Fprefu=
nc
DEBUG=3A Python function sstate=5Ftask=5Fprefunc finished
DEBUG=3A Executing python function do=5Fpackage=5Fqa
NOTE=3A DO PACKAGE QA
DEBUG=3A Executing python function read=5Fsubpackage=5Fmetadata
DEBUG=3A Python function read=5Fsubpackage=5Fmetadata finished
NOTE=3A Package db skipping QA tests=3A =5B=27dev-soalready-stripped=27=5D=

NOTE=3A Checking Package=3A db
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db/usr/lib/libdb-6=2E0=2Eso
ERROR=3A QA Issue=3A non -dev/-dbg/nativesdk- package contains symlink =2Es=
o=3A db path =27work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/pa=
ckages-split/db/usr/lib/libdb-6=2Eso=27 =5Bdev-so=5D
NOTE=3A Checking Package=3A db-bin
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fstat
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fdeadlock
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Freplicate
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Flog=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fupgrade
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fprintlog
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Farchive
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fhotbackup
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fdump
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fload
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Fcheckpoint
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Frecover
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-bin/usr/bin/db=5Ftuner
NOTE=3A Checking Package=3A db-staticdev
NOTE=3A Checking Package=3A db-dev
NOTE=3A Package db-cxx skipping QA tests=3A =5B=27dev-so=27=5D
NOTE=3A Checking Package=3A db-cxx
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-cxx/usr/lib/libdb=5Fcxx-6=2E0=2Eso
NOTE=3A Checking Package=3A db-doc
NOTE=3A Checking Package=3A db-dbg
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fstat
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fdeadlock
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Freplicate
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Flog=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fverify
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fupgrade
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fprintlog
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Farchive
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fhotbackup
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fdump
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fload
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Fcheckpoint
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Frecover
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/bin/=2Edebug/db=5Ftuner
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/lib/=2Edebug/libdb=5Fcxx-6=2E0=2Eso
NOTE=3A arm-poky-linux-gnueabi-objdump -p /home/test/karo/fsl-community-bsp=
=5F5011/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/db/6=2E0=2E30-r0/=
packages-split/db-dbg/usr/lib/=2Edebug/libdb-6=2E0=2Eso
NOTE=3A Checking Package=3A db-locale
ERROR=3A QA run found fatal errors=2E Please consider fixing them=2E
DEBUG=3A Python function do=5Fpackage=5Fqa finished
ERROR=3A Function failed=3A do=5Fpackage=5Fqa
=3C/code=3E=3C/pre=3E

=3Cp=3E--------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------ERROR
=20
Log------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------=3C/p=3E=3Cp=3EAnd the busy box recipe is below=28fr=
om the repo somewhere=29=2E There is some=20
mention in there about dev so files=2C but Im not sure if that might be=20=

the issue or even what changes might need to be made then=2E =3Cbr=3E=3C/p=
=3E=3Cp=3E=3Cbr=3E=3C/p=3E=3Cp=3E=3Cbr=3E=3C/p=3E=3Cp=3E=3Cbr=3E=3C/p=3E=3C=
p=3E-----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------BB File-----------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------------=3C/p=3E

=3Cpre=3E=3Ccode=3E=3Cbr=3E=3Cbr=3E=3Cbr=3E=3Cbr=3E=23 Version 6 of the Ber=
keley DB from Oracle =28formerly Sleepycat=29
=23
=23 At present this package only installs the DB code
=23 itself =28shared libraries=2C =2Ea in the dev package=29=2C
=23 documentation and headers=2E
=23
=23 The headers have the same names as those as v3
=23 of the DB=2C only one version can be used *for dev*
=23 at once - DB3 and DB6 can both be installed on the
=23 same system at the same time if really necessary=2E
SECTION =3D =22libs=22
SUMMARY =3D =22Berkeley Database v6=22
HOMEPAGE =3D =22http=3A//www=2Eoracle=2Ecom/technetwork/database/database-t=
echnologies/berkeleydb/overview/index=2Ehtml=22
LICENSE =3D =22AGPL-3=2E0=22
VIRTUAL=5FNAME =3F=3D =22virtual/db=22
RCONFLICTS=5F=24=7BPN=7D =3D =22db3=22

=23 Note=2C when upgraded to 6=2E1=2Ex=2C a patch in RPM will need to be re=
moved to activate db 6=2E1 support=2E

SRC=5FURI =3D =22http=3A//download=2Eoracle=2Ecom/berkeley-db/db-=24=7BPV=
=7D=2Etar=2Egz=22
SRC=5FURI +=3D =22file=3A//arm-thumb-mutex=5Fdb5=2Epatch=3Bpatchdir=3D=2E=
=2E =5C
            file=3A//fix-parallel-build=2Epatch =5C
            file=3A//Makefile-let-libso=5Ftarget-depend-on-bt=5Frec=2Epatch=
 =5C
            file=3A//Makefile-let-libdb-6=2E0=2Ela-depend-os=5Fmap=2El=2Epa=
tch=3Bpatchdir=3D=2E=2E =5C
           =22

SRC=5FURI=5Bmd5sum=5D =3D =22ad28eb86ad3203b5422844db179c585b=22
SRC=5FURI=5Bsha256sum=5D =3D =22608e4b1cf390e9bf54c0ef00c5bd9ca76d36e2261b9=
f4d33d54516f3f6a20fd2=22

=23 Exclude NC versions which lack AES encryption
UPSTREAM=5FCHECK=5FREGEX =3D =22db-=28=3FP=26lt=3Bpver=26gt=3B=5Cd+=5C=2E=
=5Cd+=28=5C=2E=5Cd+=29=3F=29=2Etar=22
UPSTREAM=5FCHECK=5FURI =3D =22http=3A//www=2Eoracle=2Ecom/technetwork/produ=
cts/berkeleydb/downloads/index-082944=2Ehtml=22

LIC=5FFILES=5FCHKSUM =3D =22file=3A//=2E=2E/LICENSE=3Bmd5=3D1ec8b0b17cc3151=
3fe35ab10716f8490=22

inherit autotools

=23 Put virtual/db in any appropriate provider of a
=23 relational database=2C use it as a dependency in
=23 place of a specific db and use=3A
=23
=23 PREFERRED=5FPROVIDER=5Fvirtual/db
=23
=23 to select the correct db in the build =28distro=29 =2Econf
PROVIDES +=3D =22=24=7BVIRTUAL=5FNAME=7D=22

=23 bitbake isn=27t quite clever enough to deal with sleepycat=2C
=23 the distribution sits in the expected directory=2C but all
=23 the builds must occur from a sub-directory=2E  The following
=23 persuades bitbake to go to the right place
S =3D =22=24=7BWORKDIR=7D/db-=24=7BPV=7D/dist=22
B =3D =22=24=7BWORKDIR=7D/db-=24=7BPV=7D/build=5Funix=22
SPDX=5FS =3D =22=24=7BWORKDIR=7D/db-=24=7BPV=7D=22

=23 The executables go in a separate package - typically there
=23 is no need to install these unless doing real database
=23 management on the system=2E
inherit lib=5Fpackage

PACKAGES =3D+ =22=24=7BPN=7D-cxx=22
FILES=5F=24=7BPN=7D-cxx =3D =22=24=7Blibdir=7D/*cxx*so=22


=23 The dev package has the =2Eso link =28as in db3=29 and the =2Ea=27s -=

=23 it is therefore incompatible =28cannot be installed at the
=23 same time=29 as the db3 package
=23 sort out the =2Eso since they do version prior to the =2Eso
SOLIBS =3D =22-6*=2Eso=22
FILES=5FSOLIBSDEV =3D =22=24=7Blibdir=7D/libdb=2Eso =24=7Blibdir=7D/libdb=
=5Fcxx=2Eso=22

=23configuration - set in local=2Econf to override
=23 All the --disable-* options replace --enable-smallbuild=2C which breaks=
 a bunch of stuff =28eg=2E postfix=29
DB6=5FCONFIG =3F=3D =22--enable-o=5Fdirect --disable-cryptography --disable=
-queue --disable-replication --disable-verify --disable-compat185 --disable=
-sql=22

EXTRA=5FOECONF =3D =22=24=7BDB6=5FCONFIG=7D --enable-shared --enable-cxx --=
with-sysroot=22

=23 Override the MUTEX setting here=2C the POSIX library is
=23 the default - =22POSIX/pthreads/library=22=2E
=23 Don=27t ignore the nice SWP instruction on the ARM=3A
=23 These enable the ARM assembler mutex code
ARM=5FMUTEX =3D =22--with-mutex=3DARM/gcc-assembly=22
MUTEX =3D =22=22
MUTEX=5Farm =3D =22=24=7BARM=5FMUTEX=7D=22
MUTEX=5Farmeb =3D =22=24=7BARM=5FMUTEX=7D=22
EXTRA=5FOECONF +=3D =22=24=7BMUTEX=7D=22
EXTRA=5FOEMAKE=5Fclass-target =3D =22LIBTOOL=3D=24=7BSTAGING=5FBINDIR=5FCRO=
SS=7D/=24=7BHOST=5FSYS=7D-libtool=22

=23 Cancel the site stuff - it=27s set for db3 and destroys the
=23 configure=2E
CONFIG=5FSITE =3D =22=22
do=5Fconfigure=28=29 =7B
    gnu-configize --force =24=7BS=7D
    export STRIP=3D=22true=22
    oe=5Frunconf
=7D

do=5Fcompile=5Fprepend=28=29 =7B
    sed -i -e =27s=7Chardcode=5Finto=5Flibs=3Dyes=7Chardcode=5Finto=5Flibs=
=3Dno=7C=27 =5C
        =24=7BB=7D/libtool
=7D

do=5Finstall=5Fappend=28=29 =7B
    mkdir -p =24=7BD=7D/=24=7Bincludedir=7D/db60
    mv =24=7BD=7D/=24=7Bincludedir=7D/db=2Eh =24=7BD=7D/=24=7Bincludedir=7D=
/db60/=2E
    mv =24=7BD=7D/=24=7Bincludedir=7D/db=5Fcxx=2Eh =24=7BD=7D/=24=7Binclude=
dir=7D/db60/=2E
    ln -s db60/db=2Eh =24=7BD=7D/=24=7Bincludedir=7D/db=2Eh
    ln -s db60/db=5Fcxx=2Eh =24=7BD=7D/=24=7Bincludedir=7D/db=5Fcxx=2Eh

    =23 The docs end up in /usr/docs - not right=2E
    if test -d =22=24=7BD=7D/=24=7Bprefix=7D/docs=22
    then
        mkdir -p =22=24=7BD=7D/=24=7Bdatadir=7D=22
        test ! -d =22=24=7BD=7D/=24=7Bdocdir=7D=22 =7C=7C rm -rf =22=24=7BD=
=7D/=24=7Bdocdir=7D=22
        mv =22=24=7BD=7D/=24=7Bprefix=7D/docs=22 =22=24=7BD=7D/=24=7Bdocdir=
=7D=22
    fi

    chown -R root=3Aroot =24=7BD=7D
=7D

INSANE=5FSKIP=5F=24=7BPN=7D =3D =22dev-so=22
INSANE=5FSKIP=5F=24=7BPN=7D-cxx =3D =22dev-so=22

BBCLASSEXTEND =3D =22native nativesdk=22
=3C/code=3E=3C/pre=3E
    =3C/div=3E=3Cbr=3E=3Cbr=3E=3Cdiv=3EThanks=2C=3C/div=3E=3Cdiv=3EChad=3Cb=
r=3E=3C/div=3E=
=3CBR /=3E
=3CBR /=3E
Cyberlock=2C Inc=2E =7C Videx=2C Inc=2E =7C 1105 NE Circle Blvd=2E =7C Corv=
allis=2C OR 97330 =7C =28541=29 738-5500=3Cbr=3EThis email is intended only=
 for the addressee=28s=29 and may include material that is privileged=2C co=
nfidential=2C and protected from disclosure=2E  No contract is intended=2E=
  =C2=A92019 Videx=2C Inc=2E=3CBR /=3E
=3C/body=3E=3C/html=3E


--=-JT9yIXTKNflcfVPNBCp9--
