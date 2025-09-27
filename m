Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E74CAC5B9
	for <webhook@archiver.kernel.org>; Sat, 27 Sep 2025 05:53:55 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.25])
 by mx.groups.io with SMTP id smtpd.web11.6607.1758952430301270657
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Sep 2025 22:53:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=Tytsec4v;
 spf=pass (domain: axis.com, ip: 52.101.69.25, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfqTOFnzqwrAhGjhvpQ72j7bFSkH8rTljKFEzrjoNS8v0bHLgFCkIyrFGQcGJi1+G5WDpU+/KcoX93UOzh+MYoV6QwI10fLAEw+klkWHzdbFw5bEEyzv4FibAjPwo27nijdS/FhIPyMTQpr69lCze/djr71MDFm5O39mjZ+ui4Ae1xOXsKEM2Q7JVWEOYnfolWPw3pSQUVQghAAn4RvUTyq+SYF/aJd8o/M8SObsQyjL1nG4rgTJfGfOpcLqs4frzzKy/QqZ6AZZYYQVEM3FKRyXdEAtPHk/ruvTGjoRs8IlBRQJvrF0A6rI1BDVhGrv2HBXg2vz2L0WIHz05gKxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXirjeqIoBedCh6iEfVkhv9wt2jiNVFQ2/t4a5//TYY=;
 b=E/G5/no/d8edLn933/etYIFFQXPs77mW0OwOT2EF8UTI0H87W9LgaRWXo9iHp/uIYxtMmuJ9GbrsOWIH2iK42NsNATqmsCRfKSgCRh4AIPFHtiRJnmODw6zC7pvUJZz2gXPAE0+DVqQbUR/Se/SLfHzX+ABebd7Swdu74hFCPmiPUjDbu+Dh/T1ymEq92Euxx6CAEwEy2lELVEO1/RZ6F8cEHtyaXTJE8RNCWh3JLt8LGzuuBBbGKRaI3vKr3m/uZ3/2RCytKz8tpNuVvm/ZLa6tHm3KCoQ/Wq2qUnbK/v9NXbZmo5VSBRNZOwiDn33RsKfw83MnMzqp3ULtKqfUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXirjeqIoBedCh6iEfVkhv9wt2jiNVFQ2/t4a5//TYY=;
 b=Tytsec4v9OFJw4sfStUZ8dVraEobzJD1GjuIvstFxZjNqsn5YvBpumACnnPNzd5dUDHTMWICqaP70WcrxxzTZP2kx7/dM1w2bDTDMZZV7V6Pu5+Jd+rg48fhLHw4Pe1XMUUx7sF9DLl1aiOt6Q8tOJ6yz9eqptagN6xLOhoRxXo=
Received: from AS4P195CA0028.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::13)
 by DU0PR02MB9548.eurprd02.prod.outlook.com (2603:10a6:10:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Sat, 27 Sep
 2025 05:53:44 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::65) by AS4P195CA0028.outlook.office365.com
 (2603:10a6:20b:5d6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.14 via Frontend Transport; Sat,
 27 Sep 2025 05:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9160.9 via Frontend Transport; Sat, 27 Sep 2025 05:53:44 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Sat, 27 Sep
 2025 07:53:43 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 27 Sep 2025 07:53:43 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id F3634862
	for <bitbake-devel@lists.openembedded.org>; Sat, 27 Sep 2025 07:53:43 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 056A7120453; Sat, 27 Sep 2025 07:53:42 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] runqueue: Make the "Initialising tasks" progress bar finish properly
