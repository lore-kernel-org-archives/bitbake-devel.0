Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 282CC6A960
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 11:18:08 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 26 Jul 2013 04:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,750,1367996400"; d="scan'208";a="337283448"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by azsmga001.ch.intel.com with ESMTP; 26 Jul 2013 04:18:07 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Jul 2013 14:20:36 +0300
Message-Id: <1374837636-16094-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: delete an unused function used before for variable from configuration
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 26 Jul 2013 11:18:09 -0000

This function was used to filter the variables saved with the
termination "_HOB". Now all the variables are saved in conf/ directory
in order to be seen the same both from Hob and from command line.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index a7bd21c..6a8c5ba 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -300,30 +300,6 @@ class Parameters:
         self.distro_version = params["distro_version"]
         self.tune_pkgarch = params["tune_pkgarch"]
 
-def hob_conf_filter(fn, data):
-    if fn.endswith("/local.conf"):
-        distro = data.getVar("DISTRO_HOB")
-        if distro:
-            if distro != "defaultsetup":
-                data.setVar("DISTRO", distro)
-            else:
-                data.delVar("DISTRO")
-
-        keys = ["MACHINE_HOB", "SDKMACHINE_HOB", "PACKAGE_CLASSES_HOB", \
-                "BB_NUMBER_THREADS_HOB", "PARALLEL_MAKE_HOB", "DL_DIR_HOB", \
-                "SSTATE_DIR_HOB", "SSTATE_MIRRORS_HOB", "INCOMPATIBLE_LICENSE_HOB"]
-        for key in keys:
-            var_hob = data.getVar(key)
-            if var_hob:
-                data.setVar(key.split("_HOB")[0], var_hob)
-        return
-
-    if fn.endswith("/bblayers.conf"):
-        layers = data.getVar("BBLAYERS_HOB")
-        if layers:
-            data.setVar("BBLAYERS", layers)
-        return
-
 class Builder(gtk.Window):
 
     (INITIAL_CHECKS,
-- 
1.7.9.5


