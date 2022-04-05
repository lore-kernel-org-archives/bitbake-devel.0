Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C37C433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 19:49:23 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.1070.1649184044173802164
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 11:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=C1k2CxZ4;
 spf=pass (domain: gmail.com, ip: 209.85.214.174,
 mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id c23so11678413plo.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrPJY1aFPgHcitysfWLnXYlFC14tWsaAX8RdJA5nlAM=;
        b=C1k2CxZ4FEtaeJl7Ejh03gN0KG7hYeTZs1SPeszXnsgYpoT+m5skgnf+vVrSz+Vpb6
         EkPyoUKzeFAOeFlLUo4AfjK6gABfseaxWiJprLr6lIQoHsxtBe5eUSW6DaNBtBYFbVIy
         IsTzivDTcYSt2K9NbWWC8GGNeXCV2X1R/J+GYKxUiXdUaTI3cCTX04t0pyDGfZtsZmn2
         5xhtMCVex90RLfWSNYwwI5eFyWJAgciARAYoozMI/dAFTowqAmyxpr5392pmbSEEwLbD
         dr/9z0Ed/j0h4KpCe16k2fpng+HHlyXB6AEchg4N0kojEBHZUDicXNPp1naQhc5/BaqJ
         eWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrPJY1aFPgHcitysfWLnXYlFC14tWsaAX8RdJA5nlAM=;
        b=zBc1r6oCA35AgSehq8D+Cy6hGEuRvZ115UwNq+jiT2pCbCYFnKSGDn3lB0i3WaSYLq
         NUFarOVh8PJ0JKZtsK9DW/VAyIGvDIjE87kLtcJuv/DRN0V5gqQ90Jpqxwz/b32sq+BN
         0jnRs1+T9/6Qpptg1geG1OjZBaM6dgA0uumnDWcLGF/rAAg0ta4tGWteKVvsEbZVMlSO
         rVbCQB7Zl/ocvCU9PemvMVJH0e6WtVubk0bZK6+b807TLbl7cLZTswMkkLREA+HHNkRx
         X53z7ry03e2MZA3Db4qN+xzIDQyMKRvEoY7Amc2iUy7A3Au06dyZ27eOrB7+StNBm1Lc
         Nq8A==
X-Gm-Message-State: AOAM530QJvRmBFVP3i4Qu5kiZVgFyuYwW7WnuLZ7rW2cyQQA0ymp1Y+x
	TFLSVR6St6MIwurKyKtDy4OxPFl38ns=
X-Google-Smtp-Source: 
 ABdhPJyLNmsnAggpPY1qCCSTyPH6rUVPVsZwi6ay5IojdpsqBqFUoX/XevdTThADnLCIjGixknTf6A==
X-Received: by 2002:a17:90a:a78c:b0:1b8:b769:62d0 with SMTP id
 f12-20020a17090aa78c00b001b8b76962d0mr5588867pjq.227.1649184043058;
        Tue, 05 Apr 2022 11:40:43 -0700 (PDT)
Received: from nereus.hsd1.or.comcast.net
 ([2601:1c0:6000:1b20:3168:a6eb:9b6b:c371])
        by smtp.gmail.com with ESMTPSA id
 s22-20020a056a00179600b004fb28a97abdsm18424657pfg.12.2022.04.05.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:40:42 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [1.52][honister][PATCH] toaster: fixtures replace gatesgarth
Date: Tue,  5 Apr 2022 11:40:36 -0700
Message-Id: <20220405184036.2622209-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Apr 2022 19:49:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13583

Add hardknott
Add honister

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 28 +++++++---
 lib/toaster/orm/fixtures/poky.xml    | 80 ++++++++++++++++++++++------
 2 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index b01a3370..25543f6e 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,9 +23,14 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
+    <field type="CharField" name="name">hardknott</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.48</field>
+    <field type="CharField" name="branch">1.50</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
+    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">1.52</field>
   </object>
 
   <!-- Releases available -->
@@ -51,11 +56,18 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
-    <field type="CharField" name="description">Openembedded Gatesgarth</field>
+    <field type="CharField" name="name">hardknott</field>
+    <field type="CharField" name="description">Openembedded Hardknott</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">gatesgarth</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=gatesgarth\"&gt;OpenEmbedded Gatesgarth&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">hardknott</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=hardknott\"&gt;OpenEmbedded Hardknott&lt;/a&gt; branch.</field>
+  </object>
+  <object model="orm.release" pk="5">
+    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="description">Openembedded Honister</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field type="CharField" name="branch_name">honister</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=honister\"&gt;OpenEmbedded Honister&lt;/a&gt; branch.</field>
   </object>
 
   <!-- Default layers for each release -->
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
index 363789d6..5811cfae 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,9 +26,15 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
+    <field type="CharField" name="name">hardknott</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="dirpath">bitbake</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
+    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="branch">honister</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
@@ -56,11 +62,18 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
-    <field type="CharField" name="description">Yocto Project 3.2 "Gatesgarth"</field>
+    <field type="CharField" name="name">hardknott</field>
+    <field type="CharField" name="description">Yocto Project 3.3 "Hardknott"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">gatesgarth</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=gatesgarth"&gt;Yocto Project Gatesgarth branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">hardknott</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=hardknott"&gt;Yocto Project Hardknott branch&lt;/a&gt;.</field>
+  </object>
+  <object model="orm.release" pk="5">
+    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="description">Yocto Project 3.4 "Honister"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field type="CharField" name="branch_name">honister</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=honister"&gt;Yocto Project Honister branch&lt;/a&gt;.</field>
   </object>
 
   <!-- Default project layers for each release -->
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
@@ -152,7 +177,14 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
+  <object model="orm.layer_version" pk="5">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">honister</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
 
@@ -164,14 +196,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="5">
+  <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">dunfell</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="6">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -179,18 +211,25 @@
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
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
+  <object model="orm.layer_version" pk="10">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">honister</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
 
@@ -202,14 +241,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">dunfell</field>
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
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
+  <object model="orm.layer_version" pk="15">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">honister</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
-- 
2.30.2


