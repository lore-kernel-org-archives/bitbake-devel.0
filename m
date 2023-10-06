Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF5DE81E0D
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 15:37:02 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web10.16164.1696606614498358669
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Oct 2023 08:36:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YFTsvDMa;
 spf=pass (domain: gmail.com, ip: 209.85.160.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1dd4eed487dso1414643fac.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696606613; x=1697211413; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqOKYLqDivxAAK9NCZFkN/LEiY4n1fpj5xSxK4ODOXc=;
        b=YFTsvDMaWSYDDxgwRn/dmfNY/2x+7ezjHlTiRYlhVfVdv7yyzXhIRtcreq7Xa2kyAz
         P0l9KEhoZT/6iH//uqW6o5gGcrECzGHxoCW5aXvieDIyZaTkKmjZncaLD9UHTdpbvcGM
         KfnpQFN5BGSn4gnBmyPo/jcyG5q9MrzHaD29rMJXMFfRAhtW7DKaYZg0fSzhha5qxXfG
         ibqdtmcVgMVKxxIX0pQjrJ6uAw+EazdSh7DbNntM99iDbCtT8pfBMrmWN4Euh3Uwb2TO
         4zi0AtMHHDemtDiZUVDsv68xREb+lWXtqDVHLV1xUfZzUHipUfyVZLmimiqCgV2mSN1k
         lsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606613; x=1697211413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqOKYLqDivxAAK9NCZFkN/LEiY4n1fpj5xSxK4ODOXc=;
        b=G/0qlXnTh5XMn2IOFPqMNvD0HOkHgYkUJ9v9FVLyeYge2fm+BvZ2hL6O4JlifzNIzh
         OpTYZiSmkSbeYe6rqMxnjDhkTQq9csqXhd3Ltk7UWB5uXhcjezvGNFbn9AYKT8l5PJuO
         qPz4COiW0G5tpUwLDni9omulIlV0Q33JYZCAe6kfDbKrK3lHt4XSp7/GGUQFZtwHTcp2
         gNXiT9ZssSfNf0kQEpXRweKzQf9p7n8tLk/Dq2xCUTLn/7syJMT/2ZyIZGy1/3SLzTm9
         x6tacRD93gfqZIAdEGRE4ivqVrRp2MuCqgTpR0MjHW2kJdnV1xU6uaic0CbyYf2TumhA
         OXVA==
X-Gm-Message-State: AOJu0Yy4oXUTlNoTRM5YP+Ws3zLy8KbN7h0xLXH63ZCuoEU8i/pV41Mf
	6vg/uqW94tdkuKOU8VzyqkejXvLsFWQ=
X-Google-Smtp-Source: AGHT+IGAJqlXmifVkWoywHLSGqq7nnmXebxgA2PdtJsAzhCG8cpHchOSDVZXb7XBFuaKXET/rStTtw==
X-Received: by 2002:a05:6870:65aa:b0:1d0:afe4:2155 with SMTP id fp42-20020a05687065aa00b001d0afe42155mr9801496oab.38.1696606613090;
        Fri, 06 Oct 2023 08:36:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b001dd395339c3sm780426oac.19.2023.10.06.08.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:36:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 3/5] hashserv: Extend get_outhash API to optionally include unihash
Date: Fri,  6 Oct 2023 09:36:43 -0600
Message-Id: <20231006153645.1609760-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006153645.1609760-1-JPEWhacker@gmail.com>
References: <20231006153645.1609760-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 15:37:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15190

Extends the get_outhash API with a flag indicating whether to include
the unihash in the output. This is means that the query doesn't require
the unihash entry to be present to return a result

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py |  4 +--
 bitbake/lib/hashserv/server.py | 45 ++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 7446e4c9f67..eeafeabda05 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -83,10 +83,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             {"get": {"taskhash": taskhash, "method": method, "all": all_properties}}
         )
 
-    async def get_outhash(self, method, outhash, taskhash):
+    async def get_outhash(self, method, outhash, taskhash, with_unihash=True):
         await self._set_mode(self.MODE_NORMAL)
         return await self.send_message(
-            {"get-outhash": {"outhash": outhash, "taskhash": taskhash, "method": method}}
+            {"get-outhash": {"outhash": outhash, "taskhash": taskhash, "method": method, "with_unihash": with_unihash}}
         )
 
     async def get_stats(self):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index daf1ffacbb9..d52e1d46df5 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -270,27 +270,42 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         method = request['method']
         outhash = request['outhash']
         taskhash = request['taskhash']
+        with_unihash = request.get("with_unihash", True)
 
         with closing(self.db.cursor()) as cursor:
-            d = await self.get_outhash(cursor, method, outhash, taskhash)
+            d = await self.get_outhash(cursor, method, outhash, taskhash, with_unihash)
 
         self.write_message(d)
 
-    async def get_outhash(self, cursor, method, outhash, taskhash):
+    async def get_outhash(self, cursor, method, outhash, taskhash, with_unihash=True):
         d = None
-        cursor.execute(
-            '''
-            SELECT *, unihashes_v2.unihash AS unihash FROM outhashes_v2
-            INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
-            WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash
-            ORDER BY outhashes_v2.created ASC
-            LIMIT 1
-            ''',
-            {
-                'method': method,
-                'outhash': outhash,
-            }
-        )
+        if with_unihash:
+            cursor.execute(
+                '''
+                SELECT *, unihashes_v2.unihash AS unihash FROM outhashes_v2
+                INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
+                WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash
+                ORDER BY outhashes_v2.created ASC
+                LIMIT 1
+                ''',
+                {
+                    'method': method,
+                    'outhash': outhash,
+                }
+            )
+        else:
+            cursor.execute(
+                """
+                SELECT * FROM outhashes_v2
+                WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash
+                ORDER BY outhashes_v2.created ASC
+                LIMIT 1
+                """,
+                {
+                    'method': method,
+                    'outhash': outhash,
+                }
+            )
         row = cursor.fetchone()
 
         if row is not None:
-- 
2.34.1


