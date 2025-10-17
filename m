Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98141CCD193
	for <webhook@archiver.kernel.org>; Sat, 18 Oct 2025 10:16:56 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.121])
 by mx.groups.io with SMTP id smtpd.web10.15120.1760706818774802432
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 06:13:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=H3EY7IE7;
 spf=pass (domain: navimatix.de, ip: 52.101.66.121, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+B4uxGH2l0b8gQB+iOkWgEIqgsHj2jt2f2zS90hygD6pVKWbKsLVjGAZPwQWMGwm3RPmISPzgwHFcDbTDCJRGmxkbQsfltwdqVjUK9nfAFUNSVsxvDzVEpZrt5ezD/WMGMFroeBO4bCT+yemfB0o/vGbaxtB6mJYl6dePPyp9tmT5iEi99S5OWLcQgMHUxGyj85bxV2YGCiF+6hs3KywtXiZ4hYWFJXQgm03F9UkW6B5MPxUeZUV3nRRKE7S6gWfAuF+JhuXh5lG3PxPULUcVx+8ChIQGaUob9QmDurJW4W+OWyCl8Z7YPjPAjlnzw/aDV+NQNrwybZzwlAWs5ktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxIpjnoPw1NIjZgHUGDQkZLTGXClrMlndEz/UrJOF9A=;
 b=WkNaAKhVUvdsyFLh/0FWXHpZPkLTH0ikYNi8NUuCwVJLfk2o0JFnUnk50tHtZ5OtafwUTy17wbVarzvBBW8stCKanl/0VS7ack5B7emWfqw7+CbSZOeE3JM06qNes1REFlJM186UKtsEC6D9mMtyRIkuCdyMXYGZe8GszElBwWercnsHPE8GfBogAScwbbJXU/vmhddLJEZqyASfV3+Vz75s4DlLwnzi3HU6uJ/YexIBY+efrfAmrBkPPW7slIbpG5mGht6aDPB0LbwMKZX1ETxG6WizBM9L/5ziNAdIFMG83lc1Fd4bcW9lgIi92MMDTnGEQ2ho408+cj+s2ss13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxIpjnoPw1NIjZgHUGDQkZLTGXClrMlndEz/UrJOF9A=;
 b=H3EY7IE7X3DAKiynIRaCVakxDdPFhJe59XOlKYPdEq+ISFVK4Zln3WOnXZ7wx40reFyuOx4edmxa+Id6NBPefOCw7+Osu7RtXaXC1dHl4gBQ+AZSsgksXYzh2ToMpKj91vWcpDH9aXufrubTyQumDAINeOke4JZkbsvYvbDPHhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from PAXPR01MB8552.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:22f::12) by PAXPR01MB8304.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:217::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 13:13:35 +0000
