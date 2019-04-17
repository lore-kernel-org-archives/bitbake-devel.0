Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 4D2397D31B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 09:13:00 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x3H9D1Op020142
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 02:13:01 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.92) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 17 Apr 2019 02:13:00 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Apr 2019 02:10:49 -0700
Message-ID: <3287f9c50e1e631e03e283584406b339cf173a35.1555492152.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1555492152.git.David.Reyna@windriver.com>
References: <cover.1555492152.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.209.92]
Subject: [PATCH 1/1] toaster: update to Warrior
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
X-List-Received-Date: Wed, 17 Apr 2019 09:13:01 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Update the fixture files to add Warrior and remove Sumo.

[YOCTO #13287]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index a37c664..bd9c3268 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">sumo</field>
+    <field type="CharField" name="name">warrior</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.38</field>
+    <field type="CharField" name="branch">1.42</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
@@ -30,11 +30,11 @@
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">sumo</field>
-    <field type="CharField" name="description">Openembedded Sumo</field>
+    <field type="CharField" name="name">warrior</field>
+    <field type="CharField" name="description">Openembedded Warrior</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">sumo</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=sumo\"&gt;OpenEmbedded Sumo&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">warrior</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=warrior\"&gt;OpenEmbedded Warrior&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 482efaf..4162e4f 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">sumo</field>
+    <field type="CharField" name="name">warrior</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">sumo</field>
+    <field type="CharField" name="branch">warrior</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
@@ -35,11 +35,11 @@
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">sumo</field>
-    <field type="CharField" name="description">Yocto Project 2.5 "Sumo"</field>
+    <field type="CharField" name="name">warrior</field>
+    <field type="CharField" name="description">Yocto Project 2.7 "Warrior"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">sumo</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=sumo"&gt;Yocto Project Sumo branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">warrior</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=warrior"&gt;Yocto Project Warrior branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -130,7 +130,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">sumo</field>
+    <field type="CharField" name="branch">warrior</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="2">
@@ -168,7 +168,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">sumo</field>
+    <field type="CharField" name="branch">warrior</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
   <object model="orm.layer_version" pk="6">
@@ -206,7 +206,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">sumo</field>
+    <field type="CharField" name="branch">warrior</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
   <object model="orm.layer_version" pk="10">
-- 
1.9.1


