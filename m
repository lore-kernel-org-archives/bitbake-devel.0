Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.6944.1624853644602425957
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Jun 2021 21:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=q79Qip1F;
 spf=pass (domain: konsulko.com, ip: 209.85.221.41, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f41.google.com with SMTP id r8so5614936wrx.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Jun 2021 21:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiVj1WxKVG7GK+xV/grFrhbKLyLr0FR5jEscQG+sdbQ=;
        b=q79Qip1FuNOdDK7Kbis402WdvYXxfiTkzo5kPEcupO/ogM2VpT7Lsk/neD/9tGVjXQ
         D0tmI+5pqy50c9oIdonaxlobdov5Vl4bTDo73D/qxzadakg9m0kG+bckR1wyYwJMwkkx
         wesok55NZdZhlSkbQprENkfVPdDbMzdnjeR2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiVj1WxKVG7GK+xV/grFrhbKLyLr0FR5jEscQG+sdbQ=;
        b=Zqy5ElXd0IorA/yZvoqUkYoFMH/iI3hOvsxEXwCZ1Qy5l1ku6t1D9J6HqB4U3SjVjY
         tYt3bBv6T5bucPmmeJCyszzUlXaxDdyjxHNS58WTJfHXgwTQtQu9+3pzoGgJJDfXFRVX
         q1peXeB/JhVatLNGgwmrVQiQ1ASdhlQtED4naM5+yvjR7nL/nU4DeF8t3VZyQ06lgBtO
         KhyxWd7+t4wUNDuYmlmVMUNYVXSdCoReSm7sWOpJiknRdFivwqjPyzQL5twyTw9ryxh/
         yJxinTQlYh4poXGcgaOmNwaWL3tEWZo1/fHPZnpnEvEHHfIJaiTaw6FEXw1JnWIgA9kN
         BDzg==
X-Gm-Message-State: AOAM532Wjm3gtnaHCZByCY94qrS0bFxj6mBXTzm5erEYdqsDoBC9Wzue
	b+roY6vUPiiEFeUY+pZyuAuOLz4V+4tzfg==
X-Google-Smtp-Source: ABdhPJxWnt7sJbRleFQbXrrggYThVOlMSXqGKEH7DmiAXdrUo3n8qIsTxl0N1seC5ZGDH9m1s6eRgw==
X-Received: by 2002:a5d:4351:: with SMTP id u17mr24432953wrr.47.1624853643074;
        Sun, 27 Jun 2021 21:14:03 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from owl.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id b187sm2874590wmh.32.2021.06.27.21.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:14:02 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v3 2/4] asyncrpc: Ensure that asyncio shutdown is clean
Date: Mon, 28 Jun 2021 05:13:54 +0100
Message-Id: <20210628041356.2676-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210628041356.2676-1-pbarker@konsulko.com>
References: <20210628041356.2676-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should ensure that all async tasks are cancelled and then allowed to
finish gracefully before closing the asyncio loop.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index d6e3df2c5..0cdae5327 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -198,25 +198,34 @@ class AsyncServer(object):
                 await writer.wait_closed()
         self.logger.debug('Client disconnected')
 
-    def run_loop_forever(self):
-        try:
-            self.loop.run_forever()
-        except KeyboardInterrupt:
-            pass
-
-    def signal_handler(self):
+    def handle_signal(self):
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
 
+    def run_loop_forever(self):
+        self.loop.run_forever()
+
     def serve_forever(self):
         asyncio.set_event_loop(self.loop)
         try:
-            self.loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
+            self.loop.add_signal_handler(signal.SIGTERM, self.handle_signal)
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
2.26.2

