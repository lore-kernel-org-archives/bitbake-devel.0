Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE6C0218D
	for <webhook@archiver.kernel.org>; Sun, 26 Jan 2025 10:28:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.45])
 by mx.groups.io with SMTP id smtpd.web11.3038.1737685550564615907
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 18:25:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=W7Q6ieLo;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.45, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fbm0helv9tIYIu1urk2uh2v+pIkEPYXVRGC/nVg6a9yQkipU8dc2BPv8sEqNE1IHxObIBLymZQZQoAV4Wxc2+heTD01QnOp/07p5OAAiR355RJLr2EtYSy8KJyDX7pnZRcsSgLgn3Lg81heMkldlJYGmaTBuvDL+sukUBKW9OK5Ww8erzayiT21lju/h//AHQeveWJnMnu01l/SmLw1XtmjDcxc6QWfKgCT0H9l/2J1cVMyO5dQOj4ChSJ2E97Ppa8TdZuWMzbbZxpEt0WpDuYGEErUp/W7ndmAWcHPPj/mvUWyMAz/7J5raz0Gp/du3ZYPsloeuiLTgTywaonojMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7/78ByHHuSnmQbknVqTNDY64MXzl/oAFtmiy/T9z2c=;
 b=XA6rkz0AyPXJ7w+LnelK9eriZyo7BsJvLK4LxeBP2BlBXtoacHTTibWuA7rcwXAEhHqOgzGy4Zt8O1gqjQSx1SDVL2ichG2i7mYdi43FQprkrw9A1zhi6qoCZZqAsfkFnPmbK692s+ujbhhTVR+FjbWqwyEiMN4cvDMlcxUydGhsICArobuf5bxc7h40qBrLD8OaXQKxon3Xx87zxA/iIVz+kFa/Tf+SzTOfa5nuuaL3PJucZdtAL2utleqjEF/6gqAcaIkazgop5tpudMCC46HHhPTqhxio6KVeCFGhribdxO3Av4AgUHdArQXhOXrU4Cuhn05CPGxGJrdem1w/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7/78ByHHuSnmQbknVqTNDY64MXzl/oAFtmiy/T9z2c=;
 b=W7Q6ieLo/bL79byUCOWjUCZR1tOqr42QDlkJ6GMd4wwCAeOje3tuQ1MVUiarJHxVA+dTKvn9dQ4Q+SUEDFHi4YYsQ/nSERw+33OZgztaaYIl3w6x39BxTkLf4o+rpb5hUstlVUXvDFGgYZhYg1zPiuTmhagYnChuN9xFcyAy8Ww=
