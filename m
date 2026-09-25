Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE97C98328
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 16:32:49 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2428.1790353966679824138
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Sep 2026 09:32:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dDHGEkuV;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.76, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so869209f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790353965; x=1790958765; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCmhdxQe6u6AjDyNOAH4acQDF8HU/ZPAyw0zy342bWo=;
        b=dDHGEkuVAFOHMJclYQawrMg0yY50VGvaePSTf6vuwpy0FDBWQphC9duHKka6qIFZrQ
         LQhWrRoiKQwPDImD2/CcOFI7kGVlGZbg+I3j3VqZmvWJNshh+KiBSk7zc1msONac0EqF
         V8kr1NYFPvrxoU4/zE3wQseeTsS+5CICCnMMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790353965; x=1790958765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sCmhdxQe6u6AjDyNOAH4acQDF8HU/ZPAyw0zy342bWo=;
        b=bjKjG/5eAkPyO6zsWct7h4/PyPTb6uC7dYwlxg5iDMoJXez0ejcTDdulI/vogPQDIg
         06QFvEsZGECI/+4ucsqFCeNCmK3DoPHk58xU+TiBbLCi7THuNtWItkXe83zjlcGjYLfB
         59yPy5mAFVbSckzCcL1U6suQaRxdRxmoV7dURblZBXZ10FveVxYiFh0VhroEfjqHwr9U
         dYsZKuyO0ZI+7CmJeLijE1u7eBJpLzr0KV9IYmi4JuJpbuX5UublfATo2FUtVQKXvted
         ED3KK8QOMJ7ubNB/ionbp5bQI0S1E43I8VteDj55SmkGa4SvHWCjqVJvEnFkHInEWWYM
         hd+Q==
X-Gm-Message-State: AFuF++kG9zzch4TP42hv2yafjig4KrmLL4u4AXb20U+gyNLr+rqnsn5L
	eDKBkm5vHnfP12r9o4V/DXwDvsmEjXhXI81Tx2FB2gJcQ+NA8vH1Pzxtxdx/I1exvdGCqkemWnF
	BHNMXCIE=
X-Gm-Gg: AYBFou1gMNz6xK/1bfOMLNWVmSvQtuXNHBdtfYc892fFqGJ4GKAxEJj6hzhGoAmVnXC
	sAkt8HybA2NQ/56uNKZvYx5KHyCX/pn3jWr0f5+0gCEP8eyhhLPH7vL8mXDAkD9sq6yHZOXYaKP
	9EkxRi+Qnli+80Y+Vtn7fZhwf17xZZ1CkEYaGPl6B12s9+034q2lEhhmEnKxHW+kSapsUkyQ/Wj
	sodrU6ancbiL2LVntodbnOY6FZNSiowV8GfosXRgZ/InstVGnKx/sgem4Jdel9R3r3e2SyNBHzX
	x3JpNE7DMgDyzJH95bXgjyESfftONrxcnkKhsSVinZLXmCcFc4B2Hoc/B2VOZp8LaJbVktZ1TLX
	Mk2Cum99BCE1mZUnIs7wWQj+ZDT8SsYndrxLOuMKOkTQekER3fPYGjlI39XJb0GCcBxPuKXjcEf
	3Gj1q7OQ/vGBO9nCuK8xlQ1V1NBFCXXsWBuJjBOyFPq5mbPCWCCSUIbNOPFHJl3M32vebCExN9z
	JoJnXYK+YKnKfCsC3/tVPO3UKRAWR2saN4Vcuc=
X-Received: by 2002:adf:e19c:0:b0:487:11c3:b004 with SMTP id ffacd0b85a97d-488719760c4mr11461103f8f.52.1790353964465;
        Fri, 25 Sep 2026 09:32:44 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:63ad:54b4:d74c:3436])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm8410100f8f.2.2026.09.25.09.32.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:32:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] toaster: Update fixtures for blacksail
Date: Fri, 25 Sep 2026 17:32:42 +0100
Message-ID: <20260925163242.2011665-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 16:32:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20256

This adds blacksail to the toaster fixxtures list, runs the gen_fixtures script to
update the xml files and tests.

It also manually updates some of the tests since the position of "master" moved in
the list. I've parameterised it with MASTER_PROJECT_ID so it can be controlled from
one place in future at least. I did also spot a '2' that was probably meant to refer
to master as well so I've included that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/gen_fixtures.py      |   8 +-
 lib/toaster/orm/fixtures/oe-core.xml          |  54 ++++++----
 lib/toaster/orm/fixtures/poky.xml             | 102 +++++++++++++-----
 .../tests/functional/functional_helpers.py    |   2 +
 .../functional/test_create_new_project.py     |  32 ++++--
 .../tests/functional/test_functional_basic.py |   4 +-
 .../tests/functional/test_project_config.py   |   4 +-
 .../tests/functional/test_project_page.py     |   4 +-
 .../test_project_page_tab_config.py           |  10 +-
 9 files changed, 151 insertions(+), 69 deletions(-)

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
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index e28f2024f51..9bcaac61c88 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -23,6 +23,8 @@ from selenium.common.exceptions import NoSuchElementException
 logger = logging.getLogger("toaster")
 toaster_processes = []
 
+MASTER_PROJECT_ID = '4'
+
 class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
     wait_toaster_time = 10
 
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
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index d5c9708617d..71999ccf9a0 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -10,7 +10,7 @@
 import re
 from django.urls import reverse
 import pytest
-from tests.functional.functional_helpers import SeleniumFunctionalTestCase
+from tests.functional.functional_helpers import SeleniumFunctionalTestCase, MASTER_PROJECT_ID
 from orm.models import Project
 from selenium.webdriver.common.by import By
 
