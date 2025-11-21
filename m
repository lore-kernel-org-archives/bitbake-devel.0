Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F66CCFA45C
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 00:08:32 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.320.1763683709988806168
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Nov 2025 16:08:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=T/JdgbuP;
 spf=pass (domain: axis.com, ip: 52.101.83.38, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9fXxQkUCcpWyI7kV2Nw+2UDKrXiH2PqY/eZOAFYdAedJBaEfEoCpZ7SQmdCOlvQl9SBZhiOtQ0BnAa8CVJ4uPuZ+/cqxFLvdxNcAJtBvlgppki9EkNSl1O8PgSFDcYDgy7lD1TTNhEosfsFMb+XU14F/SZnf6wcaN/jtPAf4uQeNMdAi6f4OXxOjpirPGriZGHz4GKjkCTATKT4bn3SVmREYbSpJyfANuGxB4vnVv67xGMo5OCa6OC3yRthttnwum9fGQsTz/y7oW5u9pLe6/CHcyr6kWi52hCL5nCGgSGXrWUYqGIVGsh+DqWBPe7Y1JvmpsdH4EvZKlWcmoPonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTQ0+DBmW+998SlI+m7Fa/eySUkl40+Fbb1TEnctG9c=;
 b=YRBcf/GZ9k0uHSU1TDERSsZtn1QRxeyMJat0Zvw7Eb9XOm/wCe0nd8gSrnmOHAwvT5Nm8EICC8DWC2VgQ1JW3LBfwhZPAJXKgtQV5BQtahGlgva+egYXDNMo8+W7P4HPPIIDH6nDjjn1EhrShnjHud13CXJCD+gIegIAnjDqFIyH3EfSu6ZCXyTBrkovYveF7CArypUTUDUV2QWpJJVFZqSWnzdoDuDNb13FvUwgG3mu+yS/EoEl1eK0ZZjeVGms6Xm2jPsCemnk3cM/QdtNLQC49fb8tI0aVR3LFSJGsdM1mVgfzcY1KM1D0dE+oKaB5A+p3n1w+wX5k5N0BkvDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTQ0+DBmW+998SlI+m7Fa/eySUkl40+Fbb1TEnctG9c=;
 b=T/JdgbuP9wO3GcCc5gzfoBE2ejW/D5DxSyU8475IQvwGpC+LeQcDjJjlCXl7MTblsOqs5NbysuKy7qMqjrFu6IIGPfQSlScJOVsWSx7M6PiLLg4Rhycyu3Ytj3XRhq2mqZeVRX+TugqWlpkCFa1UXlfZgigitIpwz6lYCy3eT5s=
Received: from DU7PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::10) by AS1PR02MB7917.eurprd02.prod.outlook.com
 (2603:10a6:20b:4a5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 00:08:23 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::68) by DU7PR01CA0031.outlook.office365.com
 (2603:10a6:10:50e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 00:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 00:08:22 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 21 Nov
 2025 01:08:21 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 21 Nov
 2025 01:08:21 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 21 Nov 2025 01:08:21 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 899542DDB
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 01:08:21 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id EE84412058E; Fri, 21 Nov 2025 01:10:09 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/3] bitbake-layers: Correct the help description for bitbake-config-build
Date: Fri, 21 Nov 2025 01:10:04 +0100
Message-ID: <20251121001006.3756451-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|AS1PR02MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: f8be5229-2992-4aaa-8cb6-08de289215db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZSVFivEwR+LGJJFONX43pP2ciWiHf0ZzsJeXijBcSSRU0cUV0YcKRXnLpowa?=
 =?us-ascii?Q?3SxwM0IvNC31ti7eaeV2XjJIvDBm0yeqzj+wUH+Y8M5RH4gOeHCFdDRLKOFX?=
 =?us-ascii?Q?jO6PZX81BuPlWki9HahZNJSH7BhEwjwzU6BxfwTFUOjLhmgDVGJyQnbH0ljh?=
 =?us-ascii?Q?Ahu9pHkWpotMyktyqMRHH7LJTPXHGbeL/mnJFmV3DTD63UxYm2DlXwwMr3Nw?=
 =?us-ascii?Q?qeJZQDPudA8mnL+1e4MCforjfbIVsGjPvzRgGH/kHoQGcY1nHsf+zbpSUuzF?=
 =?us-ascii?Q?g2ZFKPz8797oPM6LWqPYwgobU8NMga1vX6xKqzpVpjCPayTQ5+9VSR9OIu5M?=
 =?us-ascii?Q?zBkZ8MBj92sOBBhTpPXX18vgvCkRSv1LGyjSQ3IJVmINSDuKSSWNtZ9oWaph?=
 =?us-ascii?Q?/QB6Ejpa8LJCcJh2QU9cxJRMDwpeQGlNx4lO12+ZmoGUeoxhiUA4KZxorpTX?=
 =?us-ascii?Q?lhm6PWG5AWCnXGdTFYA3AbK6Pnu2bADsbRKCOKKZY+PdIxqwmzf+xkcnNnhn?=
 =?us-ascii?Q?ZSUjarij+Z52nfMsq8aq6VEbTzsqScA/unJ1Eq8R49HDpBZzotoWZx00fqvw?=
 =?us-ascii?Q?UYoAXyUrXueBqLrSunYXUDjX0K8keuSPUaG3Dwmr/VphzUlH+l60P7QbsG2y?=
 =?us-ascii?Q?lTVE6imDWCW0IrE5Y8uNAQ0iQKtCyAoIfN7yesBGlY/vE51zpIdDo4bCnFiL?=
 =?us-ascii?Q?5YyO1vDxJlf8fJuk5M6gemd2t6tfw8LPZXHg/cUSKEm9ooDuziZ7NUzPV0Xy?=
 =?us-ascii?Q?MRh+aF7JXyaTrkbEsr4L3CbEdz3Ub0EA995jYmSmhWM5u4z5fyLCu2kgXAky?=
 =?us-ascii?Q?lix4AbIxEOb8i1aeSVAD0TcWtV7icgqfn90+oTTrYcuYifbdhtkzdkPxFBPO?=
 =?us-ascii?Q?ZYyrMjngYvcIj0X8SHNCpWQZM7I8LeCAvguR7ofBHCFrj2zNRkvTvKP/ylJg?=
 =?us-ascii?Q?p561pPhzopGxC3OQQqbO7YKo5Nmn+PTdXlwwHVXMY3Rv2N5FZWTmeDoSP8EA?=
 =?us-ascii?Q?KiHsCG7Z/ksmFSHaiIB2QWze0aB8RsQpSf/qIkHS6sBRHe/fEl5KfTkcoHkb?=
 =?us-ascii?Q?s91Vke+Mh8C3y4NeNLbfqJEmx+pbOQKHlGiQWp1BsBoc1fHJdM2P8CCyT7f6?=
 =?us-ascii?Q?UylLfQ/TPxVIahsc2j/5imxbX7QGPDiUeMzP+KZRDVV+wYA10GMblZYHqH0g?=
 =?us-ascii?Q?d2Eh4MhktpAZxQQzjh3U7YkfesHVI5cnUuRYODIFoaIseRn+lFem4Ya+dIY1?=
 =?us-ascii?Q?P4B88eAuKApPhFO1FoSdrrflk9e8ZY5Z7GezJSsvv6WLn0u3JjrORhBRgaZ6?=
 =?us-ascii?Q?jW7AJ6LFV0DLQLlWWJ39eZ7l5ZX+cnaurDeWwjzFUUwYkwzDWRY0YfbW4ujl?=
 =?us-ascii?Q?biOzga+37mVtw0jRG5SrGJv3iDZDobvGf3dQYTm4Q1JZCHX1tPvItySdA2QS?=
 =?us-ascii?Q?7o1kZwRq0FuiPysZGMmNpH+c+kHsSPC9wce3Bkr0YNo2/ttCKuzPIS6ZsPu/?=
 =?us-ascii?Q?EtwwhO+atCp5l5fvAN1fypmrTqxWNjsDVhfFO9bLeXJSfC60uZl3bge9T3D5?=
 =?us-ascii?Q?ya6s17/isETMoVX9/nI=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 00:08:22.9686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8be5229-2992-4aaa-8cb6-08de289215db
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB7917
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 00:08:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18472

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bin/bitbake-layers | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 7d929567a..1154eb6d2 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -30,7 +30,7 @@ logger =3D bb.msg.logger_create(toolname, sys.stdout)
=20
 def main():
     parser =3D argparse.ArgumentParser(
-        description=3D"BitBake layers utility",
+        description=3D{"bitbake-layers":"BitBake layers utility", "bitbake=
-config-build":"BitBake build configuration utility"}[toolname],
         epilog=3D"Use %(prog)s <subcommand> --help to get help on a specif=
ic command",
         add_help=3DFalse)
     parser.add_argument('-d', '--debug', help=3D'Enable debug output', act=
ion=3D'store_true')

