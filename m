Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6810BC41513
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 15:41:37 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.web10.13086.1717083695713565671
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 08:41:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ceiosMOa;
 spf=pass (domain: gmail.com, ip: 209.85.161.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b2d065559cso446987eaf.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717083694; x=1717688494; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WsJOBQXRdmDN5AQEbaM+NDrwk7AMcOzT3uFdplwXzjM=;
        b=ceiosMOaT5gKAMZjCkf7DGabFGyMvzzao1wtNs0q2lI7CZOu+sqODtsbiHzgqlfs71
         Kac9sJTCuGYL8Y/1DoJdjSYkGfwKTaZifUBbZ9RnLfqXhChh2pSk15szc7cSm6R2OJiB
         Asv4EolK5wHRG+IHCCsPbl3SRyBGibuKeqlizIyut+wP8bvIvp0Tn1uRwRjBBnkHiCK5
         47do2A6qz7AxEug+jlrxIx/IA8eDla2ugWPy3ZjSG3IUQx25w3YTQDQlzDZpsgZTUok0
         5zk7HIztwzyJBx+aKrH6t6/0nBZOulXJ8oKr1q/FRVMFpXc42sqWlRp0ltg17kaygtGJ
         tFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083694; x=1717688494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsJOBQXRdmDN5AQEbaM+NDrwk7AMcOzT3uFdplwXzjM=;
        b=DEqZPm5WprBm8ur2rbsvR2Jfq8IEcZPjGuXXb2PN5+tBdcxSo/BhYH16/LqS/zhTSg
         JpZom9cfCPSZ8oJDAJgiUlWJeaJPP/o+nDLLvAxG5+so2jidbmMJH6e+6u2VLqV8GSoi
         EffLYL5+Wt/r1vS2Az9BtH1JB1ocI6s+Aecx/ykqQADcj1CJyCpQDCgW8tsx9hnHHy5H
         1JsdWjOUvvoCTqM7/Jwn0/gP0Gwi/JXkQQ6TzzMJnFBJynvZ06Tro0kn/BpIeEgiHnSy
         L/cEftEe3MDonxu4hlu4EocZrw86mzKe9UKM/2d8+aEkGqKafH7ybLgff6B5D4oyD8+e
         VxAA==
X-Gm-Message-State: AOJu0YyGlk2HHnDjqUU5pK3jtmKUg6byQYchdEj2KlWJokXHJPQUuHcG
	Ew/QdUk1IcwBJ+gJxjyS0LWdwv+XL/Iy/i7ipnNZEl5Rct2AJAoiXo1fbA==
X-Google-Smtp-Source: AGHT+IHCOvP8BKijKFp68sLP+FxT8ohqiHGzldRHdPyzhlhKGHW6TgBhEWFh0Esxd5L34fwJk4NI0A==
X-Received: by 2002:a05:6820:1b90:b0:5b2:565b:b6de with SMTP id 006d021491bc7-5b9ec5bcee2mr2862539eaf.3.1717083693830;
        Thu, 30 May 2024 08:41:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::125b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c6d60f1sm3184813eaf.45.2024.05.30.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:41:33 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/3] siggen: Drop client pool support
Date: Thu, 30 May 2024 09:41:25 -0600
Message-ID: <20240530154127.792582-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 15:41:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16289

Drops support for client pools, since batching support in the client
code has proven to be much more effective

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 53 ++++++++++++----------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 65ca0811d58..79f347db303 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -540,7 +540,7 @@ class SignatureGeneratorUniHashMixIn(object):
     def __init__(self, data):
         self.extramethod = {}
         # NOTE: The cache only tracks hashes that exist. Hashes that don't
-        # exist are always queries from the server since it is possible for
+        # exist are always queried from the server since it is possible for
         # hashes to appear over time, but much less likely for them to
         # disappear
         self.unihash_exists_cache = set()
@@ -558,11 +558,11 @@ class SignatureGeneratorUniHashMixIn(object):
         super().__init__(data)
 
     def get_taskdata(self):
