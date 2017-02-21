Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 001F371E1D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 15:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 7CB842E55C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 8YtbfO+3O2VB for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:03 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bes.se.axis.com (Postfix) with ESMTPS id 01BE02E097
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:03 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4BA11A05E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5E421A05B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id A9D5B351
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v1LFJ250023525
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v1LFJ2Gi023524
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Feb 2017 16:19:02 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 16:19:00 +0100
Message-Id: <00321a9f25646b839353eca39092ac2d0a2da225.1487690243.git.pkj@axis.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <cover.1487690243.git.pkj@axis.com>
References: <cover.1487690243.git.pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 2/2] Make use of the new bb.utils.filter() function
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
X-List-Received-Date: Tue, 21 Feb 2017 15:19:11 -0000

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 meta/classes/testimage.bbclass                                  | 2 +-
 meta/recipes-bsp/u-boot/u-boot.inc                              | 2 +-
 meta/recipes-connectivity/connman/connman.inc                   | 4 +---
 meta/recipes-connectivity/libpcap/libpcap.inc                   | 2 +-
 meta/recipes-connectivity/neard/neard_0.16.bb                   | 2 +-
 meta/recipes-connectivity/nfs-utils/nfs-utils_1.3.4.bb          | 2 +-
 meta/recipes-connectivity/ofono/ofono.inc                       | 2 +-
 meta/recipes-connectivity/openssh/openssh_7.4p1.bb              | 4 ++--
 meta/recipes-core/coreutils/coreutils_6.9.bb                    | 2 +-
 meta/recipes-core/coreutils/coreutils_8.26.bb                   | 3 +--
 meta/recipes-core/dbus/dbus_1.10.14.bb                          | 4 +---
 meta/recipes-core/dropbear/dropbear.inc                         | 2 +-
 meta/recipes-core/kbd/kbd_2.0.3.bb                              | 2 +-
 meta/recipes-core/libxml/libxml2_2.9.4.bb                       | 2 +-
 meta/recipes-core/systemd/systemd_232.bb                        | 4 +---
 meta/recipes-core/util-linux/util-linux.inc                     | 4 ++--
 meta/recipes-devtools/mtd/mtd-utils_git.bb                      | 2 +-
 meta/recipes-devtools/patch/patch_2.7.5.bb                      | 2 +-
 meta/recipes-devtools/pax-utils/pax-utils_1.2.2.bb              | 2 +-
 meta/recipes-devtools/qemu/qemu.inc                             | 3 +--
 meta/recipes-devtools/rsync/rsync_2.6.9.bb                      | 2 +-
 meta/recipes-devtools/rsync/rsync_3.1.2.bb                      | 2 +-
 meta/recipes-devtools/ruby/ruby_2.3.3.bb                        | 2 +-
 meta/recipes-extended/at/at_3.1.20.bb                           | 2 +-
 meta/recipes-extended/cronie/cronie_1.5.1.bb                    | 2 +-
 meta/recipes-extended/cups/cups.inc                             | 3 +--
 meta/recipes-extended/iptables/iptables_1.6.0.bb                | 2 +-
 meta/recipes-extended/libarchive/libarchive_3.2.2.bb            | 4 +---
 meta/recipes-extended/lighttpd/lighttpd_1.4.45.bb               | 2 +-
 meta/recipes-extended/logrotate/logrotate_3.9.1.bb              | 5 +----
 meta/recipes-extended/psmisc/psmisc.inc                         | 2 +-
 meta/recipes-extended/rpcbind/rpcbind_0.2.4.bb                  | 2 +-
 meta/recipes-extended/screen/screen_4.4.0.bb                    | 2 +-
 meta/recipes-extended/shadow/shadow.inc                         | 2 +-
 meta/recipes-extended/sudo/sudo_1.8.18p1.bb                     | 2 +-
 meta/recipes-extended/wget/wget.inc                             | 2 +-
 meta/recipes-gnome/gdk-pixbuf/gdk-pixbuf_2.36.1.bb              | 2 +-
 meta/recipes-gnome/gtk+/gtk+.inc                                | 4 +---
 meta/recipes-gnome/gtk+/gtk+3.inc                               | 6 ++----
 meta/recipes-graphics/cairo/cairo.inc                           | 2 +-
 meta/recipes-graphics/clutter/clutter-1.0.inc                   | 2 +-
 meta/recipes-graphics/libepoxy/libepoxy_1.4.0.bb                | 2 +-
 meta/recipes-graphics/libsdl/libsdl_1.2.15.bb                   | 9 +++------
 meta/recipes-graphics/libsdl2/libsdl2_2.0.5.bb                  | 7 ++-----
 meta/recipes-graphics/libva/libva_1.7.3.bb                      | 3 +--
 meta/recipes-graphics/mesa/mesa-demos_8.3.0.bb                  | 2 +-
 meta/recipes-graphics/mesa/mesa-gl_13.0.4.bb                    | 2 +-
 meta/recipes-graphics/mesa/mesa.inc                             | 3 +--
 meta/recipes-graphics/pango/pango_1.40.3.bb                     | 2 +-
 meta/recipes-graphics/wayland/weston_1.11.1.bb                  | 6 ++----
 meta/recipes-graphics/xorg-app/xauth_1.0.9.bb                   | 2 +-
 meta/recipes-graphics/xorg-app/xhost_1.0.7.bb                   | 2 +-
 meta/recipes-graphics/xorg-lib/libice_1.0.9.bb                  | 2 +-
 meta/recipes-graphics/xorg-lib/libsm_1.2.2.bb                   | 2 +-
 meta/recipes-graphics/xorg-lib/libxfont2_2.0.1.bb               | 2 +-
 meta/recipes-graphics/xorg-lib/libxfont_1.5.2.bb                | 2 +-
 meta/recipes-graphics/xorg-lib/libxkbcommon_0.7.1.bb            | 2 +-
 meta/recipes-graphics/xorg-lib/libxmu_1.1.2.bb                  | 2 +-
 meta/recipes-graphics/xorg-xserver/xserver-xorg.inc             | 4 ++--
 meta/recipes-kernel/latencytop/latencytop_0.5.bb                | 2 +-
 meta/recipes-multimedia/alsa/alsa-plugins_1.1.1.bb              | 2 +-
 meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad.inc  | 2 +-
 meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base.inc | 3 +--
 meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-good.inc | 3 +--
 meta/recipes-multimedia/gstreamer/gstreamer1.0-vaapi.inc        | 5 ++---
 meta/recipes-multimedia/libsndfile/libsndfile1_1.0.27.bb        | 2 +-
 meta/recipes-multimedia/mpeg2dec/mpeg2dec_0.4.1.bb              | 2 +-
 meta/recipes-multimedia/mpg123/mpg123_1.23.8.bb                 | 2 +-
 meta/recipes-multimedia/pulseaudio/pulseaudio.inc               | 4 +---
 meta/recipes-support/apr/apr_1.5.2.bb                           | 2 +-
 meta/recipes-support/consolekit/consolekit_0.4.6.bb             | 3 +--
 meta/recipes-support/curl/curl_7.52.1.bb                        | 2 +-
 meta/recipes-support/libcap/libcap_2.25.bb                      | 2 +-
 meta/recipes-support/nspr/nspr_4.13.1.bb                        | 2 +-
 74 files changed, 83 insertions(+), 117 deletions(-)

diff --git a/meta/classes/testimage.bbclass b/meta/classes/testimage.bbclass
index 09cc6d2..05ac2ef 100644
--- a/meta/classes/testimage.bbclass
+++ b/meta/classes/testimage.bbclass
@@ -36,7 +36,7 @@ TEST_EXTRACTED_DIR ?= "${TEST_NEEDED_PACKAGES_DIR}/extracted"
 TEST_PACKAGED_DIR ?= "${TEST_NEEDED_PACKAGES_DIR}/packaged"
 
 RPMTESTSUITE = "${@bb.utils.contains('IMAGE_PKGTYPE', 'rpm', 'smart rpm', '', d)}"
-SYSTEMDSUITE = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
+SYSTEMDSUITE = "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}"
 MINTESTSUITE = "ping"
 NETTESTSUITE = "${MINTESTSUITE} ssh df date scp oe_syslog ${SYSTEMDSUITE}"
 DEVTESTSUITE = "gcc kernelmodule ldd"
