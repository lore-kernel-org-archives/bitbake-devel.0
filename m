Return-Path: <jhaller.oss@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF6C36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:27:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.46])
 by mx.groups.io with SMTP id smtpd.web11.48569.1743416851550469689
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Mar 2025 03:27:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@Philips.onmicrosoft.com header.s=selector2-Philips-onmicrosoft-com header.b=N/gXVAan;
 spf=pass (domain: bbl.ms.philips.com, ip: 40.107.20.46, mailfrom: jhaller@bbl.ms.philips.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX3MeUYm52U8mjzo9vEHXJMbrAsHYrv5n0FBw4K/H4xTYKPydW30Niwp4xfll4VxLY5KoYBPb62xjo1cKnVEG3SPaOSfem/aU6B+eeWH8iSg1v14vFkjolDHYPAoNhNAeJ7JbNxHegskudHIYrbSjs+3ZaG5RpalPEXJTYE8zogFY2lIa5FlFsKxzfhQATKU0KSzbLUx8L/xnXpvIdh2Y8whF3P5+rAUoiQBoJCnzWLjuQxLXh3t1sbv4Y9gYdVDo/xUF62TM6sCYhCejOB19ocDhRIcqlmvTqdY9I9CeWqDoeZEhggBmtsfN7HV6Qaz+ram/BEQC2lj0BdNYEWUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQFk/U94eOhuP+uyhooSYwXQbkBxtRb1R8k31MDjREc=;
 b=c8rqGjlolxw0BqS1xABW4XWPdYPwQFBnX9Ioq2MazaUJXrvCNesYvtuTsi4R8gFRhIkbcdfe+OPN/v/e7vWxu+H/MiAWwI/vafWdBqElRUWcrJ1kVkWMNGkGx1poiQ7gNVMk/KGurljxc4mJbmKNSLGHM0TDHxLz7y1qvmHG66SFh8NgF3303MeOuPUfXdG4ovvU3cLHv2J2WUN5kBSwVbMwG8gma1NiOu7D8rJUgdPY4bv3ct7opbppbbvBfKfbcYh64QcNf4+vPB/KfhLBo6buifvVlOfQ0kbK2GIsYT97owtGI+pek2E1DihnHOjebJuoNShgRawQz7fBtJNPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQFk/U94eOhuP+uyhooSYwXQbkBxtRb1R8k31MDjREc=;
 b=N/gXVAan1qkB7z+cDMdJZcLqDxCd51Dpe20XwvXwoGl5NmeM4VNGsczOtFDu1503Q9UAD3UNRkQO2BEz6eQdXoCHfC1RS+FP+VYIfx2wXYjFS3gmfqjmsxhC8G4rlDa5Tm2UvvJTDWTwNNBxMmcDRg4VnU8L6YR3UKi53jncCSs=
Received: from CWLP123CA0257.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::17)
 by VI1P122MB0205.EURP122.PROD.OUTLOOK.COM (2603:10a6:800:176::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Mon, 31 Mar
 2025 10:27:27 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::e0) by CWLP123CA0257.outlook.office365.com
 (2603:10a6:400:19e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 31 Mar 2025 10:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com;
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 10:27:26 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTPS
	id z6ZXt5CEqQb50zCMYtHXFF; Mon, 31 Mar 2025 12:27:26 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id zCMYtLk9qFWGrzCMYtUszT; Mon, 31 Mar 2025 12:27:26 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.223.70])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 391EC182F48
	for <bitbake-devel@lists.openembedded.org>; Mon, 31 Mar 2025 12:27:26 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
	id 2BD9F7C022B; Mon, 31 Mar 2025 12:27:26 +0200 (CEST)
