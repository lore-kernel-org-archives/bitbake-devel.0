Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D82C6FD1F
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 20:31:56 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.6301.1678825908590765764
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 13:31:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=baWVLC3y;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso6134161pjb.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678825908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7tOVN50RfWNaRZD8DGFCNl6ssSZL9ythi52vlc0iyI=;
        b=baWVLC3yfZN9weKep4kCHEgSMp790l9WbNpwS1c+GrcmzKIeF/7fwqDC1fMNs29idL
         AebYO8p71Hnx1WWiVl6vTXuUZ+LPnzGvcd+HI9VHQPI/6Oie7bReMNpUKkple+2etLhT
         jA2uAd5IpngCEXVVk1KNfDsSFIcW7JHiY35E7VBipfv9Px2dJFHBZ30wBER2o42bNsyE
         u2z5dnOXVU8K8dihkLQjTsY6IB+88f8uqwDYUVDcskCRVnqjZFoJWt9sXSkzSSyVBx56
         nLbkLlChqbrPFcmAxHFtbHbbeR3yrAFFP+ZcTMU+fF9OCsTmtXEQjMNJqtuzj7QxK6ds
         eIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7tOVN50RfWNaRZD8DGFCNl6ssSZL9ythi52vlc0iyI=;
        b=M5aL1iz6tBkyiCo22rLR3aKicNzxTSakqirxDpKM8qn8Ib4ljjYpdfWuljc2usgo4+
         9++Gk+ALqCAeWDMLuAISi/kP+ur1KF47alZLxFPzgqZ46O+0i301zkWNQasZaWTzXEYO
         jY4Ejgoym7L3lsX84c+GAKA2lCP5DlDoBHrL1mI2yC1Lx73f+BlcTKpBO3n3KuySUFs0
         bgxRj6EqkXL06otf9tVGB29O3KVw2LEVeyR0NjxPPwMHwrQH79L4qRWnfMhh79qQQ1VH
         A59yInBb3Pr/TRji6HJMDBQfj1bLujNsI7V5kgX7kwSBSjnO+hqJ6ozInLne4/LeW4O9
         fktQ==
X-Gm-Message-State: AO0yUKVt5p5huX1GB7hW+VA3h3Nz6MMiYvteTFPS06ekislC0x55PvTx
	1BQRQsihomF8ZYZdti4xIRK48STppwE=
X-Google-Smtp-Source: AK7set+DusNTk0Z6gTN8qjoGJN1CCIpCb1x8zA82OVufJ0gvlQRZ4ljo4qBjrdMDvtrV92X43wuWow==
X-Received: by 2002:a17:903:430b:b0:19c:171a:d346 with SMTP id jz11-20020a170903430b00b0019c171ad346mr216679plb.44.1678825907714;
        Tue, 14 Mar 2023 13:31:47 -0700 (PDT)
Received: from chiron.. ([2601:1c0:ca00:cea0:155f:ded0:e803:df3c])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001a076568da9sm215464plr.216.2023.03.14.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:31:47 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: steve@sakoman.com
Subject: [langdale][2.2][PATCH 3/3] toaster: Add refreshed oe-core and poky fixtures
Date: Tue, 14 Mar 2023 13:31:30 -0700
Message-Id: <2c883cd8af4bd35836dee64e782e5172ae416fff.1678825322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678825322.git.tim.orling@konsulko.com>
References: <cover.1678825322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 20:31:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14559

After updating gen_fixtures.py, run ./gen_fixtures.py --all

This includes the latest stable/supported releases.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 26 ++++++++++----------
 lib/toaster/orm/fixtures/poky.xml    | 36 ++++++++++++++--------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 450e7a2f8..615e88aba 100644
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
@@ -23,14 +23,14 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="name">langdale</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.52</field>
+    <field type="CharField" name="branch">2.2</field>
   </object>
   <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">hardknott</field>
+    <field type="CharField" name="name">dunfell</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.50</field>
+    <field type="CharField" name="branch">1.46</field>
   </object>
 
   <!-- Releases available -->
@@ -56,18 +56,18 @@
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
+    <field type="CharField" name="branch_name">langdale</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=langdale\"&gt;OpenEmbedded Langdale&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="5">
-    <field type="CharField" name="name">hardknott</field>
-    <field type="CharField" name="description">Openembedded Hardknott</field>
+    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="description">Openembedded Dunfell</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">hardknott</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=hardknott\"&gt;OpenEmbedded Hardknott&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">dunfell</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=dunfell\"&gt;OpenEmbedded Dunfell&lt;/a&gt; branch.</field>
   </object>
 
   <!-- Default layers for each release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 20fcc0176..04e12f96f 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,15 +26,15 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">honister</field>
+    <field type="CharField" name="name">langdale</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">honister</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="5">
-    <field type="CharField" name="name">hardknott</field>
+    <field type="CharField" name="name">dunfell</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">dunfell</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
@@ -62,18 +62,18 @@
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
+    <field type="CharField" name="branch_name">langdale</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=langdale"&gt;Yocto Project Langdale branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="5">
-    <field type="CharField" name="name">hardknott</field>
-    <field type="CharField" name="description">Yocto Project 3.3 "Hardknott"</field>
+    <field type="CharField" name="name">dunfell</field>
+    <field type="CharField" name="description">Yocto Project 3.1 "Dunfell"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">5</field>
-    <field type="CharField" name="branch_name">hardknott</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=hardknott"&gt;Yocto Project Hardknott branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">dunfell</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=dunfell"&gt;Yocto Project Dunfell branch&lt;/a&gt;.</field>
   </object>
 
   <!-- Default project layers for each release -->
@@ -177,14 +177,14 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">honister</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">dunfell</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
 
@@ -222,14 +222,14 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">honister</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
   <object model="orm.layer_version" pk="10">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">dunfell</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
 
@@ -267,14 +267,14 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">honister</field>
+    <field type="CharField" name="branch">langdale</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
   <object model="orm.layer_version" pk="15">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">5</field>
-    <field type="CharField" name="branch">hardknott</field>
+    <field type="CharField" name="branch">dunfell</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
-- 
2.34.1


