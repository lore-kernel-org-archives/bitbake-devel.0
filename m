Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 65D5E621CA
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Jun 2013 10:15:37 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 09 Jun 2013 03:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,831,1363158000"; d="scan'208";a="347086931"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.244])
	by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2013 03:16:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  9 Jun 2013 11:15:35 +0100
Message-Id: <1370772935-12586-2-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1370772935-12586-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1370772935-12586-1-git-send-email-paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake-layers: fix for move of data object to cooker
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
X-List-Received-Date: Sun, 09 Jun 2013 10:15:37 -0000

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index ae61239..047583c 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -226,7 +226,7 @@ Options:
 
     def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only):
         pkg_pn = self.bbhandler.cooker.recipecache.pkg_pn
-        (latest_versions, preferred_versions) = bb.providers.findProviders(self.bbhandler.cooker.configuration.data, self.bbhandler.cooker.recipecache, pkg_pn)
+        (latest_versions, preferred_versions) = bb.providers.findProviders(self.bbhandler.config_data, self.bbhandler.cooker.recipecache, pkg_pn)
         allproviders = bb.providers.allProviders(self.bbhandler.cooker.recipecache)
 
         # Ensure we list skipped recipes
@@ -515,7 +515,7 @@ Recipes are listed with the bbappends that apply to them as subitems.
         filenames = self.bbhandler.cooker_data.pkg_pn[pn]
 
         best = bb.providers.findBestProvider(pn,
-                                             self.bbhandler.cooker.configuration.data,
+                                             self.bbhandler.config_data,
                                              self.bbhandler.cooker_data,
                                              self.bbhandler.cooker_data.pkg_pn)
         best_filename = os.path.basename(best[3])
@@ -598,7 +598,7 @@ The .bbappend file can impact the dependency.
             for pn in deps:
                 if pn in self.bbhandler.cooker_data.pkg_pn:
                     best = bb.providers.findBestProvider(pn,
-                            self.bbhandler.cooker.configuration.data,
+                            self.bbhandler.config_data,
                             self.bbhandler.cooker_data,
                             self.bbhandler.cooker_data.pkg_pn)
                     self.check_cross_depends("DEPENDS", layername, f, best[3], show_filenames)
@@ -616,7 +616,7 @@ The .bbappend file can impact the dependency.
                 all_p = bb.providers.getRuntimeProviders(self.bbhandler.cooker_data, rdep)
                 if all_p:
                     best = bb.providers.filterProvidersRunTime(all_p, rdep,
-                                    self.bbhandler.cooker.configuration.data,
+                                    self.bbhandler.config_data,
                                     self.bbhandler.cooker_data)[0][0]
                     self.check_cross_depends("RDEPENDS", layername, f, best, show_filenames)
 
-- 
1.8.1.2


