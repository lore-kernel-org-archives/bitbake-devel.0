Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Safss-0001xR-An
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Jun 2012 06:24:14 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Jun 2012 21:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="147239223"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 01 Jun 2012 21:13:51 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Jun 2012 12:54:37 +0800
Message-Id: <be51f2ef1496567a3011b9dc07bab6a2f44105c3.1338612620.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <5b4c1d6a5c75f186454ed87614e4e9926f5b2d3a.1338612620.git.shane.wang@intel.com>
References: <5b4c1d6a5c75f186454ed87614e4e9926f5b2d3a.1338612620.git.shane.wang@intel.com>
In-Reply-To: <cover.1338612620.git.shane.wang@intel.com>
References: <cover.1338612620.git.shane.wang@intel.com>
Subject: [PATCH 2/3] Hob: add versions for compatibility check between Hob and templates
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
X-List-Received-Date: Sat, 02 Jun 2012 04:24:14 -0000

If a user uses a very old version of Hob and does some work,
later on he/she upgrade to the latest version of Hob, because
Hob may change the settings (add more config option into the Adv.
Settings dialog or remove some), then the old templates are not
loadable and workable for the new Hob.

Even though the user hasn't save any template before, the Hob could
remember the settings between Hob sessions as a default template,
(Remember we have a bug to ask Hob remember between sessions?),
the new Hob will also load the default template.

By adding versions, we can easily to fix the issue. If the versions
don't match, Hob will remove the old default template first and
initiate a new build, which has very very little impact on the user.
(Just can't remember from the previous session after the user upgrades
to a new and incompatible Hob)

[Yocto #2492]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py  |   14 ++++++++++++--
 bitbake/lib/bb/ui/crumbs/template.py |   17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 8d35ea9..eaf18ab 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -40,6 +40,8 @@ from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
 from bb.ui.crumbs.persistenttooltip import PersistentTooltip
 import bb.ui.crumbs.utils
 
+hobVer = 20120530
+
 class Configuration:
     '''Represents the data structure of configuration.'''
 
@@ -222,6 +224,7 @@ class Configuration:
         self.split_proxy("cvs", template.getVar("CVS_PROXY_HOST") + ":" + template.getVar("CVS_PROXY_PORT"))
 
     def save(self, template, defaults=False):
+        template.setVar("VERSION", "%s" % hobVer)
         # bblayers.conf
         template.setVar("BBLAYERS", " ".join(self.layers))
         # local.conf
@@ -468,7 +471,7 @@ class Builder(gtk.Window):
 
     def initiate_new_build_async(self):
         self.switch_page(self.MACHINE_SELECTION)
-        if self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/")) == None:
+        if self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/")) == False:
             self.handler.init_cooker()
             self.handler.set_extra_inherit("image_types")
             self.handler.generate_configuration()
@@ -537,9 +540,16 @@ class Builder(gtk.Window):
 
     def load_template(self, path):
         if not os.path.isfile(path):
-            return None
+            return False
 
         self.template = TemplateMgr()
+        # check compatibility
+        tempVer = self.template.getVersion(path)
+        if not tempVer or int(tempVer) < hobVer:
+            self.template.destroy()
+            self.template = None
+            return False
+
         try:
             self.template.load(path)
             self.configuration.load(self.template)
diff --git a/bitbake/lib/bb/ui/crumbs/template.py b/bitbake/lib/bb/ui/crumbs/template.py
index cbed270..7309bb6 100644
--- a/bitbake/lib/bb/ui/crumbs/template.py
+++ b/bitbake/lib/bb/ui/crumbs/template.py
@@ -101,7 +101,19 @@ class HobTemplateFile(ConfigFile):
             return self.dictionary[var]
         else:
             return ""
- 
+
+    def getVersion(self):
+        contents = ConfigFile.readFile(self)
+
+        pattern = "^\s*(\S+)\s*=\s*(\".*?\")"
+
+        for line in contents:
+            match = re.search(pattern, line)
+            if match:
+                if match.group(1) == "VERSION":
+                    return match.group(2).strip('"')
+        return None
+
     def load(self):
         contents = ConfigFile.readFile(self)
         self.dictionary.clear()
@@ -174,6 +186,9 @@ class TemplateMgr(gobject.GObject):
         self.image_bb.save()
         self.template_hob.save()
 
+    def getVersion(self, path):
+        return HobTemplateFile(path).getVersion()
+
     def load(self, path):
         self.template_hob = HobTemplateFile(path)
         self.dictionary = self.template_hob.load()
-- 
1.7.6



