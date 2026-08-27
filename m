Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E7C61DD6
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:03 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com (BN8PR05CU002.outbound.protection.outlook.com [52.101.57.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1.1787861874374598388
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=PBX7RDPU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.57.8, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CulRRwVlp7Y50o2GJHBbl1ctAK3VVzoGIPIwutSGhmtkSr5gcZ0CP6d+lGk9zjUOOSVpOn9OlVIA0w4Ed2n70OwZnfe6Sv9CTB9IzxFgYWBS2fYTZEWq8wQV8Dd2lmS/XNyS6r8QV0sR8qv7ArlT/044EGMh5E03KISDtA0QS/RzXa7bSC0ewrZB1y04pS3kLcRZGX38D1EPY2g/bRbHrSF5lSedonc3N9cqEfAocZAZ0ZYCqbUNLL5irXY7tfRIgqydv6rnrBL9d0mdw9PFJIDaks6FjYNl3hr3SMetVmmtRRnKPgEEO2e5uRwZoiFjTItSVJj+8CCYQeuoopul6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBgyP2myOt72HfSSldZrgG0gOPSpBvxnTYQjY+aWZvg=;
 b=nr0o902Wo+9oRi9Mfii9yiHOpYmJ/J/PhaVUczLpDVkd2vkRTwO/QaEkwLU3DpsKAiR1DznCGL1mxsd1ueAFbGRtOAxmY77n71GLVkogY+PgZ7BdHQUvSrIfmkoM7jF+I4auuatLDtOYRQn7adymTJWyUizYfc6F4jDB5rjEJ2J89dgsK+mgY7cUzMxrQtmmcUGvgHE35daqupCgrBP97BZnWLzgIDv0LCjxQiXSUg4ZySX+NdWPF7D4bD9yFlr/T7dKTDoPwRFwFWBYG+2vB31swxLRrX5m1TE+n0NT3FyVAlRXZbRQhR26zsLGsdoFR9w/wMsjyVQLexz+ULEp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBgyP2myOt72HfSSldZrgG0gOPSpBvxnTYQjY+aWZvg=;
 b=PBX7RDPU96pD/jEZ9xBNBirTV8rTAAW7e8PXCFW8n5E+zpmu+xwMSrmKgkww43Sdjnukn3eNBVL6s0lRHCCzhOXY/QytvzTPF2F3VxI5FV7Qvq6khVmNQTvLXJmeovfWvXj/eHVh/pwOL2GtBBeiyTfVHQyLwgkKpecLuQMRxTScVzxUv6I5LwsOlWuDBKVHdWX3nGQz3XowSdXB1wO/ksI8XVb6rzn2wpAjl4Eg/adudMerxpe+y6CevUpyFBi9JfLuUo9QE8XqvkDJ8gA6JNKRdEz4YM1cLscdscjUaLRGNBuBWHV6b+NgL8ZI72SSU32oTxUeQ/1gYxfNaljTKg==
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:17:48 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::9c) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:46 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:32 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 05/11] runqueue: remove RunQueueExecute.build_stamps2 which is never read
Date: Thu, 27 Aug 2026 16:17:15 -0400
Message-ID: <20260827201720.698482-7-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 412b27a6-f81a-4ac5-6a5c-08df04784238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Dd4EVd0VF5/XoC6Ta217o+GKGzpGqBuOXA711YUGVTVDkSoAnA/k13BurYhKkRmx4wIEZymwUXTvZUHzXo57nz0PcB75E+8f6NjMnnENK7sXeHEkJp0b1hsx8c+hbQhsGfh+6uHKp3LgD/l05xi1NLaO0p2To1GHxIyTQm54wXbAWjVVpIzV9xstS+cccK9yKdAm5Et2O7E3RG/p540idVh56350uelAvdmnF5TkRwVfAXOyqd7phBO3aGdzKcUPhb250R1Mo+wykh2ccrol/4stof5MVvQWZopykC4gIRzk3aiGaZ/Rynp6nbojo2iVmN8MvX6RYo02+n53I3uUxd2mf4K9PPr0dfCM51v9VSQJveqciLOdiVBjcCNyMIj1ajIdcsSieLAb2oeXaEfvWn45QTOa9Gd75jLyi0pZIv31xkthF1qS4QwCKZVAyZBZ3QhmH/GtcCQoXxrq3fvSoH7jl6NgZzapFpy+caM6UsnCeZjUGaAKvEFMfXLbWdy2PA6epsk/kOCKBaLD+N+sbPtVC6cf6IX0GroLOWuKmiJZt5TSAXEZJfHXUQlIf2Yv3UdEgTL65mQ5KM99yHSCpra3pK1TfalcX8X+y3c0O+bs8f4UUH55/IsGCXfbBJuNLi9ucvP9KWMS9B7bNVw3oG0qOO/HlEjEGlvCLv5CMkn7mUdxMcIp6Ji3mU5p1kjnXkCKBIS9iWAbrHw68ElVzA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oahbnNxB7SEORgtLN0JmdRaM0en3NRWiOTem3rOSoTIHLUG/n1Had9nGrkFBP2fEi0BFg/D3cKud3xKgcyvjtronmSgnuj66BcDmxTXQjiIgfiu4HZUpBCYWpuCfSUc8BYJVGg0QmpfHKBxWd+N3yTNtKtdwjN4CD5NOc45Czee09xbPNVo5Y0qvfkc1vRktu0VlPSCheYhJixbiw5R/b7Qir7QcuxmAjGjFDpOWFZ2hfwhCu5U0tVjy5vEeQIUun5cYruTUCDPegM31j838PfTKrSivRQX9+ipoYg74lBiF3wyaX12fU1riXxaZ/G8KUpKSQQWDigKZfozBO0aMtNfaeC8x4qU9xy2ec47K7K3BhEGBl2VDVC1SA7rfBjqBjM1TAf+OY7s4utV6eEbPkWVHc6BdHEtjeQNiNx21a6Mj0Hj6zhMSeW6uvYrgXRIW
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:46.2081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412b27a6-f81a-4ac5-6a5c-08df04784238
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20092

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 07f5d9fb1..5b92e405e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1873,7 +1873,6 @@ class RunQueueExecute:
         self.runq_tasksrun =3D set()
=20
         self.build_stamps =3D {}
-        self.build_stamps2 =3D []
         self.failed_tids =3D []
         self.sq_deferred =3D {}
         self.sq_needed_harddeps =3D set()
@@ -1965,7 +1964,6 @@ class RunQueueExecute:
=20
         # self.build_stamps[pid] may not exist when use shared work direct=
ory.
         if task in self.build_stamps:
-            self.build_stamps2.remove(self.build_stamps[task])
             del self.build_stamps[task]
=20
         if task in self.sq_live:
@@ -2315,7 +2313,6 @@ class RunQueueExecute:
                 self.rq.worker[mc].process.stdin.flush()
=20
             self.build_stamps[task] =3D bb.parse.siggen.stampfile_mcfn(tas=
kname, taskfn, extrainfo=3DFalse)
-            self.build_stamps2.append(self.build_stamps[task])
             self.sq_running.add(task)
             self.sq_live.add(task)
             self.stats.updateActiveSetscene(len(self.sq_live))
@@ -2416,7 +2413,6 @@ class RunQueueExecute:
                 self.rq.worker[mc].process.stdin.flush()
=20
             self.build_stamps[task] =3D bb.parse.siggen.stampfile_mcfn(tas=
kname, taskfn, extrainfo=3DFalse)
-            self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()
             if self.can_start_task():
--=20
2.43.0


