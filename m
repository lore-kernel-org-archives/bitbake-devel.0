Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2601.1794947841120808722
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 12:37:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=ZsevHd5A;
 spf=pass (domain: gmail.com, ip: 209.85.221.169, mailfrom: maxime.roussinbelanger@gmail.com)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ee3a3d281fso113971e0c.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 12:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794947840; x=1795552640; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8WMs6h4ULWJ5Ek9sophqgwSdukyJ4FBvPaS3EkllLlE=;
        b=ZsevHd5AoudhV7v+HO8ExaiHwkRgWJftyqWrKmTdSYYz5a5k9cCMDekrbrxpZlTf6Q
         euKWcu4u2GpFipQ5OLs1KN/O+zNOlh35AvTQ/GgkToRWZLWxa48JE2mOSGEanNLxjd1S
         wkMcwrda5HxCjmQEVyDqhXYHXDIXzjL5RXaY1bn5q9mxd59e9yKKgbCYkDtnPChbmSDn
         KKbsjZocAYmdGo4YqV9irMOpv5HB0MqH3Wpd6OC82TF1r+9pmqibaa3pyIAhaoQGN/cW
         ukjBYUsTjxy1TUrpjkJKCxo394l5V0/j3+K4UVU9SV8O2R5/92unKDlFXluQlleTT4rA
         Y9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947840; x=1795552640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8WMs6h4ULWJ5Ek9sophqgwSdukyJ4FBvPaS3EkllLlE=;
        b=U9i21eG9wOGH7gq5BMTmcWwfCnfiLzwB5Hk0D4eoeXg8C+Ebw0M6Jn4TVGnl6BP64V
         qxOkuXsoSKj5ElGckqLpKhW+maU04aJAmOz81ddcMmS0Bmhs3oTQ56lYGsb084x7jv+x
         0I4/y082ABhekm0r6/D/ihh1MhWqmUV8RNiG0PX62pE3hMRrimX1q+szAbJcJL3G1ysJ
         hPY63jzUSMFAXdNx5npd6V1l0L2JOcz1jnldtQOwM6Z/5LRo+doCcZ+ut5K3Z4AX2MBD
         lrrBPg4dW8FGireWZPHp2U52Ir7nhdIlywqbSgaI90+/h+m/TvAKeSelQ4oYJO4g1j1o
         2WNQ==
X-Gm-Message-State: APuU4Z/VX1ci5pS/2QAQV+d5K5+DjfXakCiA1RZvtCiaPJO2OkK1RTnq
	rcj+kUE+j1O1zqt2jpxBPzKGFoka1B1hvJNGERYyR57/kcuYr1QZ0fGzutbpew==
X-Gm-Gg: AYBFou3AZ6AucITW3UMbA/h/5q6SwPiYgN+vUzCifOqbxtXGk9FOKdPuAKZ5o2OYQ9U
	abp/reUcyteR9m5FB8dfvVs72xQ/lZc8+47S3pSLOJn9HeGExkMVlQa1bc3vYTs0NN+ogcjeHGU
	LxnDNpWVXn1MnwBCqK0tPBjj3sMPcHYIOUPbN7IeEsBt7Oxy7aX3rc8H54WaajGkvAQyM18ww+n
	QI/r03BR1Fp7RYnmKstxHYvv4WAfjRqR5JyzubnjTMvYayjezA085gkL/9v1KlWaMEFZiprBFvM
	Wk/8ztyG/Bz2H2OO3w08jDqiQ7gcOWf0HLw9BObfQzmSankNzyhuI+3nYtD8+HBXDmUzfdpiG0v
	oXNqqm9Gr1zN0rzqjKy1TrYaC81AWRQpF+tWBNknk/vDCbytbOziWQRBcNoK5u4hxTwbebEqG18
	RYN6HUqfeJ6zOJktzJxEIxQAnd9sSlEUprVx4CqTEc211aJB1B1Eu8RZcjLMDbVc5GPY3tKaw4l
	8/R7zyTtbGunac9O2MwKtMgMCIIdrxUObdADfwBolW0LdxSN1AENFdEVHXB/sF1oz6aDqk4KEH1
	YDXpDxkaHkAOIK453STL/5YWMQWFC4jw9CTLRrzjHOB8sujJTv4EEwfbkB1G1OL3g6uFn90hjOd
	tfNqXny04hR7JJg==
X-Received: by 2002:a05:6122:4d08:b0:5ea:c3bc:c567 with SMTP id 71dfb90a1353d-5ee646c6085mr433229e0c.9.1794947839926;
        Tue, 17 Nov 2026 12:37:19 -0800 (PST)
Return-Path: <maxime.roussinbelanger@gmail.com>
Received: from mbelap.can-explore.com ([70.54.251.90])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64ed7adesm342572e0c.15.2026.11.17.12.37.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:37:18 -0800 (PST)
From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 2/2] utils: Make set_context() replace the global context
Date: Tue, 17 Nov 2026 15:37:16 -0500
Message-ID: <20261117203716.3276852-2-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117203716.3276852-1-maxime.roussinbelanger@gmail.com>
References: <20261117152318.2560775-1-maxime.roussinbelanger@gmail.com>
 <20261117203716.3276852-1-maxime.roussinbelanger@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 20:37:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20453
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
Changes in v2:
- Run ContextTests on a clean context instead of a copy of the global one,
  which already held testfunc when bb.tests.data ran first in the same
  process (autobuilder failure reported on v1).
- New patch 1/2 stops bb.tests.data leaking testfunc into the global
  context.

 lib/bb/tests/utils.py | 23 +++++++++++++++++++++++
 lib/bb/utils.py       |  1 +
 2 files changed, 24 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 0c3360505..4dd643e56 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -729,3 +729,26 @@ class SplitFileChecksums(unittest.TestCase):
         self.check("/a:Truex /b:False", ["/a:Truex /b:False"])
         self.check(":True :False", [":True", ":False"])
         self.check("/a:True:False /b:False", ["/a:True:False", "/b:False"])
+
+class ContextTests(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        # Not set_context(), so a broken setter cannot leak into other tests.
+        self.saved_context = bb.utils._context
+        bb.utils._context = bb.utils.clean_context()
+
+    def tearDown(self):
+        bb.utils._context = self.saved_context
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
+        bb.utils.set_context(bb.utils.clean_context())
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