diff --git a/meta/recipes-bsp/u-boot/u-boot.inc b/meta/recipes-bsp/u-boot/u-boot.inc
index 4a55fd6..8ed6695e 100644
--- a/meta/recipes-bsp/u-boot/u-boot.inc
+++ b/meta/recipes-bsp/u-boot/u-boot.inc
@@ -64,7 +64,7 @@ UBOOT_EXTLINUX_CONF_NAME ?= "extlinux.conf"
 UBOOT_EXTLINUX_SYMLINK ?= "${UBOOT_EXTLINUX_CONF_NAME}-${MACHINE}-${PR}"
 
 do_compile () {
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', 'ld-is-gold', '', d)}" = "ld-is-gold" ] ; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'ld-is-gold', d)}" = "ld-is-gold" ] ; then
 		sed -i 's/$(CROSS_COMPILE)ld$/$(CROSS_COMPILE)ld.bfd/g' ${S}/config.mk
 	fi
 
diff --git a/meta/recipes-connectivity/connman/connman.inc b/meta/recipes-connectivity/connman/connman.inc
index 7fa9a7b..64a5418 100644
--- a/meta/recipes-connectivity/connman/connman.inc
+++ b/meta/recipes-connectivity/connman/connman.inc
@@ -31,10 +31,8 @@ EXTRA_OECONF += "\
 "
 
 PACKAGECONFIG ??= "wispr \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'systemd','systemd', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'wifi','wifi', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', '3g systemd wifi', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'bluez', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', '3g','3g', '', d)} \
 "
 
 # If you want ConnMan to support VPN, add following statement into
diff --git a/meta/recipes-connectivity/libpcap/libpcap.inc b/meta/recipes-connectivity/libpcap/libpcap.inc
index 4453a9e..6635779 100644
--- a/meta/recipes-connectivity/libpcap/libpcap.inc
+++ b/meta/recipes-connectivity/libpcap/libpcap.inc
@@ -22,7 +22,7 @@ EXTRA_OECONF = "--with-pcap=linux"
 EXTRA_AUTORECONF += "--exclude=aclocal"
 
 PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', '${BLUEZ}', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)} \
 "
 PACKAGECONFIG[bluez4] = "--enable-bluetooth,--disable-bluetooth,bluez4"
 # Add a dummy PACKAGECONFIG for bluez5 since it is not supported by libpcap.
diff --git a/meta/recipes-connectivity/neard/neard_0.16.bb b/meta/recipes-connectivity/neard/neard_0.16.bb
index 5433dc3..d6157a8 100644
--- a/meta/recipes-connectivity/neard/neard_0.16.bb
+++ b/meta/recipes-connectivity/neard/neard_0.16.bb
@@ -19,7 +19,7 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e \
 
 inherit autotools pkgconfig systemd update-rc.d bluetooth
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}"
 
 PACKAGECONFIG[systemd] = "--enable-systemd --with-systemdsystemunitdir=${systemd_unitdir}/system/ --with-systemduserunitdir=${systemd_unitdir}/user/,--disable-systemd"
 
diff --git a/meta/recipes-connectivity/nfs-utils/nfs-utils_1.3.4.bb b/meta/recipes-connectivity/nfs-utils/nfs-utils_1.3.4.bb
index 4a45acc..4ca9ab2 100644
--- a/meta/recipes-connectivity/nfs-utils/nfs-utils_1.3.4.bb
+++ b/meta/recipes-connectivity/nfs-utils/nfs-utils_1.3.4.bb
@@ -63,7 +63,7 @@ EXTRA_OECONF = "--with-statduser=rpcuser \
                "
 
 PACKAGECONFIG ??= "tcp-wrappers \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)} \
 "
 PACKAGECONFIG_remove_libc-musl = "tcp-wrappers"
 PACKAGECONFIG[tcp-wrappers] = "--with-tcp-wrappers,--without-tcp-wrappers,tcp-wrappers"
diff --git a/meta/recipes-connectivity/ofono/ofono.inc b/meta/recipes-connectivity/ofono/ofono.inc
index 9c47c6f..676a0c0 100644
--- a/meta/recipes-connectivity/ofono/ofono.inc
+++ b/meta/recipes-connectivity/ofono/ofono.inc
@@ -13,7 +13,7 @@ INITSCRIPT_NAME = "ofono"
 INITSCRIPT_PARAMS = "defaults 22"
 
 PACKAGECONFIG ??= "\
-    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)} \
     ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'bluez', '', d)} \
     "
 PACKAGECONFIG[systemd] = "--with-systemdunitdir=${systemd_unitdir}/system/,--with-systemdunitdir="
diff --git a/meta/recipes-connectivity/openssh/openssh_7.4p1.bb b/meta/recipes-connectivity/openssh/openssh_7.4p1.bb
index 3b3d667..f595837 100644
--- a/meta/recipes-connectivity/openssh/openssh_7.4p1.bb
+++ b/meta/recipes-connectivity/openssh/openssh_7.4p1.bb
@@ -91,12 +91,12 @@ do_compile_ptest() {
 }
 
 do_install_append () {
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}" = "pam" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}" = "pam" ]; then
 		install -D -m 0644 ${WORKDIR}/sshd ${D}${sysconfdir}/pam.d/sshd
 		sed -i -e 's:#UsePAM no:UsePAM yes:' ${D}${sysconfdir}/ssh/sshd_config
 	fi
 
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}" = "x11" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}" = "x11" ]; then
 		sed -i -e 's:#X11Forwarding no:X11Forwarding yes:' ${D}${sysconfdir}/ssh/sshd_config
 	fi
 
diff --git a/meta/recipes-core/coreutils/coreutils_6.9.bb b/meta/recipes-core/coreutils/coreutils_6.9.bb
index 9bfbeab..821aafc 100644
--- a/meta/recipes-core/coreutils/coreutils_6.9.bb
+++ b/meta/recipes-core/coreutils/coreutils_6.9.bb
@@ -36,7 +36,7 @@ EXTRA_OECONF += "ac_cv_func_getgroups_works=yes \
 
 # acl is not a default feature
 #
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'acl', 'acl', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'acl', d)}"
 
 # with, without, depends, rdepends
 #
diff --git a/meta/recipes-core/coreutils/coreutils_8.26.bb b/meta/recipes-core/coreutils/coreutils_8.26.bb
index caa6d96..52ef101 100644
--- a/meta/recipes-core/coreutils/coreutils_8.26.bb
+++ b/meta/recipes-core/coreutils/coreutils_8.26.bb
@@ -35,8 +35,7 @@ EXTRA_OECONF_class-nativesdk = "--enable-install-program=arch"
 # acl and xattr are not default features
 #
 PACKAGECONFIG_class-target ??= "\
-    ${@bb.utils.contains('DISTRO_FEATURES', 'acl', 'acl', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'acl xattr', d)} \
 "
 
 # The lib/oe/path.py requires xattr
diff --git a/meta/recipes-core/dbus/dbus_1.10.14.bb b/meta/recipes-core/dbus/dbus_1.10.14.bb
index f50aff8..c8ca6c6 100644
--- a/meta/recipes-core/dbus/dbus_1.10.14.bb
+++ b/meta/recipes-core/dbus/dbus_1.10.14.bb
@@ -99,9 +99,7 @@ EXTRA_OECONF = "--disable-tests \
 
 EXTRA_OECONF_append_class-native = " --disable-selinux"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'largefile', 'largefile', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'largefile systemd x11', d)}"
 PACKAGECONFIG_class-native = ""
 PACKAGECONFIG_class-nativesdk = ""
 
diff --git a/meta/recipes-core/dropbear/dropbear.inc b/meta/recipes-core/dropbear/dropbear.inc
index bda7eb8..13fc844 100644
--- a/meta/recipes-core/dropbear/dropbear.inc
+++ b/meta/recipes-core/dropbear/dropbear.inc
@@ -74,7 +74,7 @@ do_install() {
 		-e 's,/usr/bin,${bindir},g' \
 		-e 's,/usr,${prefix},g' ${WORKDIR}/init > ${D}${sysconfdir}/init.d/dropbear
 	chmod 755 ${D}${sysconfdir}/init.d/dropbear
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}" = "pam" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}" = "pam" ]; then
 		install -d ${D}${sysconfdir}/pam.d
 		install -m 0644 ${WORKDIR}/dropbear  ${D}${sysconfdir}/pam.d/
 	fi
