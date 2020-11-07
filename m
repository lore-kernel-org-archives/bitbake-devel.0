Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.87])
 by mx.groups.io with SMTP id smtpd.web10.6755.1604715679020288054
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 18:21:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=dqRq4jF7;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.87, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUZ3FG1IwZi1ZDNEhZ2fcyHulkUo/kZv9mJ2NqBFv0dX4xdjFCtqXz+LFkA72fd1lOJuWvyXsDAdyeDW/sXx/8OMDjLhqhKBN/QSZ9Ejfnu0wwPbkKFw+KMizqngi4hbu4Yi4RJDAowutMQc4BWEELnMiHrcXuixMUH0su8t+P7zEgef1dWQBLKwOg+hUGx1zXG/FUUGXn+tlJUVw09lfq/L9YeQJA2rIT4oNVMdDNNbOZjxwFP6Vi8E+6z3Hx6HjhDbcDvDh1l/tRFJTBIkl/ACPZMAq6c/nCpQWfBayJchjcfRC6uOO9WYJ3r+KtDIz2M1BWnkRKy1B1n3MbTN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NFHfzeZGuKRbo4iisQSL99KIKQBlqZtJsuDKbj9DZo=;
 b=PIpn8s4c3Yjlm30NTeNUv06+vuqz7qiLxLHUQfcXQANY2jtPO7YGokiy38ia1qOLzE5wJFTwyOzVE6ku1PTbNthaMSrq5PDK4eQYIjzhx08OxMwiDo2e2i+ViCh1dX/arqmJj6o/WmOf1gusyAvVb1BeHFAbAl4Pc9NKHspbSDI+ht6RQp5zl8JC8To9VfE0MnL9XpZazwnPb+GKYFdJTZLhD/gzojSwatiXphexzbxFOx3brcgModP+QLfUpjSWQef+vGvhRrPbgW+jsRCG9CFK4JCwvBYdKeuCVuE4h+Dn9aCrXFFUurW3A2+q0ZO2XhEkz3H85VPU6jXS2JpsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NFHfzeZGuKRbo4iisQSL99KIKQBlqZtJsuDKbj9DZo=;
 b=dqRq4jF7oWufQpEVQcpfHxImVc4UJAMvwaLxt8W3rTrSotNmnulx7KX6dlb+Z26Xd0CGXLJiXVhGaYcQc4d53WOW2kV7rb24bUUVWuQBqCp2R/6CnLiqzrbJ8MK75ECE25ObHCNam50TkC0S9GcjH1mescTynOD73eUSVejpUYbRBdXf99pw1+EVCiyOwiddmXZ1IGoqIvWqJnujv1TMWdiPQ944Lk9TotRpejPHxIsZt9vGvNO72ZQfmmRJN71MwULGt11XLhRYKdmgefI4OU8irTUB4UINgumlYtoO45D5HkE2A/JVbZ/H6YWpyNVgmCWlB+U2lyVdFXVlgtZlFw==
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Sat, 7 Nov
 2020 02:21:17 +0000
Received: from DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::54) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend
 Transport; Sat, 7 Nov 2020 02:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT058.mail.protection.outlook.com (10.13.179.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Sat, 7 Nov 2020 02:21:17 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 19:21:13 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 4/5] tests/arg_parser: add test for lazy loading of bb.ui modules
Date: Fri, 6 Nov 2020 21:21:05 -0500
Message-ID: <20201107022106.84056-5-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201107022106.84056-1-chris.laplante@agilent.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd09c4a-5701-4c3d-49c1-08d882c3cecc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM6PR12MB4418791C924F4AF3343F3C7E8BEC0@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OH1xN87yhuo67Z9TieflTRN0jJg+tdbWQ7uxMgvSMTehsfbjD6yG8iD+z2A+JXzgLmN6nsCab8YyTzM1BZmunan8ZRMRqhtWOHBFWKl2F4tGg2qwnUu/21zygn/5ZNGAdQTrZUSIVNHbUs6OBPnbi8AYQMa8HYsTqc4e5WiqrFgZKIaqVV/M97ATalOvaMdoZCo5aGYr/1DFoY2Me7b6QaUplSYhF4UUPdy6OWgCOr6oEN6fVm1FdYyeqqthVtr4cayTQJVZJFT6MqDAKY/IeBWIk7nIt6zVQzxbDoAFKwec66wTifzt4J0o2tCvLprLw03WWnquZAISQDj3bWbwmZ67KYwChvAZz0wPnoWS1MIzMzksHp3Ms3X/DNyCqg0+E0kVjxMtp1qus6Mw3QhNZDKW+Pbisg5iY9AZd2AqJuI=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(29502001)(46966005)(186003)(70206006)(2906002)(336012)(47076004)(83380400001)(26005)(478600001)(426003)(4326008)(2616005)(356005)(7636003)(316002)(36906005)(86362001)(36756003)(6916009)(82310400003)(8676002)(6666004)(8936002)(1076003)(44832011)(107886003)(5660300002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 02:21:17.1374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd09c4a-5701-4c3d-49c1-08d882c3cecc
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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

