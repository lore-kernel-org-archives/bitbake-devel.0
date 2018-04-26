Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 68E5974559
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Apr 2018 06:09:41 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w3Q69gjq006339
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Apr 2018 23:09:42 -0700 (PDT)
Received: from ord-dlerner-d8.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Wed, 25 Apr 2018 23:09:41 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Apr 2018 00:53:28 -0500
Message-ID: <a57224f70c7ca5561d16bf5afb622fe127bfac4b.1524721541.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1524721541.git.david.reyna@windriver.com>
References: <cover.1524721541.git.david.reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/1] toaster: add 'Sumo' to release selection
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
X-List-Received-Date: Thu, 26 Apr 2018 06:09:41 -0000
Content-Type: text/plain

Add Sumo (YP-2.5) to the release selection for new projects.

[YOCTO #12713]

Signed-off-by: David Reyna <david.reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 26 +++++++++---
 lib/toaster/orm/fixtures/poky.xml    | 76 +++++++++++++++++++++++++++++-------
 2 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 00720c3da9a..d7ea78dc294 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="name">sumo</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.36</field>
+    <field type="CharField" name="branch">1.38</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
@@ -22,14 +22,19 @@
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">master</field>
   </object>
+  <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">1.36</field>
+  </object>
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
     <field type="CharField" name="name">rocko</field>
-    <field type="CharField" name="description">Openembedded Rocko</field>
+    <field type="CharField" name="description">Openembedded Sumo</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">rocko</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=rocko\"&gt;OpenEmbedded Rocko&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">sumo</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=sumo\"&gt;OpenEmbedded Sumo&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -45,6 +50,13 @@
     <field type="CharField" name="branch_name">master</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
+  <object model="orm.release" pk="4">
+    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="description">Openembedded Rocko</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field type="CharField" name="branch_name">rocko</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=rocko\"&gt;OpenEmbedded Rocko&lt;/a&gt; branch.</field>
+  </object>
 
   <!-- Default layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -59,6 +71,10 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="4">
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
 
 
   <!-- Layer for the Local release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 2f39d7776dd..6c966da4a92 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="name">sumo</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">sumo</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
@@ -25,15 +25,21 @@
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
+  <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="dirpath">bitbake</field>
+  </object>
 
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">rocko</field>
-    <field type="CharField" name="description">Yocto Project 2.4 "Rocko"</field>
+    <field type="CharField" name="name">sumo</field>
+    <field type="CharField" name="description">Yocto Project 2.5 "Sumo"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">rocko</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=rocko"&gt;Yocto Project Rocko branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">sumo</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=sumo"&gt;Yocto Project Sumo branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -49,6 +55,13 @@
     <field type="CharField" name="branch_name">master</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
+  <object model="orm.release" pk="4">
+    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="description">Yocto Project 2.4 "Rocko"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field type="CharField" name="branch_name">rocko</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=rocko"&gt;Yocto Project Rocko branch&lt;/a&gt;.</field>
+  </object>
 
   <!-- Default project layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -87,6 +100,18 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="layer_name">meta-yocto-bsp</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="10">
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="11">
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="layer_name">meta-poky</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="12">
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="layer_name">meta-yocto-bsp</field>
+  </object>
 
   <!-- Default layers provided by poky
        openembedded-core
@@ -105,7 +130,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">sumo</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="2">
@@ -123,6 +148,13 @@
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
+  <object model="orm.layer_version" pk="4">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
 
   <object model="orm.layer" pk="2">
     <field type="CharField" name="name">meta-poky</field>
@@ -132,14 +164,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="4">
+  <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">sumo</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="5">
+  <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -147,13 +179,20 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="6">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
+  <object model="orm.layer_version" pk="8">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
 
   <object model="orm.layer" pk="3">
     <field type="CharField" name="name">meta-yocto-bsp</field>
@@ -163,14 +202,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="7">
+  <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">sumo</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="8">
+  <object model="orm.layer_version" pk="10">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -178,11 +217,18 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
+  <object model="orm.layer_version" pk="12">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
 </django-objects>
-- 
2.11.0


