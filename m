Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD6FC61DDA
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 16:27:08 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com (BN8PR05CU002.outbound.protection.outlook.com [52.101.57.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4810.1787934420254855361
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 09:27:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=s8g8kLbr;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.57.62, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neQeBk5vdIutGFwY0qV0aOSxju5l3JxCj7GhtKOKP7wY2j2dQv6dbO6nRPoo7vqNj4QMZ5U/OiNTru5rl3Dis+QMNfSH25erL+mHADFNSkyBFD19qfjFBYfgEQ92jhFhNf4vyjkwOsrcSrTI3K1Rqc3IHbGNkyn/LmA12cjStYyOo7ST96qk8r6IOqI03CNKQ94BcwfhYYCx89f5LFTIDuJCo3B1vn9Qpi0U0quSppai4oCwCC80JLv4Je5YRMS7CaDJj+AK6ppUXihhCrUBpfj5bEUNpvPWFS7RrV7+vtN8nuDsMnCYToCa0w7FrB6SO8IKy3doc8vgk5ERO8KngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Xc78Mtn9zPQrbJLiI/+RjQGamWz2+QKrIaqyQdkWeM=;
 b=EhCG2mCD9KDDHYgn0rClbWpixyqMYMid9r37NwAGcCcl9ZoO0KvnP4J8qmROGu2tF5NmtO47FGVPdIoALyhXg3O53VetYgblRE3DxnUq0fAGZ7fBmssFZRPwli7zJ4uuwBURLHSfG1SerFrgUzqzUJfGeVU1cE7xRwc+IsN258P9PNgHeNx1EkEUo0kl+FO/UKi/3jgtvMUMoAP4pyJ+xzoiOXh/m77uhEquBIs0tkUD+iMIELQ4hIsWJ4yg54aR0Ilox9VmAB6k+zr7X63snZUveAB0qu4IyRbob636/sk4FCICduiBiphIw+mnxUISEZlVNzG+mc3e0lZVZijsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xc78Mtn9zPQrbJLiI/+RjQGamWz2+QKrIaqyQdkWeM=;
 b=s8g8kLbr4RCfX4t0LeNGQlRm9MrYoezqIi8OakBNRHC/9oke1Ow6sIMJL7KhNHbE4vtYq7lhXwbswt9SzZf2Moc2pTCpshs84fYTL+Bwlhzr5UMghrJar5BqEGLoGQfVjrTIT6iEnzdPLA5I3hmnhnxDiQk8zq12kN982Bjmo7YRzgN6mTewcJeaQXA3ITquMV7p/7Kn9ro2nK1QcvDl6cUAQWcUABHrAuvY8TSRb+lYaf47pl0YtnIZr5/J1HEltfiaNBjrnapmJCI7Y0TLik7HjQTseO+QfAAZj/TN4S2PvjKm6ZESe6R1I0PFlD6b5A3cHXrThOZuvkqAfrwseQ==
Received: from IA4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::10)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 16:26:54 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::56) by IA4P220CA0009.outlook.office365.com
 (2603:10b6:208:558::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 16:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 16:26:54 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 28 Aug 2026 10:26:35 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 3/4] tests: add fetch_import tests to test bb.fetch2 => bb.fetch migration
Date: Fri, 28 Aug 2026 12:26:11 -0400
Message-ID: <20260828162612.753815-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828162612.753815-1-chris.laplante@agilent.com>
References: <20260828162612.753815-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: ac06a621-9e26-4bd9-b3bc-08df05212c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	F7zf0Dc4hbQAfzmVivwTQJ0R2MnpO1oSisLuDj8ELvK4ScGsicpFnM0VhOO3l1ZyMnw5lwmuTrSr3wtboiAUBSkE3mw44RsjfIHp+R9190OczMEVlmaixziXvS0hTa/dLpJIpUqIt+MJkop0TOTAvj6TK21jDXhRHElRZc+6FZHuYzE2bs8PHq5BGdVvZ78psKUPCGwKwO/yGPr7KKjlYTwV8l6hu4yKW/oICpYFmJlSrjDJigpfB/6rXOWl3hFpcjHAlOscCkXA7sIEqSEGWfTcMi2AklLbvAKhHhp5tZeQ70dQZnkhyYZ1jxnjFlGc9Z5d3+84v6U/CC5xA6nxmD1XzgZrbK/xCL/eC6Btw+6i498BGfcHK83pYL2icv7Y1bOcs/zgrg1YHzld48Yn9C9kbPkyFdN//8Q3xckDLmg4yXoWzmZhQGv/B/GPbuaEQwkBXrEU8Fmhzmi6t0m73EoBDBuxjp+QNA74RuqHodg01TFZ+37QxFlv55fc7QzQM0W+uiT9ruVUSYRJn8c1SSTBgBOmckcQTHYQv4J/hkdOkzlTZYvKrcNto+8VBZtI98G0cg/eMpPIJ4L4eBLEieBIwpT7Xi4brrjW85KBw8S6BgcWwrvbVLJuR0Ecd29SD9d5jXgkCLxcMJhkkU0XklJVcvlbQpxOA93HY84caxdWChGH0mIAwkaM+XY6vu3k6jNxAgHHOkR1S212sYrVCg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	EOTqNaTNTtisVbJS1fRvNZy9M0dDaGsQ7lhV68GubTdiH1laEKqfuTBnOXh0uBjybNMRTUtdul8fWgOtuH+LQEMnl3enKCAeUueN43rhmK9Z6KoCoI7PN+x3rUQAsBxkmwWVsIYZrNlY/4xzfwV11K6lMuvCuk+J+5Ia+ejWXdkrWy2e9bi6bwPVXSNS4G8+yq3wsgbaWCvu0plIG+g9Z5aNuMA4a/CsSRcb3HwFJES5WS/sqDeYCj5Yqwe5M1r/ruscV2Eqcqvanq5Bjd0/GCKHxt8ekmXkv/ft6tQG12f5rsAFz04sFKJ99NDUsGTnfQL5c1N1Dvg0ok/nllI+jg7FmCYlxqstQMw50iv+xz0awEglkWG7pw+h6nSQdsI2j9VqDwhb9IMBEDgF+ozgpdXOmnmSfAD0SjZDtdfSj4IfEEPPGD52SZxU+SQv1hPY
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:26:54.1156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac06a621-9e26-4bd9-b3bc-08df05212c23
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 16:27:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20119

