Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web11.14281.1600868802763796147
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2020 06:46:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=nk2Rkf4Z;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id b2so18633255qtp.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2020 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOkF8reEWm+EellrMzVk4YWqMMPo7fXJIwspy2NPTVk=;
        b=nk2Rkf4ZH74ZsthwIqPp3BewI5EyqpMXNF120M+eT16dp97ZekfnLvSJsxvNgi5eTZ
         1jbP55FBbR18Pgr057yIzC5U6vKPUfhbPwm7SPxFLCtXAb+CEybP9KzXsbvJsukAl21w
         uV+cYy2wFoVYHzLX8kDkvwCzA4Vfnc9pPzQbzaFvlHTdWMIDHOxxlb1iJWUyV9G7o7vL
         KV5DApmUR8MF5jnsJzp1pYusEF5uO28W1Eqi/qwUJ9Vb8BgRDtPnjLojoOtTqe/x58GA
         WczV2ztUSVDWCYVfxfoEcHtGtHW9dx/VTvGxe+kPR7N1UKSRiGMhDaF/Rww25tsI3W1F
         i+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOkF8reEWm+EellrMzVk4YWqMMPo7fXJIwspy2NPTVk=;
        b=k4QuPP/PMO/nrbfMVGmPhmXdtliA02uPPVAo00ZKjkk/t8fOUxTH1UjkYGznZRD1DV
         zhhtblEi53EqpeWU2cEyWEaFOgPkXDpzf3UVyr5puhLQk9WI/lZ2hv8VYcEU82PtExck
         wfw/BiBKmAdAEgfLEayEX+bvQHUtgtWl7a6u+kEHuUbp1iDzOf6KOkV/43oy/FANwa3N
         N97WKpRpig0CjL7uzyRvNuV0QmokaExvsRf54tNxjd2iwEHQjVRxr7H1LjQnOHda2xLB
         AApxT1Oy8J0zx7jCSdKd6TH90h/LYGbLCk1Vp4NtHwcWnjTlNcx/YuyRBlL48fh2+f9O
         cYYA==
X-Gm-Message-State: AOAM530L5Pnq8gWLzFNO3BdSoxwKaQWeFm0kG2h5hM0k4TEwGiQk2iN4
	Sp6IWMZRqTRzhgjtVKV2RE2/gdZ7W44Tag==
X-Google-Smtp-Source: ABdhPJyoPRLaei/cGH9pRNrxOvftexoeAvJHH6hwn0BLXTwKQJA8deYNZjU8xXrNho5k3Y8+kjJJ7w==
X-Received: by 2002:ac8:7388:: with SMTP id t8mr33811qtp.187.1600868801547;
        Wed, 23 Sep 2020 06:46:41 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id z7sm4948885qtc.10.2020.09.23.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 06:46:40 -0700 (PDT)
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] bitbake: tests/siggen: introduce clean_basepath testcases
Date: Wed, 23 Sep 2020 09:44:05 -0400
Message-Id: <20200923134406.19362-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
References: <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While discussing with Richard we thought these might help document
and safeguard the basic requirements of clean_basepath.

A 'bonus' performance testcase is added but commented out since its
runtime is long and test machine specific. It is intended for developers
to test before and after their changes to the target function as a due
diligence verification.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 bin/bitbake-selftest   |  1 +
 lib/bb/tests/siggen.py | 91 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 lib/bb/tests/siggen.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index e84d6a55..6c073741 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -27,6 +27,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.parse",
          "bb.tests.persist_data",
          "bb.tests.runqueue",
+         "bb.tests.siggen",
          "bb.tests.utils",
          "hashserv.tests",
          "layerindexlib.tests.layerindexobj",
diff --git a/lib/bb/tests/siggen.py b/lib/bb/tests/siggen.py
new file mode 100644
index 00000000..c21ab4e4
--- /dev/null
+++ b/lib/bb/tests/siggen.py
@@ -0,0 +1,91 @@
+#
+# BitBake Test for lib/bb/siggen.py
+#
+# Copyright (C) 2020 Jean-François Dagenais
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import unittest
+import logging
+import bb
+import time
+
+logger = logging.getLogger('BitBake.TestSiggen')
+
+import bb.siggen
+
+class SiggenTest(unittest.TestCase):
+
+    def test_clean_basepath_simple_target_basepath(self):
+        basepath = '/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
+        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask'
+
+        actual_cleaned = bb.siggen.clean_basepath(basepath)
+
+        self.assertEqual(actual_cleaned, expected_cleaned)
+
+    def test_clean_basepath_basic_virtual_basepath(self):
+        basepath = 'virtual:something:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
+        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something'
+
+        actual_cleaned = bb.siggen.clean_basepath(basepath)
+
+        self.assertEqual(actual_cleaned, expected_cleaned)
+
+    def test_clean_basepath_mc_basepath(self):
+        basepath = 'mc:somemachine:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
+        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:mc:somemachine'
+
+        actual_cleaned = bb.siggen.clean_basepath(basepath)
+
+        self.assertEqual(actual_cleaned, expected_cleaned)
+
+    def test_clean_basepath_virtual_long_prefix_basepath(self):
+        basepath = 'virtual:something:A:B:C:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
+        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something:A:B:C'
+
+        actual_cleaned = bb.siggen.clean_basepath(basepath)
+
+        self.assertEqual(actual_cleaned, expected_cleaned)
+
+    def test_clean_basepath_mc_virtual_basepath(self):
+        basepath = 'mc:somemachine:virtual:something:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
+        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something:mc:somemachine'
+
+        actual_cleaned = bb.siggen.clean_basepath(basepath)
+
+        self.assertEqual(actual_cleaned, expected_cleaned)
+
+    def test_clean_basepath_mc_virtual_long_prefix_basepath(self):
+        basepath = 'mc:X:virtual:something:C:B:A:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask'
+        expected_cleaned = 'helloworld/helloworld_1.2.3.bb:do_sometask:virtual:something:C:B:A:mc:X'
+
+        actual_cleaned = bb.siggen.clean_basepath(basepath)
+
+        self.assertEqual(actual_cleaned, expected_cleaned)
+
+
+    # def test_clean_basepath_performance(self):
+    #     input_basepaths = [
+    #         'mc:X:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
+    #         'mc:X:virtual:something:C:B:A:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
+    #         'virtual:something:C:B:A:/different/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
+    #         'virtual:something:A:/full/path/to/poky/meta/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
+    #         '/this/is/most/common/input/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
+    #         '/and/should/be/tested/with/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
+    #         '/more/weight/recipes-whatever/helloworld/helloworld_1.2.3.bb:do_sometask',
+    #     ]
+
+    #     time_start = time.time()
+
+    #     i = 2000000
+    #     while i >= 0:
+    #         for basepath in input_basepaths:
+    #             bb.siggen.clean_basepath(basepath)
+    #         i -= 1
+
+    #     elapsed = time.time() - time_start
+    #     print('{} ({}s)'.format(self.id(), round(elapsed, 3)))
+
+    #     self.assertTrue(False)
-- 
2.28.0

