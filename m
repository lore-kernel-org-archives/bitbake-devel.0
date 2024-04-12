Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A4C4345F
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 15:57:24 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
 by mx.groups.io with SMTP id smtpd.web10.50869.1712937436928262999
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 08:57:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eroB8s9S;
 spf=pass (domain: gmail.com, ip: 209.85.166.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c8dd755793so28142139f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712937435; x=1713542235; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLi73jOkg2JrMVnywoWXrUDFNNEjMtluiPEr0to8ESs=;
        b=eroB8s9SIPli089O1fr+mh8xO5juUjWVaYPLsW63En1heKZUcI6RRlkBd/pHRYdXPA
         Em299O1aAGJWFG3VsFsVGUQYq0FFDrO7a6zMctqDGqm/KdFfcuUYFl7Qi/6wgonn76IF
         3CV0BINO5N/Bx/IxuAuRwKczk/5bXNR6n89YIQ815b/QUnVpyTl5EGe+sEM2QHE4Leva
         6T6XQh5Q1WdUN6Epdho66SajwIqQHaRL7m2mtydH/t7uUnAQQpM9gNyRgNk/Dz5Jp7+1
         uLa8wvxJPsKMsqQYXIbslCGyH4fTg8S0zEqqK1UwAQaRBCUnIoqcGXnnCSyOzj/AUicG
         bqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712937435; x=1713542235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLi73jOkg2JrMVnywoWXrUDFNNEjMtluiPEr0to8ESs=;
        b=ZPwoyGSFcz0NxwYaER3CeiOgItfEMs9WMp8uC8ZkUtuzWL0a3ba28UZ6t8ZYlodtuy
         bTL2aM1CosO8QMIqrJTh3dJdSNOm54UxD8Oi3nDHuzc+FS3kj7AJmALWdehLBY/5qIJT
         HEvdtiFTKqvHwFKdS1cj8Ih3M1bRAMLg7g+CfRco0mGM6YlkpH2PB+8qEm3bvAKQbfNT
         HkYwlmn9K5b4pAam0iMjlCuHpHCVfDh8wh7GBZ8TzALBvSH7Mq1nmTofyzSSHJoR8/xn
         iGe9do+gvIFlS+ZRlr3WYm7zTTKTXF98ZRqxq1vlMYFqaUXjxC9GIuOmSdGQB3cwlcT7
         paGQ==
X-Gm-Message-State: AOJu0YyFLU8xQhTlr2oNVuLqk1RG3xB4e8Vg9USIE3PvDv5bN4Cy6juK
	lwFATYBTBeRYcAyCnhaWiZNOjt8BCtJgHk6+4uc4DcrCA0Ry0uM4W6lwhQ==
X-Google-Smtp-Source: AGHT+IH8sMt2zyHa1CciPyMd1HVoeVmNuXa7efdLxjCYxxUGB3QAuQMAkRQDUXDVWR0M26eBYhW+HA==
X-Received: by 2002:a05:6602:3e88:b0:7d5:df5e:506 with SMTP id el8-20020a0566023e8800b007d5df5e0506mr4422749iob.9.1712937435526;
        Fri, 12 Apr 2024 08:57:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::78ab])
        by smtp.gmail.com with ESMTPSA id cb6-20020a0566381b0600b0048275128dbfsm1096630jab.96.2024.04.12.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:57:14 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] siggen: Capture SSL environment for hashserver
Date: Fri, 12 Apr 2024 09:57:09 -0600
Message-Id: <20240412155709.1930523-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 15:57:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16089

Now that the bitbake hash server supports SSL connections, we need to
capture a few environment variables which can affect the ability to
connect via SSL. Note that the variables are only put in place to affect
the environment while actually invoking the server

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 77 +++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 2a0ecf57e16..52b84c0e5ed 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -15,6 +15,7 @@ import difflib
 import simplediff
 import json
 import types
+from contextlib import contextmanager
 import bb.compress.zstd
 from bb.checksum import FileChecksumCache
 from bb import runqueue
@@ -537,14 +538,18 @@ class SignatureGeneratorUniHashMixIn(object):
         self.unihash_exists_cache = set()
         self.username = None
         self.password = None
+        self.env = {}
+        for e in ("SSL_CERT_DIR", "SSL_CERT_FILE", "NO_PROXY", "HTTPS_PROXY", "HTTP_PROXY"):
+            if e in os.environ:
+                self.env[e] = os.environ[e]
         super().__init__(data)
 
     def get_taskdata(self):
-        return (self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password) + super().get_taskdata()
+        return (self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password, self.env) + super().get_taskdata()
 
     def set_taskdata(self, data):
