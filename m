Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A862FC61DC7
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:35 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3292.1787861250385735422
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=lF23mJNW;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.62.66, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK0NKKaieHXlm8MtxS1gOhdMwD3BoCCGULEpHCOKWKzk3jBmGrOhPFtv/zVxBwY4NPn9AjuUZBNAyDqfehXDZzA9gSZVSr1K4mFDRnDzFie7r6j5OUDlM/MUaQA+caQ7TtGEKglQrY+ZGbYAe+VlBF+rXRDlAULQliZNvvN7sTll2D38aVwRuBCRJF1JyzUk97mKxZu3sm7efrW8I2pfAKx196a/MwD/powvSVV9u97PkQ2Y34DI9nIFLyiyo9JbuowzfIPuT99vZ/3M6k9Ou9j2KyysmKuX8/J6BGi2z+whkfYYlxcZrhKTghQywusv1QuH8Bd72pqva1U1s/57Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49YK97FDDQPAQbP8cL0a+g2bpd998lK9YKsRrIbRJZE=;
 b=GSDq+oXg06payX+CPCK4jXgkIHcwV3fW+sdG2BRLFP96O7ssIVlbDrvEd1hKCrleyM0WwsvOTUZmM14igp843+QsJJYg9px6xUN55oetHVsHtHnGF2zhWBfCDIo874cOUQqWIdNT2nIiTiO0wBTqi21xqRyry5aOUDvRQEBE5ultExLeqzHf6s0kz7txjlEnouY7X0qNbdF2gwgcr+/4wer7q738Crg4a4743qD0Xpo33+AofvpdNyed/EAtgKhd1LFwQWBifO253LorGZzrs7Low6pxWppHQBTwjx7DuJVBpAbLjb69batEK+WBbO79mgV6DuwV8RbTk27d20pxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49YK97FDDQPAQbP8cL0a+g2bpd998lK9YKsRrIbRJZE=;
 b=lF23mJNWrbCR25GvBvMew6BBFyoKnHZCpNdaqG72nUoxHtTa/ReY4iblSyDxZTnZ+n/AzK051j/06ULssACywCjhyktcS1kIp8jUBKPzlX1Yg8lYjaO8cf9fMd9zLBLahIp3eHT3hbepdpJ71FS+TttjybVkjj7A0AnVK4j77fLlJgkasLO56jHFgu6h1upLIoi6mXvoXI5lzKQms9gftNUL/mjfhf1ip/vbZdzffYhqUeueJT+535aStHLYz9rEw4UC3BTkf982KtnaLDeV4rFVMk4wKK34kVoaxGn2riZpn7f3PMzMlw/eP2fZEwv1P3DRq9xlm2+h2a8lw9Htkw==
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:07:23 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::79) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:21 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:01 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 05/11] runqueue: remove RunQueueExecute.build_stamps2 which is never read
Date: Thu, 27 Aug 2026 16:05:57 -0400
Message-ID: <20260827200603.688796-6-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 83518523-ec5c-4ec0-8c7c-08df0476cdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	8yGBBzckEco2LDL9R3QFn1nMYNPoNqoiUwfWuEVhTuI4uHgaGvE+ajxWwlHY+EqyZ6ISt+rSTXfBkY/wbN62FoELx4NCCW4yo6E54lV+0W26f/VUKvE0fKWZADWGqit7wmmkwjqFS8txKzYjwHTRunY/FphYPcb+2JtYywiQ1Kdeo6WGSQ7R5tp8jbOEtzXVzA2wrj1VIBAMbSWe7P/Dt0ou3vNw6acjt5QCed3Od0KzjPD2w6LKgJidg0gFOXmRTVdqCoH0rqXT+qdVlsW7UIehmtlo3HmjlHjNGCNxUunsRqxVEVVzhP+LAb14OeM8Le4xyrBuEHUXHDaDk4x5FgE5WH8Z0+qF3RxruTKVB1lyWUmnLHUbz8rb99qAz3knibjntJKxCggdlhCZSM5cnItz2EpHXjQLIo7bJq2zxnINgyxwInRJ06jClh1STsSyattRWtpzw1RJGAY/Bvw4oP59CXVvC16bymVCjtYf3HQLz4uDpss4S8GKoNIB1w0m0wetV4u233lQB+9bOzLRPw3bNnKXumZ2S9MyqNrA2WpuTTe55wnDbqnTtJjZs9vtnaTrDr72M4NAQ9Y0UJ2NUlfUHjpv1EDQs6DxtSlKlYlT10TBuUrYMnyhE1/1V8MnBNhS5zIe3Yu49lPW3I9VeoRGikK11RvL/aVJyWVTKbE39sYwGw9SM2fAcLlqwtjc1JXG/m0TKBHJH5pgFSYM7w==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	M+3STkpdim+gcoK8zQTk9Lck+4pJwF99trFoyUi78JenikSV5haWhd19PcjOnm/UNux+6LPxq10fXqGehIAI79UW2ikzOqQWtweI5jgEZiGPmyAStNCobBfN+PkF8vNXejdfKoPlYeeHEb9Og6Hda4eNR8+kj52IqS85EFUsRVPZ7mKwb9BbvHEJVdblrdNPZNJ6+2m8761AT6ziVv3w5ehLwSvleWvXHDPe8S5NEFeCUnNIAkUBB/uov15Y7+GTDfAaWKVZS6fbSHB+8VkeJQks4Nbpb5j3O9M872buBoHmPnb8rIP9FKfkjvMWLamVh5I/9xuYWiyEkI24mBmj2KOdH4bCQIi8IJwgT/YigEHNzojlgbNQqlqDxxlEZtSXyYBF+WJUZWytvrW6k1ZoJRACnLLH7t/spyXkzTKRcuUodl6UpV17Z7M3+fIOW0ki
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:21.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83518523-ec5c-4ec0-8c7c-08df0476cdb6
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20080

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c7b6a9d25..d64624e40 100644
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


