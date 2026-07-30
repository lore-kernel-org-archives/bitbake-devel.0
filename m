Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00DAC55176
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18823.1785436385113950930
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:33:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GBrmDLJN;
 spf=pass (domain: gmail.com, ip: 209.85.167.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4864ebb6268so95057b6e.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436384; x=1786041184; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZcxZ3UaMHTn38iuVdLYUP8pryE3wcTDVvswqZpNd+k=;
        b=GBrmDLJNhxstrvmnq+4Dg+jtczLo3jtpXZ4Mpk7Jvj+aDXYwSHw/06u0LfkpakSd7R
         QbMZuG0vnCfOfwipzZ6fpa5YSinDSku4Rj6del/DtE5GIY9l5Pxm9AerwCMAfZCStWWd
         9jVyY3nPea2eE95vhAKEAe6euRXI35ZQABymfjEhTI459KEde+AwhgZQFUKawKhaSjYH
         CQUSM2hGQs/B69LpFULmVgKsjnV7O3KU4+uOUPyXSNeDXhdMQ0InCdzc4oGCvBl0gChG
         1XyfvujChKPGaBJJkfwiJgPU6hE4zskkiSvcTelyQgSCDxelV6FOOHfX3xi4mlPWbRP3
         tIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436384; x=1786041184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZcxZ3UaMHTn38iuVdLYUP8pryE3wcTDVvswqZpNd+k=;
        b=pV13DGI7m0jMNdsjHcdC54Vh4+iJVy2wUZpgW1FvUz7eSBzBeNiOn7egzjEz64pYxi
         2NjEp37fvoczWkT5owOtgYWiBv/hT/gfM2NyRSJEYOv5cjb9n1Lmc/VH/tBRhjb4ITER
         B/2/o3ihrdTUK9w6tkL1A3DzMpUD6U+JLx7md0c1xFaZhv+n4q0/u5ozdp+iPSVPuJlF
         voBKeregCBCwGq+ZjO6cbGffhr347JRYzbwF/k423HvatkhcAQVYK7/+AURyrTNeFqIa
         K8ISnWt2Hksp9M+/NK6s8x5dtb8/eh6ANxwP8W/wB9Z/cAUl/FAUHbEPpLn61x5y6+xH
         18sw==
X-Gm-Message-State: AOJu0Yxt/PyLdKG29xofEfSxOFji+RZ1FmYaT1B5oGzajMPYKBH4OI9L
	ZlH1yDRL541YXfcAipEPQjs5hDn3MvVkFp0qgFusW8CSs8H90ZRvPEOmkFZ1IA==
X-Gm-Gg: AR+sD13dnSjWSDeEzwtC9lVsi9y9cA4YePKYMKaHL/5k3fVJBX2wYfxGOzdem/O4Unl
	puJGrIXz09Hi88eJhFZuXscl/qXl/A0WpKgKmjhSFjun7oMcexviKl1vkH0TDdUVgWT3Qn+5MpF
	kGFHJmGi8df4Ze7XtNU3o1nB63tv9YN/P1y7EJ4l5cNeAcUvLQV8hvxe5n64M8G3K0rRB0tNZAr
	dJsdJdDteencZ9it1YICvix+A7usBT/FydFgsSm50s/lyCi0hcyp5RvTaOSVBGVi3QVZ/QMSMkr
	NxcWj/hFxYsRgba4wceGks8qmbdkYh10ZLFe0dfTdh/9/iFJ2PNxKK8HAL1ftLTc8Yk9ohA9+e3
	TL5m1m6zPgjYIt0bFOtcqlc2CweeYmu7h10/4Uv02BFtBwpKpBtxhoEH7zOcjgOMEqycTBvgMbN
	nwt26YFea2+Aa8iWlX+rpTw5baoY8osCvNKTnMrvCMU0X3SLy3I9TgZa9vNQ==
X-Received: by 2002:a05:6808:30a3:b0:4a3:cea7:4ab4 with SMTP id 5614622812f47-4ad877fc162mr3161720b6e.14.1785436384204;
        Thu, 30 Jul 2026 11:33:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:33:03 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Michal Sieron <michal.sieron@nokia.com>
Subject: [bitbake-devel][PATCH v2 10/10] hashserv: tests: Add test for upstream pipelining
Date: Thu, 30 Jul 2026 12:31:03 -0600
Message-ID: <20260730183254.793698-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19890

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
2.54.0


