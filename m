Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3BADF60111
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 00:46:56 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x5A0kvfH028038
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 9 Jun 2019 17:46:57 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.225) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Sun, 9 Jun 2019 17:46:51 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 9 Jun 2019 17:44:55 -0700
Message-ID: <2784075cbd0cc105c8c6ecdced2226de94d4b343.1560127238.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1560127238.git.David.Reyna@windriver.com>
References: <cover.1560127238.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.209.225]
Subject: [PATCH 1/1] [THUD] toaster: Fix Thud Bitbake release for YP-2.6
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
X-List-Received-Date: Mon, 10 Jun 2019 00:46:56 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix the Bitbake version ID for Thud (1.40).

[YOCTO #13356]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 2 +-
 lib/toaster/orm/fixtures/poky.xml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index a37c664..3ed234c 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -53,7 +53,7 @@
   <object model="orm.release" pk="4">
     <field type="CharField" name="name">thud</field>
     <field type="CharField" name="description">Openembedded Thud</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
     <field type="CharField" name="branch_name">thud</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=thud\"&gt;OpenEmbedded Thud&lt;/a&gt; branch.</field>
   </object>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 482efaf..80b7ef5 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -58,7 +58,7 @@
   <object model="orm.release" pk="4">
     <field type="CharField" name="name">thud</field>
     <field type="CharField" name="description">Yocto Project 2.6 "Thud"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
     <field type="CharField" name="branch_name">thud</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=thud"&gt;Yocto Project Thud branch&lt;/a&gt;.</field>
   </object>
-- 
1.9.1


