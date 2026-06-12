Return-Path: <jeremy.rosen@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3236CD98D9
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 14:29:20 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71951.1781274552151735214
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 07:29:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=QxbJ/kQ9;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: jeremy.rosen@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b613a17bso8910365e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781274550; x=1781879350; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxXfmKyiKwMecIuDtnNUR2rWw6Xn5R6tltb5jVh11RU=;
        b=QxbJ/kQ98MeVyiHJ3Jl46k/w3eZtibJhCNwTtXmvoV7ZXiqgkNksnT/xxcwPvN/ANd
         XdhhVH0z9Bi737kDA2TH3PtvvVFKZ5sYkqTERWUdlnkdxTbma5gPzPO7xolkU6YK0M2i
         YLC3NdXpQXH0mdrQt59svdNgfD6u/+bFetVY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274550; x=1781879350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pxXfmKyiKwMecIuDtnNUR2rWw6Xn5R6tltb5jVh11RU=;
        b=dymg6KrOXfvEiPZi/bnFsW6YtI6fvhRIKehpXR5CzVwA8TyE9wWh6V8pGYcgPK4HDr
         1RG6YHcGoxX52Ys9agGk8Kg3dnJAuRTpPd730gq7nrIFMaqxvyidUN0tiD9cPkuFyHag
         OHECIeaTsSsXsdpA5XOWdcHgJ2kCxHfvGf4cMGFf9Ov0f8xlCI4DiTSWj3FbpLkTdF8X
         ueMdpOqS2ksBaHU/XdKOx/Dl4aaiv4xYw8yu4cvyuL1jUQViHtdmVP0UpQCBWyahHIz9
         wMw1kTzXFUliEEaSzmqgIcUeVhnlk5coT2YE9VQ+Nfwt5CZENsaewPQLPvPwaA21O0Sh
         THgA==
X-Gm-Message-State: AOJu0Yyk0iFFxNvFoM5zaOwfQdBJz0wY5lcov9RBI4Fle85fFFnbqLHD
	BcoD5uMVvirTUE2Fd/wZ5IqRX273Q7dsbhs9A2UWXlkvKcPmTYvPgCpgk7Dnbzqqw7Dwgzl6UY5
	voQ9r1Q==
X-Gm-Gg: Acq92OH6iC7ORH4YZkqw30FMil0QgT0V+sUW9oDIESidAkWYWibqNAV07b3QbLQz6X0
	oNqe8soSuj32H7w0GmD/IVr7UXaqa2Yec+8S4V7TjUC+q3z6MyuMJi/hXyiQlvVqUJ5GTrsHVCv
	MvMgOMPViUCiNT+YnllAp+07nBO2vUsCfuqmktB0jQOG39qW5z1m6+owuuZQmsWNNAIHXxi6Y4v
	65XwAHRde3eBjCL/OXTOhL3CgVGvgZzfS2mmTdySlrtltqkxGbKa11nqET/sa6ZeKU5L9aWLst+
	cnAj+gen855l213d4lHzlUqXQJylRB+Z1120r21vxoZkXN5/ShfdDCzZVpvIXmftDJpV3XweA66
	WXTPA+JGo8X/TOGcu6OgIlta/xqRgEJinwKBXtgJawVlIImb4EOPQzBGAdsDVHmNok0JYZhyU5l
	VDw4mTJZrJ00P36gcZEsfHL6TEjLRtoYiCTQ==
X-Received: by 2002:a05:600c:820c:b0:490:e913:6564 with SMTP id 5b1f17b1804b1-490ec4cc6d8mr42421675e9.3.1781274550471;
        Fri, 12 Jun 2026 07:29:10 -0700 (PDT)