Date: Sat, 27 Sep 2025 07:53:39 +0200
Message-ID: <20250927055339.2472285-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|DU0PR02MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf50de8-5c08-4b3d-7acb-08ddfd8a3803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p5t6MgrqUm3ciak3ys4+X4qZBVMbL+t7v0KHqV4JaAxL9v43EfRog34E6T2w?=
 =?us-ascii?Q?RCUUu+nCm2aEhnLZUSVopbJ50ZlkI5JG4ofyXywkkRuqnw+FeuYK9levqOKN?=
 =?us-ascii?Q?BwPoBUGRp5e0y71Uk5g4qgP8bD0adXnKmOiMdepWVVTnDFCbYqRiZEdT7odX?=
 =?us-ascii?Q?ErcxDsiPtTQo2uMFfCZxYY/ms5VEMb24u6ZngofuO5SXP4ST7DR5ieUuoxDw?=
 =?us-ascii?Q?3jsZi79Fd58KI4NiibWslgqfhTXjiDOMFCumaqPiMTTIrRiBRJdqgwDz1mRB?=
 =?us-ascii?Q?c6eiViLXF78UWCF1p/ELqBLbce8rDLMvi/udedZzpp/gRMFKv8a3+rK76cZA?=
 =?us-ascii?Q?V/s6lNvGYFwsb0RoFBJRyv1zsG93oePhOxkHpdHS9IRZf0Tbmi1tOs877kSV?=
 =?us-ascii?Q?BIgNoJN6CkIVM0wlwSbdq+p2JoM65n9DSKCj4rbx+tIYsgrd+gKXAcB5mwav?=
 =?us-ascii?Q?wzSLDG8E9dDf04tecqRN2jz6tjsc9cxxFTMNWZcW9uqXakQXxVA/j5xrHgvh?=
 =?us-ascii?Q?tWuN8gc9rS2/GYeE/8piFnBWbGX9LIQtld9IIdzrsrrDEzdDgiysN+CsCBTC?=
 =?us-ascii?Q?8Nl6AXBMq3LscgzVHiIj3oJU9ev6p+1FIB1LTIcbyYw2POUJt1UKdrcJ5FzK?=
 =?us-ascii?Q?Pwcohvk4p5UWbxrcMM6Ih5CONh/pd8aBxifkw5Hgblp9ns3MKg4FZd3pAbZO?=
 =?us-ascii?Q?josLIqipNbwLQpOGUFG8aVZG63dRvJqsZOqHY9qM2aq1THPApB1Cg+aJGgfd?=
 =?us-ascii?Q?fwVH656b/HhFniHjI1vbnqasvPupfsk5+pclDZEcmtRob5Qcke0yo+KEXyMj?=
 =?us-ascii?Q?xWI3JFUhjntXNkq7aott2/CL3aIMglwuBR2u/1lmAk7ahO8FMsIDqQatEUu/?=
 =?us-ascii?Q?TO5akC3dFoDEuKYaU8vnSG3j4/AGvT4zElhJIbKtbWmPtp2FYOuHwi1x5TKI?=
 =?us-ascii?Q?kru5lcQ0WQzaBy3iP95BfZQY18XVIF3JdVo/D24GgVXpaA7VQRYI0JjSJ4zg?=
 =?us-ascii?Q?hVcnE34TWtvORWcewvABkhapkTm8zZbfbbo7ezwSXZtKhJ44h70PQ7j80TS7?=
 =?us-ascii?Q?PtmiLr7MJ6BH4reYfbXB0iSLb/4o2Qko6wyS7xmdhTr2h6ZYz4t2qCFtgURB?=
 =?us-ascii?Q?pVTq+ytHzYgfKQbLc7Nhx7JSt0b08XrQsYgnBYXcvKLvimizWwwC/VXkaydW?=
 =?us-ascii?Q?WXv0CHoGEyAq6RuOzOLl/lwOICqDjqKu7ZlKbysBdjRtlfiAlSbc+bVusxW6?=
 =?us-ascii?Q?iwMvRHLpf1JU5bTu4J90tZxL8unQOes00Q7q1cvx2KBlwiuDWxgSmiPzQUNx?=
 =?us-ascii?Q?jGJJwutFy4ZzpmpNCzeJs559avDQtIgjqktG/m9rii9m0dCTMx6f4MIUuL/6?=
 =?us-ascii?Q?E45d8rH1qknRFRbZo9cEtt6XMopJ+G87nVAHWBl8dTNFOeNVrCqqWZH8Dvzt?=
 =?us-ascii?Q?D4a1tj4RkJ48WnRJyvhWsnp7mT2EDHqHZJIZvyPG6gjLazCWQxyC1j5dpWOb?=
 =?us-ascii?Q?YeFS0J3RIIT+ukRD3pUfI2H8nuYMnluCFbf/3aGTnglDYfy4KEEeIbfp1OKH?=
 =?us-ascii?Q?3lI1AXMZf/nRYFEYcKw=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 05:53:44.3143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf50de8-5c08-4b3d-7acb-08ddfd8a3803
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9548
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 27 Sep 2025 05:53:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18097

The "Initialising tasks" progress bar needs to be finished before
update_scenequeue_data() creates another progress bar.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/runqueue.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 63d4edd892..96d70080d3 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1610,7 +1610,6 @@ class RunQueue:
=20
         if self.state =3D=3D RunQueueState.SCENE_INIT:
             self.start_worker(self.rqexe)
-            self.rqdata.init_progress_reporter.finish()
=20
             # If we don't have any setscene functions, skip execution
             if not self.rqdata.runq_setscene_tids:
@@ -1948,6 +1947,10 @@ class RunQueueExecute:
         self.sqdata =3D SQData()
         build_scenequeue_data(self.sqdata, self.rqdata, self)
=20
+        # Finish the "Initialising tasks" progress bar before
+        # update_scenequeue_data() creates another one.
+        self.rqdata.init_progress_reporter.finish()
+
         update_scenequeue_data(self.sqdata.sq_revdeps, self.sqdata, self.r=
qdata, self.rq, self.cooker, self.stampcache, self, summary=3DTrue)
=20
         # Compute a list of 'stale' sstate tasks where the current hash do=
es not match the one