From: Chris Laplante <chris.laplante@agilent.com>

Also tests that importing bb.fetch2 (instead of bb.fetch) results in a
DeprecationWarning.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-selftest         |  1 +
 lib/bb/tests/fetch_import.py | 86 ++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 lib/bb/tests/fetch_import.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 8ac0aeb5f..27791d2db 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -32,6 +32,7 @@ tests =3D ["bb.tests.codeparser",
          "bb.tests.data",
          "bb.tests.event",
          "bb.tests.fetch",
+         "bb.tests.fetch_import",
          "bb.tests.parse",
          "bb.tests.runqueue",
          "bb.tests.setup",
diff --git a/lib/bb/tests/fetch_import.py b/lib/bb/tests/fetch_import.py
new file mode 100644
index 000000000..172178423
--- /dev/null
+++ b/lib/bb/tests/fetch_import.py
@@ -0,0 +1,86 @@
+#
+# Copyright (C) 2026 Agilent Technologies, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import os
+import subprocess
+import sys
+import unittest
+
+
+class FetchImportTests(unittest.TestCase):
+    def run_python(self, code):
+        env =3D os.environ.copy()
+        libdir =3D os.path.realpath(os.path.join(os.path.dirname(__file__)=
, "..", ".."))
+        env["PYTHONPATH"] =3D os.pathsep.join(filter(None, (libdir, env.ge=
t("PYTHONPATH"))))
+        result =3D subprocess.run(
+            [sys.executable, "-c", code],
+            env=3Denv,
+            stdout=3Dsubprocess.PIPE,
+            stderr=3Dsubprocess.PIPE,
+            text=3DTrue,
+        )
+        self.assertEqual(result.returncode, 0, result.stderr)
+
+    def test_fetch_is_lazy(self):
+        self.run_python("""
+import sys
+import bb
+
+assert "bb.fetch" not in sys.modules
+assert "bb.fetch2" not in sys.modules
+""")
+
+    def test_fetch_import(self):
+        self.run_python("""
+import sys
+import bb.fetch
+from bb.fetch import Fetch
+
+assert sys.modules["bb.fetch"] is bb.fetch
+assert Fetch is bb.fetch.Fetch
+""")
+
+    def test_fetch2_import_compatibility(self):
+        self.run_python("""
+import sys
+import warnings
+
+with warnings.catch_warnings(record=3DTrue) as caught:
+    warnings.simplefilter("always")
+    import bb.fetch2
+    from bb.fetch2 import Fetch
+
+assert len(caught) =3D=3D 1
+assert caught[0].category is DeprecationWarning
+assert str(caught[0].message) =3D=3D "bb.fetch2 is deprecated; use bb.fetc=
h instead"
+assert caught[0].filename =3D=3D "<string>"
+
+assert bb.fetch2 is bb.fetch
+assert sys.modules["bb.fetch2"] is bb.fetch
+assert Fetch is bb.fetch.Fetch
+""")
+
+    def test_fetch2_attribute_access(self):
+        self.run_python("""
+import sys
+import warnings
+import bb
+
+assert "bb.fetch" not in sys.modules
+assert "bb.fetch2" not in sys.modules
+
+with warnings.catch_warnings(record=3DTrue) as caught:
+    warnings.simplefilter("always")
+    fetch2 =3D bb.fetch2
+
+assert len(caught) =3D=3D 1
+assert caught[0].category is DeprecationWarning
+assert str(caught[0].message) =3D=3D "bb.fetch2 is deprecated; use bb.fetc=
h instead"
+
+assert fetch2 is bb.fetch
+assert bb.fetch2 is bb.fetch
+assert sys.modules["bb.fetch2"] is bb.fetch
+""")
\ No newline at end of file
--=20
2.43.0


