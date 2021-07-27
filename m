Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web09.6269.1627353489236171044
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 19:38:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fBajSwEa;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id b1so8630136qtx.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 19:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5xTfpGbBov7XQ7IIawWL3SFVXyd8dM8ADZXgKIK84yM=;
        b=fBajSwEakWKwNqtGYYf4qxMY0Enbtzk0rJvg9f2xA6mhIA8lJSDIY9CBF+GW+3Fp6T
         Kw5qo5wsogM5+uLXtoTMD/Ix/yqCq8TDR4vOXV0pihQWxN4Ast4PEtaN46s+syBn+0Hq
         pOaW1uhQaNnC8RBdmCxB9TVd+BB96DowNBEes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xTfpGbBov7XQ7IIawWL3SFVXyd8dM8ADZXgKIK84yM=;
        b=DeL3ez33YGL/FxuJTRfeaLDt8+ZOWxYplpInuxl1HiujGzwaIsnbN9C0Q+/bvWOF+/
         yYJ4/VlP7JZJEvxmk5ZmWShWndTsT21YjzSVaq7c2tkwYOe+ooYH5AUI+uQDym7K1AHb
         yeuOFJGX+woPifg1QSDFZ31JVszVyh69y2rVF7KINHlbnmg2cHXDPizOvKXVmpsDsbNA
         preiqhm8wD3dsWNvxOSx1bFWSPgi3H6U37Jj3zamLkGi6gnSCksGJE8bNxL83FaZyxTq
         J3W8rm14FCh6NiOOZgm/85gnqklNa98CPwGqqANQqMf09qXn+G/WKDso4rak7z/mETIF
         b4bg==
X-Gm-Message-State: AOAM530i0m4b5ljBZBoJh6pPzFGwZkwVNBFekEnK4K8czOpo6FAReRJp
	nRX+11z/KA609tTk8ugs9OPAlVkox5PYfA==
X-Google-Smtp-Source: ABdhPJyDy+7QjVwB3uQyEwLwip0VQ8NUA2HSyt2A73Ezy+Mtp9nyqHraR4bLs6zpWHniYN+bAr1B7w==
X-Received: by 2002:ac8:7a8b:: with SMTP id x11mr17343621qtr.126.1627353488168;
        Mon, 26 Jul 2021 19:38:08 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id h10sm974887qka.83.2021.07.26.19.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:38:07 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v4 2/5] asyncrpc: Ensure that asyncio shutdown is clean
Date: Mon, 26 Jul 2021 22:37:53 -0400
Message-Id: <d77acf060d653ecb2b6dd6bf7d7d1de327f1ba4c.1627352176.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627352176.git.scott.murray@konsulko.com>
References: <cover.1627352176.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Barker <pbarker@konsulko.com>

We should ensure that all async tasks are cancelled and then allowed to
finish gracefully before closing the asyncio loop.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
[updated for asyncrpc SIGTERM handling changes]
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 2c219c1e..1b7b7a6d 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -205,21 +205,33 @@ class AsyncServer(object):
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
+        tasks = [t for t in asyncio.Task.all_tasks(self.loop)
+                 if t is not asyncio.Task.current_task(self.loop)]
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
2.31.1