diff --git a/meta/recipes-core/kbd/kbd_2.0.3.bb b/meta/recipes-core/kbd/kbd_2.0.3.bb
index 54d1683..fbc558f 100644
--- a/meta/recipes-core/kbd/kbd_2.0.3.bb
+++ b/meta/recipes-core/kbd/kbd_2.0.3.bb
@@ -18,7 +18,7 @@ SRC_URI = "${KERNELORG_MIRROR}/linux/utils/${BPN}/${BP}.tar.xz \
 SRC_URI[md5sum] = "231b46e7142eb41ea3ae06d2ded3c208"
 SRC_URI[sha256sum] = "7a899de1c0eb75f3aea737095a736f2375e1cbfbe693fc14a3fe0bfb4649fb5e"
 
-PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}"
 PACKAGECONFIG[pam] = "--enable-vlock, --disable-vlock, libpam,"
 
 do_compile_ptest() {
diff --git a/meta/recipes-core/libxml/libxml2_2.9.4.bb b/meta/recipes-core/libxml/libxml2_2.9.4.bb
index 93b9ba0..023fe99 100644
--- a/meta/recipes-core/libxml/libxml2_2.9.4.bb
+++ b/meta/recipes-core/libxml/libxml2_2.9.4.bb
@@ -43,7 +43,7 @@ RDEPENDS_${PN}-ptest_append_libc-glibc = " glibc-gconv-ebcdic-us glibc-gconv-ibm
 export PYTHON_SITE_PACKAGES="${PYTHON_SITEPACKAGES_DIR}"
 
 PACKAGECONFIG ??= "python \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)} \
 "
 PACKAGECONFIG[python] = "--with-python=${PYTHON},--without-python,python"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-core/systemd/systemd_232.bb b/meta/recipes-core/systemd/systemd_232.bb
index cc8781e..9ec8378 100644
--- a/meta/recipes-core/systemd/systemd_232.bb
+++ b/meta/recipes-core/systemd/systemd_232.bb
@@ -41,11 +41,9 @@ SRC_URI_append_qemuall = " file://0001-core-device.c-Change-the-default-device-t
 
 PACKAGECONFIG ??= "xz \
                    ldconfig \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'efi pam selinux', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xkbcommon', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'wifi', 'rfkill', '', d)} \
-                   ${@bb.utils.contains('MACHINE_FEATURES', 'efi', 'efi', '', d)} \
                    binfmt \
                    randomseed \
                    machined \
diff --git a/meta/recipes-core/util-linux/util-linux.inc b/meta/recipes-core/util-linux/util-linux.inc
index 7d948bf..3754275 100644
--- a/meta/recipes-core/util-linux/util-linux.inc
+++ b/meta/recipes-core/util-linux/util-linux.inc
@@ -52,7 +52,7 @@ SHARED_EXTRA_OECONF = "--disable-use-tty-group \
 
 EXTRA_OECONF = "${SHARED_EXTRA_OECONF} --libdir=${base_libdir}"
 
-PACKAGECONFIG_class-target ?= "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}"
+PACKAGECONFIG_class-target ?= "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}"
 PACKAGECONFIG[pam] = "--enable-su --enable-runuser,--disable-su --disable-runuser, libpam,"
 
 # Respect the systemd feature for uuidd
@@ -177,7 +177,7 @@ do_install () {
 
 	rm -f ${D}${bindir}/chkdupexe
 
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}" = "pam" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}" = "pam" ]; then
 		install -d ${D}${sysconfdir}/pam.d
 		install -m 0644 ${WORKDIR}/runuser.pamd ${D}${sysconfdir}/pam.d/runuser
 		install -m 0644 ${WORKDIR}/runuser-l.pamd ${D}${sysconfdir}/pam.d/runuser-l
diff --git a/meta/recipes-devtools/mtd/mtd-utils_git.bb b/meta/recipes-devtools/mtd/mtd-utils_git.bb
index d09ac84..30cf13c 100644
--- a/meta/recipes-devtools/mtd/mtd-utils_git.bb
+++ b/meta/recipes-devtools/mtd/mtd-utils_git.bb
@@ -26,7 +26,7 @@ S = "${WORKDIR}/git/"
 # xattr support creates an additional compile-time dependency on acl because
 # the sys/acl.h header is needed. libacl is not needed and thus enabling xattr
 # regardless whether acl is enabled or disabled in the distro should be okay.
-PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'xattr', d)}"
 PACKAGECONFIG[xattr] = ",,acl,"
 
 EXTRA_OEMAKE = "'CC=${CC}' 'RANLIB=${RANLIB}' 'AR=${AR}' 'CFLAGS=${CFLAGS} ${@bb.utils.contains('PACKAGECONFIG', 'xattr', '', '-DWITHOUT_XATTR', d)} -I${S}/include' 'BUILDDIR=${S}'"
diff --git a/meta/recipes-devtools/patch/patch_2.7.5.bb b/meta/recipes-devtools/patch/patch_2.7.5.bb
index f3fcf5e..151f021 100644
--- a/meta/recipes-devtools/patch/patch_2.7.5.bb
+++ b/meta/recipes-devtools/patch/patch_2.7.5.bb
@@ -10,6 +10,6 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"
 
 acpaths = "-I ${S}/m4 "
 
-PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'xattr', d)}"
 PACKAGECONFIG[xattr] = "--enable-xattr,--disable-xattr,attr,"
 
diff --git a/meta/recipes-devtools/pax-utils/pax-utils_1.2.2.bb b/meta/recipes-devtools/pax-utils/pax-utils_1.2.2.bb
index a032a22..dabb4db 100644
--- a/meta/recipes-devtools/pax-utils/pax-utils_1.2.2.bb
+++ b/meta/recipes-devtools/pax-utils/pax-utils_1.2.2.bb
@@ -29,7 +29,7 @@ BBCLASSEXTEND = "native"
 
 inherit autotools pkgconfig
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'largefile', 'largefile', '', d)} \
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'largefile', d)} \
 "
 PACKAGECONFIG[libcap] = "--with-caps, --without-caps, libcap"
 PACKAGECONFIG[libseccomp] = "--with-seccomp, --without-seccomp, libseccomp"
diff --git a/meta/recipes-devtools/qemu/qemu.inc b/meta/recipes-devtools/qemu/qemu.inc
index ef5d75c..58a9f7b 100644
--- a/meta/recipes-devtools/qemu/qemu.inc
+++ b/meta/recipes-devtools/qemu/qemu.inc
@@ -99,8 +99,7 @@ do_install_append() {
 
 PACKAGECONFIG ??= " \
 	fdt sdl \
-	${@bb.utils.contains('DISTRO_FEATURES', 'alsa', 'alsa', '', d)} \
-	${@bb.utils.contains('DISTRO_FEATURES', 'xen', 'xen', '', d)} \
+	${@bb.utils.filter('DISTRO_FEATURES', 'alsa xen', d)} \
 	"
 PACKAGECONFIG_class-native ??= "fdt alsa uuid"
 PACKAGECONFIG_class-nativesdk ??= "fdt sdl"
diff --git a/meta/recipes-devtools/rsync/rsync_2.6.9.bb b/meta/recipes-devtools/rsync/rsync_2.6.9.bb
index efdf255..17f1d31 100644
--- a/meta/recipes-devtools/rsync/rsync_2.6.9.bb
+++ b/meta/recipes-devtools/rsync/rsync_2.6.9.bb
@@ -12,4 +12,4 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=6d5a9d4c4d3af25cd68fd83e8a8cb09c"
 
 PR = "r4"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
diff --git a/meta/recipes-devtools/rsync/rsync_3.1.2.bb b/meta/recipes-devtools/rsync/rsync_3.1.2.bb
index c6cb331..1031984 100644
--- a/meta/recipes-devtools/rsync/rsync_3.1.2.bb
+++ b/meta/recipes-devtools/rsync/rsync_3.1.2.bb
@@ -10,7 +10,7 @@ LICENSE = "GPLv3+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"
 
 PACKAGECONFIG ??= "acl attr \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)} \
 "
 PACKAGECONFIG[acl] = "--enable-acl-support,--disable-acl-support,acl,"
 PACKAGECONFIG[attr] = "--enable-xattr-support,--disable-xattr-support,attr,"
diff --git a/meta/recipes-devtools/ruby/ruby_2.3.3.bb b/meta/recipes-devtools/ruby/ruby_2.3.3.bb
index 7ba9b46..e460139 100644
--- a/meta/recipes-devtools/ruby/ruby_2.3.3.bb
+++ b/meta/recipes-devtools/ruby/ruby_2.3.3.bb
@@ -9,7 +9,7 @@ SRC_URI[sha256sum] = "241408c8c555b258846368830a06146e4849a1d58dcaf6b14a3b6a7305
 UNKNOWN_CONFIGURE_WHITELIST += "--enable-wide-getaddrinfo"
 
 PACKAGECONFIG ??= ""
-PACKAGECONFIG += "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG += "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 
 PACKAGECONFIG[valgrind] = "--with-valgrind=yes, --with-valgrind=no, valgrind"
 PACKAGECONFIG[gpm] = "--with-gmp=yes, --with-gmp=no, gmp"
diff --git a/meta/recipes-extended/at/at_3.1.20.bb b/meta/recipes-extended/at/at_3.1.20.bb
index 85459b6..41bd49d 100644
--- a/meta/recipes-extended/at/at_3.1.20.bb
+++ b/meta/recipes-extended/at/at_3.1.20.bb
@@ -65,7 +65,7 @@ do_install () {
 	install -m 0644 ${WORKDIR}/atd.service ${D}${systemd_unitdir}/system
 	sed -i -e 's,@SBINDIR@,${sbindir},g' ${D}${systemd_unitdir}/system/atd.service
 
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}" = "pam" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}" = "pam" ]; then
 		install -D -m 0644 ${WORKDIR}/${BP}/pam.conf ${D}${sysconfdir}/pam.d/atd
 	fi
 }
