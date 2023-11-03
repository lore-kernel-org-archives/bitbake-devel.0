Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5376EC41535
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:26:56 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web11.52752.1699021615429474574
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:26:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Rkklhgkh;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce2add34c9so1124238a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021614; x=1699626414; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=RkklhgkhqvXRudus5EdVRWdI8LZLxgfuXetY5+0/kD2Ryc/W/6I2egGdvwdKav3/ku
         zUnUOAqc3ffeDjcpuJI0e8L2Xv1Acm1gEgMoVHIw6epxatANhvpWKNQd39sFVNEB5I4I
         HENdKdV/bvHeSgdtZCbqwe4GzXQ3r6wX9LPeikobmgfkAN5M8PY9/lWBrpQ7mi1t+2Xr
         yhZ6Q31zEncTAwoKMSwXoh4/xJP/SUq1i+z+SGMZIRC73n0XVMa1Sk4tpdShyOVvWkh0
         iivdBwvxLZs8auJvEIsgzY38JSbR86o2W9NGBT6T5wZDa5HZv0hqcYq+pgdhzoeHXcbI
         +O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021614; x=1699626414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+q+Jum3wcT/bW1MYDxLdu4U6YuIiAfM4cBVEFeVbAk=;
        b=feu9VwCok02T0HYYjBAuwEKqbE/dDN0UiMuVulZWlmWwwnlH6ZXnbQmjSQwF43Wvn2
         rDvYGeGcpZbPZtVKoDSA5UBkGPSJtCYbCC9zxBfGW0YrcOvoRHCcxSz4tiH5uaKmXhK5
         J5qT3u4aIp0O7apGwt/3HxfjcVbdjk5xUvwOZziBJhjEuSH7GXLeAnadbOGXkxyaDDzW
         1TPrFvN27ilGpptvaWm0t7xWATLA2vcXng8eatpc1tDhGD+fp99e1hY+LoXbN4LIWXKJ
         2zZiv4G3zI6cP4WULUnY+RCvesPEw9P3wapDBIQi1O8dULJI2hgK9oud/2nt67jJR1bV
         vZeA==
X-Gm-Message-State: AOJu0YztOjVD8ZHgaG04+XlJvtyVRQZlWbtX0vxhU1jdEMiZnSIxXjIa
	jDbz9WD8DDBhVDrUqK0XPmNJkzi6itk=
X-Google-Smtp-Source: AGHT+IHjbF0vgdksnJVpvuU9u10fqHhKeerv5T15e/SCBBqU3kmDIPi8A83NI+SJ9w+SL2rky4muOA==
X-Received: by 2002:a05:6870:fb8e:b0:1e9:a3e1:c388 with SMTP id kv14-20020a056870fb8e00b001e9a3e1c388mr24587605oab.41.1699021614091;
        Fri, 03 Nov 2023 07:26:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:26:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 03/22] asyncrpc: Add context manager API
Date: Fri,  3 Nov 2023 08:26:21 -0600
Message-Id: <20231103142640.1936827-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:26:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15424

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


