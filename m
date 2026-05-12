Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742DFCD4F26
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 08:27:43 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71002.1778574461986330750
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 01:27:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LndYD+sZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-449de065cb3so4735745f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778574460; x=1779179260; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcKvCHhT6wVwW3j4s+kDbZvhwXJ5jW1+KMOBXMFuQeI=;
        b=LndYD+sZLRzwUru4YxB854W5avTM0meXlcXVa5tvGBPuArL8PGe53BlvbeMLsUPzDr
         9S8O/IzIsuiRiRyxRfSM2NXDiOxbH1L8QR+B8RAk2hM2JMNh1EUkgC4WdmKJL7EpFqlo
         sHzj0ckn2v4YCUWtwRC/kmrZnsZT36r+c2nwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574460; x=1779179260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcKvCHhT6wVwW3j4s+kDbZvhwXJ5jW1+KMOBXMFuQeI=;
        b=Yd4WOr2sj5OuIlNwmTVlaGEAme9l+0ca6ABZF2+0h6PPXCemt5EWxoIAc4AfSVhKKi
         oWaa2x2beaucAu/Ffi3vbHDOrl0L+d/onj3YQVEXUmDuqAohj1sl3Xatq0pPBjoqFQZW
         PvD76QsjS4+4GhVQzphvRu06lRz7Ztonj0z8hVGDYhrc6qpEUtOk4UD1lRhcnLQDs1g1
         VC80ILksCx/K5ZjahlZVvTfvyZMe8DgsM6b5EY9J7zum314NIWunhSwSLXsfiXMXagj7
         ejBiCTRDscEWO+5DMWyw5Qbhd5RFJjVKolus8prI6HqxpE0AFP674sJ1/TnrDFr+ZYpK
         ndmg==
X-Gm-Message-State: AOJu0Ywu3Hue+jG8WDzTO1mNonrvrrRUNGxGXH9z6hCSzmLscvBtvf3q
	tHeuFmNdY3cHi/3dFMwIuuPSWScM5oAtUV2uyNmr6BiptrFGw7Rzz5AOpXpcGqbZf0S1P9j8HvO
	FtyO3
X-Gm-Gg: Acq92OE50aFbG219Lq94ReKYy6KhSU28jfnxlqO5lsF1zyTNKGEZPoxDtH4IwUKixcY
	/68wr4i9eyalca92x5YTNjSfr0/X9MpWN+D3LvK2lQuUF6aCIOkUnbdZO2i7cvB/2lGgxN3tqUs
	eIDXXzZQE3Rr2c2LEDd1E3XRQvnR3f9VW2vq1aOYyjofyf3uNiOM8gG5BPzCOfBMRGi2DYw+mwP
	JML2eNAyeKaLIhphbzyrwksdXyew/24jBfBV650jO7+ECExdMTNwkQQZo5CDqUZpT9b3rh+OrFq
	eJW2B683JzDxenSmzZ/mOYRViHRhlwJGtTwExdV9qo9f0T8kFBimoclcU9Bt/59cpEUCUSc62AS
	5d7j4VWEctwGRt3QusRw5PlGmwRYoBYEJj7i2mQ4vsujhL74gRoJ14dIY5IA0JQST3PhusDMlpq
	49Dm5UZKT9FWCtMD0k+577wST1eJjVXLm+fLDZgJq9Fs4hUsVCzTEM
X-Received: by 2002:a05:6000:1789:b0:441:1c06:17e4 with SMTP id ffacd0b85a97d-4515da9544cmr45018015f8f.39.1778574459533;
        Tue, 12 May 2026 01:27:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:44a5:ca0b:d27c:9664])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca383asm30413416f8f.28.2026.05.12.01.27.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:27:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster/fixtures: Drop kirkstone/whinlatter
Date: Tue, 12 May 2026 09:27:38 +0100
Message-ID: <20260512082738.2211638-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 08:27:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19497

kirkstone and whinlatter and EOL and no longer supported. Remove them
from toaster's menus.

