Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F00C4332F
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 20:23:32 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web08.140.1649188892873188012
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 13:01:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=VMZk4lAe;
 spf=pass (domain: gmail.com, ip: 209.85.215.170,
 mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f170.google.com with SMTP id s21so320740pgs.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgVCw8zE55KQ6vydfJv/YkBhX9d59hFr4BJEiw12pp0=;
        b=VMZk4lAedCcOMSKd26BAGmBYtrWXVkqaDMVWxHmxrNTno61umF9h2w0ZiZWsFZMiSP
         c7jzDfL0eJvoqcpARfeuIJABywBvSjx8SEIqqDPIWfYm3EYqTVSV8HOCcsy9HOVDQzD9
         L1+WHjFYcHL7MkQMcWaKJRIpVf3Uw1LSRX7v7013iBYR29WBfjxILlr2y31/V6SjEGLz
         yNxKMpMFKVb+s4wVxj3NLXJecuaqv2Mqm87ld4eXP/XMXfmWvxr1v0KVVpR+ZgOtmP6H
         bsuiryJ9JsAG2BTSAzDmzIcIBkeYhvidbBk9WTR6AXXHKS952C38nowAWZgVB3GS0rQ5
         XvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgVCw8zE55KQ6vydfJv/YkBhX9d59hFr4BJEiw12pp0=;
        b=UIB7EyQYQG5RpfQBvqE6JDg7ou6ifoWtlIptfgzpDS+RpMkPO3qFqNaaPt2sca3Xab
         A8/nAwkD+06fP5A2k6zqsp0tZW3Ukqt25lvKwj2EVq5kPrHBTIW8EOgnmy+I/7TspuV2
         bQjju3fFIBLO5bxenw6nOBUIE+S8UScuLCfLXagJ3BT7BEEQyZB+j15xyxciNkdHs4x0
         zgK0ybfBfpmsbfpDN9LmyKoUm6Z2mN7cJy15/6I46Tbmv5JOlQH47DK+3WxCPKAtopDI
         RBfWi2y3haqxpvaDc6BICx2GQjs0T5163km7/DWGH6WhL45q68tP8Ix4Si4TPDurWflm
         EuZg==
X-Gm-Message-State: AOAM533i1wI+L8WlNVnMDEMKwVXuJzwnhfdEiF2lc7JZ53Cu0hyWt+WW
	C1r1I35rcAc4B1WDU3NCXr2oMbTpIas=
X-Google-Smtp-Source: 
 ABdhPJzGLEk1kituczyIUemCp1oYri0+IB0L44A0k1pq/7Zo8yFWV+gAgI/9w75Yn7U2j4Yp8ecv6A==
X-Received: by 2002:a63:5756:0:b0:36c:67bc:7f3f with SMTP id
 h22-20020a635756000000b0036c67bc7f3fmr4215470pgm.389.1649188891828;
        Tue, 05 Apr 2022 13:01:31 -0700 (PDT)
Received: from nereus.hsd1.or.comcast.net
 ([2601:1c0:6000:1b20:3168:a6eb:9b6b:c371])
        by smtp.gmail.com with ESMTPSA id
 w22-20020a17090aea1600b001ca91b7542esm2994723pjy.51.2022.04.05.13.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 13:01:31 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [1.50][hardknott][PATCH] toaster: fixtures: gatesgarth -> hardknott
Date: Tue,  5 Apr 2022 13:01:04 -0700
Message-Id: <20220405200104.2681257-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Apr 2022 20:23:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13585

Replace gatesgarth (and bitbake 1.48) with hardknott (and bitbake 1.50)

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/oe-core.xml | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml    | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/orm/fixtures/oe-core.xml b/lib/toaster/orm/fixtures/oe-core.xml
index 026d9486..bb58c6f1 100644
--- a/lib/toaster/orm/fixtures/oe-core.xml
+++ b/lib/toaster/orm/fixtures/oe-core.xml
@@ -23,9 +23,9 @@
     <field type="CharField" name="branch">master</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
+    <field type="CharField" name="name">hardknott</field>
     <field type="CharField" name="giturl">git://git.openembedded.org/bitbake</field>
-    <field type="CharField" name="branch">1.48</field>
+    <field type="CharField" name="branch">1.50</field>
   </object>
 
   <!-- Releases available -->
@@ -51,11 +51,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
-    <field type="CharField" name="description">Openembedded Gatesgarth</field>
+    <field type="CharField" name="name">hardknott</field>
+    <field type="CharField" name="description">Openembedded Hardknott</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">gatesgarth</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=gatesgarth\"&gt;OpenEmbedded Gatesgarth&lt;/a&gt; branch.</field>
+    <field type="CharField" name="branch_name">hardknott</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=hardknott\"&gt;OpenEmbedded Hardknott&lt;/a&gt; branch.</field>
   </object>
 
   <!-- Default layers for each release -->
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/poky.xml
index a468a54c..483d9d8f 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -26,9 +26,9 @@
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
   <object model="orm.bitbakeversion" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
+    <field type="CharField" name="name">hardknott</field>
     <field type="CharField" name="giturl">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
     <field type="CharField" name="dirpath">bitbake</field>
   </object>
 
@@ -56,11 +56,11 @@
     <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
-    <field type="CharField" name="name">gatesgarth</field>
-    <field type="CharField" name="description">Yocto Project 3.2 "Gatesgarth"</field>
+    <field type="CharField" name="name">hardknott</field>
+    <field type="CharField" name="description">Yocto Project 3.2 "Hardknott"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
-    <field type="CharField" name="branch_name">gatesgarth</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=gatesgarth"&gt;Yocto Project Gatesgarth branch&lt;/a&gt;.</field>
+    <field type="CharField" name="branch_name">hardknott</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=hardknott"&gt;Yocto Project Hardknott branch&lt;/a&gt;.</field>
   </object>
 
   <!-- Default project layers for each release -->
@@ -152,7 +152,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
     <field type="CharField" name="dirpath">meta</field>
   </object>
 
@@ -190,7 +190,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
     <field type="CharField" name="dirpath">meta-poky</field>
   </object>
 
@@ -228,7 +228,7 @@
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
     <field type="IntegerField" name="layer_source">0</field>
     <field rel="ManyToOneRel" to="orm.release" name="release">4</field>
-    <field type="CharField" name="branch">gatesgarth</field>
+    <field type="CharField" name="branch">hardknott</field>
     <field type="CharField" name="dirpath">meta-yocto-bsp</field>
   </object>
 </django-objects>
-- 
2.30.2


