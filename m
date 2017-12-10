Return-Path: <akuster808@gmail.com>
Received: from mail-pg0-f42.google.com (mail-pg0-f42.google.com [74.125.83.42])
	by mail.openembedded.org (Postfix) with ESMTP id 2D3DF71DD2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Dec 2017 23:17:51 +0000 (UTC)
Received: by mail-pg0-f42.google.com with SMTP id y6so9643448pgp.4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Dec 2017 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:from:subject:message-id:date:user-agent:mime-version
	:content-language;
	bh=hJXeOm/nu9V96VJzMuRZtSb7xeu/diDtfl+ukiMbN6I=;
	b=i6/nkyBI7Pz72lIl4Fzm5mtrHjGyBHRQDZd+KFLH76wKUKf23nXTOhYShzmHxsACum
	ddW235UkTmS2RP0n7f7iwKY0iqVfwjORpC40pFmR+n/hiZHjp3RgWiT7xgXI9H8Lnwhm
	crzX7MdMNEy6utraOQqLtWSovQJFN6JmmknkGrBZ2/lOmEEpqbJ2nqMHS7IBTJhKJl1C
	gXd6vS3A4LUlBIFkzJVo3+mJkFu+TCgdB2dDxx83rMDpmzXz/bj/ltT3/xMz2AmuKU9n
	h9pQ8x1SMYDjIxafLt6DY1aR8srdxi53zTtUz038j5cp6v6YH1Df7X349e2iFF93xNoU
	XlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:to:from:subject:message-id:date:user-agent
	:mime-version:content-language;
	bh=hJXeOm/nu9V96VJzMuRZtSb7xeu/diDtfl+ukiMbN6I=;
	b=qaOLQ727BwkE1PoR5V5tqFHGi+oHxe/PZaWjwiLetM+D9ZD0E5Wb/foHJ0spapC26a
	JxpU2rM3PdqfcUFINc7N1v1lPOFgmgGBOv9YelCuyrxfGwa/CCQfjcKoDiX19r8LikcQ
	NDXDoHuO9EXQLbZsIXIjYDkkrIu+ljkqQjh2O65hJkKvkfWveGTRQ2tC6YDU5TspY6uv
	M+KtrDvMcLY3R7b3zqR/v8pbTe1DO0j2wwXbYdyNgb+nlnMbBm+uUi4GAcbX7/FhybMs
	k2COCnfavXGBx7ah2FToxYCKUqIRwCpqooO8ZyjcxAlZhhA6SX5QixjOfPAOfuIXqXUR
	fK9Q==
X-Gm-Message-State: AKGB3mK4IzRVcaUHtUejJw6TrzTm7RB1V6xRGh7gqKxJIUfOQX6emvSf
	dZROVpOTEtW+flvcvqVZCX+RHg==
X-Google-Smtp-Source: ACJfBos14rI+1riBIC4uEUoTCNOaZOwLyo6peHNxGhq8jz4oMxZ7O2UdEWxAMM6yTNPMTAgvxvziGw==
X-Received: by 10.101.75.82 with SMTP id k18mr1200285pgt.234.1512947871265;
	Sun, 10 Dec 2017 15:17:51 -0800 (PST)
Received: from ?IPv6:2601:202:4001:9ea0:e123:fa08:5e4f:33d?
	([2601:202:4001:9ea0:e123:fa08:5e4f:33d])
	by smtp.gmail.com with ESMTPSA id
	f79sm23570222pfd.45.2017.12.10.15.17.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 10 Dec 2017 15:17:50 -0800 (PST)
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
From: akuster808 <akuster808@gmail.com>
Message-ID: <cf3457ab-712d-a610-0a7c-87de94160eaa@gmail.com>
Date: Sun, 10 Dec 2017 15:17:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.0
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 17 Dec 2017 14:25:17 +0000
Subject: State of bitbake world, Failed tasks 2017-12-07
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
X-List-Received-Date: Sun, 10 Dec 2017 23:17:52 -0000
Content-Type: multipart/alternative;
	boundary="------------80084A18AD7A7E0A8270D4A5"
Content-Language: en-US

--------------80084A18AD7A7E0A8270D4A5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

http://www.openembedded.org/wiki/Bitbake_World_Status

=3D=3D Number of issues - stats =3D=3D
{| class=3D'wikitable'
!|Date		     !!colspan=3D'4'|Failed tasks			    !!|Signatures		  !!colspa=
n=3D'15'|QA !!Comment
|-
||		||qemuarm	||qemuarm64	||qemux86	||qemux86_64	||all 	||already-strippe=
d	||libdir	||textrel	||build-deps	||file-rdeps	||version-going-backwards	=
||host-user-contaminated	||installed-vs-shipped	||unknown-configure-optio=
n	||symlink-to-sysroot	||invalid-pkgconfig	||pkgname	||ldflags	||compile-=
host-path	||qa_pseudo	||=09
|-
||2017-12-07	||8	||12	||36	||8	||0	||0		||0		||2		||0		||0		||0		||8		||1=
		||0		||0		||0		||0		||0		||0		||515		||=09
|}

=3D=3D Failed tasks 2017-12-07 =3D=3D

INFO: jenkins-job.sh-1.8.43 Complete log available at http://logs.nslu2-l=
inux.org/buildlogs/oe/world/sumo/log.report.20171209_044021.log

=3D=3D=3D common (6) =3D=3D=3D
    * meta-openembedded/meta-gnome/recipes-gnome/eds/evolution-data-serve=
r_git.bb:do_compile
    * meta-openembedded/meta-gnome/recipes-gnome/libgnome/libgnome_2.32.1=
=2Ebb:do_compile
    * meta-openembedded/meta-networking/recipes-daemons/ddclient/ddclient=
_3.8.3.bb:do_install
    * meta-openembedded/meta-networking/recipes-daemons/postfix/postfix_3=
=2E2.2.bb:do_install
    * meta-openembedded/meta-oe/recipes-devtools/glade/glade_3.20.0.bb:do=
_compile
    * meta-openembedded/meta-xfce/recipes-xfce/gtk-xfce-engine/gtk-xfce-e=
ngine_3.2.0.bb:do_compile

=3D=3D=3D common-x86 (0) =3D=3D=3D

=3D=3D=3D qemuarm (2) =3D=3D=3D
    * meta-openembedded/meta-oe/recipes-devtools/android-tools/android-to=
ols_5.1.1.r37.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtsystems_git.bb:do_package_qa

=3D=3D=3D qemuarm64 (6) =3D=3D=3D
    * meta-openembedded/meta-initramfs/recipes-devtools/mtd/ubi-utils-kli=
bc_1.5.2.bb:do_install
    * meta-openembedded/meta-initramfs/recipes-kernel/kexec/kexec-tools-k=
libc_2.0.2.bb:do_configure
    * meta-openembedded/meta-oe/recipes-devtools/luajit/luajit_2.0.5.bb:d=
o_compile
    * meta-qt5/recipes-connectivity/libqofono/libqofono_git.bb:do_package=
_qa
    * openembedded-core/meta/recipes-core/glibc/glibc-locale_2.26.bb:do_p=
ackage_qa
    * openembedded-core/meta/recipes-kernel/kexec/kexec-tools_2.0.15.bb:d=
o_compile

=3D=3D=3D qemux86 (30) =3D=3D=3D
    * meta-browser/recipes-browser/chromium/chromium-ozone-wayland_64.0.3=
274.0.r517731.igalia.1.bb:do_compile
    * meta-browser/recipes-browser/chromium/chromium-x11_62.0.3202.94.bb:=
do_compile
    * meta-browser/recipes-browser/firefox/firefox_45.9.0esr.bb:do_compil=
e
    * meta-openembedded/meta-networking/recipes-connectivity/rdist/rdist_=
6.1.5.bb:do_package
    * meta-openembedded/meta-networking/recipes-connectivity/samba/samba_=
4.7.0.bb:do_patch
    * meta-openembedded/meta-networking/recipes-daemons/opensaf/opensaf_5=
=2E17.07.bb:do_compile
    * meta-openembedded/meta-networking/recipes-daemons/vsftpd/vsftpd_3.0=
=2E3.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rsh/netkit-=
rsh_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rusers/netk=
it-rusers_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-telnet/netk=
it-telnet_0.17.bb:do_configure
    * meta-openembedded/meta-networking/recipes-protocols/mdns/mdns_765.5=
0.9.bb:do_compile
    * meta-openembedded/meta-networking/recipes-protocols/tsocks/tsocks_1=
=2E8beta5.bb:do_compile
    * meta-openembedded/meta-networking/recipes-support/open-isns/open-is=
ns_0.97.bb:do_compile
    * meta-openembedded/meta-oe/recipes-benchmark/libhugetlbfs/libhugetlb=
fs_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-connectivity/umip/umip_1.0.bb:do_=
compile
    * meta-openembedded/meta-oe/recipes-connectivity/wvdial/wvdial_1.61.b=
b:do_compile
    * meta-openembedded/meta-oe/recipes-devtools/pm-qa/pm-qa_git.bb:do_co=
mpile
    * meta-openembedded/meta-oe/recipes-extended/mraa/mraa_git.bb:do_comp=
ile
    * meta-openembedded/meta-oe/recipes-kernel/crash/crash_7.1.9.bb:do_co=
mpile
    * meta-openembedded/meta-oe/recipes-kernel/minicoredumper/minicoredum=
per_2.0.0.bb:do_compile
    * meta-openembedded/meta-oe/recipes-multimedia/alsa/alsa-oss_1.0.17.b=
b:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python3-syste=
md_234.bb:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python-system=
d_234.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qt3d_git.bb:do_package_qa
    * meta-qt5/recipes-qt/qt5/qtlocation_git.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtmultimedia_git.bb:do_package_qa
    * openembedded-core/meta/recipes-devtools/systemd-bootchart/systemd-b=
ootchart_231.bb:do_compile
    * openembedded-core/meta/recipes-graphics/cogl/cogl-1.0_1.22.2.bb:do_=
compile
    * openembedded-core/meta/recipes-multimedia/gstreamer/gstreamer1.0-pl=
ugins-bad_1.12.3.bb:do_compile
    * openembedded-core/meta/recipes-multimedia/x264/x264_git.bb:do_packa=
ge_qa

=3D=3D=3D qemux86_64 (1) =3D=3D=3D
    * meta-browser/recipes-browser/chromium/chromium-ozone-wayland_64.0.3=
274.0.r517731.igalia.1.bb:do_configure

=3D=3D=3D Number of failed tasks (64) =3D=3D=3D
{| class=3Dwikitable
|-
|| qemuarm 	|| 8	 || http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/=
log.world.qemuarm.20171206_171004.log/ || http://errors.yoctoproject.org/=
Errors/Build/49258/
|-
|| qemuarm64 	|| 12	 || http://logs.nslu2-linux.org/buildlogs/oe/world/su=
mo/log.world.qemuarm64.20171207_184553.log/ || http://errors.yoctoproject=
=2Eorg/Errors/Build/49290/
|-
|| qemux86 	|| 36	 || http://logs.nslu2-linux.org/buildlogs/oe/world/sumo=
/log.world.qemux86.20171206_171014.log/ ||=20
|-
|| qemux86_64 	|| 8	 || http://logs.nslu2-linux.org/buildlogs/oe/world/su=
mo/log.world.qemux86-64.20171207_171249.log/ || http://errors.yoctoprojec=
t.org/Errors/Build/49282/
|}

=3D=3D=3D PNBLACKLISTs (0) =3D=3D=3D

=3D=3D=3D QA issues (526) =3D=3D=3D
{| class=3Dwikitable
!| Count		||Issue
|-
||0	||already-stripped
|-
||0	||build-deps
|-
||0	||compile-host-path
|-
||0	||file-rdeps
|-
||0	||invalid-pkgconfig
|-
||0	||ldflags
|-
||0	||libdir
|-
||0	||pkgname
|-
||0	||symlink-to-sysroot
|-
||0	||unknown-configure-option
|-
||0	||version-going-backwards
|-
||1	||installed-vs-shipped
|-
||2	||textrel
|-
||515	||qa_pseudo
|-
||8	||host-user-contaminated
|}



=3D=3D=3D Incorrect PACKAGE_ARCH or sstate signatures (0) =3D=3D=3D

Complete log: http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.sig=
natures.20171208_233417.log/


    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe=
/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.b=
b RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable =
providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86copy in /=
home/jenkins/oe/world/shr-core/tmpfs/stamps
    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe=
/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.b=
b RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable =
providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86 in /home=
/jenkins/oe/world/shr-core/tmpfs/stamps


PNBLACKLISTs:
openembedded-core/:
meta-browser:
meta-openembedded:
meta-qt5:
PNBLACKLIST[android-system] =3D "depends on lxc from meta-virtualiazation=
 which isn't included in my world builds"
PNBLACKLIST[bigbuckbunny-1080p] =3D "big and doesn't really need to be te=
sted so much"
PNBLACKLIST[bigbuckbunny-480p] =3D "big and doesn't really need to be tes=
ted so much"
PNBLACKLIST[bigbuckbunny-720p] =3D "big and doesn't really need to be tes=
ted so much"
PNBLACKLIST[bigbuckbunny-720p] =3D "big and doesn't really need to be tes=
ted so much"
PNBLACKLIST[tearsofsteel-1080p] =3D "big and doesn't really need to be te=
sted so much"
PNBLACKLIST[build-appliance-image] =3D "tries to include whole downloads =
directory in /home/builder/poky :/"


QA issues by type:
count: 0	issue: already-stripped


count: 0	issue: libdir


count: 2	issue: textrel
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x2=
64/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264-bin/usr/bin/x264' h=
as relocations in .text [textrel]
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x2=
64/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264/usr/lib/libx264.so.=
148' has relocations in .text [textrel]


count: 0	issue: build-deps


count: 0	issue: file-rdeps


count: 0	issue: version-going-backwards


