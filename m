Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59244C636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 13:55:58 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.14613.1676296556232010991
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Feb 2023 05:55:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Ez/1KVDp;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso3726366wmo.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 05:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuhgLBmoOYJJj+DDdC1z/F1xkw1sSe6H/Q9TLlIp40k=;
        b=Ez/1KVDpnzh3TTpSCWrwEWmASfnLJMk0Ya5FXb8y+mUGQ+VcDyb8UQ6aXKLFI9I/28
         Ck7nuEXFMNjCW/T+tqb5kbI4dMiBXLjSqOrF7fWHEvqnQT2eXF/bnnI48lKXTvmvwNZa
         M2F74oImqkGXfSkNksAgMxaFrrzQPiAYzOmNovuwqsXVFOtHelQ3oMZQfEXUvrInZVSr
         zGRWL1Ff8q221Q2G0/FOThwI2pQ0MAhAZVB0B2b4JS0Cwj5d0davTP/soVA5Mus4pdjS
         J0LxjOzbwdrQHCrCISrJHlFGD7INp3oqC5U+1gQfex9KtSjK4m012CZh8qrKUGhkZhSA
         w7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuhgLBmoOYJJj+DDdC1z/F1xkw1sSe6H/Q9TLlIp40k=;
        b=45OwoZUZ9lkLOV/vAfbghJHFdF3lTq2pI5fDvc0w+aZ8adIVLZbyg4l883uInSj1AO
         1ExH5/Gshl+2Q1q9RaJShYjIvLTrj7JJcQWEl80JckVNf78tvwirdzWBSgXsZDasHMCm
         tOYMGYKL1jkdSYTUoDXYrXSOU40ZyD4NIXhHakWz+OlwuR+hyKyJZ+LGH2t9UXVNse5U
         yPdBmpl1mlFOd4cy798QQ68gxJo+tmfr66sCFqZS3kaYMw2lPF9hHvV+Y3Q+HGpDbRiJ
         bOCNleHa9RCk4el9S0Vvgsqnpwcrfm/9aeN4J8Nz1C2jO2aPW2rPu6U7Jr7U5m3YQwY1
         DQtQ==
X-Gm-Message-State: AO0yUKXIuzqrRx2qbx7abDYPVKs1S9tqul/SwUA5x+s7edgIlp4M2KtU
	M1A9+2vVChrQuB0+aW9MzQl7M4XtG7I=
X-Google-Smtp-Source: AK7set9GM6vZQEbYIKRqrvDqYLf8wb+BXxoU898Um5S6tsfmnBBAcDpbWAtIMplcYUhea+OMMfdB3w==
X-Received: by 2002:a05:600c:3416:b0:3df:50eb:7ca6 with SMTP id y22-20020a05600c341600b003df50eb7ca6mr19335030wmp.15.1676296554554;
        Mon, 13 Feb 2023 05:55:54 -0800 (PST)
Received: from localhost.localdomain ([213.13.226.153])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003daf6e3bc2fsm24594799wms.1.2023.02.13.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 05:55:54 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [bitbake][PATCHv2 2/2] action.py: add BBPATH in bblayers_conf path for remove-layer
Date: Mon, 13 Feb 2023 13:55:25 +0000
Message-Id: <20230213135525.3650-2-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213135525.3650-1-pedro.miguel.baptista@gmail.com>
References: <20230213135525.3650-1-pedro.miguel.baptista@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 13:55:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14398

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

By including the full path to bblayers.conf the remove-layer
command can be executed from any location, not only from the
build directory.

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 bitbake/lib/bblayers/action.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index a2208db0bc..dab4dc0107 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -65,7 +65,7 @@ class ActionPlugin(LayerPlugin):
 
     def do_remove_layer(self, args):
         """Remove one or more layers from bblayers.conf."""
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        bblayers_conf = os.path.join(os.environ['BBPATH'], 'conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
-- 
2.34.1