-        return (self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password, self.env) + super().get_taskdata()
+        return (self.server, self.method, self.extramethod, self.username, self.password, self.env) + super().get_taskdata()
 
     def set_taskdata(self, data):
-        self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password, self.env = data[:7]
-        super().set_taskdata(data[7:])
+        self.server, self.method, self.extramethod, self.username, self.password, self.env = data[:6]
+        super().set_taskdata(data[6:])
 
     def get_hashserv_creds(self):
         if self.username and self.password:
@@ -595,13 +595,6 @@ class SignatureGeneratorUniHashMixIn(object):
                 self._client = hashserv.create_client(self.server, **self.get_hashserv_creds())
             yield self._client
 
-    @contextmanager
-    def client_pool(self):
-        with self._client_env():
-            if getattr(self, '_client_pool', None) is None:
-                self._client_pool = hashserv.client.ClientPool(self.server, self.max_parallel, **self.get_hashserv_creds())
-            yield self._client_pool
-
     def reset(self, data):
         self.__close_clients()
         return super().reset(data)
@@ -686,15 +679,10 @@ class SignatureGeneratorUniHashMixIn(object):
             else:
                 uncached_query[key] = unihash
 
-        if self.max_parallel <= 1 or len(uncached_query) <= 1:
-            # No parallelism required. Make the query serially with the single client
-            with self.client() as client:
-                uncached_result = {
-                    key: client.unihash_exists(value) for key, value in uncached_query.items()
-                }
-        else:
-            with self.client_pool() as client_pool:
-                uncached_result = client_pool.unihashes_exist(uncached_query)
+        with self.client() as client:
+            uncached_result = {
+                key: client.unihash_exists(value) for key, value in uncached_query.items()
+            }
 
         for key, exists in uncached_result.items():
             if exists:
@@ -712,32 +700,20 @@ class SignatureGeneratorUniHashMixIn(object):
         unihash
         """
         result = {}
-        queries = {}
-        query_result = {}
+        query_tids = []
 
         for tid in tids:
             unihash = self.get_cached_unihash(tid)
             if unihash:
                 result[tid] = unihash
             else:
-                queries[tid] = (self._get_method(tid), self.taskhash[tid])
-
-        if len(queries) == 0:
-            return result
+                query_tids.append(tid)
 
-        if self.max_parallel <= 1 or len(queries) <= 1:
-            # No parallelism required. Make the query using a single client
+        if query_tids:
             with self.client() as client:
-                keys = list(queries.keys())
-                unihashes = client.get_unihash_batch(queries[k] for k in keys)
+                unihashes = client.get_unihash_batch((self._get_method(tid), self.taskhash[tid]) for tid in query_tids)
 
-                for idx, k in enumerate(keys):
-                    query_result[k] = unihashes[idx]
-        else:
-            with self.client_pool() as client_pool:
-                query_result = client_pool.get_unihashes(queries)
-
-        for tid, unihash in query_result.items():
+        for idx, tid in enumerate(query_tids):
             # In the absence of being able to discover a unique hash from the
             # server, make it be equivalent to the taskhash. The unique "hash" only
             # really needs to be a unique string (not even necessarily a hash), but
@@ -752,6 +728,8 @@ class SignatureGeneratorUniHashMixIn(object):
             #    to the server, there is a better chance that they will agree on
             #    the unique hash.
             taskhash = self.taskhash[tid]
+            unihash = unihashes[idx]
+
             if unihash:
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
@@ -898,7 +876,6 @@ class SignatureGeneratorTestEquivHash(SignatureGeneratorUniHashMixIn, SignatureG
         super().init_rundepcheck(data)
         self.server = data.getVar('BB_HASHSERVE')
         self.method = "sstate_output_hash"
-        self.max_parallel = 1
 
 def clean_checksum_file_path(file_checksum_tuple):
     f, cs = file_checksum_tuple
-- 
2.43.2


