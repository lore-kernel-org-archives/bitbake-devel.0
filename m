Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB5DE7AD6B
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:02 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web11.110206.1696344779806220502
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:52:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a9jZrqDU;
 spf=pass (domain: gmail.com, ip: 209.85.160.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1dd1db54d42so654909fac.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344778; x=1696949578; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah7T5DLLgKcwbR+nAz+6ZVzD9pqliJvXfCYEytYbfGQ=;
        b=a9jZrqDUT7xBHZioFMxBQHJHj6wBpyb/oqYoR6CWwOMFd4QPfkX/FVQEjd2bI0CxQ7
         MaksIo8fRAKsPkpoilsa4boNdd93qczrgKxXdWyxmyg6LmFYLZ0jC+ZpjMWb1neEEMo6
         xYXfjSm/30jn6Qq+bTWjg1WPvMOkWgyLBH9x7ctsc091EO29k+2Y8SVmEO1S+eTRi1pI
         TaNd9bz9E+dywLL6Vm06EVpdd8ywrlebZpUgUKlrZIU7HZlQu1weRkiRCwM2Wx1V4bLt
         toMzfgJ+EV7zfy5K3LC1xZ69/7xiCbz58nzAen5Xr6APUYmG9cSWCJ1HUKmocIuGvqJS
         qdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344778; x=1696949578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah7T5DLLgKcwbR+nAz+6ZVzD9pqliJvXfCYEytYbfGQ=;
        b=LmqU+v3vU+Kyr2K1rDvka8lMeL16uAT9KC9T/NhhboHMs46y875b2adtIZkLHObsqa
         wyFyEnBFMzw3GJU+6PdfDTI3n8u/gW6ayfNrtHJ9+u3mfeTMHahfUrG8dDC8rOkzyaUw
         Nr30LoT6tJft/U9zLUoxt4KV19t0zqv8+WutDPkowpX6ki0TgriG+cjeL5kaNDSZxg6A
         fEi0vqA295b06PCXwoli00K4ybyjf7bnBuibUv2FX6T4Cyj+ukfAUGq5/I/kB8fYkaHI
         W+tUk4LG8mXDPWFs1RjnPljb6tsb0x8RKaLYrZthMEKka3rAVhIdXfYA5bcu3LDjrOtR
         yXFg==
X-Gm-Message-State: AOJu0YwbabssjCLijP6T40GnUQCVY6pqM0jKIh5DNcjVdwOwoqQwkO7h
	f/DkSMt4iiCrH9ChVCt0TLKc3JxApYQ=
X-Google-Smtp-Source: AGHT+IFpvww6Gk+VAQS4zCWKMJSHAIcvdFKjduryLP0xY31gmAkLPJAsNaZLQ9+WC6CBPKIW8zxz9Q==
X-Received: by 2002:a05:6870:d38c:b0:1bb:c50d:7451 with SMTP id k12-20020a056870d38c00b001bbc50d7451mr17171122oag.46.1696344778348;
        Tue, 03 Oct 2023 07:52:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:52:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 05/12] asyncrpc: Add context manager API
Date: Tue,  3 Oct 2023 08:52:42 -0600
Message-Id: <20231003145249.1166276-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15166

Adds context manager API for the asyncrcp client class which allow
writing code that will automatically close the connection like so:

    with hashserv.create_client(address) as client:
       ...

Rework the bitbake-hashclient tool and PR server to use this new API to
fix warnings about unclosed event loops when exiting

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient    | 36 +++++++++++++++----------------
 bitbake/lib/bb/asyncrpc/client.py | 13 +++++++++++
 bitbake/lib/prserv/serv.py        |  6 +++---
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index d09104336ab..00f100b5de1 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
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
@@ -165,9 +164,8 @@ def main():
 
     func = getattr(args, 'func', None)
     if func:
-        client = hashserv.create_client(args.address)
-
-        return func(args, client)
+        with hashserv.create_client(args.address) as client:
+            return func(args, client)
 
     return 0
 
diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index 802c07df1f4..009085c306a 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
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
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index ea7933164b1..6168eb183d7 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
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


