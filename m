Return-Path: <jhaller.oss@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93928C36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 12:10:53 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.81])
 by mx.groups.io with SMTP id smtpd.web11.9811.1743768649466741872
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Apr 2025 05:10:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@Philips.onmicrosoft.com header.s=selector2-Philips-onmicrosoft-com header.b=TxA0btSf;
 spf=pass (domain: bbl.ms.philips.com, ip: 40.107.247.81, mailfrom: jhaller@bbl.ms.philips.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIN+1rXi59o4x5igheUjfPtvkMLbDWhm38KAjJusKmsZnmDowSIekzQfdadderUbHj1//pHeugZtOAIco6SUX/cLxKUozWXbPKLJw0uhJtvZlwaF+SbIV37LTTF/1lnGNBchHBgrE6gqPPZA8TmyddTnDiqZPr8TDJNJdZ3KkWu1tvzI0NGru+RDDfRaNFliqJ2GNRudBhNiqiFxe6SNNEOj3ncxUl0c+SGNMZVXqhya5TfB79Ae3qFdB6hZExvlVO0laABJHZJrBlEBoQcVtrkvn1pXIpAXKsphY2nQWUYuHL/6BjtY9eU+PJCfcguBGxWLzZBlMJnFai69Nz6rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APwbMpBHqCj5wSAjSrYEzYNdD8YTLUoJ4lc9xXf9d3A=;
 b=smz5HgGL2gEhKviYrond934TdYx+67aAhIxl9SEDcDM4D0xds5GCYHRmywVgIT/8xU5X/sgMSTr1s0fQL+IBuRKf/80JfrKZRsf0DNgVe4qTMGTCT8ugBHV9weOJCBFhvxQuNJ8tgXoVY8gCb72/NgkmL98mqX1vCp0H8/3vfbIxz004Awg932a+T74f91tVqPK2DLXw6yC5OJe6cEa6q+f9l956w4w5r8wJBKcuo9kclroNdT54BpQ0EDsUmsdPtGn7OhI4GIO8UVau3BHyJi2lX6U8cTlTn9eiPznrRX+CMRTzUBUrwKHFLkMsCMmivsXusF0/eATME/Y06gTQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APwbMpBHqCj5wSAjSrYEzYNdD8YTLUoJ4lc9xXf9d3A=;
 b=TxA0btSfwAbnOK4Dy6tSZNFdEd1xpAi9ciJ5OR6uakz3uw2F71xRsisV76n/G7Uvq22v9F9C+fQMgjxj76h7bDcQinDgKjq7Tkoog7CA4UDomiaVWfFvxYUHjm8Yx9cibVHf/cDk+JfrKr29V2/zvK8vdlyL20i+jnUcch/w5jY=
Received: from DU7P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::22)
 by PAWP122MB0332.EURP122.PROD.OUTLOOK.COM (2603:10a6:102:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 12:10:46 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::e2) by DU7P195CA0012.outlook.office365.com
 (2603:10a6:10:54d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Fri,
 4 Apr 2025 12:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com;
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 12:10:45 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTPS
	id 0SNtu8jkZQb500fsjuUHRH; Fri, 04 Apr 2025 14:10:45 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id 0fsjuQx3sFWGr0fsjuiJa1; Fri, 04 Apr 2025 14:10:45 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.223.70])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 7C42518476E
	for <bitbake-devel@lists.openembedded.org>; Fri,  4 Apr 2025 14:10:45 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
	id 7666C7C022A; Fri,  4 Apr 2025 14:10:45 +0200 (CEST)