-        self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password = data[:6]
-        super().set_taskdata(data[6:])
+        self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password, self.env = data[:7]
+        super().set_taskdata(data[7:])
 
     def get_hashserv_creds(self):
         if self.username and self.password:
@@ -555,15 +560,30 @@ class SignatureGeneratorUniHashMixIn(object):
 
         return {}
 
+    @contextmanager
+    def _client_env(self):
+        orig_env = os.environ.copy()
+        try:
+            for k, v in self.env.items():
+                os.environ[k] = v
+
+            yield
+        finally:
+            os.environ = orig_env
+
+    @contextmanager
     def client(self):
-        if getattr(self, '_client', None) is None:
-            self._client = hashserv.create_client(self.server, **self.get_hashserv_creds())
-        return self._client
+        with self._client_env():
+            if getattr(self, '_client', None) is None:
+                self._client = hashserv.create_client(self.server, **self.get_hashserv_creds())
+            yield self._client
 
+    @contextmanager
     def client_pool(self):
-        if getattr(self, '_client_pool', None) is None:
-            self._client_pool = hashserv.client.ClientPool(self.server, self.max_parallel, **self.get_hashserv_creds())
-        return self._client_pool
+        with self._client_env():
+            if getattr(self, '_client_pool', None) is None:
+                self._client_pool = hashserv.client.ClientPool(self.server, self.max_parallel, **self.get_hashserv_creds())
+            yield self._client_pool
 
     def reset(self, data):
         self.__close_clients()
@@ -574,12 +594,13 @@ class SignatureGeneratorUniHashMixIn(object):
         return super().exit()
 
     def __close_clients(self):
-        if getattr(self, '_client', None) is not None:
-            self._client.close()
-            self._client = None
-        if getattr(self, '_client_pool', None) is not None:
-            self._client_pool.close()
-            self._client_pool = None
+        with self._client_env():
+            if getattr(self, '_client', None) is not None:
+                self._client.close()
+                self._client = None
+            if getattr(self, '_client_pool', None) is not None:
+                self._client_pool.close()
+                self._client_pool = None
 
     def get_stampfile_hash(self, tid):
         if tid in self.taskhash:
@@ -650,11 +671,13 @@ class SignatureGeneratorUniHashMixIn(object):
 
         if self.max_parallel <= 1 or len(uncached_query) <= 1:
             # No parallelism required. Make the query serially with the single client
-            uncached_result = {
-                key: self.client().unihash_exists(value) for key, value in uncached_query.items()
-            }
+            with self.client() as client:
+                uncached_result = {
+                    key: client.unihash_exists(value) for key, value in uncached_query.items()
+                }
         else:
-            uncached_result = self.client_pool().unihashes_exist(uncached_query)
+            with self.client_pool() as client_pool:
+                uncached_result = client_pool.unihashes_exist(uncached_query)
 
         for key, exists in uncached_result.items():
             if exists:
@@ -687,10 +710,12 @@ class SignatureGeneratorUniHashMixIn(object):
 
         if self.max_parallel <= 1 or len(queries) <= 1:
             # No parallelism required. Make the query serially with the single client
-            for tid, args in queries.items():
-                query_result[tid] = self.client().get_unihash(*args)
+            with self.client() as client:
+                for tid, args in queries.items():
+                    query_result[tid] = client.get_unihash(*args)
         else:
-            query_result = self.client_pool().get_unihashes(queries)
+            with self.client_pool() as client_pool:
+                query_result = client_pool.get_unihashes(queries)
 
         for tid, unihash in query_result.items():
             # In the absence of being able to discover a unique hash from the
@@ -785,7 +810,9 @@ class SignatureGeneratorUniHashMixIn(object):
                 if tid in self.extramethod:
                     method = method + self.extramethod[tid]
 
-                data = self.client().report_unihash(taskhash, method, outhash, unihash, extra_data)
+                with self.client() as client:
+                    data = client.report_unihash(taskhash, method, outhash, unihash, extra_data)
+
                 new_unihash = data['unihash']
 
                 if new_unihash != unihash:
@@ -816,7 +843,9 @@ class SignatureGeneratorUniHashMixIn(object):
             if tid in self.extramethod:
                 method = method + self.extramethod[tid]
 
-            data = self.client().report_unihash_equiv(taskhash, method, wanted_unihash, extra_data)
+            with self.client() as client:
+                data = client.report_unihash_equiv(taskhash, method, wanted_unihash, extra_data)
+
             hashequiv_logger.verbose('Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
 
             if data is None:
-- 
2.34.1


