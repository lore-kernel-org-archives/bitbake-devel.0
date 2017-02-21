Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id CFBB271E15
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 15:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 06E401809C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id BJx6Dr4KXcOv for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:03 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id B28761829B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E8111E066
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9336E1E04F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 87D86444
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v1LFJ2YM023517
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v1LFJ2BO023516
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Feb 2017 16:19:02 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 16:18:58 +0100
Message-Id: <cover.1487690243.git.pkj@axis.com>
X-Mailer: git-send-email 2.9.0
X-TM-AS-GCONF: 00
Subject: [PATCH 0/2] Add bb.utils.filter()
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
X-List-Received-Date: Tue, 21 Feb 2017 15:19:05 -0000

The first patch in this set introduces a new utility function to
BitBake: bb.utils.filter(). It can be used to filter a variable
containing whitespace separated words based on another set of words.
It has been modeled after the bb.utils.contains_any() function.

We have quite a number of recipes where we today use:

PACKAGECONFIG ??= "${MACHINE_FEATURES}"

This is nice and simple. However, the drawback is that it means that
we have had to disable the invalid-packageconfig QA warning for these
recipes. To be able to re-enable the QA warning for these recipes I
came up with the bb.utils.filter() function.

A typical example of how it can be used is to simplify constructs for
PACKAGECONFIG that depend on DISTRO_FEATURES:

-PACKAGECONFIG ?= "\
-    ${@bb.utils.contains('DISTRO_FEATURES', 'acl', 'acl', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)} \
-"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'acl selinux', d)}"

An alternative is to write it as:

PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', d.getVarFlags('PACKAGECONFIG'), d)}"

The latter construct may seem to add nothing extra compared to setting
PACKAGECONFIG = "${DISTRO_FEATURES}" with the QA warning disabled, but
the difference is that the warning can remain enabled and still catch
someone doing something like PACKAGECONFIG += "unsupported-feature".

The second patch is for the meta layer and updates all recipes to take
advantage of the new function.

//Peter

