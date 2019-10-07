Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E73AE7D6C2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Oct 2019 04:42:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x974gmNP004725
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 6 Oct 2019 21:42:49 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.225) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.468.0; Sun, 6 Oct 2019 21:42:48 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 6 Oct 2019 21:41:17 -0700
Message-ID: <2cfa65355b52aac8ed68469ca8db64406c6c5675.1570423041.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1570423041.git.David.Reyna@windriver.com>
References: <cover.1570423041.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.209.225]
Subject: [PATCH 1/1] toaster: Enable Zeus branch in place of Thud
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
X-List-Received-Date: Mon, 07 Oct 2019 04:42:48 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster directly supports the last two stable branches of Yocto
Project. With "Zeus" being released, it is time to replace "Thud".

[YOCTO #13579]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 9ae2e42..a723f5a 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,9 +23,9 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">thud</field>
+    <field type="CharField" name="name">zeus</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.40</field>
+    <field type="CharField" name="branch">1.44</field>
   </object>
 
   <!-- Releases available -->
@@ -51,11 +51,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">thud</field>
-    <field type="CharField" name="description">Openembedded Thud</field>
+    <field type="CharField" name="name">zeus</field>
+    <field type="CharField" name="description">Openembedded Zeus</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">thud</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=thud\"&gt;OpenEmbedded Thud&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">zeus</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=zeus\"&gt;OpenEmbedded Zeus&lt;/a&gt; branch.</field>
   </object>
 
   <!-- Default layers for each release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index da3b930..7992383 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,9 +26,9 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">thud</field>
+    <field type="CharField" name="name">zeus</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">thud</field>
+    <field type="CharField" name="branch">zeus</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
@@ -56,11 +56,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">thud</field>
-    <field type="CharField" name="description">Yocto Project 2.6 "Thud"</field>
+    <field type="CharField" name="name">zeus</field>
+    <field type="CharField" name="description">Yocto Project 3.0 "Zeus"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">thud</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=thud"&gt;Yocto Project Thud branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">zeus</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=zeus"&gt;Yocto Project Zeus branch&lt;/a&gt;.</field>
   </object>
 
   <!-- Default project layers for each release -->
@@ -152,7 +152,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">thud</field>
+    <field type="CharField" name="branch">zeus</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
 
@@ -190,7 +190,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">thud</field>
+    <field type="CharField" name="branch">zeus</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
 
@@ -228,7 +228,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">thud</field>
+    <field type="CharField" name="branch">zeus</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
-- 
1.9.1


