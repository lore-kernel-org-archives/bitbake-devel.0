Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4678C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 14:30:55 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37729.1787841052975873691
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 07:30:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=ASRf965e;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.194.18, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on2lLjd7SDkk67qhWgdgh3V0pdzOaaGGgYpZCBwk0HK2wbqbv3ZTf88qyWGPXGWlm0og8NNi7imCky7mheThwa0X9cUbXykBn6DQNxzne98XskNhWJhy2WLRL/0CCQpHyokeEXpJu9EMbI1Z5TZ/lsGZp5fTxIrYcNI9rImtxc3Q0KjB6jLJ8UUEuluqcCmndZTnYMAoZL8sFxkC2wTc06fv+TCLI4PlxK1MOrR4RID/WWjutwA4pbiZ6gZb3Ynm3BdxMByOaYCw7ynom0acKXBYoQmrfCZE7JdJ9gOpcN/sdlG/vrj9+0XSelwrxf2eZiYRB8rKRrpRH1XHYBtnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdT16wZ1axm0KM4CPhizs+rYPQs/VCKEoDtCUYe9p2g=;
 b=VmNQxyS0ubWwIgJzjnmpQkM151M5p4kvhmCm6C0O8eHvnoNk1KELCree+F2+z61M41QNq1ForxbP3VKFZhyro/+h8Nwzn7g0qs1XvhdGRtzIF0S0+9CalYRfjcF8yULv+CLaOkIyhRGmB2d4+64DJ+a661CcwLpy2BkiN6XgEqc0fp92xzPM6w6dPMhYDCoVLmRqyhoK4L830cBDyS0FkKI/EKWoV8lvgyGqv4fEnjutrFsPCARMMiaD0wF2medjDHhze4UgxflS5Q3Si1Wky2NoYlfcK2u+QjGvnhLcM/HZXVil/JjOQmd8Uv9iZqbPZEDhVF4eIDI8VRqPJUa22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdT16wZ1axm0KM4CPhizs+rYPQs/VCKEoDtCUYe9p2g=;
 b=ASRf965eApgr+XT1xPxoQKIGBum0IB84i1W/1SLziEuG+0UxJM0lsXN9KBLgCZ2NTpq0IqJHp0vYXdgwEr/Q/v1KW5UXo32D3FGW0QFhi16yNHact7USgONcWAY36WejHCk171YqjtS50PVqUJhW1Tbi3pTtVGVuAxxEseBMPJIfqFccAK8v3ZMOuHVOKfWj/wHGrMK2CDkuKteUVBxkHi1I46jrHKhKxiZJ6XK6FumxVMwXJSDvk83c6Zxqbjgv+3Qc8wZQtdEzW56ArHbHdO/xfdg2G7Oy73NvS3JvDGn81ZBBtoxOMSeELja0N18Xf7lR1KJpMoXR3GpWcA4cbA==
Received: from BN9PR03CA0574.namprd03.prod.outlook.com (2603:10b6:408:10d::9)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Thu, 27 Aug
 2026 14:30:50 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::95) by BN9PR03CA0574.outlook.office365.com
 (2603:10b6:408:10d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 14:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Thu, 27 Aug 2026 14:30:49 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 08:30:14 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 3/4] tests: add fetch_import tests to test bb.fetch2 => bb.fetch migration
Date: Thu, 27 Aug 2026 10:29:57 -0400
Message-ID: <20260827142958.547182-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827142958.547182-1-chris.laplante@agilent.com>
References: <20260827142958.547182-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ca6c27-768b-4139-c6f8-08df0447caaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	/Y3QCG3vBxajTdkldjjvA76nkmBAC3COP24B42KRSfCvRucVCXXk5qVxSUoIE50Izum549k8fMeajGwtu92rA00JqHuvDlSxwhAp+0uvmK+8J98HE3JLe1eqXRzJCzyAM9EIHZ1oz7zqQD2BH1bFYGXk2u7CC7Q1KynteORwtvEXIyXwYfLqC2z8wqrctbsntnvHwurcQVP2kl4IXDbBtWLBjkFrLWHuxkVYc63u8fsvMIE+GhCa1e2T4F4gQvuxuIEzRLWRRtuj6TXHx4hpuJgXPfLAIRAqTWqhEXf6vx2FxMhBh9hCDK9BkIWW4t6b6T/dZVahPoZ0B0279fihZ0VjDHlCjnqE0P4jQM5hDsJxaHqFTs2/I+OL0vNfKMAD5LdQxx2KVpElbob193hnLuAnvMxbhLravcROGoOwFymDvSNdq2crzz1C373gpfVNL0batTHapnktM4hI+sSXvbKfFYtsbwMFKLEZI7yGzxGEWK1tKMzRmrjWeEHPAqvL3OuMw1mXFYplDGNmJBO4GXZ/tDFZLhF548wUHkdaMxC1jLWNqkmtM2RKkRX7ImIAhq0JWAIHXkNdhng1tc/7B3VmBi18ygFsp5q+fCp54cCO8Xhtd6qZiB4sGeHmv5ZDJ5ZwX4zxMNzTZRfYnBFQLO29Ve3ZbXx7POaCYHZgQBjBwykO3qqDv8XdfiB2umj/2+RYRJbDio2BRVRwtOL0AA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Aj75D25SERE8GaYn07luZaoznm5ikNTT0/lzPKKglly/n5OJuUAPzDScwTUVUai9kNemWAW0uCSWvLtXNC0YhJ/hUji7AdfY7UhfCvzf+d/WSOBInrr9s0OIyClHzKetnigMJNqHkY+AuHYuwH44zL8WodLPfWOOe5jyw8SSME6X+fYk2Yvj+/+HAGC4APC+F32QFoaxBcmp54CaaxlFCefQdpxpw/LbVs+dPHbwYb6qBfO6ReozkC22L4qvn/swn7550OB51sAB6nqjZFO3kdTKaAXqUBEvBrcWQA5Qu8gYNo6TZchcSjUvpExf7N1+YCdJ8+9U82Nt7/SYaEamTkWWEbWtlhAjw/9UBbc3JuPfRRQVr5XaKYUe+T9H2I4LesRcTsOuR/6saiVzbI3RZMGwa1cqSuO3KDdSJNHXmjrTh1pWgCEI8eUJdiREsFur
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:30:49.7888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ca6c27-768b-4139-c6f8-08df0447caaa
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 14:30:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20069

From: Chris Laplante <chris.laplante@agilent.com>

Also tests that importing bb.fetch2 (instead of bb.fetch) results in a
DeprecationWarning.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-selftest         |  1 +
 lib/bb/tests/fetch_import.py | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
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
index 000000000..3c44a1b3a
--- /dev/null
+++ b/lib/bb/tests/fetch_import.py
@@ -0,0 +1,64 @@
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
\ No newline at end of file
--=20
2.43.0


