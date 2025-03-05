Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEDDC282DC
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:17:42 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.10298.1741169857616494802
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Mar 2025 02:17:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VSVMCDlG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso44783815e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741169855; x=1741774655; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h91u1x6saolsnHqZQhps/PJOjQcsIeEhpWMGE461Tuk=;
        b=VSVMCDlGvPrwkBgoQRgQxg/XABZ/D16WsHZzaGR2Bh8m383pI9tjxdLv7FhhdE+H6c
         EfKIx204/IvjAoNQmbHS4hIkKZoUiilT1luoIWfUTGxHAThWh/q1MZ8+PrXc4PfRo2Is
         DIaLq+24MWgFB4lc7TCzOOI2RH0afMVoCQJ+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169855; x=1741774655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h91u1x6saolsnHqZQhps/PJOjQcsIeEhpWMGE461Tuk=;
        b=Sc0HsP1JBPOT/KeJVxQrVxM0+8hzjBbfBX6hGosD+H1BQ0wAtl05HpKQkSDbB00+ZZ
         +eNReGyZtJFY9m/1hlACyuNdU2G6VrgPfAFauqN0LLDxmLB7wzmZk2kcUT717x+AxKJp
         YWExl0cmLrm5fydNKXQovdQYAiGK89g4VAp4o5yWhY8p6tTej1vPGkZePsMEjYSEbM9K
         EkDar+t5VyWz6wBg+NpbU+QJr8Ab30PNl/Zz5/MLQC5ligq2JdzAFQgt8X6viYw9Qjb6
         tzrm833uyDKRwROmSv+5LXPzlqajaRdmYcMCywz9ENtLY3T7s0DDPu1bHk3xc33R/HzZ
         1IxA==
X-Gm-Message-State: AOJu0YyJBAj6QxfG8Y6ot4hHDtqEeEEcI5F2McL0ZrKAAJehHUCfQw5I
	Pwvoc0t+LbrF+LXPnhVvxLRxn7d2WdMEE2ow4YAkQbS1ZjfsZk7JevvZPurB5CXxg20ZDCyobFg
	K
X-Gm-Gg: ASbGncvqCsezLwnCsZJBrDiaUynslRes/Y3U81/fA+TflkqRjwkGGZAYugt72zD1Qfq
	KmT13Zu3RX9waicfA/TGPdImfe7sKd7Bcfsu2ngNAmbnwuABUn++mcxKOcrqHqwQU8v4mix4FwO
	pQSbCUBAZp3IyKar/uhkBMsqpNrsjvAhipUC0zjRw8qWPZINyovNT/09zOlDGKj2ggQPBXn23dl
	t4h2OUy+gkP2xyexwx8vX3/2aF35P/uC1x2rDsvPaE12CHH5N9IS1Ro5/NBzqBiWwHJjtVGqKu/
	CLCfpdSyR/X32k6s1XTwz/Pci+uvPuX7MvPSbrYMcesgiWXqE4OGqhnWukHHxM2XHH/GPvFvcw=
	=
X-Google-Smtp-Source: AGHT+IGPiazKvppLulwQzCscrnrTq6KS15nCbj0i6UcpQmG2P+l+SZDHnEhp8pfTudJqy9pyjVEhhA==
X-Received: by 2002:a5d:5f8f:0:b0:391:10f9:f3a6 with SMTP id ffacd0b85a97d-3911f7b8ac5mr1997099f8f.34.1741169855332;
        Wed, 05 Mar 2025 02:17:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847fe5sm20642373f8f.73.2025.03.05.02.17.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:17:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] toaster/fixtures: Add walnascar release information
