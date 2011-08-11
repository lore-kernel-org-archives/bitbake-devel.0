Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QreBk-0004ve-Gf
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 00:57:21 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="36965241"
Received: from vorpal.jf.intel.com ([10.7.199.53])
	by orsmga002.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2011 15:57:30 -0700
Message-Id: <73782ff26e1cd169b14f6efa89e8463b515bf8e0.1313103368.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
Subject: [PATCH 7/8] bb/ui/crumbs/configurator: introduce writeConfFile method for all writes
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
X-List-Received-Date: Thu, 11 Aug 2011 22:57:21 -0000

Configuration files are written in several places, this refactors the code
to use a common method.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py |   46 +++++++++++++++----------------------
 1 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index e17d555..c37e917 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -207,6 +207,19 @@ class Configurator(gobject.GObject):
 
         return "".join(layer_entry)
 
+    def writeConfFile(self, conffile, contents):
+        """
+        Make a backup copy of conffile and write a new file in its stead with
+        the lines in the contents list.
+        """
+        # Create a backup of the conf file
+        bkup = "%s~" % conffile
+        os.rename(conffile, bkup)
+
+        # Write the contents list object to the conf file
+        with open(conffile, "w") as new:
+            new.write("".join(contents))
+
     def writeLocalConf(self):
         # Dictionary containing only new or modified variables
         changed_values = {}
@@ -218,12 +231,8 @@ class Configurator(gobject.GObject):
         if not len(changed_values):
             return
 
-        # Create a backup of the local.conf
-        bkup = "%s~" % self.local
-        os.rename(self.local, bkup)
-
         # read the original conf into a list
-        with open(bkup, 'r') as config:
+        with open(self.local, 'r') as config:
             config_lines = config.readlines()
 
         new_config_lines = ["\n"]
@@ -259,20 +268,14 @@ class Configurator(gobject.GObject):
         # Add the modified variables
         config_lines.extend(new_config_lines)
 
-        # Write the updated lines list object to the local.conf
-        with open(self.local, "w") as n:
-            n.write("".join(config_lines))
+        self.writeConfFile(self.local, config_lines)
 
         del self.orig_config
         self.orig_config = copy.deepcopy(self.config)
 
     def insertTempBBPath(self, bbpath, bbfiles):
-        # Create a backup of the local.conf
-        bkup = "%s~" % self.local
-        os.rename(self.local, bkup)
-
         # read the original conf into a list
-        with open(bkup, 'r') as config:
+        with open(self.local, 'r') as config:
             config_lines = config.readlines()
 
         if bbpath:
@@ -280,9 +283,7 @@ class Configurator(gobject.GObject):
         if bbfiles:
             config_lines.append("BBFILES := \"${BBFILES} %s\"\n" % bbfiles)
 
-        # Write the updated lines list object to the local.conf
-        with open(self.local, "w") as n:
-            n.write("".join(config_lines))
+        self.writeConfFile(self.local, config_lines)
 
     def writeLayerConf(self):
         # If we've not added/removed new layers don't write
@@ -292,23 +293,14 @@ class Configurator(gobject.GObject):
         # This pattern should find the existing BBLAYERS
         pattern = 'BBLAYERS\s=\s\".*\"'
 
-        # Backup the users bblayers.conf
-        bkup = "%s~" % self.bblayers
-        os.rename(self.bblayers, bkup)
-
         replacement = self._constructLayerEntry()
 
-        with open(bkup, "r") as f:
+        with open(self.bblayers, "r") as f:
             contents = f.read()
             p = re.compile(pattern, re.DOTALL)
             new = p.sub(replacement, contents)
 
-        with open(self.bblayers, "w") as n:
-            n.write(new)
-
-        # At some stage we should remove the backup we've created
-        # though we should probably verify it first
-        #os.remove(bkup)
+        self.writeConfFile(self.bblayers, new)
 
         # set loaded_layers for dirtiness tracking
         self.loaded_layers = copy.deepcopy(self.enabled_layers)
-- 
1.7.6



