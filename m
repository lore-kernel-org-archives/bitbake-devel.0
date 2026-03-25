Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB1106B52A
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 12:50:25 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21401.1774443024026343480
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 05:50:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hiJUUm5D;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso21093815e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774443022; x=1775047822; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xzr++hjYr5B1oUQibsEP8M4cOuKlLWubV7P4xs/ZH8=;
        b=hiJUUm5DpXv8qZEpplO5bvHdZAciuPbrbw3eIdLAJCcYYczANRChuCEWAbpzgup7Hk
         r601qTmYdZbWnbre5o/gd6uLeMo1B8+IVUo90vaRAXfUfBPHiyjel/1ibZprOMvhI5ef
         kp7V6pSRYHDVTV/y/5PLuu4Wb4bAN9c06sanU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443022; x=1775047822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Xzr++hjYr5B1oUQibsEP8M4cOuKlLWubV7P4xs/ZH8=;
        b=avOd44N/jltYZdIPKr3YOu1TBGlSQlX0XgP2QQKliK3iYeDMs2VWEnUQ41k0G7xHjd
         ZAanPbZ/CUE5Qv6ynq3rbJ5FLvHR9hvDA7dgfVHfsCrBhM87bO5vOeIZE6CXBHgFxHU6
         +UxaCAg3FivkrEK+xgT6EH2V+EDhqV7eHBYg7sAxKkDUie8hJgIcCAlQx+pf7oueVzXv
         2lRk+pQqDJ3BaOH1iZvHjpNqfQVNqAcAlpPDdkAz0lcQhmyLE0mhTng1UhHMJonfqU92
         OTZ7RuUXRbJmMMg+Z52KLNbHGYXcCNFoensrtZVQderfHLvYzoJ4iCVFDiUoZz1br6sS
         nQ6Q==
X-Gm-Message-State: AOJu0Yzah8S6jj0c0JDoT9eCNxGA83TeBdkQh/F+DvzVItKvj+n9hLb0
	JsbJhLHfgUyFGX+30wS1lFJNe4j2Z1fZWuTmugoXaPZFNnjvSUsNAqFBcrpiW59f3PBkSykZBdZ
	rlkJl
X-Gm-Gg: ATEYQzz9pb6pDgVJTpBRh1CA8xURIBlAAOM3ErND1XotGpO7+aASL6afNs1yNs6YUmi
	DmXTnzt+exBSQTjSwYzdzgy3NRhiIrnvf92s/bOcq3U2taPc9Uqulbq8dlZYe5Uhfz9apyixVA8
	Epn0ZSWbffie8iIFMtdj0d1wKO7Fj50Muw7dQZJlok0nHxd57k/fEuKtgIJnwp83UVEEVT2MVmL
	S6fXfWkj7Xp+UZBZSPdBn1iDZF0nhuMf9/T6sohTWMfaRqSvh0xp0I57gFhy/YKS9gYqf8cjV+Q
	2mEuaOv6oxkQcQ5NAUwDZ7jQKYKHoUApTK5apwq3SEd2Gilx0sWAnfVMMU3GjLwQpTE/p6Lbl02
	lemedUQCJhnzY8ZItVLP2qdf3CG9MYuwCRaO7RiXsyJP1Mh/NIwScKxCdZI8PMirQtthh2Q36OP
	l2dxBx/X8iYOmD0R9XFmMhnwWpvrvrfk/pQVBNnAxRIUgUloVa6H9Z
X-Received: by 2002:a05:600c:3515:b0:486:fe39:28b7 with SMTP id 5b1f17b1804b1-48715fd99admr49919215e9.9.1774443021570;
        Wed, 25 Mar 2026 05:50:21 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:74e2:2425:51dc:4aed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116d820bsm124451735e9.10.2026.03.25.05.50.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:50:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster: Update fixtures for wrynose release
Date: Wed, 25 Mar 2026 12:50:19 +0000
Message-ID: <20260325125019.297452-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 12:50:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19231

Update the fixtures for toaster to add wynose. Update the tests to
match.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/gen_fixtures.py      |  8 +--
 lib/toaster/orm/fixtures/oe-core.xml          | 49 ++++++-------
 lib/toaster/orm/fixtures/poky.xml             | 72 +++++++++----------
 .../functional/test_create_new_project.py     | 25 +++++--
 4 files changed, 86 insertions(+), 68 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fixtures/gen_fixtures.py
