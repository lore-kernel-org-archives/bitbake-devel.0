Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 30464616F9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2013 14:10:04 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 21 Nov 2013 06:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,744,1378882800"; d="scan'208";a="431510149"
Received: from pmcgurk-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.225])
	by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2013 06:10:01 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2013 14:09:46 +0000
Message-Id: <1385042986-11444-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] bitbake-layers: avoid loading configuration when not needed
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
X-List-Received-Date: Thu, 21 Nov 2013 14:10:04 -0000

In recent versions of bitbake, it is not possible to initialise a
BBCooker object without having it load the configuration first. Thus we
should avoid creating the Tinfoil object here in bitbake-layers which
does that internally until we actually need to, so you can run
"bitbake-layers help" and not have to wait several seconds for the
output.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 047583c..2a7f829 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -55,10 +55,16 @@ def main(args):
 
 class Commands(cmd.Cmd):
     def __init__(self):
-        cmd.Cmd.__init__(self)
-        self.bbhandler = bb.tinfoil.Tinfoil()
+        self.bbhandler = None
         self.returncode = 0
-        self.bblayers = (self.bbhandler.config_data.getVar('BBLAYERS', True) or "").split()
+        self.bblayers = []
+        cmd.Cmd.__init__(self)
+
+    def init_bbhandler(self, config_only = False):
+        if not self.bbhandler:
+            self.bbhandler = bb.tinfoil.Tinfoil()
+            self.bblayers = (self.bbhandler.config_data.getVar('BBLAYERS', True) or "").split()
+            self.bbhandler.prepare(config_only)
 
     def default(self, line):
         """Handle unrecognised commands"""
@@ -83,7 +89,7 @@ class Commands(cmd.Cmd):
 
     def do_show_layers(self, args):
         """show current configured layers"""
-        self.bbhandler.prepare(config_only = True)
+        self.init_bbhandler(config_only = True)
         logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
         logger.plain('=' * 74)
         for layerdir in self.bblayers:
@@ -120,7 +126,7 @@ Options:
        recipes with the ones they overlay indented underneath
   -s   only list overlayed recipes where the version is the same
 """
-        self.bbhandler.prepare()
+        self.init_bbhandler()
 
         show_filenames = False
         show_same_ver_only = False
@@ -203,7 +209,7 @@ Options:
   -m   only list where multiple recipes (in the same layer or different
        layers) exist for the same recipe name
 """
-        self.bbhandler.prepare()
+        self.init_bbhandler()
 
         show_filenames = False
         show_multi_provider_only = False
@@ -341,7 +347,7 @@ build results (as the layer priority order has effectively changed).
             logger.error('Directory %s exists and is non-empty, please clear it out first' % outputdir)
             return
 
-        self.bbhandler.prepare()
+        self.init_bbhandler()
         layers = self.bblayers
         if len(arglist) > 2:
             layernames = arglist[:-1]
@@ -497,7 +503,7 @@ usage: show-appends
 
 Recipes are listed with the bbappends that apply to them as subitems.
 """
-        self.bbhandler.prepare()
+        self.init_bbhandler()
         if not self.bbhandler.cooker.collection.appendlist:
             logger.plain('No append files found')
             return
@@ -570,7 +576,7 @@ Options:
 NOTE:
 The .bbappend file can impact the dependency.
 """
-        self.bbhandler.prepare()
+        self.init_bbhandler()
 
         show_filenames = False
         for arg in args.split():
-- 
1.8.1.2


