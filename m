Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id F0BBC7C10E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Feb 2019 04:15:57 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x154FDEL025552
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 4 Feb 2019 20:15:49 -0800
Received: from dreyna-Precision-T5600.corp.ad.wrs.com (147.11.200.210) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.435.0; Mon, 4 Feb 2019 20:15:23 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 4 Feb 2019 19:40:31 -0800
Message-ID: <cb53ed19d8999b46fedaaf8ca26646469f3de7e7.1549337711.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549337711.git.David.Reyna@windriver.com>
References: <cover.1549337711.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.210]
Subject: [PATCH 1/1] toaster: correctly register the thud branch
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
X-List-Received-Date: Tue, 05 Feb 2019 04:15:58 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

There are typos in the fixture files that need to be fixed to correctly
check out the 'thud' branch.

[YOCTO #13064]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 2 +-
 lib/toaster/orm/fixtures/poky.xml    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index fec93ab..a37c664 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -52,7 +52,7 @@
   </object>
   <object model="orm.release" pk="4">
     <field type="CharField" name="name">thud</field>
-    <field type="CharField" name="description">Openembedded Rocko</field>
+    <field type="CharField" name="description">Openembedded Thud</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
     <field type="CharField" name="branch_name">thud</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=thud\"&gt;OpenEmbedded Thud&lt;/a&gt; branch.</field>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index fb9a771..482efaf 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -56,7 +56,7 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">rocko</field>
+    <field type="CharField" name="name">thud</field>
     <field type="CharField" name="description">Yocto Project 2.6 "Thud"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
     <field type="CharField" name="branch_name">thud</field>
@@ -152,7 +152,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">thud</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
 
@@ -190,7 +190,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">thud</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
 
@@ -228,7 +228,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">rocko</field>
+    <field type="CharField" name="branch">thud</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
-- 
2.7.4


