Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QruRj-0007qD-Ee
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 18:18:55 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Aug 2011 09:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,363,1309762800"; d="scan'208";a="38827050"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.18.64])
	by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2011 09:14:02 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:13:56 +0100
Message-Id: <a163dd0ec242f5b12139672a639f4e78392de15c.1313165343.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] bitbake-layers: improve default command help
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
X-List-Received-Date: Fri, 12 Aug 2011 16:18:55 -0000

Improve default help output and make unrecognised commands print it out
rather than just an error.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index d9f95d1..0900d00 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -76,16 +76,36 @@ class Commands(cmd.Cmd):
         if not self.cooker_data:
             self.prepare_cooker()
 
+    def default(self, line):
+        """Handle unrecognised commands"""
+        sys.stderr.write("Unrecognised command or option\n")
+        self.do_help('')
+
+    def do_help(self, topic):
+        """display general help or help on a specified command"""
+        if topic:
+            sys.stdout.write('%s: ' % topic)
+            cmd.Cmd.do_help(self,topic)
+        else:
+            sys.stdout.write("usage: bitbake-layers <command> [arguments]\n\n")
+            sys.stdout.write("Available commands:\n")
+            procnames = self.get_names()
+            for procname in procnames:
+                if procname[:3] == 'do_':
+                    sys.stdout.write("  %s\n" % procname[3:])
+                    doc = getattr(self, procname).__doc__
+                    if doc:
+                        sys.stdout.write("    %s\n" % doc.splitlines()[0])
+
     def do_show_layers(self, args):
-        """show_layers: shows current configured layers"""
+        """show current configured layers"""
         self.check_prepare_cooker()
         logger.info(str(self.config_data.getVar('BBLAYERS', True)))
 
     def do_show_overlayed(self, args):
-        """show_overlayed: list overlayed recipes (where there is a recipe in another
-layer that has a higher layer priority)
+        """list overlayed recipes (where there is a recipe in another layer that has a higher layer priority)
 
-syntax: show_overlayed
+usage: show_overlayed
 
 Highest priority recipes are listed with the recipes they overlay as subitems.
 """
@@ -100,9 +120,9 @@ Highest priority recipes are listed with the recipes they overlay as subitems.
             logger.info('No overlayed recipes found')
 
     def do_flatten(self, args):
-        """flatten: flattens layer configuration into a separate output directory.
+        """flattens layer configuration into a separate output directory.
 
-syntax: flatten <outputdir>
+usage: flatten <outputdir>
 
 Takes the current layer configuration and builds a "flattened" directory
 containing the contents of all layers, with any overlayed recipes removed
@@ -175,9 +195,9 @@ cleanup may still be necessary afterwards, in particular:
         recipefile.writelines(appendfile.readlines())
 
     def do_show_appends(self, args):
-        """show_appends: List bbappend files and recipe files they apply to
+        """list bbappend files and recipe files they apply to
 
-syntax: show_appends
+usage: show_appends
 
 Recipes are listed with the bbappends that apply to them as subitems.
 """
-- 
1.7.4.1



