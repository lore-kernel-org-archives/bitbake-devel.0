Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EAEC54E94
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:23:18 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.6415.1674336188748018524
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:23:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZHwQWO4x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so6030182wmq.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EQe4YsqesQOgoZPdpKCH2JMHdTzZgiau54EwtXscr0=;
        b=ZHwQWO4xmHIAizJl6VSqhknd/goMayD53ZwnpJ+u/MnQN2XHcnts+bvXUiLj177Nrc
         MPx8fgcZ0MZlXzSnDvJ6mmPiSZfRGsiXc1tjIjYDj4b8H6BtPZku1w1x35jz9IlhGOeb
         9jB9onIOJ4BNS4dP9W8ZXOsITvezvdygzJT5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EQe4YsqesQOgoZPdpKCH2JMHdTzZgiau54EwtXscr0=;
        b=sESd36HpotWzlZvNQo9TBuxuv0mBhlspVDzgTHPIz5Ku7KfmGAPcKOjfEDH6b3xfNf
         +qnVm+QzjNYeMvjln2rFBqSlciLwM4yQ8iEIUG3j+A2Ebk+mWT1K41ybXuScqo7OSg2t
         3Sq2k7oreOYPW5ZUj/b4qSCfYml8RZ0uHeHK7a6E+IPj6P834TZVUNwbebuyC8hh0kHj
         KOw+3EHkDkrGV9drgnj1NyyjAdVNhsLt4Vm0A+JKws0EeoFVTEWumIYbi1oJ0NgNY3fc
         cuCbWLXj/Q6xUkdb9xP00aVdP1qWXFNo6nDFlnp4W/uvdyt0hTdtqRWvZ66O8qsEdKYX
         ek8Q==
X-Gm-Message-State: AFqh2kq+/pvcvP9c6ZKiZaGLTyy2mITx62HJUrp5V+Rwb0EjlY4t8ksl
	XtX/n5m4tprYut4O941yhoS2Vjl5zWar4ebk
X-Google-Smtp-Source: AMrXdXsAaPRWqSUH/WFsEz4SaFzdVqnTSwTbtFTU0DHcbMjkZVyA1yg4hfM0w2Gf/2nDCqEpXtk7fQ==
X-Received: by 2002:a05:600c:35ce:b0:3db:1caf:1020 with SMTP id r14-20020a05600c35ce00b003db1caf1020mr11832734wmq.35.1674336187121;
        Sat, 21 Jan 2023 13:23:07 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm6713089wmq.29.2023.01.21.13.23.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:23:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/6] cooker: Fix siggen recipe cache race issue
Date: Sat, 21 Jan 2023 21:23:01 +0000
Message-Id: <20230121212305.2171310-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
References: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:23:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14329

We need to reset the cache before the start() call which starts the
parsing processs, tweak the code to ensure this is the case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 617d582acc..d15ad2fb2e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2187,12 +2187,11 @@ class CookerParser(object):
         self.num_processes = min(int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS") or
                                  multiprocessing.cpu_count()), self.toparse)
 
+        bb.cache.SiggenRecipeInfo.reset()
         self.start()
         self.haveshutdown = False
         self.syncthread = None
 
-        bb.cache.SiggenRecipeInfo.reset()
-
     def start(self):
         self.results = self.load_cached()
         self.processes = []
-- 
2.37.2


