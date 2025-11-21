Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1440CFC50A
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 20:45:58 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21160.1763757951286506002
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Nov 2025 12:45:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=PlMQg9Bn;
 spf=pass (domain: axis.com, ip: 52.101.66.4, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WykuZRxjcRSqjMUkD6oqubZ8IrVSrBuObys7FVSYfS/CtpoPGkZyVZ4JApb61bJajqWoMsvDR+5103ekLJYS15wTjVblNtVtWhViy3+2Ed1g8a+8BdGx9oQWIu6qNybT7lDMvvpsWQme3EqE4lKZmzOFBi1IpGv/nczY9Olv0cIIRjIK2jjFcGd9YzsTDAhV0XpNpH/cQXxK98X5uc+tRMNh/W9mhwu4yETgTD/CUCa2r25GArwE11yS/sRv7NujLWRMaIn9DtqI9rFFrWlDbL7PO7lkCq+lPnQC5fDO4qBjK6nhW0zkluaw0cQoG2XcGRGdFlneRwVSc5n9rnl8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fzOTFDxGmRfvw5AyO3elJ8u8ffeJt5wMnVvO3QFLx0=;
 b=Iqle79gFzSmtCVPzdslprcxkG90OJp9G188uY0EBJr3LuBu5YmeB59f7CaeTamXVPbVAFjzQzmI4Y45VqZzp/SgGuaEc/uuZwMgVNZFkpLeEA326+YqxEnBUfq0Cv+DPtS33m+uBfSx/G3Q/t4HXiYYRny9SJvHfAJ08qLRreUMPQhIgAE4tRvLSBYfRhtUffYUYU/iMIz/CgczDqRyZtOd1tOtvYoEZFTKK/Bl5aZYs97Eor3krZ1Hjos58RMuaflPHMxBKZO27z5SuVh94Yvcx5v1fjAyjbsuoaM2fGawUBiyYHajGR+F3khD29BXX6WJ5DQr6/WOFuUubCCs/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fzOTFDxGmRfvw5AyO3elJ8u8ffeJt5wMnVvO3QFLx0=;
 b=PlMQg9Bnl+ZoP662dsOHNHIczUSIgIOLm/E5ryP3F2biawMLRgS/QGR4kPWGmWG3GS5TdyF3mQv+UspyRTMwprybiLawu0V3KYj86xPDuzHaL/4iuE1+Sg3H/5J4kXDZ1OJGpT9MEJ707TDoUzxkwPZdj+ET2ODXnLf87A+Qckk=
Received: from DU7PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::20) by DU2PR02MB10283.eurprd02.prod.outlook.com
 (2603:10a6:10:492::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 20:45:44 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::99) by DU7PR01CA0023.outlook.office365.com
 (2603:10a6:10:50f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 20:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 20:45:43 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 21 Nov
 2025 21:45:43 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 21 Nov 2025 21:45:43 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7F8335960
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 21:45:43 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id B696F12031F; Fri, 21 Nov 2025 21:47:32 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 3/3] ast: Improve output when a fragment cannot be found
Date: Fri, 21 Nov 2025 21:47:30 +0100
Message-ID: <20251121204730.4057465-3-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121204730.4057465-1-pkj@axis.com>
References: <20251121204730.4057465-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|DU2PR02MB10283:EE_
X-MS-Office365-Filtering-Correlation-Id: c2317385-147d-460f-3f2e-08de293ef0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yQe8+8d9H0iCK4mXCaYczF2J8EGn9FDcC8yO7hJCAj0zMjf0EOvzqflRxPIa?=
 =?us-ascii?Q?EdKHf+1chnUlHgG3gI4jLGq+iLnv4LS/P8WzW6dyr+wb0p9+BUNQxMOruMSD?=
 =?us-ascii?Q?H4MDyvHrAPsK8iRLtv5Q9gyKs6bXsnxgKrsM3a2OtSUgAIWznDkeuF63dzWa?=
 =?us-ascii?Q?MTzeoKM5FZMWOjt2b9ZrpYGDpjFcLsNtbmYShZdFBMUR9gxI2RHR1j6ANMZy?=
 =?us-ascii?Q?QacTaF3D4b2+EoH3iVgBe5Cj2wLhEzcQeb4Oa/KNnQW9laZ7e/LR0LnQyhDf?=
 =?us-ascii?Q?5b5vPzliGZ0UwqEKIu37ylmfAKE0cQerWmgRxTl6hw3Dfgov6ngnRISKWDdA?=
 =?us-ascii?Q?uDmeq4nITnZNYlPSp08wP7SNdw2/K906fB3efZBCIiI6OElm3gLRAlFX1Q6G?=
 =?us-ascii?Q?UlQL4HkPRW/0QFzo33p1sCl46solJO908z59zBtmOQLqzMb/6HUp6SWWiZcp?=
 =?us-ascii?Q?T5AGrSXFTVd5+bUJtXs/LrzQQmgNk5a465+jSFHLvWxABc9HKJ3q2C/mjK+V?=
 =?us-ascii?Q?I5wgjZZXPOKi0ZQ+hjds8GWOIAhPDy1PQSI9hnu+0i5v4JUiXqZLicInRGcU?=
 =?us-ascii?Q?2vOl9gMVcO+PryQH2Hn6Ql6dJA/wj15gSUtU7fJjvMP7poU97Zg+1n/NJbvl?=
 =?us-ascii?Q?FTLna8BHgwclhUmw0f9VQ5JUZE5rWFu9LtYofdfu7EjoTs/57QOZtED34pkj?=
 =?us-ascii?Q?sMUqKvpX59dVCM+y6E6gkFwHKiH7/Ahpl51z7bQ3jMO0P8aeZk00G8UMzpNk?=
 =?us-ascii?Q?Njwr2grKrCaiaalWfcZjlOPfDAuIaRsTka+JVFC1nyU5r5YbK707zgFKE8TS?=
 =?us-ascii?Q?ynRnIfltTVSBINmm3D29GaVIfz9f7DgjoCqb4ikxvv6bL2HIpooVP37CEIpT?=
 =?us-ascii?Q?MzOQmtJZ0SNcTXHF/HIf0NDZaj/N+TuJrX/g6wYktpqPmTyMqrgZ1Af3g5o3?=
 =?us-ascii?Q?e6tRsok1Nbr+CHqeIp/+xiQf0mmWe7SUz/2/vrz5Ccz1aQX+Dkg3d0j/O3bu?=
 =?us-ascii?Q?ZSaTsTzdXYp6Kg4ek8Ys2QRMCgbrskxe2aADK2MSiLp3YS9H4fL0uVz0k3Kh?=
 =?us-ascii?Q?AGaGzcEH/MudiGGzMIEqhGQXPDnT9EMW9JRSJ62L5mR5Z96O4LwQTwxYXQTg?=
 =?us-ascii?Q?KVM2jSq9tdUJiZ4GuMAlGGaFfro4nF7/JAxQK6zbK9mVjT+mnhr8kNYC3omk?=
 =?us-ascii?Q?WWT1nrsZm6o/C44b2HbTPD7xXg/ovHMtoX08GKvgocEnPt6VKM0tPVhegTjE?=
 =?us-ascii?Q?Q0rkJWBmDyn4cAKzCMC9DHvhqy5kQkDJyzcEv7flTSofF2GyiQ3bUKlG0BZU?=
 =?us-ascii?Q?HglO8nYQ11Xblhh4ycWlXloR5r9hKQ00KeNQJZ94AFISz8bMky7Mo7KBvOB2?=
 =?us-ascii?Q?4KyKu0SIQM+VtO/36aUGJl6W/aEaOpZoXDTEj9ql+QsLE3FQgp/zHpAq8IVd?=
 =?us-ascii?Q?q7sFqSjhNWQB/eKqMVWEd3A3d5Bo3qLwB7gANgOEfp54AN//KjOweFjLjTzN?=
 =?us-ascii?Q?t+e4UEfEe0j8K/pPceJcFTR2dKhpeH7mavnzitCapufjundJN91VHdjpym5o?=
 =?us-ascii?Q?PdmhyeTxJOplkWrmsb0=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 20:45:43.9229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2317385-147d-460f-3f2e-08de293ef0ea
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10283
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 20:45:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18476

Show the list of searched layers as one layer per line rather than just
dumping the contents of the BBLAYERS variable.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No changes.

 lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 69e9f166c..e23ef6db3 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -427,7 +427,7 @@ class AddFragmentsNode(AstNode):
                     data.setVarFlag(flagged_var, f, val)
                     data.setVar(flagged_var, None)
             else:
-                bb.fatal("Could not find fragment {} in enabled layers: {}=
".format(f, layers))
+                bb.fatal("Could not find fragment {} in enabled layers:\n\=
t{}".format(f, "\n\t".join(layers.split())))
=20
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))

