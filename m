Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D317ACFC281
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 20:45:58 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21159.1763757951256918266
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Nov 2025 12:45:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=SSsmTZ1J;
 spf=pass (domain: axis.com, ip: 52.101.70.60, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsCrL+fnPVpY0fkJTHP5/bbxM6v8+HaLrCaA/xagxKXx/uzz0lBDbLie4hV570WgcWnsNaoQlqO4fOOqsXpqlQQw6Mhjsl7ckkmTNrG/eAPNciDe3sJLxaoMEe2jWYrmD2Ya7I2kAeLLTuhlNprwLMieOy6+R3a91wVM/jU4KVEf70hBQ/prNTpPxSo3x71JERxDotelXugtL2qv+ErebO9xn+LlAb47owAxZ+QnBDQBCAPOhHPVYiOOsAleR6EFjUaC5/CTeU8ao7RvPP4ioiwKYUHcEWEYOQR0R5jC4yeNeTKzOhD2g6PHAmdV87VkpZr2R0ild0LiDLcHAHkRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuClf3wRUUncE0fFbPZjW3Z29fzu+e68fmOz0lvlaK8=;
 b=Y7j4eeYWath/ByfQui8EKoh2e1i++ZKJuVHaFjvPB6NvCJRHBua/33Pm/UcukWlM2EvGvFn1QbCj28BYWpxS2g2IEWFCDVajqVpxWQ416dJlU3aRyV2aRNav4Cp6qBg2Wgx2mSotryr2+cbam2TVinkVvsFSfqT8V69VHVCVrjrOtS5Zi9yvkIh5xWJbx40fe/Tl3JKYTmCDs8LjNgdNqPnPs0M4/5uE1T+XEfc8JAQoE4Tl5/aMU4l7++RIlRh56cQ7z6uO0pzyZoCM+z5Sh2qyin/BJbnQXhwmnWPIiJbgSsFppyoppz4PY2zfCXZpY50hD1Y7LjqjeZVCzvhK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuClf3wRUUncE0fFbPZjW3Z29fzu+e68fmOz0lvlaK8=;
 b=SSsmTZ1J5Eip0V0w9QY2F4eQYt8nTzPPjhD0eLwsbsd01Qoi1NyBNkFKPN0e3xdUw15ayGMyGAyZd6qryvMRiXpolIL65wxHhYE6+a0NkItyZwWjfBA2p/MXqK81Vp3xVr/9IGi0GRLtGmfhjgSrPrxOXfJFuXN2BQyfq/wcO1A=
Received: from DU7PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::17) by VI0PR02MB11020.eurprd02.prod.outlook.com
 (2603:10a6:800:265::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 20:45:44 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::5) by DU7PR01CA0003.outlook.office365.com
 (2603:10a6:10:50f::17) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 20:45:44 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 21 Nov
 2025 21:45:43 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 21 Nov
 2025 21:45:43 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 21 Nov 2025 21:45:43 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7AF9D2CEB
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 21:45:43 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id AFFBD12031F; Fri, 21 Nov 2025 21:47:32 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 1/3] bitbake-layers: Correct the help description for bitbake-config-build
Date: Fri, 21 Nov 2025 21:47:28 +0100
Message-ID: <20251121204730.4057465-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|VI0PR02MB11020:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d2bef1-e96d-4b29-eb0e-08de293ef171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jy4iIoWhgkreVg+ley9TlxfkosbSlWcokUP6DK5derHAgTSh4zRuNXsuVRBE?=
 =?us-ascii?Q?9GPL//MnkpmloIqewxhr1gSSb9YXqEWiSyh/dZj7zScri7Xja5ARcAyeGwVY?=
 =?us-ascii?Q?v3mG6C8KgFn8w97DxzBcbpJ5AHLndvmFDnS3hSCiKr6qQ46D49YDvrToP3Vh?=
 =?us-ascii?Q?3DkZOYjiLFORNIocvK2BxfQ8PS4O4V6LPvbJ2ZU16z5N9cAiajgC2BSKkkg2?=
 =?us-ascii?Q?wFeZcnZ0iqxahGX/N4GyTQmIiHuhKRYVEyKRTRAnKh+q+QwoDHUJsjau0YOi?=
 =?us-ascii?Q?V2LhyQIyhBll8RzXyAR6n+94psTW1ebYECAeuoUguoN2xNla2mwFSKUmtBYe?=
 =?us-ascii?Q?QK4gksy6Y6KM/v4nxpfsN2+F7QO7gRvS7ne6DKa93obpRe7nqkDWelpNyAis?=
 =?us-ascii?Q?w5Db92M18Wi7FGSR3Axp5Jxf6v40Lu4FxuG5vN/GjAb9Xi0OfpzQOaiX7L9t?=
 =?us-ascii?Q?0LWHtIXnfUr9UrQVB6Kae5hnRCSQKr1zJztDb7HYp/8zT3JsK6X30jmdFWnv?=
 =?us-ascii?Q?AUtlBSqLuhwVksmNcA5MAqKsxHu39Ff2zRn+uBElgV3W///TdoIceNg41RdG?=
 =?us-ascii?Q?P1vMu3Zc/zxawdbpAG5ZsGdf4ZwzXWhcW97IahUKduHZFDw/HSIU/2FmBL8B?=
 =?us-ascii?Q?8ep9vfZqKTjzobPGlJloWkUyIiMRnppRf74ZsvSBhbjFNRxZiMzVNM23T3ZD?=
 =?us-ascii?Q?m3Ym+1bU8lk7Y334qvA6XJYyhuad+fOCqW8JB3jRkeSWLmEpgr2cuPPR51Es?=
 =?us-ascii?Q?kD3zK7gRUxwehB3zO6SqX7UGhaNtynq/HSWIk1W374MWxG+f51kBnPBGvVGv?=
 =?us-ascii?Q?oWaRMWDznP90q3LAjHWxu384T13x7uS4Bnk9kjOEntKkGUZxFzvfcApVA3z+?=
 =?us-ascii?Q?ZWJhMwFdR93WXnkiZzywx8xMVATZRExhvf2jjfBNqg6zlSmn6Ed7wZvlRaQR?=
 =?us-ascii?Q?XKCYOBnFNVCglvYp9C/LDRnJZjgl/KoawjOrKfO2xPCVL7dPI0aHKgev69N3?=
 =?us-ascii?Q?XGWK2kwn7ndH/Xf0+JUAivIoMVYJ4Fz369rkf4JCvJyUyfgct5S434RfTJwr?=
 =?us-ascii?Q?X4RZSh5DzEIJ+urtY+Vs086rVHU6VdFmADJQEQV81XBFqk4uJ3MUE6RH8/Vc?=
 =?us-ascii?Q?7mjL4kzIODQ9nRn59W2QdmZOAnJbiHs2+IPP8gICXqO8tFg4KQxEwhSrvCEW?=
 =?us-ascii?Q?Qbd6GlOf3kc6S/1cOU+M05LE3dHyDhdxYVyYcPw5y8dy6vS+Ud0lgf6X9jZu?=
 =?us-ascii?Q?I7e7DtY+eN+wj5lRmyN+/Sa1qv9PIXuNcWupbVk0HQSR5vzuIKDv1CiNp9mm?=
 =?us-ascii?Q?DOgFG0BLuuIILA18DzZSYE0XyGdm4i7lcmTY+s2JX8hiAhQffqBHox1Ga1aY?=
 =?us-ascii?Q?SdQ7jtJzWSnsDPGbETmYNR9z7cjfRtdrJiLuZ6BmSRGf88t/ylI4mnQ94LvM?=
 =?us-ascii?Q?dtmkdlLqf6C9NxUzzw5vH935wF5ZInUczDWKjvdr8bj3LOdHxURtDjmHAcH3?=
 =?us-ascii?Q?RPAVDY1pdIqtyPkgeo2BupsvQdxyIyh+HcgGK87SQ7FkGPqWLL115b8d6o3M?=
 =?us-ascii?Q?qIKKuNC+k41TAfEwQbI=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 20:45:44.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d2bef1-e96d-4b29-eb0e-08de293ef171
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB11020
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 20:45:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18477

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No changes.

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

