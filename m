Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC1DC0018A
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:27 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web11.10718.1698853345566049754
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=InJlLhmy;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b5714439b3so819471b6e.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853344; x=1699458144; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=InJlLhmy7UIhUqpudOOQO+aE2tLa3ReiTqYiQOFn7lBV1TlTPLKZ7fZEORNVbiCX/U
         hh6CiQkh1kloFHAyLXpfrtDGk6bpSlanvRIuq5R2Cn/J1CtwdiyHxxen7nozS0yrD+iN
         A62BU7Sh+N0FwyJdvXZRFfOsHeX2UzwTCUtvCBoGtreRsfEEh9zkkqHpNxmIIQ81UI9+
         ldVOr9681h0S5MmcpE+o5hd2WngCW8/8MiR2aaElZfgur443egFDouo825vpZTJb3NEr
         HrqAiKRENy+0quJLR+inYE+gxrLHq+k1PDObFzdzY9bR2QAQ49tYx50uUdJfe1OC+gn5
         x29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853344; x=1699458144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=snHmlGRh181vDot3HOgkfZn2bjfbAIrG8b3jNrO/VqxPCgzA6nppRpg7vOTRiL6OcZ
         h5BeCpdgayfBVBnGmbCbqaBm318fOX2sWipNxfb8VS5UP+FHVfu6TB5dD5ptTtjR64Nm
         DkUeYwGo0vOwfZqlrd6yecc5h6GcguJPOUXud95rfht97YWxa3f4+N0aUvSmwvX95UNM
         077iW+BDOBOX5vwFg/pxHNMjsEvkvDlsryia+nlVH4MnpzYt+7UVLddkySMcWvA6rEsS
         t8+ljeB7yn29hmqeyn7GVqoWSFCImgDQU66NFfUceds2WDeefdoK9l7IItEDUoP8H6G7
         q8ZQ==
X-Gm-Message-State: AOJu0Yz1ufg/DwhaiawxY6t+zvxUxM1lqTKgZyabcshB3u/Nxh2Nxcyv
	HJjTFkSfFUxgdum1z+3WZFijTmP6CA4=
X-Google-Smtp-Source: AGHT+IHp/brl0jA1XC9tqz95sd9B8FDZvgzT65CUx7EwsbxHI5K1PemgEPRKWsBtmzRk2v6rShyISw==
X-Received: by 2002:a05:6808:220f:b0:3b5:69c2:59cd with SMTP id bd15-20020a056808220f00b003b569c259cdmr5063012oib.25.1698853344177;
        Wed, 01 Nov 2023 08:42:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:23 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 03/22] asyncrpc: Add context manager API
Date: Wed,  1 Nov 2023 09:41:57 -0600
Message-Id: <20231101154216.2758185-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15385

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


