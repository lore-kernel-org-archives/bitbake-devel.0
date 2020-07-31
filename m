Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.82])
 by mx.groups.io with SMTP id smtpd.web10.21214.1596210212670518688
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2020 08:43:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=f0HNLkvq;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.82, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqzpeVzIYxItc9j48nwG42eycl8qBGSTLCj70MXT126WjsqK2NkNrEFaQXskoqZWXv3FobM1xq0rY6o+AxVcoDKvdaZQxI2DxXIDdfyB37WJtieHm2JY7ZhqzguTYQoXX6D3f0sRGcAJI8zCgMD3oCMteaxdl+GeuLlDfvd6B1xR510DIJpkYi2BK5KlNz2iTIBYdrCFXTWur/fBIC/I5bLtJCAU0bqbuWZXvmeFaXMKtfeAGqU+FQx6Z90hTXjL/NjUAmbvZX9+oe2rMzdKPaw1rg2AsCo8Mn5VP4FwwT2j4QygfkPFK5bi9gJ6cKkdXFz0wdiV8saSnlPLSaIbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beZhMWFPrb7+vV4ewGVnSKC0ZgZam5JjlisGpWEiysc=;
 b=mdoM+f4p1ATPYnAlGGymkdIWYMpXspIlk5WMB5A9yrKRnJy3muBHZm98/RMMhYspBcBRLa+M4ySDWqPtW3IAyxIXUr2n/pnAyiuYOjkd/Ly2lchychteo0LPyTQionGnen8GgqDrs5kKEhRcTUocFYQ5+bbHZJEuoW7sF4r7UTnIiN+qrFI4QWqpxLJAjlkL1Kw33qm/KFWGRjqEZC0Mvy6hwJCURcXYgZoOOkYvnHdTxaKBKt/nKR9UWSl0Bw8chH97yCpGrk6J6kMoMlqirEWrK+FZD3uI+y+d4QztUKTA2y0bC/ZkIe9pcP89Qke3yJbKpLIJuzCZVjZlhfdeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beZhMWFPrb7+vV4ewGVnSKC0ZgZam5JjlisGpWEiysc=;
 b=f0HNLkvqojZjB8Du8ipVpqDppemMqVVQcTngsG2jSMAdRo7nqXfyojuXtxUcxv+HtZx67Yh/NftD24GWhRjdSHpR1iy3CV3Wnhv9reAtCjD9AKZ+LoyPebdNqd8BVaQc5tcwal7JzWpLwaTOy8is+7YVGd3ZAurKgRCfUMgnZp1/PLTx7NOysfZBKK9wuWrWE7BaOW5EfAyXRnmYYIOQI7tEJrk02xacX7uIMCSNZkq6I9tT+sH6vc0fl2Hhirrd7h4fCu3ABG0/gkUbrYP+BTzbRlkQg4QbbS/K2YdKQHgd+ZaWEX1+FmbAxsFIr7PHtuS2vfHwVaSrfKSWrorZyA==
Received: from DM5PR21CA0033.namprd21.prod.outlook.com (2603:10b6:3:ed::19) by
 BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Fri, 31 Jul 2020 15:43:31 +0000
