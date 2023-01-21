Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C2C54EAA
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 22:43:29 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.7897.1674341001884166024
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 14:43:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=JQwNpH1Q;
 spf=pass (domain: gmail.com, ip: 209.85.215.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f170.google.com with SMTP id d10so6560165pgm.13
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=il3wrwTZaiGvM/yMn1n+YAzaqgrfoyPiNbzQBGW3U1c=;
        b=JQwNpH1QD0+BFv9JWRxAXEjS3J/Lq1tEM97ayb/kB/a16NmOZNTnGuG2jwDqUCJ8L/
         fF9R8gm3zz9YRuuBfDMaHpidT5db3jwSp9JRtBDmqwh6PKc9mJSC3Abydw07SG906c/i
         FcFP7wlp9/x8mDh1KkoSigAbP/A9hiu+RMQPFMH1MOW/6djFHaqQOxEXe4NbWXOuOPKF
         TZjvC7XtByhzzhf7Oj1JWtqF+eJ8fduN0pIswFslY7yTdk1mZM8eYxMbZck2+KFosTlR
         5MATSnIf8DTJmfqwsqxJfs33JhzdWq7axGH4Z/JUwXGOMD/pmW16F3tcFmuNQz/OCvrK
         /jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=il3wrwTZaiGvM/yMn1n+YAzaqgrfoyPiNbzQBGW3U1c=;
        b=KzbgDOdEbZcllp9J9JMjHl64PKmCmX2N+00HxaSsEh/R0no4mPl0F4eliC8AYER0Mt
         krDmzQzdTSeFUlgIYruPV0eIkZIhQ2llHOgC5nVkWGB9+AIungWSLeFx7xrM8X1CeO1e
         n6qDpQPZE75MiF7oVM3xDHA3sp8zNoqQ2J+1t1Hb91Dk2y5mZ8Ra6EY4n2XBmyW00s/f
         b/8WMlh6+2a++an3NpIEQIc+wBL60pGb3GD64Tu4xgBk+7rowrjUAxbAJBCKsQ8xviJj
         usICURLQZAcbIKPcEYunN6/b9rZhAv+dMGmJEHdUve49+ZOyLqQk0RI7Q+OmecdzXHsY
         ONbQ==
X-Gm-Message-State: AFqh2krIe2ZSK3zQmokqcUIsF/zC6pfNFfGxsbq00QpM7Wq2HdU1RhMT
	UflsBqXd+uuQXq2Lpz7iXIS5TbWEaAk=
X-Google-Smtp-Source: AMrXdXueqX63tddnz4BtjSyaSlF/yuyhsITbd4iMCUSx3bOFrKvEfgfgEriXrmpEhO30JyemCyxsmA==
X-Received: by 2002:a05:6a00:4209:b0:58d:8f94:35ec with SMTP id cd9-20020a056a00420900b0058d8f9435ecmr31132751pfb.8.1674341000856;
        Sat, 21 Jan 2023 14:43:20 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:a180:2f88:c007:24cf])
        by smtp.gmail.com with ESMTPSA id z13-20020aa7990d000000b0058a313f4e4esm22848332pff.149.2023.01.21.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 14:43:20 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] toaster: update fixtures
Date: Sat, 21 Jan 2023 14:43:02 -0800
Message-Id: <20230121224302.2868254-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 22:43:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14338

* Update to latest langdale 4.1.2 and kirkstone 4.0.6
* Re-instate dunfell and update to 3.1.22
  - drop comments about bitbake crash

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/gen_fixtures.py | 18 ++-----
 lib/toaster/orm/fixtures/oe-core.xml     | 16 ++++++
 lib/toaster/orm/fixtures/poky.xml        | 62 +++++++++++++++++++++---
 3 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index ad20d6bdd..69f557657 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,26 +35,18 @@ verbose = False
 # [Codename, Yocto Project Version, Release Date, Current Version, Support Level, Poky Version, BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Kirkstone','4.0','April 2022','4.0.5 (October 2022)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
