Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 766717A286
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 07:49:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w917nGMK013748
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 1 Oct 2018 00:49:37 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 1 Oct 2018 00:49:32 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 1 Oct 2018 00:45:56 -0700
Message-ID: <fae96d2edfa6ec32e46150b9c1af06899335d189.1538379577.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1538379577.git.David.Reyna@windriver.com>
References: <cover.1538379577.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 2/3] toaster: add 'thud' release to Toaster
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
X-List-Received-Date: Mon, 01 Oct 2018 07:49:46 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster needs to include new YP-2.6 "Thud" release.

[YOCTO #12943]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index d7ea78d..fec93ab 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,14 +23,14 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="name">thud</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.36</field>
+    <field type="CharField" name="branch">1.40</field>
   </object>
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="name">sumo</field>
     <field type="CharField" name="description">Openembedded Sumo</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
     <field type="CharField" name="branch_name">sumo</field>
@@ -51,11 +51,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="name">thud</field>
     <field type="CharField" name="description">Openembedded Rocko</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">rocko</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=rocko\"&gt;OpenEmbedded Rocko&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">thud</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=thud\"&gt;OpenEmbedded Thud&lt;/a&gt; branch.</field>
   </object>
 
   <!-- Default layers for each release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 6c966da..fb9a771 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,9 +26,9 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="name">thud</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">thud</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
@@ -57,10 +57,10 @@
   </object>
   <object model="orm.release" pk="4">
     <field type="CharField" name="name">rocko</field>
-    <field type="CharField" name="description">Yocto Project 2.4 "Rocko"</field>
+    <field type="CharField" name="description">Yocto Project 2.6 "Thud"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">rocko</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=rocko"&gt;Yocto Project Rocko branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">thud</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=thud"&gt;Yocto Project Thud branch&lt;/a&gt;.</field>
   </object>
 
   <!-- Default project layers for each release -->
-- 
1.9.1


