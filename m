Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D8CAC58A
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=RpSUDf8e;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOpNH8PZJnXds1JBrl/yLCExBPMU9SEotgbqOVYfdxonBIUrTwwmUeizuvdxBfw1B7X5tBK6LNJcO9yZbvfq31q3LjNsSQUVH5aU7q2sWOGeEL/tclJ3fHBfg/ByqkNL9FllFbSfDn+OfH1wkFKslblVetExZGGKEWhReAhopNk8lx5IHNPk2cBV91syZSKJKrTBWkFjg2XF3Osv86l1dfc5AhDIYNXErpwfXp6u5CpOUIlvEBRyoPvmMNMju3HE6OM5CLFUpm2+txcVdpTVExginfNj2lFz5ZbSxZIy4s5hOTzCbviz0iKkj0cTeiBQo4KnrYm8yopn1kzMi1439Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g70lbox7wsqQOL2hmPiU+ST8aeXYcjpmdmAUvFbrMGw=;
 b=XthYtBSxLuorSjZZn1A/c8nRdCfBLkG+N67qMRJjTCjbkd+rvy8UMh25f+ngyLIbznTrsP/4zBkxp5yLcsedsVCTBRDewGv4TwSop0W0GfestrAV/1r5UAwGW7Z4ozpeOMYOAir7mHxYjIi1h+c8V/2ZjmU+5Vt0XMpaCw2zQG8LJ+V31IhHsfTiBN0aRZxsEaBfGfa+gTjtWtbN3Q93ZNPvfT7rYAKZ7WGaLtV6TX7e/vMu+fMF21ki4JEZP2ZXlD77F4EzuhPkXcCJeihMnKQBnIYdjSJIzIo37XT7110rBUC4mft5hPZoq28wnSXxipTSaDWxOm0+rGEHKiCZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g70lbox7wsqQOL2hmPiU+ST8aeXYcjpmdmAUvFbrMGw=;
 b=RpSUDf8eJjnxJehRXV3HvyvWizIVSR/EIQ15OsLXzoUv55Vd18V/TWgGsbdFh4o04dOhzr9RACNhYEpxRJZDdkH80iyYtSZXBPCIENecg8Sgp+r7fkGNmUUshs6fdRhHbfeMGnM4sc9jRaW5GrtRbZsx5h3mtrCyBjiaAW2iHm28ikdqVdRG/ZOzHGAhzviHdCMb2Y2g3rGDlPaAdoXq4hxQKCP0FbzttlS7PE3r1ghekM6nDIxINAry0QFsIpXPKa04KNUlJcZU9rdfWT0cZi69+PokHOc3jC2XqXzueA/wsK8hOu8pBL+hdu12WG+iVDUw0MS32SpdIGIs770img==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:13 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:11 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 05/15] fetch2: gitsm: remove redundant set value
