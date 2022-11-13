Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C331BC4332F
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 23:30:26 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.70.1668382222183896086
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Nov 2022 15:30:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=F2LMYdTU;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id p21so8602337plr.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 15:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGJAur1q2h7BjQUtZma9pmUIEMUt0S2+iGuXSxMNJCQ=;
        b=F2LMYdTUBqLWw4vA7zRNL3VMCb+FUgNo+Lk7cBQrlM32agLEnyKO8QxL1T8uJ3m5Qh
         MFk5FbJlfsvR5WE1pKCAqd2OAnQrEBWGq+xqnMngYlb3NT7rS9LTUOLErXs+wpFKF4hM
         eBggT0oZr/iG6NSMyDohqCI47ziE9hv/bFnA0C0bx8juUyiZcZ5kLAQKSxVlyCsczraO
         VRsNfzl5U5ElAvsHnHhJcXJvDmHi2dyyS/zd/FOvovui2EIidAppS0rfiuBSLJ7t09R3
         /yv9IOpru6/BS3zdzAhcF5TvzyOGM3J3f4MifnF9XS1iZwphk3CmHv6WZ0GSyuKKyCJh
         dgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGJAur1q2h7BjQUtZma9pmUIEMUt0S2+iGuXSxMNJCQ=;
        b=y3rCDnnZd8ZF4gtJ+oTzWvePGp6/f+RDSn+vOCSPS2hZ5/YAkITBelRPCOwAOuKby2
         S5HkPpGiyWQDrv2aPomPpncgAks8K98OYAWKfRRrRHv24e9FaLX6y3euYsHgWwda4Gyr
         oA2dZ5ZC30q9WIWyAWU363rjT8MBtegekkLEUy2m1LTZTGw9hcj80byx4RzoLPz6cFhc
         dYVJc94r9vu5eR/HrE4vquxqWjmEorn/QAGJv/urWzzhNP4A1XcRVyIJQIzaAdGJbku9
         YDGQp2AYWyZOF4JeLb2uIVDiKJ/5yM23dYNAqrlGGSWYn3miOGt1X7oYXXp8ZO7l9zYJ
         8yfg==
X-Gm-Message-State: ANoB5pmjijQKLFdoI5R6PxY9F2dZ6nDn+OX9g5sd8CLoJq9Pfa4qJpTg
	ETIyzxhKTg8EUJQtaU9mWtj5jZvWivx9ig==
X-Google-Smtp-Source: AA0mqf4GvnMP4IpNLsNxpFgoP4i8Ozp5Wf4+WVfOshBQ6WnwsdxkkW1u/3kDi5joEQG/0Yv63aNDjA==
X-Received: by 2002:a17:902:f64f:b0:186:a3bc:93a1 with SMTP id m15-20020a170902f64f00b00186a3bc93a1mr11361474plg.13.1668382221093;
        Sun, 13 Nov 2022 15:30:21 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:4998:ee9c:6c85:68ed])
        by smtp.gmail.com with ESMTPSA id c129-20020a621c87000000b00561b3ee73f6sm5404438pfc.144.2022.11.13.15.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:30:20 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [PATCH 3/3] toaster: Add refreshed oe-core and poky fixtures
Date: Sun, 13 Nov 2022 15:30:03 -0800
Message-Id: <9de8b04297b0281789a4fe051501fede4e65ca0c.1668381699.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1668381699.git.tim.orling@konsulko.com>
References: <cover.1668381699.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 23:30:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14080

After updating gen_fixtures.py, run ./gen_fixtures.py --all

This includes the latest stable/supported releases.
Currently excludes 'dunfell' as it seems to crash.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 30 +++--------
 lib/toaster/orm/fixtures/poky.xml    | 80 ++++++----------------------
 2 files changed, 24 insertions(+), 86 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 450e7a2f8..b83b94d5f 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -10,7 +10,7 @@
   <object model="orm.bitbakeversion" pk="1">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.54</field>
+    <field type="CharField" name="branch">2.0</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
@@ -23,14 +23,9 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="name">langdale</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.52</field>
-  </object>
-  <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">hardknott</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.50</field>
+    <field type="CharField" name="branch">2.2</field>
   </object>
 
   <!-- Releases available -->
@@ -56,18 +51,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">honister</field>
-    <field type="CharField" name="description">Openembedded Honister</field>
+    <field type="CharField" name="name">langdale</field>
+    <field type="CharField" name="description">Openembedded Langdale</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">honister</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=honister\"&gt;OpenEmbedded Honister&lt;/a&gt; branch.</field>
-  </object>
-  <object model="orm.release" pk="5">
-    <field type="CharField" name="name">hardknott</field>
-    <field type="CharField" name="description">Openembedded Hardknott</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">hardknott</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=hardknott\"&gt;OpenEmbedded Hardknott&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">langdale</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=langdale\"&gt;OpenEmbedded Langdale&lt;/a&gt; branch.</field>
   </object>
 
   <!-- Default layers for each release -->
@@ -87,10 +75,6 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
-  <object model="orm.releasedefaultlayer" pk="5">
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="layer_name">openembedded-core</field>
-  </object>
 
 
   <!-- Layer for the Local release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 20fcc0176..6d58a4fdb 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,15 +26,9 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="name">langdale</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">honister</field>
-    <field type="CharField" name="dirpath">bitbake</field>
-  </object>
-  <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">hardknott</field>
-    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
@@ -62,18 +56,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">honister</field>
-    <field type="CharField" name="description">Yocto Project 3.4 "Honister"</field>
+    <field type="CharField" name="name">langdale</field>
+    <field type="CharField" name="description">Yocto Project 4.1 "Langdale"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">honister</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=honister"&gt;Yocto Project Honister branch&lt;/a&gt;.</field>
-  </object>
-  <object model="orm.release" pk="5">
-    <field type="CharField" name="name">hardknott</field>
-    <field type="CharField" name="description">Yocto Project 3.3 "Hardknott"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">hardknott</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=hardknott"&gt;Yocto Project Hardknott branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">langdale</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=langdale"&gt;Yocto Project Langdale branch&lt;/a&gt;.</field>
   </object>
 
   <!-- Default project layers for each release -->
@@ -125,18 +112,6 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="layer_name">meta-yocto-bsp</field>
   </object>
-  <object model="orm.releasedefaultlayer" pk="13">
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="layer_name">openembedded-core</field>
-  </object>
-  <object model="orm.releasedefaultlayer" pk="14">
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="layer_name">meta-poky</field>
-  </object>
-  <object model="orm.releasedefaultlayer" pk="15">
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="layer_name">meta-yocto-bsp</field>
-  </object>
 
   <!-- Default layers provided by poky
        openembedded-core
@@ -177,14 +152,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">honister</field>
-    <field type="CharField" name="dirpath">meta</field>
-  </object>
-  <object model="orm.layer_version" pk="5">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
 
@@ -196,14 +164,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="6">
+  <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="7">
+  <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -211,25 +179,18 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="8">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="8">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">honister</field>
-    <field type="CharField" name="dirpath">meta-poky</field>
-  </object>
-  <object model="orm.layer_version" pk="10">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
 
@@ -241,14 +202,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="11">
+  <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="12">
+  <object model="orm.layer_version" pk="10">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -256,25 +217,18 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="13">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="14">
+  <object model="orm.layer_version" pk="12">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">honister</field>
-    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
-  </object>
-  <object model="orm.layer_version" pk="15">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
-- 
2.34.1


