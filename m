Received: from NAM04-CO1-obe.outbound.protection.outlook.com (NAM04-CO1-obe.outbound.protection.outlook.com [40.107.69.76])
 by mx.groups.io with SMTP id smtpd.web08.1043.1604687105418646903
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 10:25:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=zAe+3YVR;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.69.76, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHA5WtGKNjJkv2lk4To2/cOf0aQjlQ59BpKvJVGmrmbDP4A4/ROK/0D60Hm0Z+wzR2SlTPtRkCSPzof6ILh0XABJT6cSowqURWOL1g1wIgusiFjxeYOWPuH3NCVcwhjycYRetwj3Wd5t9W4/0xv3mVpHIEGgZsaDanpDVpNHwVwe/hF9rhXiaOZ1bPC7TFNcLfHf0ZISuWy57xVWegKfIm7g7QjUaAEDmN9ylB5rP0BXY9lsRAaBd7qH5a6Rhw7AVuw0DL5a83IaKOVPLcr/n/LiJOrKePK0bKnTJ6U/b7jpyVOT6Djo2IQ7k97y+NiwJ4RD+djSlcFV/dzrqIqVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NFHfzeZGuKRbo4iisQSL99KIKQBlqZtJsuDKbj9DZo=;
 b=LHMUfv9nvVWVBwIhqrsMNo+tUlqsJqCVIK3boIJiazSl9Ttk+1vjKO8EaGXE3Ic9POLvXuQRkosGphQl8JR2XgP8P6wLOunL+Qy0HNRCzRFg9Y/mRtsgLB99b8H/uk4ZwAC2iGDfpIygAPxS+rGsAwaTEhD2fpxets7K5Xt8RUWLgdNOeUMNWb/gSN18pzATaYH+IglmsZz5SFMIjQI6rJpo7oNjZEOsN7x0KiwQj7R9dv76uY7ZxRWEXeWt+d66UJiHMRGfWZxHdJADe8TIhtq/ilysjxWNAJ5pdpACccAY+HdlyDdkbojusFx6X5guuSyXa/IQ1OAt6BHUIXT8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NFHfzeZGuKRbo4iisQSL99KIKQBlqZtJsuDKbj9DZo=;
 b=zAe+3YVRAwe7j8774S9mUfjYJpxTHlRNyl/AZodDxZ93sVeFCwzpvO1dsga2wqyb0E+IGAv/fQAwF30pTCRipzqAms/x88NFpn/bOdEN9KNZXNWxrFlWCaJZoLzFivx3zrnRHUPlhq6bx+MCxg/W9qGY+W4YgcH9/1Rpzwdvf7ZcXnDmSAhdCtFPbwR42e74JNtTdJjNMRNHHuFqtayBx5D0hQfqWwoeCKEesitk582oAIKk9oaMVTfIpZY5dDGhCTE8jmKHGSaGyuisZtMPoqsKJ4RvR10mjTIcvD6EIZrkqmAtfF3hRRoKsIsLwoVAJI4d25UkD9l6/qhv/BZsXA==
