Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C47C4167B
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:17:43 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web11.158480.1698693461703001739
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:17:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BnS3G5Do;
 spf=pass (domain: gmail.com, ip: 209.85.161.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5820299b99cso2936454eaf.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693460; x=1699298260; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=BnS3G5Do2y1DgM4l5Zu37ScUqv4VHRqkESaYIjdQ+8S6xZMmA2HDIzxlzIQr4cBcJS
         m5IcqAFSReR5qqAuqQ42BW9EkmHBwVsNiI3PMu0gqfEGRkz+FQM3oo1eyBhnDuKoD0a3
         dNso15rHNq0TvHPvZXtxIVOFv3y2z5igjRtPb2fVmmQBlrcrhOPgloOfYqx2qjygkZ4a
         1e6Ykt5adjBPxC8jVdmMSU/nt8RWCsHuvEIxxDpGg6NBOBoExWtoewjSj4Xd5tNr5DxF
         Kus8tuE+ncrB5ycS/JREDJB2Cacl63yublq3pw232UlBtO63I/z/wi9pk4yy9t8hh+nY
         nIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693460; x=1699298260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=MBw+ysZ6ITKXPe79UpUGhD1DhzZpclUu0DvODGxKPTWvP8zT8tmxzm4t6qAqtKXx8X
         fXyk9qHEr7c9brOJzr+jqjYnJc86/acFJJNhbECHL1xqDCU+vPWcyhdgYceKlZhupASW
         IYJ+K8dPdNM71wCJ0bTE4LGqMzGJjaApgx+iiySnuX04TpEXFRbtnwQwsquEXnRGtOuz
         npo4EWSX9BD6gaWo8lFvZBslzTj+JjjAD57PqDgxeR28WKwzNvHhuB9ydhERQxjNUmGu
         9y4GgbMQZ1BVpCiQFIDsgVvggwm2KLMT6BK9xJqsBplmNes7wmVDHZC36RjmS/NSDv2/
         sC8A==
X-Gm-Message-State: AOJu0YziE6uXGC4oaV8lTl82ypqiHVUwHfJE1aWricjy2gqTOyjDHgzX
	T834jx545TBmWnBwiJAEvKbIi0r+m14=
X-Google-Smtp-Source: AGHT+IFrI7708XgbFsh3Sllhh2xuhMl1iL70jfJjRcszLUzbZiml1TxubQ56ql5X13ebsqNh2uVC0g==
X-Received: by 2002:a05:6870:1816:b0:1e9:dfe6:38b4 with SMTP id t22-20020a056870181600b001e9dfe638b4mr331495oaf.15.1698693460348;
        Mon, 30 Oct 2023 12:17:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:17:39 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 03/22] asyncrpc: Add context manager API
Date: Mon, 30 Oct 2023 13:17:09 -0600
Message-Id: <20231030191728.1276805-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:17:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15305

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


