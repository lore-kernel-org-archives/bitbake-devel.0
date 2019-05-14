Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by mail.openembedded.org (Postfix) with ESMTP id 754C97DEDA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 May 2019 04:40:59 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id p15so7573926pll.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 May 2019 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=GRY8cWkU8jbtn25eEKzFp0F/FFcYBRLzOQaMRUkrqJs=;
	b=A0ZLvxzWFyuOQQCbqzBlZMesehhj2txw2151jB+QNpgL+I11M+SZEj8GcmU5bhHuTY
	Gf/cYe860SRm+JGftccEdMNkJoxmlNZIPGbvwT8YlUBb8x2rEUC+LiiNaJ4menNbtszC
	vgNLSpaxQMaBhb3fCU7PIgueNx+MDTAnJcxvnU3DL/dYR9qBMB81AW6/XUkuzsdB2xCP
	WkPd2pWkfydPosbnTQstDimuL0DuZBAZC9UR//Lzdr7NrYXitEo0hQGt9uIgxdxpTV2F
	UqgVt9XjClnHjPdts+ipRL87MKRo2pSDBWeHQoU3V9ZiKHj67TMCplPqPpIN55abc/Ln
	na1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=GRY8cWkU8jbtn25eEKzFp0F/FFcYBRLzOQaMRUkrqJs=;
	b=fe8WqRWLXYJkvkFMCFO421TLJn0E3v0UVx2fibrTQFNjafmjFrQtjftahMYi6KoWHk
	IFsL4Tg5Ja8Fk+3/9lxV1BMInJQbj3SkQ1m8FtzQOIV98ENWOSKfZkoJ93Obdmd+clRG
	cSZUtr06zRiOR01lWiypo6hQjIy6jfF4BFmk9w0Aii5Gtw6+XqPMzTTX/WFsDrnELqq7
	fNLqUvKHkCbKEkFNheAdqDsddNhr0TOiyx8fGmWsU9poSCs4KUaYCUexKP9DuFLbkFnq
	iEZMoOjiXxeehnB6hIBNlW8fmSLxk+ZRazaqj+I0PHVpTe3PQBEXO5H5BpjoNxFfrjo7
	e8gg==
X-Gm-Message-State: APjAAAUo/mBcEMe15QTN/mniC3tPF8UtKu98LfGEw0rlNLBkTf4Ip/U9
	4v3e7WtCw+mse1BAqg/WODSiMdXJ
X-Google-Smtp-Source: APXvYqxJmB3VfpIQpylBc4nV3Z4BuMeXQs8h0kU0Jj/+pHelqIYTMCOhlcuNwHtIf+w56VGM2zA7yA==
X-Received: by 2002:a17:902:7689:: with SMTP id
	m9mr35057064pll.274.1557808860282; 
	Mon, 13 May 2019 21:41:00 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:c33:d909:eb3d:d2ab:fd1d])
	by smtp.gmail.com with ESMTPSA id
	132sm18371323pga.79.2019.05.13.21.40.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 May 2019 21:40:59 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 May 2019 21:40:27 -0700
Message-Id: <bf513bb431aa81e5d1ab43830a0240a67914388b.1557808320.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557808320.git.akuster808@gmail.com>
References: <cover.1557808320.git.akuster808@gmail.com>
Subject: [PATCH 1/2] toaster: update to Warrior
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
X-List-Received-Date: Tue, 14 May 2019 04:40:59 -0000

From: David Reyna <David.Reyna@windriver.com>

Update the fixture files to add Warrior and remove Sumo.

[YOCTO #13287]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
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
2.7.4