diff --git a/meta/recipes-extended/cronie/cronie_1.5.1.bb b/meta/recipes-extended/cronie/cronie_1.5.1.bb
index 99b2bb5..ad616d5 100644
--- a/meta/recipes-extended/cronie/cronie_1.5.1.bb
+++ b/meta/recipes-extended/cronie/cronie_1.5.1.bb
@@ -28,7 +28,7 @@ SRC_URI[sha256sum] = "6c73666102a6b5d35e2eaf1bd06925f2d4b0cef8d3323c37286dda3089
 
 inherit autotools update-rc.d useradd systemd
 
-PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}"
 
 PACKAGECONFIG[audit] = "--with-audit,--without-audit,audit,"
 PACKAGECONFIG[pam] = "--with-pam,--without-pam,libpam,${PAM_DEPS}"
diff --git a/meta/recipes-extended/cups/cups.inc b/meta/recipes-extended/cups/cups.inc
index e69f178..c3fa459 100644
--- a/meta/recipes-extended/cups/cups.inc
+++ b/meta/recipes-extended/cups/cups.inc
@@ -24,8 +24,7 @@ GROUPADD_PARAM_${PN} = "--system lpadmin"
 SYSTEMD_SERVICE_${PN} = "org.cups.cupsd.socket org.cups.cupsd.path org.cups.cupsd.service org.cups.cups-lpd.socket org.cups.cups-lpd@.service"
 
 PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'zeroconf', 'avahi', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}"
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'pam systemd', d)}"
 PACKAGECONFIG[avahi] = "--enable-avahi,--disable-avahi,avahi"
 PACKAGECONFIG[acl] = "--enable-acl,--disable-acl,acl"
 PACKAGECONFIG[pam] = "--enable-pam, --disable-pam, libpam"
diff --git a/meta/recipes-extended/iptables/iptables_1.6.0.bb b/meta/recipes-extended/iptables/iptables_1.6.0.bb
index fbbe418..9eaa77f 100644
--- a/meta/recipes-extended/iptables/iptables_1.6.0.bb
+++ b/meta/recipes-extended/iptables/iptables_1.6.0.bb
@@ -32,7 +32,7 @@ inherit autotools pkgconfig
 
 EXTRA_OECONF = "--with-kernel=${STAGING_INCDIR} \
                "
-PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)} \
                  "
 
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-extended/libarchive/libarchive_3.2.2.bb b/meta/recipes-extended/libarchive/libarchive_3.2.2.bb
index 8ad62ad..df46aeb 100644
--- a/meta/recipes-extended/libarchive/libarchive_3.2.2.bb
+++ b/meta/recipes-extended/libarchive/libarchive_3.2.2.bb
@@ -11,9 +11,7 @@ PACKAGECONFIG ?= "zlib bz2"
 
 PACKAGECONFIG_append_class-target = "\
 	libxml2 \
-	${@bb.utils.contains('DISTRO_FEATURES', 'acl', 'acl', '', d)} \
-	${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr', '', d)} \
-	${@bb.utils.contains('DISTRO_FEATURES', 'largefile', 'largefile', '', d)} \
+	${@bb.utils.filter('DISTRO_FEATURES', 'acl largefile xattr', d)} \
 "
 
 PACKAGECONFIG_append_class-nativesdk = " largefile"
diff --git a/meta/recipes-extended/lighttpd/lighttpd_1.4.45.bb b/meta/recipes-extended/lighttpd/lighttpd_1.4.45.bb
index c82d93b..5521851 100644
--- a/meta/recipes-extended/lighttpd/lighttpd_1.4.45.bb
+++ b/meta/recipes-extended/lighttpd/lighttpd_1.4.45.bb
@@ -24,7 +24,7 @@ SRC_URI[md5sum] = "a128e1eda76899ce3fd115efae5fe631"
 SRC_URI[sha256sum] = "1c97225deea33eefba6d4158c2cef27913d47553263516bbe9d2e2760fc43a3f"
 
 PACKAGECONFIG ??= "openssl pcre zlib \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)} \
     ${@bb.utils.contains('DISTRO_FEATURES', 'largefile', 'lfs', '', d)} \
     ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'attr', '', d)} \
 "
diff --git a/meta/recipes-extended/logrotate/logrotate_3.9.1.bb b/meta/recipes-extended/logrotate/logrotate_3.9.1.bb
index 5f1a601..9c2dfe0 100644
--- a/meta/recipes-extended/logrotate/logrotate_3.9.1.bb
+++ b/meta/recipes-extended/logrotate/logrotate_3.9.1.bb
@@ -19,10 +19,7 @@ SRC_URI = "https://fedorahosted.org/releases/l/o/logrotate/logrotate-${PV}.tar.g
 SRC_URI[md5sum] = "4492b145b6d542e4a2f41e77fa199ab0"
 SRC_URI[sha256sum] = "022769e3288c80981559a8421703c88e8438b447235e36dd3c8e97cd94c52545"
 
-PACKAGECONFIG ?= "\
-    ${@bb.utils.contains('DISTRO_FEATURES', 'acl', 'acl', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)} \
-"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'acl selinux', d)}"
 
 PACKAGECONFIG[acl] = ",,acl"
 PACKAGECONFIG[selinux] = ",,libselinux"
diff --git a/meta/recipes-extended/psmisc/psmisc.inc b/meta/recipes-extended/psmisc/psmisc.inc
index 98a8470..22b2e85 100644
--- a/meta/recipes-extended/psmisc/psmisc.inc
+++ b/meta/recipes-extended/psmisc/psmisc.inc
@@ -15,7 +15,7 @@ S = "${WORKDIR}/psmisc-${PV}"
 
 inherit autotools gettext
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
 
 ALLOW_EMPTY_${PN} = "1"
diff --git a/meta/recipes-extended/rpcbind/rpcbind_0.2.4.bb b/meta/recipes-extended/rpcbind/rpcbind_0.2.4.bb
index 53cd59d..4911fe5 100644
--- a/meta/recipes-extended/rpcbind/rpcbind_0.2.4.bb
+++ b/meta/recipes-extended/rpcbind/rpcbind_0.2.4.bb
@@ -43,7 +43,7 @@ USERADD_PACKAGES = "${PN}"
 USERADD_PARAM_${PN} = "--system --no-create-home --home-dir / \
                        --shell /bin/false --user-group rpc"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}"
 PACKAGECONFIG[systemd] = "--with-systemdsystemunitdir=${systemd_unitdir}/system/, \
                           --without-systemdsystemunitdir, \
                           systemd \
diff --git a/meta/recipes-extended/screen/screen_4.4.0.bb b/meta/recipes-extended/screen/screen_4.4.0.bb
index 769bac1..e991616 100644
--- a/meta/recipes-extended/screen/screen_4.4.0.bb
+++ b/meta/recipes-extended/screen/screen_4.4.0.bb
@@ -38,7 +38,7 @@ EXTRA_OECONF = "--with-pty-mode=0620 --with-pty-group=5 \
                ${@bb.utils.contains('DISTRO_FEATURES', 'pam', '--enable-pam', '--disable-pam', d)}"
 
 do_install_append () {
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}" = "pam" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}" = "pam" ]; then
 		install -D -m 644 ${WORKDIR}/screen.pam ${D}/${sysconfdir}/pam.d/screen
 	fi
 }
