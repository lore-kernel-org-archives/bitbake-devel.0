Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0199AF33A96
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:32:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46942.1772724741212391441
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Mar 2026 07:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=rzMK4+NV;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+pascal.eberhard.se.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 526A461420;
	Thu,  5 Mar 2026 15:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04058C2BCAF;
	Thu,  5 Mar 2026 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724740;
	bh=fM0XKZyQ6asKTKoIICxhU8YNDQTj30aIqR/D4+BtmqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rzMK4+NV3tJeMUH7BvTP9RAotvYzWjDBHFChlGy+kXnd8MYmE6mfhxjIrL7p8ZPkC
	 /Sq9b1pkG5pk5unqWTDC+kr4eJgLmywoT7o61oC9q4ARBdgi3AuPlQ+Ux5CTni0rxl
	 QHTuxBJYOP5AGfGwmWELu+FQntxteTtubI2WnYnhgxdj59hXzXmV8otSPUZv8E7pN2
	 F6TNR5qRjLccMzrrni3nDk/JpDtlgD3QYZbqf8HEnRQYZa+mp2YZth34hChavNtM12
	 aYDCXAP0Yxg61ey/NJ+N3ihVrulTBh9dMHdFSLXF+OAqaXqkeZ3X+WA43y5obPbsWh
	 K32/j7lXpgOSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F7F33A93;
	Thu,  5 Mar 2026 15:32:19 +0000 (UTC)
From: Pascal Eberhard via B4 Relay <devnull+pascal.eberhard.se.com@kernel.org>
Date: Thu, 05 Mar 2026 16:32:16 +0100
Subject: [PATCH 3/4] lib/tests/fetch2: add tests for curl method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-add_alt_fetch_method_curl-v1-3-0d0220e5fa59@se.com>
References: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
In-Reply-To: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772724738; l=5017;
 i=pascal.eberhard@se.com; s=20260304; h=from:subject:message-id;
 bh=UaiA9e2FKgpaMtTOgq8g3apGKeVH2UE6u0BEkf4ti6I=;
 b=LWVdmEF5vO47Le3Uoh4IzaJLH1WRTHoGSglqElCbF3nJZu5CcOm2dc1HMREguk2M39QMjxYpL
 zqEBnEWdtMgB/aK+3J2eAmfqdsS7Iqyc8dmBn5vmgWnWJCyGjodxBco
X-Developer-Key: i=pascal.eberhard@se.com; a=ed25519;
 pk=J7TbFctjt1RVuN5K0juhf/w1E9bAfSeoQ/JG1vV9mWg=
X-Endpoint-Received: by B4 Relay for pascal.eberhard@se.com/20260304 with
 auth_id=661
X-Original-From: Pascal Eberhard <pascal.eberhard@se.com>
Reply-To: pascal.eberhard@se.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 15:32:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19112

From: Pascal Eberhard <pascal.eberhard@se.com>

Duplicate wget fetch method test cases to test curl fetch method.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 lib/bb/tests/fetch.py | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 74eb73472..5c587d7b4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1550,6 +1550,7 @@ class FetchLatestVersionTest(FetcherTest):
 
                     url = "http://127.0.0.1:%s/%s" % (port, data.path)
                     ud = bb.fetch2.FetchData(url, self.d)
+                    self.assertEqual(ud.method.__class__.__name__, "Wget")
                     pupver = ud.method.latest_versionstring(ud, self.d)
                     verstring = pupver[0]
                     self.assertTrue(verstring, msg="Could not find upstream version for %s" % data.pn)
@@ -1558,6 +1559,35 @@ class FetchLatestVersionTest(FetcherTest):
         finally:
             server.stop()
 
+    def test_curl_latest_versionstring(self):
+        self.d.setVar("BB_FETCH_METHOD_HTTP", "curl")
+        testdata = os.path.dirname(os.path.abspath(__file__)) + "/fetch-testdata"
+        server = HTTPService(testdata, host="127.0.0.1")
+        server.start()
+        port = server.port
+        try:
+            for data, v in self.test_wget_uris.items():
+                with self.subTest(pn=data.pn):
+                    self.d.setVar("PN", data.pn)
+                    self.d.setVar("PV", data.pv)
+                    if data.check_uri:
+                        checkuri = "http://127.0.0.1:%s/%s" % (port, data.check_uri)
+                        self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
+                    if data.check_regex:
+                        self.d.setVar("UPSTREAM_CHECK_REGEX", data.check_regex)
+
+                    url = "http://127.0.0.1:%s/%s" % (port, data.path)
+                    ud = bb.fetch2.FetchData(url, self.d)
+                    self.assertEqual(ud.method.__class__.__name__, "Curl")
+                    pupver = ud.method.latest_versionstring(ud, self.d)
+                    verstring = pupver[0]
+                    self.assertTrue(verstring, msg="Could not find upstream version for %s" % data.pn)
+                    r = bb.utils.vercmp_string(v, verstring)
+                    self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (data.pn, v, verstring))
+        finally:
+            server.stop()
+        self.d.delVar("BB_FETCH_METHOD_HTTP")
+
     @skipIfNoNetwork()
     def test_crate_latest_versionstring(self):
         for k, v in self.test_crate_uris.items():
@@ -1590,6 +1620,7 @@ class FetchCheckStatusTest(FetcherTest):
             with self.subTest(url=u):
                 ud = fetch.ud[u]
                 m = ud.method
+                self.assertEqual(ud.method.__class__.__name__, "Wget")
                 ret = m.checkstatus(fetch, ud, self.d)
                 self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
@@ -1605,10 +1636,47 @@ class FetchCheckStatusTest(FetcherTest):
             with self.subTest(url=u):
                 ud = fetch.ud[u]
                 m = ud.method
+                self.assertEqual(ud.method.__class__.__name__, "Wget")
+                ret = m.checkstatus(fetch, ud, self.d)
+                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+
+        connection_cache.close_connections()
+
+    @skipIfNoNetwork()
+    def test_curl_checkstatus(self):
+        self.d.setVar("BB_FETCH_METHOD_HTTP", "curl")
+
+        fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d)
+        for u in self.test_wget_uris:
+            with self.subTest(url=u):
+                ud = fetch.ud[u]
+                m = ud.method
+                self.assertEqual(ud.method.__class__.__name__, "Curl")
+                ret = m.checkstatus(fetch, ud, self.d)
+                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+
+        self.d.delVar("BB_FETCH_METHOD_HTTP")
+
+    @skipIfNoNetwork()
+    def test_curl_checkstatus_connection_cache(self):
+        from bb.fetch2 import FetchConnectionCache
+
+        self.d.setVar("BB_FETCH_METHOD_HTTP", "curl")
+
+        connection_cache = FetchConnectionCache()
+        fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d,
+                    connection_cache = connection_cache)
+
+        for u in self.test_wget_uris:
+            with self.subTest(url=u):
+                ud = fetch.ud[u]
+                m = ud.method
+                self.assertEqual(ud.method.__class__.__name__, "Curl")
                 ret = m.checkstatus(fetch, ud, self.d)
                 self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
         connection_cache.close_connections()
+        self.d.delVar("BB_FETCH_METHOD_HTTP")
 
 
 class GitMakeShallowTest(FetcherTest):

-- 
2.43.0



