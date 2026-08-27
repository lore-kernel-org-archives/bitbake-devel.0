Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F99C61DD6
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:36 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3447.1787861255347863697
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=qKIhuRu1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.200.31, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmGdSh5tqaF2AS9G2xKPaCgC+ssJE1FHx0xPgM/JiQBzA0Ep4sTl6HEelbOKEIGL4pjvVCP1tVG08BhEC+M+pI3im++0kR4FQIeMHWjU/4I5nIILekc5aLfxf7m1Aq2yIDkohhXi3aiMMgWb2W3ZZEWXcKcw3wDCpsRNb9mo66Q1SUJbud0WNZ3hLj3+QNsS9pUuvEooAlu9DcRDyibv+wTKna+nlt7ly3RTPZby8bCHAVOyxY/ALqcN1oR7z9u3a0kyIJa5lMEiEsbNQmFfdqJ3hozIQdaGTMiUYd9FSwKq0bubIG3mTpvr/vfLKxX6OpgHsDyoIdn20ZiWvC5KAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KfzDITMcT/dMOtgAorjEMl11ILAgKuBKO0ANvlr+DU=;
 b=akTM6LAeYJ651LB9z6xZtklRHFDNgmroNdkp0+eVw8koa4rLmVYoKBycV3nCULl/2xibUxDjE5Z5mFsF3BM9sMMPimQwTuCfAsSADSfo5WM0LkpwcdBTJI1iX7aD/k/QdKtx7lmFRqtSWXAKezWE8vIByBOdFDsEX9lQrfK7MTGMsBogI/jjZDXSJbYIL3006zyo0mfjwj1XzoOPTTA/J66OX+4ruC8IDp7FMXLsBTKT0hx5wtNzPGOkrK842tNd/uTIOv8Kom5CAZ3jJ9iIPUm12pnzwYbYlw+wtmdETlqrL8veUfMY/iDUjbkczkRLHDvB2mTQ5rufbfGmzRdbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KfzDITMcT/dMOtgAorjEMl11ILAgKuBKO0ANvlr+DU=;
 b=qKIhuRu1JOipTw/ZnugRENikTkV1L/5ZjgjpuKke1u71whRemrs8gHvJjKpjyGmOS22CWnmD3zgUmc/gZhzwssMhhYgiJkaqmhymnyWjSB3Wh/OlIIIvzvjebbS5yWLO6Y6hOYaySy2cq2ayhc53Elx1AW8Av/cm28nyrYL0Cnf5JW/7OMtvIGKBVwSTcUZ/CqqlBPdDvBZrW2uAYA0xO8RfOPsBP3t0M84GWtncSaMIQD6U3AxU1I5TM9OepkhLecI/lUgnwG6yM6LVWnot0mq+to/AnnOlNn0cuXGTnUysMbKKxN+xJZEWHELQl7pRBDoti/6tLa2hFRD+EyifjQ==
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 20:07:30 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::82) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:29 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:03 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 09/11] runqueue: wait for covered tasks before setscene
Date: Thu, 27 Aug 2026 16:06:01 -0400
Message-ID: <20260827200603.688796-10-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 196bd5cd-a237-4ff6-c16d-08df0476d2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	4CXwG4BoTYpr9vcZVea4Vs3WZs/tzcp+oyLudJlCY/kbHgasUc8WXJoHiP9bjY8mxgSTzA39dw4wZCUHKdz/ooJtsEeZ5YB9n/rKQK4gDlcnCq2IZF0wFkWTQAULjnaamnZDyR++HxWC6Ubg/fJYguv2rhHeRe592P10oG7YxRigvH4li+zpUIepy9I8WXwPCWJ07Qq+iR5Yu1VmJEdvtVgxMj/VZQWCcBEDN1AcA6oBOrEQMeJyn8Dea2nZnBaMDgrEH4IXp5aJub3tVyL3qC0q2pZxzvS/0wczqh7qAvddJewyyA0fMtH2SvBArMox7NOZJNqnIVRTD9lm186ihqnaem1YnHhnTukJIKEtVhDzU/E7giEZ1V0+aZMTZwwHlN1EfiaFkVIIbzYrCJIQ6nFFfSoj9wLXHj8HBtjjN5BJQtFjrmLUfsfyJqiJ52SeTH78OwAVP4uJ+6akY22U3s8H5Y0a0oHmBfjBeUvhyqLLfKFEOgGUQODJOv0aDOfV/mnVezMxjxHhpV0NEBK6FcOQjEcy7gH/y5PmNOgWqsxDxAzDUU/JjxtMPaNSmRhGQKe+pivfzdzvM45592PAwiNiRfLeO0Gs7CYK8YDM3U0CopWDUbJRn4ezG9svsiEEWoJqgcqubGHnuE+OTrTiTOIQFNgsTn4dXlbNDzoYNX3ox0+AJGvBGxAExghYtXNFQpiBkrzbab4kpfrcAqfcjg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	10aAme6QaP03E9JOL4pmAMZDLLQGiCC4RScME3ekEEAIe+L2WHDGKr3ShUeE/tYPKUi2He+Yy1g5OWgmzxoEC5G4XXcHMC7wh7pjhWxAO5yVD6MTSVCloF/SAh5rfQHXGTohHGufnu2lzXPIYIsF5VBbJnO4Rjf+D1sXLTOUURv4isPUzz1wbSneXyUJ9z+8HdlBWVLGxXku6rSfoDaqLbbWCRLwqN8P5OKx+fsiBz5SO8JnyZgX1eDq1wGY+osGxqrMlDyN5oXTCUBUIFXb/lX/THhhsztk0SFACxy1Jvn6WXobixUKsTFKwoSterP7n7EpjoRcW8z4lXIB/6Q3dp/0ISiSW80XZmfFJ/jFgb7CCxc71fOf2A3TZhnwIqkulc4rowVPY4zjAY6aVdIOv7IcbImUhlXF6/HLZ6c/MDAjcpE/m3+CPdO7Sz53Q8d4
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:29.9813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 196bd5cd-a237-4ff6-c16d-08df0476d2e9
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20083

From: Chris Laplante <chris.laplante@agilent.com>

The existing continue only affected the inner loop, allowing setscene
execution while covered tasks were still running. Check the collection
directly so candidate selection waits as intended.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 826801855..7de6c8636 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2252,9 +2252,8 @@ class RunQueueExecute:
                             return True
                         continue
                     # If covered tasks are running, need to wait for them =
to complete
-                    for t in self.sqdata.sq_covered_tasks[nexttask]:
-                        if t in self.runq_running and t not in self.runq_c=
omplete:
-                            continue
+                    if any(t in self.runq_running and t not in self.runq_c=
omplete for t in self.sqdata.sq_covered_tasks[nexttask]):
+                        continue
                     if nexttask in self.sq_deferred:
                         # Deferred tasks that were still deferred were ski=
pped above so we now need to process
                         logger.debug("Task %s no longer deferred" % nextta=
sk)
--=20
2.43.0