Received: from Logrus.lan ([2001:861:560f:240:8dd0:2c2:7492:641b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea8123e1sm74072065e9.0.2026.06.12.07.29.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:29:10 -0700 (PDT)
From: Jeremy Rosen <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/4] tests/fetch: cover checkstatus redirect auth handling
Date: Fri, 12 Jun 2026 16:29:02 +0200
Message-ID: <2b0f7fb5f54a415d851038ba7cb836b18289e000.1781271084.git.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781271084.git.jeremy.rosen@smile.fr>
References: <cover.1781271084.git.jeremy.rosen@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 14:29:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19678

From: Anders Heimer <anders.heimer@est.tech>

Add local HTTP server tests for Wget.checkstatus() redirects. They check
that Authorization is kept for same-origin redirects and dropped when the
target has a different origin.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c687d42b81b17e7a2399099cab0f1a6aafcf6520)
Signed-off-by: Jeremy Rosen <jeremy.rosen@smile.fr>
---
 lib/bb/tests/fetch.py | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 2d95ef87d..a658b89a8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -7,6 +7,7 @@
 #
 
 import contextlib
+import http.server
 import shutil
 import unittest
 import hashlib
@@ -16,6 +17,7 @@ import os
 import signal
 import subprocess
 import tarfile
+import threading
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
 import bb
@@ -1610,6 +1612,41 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
 
+    def _start_checkstatus_server(self):
+        class CheckStatusHTTPRequestHandler(http.server.BaseHTTPRequestHandler):
+            def do_HEAD(self):
+                self.server.requests.append((self.path, dict(self.headers)))
+                if self.path == "/a" and self.server.redirect_url:
+                    self.send_response(302)
+                    self.send_header("Location", self.server.redirect_url)
+                    self.end_headers()
+                    return
+                self.send_response(200)
+                self.end_headers()
+
+            def log_message(self, format_str, *args):
+                pass
+
+        server = http.server.HTTPServer(("127.0.0.1", 0), CheckStatusHTTPRequestHandler)
+        server.redirect_url = None
+        server.requests = []
+        thread = threading.Thread(target=server.serve_forever, kwargs={"poll_interval": 0.05})
+        thread.daemon = True
+        thread.start()
+
+        def stop_server():
+            server.shutdown()
+            thread.join()
+            server.server_close()
+
+        self.addCleanup(stop_server)
+        return server
+
+    def _checkstatus(self, url):
+        fetch = bb.fetch2.Fetch([url], self.d)
+        ud = fetch.ud[url]
+        return ud.method.checkstatus(fetch, ud, self.d)
+
     @skipIfNoNetwork()
     def test_wget_checkstatus(self):
         fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d)
@@ -1637,6 +1674,31 @@ class FetchCheckStatusTest(FetcherTest):
 
         connection_cache.close_connections()
 
+    def test_wget_checkstatus_same_origin_redirect_keeps_auth(self):
+        server = self._start_checkstatus_server()
+        server.redirect_url = "http://127.0.0.1:%s/b" % server.server_port
+
+        url = "http://127.0.0.1:%s/a;user=user;pswd=pass" % server.server_port
+        self.assertTrue(self._checkstatus(url))
+
+        self.assertEqual(len(server.requests), 2)
+        redirected_headers = {k.lower(): v for k, v in server.requests[1][1].items()}
+        self.assertIn("authorization", redirected_headers)
+
+    def test_wget_checkstatus_different_origin_redirect_drops_auth(self):
+        origin = self._start_checkstatus_server()
+        target = self._start_checkstatus_server()
+        # Same host but different port is a different origin.
+        origin.redirect_url = "http://127.0.0.1:%s/b" % target.server_port
+
+        url = "http://127.0.0.1:%s/a;user=user;pswd=pass" % origin.server_port
+        self.assertTrue(self._checkstatus(url))
+
+        self.assertEqual(len(origin.requests), 1)
+        self.assertEqual(len(target.requests), 1)
+        redirected_headers = {k.lower(): v for k, v in target.requests[0][1].items()}
+        self.assertNotIn("authorization", redirected_headers)
+
 
 class GitMakeShallowTest(FetcherTest):
     def setUp(self):
-- 
2.53.0


