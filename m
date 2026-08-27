Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4055C61DC7
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:02 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9.1787861881870796781
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=LAV2oYB1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.36, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBct+4tLpSUwOP5ICFe4vsVkwpdetCuOONz/CEqTj1IKuFApd94GZDgxCnycQKdU1lw05QH3whwGV7ccsNIMNNg6cTCotD32skHjka217zQ0HT8Sa+Qcg90cfgwzZlZlEqOiWylIzzmx7SOCxiIvrBZ4nDI+suMBWROFFZhMOepjV4g3wJUcfSgUyHpH1ykXQO+EelN7+m/34B0UxW7OM3Zti10xsI4wTqvbz/RnNYZSYu2+BMIfa7jNypc+OENy+Wbtx5fWTdKx2GzjDLDAWRX4XVduPYBwEHj6VR4qEF929GBQ69y2LxyPnXn3p6vKDbQp4tKlg3o/GoPaApCiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HINWt7VvDqEx3NOWX1yziqFi43eH+97hqeGD+AoUuPI=;
 b=RB11Yzs+661z1O9WCrxNe2kgX7BOqQ+iWdY2l0vR4CiKkXUbPPPMNoqi7fv/k4h7c9ttFMZuA8O8EcUrDYEJDGrHTkKCcEkr194zxgPA49eZdZ8f5gFLHp84U6/rryg2BXxLHFQ4iywHMh8hWI/8el6fTS8K6kaKcMjfcCWlO7ZP7wUmEWJyZM+Xh+fNEySgJ2BAMZpiI4EQPDYrCRRhFJtrHaBrfjQdfbs/qiYadL6CpnhmuKK55QaaW4SJaYNAIBV5KpUbqcPczH88iGg9AOAx5VG5VFybdvzPZ8+HarwQWXr0pmImDnAnhOnNIlGm+Enutzp+uaI8+t0eY5sEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HINWt7VvDqEx3NOWX1yziqFi43eH+97hqeGD+AoUuPI=;
 b=LAV2oYB1aFLzAxZP4W3mTnE/Psw6lbr29L2qV5D5SYkBEZR1KslSbic05VMJj4PyI5LMk2CLzSYR9kS2XDoapt+vqqGej8/MFyGwOJW/oWFKS2QrTXk6fAr/ptT2P5MJ99C8DLT8QZl/sxYhH9nNSdthEgeu2V+i+uL7SGK9QCQcq+hGQwVpil9GcfvcccypxliTZWWRG6lDKpwafPjubBinnmel/wFU8y7XzZ1BOGk0rbZhgHx+KsCDFNkm5JOhf93iEwVZKVNeJyo/FR5dvXjITgVW8y+LitfRDorK7CTzNbXfloSxd/AqObICFmLfgLVRmHMfCrKBroG7iartxw==
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:17:49 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::a4) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:48 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:33 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 06/11] runqueue: optimize construction of rev_prio_map
Date: Thu, 27 Aug 2026 16:17:16 -0400
Message-ID: <20260827201720.698482-8-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1cac09-89d8-460b-1e64-08df04784392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	uGNmluWVlxzYk0/L5YQXansUtP6RDCUS1TZzmAhlPhmWj8H7ICqolJp7dDRwyEgFMrJn1w2n4C3gy7bYBhdneBHbMkYjAXcsnOKs92WJekgwUvTq8qYpTKHsvpwUiYnUEF16SmHsTAG4TpmPUsfVy5llTuKZq2yU5IS0Un0he59hGDkHiD9LtME+VhIGLTXSimyIBGnqGhE1sTDl5BMHv2SEYXwY6oPDniw5+x6tdaRcYBtJWoSgZmXz1yaUQ8Iq2PoKU0InFZfFWgxXm1Y42UnVFsAj7Vsr0+Kuv0iFFoN6R5FO67r3R5XTCbdQ2rfGMq+dxqKZVBTMqr5dYSILs9Fr9ewIITI2KTQ5BgPPLVCFxYommrnWBWs18wqjl/OlgCtPEwmGNDco7j7ZttDmgH9ev8P4hgINt1Gt2JYLhXN78bNiIBvazGBgS1CKLCUIhRzqV0a7m8Ah1UNDLtft0xhZy6lT3dR43vdb3eA/AHaxo4tCrITadkJ3fQdR29rB4cjJF1mmqPubutRtiJAA9qA58vlvKHfcGIeWxV+lobwuRKJC7+RrHP2s1e3+7dqmczNjatV6UFXo1fMA3U1lGGmuMaRokUuNJQ5DjftDP3YRs9AOlqkRZqTaNgz2AVyDtVbWFTU8982T0/FnSi+FVRcZKw6zWuNvr+xWd2AYAy5Mbxd3qAL97nE9QTizkgeyHAva5kTuoZMpvtnvUItmhQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ffA7zCSp2QYsRBeUsBXl2CtrdFe7h31cILG2+HBvFntzcK9Zz0eFrcieYKdTl6ZtsTY7LIW/VayOysvlaqlgty7uJeso0Gf3aK66EQqwhaKfapiqeMz0MULlKnmwuzeeM7S/kWARSs/T/W79CVEM1/EDBrSNXQ1Rjrhs9ocM8x8BvLi7+9NLhl6wpoW/osMdaCwW5YzUkT/20cuIsYv3i9XxJouR0RBduy86aPXMiNXVefiWtnApuoyDy5BayZuLlmz/pQMNjtPB97EIxeVksTzsMlJfKfrgMLb2CFba93Cf9ey+7+0Bezvv8js47LznslGKTrphERjONLSq9B1yUlJvQXcf+0OfxgdSpZpG0tzZbduUMQddRjVeLSe0Uigq8HAyWGBBsRHMnx34LlZZ4rb7RFyDiMwL64xnW/VB+drrZFjV4gtNCjKlL0Hqd6+y
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:48.4560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1cac09-89d8-460b-1e64-08df04784392
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20098

From: Chris Laplante <chris.laplante@agilent.com>

Make this an O(N) operation instead of O(N^2), where N =3D size of
runtaskentries map

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 5b92e405e..54e1066a9 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -287,9 +287,10 @@ class RunQueueScheduler(object):
                 return tid
=20
         if not self.rev_prio_map:
-            self.rev_prio_map =3D {}
-            for tid in self.rqdata.runtaskentries:
-                self.rev_prio_map[tid] =3D self.prio_map.index(tid)
+            self.rev_prio_map =3D {
+                tid: priority
+                for priority, tid in enumerate(self.prio_map)
+            }
=20
         best =3D None
         bestprio =3D None
--=20
2.43.0


