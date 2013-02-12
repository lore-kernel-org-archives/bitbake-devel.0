Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1U5G4v-0003rz-Qg
	for bitbake-devel@lists.openembedded.org;
	Tue, 12 Feb 2013 14:39:26 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 12 Feb 2013 05:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,650,1355126400"; d="scan'208";a="286145351"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2013 05:23:20 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Feb 2013 15:27:22 +0200
Message-Id: <1360675642-12435-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH_V2] bitbake & hob: reparse config files, when sanity check updates bblayers.conf
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 12 Feb 2013 13:39:37 -0000

I've sent a patch to poky, with some changes in sanity.bbclass. When bblayers.conf
is updated, it updates also a variable to know when to reparse configuration files.
This patch contains the changes to reparse conf files, after a sanity check which
changes bblayers.conf.

[YOCTO #3213]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py                    |   14 ++++++++++----
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f70a04f..9d051fa 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -977,10 +977,16 @@ class BBCooker:
             bb.fetch.fetcher_init(data)
         bb.codeparser.parser_cache_init(data)
         bb.event.fire(bb.event.ConfigParsed(), data)
-        bb.parse.init_parser(data)
-        data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
-        self.configuration.data = data
-        self.configuration.data_hash = data.get_hash()
+
+        if data.getVar("BB_INVALIDCONF") is True:
+            data.setVar("BB_INVALIDCONF", False)
+            self.parseConfigurationFiles(self.configuration.prefile,
+                                         self.configuration.postfile)
+        else:
+            bb.parse.init_parser(data)
+            data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
+            self.configuration.data = data
+            self.configuration.data_hash = data.get_hash()
 
     def handleCollections( self, collections ):
         """Handle collections"""
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index d953f34..15d28d9 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -202,6 +202,10 @@ class HobHandler(gobject.GObject):
             self.run_next_command()
 
         elif isinstance(event, bb.event.SanityCheckPassed):
+            reparse = self.runCommand(["getVariable", "BB_INVALIDCONF"]) or None
+            if reparse is True:
+                self.runCommand(["setVariable", "BB_INVALIDCONF", False])
+                self.runCommand(["parseConfigurationFiles", "", ""])
             self.run_next_command()
 
         elif isinstance(event, bb.event.SanityCheckFailed):
-- 
1.7.9.5