+    ['Kirkstone','4.0','April 2022','4.0.6 (December 2022)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
-    ['Langdale','4.1','October 2022','4.1.1 (November 2022)','Support for 7 months (until May 2023)','','2.2'],
+    ['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
 #   ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
-#   ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
-    # Optional Release slot #4
-    # 'dunfell' seems to have a bug:
-    # Bitbake crash
-    # Traceback (most recent call last):
-    # File "/home/usersetup/poky/bitbake/lib/bb/ui/toasterui.py", line 337, in main
-    #   buildinfohelper.update_and_store_task(event)
-    #   File "/home/usersetup/poky/bitbake/lib/bb/ui/buildinfohelper.py", line 1267, in update_and_store_task
-    #   assert identifier in self.internal_state['taskdata']
-    #   AssertionError
-#   ['Dunfell','3.1','April 2021','3.1.20 (October 2022)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
 #   ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
+#   ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
+    # Optional Release slot #5
+    ['Dunfell','3.1','April 2020','3.1.22 (January 2023)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
 ]
 
 default_poky_layers = [
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index b83b94d5f..615e88aba 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -27,6 +27,11 @@
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.2</field>
   </object>
+  <object model="orm.bitbakeversion" pk="5">
+    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">1.46</field>
+  </object>
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
@@ -57,6 +62,13 @@
     <field type="CharField" name="branch_name">langdale</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=langdale\"&gt;OpenEmbedded Langdale&lt;/a&gt; branch.</field>
   </object>
+  <object model="orm.release" pk="5">
+    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="description">Openembedded Dunfell</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field type="CharField" name="branch_name">dunfell</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=dunfell\"&gt;OpenEmbedded Dunfell&lt;/a&gt; branch.</field>
+  </object>
 
   <!-- Default layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -75,6 +87,10 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="5">
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
 
 
   <!-- Layer for the Local release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 6d58a4fdb..04e12f96f 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -31,6 +31,12 @@
     <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
+  <object model="orm.bitbakeversion" pk="5">
+    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="dirpath">bitbake</field>
+  </object>
 
 
   <!-- Releases available -->
@@ -62,6 +68,13 @@
     <field type="CharField" name="branch_name">langdale</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=langdale"&gt;Yocto Project Langdale branch&lt;/a&gt;.</field>
   </object>
+  <object model="orm.release" pk="5">
+    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="description">Yocto Project 3.1 "Dunfell"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field type="CharField" name="branch_name">dunfell</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=dunfell"&gt;Yocto Project Dunfell branch&lt;/a&gt;.</field>
+  </object>
 
   <!-- Default project layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -112,6 +125,18 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="layer_name">meta-yocto-bsp</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="13">
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="14">
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="layer_name">meta-poky</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="15">
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="layer_name">meta-yocto-bsp</field>
+  </object>
 
   <!-- Default layers provided by poky
        openembedded-core
@@ -155,6 +180,13 @@
     <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
+  <object model="orm.layer_version" pk="5">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
 
   <object model="orm.layer" pk="2">
     <field type="CharField" name="name">meta-poky</field>
@@ -164,14 +196,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="5">
+  <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="6">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -179,20 +211,27 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="7">
+  <object model="orm.layer_version" pk="8">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="8">
+  <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
+  <object model="orm.layer_version" pk="10">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
 
   <object model="orm.layer" pk="3">
     <field type="CharField" name="name">meta-yocto-bsp</field>
@@ -202,14 +241,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="10">
+  <object model="orm.layer_version" pk="12">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -217,18 +256,25 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="11">
+  <object model="orm.layer_version" pk="13">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="12">
+  <object model="orm.layer_version" pk="14">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
+  <object model="orm.layer_version" pk="15">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
 </django-objects>
-- 
2.34.1


