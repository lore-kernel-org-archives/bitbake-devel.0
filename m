Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C4C433EF
	for <webhook@archiver.kernel.org>; Thu, 28 Apr 2022 14:15:48 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.10884.1651155337917505055
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Apr 2022 07:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OC10ic80;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id e24so6966046wrc.9
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Apr 2022 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TozltjYGe2ivcIhNFHq5RgDfjIdzOKQhfiKXbZ2yB7U=;
        b=OC10ic80JL0m5yCXvHHSkg4hFEiWtK5xleeJeNWFNThMk62ws8LjMeS8HIK81DIr60
         bxwV/I40fAWrjxtT3jhqTb+wQ5JAYf0zvKlL1Kj28UVSagOip6+iyjYeOOG01MithZJC
         0NXe0BCTU4J6/rGMEA/mnXKEu/d7EojRG2HGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TozltjYGe2ivcIhNFHq5RgDfjIdzOKQhfiKXbZ2yB7U=;
        b=LpeHdoZ0RyyvU7atWvoU5drVWxmlA1gx73Ik90czDKSVlzbREyUzPWeJV5hKVuKffY
         mana/sAf1XwEsPkgbpoCq3fxa/eHtVvYTOokH4NXuaa6Xodo0T6MFOZwnmI9Zhp2pL8U
         gSbw0YdZBq+3Y8iwZm47T+mBKDN+t67bJkb/Hhilz/z8iX58MdXukcO0GSwVxeh/gQpP
         dlV97h2AKeN9QX2kNvixAMuRfUv1okWGrGhDetUrR6aueM6N8RtR/ajjbNat3dzm+XwO
         JEd+tTT3+3LfBj0AvmaGAuceEPKbGhlWGLFMBQM1SAB3hqqL4GPtUlHAwlrVe49RsaO6
         GxYg==
X-Gm-Message-State: AOAM5334Wxn7VegbZRWaclm9SWaPoi9YW6dqxYF7antzo6EB1NP8O5Rt
	KLkWnReAwTdodF8RRFgsMipMRSYHhLrLsw==
X-Google-Smtp-Source: 
 ABdhPJzKlOqhjxLp+N/bcQdm5JSBNd8YdC5c0zUzxOVF3+9Jl8waqV2d1SuEbM6qybjrevES88AOUg==
X-Received: by 2002:a5d:64ce:0:b0:20a:e769:d282 with SMTP id
 f14-20020a5d64ce000000b0020ae769d282mr10499209wri.655.1651155336247;
        Thu, 28 Apr 2022 07:15:36 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e3fc:fa86:a530:4b66])
        by smtp.gmail.com with ESMTPSA id
 f10-20020adfc98a000000b0020acee46c88sm4260wrh.21.2022.04.28.07.15.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:15:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Fix sig file location when using multiconfig
Date: Thu, 28 Apr 2022 15:15:35 +0100
Message-Id: <20220428141535.2876849-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Apr 2022 14:15:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13664

We're using the wrong data store when trying to locate siginfo files,
fix this. Thanks to Gregory Lumen <gregorylumen@microsoft.com> for
spotting.

[YOCTO #14774]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a4e82f375c..f34f1568e2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1674,7 +1674,7 @@ class RunQueue:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
             pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
             h = self.rqdata.runtaskentries[tid].hash
-            matches = bb.siggen.find_siginfo(pn, taskname, [], self.cfgData)
+            matches = bb.siggen.find_siginfo(pn, taskname, [], self.cooker.databuilder.mcdata[mc])
             match = None
             for m in matches:
                 if h in m:
-- 
2.32.0


