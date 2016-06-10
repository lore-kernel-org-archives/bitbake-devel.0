Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 85B6962134
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jun 2016 19:50:53 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 10 Jun 2016 12:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,451,1459839600"; d="scan'208";a="717146758"
Received: from yctb01.ostc.intel.com (HELO yctb01.otcr.intel.com)
	([10.54.69.55])
	by FMSMGA003.fm.intel.com with ESMTP; 10 Jun 2016 12:50:33 -0700
From: mariano.lopez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2016 11:45:20 +0000
Message-Id: <3da6a3ae457fb93388b3ae2a255a043b60626f42.1465559091.git.mariano.lopez@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1465559091.git.mariano.lopez@linux.intel.com>
References: <cover.1465559091.git.mariano.lopez@linux.intel.com>
Subject: [PATCH 1/1] update-rc.d.bbclass: Disable class when sysvinit is not in DISTRO_FEATURES
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
X-List-Received-Date: Fri, 10 Jun 2016 19:50:55 -0000

From: Mariano Lopez <mariano.lopez@linux.intel.com>

When sysvinit is not in use, update-rd.d class adds build dependencies
that won't be needed, this patch removes the build dependecies and
won't add the task to PACKAGESPLITFUNCS.

[YOCTO #9515]

Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
---
 meta/classes/update-rc.d.bbclass | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/meta/classes/update-rc.d.bbclass b/meta/classes/update-rc.d.bbclass
index 2a0a74a..82b8024 100644
--- a/meta/classes/update-rc.d.bbclass
+++ b/meta/classes/update-rc.d.bbclass
@@ -1,6 +1,7 @@
 UPDATERCPN ?= "${PN}"
 
-DEPENDS_append_class-target = " update-rc.d-native update-rc.d initscripts"
+DEPENDS_append_class-target = "${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', ' update-rc.d-native update-rc.d initscripts', '', d)}"
+
 UPDATERCD = "update-rc.d"
 UPDATERCD_class-cross = ""
 UPDATERCD_class-native = ""
@@ -64,7 +65,7 @@ python __anonymous() {
     update_rc_after_parse(d)
 }
 
-PACKAGESPLITFUNCS_prepend = "populate_packages_updatercd "
+PACKAGESPLITFUNCS_prepend = "${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'populate_packages_updatercd ', '', d)}"
 PACKAGESPLITFUNCS_remove_class-nativesdk = "populate_packages_updatercd "
 
 populate_packages_updatercd[vardeps] += "updatercd_prerm updatercd_postrm updatercd_preinst updatercd_postinst"
@@ -120,8 +121,7 @@ python populate_packages_updatercd () {
 
     # Check that this class isn't being inhibited (generally, by
     # systemd.bbclass) before doing any work.
-    if bb.utils.contains('DISTRO_FEATURES', 'sysvinit', True, False, d) or \
-       not d.getVar("INHIBIT_UPDATERCD_BBCLASS", True):
+    if not d.getVar("INHIBIT_UPDATERCD_BBCLASS", True):
         pkgs = d.getVar('INITSCRIPT_PACKAGES', True)
         if pkgs == None:
             pkgs = d.getVar('UPDATERCPN', True)
-- 
2.6.6


