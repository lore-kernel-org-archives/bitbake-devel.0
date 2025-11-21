Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81945CFA45D
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 00:08:32 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.285.1763683706983509009
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Nov 2025 16:08:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=fcC6Xlac;
 spf=pass (domain: axis.com, ip: 52.101.72.66, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFWOa66Pl0MqzEC3aJVSH03Uj+AQx6cC76t5MPSRPXqLpMmXctR7KqehvFyWAQZNh9iC0DGMgZOTEt1L5qlTONA517BFjJ7XkYUDIDsJQDUMiaGAMoLIry3hKx/ArnbIzET89px7f/8Sybl8oID6qAA5LmxAGxnxpknTqjNkUB9mgLKTUoi+oQ048lrtitxVylNxcm6eqy2B+bOUNP1WiVokOh7KgjIpELujsTOCGWrb9xcGMevUqssRgn0gK4GHVe+oimlcfj+VvNB0180KJft3k+1FXh6zAcBpfAgubmxZJTPsCBi/k0u7Nyq92Sw+7SvnA21xmg4bvXoPow5PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCcqCjwvXwjBq5q5oyUtuSSDJJpEIgJvo0Vt48pbXjY=;
 b=btX8lETH1cKxjT/B8x2ue242CyYbqwRJDcK896ME7hmHYCbMb/gtjNcCLXIGgp6m2/xx1voZ2u2qYjAfHiZdnGs9q550eU0EBOtrUA/bJu7CyH0H723I+Ruja/llpseqhD4XfI20Xm/y1mrVHTQpR/Caz7EV9AAHCBdjb2GvOuWXvVZis4S9ukXCNh83/M0YpX8O8L8aVwbtw1L0E8/tWy7LRHjRSD04356o4p0pHb4y+A6RYHlnGeC3pk9dWm1aIlL2u4g1RRYdzu7H9jKUMoKiyy0lVHejjiwdVuq6yfPOuj6hIYeNavTGlMUSlgqAWTVF6p9ij4HgoPzvrAeRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCcqCjwvXwjBq5q5oyUtuSSDJJpEIgJvo0Vt48pbXjY=;
 b=fcC6XlacnsckS0ENytvZuvOIfD1Ygd5ErhMqq5NGwcALFuBQkc7UDFA4RtckFH45YfUDNXsU+El0TKrbyUL4dK6KbdwTt4KBJYvWeCWda7hKm75TWuOI0h8E0nBcKDrwLDYHQqSiL5BivKs/tXJhyDwi+IQ4ilWxpgISx89nJqU=
Received: from AM4PR0302CA0024.eurprd03.prod.outlook.com (2603:10a6:205:2::37)
 by PA6PR02MB10458.eurprd02.prod.outlook.com (2603:10a6:102:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 21 Nov
 2025 00:08:22 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:205:2:cafe::8e) by AM4PR0302CA0024.outlook.office365.com
 (2603:10a6:205:2::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Fri,
 21 Nov 2025 00:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 00:08:22 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 21 Nov
 2025 01:08:21 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 21 Nov
 2025 01:08:21 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 21 Nov 2025 01:08:21 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id A979128DA
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 01:08:21 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id F0E22120126; Fri, 21 Nov 2025 01:10:09 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/3] bitbake-layers: Remove the --force option for bitbake-config-build
Date: Fri, 21 Nov 2025 01:10:05 +0100
Message-ID: <20251121001006.3756451-2-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121001006.3756451-1-pkj@axis.com>
References: <20251121001006.3756451-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|PA6PR02MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: d34061ea-172e-4646-8029-08de2892155b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Nvmw0UffkNGfn9ezaEaLh0+dH9WkLtYEmpczG0H4QYVbHBOzRA4MzV+P6tyr?=
 =?us-ascii?Q?4wVPK7Sj2fev8tZU5uJmKjaW/jReq1obnV/9PQMZ5YAD7MiVR3pFlSHc4ErZ?=
 =?us-ascii?Q?qucp11c6pGb/HmpJMesuhWsr6ew+Uh48sY/3cCYjw6bF5peyyKQwTxlDA6gW?=
 =?us-ascii?Q?DeY5jIF8Epk/P+psDo7EsAYU2Aw549feeuzaalQGH/nrCnlEssUF1Bs8m7tr?=
 =?us-ascii?Q?liHFEQl+UqA6aYk2Mxnyaj20RQg4b3H9pit25yTIeMyFp9ZIQLMzIIer3TbR?=
 =?us-ascii?Q?1gh7JMf2Bmn8AcpuJZyCGDB0kcxsVbLOg342q5urzpjJuDSXLsfgdARK92ef?=
 =?us-ascii?Q?9ufIB4C0pEn8Zx/OkX8FcVopkRqnd//oIs0NdHKiRpePh1PcCLVz6WgjRg8D?=
 =?us-ascii?Q?gAbknPeDdix8NRODNx66d9EVIkKGUIHIOWwBSgtocHv79Y0MCfWdW3VnDEIV?=
 =?us-ascii?Q?QTF4VaiboSDVdyeq7hxCutq2ML/Bx55xHlwBi7KkFsTorPyIKf/hnsfHC2me?=
 =?us-ascii?Q?5rK4xnz/iuHUBBtrybjpM6vdfPwW2cm4l03HZ4pHFfDZFYKHHsqWL9gyQrhz?=
 =?us-ascii?Q?ANyXlhBlHiHYPXRoMhBqXMJt0g2/wJ2rt+yhrX9xCOldT4N0mW60Q9wctRNj?=
 =?us-ascii?Q?9FyQQiZhIXCAu7xwnhp3jDog1T8cfJvUTalIh0uHfeI5ROICgU7BkML/bJAH?=
 =?us-ascii?Q?2PLn/hlwg3mCiq+4lPjggLeWFVH1sxzbZ0EartKTLlIIL13/jWrHyuMK8N+k?=
 =?us-ascii?Q?nNkxY+eZl80WffsaH9q21hn1I1iku5ESrYX87Nas0m4gWSL5u59+qq1WlpOM?=
 =?us-ascii?Q?RpEQ7i7or3NVPRa3SG3c8YaI+na0G4WKAtjHynfRNtkXHeNAYdav38PEmucN?=
 =?us-ascii?Q?0N3nKlBhJHzoFL19NdGUkm7NJjlDl2g/wAHsMKc6SE3JGXsn7DtckQXNtn7o?=
 =?us-ascii?Q?zJGR8aAsN1+0Sv0OYi7d1q0wcdn1bwDo9ALUkZXU4rmkT7MHY6crF8fPFcpE?=
 =?us-ascii?Q?g3pgWv4A090hBZBxt/9Z3wps4KtEuUk7FikmX0wEaK+FfZHD93FpVzvZpXqM?=
 =?us-ascii?Q?99qmAfquyxJRytDlx9eXy7DCf/BK5TQ6QlTXe3JmHwvhV/zapf4jJS8jZHWq?=
 =?us-ascii?Q?Q9Ag3L7xez8ImLnMxEEWlENQdd83dcMq/vzOIux3pA/UM5fSwhT7yF19cJky?=
 =?us-ascii?Q?Zbw0zYcVfOCKvdzESYFBOUpRjphZzdR7plN2RpTIv0OT8uBRfHs1TKXR/n1B?=
 =?us-ascii?Q?ZC5zfa1Wd4KSYe2rbIjlPCafGZa77qhf2l+uDVZPN7fivbmbpOOBmx76Obq6?=
 =?us-ascii?Q?hoCTYq778T+Ug+8Lq25WAED+myNKJLF50ht6ISz5hnCsIh7jtYzf5m2yDOMD?=
 =?us-ascii?Q?2mD/fWwqQ95r7onBDqyHzrAUwXW9JsHgUO63oix/UCc2MhuHXOSOxAixfWxY?=
 =?us-ascii?Q?yoi/HqZzBRt0ga9ZH6qHpOSA7v5Hle+w5LEL99XfWiT9kd3z2JZRfDRAXXgB?=
 =?us-ascii?Q?a8F54ao9XgpHuT1UxidC/n2xsYZo8qx6xRl/G5D8fs4FU0sDJ/PnFAx0wxqY?=
 =?us-ascii?Q?QkoMU/WIVffn/LVSpx4=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 00:08:22.1390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34061ea-172e-4646-8029-08de2892155b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10458
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 00:08:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18471

There is currently no use for it, and its help message makes no sense in
the context of bitbake-config-build.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bin/bitbake-layers | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 1154eb6d2..945921d9d 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -35,11 +35,15 @@ def main():
         add_help=3DFalse)
     parser.add_argument('-d', '--debug', help=3D'Enable debug output', act=
ion=3D'store_true')
     parser.add_argument('-q', '--quiet', help=3D'Print only errors', actio=
n=3D'store_true')
-    parser.add_argument('-F', '--force', help=3D'Forced execution: can be =
specified multiple times. -F will force add without recipe parse verificati=
on and -FF will additionally force the run withput layer parsing.', action=
=3D'count', default=3D0)
+    if toolname =3D=3D "bitbake-layers":
+        parser.add_argument('-F', '--force', help=3D'Forced execution: can=
 be specified multiple times. -F will force add without recipe parse verifi=
cation and -FF will additionally force the run without layer parsing.', act=
ion=3D'count', default=3D0)
     parser.add_argument('--color', choices=3D['auto', 'always', 'never'], =
default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choices)s=
)', metavar=3D'COLOR')
=20
     global_args, unparsed_args =3D parser.parse_known_args()
=20
+    if toolname !=3D "bitbake-layers":
+        global_args.force =3D 0
+
     # Help is added here rather than via add_help=3DTrue, as we don't want=
 it to
     # be handled by parse_known_args()
     parser.add_argument('-h', '--help', action=3D'help', default=3Dargpars=
e.SUPPRESS,