Also remove a test case which is no longer needed for kirkstone.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/gen_fixtures.py      |   4 +-
 lib/toaster/orm/fixtures/oe-core.xml          |  32 ------
 lib/toaster/orm/fixtures/poky.xml             | 108 ++----------------
 .../functional/test_create_new_project.py     |  16 ---
 4 files changed, 10 insertions(+), 150 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 9488ce852e3..8c03d9c9ed1 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -42,12 +42,12 @@ current_releases = [
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
     ['Scarthgap','5.0','April 2024','5.0 (April 2024)','Long Term Support (until April 2028)','','2.8'],
+    #['Whinlatter','5.3','October 2025','5.3 (October 2024)','Support for 7 months (until May 2026)','','2.14'],
     #['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'],
     #['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','','2.6'],
     #['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
     #['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
-    ['Kirkstone','4.0','April 2022','4.0 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
-    ['Whinlatter','5.3','October 2025','5.3 (October 2024)','Support for 7 months (until May 2026)','','2.14'],
+    #['Kirkstone','4.0','April 2022','4.0 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
     #['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
     #['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
     #['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 01f55ffda8e..9197e160c67 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -27,16 +27,6 @@
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.8</field>
   </object>
-  <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">kirkstone</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.0</field>
-  </object>
-  <object model="orm.bitbakeversion" pk="6">
-    <field type="CharField" name="name">whinlatter</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.14</field>
-  </object>
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
@@ -67,20 +57,6 @@
     <field type="CharField" name="branch_name">scarthgap</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=scarthgap\"&gt;OpenEmbedded Scarthgap&lt;/a&gt; branch.</field>
   </object>
-  <object model="orm.release" pk="5">
-    <field type="CharField" name="name">kirkstone</field>
-    <field type="CharField" name="description">Openembedded Kirkstone</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">kirkstone</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=kirkstone\"&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.</field>
-  </object>
-  <object model="orm.release" pk="6">
-    <field type="CharField" name="name">whinlatter</field>
-    <field type="CharField" name="description">Openembedded Whinlatter</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
-    <field type="CharField" name="branch_name">whinlatter</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=whinlatter\"&gt;OpenEmbedded Whinlatter&lt;/a&gt; branch.</field>
-  </object>
 
   <!-- Default layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -99,14 +75,6 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
-  <object model="orm.releasedefaultlayer" pk="5">
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="layer_name">openembedded-core</field>
-  </object>
-  <object model="orm.releasedefaultlayer" pk="6">
-    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="layer_name">openembedded-core</field>
-  </object>
 
 
   <!-- Layer for the Local release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 3648170bb26..dd9ea3c1f88 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -31,18 +31,6 @@
     <field type="CharField" name="branch">2.8</field>
     <field type="CharField" name="dirpath"></field>
   </object>
-  <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">kirkstone</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.0</field>
-    <field type="CharField" name="dirpath"></field>
-  </object>
-  <object model="orm.bitbakeversion" pk="6">
-    <field type="CharField" name="name">whinlatter</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.14</field>
-    <field type="CharField" name="dirpath"></field>
-  </object>
 
 
   <!-- Releases available -->
@@ -74,20 +62,6 @@
     <field type="CharField" name="branch_name">scarthgap</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=scarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
   </object>
-  <object model="orm.release" pk="5">
-    <field type="CharField" name="name">kirkstone</field>
-    <field type="CharField" name="description">Yocto Project 4.0 "Kirkstone"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">kirkstone</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=kirkstone"&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</field>
-  </object>
-  <object model="orm.release" pk="6">
-    <field type="CharField" name="name">whinlatter</field>
-    <field type="CharField" name="description">Yocto Project 5.3 "Whinlatter"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
-    <field type="CharField" name="branch_name">whinlatter</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=whinlatter"&gt;Yocto Project Whinlatter branch&lt;/a&gt;.</field>
-  </object>
 
   <!-- Default project layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -138,30 +112,6 @@
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
-  <object model="orm.releasedefaultlayer" pk="16">
-    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="layer_name">openembedded-core</field>
-  </object>
-  <object model="orm.releasedefaultlayer" pk="17">
-    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="layer_name">meta-poky</field>
-  </object>
-  <object model="orm.releasedefaultlayer" pk="18">
-    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="layer_name">meta-yocto-bsp</field>
-  </object>
 
   <!-- Default layers provided by poky
        openembedded-core
@@ -205,20 +155,6 @@
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
-  <object model="orm.layer_version" pk="5">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">kirkstone</field>
-    <field type="CharField" name="dirpath">meta</field>
-  </object>
-  <object model="orm.layer_version" pk="6">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="branch">whinlatter</field>
-    <field type="CharField" name="dirpath">meta</field>
-  </object>
 
   <object model="orm.layer" pk="2">
     <field type="CharField" name="name">meta-poky</field>
@@ -228,14 +164,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="7">
+  <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">wrynose</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="8">
+  <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -243,34 +179,20 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="10">
+  <object model="orm.layer_version" pk="8">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="11">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">kirkstone</field>
-    <field type="CharField" name="dirpath">meta-poky</field>
-  </object>
-  <object model="orm.layer_version" pk="12">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="branch">whinlatter</field>
-    <field type="CharField" name="dirpath">meta-poky</field>
-  </object>
 
   <object model="orm.layer" pk="3">
     <field type="CharField" name="name">meta-yocto-bsp</field>
@@ -280,14 +202,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="13">
+  <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">wrynose</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="14">
+  <object model="orm.layer_version" pk="10">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -295,32 +217,18 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="15">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="16">
+  <object model="orm.layer_version" pk="12">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="17">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">kirkstone</field>
-    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
-  </object>
-  <object model="orm.layer_version" pk="18">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="branch">whinlatter</field>
-    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
-  </object>
 </django-objects>
diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index 5de3c06f123..6e22bdee370 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -64,22 +64,6 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             True,
         )
 
-    def test_create_new_project_kirkstone(self):
-        """ Test create new project using:
-          - Project Name: Any string
-          - Release: Yocto Project 4.0 "Kirkstone" (option value: 5)
-          - Merge Toaster settings: True
-        """
-        release = '5'
-        release_title = 'Yocto Project 4.0 "Kirkstone"'
-        project_name = 'projectkirkstone'
-        self.create_new_project(
-            project_name,
-            release,
-            release_title,
-            True,
-        )
-
     def test_create_new_project_local(self):
         """ Test create new project using:
           - Project Name: Any string

