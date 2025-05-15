Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D5C3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 11:22:18 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.10200.1747308137695761064
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 May 2025 04:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CA+bPBU6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0618746bso6264955e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747308136; x=1747912936; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ7378AIb3LCJYvHDoCFuNaEr8VguAPye31n+pN1gUM=;
        b=CA+bPBU66wx12J5qAvZfY8zIn6Rw/KWCW3Nb4MJ2v7a/W4vxZf9G5j2ZkdQAVLBHVw
         m2UetoG15OqTGTlW5Y+Gnops3YZ7HreKLkrZs8D3Nw7Op6zsb7WhzQ5FMcnD6rp66RkX
         XKSOBiv+NksOE4NxKZhbUrPHHsNLp52Z0jS20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308136; x=1747912936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ7378AIb3LCJYvHDoCFuNaEr8VguAPye31n+pN1gUM=;
        b=FAtv3pxYJZykM0sAWSjSRAohsKhzPiz3rb67wTcUjBKWS1rvmT1qn3GiFgftFLoHe2
         wNQPz6xqqToeW4NrcwRpWIyLgJRBNUgwvwV0JjbAmI0vkJXeHXO4O0D+fqA8wQu7SbX6
         j2S4q+NhIiEoQODM2xjZN3JqoRAA5frji6EKQWOnf/z7tNG2fWwlrG066aVQWLl5MyMT
         rFER+HSKxYW9p/QpNGjEHzrxHPIA2Vl7jviUiU2IzQ6EBJbgFvkgnqkYkjhm1FDMexdN
         /0yQau8x4PJRsoKPFeLDpYAmrFYjqVkEpen9dku64WTnNwoH8Wz/CzD+cD34fRk1gIwx
         ujdg==
X-Gm-Message-State: AOJu0Yy6HzNG+ppLXutq2SdcE6nlxZHFMm6dbPkrz4dcUqMW7oimzWQ2
	5KyIrqzfofnU7PhgHX6hSU+fsqTfDNa8sZ0lSkvlW6sBE69J1I+MPx/TE4UpEh2RakQ978o01Dw
	/
X-Gm-Gg: ASbGncslpW1buoOY6txjhUkHxfgqjkGMflKUA4MJ4OVgs/Nk87mIE+sPgAuQgaf1DZa
	6ctdBFmpjcobw8rzfDwzRn7SryUA8zFpckrbxBXQ2JXLfW3QRz4KEGxOyvkDi4o2zWMsERNMfKM
	j9gjn5OcmzDVp0nePTPRbyzejGTLTf8aCyYMfkH6/R3rVlc4hXXxJVdxiIVRjkNVTNiKv34pO67
	FTBqVbljACq6cf2VArqpqJRnMAhX3Zf5RQkUW8hPSWLh3/jJ0EK0KuA6Wlx6oVPKp0Ni7S+dM+n
	aOyv0saosHOT3OsReUBImsQljS4rw6yDoC5Hj1on4ur6oBnkLz1ia+bylg7C+dbNRW+bK0qHKnS
	04ig=
X-Google-Smtp-Source: AGHT+IFK7F9NKNLPxTNVqP3e74zImzUTk0nAszpTHZ672TT4DkkseWr7ePyEIpjOwTe+6/37qeqhOQ==
X-Received: by 2002:a05:600c:1553:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-442f96e958emr23477575e9.10.1747308135355;
        Thu, 15 May 2025 04:22:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7c21:701d:240:45b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd6fe86sm69153425e9.0.2025.05.15.04.22.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:22:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster/fixtures: Add whinlatter, drop styhead
Date: Thu, 15 May 2025 12:22:13 +0100
Message-ID: <20250515112213.1634331-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 11:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17616

