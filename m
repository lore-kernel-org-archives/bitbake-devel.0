Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 94E7B73D46
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 17:04:42 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 03 Nov 2015 09:04:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,239,1444719600"; d="scan'208";a="841667378"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 03 Nov 2015 09:04:00 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 757916A4083;
	Tue,  3 Nov 2015 09:02:56 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Nov 2015 19:03:49 +0200
Message-Id: <1446570229-7700-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] qemu-native: fix build on Ubuntu 15.10
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
X-List-Received-Date: Tue, 03 Nov 2015 17:04:43 -0000

Build of qemu-native on Ubuntu 15.10 fails on configure step.
The reason for this is that system dbus version is higher than
oe dbus version and system pulseaudio libraries require newer dbus.

It causes configure to break with a lot of errors similar to this:
  libpulsecommon-6.0.so: undefined reference to dbus_watch_get_enabled@LIBDBUS_1_3

Fixed by building qemu-native with the system dbus on Ubuntu 15.10

Note: This is a workaround. It must be removed when oe dbus is upgraded
to the version >= system dbus version (1.10.0 at the moment).

[YOCTO #8553]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 meta/recipes-devtools/qemu/qemu.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meta/recipes-devtools/qemu/qemu.inc b/meta/recipes-devtools/qemu/qemu.inc
index abbace8..b17da2f 100644
--- a/meta/recipes-devtools/qemu/qemu.inc
+++ b/meta/recipes-devtools/qemu/qemu.inc
@@ -40,6 +40,12 @@ do_configure_prepend_class-native() {
 	BHOST_PKGCONFIG_PATH=$(PATH=/usr/bin:/bin pkg-config --variable pc_path pkg-config || echo "")
 	if [ ! -z "$BHOST_PKGCONFIG_PATH" ]; then
 		export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BHOST_PKGCONFIG_PATH
+		# link with system dbus on Ubuntu 15.10
+		# FIXME: remove below 4 lines when oe dbus is upgraded
+		if [ -r /etc/lsb-release -a "$(lsb_release -is)$(lsb_release -rs)" = "Ubuntu15.10" ] ; then
+			libs=$(PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 PKG_CONFIG_PATH=$BHOST_PKGCONFIG_PATH PATH=/usr/bin:/bin pkg-config --libs dbus-1 || echo "")
+			[ -n "$libs" ] && export LDFLAGS="$libs $LDFLAGS"
+		fi
 	fi
 }
 
-- 
2.1.4


