Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC509C433F5
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 16:25:59 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.795.1633623957939061273
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 09:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.201,
 mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 06AD91BF206;
	Thu,  7 Oct 2021 16:25:54 +0000 (UTC)
Date: Thu, 07 Oct 2021 18:25:52 +0200
From: Quentin Schulz <foss@0leil.net>
To: Jon Mason <jdmason@kudzu.us>, openembedded-core@lists.openembedded.org,
 docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [PATCH 3/8] meta: replace http with https for URLs
In-Reply-To: <20211007150630.22138-4-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
 <20211007150630.22138-4-jdmason@kudzu.us>
Message-ID: <39119895-2E58-45E0-8177-F9080843FE25@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 16:25:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12751

Hi Jon,

On October 7, 2021 5:06:25 PM GMT+02:00, Jon Mason <jdmason@kudzu=2Eus> wr=
ote:
>https has been the preferred way to access websites for many years now=2E
>Change all of the URLs with a _working_ https server/certificate to use
>that URL=2E
>
>Signed-off-by: Jon Mason <jdmason@kudzu=2Eus>
>---
> README=2EOE-Core=2Emd                             | 10 ++++-----
> =2E=2E=2E/devtool/devtool-test-local_6=2E03=2Ebb        |  2 +-
> =2E=2E=2E/devtool/devtool-test-patch-gz=2Ebb          |  2 +-
> =2E=2E=2E/devtool/devtool-upgrade-test2_git=2Ebb      |  2 +-
> =2E=2E=2E/devtool-upgrade-test2_git=2Ebb=2Eupgraded     |  2 +-
> =2E=2E=2E/git-submodule-test/git-submodule-test=2Ebb  |  2 +-
> =2E=2E=2E/recipes-core/busybox/busybox_%=2Ebbappend   |  2 +-
> meta/classes/insane=2Ebbclass                   |  2 +-
> meta/classes/mirrors=2Ebbclass                  | 20 ++++++++---------
> meta/classes/sstate=2Ebbclass                   |  2 +-
> meta/classes/toaster=2Ebbclass                  |  2 +-
> meta/conf/distro/include/maintainers=2Einc      |  2 +-
> meta/conf/distro/include/yocto-uninative=2Einc  |  2 +-
> meta/lib/oe/package_manager/__init__=2Epy       |  2 +-
> =2E=2E=2E/lib/oeqa/manual/toaster-managed-mode=2Ejson |  8 +++----
> meta/lib/oeqa/runtime/cases/buildlzip=2Epy      |  2 +-
> meta/lib/oeqa/sdk/cases/buildlzip=2Epy          |  2 +-
> meta/lib/oeqa/selftest/cases/buildoptions=2Epy  | 22 +++++++++----------
> meta/lib/oeqa/selftest/cases/devtool=2Epy       |  4 ++--
> meta/lib/oeqa/selftest/cases/fetch=2Epy         |  2 +-
> meta/lib/oeqa/selftest/cases/recipetool=2Epy    |  2 +-
> meta/recipes-core/dbus-wait/dbus-wait_git=2Ebb  |  2 +-
> =2E=2E=2E/images/build-appliance-image_15=2E0=2E0=2Ebb    |  2 +-
> meta/recipes-core/psplash/psplash_git=2Ebb      |  2 +-
> meta/recipes-devtools/glide/glide_0=2E13=2E3=2Ebb   |  4 ++--
> =2E=2E=2E/opkg-utils/opkg-utils_0=2E4=2E5=2Ebb            |  6 ++---
> meta/recipes-devtools/opkg/opkg_0=2E4=2E5=2Ebb      |  2 +-
> meta/recipes-devtools/prelink/prelink_git=2Ebb  |  4 ++--
> =2E=2E=2E/pseudo/files/build-oldlibc                |  2 +-
> meta/recipes-devtools/pseudo/pseudo=2Einc       |  2 +-
> meta/recipes-devtools/pseudo/pseudo_git=2Ebb    |  4 ++--
> =2E=2E=2Essing-libraries-to-Extension-for-mul=2Epatch |  2 +-
> =2E=2E=2Et-fail-to-build-on-some-PPC32-config=2Epatch |  2 +-
> meta/recipes-gnome/gcr/gcr_3=2E40=2E0=2Ebb          |  2 +-
> =2E=2E=2E/libsecret/libsecret_0=2E20=2E4=2Ebb             |  2 +-
> =2E=2E=2E/libfakekey/libfakekey_git=2Ebb              |  2 +-
> =2E=2E=2E/matchbox-session/matchbox-session_0=2E1=2Ebb  |  2 +-
> =2E=2E=2E/matchbox-wm/matchbox-wm_1=2E2=2E2=2Ebb          |  2 +-
> =2E=2E=2E/mini-x-session/mini-x-session_0=2E1=2Ebb      |  2 +-
> =2E=2E=2E/xcursor-transparent-theme_git=2Ebb          |  2 +-
> =2E=2E=2E-workarounds-in-cpu-features-detecti=2Epatch |  2 +-
> meta/recipes-graphics/xrestop/xrestop_0=2E4=2Ebb  |  2 +-
> =2E=2E=2Eder=2Ec-when-env-var-is-set-do-not-fal=2Epatch |  2 +-
> =2E=2E=2E/matchbox-config-gtk_0=2E2=2Ebb                |  2 +-
> =2E=2E=2E/matchbox-desktop/matchbox-desktop_2=2E2=2Ebb  |  2 +-
> =2E=2E=2E/matchbox-keyboard_0=2E1=2E1=2Ebb                |  2 +-
> =2E=2E=2E/matchbox-panel-2/matchbox-panel-2_2=2E11=2Ebb |  2 +-
> =2E=2E=2E/matchbox-session-sato_0=2E1=2Ebb              |  2 +-
> =2E=2E=2E/matchbox-terminal_0=2E2=2Ebb                  |  2 +-
> =2E=2E=2E/matchbox-theme-sato=2Einc                   |  2 +-
> =2E=2E=2E/sato-screenshot/sato-screenshot_0=2E3=2Ebb    |  2 +-
> =2E=2E=2E/settings-daemon/settings-daemon_0=2E0=2E2=2Ebb  |  2 +-
> meta/recipes-sato/webkit/webkitgtk_2=2E32=2E3=2Ebb  |  2 +-
> meta/recipes-support/icu/icu_69=2E1=2Ebb          |  2 +-
> =2E=2E=2E/libunwind/libunwind_1=2E5=2E0=2Ebb              |  2 +-
> =2E=2E=2E/ptest-runner/ptest-runner_2=2E4=2E2=2Ebb        |  2 +-
> scripts/autobuilder-worker-prereq-tests       |  6 ++---
> scripts/create-pull-request                   |  4 ++--
> scripts/install-buildtools                    | 10 ++++-----
> scripts/lib/build_perf/html/report=2Ehtml       |  2 +-
> 60 files changed, 99 insertions(+), 99 deletions(-)
>
>diff --git a/README=2EOE-Core=2Emd b/README=2EOE-Core=2Emd
>index 521916cd4f3f=2E=2E2f2127fb03a7 100644
>--- a/README=2EOE-Core=2Emd
>+++ b/README=2EOE-Core=2Emd
>@@ -6,24 +6,24 @@ of OpenEmbedded=2E It is distro-less (can build a funct=
ional image with
> DISTRO =3D "nodistro") and contains only emulated machine support=2E
>=20
> For information about OpenEmbedded, see the OpenEmbedded website:
>-    http://www=2Eopenembedded=2Eorg/
>+    https://www=2Eopenembedded=2Eorg/
>=20
> The Yocto Project has extensive documentation about OE including a refer=
ence manual
> which can be found at:
>-    http://yoctoproject=2Eorg/documentation
>+    https://docs=2Eyoctoproject=2Eorg/
>=20
>=20
> Contributing
> ------------
>=20
> Please refer to
>-http://www=2Eopenembedded=2Eorg/wiki/How_to_submit_a_patch_to_OpenEmbedd=
ed
>+https://www=2Eopenembedded=2Eorg/wiki/How_to_submit_a_patch_to_OpenEmbed=
ded
> for guidelines on how to submit patches=2E
>=20
> Mailing list:
>=20
>-    http://lists=2Eopenembedded=2Eorg/mailman/listinfo/openembedded-core
>+    https://lists=2Eopenembedded=2Eorg/g/openembedded-core
>=20
> Source code:
>=20
>-    http://git=2Eopenembedded=2Eorg/openembedded-core/
>+    https://git=2Eopenembedded=2Eorg/openembedded-core/
>diff --git a/meta-selftest/recipes-test/devtool/devtool-test-local_6=2E03=
=2Ebb b/meta-selftest/recipes-test/devtool/devtool-test-local_6=2E03=2Ebb
>index 6bfc557060a3=2E=2Ee95b365ce806 100644
>--- a/meta-selftest/recipes-test/devtool/devtool-test-local_6=2E03=2Ebb
>+++ b/meta-selftest/recipes-test/devtool/devtool-test-local_6=2E03=2Ebb
>@@ -3,7 +3,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D0636e73ff0215e=
8d672dc4c32c317bb3"
>=20
> INHIBIT_DEFAULT_DEPS =3D "1"
>=20
>-SRC_URI =3D "http://downloads=2Eyoctoproject=2Eorg/mirror/sources/syslin=
ux-${PV}=2Etar=2Exz \
>+SRC_URI =3D "https://downloads=2Eyoctoproject=2Eorg/mirror/sources/sysli=
nux-${PV}=2Etar=2Exz \
>            file://file1 \
>            file://file2"
>=20
>diff --git a/meta-selftest/recipes-test/devtool/devtool-test-patch-gz=2Eb=
b b/meta-selftest/recipes-test/devtool/devtool-test-patch-gz=2Ebb
>index fc3799590cc3=2E=2E069d0395be98 100644
>--- a/meta-selftest/recipes-test/devtool/devtool-test-patch-gz=2Ebb
>+++ b/meta-selftest/recipes-test/devtool/devtool-test-patch-gz=2Ebb
>@@ -3,7 +3,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba3=
6caa9b7df079bae19f"
>=20
> DEPENDS =3D "libxres libxext virtual/libx11 ncurses"
>=20
>-SRC_URI =3D "http://downloads=2Eyoctoproject=2Eorg/releases/xrestop/xres=
top-0=2E4=2Etar=2Egz \
>+SRC_URI =3D "https://downloads=2Eyoctoproject=2Eorg/releases/xrestop/xre=
stop-0=2E4=2Etar=2Egz \
>            file://readme=2Epatch=2Egz \
>            "
> UPSTREAM_VERSION_UNKNOWN =3D "1"
>diff --git a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git=
=2Ebb b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git=2Ebb
>index 07b83276fb95=2E=2Edcb5816da552 100644
>--- a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git=2Ebb
>+++ b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git=2Ebb
>@@ -1,5 +1,5 @@
> SUMMARY =3D "A simple tool to wait for a specific signal over DBus"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/dbus-wait"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/dbus-wait=
"
> SECTION =3D "base"
> LICENSE =3D "GPLv2"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Db234ee4d69f5fce4486a80fdaf4a4=
263"
>diff --git a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git=
=2Ebb=2Eupgraded b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2=
_git=2Ebb=2Eupgraded
>index 32ec4b14fa62=2E=2Ecef88cbb3351 100644
>--- a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git=2Ebb=
=2Eupgraded
>+++ b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git=2Ebb=
=2Eupgraded
>@@ -1,5 +1,5 @@
> SUMMARY =3D "A simple tool to wait for a specific signal over DBus"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/dbus-wait"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/dbus-wait=
"
> SECTION =3D "base"
> LICENSE =3D "GPLv2"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Db234ee4d69f5fce4486a80fdaf4a4=
263"
>diff --git a/meta-selftest/recipes-test/git-submodule-test/git-submodule-=
test=2Ebb b/meta-selftest/recipes-test/git-submodule-test/git-submodule-tes=
t=2Ebb
>index 9429564df43d=2E=2E41e50b792e0b 100644
>--- a/meta-selftest/recipes-test/git-submodule-test/git-submodule-test=2E=
bb
>+++ b/meta-selftest/recipes-test/git-submodule-test/git-submodule-test=2E=
bb
>@@ -1,5 +1,5 @@
> SUMMARY =3D "Test recipe for fetching git submodules"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/git-submod=
ule-test/"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/git-submo=
dule-test/"
> LICENSE =3D "MIT"
> LIC_FILES_CHKSUM =3D "file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e=
0bcf8506ecda2f7b4f302"
>=20
>diff --git a/meta-skeleton/recipes-core/busybox/busybox_%=2Ebbappend b/me=
ta-skeleton/recipes-core/busybox/busybox_%=2Ebbappend
>index 621c94f651f5=2E=2E79353bf61e4d 100644
>--- a/meta-skeleton/recipes-core/busybox/busybox_%=2Ebbappend
>+++ b/meta-skeleton/recipes-core/busybox/busybox_%=2Ebbappend
>@@ -5,7 +5,7 @@
> # when DISTRO =3D "mydistro" is defined in your conf/local=2Econf file=
=2E
> #
> # More details can be found in the Kernel Dev Manual
>-# http://www=2Eyoctoproject=2Eorg/docs/current/kernel-dev/kernel-dev=2Eh=
tml#changing-the-configuration
>+# https://www=2Eyoctoproject=2Eorg/docs/current/kernel-dev/kernel-dev=2E=
html#changing-the-configuration