Update the fixtures generator table and update the fixtures removing
styhead and adding whinlatter.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/gen_fixtures.py |  5 +-
 lib/toaster/orm/fixtures/oe-core.xml     | 30 ++++++--
 lib/toaster/orm/fixtures/poky.xml        | 96 ++++++++++++++++++------
 3 files changed, 97 insertions(+), 34 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 1bb3788567..6201f679b9 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -41,8 +41,9 @@ current_releases = [
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
-    ['Walnascar','5.2','April 2025','5.2.0 (April 2024)','Support for 7 months (until October 2025)','','2.12'],
-    ['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'],
+    ['Whinlatter','5.3','October 2025','5.3.0 (October 2024)','Support for 7 months (until May 2026)','','2.14'],
+    ['Walnascar','5.2','April 2025','5.2.0 (April 2025)','Support for 7 months (until October 2025)','','2.12'],
+    #['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'],
     #['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','','2.6'],
     #['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
     #['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 3d4ec265a5..264231d139 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,16 +23,21 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
+    <field type="CharField" name="branch">2.14</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">walnascar</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.12</field>
   </object>
-  <object model="orm.bitbakeversion" pk="5">
+  <object model="orm.bitbakeversion" pk="6">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.10</field>
   </object>
-  <object model="orm.bitbakeversion" pk="6">
+  <object model="orm.bitbakeversion" pk="7">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
     <field type="CharField" name="branch">2.0</field>
@@ -61,23 +66,30 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
+    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="description">Openembedded Whinlatter</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field type="CharField" name="branch_name">whinlatter</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=whinlatter\"&gt;OpenEmbedded Whinlatter&lt;/a&gt; branch.</field>
+  </object>
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">walnascar</field>
     <field type="CharField" name="description">Openembedded Walnascar</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">walnascar</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=walnascar\"&gt;OpenEmbedded Walnascar&lt;/a&gt; branch.</field>
   </object>
-  <object model="orm.release" pk="5">
+  <object model="orm.release" pk="6">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="description">Openembedded Styhead</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
     <field type="CharField" name="branch_name">styhead</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=styhead\"&gt;OpenEmbedded Styhead&lt;/a&gt; branch.</field>
   </object>
-  <object model="orm.release" pk="6">
+  <object model="orm.release" pk="7">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Openembedded Kirkstone</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">7</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=kirkstone\"&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.</field>
   </object>
@@ -107,6 +119,10 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="7">
+    <field rel="ManyToOneRel" to="orm.release" name="release">7</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
 
 
   <!-- Layer for the Local release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index f2c538d0c2..6cf4f0687a 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,18 +26,24 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
+    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
+    <field type="CharField" name="branch">whinlatter</field>
+    <field type="CharField" name="dirpath">bitbake</field>
+  </object>
+  <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">walnascar</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
     <field type="CharField" name="branch">walnascar</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
-  <object model="orm.bitbakeversion" pk="5">
+  <object model="orm.bitbakeversion" pk="6">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
     <field type="CharField" name="branch">styhead</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
-  <object model="orm.bitbakeversion" pk="6">
+  <object model="orm.bitbakeversion" pk="7">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
     <field type="CharField" name="branch">kirkstone</field>
@@ -68,23 +74,30 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
+    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="description">Yocto Project 5.3 "Whinlatter"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field type="CharField" name="branch_name">whinlatter</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=whinlatter"&gt;Yocto Project Whinlatter branch&lt;/a&gt;.</field>
+  </object>
+  <object model="orm.release" pk="5">
     <field type="CharField" name="name">walnascar</field>
     <field type="CharField" name="description">Yocto Project 5.2 "Walnascar"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">walnascar</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=walnascar"&gt;Yocto Project Walnascar branch&lt;/a&gt;.</field>
   </object>
-  <object model="orm.release" pk="5">
+  <object model="orm.release" pk="6">
     <field type="CharField" name="name">styhead</field>
     <field type="CharField" name="description">Yocto Project 5.1 "Styhead"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
     <field type="CharField" name="branch_name">styhead</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=styhead"&gt;Yocto Project Styhead branch&lt;/a&gt;.</field>
   </object>
-  <object model="orm.release" pk="6">
+  <object model="orm.release" pk="7">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Yocto Project 4.0 "Kirkstone"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">7</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=kirkstone"&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</field>
   </object>
@@ -162,6 +175,18 @@
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
     <field type="CharField" name="layer_name">meta-yocto-bsp</field>
   </object>
+  <object model="orm.releasedefaultlayer" pk="19">
+    <field rel="ManyToOneRel" to="orm.release" name="release">7</field>
+    <field type="CharField" name="layer_name">openembedded-core</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="20">
+    <field rel="ManyToOneRel" to="orm.release" name="release">7</field>
+    <field type="CharField" name="layer_name">meta-poky</field>
+  </object>
+  <object model="orm.releasedefaultlayer" pk="21">
+    <field rel="ManyToOneRel" to="orm.release" name="release">7</field>
+    <field type="CharField" name="layer_name">meta-yocto-bsp</field>
+  </object>
 
   <!-- Default layers provided by poky
        openembedded-core
@@ -202,20 +227,27 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">walnascar</field>
+    <field type="CharField" name="branch">whinlatter</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="branch">walnascar</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta</field>
+  </object>
+  <object model="orm.layer_version" pk="7">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">7</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
@@ -228,14 +260,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="7">
+  <object model="orm.layer_version" pk="8">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="8">
+  <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -243,31 +275,38 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="9">
+  <object model="orm.layer_version" pk="10">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="10">
+  <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">walnascar</field>
+    <field type="CharField" name="branch">whinlatter</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="11">
+  <object model="orm.layer_version" pk="12">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="branch">walnascar</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
-  <object model="orm.layer_version" pk="12">
+  <object model="orm.layer_version" pk="13">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta-poky</field>
+  </object>
+  <object model="orm.layer_version" pk="14">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">7</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
@@ -280,14 +319,14 @@
     <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
     <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
-  <object model="orm.layer_version" pk="13">
+  <object model="orm.layer_version" pk="15">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
     <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="14">
+  <object model="orm.layer_version" pk="16">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">2</field>
@@ -295,31 +334,38 @@
     <field type="CharField" name="commit">HEAD</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="15">
+  <object model="orm.layer_version" pk="17">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">3</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="16">
+  <object model="orm.layer_version" pk="18">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">walnascar</field>
+    <field type="CharField" name="branch">whinlatter</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="17">
+  <object model="orm.layer_version" pk="19">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="branch">walnascar</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
-  <object model="orm.layer_version" pk="18">
+  <object model="orm.layer_version" pk="20">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
+    <field type="CharField" name="branch">styhead</field>
+    <field type="CharField" name="dirpath">meta-yocto-bsp</field>
+  </object>
+  <object model="orm.layer_version" pk="21">
+    <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
+    <field type="IntegerField" name="layer_source">0</field>
+    <field rel="ManyToOneRel" to="orm.release" name="release">7</field>
     <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>

