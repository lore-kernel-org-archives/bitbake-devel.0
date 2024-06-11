Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40837C41513
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 16:13:55 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.700.1718122432439189740
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jun 2024 09:13:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ptUhLIuD;
 spf=pass (domain: konsulko.com, ip: 209.85.210.181, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-704313fa830so2272179b3a.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1718122431; x=1718727231; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MRCzQ8kG8pzgbnMY7tL6EU5dTbSlsus9abn/rYhZdQ=;
        b=ptUhLIuDPlweg38tSgLZYyADAm71XwtVSWKMu4S2awF5EpTfe3QCDaQxmWb3Iji1+0
         dr/SPN/vSRS4Nc/vqNOWCmAXG4VH8hhmszRALdoxz4EL1Y7biIaFTv6ZXNohbyus8jyo
         6DttBMAsArukrqNGSay5AQ6EuQS4ZiUf6eKbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718122431; x=1718727231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MRCzQ8kG8pzgbnMY7tL6EU5dTbSlsus9abn/rYhZdQ=;
        b=uViOTimE7EKqU18NIs+UUexWeopCTjWJbw8+UDBn0Y43qiA3t9N08UYHfHwbewuMiX
         vS09jwLDahjK30INOPsbBzu9qP1xlWPeLvy6TsJBbypRhEIIkh2gwMbdQyUtNDY7SjG/
         cQHZdAC5jEfaQ/u+1l1zBI1uOLQpIig+h5uAZYgpoaYHv/vVc42GSsOnaBRXCsu6j4NZ
         TKw2hxzN7MJ6d9/sKVYemK0uStOGBGGGAw+zZl2DAbZM7TeAZJGko4P53ijcKl5wB8nx
         5rFICiyQCUYJ8b4MGk+PAVA8JY8z0So5dyHFcFT7M4Jh6st3ykFLL5OYnFLr4Lc/bhWU
         8nCw==
X-Gm-Message-State: AOJu0YxgsPKuaa1iz6dzyTP7lJ/1/7fsN1M9qCjHUV7+5GkSs53XDy74
	Cz6T0O8RAHmsQNZbddzdEtWRvJMSlyq6kZEinIOM/lZzj18K/3fOOTrttKh5WZvPLkuZrbpWAOg
	XzQM=
X-Google-Smtp-Source: AGHT+IGVrqyPOZh5cYVogYpqmPoldfizQy4LFNxhLwjv1oaIrxshGyR2iOanybDkiPYHeTCvBbfYoQ==
X-Received: by 2002:a05:6a00:1aca:b0:705:a18a:6870 with SMTP id d2e1a72fcca58-705a18a6b53mr4314117b3a.5.1718122431248;
        Tue, 11 Jun 2024 09:13:51 -0700 (PDT)
Received: from localhost ([2601:1c2:c182:4da0::2bc4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704217f7c08sm6196790b3a.184.2024.06.11.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:13:50 -0700 (PDT)
From: tim.orling@konsulko.com
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [toaster 1/3] taoster: update fixtures for scarthgap, current
Date: Tue, 11 Jun 2024 09:13:32 -0700
Message-ID: <20240611161333.2794231-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 16:13:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16349

From: Tim Orling <tim.orling@konsulko.com>

gen_fixtures.py:
* Add Scarthgap to slot #1
* Drop EOL Mickledore
* Move Kirkstone to lower slot
* Drop optional slot for EOL Dunfell

Refresh oe-core.xml and poky.xml

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/gen_fixtures.py |  8 +-
 lib/toaster/orm/fixtures/oe-core.xml     | 40 +++-------
 lib/toaster/orm/fixtures/poky.xml        | 98 +++++++-----------------
 3 files changed, 43 insertions(+), 103 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 71afe3914..5f43400cd 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,19 +35,21 @@ verbose = False
 # [Codename, Yocto Project Version, Release Date, Current Version, Support Level, Poky Version, BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Kirkstone','4.0','April 2022','4.0.8 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
+	['Scarthgap','5.0','April 2024','5.0.0 (April 2024)','Long Term Support (until April 2028)','','2.8'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
-    ['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
+#   ['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','','2.6'],
+#   ['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
 #   ['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
+    ['Kirkstone','4.0','April 2022','4.0.8 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
 #   ['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
 #   ['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
 #   ['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
     # Optional Release slot #5
-    ['Dunfell','3.1','April 2020','3.1.23 (February 2023)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
+    #['Dunfell','3.1','April 2020','3.1.23 (February 2023)','Stable - Long Term Support (until Apr. 2024)','23.0','1.46'],
 ]
 
 default_poky_layers = [
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 950f2a98a..d381027c7 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">kirkstone</field>
+    <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.0</field>
+    <field type="CharField" name="branch">2.8</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
@@ -23,23 +23,18 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">mickledore</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.4</field>
-  </object>
-  <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.46</field>
+    <field type="CharField" name="branch">2.0</field>
   </object>
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">kirkstone</field>
-    <field type="CharField" name="description">Openembedded Kirkstone</field>
+    <field type="CharField" name="name">scarthgap</field>
+    <field type="CharField" name="description">Openembedded Scarthgap</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">kirkstone</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=kirkstone\"&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">scarthgap</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=scarthgap\"&gt;OpenEmbedded Scarthgap&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -56,18 +51,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">mickledore</field>
-    <field type="CharField" name="description">Openembedded Mickledore</field>
+    <field type="CharField" name="name">kirkstone</field>
+    <field type="CharField" name="description">Openembedded Kirkstone</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">mickledore</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=mickledore\"&gt;OpenEmbedded Mickledore&lt;/a&gt; branch.</field>
-  </object>
-  <object model="orm.release" pk="5">
-    <field type="CharField" name="name">dunfell</field>
-    <field type="CharField" name="description">Openembedded Dunfell</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">dunfell</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=dunfell\"&gt;OpenEmbedded Dunfell&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">kirkstone</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=kirkstone\"&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.</field>
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
index 121e52fd4..21355aeb7 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">kirkstone</field>
+    <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">kirkstone</field>
+    <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
@@ -26,26 +26,20 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">mickledore</field>
-    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">mickledore</field>
-    <field type="CharField" name="dirpath">bitbake</field>
-  </object>
-  <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">kirkstone</field>
-    <field type="CharField" name="description">Yocto Project 4.0 "Kirkstone"</field>
+    <field type="CharField" name="name">scarthgap</field>
+    <field type="CharField" name="description">Yocto Project 5.0 "Scarthgap"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">kirkstone</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=kirkstone"&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">scarthgap</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=scarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -62,18 +56,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">mickledore</field>
-    <field type="CharField" name="description">Yocto Project 4.2 "Mickledore"</field>
+    <field type="CharField" name="name">kirkstone</field>
+    <field type="CharField" name="description">Yocto Project 4.0 "Kirkstone"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">mickledore</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=mickledore"&gt;Yocto Project Mickledore branch&lt;/a&gt;.</field>
-  </object>
-  <object model="orm.release" pk="5">
-    <field type="CharField" name="name">dunfell</field>
-    <field type="CharField" name="description">Yocto Project 3.1 "Dunfell"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">dunfell</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=dunfell"&gt;Yocto Project Dunfell branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">kirkstone</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=kirkstone"&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</field>
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
@@ -155,7 +130,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">kirkstone</field>
+    <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="2">
@@ -177,14 +152,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">mickledore</field>
-    <field type="CharField" name="dirpath">meta</field>
-  </object>
-  <object model="orm.layer_version" pk="5">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="branch">kirkstone</field>
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
-    <field type="CharField" name="branch">kirkstone</field>
+    <field type="CharField" name="branch">scarthgap</field>
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
-    <field type="CharField" name="branch">mickledore</field>
-    <field type="CharField" name="dirpath">meta-poky</field>
-  </object>
-  <object model="orm.layer_version" pk="10">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="branch">kirkstone</field>
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
-    <field type="CharField" name="branch">kirkstone</field>
+    <field type="CharField" name="branch">scarthgap</field>
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
-    <field type="CharField" name="branch">mickledore</field>
-    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
-  </object>
-  <object model="orm.layer_version" pk="15">
-    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
-    <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">dunfell</field>
+    <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
-- 
2.45.2


