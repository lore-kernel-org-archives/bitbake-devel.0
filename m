Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id 945E66E64A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:48:23 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 90878100F84;
	Mon, 22 Aug 2016 15:42:50 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-220-3-24.us-west-2.compute.internal [10.220.3.24])
	by relay.mailchannels.net (Postfix) with ESMTPA id EF3BB1005B4;
	Mon, 22 Aug 2016 15:42:49 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880570384:495722113
X-MC-Ingress-Time: 1471880570384
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN6-0002ZA-BL; Mon, 22 Aug 2016 11:42:44 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:32 +0100
Message-Id: <1471880556-9232-5-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 5/9] toaster: Fix oe-core fixture
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
X-List-Received-Date: Mon, 22 Aug 2016 15:48:26 -0000

From: Michael Wood <michael.g.wood@intel.com>

Due to a copy paste error we managed to get some of the wrong
information in the oe fixture that provides a suggested default settings
for Toaster. This meant it tested correctly when it shouldn't have.
Fix:
 - The use of local bitbake
 - An incorrect call to realpath which didn't include its parent module.
 - The field used for the local_dir of an existing openembedded-core

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 10 ++++++----
 .../bldcontrol/management/commands/checksettings.py     | 10 ++++++----
 bitbake/lib/toaster/orm/fixtures/oe-core.xml            | 16 +++++++++-------
 bitbake/lib/toaster/orm/fixtures/poky.xml               |  6 ++++++
 bitbake/lib/toaster/orm/fixtures/settings.xml           | 17 +++++++----------
 5 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 283e154..fbc5ee9 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -98,8 +98,12 @@ class LocalhostBEController(BuildEnvironmentController):
         # 1. get a list of repos with branches, and map dirpaths for each layer
         gitrepos = {}
 
-        gitrepos[(bitbake.giturl, bitbake.commit)] = []
-        gitrepos[(bitbake.giturl, bitbake.commit)].append( ("bitbake", bitbake.dirpath) )
+        # if we're using a remotely fetched version of bitbake add its git
+        # details to the list of repos to clone
+        if bitbake.giturl and bitbake.commit:
+            gitrepos[(bitbake.giturl, bitbake.commit)] = []
+            gitrepos[(bitbake.giturl, bitbake.commit)].append(
+                ("bitbake", bitbake.dirpath))
 
         for layer in layers:
             # We don't need to git clone the layer for the CustomImageRecipe
@@ -142,8 +146,6 @@ class LocalhostBEController(BuildEnvironmentController):
 
         logger.info("Using pre-checked out source for layer %s", cached_layers)
 
-
-
         # 3. checkout the repositories
         for giturl, commit in gitrepos.keys():
             localdirname = os.path.join(self.be.sourcedir, self.getGitCloneDirectory(giturl, commit))
diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py b/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
index 0dc55f6..28b9945 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -84,8 +84,9 @@ class Command(NoArgsCommand):
                             print("Loading OE-Core configuration")
                             call_command("loaddata", "oe-core")
                             if template_conf:
-                                oe_core_path = os.realpath(template_conf +
-                                                           "/../")
+                                oe_core_path = os.path.realpath(
+                                    template_conf +
+                                    "/../")
                             else:
                                 print("TEMPLATECONF not found. You may have to"
                                       " manually configure layer paths")
@@ -94,8 +95,9 @@ class Command(NoArgsCommand):
                                                      "layer: ")
                             # Update the layer instances of openemebedded-core
                             for layer in Layer.objects.filter(
-                                    name="openembedded-core"):
-                                layer.local_source_dir = oe_core_path
+                                    name="openembedded-core",
+                                    local_source_dir="OE-CORE-LAYER-DIR"):
+                                layer.local_path = oe_core_path
                                 layer.save()
 
                         # Import the custom fixture if it's present
diff --git a/bitbake/lib/toaster/orm/fixtures/oe-core.xml b/bitbake/lib/toaster/orm/fixtures/oe-core.xml
index 9572ef6..d062de5 100644
--- a/bitbake/lib/toaster/orm/fixtures/oe-core.xml
+++ b/bitbake/lib/toaster/orm/fixtures/oe-core.xml
@@ -1,17 +1,19 @@
 <?xml version="1.0" encoding="utf-8"?>
 <django-objects version="1.0">
