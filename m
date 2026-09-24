Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE289C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 15:34:55 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1290.1790264090771529066
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2026 08:34:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ew/pjJ1C;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.141, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so15689335e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790264089; x=1790868889; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ap3Auzabngw09bAWi7N4aaRhRglyqQyUXr040twurak=;
        b=ew/pjJ1CeqKYeYA3HaZf9pzbL/d0laHObQNLdhrkJfM/oodAAeSKNBYzaJdJVtpEtJ
         BGz0NUPMXZPg3bB79hIUj5C1a1iap0q4qIXWtciyt8l8ibf0uJy1/LegQwnIzoOWAK9P
         vKOtj/lk/EtRZhgqFs+iUafNEUZkVAMtVEG+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264089; x=1790868889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ap3Auzabngw09bAWi7N4aaRhRglyqQyUXr040twurak=;
        b=BpjByO8z4y/JOX3r4GbpmUjt/hAgdmpz2JmXmSdJV6G5cCyiTXffXy8XCF24I0x+m9
         PKKwfAdGBklBX2sxXufQUqFEDo5Nci9tXC6FUqNaK1oLC8Abbkk/g6AZ4KJmy+UfaTSf
         SflEkH+jGHNmquTESc/UqD0aKj3iIR0mDX7AVNL29lRQkgl9hNkNIKrHhSP4SwCymuyO
         0jYOBYp5L1tcbvnNNDH35TGnkxqhLHvTirQrGyeyGRCunzrK7F1x6LjkiRkSHat/bI4k
         4PhJrpd+JZyaLVGJxEzJEJCPQzOS/yiBD0rxGyCKf/x7A/eNG4g0ILvPlj3PDqRQGlKe
         ftHA==
X-Gm-Message-State: AFuF++kKL0LFVVW9W6+cF5stFFqtc766Aw3eWogpKcihxdRLswhl3msN
	N/ypLoyX2z8/7jsX7qY76yiVs4gKpT0lrC1D90Ex8rv5q6eUvk0pXqqAxt0bXIQLxK7miBxbyhd
	nc0O5a+E=
X-Gm-Gg: AYBFou1iMqmY3ESYA7MXQDnYEIqFogbUHslgoFyt4tpAXN/DRDKuLoE4RuNghlmZhRl
	+k7ZuySIQyFHQoWHNxdhtTHpq13HKXxV76yT0Rcpb0EjUsV+5WS1ozGRxFnhH75x6REnLOqMPRr
	bOCf7Vd3+mQTU1CbDx45oWZiTEAaYtbxK/VzsoEAuI/C3H/2Nl4ZInsdqDefsAVxFR+DZXjui3F
	GczRkM+L8dAwC2t2r92hj35dXG0DtMynHe8Jw18Tj4mQrjchxtorVfmrCnv431oolkPYI5gXRtH
	OaE55RAvLcAuEex6cpNbihopaA+blkDjG7uRypXV9FtsQoS1vvQt2I7liT1O6TYJAOrSCfKuZn0
	7KCeZALYjgtEJcr6r0pYDDMHPVTGMGVc5tIWM0iMHw/T52GsN5u3wkNjOP/clbZdVH0BtjcFrBc
	pYflAJ43JCK0W5uv/S7DhAgU9sEYiX02EfD3SMc/rD60x2P15YS0rtjvXEqx5K9zRlpiXUjc8nJ
	eSMdvgXcSe1El/lsJqaL0gxvQ==
X-Received: by 2002:a05:600c:3514:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-49fe6701e7emr48094575e9.35.1790264088635;
        Thu, 24 Sep 2026 08:34:48 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d896:f63e:1133:71e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cc9a37sm86302135e9.11.2026.09.24.08.34.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:34:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster: Update fixtures for blacksail
Date: Thu, 24 Sep 2026 16:34:47 +0100
Message-ID: <20260924153447.1091145-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 15:34:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20252

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/gen_fixtures.py      |   8 +-
 lib/toaster/orm/fixtures/oe-core.xml          |  54 ++++++----
 lib/toaster/orm/fixtures/poky.xml             | 102 +++++++++++++-----
 .../functional/test_create_new_project.py     |  32 ++++--
 4 files changed, 138 insertions(+), 58 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 937f1ff882e..58961d8ebb4 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,12 +35,14 @@ verbose = False
 # [0=Codename, 1=Yocto Project Version, 2=Release Date, 3=Current Version, 4=Support Level, 5=Poky Version, 6=BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Wrynose','6.0','April 2026','6.0 (April 2026)','Long Term Support (until April 2030)','','2.18'],
