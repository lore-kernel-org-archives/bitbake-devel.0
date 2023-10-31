Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C27C4167B
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:21:52 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web10.1609.1698772912024106827
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:21:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WDpU+aXk;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57ad95c555eso3764764eaf.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772910; x=1699377710; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=WDpU+aXkq6qMHRsV6v/XYfs3MfPUlaGyJ9vtKKSBJAilQ6JRGF3WaClHprEaXdexSM
         6iurtmXrd7uP67UWRCH0g69vj5t+8tiJJJyBiyqbiNSsP/RWF7Se1Z53Loi0ZhJNGCHw
         pF44APLTGz3zFwn4nqH6HOYqET5OHvnzsRdn5VX58OVd9/se2AY09+uG5d1EVo8wdyWK
         O5DC1NR9tyaN45QRoxLtJ0mw90cr9Pss3o5ZfbBvGqPc7C+/DppUoW4q59yj/O5r8pdY
         Dxgcp+hUiVaKb7rRHcxgE0mN52TpWHOhjEpvIuV97vAuPfPEYzwKxEXMGkFBKFTb1IO5
         oaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772910; x=1699377710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=rKiy6lRAxinqCstk2k9t5se2GobIxBgSzB2NuXfeLqbCz+XYoETzZj9rwhq6COzuYN
         3uVmnwK0JOefcLflqNsaTkN+fG3R2V0Yqw2eK4OwjNqJWQgcn55bXvpXKSDfd97bH7oQ
         4LI+1NHvAmLEekGADJ8cTdLXz3ympGaAdXwM2HOzZ6K0RcxtUhSsrmbA5q1SLW+B6xkt
         mHSKC/MXpAdcL75+w+krzdK7rSzT8OfjEnJs1/K9W2S3ZItiCt2qTalJgRvZ1mqhAPBP
         Stnaei7iFrUDmthizewdtGcSisfUc4FFs0xwYaGzTL9OxPs/hvGMgR396Zio1e/GJjY2
         UqmQ==
X-Gm-Message-State: AOJu0Yxb1RN/GykiyGGgzTqaLd6J5R3mtUoIBcv/EAbYxo2eHxxMHAnI
	LYjry1eLjNVf2fjMsLcWz60q+zJXbcQ=
X-Google-Smtp-Source: AGHT+IHxT1YwxalmTQvw7wqsV02/ZaFw1s9U0hRzpXvNhBJZby7UMenp4YrMSx9ysybE0SRSBu6RVw==
X-Received: by 2002:a4a:da4f:0:b0:582:3c4a:923a with SMTP id f15-20020a4ada4f000000b005823c4a923amr12181927oou.9.1698772910240;
        Tue, 31 Oct 2023 10:21:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:21:48 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 03/22] asyncrpc: Add context manager API
Date: Tue, 31 Oct 2023 11:21:19 -0600
Message-Id: <20231031172138.3577199-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:21:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15353

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


