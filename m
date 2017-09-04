Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 767C6781C2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 04:10:40 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v844AfTL008157
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 3 Sep 2017 21:10:41 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 3 Sep 2017 21:10:41 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 3 Sep 2017 21:02:22 -0700
Message-ID: <6bd2a8b76fc0799b77ffdf99bd3b3ff9b74f57e8.1504496902.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504496902.git.David.Reyna@windriver.com>
References: <cover.1504496902.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 2/3] toaster: recipe links broken for default layers
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
X-List-Received-Date: Mon, 04 Sep 2017 04:10:40 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The default layers are missing the recipe link definitions in
the fixture files, and because they are predefined they do not
get the updated information from the Layer Index.

[YOCTO #12006]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml             | 3 +++
 lib/toaster/orm/fixtures/poky.xml                | 9 +++++++++
 lib/toaster/orm/management/commands/lsupdates.py | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index e285ec6..66c3595 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -65,6 +65,9 @@
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
     <field type="CharField" name="vcs_url">git://git.openembedded.org/openembedded-core</field>
+    <field type="CharField" name="vcs_web_url">http://cgit.openembedded.org/openembedded-core</field>
+    <field type="CharField" name="vcs_web_tree_base_url">http://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">http://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index b3f6c96..7827aac 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -97,6 +97,9 @@
     <field type="CharField" name="name">openembedded-core</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="vcs_web_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
+    <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
@@ -125,6 +128,9 @@
     <field type="CharField" name="name">meta-poky</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="vcs_web_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
+    <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="4">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
@@ -153,6 +159,9 @@
     <field type="CharField" name="name">meta-yocto-bsp</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="vcs_web_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
+    <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 54b4fab..efc6b3a 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -166,6 +166,8 @@ class Command(BaseCommand):
                 l.description = li['description']
 
                 if created:
+                    # predefined layers in the fixtures (for example poky.xml)
+                    # always preempt the Layer Index for these values
                     l.vcs_url = li['vcs_url']
                     l.vcs_web_url = li['vcs_web_url']
                     l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
-- 
1.9.1


