Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.69])
 by mx.groups.io with SMTP id smtpd.web12.3225.1604873539351101910
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=cQISzCap;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.69, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDy0sRYaOe1hsu17HVcawWqFuvRsI62lEkZINenbjVz3/7szZ6DJgHawX9KH5MIl4mzAyb1r9/vz7ORqVElG9Y2dk7KGK+n+CupdUEtjYvMiOsYwGwg3/eqHS+SYc1hok/QU2A1IIkbcxByXKfeqoyQ9RLMXl2f87aZqZsKySoXUsxT07bEgq6r9qf1UGsUqt+cXxVPZBpAuf4tBC2Y2wxcgtZpvVreRd1vu2Mbj0MXiw4cNWpzI1+cpNAiHgj2h2Px3juVgCLGE0bCZf51s7Y5AI4mxbsBvuwtfgS4WE1Y69/FDZ/el4lNn2aqRvblFqEWVOdQarIuAHkQxF5VGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRhgfnnnXzpyJSSCq4hZ8jfPnPvn9/lBRVdnPbeDhCQ=;
 b=TdBINiLk0H3o1COkAEJggMjJgCksuFDT37sn816mXKQmCzK7pjaHanMAd+Sl6v+FidaebSE3FzSdE97nmL+KHyzdd6c45MyAt8nzHH3fdLVoIBu0O8xJl8t3pzpoktYU6de0yoJdzbWKnk6GJG4CYcHQRzKIo5uUTAhle5Uc6P5m7SUbJeB5YjQTph932lox3bKYFQ+MwBJiO9ghKV6Gjp+yHUfitJ5TJEaW7AZKOZwuPx8CxklskukcaUNk/rENYdeHwaLezNE7Gsc8OICO3llP1DyKh5q01w0PbYUztVqKKrAHkOaXsQWxxfFbddfn82Jya9RmQD1PulgmKUK8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRhgfnnnXzpyJSSCq4hZ8jfPnPvn9/lBRVdnPbeDhCQ=;
 b=cQISzCapMlHWxxufJ4g43VMeeSIVLdZW/lS460woSKh7UfFOnW8In8hcjUMYyMhnalT5q4aAsaPQza8VRPC8Ry48mrW7HD/KOwScr/IRZF4qp4nrhUKv4W5ceQOB+kr0N9hT/OTFL3uBfZa9gkwvcW7mQayxPjVaWGSyUnj85F7vF72N7bOx5zLKzg4RJye7EvtrpmJQ3ym46Zs0jd/xQGcM7DhkwdSGYT9HRT6P2QL9rRrq2arFoIjFgiFMyubnvLmiZdsqdX9crPmBQ9HovD/vdzxEjr+DoBNk3E3auNIak//Dq7aJCNM5SQhLH3xjrbJv1dEwrVEXneJztRQDrw==
Received: from MWHPR12CA0070.namprd12.prod.outlook.com (2603:10b6:300:103::32)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Sun, 8 Nov
 2020 22:12:17 +0000
Received: from MW2NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::43) by MWHPR12CA0070.outlook.office365.com
 (2603:10b6:300:103::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT049.mail.protection.outlook.com (10.13.181.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:17 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:15 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 02/10] tests/arg_parser: add stub for testing arg parsing
Date: Sun, 8 Nov 2020 17:10:51 -0500
Message-ID: <20201108221059.16854-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201108221059.16854-1-chris.laplante@agilent.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db30eca2-016e-4759-f20b-08d884335ae6
X-MS-TrafficTypeDiagnostic: MW3PR12MB4555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MW3PR12MB45559464B01E00929851CBC68BEB0@MW3PR12MB4555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XOdGqBWrKuk8t8IxPh3hG35MaTNl1/EUtKwiADz76wzpNvWLHIdZOam5WUpDofzWXb+rZbCTD0iffcb2bpk99prioZTQaPZNlZLME9yiA56CsVPKtnWqwirJItN9ixH5ahofbMtcbyHJbPWBomBhKuUNcPOsO0w8GsHE0fhDh1fUY3YkwnJEu/wI2cLULaHjtAEfpX8abq1sK3SAKu8cx1329FNToe+0O5/U0Av8vER3L3W0dU0jX0dXvTIE5lAP8CL2bjzlIXwXulbezSTUhEXtmMiCCwMiaKSEo6SWj0zJH4sW93sk63WMwJPEoxtsrKhXIpotshI/KT9wlxmOhHrs3Xc9Jqe4agFVBAlyiMgnWvueLfXTnXRyVs1jMyQd/qHHhNp1ZZQTttkz6y1XloO8+q3MnBWeIyIuS0Ef8Uk=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(29502001)(46966005)(8676002)(8936002)(82310400003)(36756003)(2906002)(6916009)(47076004)(83380400001)(5660300002)(70206006)(86362001)(1076003)(356005)(316002)(36906005)(7636003)(4326008)(6666004)(478600001)(336012)(82740400003)(107886003)(426003)(44832011)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:17.4949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db30eca2-016e-4759-f20b-08d884335ae6
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT049.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-selftest       |  3 ++-
 lib/bb/tests/arg_parser.py | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
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
diff --git a/lib/bb/tests/arg_parser.py b/lib/bb/tests/arg_parser.py
new file mode 100644
index 00000000..e6b55f69
--- /dev/null
+++ b/lib/bb/tests/arg_parser.py
@@ -0,0 +1,17 @@
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
+from bb.main import create_bitbake_parser
+
+
+class ArgParserTests(unittest.TestCase):
+    def setUp(self):
+        self._parser = create_bitbake_parser()
-- 
2.17.1