@@ -25,7 +25,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
     def setUp(self):
         super(FuntionalTestBasic, self).setUp()
         if not FuntionalTestBasic.project_id:
-            FuntionalTestBasic.project_id = self.create_new_project('selenium-project', '3', None, False)
+            FuntionalTestBasic.project_id = self.create_new_project('selenium-project', MASTER_PROJECT_ID, None, False)
 
  #  testcase (1515)
     def test_verify_left_bar_menu(self):
diff --git a/lib/toaster/tests/functional/test_project_config.py b/lib/toaster/tests/functional/test_project_config.py
index fcb1bc3284c..8c8450cf514 100644
--- a/lib/toaster/tests/functional/test_project_config.py
+++ b/lib/toaster/tests/functional/test_project_config.py
@@ -12,7 +12,7 @@ from django.urls import reverse
 from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
 from selenium.common.exceptions import TimeoutException
-from tests.functional.functional_helpers import SeleniumFunctionalTestCase
+from tests.functional.functional_helpers import SeleniumFunctionalTestCase, MASTER_PROJECT_ID
 from selenium.webdriver.common.by import By
 
 from .utils import get_projectId_from_url
@@ -32,7 +32,7 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
         """ Navigate to project BitBake variables page """
         # check if the menu is displayed
         if TestProjectConfig.project_id is None:
-            TestProjectConfig.project_id = self.create_new_project(self.PROJECT_NAME, '3', None, True)
+            TestProjectConfig.project_id = self.create_new_project(self.PROJECT_NAME, MASTER_PROJECT_ID, None, True)
 
         url = reverse('projectconf', args=(TestProjectConfig.project_id,))
         self.get(url)
diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 0a8aa1c7dcb..8f67c420f33 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -16,7 +16,7 @@ from django.utils import timezone
 from selenium.webdriver.common.keys import Keys
 from selenium.webdriver.support.select import Select
 from selenium.common.exceptions import TimeoutException
-from tests.functional.functional_helpers import SeleniumFunctionalTestCase
+from tests.functional.functional_helpers import SeleniumFunctionalTestCase, MASTER_PROJECT_ID
 from orm.models import Build, Project, Target
 from selenium.webdriver.common.by import By
 
@@ -29,7 +29,7 @@ class TestProjectPageBase(SeleniumFunctionalTestCase):
     def _navigate_to_project_page(self):
         # Navigate to project page
         if TestProjectPageBase.project_id is None:
-            TestProjectPageBase.project_id = self.create_new_project(self.PROJECT_NAME, '3', None, True)
+            TestProjectPageBase.project_id = self.create_new_project(self.PROJECT_NAME, MASTER_PROJECT_ID, None, True)
 
         url = reverse('project', args=(TestProjectPageBase.project_id,))
         self.get(url)
diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 525073ef6b0..0c1100c5e22 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -13,7 +13,7 @@ from django.urls import reverse
 from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
 from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException, TimeoutException
-from tests.functional.functional_helpers import SeleniumFunctionalTestCase
+from tests.functional.functional_helpers import SeleniumFunctionalTestCase, MASTER_PROJECT_ID
 from selenium.webdriver.common.by import By
 
 from .utils import get_projectId_from_url, wait_until_build, wait_until_build_cancelled
@@ -25,7 +25,7 @@ class TestProjectConfigTabBase(SeleniumFunctionalTestCase):
     def _navigate_to_project_page(self):
         # Navigate to project page
         if TestProjectConfigTabBase.project_id is None:
-            TestProjectConfigTabBase.project_id = self.create_new_project(self.PROJECT_NAME, '3', None, True)
+            TestProjectConfigTabBase.project_id = self.create_new_project(self.PROJECT_NAME, MASTER_PROJECT_ID, None, True)
         url = reverse('project', args=(TestProjectConfigTabBase.project_id,))
         self.get(url)
         self.wait_until_visible('#config-nav')
@@ -256,7 +256,7 @@ class TestProjectConfigTab(TestProjectConfigTabBase):
                     - meta-poky
                     - meta-yocto-bsp
         """
-        project_id = self.create_new_project(self.PROJECT_NAME + "-ST", '3', None, True)
+        project_id = self.create_new_project(self.PROJECT_NAME + "-ST", MASTER_PROJECT_ID, None, True)
         url = reverse('project', args=(project_id,))
         self.get(url)
         self.wait_until_visible('#config-nav')
@@ -388,7 +388,7 @@ class TestProjectConfigTab(TestProjectConfigTabBase):
 
     def test_project_page_custom_image_no_image(self):
         """ Test project page tab "New custom image" when no custom image """
-        project_id = self.create_new_project(self.PROJECT_NAME + "-CustomImage", '3', None, True)
+        project_id = self.create_new_project(self.PROJECT_NAME + "-CustomImage", MASTER_PROJECT_ID, None, True)
         url = reverse('project', args=(project_id,))
         self.get(url)
         self.wait_until_visible('#config-nav')
@@ -474,7 +474,7 @@ class TestProjectConfigTabDB(TestProjectConfigTabBase):
             wait_until_build_cancelled(self)
 
         # Create a new project for remaining asserts
-        project_id = self.create_new_project(self.PROJECT_NAME + "-MostBuilt", '2', None, True)
+        project_id = self.create_new_project(self.PROJECT_NAME + "-MostBuilt", MASTER_PROJECT_ID, None, True)
         url = reverse('project', args=(project_id,))
         self.get(url)
         self.wait_until_visible('#config-nav')

