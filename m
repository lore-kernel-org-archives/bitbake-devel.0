Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22068C87FC9
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 18:44:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.80])
 by mx.groups.io with SMTP id smtpd.web10.16036.1753814641133369978
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 11:44:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=WbF995bh;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.80, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo9SCJr7Qf3ejrw+jPrLIm7v2GIHTgxSFwJYaf/8cVvr7sz0UemDpYqyrU9NUmI5Hn3Jy1OghWOHEHfMSIngrkGu+5muM4d1V4H8wnWvshnJ8BnpVkt2qNLrOclbAhPJpOL4kFQB0F12x8zsOkB1saieg8EpvkSLpsIxy8RrAcNTHoc+CMkeZt5urIc/qLN3fmNZtrQC8uKMZwjxdWAvAqN1HuTW90lY1CoryGJbiUS8qrInPgsnccTr0FPzwL9fPBAdOcdfI9sWzwk2eqbdVpfGyx2Wp08wJElIOJfX9TL4EqzUpcjHYURTddS9s3Xz9p/6aENDFxKFMLrQRlTIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+AmKSU6bf620DbKyZWy0UKO2lQ1wYOFWQliFCmcCKg=;
 b=UFVXv85gZTsRa6DCpNr5p1/dbk4pJNXCrwpqposSM+ejPmstsfen1Z3uyKikjU52dTgbfz3d0iVeUsY/bcsNAmdo5JI+FQ0abRusauW8434/wBJD+yx4r/F7JkFN3AvoRzhlmFP1jQxjY5fYserakWjSLYeaqF3MqZXiD7ZOmmsCVgU1FEiE0T+9VfccIJeTnKmIvv4L3InI46TVFZGyxKnu8grG6nyo8NfcIWvy0LpR47FuOKK4aqi7CUlCagk0PRylqywJU4NhyyjuktJvWTanu5GZx8r3wXfcvKl1IcaZrRaAae+rOuXBPCq+Y45lRuBFoldgwvsADsMadRtsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+AmKSU6bf620DbKyZWy0UKO2lQ1wYOFWQliFCmcCKg=;
 b=WbF995bhAhXUt0lab/VzO3ZPxajnv33pef3pFhk2g00StZtKbjJxmA9Dvs8IJBl5qUabhdAjA50KcICGk8GAn+8PXg9R0q7kWVnybL8Kmo2xWAvy15+hIHDlq/4U1I89FtfN0vUZscARoVQNvsPmKkk21P4Xa2FqjNNfUTCw6SCUzc8db8VR3cESxSNpYhd5gT3agHALRV2O6TJedXalGEi3CQY+vpYqSkvkYYRitmT/b1xMa+b9WZUkoluHXpEqvT1DZsA016w0n2TzfmnoqPgyMhwwvAHPkgN7985s/d/KhIVlI+uC+0IAHIDmR2PAloF72sHfkep1IxJtN/L3Xw==