From: jhaller.oss@gmail.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 1/2] bitbake: fetch: Fix BB_FETCH_PREMIRRORONLY for git mirror tarballs
Date: Fri,  4 Apr 2025 14:10:44 +0200
Message-ID: <20250404121045.1133722-1-jhaller.oss@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Julian Haller <julian.haller@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|PAWP122MB0332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 61b5ad87-68de-4b85-47e8-08dd7371bab8
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|61400799027|36860700013|7093399015|376014|82310400026|48200799018|35450700002;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?G7fDbpVUqe2Njbz0xpjbUQ8LTMbKtbDxkBk/PstYIJRF+egLrqnxXZXRKLjr?=
 =?us-ascii?Q?hjhWVFJDeuDYTSISUSNoo5wcGN1Tvn5O+sgw0VxvZPVGUUzWgtxbjCt5ggdG?=
 =?us-ascii?Q?CNlG+O7RK9kMdbBGSycegdmobEK125Whzymo7eHHGSgzzEQXIXVwcYgpaYPX?=
 =?us-ascii?Q?vO6/eBBbZIrO+4SVoliyKg47InGnq20U3sSmTRs7NhOqfT63bQjwiuXa3c+r?=
 =?us-ascii?Q?y3gakMPy4A7q8K3FO6JqQQfaUN7iXiiTasENYvlhO5LcPg++qt1rdyY87Cfa?=
 =?us-ascii?Q?iK+oMwG/LIldVYjAuXHc9SIamTz3fhCP4a16GRMyGtW8fBeaaWuxo+x/9Tkh?=
 =?us-ascii?Q?QfffXzSVbVZU9E1tx7qhxvhoKCdNs8BBXgfxLAraGgwYTt42/6B6eG7vij2T?=
 =?us-ascii?Q?VZowIzQ/hvArE/36Pbt4iGif4p/OoXaXoqbKjx3IhiXOrfIRJtf6AXMMB8+A?=
 =?us-ascii?Q?oj8beq5PM5FTEKHAuZSgOt2M+jX0X3gfq3mr9+xhubx7IB72JzHEW8rykQGo?=
 =?us-ascii?Q?G7KKUL9WbCxFkiRdf9qe+KpuAyE9hmDJ4jz6t5iTXqP4VBumwcgrpwvnNS5o?=
 =?us-ascii?Q?Nww6M3njXIi4htrMTI6PoqtyAKyYHaVXe5qNIlpt3oFHkwhm4JQ6VvcZAH/c?=
 =?us-ascii?Q?Ugb81Dr94Gz25zbbYMt8tJAzFa/g32oRKJgzuy1qPZBFcwzeSq07AjiXqA++?=
 =?us-ascii?Q?fzWNuoWX2UpFIWWvDEUuOt/qpqCIqIMpXDO84C5hasY0zN/46JT0kU5wIeb7?=
 =?us-ascii?Q?C6c7O1n2103KLCULyI+miqrph4hpz9XVJ3ivoxeXEOfRdTGaR65fyn9DRsu4?=
 =?us-ascii?Q?KXnewq6TJ4AdX56T8yg/dfYNiCYzZv9PzSxnPWk0uaPWDEt4AfmIMSKY1PZ5?=
 =?us-ascii?Q?x1JrSt9IKlHmR2nZZzZg6PlMQMlW0RmR5rL9+xXp85WsYZYzi/+2blB8RwWH?=
 =?us-ascii?Q?QtGxC2Bh4LZPKMKzDIALiDWtoq+gw2pR/AMbJj3tF/fiaGLTbe3EsYx010XW?=
 =?us-ascii?Q?lBW4QEjdw3dbH13T+8s7ndLgNueXugV0lEy1LXAcyyjzp+5biZk9H6jjFxTo?=
 =?us-ascii?Q?fAwHUXSM9UeGdf+6ybGp7alGEgu56rD+HqPkOGdyjeB+q/D6rrdRrCeFmo8O?=
 =?us-ascii?Q?1XGFFkaoehJQKLzSG3FQameYKc7QCBL4kW/HB6pzkn/72ktYTp6dTPymRjSm?=
 =?us-ascii?Q?eV7Jay9lMkI9rwH2vupc10y1MMoA2Z2M999/GysI1svy0e5/te1YSVSC/Upo?=
 =?us-ascii?Q?EInHaof3KNipVcUmN/ToZ/F0zGSBC6QoGQ7KebxC6j5lIwI1pjDXmTFutO01?=
 =?us-ascii?Q?En5uYOyBq/KquSgqon5g2paUtrp1RJny/dASB0InaxFQ28vztyjrnEu/ghWu?=
 =?us-ascii?Q?Zu/P9aPpjAdgLQ6PBXqAeIdMoA9RBJ76Ngel513AYL5GVDwLVCOkUj5SL7/o?=
 =?us-ascii?Q?JxB87wcUzDt1XgA8t3/8Necpp0ZfFS99/SumTH5o0ILoiGfLxCVy0HsKR6CW?=
 =?us-ascii?Q?osB+J49IR769bEflnnB4pTcmVviO0gWDwSjI?=
X-Forefront-Antispam-Report: 
	CIP:3.248.88.141;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(7093399015)(376014)(82310400026)(48200799018)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 12:10:45.7616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b5ad87-68de-4b85-47e8-08dd7371bab8
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[3.248.88.141];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP122MB0332
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Apr 2025 12:10:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17514

From: Julian Haller <julian.haller@philips.com>

When invoking the original git fetcher after downloading a mirror
tarball, BB_FETCH_PREMIRRORONLY is ignored. This leads to git fetch
commands targeting the upstream source being executed silently. Ensure
setting BB_NO_NETWORK before invoking the original fetcher. While this
was only observed for git, setting this in general for all fetcher
types makes sense at this location.
---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index e698fde19c..345b003efc 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1072,6 +1072,10 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D =
False):
         # If that tarball is a local file:// we need to provide a symlink =
to it
         dldir =3D ld.getVar("DL_DIR")
=20
+        if bb.utils.to_boolean(ld.getVar("BB_FETCH_PREMIRRORONLY")):
+            ld =3D ld.createCopy()
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


