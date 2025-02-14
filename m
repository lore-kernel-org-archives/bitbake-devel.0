Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B241EC3DA4A
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 21:14:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.52])
 by mx.groups.io with SMTP id smtpd.web11.31876.1739567657269547741
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 13:14:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=NuDbTqm5;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.52, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2mr8ORATwEI8OYzBXQmN2fHFmt2Zi7xXGDyRGqjjVLqFlX2ogJWX366w3okftM6yFbcscOxPw1Ic7EuIATZh4IhVQxx/13yB7MjNV4Pd2MdfD1pUw+Dtv4HESFRbvwTgReLAswPxNhzc9h0SdzIbf2BOUOjYwKoC3ELf+ktTK/5IND/iO+u4TRg5i1C1CiIV9FZdVmgBgQQtw9TjpsgLh2SwjhVeIq8RDO6rE6bP5xEeicr0H0kEnrxLRuZB0Kt+d61ONI7PG4zIRvbENdGPWuahzhiNziJFIMC9hoTqGqohYsPiztzvUU58ZHkl4cE3/ufjDFHvag5psLQnaxsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0l24tqL9ctZjXoL6o36yc3d7W0Y0IANwWweLOSWeYc=;
 b=PPNuXe5pMIZBfA6DgRCP+uOInCAYPRAMhxKIm1qt0XpHrvGLtXsqEBal3Um66X68IzBg7JomU1xmq5ZszsHfOtDuyFueYMsMHlhIVg4RHuXt5Dz5WJ7z6BRqiQ68ccFuXTWPkZuyGYc3nD/uBPWcKm62/V8QKNSGDBTon4b1mfQy1lyTQCUzAa/Is7D0tMIUwOAEJoAuJP6G4QHMD2RQg1aVLgJJebk37FOxV3kNCaMghtZ1jrlFidpo4GOaGJBf2CsJ9ctkpE8UjiLiBRkmR5urPyfmZOXkVTynWVLMRQYoGk/2ptBm/i2aaA0gc7KBFaKO+FGKHuDbiEL8mXAOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0l24tqL9ctZjXoL6o36yc3d7W0Y0IANwWweLOSWeYc=;
 b=NuDbTqm5Ye1ioupFvfgSW/KaUH/Wkazsw44IKtJvOhxFCoohGgzqghzTh9nDLX2x/wHt3CQ8zG8soRmFzabg14LE30+6XxLejhUwJ1SmeulHA7Kdm5x9OcG9ZnQWZG0engZvL9HWwRHlIYe4z10lze1Z7LLNfaPEoiH+3lTY31uSZHechhDJtBcEn/fslVSrRe1mUxxlR/9W/48NrhsED4MbIptWo5aCir5enTLSP4rhhwgwudxXroAQkJ5rstUBdHyrah3cCP9rTCnhBtLLy7JsVIB+BMDO8FX1Viy00VMsj5rFzcYBUpR4T4qbh3YzShZmcXS7+I9pfGgvJb0MJA==
Received: from MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 21:14:13 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::d6) by MN2PR20CA0065.outlook.office365.com
 (2603:10b6:208:235::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 21:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 21:14:13 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Feb 2025 14:13:35 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] bitbake: knotty: report cache validity checking progress