Date: Wed,  5 Mar 2025 10:17:32 +0000
Message-ID: <20250305101732.2042605-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305101732.2042605-1-richard.purdie@linuxfoundation.org>
References: <20250305101732.2042605-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 10:17:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17385

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/gen_fixtures.py | 14 ++---
 lib/toaster/orm/fixtures/oe-core.xml     | 24 +++++--
 lib/toaster/orm/fixtures/poky.xml        | 80 +++++++++++++++++++-----
 3 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index e33c7f3954..1bb3788567 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -41,15 +41,15 @@ current_releases = [
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
+    ['Walnascar','5.2','April 2025','5.2.0 (April 2024)','Support for 7 months (until October 2025)','','2.12'],
     ['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'],
-#   ['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','','2.6'],
-#   ['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
-#   ['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
+    #['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','','2.6'],
+    #['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
+    #['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
     ['Kirkstone','4.0','April 2022','4.0.8 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
-#   ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
-#   ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
-#   ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
-    # Optional Release slot #5
+    #['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
+    #['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
+    #['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
     #['Dunfell','3.1','April 2020','3.1.23 (February 2023)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
 ]
 
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 4a3865099f..3d4ec265a5 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,11 +23,16 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">walnascar</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">2.12</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.10</field>
   </object>
-  <object model="orm.bitbakeversion" pk="5">
+  <object model="orm.bitbakeversion" pk="6">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.0</field>
@@ -56,16 +61,23 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
+    <field type="CharField" name="name">walnascar</field>
+    <field type="CharField" name="description">Openembedded Walnascar</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field type="CharField" name="branch_name">walnascar</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=walnascar\"&gt;OpenEmbedded Walnascar&lt;/a&gt; branch.</field>
+  </object>
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="description">Openembedded Styhead</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">styhead</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=styhead\"&gt;OpenEmbedded Styhead&lt;/a&gt; branch.</field>
   </object>
-  <object model="orm.release" pk="5">
+  <object model="orm.release" pk="6">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Openembedded Kirkstone</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=kirkstone\"&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.</field>
   </object>
@@ -91,6 +103,10 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="6">
+    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
 
 
   <!-- Layer for the Local release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index d782a8e62d..f2c538d0c2 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,12 +26,18 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">walnascar</field>
+    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="branch">walnascar</field>
+    <field type="CharField" name="dirpath">bitbake</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
     <field type="CharField" name="branch">styhead</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
-  <object model="orm.bitbakeversion" pk="5">
+  <object model="orm.bitbakeversion" pk="6">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
     <field type="CharField" name="branch">kirkstone</field>
@@ -62,16 +68,23 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
+    <field type="CharField" name="name">walnascar</field>
+    <field type="CharField" name="description">Yocto Project 5.2 "Walnascar"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field type="CharField" name="branch_name">walnascar</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=walnascar"&gt;Yocto Project Walnascar branch&lt;/a&gt;.</field>
+  </object>
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="description">Yocto Project 5.1 "Styhead"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">styhead</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=styhead"&gt;Yocto Project Styhead branch&lt;/a&gt;.</field>
   </object>
-  <object model="orm.release" pk="5">
+  <object model="orm.release" pk="6">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Yocto Project 4.0 "Kirkstone"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=kirkstone"&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</field>
   </object>
@@ -137,6 +150,18 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="layer_name">meta-yocto-bsp</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="16">
+    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="17">
+    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
+    <field type="CharField" name="layer_name">meta-poky</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="18">
+    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
+    <field type="CharField" name="layer_name">meta-yocto-bsp</field>
+  </object>
 
   <!-- Default layers provided by poky
        openembedded-core
@@ -177,13 +202,20 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="branch">walnascar</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
+  <object model="orm.layer_version" pk="6">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
@@ -196,14 +228,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="6">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="7">
+  <object model="orm.layer_version" pk="8">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -211,24 +243,31 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="8">
+  <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="10">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="branch">walnascar</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="10">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
+  <object model="orm.layer_version" pk="12">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
@@ -241,14 +280,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="11">
+  <object model="orm.layer_version" pk="13">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="12">
+  <object model="orm.layer_version" pk="14">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -256,24 +295,31 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="13">
+  <object model="orm.layer_version" pk="15">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="14">
+  <object model="orm.layer_version" pk="16">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="branch">walnascar</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="15">
+  <object model="orm.layer_version" pk="17">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
+  <object model="orm.layer_version" pk="18">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>

