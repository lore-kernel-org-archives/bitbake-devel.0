Return-Path: <irina.patru@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B12836B05F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jan 2014 09:46:01 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 23 Jan 2014 01:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,705,1384329600"; d="scan'208";a="463399771"
Received: from irina-vostro-460.rb.intel.com ([10.237.105.140])
	by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2014 01:45:49 -0800
From: Irina Patru <irina.patru@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jan 2014 11:49:42 +0200
Message-Id: <1390470583-30319-1-git-send-email-irina.patru@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <y>
References: <y>
Subject: [PATCH 1/2] hob: Don't always save proxy values in conf file
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
X-List-Received-Date: Thu, 23 Jan 2014 09:46:02 -0000

If enable_proxy is not activated, Hob should not save the proxy values
in the conf file when user hits save button.

[ HOB #5308 ]

Signed-off-by: Irina Patru <irina.patru@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 1eae814..7bc3227 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -229,12 +229,20 @@ class Configuration:
         # proxy
         handler.set_var_in_file("enable_proxy", self.enable_proxy, "local.conf")
         handler.set_var_in_file("use_same_proxy", self.same_proxy, "local.conf")
-        handler.set_var_in_file("http_proxy", self.combine_proxy("http"), "local.conf")
-        handler.set_var_in_file("https_proxy", self.combine_proxy("https"), "local.conf")
-        handler.set_var_in_file("ftp_proxy", self.combine_proxy("ftp"), "local.conf")
-        handler.set_var_in_file("all_proxy", self.combine_proxy("socks"), "local.conf")
-        handler.set_var_in_file("CVS_PROXY_HOST", self.combine_host_only("cvs"), "local.conf")
-        handler.set_var_in_file("CVS_PROXY_PORT", self.combine_port_only("cvs"), "local.conf")
+        if self.enable_proxy == True:
+            handler.set_var_in_file("http_proxy", self.combine_proxy("http"), "local.conf")
+            handler.set_var_in_file("https_proxy", self.combine_proxy("https"), "local.conf")
+            handler.set_var_in_file("ftp_proxy", self.combine_proxy("ftp"), "local.conf")
+            handler.set_var_in_file("all_proxy", self.combine_proxy("socks"), "local.conf")
+            handler.set_var_in_file("CVS_PROXY_HOST", self.combine_host_only("cvs"), "local.conf")
+            handler.set_var_in_file("CVS_PROXY_PORT", self.combine_port_only("cvs"), "local.conf")
+        else:
+            handler.set_var_in_file("http_proxy", "", "local.conf")
+            handler.set_var_in_file("https_proxy", "", "local.conf")
+            handler.set_var_in_file("ftp_proxy", "", "local.conf")
+            handler.set_var_in_file("all_proxy", "", "local.conf")
+            handler.set_var_in_file("CVS_PROXY_HOST", "", "local.conf")
+            handler.set_var_in_file("CVS_PROXY_PORT", "", "local.conf")
 
     def __str__(self):
         s = "VERSION: '%s', BBLAYERS: '%s', MACHINE: '%s', DISTRO: '%s', DL_DIR: '%s'," % \
-- 
1.7.9.5