Date: Fri, 14 Feb 2025 16:14:03 -0500
Message-ID: <20250214211403.493573-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214211403.493573-1-chris.laplante@agilent.com>
References: <20250214211403.493573-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ec0a2f-e9b9-4efe-92b2-08dd4d3c882e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J4xisvrrwY1J0pgKDfl+/EcsPBUvKlsyp1yVDlQaEWTTt/Kxb7V60H85+A+E?=
 =?us-ascii?Q?SWp7ZmG/LsbH7+6sVCt9a/D/95tRTQaU7u8fyg4KqOoB+RUPUyE30ivff09v?=
 =?us-ascii?Q?ysPJCjODyB5WXz/BRkbBSfNo/YjugRu69dU5a6W80uME3o5aasWI/RGa8wDO?=
 =?us-ascii?Q?L4S3KNOuALs2fk/2BwSg2KnaL7G87CdpSnGZRwej3JS81d9/8L5A2RO72zxo?=
 =?us-ascii?Q?dwiJJTd8NxzSX6mvE3u5k1RZrWQelZ13A9qGbdEdw5cekk9PbbgzPkuJXLji?=
 =?us-ascii?Q?Aeg9ZrW3NVhMKxmDb1o49WmaRzk6UmC9/vmYY7NmiUZgk0p3uY/4IrDpBwFV?=
 =?us-ascii?Q?7+17R+BGu1Ei1efNfM7UGsKkERFwfk8z3b+Ww5+UaXwv2TNN6sW8HQmUEUtl?=
 =?us-ascii?Q?f7nGQgEHtrIzAukk3eKSKFzdxEu/QKU2iQM05PhRHP6/eyUj22ofDvNbd0VF?=
 =?us-ascii?Q?H67KTLvZwjd/l2NEYoSUDouNTlZcUV5MIjxyR73KJExx0799yLyDxzme41tt?=
 =?us-ascii?Q?vMSNmn1/4NngxLIRdU0odi1Rx+0l8A+YCqk0wV81WGSyX3U6D8PMXvQYQirA?=
 =?us-ascii?Q?hfvti3NzuAeYV9JKoFE9t4cHH2+ddr0QhLyIdPR/XqiZT2eZGlNTu4OEEKa6?=
 =?us-ascii?Q?n1a7XS65cP98Gvkp99nGyobXTsQVDwP2eDiZ/GIMsUjz6qD2bNhExTB/d2KA?=
 =?us-ascii?Q?4LG/vppt/8PGdV3psydvjgsI/4AR01oO7Z2SErg2lmgb1Nkkfn01aMoEsXDk?=
 =?us-ascii?Q?W0OucFazVuc7opUeahJfRv33YT77+VF1ChIReRwWH/T6B/UXEqbS5D1pEhLv?=
 =?us-ascii?Q?7Nov4UUR46Nkm0erz/s6xkoUvZYffaDXtKP82v0jbURiQpfShce79TWL8pUW?=
 =?us-ascii?Q?e0kbawYLfGRWirhIM7Kq5gfxgWsyVfjJ5VQjzZjervlw7JIZMhNHdVzgCsWm?=
 =?us-ascii?Q?o70xr1g+FrHI1lt9qPE7Q1kZ+1HoPBEZ1MDdhWVFGORILqGJohM4TuGITyUD?=
 =?us-ascii?Q?DilC/zc/S8pWdW2dN5jGxI4vFNDG3sY2He0c9DWD7TMyVoHdIplZoXL/HRf+?=
 =?us-ascii?Q?ruvmanNpti/h8Oqb7y02ZdZz3Vw/UUPF52Ru28ekIiO58bgUExrzLb5tB+78?=
 =?us-ascii?Q?H59In7pCda0PzmSitWAE1pHw0bgyfN4uKz90JK8drtw4rXMCsLYzqQAE4y5p?=
 =?us-ascii?Q?obafurAZZtD2ibReGVq7eM0Q06bXMrGKbTS+Mlp0NTShwpfYOUpRO7VxFfjs?=
 =?us-ascii?Q?F7leol/tZcHrt+YuA6KtSb7V3/ghVKsN8WSgatNF6bG89Trf6fPWxaDZnGM9?=
 =?us-ascii?Q?N+W01ye8BkClNypcg2qwAK7ONZNrxO0s6O5oGuE6D5f9B2CloHCCQaB7KQTV?=
 =?us-ascii?Q?nfuJAEk8n0rEF8sS4GHyh+FKg8S3QycEXBQTgtV/PEuzbkAmiv8+oYPSfuKM?=
 =?us-ascii?Q?ypFkt0yFa1XhCSRXPKUeYtVy93ulZAL5Gv/0eAOddgoUrNWN8WGGndQNfD4z?=
 =?us-ascii?Q?7O3L5whIDEQIaNg=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:14:13.3514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ec0a2f-e9b9-4efe-92b2-08dd4d3c882e
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 21:14:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17229

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/lib/bb/ui/knotty.py | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 2fff1b3669..92b1980f5d 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -404,7 +404,8 @@ _evt_list =3D [ "bb.runqueue.runQueueExitWait", "bb.eve=
nt.LogExecTTY", "logging.Lo
               "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.run=
queue.sceneQueueTaskStarted",
               "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTask=
Failed", "bb.runqueue.sceneQueueTaskFailed",
               "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.Task=
Succeeded", "bb.build.TaskFailedSilent",
-              "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.even=
t.ProcessProgress", "bb.event.ProcessFinished"]
+              "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.even=
t.ProcessProgress", "bb.event.ProcessFinished",
+              "bb.event.CheckCacheValidityStarted", "bb.event.CheckCacheVa=
lidityProgress", "bb.event.CheckCacheValidityCompleted"]
=20
 def drain_events_errorhandling(eventHandler):
     # We don't have logging setup, we do need to show any events we see be=
fore exiting
@@ -796,6 +797,26 @@ def main(server, eventHandler, params, tf =3D Terminal=
Filter):
                     print("Loaded %d entries from dependency cache." % eve=
nt.num_entries)
                 continue
=20
+            if isinstance(event, bb.event.CheckCacheValidityStarted):
+                if params.options.quiet > 1:
+                    continue
+                cacheprogress =3D new_progress("Checking cache validity", =
event.total).start()
+                continue
+
+            if isinstance(event, bb.event.CheckCacheValidityProgress):
+                if params.options.quiet > 1:
+                    continue
+                cacheprogress.update(event.current)
+                continue
+
+            if isinstance(event, bb.event.CheckCacheValidityCompleted):
+                if params.options.quiet > 1:
+                    continue
+                cacheprogress.finish()
+                if params.options.quiet =3D=3D 0:
+                    print(f"Checked {event.total:d} cache entries for vali=
dity.")
+                continue
+
             if isinstance(event, bb.command.CommandFailed):
                 return_value =3D event.exitcode
                 if event.error:
--=20
2.43.0


