Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5861C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 01:33:41 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.2024.1678844014556679441
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 18:33:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bu5S0nYA;
 spf=pass (domain: gmail.com, ip: 209.85.210.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f174.google.com with SMTP id ay18so10855810pfb.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 18:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678844015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4uB5U+Wyu3LfouGSp0vOrfbQ6j2CgnLhj1afZ8O/rU=;
        b=bu5S0nYAm6+8JyMWC+Qepv7M0a9ObFdvThUr4/PjbDuqpwN9RTS1neqhxsXZhHhUki
         rrMM9fFEmcdyBV0PUDukWrExUwUUYkTJphs9tflQ8zdk6umZaCG33k4i7NIhN/eFGmIm
         6WIzGUQ+s3HWqU9Ea9um9i8JdZTO1hBb33l1RaZ2j1LSXgxQASSMMeC1krnJUc49Ujnn
         usEZpRRx5y776upoJMogjJBZD4UaMTKOXwIOS/GwWaMXGYZk/JJh+ae9MBJeNBEVkUIj
         DEObQl5SJyvlNy0j7TEPl3E/bMa/fHc7RK6K6aP760mNEqSyBAFoOFNefpc8HOhwVn7E
         H1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678844015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4uB5U+Wyu3LfouGSp0vOrfbQ6j2CgnLhj1afZ8O/rU=;
        b=IRISkcOHNYDHQuTLoFr1xricwVG3sinPrxXX4JSXJj0Irq8yY5tSrVIKvWqhvW8xKv
         sNh5PQGUGiUC2h8nyEvAXem/reZ6HOAuP8GjzdcuAOzy0JYme/8Ipbj47CHaNsbsQfdC
         BJhCdGCmi1O7tdij8eAWg9l1yZNFMatZCoz2a7IYzUqHMIuU+C3jNqS163MXRRYtiPiC
         xml0zqAE76+w/gXqj9EvTW6WAPT+cIBR4Gg1IRD0/c/FziHcaAfRxo7sFrgbQ9jU/1J9
         4ALHOy17y2KK3RoTrKIDm8rliI/3gj6lRilEacrnlS2h2RAPnB3dOBfOY5Pw5I1RlL0j
         fkAg==
X-Gm-Message-State: AO0yUKUF+d5D4NVLyrz7Uxycg8xnl0dgBeGtO3FwpKe2COzT8IkBf1yS
	H82z0QsjMkOvox1SA9ir8fq7Yfcf9X8=
X-Google-Smtp-Source: AK7set+9jBtNQi+IOTltKjgVBtSzzBXKCj0FtgIAVBZA6RiZ5fKTOssfQq45f9K+NlDKllQE889OyA==
X-Received: by 2002:aa7:843b:0:b0:622:5be5:212c with SMTP id q27-20020aa7843b000000b006225be5212cmr10953459pfn.2.1678844015342;
        Tue, 14 Mar 2023 18:33:35 -0700 (PDT)
Received: from chiron.. ([2601:1c0:ca00:cea0:155f:ded0:e803:df3c])
        by smtp.gmail.com with ESMTPSA id t21-20020a62ea15000000b00571cdbd0771sm397745pfh.102.2023.03.14.18.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 18:33:35 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [mickledore][2.4][PATCH 2/2] toaster: update fixtures for mickledore
Date: Tue, 14 Mar 2023 18:33:06 -0700
Message-Id: <f37e4d6bbdc7ce21fc009ec9ede8c75c1f48822f.1678843397.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678843397.git.tim.orling@konsulko.com>
References: <cover.1678843397.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 01:33:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14562

After updating gen_fixtures.py for 'mickledore' 4.2,
run './gen_fixutures.py --all' to update oe-core.xml
and poky.xml.

Drop langdale as support is ending soon.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 615e88aba..950f2a98a 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,9 +23,9 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">langdale</field>
+    <field type="CharField" name="name">mickledore</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">2.2</field>
+    <field type="CharField" name="branch">2.4</field>
   </object>
   <object model="orm.bitbakeversion" pk="5">
     <field type="CharField" name="name">dunfell</field>
@@ -56,11 +56,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">langdale</field>
-    <field type="CharField" name="description">Openembedded Langdale</field>
+    <field type="CharField" name="name">mickledore</field>
+    <field type="CharField" name="description">Openembedded Mickledore</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">langdale</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=langdale\"&gt;OpenEmbedded Langdale&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">mickledore</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=mickledore\"&gt;OpenEmbedded Mickledore&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="5">
     <field type="CharField" name="name">dunfell</field>
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index 04e12f96f..121e52fd4 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,9 +26,9 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">langdale</field>
+    <field type="CharField" name="name">mickledore</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">langdale</field>
+    <field type="CharField" name="branch">mickledore</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="5">
@@ -62,11 +62,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">langdale</field>
-    <field type="CharField" name="description">Yocto Project 4.1 "Langdale"</field>
+    <field type="CharField" name="name">mickledore</field>
+    <field type="CharField" name="description">Yocto Project 4.2 "Mickledore"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">langdale</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=langdale"&gt;Yocto Project Langdale branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">mickledore</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=mickledore"&gt;Yocto Project Mickledore branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="5">
     <field type="CharField" name="name">dunfell</field>
@@ -177,7 +177,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">langdale</field>
+    <field type="CharField" name="branch">mickledore</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
   <object model="orm.layer_version" pk="5">
@@ -222,7 +222,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">langdale</field>
+    <field type="CharField" name="branch">mickledore</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
   <object model="orm.layer_version" pk="10">
@@ -267,7 +267,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">langdale</field>
+    <field type="CharField" name="branch">mickledore</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
   <object model="orm.layer_version" pk="15">
-- 
2.34.1


