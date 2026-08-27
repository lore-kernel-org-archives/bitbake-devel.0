Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F91EC61DD5
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:03 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (SN4PR2101CU001.outbound.protection.outlook.com [40.93.195.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2.1787861875422864646
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=nDjG6q65;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.195.65, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F00yaxrdqWGjj1PKkat1jRnZDf8HUl4LxEc2hf7N5SCkmabD04ArFccBZvpm99qYil69w/nztq3bJtnw+E3k5VSkP6XQLQRfRGozs0wNAGZRYs2nOVC0rdY6Z+Kb3pv8lcgPrLEy/eAVMXWr21Sf4N1o1+xlYtROPf2RQDhWGRtVKMrtYwUXZqDOWoRQVwRXBNYERX4ATaoM8jGStZI7AFKIWnw89guGYFlJiOhehJ9wbyzZOo42KWNf//v7tESR1OVex74k0qYE3zaJmJjvmMHwoROG2+wdZBTaAwPZOVDEB+1g+dL6BSIv5gRmPMFOg3S9GQb6AtYPzQakX9fy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khRz4cDKQVws1dZjEqYWy0Muu58KpGUqNR6OjOb+PTU=;
 b=weWqexyfYzf8QRy7r6pYnJF4IsmgaGg7DMiz9+FX17K75EOlx8zmV9EB+ENfeXmpbI5Pi4vkx9+xhqoIePBvDhM3+uB2aB9VvC2AFwvyzsVwtDRLiXNc+OsikG968VOflUn7M1FAw+6X6tVqxflg42gHL3ndvccVgC1VmJpYSiP5+N5wD+ZWoUVZnll8fIecixoUTA/FuERXFY0E/SnlAsqo4WetZTfi4Kn10X5h7qm3whUt0FUov7mf4niWcnyr83BrN1wYEJflyDvtetlxukjNrIroXz/OdfkVlgshOOdZoAHvUsU+RhIIdHNTLtpvGAwTCZGLriO7rDHiX203gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khRz4cDKQVws1dZjEqYWy0Muu58KpGUqNR6OjOb+PTU=;
 b=nDjG6q650YAz7gG9qpd5xUiwPIe+P7BTg26iWUXpLwFXfiSAdp+xK9UHAC76aaFZ9ScgM4AquhOVuWCYyhI8dvYkrgpYD5AClMErtovNq6lcFKeeZasz6Ib2uvgvoEZIaeBqfoE3oK3HTJN3t95FY1agdCdPPm2V+/tmQ3AwG7bmABu+EYLRqTQwOcTl4T0RbLbM4eC4bQBmXuo+XatYuTitOmLp96h0jNd2YmYt3gjfPCNmG/G6k1qZCpn2/votium1uBJosiX2beieRUoO+Sztim8tJWbpZQjVz69UXKYaD5gvrgxuWRyIcCsKrNAtby72Nhe544FanJCuYlYmxA==
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 20:17:50 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::5) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:50 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:34 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 08/11] runqueue: fix remaining attributes created outside of constructor
Date: Thu, 27 Aug 2026 16:17:18 -0400
Message-ID: <20260827201720.698482-10-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 125dcea9-3cec-4e3d-83b9-08df047844d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	vPrdRI58doRSssfCnfit17vrBauX2mT+XXDh5U1aiQq55P2FMdWfAx998yUGR/oFv9nDuiR51AbamqofsA4Sh815qqA9DD9Ab7JWS63Y89BA4Bjy/fRa7+t3SXT3uEzbzIJWu0UHSqv8bkDvyMucKrKGfa608KnISRN+CUv/t7ZZ4Me/TkXLnBznWEnknNG03zjecXyon5YED6lodSmAacr3iUcj9WfW3vNT0lMNMooDquOP74yjPcXXtbAi8S81LgZKzuvVWCc7ixB+ou4vlXiXUJeKy4wN0godW64mx+/A5h9HbN71IoWw5pT5RGjA7nYl89RvjauVrNRVZj4tNsSc82Ebx5YMy92Su485bX4hFwFxQ1uyGz7vuiotK1P9YbHagUM6UwIho2N+Lpqn5tyYCpUXuXbWQBcmQoE6zC3pMQehd5+qq8h5cZGeDHvKBwWfjpg/ZHzwpL87BmdvTHrFCuauRMQrGZUcDp73Vv9lJJQqBM1Qn/SlmGhb4DvYmrvO4T+OqpwVHfdKgfcj+ciIhgFu7B/1nba5ZtPK8K/bmngA0o1awPrHNI5RBOHGzNq3eg5gX8hMGVoVmw8A8LEoyDmaYWJzLizXgpLpmhmpEX0L9+rgSByFiNSF6VgWok5ptM8OHnxA12kxbSCNI1jP5ZyjHKlIn762PQzlL2oQBLzBvzo8U8MACSaiShiig3mnvFDDENCaxXkslbA6Rg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	DDdRfbZRXbhy0Y75wBsU8pXgw6GBjKuBQIdyt2xnLh8gsTX3rloVj2ND+XQoPf0mq1hegradFDbiLJTHEt7ww9E4hMOfeLfTAhHt6BJVVKoXkG6eSUfCx0Fo8286+/KbsElHBSgh0rV5rvA4/+phApAC9tFslb7cKfrFNbzRDUUlsxZjJnhM0coq9/WDUlfG7ybO90yYZutD30evummkIXJwKO1+LUaKBVOgfPpmk+zGXkEWiCMaw6vLqldcdEd2BvLz3/lCLqWBmzkv5Kq5Lgb4rnegE+QNn00kGext3xIvZef5WhlHXTrnSMzVs52LZ8S+rH5vUF+tkmev8PtiV7Zg2E9uS+wvf3CniyER7W/fmKgiAYMJVSHVcj/VIVyQZ0v31UihfYZUTrTg01/k8LTAPgzpBk6YjGolrgJJFUl6bLBVZwsFhZ1FXbRI6NP4
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:50.5631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125dcea9-3cec-4e3d-83b9-08df047844d0
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20093

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8b92ec7a9..dbd69b055 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -488,6 +488,8 @@ class RunQueueData:
         self.setscene_ignore_tasks =3D get_setscene_enforce_ignore_tasks(c=
fgData, targets)
         self.setscene_enforce =3D (cfgData.getVar('BB_SETSCENE_ENFORCE') =
=3D=3D "1")
         self.init_progress_reporter =3D bb.progress.DummyMultiStageProcess=
