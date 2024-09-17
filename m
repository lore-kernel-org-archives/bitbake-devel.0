Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF863C36014
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 11:23:08 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.18635.1726572179806688364
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Sep 2024 04:23:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G1ns8cbV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so3296543f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726572178; x=1727176978; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/49zACe0JSOp8q77RGn8K3+X9mAlIREcT2L2T6jors=;
        b=G1ns8cbV+2MSlyP7K0LcyroGrWmi21mkBwoYuBqoD0800Ub7jf2OvteA1zER6H4bOx
         l/sNvzaSEFNTYzPANdt4Sm4IkdnYgh2pxPrZQ4wpFf5MIHYW8zVJ7PCjmFcHOjQTwoQM
         A/ltkDUb0hjwU+Xo2h3aGljl1TMIqQaghRqDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726572178; x=1727176978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/49zACe0JSOp8q77RGn8K3+X9mAlIREcT2L2T6jors=;
        b=pXH7RWxNvSKDsPk/yQ4aq3WNsNN9KU5U/54+GM0L9BbW6gDvXYpEpl5eug7RRwushM
         owbTYGAnhJRuK72NR48VKEB9+pQAE9KUj5FGnnZ84VVyfH1OSOcbxtbaaNWL2qSX/QpQ
         zmEslnfeJhgSXfpjqhlb4KZzpHqjjGCo6D3IXjTJ/bh+VLaX81wSpAA2MM+ObnJCGnFk
         XBDw2KPDEkfJ6QDgV0YcyX7XjXYtWmUE5+bZuBcArZxZ05dRDCy0pc1yrxgwG4pDA2qb
         1haacOPTIbx9ifFMrcxhWg71e6/MzolACqocY5m2lJOSIGTDb7ayVaHPdrv/QhQNjOp5
         TUeA==
X-Gm-Message-State: AOJu0YzjyolfbsDBhk7UeoY9gapceg7qxtxSE2y6yNRPC86BucCbt23t
	Gew+TzL2oIgnu+nzWqx9Ag5oU+jbPS2uhA9/Ec+i6GI83Fbgyf2BGAR2D/Oz+eRmSYbYoz3W45O
	Q
X-Google-Smtp-Source: AGHT+IEIqbViZ/6Up0lTJgK/kEyDOVfXw75oZ88d+6qCuBC0CduAlLCzlvvTJ8rs7c9Za+E88WDHWw==
X-Received: by 2002:a5d:6189:0:b0:36b:a2bb:b374 with SMTP id ffacd0b85a97d-378c2d61762mr10805796f8f.52.1726572177359;
        Tue, 17 Sep 2024 04:22:57 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7c97:abb4:726a:74dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780025asm9336018f8f.72.2024.09.17.04.22.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:22:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster: Update fixtures for styhead
Date: Tue, 17 Sep 2024 12:22:56 +0100
Message-ID: <20240917112256.3601975-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 11:23:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16564

Add styhead. Also fix a typo in the usage instructions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/gen_fixtures.py |  5 +-
 lib/toaster/orm/fixtures/oe-core.xml     | 18 ++++++-
 lib/toaster/orm/fixtures/poky.xml        | 64 ++++++++++++++++++++----
 3 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 5f43400cdc..e33c7f3954 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -9,7 +9,7 @@
 #
 # Edit the 'current_releases' table for each new release cycle
 #
-# Usage: ./get_fixtures all
+# Usage: ./get_fixtures --all
 #
 
 import os
@@ -35,12 +35,13 @@ verbose = False
 # [Codename, Yocto Project Version, Release Date, Current Version, Support Level, Poky Version, BitBake branch]
 current_releases = [
     # Release slot #1
-	['Scarthgap','5.0','April 2024','5.0.0 (April 2024)','Long Term Support (until April 2028)','','2.8'],
+    ['Scarthgap','5.0','April 2024','5.0.0 (April 2024)','Long Term Support (until April 2028)','','2.8'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
+    ['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'],
 #   ['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','','2.6'],
 #   ['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
 #   ['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index d381027c7b..4a3865099f 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,6 +23,11 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">styhead</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">2.10</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.0</field>
@@ -51,9 +56,16 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
+    <field type="CharField" name="name">styhead</field>
+    <field type="CharField" name="description">Openembedded Styhead</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field type="CharField" name="branch_name">styhead</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=styhead\"&gt;OpenEmbedded Styhead&lt;/a&gt; branch.</field>
+  </object>
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Openembedded Kirkstone</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=kirkstone\"&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.</field>
   </object>
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
index 21355aeb7b..d782a8e62d 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,6 +26,12 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">styhead</field>
+    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">bitbake</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
     <field type="CharField" name="branch">kirkstone</field>
@@ -56,9 +62,16 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
+    <field type="CharField" name="name">styhead</field>
+    <field type="CharField" name="description">Yocto Project 5.1 "Styhead"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field type="CharField" name="branch_name">styhead</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=styhead"&gt;Yocto Project Styhead branch&lt;/a&gt;.</field>
+  </object>
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Yocto Project 4.0 "Kirkstone"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=kirkstone"&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</field>
   </object>
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
@@ -152,6 +177,13 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
+  <object model="orm.layer_version" pk="5">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="branch">kirkstone</field>
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
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="6">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -179,17 +211,24 @@
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
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
+  <object model="orm.layer_version" pk="10">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="branch">kirkstone</field>
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
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="10">
+  <object model="orm.layer_version" pk="12">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -217,17 +256,24 @@
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
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
+  <object model="orm.layer_version" pk="15">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>