diff --git a/meta/recipes-extended/shadow/shadow.inc b/meta/recipes-extended/shadow/shadow.inc
index 4c4db00..99ffac3 100644
--- a/meta/recipes-extended/shadow/shadow.inc
+++ b/meta/recipes-extended/shadow/shadow.inc
@@ -74,7 +74,7 @@ PAM_PLUGINS = "libpam-runtime \
                pam-plugin-shells \
                pam-plugin-rootok"
 
-PACKAGECONFIG = "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}"
+PACKAGECONFIG = "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}"
 PACKAGECONFIG_class-native = ""
 PACKAGECONFIG_class-nativesdk = ""
 PACKAGECONFIG[pam] = "--with-libpam,--without-libpam,libpam,${PAM_PLUGINS}"
diff --git a/meta/recipes-extended/sudo/sudo_1.8.18p1.bb b/meta/recipes-extended/sudo/sudo_1.8.18p1.bb
index 95e1b84..b3f42cd 100644
--- a/meta/recipes-extended/sudo/sudo_1.8.18p1.bb
+++ b/meta/recipes-extended/sudo/sudo_1.8.18p1.bb
@@ -20,7 +20,7 @@ EXTRA_OECONF += " \
              "
 
 do_install_append () {
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)}" = "pam" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)}" = "pam" ]; then
 		install -D -m 644 ${WORKDIR}/sudo.pam ${D}/${sysconfdir}/pam.d/sudo
 	fi
 
diff --git a/meta/recipes-extended/wget/wget.inc b/meta/recipes-extended/wget/wget.inc
index 3b223a3..9eb051f 100644
--- a/meta/recipes-extended/wget/wget.inc
+++ b/meta/recipes-extended/wget/wget.inc
@@ -18,7 +18,7 @@ RRECOMMENDS_${PN} += "ca-certificates"
 
 BBCLASSEXTEND += "nativesdk"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[libuuid] = "--with-libuuid, --without-libuuid,util-linux"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
 
diff --git a/meta/recipes-gnome/gdk-pixbuf/gdk-pixbuf_2.36.1.bb b/meta/recipes-gnome/gdk-pixbuf/gdk-pixbuf_2.36.1.bb
index 98e5090..a188f54 100644
--- a/meta/recipes-gnome/gdk-pixbuf/gdk-pixbuf_2.36.1.bb
+++ b/meta/recipes-gnome/gdk-pixbuf/gdk-pixbuf_2.36.1.bb
@@ -29,7 +29,7 @@ LIBV = "2.10.0"
 GDK_PIXBUF_LOADERS ?= "png jpeg"
 
 PACKAGECONFIG ??= "${GDK_PIXBUF_LOADERS}"
-PACKAGECONFIG_linuxstdbase = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)} ${GDK_PIXBUF_LOADERS}"
+PACKAGECONFIG_linuxstdbase = "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)} ${GDK_PIXBUF_LOADERS}"
 PACKAGECONFIG_class-native = "${GDK_PIXBUF_LOADERS}"
 
 PACKAGECONFIG[png] = "--with-libpng,--without-libpng,libpng"
diff --git a/meta/recipes-gnome/gtk+/gtk+.inc b/meta/recipes-gnome/gtk+/gtk+.inc
index b9b4721..558bc48 100644
--- a/meta/recipes-gnome/gtk+/gtk+.inc
+++ b/meta/recipes-gnome/gtk+/gtk+.inc
@@ -21,9 +21,7 @@ X11DEPENDS = "virtual/libx11 libxext libxcursor libxrandr libxdamage libxrender
 DEPENDS = "glib-2.0 pango atk jpeg libpng gdk-pixbuf-native \
  cairo gdk-pixbuf"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)} \
-           ${@bb.utils.contains('DISTRO_FEATURES', 'directfb', 'directfb', '', d)} \
-"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'directfb x11', d)}"
 
 PACKAGECONFIG[x11] = "--with-x=yes --with-gdktarget=x11,--with-x=no,${X11DEPENDS}"
 # without --with-gdktarget=directfb it will check for cairo-xlib which isn't available without X11 DISTRO_FEATURE
diff --git a/meta/recipes-gnome/gtk+/gtk+3.inc b/meta/recipes-gnome/gtk+/gtk+3.inc
index 9c104e2..27da844 100644
--- a/meta/recipes-gnome/gtk+/gtk+3.inc
+++ b/meta/recipes-gnome/gtk+/gtk+3.inc
@@ -40,10 +40,8 @@ do_compile_prepend() {
         export GIR_EXTRA_LIBS_PATH="${B}/gdk/.libs"
 }
 
-PACKAGECONFIG ??= "${@bb.utils.contains("DISTRO_FEATURES", "x11", "x11", "", d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "opengl", "opengl", "", d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "opengl x11", "glx", "", d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "wayland", "", d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'opengl wayland x11', d)} \
+                   ${@bb.utils.contains('DISTRO_FEATURES', 'opengl x11', 'glx', '', d)}"
 
 PACKAGECONFIG[x11] = "--enable-x11-backend,--disable-x11-backend,at-spi2-atk fontconfig libx11 libxext libxcursor libxi libxdamage libxrandr libxrender libxcomposite libxfixes"
 # this is provided by oe-core patch that removes epoxy/gl dependency from a X11 build
diff --git a/meta/recipes-graphics/cairo/cairo.inc b/meta/recipes-graphics/cairo/cairo.inc
index 597b582..8e1e2e1 100644
--- a/meta/recipes-graphics/cairo/cairo.inc
+++ b/meta/recipes-graphics/cairo/cairo.inc
@@ -22,7 +22,7 @@ X11DEPENDS = "virtual/libx11 libsm libxrender libxext"
 DEPENDS = "libpng fontconfig pixman glib-2.0 zlib"
 
 PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11 xcb', '', d)} \
-           ${@bb.utils.contains('DISTRO_FEATURES', 'directfb', 'directfb', '', d)}"
+           ${@bb.utils.filter('DISTRO_FEATURES', 'directfb', d)}"
 
 PACKAGECONFIG[x11] = "--with-x=yes -enable-xlib,--with-x=no --disable-xlib,${X11DEPENDS}"
 PACKAGECONFIG[xcb] = "--enable-xcb,--disable-xcb,libxcb"
diff --git a/meta/recipes-graphics/clutter/clutter-1.0.inc b/meta/recipes-graphics/clutter/clutter-1.0.inc
index c6ecd08..6dbbf4d 100644
--- a/meta/recipes-graphics/clutter/clutter-1.0.inc
+++ b/meta/recipes-graphics/clutter/clutter-1.0.inc
@@ -35,7 +35,7 @@ PACKAGECONFIG[wayland-compositor] = "--enable-wayland-compositor,--disable-wayla
 
 # Default configuration, distros might want to override
 PACKAGECONFIG ??= "egl \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'wayland', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'glx x11', '', d)}"
 
 FILES_${PN}-examples = "${libdir}/clutter/examples"
diff --git a/meta/recipes-graphics/libepoxy/libepoxy_1.4.0.bb b/meta/recipes-graphics/libepoxy/libepoxy_1.4.0.bb
index 4d52f12..bd0148e 100644
--- a/meta/recipes-graphics/libepoxy/libepoxy_1.4.0.bb
+++ b/meta/recipes-graphics/libepoxy/libepoxy_1.4.0.bb
@@ -16,4 +16,4 @@ REQUIRED_DISTRO_FEATURES = "opengl"
 DEPENDS = "util-macros virtual/egl"
 
 PACKAGECONFIG[x11] = "--enable-glx, --disable-glx, virtual/libx11"
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}"
diff --git a/meta/recipes-graphics/libsdl/libsdl_1.2.15.bb b/meta/recipes-graphics/libsdl/libsdl_1.2.15.bb
index 9c0ec54..c802a6f 100644
--- a/meta/recipes-graphics/libsdl/libsdl_1.2.15.bb
+++ b/meta/recipes-graphics/libsdl/libsdl_1.2.15.bb
@@ -41,13 +41,10 @@ EXTRA_OECONF = "--disable-static --enable-cdrom --enable-threads --enable-timers
                 --disable-video-picogui --disable-video-qtopia --enable-sdl-dlopen \
                 --disable-rpath"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'alsa', 'alsa', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'pulseaudio', 'pulseaudio', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'directfb', 'directfb', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11 opengl', 'opengl', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'alsa directfb pulseaudio x11', d)} \
+                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11 opengl', 'opengl', '', d)}"
 PACKAGECONFIG_class-native = "x11"