Date: Fri,  5 Sep 2025 08:20:48 +0200
Message-ID: <20250905062058.2563806-6-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: c017f8c2-0fdf-458f-9239-08ddec4468b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ACNiYQceyDOxNGvAUgoANvKy7Y7dxBlSlW36usgcz01XFDm6M24UmUgAeckf?=
 =?us-ascii?Q?2R/ZMlYCj1bV2oTxpzUTyhJOC1VcDYE2+vxLlQ5a9IO12WKdLEbkz+8hFO5F?=
 =?us-ascii?Q?WEQSaHxBKpdEMjidMH7ScMpFddq13QObMO2byPDEoruApbq7oSCG7QnTWZfW?=
 =?us-ascii?Q?fmmuTcFzfMKeqTkHllUW71iCib9QLCVrcEmdRUdh3Ntk8YFerHbrrOCZxHN/?=
 =?us-ascii?Q?ywYXedfVrVdgJbixBJ+0vvCOjU5qjY/Dkb4fK0x57k0yaw4OIKMlpzuDfBsQ?=
 =?us-ascii?Q?YE2XV5v2frzps32Z3x6MJ3dhBpnF3GbX6DgaNfpQfDB69TJ2bK0eWSXcXE05?=
 =?us-ascii?Q?/KvldJAuIM9aNr+DOA+x2DfuBkRYBWZWPr8ZMmL5rRoqh/ppB5y4bXdpRf7V?=
 =?us-ascii?Q?OyySROV7fqJLj5qTDUWFGnt30zTrESUfOr1jxfQZxEzV87QKUDdmdD195IVp?=
 =?us-ascii?Q?ZTE4/gqtYyo0eO1S8WGkC8SXz5CNQBk3+cx15w2Tu/qDTI+LHEbEq5Z4T5Gq?=
 =?us-ascii?Q?d/rcqjI91bHc8yveOcrplnPErYJgmBx2WnmI8FxLZhLk5RymFYZPsvd78TNt?=
 =?us-ascii?Q?y2ynJOtHlPOacAU8D8cX3R4yGwpirx0CJ6V5ojW/AbIQzKNyij9aAKuwmyPa?=
 =?us-ascii?Q?k6nxls8zXqPtMYGk8zFj0ywVR7H7uWnKeeEzaCJuK3gM5sGqHAoDQ/CE3PEk?=
 =?us-ascii?Q?0un+f9JxE6IoTSD6YKZWiZZXwPJqNwG/eCywnOx5s3UXXdLrF/949kK0KqyQ?=
 =?us-ascii?Q?0J28hS2vs3coDxX8Gr7DwT9Yq555+cJW8nQyhJIoAtyF4O2BIe3TSRMDb2Qe?=
 =?us-ascii?Q?aL7mbx8EpyyhUKg6x0/Zu0m8C1/bmtuw+Ogz0wTwiNCTQBmfhlsOhgtgYq6o?=
 =?us-ascii?Q?t/VyiawJSjZHVsmK9w0LO3c8opBIdFCsRyViIOD5LHHloSk27elgacZSt6Q5?=
 =?us-ascii?Q?zMkiW3vvmH49XwocJGrtXK+8TJtZPwxRAkaOBGxy+OZaZhEz+HruEjkgwFub?=
 =?us-ascii?Q?/UEs3B+3Q+vWinlIZjWAi/BGzoYuaseaeq96PeBEEJj+1Cxy9w7PdpL/UZlF?=
 =?us-ascii?Q?i345K4eOCYkyFQjA0UrgpFmAJY/67BOZmy+Wa9wKP3j48vSLGAfjiUZUL9wS?=
 =?us-ascii?Q?ZCSfq+Ju8R/LkWImIwNkyJymgxIW50q+6+uk0dZ1+opnbO+ukpLWCDstBBf6?=
 =?us-ascii?Q?g0nrMLc822Fw1BrD9H4dLpR2Jn+OH1RRs5vRcj1/QuYivxEkL907mEhwhp8m?=
 =?us-ascii?Q?XQAVmUE5y6iGowffVvY48v0i/JxW3AMoKjlmcpSwpjMh7Dy7bxOt28sdh5kF?=
 =?us-ascii?Q?G6FntC9VAKxqSQfZ1Efp0UtoDfYG6xrMu/4U3mcvoNAzXlRRgMlFKc7wTNpc?=
 =?us-ascii?Q?wmck1vxrVeG84jITtlyyRod2ouwb6FUnwqRixg0St1YXwc0UZmHFJD544lms?=
 =?us-ascii?Q?ElgPlYGkNlwmftRHVz4v9IxaYYMCfFIWuUPQ373iYdsDcW34Qe8QhA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HBzPcm9XacIquU+4pLzxqvUDrbsBilwP4RUKXiBfHZ3ZnurO3nx2xkWV0djr?=
 =?us-ascii?Q?2NUYvopVz2lS+sOLU0w2u2YsJ4HirotpugeY4UwGkQImph7Yg4nKWPE/UoQZ?=
 =?us-ascii?Q?qyEafd5CuQL+PM7mqtCE8DzAwHKTMSoqh8kH51Y+MpFanShheBfMPB/dFZQ7?=
 =?us-ascii?Q?4I7Ids4gCb12H7hXzsjjuVrnEE0H5Eyo5jFBTjMRcTcadZSL7tVNyAV56UKW?=
 =?us-ascii?Q?ug3BsNYr+TP+VmWTlPx4fjW56v49N/BWIrx6ESU/+reAVPASdFHIRjGWoIbp?=
 =?us-ascii?Q?XJyyubwZsXIyd9QctR6Nw+890OzOagyqM0vzH7hrMi1DKCudOLLb4DxZagGr?=
 =?us-ascii?Q?tqdMLmU5tJQAzMMlovxXoNG2/8aX47sPJjQn9i7EGAbrtuxIKvkHkWwhka7a?=
 =?us-ascii?Q?EsI26FVGWqB/r5tXyfxPS8PAE0ATeP5wfy7ePBhux4AnI98TgduhkWY6o3+z?=
 =?us-ascii?Q?SP24GgrndNrTir1opRmdJtYt57RvV3Cnbaniz2zVDrR5F2bbBkRbDLlxTmuN?=
 =?us-ascii?Q?FzIWgpOlqzIQasSEpexDpVOwlGvdKn3PtHkXXb+BN7B12zPfeWIxcIdpYOGE?=
 =?us-ascii?Q?+dmH8tvleVBqU5P1+Bw9dQ319uQI8/IRKKMn4H3D+2N98JTFvfBjvj1Ep3OL?=
 =?us-ascii?Q?3p0P3f8O7MSb/7FEf/r2oOLQHPFzJq2E/BsKP+eiKbkEAv2inzR8MyGZgDqa?=
 =?us-ascii?Q?KH4oUXJG2romWBeILxBC2XXhFtF/V57xNiL8aTyNN5DCPYRCjHKp86veWpRG?=
 =?us-ascii?Q?NGFrjYZ18lQHdefNS6jU1OSDs7AK4aaWohGwWfkbfgQOKRD0R6JaxJizZgCH?=
 =?us-ascii?Q?tL+KQ4V6Bglpvun3ddIGpcSKYg3H791W8msm9ddxHlDc70tZvGt51Tbd883H?=
 =?us-ascii?Q?2KsLuHkwJVYSydhnWdrI+BDKjEd+p39bdkgX7yqR+N7EsDLwT9VBoO2EpaYp?=
 =?us-ascii?Q?izUFixReVfVVvJZUIzImZDdpYyStFUZ26NKXEfnA3uxiy0blvavEw2IWAy65?=
 =?us-ascii?Q?+xs6bYdH+XCFgOkGswKqFdZjm8aFjuDv3yO1YADVfQhE04alelzC82CYkby4?=
 =?us-ascii?Q?LvXpAMLulIKsF6ipleL/kkhuPyecVhxpX8J3Z+HNmWSGvkXh+AD9kjs3ThDH?=
 =?us-ascii?Q?b+DArRJddr2vO0m+8HqFHQe2jn/G53ShtOmYxGVaZZUybUEuRS5lIvmVAmJW?=
 =?us-ascii?Q?5uUjX68/IWBAfbxoWmVPoCKK177hWcX7HVubFw6RzxzrviXrKitg13aEztem?=
 =?us-ascii?Q?nh4F3lBWFiZPVcADYxXP9PuyOjcjMwMPtipIXLjS1/MBZjCTl7+DJJZNjpBM?=
 =?us-ascii?Q?wRs9qoa3XkYTmqDBPc1nPUUlEXC2HlRGupJzihjKJ+zoWB5sfO3s9Uhvw21B?=
 =?us-ascii?Q?baLLLiQ5DP1gQ2KT6pgoS4Uu1e+T8lGxxmQpFFS8w2n1mFILAN2ycQCD9fOq?=
 =?us-ascii?Q?lMz/X/tZ2FvzMGskUhp5ItcJOxmKp5DXe5xuwl4x6CE9re3w1qlOty/dmkxg?=
 =?us-ascii?Q?TtvF7Qr+Vip44cCxrd1F72Qd1gdUdeJO55WY33hX+LjXkAKARMGO2pJEUvFh?=
 =?us-ascii?Q?ZzMA/058nmzv/twCcG9piNSiXrrrKq9qMW+tpWuq1e9KwiOVNfsltk6cvJ1q?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c017f8c2-0fdf-458f-9239-08ddec4468b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:11.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrtU+ynE63yq0y6aMnN0yPDErIM18nA7CUda7QaOV0/WQCnUDrK+P4hfTVBxgE//M8xpKXO6osBFnG+fWYtoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17962

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 9baefb3e6..15b9c3740 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -139,7 +139,6 @@ class GitSM(Git):
             # Workaround for issues with SRCPV/SRCREV_FORMAT errors
             # error refer to 'multiple' repositories.  Only the repository
             # in the original SRC_URI actually matters...
-            ld.setVar('SRCPV', d.getVar('SRCPV'))
             ld.setVar('SRCREV_FORMAT', module)
=20
             function(ud, url, module, paths[module], workdir, ld)
--=20
2.39.5