index 4b87ba0baab..9488ce852e3 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,19 +35,19 @@ verbose = False
 # [0=Codename, 1=Yocto Project Version, 2=Release Date, 3=Current Version, 4=Support Level, 5=Poky Version, 6=BitBake branch]
 current_releases = [
     # Release slot #1
-    ['Scarthgap','5.0','April 2024','5.0.0 (April 2024)','Long Term Support (until April 2028)','','2.8'],
+    ['Wrynose','6.0','April 2026','6.0 (April 2026)','Long Term Support (until April 2030)','','2.16'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
     ['Master','master','','Yocto Project master','master','','master'],
     # Release slot #4
-    ['Whinlatter','5.3','October 2025','5.3.0 (October 2024)','Support for 7 months (until May 2026)','','2.14'],
-    ['Walnascar','5.2','April 2025','5.2.0 (April 2025)','Support for 7 months (until October 2025)','','2.12'],
+    ['Scarthgap','5.0','April 2024','5.0 (April 2024)','Long Term Support (until April 2028)','','2.8'],
     #['Styhead','5.1','November 2024','5.1.0 (November 2024)','Support for 7 months (until May 2025)','','2.10'],
     #['Nanbield','4.3','November 2023','4.3.0 (November 2023)','Support for 7 months (until May 2024)','','2.6'],
     #['Mickledore','4.2','April 2023','4.2.0 (April 2023)','Support for 7 months (until October 2023)','','2.4'],
     #['Langdale','4.1','October 2022','4.1.2 (January 2023)','Support for 7 months (until May 2023)','','2.2'],
-    ['Kirkstone','4.0','April 2022','4.0.8 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
+    ['Kirkstone','4.0','April 2022','4.0 (March 2023)','Stable - Long Term Support (until Apr. 2024)','','2.0'],
+    ['Whinlatter','5.3','October 2025','5.3 (October 2024)','Support for 7 months (until May 2026)','','2.14'],
     #['Honister','3.4','October 2021','3.4.2 (February 2022)','Support for 7 months (until May 2022)','26.0','1.52'],
     #['Hardknott','3.3','April 2021','3.3.5 (March 2022)','Stable - Support for 13 months (until Apr. 2022)','25.0','1.50'],
     #['Gatesgarth','3.2','Oct 2020','3.2.4 (May 2021)','EOL','24.0','1.48'],
diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index a83b18844b3..01f55ffda8e 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">scarthgap</field>
+    <field type="CharField" name="name">wrynose</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.8</field>
+    <field type="CharField" name="branch">2.16</field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
     <field type="CharField" name="name">HEAD</field>
@@ -23,28 +23,28 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.14</field>
+    <field type="CharField" name="branch">2.8</field>
   </object>
   <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">walnascar</field>
+    <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.12</field>
+    <field type="CharField" name="branch">2.0</field>
   </object>
   <object model="orm.bitbakeversion" pk="6">
-    <field type="CharField" name="name">kirkstone</field>
+    <field type="CharField" name="name">whinlatter</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.0</field>
+    <field type="CharField" name="branch">2.14</field>
   </object>
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">scarthgap</field>
-    <field type="CharField" name="description">Openembedded Scarthgap</field>
+    <field type="CharField" name="name">wrynose</field>
+    <field type="CharField" name="description">Openembedded Wrynose</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">scarthgap</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=scarthgap\"&gt;OpenEmbedded Scarthgap&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">wrynose</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=wrynose\"&gt;OpenEmbedded Wrynose&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -61,26 +61,26 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">whinlatter</field>
-    <field type="CharField" name="description">Openembedded Whinlatter</field>
+    <field type="CharField" name="name">scarthgap</field>
+    <field type="CharField" name="description">Openembedded Scarthgap</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">whinlatter</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=whinlatter\"&gt;OpenEmbedded Whinlatter&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">scarthgap</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=scarthgap\"&gt;OpenEmbedded Scarthgap&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="5">
-    <field type="CharField" name="name">walnascar</field>
-    <field type="CharField" name="description">Openembedded Walnascar</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">walnascar</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=walnascar\"&gt;OpenEmbedded Walnascar&lt;/a&gt; branch.</field>
-  </object>
-  <object model="orm.release" pk="6">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Openembedded Kirkstone</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=kirkstone\"&gt;OpenEmbedded Kirkstone&lt;/a&gt; branch.</field>
   </object>
+  <object model="orm.release" pk="6">
+    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="description">Openembedded Whinlatter</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
+    <field type="CharField" name="branch_name">whinlatter</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=whinlatter\"&gt;OpenEmbedded Whinlatter&lt;/a&gt; branch.</field>
+  </object>
 
   <!-- Default layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -108,6 +108,7 @@
     <field type="CharField" name="layer_name">openembedded-core</field>
   </object>
 
+
   <!-- Layer for the Local release -->
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index a8a5a7aeb08..3648170bb26 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -8,9 +8,9 @@
 
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model="orm.bitbakeversion" pk="1">
-    <field type="CharField" name="name">scarthgap</field>
+    <field type="CharField" name="name">wrynose</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.8</field>
+    <field type="CharField" name="branch">2.16</field>
     <field type="CharField" name="dirpath"></field>
   </object>
   <object model="orm.bitbakeversion" pk="2">
@@ -26,32 +26,32 @@
     <field type="CharField" name="dirpath"></field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="name">scarthgap</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.14</field>
+    <field type="CharField" name="branch">2.8</field>
     <field type="CharField" name="dirpath"></field>
   </object>
   <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">walnascar</field>
+    <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.12</field>
+    <field type="CharField" name="branch">2.0</field>
     <field type="CharField" name="dirpath"></field>
   </object>
   <object model="orm.bitbakeversion" pk="6">
-    <field type="CharField" name="name">kirkstone</field>
+    <field type="CharField" name="name">whinlatter</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.0</field>
+    <field type="CharField" name="branch">2.14</field>
     <field type="CharField" name="dirpath"></field>
   </object>
 
 
   <!-- Releases available -->
   <object model="orm.release" pk="1">
-    <field type="CharField" name="name">scarthgap</field>
-    <field type="CharField" name="description">Yocto Project 5.0 "Scarthgap"</field>
+    <field type="CharField" name="name">wrynose</field>
+    <field type="CharField" name="description">Yocto Project 6.0 "Wrynose"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
-    <field type="CharField" name="branch_name">scarthgap</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=scarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">wrynose</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=wrynose"&gt;Yocto Project Wrynose branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -68,26 +68,26 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">whinlatter</field>
-    <field type="CharField" name="description">Yocto Project 5.3 "Whinlatter"</field>
+    <field type="CharField" name="name">scarthgap</field>
+    <field type="CharField" name="description">Yocto Project 5.0 "Scarthgap"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">whinlatter</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=whinlatter"&gt;Yocto Project Whinlatter branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">scarthgap</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=scarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="5">
-    <field type="CharField" name="name">walnascar</field>
-    <field type="CharField" name="description">Yocto Project 5.2 "Walnascar"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">walnascar</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=walnascar"&gt;Yocto Project Walnascar branch&lt;/a&gt;.</field>
-  </object>
-  <object model="orm.release" pk="6">
     <field type="CharField" name="name">kirkstone</field>
     <field type="CharField" name="description">Yocto Project 4.0 "Kirkstone"</field>
-    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
     <field type="CharField" name="branch_name">kirkstone</field>
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=kirkstone"&gt;Yocto Project Kirkstone branch&lt;/a&gt;.</field>
   </object>
+  <object model="orm.release" pk="6">
+    <field type="CharField" name="name">whinlatter</field>
+    <field type="CharField" name="description">Yocto Project 5.3 "Whinlatter"</field>
+    <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">6</field>
+    <field type="CharField" name="branch_name">whinlatter</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=whinlatter"&gt;Yocto Project Whinlatter branch&lt;/a&gt;.</field>
+  </object>
 
   <!-- Default project layers for each release -->
   <object model="orm.releasedefaultlayer" pk="1">
@@ -180,7 +180,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">scarthgap</field>
+    <field type="CharField" name="branch">wrynose</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="2">
@@ -202,21 +202,21 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">whinlatter</field>
+    <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">walnascar</field>
+    <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="6">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="branch">kirkstone</field>
+    <field type="CharField" name="branch">whinlatter</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
 
@@ -232,7 +232,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">scarthgap</field>
+    <field type="CharField" name="branch">wrynose</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
   <object model="orm.layer_version" pk="8">
@@ -254,21 +254,21 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">whinlatter</field>
+    <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
   <object model="orm.layer_version" pk="11">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">walnascar</field>
+    <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
   <object model="orm.layer_version" pk="12">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="branch">kirkstone</field>
+    <field type="CharField" name="branch">whinlatter</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
 
@@ -284,7 +284,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">1</field>
-    <field type="CharField" name="branch">scarthgap</field>
+    <field type="CharField" name="branch">wrynose</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
   <object model="orm.layer_version" pk="14">
@@ -306,21 +306,21 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">whinlatter</field>
+    <field type="CharField" name="branch">scarthgap</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
   <object model="orm.layer_version" pk="17">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">walnascar</field>
+    <field type="CharField" name="branch">kirkstone</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
   <object model="orm.layer_version" pk="18">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">6</field>
-    <field type="CharField" name="branch">kirkstone</field>
+    <field type="CharField" name="branch">whinlatter</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index 51c8c120370..5de3c06f123 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -31,13 +31,30 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             False,
         )
 
-    def test_create_new_project_scarthgap(self):
+    def test_create_new_project_wrynose(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 5.0 "Scarthgap" (option value: 1)
+          - Release: Yocto Project 6.0 "Wrynose" (option value: 1)
           - Merge Toaster settings: True
         """
         release = '1'
+        release_title = 'Yocto Project 6.0 "Wrynose"'
+        project_name = 'projectwrynose'
+        self.create_new_project(
+            project_name,
+            release,
+            release_title,
+            True,
+        )
+
+
+    def test_create_new_project_scarthgap(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project 5.0 "Scarthgap" (option value: 4)
+          - Merge Toaster settings: True
+        """
+        release = '4'
         release_title = 'Yocto Project 5.0 "Scarthgap"'
         project_name = 'projectscarthgap'
         self.create_new_project(
@@ -50,10 +67,10 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
     def test_create_new_project_kirkstone(self):
         """ Test create new project using:
           - Project Name: Any string
-          - Release: Yocto Project 4.0 "Kirkstone" (option value: 6)
+          - Release: Yocto Project 4.0 "Kirkstone" (option value: 5)
           - Merge Toaster settings: True
         """
-        release = '6'
+        release = '5'
         release_title = 'Yocto Project 4.0 "Kirkstone"'
         project_name = 'projectkirkstone'
         self.create_new_project(