-PACKAGECONFIG_class-nativesdk = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG_class-nativesdk = "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}"
 
 PACKAGECONFIG[alsa] = "--enable-alsa --disable-alsatest,--disable-alsa,alsa-lib"
 PACKAGECONFIG[pulseaudio] = "--enable-pulseaudio,--disable-pulseaudio,pulseaudio"
diff --git a/meta/recipes-graphics/libsdl2/libsdl2_2.0.5.bb b/meta/recipes-graphics/libsdl2/libsdl2_2.0.5.bb
index 0d9a129..d747cf1 100644
--- a/meta/recipes-graphics/libsdl2/libsdl2_2.0.5.bb
+++ b/meta/recipes-graphics/libsdl2/libsdl2_2.0.5.bb
@@ -38,15 +38,12 @@ EXTRA_OECONF = "--disable-oss --disable-esd --disable-arts \
 
 # opengl packageconfig factored out to make it easy for distros
 # and BSP layers to pick either (desktop) opengl, gles2, or no GL
-PACKAGECONFIG_GL ?= "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'opengl', '', d)}"
+PACKAGECONFIG_GL ?= "${@bb.utils.filter('DISTRO_FEATURES', 'opengl', d)}"
 
 PACKAGECONFIG ??= " \
     ${PACKAGECONFIG_GL} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'alsa', 'alsa', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'directfb', 'directfb', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'pulseaudio', 'pulseaudio', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'alsa directfb pulseaudio x11', d)} \
     ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland gles2', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)} \
 "
 PACKAGECONFIG[alsa]       = "--enable-alsa --disable-alsatest,--disable-alsa,alsa-lib,"
 PACKAGECONFIG[directfb]   = "--enable-video-directfb,--disable-video-directfb,directfb"
diff --git a/meta/recipes-graphics/libva/libva_1.7.3.bb b/meta/recipes-graphics/libva/libva_1.7.3.bb
index a7b4b90..2c9c638 100644
--- a/meta/recipes-graphics/libva/libva_1.7.3.bb
+++ b/meta/recipes-graphics/libva/libva_1.7.3.bb
@@ -30,8 +30,7 @@ REQUIRED_DISTRO_FEATURES = "opengl"
 
 EXTRA_OECONF = "--disable-dummy-driver"
 
-PACKAGECONFIG ??= "${@bb.utils.contains("DISTRO_FEATURES", "x11", "x11", "", d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "wayland", "", d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'wayland x11', d)}"
 PACKAGECONFIG[x11] = "--enable-x11,--disable-x11,virtual/libx11 libxext libxfixes"
 PACKAGECONFIG[wayland] = "--enable-wayland,--disable-wayland,wayland"
 
diff --git a/meta/recipes-graphics/mesa/mesa-demos_8.3.0.bb b/meta/recipes-graphics/mesa/mesa-demos_8.3.0.bb
index fab0bdb..e80d1e8 100644
--- a/meta/recipes-graphics/mesa/mesa-demos_8.3.0.bb
+++ b/meta/recipes-graphics/mesa/mesa-demos_8.3.0.bb
@@ -30,7 +30,7 @@ PACKAGECONFIG ?= "drm osmesa freetype2 gbm egl gles1 gles2 \
                   x11 glew glu glx"
 
 # The Wayland code doesn't work with Wayland 1.0, so disable it for now
-#${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '', d)}"
+#${@bb.utils.filter('DISTRO_FEATURES', 'wayland', d)}"
 
 EXTRA_OECONF = "--with-system-data-files"
 
diff --git a/meta/recipes-graphics/mesa/mesa-gl_13.0.4.bb b/meta/recipes-graphics/mesa/mesa-gl_13.0.4.bb
index f06a3e9..85cc396 100644
--- a/meta/recipes-graphics/mesa/mesa-gl_13.0.4.bb
+++ b/meta/recipes-graphics/mesa/mesa-gl_13.0.4.bb
@@ -8,6 +8,6 @@ PROVIDES = "virtual/libgl virtual/mesa"
 
 S = "${WORKDIR}/mesa-${PV}"
 
-PACKAGECONFIG ??= "dri ${MESA_CRYPTO} ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ??= "dri ${MESA_CRYPTO} ${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}"
 
 EXCLUDE_FROM_WORLD = "1"
diff --git a/meta/recipes-graphics/mesa/mesa.inc b/meta/recipes-graphics/mesa/mesa.inc
index 5d882b1..87c6821 100644
--- a/meta/recipes-graphics/mesa/mesa.inc
+++ b/meta/recipes-graphics/mesa/mesa.inc
@@ -25,8 +25,7 @@ REQUIRED_DISTRO_FEATURES = "opengl"
 EXTRA_OECONF = "--enable-shared-glapi"
 
 PACKAGECONFIG ??= "gbm egl gles dri ${MESA_CRYPTO} \
-		${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}\
-		${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '', d)}\
+		${@bb.utils.filter('DISTRO_FEATURES', 'wayland x11', d)} \
 		"
 
 PACKAGECONFIG[gbm] = "--enable-gbm,--disable-gbm"
diff --git a/meta/recipes-graphics/pango/pango_1.40.3.bb b/meta/recipes-graphics/pango/pango_1.40.3.bb
index 338ef4a..e259a82 100644
--- a/meta/recipes-graphics/pango/pango_1.40.3.bb
+++ b/meta/recipes-graphics/pango/pango_1.40.3.bb
@@ -22,7 +22,7 @@ SRC_URI[archive.sha256sum] = "abba8b5ce728520c3a0f1535eab19eac3c14aeef7faa5aded9
 
 DEPENDS = "glib-2.0 glib-2.0-native fontconfig freetype virtual/libiconv cairo harfbuzz"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}"
 PACKAGECONFIG[x11] = "--with-xft,--without-xft,virtual/libx11 libxft"
 
 EXTRA_AUTORECONF = ""
diff --git a/meta/recipes-graphics/wayland/weston_1.11.1.bb b/meta/recipes-graphics/wayland/weston_1.11.1.bb
index 2736cc1..edea1be 100644
--- a/meta/recipes-graphics/wayland/weston_1.11.1.bb
+++ b/meta/recipes-graphics/wayland/weston_1.11.1.bb
@@ -37,10 +37,8 @@ EXTRA_OECONF_append_qemux86-64 = "\
 		WESTON_NATIVE_BACKEND=fbdev-backend.so \
 		"
 PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'kms fbdev wayland egl', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'x11 wayland', 'xwayland', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'pam systemd x11', d)} \
                    clients launch"
 #
 # Compositor choices