Received: from CH0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:610:77::31)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 18:43:57 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::90) by CH0PR04CA0056.outlook.office365.com
 (2603:10b6:610:77::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 18:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 18:43:56 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 29 Jul 2025 12:43:31 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Mark Hatle <mark.hatle@amd.com>, Mark Hatle
	<mark.hatle@kernel.crashing.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [2.8][PATCH 1/2] bitbake: runqueue: Verify mcdepends are valid
Date: Tue, 29 Jul 2025 14:43:08 -0400
Message-ID: <20250729184309.292510-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: fe674d40-8e68-410d-290b-08ddcecfe004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yjBxrJjgL+tF+PKlTeXZAYVu0IBe9AiKU6Nz9EXPJtOl+2R+AHt5TC2HCHrb?=
 =?us-ascii?Q?VUC+NtoJQY4Z1sZLgZCQ3kc8kEOnySEk4HbDFOF4LeBGEZKzNQp17LpwVrNL?=
 =?us-ascii?Q?+imxkfXwiDChmtBsVW0IoaRZjme61qCfS05hA2lydZrZVRHEQ4bacECML4Bq?=
 =?us-ascii?Q?B1lSLwosJkc1MgyiGBoXX5Y0DvcDVtjT+g77ZBX5kNPmlZJzauvZSCHy7RHc?=
 =?us-ascii?Q?3dz4vz6VZzPFTepoSf9kMK953ib9r3TNdj4nqjAlu4tNDLJ1GclX8WHkqQ8Z?=
 =?us-ascii?Q?X18L3xs7p52Anut13c/0J5KEV/BBRi2OOIoe+i0UyzPX3hBFyHecqDBSkDRA?=
 =?us-ascii?Q?nde+zyj8U9cYf6I9fhUpGpADkV9QZGSqb55XnrO/6WWtZGNejZINh3kbONap?=
 =?us-ascii?Q?F0PLQBGCsIbmCiMvibK9eAz0tLyNgQtoQxWICt9Hka7Eg8R2oQtUr6HnjBqF?=
 =?us-ascii?Q?W6ybgcBqO8wXHx3LRcUSLUfv3j9K4YB/XBUNfa12w7/hx35nh9Lsls6Z7UMT?=
 =?us-ascii?Q?MVa+NR1pWzmmBI7Kb7TTIe6uRoiCgl5kyYLEbZS96hN4GWnpecp2xPOfgjjM?=
 =?us-ascii?Q?b9Lw6v0laEhouZuuCsVjzanS/ELBGnj4GZonDKmxpqZxq2sFv0/uYyLfIsIt?=
 =?us-ascii?Q?JEJ8cUF6kSIGUjofAIVTNejdKj3VkkUbJul6+UOHDkzPxz8ApikaqvCcoI6h?=
 =?us-ascii?Q?H+2hBBWTG54dnIaSag5HfJZb7/S4Xt0optdKPGB8gNsdWEKg//zlJTuuqYTY?=
 =?us-ascii?Q?WSfNcV9DTeKDDbmOxChTPGwvDelRWrKBQJwwD11/VDjiqOvyNEWAEfvdjwwE?=
 =?us-ascii?Q?us5iwxGUD3akYF/Td5EvzhFkMWWjls4kDyAD+YP/2jUzwvNW95XkDKxfhpXV?=
 =?us-ascii?Q?EgF3GWQKeLi2zBCi2PNytc8afsOp0h0HiLT0l2rNqMlr07SyKWiVEVGugZM/?=
 =?us-ascii?Q?0iH/8z8z+6AiddFSO7HaEzpk7jY/ZtdQVhQjQzaN7jrG0XfDOTemV7EpqNXO?=
 =?us-ascii?Q?4m8PCp0DD6GEEPd8SLxDOD1jSG1qy2jXN8IFi9ZDmmcBAJA+2tpBWMcWh9h0?=
 =?us-ascii?Q?IqP3Jk0GZUgWrqqcYu6uzh6QBj8V5na7n84iehvv0pF/ZGIEFSIUgZfC8J02?=
 =?us-ascii?Q?HZ+S3NVYnMRoEKOa/Ha85UMJU1B1AQPwTVTzL7hIWIFkpFzT85MSLq1Me6ta?=
 =?us-ascii?Q?jWzmu7tZsjELmoZG84XnJaXeTcLYTGI5Gv3ERUqZeHdh255isYlK75mhIdiF?=
 =?us-ascii?Q?LqLe5kTO7GmKVbFpdFQ12/3zOgsEDKTM8c3RwWhUzNCNgrDmc3HANB7QqCtz?=
 =?us-ascii?Q?LEN68sdiZ+zl1Ah+W23rI5Aw4Dn8jsN2tSXmKhmlCd5lluk2eTsuMsp8hwUL?=
 =?us-ascii?Q?7Savuc3vN8qRh7WQwcy1IdcNw5Pg62F15QhpYjFVvlIcecwD+mVd5CgE3tgP?=
 =?us-ascii?Q?xBWHXbBG/ylqgV9RPJ2B6KV2U6RSl8d+Lv+xW5JmKB/IPb2UN7rG9tZhujSa?=
 =?us-ascii?Q?bGkd7FGAQ4Ro1aGiHu4iZq/Ee6CO2KWZ2JwY?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:43:56.7296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe674d40-8e68-410d-290b-08ddcecfe004
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 18:44:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17824

From: Mark Hatle <mark.hatle@amd.com>

In order to avoid a potentially confusing backtrace, check that the mcdepen=
d
is valid when we add it.

Add a test case to ensure invalid configurations are caught and trigger an
error.

[RP: Reworked test case to simplify and improve code]
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py                        |  2 ++
 lib/bb/tests/runqueue-tests/recipes/g1.bb |  2 ++
 lib/bb/tests/runqueue-tests/recipes/h1.bb |  0
 lib/bb/tests/runqueue.py                  | 11 ++++++++++-
 4 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/g1.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/h1.bb

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 439da2bb4..db68f97e6 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -729,6 +729,8 @@ class RunQueueData:
                 if mc =3D=3D frommc:
                     fn =3D taskData[mcdep].build_targets[pn][0]
                     newdep =3D '%s:%s' % (fn,deptask)
+                    if newdep not in taskData[mcdep].taskentries:
+                        bb.fatal("Task mcdepends on non-existent task %s" =
% (newdep))
                     taskData[mc].taskentries[tid].tdepends.append(newdep)
=20
         for mc in taskData:
diff --git a/lib/bb/tests/runqueue-tests/recipes/g1.bb b/lib/bb/tests/runqu=
eue-tests/recipes/g1.bb
new file mode 100644
index 000000000..3c7dca025
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/g1.bb
@@ -0,0 +1,2 @@
+do_build[mcdepends] =3D "mc::mc-1:h1:do_invalid"
+
diff --git a/lib/bb/tests/runqueue-tests/recipes/h1.bb b/lib/bb/tests/runqu=
eue-tests/recipes/h1.bb
new file mode 100644
index 000000000..e69de29bb
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index cc87e8d6a..74f5ded2e 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -26,7 +26,7 @@ class RunQueueTests(unittest.TestCase):
     a1_sstatevalid =3D "a1:do_package a1:do_package_qa a1:do_packagedata a=
1:do_package_write_ipk a1:do_package_write_rpm a1:do_populate_lic a1:do_pop=
ulate_sysroot"
     b1_sstatevalid =3D "b1:do_package b1:do_package_qa b1:do_packagedata b=
1:do_package_write_ipk b1:do_package_write_rpm b1:do_populate_lic b1:do_pop=
ulate_sysroot"
=20
-    def run_bitbakecmd(self, cmd, builddir, sstatevalid=3D"", slowtasks=3D=
"", extraenv=3DNone, cleanup=3DFalse):
+    def run_bitbakecmd(self, cmd, builddir, sstatevalid=3D"", slowtasks=3D=
"", extraenv=3DNone, cleanup=3DFalse, allowfailure=3DFalse):
         env =3D os.environ.copy()
         env["BBPATH"] =3D os.path.realpath(os.path.join(os.path.dirname(__=
file__), "runqueue-tests"))
         env["BB_ENV_PASSTHROUGH_ADDITIONS"] =3D "SSTATEVALID SLOWTASKS TOP=
DIR"
@@ -41,6 +41,8 @@ class RunQueueTests(unittest.TestCase):
             output =3D subprocess.check_output(cmd, env=3Denv, stderr=3Dsu=
bprocess.STDOUT,universal_newlines=3DTrue, cwd=3Dbuilddir)
             print(output)
         except subprocess.CalledProcessError as e:
+            if allowfailure:
+                return e.output
             self.fail("Command %s failed with %s" % (cmd, e.output))
         tasks =3D []
         tasklog =3D builddir + "/task.log"
@@ -314,6 +316,13 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
=20
+            # Check that a multiconfig that doesn't exist rasies a correct=
 error message
+            error_output =3D self.run_bitbakecmd(["bitbake", "g1"], tempdi=
r, "", extraenv=3Dextraenv, cleanup=3DTrue, allowfailure=3DTrue)
+            self.assertIn("non-existent task", error_output)
+            # If the word 'Traceback' or 'KeyError' is in the output we've=
 regressed
+            self.assertNotIn("Traceback", error_output)
+            self.assertNotIn("KeyError", error_output)
+
             self.shutdown(tempdir)
=20
     def test_hashserv_single(self):
--=20
2.43.0


