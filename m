Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E611EC54EAA
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 00:55:26 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.91829.1674780923381493196
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 16:55:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=V/LnYqrD;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id j17so2439447wms.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 16:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3U21yLFUtDtRCsasq2BmP4s2AVivrRgPKDrlIGOJjg=;
        b=V/LnYqrD+oaTWCUWH8lBA1v6PknOos103vCMqo9sJrZmJwk9cGCKlqm0HClCpn1Ext
         UmlV9AoTaI2UpBEhRRMd8mBzjfGtvEA1OGbuAvpbW5NzzulmDC0aPtAhMmkBzzipuiPd
         8oBuHqu7Dh8yLa732CmWb/c9rboHHJzLKOFwNoJ0GDo42VhBTCUy/YIksa7ABkpLM9Hi
         kyymqW+HyPbHn7pjgBnBDSu+wlW8mLk/QSdGkSW+kF7m7dv/7A87Cgl1qbmfhyWRSiof
         42XKiXnOO15N45v+F5P7ZjJ9r9TiSwDQJx5q/lmVPz2Y4HcBFwjjeG8l/L+judSbGl9h
         H5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3U21yLFUtDtRCsasq2BmP4s2AVivrRgPKDrlIGOJjg=;
        b=Hlw1f2K6lSETz8HzQfqOA/wm7i4dq2f4zs8+TxlR0qdmi5imZSVPBN/eqGxf0k9C3i
         nZe/0DA4yQbRP546CMoBLZKsRRF2i/YdEos0G+AZsSYHH2BR6t8PiJJen6aKsPDZdjgr
         TyzI3hkaZO4Oj3nEW8JXa1OQBLoqbuddyCSyXU4cMVthdl+S0uQFwBIsklBY/XaOnf3V
         0RUrLpzcXAqr/qQn3rlrUPvPbdL24ceWyEX6tbRHYI/2/XoU1nuKlH6dMTx7V1nTgFyM
         lYXNIfVIr+WF00v++kZBsqZtWW4s+37LYlir0CpBfdJkowPUX2BInmF/wG8Q7viP/6Ht
         2mpw==
X-Gm-Message-State: AFqh2kphtBCQRHvlDfcAoGfFP92pgFuQ2Q9BaT0vsfEW7F00YFAcFu58
	f1PnDjdDo2ra5zRcCOY/7dTVn1ovPyc=
X-Google-Smtp-Source: AMrXdXsCpuiAYo0WQpE/rHaW+XscSlNOVW+9hRvbWDAorozwUVBk31C0lSf63PBAQJ9FKDJ1PpZxYQ==
X-Received: by 2002:a05:600c:4395:b0:3da:2829:2935 with SMTP id e21-20020a05600c439500b003da28292935mr37407403wmn.11.1674780921648;
        Thu, 26 Jan 2023 16:55:21 -0800 (PST)
Received: from CTW-01843.criticaltechworks.com ([88.157.222.244])
        by smtp.gmail.com with ESMTPSA id e38-20020a05600c4ba600b003db11dfc687sm2744576wmp.36.2023.01.26.16.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:55:21 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [PATCH 2/2] query.py: Adjust show-layers output layout
Date: Fri, 27 Jan 2023 00:54:57 +0000
Message-Id: <20230127005457.48733-2-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127005457.48733-1-pedro.miguel.baptista@gmail.com>
References: <20230127005457.48733-1-pedro.miguel.baptista@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jan 2023 00:55:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14357

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

Increase the `ljust` value for each column in show-layers
output. This improves readability  when long layer paths are
included

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 lib/bblayers/query.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 4c071326..bec76db9 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -29,12 +29,12 @@ class QueryPlugin(LayerPlugin):
 
     def do_show_layers(self, args):
         """show current configured layers."""
-        logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
-        logger.plain('=' * 74)
+        logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(70), "priority"))
+        logger.plain('=' * 104)
         for layer, _, regex, pri in self.tinfoil.cooker.bbfile_config_priorities:
             layerdir = self.bbfile_collections.get(layer, None)
             layername = layer
-            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(0), pri))
+            logger.plain("%s  %s  %s" % (layername.ljust(20), layerdir.ljust(70), pri))
 
     def version_str(self, pe, pv, pr = None):
         verstr = "%s" % pv
-- 
2.25.1