Received: from BYAPR06CA0034.namprd06.prod.outlook.com (2603:10b6:a03:d4::47)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 02:25:47 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::a3) by BYAPR06CA0034.outlook.office365.com
 (2603:10b6:a03:d4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Fri,
 24 Jan 2025 02:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 02:25:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 20:25:44 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 23 Jan 2025 20:25:44 -0600
From: "Mark Hatle" <mark.hatle@amd.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel][PATCH] runqueue: add 'default' mc translation to mcdepends
Date: Thu, 23 Jan 2025 19:25:39 -0700
Message-ID: <20250124022539.1504699-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Received-SPF: None (SATLEXMB03.amd.com: mark.hatle@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eee030-925c-47a5-a693-08dd3c1e6935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Edchh2pR3u4Jkg2+WD6K7rp9wD92DoFoEkpeyXzZ9sT1Zlos5AM0adiDc2QQ?=
 =?us-ascii?Q?GSR9nkqz/0Y3q7DhXyRkh99rQpVXUDdSbjK3f8BErf75IMKFXdJNA7XY89bf?=
 =?us-ascii?Q?67VSbaAfvZi9+V+r0p/LDcAXKxaqXaGRiwKjPn4uELT/B0w44eYHAtU93AwV?=
 =?us-ascii?Q?9aw5quo18BEIwZjQ+DYyHFipKRBTCQ6YSQ28GHyaK1jkWe3Iqjeh19+XtocG?=
 =?us-ascii?Q?BYzrcg/PS7+rqcuvg1iZDNaHkjw+eMu2gQBYWrxmUZz8fr0oxrzPR27IQeIv?=
 =?us-ascii?Q?mHQwwW8vReezND8LM4JAZQq+7hqODQUadVoHol9gvOhFgdElLSfv9og8YemU?=
 =?us-ascii?Q?xQtymGPLpIji6IuTaskmNxaoA6AjGk4ZFhkuRLl7WR7RNcA4JNecRIlOev4d?=
 =?us-ascii?Q?9bW58YWVIQ3g8QnSYe9QrgEssG9pkqdDJBn99UYzAEZVx7mXJ+zWZ1OPWo9O?=
 =?us-ascii?Q?Yuz001zPLAy1ln8VGFGPB03cqnnbGzc3tdtUWW0+k6yyul0wS6EHC8mkgFcj?=
 =?us-ascii?Q?5wk/bGzCeLsM4NRlqIxWegIVFcTViby5qFF8h3FeiI3PIwwrhrJEiuNSNoHN?=
 =?us-ascii?Q?4722JQnCAb6Nzk0RkgkNnldQpzzF4am72gvIRjhShgVUkIHi0BRXNllQNqEb?=
 =?us-ascii?Q?so6lqc/N2pbzoFj6bmZlv/y2EaZ/BsLlHqIwQDWi5tbBukitZcN8jjyZqgps?=
 =?us-ascii?Q?3v64v2hEPhc19eGZBz3Jbb0D29ZU5IeKzEzAlqEqfb4STbftEh6J7FMzot8k?=
 =?us-ascii?Q?sncSCYqApKiaIrBbzjnImBIAom0u3Xo8pdCg1ZZS8NNP/oFmh0LoWCSAGZTf?=
 =?us-ascii?Q?auWw3VApvMsoKsu7ijHqmwfQcywfBaUFWK8vosWM8HvS/qWsQFou+i9+/m9X?=
 =?us-ascii?Q?qVgcomzfFYZV7Tpgvngxcq7Ew5/gNd7BfW9nrRNoygm5243nrHQKKH9fao5a?=
 =?us-ascii?Q?B2yRmX7VWszyvFURJ9rHsgs5EHNuMO4se1elilSmv/wdf/pJaltobyCiIFyg?=
 =?us-ascii?Q?0wPQKrIOod6xBBLUcm2hjtr/YcFM3pWULig/RaXZv4fiB//R6tOTE2TRP1eH?=
 =?us-ascii?Q?GHWtN4t5a2ZkrmG9oHTrf3NfajN/pHM7jBK9gTHMUlIgG7lfOJfadVvIiEV9?=
 =?us-ascii?Q?sGCJltHPX5kiuwRiNUhWtLlXqe/y3p6XWxeoWx8CzW0XE+PM00eHNx+jXzfq?=
 =?us-ascii?Q?HIatHuyHf5cE+UWF/vyt8kl9vP2k3J47DzFwds0yxoCQTQdVyAnqCnLNAbRt?=
 =?us-ascii?Q?bPR+Tzbj3ZifHyYwMcUbJA4CNH4sbz/GWIgktbxHYQPqKj6YilvZ0avaWvnH?=
 =?us-ascii?Q?7m89AEr2uHz5VIcm8xAePNR5tBDMCA7PzdLdsfx7L3YQGSbI7OPk5etUPef3?=
 =?us-ascii?Q?JT4lZ/maBmtJF4tY89SKeOC4BoqBMN5UvKRnKXVDZNaUdNOGJJ81M3PmR+20?=
 =?us-ascii?Q?6/oH9i66HwoknPdhouC4OfKlO4r7gT0ieZ7ip74QvjKjol/TIqmuRQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 02:25:46.6725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eee030-925c-47a5-a693-08dd3c1e6935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jan 2025 10:28:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17091

The default mc is '' (blank), however BB_CURRENT_MC returns 'default'.
Allow a user to specify a mcdepend such as:

  mc:${BB_CURRENT_MC}:m2:recipe:task

Both '' (blank) and 'default' are now supported and have equivalent
meaning.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 bitbake/lib/bb/runqueue.py                        | 4 ++++
 bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb | 2 ++
 bitbake/lib/bb/tests/runqueue-tests/recipes/h1.bb | 0
 bitbake/lib/bb/tests/runqueue-tests/recipes/i1.bb | 0
 bitbake/lib/bb/tests/runqueue.py                  | 7 +++++++
 5 files changed, 13 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/h1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/i1.bb

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index ffb2d28494..f941749b0d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -723,7 +723,11 @@ class RunQueueData:
                 mcdependency =3D dep.split(':')
                 pn =3D mcdependency[3]
                 frommc =3D mcdependency[1]
+                if frommc =3D=3D 'default':
+                    frommc =3D ''
                 mcdep =3D mcdependency[2]
+                if mcdep =3D=3D 'default':
+                    mcdep =3D ''
                 deptask =3D mcdependency[4]
                 if mcdep not in taskData:
                     bb.fatal("Multiconfig '%s' is referenced in multiconfi=
g dependency '%s' but not enabled in BBMULTICONFIG?" % (mcdep, dep))
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb b/bitbake/li=
b/bb/tests/runqueue-tests/recipes/g1.bb
new file mode 100644
index 0000000000..20ce8dd3ad
--- /dev/null
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb
@@ -0,0 +1,2 @@
+do_build[mcdepends] =3D "mc::mc-1:h1:do_build mc:default:mc_2:i1:do_build"
+
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/h1.bb b/bitbake/li=
b/bb/tests/runqueue-tests/recipes/h1.bb
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/i1.bb b/bitbake/li=
b/bb/tests/runqueue-tests/recipes/i1.bb
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bitbake/lib/bb/tests/runqueue.py b/bitbake/lib/bb/tests/runque=
ue.py
index cc87e8d6a8..cea2ca13fe 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -314,6 +314,13 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
=20
+            # Test that mc::... and mc:default:... both work
+            tasks =3D self.run_bitbakecmd(["bitbake", "g1"], tempdir, "", =
extraenv=3Dextraenv, cleanup=3DTrue)
+            expected =3D ["g1:%s" % t for t in self.alltasks] + \
+                       ["mc-1:h1:%s" % t for t in self.alltasks] + \
+                       ["mc_2:i1:%s" % t for t in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+
             self.shutdown(tempdir)
=20
     def test_hashserv_single(self):
--=20
2.34.1