count: 8	issue: host-user-contaminated
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-ar-ss/usr/lib/l=
ocale/ar_SS/LC_NUMERIC is owned by uid 3004, which is the same as the use=
r running bitbake. This may be due to host contamination [host-user-conta=
minated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-en-ie/usr/lib/l=
ocale/en_IE/LC_MEASUREMENT is owned by uid 3004, which is the same as the=
 user running bitbake. This may be due to host contamination [host-user-c=
ontaminated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-es-hn/usr/lib/l=
ocale/es_HN/LC_CTYPE is owned by uid 3004, which is the same as the user =
running bitbake. This may be due to host contamination [host-user-contami=
nated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-so-ke.iso-8859-=
1/usr/lib/locale/so_KE.ISO-8859-1/LC_PAPER is owned by uid 3004, which is=
 the same as the user running bitbake. This may be due to host contaminat=
ion [host-user-contaminated]
libqofono-0.92+gitrAUTOINC+6916cd030b: libqofono: /libqofono-tests/usr/li=
b/libqofono-qt5/tests/tst_qofonosimmanager is owned by uid 3004, which is=
 the same as the user running bitbake. This may be due to host contaminat=
ion [host-user-contaminated]
qt3d-5.9.2+gitAUTOINC+143b721249: qt3d: /qt3d-mkspecs/usr/lib/qt5/mkspecs=
/modules/qt_lib_3dcore_private.pri is owned by uid 3004, which is the sam=
e as the user running bitbake. This may be due to host contamination [hos=
t-user-contaminated]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: qtmultimedia: /qtmultimedia-mks=
pecs/usr/lib/qt5/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pr=
i is owned by uid 3004, which is the same as the user running bitbake. Th=
is may be due to host contamination [host-user-contaminated]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: qtsystems: /qtsystems-mkspecs/usr/=
lib/qt5/mkspecs/modules/qt_lib_publishsubscribe_private.pri is owned by u=
id 3004, which is the same as the user running bitbake. This may be due t=
o host contamination [host-user-contaminated]


count: 1	issue: installed-vs-shipped
rdist: 1 installed and not shipped files. [installed-vs-shipped]


count: 0	issue: unknown-configure-option


count: 0	issue: symlink-to-sysroot


count: 0	issue: invalid-pkgconfig


count: 0	issue: pkgname


count: 0	issue: ldflags


count: 0	issue: compile-host-path


count: 515	issue: qa_pseudo
acl-2.2.52: This /work/armv5te-oe-linux-gnueabi/acl/2.2.52-r0/pseudo/pseu=
do.log indicates 10 errors [qa_pseudo]
acpid-2.0.28: This /work/armv5te-oe-linux-gnueabi/acpid/2.0.28-r0/pseudo/=
pseudo.log indicates 10 errors [qa_pseudo]
alsa-equal-0.6: This /work/core2-64-oe-linux/alsa-equal/0.6-r0/pseudo/pse=
udo.log indicates 10 errors [qa_pseudo]
alsa-oss-1.0.17: This /work/core2-64-oe-linux/alsa-oss/1.0.17-r1/pseudo/p=
seudo.log indicates 10 errors [qa_pseudo]
alsa-plugins-1.1.4: This /work/armv5te-oe-linux-gnueabi/alsa-plugins/1.1.=
4-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
apache2-2.4.29: This /work/aarch64-oe-linux/apache2/2.4.29-r0/pseudo/pseu=
do.log indicates 7 errors [qa_pseudo]
apache2-2.4.29: This /work/armv5te-oe-linux-gnueabi/apache2/2.4.29-r0/pse=
udo/pseudo.log indicates 4 errors [qa_pseudo]
apache2-2.4.29: This /work/core2-64-oe-linux/apache2/2.4.29-r0/pseudo/pse=
udo.log indicates 5 errors [qa_pseudo]
apache2-2.4.29: This /work/i586-oe-linux-musl/apache2/2.4.29-r0/pseudo/ps=
eudo.log indicates 6 errors [qa_pseudo]
arptables-0.0.4+gitAUTOINC+f4ab8f63f1: This /work/armv5te-oe-linux-gnueab=
i/arptables/0.0.4+gitAUTOINC+f4ab8f63f1-r0/pseudo/pseudo.log indicates 10=
 errors [qa_pseudo]
asciidoc-8.6.9: This /work/aarch64-oe-linux/asciidoc/8.6.9-r0/pseudo/pseu=
do.log indicates 12 errors [qa_pseudo]
blktrace-1.1.0+gitAUTOINC+43fc870ce0: This /work/aarch64-oe-linux/blktrac=
e/1.1.0+gitAUTOINC+43fc870ce0-r0/pseudo/pseudo.log indicates 12 errors [q=
a_pseudo]
bluez5-5.47: This /work/aarch64-oe-linux/bluez5/5.47-r0/pseudo/pseudo.log=
 indicates 10 errors [qa_pseudo]
bluez5-5.47: This /work/armv5te-oe-linux-gnueabi/bluez5/5.47-r0/pseudo/ps=
eudo.log indicates 10 errors [qa_pseudo]
bluez5-5.47: This /work/core2-64-oe-linux/bluez5/5.47-r0/pseudo/pseudo.lo=
g indicates 11 errors [qa_pseudo]
bmap-tools-3.4: This /work/armv5te-oe-linux-gnueabi/bmap-tools/3.4-r0/pse=
udo/pseudo.log indicates 4 errors [qa_pseudo]
boost-1.65.1: This /work/armv5e-oe-linux-gnueabi/boost/1.65.1-r0/pseudo/p=
seudo.log indicates 10 errors [qa_pseudo]
btrfs-tools-4.13.3: This /work/core2-64-oe-linux/btrfs-tools/4.13.3-r0/ps=
eudo/pseudo.log indicates 16 errors [qa_pseudo]
busybox-1.27.2: This /work/core2-64-oe-linux/busybox/1.27.2-r0/pseudo/pse=
udo.log indicates 11 errors [qa_pseudo]
byacc-20170201: This /work/core2-64-oe-linux/byacc/20170201-r0/pseudo/pse=
udo.log indicates 9 errors [qa_pseudo]
cdrkit-1.1.11: This /work/core2-64-oe-linux/cdrkit/1.1.11-r0/pseudo/pseud=
o.log indicates 10 errors [qa_pseudo]
cgdb-0.6.8: This /work/armv5te-oe-linux-gnueabi/cgdb/0.6.8-r0/pseudo/pseu=
do.log indicates 4 errors [qa_pseudo]
cherokee-1.2.104+gitAUTOINC+75f041e225: This /work/armv5te-oe-linux-gnuea=
bi/cherokee/1.2.104+gitAUTOINC+75f041e225-r0/pseudo/pseudo.log indicates =
10 errors [qa_pseudo]
chrony-3.2: This /work/aarch64-oe-linux/chrony/3.2-r0/pseudo/pseudo.log i=
ndicates 6 errors [qa_pseudo]
chrony-3.2: This /work/armv5te-oe-linux-gnueabi/chrony/3.2-r0/pseudo/pseu=
do.log indicates 4 errors [qa_pseudo]
chrony-3.2: This /work/core2-64-oe-linux/chrony/3.2-r0/pseudo/pseudo.log =
indicates 6 errors [qa_pseudo]
chrony-3.2: This /work/i586-oe-linux-musl/chrony/3.2-r0/pseudo/pseudo.log=
 indicates 6 errors [qa_pseudo]
console-tools-0.3.2: This /work/aarch64-oe-linux/console-tools/0.3.2-r8/p=
seudo/pseudo.log indicates 6 errors [qa_pseudo]
coreutils-8.27: This /work/armv5te-oe-linux-gnueabi/coreutils/8.27-r0/pse=
udo/pseudo.log indicates 17 errors [qa_pseudo]
corosync-2.4.3: This /work/aarch64-oe-linux/corosync/2.4.3-r0/pseudo/pseu=
do.log indicates 12 errors [qa_pseudo]
corosync-2.4.3: This /work/core2-64-oe-linux/corosync/2.4.3-r0/pseudo/pse=
udo.log indicates 16 errors [qa_pseudo]
corosync-2.4.3: This /work/i586-oe-linux-musl/corosync/2.4.3-r0/pseudo/ps=
eudo.log indicates 19 errors [qa_pseudo]
cpufrequtils-008: This /work/armv5te-oe-linux-gnueabi/cpufrequtils/008-r5=
/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
cryptodev-tests-1.9: This /work/aarch64-oe-linux/cryptodev-tests/1.9-r0/p=
seudo/pseudo.log indicates 7 errors [qa_pseudo]
ctdb-2.5.6: This /work/i586-oe-linux-musl/ctdb/2.5.6-r0/pseudo/pseudo.log=
 indicates 6 errors [qa_pseudo]
cups-2.2.6: This /work/i586-oe-linux-musl/cups/2.2.6-r0/pseudo/pseudo.log=
 indicates 18 errors [qa_pseudo]
curlpp-0.8.1: This /work/aarch64-oe-linux/curlpp/0.8.1-r0/pseudo/pseudo.l=
og indicates 7 errors [qa_pseudo]
curlpp-0.8.1: This /work/armv5te-oe-linux-gnueabi/curlpp/0.8.1-r0/pseudo/=
pseudo.log indicates 5 errors [qa_pseudo]
curlpp-0.8.1: This /work/core2-64-oe-linux/curlpp/0.8.1-r0/pseudo/pseudo.=
log indicates 5 errors [qa_pseudo]
curlpp-0.8.1: This /work/i586-oe-linux-musl/curlpp/0.8.1-r0/pseudo/pseudo=
=2Elog indicates 7 errors [qa_pseudo]
cxxtest-4.3: This /work/armv5te-oe-linux-gnueabi/cxxtest/4.3-r0/pseudo/ps=
eudo.log indicates 5 errors [qa_pseudo]
dbus-test-1.10.20: This /work/i586-oe-linux-musl/dbus-test/1.10.20-r0/pse=
udo/pseudo.log indicates 10 errors [qa_pseudo]
dhcp-4.3.6: This /work/aarch64-oe-linux/dhcp/4.3.6-r0/pseudo/pseudo.log i=
ndicates 12 errors [qa_pseudo]
dhcp-4.3.6: This /work/armv5te-oe-linux-gnueabi/dhcp/4.3.6-r0/pseudo/pseu=
do.log indicates 10 errors [qa_pseudo]
dhcp-4.3.6: This /work/core2-64-oe-linux/dhcp/4.3.6-r0/pseudo/pseudo.log =
indicates 10 errors [qa_pseudo]
dhcp-4.3.6: This /work/i586-oe-linux-musl/dhcp/4.3.6-r0/pseudo/pseudo.log=
 indicates 12 errors [qa_pseudo]
dleyna-renderer-0.6.0: This /work/armv5te-oe-linux-gnueabi/dleyna-rendere=
r/0.6.0-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
dmalloc-5.5.2: This /work/armv5e-oe-linux-gnueabi/dmalloc/5.5.2-r0/pseudo=
/pseudo.log indicates 4 errors [qa_pseudo]
dovecot-2.2.29: This /work/aarch64-oe-linux/dovecot/2.2.29-r0/pseudo/pseu=
do.log indicates 13 errors [qa_pseudo]
dovecot-2.2.29: This /work/armv5te-oe-linux-gnueabi/dovecot/2.2.29-r0/pse=
udo/pseudo.log indicates 12 errors [qa_pseudo]
dovecot-2.2.29: This /work/core2-64-oe-linux/dovecot/2.2.29-r0/pseudo/pse=
udo.log indicates 11 errors [qa_pseudo]
dovecot-2.2.29: This /work/i586-oe-linux-musl/dovecot/2.2.29-r0/pseudo/ps=
eudo.log indicates 12 errors [qa_pseudo]
dracut-045+git39c9b67f86145953aa30def9d77c68597a4ccfe8: This /work/aarch6=
4-oe-linux/dracut/1_045+git39c9b67f86145953aa30def9d77c68597a4ccfe8-r0/ps=
eudo/pseudo.log indicates 12 errors [qa_pseudo]
dracut-045+git39c9b67f86145953aa30def9d77c68597a4ccfe8: This /work/core2-=
64-oe-linux/dracut/1_045+git39c9b67f86145953aa30def9d77c68597a4ccfe8-r0/p=
seudo/pseudo.log indicates 16 errors [qa_pseudo]
ebtables-2.0.10-4: This /work/aarch64-oe-linux/ebtables/2.0.10-4-r4/pseud=
o/pseudo.log indicates 7 errors [qa_pseudo]
ebtables-2.0.10-4: This /work/core2-64-oe-linux/ebtables/2.0.10-4-r4/pseu=
do/pseudo.log indicates 5 errors [qa_pseudo]
ebtables-2.0.10-4: This /work/i586-oe-linux-musl/ebtables/2.0.10-4-r4/pse=
udo/pseudo.log indicates 14 errors [qa_pseudo]
enca-1.9: This /work/aarch64-oe-linux/enca/1.9-r0/pseudo/pseudo.log indic=
ates 12 errors [qa_pseudo]
espeak-1.48.04: This /work/aarch64-oe-linux/espeak/1.48.04-r0/pseudo/pseu=
do.log indicates 6 errors [qa_pseudo]
espeak-1.48.04: This /work/i586-oe-linux-musl/espeak/1.48.04-r0/pseudo/ps=
eudo.log indicates 6 errors [qa_pseudo]
expat-2.2.5: This /work/armv5te-oe-linux-gnueabi/expat/2.2.5-r0/pseudo/ps=
eudo.log indicates 9 errors [qa_pseudo]
expect-5.45.3: This /work/aarch64-oe-linux/expect/5.45.3-r0/pseudo/pseudo=
=2Elog indicates 6 errors [qa_pseudo]
f2fs-tools-1.8.0: This /work/aarch64-oe-linux/f2fs-tools/1.8.0-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
faac-1.29: This /work/core2-64-oe-linux/faac/1.29-r0/pseudo/pseudo.log in=
dicates 5 errors [qa_pseudo]
faad2-2.7: This /work/core2-64-oe-linux/faad2/2.7-r1/pseudo/pseudo.log in=
dicates 4 errors [qa_pseudo]
firefox-l10n-dsb-45.9.0esr: This /work/all-oe-linux/firefox-l10n-dsb/45.9=
=2E0esr-r3/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
firefox-l10n-kn-45.9.0esr: This /work/all-oe-linux/firefox-l10n-kn/45.9.0=
esr-r3/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
firefox-l10n-rm-45.9.0esr: This /work/all-oe-linux/firefox-l10n-rm/45.9.0=
esr-r3/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
firefox-l10n-sq-45.9.0esr: This /work/all-oe-linux/firefox-l10n-sq/45.9.0=
esr-r3/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
firefox-l10n-te-45.9.0esr: This /work/all-oe-linux/firefox-l10n-te/45.9.0=
esr-r3/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
flex-2.6.0: This /work/armv5te-oe-linux-gnueabi/flex/2.6.0-r0/pseudo/pseu=
do.log indicates 10 errors [qa_pseudo]
freediameter-1.2.1: This /work/armv5te-oe-linux-gnueabi/freediameter/1.2.=
1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
freediameter-1.2.1: This /work/i586-oe-linux-musl/freediameter/1.2.1-r0/p=
seudo/pseudo.log indicates 10 errors [qa_pseudo]
freerdp-2.0.0+gitrAUTOINC+1648deb435: This /work/armv5te-oe-linux-gnueabi=
/freerdp/2.0.0+gitrAUTOINC+1648deb435-r0/pseudo/pseudo.log indicates 10 e=
rrors [qa_pseudo]
fribidi-0.19.7: This /work/armv5te-oe-linux-gnueabi/fribidi/0.19.7-r0/pse=
udo/pseudo.log indicates 15 errors [qa_pseudo]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/aarch64-oe-linux/gateone/1.=
2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 6 errors [qa_pseud=
o]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/armv5te-oe-linux-gnueabi/ga=
teone/1.2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 4 errors [=
qa_pseudo]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/core2-64-oe-linux/gateone/1=
=2E2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 4 errors [qa_ps=
eudo]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/i586-oe-linux-musl/gateone/=
1.2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 6 errors [qa_pse=
udo]
gawk-4.2.0: This /work/aarch64-oe-linux/gawk/4.2.0-r0/pseudo/pseudo.log i=
ndicates 4 errors [qa_pseudo]
gdk-pixbuf-2.36.11: This /work/armv5te-oe-linux-gnueabi/gdk-pixbuf/2.36.1=
1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
geis-2.2.17: This /work/aarch64-oe-linux/geis/2.2.17-r0/pseudo/pseudo.log=
 indicates 12 errors [qa_pseudo]
geoip-1.6.9: This /work/i586-oe-linux-musl/geoip/1.6.9-r0/pseudo/pseudo.l=
og indicates 12 errors [qa_pseudo]
ghostscript-9.21: This /work/i586-oe-linux-musl/ghostscript/9.21-r0/pseud=
o/pseudo.log indicates 18 errors [qa_pseudo]
giflib-5.1.4: This /work/armv5te-oe-linux-gnueabi/giflib/5.1.4-r0/pseudo/=
pseudo.log indicates 10 errors [qa_pseudo]
giflib-5.1.4: This /work/core2-64-oe-linux/giflib/5.1.4-r0/pseudo/pseudo.=
log indicates 10 errors [qa_pseudo]
git-2.15.0: This /work/armv5te-oe-linux-gnueabi/git/2.15.0-r0/pseudo/pseu=
do.log indicates 4 errors [qa_pseudo]
glib-2.0-2.54.2: This /work/aarch64-oe-linux/glib-2.0/1_2.54.2-r0/pseudo/=
pseudo.log indicates 16 errors [qa_pseudo]
glibc-2.26: This /work/aarch64-oe-linux/glibc/2.26-r0/pseudo/pseudo.log i=
ndicates 6 errors [qa_pseudo]
glibc-2.26: This /work/armv5e-oe-linux-gnueabi/glibc/2.26-r0/pseudo/pseud=
o.log indicates 29 errors [qa_pseudo]
glibc-2.26: This /work/core2-64-oe-linux/glibc/2.26-r0/pseudo/pseudo.log =
indicates 264 errors [qa_pseudo]
glibc-locale-2.26: This /work/aarch64-oe-linux/glibc-locale/2.26-r0/pseud=
o/pseudo.log indicates 9 errors [qa_pseudo]
glibc-locale-2.26: This /work/armv5e-oe-linux-gnueabi/glibc-locale/2.26-r=
0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
glibc-locale-2.26: This /work/core2-64-oe-linux/glibc-locale/2.26-r0/pseu=
do/pseudo.log indicates 10 errors [qa_pseudo]
grub-2.02: This /work/i586-oe-linux-musl/grub/2.02-r0/pseudo/pseudo.log i=
ndicates 6 errors [qa_pseudo]
gsettings-desktop-schemas-3.24.1: This /work/aarch64-oe-linux/gsettings-d=
esktop-schemas/3.24.1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo=
]
gstreamer1.0-plugins-bad-1.12.3: This /work/core2-64-oe-linux/gstreamer1.=
0-plugins-bad/1.12.3-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]=

gst-rtsp-0.10.8: This /work/armv5te-oe-linux-gnueabi/gst-rtsp/0.10.8-r0/p=
seudo/pseudo.log indicates 16 errors [qa_pseudo]
gtkmathview-0.8.0+gitAUTOINC+0bc2cfa0a4: This /work/armv5te-oe-linux-gnue=
abi/gtkmathview/0.8.0+gitAUTOINC+0bc2cfa0a4-r3/pseudo/pseudo.log indicate=
s 16 errors [qa_pseudo]
icu-60.1: This /work/aarch64-oe-linux/icu/60.1-r0/pseudo/pseudo.log indic=
ates 7 errors [qa_pseudo]
icu-60.1: This /work/armv5e-oe-linux-gnueabi/icu/60.1-r0/pseudo/pseudo.lo=
g indicates 4 errors [qa_pseudo]
icu-60.1: This /work/core2-64-oe-linux/icu/60.1-r0/pseudo/pseudo.log indi=
cates 5 errors [qa_pseudo]
icu-60.1: This /work/i586-oe-linux-musl/icu/60.1-r0/pseudo/pseudo.log ind=
icates 7 errors [qa_pseudo]
initramfs-module-install-1.0: This /work/aarch64-oe-linux/initramfs-modul=
e-install/1.0-r1/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
initscripts-1.0: This /work/aarch64-oe-linux/initscripts/1.0-r155/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
iotop-0.6: This /work/core2-64-oe-linux/iotop/0.6-r0/pseudo/pseudo.log in=
dicates 4 errors [qa_pseudo]
iozone3-465: This /work/armv5te-oe-linux-gnueabi/iozone3/465-r0/pseudo/ps=
eudo.log indicates 4 errors [qa_pseudo]
iproute2-4.13.0: This /work/armv5te-oe-linux-gnueabi/iproute2/4.13.0-r0/p=
seudo/pseudo.log indicates 4 errors [qa_pseudo]
irda-utils-0.9.18: This /work/i586-oe-linux-musl/irda-utils/0.9.18-r0/pse=
udo/pseudo.log indicates 12 errors [qa_pseudo]
jsonrpc-0.7.0+gitAUTOINC+ccbdb41388: This /work/core2-64-oe-linux/jsonrpc=
/0.7.0+gitAUTOINC+ccbdb41388-r0/pseudo/pseudo.log indicates 10 errors [qa=
_pseudo]
kconfig-frontends-4.11.0.1: This /work/core2-64-oe-linux/kconfig-frontend=
s/4.11.0.1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/aarch64-oe-linux/lcdproc/=
0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 11 errors [qa_=
pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/armv5te-oe-linux-gnueabi/=
lcdproc/0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 11 err=
ors [qa_pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/core2-64-oe-linux/lcdproc=
/0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 10 errors [qa=
_pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/i586-oe-linux-musl/lcdpro=
c/0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 12 errors [q=
a_pseudo]
leptonica-1.74.4: This /work/armv5te-oe-linux-gnueabi/leptonica/1.74.4-r0=
/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
libatasmart-0.19: This /work/aarch64-oe-linux/libatasmart/0.19-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
libatasmart-0.19: This /work/armv5te-oe-linux-gnueabi/libatasmart/0.19-r0=
/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libatasmart-0.19: This /work/core2-64-oe-linux/libatasmart/0.19-r0/pseudo=
/pseudo.log indicates 10 errors [qa_pseudo]
libatasmart-0.19: This /work/i586-oe-linux-musl/libatasmart/0.19-r0/pseud=
o/pseudo.log indicates 12 errors [qa_pseudo]
libblockdev-2.10: This /work/aarch64-oe-linux/libblockdev/2.10-r0/pseudo/=
pseudo.log indicates 18 errors [qa_pseudo]
libbsd-0.8.6: This /work/i586-oe-linux-musl/libbsd/0.8.6-r0/pseudo/pseudo=
=2Elog indicates 12 errors [qa_pseudo]
libconnman-qt5-1.2.4+gitAUTOINC+9d98e12ed6: This /work/aarch64-oe-linux/l=
ibconnman-qt5/1.2.4+gitAUTOINC+9d98e12ed6-r0/pseudo/pseudo.log indicates =
14 errors [qa_pseudo]
libconnman-qt5-1.2.4+gitAUTOINC+9d98e12ed6: This /work/core2-64-oe-linux/=
libconnman-qt5/1.2.4+gitAUTOINC+9d98e12ed6-r0/pseudo/pseudo.log indicates=
 12 errors [qa_pseudo]
libconnman-qt5-1.2.4+gitAUTOINC+9d98e12ed6: This /work/i586-oe-linux-musl=
/libconnman-qt5/1.2.4+gitAUTOINC+9d98e12ed6-r0/pseudo/pseudo.log indicate=
s 13 errors [qa_pseudo]
libee-0.4.1: This /work/i586-oe-linux-musl/libee/0.4.1-r0/pseudo/pseudo.l=
og indicates 15 errors [qa_pseudo]
libevent-2.1.8: This /work/core2-64-oe-linux/libevent/2.1.8-r0/pseudo/pse=
udo.log indicates 10 errors [qa_pseudo]
libgphoto2-2.5.14: This /work/core2-64-oe-linux/libgphoto2/2.5.14-r0/pseu=
do/pseudo.log indicates 10 errors [qa_pseudo]
libhugetlbfs-2.20: This /work/aarch64-oe-linux/libhugetlbfs/1_2.20-r0/pse=
udo/pseudo.log indicates 11 errors [qa_pseudo]
libice-1.0.9: This /work/aarch64-oe-linux/libice/1_1.0.9-r0/pseudo/pseudo=
=2Elog indicates 12 errors [qa_pseudo]
libice-1.0.9: This /work/core2-64-oe-linux/libice/1_1.0.9-r0/pseudo/pseud=
o.log indicates 10 errors [qa_pseudo]
libmoo-perl-2.003002: This /work/aarch64-oe-linux/libmoo-perl/2.003002-r0=
/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libndp-1.6: This /work/i586-oe-linux-musl/libndp/1.6-r0/pseudo/pseudo.log=
 indicates 12 errors [qa_pseudo]
libnet-1.2-rc3: This /work/aarch64-oe-linux/libnet/1.2-rc3-r0/pseudo/pseu=
do.log indicates 12 errors [qa_pseudo]
libnss-mdns-0.10: This /work/core2-64-oe-linux/libnss-mdns/0.10-r7/pseudo=
/pseudo.log indicates 16 errors [qa_pseudo]
libomxil-0.9.3: This /work/aarch64-oe-linux/libomxil/0.9.3-r0/pseudo/pseu=
do.log indicates 12 errors [qa_pseudo]
libpthread-stubs-0.4: This /work/i586-oe-linux-musl/libpthread-stubs/0.4-=
r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/aarch64-oe-linux/libqof=
ono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 16 errors =
[qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/armv5te-oe-linux-gnueab=
i/libqofono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 10=
 errors [qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/core2-64-oe-linux/libqo=
fono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 11 errors=
 [qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/i586-oe-linux-musl/libq=
ofono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 14 error=
s [qa_pseudo]
libsdl2-2.0.7: This /work/i586-oe-linux-musl/libsdl2/2.0.7-r0/pseudo/pseu=
do.log indicates 18 errors [qa_pseudo]
libsdl2-mixer-2.0.1: This /work/i586-oe-linux-musl/libsdl2-mixer/2.0.1-r0=
/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
libsoc-0.8.2: This /work/aarch64-oe-linux/libsoc/0.8.2-r0/pseudo/pseudo.l=
og indicates 11 errors [qa_pseudo]
libtar-1.2.20: This /work/i586-oe-linux-musl/libtar/1.2.20-r0/pseudo/pseu=
do.log indicates 12 errors [qa_pseudo]
libtool-cross-2.4.6: This /work/i586-oe-linux-musl/libtool-cross/2.4.6-r0=
/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
libvncserver-0.9.11: This /work/aarch64-oe-linux/libvncserver/0.9.11-r0/p=
seudo/pseudo.log indicates 13 errors [qa_pseudo]
libvncserver-0.9.11: This /work/armv5te-oe-linux-gnueabi/libvncserver/0.9=
=2E11-r0/pseudo/pseudo.log indicates 22 errors [qa_pseudo]
libvncserver-0.9.11: This /work/core2-64-oe-linux/libvncserver/0.9.11-r0/=
pseudo/pseudo.log indicates 11 errors [qa_pseudo]
libvncserver-0.9.11: This /work/i586-oe-linux-musl/libvncserver/0.9.11-r0=
/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/aarch64-oe-linux/libwmf/0.2.8.4-r3/pseudo/pseu=
do.log indicates 13 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/armv5te-oe-linux-gnueabi/libwmf/0.2.8.4-r3/pse=
udo/pseudo.log indicates 10 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/core2-64-oe-linux/libwmf/0.2.8.4-r3/pseudo/pse=
udo.log indicates 10 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/i586-oe-linux-musl/libwmf/0.2.8.4-r3/pseudo/ps=
eudo.log indicates 12 errors [qa_pseudo]
libxcalibrate-0.0+gitAUTOINC+209d83af61: This /work/i586-oe-linux-musl/li=
bxcalibrate/0.0+gitAUTOINC+209d83af61-r0/pseudo/pseudo.log indicates 12 e=
rrors [qa_pseudo]
libxml2-2.9.7: This /work/armv5te-oe-linux-gnueabi/libxml2/2.9.7-r0/pseud=
o/pseudo.log indicates 4 errors [qa_pseudo]
linux-atm-2.5.2: This /work/qemuarm-oe-linux-gnueabi/linux-atm/2.5.2-r0/p=
seudo/pseudo.log indicates 10 errors [qa_pseudo]
linux-libc-headers-4.12: This /work/i586-oe-linux-musl/linux-libc-headers=
/4.12-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
lio-utils-4.1+gitAUTOINC+28bd928655: This /work/core2-64-oe-linux/lio-uti=
ls/4.1+gitAUTOINC+28bd928655-r0/pseudo/pseudo.log indicates 9 errors [qa_=
pseudo]
lirc-0.9.4d: This /work/aarch64-oe-linux/lirc/0.9.4d-r0/pseudo/pseudo.log=
 indicates 12 errors [qa_pseudo]
lirc-0.9.4d: This /work/armv5te-oe-linux-gnueabi/lirc/0.9.4d-r0/pseudo/ps=
eudo.log indicates 10 errors [qa_pseudo]
lirc-0.9.4d: This /work/core2-64-oe-linux/lirc/0.9.4d-r0/pseudo/pseudo.lo=
g indicates 10 errors [qa_pseudo]
lirc-0.9.4d: This /work/i586-oe-linux-musl/lirc/0.9.4d-r0/pseudo/pseudo.l=
og indicates 12 errors [qa_pseudo]
lksctp-tools-1.0.17+gitAUTOINC+736b91d340: This /work/i586-oe-linux-musl/=
lksctp-tools/1.0.17+gitAUTOINC+736b91d340-r0/pseudo/pseudo.log indicates =
13 errors [qa_pseudo]
llvm-5.0: This /work/aarch64-oe-linux/llvm/5.0-r0/pseudo/pseudo.log indic=
ates 13 errors [qa_pseudo]
llvm-5.0: This /work/armv5e-oe-linux-gnueabi/llvm/5.0-r0/pseudo/pseudo.lo=
g indicates 5 errors [qa_pseudo]
llvm-5.0: This /work/core2-64-oe-linux/llvm/5.0-r0/pseudo/pseudo.log indi=
cates 5 errors [qa_pseudo]
llvm-5.0: This /work/i586-oe-linux-musl/llvm/5.0-r0/pseudo/pseudo.log ind=
icates 6 errors [qa_pseudo]
lmbench-3.0-a9: This /work/aarch64-oe-linux/lmbench/3.0-a9-r2/pseudo/pseu=
do.log indicates 12 errors [qa_pseudo]
lockdev-1.0.3+gitAUTOINC+16b899645d: This /work/i586-oe-linux-musl/lockde=
v/1.0.3+gitAUTOINC+16b899645d-r0/pseudo/pseudo.log indicates 12 errors [q=
a_pseudo]
log4cpp-1.1.2: This /work/aarch64-oe-linux/log4cpp/1.1.2-r0/pseudo/pseudo=
=2Elog indicates 7 errors [qa_pseudo]
log4cpp-1.1.2: This /work/armv5te-oe-linux-gnueabi/log4cpp/1.1.2-r0/pseud=
o/pseudo.log indicates 4 errors [qa_pseudo]
log4cpp-1.1.2: This /work/i586-oe-linux-musl/log4cpp/1.1.2-r0/pseudo/pseu=
do.log indicates 8 errors [qa_pseudo]
lowpan-tools-0.3.1+gitAUTOINC+38f42dbfce: This /work/core2-64-oe-linux/lo=
wpan-tools/0.3.1+gitAUTOINC+38f42dbfce-r0/pseudo/pseudo.log indicates 10 =
errors [qa_pseudo]
lttng-tools-2.9.5: This /work/core2-64-oe-linux/lttng-tools/2.9.5-r0/pseu=
do/pseudo.log indicates 10 errors [qa_pseudo]
lttng-tools-2.9.5: This /work/i586-oe-linux-musl/lttng-tools/2.9.5-r0/pse=
udo/pseudo.log indicates 10 errors [qa_pseudo]
lvm2-2.02.171: This /work/core2-64-oe-linux/lvm2/2.02.171-r0/pseudo/pseud=
o.log indicates 10 errors [qa_pseudo]
lzip-1.19: This /work/armv5te-oe-linux-gnueabi/lzip/1.19-r0/pseudo/pseudo=
=2Elog indicates 10 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/aarch64-oe-=
linux/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo/pseudo.=
log indicates 12 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/armv5te-oe-=
linux-gnueabi/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo=
/pseudo.log indicates 11 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/core2-64-oe=
-linux/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo/pseudo=
=2Elog indicates 11 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/i586-oe-lin=
ux-musl/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo/pseud=
o.log indicates 10 errors [qa_pseudo]
mariadb-5.5.57: This /work/core2-64-oe-linux/mariadb/5.5.57-r0/pseudo/pse=
udo.log indicates 10 errors [qa_pseudo]
meson-0.40.1: This /work/core2-64-oe-linux/meson/0.40.1-r0/pseudo/pseudo.=
log indicates 4 errors [qa_pseudo]
modemmanager-1.6.4: This /work/core2-64-oe-linux/modemmanager/1.6.4-r0/ps=
eudo/pseudo.log indicates 16 errors [qa_pseudo]
mosquitto-1.4.14: This /work/aarch64-oe-linux/mosquitto/1.4.14-r0/pseudo/=
pseudo.log indicates 6 errors [qa_pseudo]
mosquitto-1.4.14: This /work/armv5te-oe-linux-gnueabi/mosquitto/1.4.14-r0=
/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
mosquitto-1.4.14: This /work/i586-oe-linux-musl/mosquitto/1.4.14-r0/pseud=
o/pseudo.log indicates 6 errors [qa_pseudo]
mozilla-devscripts-0.30: This /work/aarch64-oe-linux/mozilla-devscripts/0=
=2E30-r1/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
mpich-3.2: This /work/core2-64-oe-linux/mpich/3.2-r0/pseudo/pseudo.log in=
dicates 4 errors [qa_pseudo]
mpich-3.2: This /work/i586-oe-linux-musl/mpich/3.2-r0/pseudo/pseudo.log i=
ndicates 6 errors [qa_pseudo]
mraa-1.7.0-gitAUTOINC+8ddbcde84e: This /work/aarch64-oe-linux/mraa/1.7.0-=
gitAUTOINC+8ddbcde84e-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo=
]
mraa-1.7.0-gitAUTOINC+8ddbcde84e: This /work/armv5te-oe-linux-gnueabi/mra=
a/1.7.0-gitAUTOINC+8ddbcde84e-r0/pseudo/pseudo.log indicates 10 errors [q=
a_pseudo]
mtr-0.87+gitAUTOINC+e6d0a7e931: This /work/core2-64-oe-linux/mtr/0.87+git=
AUTOINC+e6d0a7e931-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
multipath-tools-0.7.1: This /work/armv5e-oe-linux-gnueabi/multipath-tools=
/0.7.1-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
ncftp-3.2.6: This /work/i586-oe-linux-musl/ncftp/3.2.6-r0/pseudo/pseudo.l=
og indicates 12 errors [qa_pseudo]
netdata-1.8.0+gitAUTOINC+89ed309252: This /work/i586-oe-linux-musl/netdat=
a/1.8.0+gitAUTOINC+89ed309252-r0/pseudo/pseudo.log indicates 13 errors [q=
a_pseudo]
net-snmp-5.7.3: This /work/aarch64-oe-linux/net-snmp/5.7.3-r0/pseudo/pseu=
do.log indicates 13 errors [qa_pseudo]
net-snmp-5.7.3: This /work/armv5te-oe-linux-gnueabi/net-snmp/5.7.3-r0/pse=
udo/pseudo.log indicates 10 errors [qa_pseudo]
net-snmp-5.7.3: This /work/core2-64-oe-linux/net-snmp/5.7.3-r0/pseudo/pse=
udo.log indicates 11 errors [qa_pseudo]
net-snmp-5.7.3: This /work/i586-oe-linux-musl/net-snmp/5.7.3-r0/pseudo/ps=
eudo.log indicates 12 errors [qa_pseudo]
nettle-3.4: This /work/armv5te-oe-linux-gnueabi/nettle/3.4-r0/pseudo/pseu=
do.log indicates 10 errors [qa_pseudo]
nginx-1.12.2: This /work/armv5te-oe-linux-gnueabi/nginx/1.12.2-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
nginx-1.12.2: This /work/i586-oe-linux-musl/nginx/1.12.2-r0/pseudo/pseudo=
=2Elog indicates 8 errors [qa_pseudo]
nspr-4.17: This /work/armv5te-oe-linux-gnueabi/nspr/4.17-r0/pseudo/pseudo=
=2Elog indicates 10 errors [qa_pseudo]
ntp-4.2.8p10: This /work/aarch64-oe-linux/ntp/4.2.8p10-r0/pseudo/pseudo.l=
og indicates 11 errors [qa_pseudo]
ntp-4.2.8p10: This /work/armv5te-oe-linux-gnueabi/ntp/4.2.8p10-r0/pseudo/=
pseudo.log indicates 10 errors [qa_pseudo]
ntp-4.2.8p10: This /work/core2-64-oe-linux/ntp/4.2.8p10-r0/pseudo/pseudo.=
log indicates 11 errors [qa_pseudo]
ntp-4.2.8p10: This /work/i586-oe-linux-musl/ntp/4.2.8p10-r0/pseudo/pseudo=
=2Elog indicates 15 errors [qa_pseudo]
numlockx-1.2: This /work/i586-oe-linux-musl/numlockx/1.2-r0/pseudo/pseudo=
=2Elog indicates 14 errors [qa_pseudo]
nuttcp-7.2.1: This /work/i586-oe-linux-musl/nuttcp/7.2.1-r0/pseudo/pseudo=
=2Elog indicates 11 errors [qa_pseudo]
obexd-0.48: This /work/aarch64-oe-linux/obexd/0.48-r0/pseudo/pseudo.log i=
ndicates 18 errors [qa_pseudo]
open-isns-0.97: This /work/aarch64-oe-linux/open-isns/0.97-r0/pseudo/pseu=
do.log indicates 6 errors [qa_pseudo]
open-isns-0.97: This /work/armv5te-oe-linux-gnueabi/open-isns/0.97-r0/pse=
udo/pseudo.log indicates 4 errors [qa_pseudo]
open-isns-0.97: This /work/core2-64-oe-linux/open-isns/0.97-r0/pseudo/pse=
udo.log indicates 4 errors [qa_pseudo]
opensaf-5.17.07: This /work/aarch64-oe-linux/opensaf/5.17.07-r0/pseudo/ps=
eudo.log indicates 18 errors [qa_pseudo]
opensaf-5.17.07: This /work/armv5te-oe-linux-gnueabi/opensaf/5.17.07-r0/p=
seudo/pseudo.log indicates 20 errors [qa_pseudo]
openssh-7.6p1: This /work/aarch64-oe-linux/openssh/7.6p1-r0/pseudo/pseudo=
=2Elog indicates 12 errors [qa_pseudo]
openssh-7.6p1: This /work/armv5te-oe-linux-gnueabi/openssh/7.6p1-r0/pseud=
o/pseudo.log indicates 10 errors [qa_pseudo]
openssh-7.6p1: This /work/core2-64-oe-linux/openssh/7.6p1-r0/pseudo/pseud=
o.log indicates 10 errors [qa_pseudo]
openssh-7.6p1: This /work/i586-oe-linux-musl/openssh/7.6p1-r0/pseudo/pseu=
do.log indicates 12 errors [qa_pseudo]
orbit2-2.14.19: This /work/core2-64-oe-linux/orbit2/2.14.19-r0/pseudo/pse=
udo.log indicates 16 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/aarch64-oe-linux/ossp-uuid/1.6.2-r2/pseudo/ps=
eudo.log indicates 7 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/armv5te-oe-linux-gnueabi/ossp-uuid/1.6.2-r2/p=
seudo/pseudo.log indicates 5 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/core2-64-oe-linux/ossp-uuid/1.6.2-r2/pseudo/p=
seudo.log indicates 4 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/i586-oe-linux-musl/ossp-uuid/1.6.2-r2/pseudo/=
pseudo.log indicates 7 errors [qa_pseudo]
packagegroup-xfce-base-1.0: This /work/all-oe-linux/packagegroup-xfce-bas=
e/1.0-r5/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
perf-1.0: This /work/qemuarm64-oe-linux/perf/1.0-r9/pseudo/pseudo.log ind=
icates 10 errors [qa_pseudo]
perf-1.0: This /work/qemuarm-oe-linux-gnueabi/perf/1.0-r9/pseudo/pseudo.l=
og indicates 4 errors [qa_pseudo]
perf-1.0: This /work/qemux86_64-oe-linux/perf/1.0-r9/pseudo/pseudo.log in=
dicates 10 errors [qa_pseudo]
perl-5.24.1: This /work/aarch64-oe-linux/perl/5.24.1-r0/pseudo/pseudo.log=
 indicates 6 errors [qa_pseudo]
perl-5.24.1: This /work/armv5te-oe-linux-gnueabi/perl/5.24.1-r0/pseudo/ps=
eudo.log indicates 5 errors [qa_pseudo]
perl-5.24.1: This /work/core2-64-oe-linux/perl/5.24.1-r0/pseudo/pseudo.lo=
g indicates 4 errors [qa_pseudo]
perl-5.24.1: This /work/i586-oe-linux-musl/perl/5.24.1-r0/pseudo/pseudo.l=
og indicates 5 errors [qa_pseudo]
php-7.1.9: This /work/aarch64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log ind=
icates 14 errors [qa_pseudo]
php-7.1.9: This /work/armv5e-oe-linux-gnueabi/php/7.1.9-r0/pseudo/pseudo.=
log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/core2-64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log in=
dicates 12 errors [qa_pseudo]
php-7.1.9: This /work/i586-oe-linux-musl/php/7.1.9-r0/pseudo/pseudo.log i=
ndicates 13 errors [qa_pseudo]
piglit-1.0+gitrAUTOINC+c8f4fd9eeb: This /work/armv5te-oe-linux-gnueabi/pi=
glit/1.0+gitrAUTOINC+c8f4fd9eeb-r0/pseudo/pseudo.log indicates 14 errors =
[qa_pseudo]
pkcs11-helper-1.11: This /work/aarch64-oe-linux/pkcs11-helper/1.11-r0/pse=
udo/pseudo.log indicates 12 errors [qa_pseudo]
pm-qa-0.5.2: This /work/aarch64-oe-linux/pm-qa/0.5.2-r0/pseudo/pseudo.log=
 indicates 47 errors [qa_pseudo]
pm-qa-0.5.2: This /work/armv5te-oe-linux-gnueabi/pm-qa/0.5.2-r0/pseudo/ps=
eudo.log indicates 50 errors [qa_pseudo]
pm-qa-0.5.2: This /work/core2-64-oe-linux/pm-qa/0.5.2-r0/pseudo/pseudo.lo=
g indicates 29 errors [qa_pseudo]
pngcheck-2.3.0: This /work/i586-oe-linux-musl/pngcheck/2.3.0-r0/pseudo/ps=
eudo.log indicates 12 errors [qa_pseudo]
polkit-gnome-0.105: This /work/aarch64-oe-linux/polkit-gnome/0.105-r0/pse=
udo/pseudo.log indicates 10 errors [qa_pseudo]
poppler-0.57.0: This /work/armv5te-oe-linux-gnueabi/poppler/0.57.0-r0/pse=
udo/pseudo.log indicates 10 errors [qa_pseudo]
portaudio-v19-v190600: This /work/aarch64-oe-linux/portaudio-v19/v190600-=
r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
portaudio-v19-v190600: This /work/armv5te-oe-linux-gnueabi/portaudio-v19/=
v190600-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
portaudio-v19-v190600: This /work/core2-64-oe-linux/portaudio-v19/v190600=
-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
postgresql-9.4.15: This /work/aarch64-oe-linux/postgresql/9.4.15-r0/pseud=
o/pseudo.log indicates 14 errors [qa_pseudo]
postgresql-9.4.15: This /work/armv5e-oe-linux-gnueabi/postgresql/9.4.15-r=
0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
postgresql-9.4.15: This /work/core2-64-oe-linux/postgresql/9.4.15-r0/pseu=
do/pseudo.log indicates 12 errors [qa_pseudo]
postgresql-9.4.15: This /work/i586-oe-linux-musl/postgresql/9.4.15-r0/pse=
udo/pseudo.log indicates 14 errors [qa_pseudo]
pptp-linux-1.9.0: This /work/aarch64-oe-linux/pptp-linux/1.9.0-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
proftpd-1.3.6: This /work/aarch64-oe-linux/proftpd/1.3.6-r0/pseudo/pseudo=
=2Elog indicates 15 errors [qa_pseudo]
proftpd-1.3.6: This /work/core2-64-oe-linux/proftpd/1.3.6-r0/pseudo/pseud=
o.log indicates 12 errors [qa_pseudo]
proftpd-1.3.6: This /work/i586-oe-linux-musl/proftpd/1.3.6-r0/pseudo/pseu=
do.log indicates 13 errors [qa_pseudo]
psqlodbc-09.05.0300: This /work/aarch64-oe-linux/psqlodbc/09.05.0300-r0/p=
seudo/pseudo.log indicates 17 errors [qa_pseudo]
ptpd-2.3.1: This /work/core2-64-oe-linux/ptpd/2.3.1-r0/pseudo/pseudo.log =
indicates 4 errors [qa_pseudo]
pure-ftpd-1.0.42: This /work/aarch64-oe-linux/pure-ftpd/1.0.42-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
python-2.7.13: This /work/aarch64-oe-linux/python/2.7.13-r1/pseudo/pseudo=
=2Elog indicates 4 errors [qa_pseudo]
python-2.7.13: This /work/armv5te-oe-linux-gnueabi/python/2.7.13-r1/pseud=
o/pseudo.log indicates 5 errors [qa_pseudo]
python-2.7.13: This /work/core2-64-oe-linux/python/2.7.13-r1/pseudo/pseud=
o.log indicates 5 errors [qa_pseudo]
python-2.7.13: This /work/i586-oe-linux-musl/python/2.7.13-r1/pseudo/pseu=
do.log indicates 5 errors [qa_pseudo]
python3-3.5.3: This /work/aarch64-oe-linux/python3/3.5.3-r1.0/pseudo/pseu=
do.log indicates 7 errors [qa_pseudo]
python3-3.5.3: This /work/armv5te-oe-linux-gnueabi/python3/3.5.3-r1.0/pse=
udo/pseudo.log indicates 4 errors [qa_pseudo]
python3-3.5.3: This /work/core2-64-oe-linux/python3/3.5.3-r1.0/pseudo/pse=
udo.log indicates 11 errors [qa_pseudo]
python3-3.5.3: This /work/i586-oe-linux-musl/python3/3.5.3-r1.0/pseudo/ps=
eudo.log indicates 12 errors [qa_pseudo]
python3-bitarray-0.8.1: This /work/i586-oe-linux-musl/python3-bitarray/0.=
8.1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python3-cassandra-driver-3.11.0: This /work/aarch64-oe-linux/python3-cass=
andra-driver/3.11.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-chardet-3.0.4: This /work/aarch64-oe-linux/python3-chardet/3.0.4-=
r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-coverage-4.4.2: This /work/i586-oe-linux-musl/python3-coverage/4.=
4.2-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-cryptography-vectors-2.1.3: This /work/core2-64-oe-linux/python3-=
cryptography-vectors/2.1.3-r0/pseudo/pseudo.log indicates 10 errors [qa_p=
seudo]
python3-cython-0.27.3: This /work/armv5te-oe-linux-gnueabi/python3-cython=
/0.27.3-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-django-1.11.5: This /work/armv5te-oe-linux-gnueabi/python3-django=
/1.11.5-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-django-1.11.5: This /work/i586-oe-linux-musl/python3-django/1.11.=
5-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-docutils-0.14: This /work/aarch64-oe-linux/python3-docutils/0.14-=
r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-docutils-0.14: This /work/core2-64-oe-linux/python3-docutils/0.14=
-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-flask-0.12.2: This /work/core2-64-oe-linux/python3-flask/0.12.2-r=
0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-jsonschema-2.6.0: This /work/aarch64-oe-linux/python3-jsonschema/=
2.6.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-jsonschema-2.6.0: This /work/core2-64-oe-linux/python3-jsonschema=
/2.6.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-ndg-httpsclient-0.4.3: This /work/armv5te-oe-linux-gnueabi/python=
3-ndg-httpsclient/0.4.3-r0/pseudo/pseudo.log indicates 4 errors [qa_pseud=
o]
python3-netaddr-0.7.19: This /work/core2-64-oe-linux/python3-netaddr/0.7.=
19-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-nose-1.3.7: This /work/aarch64-oe-linux/python3-nose/1.3.7-r0/pse=
udo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pandas-0.21.0: This /work/core2-64-oe-linux/python3-pandas/0.21.0=
-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pid-2.1.1: This /work/aarch64-oe-linux/python3-pid/2.1.1-r0/pseud=
o/pseudo.log indicates 12 errors [qa_pseudo]
python3-pip-9.0.1: This /work/armv5te-oe-linux-gnueabi/python3-pip/9.0.1-=
r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pip-9.0.1: This /work/i586-oe-linux-musl/python3-pip/9.0.1-r0/pse=
udo/pseudo.log indicates 7 errors [qa_pseudo]
python3-pyalsaaudio-0.8.4: This /work/i586-oe-linux-musl/python3-pyalsaau=
dio/0.8.4-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/aarch64-oe-linux/python3-pylint/1.7.4-r0=
/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/armv5te-oe-linux-gnueabi/python3-pylint/=
1.7.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/core2-64-oe-linux/python3-pylint/1.7.4-r=
0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/i586-oe-linux-musl/python3-pylint/1.7.4-=
r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pytest-3.2.5: This /work/i586-oe-linux-musl/python3-pytest/3.2.5-=
r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pyudev-0.21.0: This /work/armv5te-oe-linux-gnueabi/python3-pyudev=
/0.21.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-requests-2.18.4: This /work/armv5te-oe-linux-gnueabi/python3-requ=
ests/2.18.4-r0/pseudo/pseudo.log indicates 9 errors [qa_pseudo]
python3-setuptools-36.5.0: This /work/aarch64-oe-linux/python3-setuptools=
/36.5.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-setuptools-scm-1.15.6: This /work/armv5te-oe-linux-gnueabi/python=
3-setuptools-scm/1.15.6-r0/pseudo/pseudo.log indicates 10 errors [qa_pseu=
do]
python3-twisted-17.9.0: This /work/i586-oe-linux-musl/python3-twisted/17.=
9.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-unidiff-0.5.4: This /work/aarch64-oe-linux/python3-unidiff/0.5.4-=
r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-werkzeug-0.12.2: This /work/aarch64-oe-linux/python3-werkzeug/0.1=
2.2-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-attr-0.2.0: This /work/armv5te-oe-linux-gnueabi/python-attr/0.2.0-=
r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
python-automat-0.6.0: This /work/aarch64-oe-linux/python-automat/0.6.0-r0=
/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-babel-2.5.1: This /work/armv5te-oe-linux-gnueabi/python-babel/2.5.=
1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-babel-2.5.1: This /work/i586-oe-linux-musl/python-babel/2.5.1-r0/p=
seudo/pseudo.log indicates 6 errors [qa_pseudo]
python-cheetah-2.4.4: This /work/armv5te-oe-linux-gnueabi/python-cheetah/=
2.4.4-r3/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-cython-0.27.3: This /work/core2-64-oe-linux/python-cython/0.27.3-r=
0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-docutils-0.14rc2: This /work/core2-64-oe-linux/python-docutils/0.1=
4rc2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-epydoc-3.0.1: This /work/aarch64-oe-linux/python-epydoc/3.0.1-r0/p=
seudo/pseudo.log indicates 6 errors [qa_pseudo]
python-flask-login-0.4.0: This /work/aarch64-oe-linux/python-flask-login/=
0.4.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-future-0.16.0: This /work/armv5te-oe-linux-gnueabi/python-future/0=
=2E16.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-incremental-17.5.0: This /work/core2-64-oe-linux/python-incrementa=
l/17.5.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
python-isort-4.2.15: This /work/core2-64-oe-linux/python-isort/4.2.15-r0/=
pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-jsonpatch-1.20: This /work/core2-64-oe-linux/python-jsonpatch/1.20=
-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-netaddr-0.7.19: This /work/armv5te-oe-linux-gnueabi/python-netaddr=
/0.7.19-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-netaddr-0.7.19: This /work/core2-64-oe-linux/python-netaddr/0.7.19=
-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-nose-1.3.7: This /work/aarch64-oe-linux/python-nose/1.3.7-r0/pseud=
o/pseudo.log indicates 6 errors [qa_pseudo]
python-numpy-1.13.1: This /work/armv5te-oe-linux-gnueabi/python-numpy/1.1=
3.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-pep8-1.7.1: This /work/core2-64-oe-linux/python-pep8/1.7.1-r0/pseu=
do/pseudo.log indicates 4 errors [qa_pseudo]
python-pexpect-4.3.0: This /work/i586-oe-linux-musl/python-pexpect/4.3.0-=
r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
python-protobuf-3.4.0: This /work/armv5te-oe-linux-gnueabi/python-protobu=
f/3.4.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
python-pyflakes-1.2.3: This /work/aarch64-oe-linux/python-pyflakes/1.2.3-=
r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-pylint-1.7.4: This /work/aarch64-oe-linux/python-pylint/1.7.4-r0/p=
seudo/pseudo.log indicates 6 errors [qa_pseudo]
python-pylint-1.7.4: This /work/core2-64-oe-linux/python-pylint/1.7.4-r0/=
pseudo/pseudo.log indicates 5 errors [qa_pseudo]
python-pylint-1.7.4: This /work/i586-oe-linux-musl/python-pylint/1.7.4-r0=
/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-pyopenssl-17.3.0: This /work/aarch64-oe-linux/python-pyopenssl/17.=
3.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-pysmi-0.2.2: This /work/core2-64-oe-linux/python-pysmi/0.2.2-r0/ps=
eudo/pseudo.log indicates 4 errors [qa_pseudo]
python-pysmi-0.2.2: This /work/i586-oe-linux-musl/python-pysmi/0.2.2-r0/p=
seudo/pseudo.log indicates 12 errors [qa_pseudo]
python-pytest-3.2.5: This /work/armv5te-oe-linux-gnueabi/python-pytest/3.=
2.5-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-scons-3.0.0: This /work/aarch64-oe-linux/python-scons/3.0.0-r0/pse=
udo/pseudo.log indicates 7 errors [qa_pseudo]
python-scons-3.0.0: This /work/i586-oe-linux-musl/python-scons/3.0.0-r0/p=
seudo/pseudo.log indicates 6 errors [qa_pseudo]
python-setuptools-36.5.0: This /work/aarch64-oe-linux/python-setuptools/3=
6.5.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-snakefood-1.4: This /work/aarch64-oe-linux/python-snakefood/1.4-r0=
/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-snakefood-1.4: This /work/armv5te-oe-linux-gnueabi/python-snakefoo=
d/1.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-snimpy-0.8.12: This /work/aarch64-oe-linux/python-snimpy/0.8.12-r0=
/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-unidiff-0.5.4: This /work/armv5te-oe-linux-gnueabi/python-unidiff/=
0.5.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-vobject-0.9.5: This /work/core2-64-oe-linux/python-vobject/0.9.5-r=
0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-xlrd-1.1.0: This /work/armv5te-oe-linux-gnueabi/python-xlrd/1.1.0-=
r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-xlrd-1.1.0: This /work/i586-oe-linux-musl/python-xlrd/1.1.0-r0/pse=
udo/pseudo.log indicates 6 errors [qa_pseudo]
python-yappi-0.98: This /work/i586-oe-linux-musl/python-yappi/0.98-r0/pse=
udo/pseudo.log indicates 6 errors [qa_pseudo]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/aarch64-oe-linux/qt3d/5.9.2+=
gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo=
]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/armv5te-oe-linux-gnueabi/qt3=
d/5.9.2+gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 20 errors [q=
a_pseudo]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/core2-64-oe-linux/qt3d/5.9.2=
+gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 13 errors [qa_pseud=
o]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/i586-oe-linux-musl/qt3d/5.9.=
2+gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 14 errors [qa_pseu=
do]
qt5-creator-3.5.1: This /work/armv5te-oe-linux-gnueabi/qt5-creator/3.5.1-=
r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtbase-5.9.2+gitAUTOINC+ec16ba393b: This /work/aarch64-oe-linux/qtbase/5.=
9.2+gitAUTOINC+ec16ba393b-r0/pseudo/pseudo.log indicates 597 errors [qa_p=
seudo]
qtbase-5.9.2+gitAUTOINC+ec16ba393b: This /work/armv5te-oe-linux-gnueabi/q=
tbase/5.9.2+gitAUTOINC+ec16ba393b-r0/pseudo/pseudo.log indicates 12 error=
s [qa_pseudo]
qtbase-5.9.2+gitAUTOINC+ec16ba393b: This /work/i586-oe-linux-musl/qtbase/=
5.9.2+gitAUTOINC+ec16ba393b-r0/pseudo/pseudo.log indicates 12 errors [qa_=
pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/aarch64-oe-linux/qtchart=
s/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 15 errors [q=
a_pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/armv5te-oe-linux-gnueabi=
/qtcharts/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 12 e=
rrors [qa_pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/core2-64-oe-linux/qtchar=
ts/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 11 errors [=
qa_pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/i586-oe-linux-musl/qtcha=
rts/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 12 errors =
[qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/aarch64-oe-linux/q=
tconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log indicates =
13 errors [qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/armv5te-oe-linux-g=
nueabi/qtconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log in=
dicates 12 errors [qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/core2-64-oe-linux/=
qtconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log indicates=
 11 errors [qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/i586-oe-linux-musl=
/qtconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log indicate=
s 13 errors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/aarch64-oe-linux/qtda=
tavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicates 13 err=
ors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/armv5te-oe-linux-gnue=
abi/qtdatavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicate=
s 10 errors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/core2-64-oe-linux/qtd=
atavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicates 11 er=
rors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/i586-oe-linux-musl/qt=
datavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicates 13 e=
rrors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/aarch64-oe-linux/qt=
declarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indicates 26=
 errors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/armv5te-oe-linux-gn=
ueabi/qtdeclarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indi=
cates 18 errors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/core2-64-oe-linux/q=
tdeclarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indicates 1=
7 errors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/i586-oe-linux-musl/=
qtdeclarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indicates =
21 errors [qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/aarch64-oe-linux/qtengi=
nio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 12 errors =
[qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/armv5te-oe-linux-gnueab=
i/qtenginio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 10=
 errors [qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/core2-64-oe-linux/qteng=
inio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 11 errors=
 [qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/i586-oe-linux-musl/qten=
ginio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 13 error=
s [qa_pseudo]
qtgamepad-5.9.2+gitAUTOINC+167566d228: This /work/aarch64-oe-linux/qtgame=
pad/5.9.2+gitAUTOINC+167566d228-r0/pseudo/pseudo.log indicates 13 errors =
[qa_pseudo]
qtgamepad-5.9.2+gitAUTOINC+167566d228: This /work/armv5te-oe-linux-gnueab=
i/qtgamepad/5.9.2+gitAUTOINC+167566d228-r0/pseudo/pseudo.log indicates 11=
 errors [qa_pseudo]
qtgamepad-5.9.2+gitAUTOINC+167566d228: This /work/core2-64-oe-linux/qtgam=
epad/5.9.2+gitAUTOINC+167566d228-r0/pseudo/pseudo.log indicates 13 errors=
 [qa_pseudo]
qtgraphicaleffects-5.9.2+gitAUTOINC+1f6658cbaa: This /work/i586-oe-linux-=
musl/qtgraphicaleffects/5.9.2+gitAUTOINC+1f6658cbaa-r0/pseudo/pseudo.log =
indicates 8 errors [qa_pseudo]
qtlocation-5.9.2+gitAUTOINC+d919f47308_1c633072fc: This /work/aarch64-oe-=
linux/qtlocation/5.9.2+gitAUTOINC+d919f47308_1c633072fc-r0/pseudo/pseudo.=
log indicates 13 errors [qa_pseudo]
qtlocation-5.9.2+gitAUTOINC+d919f47308_1c633072fc: This /work/armv5te-oe-=
linux-gnueabi/qtlocation/5.9.2+gitAUTOINC+d919f47308_1c633072fc-r0/pseudo=
/pseudo.log indicates 10 errors [qa_pseudo]
qtlocation-5.9.2+gitAUTOINC+d919f47308_1c633072fc: This /work/core2-64-oe=
-linux/qtlocation/5.9.2+gitAUTOINC+d919f47308_1c633072fc-r0/pseudo/pseudo=
=2Elog indicates 11 errors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/aarch64-oe-linux/qtm=
ultimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indicates 13 e=
rrors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/armv5te-oe-linux-gnu=
eabi/qtmultimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indica=
tes 12 errors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/core2-64-oe-linux/qt=
multimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indicates 11 =
errors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/i586-oe-linux-musl/q=
tmultimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indicates 15=
 errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/aarch64-oe-linux/qt=
networkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indicates 7 =
errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/armv5te-oe-linux-gn=
ueabi/qtnetworkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indi=
cates 11 errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/core2-64-oe-linux/q=
tnetworkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indicates 5=
 errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/i586-oe-linux-musl/=
qtnetworkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indicates =
13 errors [qa_pseudo]
qtquick1-5.9.2+gitAUTOINC+9bf0edd9bd: This /work/aarch64-oe-linux/qtquick=
1/5.9.2+gitAUTOINC+9bf0edd9bd-r0/pseudo/pseudo.log indicates 19 errors [q=
a_pseudo]
qtquick1-5.9.2+gitAUTOINC+9bf0edd9bd: This /work/armv5te-oe-linux-gnueabi=
/qtquick1/5.9.2+gitAUTOINC+9bf0edd9bd-r0/pseudo/pseudo.log indicates 17 e=
rrors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/aarch64-oe-linux=
/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.log indica=
tes 12 errors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/armv5te-oe-linux=
-gnueabi/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.lo=
g indicates 12 errors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/core2-64-oe-linu=
x/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.log indic=
ates 10 errors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/i586-oe-linux-mu=
sl/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.log indi=
cates 12 errors [qa_pseudo]
qtquickcontrols-5.9.2+gitAUTOINC+8476f8fff7: This /work/armv5te-oe-linux-=
gnueabi/qtquickcontrols/5.9.2+gitAUTOINC+8476f8fff7-r0/pseudo/pseudo.log =
indicates 12 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/aarch64-oe-linux/=
qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log indicate=
s 13 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/armv5te-oe-linux-=
gnueabi/qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log =
indicates 11 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/core2-64-oe-linux=
/qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log indicat=
es 10 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/i586-oe-linux-mus=
l/qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log indica=
tes 15 errors [qa_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/aarch64-oe-linux/qtscrip=
t/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 13 errors [q=
a_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/armv5e-oe-linux-gnueabi/=
qtscript/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 13 er=
rors [qa_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/core2-64-oe-linux/qtscri=
pt/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 10 errors [=
qa_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/i586-oe-linux-musl/qtscr=
ipt/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 15 errors =
[qa_pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/aarch64-oe-linux/qtscxml/=
5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 13 errors [qa_=
pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/armv5te-oe-linux-gnueabi/=
qtscxml/5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 12 err=
ors [qa_pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/core2-64-oe-linux/qtscxml=
/5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 17 errors [qa=
_pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/i586-oe-linux-musl/qtscxm=
l/5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 13 errors [q=
a_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/aarch64-oe-linux/qtsens=
ors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 13 errors =
[qa_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/armv5te-oe-linux-gnueab=
i/qtsensors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 11=
 errors [qa_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/core2-64-oe-linux/qtsen=
sors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 11 errors=
 [qa_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/i586-oe-linux-musl/qtse=
nsors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 13 error=
s [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/aarch64-oe-linux/qtse=
rialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicates 12 err=
ors [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/armv5te-oe-linux-gnue=
abi/qtserialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicate=
s 12 errors [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/core2-64-oe-linux/qts=
erialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicates 11 er=
rors [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/i586-oe-linux-musl/qt=
serialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicates 14 e=
rrors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/aarch64-oe-linux/qts=
erialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indicates 14 e=
rrors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/armv5te-oe-linux-gnu=
eabi/qtserialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indica=
tes 5 errors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/core2-64-oe-linux/qt=
serialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indicates 5 e=
rrors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/i586-oe-linux-musl/q=
tserialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indicates 7 =
errors [qa_pseudo]
qtsmarthome-1.0: This /work/i586-oe-linux-musl/qtsmarthome/1.0-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
qtsvg-5.9.2+gitAUTOINC+bdcd7a9744: This /work/aarch64-oe-linux/qtsvg/5.9.=
2+gitAUTOINC+bdcd7a9744-r0/pseudo/pseudo.log indicates 14 errors [qa_pseu=
do]
qtsvg-5.9.2+gitAUTOINC+bdcd7a9744: This /work/armv5te-oe-linux-gnueabi/qt=
svg/5.9.2+gitAUTOINC+bdcd7a9744-r0/pseudo/pseudo.log indicates 11 errors =
[qa_pseudo]
qtsvg-5.9.2+gitAUTOINC+bdcd7a9744: This /work/i586-oe-linux-musl/qtsvg/5.=
9.2+gitAUTOINC+bdcd7a9744-r0/pseudo/pseudo.log indicates 11 errors [qa_ps=
eudo]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: This /work/armv5te-oe-linux-gnueab=
i/qtsystems/5.9.2+gitAUTOINC+9c204e05ae-r0/pseudo/pseudo.log indicates 11=
 errors [qa_pseudo]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: This /work/core2-64-oe-linux/qtsys=
tems/5.9.2+gitAUTOINC+9c204e05ae-r0/pseudo/pseudo.log indicates 11 errors=
 [qa_pseudo]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: This /work/i586-oe-linux-musl/qtsy=
stems/5.9.2+gitAUTOINC+9c204e05ae-r0/pseudo/pseudo.log indicates 12 error=
s [qa_pseudo]
qttools-5.9.2+gitAUTOINC+90a701032e: This /work/armv5te-oe-linux-gnueabi/=
qttools/5.9.2+gitAUTOINC+90a701032e-r0/pseudo/pseudo.log indicates 15 err=
ors [qa_pseudo]
qttools-5.9.2+gitAUTOINC+90a701032e: This /work/core2-64-oe-linux/qttools=
/5.9.2+gitAUTOINC+90a701032e-r0/pseudo/pseudo.log indicates 12 errors [qa=
_pseudo]
qttools-5.9.2+gitAUTOINC+90a701032e: This /work/i586-oe-linux-musl/qttool=
s/5.9.2+gitAUTOINC+90a701032e-r0/pseudo/pseudo.log indicates 13 errors [q=
a_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/aarch64-oe-linux/qtwayl=
and/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 13 errors =
[qa_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/armv5te-oe-linux-gnueab=
i/qtwayland/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 10=
 errors [qa_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/core2-64-oe-linux/qtway=
land/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 11 errors=
 [qa_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/i586-oe-linux-musl/qtwa=
yland/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 14 error=
s [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/aarch64-oe-linux/qtw=
ebchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indicates 12 e=
rrors [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/armv5te-oe-linux-gnu=
eabi/qtwebchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indica=
tes 11 errors [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/core2-64-oe-linux/qt=
webchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indicates 11 =
errors [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/i586-oe-linux-musl/q=
twebchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indicates 13=
 errors [qa_pseudo]
qtwebengine-5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903: This /work/aarch64-oe=
-linux/qtwebengine/5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903-r0/pseudo/pseud=
o.log indicates 13 errors [qa_pseudo]
qtwebengine-5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903: This /work/core2-64-o=
e-linux/qtwebengine/5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903-r0/pseudo/pseu=
do.log indicates 10 errors [qa_pseudo]
qtwebkit-5.9.2+gitAUTOINC+97c4a80a12: This /work/aarch64-oe-linux/qtwebki=
t/5.9.2+gitAUTOINC+97c4a80a12-r0/pseudo/pseudo.log indicates 12 errors [q=
a_pseudo]
qtwebkit-5.9.2+gitAUTOINC+97c4a80a12: This /work/armv5e-oe-linux-gnueabi/=
qtwebkit/5.9.2+gitAUTOINC+97c4a80a12-r0/pseudo/pseudo.log indicates 11 er=
rors [qa_pseudo]
qtwebkit-5.9.2+gitAUTOINC+97c4a80a12: This /work/core2-64-oe-linux/qtwebk=
it/5.9.2+gitAUTOINC+97c4a80a12-r0/pseudo/pseudo.log indicates 14 errors [=
qa_pseudo]
qtwebkit-examples-5.9.2+gitAUTOINC+a24c780b60: This /work/aarch64-oe-linu=
x/qtwebkit-examples/5.9.2+gitAUTOINC+a24c780b60-r0/pseudo/pseudo.log indi=
cates 14 errors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/aarch64-oe-linux/qtw=
ebsockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indicates 12 e=
rrors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/armv5te-oe-linux-gnu=
eabi/qtwebsockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indica=
tes 11 errors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/core2-64-oe-linux/qt=
websockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indicates 11 =
errors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/i586-oe-linux-musl/q=
twebsockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indicates 16=
 errors [qa_pseudo]
qtwebview-5.9.2+gitAUTOINC+ec640efd1d: This /work/aarch64-oe-linux/qtwebv=
iew/5.9.2+gitAUTOINC+ec640efd1d-r0/pseudo/pseudo.log indicates 7 errors [=
qa_pseudo]
qtwebview-5.9.2+gitAUTOINC+ec640efd1d: This /work/core2-64-oe-linux/qtweb=
view/5.9.2+gitAUTOINC+ec640efd1d-r0/pseudo/pseudo.log indicates 5 errors =
[qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/aarch64-oe-linux/qtx1=
1extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicates 8 erro=
rs [qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/armv5te-oe-linux-gnue=
abi/qtx11extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicate=
s 6 errors [qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/core2-64-oe-linux/qtx=
11extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicates 4 err=
ors [qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/i586-oe-linux-musl/qt=
x11extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicates 13 e=
rrors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/aarch64-oe-linux/qt=
xmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indicates 11=
 errors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/armv5te-oe-linux-gn=
ueabi/qtxmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indi=
cates 10 errors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/core2-64-oe-linux/q=
txmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indicates 1=
5 errors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/i586-oe-linux-musl/=
qtxmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indicates =
11 errors [qa_pseudo]
quagga-1.2.1: This /work/aarch64-oe-linux/quagga/1.2.1-r0/pseudo/pseudo.l=
og indicates 15 errors [qa_pseudo]
quagga-1.2.1: This /work/armv5te-oe-linux-gnueabi/quagga/1.2.1-r0/pseudo/=
pseudo.log indicates 13 errors [qa_pseudo]
quagga-1.2.1: This /work/core2-64-oe-linux/quagga/1.2.1-r0/pseudo/pseudo.=
log indicates 12 errors [qa_pseudo]
quazip-0.7.3: This /work/aarch64-oe-linux/quazip/0.7.3-r0/pseudo/pseudo.l=
og indicates 6 errors [qa_pseudo]
quilt-0.65: This /work/aarch64-oe-linux/quilt/0.65-r0/pseudo/pseudo.log i=
ndicates 10 errors [qa_pseudo]
qwt-qt5-6.1.3: This /work/i586-oe-linux-musl/qwt-qt5/6.1.3-r0/pseudo/pseu=
do.log indicates 7 errors [qa_pseudo]
radvd-2.17: This /work/armv5te-oe-linux-gnueabi/radvd/2.17-r0/pseudo/pseu=
do.log indicates 5 errors [qa_pseudo]
radvd-2.17: This /work/core2-64-oe-linux/radvd/2.17-r0/pseudo/pseudo.log =
indicates 11 errors [qa_pseudo]
rpm-4.13.90+gitAUTOINC+a8e51b3bb0: This /work/core2-64-oe-linux/rpm/1_4.1=
3.90+gitAUTOINC+a8e51b3bb0-r0/pseudo/pseudo.log indicates 10 errors [qa_p=
seudo]
rp-pppoe-3.12: This /work/armv5te-oe-linux-gnueabi/rp-pppoe/3.12-r10/pseu=
do/pseudo.log indicates 4 errors [qa_pseudo]
rsyslog-8.29.0: This /work/aarch64-oe-linux/rsyslog/8.29.0-r0/pseudo/pseu=
do.log indicates 11 errors [qa_pseudo]
rsyslog-8.29.0: This /work/armv5te-oe-linux-gnueabi/rsyslog/8.29.0-r0/pse=
udo/pseudo.log indicates 10 errors [qa_pseudo]
rsyslog-8.29.0: This /work/core2-64-oe-linux/rsyslog/8.29.0-r0/pseudo/pse=
udo.log indicates 10 errors [qa_pseudo]
rsyslog-8.29.0: This /work/i586-oe-linux-musl/rsyslog/8.29.0-r0/pseudo/ps=
eudo.log indicates 10 errors [qa_pseudo]
satyr-0.23: This /work/armv5te-oe-linux-gnueabi/satyr/0.23-r0/pseudo/pseu=
do.log indicates 15 errors [qa_pseudo]
sblim-sfcb-1.4.9: This /work/aarch64-oe-linux/sblim-sfcb/1.4.9-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
scsirastools-1.6.6: This /work/aarch64-oe-linux/scsirastools/1.6.6-r0/pse=
udo/pseudo.log indicates 12 errors [qa_pseudo]
sed-4.2.2: This /work/armv5te-oe-linux-gnueabi/sed/4.2.2-r0/pseudo/pseudo=
=2Elog indicates 10 errors [qa_pseudo]
sed-4.2.2: This /work/i586-oe-linux-musl/sed/4.2.2-r0/pseudo/pseudo.log i=
ndicates 10 errors [qa_pseudo]
sessreg-1.1.0: This /work/core2-64-oe-linux/sessreg/1.1.0-r0/pseudo/pseud=
o.log indicates 10 errors [qa_pseudo]
shadow-4.2.1: This /work/aarch64-oe-linux/shadow/4.2.1-r0/pseudo/pseudo.l=
og indicates 5 errors [qa_pseudo]
slang-2.3.1a: This /work/core2-64-oe-linux/slang/2.3.1a-r0/pseudo/pseudo.=
log indicates 4 errors [qa_pseudo]
speexdsp-1.2rc3: This /work/i586-oe-linux-musl/speexdsp/1.2rc3-r0/pseudo/=
pseudo.log indicates 12 errors [qa_pseudo]
squid-3.5.26: This /work/aarch64-oe-linux/squid/3.5.26-r0/pseudo/pseudo.l=
og indicates 12 errors [qa_pseudo]
squid-3.5.26: This /work/armv5te-oe-linux-gnueabi/squid/3.5.26-r0/pseudo/=
pseudo.log indicates 10 errors [qa_pseudo]
squid-3.5.26: This /work/core2-64-oe-linux/squid/3.5.26-r0/pseudo/pseudo.=
log indicates 10 errors [qa_pseudo]
squid-3.5.26: This /work/i586-oe-linux-musl/squid/3.5.26-r0/pseudo/pseudo=
=2Elog indicates 12 errors [qa_pseudo]
sthttpd-2.27.1: This /work/aarch64-oe-linux/sthttpd/2.27.1-r0/pseudo/pseu=
do.log indicates 7 errors [qa_pseudo]
sthttpd-2.27.1: This /work/armv5te-oe-linux-gnueabi/sthttpd/2.27.1-r0/pse=
udo/pseudo.log indicates 5 errors [qa_pseudo]
sthttpd-2.27.1: This /work/core2-64-oe-linux/sthttpd/2.27.1-r0/pseudo/pse=
udo.log indicates 10 errors [qa_pseudo]
strace-4.19: This /work/aarch64-oe-linux/strace/4.19-r0/pseudo/pseudo.log=
 indicates 13 errors [qa_pseudo]
strace-4.19: This /work/armv5te-oe-linux-gnueabi/strace/4.19-r0/pseudo/ps=
eudo.log indicates 10 errors [qa_pseudo]
strace-4.19: This /work/core2-64-oe-linux/strace/4.19-r0/pseudo/pseudo.lo=
g indicates 10 errors [qa_pseudo]
strace-4.19: This /work/i586-oe-linux-musl/strace/4.19-r0/pseudo/pseudo.l=
og indicates 13 errors [qa_pseudo]
tcl-8.6.7: This /work/aarch64-oe-linux/tcl/8.6.7-r0/pseudo/pseudo.log ind=
icates 8 errors [qa_pseudo]
tcl-8.6.7: This /work/armv5te-oe-linux-gnueabi/tcl/8.6.7-r0/pseudo/pseudo=
=2Elog indicates 5 errors [qa_pseudo]
tcl-8.6.7: This /work/core2-64-oe-linux/tcl/8.6.7-r0/pseudo/pseudo.log in=
dicates 5 errors [qa_pseudo]
tcl-8.6.7: This /work/i586-oe-linux-musl/tcl/8.6.7-r0/pseudo/pseudo.log i=
ndicates 7 errors [qa_pseudo]
tftp-hpa-5.2: This /work/aarch64-oe-linux/tftp-hpa/5.2-r0/pseudo/pseudo.l=
og indicates 7 errors [qa_pseudo]
tftp-hpa-5.2: This /work/armv5te-oe-linux-gnueabi/tftp-hpa/5.2-r0/pseudo/=
pseudo.log indicates 4 errors [qa_pseudo]
tftp-hpa-5.2: This /work/core2-64-oe-linux/tftp-hpa/5.2-r0/pseudo/pseudo.=
log indicates 5 errors [qa_pseudo]
tftp-hpa-5.2: This /work/i586-oe-linux-musl/tftp-hpa/5.2-r0/pseudo/pseudo=
=2Elog indicates 6 errors [qa_pseudo]
tipcutils-2.2.0+gitAUTOINC+7ab2211b87: This /work/qemuarm-oe-linux-gnueab=
i/tipcutils/2.2.0+gitAUTOINC+7ab2211b87-r0/pseudo/pseudo.log indicates 10=
 errors [qa_pseudo]
tipcutils-2.2.0+gitAUTOINC+7ab2211b87: This /work/qemux86-oe-linux-musl/t=
ipcutils/2.2.0+gitAUTOINC+7ab2211b87-r0/pseudo/pseudo.log indicates 6 err=
ors [qa_pseudo]
tomoyo-tools-2.5.0: This /work/core2-64-oe-linux/tomoyo-tools/2.5.0-r0/ps=
eudo/pseudo.log indicates 10 errors [qa_pseudo]
tomoyo-tools-2.5.0: This /work/i586-oe-linux-musl/tomoyo-tools/2.5.0-r0/p=
seudo/pseudo.log indicates 12 errors [qa_pseudo]
trace-cmd-2.6.1: This /work/i586-oe-linux-musl/trace-cmd/2.6.1-r0/pseudo/=
pseudo.log indicates 6 errors [qa_pseudo]
traceroute-2.1.0: This /work/core2-64-oe-linux/traceroute/2.1.0-r0/pseudo=
/pseudo.log indicates 10 errors [qa_pseudo]
tunctl-1.5: This /work/armv5te-oe-linux-gnueabi/tunctl/1.5-r0/pseudo/pseu=
do.log indicates 4 errors [qa_pseudo]
ufw-0.33: This /work/aarch64-oe-linux/ufw/0.33-r0/pseudo/pseudo.log indic=
ates 7 errors [qa_pseudo]
uml-utilities-20040406: This /work/armv5te-oe-linux-gnueabi/uml-utilities=
/20040406-r1/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
upm-1.3.0-gitAUTOINC+106b6c7062: This /work/aarch64-oe-linux/upm/1.3.0-gi=
tAUTOINC+106b6c7062-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
util-linux-2.31: This /work/armv5te-oe-linux-gnueabi/util-linux/2.31-r0/p=
seudo/pseudo.log indicates 10 errors [qa_pseudo]
valgrind-3.13.0: This /work/aarch64-oe-linux/valgrind/3.13.0-r0/pseudo/ps=
eudo.log indicates 6 errors [qa_pseudo]
vlock-2.2.3: This /work/armv5te-oe-linux-gnueabi/vlock/2.2.3-r0/pseudo/ps=
eudo.log indicates 10 errors [qa_pseudo]
vo-aacenc-0.1.3: This /work/armv5te-oe-linux-gnueabi/vo-aacenc/0.1.3-r0/p=
seudo/pseudo.log indicates 10 errors [qa_pseudo]
vorbis-tools-1.4.0: This /work/i586-oe-linux-musl/vorbis-tools/1.4.0-r0/p=
seudo/pseudo.log indicates 18 errors [qa_pseudo]
weston-init-1.0: This /work/all-oe-linux/weston-init/1.0-r0/pseudo/pseudo=
=2Elog indicates 4 errors [qa_pseudo]
xcb-proto-1.12: This /work/armv5te-oe-linux-gnueabi/xcb-proto/1.12-r0/pse=
udo/pseudo.log indicates 16 errors [qa_pseudo]
xclock-1.0.5: This /work/core2-64-oe-linux/xclock/1.0.5-r0/pseudo/pseudo.=
log indicates 10 errors [qa_pseudo]
xl2tpd-1.3.9+gitAUTOINC+f114c10ac5: This /work/qemux86_64-oe-linux/xl2tpd=
/1.3.9+gitAUTOINC+f114c10ac5-r0/pseudo/pseudo.log indicates 5 errors [qa_=
pseudo]
znc-1.6.0: This /work/core2-64-oe-linux/znc/1.6.0-r0/pseudo/pseudo.log in=
dicates 10 errors [qa_pseudo]
znc-1.6.0: This /work/i586-oe-linux-musl/znc/1.6.0-r0/pseudo/pseudo.log i=
ndicates 12 errors [qa_pseudo]



This git log matches with the metadata as seen by qemuarm build.
In some cases qemux86 and qemux86-64 builds are built with slightly
different metadata, you can see the exact version near the top of each
log.world.qemu* files linked from the report

=3D=3D Tested changes (not included in master yet) - bitbake =3D=3D
latest upstream commit:=20
2ba8a6b fetch2: fix unpack of .txz files
not included in master yet:=20
7e53b28 world-image: add extra target
1306511 fetch2: Allow Fetch.download() to warn instead of error

=3D=3D Tested changes (not included in master yet) - openembedded-core =3D=
=3D
latest upstream commit:=20
a7cd9d1 lib/oe/utils: remove param_bool()
not included in master yet:=20
6194eb0 kernel-devicetree.bbclass: Use lowercase names for shell variable=
s
409bf31 kernel-devicetree.bbclass: Fix and simplify instalation of DTB fi=
les
d5748b1 kernel.bbclass: use the consistent naming schema for initramfs
2889c86 kernel.bbclass: move variables for kernel artifacts names to sepa=
rate bbclass
9f0447f report-error: Allow to upload reports automatically
d02a701 buildhistory.bbclass: metadata-revs show repo parent
5e85c8e metadata-revs: provide more information
84279f5 qemux86: Add identical qemux86copy variant for tests
3e289a4 reproducible_build.bbclass: initial support for binary reproducib=
ility
4d1e6b3 cpio: provide cpio-replacement-native
3e227c3 image_types.bbclass: improve cpio image reproducibility
fe80a9d rootfs-postcommands.bbclass: support binary reproducibility
a28dcc5 sstate.bbclass: Do not cause build failures due to setscene error=
s
7dc8920 insane.bbclass: Add do_qa_pseudo function to check for common err=
ors listed in pseudo.log
359767a insane.bbclass: use package_qa_handle_error for do_qa_pseudo
b7d0742 initramfs-module-install: Remove allarch and FILESEXTRAPATHS

=3D=3D Tested changes (not included in master yet) - meta-openembedded =3D=
=3D
latest upstream commit:=20
e08670d python-pyasn1: update to version 0.4.2
not included in master yet:=20
32f9a40 bridge-utils: modify the AR to cross toolchain
e375f6f ssmtp: misc recipe updates + add Debian "partial loss of message =
body" fix
524d8da dovecot: Fix parallel build
a1c5667 dnsmasq: update SRC_URI for versions 2.69 and earlier
d1a7eb6 postfix: fix send mail failure and eliminate warning
818ca3a openvpn: Upgrade 2.4.3 -> 2.4.4
0217722 arptables: Fix do_install task
24bc1c0 ddclient: new package
2d43251 lksctp-tools: update and remove from blacklist
111ef72 freediameter: add new recipe
bcbca63 net-snmp: support openssl without 3des
4bfc684 stunnel: fix compile error when openssl disable des support
11a1dc5 bridge-utils: update to v1.6
f4df41c corosync: 2.4.2 -> 2.4.3
ce4720a cyrus-sasl: virtual/db isn't used by core, change to db
5b44772 postfix: virtual/db isn't used by core, change to db
83b5934 networkmanager: add consolekit only when x11 is enabled
4402570 iscsi-initiator-utils: check file existence before moving
f7291c3 iscsi-initiator-utils: remove the distro_features_check
9af95d1 open-isns: add sysvinit support
19f0225 libtalloc: update to version 2.1.10
c25c094 libtevent: update to version 0.99.33
d5e4e7a libtdb: update to version 1.3.15
df1442e libldb: update to version 1.2.2
2d6c3be Revert "samba: add missing RDEPENDS"
8783fa6 samba: move to version 4.7.0
80caa75 pcmciautils: add (from oe-core)
ac45093 chrony: Update to version 3.2
ffa622b debootstrap: change license to MIT
0e91993 site: move from meta-oe to meta-networking
2498767 gnome-common: add PACKAGECONFIG for autoconf-archive
e1dc43a xrdp: new recipe
1ddea6b dfu-utils-native: fix do_deploy sstate handling
85411df poppler-data: update 0.4.7 -> 0.4.8
b8c2598 glibmm: update 2.50.1 -> 2.54.1
48109cf glm: update 0.9.8.4 -> 0.9.8.5
6f61ead fftw: update 3.3.6-p1 -> 3.3.7
b18e363 fftw: Let dev-packages depend on libraries created
48bc4e7 nginx: correctly set the endianness of the target
32a77bd fluidsynth: performance improvements
715b235 tumbler: ensure thumbnails work properly
782f1d1 xfce4-whiskermenu-plugin: update 2.1.3 -> 2.1.4
ac9e32c thunar: update 1.6.12 -> thunar_1.6.13
992422d xfce4-pulseaudio-plugin: update 0.3.2 -> 0.3.3
9e60a8c python3-ntplib: add the correct RDEPENDS for the package
b11c71a python-paho-mqtt: update RDEPENDS to work on minimal python insta=
ll
7895909 python3-langtable: update RDEPENDS to work on minimal python inst=
all
0b12934 python-simplejson: add the tests into their own package
5325991 python-itsdangerous: fix RDEPENDS to work on minimal python insta=
ll
e497c06 python-chardet: add a separate package for the cli utils
fa7df07 python-chardet: fix the RDEPENDS to work on a minimal python inst=
all
c969c2f pyrtm: break samples and unit tests into separate packages
75ad786 python-asn1crypto: correct the RDEPENDS to work on a minimal pyth=
on install
86690e1 python-attrs: correct the RDEPENDS to work on a minimal python in=
stall
368bcd9 python-babel: correct the RDEPENDS to work on a minimal python in=
stall
2259bc3 python-pytz: correct the RDEPENDS to work on a minimal python ins=
tall
1df2c56 python-bcrypt: correct the RDEPENDS to work on a minimal python i=
nstall
c695927 python-cffi: correct the RDEPENDS to work on a minimal python ins=
tall
fa968bd python-can: correct the RDEPENDS to work on a minimal python inst=
all
bf8c7a1 python-msgpack: correct the RDEPENDS to work on a minimal python =
install
6647fd2 python-dateutil: correct the RDEPENDS to work on a minimal python=
 install
ad8dee6 python-pymongo: correct the RDEPENDS to work on a minimal python =
install
dbc3a1e neon: add the recipe from oe-core
6df5dda python-werkzeug: add a test package for the unit and integration =
tests
b0108b8 python-pylint: add a test package for unit tests
c002434 python-yappi: correct the RDEPENDS to work on a minimal python in=
stall
53dd211 python-ply: add a python3 version of the recipe
0f4ead3 python-dominate: move core of recipe to a .inc file
1f05d0c python3-dominate: new recipe

=3D=3D Tested changes (not included in master yet) - meta-qt5 =3D=3D
latest upstream commit:=20
06d1c47 qtwebengine: make test suite succeed
not included in master yet:=20

=3D=3D Tested changes (not included in master yet) - meta-browser =3D=3D
latest upstream commit:=20
4dda3fb Merge pull request #79 from msisov/add-ozone-wayland-recipe
not included in master yet:=20


--------------80084A18AD7A7E0A8270D4A5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre class="console-output"><a href="http://www.openembedded.org/wiki/Bitbake_World_Status">http://www.openembedded.org/wiki/Bitbake_World_Status</a>

== Number of issues - stats ==
{| class='wikitable'
!|Date		     !!colspan='4'|Failed tasks			    !!|Signatures		  !!colspan='15'|QA !!Comment
|-
||		||qemuarm	||qemuarm64	||qemux86	||qemux86_64	||all 	||already-stripped	||libdir	||textrel	||build-deps	||file-rdeps	||version-going-backwards	||host-user-contaminated	||installed-vs-shipped	||unknown-configure-option	||symlink-to-sysroot	||invalid-pkgconfig	||pkgname	||ldflags	||compile-host-path	||qa_pseudo	||	
|-
||2017-12-07	||8	||12	||36	||8	||0	||0		||0		||2		||0		||0		||0		||8		||1		||0		||0		||0		||0		||0		||0		||515		||	
|}

== Failed tasks 2017-12-07 ==

INFO: jenkins-job.sh-1.8.43 Complete log available at <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.report.20171209_044021.log">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.report.20171209_044021.log</a>

=== common (6) ===
    * meta-openembedded/meta-gnome/recipes-gnome/eds/evolution-data-server_git.bb:do_compile
    * meta-openembedded/meta-gnome/recipes-gnome/libgnome/libgnome_2.32.1.bb:do_compile
    * meta-openembedded/meta-networking/recipes-daemons/ddclient/ddclient_3.8.3.bb:do_install
    * meta-openembedded/meta-networking/recipes-daemons/postfix/postfix_3.2.2.bb:do_install
    * meta-openembedded/meta-oe/recipes-devtools/glade/glade_3.20.0.bb:do_compile
    * meta-openembedded/meta-xfce/recipes-xfce/gtk-xfce-engine/gtk-xfce-engine_3.2.0.bb:do_compile

=== common-x86 (0) ===

=== qemuarm (2) ===
    * meta-openembedded/meta-oe/recipes-devtools/android-tools/android-tools_5.1.1.r37.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtsystems_git.bb:do_package_qa

=== qemuarm64 (6) ===
    * meta-openembedded/meta-initramfs/recipes-devtools/mtd/ubi-utils-klibc_1.5.2.bb:do_install
    * meta-openembedded/meta-initramfs/recipes-kernel/kexec/kexec-tools-klibc_2.0.2.bb:do_configure
    * meta-openembedded/meta-oe/recipes-devtools/luajit/luajit_2.0.5.bb:do_compile
    * meta-qt5/recipes-connectivity/libqofono/libqofono_git.bb:do_package_qa
    * openembedded-core/meta/recipes-core/glibc/glibc-locale_2.26.bb:do_package_qa
    * openembedded-core/meta/recipes-kernel/kexec/kexec-tools_2.0.15.bb:do_compile

=== qemux86 (30) ===
    * meta-browser/recipes-browser/chromium/chromium-ozone-wayland_64.0.3274.0.r517731.igalia.1.bb:do_compile
    * meta-browser/recipes-browser/chromium/chromium-x11_62.0.3202.94.bb:do_compile
    * meta-browser/recipes-browser/firefox/firefox_45.9.0esr.bb:do_compile
    * meta-openembedded/meta-networking/recipes-connectivity/rdist/rdist_6.1.5.bb:do_package
    * meta-openembedded/meta-networking/recipes-connectivity/samba/samba_4.7.0.bb:do_patch
    * meta-openembedded/meta-networking/recipes-daemons/opensaf/opensaf_5.17.07.bb:do_compile
    * meta-openembedded/meta-networking/recipes-daemons/vsftpd/vsftpd_3.0.3.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rsh/netkit-rsh_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-rusers/netkit-rusers_0.17.bb:do_compile
    * meta-openembedded/meta-networking/recipes-netkit/netkit-telnet/netkit-telnet_0.17.bb:do_configure
    * meta-openembedded/meta-networking/recipes-protocols/mdns/mdns_765.50.9.bb:do_compile
    * meta-openembedded/meta-networking/recipes-protocols/tsocks/tsocks_1.8beta5.bb:do_compile
    * meta-openembedded/meta-networking/recipes-support/open-isns/open-isns_0.97.bb:do_compile
    * meta-openembedded/meta-oe/recipes-benchmark/libhugetlbfs/libhugetlbfs_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-connectivity/umip/umip_1.0.bb:do_compile
    * meta-openembedded/meta-oe/recipes-connectivity/wvdial/wvdial_1.61.bb:do_compile
    * meta-openembedded/meta-oe/recipes-devtools/pm-qa/pm-qa_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-extended/mraa/mraa_git.bb:do_compile
    * meta-openembedded/meta-oe/recipes-kernel/crash/crash_7.1.9.bb:do_compile
    * meta-openembedded/meta-oe/recipes-kernel/minicoredumper/minicoredumper_2.0.0.bb:do_compile
    * meta-openembedded/meta-oe/recipes-multimedia/alsa/alsa-oss_1.0.17.bb:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python3-systemd_234.bb:do_compile
    * meta-openembedded/meta-python/recipes-devtools/python/python-systemd_234.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qt3d_git.bb:do_package_qa
    * meta-qt5/recipes-qt/qt5/qtlocation_git.bb:do_compile
    * meta-qt5/recipes-qt/qt5/qtmultimedia_git.bb:do_package_qa
    * openembedded-core/meta/recipes-devtools/systemd-bootchart/systemd-bootchart_231.bb:do_compile
    * openembedded-core/meta/recipes-graphics/cogl/cogl-1.0_1.22.2.bb:do_compile
    * openembedded-core/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_1.12.3.bb:do_compile
    * openembedded-core/meta/recipes-multimedia/x264/x264_git.bb:do_package_qa

=== qemux86_64 (1) ===
    * meta-browser/recipes-browser/chromium/chromium-ozone-wayland_64.0.3274.0.r517731.igalia.1.bb:do_configure

=== Number of failed tasks (64) ===
{| class=wikitable
|-
|| qemuarm 	|| 8	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm.20171206_171004.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm.20171206_171004.log/</a> || <a href="http://errors.yoctoproject.org/Errors/Build/49258/">http://errors.yoctoproject.org/Errors/Build/49258/</a>
|-
|| qemuarm64 	|| 12	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm64.20171207_184553.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemuarm64.20171207_184553.log/</a> || <a href="http://errors.yoctoproject.org/Errors/Build/49290/">http://errors.yoctoproject.org/Errors/Build/49290/</a>
|-
|| qemux86 	|| 36	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86.20171206_171014.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86.20171206_171014.log/</a> || 
|-
|| qemux86_64 	|| 8	 || <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86-64.20171207_171249.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.world.qemux86-64.20171207_171249.log/</a> || <a href="http://errors.yoctoproject.org/Errors/Build/49282/">http://errors.yoctoproject.org/Errors/Build/49282/</a>
|}

=== PNBLACKLISTs (0) ===

=== QA issues (526) ===
{| class=wikitable
!| Count		||Issue
|-
||0	||already-stripped
|-
||0	||build-deps
|-
||0	||compile-host-path
|-
||0	||file-rdeps
|-
||0	||invalid-pkgconfig
|-
||0	||ldflags
|-
||0	||libdir
|-
||0	||pkgname
|-
||0	||symlink-to-sysroot
|-
||0	||unknown-configure-option
|-
||0	||version-going-backwards
|-
||1	||installed-vs-shipped
|-
||2	||textrel
|-
||515	||qa_pseudo
|-
||8	||host-user-contaminated
|}



=== Incorrect PACKAGE_ARCH or sstate signatures (0) ===

Complete log: <a href="http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.signatures.20171208_233417.log/">http://logs.nslu2-linux.org/buildlogs/oe/world/sumo/log.signatures.20171208_233417.log/</a>


    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.bb RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86copy in /home/jenkins/oe/world/shr-core/tmpfs/stamps
    * ERROR: Nothing RPROVIDES 'glibc-gconv-euc-jp' (but /home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/uim/uim_1.8.6.bb RDEPENDS on or otherwise requires it)
    * ERROR: Required build target 'meta-world-pkgdata' has no buildable providers.
    * ERROR: no sigdata files were generated for MACHINE qemux86 in /home/jenkins/oe/world/shr-core/tmpfs/stamps


PNBLACKLISTs:
openembedded-core/:
meta-browser:
meta-openembedded:
meta-qt5:
PNBLACKLIST[android-system] = "depends on lxc from meta-virtualiazation which isn't included in my world builds"
PNBLACKLIST[bigbuckbunny-1080p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-480p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-720p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[bigbuckbunny-720p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[tearsofsteel-1080p] = "big and doesn't really need to be tested so much"
PNBLACKLIST[build-appliance-image] = "tries to include whole downloads directory in /home/builder/poky :/"


QA issues by type:
count: 0	issue: already-stripped


count: 0	issue: libdir


count: 2	issue: textrel
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x264/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264-bin/usr/bin/x264' has relocations in .text [textrel]
x264-r2731+gitAUTOINC+2b741f81e5: ELF binary '/work/i586-oe-linux-musl/x264/r2731+gitAUTOINC+2b741f81e5-r0/packages-split/x264/usr/lib/libx264.so.148' has relocations in .text [textrel]


count: 0	issue: build-deps


count: 0	issue: file-rdeps


count: 0	issue: version-going-backwards


count: 8	issue: host-user-contaminated
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-ar-ss/usr/lib/locale/ar_SS/LC_NUMERIC is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-en-ie/usr/lib/locale/en_IE/LC_MEASUREMENT is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-es-hn/usr/lib/locale/es_HN/LC_CTYPE is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
glibc-locale-2.26: glibc-locale: /glibc-binary-localedata-so-ke.iso-8859-1/usr/lib/locale/so_KE.ISO-8859-1/LC_PAPER is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
libqofono-0.92+gitrAUTOINC+6916cd030b: libqofono: /libqofono-tests/usr/lib/libqofono-qt5/tests/tst_qofonosimmanager is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
qt3d-5.9.2+gitAUTOINC+143b721249: qt3d: /qt3d-mkspecs/usr/lib/qt5/mkspecs/modules/qt_lib_3dcore_private.pri is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: qtmultimedia: /qtmultimedia-mkspecs/usr/lib/qt5/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pri is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: qtsystems: /qtsystems-mkspecs/usr/lib/qt5/mkspecs/modules/qt_lib_publishsubscribe_private.pri is owned by uid 3004, which is the same as the user running bitbake. This may be due to host contamination [host-user-contaminated]


count: 1	issue: installed-vs-shipped
rdist: 1 installed and not shipped files. [installed-vs-shipped]


count: 0	issue: unknown-configure-option


count: 0	issue: symlink-to-sysroot


count: 0	issue: invalid-pkgconfig


count: 0	issue: pkgname


count: 0	issue: ldflags


count: 0	issue: compile-host-path


count: 515	issue: qa_pseudo
acl-2.2.52: This /work/armv5te-oe-linux-gnueabi/acl/2.2.52-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
acpid-2.0.28: This /work/armv5te-oe-linux-gnueabi/acpid/2.0.28-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
alsa-equal-0.6: This /work/core2-64-oe-linux/alsa-equal/0.6-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
alsa-oss-1.0.17: This /work/core2-64-oe-linux/alsa-oss/1.0.17-r1/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
alsa-plugins-1.1.4: This /work/armv5te-oe-linux-gnueabi/alsa-plugins/1.1.4-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
apache2-2.4.29: This /work/aarch64-oe-linux/apache2/2.4.29-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
apache2-2.4.29: This /work/armv5te-oe-linux-gnueabi/apache2/2.4.29-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
apache2-2.4.29: This /work/core2-64-oe-linux/apache2/2.4.29-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
apache2-2.4.29: This /work/i586-oe-linux-musl/apache2/2.4.29-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
arptables-0.0.4+gitAUTOINC+f4ab8f63f1: This /work/armv5te-oe-linux-gnueabi/arptables/0.0.4+gitAUTOINC+f4ab8f63f1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
asciidoc-8.6.9: This /work/aarch64-oe-linux/asciidoc/8.6.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
blktrace-1.1.0+gitAUTOINC+43fc870ce0: This /work/aarch64-oe-linux/blktrace/1.1.0+gitAUTOINC+43fc870ce0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
bluez5-5.47: This /work/aarch64-oe-linux/bluez5/5.47-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
bluez5-5.47: This /work/armv5te-oe-linux-gnueabi/bluez5/5.47-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
bluez5-5.47: This /work/core2-64-oe-linux/bluez5/5.47-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
bmap-tools-3.4: This /work/armv5te-oe-linux-gnueabi/bmap-tools/3.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
boost-1.65.1: This /work/armv5e-oe-linux-gnueabi/boost/1.65.1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
btrfs-tools-4.13.3: This /work/core2-64-oe-linux/btrfs-tools/4.13.3-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
busybox-1.27.2: This /work/core2-64-oe-linux/busybox/1.27.2-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
byacc-20170201: This /work/core2-64-oe-linux/byacc/20170201-r0/pseudo/pseudo.log indicates 9 errors [qa_pseudo]
cdrkit-1.1.11: This /work/core2-64-oe-linux/cdrkit/1.1.11-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
cgdb-0.6.8: This /work/armv5te-oe-linux-gnueabi/cgdb/0.6.8-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
cherokee-1.2.104+gitAUTOINC+75f041e225: This /work/armv5te-oe-linux-gnueabi/cherokee/1.2.104+gitAUTOINC+75f041e225-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
chrony-3.2: This /work/aarch64-oe-linux/chrony/3.2-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
chrony-3.2: This /work/armv5te-oe-linux-gnueabi/chrony/3.2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
chrony-3.2: This /work/core2-64-oe-linux/chrony/3.2-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
chrony-3.2: This /work/i586-oe-linux-musl/chrony/3.2-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
console-tools-0.3.2: This /work/aarch64-oe-linux/console-tools/0.3.2-r8/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
coreutils-8.27: This /work/armv5te-oe-linux-gnueabi/coreutils/8.27-r0/pseudo/pseudo.log indicates 17 errors [qa_pseudo]
corosync-2.4.3: This /work/aarch64-oe-linux/corosync/2.4.3-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
corosync-2.4.3: This /work/core2-64-oe-linux/corosync/2.4.3-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
corosync-2.4.3: This /work/i586-oe-linux-musl/corosync/2.4.3-r0/pseudo/pseudo.log indicates 19 errors [qa_pseudo]
cpufrequtils-008: This /work/armv5te-oe-linux-gnueabi/cpufrequtils/008-r5/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
cryptodev-tests-1.9: This /work/aarch64-oe-linux/cryptodev-tests/1.9-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
ctdb-2.5.6: This /work/i586-oe-linux-musl/ctdb/2.5.6-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
cups-2.2.6: This /work/i586-oe-linux-musl/cups/2.2.6-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
curlpp-0.8.1: This /work/aarch64-oe-linux/curlpp/0.8.1-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
curlpp-0.8.1: This /work/armv5te-oe-linux-gnueabi/curlpp/0.8.1-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
curlpp-0.8.1: This /work/core2-64-oe-linux/curlpp/0.8.1-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
curlpp-0.8.1: This /work/i586-oe-linux-musl/curlpp/0.8.1-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
cxxtest-4.3: This /work/armv5te-oe-linux-gnueabi/cxxtest/4.3-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
dbus-test-1.10.20: This /work/i586-oe-linux-musl/dbus-test/1.10.20-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
dhcp-4.3.6: This /work/aarch64-oe-linux/dhcp/4.3.6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
dhcp-4.3.6: This /work/armv5te-oe-linux-gnueabi/dhcp/4.3.6-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
dhcp-4.3.6: This /work/core2-64-oe-linux/dhcp/4.3.6-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
dhcp-4.3.6: This /work/i586-oe-linux-musl/dhcp/4.3.6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
dleyna-renderer-0.6.0: This /work/armv5te-oe-linux-gnueabi/dleyna-renderer/0.6.0-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
dmalloc-5.5.2: This /work/armv5e-oe-linux-gnueabi/dmalloc/5.5.2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
dovecot-2.2.29: This /work/aarch64-oe-linux/dovecot/2.2.29-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
dovecot-2.2.29: This /work/armv5te-oe-linux-gnueabi/dovecot/2.2.29-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
dovecot-2.2.29: This /work/core2-64-oe-linux/dovecot/2.2.29-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
dovecot-2.2.29: This /work/i586-oe-linux-musl/dovecot/2.2.29-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
dracut-045+git39c9b67f86145953aa30def9d77c68597a4ccfe8: This /work/aarch64-oe-linux/dracut/1_045+git39c9b67f86145953aa30def9d77c68597a4ccfe8-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
dracut-045+git39c9b67f86145953aa30def9d77c68597a4ccfe8: This /work/core2-64-oe-linux/dracut/1_045+git39c9b67f86145953aa30def9d77c68597a4ccfe8-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
ebtables-2.0.10-4: This /work/aarch64-oe-linux/ebtables/2.0.10-4-r4/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
ebtables-2.0.10-4: This /work/core2-64-oe-linux/ebtables/2.0.10-4-r4/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
ebtables-2.0.10-4: This /work/i586-oe-linux-musl/ebtables/2.0.10-4-r4/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
enca-1.9: This /work/aarch64-oe-linux/enca/1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
espeak-1.48.04: This /work/aarch64-oe-linux/espeak/1.48.04-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
espeak-1.48.04: This /work/i586-oe-linux-musl/espeak/1.48.04-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
expat-2.2.5: This /work/armv5te-oe-linux-gnueabi/expat/2.2.5-r0/pseudo/pseudo.log indicates 9 errors [qa_pseudo]
expect-5.45.3: This /work/aarch64-oe-linux/expect/5.45.3-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
f2fs-tools-1.8.0: This /work/aarch64-oe-linux/f2fs-tools/1.8.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
faac-1.29: This /work/core2-64-oe-linux/faac/1.29-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
faad2-2.7: This /work/core2-64-oe-linux/faad2/2.7-r1/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
firefox-l10n-dsb-45.9.0esr: This /work/all-oe-linux/firefox-l10n-dsb/45.9.0esr-r3/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
firefox-l10n-kn-45.9.0esr: This /work/all-oe-linux/firefox-l10n-kn/45.9.0esr-r3/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
firefox-l10n-rm-45.9.0esr: This /work/all-oe-linux/firefox-l10n-rm/45.9.0esr-r3/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
firefox-l10n-sq-45.9.0esr: This /work/all-oe-linux/firefox-l10n-sq/45.9.0esr-r3/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
firefox-l10n-te-45.9.0esr: This /work/all-oe-linux/firefox-l10n-te/45.9.0esr-r3/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
flex-2.6.0: This /work/armv5te-oe-linux-gnueabi/flex/2.6.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
freediameter-1.2.1: This /work/armv5te-oe-linux-gnueabi/freediameter/1.2.1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
freediameter-1.2.1: This /work/i586-oe-linux-musl/freediameter/1.2.1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
freerdp-2.0.0+gitrAUTOINC+1648deb435: This /work/armv5te-oe-linux-gnueabi/freerdp/2.0.0+gitrAUTOINC+1648deb435-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
fribidi-0.19.7: This /work/armv5te-oe-linux-gnueabi/fribidi/0.19.7-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/aarch64-oe-linux/gateone/1.2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/armv5te-oe-linux-gnueabi/gateone/1.2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/core2-64-oe-linux/gateone/1.2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
gateone-1.2+gitAUTOINC+f7a9be46cb: This /work/i586-oe-linux-musl/gateone/1.2+gitAUTOINC+f7a9be46cb-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
gawk-4.2.0: This /work/aarch64-oe-linux/gawk/4.2.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
gdk-pixbuf-2.36.11: This /work/armv5te-oe-linux-gnueabi/gdk-pixbuf/2.36.11-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
geis-2.2.17: This /work/aarch64-oe-linux/geis/2.2.17-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
geoip-1.6.9: This /work/i586-oe-linux-musl/geoip/1.6.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
ghostscript-9.21: This /work/i586-oe-linux-musl/ghostscript/9.21-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
giflib-5.1.4: This /work/armv5te-oe-linux-gnueabi/giflib/5.1.4-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
giflib-5.1.4: This /work/core2-64-oe-linux/giflib/5.1.4-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
git-2.15.0: This /work/armv5te-oe-linux-gnueabi/git/2.15.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
glib-2.0-2.54.2: This /work/aarch64-oe-linux/glib-2.0/1_2.54.2-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
glibc-2.26: This /work/aarch64-oe-linux/glibc/2.26-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
glibc-2.26: This /work/armv5e-oe-linux-gnueabi/glibc/2.26-r0/pseudo/pseudo.log indicates 29 errors [qa_pseudo]
glibc-2.26: This /work/core2-64-oe-linux/glibc/2.26-r0/pseudo/pseudo.log indicates 264 errors [qa_pseudo]
glibc-locale-2.26: This /work/aarch64-oe-linux/glibc-locale/2.26-r0/pseudo/pseudo.log indicates 9 errors [qa_pseudo]
glibc-locale-2.26: This /work/armv5e-oe-linux-gnueabi/glibc-locale/2.26-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
glibc-locale-2.26: This /work/core2-64-oe-linux/glibc-locale/2.26-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
grub-2.02: This /work/i586-oe-linux-musl/grub/2.02-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
gsettings-desktop-schemas-3.24.1: This /work/aarch64-oe-linux/gsettings-desktop-schemas/3.24.1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
gstreamer1.0-plugins-bad-1.12.3: This /work/core2-64-oe-linux/gstreamer1.0-plugins-bad/1.12.3-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
gst-rtsp-0.10.8: This /work/armv5te-oe-linux-gnueabi/gst-rtsp/0.10.8-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
gtkmathview-0.8.0+gitAUTOINC+0bc2cfa0a4: This /work/armv5te-oe-linux-gnueabi/gtkmathview/0.8.0+gitAUTOINC+0bc2cfa0a4-r3/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
icu-60.1: This /work/aarch64-oe-linux/icu/60.1-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
icu-60.1: This /work/armv5e-oe-linux-gnueabi/icu/60.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
icu-60.1: This /work/core2-64-oe-linux/icu/60.1-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
icu-60.1: This /work/i586-oe-linux-musl/icu/60.1-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
initramfs-module-install-1.0: This /work/aarch64-oe-linux/initramfs-module-install/1.0-r1/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
initscripts-1.0: This /work/aarch64-oe-linux/initscripts/1.0-r155/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
iotop-0.6: This /work/core2-64-oe-linux/iotop/0.6-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
iozone3-465: This /work/armv5te-oe-linux-gnueabi/iozone3/465-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
iproute2-4.13.0: This /work/armv5te-oe-linux-gnueabi/iproute2/4.13.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
irda-utils-0.9.18: This /work/i586-oe-linux-musl/irda-utils/0.9.18-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
jsonrpc-0.7.0+gitAUTOINC+ccbdb41388: This /work/core2-64-oe-linux/jsonrpc/0.7.0+gitAUTOINC+ccbdb41388-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
kconfig-frontends-4.11.0.1: This /work/core2-64-oe-linux/kconfig-frontends/4.11.0.1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/aarch64-oe-linux/lcdproc/0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/armv5te-oe-linux-gnueabi/lcdproc/0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/core2-64-oe-linux/lcdproc/0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lcdproc-0.5.8+gitAUTOINC+f5156e2e41: This /work/i586-oe-linux-musl/lcdproc/0.5.8+gitAUTOINC+f5156e2e41-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
leptonica-1.74.4: This /work/armv5te-oe-linux-gnueabi/leptonica/1.74.4-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
libatasmart-0.19: This /work/aarch64-oe-linux/libatasmart/0.19-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libatasmart-0.19: This /work/armv5te-oe-linux-gnueabi/libatasmart/0.19-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libatasmart-0.19: This /work/core2-64-oe-linux/libatasmart/0.19-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libatasmart-0.19: This /work/i586-oe-linux-musl/libatasmart/0.19-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libblockdev-2.10: This /work/aarch64-oe-linux/libblockdev/2.10-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
libbsd-0.8.6: This /work/i586-oe-linux-musl/libbsd/0.8.6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libconnman-qt5-1.2.4+gitAUTOINC+9d98e12ed6: This /work/aarch64-oe-linux/libconnman-qt5/1.2.4+gitAUTOINC+9d98e12ed6-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
libconnman-qt5-1.2.4+gitAUTOINC+9d98e12ed6: This /work/core2-64-oe-linux/libconnman-qt5/1.2.4+gitAUTOINC+9d98e12ed6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libconnman-qt5-1.2.4+gitAUTOINC+9d98e12ed6: This /work/i586-oe-linux-musl/libconnman-qt5/1.2.4+gitAUTOINC+9d98e12ed6-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
libee-0.4.1: This /work/i586-oe-linux-musl/libee/0.4.1-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
libevent-2.1.8: This /work/core2-64-oe-linux/libevent/2.1.8-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libgphoto2-2.5.14: This /work/core2-64-oe-linux/libgphoto2/2.5.14-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libhugetlbfs-2.20: This /work/aarch64-oe-linux/libhugetlbfs/1_2.20-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
libice-1.0.9: This /work/aarch64-oe-linux/libice/1_1.0.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libice-1.0.9: This /work/core2-64-oe-linux/libice/1_1.0.9-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libmoo-perl-2.003002: This /work/aarch64-oe-linux/libmoo-perl/2.003002-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libndp-1.6: This /work/i586-oe-linux-musl/libndp/1.6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libnet-1.2-rc3: This /work/aarch64-oe-linux/libnet/1.2-rc3-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libnss-mdns-0.10: This /work/core2-64-oe-linux/libnss-mdns/0.10-r7/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
libomxil-0.9.3: This /work/aarch64-oe-linux/libomxil/0.9.3-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libpthread-stubs-0.4: This /work/i586-oe-linux-musl/libpthread-stubs/0.4-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/aarch64-oe-linux/libqofono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/armv5te-oe-linux-gnueabi/libqofono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/core2-64-oe-linux/libqofono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
libqofono-0.92+gitrAUTOINC+6916cd030b: This /work/i586-oe-linux-musl/libqofono/0.92+gitrAUTOINC+6916cd030b-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
libsdl2-2.0.7: This /work/i586-oe-linux-musl/libsdl2/2.0.7-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
libsdl2-mixer-2.0.1: This /work/i586-oe-linux-musl/libsdl2-mixer/2.0.1-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
libsoc-0.8.2: This /work/aarch64-oe-linux/libsoc/0.8.2-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
libtar-1.2.20: This /work/i586-oe-linux-musl/libtar/1.2.20-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libtool-cross-2.4.6: This /work/i586-oe-linux-musl/libtool-cross/2.4.6-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
libvncserver-0.9.11: This /work/aarch64-oe-linux/libvncserver/0.9.11-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
libvncserver-0.9.11: This /work/armv5te-oe-linux-gnueabi/libvncserver/0.9.11-r0/pseudo/pseudo.log indicates 22 errors [qa_pseudo]
libvncserver-0.9.11: This /work/core2-64-oe-linux/libvncserver/0.9.11-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
libvncserver-0.9.11: This /work/i586-oe-linux-musl/libvncserver/0.9.11-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/aarch64-oe-linux/libwmf/0.2.8.4-r3/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/armv5te-oe-linux-gnueabi/libwmf/0.2.8.4-r3/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/core2-64-oe-linux/libwmf/0.2.8.4-r3/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
libwmf-0.2.8.4: This /work/i586-oe-linux-musl/libwmf/0.2.8.4-r3/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libxcalibrate-0.0+gitAUTOINC+209d83af61: This /work/i586-oe-linux-musl/libxcalibrate/0.0+gitAUTOINC+209d83af61-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
libxml2-2.9.7: This /work/armv5te-oe-linux-gnueabi/libxml2/2.9.7-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
linux-atm-2.5.2: This /work/qemuarm-oe-linux-gnueabi/linux-atm/2.5.2-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
linux-libc-headers-4.12: This /work/i586-oe-linux-musl/linux-libc-headers/4.12-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
lio-utils-4.1+gitAUTOINC+28bd928655: This /work/core2-64-oe-linux/lio-utils/4.1+gitAUTOINC+28bd928655-r0/pseudo/pseudo.log indicates 9 errors [qa_pseudo]
lirc-0.9.4d: This /work/aarch64-oe-linux/lirc/0.9.4d-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
lirc-0.9.4d: This /work/armv5te-oe-linux-gnueabi/lirc/0.9.4d-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lirc-0.9.4d: This /work/core2-64-oe-linux/lirc/0.9.4d-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lirc-0.9.4d: This /work/i586-oe-linux-musl/lirc/0.9.4d-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
lksctp-tools-1.0.17+gitAUTOINC+736b91d340: This /work/i586-oe-linux-musl/lksctp-tools/1.0.17+gitAUTOINC+736b91d340-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
llvm-5.0: This /work/aarch64-oe-linux/llvm/5.0-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
llvm-5.0: This /work/armv5e-oe-linux-gnueabi/llvm/5.0-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
llvm-5.0: This /work/core2-64-oe-linux/llvm/5.0-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
llvm-5.0: This /work/i586-oe-linux-musl/llvm/5.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
lmbench-3.0-a9: This /work/aarch64-oe-linux/lmbench/3.0-a9-r2/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
lockdev-1.0.3+gitAUTOINC+16b899645d: This /work/i586-oe-linux-musl/lockdev/1.0.3+gitAUTOINC+16b899645d-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
log4cpp-1.1.2: This /work/aarch64-oe-linux/log4cpp/1.1.2-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
log4cpp-1.1.2: This /work/armv5te-oe-linux-gnueabi/log4cpp/1.1.2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
log4cpp-1.1.2: This /work/i586-oe-linux-musl/log4cpp/1.1.2-r0/pseudo/pseudo.log indicates 8 errors [qa_pseudo]
lowpan-tools-0.3.1+gitAUTOINC+38f42dbfce: This /work/core2-64-oe-linux/lowpan-tools/0.3.1+gitAUTOINC+38f42dbfce-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lttng-tools-2.9.5: This /work/core2-64-oe-linux/lttng-tools/2.9.5-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lttng-tools-2.9.5: This /work/i586-oe-linux-musl/lttng-tools/2.9.5-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lvm2-2.02.171: This /work/core2-64-oe-linux/lvm2/2.02.171-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
lzip-1.19: This /work/armv5te-oe-linux-gnueabi/lzip/1.19-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/aarch64-oe-linux/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/armv5te-oe-linux-gnueabi/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/core2-64-oe-linux/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
maliit-framework-qt5-0.99.0+gitAUTOINC+60b1b10de1: This /work/i586-oe-linux-musl/maliit-framework-qt5/0.99.0+gitAUTOINC+60b1b10de1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
mariadb-5.5.57: This /work/core2-64-oe-linux/mariadb/5.5.57-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
meson-0.40.1: This /work/core2-64-oe-linux/meson/0.40.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
modemmanager-1.6.4: This /work/core2-64-oe-linux/modemmanager/1.6.4-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
mosquitto-1.4.14: This /work/aarch64-oe-linux/mosquitto/1.4.14-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
mosquitto-1.4.14: This /work/armv5te-oe-linux-gnueabi/mosquitto/1.4.14-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
mosquitto-1.4.14: This /work/i586-oe-linux-musl/mosquitto/1.4.14-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
mozilla-devscripts-0.30: This /work/aarch64-oe-linux/mozilla-devscripts/0.30-r1/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
mpich-3.2: This /work/core2-64-oe-linux/mpich/3.2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
mpich-3.2: This /work/i586-oe-linux-musl/mpich/3.2-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
mraa-1.7.0-gitAUTOINC+8ddbcde84e: This /work/aarch64-oe-linux/mraa/1.7.0-gitAUTOINC+8ddbcde84e-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
mraa-1.7.0-gitAUTOINC+8ddbcde84e: This /work/armv5te-oe-linux-gnueabi/mraa/1.7.0-gitAUTOINC+8ddbcde84e-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
mtr-0.87+gitAUTOINC+e6d0a7e931: This /work/core2-64-oe-linux/mtr/0.87+gitAUTOINC+e6d0a7e931-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
multipath-tools-0.7.1: This /work/armv5e-oe-linux-gnueabi/multipath-tools/0.7.1-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
ncftp-3.2.6: This /work/i586-oe-linux-musl/ncftp/3.2.6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
netdata-1.8.0+gitAUTOINC+89ed309252: This /work/i586-oe-linux-musl/netdata/1.8.0+gitAUTOINC+89ed309252-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
net-snmp-5.7.3: This /work/aarch64-oe-linux/net-snmp/5.7.3-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
net-snmp-5.7.3: This /work/armv5te-oe-linux-gnueabi/net-snmp/5.7.3-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
net-snmp-5.7.3: This /work/core2-64-oe-linux/net-snmp/5.7.3-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
net-snmp-5.7.3: This /work/i586-oe-linux-musl/net-snmp/5.7.3-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
nettle-3.4: This /work/armv5te-oe-linux-gnueabi/nettle/3.4-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
nginx-1.12.2: This /work/armv5te-oe-linux-gnueabi/nginx/1.12.2-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
nginx-1.12.2: This /work/i586-oe-linux-musl/nginx/1.12.2-r0/pseudo/pseudo.log indicates 8 errors [qa_pseudo]
nspr-4.17: This /work/armv5te-oe-linux-gnueabi/nspr/4.17-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
ntp-4.2.8p10: This /work/aarch64-oe-linux/ntp/4.2.8p10-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
ntp-4.2.8p10: This /work/armv5te-oe-linux-gnueabi/ntp/4.2.8p10-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
ntp-4.2.8p10: This /work/core2-64-oe-linux/ntp/4.2.8p10-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
ntp-4.2.8p10: This /work/i586-oe-linux-musl/ntp/4.2.8p10-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
numlockx-1.2: This /work/i586-oe-linux-musl/numlockx/1.2-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
nuttcp-7.2.1: This /work/i586-oe-linux-musl/nuttcp/7.2.1-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
obexd-0.48: This /work/aarch64-oe-linux/obexd/0.48-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
open-isns-0.97: This /work/aarch64-oe-linux/open-isns/0.97-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
open-isns-0.97: This /work/armv5te-oe-linux-gnueabi/open-isns/0.97-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
open-isns-0.97: This /work/core2-64-oe-linux/open-isns/0.97-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
opensaf-5.17.07: This /work/aarch64-oe-linux/opensaf/5.17.07-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
opensaf-5.17.07: This /work/armv5te-oe-linux-gnueabi/opensaf/5.17.07-r0/pseudo/pseudo.log indicates 20 errors [qa_pseudo]
openssh-7.6p1: This /work/aarch64-oe-linux/openssh/7.6p1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
openssh-7.6p1: This /work/armv5te-oe-linux-gnueabi/openssh/7.6p1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
openssh-7.6p1: This /work/core2-64-oe-linux/openssh/7.6p1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
openssh-7.6p1: This /work/i586-oe-linux-musl/openssh/7.6p1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
orbit2-2.14.19: This /work/core2-64-oe-linux/orbit2/2.14.19-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/aarch64-oe-linux/ossp-uuid/1.6.2-r2/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/armv5te-oe-linux-gnueabi/ossp-uuid/1.6.2-r2/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/core2-64-oe-linux/ossp-uuid/1.6.2-r2/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
ossp-uuid-1.6.2: This /work/i586-oe-linux-musl/ossp-uuid/1.6.2-r2/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
packagegroup-xfce-base-1.0: This /work/all-oe-linux/packagegroup-xfce-base/1.0-r5/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
perf-1.0: This /work/qemuarm64-oe-linux/perf/1.0-r9/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
perf-1.0: This /work/qemuarm-oe-linux-gnueabi/perf/1.0-r9/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
perf-1.0: This /work/qemux86_64-oe-linux/perf/1.0-r9/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
perl-5.24.1: This /work/aarch64-oe-linux/perl/5.24.1-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
perl-5.24.1: This /work/armv5te-oe-linux-gnueabi/perl/5.24.1-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
perl-5.24.1: This /work/core2-64-oe-linux/perl/5.24.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
perl-5.24.1: This /work/i586-oe-linux-musl/perl/5.24.1-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
php-7.1.9: This /work/aarch64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
php-7.1.9: This /work/armv5e-oe-linux-gnueabi/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/core2-64-oe-linux/php/7.1.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
php-7.1.9: This /work/i586-oe-linux-musl/php/7.1.9-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
piglit-1.0+gitrAUTOINC+c8f4fd9eeb: This /work/armv5te-oe-linux-gnueabi/piglit/1.0+gitrAUTOINC+c8f4fd9eeb-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
pkcs11-helper-1.11: This /work/aarch64-oe-linux/pkcs11-helper/1.11-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
pm-qa-0.5.2: This /work/aarch64-oe-linux/pm-qa/0.5.2-r0/pseudo/pseudo.log indicates 47 errors [qa_pseudo]
pm-qa-0.5.2: This /work/armv5te-oe-linux-gnueabi/pm-qa/0.5.2-r0/pseudo/pseudo.log indicates 50 errors [qa_pseudo]
pm-qa-0.5.2: This /work/core2-64-oe-linux/pm-qa/0.5.2-r0/pseudo/pseudo.log indicates 29 errors [qa_pseudo]
pngcheck-2.3.0: This /work/i586-oe-linux-musl/pngcheck/2.3.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
polkit-gnome-0.105: This /work/aarch64-oe-linux/polkit-gnome/0.105-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
poppler-0.57.0: This /work/armv5te-oe-linux-gnueabi/poppler/0.57.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
portaudio-v19-v190600: This /work/aarch64-oe-linux/portaudio-v19/v190600-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
portaudio-v19-v190600: This /work/armv5te-oe-linux-gnueabi/portaudio-v19/v190600-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
portaudio-v19-v190600: This /work/core2-64-oe-linux/portaudio-v19/v190600-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
postgresql-9.4.15: This /work/aarch64-oe-linux/postgresql/9.4.15-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
postgresql-9.4.15: This /work/armv5e-oe-linux-gnueabi/postgresql/9.4.15-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
postgresql-9.4.15: This /work/core2-64-oe-linux/postgresql/9.4.15-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
postgresql-9.4.15: This /work/i586-oe-linux-musl/postgresql/9.4.15-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
pptp-linux-1.9.0: This /work/aarch64-oe-linux/pptp-linux/1.9.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
proftpd-1.3.6: This /work/aarch64-oe-linux/proftpd/1.3.6-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
proftpd-1.3.6: This /work/core2-64-oe-linux/proftpd/1.3.6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
proftpd-1.3.6: This /work/i586-oe-linux-musl/proftpd/1.3.6-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
psqlodbc-09.05.0300: This /work/aarch64-oe-linux/psqlodbc/09.05.0300-r0/pseudo/pseudo.log indicates 17 errors [qa_pseudo]
ptpd-2.3.1: This /work/core2-64-oe-linux/ptpd/2.3.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
pure-ftpd-1.0.42: This /work/aarch64-oe-linux/pure-ftpd/1.0.42-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-2.7.13: This /work/aarch64-oe-linux/python/2.7.13-r1/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-2.7.13: This /work/armv5te-oe-linux-gnueabi/python/2.7.13-r1/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
python-2.7.13: This /work/core2-64-oe-linux/python/2.7.13-r1/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
python-2.7.13: This /work/i586-oe-linux-musl/python/2.7.13-r1/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
python3-3.5.3: This /work/aarch64-oe-linux/python3/3.5.3-r1.0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
python3-3.5.3: This /work/armv5te-oe-linux-gnueabi/python3/3.5.3-r1.0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-3.5.3: This /work/core2-64-oe-linux/python3/3.5.3-r1.0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
python3-3.5.3: This /work/i586-oe-linux-musl/python3/3.5.3-r1.0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python3-bitarray-0.8.1: This /work/i586-oe-linux-musl/python3-bitarray/0.8.1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python3-cassandra-driver-3.11.0: This /work/aarch64-oe-linux/python3-cassandra-driver/3.11.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-chardet-3.0.4: This /work/aarch64-oe-linux/python3-chardet/3.0.4-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-coverage-4.4.2: This /work/i586-oe-linux-musl/python3-coverage/4.4.2-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-cryptography-vectors-2.1.3: This /work/core2-64-oe-linux/python3-cryptography-vectors/2.1.3-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
python3-cython-0.27.3: This /work/armv5te-oe-linux-gnueabi/python3-cython/0.27.3-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-django-1.11.5: This /work/armv5te-oe-linux-gnueabi/python3-django/1.11.5-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-django-1.11.5: This /work/i586-oe-linux-musl/python3-django/1.11.5-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-docutils-0.14: This /work/aarch64-oe-linux/python3-docutils/0.14-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-docutils-0.14: This /work/core2-64-oe-linux/python3-docutils/0.14-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-flask-0.12.2: This /work/core2-64-oe-linux/python3-flask/0.12.2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-jsonschema-2.6.0: This /work/aarch64-oe-linux/python3-jsonschema/2.6.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-jsonschema-2.6.0: This /work/core2-64-oe-linux/python3-jsonschema/2.6.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-ndg-httpsclient-0.4.3: This /work/armv5te-oe-linux-gnueabi/python3-ndg-httpsclient/0.4.3-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-netaddr-0.7.19: This /work/core2-64-oe-linux/python3-netaddr/0.7.19-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-nose-1.3.7: This /work/aarch64-oe-linux/python3-nose/1.3.7-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pandas-0.21.0: This /work/core2-64-oe-linux/python3-pandas/0.21.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pid-2.1.1: This /work/aarch64-oe-linux/python3-pid/2.1.1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python3-pip-9.0.1: This /work/armv5te-oe-linux-gnueabi/python3-pip/9.0.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pip-9.0.1: This /work/i586-oe-linux-musl/python3-pip/9.0.1-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
python3-pyalsaaudio-0.8.4: This /work/i586-oe-linux-musl/python3-pyalsaaudio/0.8.4-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/aarch64-oe-linux/python3-pylint/1.7.4-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/armv5te-oe-linux-gnueabi/python3-pylint/1.7.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/core2-64-oe-linux/python3-pylint/1.7.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python3-pylint-1.7.4: This /work/i586-oe-linux-musl/python3-pylint/1.7.4-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pytest-3.2.5: This /work/i586-oe-linux-musl/python3-pytest/3.2.5-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-pyudev-0.21.0: This /work/armv5te-oe-linux-gnueabi/python3-pyudev/0.21.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-requests-2.18.4: This /work/armv5te-oe-linux-gnueabi/python3-requests/2.18.4-r0/pseudo/pseudo.log indicates 9 errors [qa_pseudo]
python3-setuptools-36.5.0: This /work/aarch64-oe-linux/python3-setuptools/36.5.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-setuptools-scm-1.15.6: This /work/armv5te-oe-linux-gnueabi/python3-setuptools-scm/1.15.6-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
python3-twisted-17.9.0: This /work/i586-oe-linux-musl/python3-twisted/17.9.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-unidiff-0.5.4: This /work/aarch64-oe-linux/python3-unidiff/0.5.4-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python3-werkzeug-0.12.2: This /work/aarch64-oe-linux/python3-werkzeug/0.12.2-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-attr-0.2.0: This /work/armv5te-oe-linux-gnueabi/python-attr/0.2.0-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
python-automat-0.6.0: This /work/aarch64-oe-linux/python-automat/0.6.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-babel-2.5.1: This /work/armv5te-oe-linux-gnueabi/python-babel/2.5.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-babel-2.5.1: This /work/i586-oe-linux-musl/python-babel/2.5.1-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-cheetah-2.4.4: This /work/armv5te-oe-linux-gnueabi/python-cheetah/2.4.4-r3/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-cython-0.27.3: This /work/core2-64-oe-linux/python-cython/0.27.3-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-docutils-0.14rc2: This /work/core2-64-oe-linux/python-docutils/0.14rc2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-epydoc-3.0.1: This /work/aarch64-oe-linux/python-epydoc/3.0.1-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-flask-login-0.4.0: This /work/aarch64-oe-linux/python-flask-login/0.4.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-future-0.16.0: This /work/armv5te-oe-linux-gnueabi/python-future/0.16.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-incremental-17.5.0: This /work/core2-64-oe-linux/python-incremental/17.5.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
python-isort-4.2.15: This /work/core2-64-oe-linux/python-isort/4.2.15-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-jsonpatch-1.20: This /work/core2-64-oe-linux/python-jsonpatch/1.20-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-netaddr-0.7.19: This /work/armv5te-oe-linux-gnueabi/python-netaddr/0.7.19-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-netaddr-0.7.19: This /work/core2-64-oe-linux/python-netaddr/0.7.19-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-nose-1.3.7: This /work/aarch64-oe-linux/python-nose/1.3.7-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-numpy-1.13.1: This /work/armv5te-oe-linux-gnueabi/python-numpy/1.13.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-pep8-1.7.1: This /work/core2-64-oe-linux/python-pep8/1.7.1-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-pexpect-4.3.0: This /work/i586-oe-linux-musl/python-pexpect/4.3.0-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
python-protobuf-3.4.0: This /work/armv5te-oe-linux-gnueabi/python-protobuf/3.4.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
python-pyflakes-1.2.3: This /work/aarch64-oe-linux/python-pyflakes/1.2.3-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-pylint-1.7.4: This /work/aarch64-oe-linux/python-pylint/1.7.4-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-pylint-1.7.4: This /work/core2-64-oe-linux/python-pylint/1.7.4-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
python-pylint-1.7.4: This /work/i586-oe-linux-musl/python-pylint/1.7.4-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-pyopenssl-17.3.0: This /work/aarch64-oe-linux/python-pyopenssl/17.3.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-pysmi-0.2.2: This /work/core2-64-oe-linux/python-pysmi/0.2.2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-pysmi-0.2.2: This /work/i586-oe-linux-musl/python-pysmi/0.2.2-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
python-pytest-3.2.5: This /work/armv5te-oe-linux-gnueabi/python-pytest/3.2.5-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-scons-3.0.0: This /work/aarch64-oe-linux/python-scons/3.0.0-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
python-scons-3.0.0: This /work/i586-oe-linux-musl/python-scons/3.0.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-setuptools-36.5.0: This /work/aarch64-oe-linux/python-setuptools/36.5.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-snakefood-1.4: This /work/aarch64-oe-linux/python-snakefood/1.4-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-snakefood-1.4: This /work/armv5te-oe-linux-gnueabi/python-snakefood/1.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-snimpy-0.8.12: This /work/aarch64-oe-linux/python-snimpy/0.8.12-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-unidiff-0.5.4: This /work/armv5te-oe-linux-gnueabi/python-unidiff/0.5.4-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-vobject-0.9.5: This /work/core2-64-oe-linux/python-vobject/0.9.5-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-xlrd-1.1.0: This /work/armv5te-oe-linux-gnueabi/python-xlrd/1.1.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
python-xlrd-1.1.0: This /work/i586-oe-linux-musl/python-xlrd/1.1.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
python-yappi-0.98: This /work/i586-oe-linux-musl/python-yappi/0.98-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/aarch64-oe-linux/qt3d/5.9.2+gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/armv5te-oe-linux-gnueabi/qt3d/5.9.2+gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 20 errors [qa_pseudo]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/core2-64-oe-linux/qt3d/5.9.2+gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qt3d-5.9.2+gitAUTOINC+143b721249: This /work/i586-oe-linux-musl/qt3d/5.9.2+gitAUTOINC+143b721249-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
qt5-creator-3.5.1: This /work/armv5te-oe-linux-gnueabi/qt5-creator/3.5.1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtbase-5.9.2+gitAUTOINC+ec16ba393b: This /work/aarch64-oe-linux/qtbase/5.9.2+gitAUTOINC+ec16ba393b-r0/pseudo/pseudo.log indicates 597 errors [qa_pseudo]
qtbase-5.9.2+gitAUTOINC+ec16ba393b: This /work/armv5te-oe-linux-gnueabi/qtbase/5.9.2+gitAUTOINC+ec16ba393b-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtbase-5.9.2+gitAUTOINC+ec16ba393b: This /work/i586-oe-linux-musl/qtbase/5.9.2+gitAUTOINC+ec16ba393b-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/aarch64-oe-linux/qtcharts/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/armv5te-oe-linux-gnueabi/qtcharts/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/core2-64-oe-linux/qtcharts/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtcharts-5.9.2+gitAUTOINC+e3af14e916: This /work/i586-oe-linux-musl/qtcharts/5.9.2+gitAUTOINC+e3af14e916-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/aarch64-oe-linux/qtconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/armv5te-oe-linux-gnueabi/qtconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/core2-64-oe-linux/qtconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtconnectivity-5.9.2+gitAUTOINC+6b3bdb8440: This /work/i586-oe-linux-musl/qtconnectivity/5.9.2+gitAUTOINC+6b3bdb8440-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/aarch64-oe-linux/qtdatavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/armv5te-oe-linux-gnueabi/qtdatavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/core2-64-oe-linux/qtdatavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtdatavis3d-5.9.2+gitAUTOINC+8329a8fb28: This /work/i586-oe-linux-musl/qtdatavis3d/5.9.2+gitAUTOINC+8329a8fb28-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/aarch64-oe-linux/qtdeclarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indicates 26 errors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/armv5te-oe-linux-gnueabi/qtdeclarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/core2-64-oe-linux/qtdeclarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indicates 17 errors [qa_pseudo]
qtdeclarative-5.9.2+gitAUTOINC+32218c3243: This /work/i586-oe-linux-musl/qtdeclarative/5.9.2+gitAUTOINC+32218c3243-r0/pseudo/pseudo.log indicates 21 errors [qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/aarch64-oe-linux/qtenginio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/armv5te-oe-linux-gnueabi/qtenginio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/core2-64-oe-linux/qtenginio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtenginio-5.9.2+gitAUTOINC+23603a3b08: This /work/i586-oe-linux-musl/qtenginio/5.9.2+gitAUTOINC+23603a3b08-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtgamepad-5.9.2+gitAUTOINC+167566d228: This /work/aarch64-oe-linux/qtgamepad/5.9.2+gitAUTOINC+167566d228-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtgamepad-5.9.2+gitAUTOINC+167566d228: This /work/armv5te-oe-linux-gnueabi/qtgamepad/5.9.2+gitAUTOINC+167566d228-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtgamepad-5.9.2+gitAUTOINC+167566d228: This /work/core2-64-oe-linux/qtgamepad/5.9.2+gitAUTOINC+167566d228-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtgraphicaleffects-5.9.2+gitAUTOINC+1f6658cbaa: This /work/i586-oe-linux-musl/qtgraphicaleffects/5.9.2+gitAUTOINC+1f6658cbaa-r0/pseudo/pseudo.log indicates 8 errors [qa_pseudo]
qtlocation-5.9.2+gitAUTOINC+d919f47308_1c633072fc: This /work/aarch64-oe-linux/qtlocation/5.9.2+gitAUTOINC+d919f47308_1c633072fc-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtlocation-5.9.2+gitAUTOINC+d919f47308_1c633072fc: This /work/armv5te-oe-linux-gnueabi/qtlocation/5.9.2+gitAUTOINC+d919f47308_1c633072fc-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtlocation-5.9.2+gitAUTOINC+d919f47308_1c633072fc: This /work/core2-64-oe-linux/qtlocation/5.9.2+gitAUTOINC+d919f47308_1c633072fc-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/aarch64-oe-linux/qtmultimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/armv5te-oe-linux-gnueabi/qtmultimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/core2-64-oe-linux/qtmultimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtmultimedia-5.9.2+gitAUTOINC+1e2702e86d: This /work/i586-oe-linux-musl/qtmultimedia/5.9.2+gitAUTOINC+1e2702e86d-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/aarch64-oe-linux/qtnetworkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/armv5te-oe-linux-gnueabi/qtnetworkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/core2-64-oe-linux/qtnetworkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
qtnetworkauth-5.9.2+gitAUTOINC+47b80ecae6: This /work/i586-oe-linux-musl/qtnetworkauth/5.9.2+gitAUTOINC+47b80ecae6-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtquick1-5.9.2+gitAUTOINC+9bf0edd9bd: This /work/aarch64-oe-linux/qtquick1/5.9.2+gitAUTOINC+9bf0edd9bd-r0/pseudo/pseudo.log indicates 19 errors [qa_pseudo]
qtquick1-5.9.2+gitAUTOINC+9bf0edd9bd: This /work/armv5te-oe-linux-gnueabi/qtquick1/5.9.2+gitAUTOINC+9bf0edd9bd-r0/pseudo/pseudo.log indicates 17 errors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/aarch64-oe-linux/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/armv5te-oe-linux-gnueabi/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/core2-64-oe-linux/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtquickcontrols2-5.9.2+gitAUTOINC+871d8e8e2f: This /work/i586-oe-linux-musl/qtquickcontrols2/5.9.2+gitAUTOINC+871d8e8e2f-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtquickcontrols-5.9.2+gitAUTOINC+8476f8fff7: This /work/armv5te-oe-linux-gnueabi/qtquickcontrols/5.9.2+gitAUTOINC+8476f8fff7-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/aarch64-oe-linux/qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/armv5te-oe-linux-gnueabi/qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/core2-64-oe-linux/qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtremoteobjects-5.9.2+gitAUTOINC+6e0341bc87: This /work/i586-oe-linux-musl/qtremoteobjects/5.9.2+gitAUTOINC+6e0341bc87-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/aarch64-oe-linux/qtscript/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/armv5e-oe-linux-gnueabi/qtscript/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/core2-64-oe-linux/qtscript/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtscript-5.9.2+gitAUTOINC+08b74f4f30: This /work/i586-oe-linux-musl/qtscript/5.9.2+gitAUTOINC+08b74f4f30-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/aarch64-oe-linux/qtscxml/5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/armv5te-oe-linux-gnueabi/qtscxml/5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/core2-64-oe-linux/qtscxml/5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 17 errors [qa_pseudo]
qtscxml-5.9.2+gitAUTOINC+3caae998c8: This /work/i586-oe-linux-musl/qtscxml/5.9.2+gitAUTOINC+3caae998c8-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/aarch64-oe-linux/qtsensors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/armv5te-oe-linux-gnueabi/qtsensors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/core2-64-oe-linux/qtsensors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtsensors-5.9.2+gitAUTOINC+c273f2e5c8: This /work/i586-oe-linux-musl/qtsensors/5.9.2+gitAUTOINC+c273f2e5c8-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/aarch64-oe-linux/qtserialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/armv5te-oe-linux-gnueabi/qtserialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/core2-64-oe-linux/qtserialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtserialbus-5.9.2+gitAUTOINC+ce5a3ced5e: This /work/i586-oe-linux-musl/qtserialbus/5.9.2+gitAUTOINC+ce5a3ced5e-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/aarch64-oe-linux/qtserialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/armv5te-oe-linux-gnueabi/qtserialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/core2-64-oe-linux/qtserialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
qtserialport-5.9.2+gitAUTOINC+cb9ade8bea: This /work/i586-oe-linux-musl/qtserialport/5.9.2+gitAUTOINC+cb9ade8bea-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
qtsmarthome-1.0: This /work/i586-oe-linux-musl/qtsmarthome/1.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtsvg-5.9.2+gitAUTOINC+bdcd7a9744: This /work/aarch64-oe-linux/qtsvg/5.9.2+gitAUTOINC+bdcd7a9744-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
qtsvg-5.9.2+gitAUTOINC+bdcd7a9744: This /work/armv5te-oe-linux-gnueabi/qtsvg/5.9.2+gitAUTOINC+bdcd7a9744-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtsvg-5.9.2+gitAUTOINC+bdcd7a9744: This /work/i586-oe-linux-musl/qtsvg/5.9.2+gitAUTOINC+bdcd7a9744-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: This /work/armv5te-oe-linux-gnueabi/qtsystems/5.9.2+gitAUTOINC+9c204e05ae-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: This /work/core2-64-oe-linux/qtsystems/5.9.2+gitAUTOINC+9c204e05ae-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtsystems-5.9.2+gitAUTOINC+9c204e05ae: This /work/i586-oe-linux-musl/qtsystems/5.9.2+gitAUTOINC+9c204e05ae-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qttools-5.9.2+gitAUTOINC+90a701032e: This /work/armv5te-oe-linux-gnueabi/qttools/5.9.2+gitAUTOINC+90a701032e-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
qttools-5.9.2+gitAUTOINC+90a701032e: This /work/core2-64-oe-linux/qttools/5.9.2+gitAUTOINC+90a701032e-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qttools-5.9.2+gitAUTOINC+90a701032e: This /work/i586-oe-linux-musl/qttools/5.9.2+gitAUTOINC+90a701032e-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/aarch64-oe-linux/qtwayland/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/armv5te-oe-linux-gnueabi/qtwayland/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/core2-64-oe-linux/qtwayland/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtwayland-5.9.2+gitAUTOINC+d483ed2927: This /work/i586-oe-linux-musl/qtwayland/5.9.2+gitAUTOINC+d483ed2927-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/aarch64-oe-linux/qtwebchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/armv5te-oe-linux-gnueabi/qtwebchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/core2-64-oe-linux/qtwebchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtwebchannel-5.9.2+gitAUTOINC+61a638663c: This /work/i586-oe-linux-musl/qtwebchannel/5.9.2+gitAUTOINC+61a638663c-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtwebengine-5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903: This /work/aarch64-oe-linux/qtwebengine/5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtwebengine-5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903: This /work/core2-64-oe-linux/qtwebengine/5.9.2+gitAUTOINC+c11c2c8981_cfe8c60903-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtwebkit-5.9.2+gitAUTOINC+97c4a80a12: This /work/aarch64-oe-linux/qtwebkit/5.9.2+gitAUTOINC+97c4a80a12-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtwebkit-5.9.2+gitAUTOINC+97c4a80a12: This /work/armv5e-oe-linux-gnueabi/qtwebkit/5.9.2+gitAUTOINC+97c4a80a12-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtwebkit-5.9.2+gitAUTOINC+97c4a80a12: This /work/core2-64-oe-linux/qtwebkit/5.9.2+gitAUTOINC+97c4a80a12-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
qtwebkit-examples-5.9.2+gitAUTOINC+a24c780b60: This /work/aarch64-oe-linux/qtwebkit-examples/5.9.2+gitAUTOINC+a24c780b60-r0/pseudo/pseudo.log indicates 14 errors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/aarch64-oe-linux/qtwebsockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/armv5te-oe-linux-gnueabi/qtwebsockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/core2-64-oe-linux/qtwebsockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtwebsockets-5.9.2+gitAUTOINC+492981b932: This /work/i586-oe-linux-musl/qtwebsockets/5.9.2+gitAUTOINC+492981b932-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
qtwebview-5.9.2+gitAUTOINC+ec640efd1d: This /work/aarch64-oe-linux/qtwebview/5.9.2+gitAUTOINC+ec640efd1d-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
qtwebview-5.9.2+gitAUTOINC+ec640efd1d: This /work/core2-64-oe-linux/qtwebview/5.9.2+gitAUTOINC+ec640efd1d-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/aarch64-oe-linux/qtx11extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicates 8 errors [qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/armv5te-oe-linux-gnueabi/qtx11extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/core2-64-oe-linux/qtx11extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
qtx11extras-5.9.2+gitAUTOINC+160435b0eb: This /work/i586-oe-linux-musl/qtx11extras/5.9.2+gitAUTOINC+160435b0eb-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/aarch64-oe-linux/qtxmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/armv5te-oe-linux-gnueabi/qtxmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/core2-64-oe-linux/qtxmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
qtxmlpatterns-5.9.2+gitAUTOINC+8d7e1e0ec0: This /work/i586-oe-linux-musl/qtxmlpatterns/5.9.2+gitAUTOINC+8d7e1e0ec0-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
quagga-1.2.1: This /work/aarch64-oe-linux/quagga/1.2.1-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
quagga-1.2.1: This /work/armv5te-oe-linux-gnueabi/quagga/1.2.1-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
quagga-1.2.1: This /work/core2-64-oe-linux/quagga/1.2.1-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
quazip-0.7.3: This /work/aarch64-oe-linux/quazip/0.7.3-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
quilt-0.65: This /work/aarch64-oe-linux/quilt/0.65-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
qwt-qt5-6.1.3: This /work/i586-oe-linux-musl/qwt-qt5/6.1.3-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
radvd-2.17: This /work/armv5te-oe-linux-gnueabi/radvd/2.17-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
radvd-2.17: This /work/core2-64-oe-linux/radvd/2.17-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
rpm-4.13.90+gitAUTOINC+a8e51b3bb0: This /work/core2-64-oe-linux/rpm/1_4.13.90+gitAUTOINC+a8e51b3bb0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
rp-pppoe-3.12: This /work/armv5te-oe-linux-gnueabi/rp-pppoe/3.12-r10/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
rsyslog-8.29.0: This /work/aarch64-oe-linux/rsyslog/8.29.0-r0/pseudo/pseudo.log indicates 11 errors [qa_pseudo]
rsyslog-8.29.0: This /work/armv5te-oe-linux-gnueabi/rsyslog/8.29.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
rsyslog-8.29.0: This /work/core2-64-oe-linux/rsyslog/8.29.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
rsyslog-8.29.0: This /work/i586-oe-linux-musl/rsyslog/8.29.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
satyr-0.23: This /work/armv5te-oe-linux-gnueabi/satyr/0.23-r0/pseudo/pseudo.log indicates 15 errors [qa_pseudo]
sblim-sfcb-1.4.9: This /work/aarch64-oe-linux/sblim-sfcb/1.4.9-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
scsirastools-1.6.6: This /work/aarch64-oe-linux/scsirastools/1.6.6-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
sed-4.2.2: This /work/armv5te-oe-linux-gnueabi/sed/4.2.2-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
sed-4.2.2: This /work/i586-oe-linux-musl/sed/4.2.2-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
sessreg-1.1.0: This /work/core2-64-oe-linux/sessreg/1.1.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
shadow-4.2.1: This /work/aarch64-oe-linux/shadow/4.2.1-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
slang-2.3.1a: This /work/core2-64-oe-linux/slang/2.3.1a-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
speexdsp-1.2rc3: This /work/i586-oe-linux-musl/speexdsp/1.2rc3-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
squid-3.5.26: This /work/aarch64-oe-linux/squid/3.5.26-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
squid-3.5.26: This /work/armv5te-oe-linux-gnueabi/squid/3.5.26-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
squid-3.5.26: This /work/core2-64-oe-linux/squid/3.5.26-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
squid-3.5.26: This /work/i586-oe-linux-musl/squid/3.5.26-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
sthttpd-2.27.1: This /work/aarch64-oe-linux/sthttpd/2.27.1-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
sthttpd-2.27.1: This /work/armv5te-oe-linux-gnueabi/sthttpd/2.27.1-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
sthttpd-2.27.1: This /work/core2-64-oe-linux/sthttpd/2.27.1-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
strace-4.19: This /work/aarch64-oe-linux/strace/4.19-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
strace-4.19: This /work/armv5te-oe-linux-gnueabi/strace/4.19-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
strace-4.19: This /work/core2-64-oe-linux/strace/4.19-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
strace-4.19: This /work/i586-oe-linux-musl/strace/4.19-r0/pseudo/pseudo.log indicates 13 errors [qa_pseudo]
tcl-8.6.7: This /work/aarch64-oe-linux/tcl/8.6.7-r0/pseudo/pseudo.log indicates 8 errors [qa_pseudo]
tcl-8.6.7: This /work/armv5te-oe-linux-gnueabi/tcl/8.6.7-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
tcl-8.6.7: This /work/core2-64-oe-linux/tcl/8.6.7-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
tcl-8.6.7: This /work/i586-oe-linux-musl/tcl/8.6.7-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
tftp-hpa-5.2: This /work/aarch64-oe-linux/tftp-hpa/5.2-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
tftp-hpa-5.2: This /work/armv5te-oe-linux-gnueabi/tftp-hpa/5.2-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
tftp-hpa-5.2: This /work/core2-64-oe-linux/tftp-hpa/5.2-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
tftp-hpa-5.2: This /work/i586-oe-linux-musl/tftp-hpa/5.2-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
tipcutils-2.2.0+gitAUTOINC+7ab2211b87: This /work/qemuarm-oe-linux-gnueabi/tipcutils/2.2.0+gitAUTOINC+7ab2211b87-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
tipcutils-2.2.0+gitAUTOINC+7ab2211b87: This /work/qemux86-oe-linux-musl/tipcutils/2.2.0+gitAUTOINC+7ab2211b87-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
tomoyo-tools-2.5.0: This /work/core2-64-oe-linux/tomoyo-tools/2.5.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
tomoyo-tools-2.5.0: This /work/i586-oe-linux-musl/tomoyo-tools/2.5.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]
trace-cmd-2.6.1: This /work/i586-oe-linux-musl/trace-cmd/2.6.1-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
traceroute-2.1.0: This /work/core2-64-oe-linux/traceroute/2.1.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
tunctl-1.5: This /work/armv5te-oe-linux-gnueabi/tunctl/1.5-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
ufw-0.33: This /work/aarch64-oe-linux/ufw/0.33-r0/pseudo/pseudo.log indicates 7 errors [qa_pseudo]
uml-utilities-20040406: This /work/armv5te-oe-linux-gnueabi/uml-utilities/20040406-r1/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
upm-1.3.0-gitAUTOINC+106b6c7062: This /work/aarch64-oe-linux/upm/1.3.0-gitAUTOINC+106b6c7062-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
util-linux-2.31: This /work/armv5te-oe-linux-gnueabi/util-linux/2.31-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
valgrind-3.13.0: This /work/aarch64-oe-linux/valgrind/3.13.0-r0/pseudo/pseudo.log indicates 6 errors [qa_pseudo]
vlock-2.2.3: This /work/armv5te-oe-linux-gnueabi/vlock/2.2.3-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
vo-aacenc-0.1.3: This /work/armv5te-oe-linux-gnueabi/vo-aacenc/0.1.3-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
vorbis-tools-1.4.0: This /work/i586-oe-linux-musl/vorbis-tools/1.4.0-r0/pseudo/pseudo.log indicates 18 errors [qa_pseudo]
weston-init-1.0: This /work/all-oe-linux/weston-init/1.0-r0/pseudo/pseudo.log indicates 4 errors [qa_pseudo]
xcb-proto-1.12: This /work/armv5te-oe-linux-gnueabi/xcb-proto/1.12-r0/pseudo/pseudo.log indicates 16 errors [qa_pseudo]
xclock-1.0.5: This /work/core2-64-oe-linux/xclock/1.0.5-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
xl2tpd-1.3.9+gitAUTOINC+f114c10ac5: This /work/qemux86_64-oe-linux/xl2tpd/1.3.9+gitAUTOINC+f114c10ac5-r0/pseudo/pseudo.log indicates 5 errors [qa_pseudo]
znc-1.6.0: This /work/core2-64-oe-linux/znc/1.6.0-r0/pseudo/pseudo.log indicates 10 errors [qa_pseudo]
znc-1.6.0: This /work/i586-oe-linux-musl/znc/1.6.0-r0/pseudo/pseudo.log indicates 12 errors [qa_pseudo]



This git log matches with the metadata as seen by qemuarm build.
In some cases qemux86 and qemux86-64 builds are built with slightly
different metadata, you can see the exact version near the top of each
log.world.qemu* files linked from the report

== Tested changes (not included in master yet) - bitbake ==
latest upstream commit: 
2ba8a6b fetch2: fix unpack of .txz files
not included in master yet: 
7e53b28 world-image: add extra target
1306511 fetch2: Allow Fetch.download() to warn instead of error

== Tested changes (not included in master yet) - openembedded-core ==
latest upstream commit: 
a7cd9d1 lib/oe/utils: remove param_bool()
not included in master yet: 
6194eb0 kernel-devicetree.bbclass: Use lowercase names for shell variables
409bf31 kernel-devicetree.bbclass: Fix and simplify instalation of DTB files
d5748b1 kernel.bbclass: use the consistent naming schema for initramfs
2889c86 kernel.bbclass: move variables for kernel artifacts names to separate bbclass
9f0447f report-error: Allow to upload reports automatically
d02a701 buildhistory.bbclass: metadata-revs show repo parent
5e85c8e metadata-revs: provide more information
84279f5 qemux86: Add identical qemux86copy variant for tests
3e289a4 reproducible_build.bbclass: initial support for binary reproducibility
4d1e6b3 cpio: provide cpio-replacement-native
3e227c3 image_types.bbclass: improve cpio image reproducibility
fe80a9d rootfs-postcommands.bbclass: support binary reproducibility
a28dcc5 sstate.bbclass: Do not cause build failures due to setscene errors
7dc8920 insane.bbclass: Add do_qa_pseudo function to check for common errors listed in pseudo.log
359767a insane.bbclass: use package_qa_handle_error for do_qa_pseudo
b7d0742 initramfs-module-install: Remove allarch and FILESEXTRAPATHS

== Tested changes (not included in master yet) - meta-openembedded ==
latest upstream commit: 
e08670d python-pyasn1: update to version 0.4.2
not included in master yet: 
32f9a40 bridge-utils: modify the AR to cross toolchain
e375f6f ssmtp: misc recipe updates + add Debian "partial loss of message body" fix
524d8da dovecot: Fix parallel build
a1c5667 dnsmasq: update SRC_URI for versions 2.69 and earlier
d1a7eb6 postfix: fix send mail failure and eliminate warning
818ca3a openvpn: Upgrade 2.4.3 -&gt; 2.4.4
0217722 arptables: Fix do_install task
24bc1c0 ddclient: new package
2d43251 lksctp-tools: update and remove from blacklist
111ef72 freediameter: add new recipe
bcbca63 net-snmp: support openssl without 3des
4bfc684 stunnel: fix compile error when openssl disable des support
11a1dc5 bridge-utils: update to v1.6
f4df41c corosync: 2.4.2 -&gt; 2.4.3
ce4720a cyrus-sasl: virtual/db isn't used by core, change to db
5b44772 postfix: virtual/db isn't used by core, change to db
83b5934 networkmanager: add consolekit only when x11 is enabled
4402570 iscsi-initiator-utils: check file existence before moving
f7291c3 iscsi-initiator-utils: remove the distro_features_check
9af95d1 open-isns: add sysvinit support
19f0225 libtalloc: update to version 2.1.10
c25c094 libtevent: update to version 0.99.33
d5e4e7a libtdb: update to version 1.3.15
df1442e libldb: update to version 1.2.2
2d6c3be Revert "samba: add missing RDEPENDS"
8783fa6 samba: move to version 4.7.0
80caa75 pcmciautils: add (from oe-core)
ac45093 chrony: Update to version 3.2
ffa622b debootstrap: change license to MIT
0e91993 site: move from meta-oe to meta-networking
2498767 gnome-common: add PACKAGECONFIG for autoconf-archive
e1dc43a xrdp: new recipe
1ddea6b dfu-utils-native: fix do_deploy sstate handling
85411df poppler-data: update 0.4.7 -&gt; 0.4.8
b8c2598 glibmm: update 2.50.1 -&gt; 2.54.1
48109cf glm: update 0.9.8.4 -&gt; 0.9.8.5
6f61ead fftw: update 3.3.6-p1 -&gt; 3.3.7
b18e363 fftw: Let dev-packages depend on libraries created
48bc4e7 nginx: correctly set the endianness of the target
32a77bd fluidsynth: performance improvements
715b235 tumbler: ensure thumbnails work properly
782f1d1 xfce4-whiskermenu-plugin: update 2.1.3 -&gt; 2.1.4
ac9e32c thunar: update 1.6.12 -&gt; thunar_1.6.13
992422d xfce4-pulseaudio-plugin: update 0.3.2 -&gt; 0.3.3
9e60a8c python3-ntplib: add the correct RDEPENDS for the package
b11c71a python-paho-mqtt: update RDEPENDS to work on minimal python install
7895909 python3-langtable: update RDEPENDS to work on minimal python install
0b12934 python-simplejson: add the tests into their own package
5325991 python-itsdangerous: fix RDEPENDS to work on minimal python install
e497c06 python-chardet: add a separate package for the cli utils
fa7df07 python-chardet: fix the RDEPENDS to work on a minimal python install
c969c2f pyrtm: break samples and unit tests into separate packages
75ad786 python-asn1crypto: correct the RDEPENDS to work on a minimal python install
86690e1 python-attrs: correct the RDEPENDS to work on a minimal python install
368bcd9 python-babel: correct the RDEPENDS to work on a minimal python install
2259bc3 python-pytz: correct the RDEPENDS to work on a minimal python install
1df2c56 python-bcrypt: correct the RDEPENDS to work on a minimal python install
c695927 python-cffi: correct the RDEPENDS to work on a minimal python install
fa968bd python-can: correct the RDEPENDS to work on a minimal python install
bf8c7a1 python-msgpack: correct the RDEPENDS to work on a minimal python install
6647fd2 python-dateutil: correct the RDEPENDS to work on a minimal python install
ad8dee6 python-pymongo: correct the RDEPENDS to work on a minimal python install
dbc3a1e neon: add the recipe from oe-core
6df5dda python-werkzeug: add a test package for the unit and integration tests
b0108b8 python-pylint: add a test package for unit tests
c002434 python-yappi: correct the RDEPENDS to work on a minimal python install
53dd211 python-ply: add a python3 version of the recipe
0f4ead3 python-dominate: move core of recipe to a .inc file
1f05d0c python3-dominate: new recipe

== Tested changes (not included in master yet) - meta-qt5 ==
latest upstream commit: 
06d1c47 qtwebengine: make test suite succeed
not included in master yet: 

== Tested changes (not included in master yet) - meta-browser ==
latest upstream commit: 
4dda3fb Merge pull request #79 from msisov/add-ozone-wayland-recipe
not included in master yet: 
</pre>
  </body>
</html>

--------------80084A18AD7A7E0A8270D4A5--
