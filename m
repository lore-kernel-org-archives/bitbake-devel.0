Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13027C27C4F
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:47 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.36154.1717244861963294790
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=G8mBULPH;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.173, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-702548b056aso547584b3a.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244861; x=1717849661; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRuJsD8VW+HVILuMIQ834MAEvuQQvTJju5ut59L8ymg=;
        b=G8mBULPHLi/qrtRn/Px1GMTutRP/vRBCktqC06oA83kwoKvrnuTEvF2TSEp/WFGS+R
         ExXa8Tk1568naRBVqgMye2oO4pYteB2l4QvkOuR5WT78ggaHnUslF9Tdsh5pHbw48FLR
         vlRZPRcUXf+NJpW3vwNSFeL4TmFOgckwvzTXF1AzQT6rHVgP2n9scXfjWrTU+BdfV2sG
         pQpY2SzELFHlIK/6toW1noo5ejeMpz+Z1LR0jiefi3TxEa9x3rWQfVOuKtV5aUT71Pj7
         KHvInwEHvL1zEYPCr1QTC6TWf3rRVRXUDTlbmbtuZeNPvsFbhZ8rVPm+M8HSA9rdmLO5
         +P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244861; x=1717849661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRuJsD8VW+HVILuMIQ834MAEvuQQvTJju5ut59L8ymg=;
        b=ISTGOBxPmKHqzw4Lr3lpSxJsWZhu/M5n8CUluk4dqLn4yhDtJ9gGBTAzAAapQNYCOz
         bq0JiZ2HNzER77ltEyPx3cvfuY5xG7OY16A34S/NaOj4eib1T8eDQbFNZywTidDPn9Oe
         psHu1oq3YABj0IB87w0PvP+I+bKOHj/4aQBHMM5CV3+iOIz2TlBF8MAoxDBh8dCJ+z7Y
         eQOEIHNJk8dj5aR29mEhtr4PAUbaYPczKCpLeF0rY018JG7ybv+lpqA6rVtgjKWEizdz
         ElETTL2UDIX9lnG2moJ9OAzfi2Ka40H0j+pzXOX7CwDQrO4aaCpTzw/+MEAgrkR2IyHA
         5Yaw==
X-Gm-Message-State: AOJu0Yxqbxz3NAaBmyru7EiLybppLT31k8j6vnOzycE0rRpcy2Hn5RRg
	7Fzby7rlHpwlfm6lS2h99Y6P5GICLhIdgBpKbCV37j4lnCQ9df3cc/VwNQYkJG0N/N8+PaAJEzG
	U
X-Google-Smtp-Source: AGHT+IFq30s0C2ecMhfwb9DawdoSzqr38WhqQig7PJ6Smf4qIOE7nDpzpScIhu7RDudcspjv111n0A==
X-Received: by 2002:a05:6a20:96ca:b0:1b1:f6a9:6b0a with SMTP id adf61e73a8af0-1b26f275a5fmr3959907637.47.1717244860835;
        Sat, 01 Jun 2024 05:27:40 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:40 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 8/8] siggen: Enable batching of unihash queries
Date: Sat,  1 Jun 2024 05:27:23 -0700
Message-Id: <df2c0ae146b5d9f82b15ab2eac988fe919175600.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16312

From: Joshua Watt <JPEWhacker@gmail.com>

Uses the batching API of the client to reduce the effect of latency when
making multiple queries to the server

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 03dfda6f3..65ca0811d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -726,10 +726,13 @@ class SignatureGeneratorUniHashMixIn(object):
             return result
 
         if self.max_parallel <= 1 or len(queries) <= 1:
-            # No parallelism required. Make the query serially with the single client
+            # No parallelism required. Make the query using a single client
             with self.client() as client:
-                for tid, args in queries.items():
-                    query_result[tid] = client.get_unihash(*args)
+                keys = list(queries.keys())
+                unihashes = client.get_unihash_batch(queries[k] for k in keys)
+
+                for idx, k in enumerate(keys):
+                    query_result[k] = unihashes[idx]
         else:
             with self.client_pool() as client_pool:
                 query_result = client_pool.get_unihashes(queries)
-- 
2.34.1