From: jhaller.oss@gmail.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] bitbake: fetch: Fix BB_FETCH_PREMIRRORONLY for git mirror tarballs
Date: Mon, 31 Mar 2025 12:27:25 +0200
Message-ID: <20250331102726.1965866-1-jhaller.oss@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Julian Haller <julian.haller@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79B:EE_|VI1P122MB0205:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96d6a62e-c2f7-4586-b36d-08dd703ea221
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7093399015|82310400026|36860700013|48200799018|376014|61400799027|35450700002;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jOPx2iU1YPtY13q3y+WVJaIBPSWbplik6xRr9DyHCgyN5gWwGzdjmMmfxulF?=
 =?us-ascii?Q?NfK4OnsCONWs8eHJ/EoRCKQ3ZYEVyrKKTMNGOI0vuViSR+hokQ7uDgitNwXP?=
 =?us-ascii?Q?SCPX1dIn+nLks3uq/K5THd5EaDNtcVUG53uEfkYNCRL9XMalE45/FcWAg60c?=
 =?us-ascii?Q?uisKYgYpSadNZbXlDTdTGTm5x/b/241zgJbpW7DjPxDp0DOjgmuxPs711kik?=
 =?us-ascii?Q?DFtzOwb/DuShPE1NBqUhr09lbiS9/XiOmGRz1P4+nzI1RQlAp0KSFWUMiM7e?=
 =?us-ascii?Q?itpi+AC8RQkMNNCSwMRlwylJEeasnt8j5VWqD5KzS7GtPEhvITwrNYH0+krV?=
 =?us-ascii?Q?HiaZFyJZX0SGB+3AwO5fvY9LbxaVjlpKzw8FVAG4qfafY2Aj57xL72tAMz0/?=
 =?us-ascii?Q?0ws+DEKJIx4cjG3izKerFDsRYQvEXz0rLNAOExKbP476MxEJdzIh0uD/4R/7?=
 =?us-ascii?Q?bZPj+UAhVMLCg72xb6MhYAwxFs9bpwE1w8PCynC/H99yg+VwXQs8tMHXAdPN?=
 =?us-ascii?Q?hFjT+3Xh2a9kQLHXZVn3ZrW9bEDsT8XIb5dgVrZt2D+ly8IMpKSvxKS0PnLa?=
 =?us-ascii?Q?TywRpkevoZAydEfeTgeDu0Ijz8bl86TJe0ZuCNo3PpALeNZgeUOQSBaB9vRZ?=
 =?us-ascii?Q?hDkUZ9OwA9fmq1X2DUDkLxPxo3jDix+E4Iq2DRQe2/GMppi7QBwDa3IEnVkA?=
 =?us-ascii?Q?XyCQ+mm1G/GROu8TYxZuyCzHTtPNJFPxiZZ+wDudLQN7ilQ7r4KDzEG1RZtQ?=
 =?us-ascii?Q?+3gCzDEsIGGWzL1V4Jg9ZSj9H/M2Ty3S7CzOS0D85DfXtYbVCg489z2TRxld?=
 =?us-ascii?Q?/os+BIwqD5eM2/brPav48saZp6ex2jb/EDwOMGBTOosZLWjDc3y2yDXxhYOF?=
 =?us-ascii?Q?tQzAFoNOWaNG9Tr0IbRKQ3JvuCuB5qfASuJ3+YYpcIJjLj23hI0T9BcZ3yib?=
 =?us-ascii?Q?kC2Z3kN8V2nYIK7R+ncvj8L1JQ2E7f4SN+Yh0/FMk/YMWr10+V9TBoJObYK7?=
 =?us-ascii?Q?oDReMleaKriCl5A+Es6qRbmOOZMY5DNNLyzF3q8mOn9pgV7Po1zQxBjB/wnR?=
 =?us-ascii?Q?ZyYQn0+OodzZZTeJsAfVu09/jfaV+jCyVsFjIN9WijbiXWCmwBUagJMKXdHR?=
 =?us-ascii?Q?/o2OBscJ9Y/CYEXUBpZ0P5jeDBlzbFRKAybzaaiwa3/YcFsoNXkFTrC2y1rP?=
 =?us-ascii?Q?BIp8QYrMEv3Hv4HQ8KsPQ9PJ8GuxhQgcFOMhQii4p+fzYODlbBjgNG0ny1lD?=
 =?us-ascii?Q?SR1+GjYb7f0tzjSIK5UNEQbYKIC2h8/KiOLxDdtT4hw7MYaf1lSd7k6Kqm72?=
 =?us-ascii?Q?rXzP57+L5WUlILEQlT6PFGz0I04ELrPybMkQa/h4bVBiTL1YoHXAgbfPT63O?=
 =?us-ascii?Q?ig3/KeC70eSYavwTQoqIjYN9P8PpI5DGFPzBLutnY/jmXTy6eG5G05V089kF?=
 =?us-ascii?Q?edls+ONBAuX4r1kX1tYC3YkKb74UDemO/oQHOoBJLSZI4tfJ7vytLi1X/7YG?=
 =?us-ascii?Q?3D+92frV8yccERbLwcKY7oL+mR/T4bJmMdW9?=
X-Forefront-Antispam-Report: 
	CIP:3.248.88.141;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230040)(7093399015)(82310400026)(36860700013)(48200799018)(376014)(61400799027)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:27:26.6254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d6a62e-c2f7-4586-b36d-08dd703ea221
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[3.248.88.141];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0205
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Mar 2025 10:27:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17506

From: Julian Haller <julian.haller@philips.com>

When invoking the original git fetcher after downloading a mirror
tarball, BB_FETCH_PREMIRRORONLY is ignored. This leads to git fetch
commands targeting the upstream source being executed silently. Ensure
setting BB_NO_NETWORK before invoking the original fetcher. While this
was only observed for git, setting this in general for all fetcher
types makes sense at this location.
---
 bitbake/lib/bb/fetch2/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index fed296097f..76f1440026 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1092,6 +1092,9 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):
         # If that tarball is a local file:// we need to provide a symlink =
to it
         dldir =3D ld.getVar("DL_DIR")
=20
+        if bb.utils.to_boolean(ld.getVar("BB_FETCH_PREMIRRORONLY")):
+            ld.setVar("BB_NO_NETWORK", "1")
+
         if origud.mirrortarballs and os.path.basename(ud.localpath) in ori=
gud.mirrortarballs and os.path.basename(ud.localpath) !=3D os.path.basename=
(origud.localpath):
             # Create donestamp in old format to avoid triggering a re-down=
load
             if ud.donestamp:
--=20
2.43.0


