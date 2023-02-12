Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CBC636CC
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 00:21:01 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.2157.1676161256154660641
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Feb 2023 16:20:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=CBEsz4xD;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso8840464wms.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Feb 2023 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYj6W78EGBPa+ORRMzTskf/tadaf1RKLYnq2oFufxB8=;
        b=CBEsz4xDDUN3b/WI1cHhI2Lt1Oy6Os2fEI5GhtJ4QaXt7NU9zK2sh7jsR7+6NF5lF8
         9m1qXlOtN4gLDA5aZJ4LvyneCCMC/fj7H2ISqKWZ3Vn/6gS0xOH3o5PMvBRmBfyHVEHg
         LGWTT2s/EUqn6QobtduvdNfSTaYvnBy+c05RvD8EZXGFJT/r7U03WZPUFSMs1OMrn5lF
         k7gk8Z0nryS4z2Yle10SXo7aBEyRDkHeeHZ11WNBnvoNpRFRK/oaRHlj3TSoBSFsCogQ
         p5cUkJ0u/5mEs5YZ8FalHA5gTQnjOFRqO15LskIyrxvjaGF4wKaMIil7+uJSi5U++wjo
         zSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYj6W78EGBPa+ORRMzTskf/tadaf1RKLYnq2oFufxB8=;
        b=nNvlvdDoqqNxPquRSU5c9BKKkMrz1PbQv7oqydJEZX/7XFAzGRPst+uRAxXkwcYCsp
         VBQo7gvfKQc4yfWXl+4hilPTdH0npn7g/4pfJdhCtwBYxvoMT9rPKXH3fLNvSHGNTY3w
         pDP5jyFBjmls1mBD4y415o0EP4OfytVuH7cdjKf6O+ez2vSSdwB3FCOzDfbo5Mt9A2JC
         +XqMd96kN2T9vPqttf1zHzOhPRzzY62txc4oTpQrw7ndWL9WoFZa3csJHK3PrRWklKbg
         dAQSvuYyqSfcJHPrs3lQTkL9Rgt70vOf/YxKx9Ruo6sxQDkuOjGPR4wVoJsjgD3LEl92
         MAlA==
X-Gm-Message-State: AO0yUKWObDF6VAPSIx1UiZqM6pblLuPLf9Vm5yR7LkG07JyTpBiOD63V
	JeOy5n6IJI9XEm61qzxX08qG289RsbY=
X-Google-Smtp-Source: AK7set86kBN+J8g4airS8SzzEXi+BrQg/Wsgq9A4AOzzjlfJt3Fir3uUj2zCHwffyzOAP35f8Aiu5Q==
X-Received: by 2002:a05:600c:44c9:b0:3df:f9e9:7600 with SMTP id f9-20020a05600c44c900b003dff9e97600mr16156255wmo.25.1676161254488;
        Sat, 11 Feb 2023 16:20:54 -0800 (PST)
Received: from localhost.localdomain (dsl-120-219.bl27.telepac.pt. [176.79.120.219])
        by smtp.gmail.com with ESMTPSA id s21-20020a1cf215000000b003e001119927sm12232081wmc.24.2023.02.11.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 16:20:54 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [PATCH 2/2] action.py: add BUILDDIR in bblayers_conf path for remove-layer
Date: Sun, 12 Feb 2023 00:20:24 +0000
Message-Id: <20230212002024.5430-2-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230212002024.5430-1-pedro.miguel.baptista@gmail.com>
References: <20230212002024.5430-1-pedro.miguel.baptista@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Feb 2023 00:21:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14395

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

By including the full path to bblayers.conf the remove-layer
command can be executed from any location, not only from the
build directory.

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 bitbake/lib/bblayers/action.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index 76a2c5acd2..f26b34d0cb 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -65,7 +65,7 @@ class ActionPlugin(LayerPlugin):
 
     def do_remove_layer(self, args):
         """Remove one or more layers from bblayers.conf."""
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        bblayers_conf = os.path.join(os.environ['BUILDDIR'], 'conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
-- 
2.34.1


