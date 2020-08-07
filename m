Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.5366.1596833235228279257
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 13:47:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Dx23ZPda;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id g8so2786816wmk.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Aug 2020 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=m/yf7SIy2K041JnsrPIH8GHsd+Y/DvWla6Iml7rmIdQ=;
        b=Dx23ZPdavnW9B7phwAcvxPzxXRRinKZBMQ1+RQ+A9mDhPIGy80NwvaJJyEc26xz8+6
         6vHu3hZprtc0qM1/mIeh2jzGpSkTHn8HSVpIBlgmNf8pnR7TzC7z1nARR/U6LVugKdKT
         ZPYn3nUmhKr31ajzAPJZdPHJrvlrfntcUXpwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=m/yf7SIy2K041JnsrPIH8GHsd+Y/DvWla6Iml7rmIdQ=;
        b=ili3PoqpbCaDMpxirn517XLtUs4UHHYXDj15CaCdT5aMUOMeArhD5RPqMx47P1lK/n
         WUy/kZ0KWUmeujh2yhvcZq1LAgR1taV3chTH33GBCUm+kDs5IWDjEBnByW9sA4HHxTOD
         38H7Xvul5GOiM8TaKJksl8mZhbDv3MaZyWoEaqU6klCKLj+j8UTfFKtQJPzHUl2OL4Le
         Fj4KeIlXWPBc8alpbB/NHJ3v25xKDGnmOj4sLxH2QMNoFpqnoceT/JPQmcCppMT3xQcX
         /W3HLEXCERxxkqCQe94tVIpjlblYafySo3P2eKIyw/+vd2vCPGamXgS9UShGoSG154p1
         z9lA==
X-Gm-Message-State: AOAM5338kX8mx5YgVcyE2wjLk8cPS02X/nToYIK/UqyqNcwPpMzkMtgv
	upcg2300amJH6dsmsBBuiYfxndA7Z5XZyg==
X-Google-Smtp-Source: ABdhPJxc7dddGn9GGnWL+7FXnGaau93DFPcTAwA+4FZs8MVMJ8OftTqUlD56aKdxkPc3Xrf71X9d/Q==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr13882097wmj.84.1596833233366;
        Fri, 07 Aug 2020 13:47:13 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (9.a.b.2.3.a.a.7.c.e.f.b.f.8.9.f.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:f98f:bfec:7aa3:2ba9])
        by smtp.gmail.com with ESMTPSA id k13sm12312332wmj.14.2020.08.07.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:47:12 -0700 (PDT)
Message-ID: <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Fri, 07 Aug 2020 21:47:12 +0100
In-Reply-To: <20200802143505.88409-1-chris.laplante@agilent.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-08-02 at 10:35 -0400, Chris Laplante via
lists.openembedded.org wrote:
> This patch series replaces the one I sent Friday. It implements two
> backtraces when a Bash shell function fails:
>=20
> 1) A backtrace within the .run file that BB generated.
> 2) A computed backtrace of the actual metadata locations (e.g. bb or
>     bbclass) where each shell function is defined.
>=20
> At one point I had both backtraces implemented entirely in the shell
> traps. I moved (2) to build.py because it is easier to implement in
> Python. One nice thing about leaving it in the shell trap would be
> that
> it would still work even if a user was running a .run script
> directly,
> but it seems like not many people do that. Still, if it's something
> we're interested in, know that it's possible.

This didn't work well in testing:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1239/step=
s/10/logs/step1b
from
https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1239

I did grab the failing script:

rpurdie@debian10-ty-1:~$ cat /home/pokybuild/yocto-worker/a-full/build/buil=
d-renamed/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/temp/run.fixup_distc=
c_mirror_tarball.9175=20
#!/bin/sh

# Emit a useful diagnostic if something fails:
bb_sh_exit_handler() {
    ret=3D$?
    if [ "$ret" !=3D 0 ]; then
        echo "WARNING: exit code $ret from a shell command."
    fi
    exit $ret
}

