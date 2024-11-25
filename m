Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC004D59D72
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 21:06:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.84])
 by mx.groups.io with SMTP id smtpd.web11.29864.1732568779001544116
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 13:06:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=wgzSiW2H;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.95.84, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLwQILbQtI9i4j50AoT8YP0wcm8QZvHu3B0MJKKiNaguYN82ismqjNlofCwFZ0CHaidQtMqulLa8PgxFBjEqeDrk3j72tvZ63LKFNZ0JGx/r9cCtUi5aLzjKMfLzG10RVLcvWPlYOrScrZDA4kpDKQrKvXpZGgX/C/tmaX1zKrMtPJXxRHQrG+dZ4g6mB+iBmhMEAVo1ZWCJlAli/pyj+oUDS1LLeHyM4Z6TRW8lNodSnD5alF+uHQyz+zLmoc+89GrUt5/PafZGEbhjWoKuZayP1UNfweVRXlGVrT7sjdhFUKeALE5kKwoSwge+Zn6ZFCgFr26qFi0Kunhdbca3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RcDs1ik7pl25rvflF+1ZTxxgp87+Y9hiQOFN5gJqkQ=;
 b=AI7YAYggHzDiJzBCr9b1DVtcjDEupi4YRUGoG9mU/tfCsF02fL/QWinIN9riQHLeq8bUYdxbs2Tcdeu/5wf/QtS6CyTGij3hRBiHPWA6Ix35/Frb/pgNAY20Rh7GogFxVCNkkSJtpIiE4/pNeutHv5leS8TdVMt6c2zwoY062/V51KvP1LeEQct6R6rsgzZkjh1p0vgKOOr/6FPFYAe8LlXJwRbrdoP4P1GwryN6PERmR+QsXpvraW7tbV/votNlGBcfBaxj6pyC6042VZQmeIDZOOZVehBN3cS4JC2tEQ/8NCESotmgF5LQRODm79Vl6kT4SBSRUK4RMdcggzOGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RcDs1ik7pl25rvflF+1ZTxxgp87+Y9hiQOFN5gJqkQ=;
 b=wgzSiW2HR1J/77YUheX1jLv60mVIHXrA24utSMreez7JL3cENSteFA3YXawgAstPw+l7/MhC0sTFSVYuY9cnIMs4osUZg+mon8ehMip1o1v2SXy5CPG+vtJFYYzghVhq1ivyFevs6rHj8gcW2gbskJizkWc+sd/PyMy0RZFAXrFo7UFUYRE6rLEfRqWwYuYGZJLTq3jEup4U9Rd6uuYpzpM99tai1zuJSaLA5h5c/VqBvyusz2t/aMicii4JcXMo3O/+66c/aD46qwkUnpdJlpeaGmAYGYI/c9b/BpBIY5rWto0KBH8FrIA4GD+rb0RgcvYJasf6AJPe35KKkufYGA==
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 21:06:13 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::9) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 21:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.0 via Frontend Transport; Mon, 25 Nov 2024 21:06:13 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 14:06:09 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] bitbake-layers: use 'with' to manage tinfoil context
Date: Mon, 25 Nov 2024 16:06:01 -0500
Message-ID: <20241125210601.1752450-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 3100cba7-2f5a-4dc4-9945-08dd0d94fe8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lKMFlNlvSB04Q76RmXx/Ffr2nVijZQi3ILII+BqpNrpL+Qtk2R/SfHUmHYmP?=
 =?us-ascii?Q?4MdDdgo9ztoZ0fwHrb6FA45sv9TJdB9dr7PTWHndMSzSz5iBvgSL9V9rRpOq?=
 =?us-ascii?Q?08Yf5oTyezZcCmydGjf2v4lXzXOFau1P3P6nVIKTJs7DYU/cQdzKCDx+uP0R?=
 =?us-ascii?Q?gh8Chp1p3h+1Qrf07vDJd06JvVYY3dH2iNqWPfdi2VJvannPM0K9UWsHULtl?=
 =?us-ascii?Q?8lPS9Sp5GcRnyhtLZ30vfQLAO8sr/ICK2t5wSQr0rYKam5RtXpm22lt57vj3?=
 =?us-ascii?Q?Yvmyy2Cd5R1XT5JRn59tey7gATr0JPqZusFdqjghpLSuQJaLD+ClbpstVbwv?=
 =?us-ascii?Q?L1fTXRIYdeMvJBNKqgihIX973b+ckDFZbQaptbxTZ7iJ6PhBmE47gl0FHrGx?=
 =?us-ascii?Q?KLffBsQ2TbBGOdx04U+ZbwdImI7cVyLY/5TqDxr2IIZw+q8LPjdefAMUse/8?=
 =?us-ascii?Q?aMMPFh2hF06UfAYqnMZnGt0YKxjcTHQHoAB4XfULaJatFWZI9HqzBZihfId5?=
 =?us-ascii?Q?PfZyir86hTrRDNuzaFvUwvSwUWCZopVKki8hchSMQWgDXq45Ll8GmtJUtg0B?=
 =?us-ascii?Q?xqBX/sR6E1jCPoWr97FuheMv2Up5M8nCGPMnlLavzn/QlQ44oeWpCvm69wTG?=
 =?us-ascii?Q?THJRPQJPCY56SaRveIcTrKVREZ94TvkQd+/aYpddbz+jTOoVSh7eKjRrcYfP?=
 =?us-ascii?Q?HXb1bnq1eSlEIvs+ZEX506zk4rro2xKCxy651vrGRGOtekDmlafXk8fDs8Sf?=
 =?us-ascii?Q?h8jIF9cBPtL6JFRF/9Nz0LFKFID4itExyejPR1/UjHK1TQmFQG+A3t4t94B5?=
 =?us-ascii?Q?mi1kmqL6fA8rQQQyfgVy6bOn0PYjUKpcrWWzdAFzxnPNXmHS6dasknd5zkYM?=
 =?us-ascii?Q?jHz39y9KnW1z5fJamNFif68KnSmS/9kC2TXR3Xm+bLz8hVcKoJ4Am3kVYPcX?=
 =?us-ascii?Q?YcH50rYnrb83iq2z82AVvEuDLe+tKViHbGSdnYPH5jL9ccfJopbJv4687aUj?=
 =?us-ascii?Q?kqaDRdBeSM39KIz8fdJw3QLmft0C5L3asJ6eOS8kdZrg8TakX6ObtguMZOyO?=
 =?us-ascii?Q?0hnI3xby//edg58jTZtbM+tQbMtnsvNFZAoveBccj/a77Fb7Px8cWvWHp40t?=
 =?us-ascii?Q?l7NN0oYU0rk1kL/icqj/3HRi0LKXAMkV66UguyVF8wZ6etswAZDCjCtCTUwa?=
 =?us-ascii?Q?VFhpX2lEAr0fI2Y4bj9pXzJL63f9Gj+YkKv7gRb7FbTVgFw2yh3Y740e6hYf?=
 =?us-ascii?Q?wSU2Q7zrgtOWU9Y6ukohw8RuupMKk53AZ3AEXZ4t4w9xqJbHloFywz9ZP2ak?=
 =?us-ascii?Q?R4M8QVEThLmAfaB+9qAXDDUtXf/vWMm1CuVN52oBe97msMXcwNuOz18JW5YJ?=
 =?us-ascii?Q?VJPnIwSh3OjKS3RDcHEyKp5Hv6aINwVdz6izoPGDgm76rFtGH7v9LpkDXH1P?=
 =?us-ascii?Q?KD+z3h3hkq3/TdqUuJIGPdgd+nbkCN6b?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 21:06:13.2529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3100cba7-2f5a-4dc4-9945-08dd0d94fe8f
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 21:06:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16837

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-layers | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 613e675cb..7bd3ea20e 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -57,9 +57,9 @@ def main():
                          level=3Dlogger.getEffectiveLevel())
=20
     plugins =3D []
-    tinfoil =3D bb.tinfoil.Tinfoil(tracking=3DTrue)
-    tinfoil.logger.setLevel(logger.getEffectiveLevel())
-    try:
+    with bb.tinfoil.Tinfoil(tracking=3DTrue) as tinfoil:
+        tinfoil.logger.setLevel(logger.getEffectiveLevel())
+
         if global_args.force > 1:
             bbpaths =3D []
         else:
@@ -90,8 +90,6 @@ def main():
             tinfoil.config_data.enableTracking()
=20
         return args.func(args)
-    finally:
-        tinfoil.shutdown()
=20
=20
 if __name__ =3D=3D "__main__":
--=20
2.43.0


