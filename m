Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.198405.1598284127975146182
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 08:48:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=KPbs9HnE;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id y65so55560qtd.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOkF8reEWm+EellrMzVk4YWqMMPo7fXJIwspy2NPTVk=;
        b=KPbs9HnEGVwiFVGJnFKllvvKhrm6pY/IdifQRm2Dq35slG1wY6kM1XLXkl1YiQ8tcr
         teesN4akNriR6WyqH1smxHjWn5aKzlOalC7VmA+xj+5YzkrKJJpFwPtTtzmZnJq0gbAm
         LIU1FKALRf6TpRVvIpKEiv4DAryHFKFWf6cc2LL8r4o3UFkKq9iRu4x43V9N2KzhYPQS
         7wQ6BlbxUQSNaF5WoU05gKu28exQUacKaqrbPw/8m0ILTTY6YGIgTFYi6hEU79xZ6/hc
         X13fk8bSc9PO2lxMwXlng2Pu7Fi4FLeK2mRDeHKLdYwAxyvnEDScH/uBJaej8H3y9buM
         CR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOkF8reEWm+EellrMzVk4YWqMMPo7fXJIwspy2NPTVk=;
        b=ZCPfjuC8wXp7T7X81lYayCf5hMf82H7Z5fo4l2QKrbqdBalPUcXxxEHJ31MfilTryk
         5bN1oIpofVk7n+2cqfUnzO0EfqvRrIPU4XN8fzd5of3tkgZsufvMqmEKnSsNBdoKZIbz
         EsnwWH/ZLt2M74A3icE+8xnUPdyer5mRaEV2cHjcSAWtvyp2A0VgbpZv58DtgbajE+uD
         JmLG4FtGbBkRgMAG7LA3I7xQ/tfEYr/djNpRIySkqvJcw39qegSAZMirLmnfw9oKapd4
         EFOr24qmvPsPVYI625bYPX9poz+IVkYjag0uCMM0T5jYYFZVt8RDZ2IgwdfRwjMj7y0T
         oniA==
X-Gm-Message-State: AOAM533Jg0z3b9ZhjIgLiiU2+5HnhZB6WiD4BpRwoIseystr1zGUfu0w
	6+IHvxekFdabjvsJriq3+5rlLLBwzRRRMw==
X-Google-Smtp-Source: ABdhPJyestzy0hwjyfkSSksHCQu3Zw4a9AJ2TL29zdmAb385iHTela6IGO1bYYtQVc1OdzQVCmDcvw==
X-Received: by 2002:aed:31a3:: with SMTP id 32mr5329481qth.46.1598284126886;
        Mon, 24 Aug 2020 08:48:46 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id x13sm11116119qts.23.2020.08.24.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:48:45 -0700 (PDT)
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] bitbake: tests/siggen: introduce clean_basepath testcases
Date: Mon, 24 Aug 2020 11:48:35 -0400
Message-Id: <20200824154836.23600-1-jeff.dagenais@gmail.com>
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