Received: from MWHPR18CA0047.namprd18.prod.outlook.com (2603:10b6:320:31::33)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 18:25:02 +0000
Received: from MW2NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::d4) by MWHPR18CA0047.outlook.office365.com
 (2603:10b6:320:31::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Fri, 6 Nov 2020 18:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT016.mail.protection.outlook.com (10.13.180.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 18:25:01 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 11:24:59 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] tests/arg_parser: add test for lazy loading of bb.ui modules
Date: Fri, 6 Nov 2020 13:24:56 -0500
Message-ID: <20201106182456.88052-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ed51b5b-8dbc-4847-d45f-08d88281468f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MW3PR12MB4539CBA3DFE82575F7A1C9098BED0@MW3PR12MB4539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C4cBohfcMoOwi7XPVq4dmQsWfcFkJvnpXDE8yAXubM4FaszCNDZhE48FHtmb4BXgSeW4kh1Ito+TZgwKc3NstsOvOioxTbhIVB+nGyQ8x1OpqMpMYUx7kldNcjNKXwYTQp5djeFbxTAwDOUZgQfxVthDUsDO+2+/9BvLmDj6BKi+WWPaTOSpaH41nokonr+0sH86Ca/La5+sRB4ISRK8yT55sGx5+eWwbyS3iT1MYkIjjdcrSr28l4N90HHacKZSOzz2aH4UkMAP8NUgBX3isweBPK8u0df/q0KNQObRdtpQSwV+7VRkBsNEoY1cIKoZfhNYbZ98Y9Vvcx1JU7/T69Jf0BVe4UjvfRt2UVw2hSihFTB1BUAPQKpj03SI8S4dwTPmNT8uPrf+5xoB+jFttCR2oI3sy/fHPQPAaOQwz2o=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(29502001)(46966005)(44832011)(186003)(356005)(36756003)(26005)(82310400003)(8936002)(36906005)(47076004)(478600001)(7636003)(86362001)(70206006)(2616005)(83380400001)(336012)(426003)(6666004)(82740400003)(6916009)(1076003)(4326008)(2906002)(8676002)(5660300002)(107886003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 18:25:01.7869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed51b5b-8dbc-4847-d45f-08d88281468f
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
Content-Type: text/plain

Ensures bb.ui modules are loaded lazily during construction
of the 'bitbake' argument parser.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-selftest       |  3 ++-
 lib/bb/main.py             |  5 ++++-
 lib/bb/tests/arg_parser.py | 30 ++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 lib/bb/tests/arg_parser.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 6c073741..cc794bd6 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -17,7 +17,8 @@ try:
 except RuntimeError as exc:
     sys.exit(str(exc))
 
-tests = ["bb.tests.codeparser",
+tests = ["bb.tests.arg_parser",
+         "bb.tests.codeparser",
          "bb.tests.color",
          "bb.tests.cooker",
          "bb.tests.cow",
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 2fb81a23..16ff6e59 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -98,12 +98,15 @@ class LazyUiChoices:
     """
     def __init__(self):
         # map module name => imported module
-        self._modules = {}
+        self._modules = None
 
     def _lazy_load_modules(self):
         if not self._modules:
             self._modules = {module.__name__.split(".")[-1]: module for module in load_extension_modules(bb.ui, "main")}
 
+    @property
+    def has_loaded_modules(self): return self._modules is not None
+
     def __iter__(self):
         self._lazy_load_modules()
         yield from self._modules.keys()
diff --git a/lib/bb/tests/arg_parser.py b/lib/bb/tests/arg_parser.py
new file mode 100644
index 00000000..0c8941f8
--- /dev/null
+++ b/lib/bb/tests/arg_parser.py
@@ -0,0 +1,30 @@
+#
+# BitBake Test for the main 'bitbake' argument parser
+#
+# Copyright (C) 2020  Agilent Technologies, Inc.
+# Author: Chris Laplante <chris.laplante@agilent.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+import unittest
+
+from bb.main import create_bitbake_parser, LazyUiChoices
+
+
+class ArgParserTests(unittest.TestCase):
+    def setUp(self):
+        self._parser = create_bitbake_parser()
+
+    def test_lazy_module_loading(self):
+        # This test ensures that the bb.ui modules weren't loaded immediately upon creation of the arg parser
+
+        # Find the UI action
+        ui_actions = [action for action in self._parser._actions if action.dest == "ui"]
+        if len(ui_actions) > 1:
+            self.fail("Found more than one 'ui' action in the argument parser?")
+        self.assertEqual(len(ui_actions), 1, "Didn't find the 'ui' action in the argument parser?")
+
+        ui_action = ui_actions[0]
+        self.assertIs(type(ui_action.type), LazyUiChoices, "'ui' action has wrong type")
+        self.assertFalse(ui_action.type.has_loaded_modules, "Creation of the arg parser loaded the bb.ui modules")
-- 
2.17.1

