Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499AECDB47E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:15 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web10.25774.1697149027710408432
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KmuOJkmD;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e9ac336589so870123fac.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149026; x=1697753826; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=KmuOJkmDq/yoX1RuT1vaDF45MfBiqmcayvOhKlttedK2lYdTkMplPl8ijeNcgdxs0Q
         oPTkZJ703zK1s/GHe/CRQ0OENGoRYnhyepFUc1tG38GZXg6joWtPaN0qRhMkttEE62fk
         RC2Fm+OOZAb0/gWs4AO02jRQRehuT9xTnUcMKOiKRS99nP8oWflNDhw09C/AtO2WUKfL
         Osi4AadOzhjscHiv9XR7f66DO86Dy/i8kx+jqpxACRaZKClAXEDPjbpm/rHHTwixjlVk
         PIwcqxIDQy/ZZ3v0pYVhl8kVLQ2Dnm536LPVoIMWmeMzEQ8SO9dQqHH8tg/r8uhzsVxm
         +kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149026; x=1697753826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=mnSN0Q8QUiRg3r+EiY3Jls62nHpCBodCVongVEatdAdJt16gCzhvhjHpBTOsYXS5j7
         infgqplSS5yofbl5T2wTFza1X/d47PW/a+YGlfuuLgp6dCSElwVNIS0pQTMzGyGGkM3i
         S/lLgb7Oj5Kw56OMSHxYLYCSl5BtlwzMWh15PTdO6MxN4I67q2UN3CKvLVtmkWaTQQa9
         vlS9H1TMKTkSZRg/rtlVI9X2Ga/yi+y4/HbK5Rc31MG6Kz3fImr64nkgNqZMZQDW/0J5
         gtMuQNItqmIjvtYrVFpT5+fJdF8qzsg1Xxj16iyBY+UKijmUOsXBzNWSgMJXkm5Caj8m
         7e9A==
X-Gm-Message-State: AOJu0YwxohbdnZedejsElljgD6KJA8QgEddNCz3ELBf3bvp7yKkghy8i
	Al0BnkPtJbWol1BwQyCvvb6VJP3wd1I=
X-Google-Smtp-Source: AGHT+IG1Xtt5CzUL5F/Bqqf5xOgPMy/QJl85pNMMPq5z3Q2X87/v5qNPi35U2ZWhrjEmvvuT4NBW9Q==
X-Received: by 2002:a05:6871:8a4:b0:1e9:8885:b534 with SMTP id r36-20020a05687108a400b001e98885b534mr8411864oaq.9.1697149026261;
        Thu, 12 Oct 2023 15:17:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:05 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 03/18] asyncrpc: Add context manager API
Date: Thu, 12 Oct 2023 16:16:40 -0600
Message-Id: <20231012221655.632637-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15221

Adds context manager API for the asyncrcp client class which allow
writing code that will automatically close the connection like so:

    with hashserv.create_client(address) as client:
       ...

Rework the bitbake-hashclient tool and PR server to use this new API to
fix warnings about unclosed event loops when exiting

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient    | 36 +++++++++++++++++-------------------
 lib/bb/asyncrpc/client.py | 13 +++++++++++++
 lib/prserv/serv.py        |  6 +++---
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 3f265e8f..a02a65b9 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -56,25 +56,24 @@ def main():
             nonlocal missed_hashes
             nonlocal max_time
 
-            client = hashserv.create_client(args.address)
-
-            for i in range(args.requests):
-                taskhash = hashlib.sha256()
-                taskhash.update(args.taskhash_seed.encode('utf-8'))
-                taskhash.update(str(i).encode('utf-8'))
+            with hashserv.create_client(args.address) as client:
+                for i in range(args.requests):
+                    taskhash = hashlib.sha256()
+                    taskhash.update(args.taskhash_seed.encode('utf-8'))
+                    taskhash.update(str(i).encode('utf-8'))
 
-                start_time = time.perf_counter()
-                l = client.get_unihash(METHOD, taskhash.hexdigest())
-                elapsed = time.perf_counter() - start_time
+                    start_time = time.perf_counter()
+                    l = client.get_unihash(METHOD, taskhash.hexdigest())
+                    elapsed = time.perf_counter() - start_time
 
-                with lock:
-                    if l:
-                        found_hashes += 1
-                    else:
-                        missed_hashes += 1
+                    with lock:
+                        if l:
+                            found_hashes += 1
+                        else:
+                            missed_hashes += 1
 
-                    max_time = max(elapsed, max_time)
-                    pbar.update()
+                        max_time = max(elapsed, max_time)
+                        pbar.update()
 
         max_time = 0
         found_hashes = 0
@@ -174,9 +173,8 @@ def main():
 
     func = getattr(args, 'func', None)
     if func:
-        client = hashserv.create_client(args.address)
-
-        return func(args, client)
+        with hashserv.create_client(args.address) as client:
+            return func(args, client)
 
     return 0
 
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 802c07df..009085c3 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -103,6 +103,12 @@ class AsyncClient(object):
     async def ping(self):
         return await self.invoke({"ping": {}})
 
+    async def __aenter__(self):
+        return self
+
+    async def __aexit__(self, exc_type, exc_value, traceback):
+        await self.close()
+
 
 class Client(object):
     def __init__(self):
@@ -153,3 +159,10 @@ class Client(object):
         if sys.version_info >= (3, 6):
             self.loop.run_until_complete(self.loop.shutdown_asyncgens())
         self.loop.close()
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        self.close()
+        return False
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index ea793316..6168eb18 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -345,9 +345,9 @@ def auto_shutdown():
 def ping(host, port):
     from . import client
 
-    conn = client.PRClient()
-    conn.connect_tcp(host, port)
-    return conn.ping()
+    with client.PRClient() as conn:
+        conn.connect_tcp(host, port)
+        return conn.ping()
 
 def connect(host, port):
     from . import client
-- 
2.34.1