The following changes since commit e436a6398684d2872cb541f1cfb0f67b3618d15a:

  layer.conf: bump version for change in eSDK selftest behaviour (2017-02-19 09:39:03 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/bb.utils.filter
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/bb.utils.filter

Peter Kjellerstedt (2):
  lib/bb/utils: Add filter()
  Make use of the new bb.utils.filter() function

 bitbake/lib/bb/utils.py                            | 24 ++++++++++++++++++++++
 meta/classes/testimage.bbclass                     |  2 +-
 meta/recipes-bsp/u-boot/u-boot.inc                 |  2 +-
 meta/recipes-connectivity/connman/connman.inc      |  4 +---
 meta/recipes-connectivity/libpcap/libpcap.inc      |  2 +-
 meta/recipes-connectivity/neard/neard_0.16.bb      |  2 +-
 .../nfs-utils/nfs-utils_1.3.4.bb                   |  2 +-
 meta/recipes-connectivity/ofono/ofono.inc          |  2 +-
 meta/recipes-connectivity/openssh/openssh_7.4p1.bb |  4 ++--
 meta/recipes-core/coreutils/coreutils_6.9.bb       |  2 +-
 meta/recipes-core/coreutils/coreutils_8.26.bb      |  3 +--
 meta/recipes-core/dbus/dbus_1.10.14.bb             |  4 +---
 meta/recipes-core/dropbear/dropbear.inc            |  2 +-
 meta/recipes-core/kbd/kbd_2.0.3.bb                 |  2 +-
 meta/recipes-core/libxml/libxml2_2.9.4.bb          |  2 +-
 meta/recipes-core/systemd/systemd_232.bb           |  4 +---
 meta/recipes-core/util-linux/util-linux.inc        |  4 ++--
 meta/recipes-devtools/mtd/mtd-utils_git.bb         |  2 +-
 meta/recipes-devtools/patch/patch_2.7.5.bb         |  2 +-
 meta/recipes-devtools/pax-utils/pax-utils_1.2.2.bb |  2 +-
 meta/recipes-devtools/qemu/qemu.inc                |  3 +--
 meta/recipes-devtools/rsync/rsync_2.6.9.bb         |  2 +-
 meta/recipes-devtools/rsync/rsync_3.1.2.bb         |  2 +-
 meta/recipes-devtools/ruby/ruby_2.3.3.bb           |  2 +-
 meta/recipes-extended/at/at_3.1.20.bb              |  2 +-
 meta/recipes-extended/cronie/cronie_1.5.1.bb       |  2 +-
 meta/recipes-extended/cups/cups.inc                |  3 +--
 meta/recipes-extended/iptables/iptables_1.6.0.bb   |  2 +-
 .../libarchive/libarchive_3.2.2.bb                 |  4 +---
 meta/recipes-extended/lighttpd/lighttpd_1.4.45.bb  |  2 +-
 meta/recipes-extended/logrotate/logrotate_3.9.1.bb |  5 +----
 meta/recipes-extended/psmisc/psmisc.inc            |  2 +-
 meta/recipes-extended/rpcbind/rpcbind_0.2.4.bb     |  2 +-
 meta/recipes-extended/screen/screen_4.4.0.bb       |  2 +-
 meta/recipes-extended/shadow/shadow.inc            |  2 +-
 meta/recipes-extended/sudo/sudo_1.8.18p1.bb        |  2 +-
 meta/recipes-extended/wget/wget.inc                |  2 +-
 meta/recipes-gnome/gdk-pixbuf/gdk-pixbuf_2.36.1.bb |  2 +-
 meta/recipes-gnome/gtk+/gtk+.inc                   |  4 +---
 meta/recipes-gnome/gtk+/gtk+3.inc                  |  6 ++----
 meta/recipes-graphics/cairo/cairo.inc              |  2 +-
 meta/recipes-graphics/clutter/clutter-1.0.inc      |  2 +-
 meta/recipes-graphics/libepoxy/libepoxy_1.4.0.bb   |  2 +-
 meta/recipes-graphics/libsdl/libsdl_1.2.15.bb      |  9 +++-----
 meta/recipes-graphics/libsdl2/libsdl2_2.0.5.bb     |  7 ++-----
 meta/recipes-graphics/libva/libva_1.7.3.bb         |  3 +--
 meta/recipes-graphics/mesa/mesa-demos_8.3.0.bb     |  2 +-
 meta/recipes-graphics/mesa/mesa-gl_13.0.4.bb       |  2 +-
 meta/recipes-graphics/mesa/mesa.inc                |  3 +--
 meta/recipes-graphics/pango/pango_1.40.3.bb        |  2 +-
 meta/recipes-graphics/wayland/weston_1.11.1.bb     |  6 ++----
 meta/recipes-graphics/xorg-app/xauth_1.0.9.bb      |  2 +-
 meta/recipes-graphics/xorg-app/xhost_1.0.7.bb      |  2 +-
 meta/recipes-graphics/xorg-lib/libice_1.0.9.bb     |  2 +-
 meta/recipes-graphics/xorg-lib/libsm_1.2.2.bb      |  2 +-
 meta/recipes-graphics/xorg-lib/libxfont2_2.0.1.bb  |  2 +-
 meta/recipes-graphics/xorg-lib/libxfont_1.5.2.bb   |  2 +-
 .../xorg-lib/libxkbcommon_0.7.1.bb                 |  2 +-
 meta/recipes-graphics/xorg-lib/libxmu_1.1.2.bb     |  2 +-
 .../recipes-graphics/xorg-xserver/xserver-xorg.inc |  4 ++--
 meta/recipes-kernel/latencytop/latencytop_0.5.bb   |  2 +-
 meta/recipes-multimedia/alsa/alsa-plugins_1.1.1.bb |  2 +-
 .../gstreamer/gstreamer1.0-plugins-bad.inc         |  2 +-
 .../gstreamer/gstreamer1.0-plugins-base.inc        |  3 +--
 .../gstreamer/gstreamer1.0-plugins-good.inc        |  3 +--
 .../gstreamer/gstreamer1.0-vaapi.inc               |  5 ++---
 .../libsndfile/libsndfile1_1.0.27.bb               |  2 +-
 meta/recipes-multimedia/mpeg2dec/mpeg2dec_0.4.1.bb |  2 +-
 meta/recipes-multimedia/mpg123/mpg123_1.23.8.bb    |  2 +-
 meta/recipes-multimedia/pulseaudio/pulseaudio.inc  |  4 +---
 meta/recipes-support/apr/apr_1.5.2.bb              |  2 +-
 .../recipes-support/consolekit/consolekit_0.4.6.bb |  3 +--
 meta/recipes-support/curl/curl_7.52.1.bb           |  2 +-
 meta/recipes-support/libcap/libcap_2.25.bb         |  2 +-
 meta/recipes-support/nspr/nspr_4.13.1.bb           |  2 +-
 75 files changed, 107 insertions(+), 117 deletions(-)

-- 
2.9.0


