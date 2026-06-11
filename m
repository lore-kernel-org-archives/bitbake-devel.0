Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6CECD98CE
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:55 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45178.1781183513293881046
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=cHh11Mc5;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46013161068so4014322f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183512; x=1781788312; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0l5raLZI/cTBQPEQqb5ISjnvVLvXFrYmIo76D6Huhg=;
        b=cHh11Mc5dSr6qcflV66CIai1aqybokwVGx03p9pQz69kbptI4ob1yT1O/Yv37glyyR
         yC5gDgIZc5b3jXJN9Zi9fCPbjmXC+6QC+7Ewc56gp74vcI/4WvVJ/2rG7iAz1UGptG1/
         Dczp+MbZZMTT4+3Pm7VKkK/sVDika5ZIuW0NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183512; x=1781788312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/0l5raLZI/cTBQPEQqb5ISjnvVLvXFrYmIo76D6Huhg=;
        b=Wh/gn050/WxuX28+wMtumlbSbDeMG0yUbgmtDfNJg8pBQOUWSPqx0W3cqwOP3nbjhA
         JdHe+NCaVcISnzjvX/laqXf8BZyBaSHEqoIm7qjaqhC76gG81Me0SbadyzZhGQ/fFDcy
         iNfyvcIYOL/j6HXzzWq/3vFjtBbWuisT7hFnyS/m/0XLME2qkg5ECPo/PjJo1m/uLOZU
         1s5hW5JDXpzQmArD1m4zzqzd/i4HPVXhCmldLgl0G6irkEZykCxxAqp7+yNqD8BPZgmJ
         uKxlFTjRIo1OahlWPxB6BB0KP0fHborbiyyn9bUd2E8lmFLQyQ29qvo0LnqVFjkDprYW
         88+A==
X-Gm-Message-State: AOJu0YzwAtCpmUx8fCYHvw6yS69/rQGPHj/b1VA/GDEI5+1qaZXQzLqn
	19I/n5WZm2gb6ReJ2OqO/c1eK76nD064EyxuPICNw9fgleRRueJfgtB0COw6PCmxWeU+azG4OM9
	jY0jy
X-Gm-Gg: Acq92OFPeK6AafuHvZjdwZFIsv8eEInfNJkuHbLjy86uBc8SxlSe7BdTPKNxIzlpQtF
	X1x74uI/ZPMycA0U3+hVvuDKOQse7Om1WxUL9/aDkVAiXSUTysvnhslt7r6qSbXfxjmsDJBnDnC
	X/Pmn1X/tDae8VnTOGYOb6psgw9k29V9sWOkw+Vr+ZopA/t5hA5MhozzyDt9+5Myk+kbMUloiwV
	gTJrDe6yUXbQUv7yQsi6XQNxIVq7fGrgpYltgFQ6+GB5zXDzfpoxQpy8n/RQRwtOnFbYLPVMSEa
	Ex72cEZBsmUG2c01pvgd/MaFjaoZEqcn1K3+LVsC6XhC6wwC9TR08xmmxYV8qqsPRctGRGuQVu/
	Nn/c8Pa9aQCCgpyn+jbRlbjRdaYB5bLv7I84BdFNOIuC53ZXTdbKm2n4I7COAjQEAwcKhoGEYnF
	oiEXyWKVVPaHVX5LV+5Zh+pBeVrJLaI6+FD/mG8P743ZI72MVydtJexUNCM4bcivW3EwicgOy7Z
	cgd1/r+Kq4erlOA5fUflz6sP6ST2W5JCpMs2xw=
X-Received: by 2002:a05:6000:1104:b0:460:ff2:63e5 with SMTP id ffacd0b85a97d-460675a61d1mr3647578f8f.18.1781183511623;
        Thu, 11 Jun 2026 06:11:51 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:51 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 8/8] tests/fetch: cover checkstatus redirect auth handling
Date: Thu, 11 Jun 2026 15:11:30 +0200
Message-ID: <acfe02fa38b5da9e6a36c6cedcf91d4fcbefbfbd.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19668

From: Anders Heimer <anders.heimer@est.tech>

Add local HTTP server tests for Wget.checkstatus() redirects. They check
that Authorization is kept for same-origin redirects and dropped when the
target has a different origin.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c687d42b81b17e7a2399099cab0f1a6aafcf6520)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e661ff0d8..c071401e6 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -7,6 +7,7 @@
 #
 
 import contextlib
+import http.server
 import shutil
 import unittest
 import unittest.mock
@@ -18,6 +19,7 @@ import os
 import signal
 import subprocess
 import tarfile
+import threading
 from bb.fetch2 import URI
 import bb
 import bb.utils
@@ -1643,6 +1645,41 @@ class FetchCheckStatusTest(FetcherTest):
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
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
@@ -1670,6 +1707,31 @@ class FetchCheckStatusTest(FetcherTest):
 
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

