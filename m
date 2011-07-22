Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QkJcu-0000xQ-Cf
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 19:35:04 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 10:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30862716"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.206])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 10:30:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 18:30:34 +0100
Message-Id: <b643c4fbac6293df9fda6bc1dbbf409a27da1e42.1311355686.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/6] bitbake-layers: add command help
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
X-List-Received-Date: Fri, 22 Jul 2011 17:35:04 -0000

If you run "bitbake-layers help commandname" it now provides some useful
help text.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 56253f5..746d79d 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -76,10 +76,18 @@ class Commands(cmd.Cmd):
             self.prepare_cooker()
 
     def do_show_layers(self, args):
+        """show_layers: shows current configured layers"""
         self.check_prepare_cooker()
         logger.info(str(self.config_data.getVar('BBLAYERS', True)))
 
     def do_show_overlayed(self, args):
+        """show_overlayed: list overlayed recipes (where there is a recipe in another
+layer that has a higher layer priority)
+
+syntax: show_overlayed
+
+Highest priority recipes are listed with the recipes they overlay as subitems.
+"""
         self.check_prepare_cooker()
         if self.cooker.overlayed:
             logger.info('Overlayed recipes:')
@@ -91,9 +99,25 @@ class Commands(cmd.Cmd):
             logger.info('No overlayed recipes found')
 
     def do_flatten(self, args):
+        """flatten: flattens layer configuration into a separate output directory.
+
+syntax: flatten <outputdir>
+
+Takes the current layer configuration and builds a "flattened" directory
+containing the contents of all layers, with any overlayed recipes removed
+and bbappends appended to the corresponding recipes. Note that some manual
+cleanup may still be necessary afterwards, in particular:
+
+* where non-recipe files (such as patches) are overwritten (the flatten
+  command will show a warning for these)
+* where anything beyond the normal layer setup has been added to
+  layer.conf (only the lowest priority layer's layer.conf is used)
+* overridden/appended items from bbappends will need to be tidied up
+"""
         arglist = args.split()
         if len(arglist) != 1:
-            logger.error('syntax: flatten <outputdir>')
+            logger.error('Please specify an output directory')
+            self.do_help('flatten')
             return
 
         if os.path.exists(arglist[0]) and os.listdir(arglist[0]):
@@ -150,6 +174,12 @@ class Commands(cmd.Cmd):
         recipefile.writelines(appendfile.readlines())
 
     def do_show_appends(self, args):
+        """show_appends: List bbappend files and recipe files they apply to
+
+syntax: show_appends
+
+Recipes are listed with the bbappends that apply to them as subitems.
+"""
         self.check_prepare_cooker()
         if not self.cooker_data.appends:
             logger.info('No append files found')
-- 
1.7.4.1