bb_bash_exit_handler() {
    ret=3D$?
    if [ "$ret" !=3D 0 ]; then
        echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '=
$BASH_COMMAND'"

        echo "WARNING: Backtrace (BB generated script): "
        for ((i=3D1; i<${#FUNCNAME[@]}; i++)); do
            if [ $i -eq 1 ]; then
                # TODO: maybe manually track LINENO with a DEBUG trap?
                # LINENO / BASH_LINENO for the first frame in an EXIT trap =
is wrong :/
                # http://gnu-bash.2382.n7.nabble.com/trap-echo-quot-trap-ex=
it-on-LINENO-quot-EXIT-gt-wrong-linenumber-td3666.html
                echo "	#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, =
line ?"
            else
                echo "	#$((i)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, =
line ${BASH_LINENO[$((i-1))]}"
            fi
        done
    fi
    exit $ret
}

bb_bash_err_handler() {
    ret=3D$?
    echo "WARNING: ${BASH_SOURCE[0]}:${BASH_LINENO[0]} exit $ret from '$BAS=
H_COMMAND'"

    echo "WARNING: Backtrace (BB generated script): "
    for ((i=3D1; i<${#FUNCNAME[@]}; i++)); do
        echo "	#$((i-1)): ${FUNCNAME[$i]}, ${BASH_SOURCE[$((i-1))]}, line $=
{BASH_LINENO[$((i-1))]}"
    done

    trap "" EXIT
    exit $ret
}

case $BASH_VERSION in
"") trap 'bb_sh_exit_handler' 0
    set -e
    ;;
*)  trap 'bb_bash_err_handler' ERR
    trap 'bb_bash_exit_handler' 0
    set -eE
esac
export AR=3D"i686-poky-linux-gcc-ar"
export AS=3D"i686-poky-linux-as  "
export BUILD_AR=3D"ar"
export BUILD_AS=3D"as "
export BUILD_CC=3D"gcc "
export BUILD_CCLD=3D"gcc "
export BUILD_CFLAGS=3D"-isystem/home/pokybuild/yocto-worker/a-full/build/bu=
ild/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/=
include -O2 -pipe"
export BUILD_CPP=3D"gcc  -E"
export BUILD_CPPFLAGS=3D"-isystem/home/pokybuild/yocto-worker/a-full/build/=
build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/us=
r/include"
export BUILD_CXX=3D"g++ "
export BUILD_CXXFLAGS=3D"-isystem/home/pokybuild/yocto-worker/a-full/build/=
build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/us=
r/include -O2 -pipe"
export BUILD_FC=3D"gfortran "
export BUILD_LD=3D"ld "
export BUILD_LDFLAGS=3D"-L/home/pokybuild/yocto-worker/a-full/build/build/t=
mp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/lib  =
                       -L/home/pokybuild/yocto-worker/a-full/build/build/tm=
p/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/lib       =
                  -Wl,--enable-new-dtags                         -Wl,-rpath=
-link,/home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32-pok=
y-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/lib                      =
   -Wl,-rpath-link,/home/pokybuild/yocto-worker/a-full/build/build/tmp/work=
/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/lib             =
            -Wl,-rpath,/home/pokybuild/yocto-worker/a-full/build/build/tmp/=
work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/lib     =
                    -Wl,-rpath,/home/pokybuild/yocto-worker/a-full/build/bu=
ild/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/lib =
                        -Wl,-O1 -Wl,--allow-shlib-undefined -Wl,--dynamic-l=
inker=3D/home/pokybuild/yocto-worker/a-full/build/build/tmp/sysroots-uninat=
ive/x86_64-linux/lib/ld-linux-x86-64.so.2"
export BUILD_NM=3D"nm"
export BUILD_RANLIB=3D"ranlib"
export BUILD_STRIP=3D"strip"
export CC=3D"i686-poky-linux-gcc  -m32 -march=3Dcore2 -mtune=3Dcore2 -msse3=
 -mfpmath=3Dsse -fstack-protector-strong  -D_FORTIFY_SOURCE=3D2 -Wformat -W=
format-security -Werror=3Dformat-security --sysroot=3D/home/pokybuild/yocto=
-worker/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/rec=
ipe-sysroot"
export CCLD=3D"i686-poky-linux-gcc  -m32 -march=3Dcore2 -mtune=3Dcore2 -mss=
e3 -mfpmath=3Dsse -fstack-protector-strong  -D_FORTIFY_SOURCE=3D2 -Wformat =
-Wformat-security -Werror=3Dformat-security --sysroot=3D/home/pokybuild/yoc=
to-worker/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/r=
ecipe-sysroot"
export CC_FOR_BUILD=3D"gcc "
export CFLAGS=3D" -O2 -pipe -g -feliminate-unused-debug-types -fmacro-prefi=
x-map=3D/home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32-p=
oky-linux/distcc/3.3.3-r0=3D/usr/src/debug/distcc/3.3.3-r0                 =
     -fdebug-prefix-map=3D/home/pokybuild/yocto-worker/a-full/build/build/t=
mp/work/core2-32-poky-linux/distcc/3.3.3-r0=3D/usr/src/debug/distcc/3.3.3-r=
0                      -fdebug-prefix-map=3D/home/pokybuild/yocto-worker/a-=
full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroo=
t=3D                      -fdebug-prefix-map=3D/home/pokybuild/yocto-worker=
/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sys=
root-native=3D "
export CFLAGS_FOR_BUILD=3D"-isystem/home/pokybuild/yocto-worker/a-full/buil=
d/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/=
usr/include -O2 -pipe"
export CPP=3D"i686-poky-linux-gcc -E --sysroot=3D/home/pokybuild/yocto-work=
er/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-s=
ysroot  -m32 -march=3Dcore2 -mtune=3Dcore2 -msse3 -mfpmath=3Dsse -fstack-pr=
otector-strong  -D_FORTIFY_SOURCE=3D2 -Wformat -Wformat-security -Werror=3D=
format-security"
export CPPFLAGS=3D""
export CPPFLAGS_FOR_BUILD=3D"-isystem/home/pokybuild/yocto-worker/a-full/bu=
ild/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-nativ=
e/usr/include"
export CPP_FOR_BUILD=3D"gcc  -E"
export CXX=3D"i686-poky-linux-g++  -m32 -march=3Dcore2 -mtune=3Dcore2 -msse=
3 -mfpmath=3Dsse -fstack-protector-strong  -D_FORTIFY_SOURCE=3D2 -Wformat -=
Wformat-security -Werror=3Dformat-security --sysroot=3D/home/pokybuild/yoct=
o-worker/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/re=
cipe-sysroot"
export CXXFLAGS=3D" -O2 -pipe -g -feliminate-unused-debug-types -fmacro-pre=
fix-map=3D/home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32=
-poky-linux/distcc/3.3.3-r0=3D/usr/src/debug/distcc/3.3.3-r0               =
       -fdebug-prefix-map=3D/home/pokybuild/yocto-worker/a-full/build/build=
/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0=3D/usr/src/debug/distcc/3.3.3=
-r0                      -fdebug-prefix-map=3D/home/pokybuild/yocto-worker/=
a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysr=
oot=3D                      -fdebug-prefix-map=3D/home/pokybuild/yocto-work=
er/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-s=
ysroot-native=3D  -fvisibility-inlines-hidden"
export CXXFLAGS_FOR_BUILD=3D"-isystem/home/pokybuild/yocto-worker/a-full/bu=
ild/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-nativ=
e/usr/include -O2 -pipe"
export CXX_FOR_BUILD=3D"g++ "
unset DISTRO
export FC=3D"i686-poky-linux-gfortran  -m32 -march=3Dcore2 -mtune=3Dcore2 -=
msse3 -mfpmath=3Dsse -fstack-protector-strong  -D_FORTIFY_SOURCE=3D2 -Wform=
at -Wformat-security -Werror=3Dformat-security --sysroot=3D/home/pokybuild/=
yocto-worker/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r=
0/recipe-sysroot"
export GIT_CEILING_DIRECTORIES=3D"/home/pokybuild/yocto-worker/a-full/build=
/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0"
export HOME=3D"/home/pokybuild"
export LC_ALL=3D"en_US.UTF-8"
export LD=3D"i686-poky-linux-ld --sysroot=3D/home/pokybuild/yocto-worker/a-=
full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroo=
t  "
export LDFLAGS=3D"-Wl,-O1 -Wl,--hash-style=3Dgnu  -Wl,-z,relro,-z,now"
export LDFLAGS_FOR_BUILD=3D"-L/home/pokybuild/yocto-worker/a-full/build/bui=
ld/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/l=
ib                         -L/home/pokybuild/yocto-worker/a-full/build/buil=
d/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/lib   =
                      -Wl,--enable-new-dtags                         -Wl,-r=
path-link,/home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32=
-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/lib                  =
       -Wl,-rpath-link,/home/pokybuild/yocto-worker/a-full/build/build/tmp/=
work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/lib         =
                -Wl,-rpath,/home/pokybuild/yocto-worker/a-full/build/build/=
tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/lib =
                        -Wl,-rpath,/home/pokybuild/yocto-worker/a-full/buil=
d/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/=
lib                         -Wl,-O1 -Wl,--allow-shlib-undefined -Wl,--dynam=
ic-linker=3D/home/pokybuild/yocto-worker/a-full/build/build/tmp/sysroots-un=
inative/x86_64-linux/lib/ld-linux-x86-64.so.2"
export LD_FOR_BUILD=3D"ld "
export LOGNAME=3D"pokybuild"
unset MACHINE
export MAKE=3D"make"
export NM=3D"i686-poky-linux-nm"
export OBJCOPY=3D"i686-poky-linux-objcopy"
export OBJDUMP=3D"i686-poky-linux-objdump"
export PATH=3D"/home/pokybuild/yocto-worker/a-full/build/build/tmp/sysroots=
-uninative/x86_64-linux/usr/bin:/home/pokybuild/yocto-worker/a-full/build/s=
cripts:/home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32-po=
ky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/bin/i686-poky-linux:/hom=
e/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32-poky-linux/di=
stcc/3.3.3-r0/recipe-sysroot/usr/bin/crossscripts:/home/pokybuild/yocto-wor=
ker/a-full/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-=
sysroot-native/usr/sbin:/home/pokybuild/yocto-worker/a-full/build/build/tmp=
/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-native/usr/bin:/ho=
me/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32-poky-linux/d=
istcc/3.3.3-r0/recipe-sysroot-native/sbin:/home/pokybuild/yocto-worker/a-fu=
ll/build/build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot-=
native/bin:/home/pokybuild/yocto-worker/a-full/build/bitbake/bin:/home/poky=
build/yocto-worker/a-full/build/build/tmp/hosttools"
export PERL_HASH_SEED=3D"0"
export PKG_CONFIG_DIR=3D"/home/pokybuild/yocto-worker/a-full/build/build/tm=
p/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot/usr/lib/pkgconfig=
"
export PKG_CONFIG_DISABLE_UNINSTALLED=3D"yes"
export PKG_CONFIG_LIBDIR=3D"/home/pokybuild/yocto-worker/a-full/build/build=
/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot/usr/lib/pkgcon=
fig"
export PKG_CONFIG_PATH=3D"/home/pokybuild/yocto-worker/a-full/build/build/t=
mp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot/usr/lib/pkgconfi=
g:/home/pokybuild/yocto-worker/a-full/build/build/tmp/work/core2-32-poky-li=
nux/distcc/3.3.3-r0/recipe-sysroot/usr/share/pkgconfig"
export PKG_CONFIG_SYSROOT_DIR=3D"/home/pokybuild/yocto-worker/a-full/build/=
build/tmp/work/core2-32-poky-linux/distcc/3.3.3-r0/recipe-sysroot"
export PKG_CONFIG_SYSTEM_INCLUDE_PATH=3D"/usr/include"
export PKG_CONFIG_SYSTEM_LIBRARY_PATH=3D"/lib:/usr/lib"
export PSEUDO_DISABLED=3D"1"
export PSEUDO_UNLOAD=3D"1"
export PYTHONHASHSEED=3D"0"
export RANLIB=3D"i686-poky-linux-gcc-ranlib"
export READELF=3D"i686-poky-linux-readelf"
unset SHELL
export SOURCE_DATE_EPOCH=3D"0"
export STRINGS=3D"i686-poky-linux-strings"
export STRIP=3D"i686-poky-linux-strip"
unset TARGET_ARCH
export TZ=3D"UTC"
export USER=3D"pokybuild"
export base_bindir=3D"/bin"
export base_libdir=3D"/lib"
export base_prefix=3D""
export base_sbindir=3D"/sbin"
export bindir=3D"/usr/bin"
export datadir=3D"/usr/share"
export docdir=3D"/usr/share/doc"
export exec_prefix=3D"/usr"
export includedir=3D"/usr/include"
export infodir=3D"/usr/share/info"
export libdir=3D"/usr/lib"
export libexecdir=3D"/usr/libexec"
export localstatedir=3D"/var"
export lt_cv_sys_lib_dlsearch_path_spec=3D"/usr/lib /lib"
export mandir=3D"/usr/share/man"
export nonarch_base_libdir=3D"/lib"
export nonarch_libdir=3D"/usr/lib"
export oldincludedir=3D"/usr/include"
export prefix=3D"/usr"
export sbindir=3D"/usr/sbin"
export servicedir=3D"/srv"
export sharedstatedir=3D"/com"
export sysconfdir=3D"/etc"
export systemd_system_unitdir=3D"/lib/systemd/system"
export systemd_unitdir=3D"/lib/systemd"
export systemd_user_unitdir=3D"/usr/lib/systemd/user"

# line: 72, file: /home/pokybuild/yocto-worker/a-full/build/meta/recipes-de=
vtools/distcc/distcc_3.3.3.bb
fixup_distcc_mirror_tarball() {
	TBALL=3D/srv/autobuilder/autobuilder.yoctoproject.org/current_sources/git2=
_github.com.distcc.distcc.git.tar.gz
	if [ -f $TBALL ]; then
		TDIR=3D`mktemp -d`
		cd $TDIR
		tar -xzf $TBALL
		set +e
		git rev-parse --verify 3.2
		if [ "$?" !=3D "0" ]; then
			git branch 3.2 d8b18df3e9dcbe4f092bed565835d3975e99432c
			tar -czf $TBALL *
		fi
		set -e
		rm -rf $TDIR/*
	fi
}

fixup_distcc_mirror_tarball

# cleanup
ret=3D$?
trap '' 0
exit $ret