Received: from DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::af) by DM5PR21CA0033.outlook.office365.com
 (2603:10b6:3:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.2 via Frontend
 Transport; Fri, 31 Jul 2020 15:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT020.mail.protection.outlook.com (10.13.179.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Fri, 31 Jul 2020 15:43:31 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 31 Jul 2020 09:43:28 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 4/4] tests/color: add test suite for ANSI color code filtering
Date: Fri, 31 Jul 2020 11:42:49 -0400
Message-ID: <20200731154249.89999-5-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731154249.89999-1-chris.laplante@agilent.com>
References: <20200731154249.89999-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10713267-2ff6-4f67-ef80-08d835687a18
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB33509EC99A368AF0579F77998B4E0@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e9dVxhNdJbxBUblPUNJDWKCyj9V4WE7j5qYI9Gpqq5pZifqChzWqT5VaRRFIy6ZZacNKXqW96pXoa/io4ItkWve2ORmZiPrSX7tD0o3zrrnMwmq0gqXJ08KzXV88iNkK3E+/29gRIVD/EVG1x+kT5l5zbkU/bJ9LiIgVnUwBjdlnYdaMKFzbxyILfi3+RBq3TIhuJP1TBtRjztNymMhSsvnatuwIJI4iEQ5PRupkYHfcWoXEMp1VINh3wEENvblwuRhE/5CObWeSiX+QF7wxc5Y6VJe9MBlL4LVd1AzrKryr3mWOata12sWi7R6TRR+FxL0iYDwgr+1AWHahj6KfzHGXK/XpIJl7g1+WP//j15ErDzbc4xyT4ocsFLhXsgKUfuKtTRQiFkfJdWBn8ahuS4CovbblCZ66j69xa4NF+zk=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(136003)(346002)(396003)(29502001)(46966005)(8936002)(186003)(2906002)(107886003)(36756003)(4326008)(356005)(6916009)(26005)(8676002)(82310400002)(1076003)(83380400001)(86362001)(47076004)(5660300002)(70206006)(44832011)(316002)(478600001)(6666004)(36906005)(956004)(336012)(426003)(82740400003)(2616005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 15:43:31.3061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10713267-2ff6-4f67-ef80-08d835687a18
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
Content-Type: text/plain

Includes tests for bb.progress integration.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-selftest  |  1 +
 lib/bb/tests/color.py | 95 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 lib/bb/tests/color.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 041a2719..e84d6a55 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -18,6 +18,7 @@ except RuntimeError as exc:
     sys.exit(str(exc))
 
 tests = ["bb.tests.codeparser",
+         "bb.tests.color",
          "bb.tests.cooker",
          "bb.tests.cow",
          "bb.tests.data",
diff --git a/lib/bb/tests/color.py b/lib/bb/tests/color.py
new file mode 100644
index 00000000..bf03750c
--- /dev/null
+++ b/lib/bb/tests/color.py
@@ -0,0 +1,95 @@
+#
+# BitBake Test for ANSI color code filtering
+#
+# Copyright (C) 2020  Agilent Technologies, Inc.
+# Author: Chris Laplante <chris.laplante@agilent.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+import unittest
+import bb.progress
+import bb.data
+import bb.event
+from bb.progress import filter_color, filter_color_n
+import io
+import re
+
+
+class ProgressWatcher:
+    def __init__(self):
+        self._reports = []
+
+    def handle_event(self, event):
+        self._reports.append((event.progress, event.rate))
+
+    def reports(self):
+        return self._reports
+
+
+class ColorCodeTests(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self._progress_watcher = ProgressWatcher()
+        bb.event.register("bb.build.TaskProgress", self._progress_watcher.handle_event)
+
+    def tearDown(self):
+        bb.event.remove("bb.build.TaskProgress", None)
+
+    def test_filter_color(self):
+        input_string = "[01;35m[K~~~~~~~~~~~~^~~~~~~~[m[K"
+        filtered = filter_color(input_string)
+        self.assertEqual(filtered, "~~~~~~~~~~~~^~~~~~~~")
+
+    def test_filter_color_n(self):
+        input_string = "[01;35m[K~~~~~~~~~~~~^~~~~~~~[m[K"
+        filtered, code_count = filter_color_n(input_string)
+        self.assertEqual(filtered, "~~~~~~~~~~~~^~~~~~~~")
+        self.assertEqual(code_count, 4)
+
+    def test_LineFilterProgressHandler_color_filtering(self):
+        class CustomProgressHandler(bb.progress.LineFilterProgressHandler):
+            PROGRESS_REGEX = re.compile(r"Progress: (?P<progress>\d+)%")
+
+            def writeline(self, line):
+                match = self.PROGRESS_REGEX.match(line)
+                if match:
+                    self.update(int(match.group("progress")))
+                    return False
+                return True
+
+        buffer = io.StringIO()
+        handler = CustomProgressHandler(self.d, buffer)
+        handler.write("Program output!\n")
+        handler.write("More output!\n")
+        handler.write("Progress: [01;35m[K10[m[K%\n") # 10%
+        handler.write("Even more\n")
+        handler.write("[01;35m[KProgress: 50[m[K%\n") # 50%
+        handler.write("[01;35m[KProgress: 60[m[K%\n") # 60%
+        handler.write("Pro[01;35m[Kgress: [m[K100%\n") # 100%
+
+        expected = [(10, None), (50, None), (60, None), (100, None)]
+        self.assertEqual(self._progress_watcher.reports(), expected)
+
+        self.assertEqual(buffer.getvalue(), "Program output!\nMore output!\nEven more\n")
+
+    def test_BasicProgressHandler_color_filtering(self):
+        buffer = io.StringIO()
+        handler = bb.progress.BasicProgressHandler(self.d, outfile=buffer)
+        handler.write("[01;35m[K1[m[K%\n") # 1%
+        handler.write("[01;35m[K2[m[K%\n") # 2%
+        handler.write("[01;35m[K10[m[K%\n") # 10%
+        handler.write("[01;35m[K100[m[K%\n") # 100%
+
+        expected = [(0, None), (1, None), (2, None), (10, None), (100, None)]
+        self.assertListEqual(self._progress_watcher.reports(), expected)
+
+    def test_OutOfProgressHandler_color_filtering(self):
+        buffer = io.StringIO()
+        handler = bb.progress.OutOfProgressHandler(self.d, r'(\d+) of (\d+)', outfile=buffer)
+        handler.write("[01;35m[KText text 1 of[m[K 5") # 1/5
+        handler.write("[01;35m[KText text 3 of[m[K 5") # 3/5
+        handler.write("[01;35m[KText text 5 of[m[K 5") # 5/5
+
+        expected = [(0, None), (20.0, None), (60.0, None), (100.0, None)]
+        self.assertListEqual(self._progress_watcher.reports(), expected)
-- 
2.17.1