Received: from PAXPR01MB8552.eurprd01.prod.exchangelabs.com
 ([fe80::4e21:cdff:f882:4f32]) by PAXPR01MB8552.eurprd01.prod.exchangelabs.com
 ([fe80::4e21:cdff:f882:4f32%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 13:13:34 +0000
Date: Fri, 17 Oct 2025 15:13:33 +0200
From: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
To: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	joerg.sommer@navimatix.de
CC: docs@lists.yoctoproject.org, 
	=?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [PATCH] bitbake/doc: Correct name of bitbake-dumpsig
Message-ID: <2091cb7f717c98168e7d2381614959cf7d976933.1760706812.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.51.0
X-ClientProxiedBy: BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::16) To PAXPR01MB8552.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:22f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8552:EE_|PAXPR01MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ef5ce1-f3de-4fbe-4e86-08de0d7efa20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BS0coRVaSxJgCEA/h8a2Qqsl/A74/lVmRmDVOCsa/FT48qPSGkiaY/BlTOXZ?=
 =?us-ascii?Q?xrFL3oNpYH0Y1gTCCxEhORTTXrSwIdt0cZatAfsbRYLI0611793jpDEY71BW?=
 =?us-ascii?Q?VYSpXARRD/UrZpsikwar3IOaU4U8NBCyazcAAERZ8VYbjvPqh4cpvIcWe30y?=
 =?us-ascii?Q?BCaKySL1XcAB8KvyjtRsqYvZU/Osy5dw2ugKpxmN/3hm28Pp2/gZSyxpG0BW?=
 =?us-ascii?Q?rOO86THH7uPehri++B2vmMgC8yvGoCAXoW3aAKvRmvhSFN657/gJmOivnmAK?=
 =?us-ascii?Q?fGukXT9dvwtp4E7w3kAVQFsRrhU2m/YBdBhZg+ZjVVnJ2f3pPbM7vhZZELpj?=
 =?us-ascii?Q?Q1mXxAx+rAo7Cgo9keV2dJPaDuen9XDSFtCBNes+EBI5+xK0OTJx4gSZ63np?=
 =?us-ascii?Q?J8rwkcPl8kDTuqw/DC+TY0N8nNCiTyK3G9J4hsYL+WP56M5SG8FZaWtHT+Af?=
 =?us-ascii?Q?1Is588gDv/9ypy1W7nGDVmyuJB46NB1MVXTXLudIWwejzfx+KT7LE45W74Z7?=
 =?us-ascii?Q?0g1fSt+grlHZJ1yoDpyMYKWprmOFSpW8yqaq1Gm1u0MWQrDSC+lX0KMbcbDF?=
 =?us-ascii?Q?RaJmiunVAJmsFAK6nW6kwA/j7RNWB45wZWWoXyt34+HbHjOVc9es+U0e1F2A?=
 =?us-ascii?Q?bh+DGLNof9lx4JDXNt1W1+7BZ/kqqM1YxYdjCzx8FJ9/iQ9C5G1ASDm3vloS?=
 =?us-ascii?Q?pPXi/IOsFH/aynogV2yvWxIGFUTLeDkpfzT8HBY9Hs4etc4OvkyBvm1E3wxo?=
 =?us-ascii?Q?JYCkY7ud5g0JTWfRuhUGZhPLUWZ1uyyPhOeC1Enx4tHFE2rgiFlNAAyBw8mu?=
 =?us-ascii?Q?3Fng0zu4YGvilkeWEyXmHRUMLZns6lnvZBfn8Nt5imxwja0vF2Zonr/GoiVu?=
 =?us-ascii?Q?IC1FGm/bjZ/1HR+jVvtWMa+e1DMixKEyIg6c5sC8qaPBeU6Xtv4FNRNbfClG?=
 =?us-ascii?Q?n00WMYUWmkLu9B2dZiiF8qXl5qxNX0KZ3oJoU5PWbThMmEu1BeFw6/K0UW4Y?=
 =?us-ascii?Q?Xgp/yeHPXfyCytcVK3QeGQS+4pseVd2ZgKIGIbVqv2J3hykpm6uGMvBtHMVF?=
 =?us-ascii?Q?oCApqJz+SW4lAPDdsrmHhAWCaZCFlSJSOPr6nPL3jml0YDCp2DshkYuZQafC?=
 =?us-ascii?Q?pYyTLvlpRX39is9lLrobEZzdhdPpuUKxil5qfWhkF00+KqWTowP6fHoY/nVu?=
 =?us-ascii?Q?4kBFk6HjRonsNvf1L8tvNP/pL7Fa768N7riVw/AN8a4BnJv1Qi4pleMG/FMo?=
 =?us-ascii?Q?hVTMbC3bo4M4Oxl9iPQ0AhXz/OGk0Ugz+FoXjrVyyQSRX59uyhrDCqruCler?=
 =?us-ascii?Q?up7bWH1ad4UTdch0U3m5qWU92NL4APtvRnJiFS8c7Xsf4gAJPpJquIL9Zmww?=
 =?us-ascii?Q?weZ+Enes3sRK57C9WMcIaUQxGuuf1JbL4D9maC6lQECV+vcC6RoLyD3Tb514?=
 =?us-ascii?Q?ZB55+rRBW8Z0g8wGtRo1WonWx3n89R60?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB8552.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sDRpoBgTKpUrxZjDkdid4aa0MbdbclUxNVfkHyFRJGxgR3zK1W7zRhRnpnTV?=
 =?us-ascii?Q?oKXWJqFL7KepCIAkJmOUEpkGZIMCxgn85nQp3CuBFLPGvdPPXBGeSm5+aujJ?=
 =?us-ascii?Q?piUHqqUGTISfDGT39YOmf3swusNx+qlpk+X2vWRYgjsY6LCcn1fuRledQUNC?=
 =?us-ascii?Q?EpKrGCT88WhJ395zEUW1WzPwiXfA90NmcFRK83ffw6VLoSJxwHWg6hdWYRx6?=
 =?us-ascii?Q?KiE4jkovSIPR2UHJ11s9wobl1tF29hAG1xmHdiacmeErX80MewdzCqWsD9MN?=
 =?us-ascii?Q?W2r91MIhlK8igtV5hlsbQLfqUIc8eQhTYLu12fu22VcEk3volU20PtMorHU0?=
 =?us-ascii?Q?DvoLEhs2N44ErX9mi3LYcHkOqLaVPx5lz05JTdM8HnmXK9oJMVkplOahknLm?=
 =?us-ascii?Q?V2V+wAMOIxicAvDSSpoKfnKVEdDYmgMnk/9sWEOcn2Gbg9q5zOXo+enr+YHy?=
 =?us-ascii?Q?QxLMLwR2CLfkH+iKKKvgbu+By9mzJC1NAI6imOoyyPoJwPVFb/oLeL/h7XwT?=
 =?us-ascii?Q?6qnjKOdAxsnxHuwX3JzSv23/iEPqAXZ3fILcKjepYkphSmS8M2up2wpE8QrV?=
 =?us-ascii?Q?IsGXEh/izMyoWbM1jOmqTPvanhSU8/8NPHOZo2ya9snv7cQGfHUMnBBDY2xM?=
 =?us-ascii?Q?TX48yOeOBLB3WmegH0wSIkkoG6uRFLBCVRtHkyvkx1uDV296OVyKb9OoZClx?=
 =?us-ascii?Q?wc3i66E55/zDijgoDxWDua292mF0t74ClnbKlio2AjOZCtqE7JG6+lJogKdM?=
 =?us-ascii?Q?R3w5RMAwhTRzZnIv7NPIAR34os7FXe6TisSzXZFa8wKUGdUk3izDtiu2wmlg?=
 =?us-ascii?Q?wkJhgl3yLbjUfeuUNiCw/1N1tRL66C3sRhJBu4TzBr4N0k73dDo1nR+h6GqJ?=
 =?us-ascii?Q?GrS2TdCOH929q+kcWjS+M04zlxve/mpU53c2La9Rlvb2zUa6BXt3mdhb0OIV?=
 =?us-ascii?Q?s7NLZml02mOnZen+b/f3fl2WBPXaRbbAD/3flmSEvIZUeX3d7pSnORVGWngq?=
 =?us-ascii?Q?JlaZpHR/v9+Iev2b+9TonH+5L0keUyllp5yYM5tl5bbAoiTmHawI4MIPKKh1?=
 =?us-ascii?Q?KnAIexIJRqfv9FiAcC1c4R5DVLra18apCW99GgIFHM7wydVswHAKGitDhh9r?=
 =?us-ascii?Q?XNkOzn0fwR2rToA2Gpz7SAPVOpj4iGjGErnmTdeH+lJ+dbEKjHAYboPAT9bh?=
 =?us-ascii?Q?pjTQHUUFMM1C8dapooeBqT1kyfv6gMlxDwJxX0RXFxWSRPUOyR1Rc27XSl4J?=
 =?us-ascii?Q?hcR6eoM3b7OkVOiGSYsLGCwa7359BaioV5Dw68nQ+/9eGYk8iFP/C4woTyRn?=
 =?us-ascii?Q?APvLsYSLvYUHRSc5+jEWf1VBcYv+Ymr+/PFB7JxACQnfro+NuX30IevTWfzZ?=
 =?us-ascii?Q?PVlHzLiXPVt4cKaxRQeCTfvMLciXIuwiFj3CQJ4wvF8dgl/BJXtyh+oWf5Dq?=
 =?us-ascii?Q?BNLm4EPIDll4olpMxU2zTnu/JZd4TpY8+MKukGmMnJa2LIYlrZCHX3JK/X6t?=
 =?us-ascii?Q?Bq+4dzNwaM+75fZS4w03c9qV3ixdc3P3FUa6CdhTSdCbBiXbM42nQDBG6v4p?=
 =?us-ascii?Q?6xtlb2j48wYhjaIFq0Fj07W+UbWJZWKiSdxhEWi8ReJrIHMpUc99aKUa+Mr7?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ef5ce1-f3de-4fbe-4e86-08de0d7efa20
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8552.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:13:34.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J794xwtX/MQFHmdlUyH78/GXoQbWWr48IDx6hfOQyWfQ1r4iwxpWBd9/LhgBd7Da/LSSeiydascFtX4s+5H+F2a14NwCKQq2F4MvoMqkys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB8304
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 18 Oct 2025 10:16:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18192

From: J=F6rg Sommer <joerg.sommer@navimatix.de>

Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
---
 .../doc/bitbake-user-manual/bitbake-user-manual-metadata.rst  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.r=
st b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 4dadf0bc7b..6a3488ed23 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -2228,12 +2228,12 @@ OpenEmbedded metadata-based example.
 These checksums are stored in :term:`STAMP`. You can
 examine the checksums using the following BitBake command::
=20
-   $ bitbake-dumpsigs
+   $ bitbake-dumpsig
=20
 This command returns the signature data in a readable
 format that allows you to examine the inputs used when the OpenEmbedded
 build system generates signatures. For example, using
-``bitbake-dumpsigs`` allows you to examine the ``do_compile`` task's
+``bitbake-dumpsig`` allows you to examine the ``do_compile`` task's
 "sigdata" for a C application (e.g. ``bash``). Running the command also
 reveals that the "CC" variable is part of the inputs that are hashed.
 Any changes to this variable would invalidate the stamp and cause the
--=20
2.51.0


