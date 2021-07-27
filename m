Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web12.4617.1627406519951626856
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 10:22:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=KBAN+uaf;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d9so10021581qty.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ju7/wL0RMYtOeHsQZamvObd3vp9kwvNCknXAEx5iPd8=;
        b=KBAN+uafgJ5rNR6b/RPAWBFf60ivab8vDr9UT1C0YZqhAtejlFv7SXC6ojnPvy8r+b
         f7Gd09amjinytkLvIXaXdhtCUN+3Neje+ABb72sPtANA0zNmxc35Z9ldAeN8jdAUHkHo
         RttmZl6x0IOVerFbv8UtC4/oOsfyZRYwEPMUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ju7/wL0RMYtOeHsQZamvObd3vp9kwvNCknXAEx5iPd8=;
        b=CWnTgDXAcg35JoL7XNV9jW0SP8uRLWNwGA/hOlsqjxfj4MfALZ4OR/TJLAc4cSXiI3
         RdVL5GjhW2pR1BorTMfwkBRXKUs8jPA974WKDyHUPWsVGHmaEWAxpU/GoEejnbGIknIA
         /lgHrdxRM7lYrlYOIEQejgx31JBRXq56LLrNKis/n+vXgniyy3NrNXNciIs44L2By1bF
         5BrdemWrCAhcCP8vvi9AT1UuKI/vsTZCmGGXBbj6aOzzPipdWFYqPS9qFA382Cc3Fo5H
         mR17e1rqroDQvHYu1PpZVUFAtMnMcHqBHB6sN7iTYyVJ6Vti1fIRszBvchBlLwIwsxRP
         t1IA==
X-Gm-Message-State: AOAM530eQH21DmK8ByKgMoaix0H4oIksT0Bdduao6zim5F69kxurORLj
	5spunll282BDMFo637CqcDB9J+f8v4Xg9w==
X-Google-Smtp-Source: ABdhPJwsEwW9eg7/0tdHPCPJnK0eHUhmvE5kS5eVGyq0mt4qBzKOKRbh+mW7tgmab66NMByBaTwnbw==
X-Received: by 2002:ac8:6705:: with SMTP id e5mr271959qtp.282.1627406518892;
        Tue, 27 Jul 2021 10:21:58 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id f2sm1648719qth.11.2021.07.27.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:21:58 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Paul Barker <paul@pbarker.dev>
Subject: [PATCH v5 2/5] asyncrpc: Ensure that asyncio shutdown is clean
Date: Tue, 27 Jul 2021 13:21:42 -0400
Message-Id: <9e7d39f0a8ea9a747188fbef2ff08a84818a1bb1.1627405824.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627405824.git.scott.murray@konsulko.com>
References: <cover.1627405824.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Barker <pbarker@konsulko.com>

We should ensure that all async tasks are cancelled and then allowed to
finish gracefully before closing the asyncio loop.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
[updated for asyncrpc SIGTERM handling changes]
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 2c219c1e..87d142c1 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -205,21 +205,37 @@ class AsyncServer(object):
         except KeyboardInterrupt:
             pass
 
-    def signal_handler(self):
+    def handle_signal(self):
         self.logger.debug("Got exit signal")
+        self.loop.create_task(self.shutdown())
+
+    async def shutdown(self):
+        self.logger.debug('Server shutting down')
+
+        # Stop accepting connections
+        self.server.close()
+        await self.server.wait_closed()
+
+        # Cancel all active tasks
+        if sys.version_info >= (3, 7):
+            tasks = [t for t in asyncio.all_tasks(self.loop)
+                     if t is not asyncio.current_task(self.loop)]
+        else:
+            tasks = [t for t in asyncio.Task.all_tasks(self.loop)
+                     if t is not asyncio.Task.current_task(self.loop)]
+        for task in tasks:
+            task.cancel()
+        await asyncio.gather(*tasks, return_exceptions=True)
         self.loop.stop()
 
     def serve_forever(self):
         asyncio.set_event_loop(self.loop)
         try:
-            self.loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
+            self.loop.add_signal_handler(signal.SIGTERM, self.handle_signal)
             signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
+            self.loop.add_signal_handler(signal.SIGINT, self.handle_signal)
 
             self.run_loop_forever()
-            self.server.close()
-
-            self.loop.run_until_complete(self.server.wait_closed())
-            self.logger.debug('Server shutting down')
         finally:
             if self.close_loop:
                 if sys.version_info >= (3, 6):
-- 
2.20.1