+    ['Blacksail','6.1','October 2026','6.1 (October 2026)','Support for 7 months (until April 2027)','','2.20'],
     # Release slot #2 'local'
-    ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
+    ['Wrynose','6.0','April 2026','6.0 (April 2026)','Long Term Support (until April 2030)','','2.18'],
     # Release slot #3 'master'
-    ['Master','master','','Yocto Project master','master','','master'],
+    ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #4
+    ['Master','master','','Yocto Project master','master','','master'],
+    # Release slot #5
     ['Scarthgap','5.0','April 2024','5.0 (April 2024)','Long Term Support (until April 2028)','','2.8'],
     #['Whinlatter','5.3','October 2025','5.3 (October 2024)','Support for 7 months (until May 2026)','','2.14'],
     #['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'],
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 9197e160c67..ccd8457a2db 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -8,52 +8,64 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">wrynose</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.16</field>
+    <field type="CharField" name="name">blacksail</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">2.20</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
+    <field type="CharField" name="name">wrynose</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">2.18</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="3">
     <field type="CharField" name="name">HEAD</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">HEAD</field>
   </object>
-  <object model="orm.bitbakeversion" pk="3">
+  <object model="orm.bitbakeversion" pk="4">
     <field type="CharField" name="name">master</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">master</field>
   </object>
-  <object model="orm.bitbakeversion" pk="4">
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">scarthgap</field>
-    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.8</field>
   </object>
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
+    <field type="CharField" name="name">blacksail</field>
+    <field type="CharField" name="description">Openembedded Blacksail</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field type="CharField" name="branch_name">blacksail</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=blacksail\"&gt;OpenEmbedded Blacksail&lt;/a&gt; branch.</field>
+  </object>
+  <object model="orm.release" pk="2">
     <field type="CharField" name="name">wrynose</field>
     <field type="CharField" name="description">Openembedded Wrynose</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">2</field>
     <field type="CharField" name="branch_name">wrynose</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=wrynose\"&gt;OpenEmbedded Wrynose&lt;/a&gt; branch.</field>
   </object>
-  <object model="orm.release" pk="2">
+  <object model="orm.release" pk="3">
     <field type="CharField" name="name">local</field>
     <field type="CharField" name="description">Local Openembedded</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">2</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
     <field type="CharField" name="branch_name">HEAD</field>
     <field type="TextField" name="helptext">Toaster will run your builds with the version of OpenEmbedded that you have cloned or downloaded to your computer.</field>
   </object>
-  <object model="orm.release" pk="3">
+  <object model="orm.release" pk="4">
     <field type="CharField" name="name">master</field>
     <field type="CharField" name="description">OpenEmbedded core master</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
     <field type="CharField" name="branch_name">master</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
-  <object model="orm.release" pk="4">
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="description">Openembedded Scarthgap</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">scarthgap</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=scarthgap\"&gt;OpenEmbedded Scarthgap&lt;/a&gt; branch.</field>
   </object>
@@ -75,15 +87,19 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="5">
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
 
 
   <!-- Layer for the Local release -->
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
-    <field type="CharField" name="vcs_url">git://git.openembedded.org/openembedded-core</field>
-    <field type="CharField" name="vcs_web_url">https://cgit.openembedded.org/openembedded-core</field>
-    <field type="CharField" name="vcs_web_tree_base_url">https://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">https://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_url">https://git.openembedded.org/openembedded-core</field>
+    <field type="CharField" name="vcs_web_url">https://git.openembedded.org/openembedded-core</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://git.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index b1b3861d687..d4c1ddfd5d9 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -8,24 +8,30 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
+    <field type="CharField" name="name">blacksail</field>
+    <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">2.20</field>
+    <field type="CharField" name="dirpath"></field>
+  </object>
+  <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">wrynose</field>
     <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.18</field>
     <field type="CharField" name="dirpath"></field>
   </object>
-  <object model="orm.bitbakeversion" pk="2">
+  <object model="orm.bitbakeversion" pk="3">
     <field type="CharField" name="name">HEAD</field>
     <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">HEAD</field>
     <field type="CharField" name="dirpath"></field>
   </object>
-  <object model="orm.bitbakeversion" pk="3">
+  <object model="orm.bitbakeversion" pk="4">
     <field type="CharField" name="name">master</field>
     <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath"></field>
   </object>
-  <object model="orm.bitbakeversion" pk="4">
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="giturl">https://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.8</field>
@@ -35,30 +41,37 @@
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
+    <field type="CharField" name="name">blacksail</field>
+    <field type="CharField" name="description">Yocto Project 6.1 "Blacksail"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field type="CharField" name="branch_name">blacksail</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/?h=blacksail"&gt;Yocto Project Blacksail branch&lt;/a&gt;.</field>
+  </object>
+  <object model="orm.release" pk="2">
     <field type="CharField" name="name">wrynose</field>
     <field type="CharField" name="description">Yocto Project 6.0 "Wrynose"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">2</field>
     <field type="CharField" name="branch_name">wrynose</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/?h=wrynose"&gt;Yocto Project Wrynose branch&lt;/a&gt;.</field>
   </object>
