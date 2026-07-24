Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C13EC531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 21:28:41 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28981.1784928511376313270
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2026 14:28:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=i67ktGzV;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4563ac048f4so494093fac.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928510; x=1785533310; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpKwBLV5BxsmWBXTu0qLwGCa5/4EAPrutBLij9MoUVY=;
        b=i67ktGzVrt62taxIEl7VEqYJUhsqiIT0+ChpmXctLPoP4U/tU7s4cENkOHxZUkI/X9
         8Lv8wk7+cc3nh2IxFm7AUS/Fs54ZdnkK8Z4ScrYtLHRAdTfDEeRmQslBSn0a5jnlGJLT
         lTXBPaGu9OvTfy1OfJIS8D2n4ovXusm16h/QaeWOk6BPKSnjUL63u0bLl7B64E8Fm2AD
         Z7cNn3UD0JhVhsu6eB+bkei3ly0/TO8EUzbQqWmc0mI2E7a0ZbxEdxNtkGS6sZ5ZwIAg
         xuK//wyjH+Tw6RJ7yQe4YR22FXd51KNT1bqrCvQDV4U3t7uz1a6WdUtnx5bThaPJT88A
         aLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928510; x=1785533310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZpKwBLV5BxsmWBXTu0qLwGCa5/4EAPrutBLij9MoUVY=;
        b=Ars9nu2njzg4FdriQqQp7Z658wduE8q+MpOIKCTJQN4ooPtlcpcqRLixCsyItgRCq7
         2u2Bn35BZAVHeBNTagEfAb9uhBBuPmnEnc5eE7VCSQgMe6LEBnQ8ryeoqGx7cFAQu9gW
         32RUBZasT0Pj0jWMXGVU++NI4bKm0btJIRQCW2HX/u4WmBE5c66XnOan1vXfTrGppATK
         w13uwOZEd9+Tey4JPSxR283F7JY5D/xf9Hrlfwx4sAcCH9CrtocBDJdoeDKib4tX7x2i
         hA5XjUNzy5NWrXczonNS6nwUBvYgoIECfxejTSy5eGJ1oylv8ZP0dNoOaqZ9d9LnOzq1
         q3vQ==
X-Gm-Message-State: AOJu0YxdeZlx+wMX9b/F52M0Eb4HsSPfvVyLV7lCM+eAYcyWPYRzEY2l
	r6Kllq682EaeNV7MlFR41MhFD44C8wwohqfyqkNmvh3Frdjo6Kyd7+f2+GZqHA==
X-Gm-Gg: AR+sD11jaUTI7x0iaaNf5bjDE578a9TfJau/H3Dk23Yf/MlYR3YjJdKxSfx8olJA6b0
	k1lQzdV441npOXG09p6PzyoxDcP3FyxcaaXesod4uU3h9E5+xEcn5bKUQvWBU/vT+fkIrJ52vJJ
	2cny5GXrE51tGlKH+2dffATj69YIlLuSKyBrrkhbibpPyJsaYf4axuM7OeLvjULHuK+2lV93crk
	vLKtr89eOvlfH+m1YIlpGIz+MCX4/nhSCwGYcOjC+cE+DPTO7tS7ZafRXxIqfpVAw15ns97BLte
	65E+r/uQOiVOhzXNXscacwncvD53kt5Ido2gExDwuFDXJKPwgsoqvMIkPUHsPNR/w02CyuiAJYV
	Z9J/hCLNLrme8opHayeTQiv6a0iZDgQjiOQExoa6Y1Ik6RGIGH2d3AW8T2TC2QmE3MLp2QtKL9Q
	g=
X-Received: by 2002:a05:6870:34d:b0:456:ae13:5583 with SMTP id 586e51a60fabf-457f27758ffmr179363fac.31.1784928510535;
        Fri, 24 Jul 2026 14:28:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::5d97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm8183883fac.10.2026.07.24.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:28:30 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 6/6] hashserv: tests: Add test for upstream pipelining
Date: Fri, 24 Jul 2026 15:25:14 -0600
Message-ID: <20260724212822.1165552-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 21:28:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19856

Adds a test that verifies that pipelining to an upstream server works as
expected.

AI-Generated: Uses Cursor, Claude Sonnet 5
Co-authored-by: Michal Sieron <michal.sieron@nokia.com>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 96 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 0fbc19c1d..41c1f249f 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -1561,6 +1561,102 @@ class TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceComm
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
+                await asyncio.gather(pipe(creader, uwriter), pipe(ureader, cwriter))
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


