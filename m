Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24445C61DE2
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:57 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4207.1787932794864436840
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NEgj/vAY;
 spf=pass (domain: gmail.com, ip: 209.85.210.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f4e596e393so1334972a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932794; x=1788537594; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=krMJFZtT11VxKkbCU4bf/lkNGA2769SAPOC0O85UI64=;
        b=NEgj/vAYDCJzJb6luHXJo8htlgZkIIgqq3r9/tYxLlWc7a/x+z4PWnAnIB2L1VJYnG
         csVSnYHkTLX4V6xcFKz2sJUc3EMOZs1WAtYTuSTDzrF/BYhxt9hMMdV20AC24q/wXmDN
         ZNhNG0AlZYnfthjAS4OOyKZFLlrLdD9btLUpeqHnD5bU/79qu6daRjSa4iy2QIAqs8wJ
         xXNJQ8bmYPk+aVrofbdNh573l9Ya7kJgkJjQIODZWK1Q9ktTTjslyeMbfZMsKKwXhoCP
         ua3pGwZ1d9M5HWYLiJ1Sz6Z8hFrLMGg1HylsZUwNLmV731nUJX6gdHuIhMrWjZrYstiI
         hG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932794; x=1788537594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=krMJFZtT11VxKkbCU4bf/lkNGA2769SAPOC0O85UI64=;
        b=HaWVdOipUQhZDOKtIiMAsHt2kFxZk2bqnLfAhxuIPYjGIH0cORUQhEmRAoM6qrdwHR
         oihGWWB1a8uqSR2CH2H77xFP3qmYs8/2t1Cv1IqVL2x0Qct+TAUeRpG9dVWGqiKIBEo2
         C6lV36ts68aklGUPGPzfA/aVPR7QAYGHEWzSem8gQf0YaFF4PrNs4n54hcZ3CkiEd3K6
         CCB8gEkKbtIX+NF5eGY+VSbppnd4jL4GMUYxKpXw3kbH6HZGyi862ZcWpCS1J6LZNFTG
         xMQ1yGUp8TsrO8RvAmNU1I4uPJCjYYbe8ay6hPWKwMGEZad241weY2FLCvX/aNgJ9J30
         Gq0Q==
X-Gm-Message-State: AFuF++krlnR9Zq1cd/AIjwQLbabK1Xn07xAUgaMhvXm7L/C28CpAF4Os
	u9uHxGHXJn2RH145eLe4meKAANWP5u4SEudYX/QeWMEBThqvIPVZKeS4AdRjBg==
X-Gm-Gg: AR+sD13T0hGeZcrcn/RXLDjn6RgB221mnen1nCIW6hRq8iTbCO+rr01VurHNR4+Bxji
	TnKlD/6LY3Bj8VQvAZoJhqsYoQQOJ8rJzBYwDES1rYrzsp8jJZiECBUR9OQ6KW0l4ZgoWLPnlYI
	zD2DDNdnxC0z/dBdj86dZhHDlI0cxPq0miH/QoBcrtYlxK6AEdhJYvbqmwJP+4/Meec69y3E7CN
	mZ10MYU9SMBsURsAKVAWvbeYXBqp3G5xjEXkJdoMttyqb0I+kmlKaF2mmu0gBXo+ovit/OO4dUy
	Z9MBIub3fuoPmoEyipUtWk2z+bAa7Wn8SC7OtloTvIWFbMrRnzAkJjaRW+g1RSZ4/L47SzZdkqW
	9XS1719m+BGhQo9MNT6S4H9J0rzomxjRFVx7akASWOTmCh8jIVFOVJz/knMYBD73ZTSh/w6lyBe
	EypYzWkvxUxqe42ztJhBOyy2Ym1zeYYH82l+9T5KxJqwCI0pYafJlKpIFCJg==
X-Received: by 2002:a05:6830:6519:b0:7e9:e8ae:7049 with SMTP id 46e09a7af769-7f4f22c9710mr10610725a34.7.1787932793944;
        Fri, 28 Aug 2026 08:59:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Michal Sieron <michal.sieron@nokia.com>
Subject: [bitbake-devel][PATCH v3 10/11] hashserv: tests: Add test for upstream pipelining
Date: Fri, 28 Aug 2026 09:58:17 -0600
Message-ID: <20260828155942.1219468-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20116

Adds a test that verifies that pipelining to an upstream server works as
expected.

AI-Generated: Uses Cursor, Claude Sonnet 5
Co-authored-by: Michal Sieron <michal.sieron@nokia.com>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 96 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index bb227c161..6201ce3bd 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -1693,6 +1693,102 @@ class TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceComm
         # case it is more reliable to resolve the IP address explicitly.
         return socket.gethostbyname("localhost") + ":0"
 
+    def test_get_stream_upstream_pipelined(self):
+        # Verify that, with an upstream configured, the get-stream handler
+        # pipelines its upstream queries instead of doing one blocking
+        # round-trip per task. A latency proxy injects RTT between this server
+        # and its upstream; a serial (one round-trip per task) implementation
+        # could not beat N * RTT, so finishing far faster proves the queries
+        # are pipelined.
+        import asyncio
+
+        LATENCY = 0.01  # 10ms each direction => ~20ms round trip
+        upstream_host, upstream_port = self.server_address.rsplit(":", 1)
+        upstream_port = int(upstream_port)
+
+        ready = threading.Event()
+        proxy = {}
+
+        def run_proxy():
+            loop = asyncio.new_event_loop()
+            asyncio.set_event_loop(loop)
+
+            async def handle(creader, cwriter):
+                ureader, uwriter = await asyncio.open_connection(upstream_host, upstream_port)
+
+                async def pipe(r, w):
+                    try:
+                        while True:
+                            data = await r.read(65536)
+                            if not data:
+                                break
+                            await asyncio.sleep(LATENCY)
+                            w.write(data)
+                            await w.drain()
+                    except Exception:
+                        pass
+                    finally:
+                        try:
+                            w.close()
+                        except Exception:
+                            pass
+
+                await bb.asyncrpc.TaskGroup.run(pipe(creader, uwriter), pipe(ureader, cwriter))
+
+            stop_event = asyncio.Event()
+            proxy["stop_event"] = stop_event
+            proxy["loop"] = loop
+
+            async def main():
+                server = await asyncio.start_server(handle, "127.0.0.1", 0)
+                proxy["port"] = server.sockets[0].getsockname()[1]
+                ready.set()
+                async with server:
+                    await stop_event.wait()
+
+            try:
+                loop.run_until_complete(main())
+            except Exception:
+                pass
+            finally:
+                loop.close()
+
+        proxy_thread = threading.Thread(target=run_proxy, daemon=True)
+        proxy_thread.start()
+        self.assertTrue(ready.wait(10), "latency proxy did not start")
+        self.addCleanup(proxy_thread.join, 10)
+        self.addCleanup(lambda: proxy["loop"].call_soon_threadsafe(proxy["stop_event"].set))
+        proxy_addr = "127.0.0.1:%d" % proxy["port"]
+
+        N = 400
+        expected = []
+        for i in range(N):
+            taskhash = hashlib.sha256(("task%d" % i).encode()).hexdigest()
+            outhash = hashlib.sha256(("out%d" % i).encode()).hexdigest()
+            unihash = hashlib.sha256(("uni%d" % i).encode()).hexdigest()
+            self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+            expected.append((self.METHOD, taskhash, unihash))
+
+        # Downstream server with an EMPTY local DB whose upstream is the slow proxy.
+        down_server = self.start_server(upstream=proxy_addr)
+        down_client = self.start_client(down_server.address)
+
+        args = [(m, th) for (m, th, _uh) in expected]
+        start = time.time()
+        results = down_client.get_unihash_batch(args)
+        elapsed = time.time() - start
+
+        self.assertEqual(results, [uh for (_m, _th, uh) in expected])
+
+        # A serial (one round-trip per task) implementation cannot beat N*RTT.
+        # Allow a generous margin to avoid flakiness on loaded CI machines.
+        serial_lower_bound = N * 2 * LATENCY
+        self.assertLess(elapsed, serial_lower_bound / 4,
+                        "Upstream queries are not being pipelined "
+                        "(%.3fs for %d queries at %.0fms injected RTT)"
+                        % (elapsed, N, 2 * LATENCY * 1000))
+
+
 
 class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def setUp(self):
-- 
2.55.0