+  <!-- Set the project default value for DISTRO -->
+  <object model="orm.toastersetting" pk="1">
+    <field type="CharField" name="name">DEFCONF_DISTRO</field>
+    <field type="CharField" name="value">nodistro</field>
+  </object>
+
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
     <field type="CharField" name="name">master</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">master</field>
-    <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">HEAD</field>
-    <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
   <!-- Releases available -->
@@ -43,15 +45,15 @@
   <!-- TYPE_LOCAL = 0 Layers for the Local release -->
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
-    <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.openembedded.org/openembedded-core</field>
   </object> 
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
-    <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
+    <field type="CharField" name="local_path">OE-CORE-LAYER-DIR</field>
     <field type="CharField" name="branch">HEAD</field>
-    <field type="CharField" name="commit">HEAD</field>
+    <field type="CharField" name="dirpath">meta</field>
+    <field type="IntegerField" name="layer_source">0</field>
   </object>
 
 </django-objects>
diff --git a/bitbake/lib/toaster/orm/fixtures/poky.xml b/bitbake/lib/toaster/orm/fixtures/poky.xml
index 373e43d..75a2916 100644
--- a/bitbake/lib/toaster/orm/fixtures/poky.xml
+++ b/bitbake/lib/toaster/orm/fixtures/poky.xml
@@ -1,5 +1,11 @@
 <?xml version="1.0" encoding="utf-8"?>
 <django-objects version="1.0">
+  <!-- Set the project default value for DISTRO -->
+  <object model="orm.toastersetting" pk="1">
+    <field type="CharField" name="name">DEFCONF_DISTRO</field>
+    <field type="CharField" name="value">poky</field>
+  </object>
+
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
     <field type="CharField" name="name">master</field>
diff --git a/bitbake/lib/toaster/orm/fixtures/settings.xml b/bitbake/lib/toaster/orm/fixtures/settings.xml
index 64a26f5..78c0fdc 100644
--- a/bitbake/lib/toaster/orm/fixtures/settings.xml
+++ b/bitbake/lib/toaster/orm/fixtures/settings.xml
@@ -1,34 +1,31 @@
 <?xml version="1.0" encoding="utf-8"?>
 <django-objects version="1.0">
   <!-- Default project settings -->
-  <object model="orm.toastersetting" pk="1">
+  <!-- pk=1 is DISTRO -->
+  <object model="orm.toastersetting" pk="2">
     <field type="CharField" name="name">DEFAULT_RELEASE</field>
     <field type="CharField" name="value">master</field>
   </object>
-  <object model="orm.toastersetting" pk="2">
+  <object model="orm.toastersetting" pk="3">
     <field type="CharField" name="name">DEFCONF_PACKAGE_CLASSES</field>
     <field type="CharField" name="value">package_rpm</field>
   </object>
-  <object model="orm.toastersetting" pk="3">
+  <object model="orm.toastersetting" pk="4">
     <field type="CharField" name="name">DEFCONF_MACHINE</field>
     <field type="CharField" name="value">qemux86</field>
   </object>
-  <object model="orm.toastersetting" pk="4">
+  <object model="orm.toastersetting" pk="5">
     <field type="CharField" name="name">DEFCONF_SSTATE_DIR</field>
     <field type="CharField" name="value">${TOPDIR}/../sstate-cache</field>
   </object>
-  <object model="orm.toastersetting" pk="5">
+  <object model="orm.toastersetting" pk="6">
     <field type="CharField" name="name">DEFCONF_IMAGE_INSTALL_append</field>
     <field type="CharField" name="value"></field>
   </object>
-  <object model="orm.toastersetting" pk="6">
+  <object model="orm.toastersetting" pk="7">
     <field type="CharField" name="name">DEFCONF_IMAGE_FSTYPES</field>
     <field type="CharField" name="value">ext3 jffs2 tar.bz2</field>
   </object>
-  <object model="orm.toastersetting" pk="7">
-    <field type="CharField" name="name">DEFCONF_DISTRO</field>
-    <field type="CharField" name="value">poky</field>
-  </object>
   <object model="orm.toastersetting" pk="8">
     <field type="CharField" name="name">DEFCONF_DL_DIR</field>
     <field type="CharField" name="value">${TOPDIR}/../downloads</field>
-- 
2.7.4


