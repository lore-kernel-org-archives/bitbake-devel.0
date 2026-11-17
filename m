Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88.1794929011527185257
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 07:23:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=jEZQ2CxM;
 spf=pass (domain: gmail.com, ip: 209.85.221.173, mailfrom: maxime.roussinbelanger@gmail.com)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ee3e658c70so1094723e0c.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 07:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794929010; x=1795533810; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiF1Aiyox/FIumf2y57MGnBc5mfS5ImVB1zFyz4xOEE=;
        b=jEZQ2CxMMGRdEZUQRSdqGBM13RZ5IZkjAO+jNXus23q2a+mSIZQ4KneyegmFJo/I9W
         j7eA/oVbq+b+nYvwOunKc/+L3/lox1iJNXkioMwUSycdzug1t2AUp4sPtIFp6UdvjyVZ
         kaUZxrjVYlUvbM92iNs55QDwzqgZbNQlI7F9NGrK7K79JIRln4QWroWflluvMjkdO6h+
         QIPjuDh9tzuscnH9DumCM0xYDKTRKvNem2MkmHxPEnXzDXKisr1wZAbLox8fo4TUVQTb
         Oeo9S2UaneSyuePaDwFwHZRC8MdLWjwaKsrESeyFKjRk71fLNvMVPtP0EkC7NHCO7TzM
         tgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794929010; x=1795533810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiF1Aiyox/FIumf2y57MGnBc5mfS5ImVB1zFyz4xOEE=;
        b=FUZid9zhfLHPuWU3oPFoqFPFUhvn71W4ab1YJ3VpZ2NX5rxrHZ5VYncl+S4gcSnUZj
         fcQQ/mH2jUaN5HeM3sKx5XE+I1sy5UIm0He4SNmbPZPFcM3pSETCNeBTN96H2kFOJxDY
         THpzTBTVz3TST2Qe6L+RUeJpXvbol9vGdxN/FUL783Hpx2a6/Ro+gOThp+z3bBlFpwBY
         v2cpPA4aTgowzVEyfmGnT5tC/zvrT80hZ83ZTMVmJev/KNvc7RQLhbe3EN0Iq2bqmFjr
         NKR61+WGlcv9XUnNbfSjbVWign5MDFXfq13u3kp79k1IDac+Z4Nj6PZa8wWtonqYXG9V
         nELQ==
X-Gm-Message-State: APuU4Z/sU0Guqf9HrhMnLiWFEHiy9B7jqRYx/VF0t72EdYBDgeDHrZ+m
	hb0fL9HG3KEJdpW7wSGDYq+mLHf7fjDfYcKHbqmDQOJbwcrE9mmvnwqSKQBDxQ==
X-Gm-Gg: AYBFou2UF71DhYTkU3+gbIhpPiiKm/YDXR5jlj7yLbzWhJoSoQp1wKP3Ipi7yBRvmIQ
	T5nbuajvbl6wGt54DSdJotg03fWcyy37PshD2xscYL1+jCv69ZJNSzlc39DcgW3kvcG6DogeG7I
	HaPWUxd6PJNVu12or6uvHthqgh2GKMCOSeE1HEXCWaLkevHk8IIgBAhVqxM0IriON9p2Doy8tON
	/ZBpUClAYucDqov7IhfZeKxlhi7/3pac6K6dxGDKqUBx4bHCDAmJfPGPEQbIShQEkuao0BfvuhH
	xCcA9bRc/cV1uvtpi2M88fRsMbIbePFlahPXTfQvrgJsP41Ij5M+LElxJkuXN+jiUZ7dQNxZcDJ
	3b/AT7tuerIiggMUk+g90fd6/GUBKCk3qO4cdpqUu0rJaTyMO2y9oXtOeCCw7yn/bRwvRI2CCzP
	blK42v+SgxqbdktkO0LFQ5lZJb4I9E83/ePmnp/8vzBVHbtrP+bOJDzY1W9v9G2dH0dfdys85Ff
	uJzaKDnX21ZclfS3yvOqGMGyXMAqntBf/lxmX8NUeEgVie8k07kJJdQVnX2mPkLuvFg1+xzOzdJ
	B6B6uFhwrSNKk/bWWt1kuKTIsmBYpPEYUARt60CgMsrDdF5YDCkDZ9855sm+4x5yT/T/gTadzh/
	tCyCteU+6CfB82g==
X-Received: by 2002:a05:6122:551:b0:5ec:c162:d58c with SMTP id 71dfb90a1353d-5ee34a7cd91mr4981763e0c.9.1794929010242;
        Tue, 17 Nov 2026 07:23:30 -0800 (PST)
Return-Path: <maxime.roussinbelanger@gmail.com>
Received: from mbelap.can-explore.com ([70.54.251.90])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e3255fsm9190420e0c.4.2026.11.17.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 07:23:29 -0800 (PST)
From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: [PATCH] utils: Make set_context() replace the global context
Date: Tue, 17 Nov 2026 10:23:18 -0500
Message-ID: <20261117152318.2560775-1-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 15:23:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20449
Content-Type: text/plain; charset="utf-8"

set_context() assigns to a local name, so the global context is never
replaced and keeps everything added to it. This has been the case since
commit 6c3281a14012 ("cooker/cookerdata/utils: Improve context
management") replaced a direct assignment to bb.utils._context with it,
which broke the two resets that rely on it:

- Parser.parse() resets the context before each recipe, so a parser
  process accumulates the Python functions of every recipe it parsed
  before. A recipe calling a function from a class it does not inherit
  parses or fails depending on which process it lands in.
- CookerDataBuilder.__init__() resets the context when the
  configuration is parsed again, so a long-lived server keeps the
  functions and modules of the previous configuration.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
---
 lib/bb/tests/utils.py | 22 ++++++++++++++++++++++
 lib/bb/utils.py       |  1 +
 2 files changed, 23 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 0c3360505..796f8398d 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -729,3 +729,25 @@ class SplitFileChecksums(unittest.TestCase):
         self.check("/a:Truex /b:False", ["/a:Truex /b:False"])
         self.check(":True :False", [":True", ":False"])
         self.check("/a:True:False /b:False", ["/a:True:False", "/b:False"])
+
+class ContextTests(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.context = bb.utils.get_context().copy()
+
+    def tearDown(self):
+        # Not set_context(), so a broken setter cannot leak into other tests.
+        bb.utils._context = self.context
+
+    def test_set_context(self):
+        context = bb.utils.clean_context()
+        bb.utils.set_context(context)
+        self.assertIs(bb.utils.get_context(), context)
+
+    def test_set_context_drops_methods(self):
+        bb.methodpool.insert_method("testfunc", "def testfunc(d):\n    return 'testvalue'\n", "test.bb", 1)
+        self.assertEqual(self.d.expand("${@testfunc(d)}"), "testvalue")
+
+        bb.utils.set_context(self.context.copy())
+        self.assertNotIn("testfunc", bb.utils.get_context())
+        self.assertRaises(bb.data_smart.ExpansionError, self.d.expand, "${@testfunc(d)}")
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0e2677f8e..78cb683b1 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -52,6 +52,7 @@ def get_context():
 
 
 def set_context(ctx):
+    global _context
     _context = ctx
 
 # Context used in better_exec, eval
-- 
2.56.1

