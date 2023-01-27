Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6148C61D97
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 00:55:26 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.91824.1674780917497698391
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 16:55:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=F9QHubxb;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so2399470wmq.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3yZBijbuqbPdPBcHIxqV8tY9rlRcTZQ9aVRSZBaebhw=;
        b=F9QHubxbKFxiACjk18iKa9iFfQ20JDMzPx3oDr3Ghvk9y1cwY1vlC2LMcEG/q4/wVF
         s6JzL4kRvbnKfVt1n0+ZEZy1rGVnuzJ4eaOK7k1VvlopuL0kghUbLhZHiKaE5l+KnpmT
         qnMmLKm3RGR2PuoUiz9UL2jkZbh0H22AE1rS0CQkBw9+vM6XNwdZaKC6sX1HUo4ZUNHW
         OJTcK09GrelB7RBRPV1Ex9uAINzb1XhNvSuUm0j314k17NrF6nqlcS824diKaBgFNT4M
         tP44av5+X1Qd9ok1b6SksNQf5QOZM/iEOOd09uK80C3JV/K61onSfhQ1BxAMagJZrhHI
         Cq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yZBijbuqbPdPBcHIxqV8tY9rlRcTZQ9aVRSZBaebhw=;
        b=pmAdNJyrnJpjV9y3ofthU0mSHFVja6/TaD9lVvnllk0WV0X7uVJ67j0qaoigiaNMk7
         l4VJXbmdMH2JEqRJj8HajwjqjBMfmm8v81aIWWwyhJx/sNHgj4UR0xJ9oL146oEJEYBV
         7kYzwGg0ArWOe5ijYVlGUyIGk/gnZrWlreZWv8tW2vg2XJwaqQkju0tAGEAO6hVTBctN
         WH74HhRA1fV2QIs2ubS13q4l7exMTsF8S3oHPTHRdGuUAtweOCC+sQEc5rCapD+0SaI3
         lt3fNblp8aOrZAOOs6isv/BUuB6XpkWPBEzp9UxymhZf2zbtXut2pz5r4rAlSuBryIHz
         X/ZA==
X-Gm-Message-State: AFqh2kq74EzMrjQyPBGNukPsTglr0AxPKAkZtngaxVJ021DGqpyFTIuG
	nCkpor/X7DFHKHtbB9FYFpCGMwzz2Rc=
X-Google-Smtp-Source: AMrXdXvmUmO+DnV5+NKzkHw0+183FdqGMDSJX0fTwwDYEYZlk4o11Po/8o9GaPlMN8hn0IYMVqSv9Q==
X-Received: by 2002:a05:600c:a4d:b0:3db:1d6:16f7 with SMTP id c13-20020a05600c0a4d00b003db01d616f7mr34951771wmq.23.1674780915640;
        Thu, 26 Jan 2023 16:55:15 -0800 (PST)
Received: from CTW-01843.criticaltechworks.com ([88.157.222.244])
        by smtp.gmail.com with ESMTPSA id e38-20020a05600c4ba600b003db11dfc687sm2744576wmp.36.2023.01.26.16.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:55:15 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [PATCH 1/2] query.py: Replace layer directory name with layer name for show-layers
Date: Fri, 27 Jan 2023 00:54:56 +0000
Message-Id: <20230127005457.48733-1-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 00:55:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14356

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

Replace the layer directory name with the name from BBFILE_COLLECTIONS
which is useful when assigning a LAYERDEPENDS value

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 lib/bblayers/query.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index afd39518..4c071326 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -33,8 +33,8 @@ class QueryPlugin(LayerPlugin):
         logger.plain('=' * 74)
         for layer, _, regex, pri in self.tinfoil.cooker.bbfile_config_priorities:
             layerdir = self.bbfile_collections.get(layer, None)
-            layername = self.get_layer_name(layerdir)
-            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), pri))
+            layername = layer
+            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(0), pri))
 
     def version_str(self, pe, pv, pr = None):
         verstr = "%s" % pv
-- 
2.25.1


