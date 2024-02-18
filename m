Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD61C48BC4
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:25 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web10.29052.1708297217529528527
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SLghGPY9;
 spf=pass (domain: gmail.com, ip: 209.85.166.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c72294e3d1so131437439f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297216; x=1708902016; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHn2D0/VtGPjS10/2+oeAuTdZ83vrklXRpiSkiY31og=;
        b=SLghGPY9KZT+7EOOEBJZ5S1PkLRWyETbB/tF+zaJ5ruav6SZds1YsB2V1XoXKcIXfd
         FnM14MYUoc9uQkOhQULcnI9MNHcuxZyhT5uPQVCJ0DCHhG8f1DVKyrrVZPXdV0tKHHm2
         MR7m9yrlEoJpBLEvQb5jerbmjTXpIoQSRGJSqDWD8QYMZ8cNPydTC6j8FHGtmNyERtnf
         zjgosLj7RMmkkAa9UPQjz78ofbK2At6wN58WK8xjgMdrMfTlOQTM5tZlcRIy+SEBrSZn
         hQMXDRra/BSQfFTZCC14L6raReZv5b/Yv5d/Hv3Y2cf6tbAE9oPnJi80OhRjZh5Xy8M+
         5uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297216; x=1708902016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHn2D0/VtGPjS10/2+oeAuTdZ83vrklXRpiSkiY31og=;
        b=qYZhZWCMSptPR68FXzS4sRgDWZGayv5kPGHVAoEbdOEHc2yxpAmwBbhkmrtNus6kfj
         4jedlTA6Q/QEDU7EHTjlR9C+MxKOjzfnYumx+FgNKV7MVat3JMBCfL04GUEgKFO9RHv7
         iiJJLODzUpzQxLzSjDr65n4bsxKyx9DBuM+eRJntohe+VD7n4LA7je90mdWBbMdsxmi3
         LtXFopJmJ0dFKMuvpEzYNUqK+gg7mQadogyFDZ2kpx0Uw7hBz0qhK5VjukwlAs8Tlrkp
         Y6wppp+oo7UJIhgWzltRM6FyJWeB5BMoGiLJ+lL3N59TcpaObmmWYOnmHsLEKzLTATDF
         pSkQ==
X-Gm-Message-State: AOJu0Yy07Xmw2p+14GRTSr9Nlz+fSgOVg66hHfL3TPN1lHo0xC+g+3sb
	22NVB1KuN4fRMUJbtY69b//PVcXzFo9Aid3sUwLGkeKD3q1176m2us0SLvBA
X-Google-Smtp-Source: AGHT+IEBqyQn6rhU7G0XlUu0e/tZdmIF9nNiiIPxlg9mtznpPw5qSaFjmvbekSKPcPXEeWCFNCG/lA==
X-Received: by 2002:a5e:9901:0:b0:7c4:7a26:60fd with SMTP id t1-20020a5e9901000000b007c47a2660fdmr12278027ioj.16.1708297215746;
        Sun, 18 Feb 2024 15:00:15 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:14 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 7/8] siggen: Add parallel unihash exist API
Date: Sun, 18 Feb 2024 15:59:52 -0700
Message-Id: <20240218225953.2997239-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218225953.2997239-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
 <20240218225953.2997239-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:00:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15929

Adds API to query if unihashes are known to the server in parallel

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index e1a4fa2cdd1..3ab8431a089 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -530,6 +530,11 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
 class SignatureGeneratorUniHashMixIn(object):
     def __init__(self, data):
         self.extramethod = {}
+        # NOTE: The cache only tracks hashes that exist. Hashes that don't
+        # exist are always queries from the server since it is possible for
+        # hashes to appear over time, but much less likely for them to
+        # disappear
+        self.unihash_exists_cache = set()
         super().__init__(data)
 
     def get_taskdata(self):
@@ -620,6 +625,33 @@ class SignatureGeneratorUniHashMixIn(object):
 
         return method
 
+    def unihashes_exist(self, query):
+        if len(query) == 0:
+            return {}
+
+        uncached_query = {}
+        result = {}
+        for key, unihash in query.items():
+            if unihash in self.unihash_exists_cache:
+                result[key] = True
+            else:
+                uncached_query[key] = unihash
+
+        if self.max_parallel <= 1 or len(uncached_query) <= 1:
+            # No parallelism required. Make the query serially with the single client
+            uncached_result = {
+                key: self.client().unihash_exists(value) for key, value in uncached_query.items()
+            }
+        else:
+            uncached_result = self.client_pool().unihashes_exist(uncached_query)
+
+        for key, exists in uncached_result.items():
+            if exists:
+                self.unihash_exists_cache.add(query[key])
+            result[key] = exists
+
+        return result
+
     def get_unihash(self, tid):
         return self.get_unihashes([tid])[tid]
 
-- 
2.34.1


