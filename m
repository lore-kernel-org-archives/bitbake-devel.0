Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 2F5AD71A27
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Nov 2016 03:49:00 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id n85so2467942pfi.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Nov 2016 19:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=IWYNWmKeQcAOa+FDZL1qV87M7CwJ0OEuukT3LSM/7XY=;
	b=gMlNyu89CfN+t/CYSXeHYCdMqR1r8bLKZMViaBNc7GJ+H2qYfMXFAul9KA6IzjRaAO
	CSNKRtPuS3ubrq5OpPOnbut0mjh5LVuCjgkOTyiXQxlqkUejbW0MVtnhh1QTVNkOxaen
	KZ7VDoZADkHKLNS+vXmDcvwHtoFut3+rxq4Hq1/QCNSz10CXX9zu/rHgMvsTBVNh9zXB
	uXALhbnyj2T/wsad6l/cj1QHpa+vir+u8CMvd2ahyCZQsp1Z7b1tnDOLdk87D9yOi0GL
	aW6MYhfRh3TGBBJ1HoF8168UT0rowow7IDCIrae8QGlO0aSkjQQw281RK31kbsAxln5G
	QTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IWYNWmKeQcAOa+FDZL1qV87M7CwJ0OEuukT3LSM/7XY=;
	b=IUGE/fb5Z1e0ZTvU8RWXUk7O+fuAdCfhcVVsVU2ecFBcxjE7Klid7h0cp00MPiPVqm
	nSIsOOVi2vfh4kbzK1ImR6Ai56kTeQA0D2p696wI1lIk7vjI9AUzZQPiT0Io6P+yJWI6
	89nh0y42OWCD+MPhKS/sduk/xhHaeh02NKglR5rrxZhg66esXbZfyAvlbYF6nN14ttZT
	uElUM/1qQTKf7xR7B79ylO9WIqAmw90X3KmLKWA6eEhg4ErSk1hRB0aeAP6rzjLgekDF
	dd8sXRknDlTgfNcNzjPXk/dh0a7GjTpsuJ5891vKkfA736XhiN2JPnKkmn52Q0i1XSgF
	B3/g==
X-Gm-Message-State: ABUngvdthyRVGPlrG0emy/b/CQ2xa0soUzWz/BBFuyK0ywlqgyzfY7wvOYToP9NEhZi9iQ==
X-Received: by 10.99.140.12 with SMTP id m12mr32229954pgd.45.1478749741665;
	Wed, 09 Nov 2016 19:49:01 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id t5sm2536480pfb.58.2016.11.09.19.49.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Nov 2016 19:49:01 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Nov 2016 19:52:33 -0800
Message-Id: <48c943f2707dcc27b39e1f4ec18617bd24dbcf1c.1478749786.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c8d2d3015115bc44b7f29000463bff7840f45447.1478749786.git.brian.avery@intel.com>
References: <c8d2d3015115bc44b7f29000463bff7840f45447.1478749786.git.brian.avery@intel.com>
In-Reply-To: <cover.1478749786.git.brian.avery@intel.com>
References: <cover.1478749786.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 2/3] toaster: orm/fixtures Add the master release and correct morty release
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
X-List-Received-Date: Thu, 10 Nov 2016 03:49:00 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add the master release option to base your project on and correct the
morty release so that for poky based setups we use the poky provided
version of the layer rather than checking out the layer from its own git
repository.

[YOCTO #10497]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 23 +++++++++-
 lib/toaster/orm/fixtures/poky.xml    | 82 +++++++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index a6c834f..4d3d185 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -14,6 +14,13 @@
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">HEAD</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="3">
+    <field type="CharField" name="name">master</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">master</field>
   </object>
 
   <!-- Releases available -->
@@ -31,18 +38,30 @@
     <field type="CharField" name="branch_name">HEAD</field>
     <field type="TextField" name="helptext">Toaster will run your builds with the version of OpenEmbedded that you have cloned or downloaded to your computer.</field>
   </object>
+  <object model="orm.release" pk="3">
+    <field type="CharField" name="name">master</field>
+    <field type="CharField" name="description">OpenEmbedded core master</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
+    <field type="CharField" name="branch_name">master</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
+  </object>
 
   <!-- Default layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
-  <object model="orm.releasedefaultlayer" pk="4">
+  <object model="orm.releasedefaultlayer" pk="2">
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="3">
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
+
 
-  <!-- TYPE_LOCAL = 0 Layers for the Local release -->
+  <!-- Layer for the Local release -->
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
     <field type="CharField" name="vcs_url">git://git.openembedded.org/openembedded-core</field>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index c192baa..dcc7aaf 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -19,6 +19,13 @@
     <field type="CharField" name="branch">HEAD</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
+  <object model="orm.bitbakeversion" pk="3">
+    <field type="CharField" name="name">master</field>
+    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="dirpath">bitbake</field>
+  </object>
+
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
@@ -35,8 +42,15 @@
     <field type="CharField" name="branch_name">HEAD</field>
     <field type="TextField" name="helptext">Toaster will run your builds with the version of the Yocto Project you have cloned or downloaded to your computer.</field>
   </object>
+  <object model="orm.release" pk="3">
+    <field type="CharField" name="name">master</field>
+    <field type="CharField" name="description">Yocto Project master</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
+    <field type="CharField" name="branch_name">master</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
+  </object>
 
-  <!-- Default layers for each release -->
+  <!-- Default project layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
@@ -61,9 +75,23 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
     <field type="CharField" name="layer_name">meta-yocto-bsp</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="7">
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="8">
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field type="CharField" name="layer_name">meta-poky</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="9">
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field type="CharField" name="layer_name">meta-yocto-bsp</field>
+  </object>
 
-  <!-- Layers for the Local release
-       layersource TYPE_LOCAL = 0
+  <!-- Default layers provided by poky
+       openembedded-core
+       meta-poky
+       meta-yocto-bsp
   -->
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
@@ -73,19 +101,39 @@
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
+    <field type="CharField" name="branch">morty</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
+  <object model="orm.layer_version" pk="2">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
     <field type="CharField" name="branch">HEAD</field>
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
-
+  <object model="orm.layer_version" pk="3">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
 
   <object model="orm.layer" pk="2">
     <field type="CharField" name="name">meta-poky</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
   </object>
-  <object model="orm.layer_version" pk="2">
+  <object model="orm.layer_version" pk="4">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
+    <field type="CharField" name="branch">morty</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
+  <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -93,14 +141,27 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-
+  <object model="orm.layer_version" pk="6">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
 
   <object model="orm.layer" pk="3">
     <field type="CharField" name="name">meta-yocto-bsp</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
   </object>
-  <object model="orm.layer_version" pk="3">
+  <object model="orm.layer_version" pk="7">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
+    <field type="CharField" name="branch">morty</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
+  <object model="orm.layer_version" pk="8">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -108,4 +169,11 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
+  <object model="orm.layer_version" pk="9">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
 </django-objects>
-- 
1.9.1


