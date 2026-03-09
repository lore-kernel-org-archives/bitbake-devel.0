Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F79F41808
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:31:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28533.1773099105763126604
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 16:31:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=oGn/7Awb;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+pascal.eberhard.se.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C722D60054;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77ABBC2BC86;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773099104;
	bh=+A3FdQDUkn0AZTnosOSfEZzGoBXWcnnu+5djFl2CwYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oGn/7AwbUGamlR3JGzMjaXbANnGIcSbEPc3P+qzW9Jv12DN0QsDBjhSgWBIxaAdbM
	 nlioJc9htrMpv2rLl2/ZPym1hIDOTjN5X38JFD7doXCkTgH6uwJznu7WTyDkRcd0rX
	 g4vl6J+Nu67A5YKOHzQT3JbCyBlYcBsTBY2ruinBE3gAFSslHMrkaVSl7LIqGDGoBw
	 QlXo8rWYdpsQH4dT/BwqI8mMKJ8ItmQu1Z/aykomvy1YH6Q2bdulDln/K1a1GlSyEE
	 LLfN2gixQYBF3xkolz6GOtSSdgXcDiSXWKceO42g6yRoaxTHH/syxIj2l4SOm792HP
	 AWcCOVyCycxng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E0CF3C27D;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
From: Pascal Eberhard via B4 Relay <devnull+pascal.eberhard.se.com@kernel.org>
Date: Tue, 10 Mar 2026 00:29:40 +0100
Subject: [PATCH v2 3/4] lib/tests/fetch2: add tests for curl method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-add_alt_fetch_method_curl-v2-3-4789639b28f1@se.com>
References: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
In-Reply-To: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773099103; l=5399;
 i=pascal.eberhard@se.com; s=20260304; h=from:subject:message-id;
 bh=IFaMueW2762ELu2lI2L6fxbF1Qag0z/rfsvviir0rz4=;
 b=mAXuBqPboTozSC7lnXNsTUZIv3gEZXE3VRXB86cOtqb6sJVRqr3xlTrbJI8J9LLeAgoUMwE4/
 nqvyNm2RLeQDQzJnGCIEF1mOvUA+Ruv4xIk8iYJdfSd7cySe/L6d5qP
X-Developer-Key: i=pascal.eberhard@se.com; a=ed25519;
 pk=J7TbFctjt1RVuN5K0juhf/w1E9bAfSeoQ/JG1vV9mWg=
X-Endpoint-Received: by B4 Relay for pascal.eberhard@se.com/20260304 with
 auth_id=661
X-Original-From: Pascal Eberhard <pascal.eberhard@se.com>
Reply-To: pascal.eberhard@se.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 23:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19138

From: Pascal Eberhard <pascal.eberhard@se.com>

Duplicate wget fetch method test cases to test curl fetch method.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 lib/bb/tests/fetch.py | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 74eb73472..72257a130 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -28,6 +28,10 @@ def skipIfNoNetwork():
         return unittest.skip("network test")
     return lambda f: f
 
+def skipIfNoCurl():
+    if not shutil.which("curl"):
+        return unittest.skip("'curl' not found")
+    return lambda f: f
 
 @contextlib.contextmanager
 def hide_directory(directory):
@@ -1550,6 +1554,7 @@ class FetchLatestVersionTest(FetcherTest):
 
                     url = "http://127.0.0.1:%s/%s" % (port, data.path)
                     ud = bb.fetch2.FetchData(url, self.d)
+                    self.assertEqual(ud.method.__class__.__name__, "Wget")
                     pupver = ud.method.latest_versionstring(ud, self.d)
                     verstring = pupver[0]
                     self.assertTrue(verstring, msg="Could not find upstream version for %s" % data.pn)
@@ -1558,6 +1563,36 @@ class FetchLatestVersionTest(FetcherTest):
         finally:
             server.stop()
 
+    @skipIfNoCurl()
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
@@ -1590,6 +1625,7 @@ class FetchCheckStatusTest(FetcherTest):
             with self.subTest(url=u):
                 ud = fetch.ud[u]
                 m = ud.method
+                self.assertEqual(ud.method.__class__.__name__, "Wget")
                 ret = m.checkstatus(fetch, ud, self.d)
                 self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
@@ -1605,10 +1641,49 @@ class FetchCheckStatusTest(FetcherTest):
             with self.subTest(url=u):
                 ud = fetch.ud[u]
                 m = ud.method
+                self.assertEqual(ud.method.__class__.__name__, "Wget")
+                ret = m.checkstatus(fetch, ud, self.d)
+                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+
+        connection_cache.close_connections()
+
+    @skipIfNoCurl()
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
+    @skipIfNoCurl()
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



