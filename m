Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4925C433F5
	for <webhook@archiver.kernel.org>; Wed, 23 Feb 2022 18:08:41 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web08.11323.1645639720996643116
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Feb 2022 10:08:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d1xxd7r9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id d17so6134411wrc.9
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Feb 2022 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IB51UhuMKjeu1gdp7LXm9Q359XSqyCE95V7gJsc2ck=;
        b=d1xxd7r9nzVSOF00HTfa6JQH17ous6h3Z2jQnEskl/bjVlEfmd9BfsMN4LsEeAVqBB
         b8MUMZd4DmRP59DzpZvdyQWjAvy/8/s3XiKlaxqIBqb1NybHTRSwnioFZUw8QRK8Mbs/
         n0sfJsjjxhQI+p+QM+M5+iqTiC8kHlbDJ4YSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IB51UhuMKjeu1gdp7LXm9Q359XSqyCE95V7gJsc2ck=;
        b=sa2ffp+UipqPjMWLpv7Mo12jA4kwzEuesEt1UVaGJqzoLSHYo+xavjYbAlSBnu5Uq3
         cWcTHEAVvsy0VYAdSnXmw5zglytOnpOMfVhTV8xQPk/rtALf1A13BVufYRxQvShS2w5B
         2n/7o2czFVCNlbNfZMw480FWHYnaBPCj0+TQZnC4DzOu91gK7NIGTwBkAQ77GuURkXJT
         i/0+AzxG1qVB6jQJMuNRxt3PZX7EVYG2xYHRP7SM4PtT+eg5EDJllUUgNd6B1k1x4OFM
         d0qoKg+yIFdTQO87VTTCJ6xd95pSgiARCFW8B6PxtNKpkOPTgP1X+u2kGY4CszE61rbe
         d8tw==
X-Gm-Message-State: AOAM530K8TxSyPuFAhcQDmXQpdipVyaeSWhfMwaWDstqD6s7LjtElcbu
	O+W8gSYqD0IdWqsPf7xIuWsAeYulFBC5HMZB
X-Google-Smtp-Source: 
 ABdhPJxqXYGCSqAedDAr2EopauXfHFj1k2LubIUVQMwccw2z39RcvLYxodyB4aX/LFO7jWpwpUaKbQ==
X-Received: by 2002:adf:9103:0:b0:1e5:8cc9:5aa1 with SMTP id
 j3-20020adf9103000000b001e58cc95aa1mr589195wrj.17.1645639719071;
        Wed, 23 Feb 2022 10:08:39 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4709:85d1:7b5:8346])
        by smtp.gmail.com with ESMTPSA id
 m13-20020a05600c3b0d00b0037c00e01771sm458827wms.34.2022.02.23.10.08.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:08:38 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Update for master -> main change upstream
Date: Wed, 23 Feb 2022 18:08:37 +0000
Message-Id: <20220223180837.3277253-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Feb 2022 18:08:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13400

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index f0d417a50d..eff12b7c50 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1110,7 +1110,7 @@ class FetcherNetworkTest(FetcherTest):
         """ Prevent regression on deeply nested submodules not being checked out properly, even though they were fetched. """
 
         # This repository also has submodules where the module (name), path and url do not align
-        url = "gitsm://github.com/azure/iotedge.git;protocol=https;rev=d76e0316c6f324345d77c48a83ce836d09392699;branch=master"
+        url = "gitsm://github.com/azure/iotedge.git;protocol=https;rev=d76e0316c6f324345d77c48a83ce836d09392699;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
-- 
2.32.0