@@ -85,7 +83,7 @@ do_install_append() {
 	rm -f ${D}/${libdir}/weston/*.la
 
 	# If X11, ship a desktop file to launch it
-	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}" = "x11" ]; then
+	if [ "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}" = "x11" ]; then
 		install -d ${D}${datadir}/applications
 		install ${WORKDIR}/weston.desktop ${D}${datadir}/applications
 
diff --git a/meta/recipes-graphics/xorg-app/xauth_1.0.9.bb b/meta/recipes-graphics/xorg-app/xauth_1.0.9.bb
index 59b3323..89c97ab 100644
--- a/meta/recipes-graphics/xorg-app/xauth_1.0.9.bb
+++ b/meta/recipes-graphics/xorg-app/xauth_1.0.9.bb
@@ -11,5 +11,5 @@ PE = "1"
 SRC_URI[md5sum] = "7d6003f32838d5b688e2c8a131083271"
 SRC_URI[sha256sum] = "56ce1523eb48b1f8a4f4244fe1c3d8e6af1a3b7d4b0e6063582421b0b68dc28f"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-graphics/xorg-app/xhost_1.0.7.bb b/meta/recipes-graphics/xorg-app/xhost_1.0.7.bb
index f23d258..77490f5 100644
--- a/meta/recipes-graphics/xorg-app/xhost_1.0.7.bb
+++ b/meta/recipes-graphics/xorg-app/xhost_1.0.7.bb
@@ -16,5 +16,5 @@ PE = "1"
 SRC_URI[md5sum] = "f5d490738b148cb7f2fe760f40f92516"
 SRC_URI[sha256sum] = "93e619ee15471f576cfb30c663e18f5bc70aca577a63d2c2c03f006a7837c29a"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-graphics/xorg-lib/libice_1.0.9.bb b/meta/recipes-graphics/xorg-lib/libice_1.0.9.bb
index b361ad6..f069749 100644
--- a/meta/recipes-graphics/xorg-lib/libice_1.0.9.bb
+++ b/meta/recipes-graphics/xorg-lib/libice_1.0.9.bb
@@ -23,6 +23,6 @@ BBCLASSEXTEND = "native"
 SRC_URI[md5sum] = "addfb1e897ca8079531669c7c7711726"
 SRC_URI[sha256sum] = "8f7032f2c1c64352b5423f6b48a8ebdc339cc63064af34d66a6c9aa79759e202"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[arc4] = "ac_cv_lib_bsd_arc4random_buf=yes,ac_cv_lib_bsd_arc4random_buf=no,libbsd"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-graphics/xorg-lib/libsm_1.2.2.bb b/meta/recipes-graphics/xorg-lib/libsm_1.2.2.bb
index da4ed92..48922cb 100644
--- a/meta/recipes-graphics/xorg-lib/libsm_1.2.2.bb
+++ b/meta/recipes-graphics/xorg-lib/libsm_1.2.2.bb
@@ -27,5 +27,5 @@ BBCLASSEXTEND = "native"
 SRC_URI[md5sum] = "499a7773c65aba513609fe651853c5f3"
 SRC_URI[sha256sum] = "0baca8c9f5d934450a70896c4ad38d06475521255ca63b717a6510fdb6e287bd"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-graphics/xorg-lib/libxfont2_2.0.1.bb b/meta/recipes-graphics/xorg-lib/libxfont2_2.0.1.bb
index 402ab0d..4bfb290 100644
--- a/meta/recipes-graphics/xorg-lib/libxfont2_2.0.1.bb
+++ b/meta/recipes-graphics/xorg-lib/libxfont2_2.0.1.bb
@@ -18,5 +18,5 @@ BBCLASSEXTEND = "native"
 SRC_URI[md5sum] = "0d9f6dd9c23bf4bcbfb00504b566baf5"
 SRC_URI[sha256sum] = "e9fbbb475ddd171b3a6a54b989cbade1f6f874fc35d505ebc5be426bc6e4db7e"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-graphics/xorg-lib/libxfont_1.5.2.bb b/meta/recipes-graphics/xorg-lib/libxfont_1.5.2.bb
index a5694a3..b11dda5 100644
--- a/meta/recipes-graphics/xorg-lib/libxfont_1.5.2.bb
+++ b/meta/recipes-graphics/xorg-lib/libxfont_1.5.2.bb
@@ -21,5 +21,5 @@ BBCLASSEXTEND = "native"
 SRC_URI[md5sum] = "254ee42bd178d18ebc7a73aacfde7f79"
 SRC_URI[sha256sum] = "02945ea68da447102f3e6c2b896c1d2061fd115de99404facc2aca3ad7010d71"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-graphics/xorg-lib/libxkbcommon_0.7.1.bb b/meta/recipes-graphics/xorg-lib/libxkbcommon_0.7.1.bb
index 07be028..81df1dd 100644
--- a/meta/recipes-graphics/xorg-lib/libxkbcommon_0.7.1.bb
+++ b/meta/recipes-graphics/xorg-lib/libxkbcommon_0.7.1.bb
@@ -18,5 +18,5 @@ inherit autotools pkgconfig
 
 EXTRA_OECONF = "--disable-docs"
 
-PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}"
 PACKAGECONFIG[x11] = "--enable-x11,--disable-x11,libxcb xkeyboard-config,"
diff --git a/meta/recipes-graphics/xorg-lib/libxmu_1.1.2.bb b/meta/recipes-graphics/xorg-lib/libxmu_1.1.2.bb
index d5935ff..4740c15 100644
--- a/meta/recipes-graphics/xorg-lib/libxmu_1.1.2.bb
+++ b/meta/recipes-graphics/xorg-lib/libxmu_1.1.2.bb
@@ -31,5 +31,5 @@ BBCLASSEXTEND = "native"
 SRC_URI[md5sum] = "41d92ab627dfa06568076043f3e089e4"
 SRC_URI[sha256sum] = "756edc7c383254eef8b4e1b733c3bf1dc061b523c9f9833ac7058378b8349d0b"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
diff --git a/meta/recipes-graphics/xorg-xserver/xserver-xorg.inc b/meta/recipes-graphics/xorg-xserver/xserver-xorg.inc
index 7717802..1650c79 100644
--- a/meta/recipes-graphics/xorg-xserver/xserver-xorg.inc
+++ b/meta/recipes-graphics/xorg-xserver/xserver-xorg.inc
@@ -123,8 +123,8 @@ EXTRA_OECONF += "--with-fop=no \
 OPENGL_PKGCONFIGS = "dri glx glamor dri3 xshmfence"
 PACKAGECONFIG ??= "dri2 udev ${XORG_CRYPTO} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', '${OPENGL_PKGCONFIGS}', '', d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "xwayland", "", d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd", "", d)} \
+                   ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'xwayland', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)} \
 "
 
 PACKAGECONFIG[udev] = "--enable-config-udev,--disable-config-udev,udev"
diff --git a/meta/recipes-kernel/latencytop/latencytop_0.5.bb b/meta/recipes-kernel/latencytop/latencytop_0.5.bb
index c38a038..eb19471 100644
--- a/meta/recipes-kernel/latencytop/latencytop_0.5.bb
+++ b/meta/recipes-kernel/latencytop/latencytop_0.5.bb
@@ -19,7 +19,7 @@ SRC_URI = "http://pkgs.fedoraproject.org/repo/pkgs/${BPN}/${BP}.tar.gz/73bb3371c
 SRC_URI[md5sum] = "73bb3371c6ee0b0e68e25289027e865c"
 SRC_URI[sha256sum] = "9e7f72fbea7bd918e71212a1eabaad8488d2c602205d2e3c95d62cd57e9203ef"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}"
 
 PACKAGECONFIG[x11] = ",,gtk+"
 
diff --git a/meta/recipes-multimedia/alsa/alsa-plugins_1.1.1.bb b/meta/recipes-multimedia/alsa/alsa-plugins_1.1.1.bb
index c95ea54..3928fb1 100644
--- a/meta/recipes-multimedia/alsa/alsa-plugins_1.1.1.bb
+++ b/meta/recipes-multimedia/alsa/alsa-plugins_1.1.1.bb
@@ -31,7 +31,7 @@ inherit autotools pkgconfig
 PACKAGECONFIG ??= "\
         samplerate \
         speexdsp \
-        ${@bb.utils.contains('DISTRO_FEATURES', 'pulseaudio', 'pulseaudio', '', d)} \
+        ${@bb.utils.filter('DISTRO_FEATURES', 'pulseaudio', d)} \
 "
 PACKAGECONFIG[avcodec] = "--enable-avcodec,--disable-avcodec,libav"
 PACKAGECONFIG[jack] = "--enable-jack,--disable-jack,jack"
diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad.inc b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad.inc
index 3cb7ab1..992373b 100644
--- a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad.inc
+++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad.inc
@@ -20,7 +20,7 @@ PACKAGECONFIG ??= " \
     ${GSTREAMER_ORC} \
     ${PACKAGECONFIG_GL} \
     ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'bluez', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'directfb', 'directfb', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'directfb', d)} \
     ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland egl', '', d)} \
     bz2 curl dash dtls hls neon rsvg sbc smoothstreaming sndfile uvch264 webp \
 "
diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base.inc b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base.inc
index 1c56200..08130c1 100644
--- a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base.inc
+++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-base.inc
@@ -17,8 +17,7 @@ PACKAGES_DYNAMIC =+ "^libgst.*"
 
 PACKAGECONFIG ??= " \
     ${GSTREAMER_ORC} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'alsa', 'alsa', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'alsa x11', d)} \
     gio-unix-2.0 ogg pango theora vorbis \
 "
 
diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-good.inc b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-good.inc
index f1e30ab..14c3d61 100644
--- a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-good.inc
+++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-good.inc
@@ -8,8 +8,7 @@ inherit gettext
 
 PACKAGECONFIG ??= " \
     ${GSTREAMER_ORC} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'pulseaudio', 'pulseaudio', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)} \
+    ${@bb.utils.filter('DISTRO_FEATURES', 'pulseaudio x11', d)} \
     cairo flac gdk-pixbuf gudev jpeg libpng soup speex taglib v4l2 \
 "
 
diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0-vaapi.inc b/meta/recipes-multimedia/gstreamer/gstreamer1.0-vaapi.inc
index 59b0324..e116428 100644
--- a/meta/recipes-multimedia/gstreamer/gstreamer1.0-vaapi.inc
+++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0-vaapi.inc
@@ -23,9 +23,8 @@ REQUIRED_DISTRO_FEATURES ?= "opengl"
 PACKAGES =+ "${PN}-tests"
 
 PACKAGECONFIG ??= "drm \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "opengl x11", "glx", "", d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "wayland", "", d)} \
-                   ${@bb.utils.contains("DISTRO_FEATURES", "x11", "x11", "", d)}"
+                   ${@bb.utils.contains('DISTRO_FEATURES', 'opengl x11', 'glx', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'wayland x11', d)}"
 
 PACKAGECONFIG[drm] = "--enable-drm,--disable-drm,udev libdrm"
 PACKAGECONFIG[glx] = "--enable-glx,--disable-glx,virtual/mesa"
diff --git a/meta/recipes-multimedia/libsndfile/libsndfile1_1.0.27.bb b/meta/recipes-multimedia/libsndfile/libsndfile1_1.0.27.bb
index ec41719..7a095b6 100644
--- a/meta/recipes-multimedia/libsndfile/libsndfile1_1.0.27.bb
+++ b/meta/recipes-multimedia/libsndfile/libsndfile1_1.0.27.bb
@@ -14,7 +14,7 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=e77fe93202736b47c07035910f47974a"
 
 S = "${WORKDIR}/libsndfile-${PV}"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'alsa', 'alsa', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'alsa', d)}"
 PACKAGECONFIG[alsa] = "--enable-alsa,--disable-alsa,alsa-lib"
 
 inherit autotools lib_package pkgconfig
diff --git a/meta/recipes-multimedia/mpeg2dec/mpeg2dec_0.4.1.bb b/meta/recipes-multimedia/mpeg2dec/mpeg2dec_0.4.1.bb
index 1666994..fe765da 100644
--- a/meta/recipes-multimedia/mpeg2dec/mpeg2dec_0.4.1.bb
+++ b/meta/recipes-multimedia/mpeg2dec/mpeg2dec_0.4.1.bb
@@ -20,7 +20,7 @@ inherit autotools pkgconfig
 
 EXTRA_OECONF = "--enable-shared --disable-sdl"
 
-PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'x11', d)}"
 PACKAGECONFIG[x11] = "--with-x,--without-x,virtual/libx11 libxext libxv"
 
 PACKAGES = "mpeg2dec-dbg mpeg2dec mpeg2dec-doc libmpeg2 libmpeg2-dev libmpeg2convert libmpeg2convert-dev libmpeg2-staticdev libmpeg2convert-staticdev"
diff --git a/meta/recipes-multimedia/mpg123/mpg123_1.23.8.bb b/meta/recipes-multimedia/mpg123/mpg123_1.23.8.bb
index f4c5c7c..dfc6db7 100644
--- a/meta/recipes-multimedia/mpg123/mpg123_1.23.8.bb
+++ b/meta/recipes-multimedia/mpg123/mpg123_1.23.8.bb
@@ -20,7 +20,7 @@ inherit autotools pkgconfig
 # The options should be mutually exclusive for configuration script.
 # If both alsa and pulseaudio are specified (as in the default distro features)
 # pulseaudio takes precedence.
-PACKAGECONFIG_ALSA = "${@bb.utils.contains('DISTRO_FEATURES', 'alsa', 'alsa', '', d)}"
+PACKAGECONFIG_ALSA = "${@bb.utils.filter('DISTRO_FEATURES', 'alsa', d)}"
 PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'pulseaudio', 'pulseaudio', '${PACKAGECONFIG_ALSA}', d)}"
 
 PACKAGECONFIG[alsa] = "--with-default-audio=alsa,,alsa-lib"
diff --git a/meta/recipes-multimedia/pulseaudio/pulseaudio.inc b/meta/recipes-multimedia/pulseaudio/pulseaudio.inc
index 818ff56..fdbf5ab 100644
--- a/meta/recipes-multimedia/pulseaudio/pulseaudio.inc
+++ b/meta/recipes-multimedia/pulseaudio/pulseaudio.inc
@@ -108,10 +108,8 @@ EXTRA_OECONF += "--disable-adrian-aec"
 
 PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', '${BLUEZ}', '', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'zeroconf', 'avahi', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', '3g', 'ofono', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'ipv6 systemd x11', d)} \
                    dbus \
                    "
 
diff --git a/meta/recipes-support/apr/apr_1.5.2.bb b/meta/recipes-support/apr/apr_1.5.2.bb
index f560c8b..079f8cd 100644
--- a/meta/recipes-support/apr/apr_1.5.2.bb
+++ b/meta/recipes-support/apr/apr_1.5.2.bb
@@ -39,7 +39,7 @@ CACHED_CONFIGUREVARS += "ac_cv_header_netinet_sctp_h=no ac_cv_header_netinet_sct
 # x86_64-linux-libtool:   error: specify a tag with '--tag'
 CCACHE = ""
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
 
 do_configure_prepend() {
diff --git a/meta/recipes-support/consolekit/consolekit_0.4.6.bb b/meta/recipes-support/consolekit/consolekit_0.4.6.bb
index ceac0fe..80d48bf 100644
--- a/meta/recipes-support/consolekit/consolekit_0.4.6.bb
+++ b/meta/recipes-support/consolekit/consolekit_0.4.6.bb
@@ -23,8 +23,7 @@ SRC_URI[sha256sum] = "b41d17e06f80059589fbeefe96ad07bcc564c49e65516da1caf9751464
 
 S = "${WORKDIR}/ConsoleKit-${PV}"
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)} \
-                   ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'pam systemd', d)}"
 
 PACKAGECONFIG[pam] = "--enable-pam-module --with-pam-module-dir=${base_libdir}/security,--disable-pam-module,libpam"
 PACKAGECONFIG[policykit] = "--with-polkit,--without-polkit,polkit"
diff --git a/meta/recipes-support/curl/curl_7.52.1.bb b/meta/recipes-support/curl/curl_7.52.1.bb
index 2882bc0..a614204 100644
--- a/meta/recipes-support/curl/curl_7.52.1.bb
+++ b/meta/recipes-support/curl/curl_7.52.1.bb
@@ -20,7 +20,7 @@ SRC_URI[sha256sum] = "d16185a767cb2c1ba3d5b9096ec54e5ec198b213f45864a38b3bda4bbf
 CVE_PRODUCT = "libcurl"
 inherit autotools pkgconfig binconfig multilib_header
 
-PACKAGECONFIG ??= "${@bb.utils.contains("DISTRO_FEATURES", "ipv6", "ipv6", "", d)} gnutls proxy zlib"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)} gnutls proxy zlib"
 PACKAGECONFIG_class-native = "ipv6 proxy ssl zlib"
 PACKAGECONFIG_class-nativesdk = "ipv6 proxy ssl zlib"
 
diff --git a/meta/recipes-support/libcap/libcap_2.25.bb b/meta/recipes-support/libcap/libcap_2.25.bb
index 343aeb6..26d7bf2 100644
--- a/meta/recipes-support/libcap/libcap_2.25.bb
+++ b/meta/recipes-support/libcap/libcap_2.25.bb
@@ -27,7 +27,7 @@ do_configure() {
 	sed -e '/shell gperf/cifeq (,yes)' -i libcap/Makefile
 }
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'pam', 'pam', '', d)} \
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'pam', d)} \
                    ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'attr', '', d)}"
 PACKAGECONFIG_class-native ??= ""
 
diff --git a/meta/recipes-support/nspr/nspr_4.13.1.bb b/meta/recipes-support/nspr/nspr_4.13.1.bb
index 23f8944..343800c 100644
--- a/meta/recipes-support/nspr/nspr_4.13.1.bb
+++ b/meta/recipes-support/nspr/nspr_4.13.1.bb
@@ -147,7 +147,7 @@ TESTS = " \
 
 inherit autotools
 
-PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)}"
+PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"
 PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"
 
 do_compile_prepend() {
-- 
2.9.0