-  <object model="orm.release" pk="2">
+  <object model="orm.release" pk="3">
     <field type="CharField" name="name">local</field>
     <field type="CharField" name="description">Local Yocto Project</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">2</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
     <field type="CharField" name="branch_name">HEAD</field>
     <field type="TextField" name="helptext">Toaster will run your builds with the version of the Yocto Project you have cloned or downloaded to your computer.</field>
   </object>
-  <object model="orm.release" pk="3">
+  <object model="orm.release" pk="4">
     <field type="CharField" name="name">master</field>
     <field type="CharField" name="description">Yocto Project master</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
     <field type="CharField" name="branch_name">master</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
-  <object model="orm.release" pk="4">
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="description">Yocto Project 5.0 "Scarthgap"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">scarthgap</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/meta-yocto/log/?h=scarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
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
@@ -130,28 +155,35 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">wrynose</field>
+    <field type="CharField" name="branch">blacksail</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="2">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
-    <field type="CharField" name="branch">HEAD</field>
-    <field type="CharField" name="commit">HEAD</field>
+    <field type="CharField" name="branch">wrynose</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="3">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
-    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="branch">HEAD</field>
+    <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="4">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field type="CharField" name="branch">master</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
+  <object model="orm.layer_version" pk="5">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
@@ -164,32 +196,39 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="5">
+  <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">wrynose</field>
+    <field type="CharField" name="branch">blacksail</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="6">
+  <object model="orm.layer_version" pk="7">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
+    <field type="CharField" name="branch">wrynose</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
+  <object model="orm.layer_version" pk="8">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">HEAD</field>
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="7">
+  <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="8">
+  <object model="orm.layer_version" pk="10">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
@@ -202,32 +241,39 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/meta-yocto/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">wrynose</field>
+    <field type="CharField" name="branch">blacksail</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="10">
+  <object model="orm.layer_version" pk="12">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
+    <field type="CharField" name="branch">wrynose</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
+  <object model="orm.layer_version" pk="13">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">HEAD</field>
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="11">
+  <object model="orm.layer_version" pk="14">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="12">
+  <object model="orm.layer_version" pk="15">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
-    <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index f290f8b3eb7..294b6bc9885 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -15,13 +15,29 @@ from selenium.webdriver.common.by import By
 
 class TestCreateNewProject(SeleniumFunctionalTestCase):
 
-    def test_create_new_project_wrynose(self):
+    def test_create_new_project_blacksail(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 6.0 "Wrynose" (option value: 1)
+          - Release: Yocto Project 6.1 "Blacksail" (option value: 1)
           - Merge Toaster settings: True
         """
         release = '1'
+        release_title = 'Yocto Project 6.1 "Blacksail"'
+        project_name = 'projectblacksail'
+        self.create_new_project(
+            project_name,
+            release,
+            release_title,
+            True,
+        )
+
+    def test_create_new_project_wrynose(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project 6.0 "Wrynose" (option value: 2)
+          - Merge Toaster settings: True
+        """
+        release = '2'
         release_title = 'Yocto Project 6.0 "Wrynose"'
         project_name = 'projectwrynose'
         self.create_new_project(
@@ -34,10 +50,10 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
     def test_create_new_project_local(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project "Local" (option value: 2)
+          - Release: Yocto Project "Local" (option value: 3)
           - Merge Toaster settings: True
         """
-        release = '2'
+        release = '3'
         release_title = 'Local Yocto Project'
         project_name = 'projectlocal'
         self.create_new_project(
@@ -50,10 +66,10 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
     def test_create_new_project_master(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project "Master" (option value: 3)
+          - Release: Yocto Project "Master" (option value: 4)
           - Merge Toaster settings: False
         """
-        release = '3'
+        release = '4'
         release_title = 'Yocto Project master'
         project_name = 'projectmaster'
         self.create_new_project(
@@ -66,10 +82,10 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
     def test_create_new_project_scarthgap(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 5.0 "Scarthgap" (option value: 4)
+          - Release: Yocto Project 5.0 "Scarthgap" (option value: 5)
           - Merge Toaster settings: True
         """
-        release = '4'
+        release = '5'
         release_title = 'Yocto Project 5.0 "Scarthgap"'
         project_name = 'projectscarthgap'
         self.create_new_project(