Actually, this is outdated=2E We should link to https://docs=2Eyoctoprojec=
t=2Eorg=2E but that can be fixed in a later commit :)

> FILESEXTRAPATHS:prepend :=3D "${THISDIR}/${PN}:"
>=20
> SRC_URI:append:mydistro +=3D " \
>diff --git a/meta/classes/insane=2Ebbclass b/meta/classes/insane=2Ebbclas=
s
>index f2d2ca3689fd=2E=2Ebb6fb8145f9e 100644
>--- a/meta/classes/insane=2Ebbclass
>+++ b/meta/classes/insane=2Ebbclass
>@@ -1132,7 +1132,7 @@ python do_qa_patch() {
>     # Check patch=2Elog for fuzz warnings
>     #
>     # Further information on why we check for patch fuzz warnings:
>-    # http://lists=2Eopenembedded=2Eorg/pipermail/openembedded-core/2018=
-March/148675=2Ehtml
>+    # https://www=2Eopenembedded=2Eorg/pipermail/openembedded-core/2018-=
March/148675=2Ehtml
>     # https://bugzilla=2Eyoctoproject=2Eorg/show_bug=2Ecgi?id=3D10450
>     ####################################################################=
#######
>=20
>diff --git a/meta/classes/mirrors=2Ebbclass b/meta/classes/mirrors=2Ebbcl=
ass
>index ba325a658bc1=2E=2E90f5d6cf2cfa 100644
>--- a/meta/classes/mirrors=2Ebbclass
>+++ b/meta/classes/mirrors=2Ebbclass
>@@ -40,16 +40,16 @@ ${SAVANNAH_NONGNU_MIRROR} http://download-mirror=2Esa=
vannah=2Enongnu=2Eorg/releases \n
> ftp://sourceware=2Eorg/pub http://mirrors=2Ekernel=2Eorg/sourceware \n \
> ftp://sourceware=2Eorg/pub http://gd=2Etuwien=2Eac=2Eat/gnu/sourceware \=
n \
> ftp://sourceware=2Eorg/pub http://ftp=2Egwdg=2Ede/pub/linux/sources=2Ere=
dhat=2Ecom/sourceware \n \
>-cvs://=2E*/=2E*     http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-svn://=2E*/=2E*     http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-git://=2E*/=2E*     http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-hg://=2E*/=2E*      http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-bzr://=2E*/=2E*     http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-p4://=2E*/=2E*      http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-osc://=2E*/=2E*     http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-https?$://=2E*/=2E* http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-ftp://=2E*/=2E*     http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>-npm://=2E*/?=2E*    http://downloads=2Eyoctoproject=2Eorg/mirror/sources=
/ \n \
>+cvs://=2E*/=2E*     https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+svn://=2E*/=2E*     https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+git://=2E*/=2E*     https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+hg://=2E*/=2E*      https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+bzr://=2E*/=2E*     https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+p4://=2E*/=2E*      https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+osc://=2E*/=2E*     https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+https?$://=2E*/=2E* https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+ftp://=2E*/=2E*     https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
>+npm://=2E*/?=2E*    https://downloads=2Eyoctoproject=2Eorg/mirror/source=
s/ \n \
> cvs://=2E*/=2E*     http://sources=2Eopenembedded=2Eorg/ \n \
> svn://=2E*/=2E*     http://sources=2Eopenembedded=2Eorg/ \n \
> git://=2E*/=2E*     http://sources=2Eopenembedded=2Eorg/ \n \
>diff --git a/meta/classes/sstate=2Ebbclass b/meta/classes/sstate=2Ebbclas=
s
>index 7f4b1f6804cc=2E=2E5810d7b56674 100644
>--- a/meta/classes/sstate=2Ebbclass
>+++ b/meta/classes/sstate=2Ebbclass
>@@ -1112,7 +1112,7 @@ def setscene_depvalid(task, taskdependees, notneede=
d, d, log=3DNone):
>             # Allow excluding certain recursive dependencies=2E If a rec=
ipe needs it should add a
>             # specific dependency itself, rather than relying on one of =
its dependees to pull
>             # them in=2E
>-            # See also http://lists=2Eopenembedded=2Eorg/pipermail/opene=
mbedded-core/2018-January/146324=2Ehtml
>+            # See also https://www=2Eopenembedded=2Eorg/pipermail/openem=
bedded-core/2018-January/146324=2Ehtml
>             not_needed =3D False
>             excludedeps =3D d=2EgetVar('_SSTATE_EXCLUDEDEPS_SYSROOT')
>             if excludedeps is None:
>diff --git a/meta/classes/toaster=2Ebbclass b/meta/classes/toaster=2Ebbcl=
ass
>index dd5c7f224ba8=2E=2Eef987656d2a2 100644
>--- a/meta/classes/toaster=2Ebbclass
>+++ b/meta/classes/toaster=2Ebbclass
>@@ -69,7 +69,7 @@ python toaster_layerinfo_dumpdata() {
>=20
>         layer_info =3D {}
>         layer_name =3D layer_path=2Esplit('/')[-1]
>-        layer_url =3D 'http://layers=2Eopenembedded=2Eorg/layerindex/lay=
er/{layer}/'
>+        layer_url =3D 'https://layers=2Eopenembedded=2Eorg/layerindex/la=
yer/{layer}/'
>         layer_url_name =3D _get_url_map_name(layer_name)
>=20
>         layer_info['name'] =3D layer_url_name
>diff --git a/meta/conf/distro/include/maintainers=2Einc b/meta/conf/distr=
o/include/maintainers=2Einc
>index 8592de5a6682=2E=2Ef3d68a0ad0b4 100644
>--- a/meta/conf/distro/include/maintainers=2Einc
>+++ b/meta/conf/distro/include/maintainers=2Einc
>@@ -12,7 +12,7 @@
> # questions in the future), but please try to do the following first:
> #
> #  - look in the Yocto Project Bugzilla
>-#    (http://bugzilla=2Eyoctoproject=2Eorg/) to see if a problem has
>+#    (https://bugzilla=2Eyoctoproject=2Eorg/) to see if a problem has
> #    already been reported
> #
> # - look through recent entries of the appropriate mailing list archives
>diff --git a/meta/conf/distro/include/yocto-uninative=2Einc b/meta/conf/d=
istro/include/yocto-uninative=2Einc
>index 3165fc93b899=2E=2E8b0bfcb5cd0d 100644
>--- a/meta/conf/distro/include/yocto-uninative=2Einc
>+++ b/meta/conf/distro/include/yocto-uninative=2Einc
>@@ -8,7 +8,7 @@
>=20
> UNINATIVE_MAXGLIBCVERSION =3D "2=2E34"
>=20
>-UNINATIVE_URL ?=3D "http://downloads=2Eyoctoproject=2Eorg/releases/unina=
tive/3=2E4/"
>+UNINATIVE_URL ?=3D "https://downloads=2Eyoctoproject=2Eorg/releases/unin=
ative/3=2E4/"
> UNINATIVE_CHECKSUM[aarch64] ?=3D "3013cdda8f0dc6639ce1c80f33eabce66f06b8=
90bd5b58739a6d7a92a0bb7100"
> UNINATIVE_CHECKSUM[i686] ?=3D "abed500de584aad63ec237546db20cdd0c69d8870=
a6f8e94ac31721ace64b376"
> UNINATIVE_CHECKSUM[x86_64] ?=3D "126f4f7f6f21084ee140dac3eb4c536b9638378=
26b7c38599db0b512c3377ba2"
>diff --git a/meta/lib/oe/package_manager/__init__=2Epy b/meta/lib/oe/pack=
age_manager/__init__=2Epy
>index 8f7b60e07703=2E=2Ebf8fa115382a 100644
>--- a/meta/lib/oe/package_manager/__init__=2Epy
>+++ b/meta/lib/oe/package_manager/__init__=2Epy
>@@ -309,7 +309,7 @@ class PackageManager(object, metaclass=3DABCMeta):
>         """
>         Add remote package feeds into repository manager configuration=
=2E The parameters
>         for the feeds are set by feed_uris, feed_base_paths and feed_arc=
hs=2E
>-        See http://www=2Eyoctoproject=2Eorg/docs/current/ref-manual/ref-=
manual=2Ehtml#var-PACKAGE_FEED_URIS
>+        See https://www=2Eyoctoproject=2Eorg/docs/current/ref-manual/ref=
-manual=2Ehtml#var-PACKAGE_FEED_URIS

Ditto=2E

>         for their description=2E
>         """
>         pass
>diff --git a/meta/lib/oeqa/manual/toaster-managed-mode=2Ejson b/meta/lib/=
oeqa/manual/toaster-managed-mode=2Ejson
>index 1a71985c3c16=2E=2E17b0d81f7386 100644
>--- a/meta/lib/oeqa/manual/toaster-managed-mode=2Ejson
>+++ b/meta/lib/oeqa/manual/toaster-managed-mode=2Ejson
>@@ -2176,7 +2176,7 @@
>       ],
>       "execution": {
>         "1": {
>-          "action": "Clone the poky environment     git clone http://git=
=2Eyoctoproject=2Eorg/git/poky",
>+          "action": "Clone the poky environment     git clone https://gi=
t=2Eyoctoproject=2Eorg/git/poky",
>           "expected_results": ""
>         },
>         "2": {
>@@ -2458,7 +2458,7 @@
>       ],
>       "execution": {
>         "1": {
>-          "action": "Clone the poky environment     git clone http://git=
=2Eyoctoproject=2Eorg/git/poky",
>+          "action": "Clone the poky environment     git clone https://gi=
t=2Eyoctoproject=2Eorg/git/poky",
>           "expected_results": ""
>         },
>         "2": {
>@@ -2496,7 +2496,7 @@
>       ],
>       "execution": {
>         "1": {
>-          "action": "Clone the poky environment     git clone http://git=
=2Eyoctoproject=2Eorg/git/poky\n",
>+          "action": "Clone the poky environment     git clone https://gi=
t=2Eyoctoproject=2Eorg/git/poky\n",
>           "expected_results": ""
>         },
>         "2": {
>@@ -2513,7 +2513,7 @@
>         },
>         "5": {
>           "action": "Remove all the layers from the project",
>-          "expected_results": " you should see a message that reads:  \n=
\nYou need to add some layers=2E For that you can:  \n\n-View all layers co=
mpatible with this project  \n\n-Import a layer  \n\n-Read about layers in =
the documentation  \n\nOr type a layer name below=2E  \n\n\n The \"Choose f=
rom the layers compatible with this project\" link should go to the compati=
ble layers page The \"Import a layer\" link should go to the import layer p=
age The \"Read about layers in the documentation\" link should open in a ne=
w window and bring you to http://www=2Eyoctoproject=2Eorg/docs/current/dev-=
manual/dev-manual=2Ehtml#understanding-and-creating-layers"
>+          "expected_results": " you should see a message that reads:  \n=
\nYou need to add some layers=2E For that you can:  \n\n-View all layers co=
mpatible with this project  \n\n-Import a layer  \n\n-Read about layers in =
the documentation  \n\nOr type a layer name below=2E  \n\n\n The \"Choose f=
rom the layers compatible with this project\" link should go to the compati=
ble layers page The \"Import a layer\" link should go to the import layer p=
age The \"Read about layers in the documentation\" link should open in a ne=
w window and bring you to https://www=2Eyoctoproject=2Eorg/docs/current/dev=
-manual/dev-manual=2Ehtml#understanding-and-creating-layers"
>         }
>       },
>       "summary": "Verify_delete_layer_functionality"
>diff --git a/meta/lib/oeqa/runtime/cases/buildlzip=2Epy b/meta/lib/oeqa/r=
untime/cases/buildlzip=2Epy
>index bc70b4146121=2E=2E37afce5f713e 100644
>--- a/meta/lib/oeqa/runtime/cases/buildlzip=2Epy
>+++ b/meta/lib/oeqa/runtime/cases/buildlzip=2Epy
>@@ -12,7 +12,7 @@ class BuildLzipTest(OERuntimeTestCase):
>=20
>     @classmethod
>     def setUpClass(cls):
>-        uri =3D 'http://downloads=2Eyoctoproject=2Eorg/mirror/sources'
>+        uri =3D 'https://downloads=2Eyoctoproject=2Eorg/mirror/sources'
>         uri =3D '%s/lzip-1=2E19=2Etar=2Egz' % uri
>         cls=2Eproject =3D TargetBuildProject(cls=2Etc=2Etarget,
>                                          uri,
>diff --git a/meta/lib/oeqa/sdk/cases/buildlzip=2Epy b/meta/lib/oeqa/sdk/c=
ases/buildlzip=2Epy
>index 49ae756bf3c4=2E=2Ec1358b69d21d 100644
>--- a/meta/lib/oeqa/sdk/cases/buildlzip=2Epy
>+++ b/meta/lib/oeqa/sdk/cases/buildlzip=2Epy
>@@ -13,7 +13,7 @@ class BuildLzipTest(OESDKTestCase):
>     """
>     def test_lzip(self):
>         with tempfile=2ETemporaryDirectory(prefix=3D"lzip", dir=3Dself=
=2Etc=2Esdk_dir) as testdir:
>-            tarball =3D self=2Efetch(testdir, self=2Etd["DL_DIR"], "http=
://downloads=2Eyoctoproject=2Eorg/mirror/sources/lzip-1=2E19=2Etar=2Egz")
>+            tarball =3D self=2Efetch(testdir, self=2Etd["DL_DIR"], "http=
s://downloads=2Eyoctoproject=2Eorg/mirror/sources/lzip-1=2E19=2Etar=2Egz")
>=20
>             dirs =3D {}
>             dirs["source"] =3D os=2Epath=2Ejoin(testdir, "lzip-1=2E19")
>diff --git a/meta/lib/oeqa/selftest/cases/buildoptions=2Epy b/meta/lib/oe=
qa/selftest/cases/buildoptions=2Epy
>index f99881758e3a=2E=2E4dc0a3ae1c15 100644
>--- a/meta/lib/oeqa/selftest/cases/buildoptions=2Epy
>+++ b/meta/lib/oeqa/selftest/cases/buildoptions=2Epy
>@@ -206,17 +206,17 @@ DL_DIR =3D "${TMPDIR}/test_downloads"
> STAMPS_DIR =3D "${TMPDIR}/test_stamps"
> SSTATE_DIR =3D "${TMPDIR}/test_sstate-cache"
> PREMIRRORS =3D "\\
>-    bzr://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    cvs://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    git://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    gitsm://=2E*/=2E* http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    hg://=2E*/=2E*    http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    osc://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    p4://=2E*/=2E*    http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    svn://=2E*/=2E*   http://downloads=2Eyoctoproject=2Eorg/mirror/sourc=
es/ \\n \\
>-    ftp://=2E*/=2E*      http://downloads=2Eyoctoproject=2Eorg/mirror/so=
urces/ \\n \\
>-    http://=2E*/=2E*     http://downloads=2Eyoctoproject=2Eorg/mirror/so=
urces/ \\n \\
>-    https://=2E*/=2E*    http://downloads=2Eyoctoproject=2Eorg/mirror/so=
urces/ \\n"
>+    bzr://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    cvs://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    git://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    gitsm://=2E*/=2E* https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    hg://=2E*/=2E*    https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    osc://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    p4://=2E*/=2E*    https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    svn://=2E*/=2E*   https://downloads=2Eyoctoproject=2Eorg/mirror/sour=
ces/ \\n \\
>+    ftp://=2E*/=2E*      https://downloads=2Eyoctoproject=2Eorg/mirror/s=
ources/ \\n \\
>+    http://=2E*/=2E*     https://downloads=2Eyoctoproject=2Eorg/mirror/s=
ources/ \\n \\
>+    https://=2E*/=2E*    https://downloads=2Eyoctoproject=2Eorg/mirror/s=
ources/ \\n"
> """)
>=20
>         bitbake("world --runall fetch")
>diff --git a/meta/lib/oeqa/selftest/cases/devtool=2Epy b/meta/lib/oeqa/se=
lftest/cases/devtool=2Epy
>index f495e84c79b8=2E=2Eac9ebd601915 100644
>--- a/meta/lib/oeqa/selftest/cases/devtool=2Epy
>+++ b/meta/lib/oeqa/selftest/cases/devtool=2Epy
>@@ -269,7 +269,7 @@ class DevtoolAddTests(DevtoolBase):
>         self=2Etrack_for_cleanup(tempdir)
>         pn =3D 'pv'
>         pv =3D '1=2E5=2E3'
>-        url =3D 'http://downloads=2Eyoctoproject=2Eorg/mirror/sources/pv=
-1=2E5=2E3=2Etar=2Ebz2'
>+        url =3D 'https://downloads=2Eyoctoproject=2Eorg/mirror/sources/p=
v-1=2E5=2E3=2Etar=2Ebz2'
>         result =3D runCmd('wget %s' % url, cwd=3Dtempdir)
>         result =3D runCmd('tar xfv %s' % os=2Epath=2Ebasename(url), cwd=
=3Dtempdir)
>         srcdir =3D os=2Epath=2Ejoin(tempdir, '%s-%s' % (pn, pv))
>@@ -1788,7 +1788,7 @@ class DevtoolUpgradeTests(DevtoolBase):
>         recipename =3D 'i2c-tools'
>         recipever =3D '3=2E1=2E2'
>         recipefile =3D os=2Epath=2Ejoin(self=2Eworkspacedir, 'recipes', =
recipename, '%s_%s=2Ebb' % (recipename, recipever))
>-        url =3D 'http://downloads=2Eyoctoproject=2Eorg/mirror/sources/i2=
c-tools-%s=2Etar=2Ebz2' % recipever
>+        url =3D 'https://downloads=2Eyoctoproject=2Eorg/mirror/sources/i=
2c-tools-%s=2Etar=2Ebz2' % recipever
>         def add_recipe():
>             result =3D runCmd('devtool add %s' % url)
>             self=2EassertExists(recipefile, 'Expected recipe file not cr=
eated')
>diff --git a/meta/lib/oeqa/selftest/cases/fetch=2Epy b/meta/lib/oeqa/self=
test/cases/fetch=2Epy
>index 9aa91e59c13d=2E=2Ed9c1e17f7b62 100644
>--- a/meta/lib/oeqa/selftest/cases/fetch=2Epy
>+++ b/meta/lib/oeqa/selftest/cases/fetch=2Epy
>@@ -47,7 +47,7 @@ PREMIRRORS:forcevariable =3D ""
>         features =3D """
> DL_DIR =3D "%s"
> GIT_PROXY_COMMAND =3D "false"
>-MIRRORS:forcevariable =3D "git://=2E*/=2E* http://downloads=2Eyoctoproje=
ct=2Eorg/mirror/sources/"
>+MIRRORS:forcevariable =3D "git://=2E*/=2E* https://downloads=2Eyoctoproj=
ect=2Eorg/mirror/sources/"
> """ % dldir
>         self=2Ewrite_config(features)
>         oe=2Epath=2Eremove(dldir, recurse=3DTrue)
>diff --git a/meta/lib/oeqa/selftest/cases/recipetool=2Epy b/meta/lib/oeqa=
/selftest/cases/recipetool=2Epy
>index c2a53815d0ea=2E=2E1100971d9ded 100644
>--- a/meta/lib/oeqa/selftest/cases/recipetool=2Epy
>+++ b/meta/lib/oeqa/selftest/cases/recipetool=2Epy
>@@ -509,7 +509,7 @@ class RecipetoolTests(RecipetoolBase):
>         temprecipe =3D os=2Epath=2Ejoin(self=2Etempdir, 'recipe')
>         os=2Emakedirs(temprecipe)
>         recipefile =3D os=2Epath=2Ejoin(temprecipe, 'matchbox-terminal_g=
it=2Ebb')
>-        srcuri =3D 'http://git=2Eyoctoproject=2Eorg/git/matchbox-termina=
l'
>+        srcuri =3D 'https://git=2Eyoctoproject=2Eorg/git/matchbox-termin=
al'
>         result =3D runCmd('recipetool create -o %s %s' % (temprecipe, sr=
curi))
>         self=2EassertTrue(os=2Epath=2Eisfile(recipefile))
>         checkvars =3D {}
>diff --git a/meta/recipes-core/dbus-wait/dbus-wait_git=2Ebb b/meta/recipe=
s-core/dbus-wait/dbus-wait_git=2Ebb
>index 677768d35a35=2E=2E8f049cb417f8 100644
>--- a/meta/recipes-core/dbus-wait/dbus-wait_git=2Ebb
>+++ b/meta/recipes-core/dbus-wait/dbus-wait_git=2Ebb
>@@ -1,5 +1,5 @@
> SUMMARY =3D "A simple tool to wait for a specific signal over DBus"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/dbus-wait"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/dbus-wait=
"
> DESCRIPTION =3D "${SUMMARY}"
> SECTION =3D "base"
> LICENSE =3D "GPLv2"
>diff --git a/meta/recipes-core/images/build-appliance-image_15=2E0=2E0=2E=
bb b/meta/recipes-core/images/build-appliance-image_15=2E0=2E0=2Ebb
>index 86dc691297d1=2E=2Eebcef783aec8 100644
>--- a/meta/recipes-core/images/build-appliance-image_15=2E0=2E0=2Ebb
>+++ b/meta/recipes-core/images/build-appliance-image_15=2E0=2E0=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "An image containing the build system itself"
> DESCRIPTION =3D "An image containing the build system that you can boot =
and run using either VirtualBox, VMware Player or VMware Workstation=2E"
>-HOMEPAGE =3D "http://www=2Eyoctoproject=2Eorg/documentation/build-applia=
nce"
>+HOMEPAGE =3D "https://www=2Eyoctoproject=2Eorg/software-item/build-appli=
ance/"
>=20
> LICENSE =3D "MIT"
> LIC_FILES_CHKSUM =3D "file://${COREBASE}/meta/COPYING=2EMIT;md5=3D3da9cf=
bcb788c80a0384361b4de20420"
>diff --git a/meta/recipes-core/psplash/psplash_git=2Ebb b/meta/recipes-co=
re/psplash/psplash_git=2Ebb
>index 1be7ece79d98=2E=2E5c76aa993c60 100644
>--- a/meta/recipes-core/psplash/psplash_git=2Ebb
>+++ b/meta/recipes-core/psplash/psplash_git=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Userspace framebuffer boot logo based on usplash"
> DESCRIPTION =3D "PSplash is a userspace graphical boot splash screen for=
 mainly embedded Linux devices supporting a 16bpp or 32bpp framebuffer=2E I=
t has few dependencies (just libc), supports basic images and text and hand=
les rotation=2E Its visual look is configurable by basic source changes=2E =
Also included is a 'client' command utility for sending information to pspl=
ash such as boot progress information=2E"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/psplash"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/psplash"
> SECTION =3D "base"
> LICENSE =3D "GPLv2+"
> LIC_FILES_CHKSUM =3D "file://psplash=2Eh;beginline=3D1;endline=3D8;md5=
=3D8f232c1e95929eacab37f00900580224"
>diff --git a/meta/recipes-devtools/glide/glide_0=2E13=2E3=2Ebb b/meta/rec=
ipes-devtools/glide/glide_0=2E13=2E3=2Ebb
>index e943dc1762a5=2E=2E06bb717cbaf0 100644
>--- a/meta/recipes-devtools/glide/glide_0=2E13=2E3=2Ebb
>+++ b/meta/recipes-devtools/glide/glide_0=2E13=2E3=2Ebb
>@@ -20,12 +20,12 @@ RDEPENDS:${PN}-ptest +=3D "bash"
> BBCLASSEXTEND =3D "native nativesdk"
>=20
> # for x86 ends with textrel in ${PN}
>-# http://errors=2Eyoctoproject=2Eorg/Errors/Details/185631/
>+# https://errors=2Eyoctoproject=2Eorg/Errors/Details/185631/
> # ERROR: QA Issue: ELF binary '/work/i586-oe-linux/glide/0=2E13=2E1-r0/p=
ackages-split/glide/usr/bin/glide' has relocations in =2Etext [textrel]
> INSANE_SKIP:${PN} +=3D "textrel"
>=20
> # for aarch64 ends with textrel in ${PN}-ptest
>-# http://errors=2Eyoctoproject=2Eorg/Errors/Details/185633/
>+# https://errors=2Eyoctoproject=2Eorg/Errors/Details/185633/
> # ERROR: QA Issue: ELF binary '/work/aarch64-oe-linux/glide/0=2E13=2E1-r=
0/packages-split/glide-ptest/usr/lib/glide/ptest/github=2Ecom/Masterminds/g=
lide/glide=2Etest' has relocations in =2Etext
> # ELF binary '/work/aarch64-oe-linux/glide/0=2E13=2E1-r0/packages-split/=
glide-ptest/usr/lib/glide/ptest/github=2Ecom/Masterminds/glide/dependency/d=
ependency=2Etest' has relocations in =2Etext
> # ELF binary '/work/aarch64-oe-linux/glide/0=2E13=2E1-r0/packages-split/=
glide-ptest/usr/lib/glide/ptest/github=2Ecom/Masterminds/glide/repo/repo=2E=
test' has relocations in =2Etext
>diff --git a/meta/recipes-devtools/opkg-utils/opkg-utils_0=2E4=2E5=2Ebb b=
/meta/recipes-devtools/opkg-utils/opkg-utils_0=2E4=2E5=2Ebb
>index a2bcc7f66116=2E=2Ef056ae1c4323 100644
>--- a/meta/recipes-devtools/opkg-utils/opkg-utils_0=2E4=2E5=2Ebb
>+++ b/meta/recipes-devtools/opkg-utils/opkg-utils_0=2E4=2E5=2Ebb
>@@ -1,16 +1,16 @@
> SUMMARY =3D "Additional utilities for the opkg package manager"
> SUMMARY:update-alternatives-opkg =3D "Utility for managing the alternati=
ves system"
> SECTION =3D "base"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/opkg-utils=
"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/opkg-util=
s"
> LICENSE =3D "GPLv2+"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba36caa9b7df079bae=
19f \
>                     file://opkg=2Epy;beginline=3D2;endline=3D18;md5=3Dff=
a11ff3c15eb31c6a7ceaa00cc9f986"
> PROVIDES +=3D "${@bb=2Eutils=2Econtains('PACKAGECONFIG', 'update-alterna=
tives', 'virtual/update-alternatives', '', d)}"
>=20
>-SRC_URI =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/${BPN}/snap=
shot/${BPN}-${PV}=2Etar=2Egz \
>+SRC_URI =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/${BPN}/sna=
pshot/${BPN}-${PV}=2Etar=2Egz \
>            file://0001-update-alternatives-correctly-match-priority=2Epa=
tch \
>            "
>-UPSTREAM_CHECK_URI =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/=
opkg-utils/refs/"
>+UPSTREAM_CHECK_URI =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi=
/opkg-utils/refs/"
>=20
> SRC_URI[md5sum] =3D "025b19744e5c7fc1c8380e17df1fcc64"
> SRC_URI[sha256sum] =3D "528635e674addea5c2b3a3268404ad04a952c4f410d17c3d=
754f5dd5529770c9"
>diff --git a/meta/recipes-devtools/opkg/opkg_0=2E4=2E5=2Ebb b/meta/recipe=
s-devtools/opkg/opkg_0=2E4=2E5=2Ebb
>index ef18ccf63a84=2E=2Ee0a3206b3c5e 100644
>--- a/meta/recipes-devtools/opkg/opkg_0=2E4=2E5=2Ebb
>+++ b/meta/recipes-devtools/opkg/opkg_0=2E4=2E5=2Ebb
>@@ -12,7 +12,7 @@ DEPENDS =3D "libarchive"
>=20
> PE =3D "1"
>=20
>-SRC_URI =3D "http://downloads=2Eyoctoproject=2Eorg/releases/${BPN}/${BPN=
}-${PV}=2Etar=2Egz \
>+SRC_URI =3D "https://downloads=2Eyoctoproject=2Eorg/releases/${BPN}/${BP=
N}-${PV}=2Etar=2Egz \
>            file://opkg=2Econf \
>            file://0001-opkg_conf-create-opkg=2Elock-in-run-instead-of-va=
r-run=2Epatch \
>            file://run-ptest \
>diff --git a/meta/recipes-devtools/prelink/prelink_git=2Ebb b/meta/recipe=
s-devtools/prelink/prelink_git=2Ebb
>index 24713b61f847=2E=2E91605494f874 100644
>--- a/meta/recipes-devtools/prelink/prelink_git=2Ebb
>+++ b/meta/recipes-devtools/prelink/prelink_git=2Ebb
>@@ -3,7 +3,7 @@ SECTION =3D "devel"
> # Would need transfig-native for documentation if it wasn't disabled
> DEPENDS =3D "elfutils binutils"
> SUMMARY =3D "An ELF prelinking utility"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/prelink-cross/a=
bout/"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/prelink-cross/=
about/"
> DESCRIPTION =3D "The prelink package contains a utility which modifies E=
LF shared libraries \
> and executables, so that far fewer relocations need to be resolved at \
> runtime and thus programs come up faster=2E"
>@@ -49,7 +49,7 @@ inherit autotools
> BBCLASSEXTEND =3D "native"
>=20
> EXTRA_OECONF =3D "--with-pkgversion=3D${PV}-${PR} \
>-	--with-bugurl=3Dhttp://bugzilla=2Eyoctoproject=2Eorg/"
>+	--with-bugurl=3Dhttps://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> PACKAGECONFIG ??=3D ""
> PACKAGECONFIG[selinux] =3D "--enable-selinux,--disable-selinux,libselinu=
x"
>diff --git a/meta/recipes-devtools/pseudo/files/build-oldlibc b/meta/reci=
pes-devtools/pseudo/files/build-oldlibc
>index 85c438de4e02=2E=2E2f8a527e53fa 100755
>--- a/meta/recipes-devtools/pseudo/files/build-oldlibc
>+++ b/meta/recipes-devtools/pseudo/files/build-oldlibc
>@@ -9,7 +9,7 @@
>=20
> for i in x86_64 aarch64 i686; do
>     if [ ! -e $i-nativesdk-libc=2Etar=2Exz ]; then
>-        wget http://downloads=2Eyoctoproject=2Eorg/releases/uninative/3=
=2E2/$i-nativesdk-libc=2Etar=2Exz
>+        wget https://downloads=2Eyoctoproject=2Eorg/releases/uninative/3=
=2E2/$i-nativesdk-libc=2Etar=2Exz
>     fi
>     tar -xf $i-nativesdk-libc=2Etar=2Exz --wildcards \*/lib/libpthread\*=
 \*/lib/libdl\*
>     cd $i-linux/lib
>diff --git a/meta/recipes-devtools/pseudo/pseudo=2Einc b/meta/recipes-dev=
tools/pseudo/pseudo=2Einc
>index 7ba414ca25d8=2E=2Eda5b254f092f 100644
>--- a/meta/recipes-devtools/pseudo/pseudo=2Einc
>+++ b/meta/recipes-devtools/pseudo/pseudo=2Einc
>@@ -3,7 +3,7 @@
> # BBFETCH2=3DTrue PSEUDO_BUILD=3D1 =2E=2E/bitbake/bin/bitbake pseudo-nat=
ive [-c CMD]
>=20
> SUMMARY =3D "Pseudo gives fake root capabilities to a normal user"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/pseudo"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/pseudo"
> DESCRIPTION =3D "The pseudo utility offers a way to run commands in a vi=
rtualized root environment=2E"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Da1d8023a6f953ac6ea4af765ff62d=
574"
> SECTION =3D "base"
>diff --git a/meta/recipes-devtools/pseudo/pseudo_git=2Ebb b/meta/recipes-=
devtools/pseudo/pseudo_git=2Ebb
>index 7acb1d64d59a=2E=2E1983ac48a04a 100644
>--- a/meta/recipes-devtools/pseudo/pseudo_git=2Ebb
>+++ b/meta/recipes-devtools/pseudo/pseudo_git=2Ebb
>@@ -6,10 +6,10 @@ SRC_URI =3D "git://git=2Eyoctoproject=2Eorg/pseudo;bran=
ch=3Doe-core \
>            file://fallback-group \
>            "
> SRC_URI:append:class-native =3D " \
>-    http://downloads=2Eyoctoproject=2Eorg/mirror/sources/pseudo-prebuilt=
-2=2E33=2Etar=2Exz;subdir=3Dgit/prebuilt;name=3Dprebuilt \
>+    https://downloads=2Eyoctoproject=2Eorg/mirror/sources/pseudo-prebuil=
t-2=2E33=2Etar=2Exz;subdir=3Dgit/prebuilt;name=3Dprebuilt \
>     file://older-glibc-symbols=2Epatch"
> SRC_URI:append:class-nativesdk =3D " \
>-    http://downloads=2Eyoctoproject=2Eorg/mirror/sources/pseudo-prebuilt=
-2=2E33=2Etar=2Exz;subdir=3Dgit/prebuilt;name=3Dprebuilt \
>+    https://downloads=2Eyoctoproject=2Eorg/mirror/sources/pseudo-prebuil=
t-2=2E33=2Etar=2Exz;subdir=3Dgit/prebuilt;name=3Dprebuilt \
>     file://older-glibc-symbols=2Epatch"
> SRC_URI[prebuilt=2Esha256sum] =3D "ed9f456856e9d86359f169f46a70ad7be4190=
d6040282b84c8d97b99072485aa"
>=20
>diff --git a/meta/recipes-devtools/python/python3/0001-setup=2Epy-pass-mi=
ssing-libraries-to-Extension-for-mul=2Epatch b/meta/recipes-devtools/python=
/python3/0001-setup=2Epy-pass-missing-libraries-to-Extension-for-mul=2Epatc=
h
>index ea0af02e7204=2E=2Ecf1d60be33a6 100644
>--- a/meta/recipes-devtools/python/python3/0001-setup=2Epy-pass-missing-l=
ibraries-to-Extension-for-mul=2Epatch
>+++ b/meta/recipes-devtools/python/python3/0001-setup=2Epy-pass-missing-l=
ibraries-to-Extension-for-mul=2Epatch
>@@ -26,7 +26,7 @@ and `__old_sem_getvalue' is to compat the old version
> sem_getvalue@GLIBC_2=2E0=2E
>=20
> To build python for embedded Linux systems:
>-http://www=2Eyoctoproject=2Eorg/docs/2=2E3=2E1/yocto-project-qs/yocto-pr=
oject-qs=2Ehtml
>+https://www=2Eyoctoproject=2Eorg/docs/2=2E3=2E1/yocto-project-qs/yocto-p=
roject-qs=2Ehtml

Ditto=2E

> If not explicitly link to library pthread (-lpthread), it will
> load glibc's sem_getvalue randomly at runtime=2E
>=20
>diff --git a/meta/recipes-devtools/valgrind/valgrind/0001-Remove-tests-th=
at-fail-to-build-on-some-PPC32-config=2Epatch b/meta/recipes-devtools/valgr=
ind/valgrind/0001-Remove-tests-that-fail-to-build-on-some-PPC32-config=2Epa=
tch
>index a78e1953ff55=2E=2Efbeda93cc279 100644
>--- a/meta/recipes-devtools/valgrind/valgrind/0001-Remove-tests-that-fail=
-to-build-on-some-PPC32-config=2Epatch
>+++ b/meta/recipes-devtools/valgrind/valgrind/0001-Remove-tests-that-fail=
-to-build-on-some-PPC32-config=2Epatch
>@@ -4,7 +4,7 @@ Date: Fri, 8 Jan 2016 16:36:29 +0200
> Subject: [PATCH] Remove tests that fail to build on some PPC32 configura=
tions
>=20
> Failures are documented here:
>-http://errors=2Eyoctoproject=2Eorg/Errors/Search/?items=3D10&query=3D862=
d702fbb99e484631315aa44b9e46f8fc567da&filter=3Dvalgrind&type=3Drecipe
>+https://errors=2Eyoctoproject=2Eorg/Errors/Search/?items=3D10&query=3D86=
2d702fbb99e484631315aa44b9e46f8fc567da&filter=3Dvalgrind&type=3Drecipe
>=20
> Signed-off-by: Alexander Kanavin <alex=2Ekanavin@gmail=2Ecom>
> Upstream-Status: Pending
>diff --git a/meta/recipes-gnome/gcr/gcr_3=2E40=2E0=2Ebb b/meta/recipes-gn=
ome/gcr/gcr_3=2E40=2E0=2Ebb
>index a05e753ee94b=2E=2Ec439185d11bb 100644
>--- a/meta/recipes-gnome/gcr/gcr_3=2E40=2E0=2Ebb
>+++ b/meta/recipes-gnome/gcr/gcr_3=2E40=2E0=2Ebb
>@@ -29,7 +29,7 @@ FILES:${PN} +=3D " \
>     ${datadir}/gcr-3 \
> "
>=20
>-# http://errors=2Eyoctoproject=2Eorg/Errors/Details/20229/
>+# https://errors=2Eyoctoproject=2Eorg/Errors/Details/20229/
> ARM_INSTRUCTION_SET:armv4 =3D "arm"
> ARM_INSTRUCTION_SET:armv5 =3D "arm"
> ARM_INSTRUCTION_SET:armv6 =3D "arm"
>diff --git a/meta/recipes-gnome/libsecret/libsecret_0=2E20=2E4=2Ebb b/met=
a/recipes-gnome/libsecret/libsecret_0=2E20=2E4=2Ebb
>index 9c1f97b8f840=2E=2E93344e89368d 100644
>--- a/meta/recipes-gnome/libsecret/libsecret_0=2E20=2E4=2Ebb
>+++ b/meta/recipes-gnome/libsecret/libsecret_0=2E20=2E4=2Ebb
>@@ -22,7 +22,7 @@ GTKDOC_MESON_OPTION =3D 'gtk_doc'
>=20
> PACKAGECONFIG[manpages] =3D "-Dmanpage=3Dtrue,-Dmanpage=3Dfalse,libxslt-=
native xmlto-native"
>=20
>-# http://errors=2Eyoctoproject=2Eorg/Errors/Details/20228/
>+# https://errors=2Eyoctoproject=2Eorg/Errors/Details/20228/
> ARM_INSTRUCTION_SET:armv4 =3D "arm"
> ARM_INSTRUCTION_SET:armv5 =3D "arm"
> ARM_INSTRUCTION_SET:armv6 =3D "arm"
>diff --git a/meta/recipes-graphics/libfakekey/libfakekey_git=2Ebb b/meta/=
recipes-graphics/libfakekey/libfakekey_git=2Ebb
>index ab6f5ac9ed22=2E=2E45058a161719 100644
>--- a/meta/recipes-graphics/libfakekey/libfakekey_git=2Ebb
>+++ b/meta/recipes-graphics/libfakekey/libfakekey_git=2Ebb
>@@ -2,7 +2,7 @@ SUMMARY =3D "Library for converting characters to X key-p=
resses"
> DESCRIPTION =3D "libfakekey is a simple library for converting UTF-8 cha=
racters into 'fake' X \
> key-presses=2E"
> HOMEPAGE =3D "http://matchbox-project=2Eorg/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "LGPLv2+"
> LIC_FILES_CHKSUM =3D "file://src/libfakekey=2Ec;endline=3D30;md5=3D602b5=
ccd48f64407510867f3373b448c"
>diff --git a/meta/recipes-graphics/matchbox-session/matchbox-session_0=2E=
1=2Ebb b/meta/recipes-graphics/matchbox-session/matchbox-session_0=2E1=2Ebb
>index 53229f2edcab=2E=2Ecdb872442346 100644
>--- a/meta/recipes-graphics/matchbox-session/matchbox-session_0=2E1=2Ebb
>+++ b/meta/recipes-graphics/matchbox-session/matchbox-session_0=2E1=2Ebb
>@@ -1,7 +1,7 @@
> SUMMARY =3D "Custom Matchbox session files"
> DESCRIPTION =3D "Very simple session manager for matchbox tools"
> HOMEPAGE =3D "http://www=2Ematchbox-project=2Eorg/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2"
> LIC_FILES_CHKSUM =3D "file://matchbox-session;endline=3D20;md5=3D180f1c1=
69a15d059a56c30094f6fb5ea"
>diff --git a/meta/recipes-graphics/matchbox-wm/matchbox-wm_1=2E2=2E2=2Ebb=
 b/meta/recipes-graphics/matchbox-wm/matchbox-wm_1=2E2=2E2=2Ebb
>index 95a0604aeea6=2E=2Eb009754c3b00 100644
>--- a/meta/recipes-graphics/matchbox-wm/matchbox-wm_1=2E2=2E2=2Ebb
>+++ b/meta/recipes-graphics/matchbox-wm/matchbox-wm_1=2E2=2E2=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Matchbox lightweight window manager"
> HOMEPAGE =3D "http://matchbox-project=2Eorg"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2+"
> LIC_FILES_CHKSUM =3D "file://src/wm=2Eh;endline=3D21;md5=3Da7e844465edbc=
f79c282369f93caa835 \
>diff --git a/meta/recipes-graphics/mini-x-session/mini-x-session_0=2E1=2E=
bb b/meta/recipes-graphics/mini-x-session/mini-x-session_0=2E1=2Ebb
>index 470a5e9ea904=2E=2Ee50f291a61aa 100644
>--- a/meta/recipes-graphics/mini-x-session/mini-x-session_0=2E1=2Ebb
>+++ b/meta/recipes-graphics/mini-x-session/mini-x-session_0=2E1=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Very simple session manager for X"
> DESCRIPTION =3D "Simple session manager for X, that provides just the ri=
ght boilerplate to create a session and launch the browser "
>-HOMEPAGE =3D "http://www=2Eyoctoproject=2Eorg"
>+HOMEPAGE =3D "https://www=2Eyoctoproject=2Eorg"
> BUGTRACKER =3D "http://bugzilla=2Epokylinux=2Eorg"
>=20
> PR =3D "r4"
>diff --git a/meta/recipes-graphics/xcursor-transparent-theme/xcursor-tran=
sparent-theme_git=2Ebb b/meta/recipes-graphics/xcursor-transparent-theme/xc=
ursor-transparent-theme_git=2Ebb
>index f484f537c1a5=2E=2Ed6d9c265922b 100644
>--- a/meta/recipes-graphics/xcursor-transparent-theme/xcursor-transparent=
-theme_git=2Ebb
>+++ b/meta/recipes-graphics/xcursor-transparent-theme/xcursor-transparent=
-theme_git=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Transparent X11 cursor theme for touchscreens"
> HOMEPAGE =3D "http://www=2Ematchbox-project=2Eorg/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba36caa9b7df079bae=
19f"
>diff --git a/meta/recipes-graphics/xorg-lib/pixman/0001-ARM-qemu-related-=
workarounds-in-cpu-features-detecti=2Epatch b/meta/recipes-graphics/xorg-li=
b/pixman/0001-ARM-qemu-related-workarounds-in-cpu-features-detecti=2Epatch
>index 4569dca01e22=2E=2E04417fe46129 100644
>--- a/meta/recipes-graphics/xorg-lib/pixman/0001-ARM-qemu-related-workaro=
unds-in-cpu-features-detecti=2Epatch
>+++ b/meta/recipes-graphics/xorg-lib/pixman/0001-ARM-qemu-related-workaro=
unds-in-cpu-features-detecti=2Epatch
>@@ -10,7 +10,7 @@ Content-Transfer-Encoding: 8bit
> This was ported from meta-oe's patch [1]=2E The original pixman patch is=
 found
> at [2]=2E
>=20
>-[1] http://cgit=2Eopenembedded=2Eorg/meta-openembedded/tree/meta-oe/reci=
pes-graphics/xorg-lib/pixman-0=2E26=2E2/0001-ARM-qemu-related-workarounds-i=
n-cpu-features-detecti=2Epatch
>+[1] https://cgit=2Eopenembedded=2Eorg/meta-openembedded/tree/meta-oe/rec=
ipes-graphics/xorg-lib/pixman-0=2E26=2E2/0001-ARM-qemu-related-workarounds-=
in-cpu-features-detecti=2Epatch
> [2] http://lists=2Efreedesktop=2Eorg/archives/pixman/2011-January/000906=
=2Ehtml
>=20
> Upstream-Status: Inappropriate [other] qemu fix
>diff --git a/meta/recipes-graphics/xrestop/xrestop_0=2E4=2Ebb b/meta/reci=
pes-graphics/xrestop/xrestop_0=2E4=2Ebb
>index c7b8716f6f6a=2E=2E8bd02e23d14b 100644
>--- a/meta/recipes-graphics/xrestop/xrestop_0=2E4=2Ebb
>+++ b/meta/recipes-graphics/xrestop/xrestop_0=2E4=2Ebb
>@@ -14,7 +14,7 @@ PR =3D "r3"
>=20
> DEPENDS =3D "libxres libxext virtual/libx11 ncurses"
>=20
>-SRC_URI =3D "http://downloads=2Eyoctoproject=2Eorg/releases/xrestop/xres=
top-${PV}=2Etar=2Egz"
>+SRC_URI =3D "https://downloads=2Eyoctoproject=2Eorg/releases/xrestop/xre=
stop-${PV}=2Etar=2Egz"
>=20
> SRC_URI[md5sum] =3D "d8a54596cbaf037e62b80c4585a3ca9b"
> SRC_URI[sha256sum] =3D "67c2fc94a7ecedbaae0d1837e82e93d1d98f4a6d75982886=
0e552119af3ce257"
>diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1=2E0/0001-gst-gs=
tpluginloader=2Ec-when-env-var-is-set-do-not-fal=2Epatch b/meta/recipes-mul=
timedia/gstreamer/gstreamer1=2E0/0001-gst-gstpluginloader=2Ec-when-env-var-=
is-set-do-not-fal=2Epatch
>index 23ebd5c6005f=2E=2E95d488c6c476 100644
>--- a/meta/recipes-multimedia/gstreamer/gstreamer1=2E0/0001-gst-gstplugin=
loader=2Ec-when-env-var-is-set-do-not-fal=2Epatch
>+++ b/meta/recipes-multimedia/gstreamer/gstreamer1=2E0/0001-gst-gstplugin=
loader=2Ec-when-env-var-is-set-do-not-fal=2Epatch
>@@ -10,7 +10,7 @@ Falling through to the one installed on the system is p=
roblamatic in cross-compi
> environemnts, regardless of whether one pointed to by the env var succee=
ded or failed=2E
>=20
> taken from:
>-http://cgit=2Eopenembedded=2Eorg/openembedded-core/commit/meta/recipes-m=
ultimedia/gstreamer/gstreamer1=2E0/0001-gst-gstpluginloader=2Ec-when-env-va=
r-is-set-do-not-fal=2Epatch?id=3D0db7ba34ca41b107042306d13a6f0162885c123b
>+https://cgit=2Eopenembedded=2Eorg/openembedded-core/commit/meta/recipes-=
multimedia/gstreamer/gstreamer1=2E0/0001-gst-gstpluginloader=2Ec-when-env-v=
ar-is-set-do-not-fal=2Epatch?id=3D0db7ba34ca41b107042306d13a6f0162885c123b
>=20
> Part-of: <https://gitlab=2Efreedesktop=2Eorg/gstreamer/gstreamer/-/merge=
_requests/669>
>=20
>diff --git a/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0=
=2E2=2Ebb b/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0=2E2=
=2Ebb
>index d5fe9b5dceae=2E=2E268979f3d44f 100644
>--- a/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0=2E2=2Eb=
b
>+++ b/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0=2E2=2Eb=
b
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Matchbox GTK+ theme configuration application"
> HOMEPAGE =3D "http://matchbox-project=2Eorg"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2+"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba36caa9b7df079bae=
19f \
>diff --git a/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2=2E2=2E=
bb b/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2=2E2=2Ebb
>index 79ccb0391b0e=2E=2E74bf45f4837f 100644
>--- a/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2=2E2=2Ebb
>+++ b/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2=2E2=2Ebb
>@@ -1,7 +1,7 @@
> SUMMARY =3D "Matchbox Window Manager Desktop"
> DESCRIPTION =3D "A lightweight windows manager for embedded systems=2E I=
t uses the desktop background to provide an application launcher and allows=
 modules to be loaded for additional functionality=2E"
> HOMEPAGE =3D "http://matchbox-project=2Eorg/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2+ & LGPLv2+"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba36caa9b7df079bae=
19f \
>diff --git a/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0=2E1=
=2E1=2Ebb b/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0=2E1=2E1=
=2Ebb
>index a87841181463=2E=2E8fb38189484e 100644
>--- a/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0=2E1=2E1=2Eb=
b
>+++ b/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0=2E1=2E1=2Eb=
b
>@@ -1,7 +1,7 @@
> SUMMARY =3D "Matchbox virtual keyboard for X11"
> DESCRIPTION =3D "An on screen 'virtual' or 'software' keyboard=2E"
> HOMEPAGE =3D "http://matchbox-project=2Eorg"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
> SECTION =3D "x11"
>=20
> LICENSE =3D "LGPLv2=2E1"
>diff --git a/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2=2E11=
=2Ebb b/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2=2E11=2Ebb
>index c6de14e34eb4=2E=2E1f851e52d251 100644
>--- a/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2=2E11=2Ebb
>+++ b/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2=2E11=2Ebb
>@@ -2,7 +2,7 @@ SUMMARY =3D "Simple GTK+ based panel for handheld devices=
"
> DESCRIPTION =3D "A flexible always present 'window bar' for holding appl=
ication \
> launchers and small 'applet' style applications"
> HOMEPAGE =3D "http://matchbox-project=2Eorg"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2+"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba36caa9b7df079bae=
19f \
>diff --git a/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0=2E1=
=2Ebb b/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0=2E1=2Ebb
>index 7af11c2f5082=2E=2E8f12268da2e6 100644
>--- a/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0=2E1=2Ebb
>+++ b/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0=2E1=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Custom Matchbox session files for the Sato environment"
> HOMEPAGE =3D "http://www=2Ematchbox-project=2Eorg/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2=2E0+"
> LIC_FILES_CHKSUM =3D "file://session;endline=3D3;md5=3Df8a5c5b9c279e52dc=
094d10e11c2be63"
>diff --git a/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0=2E2=
=2Ebb b/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0=2E2=2Ebb
>index 9f00281ddec5=2E=2E04c00c7d67d2 100644
>--- a/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0=2E2=2Ebb
>+++ b/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0=2E2=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Lightweight GTK+ terminal application"
> HOMEPAGE =3D "http://www=2Ematchbox-project=2Eorg/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2+"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba36caa9b7df079bae=
19f \
>diff --git a/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato=2E=
inc b/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato=2Einc
>index bd680111d95d=2E=2E772669f3c0b8 100644
>--- a/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato=2Einc
>+++ b/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato=2Einc
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Matchbox window manager Sato themes"
> HOMEPAGE =3D "http://www=2Ematchbox-project=2Eorg/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "CC-BY-SA-3=2E0"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Daae86bb34b0a83716ca09f4e783d6=
ba4"
>diff --git a/meta/recipes-sato/sato-screenshot/sato-screenshot_0=2E3=2Ebb=
 b/meta/recipes-sato/sato-screenshot/sato-screenshot_0=2E3=2Ebb
>index b2913b4ed5cd=2E=2E6b03a2444a93 100644
>--- a/meta/recipes-sato/sato-screenshot/sato-screenshot_0=2E3=2Ebb
>+++ b/meta/recipes-sato/sato-screenshot/sato-screenshot_0=2E3=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Ultra-simple screen capture utility, aimed at handheld devi=
ces"
> HOMEPAGE =3D "http://www=2Eo-hand=2Ecom"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
>=20
> LICENSE =3D "GPLv2 & GPLv2+"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D94d55d512a9ba36caa9b7df079bae=
19f \
>diff --git a/meta/recipes-sato/settings-daemon/settings-daemon_0=2E0=2E2=
=2Ebb b/meta/recipes-sato/settings-daemon/settings-daemon_0=2E0=2E2=2Ebb
>index 742364f699c2=2E=2Ee87a0716707a 100644
>--- a/meta/recipes-sato/settings-daemon/settings-daemon_0=2E0=2E2=2Ebb
>+++ b/meta/recipes-sato/settings-daemon/settings-daemon_0=2E0=2E2=2Ebb
>@@ -1,6 +1,6 @@
> SUMMARY =3D "Provides a bridge between gconf and xsettings"
> HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/xsettings=
-daemon/"
>-BUGTRACKER =3D "http://bugzilla=2Eyoctoproject=2Eorg/"
>+BUGTRACKER =3D "https://bugzilla=2Eyoctoproject=2Eorg/"
> LICENSE =3D "MIT-style"
> LIC_FILES_CHKSUM =3D "file://xsettings-manager=2Eh;endline=3D22;md5=3D7c=
fac9d2d4dc3694cc7eb605cf32a69b \
>                     file://xsettings-common=2Eh;endline=3D22;md5=3D7cfac=
9d2d4dc3694cc7eb605cf32a69b"
>diff --git a/meta/recipes-sato/webkit/webkitgtk_2=2E32=2E3=2Ebb b/meta/re=
cipes-sato/webkit/webkitgtk_2=2E32=2E3=2Ebb
>index 1f3f7a9c00a4=2E=2E9675ebdc4f41 100644
>--- a/meta/recipes-sato/webkit/webkitgtk_2=2E32=2E3=2Ebb
>+++ b/meta/recipes-sato/webkit/webkitgtk_2=2E32=2E3=2Ebb
>@@ -116,7 +116,7 @@ FILES:${PN} +=3D "${libdir}/webkit2gtk-4=2E0/injected=
-bundle/libwebkit2gtkinjectedbu
>=20
> RRECOMMENDS:${PN} +=3D "ca-certificates shared-mime-info"
>=20
>-# http://errors=2Eyoctoproject=2Eorg/Errors/Details/20370/
>+# https://errors=2Eyoctoproject=2Eorg/Errors/Details/20370/
> ARM_INSTRUCTION_SET:armv4 =3D "arm"
> ARM_INSTRUCTION_SET:armv5 =3D "arm"
> ARM_INSTRUCTION_SET:armv6 =3D "arm"
>diff --git a/meta/recipes-support/icu/icu_69=2E1=2Ebb b/meta/recipes-supp=
ort/icu/icu_69=2E1=2Ebb
>index 4daf0fe82e2f=2E=2E7934db65a6ed 100644
>--- a/meta/recipes-support/icu/icu_69=2E1=2Ebb
>+++ b/meta/recipes-support/icu/icu_69=2E1=2Ebb
>@@ -96,7 +96,7 @@ def icu_download_folder(d):
> ICU_PV =3D "${@icu_download_version(d)}"
> ICU_FOLDER =3D "${@icu_download_folder(d)}"
>=20
>-# http://errors=2Eyoctoproject=2Eorg/Errors/Details/20486/
>+# https://errors=2Eyoctoproject=2Eorg/Errors/Details/20486/
> ARM_INSTRUCTION_SET:armv4 =3D "arm"
> ARM_INSTRUCTION_SET:armv5 =3D "arm"
>=20
>diff --git a/meta/recipes-support/libunwind/libunwind_1=2E5=2E0=2Ebb b/me=
ta/recipes-support/libunwind/libunwind_1=2E5=2E0=2Ebb
>index 9b515b58f47d=2E=2E8804c2988201 100644
>--- a/meta/recipes-support/libunwind/libunwind_1=2E5=2E0=2Ebb
>+++ b/meta/recipes-support/libunwind/libunwind_1=2E5=2E0=2Ebb
>@@ -15,7 +15,7 @@ SRC_URI[sha256sum] =3D "90337653d92d4a13de590781371c604=
f9031cdb50520366aa1e3a91e1e
>=20
> EXTRA_OECONF:append:libc-musl =3D " --disable-documentation --disable-te=
sts --enable-static"
>=20
>-# http://errors=2Eyoctoproject=2Eorg/Errors/Details/20487/
>+# https://errors=2Eyoctoproject=2Eorg/Errors/Details/20487/
> ARM_INSTRUCTION_SET:armv4 =3D "arm"
> ARM_INSTRUCTION_SET:armv5 =3D "arm"
>=20
>diff --git a/meta/recipes-support/ptest-runner/ptest-runner_2=2E4=2E2=2Eb=
b b/meta/recipes-support/ptest-runner/ptest-runner_2=2E4=2E2=2Ebb
>index 1d3c24a17763=2E=2E90a76ef84045 100644
>--- a/meta/recipes-support/ptest-runner/ptest-runner_2=2E4=2E2=2Ebb
>+++ b/meta/recipes-support/ptest-runner/ptest-runner_2=2E4=2E2=2Ebb
>@@ -2,7 +2,7 @@ SUMMARY =3D "A C program to run all installed ptests"
> DESCRIPTION =3D "The ptest-runner2 package installs a ptest-runner \
> program which loops through all installed ptest test suites and \
> runs them in sequence=2E"
>-HOMEPAGE =3D "http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/ptest-runn=
er2/about/"
>+HOMEPAGE =3D "https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/ptest-run=
ner2/about/"
>=20
> LICENSE =3D "GPLv2+"
> LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D751419260aa954499f7abaabaa882=
bbe"
>diff --git a/scripts/autobuilder-worker-prereq-tests b/scripts/autobuilde=
r-worker-prereq-tests
>index 5d7e6e260130=2E=2E2a7d8d43ecdd 100755
>--- a/scripts/autobuilder-worker-prereq-tests
>+++ b/scripts/autobuilder-worker-prereq-tests
>@@ -49,13 +49,13 @@ fi
> mkdir -p tmp/deploy/images/qemux86-64
> pushd tmp/deploy/images/qemux86-64
> if [ ! -e core-image-minimal-qemux86-64=2Eext4 ]; then
>-    wget http://downloads=2Eyoctoproject=2Eorg/releases/yocto/yocto-2=2E=
5=2E1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64=2Eext4
>+    wget https://downloads=2Eyoctoproject=2Eorg/releases/yocto/yocto-2=
=2E5=2E1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64=2Eext4

Should/can this be updated?

> fi
> if [ ! -e core-image-minimal-qemux86-64=2Eqemuboot=2Econf ]; then
>-    wget http://downloads=2Eyoctoproject=2Eorg/releases/yocto/yocto-2=2E=
5=2E1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64=2Eqemuboot=2Ec=
onf
>+    wget https://downloads=2Eyoctoproject=2Eorg/releases/yocto/yocto-2=
=2E5=2E1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64=2Eqemuboot=
=2Econf

Ditto=2E

> fi
> if [ ! -e bzImage-qemux86-64=2Ebin ]; then
>-    wget http://downloads=2Eyoctoproject=2Eorg/releases/yocto/yocto-2=2E=
5=2E1/machines/qemu/qemux86-64/bzImage-qemux86-64=2Ebin
>+    wget https://downloads=2Eyoctoproject=2Eorg/releases/yocto/yocto-2=
=2E5=2E1/machines/qemu/qemux86-64/bzImage-qemux86-64=2Ebin

Ditto=2E

> fi
> popd
> bitbake qemu-helper-native
>diff --git a/scripts/create-pull-request b/scripts/create-pull-request
>index 8eefcf63a561=2E=2E6a9da7113b14 100755
>--- a/scripts/create-pull-request
>+++ b/scripts/create-pull-request
>@@ -149,13 +149,13 @@ fi
> WEB_URL=3D""
> case "$REMOTE_URL" in
> 	*git=2Eyoctoproject=2Eorg*)
>-		WEB_URL=3D"http://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/$REMOTE_REPO/log=
/?h=3D$BRANCH"
>+		WEB_URL=3D"https://git=2Eyoctoproject=2Eorg/cgit=2Ecgi/$REMOTE_REPO/lo=
g/?h=3D$BRANCH"
> 		;;
> 	*git=2Epokylinux=2Eorg*)
> 		WEB_URL=3D"http://git=2Epokylinux=2Eorg/cgit=2Ecgi/$REMOTE_REPO/log/?h=
=3D$BRANCH"
> 		;;
> 	*git=2Eopenembedded=2Eorg*)
>-		WEB_URL=3D"http://cgit=2Eopenembedded=2Eorg/$REMOTE_REPO/log/?h=3D$BRA=
NCH"
>+		WEB_URL=3D"https://cgit=2Eopenembedded=2Eorg/$REMOTE_REPO/log/?h=3D$BR=
ANCH"
> 		;;
> 	*github=2Ecom*)
> 		WEB_URL=3D"https://github=2Ecom/$REMOTE_REPO/tree/$BRANCH"
>diff --git a/scripts/install-buildtools b/scripts/install-buildtools
>index 8554a5db6791=2E=2E44c77cb11131 100755
>--- a/scripts/install-buildtools
>+++ b/scripts/install-buildtools
>@@ -11,11 +11,11 @@
> #  Example usage (extended buildtools from milestone):
> #    (1) using --url and --filename
> #        $ install-buildtools \
>-#          --url http://downloads=2Eyoctoproject=2Eorg/releases/yocto/mi=
lestones/yocto-3=2E1_M3/buildtools \
>+#          --url https://downloads=2Eyoctoproject=2Eorg/releases/yocto/m=
ilestones/yocto-3=2E1_M3/buildtools \
> #          --filename x86_64-buildtools-extended-nativesdk-standalone-3=
=2E0+snapshot-20200315=2Esh
> #    (2) using --base-url, --release, --installer-version and --build-da=
te
> #        $ install-buildtools \
>-#          --base-url http://downloads=2Eyoctoproject=2Eorg/releases/yoc=
to \
>+#          --base-url https://downloads=2Eyoctoproject=2Eorg/releases/yo=
cto \
> #          --release yocto-3=2E1_M3 \
> #          --installer-version 3=2E0+snapshot
> #          --build-date 202000315
>@@ -23,11 +23,11 @@
> #  Example usage (standard buildtools from release):
> #    (3) using --url and --filename
> #        $ install-buildtools --without-extended-buildtools \
>-#          --url http://downloads=2Eyoctoproject=2Eorg/releases/yocto/yo=
cto-3=2E0=2E2/buildtools \
>+#          --url https://downloads=2Eyoctoproject=2Eorg/releases/yocto/y=
octo-3=2E0=2E2/buildtools \
> #          --filename x86_64-buildtools-nativesdk-standalone-3=2E0=2E2=
=2Esh
> #    (4) using --base-url, --release and --installer-version
> #        $ install-buildtools --without-extended-buildtools \
>-#          --base-url http://downloads=2Eyoctoproject=2Eorg/releases/yoc=
to \
>+#          --base-url https://downloads=2Eyoctoproject=2Eorg/releases/yo=
cto \
> #          --release yocto-3=2E0=2E2 \
> #          --installer-version 3=2E0=2E2
> #
>@@ -56,7 +56,7 @@ PROGNAME =3D 'install-buildtools'
> logger =3D scriptutils=2Elogger_create(PROGNAME, stream=3Dsys=2Estdout)
>=20
> DEFAULT_INSTALL_DIR =3D os=2Epath=2Ejoin(os=2Epath=2Esplit(scripts_path)=
[0],'buildtools')
>-DEFAULT_BASE_URL =3D 'http://downloads=2Eyoctoproject=2Eorg/releases/yoc=
to'
>+DEFAULT_BASE_URL =3D 'https://downloads=2Eyoctoproject=2Eorg/releases/yo=
cto'
> DEFAULT_RELEASE =3D 'yocto-3=2E2_M3'
> DEFAULT_INSTALLER_VERSION =3D '3=2E1+snapshot'
> DEFAULT_BUILDDATE =3D '20200923'
>diff --git a/scripts/lib/build_perf/html/report=2Ehtml b/scripts/lib/buil=
d_perf/html/report=2Ehtml
>index d1ba6f257886=2E=2E76df3210d41a 100644
>--- a/scripts/lib/build_perf/html/report=2Ehtml
>+++ b/scripts/lib/build_perf/html/report=2Ehtml
>@@ -83,7 +83,7 @@ h3 {
> </head>
>=20
> {% macro poky_link(commit) -%}
>-    <a href=3D"http://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/poky/log/=
?id=3D{{ commit }}">{{ commit[0:11] }}</a>
>+    <a href=3D"https://git=2Eyoctoproject=2Eorg/cgit/cgit=2Ecgi/poky/log=
/?id=3D{{ commit }}">{{ commit[0:11] }}</a>
> {%- endmacro %}
>=20
> <body><div style=3D"width: 700px">