ProgressReporter()
+        self.target_tids =3D []
+        self.runq_setscene_tids =3D set()
=20
         self.reset()
=20
@@ -1354,6 +1356,9 @@ class RunQueue:
         self.rqexe =3D None
         self.worker =3D {}
         self.fakeworker =3D {}
+        self.teardown =3D False
+        self.invalidtasks_dump =3D set()
+        self.dumpsigs_launched =3D None
=20
     @staticmethod
     def send_pickled_data(worker, data, name):
@@ -1697,7 +1702,7 @@ class RunQueue:
             bb.parse.siggen.dump_sigtask(taskfn, taskname, dataCaches[mc].=
stamp[taskfn], True)
=20
     def dump_signatures(self, options):
-        if not hasattr(self, "dumpsigs_launched"):
+        if self.dumpsigs_launched is None:
             if bb.cooker.CookerFeatures.RECIPE_SIGGEN_INFO not in self.coo=
ker.featureset:
                 bb.fatal("The dump signatures functionality needs the RECI=
PE_SIGGEN_INFO feature enabled")
=20
@@ -1891,6 +1896,7 @@ class RunQueueExecute:
         self.holdoff_tasks =3D set()
         self.holdoff_need_update =3D True
         self.sqdone =3D False
+        self.taskdepdata_cache =3D {}
=20
         self.stats =3D RunQueueStats(len(self.rqdata.runtaskentries), len(=
self.rqdata.runq_setscene_tids))
=20
--=20
2.43.0


