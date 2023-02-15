Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF1AC6379F
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web11.12143.1676457746724761121
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:42:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@criticaltechworks.com header.s=selector2 header.b=mPdxKeqi;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.241.85, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRETthjnFtZNp/wEP+8tG5HBAq7TO4wyjthWterLxTtUrU9bEqV8UVw3xYuUOW5Z7BzanVjcM32XeS3lBvFtNr3+lj4ZbvnXxhsWcK5PuDa7xP+xC7PMesAZw3tsxc59rdw3c+cKYrSiwHNaNWpxJi0qpumqAmTH2Dyedhck5q30nRIXK5ICx6Ogh1lY0yNNDTau7Ll39CaTXGk2ur5IvkQvcSOoaVBi+ylGv2z4NOYAAvY2lsWbfDFX8X8o9P8rzdpV+GF/F+uYqNE3fkrqOvRURVe91vnIFqv0B2/XV4WRZWcoXs4m+60jyZPXMufNrHfEu4k7bxyV82+seqUAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxpew63iJ/0xZd3wCfHJ3Mba1sns3bi6ncVOjLnNasU=;
 b=KgMf8yK13SendlSzZm6FRAfUPeMt3r4VgI9Mc+NKcFmXehNyYiiUHBr6moXpUEJTWfD2SNh4DcwbBFG/2blh99LmbP32+X/VVSpyVpTW7iMJxocaYBqHetF9TuOWOahV1lPpZMN3dC6UVe5cPNOT31/ZXjtbbeYyQMJbKV7fljBUxANjHw7tretEs0XTADQh6XyjwRADHZQDRsvU+yOroHiIMl2oTJdA11wnjpIxQe4wJcOgkCIu3SuATRV18hKEpjKyz56/DOQKG9x3HLBKv7ujTIja56MV9HebLq3RkDVddPLUJdudAcDc7WQfm3fkqMn8tgxixE4+cnxmLBBuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxpew63iJ/0xZd3wCfHJ3Mba1sns3bi6ncVOjLnNasU=;
 b=mPdxKeqiSqkcThqPyiVbsZUhP5iTAp5MAETHU9gOf1t/N/DLRxhGtMYJx7HGVshZ/fA+AAw61EgoY87RK2ojgplvu7bHoOdlu5U6iA73RxADZyj3sd/V4//Ta1NQukhfni3KtyITVBZlmDeuJKqn98PPJ+KAcBajoVk4oVT/JAvzqYelDqvaZIjrrdadkcGoEG+f02p7z/2Z3hnSKpbdKmlkO7da7zqcSbYaQ5EVIkozokjkOsCG/IMceKqReVucseH5uyfLdIehnEGZz4bYInKvYDyYuAlnX/KtDB3b84Jz6JQIfsR3l6cTKD3QBNkzaruzKM1qduPPM5AKLliUYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criticaltechworks.com;
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13b::14)
 by DU2P193MB2034.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 10:42:23 +0000
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8]) by PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 10:42:23 +0000
From: "Fabio Berton" <Fabio.Berton@criticaltechworks.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.46][PATCH 0/6] Backport multiconfig deferred fixes
Date: Wed, 15 Feb 2023 10:43:15 +0000
Message-ID: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DU2P193MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: b030bc5c-28c7-44f8-5e68-08db0f415239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VBDWhTZybts7P7dM0OteUM0AQ33p+HjysUxbIGIXSbaEtr3lRszNvreUFaSIPYCU1im+OvaB+9+yF+E6bEnUYaARneJLHO0Vrx2OZDGSAfliuACeeRGVM14BEk7Au7hOOQSB0xoVf4lbkv1cwGX74pOUyLoPv2e1vT7hphvZc8kyOX6U/gvwZnA/abXaCFiHCB22ZclNGLpBs+kU1txvKggFoVD8lVA96bRxUOgnfKKHHo96EWrt3g4Yatk6vLAfdifrYInXLWIPeno0Ft7Gf3uFAVWfbTV9pEC6kvIIkC+4kZGxracR9KhpGmdVf19YvvGecTmT9tH+KCcb/LbEMcu2kSJX9iSeX0/+o/yeQucAV6c0ORpK19M3wRDnkDMNiDeSrlF5C+Qu3tKUYNvCDFraFQHy1xg5JA6jMKjpJOXcEm0Arwfe8kX/PICgTllNVNDzIaxdfk5pmeDAd2XUQihPBAkLc7lkDCtpAhtoiz/8ehh40gARGoS7B4WlMDDjUj3UH93WQV/BACi2+PRAy5hwQ7y4HePyORvJBCHVGTdmuLqqrq45lXGeZ4FJmH/hIEVxQIRCk/R+8YMTluViyQKnaI3NKv/b12RHl/Fwo2R8HPJA+PeQG2tkzgBCSwAtsdS6gDdTl176+R8waTL2BOz71NSsFMftjuQpj0iDX3SpJbfs0sjKNEvWM6kyYQNDCRdVhmBZFzEaOTxvSyGVkg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(451199018)(83380400001)(478600001)(2616005)(52116002)(6486002)(6506007)(1076003)(6666004)(36756003)(6512007)(26005)(186003)(44832011)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(8936002)(4744005)(316002)(66476007)(6916009)(8676002)(66946007)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ISmPZJ5sfhN6Nm4UHH5z396MXSlQJw0bCee9aLkYEJiuJF8HFV2Go7PMkUM8?=
 =?us-ascii?Q?8ah43pTctalVYYhuITzV7FFCunEEDXJqbNSuM9Y50pZuPwDUAxnLv5TsRsss?=
 =?us-ascii?Q?SNZ3trvWDuxUl5sj4wy2Q92SF/crGljfBgxMMwIGxPxkOyCCBUpfwwHUhied?=
 =?us-ascii?Q?wZMlJhSGSpIGydpTHKO0LkvbmL1AbGQpWwjdfgifoPtpk9ayUsJn5c+79yR2?=
 =?us-ascii?Q?oi0nKArDyUMtzW1Rbn0+x802jvB5cpHzLCWfa4Ev3U66CznkGAD3fcZ3OPZY?=
 =?us-ascii?Q?SpzIKs/qy219Sg9ZQ/4uNVM0YBbBzpNF3V1py8VFyvsahNX5v3x2eAgUa1E4?=
 =?us-ascii?Q?k8PtOcBKAJmvcgw+DKLflgakS0VXWwy7lPvg5uU2bv/S72hLmj3rwzrRCXNA?=
 =?us-ascii?Q?a+mmPhcHuv/fp4lzf9SAGFeeunimbH6Nnja1fGUeFK3KbJtXH5ptrYAdN2A5?=
 =?us-ascii?Q?pWirfsqk822Lz0dSAJu3b3zE8b0Hk5bGIE73dnlpsTpGRny5IF8/1MtXZR/6?=
 =?us-ascii?Q?YnaeMI0TicdZ7/HvXFEDLqERsln3RcTZH1PfiPMgsUfoT1CXXFe3R0+a2cqI?=
 =?us-ascii?Q?vOQFDoMuNUEGFUTkbSNCmQF18YwwjzEuZj5C2LkZTqDVWMHwmw/sIjgyfsIE?=
 =?us-ascii?Q?HXKN58NnwVXAA/5732u3hP00ZP5uN5oYNqFK1t+Vev5s7+fnX01IpE+LRFMs?=
 =?us-ascii?Q?HlaHgOtJXG5rAYnoDDvilS6hO0KbuasPi/7Siv9iDGA3reI3jDc2nH2lQtcZ?=
 =?us-ascii?Q?Xk1FHdUxuMmxOyCJqCAr2DXOgTNqTI8lXfX3tW/mFHEsNvgk9urb29gjj6Ho?=
 =?us-ascii?Q?5pn5fImCkru9YayBEB0t625w4NnEw2Fu/bAjDijN3JWaiup4HCriGlYadtnE?=
 =?us-ascii?Q?z7Ccu2DKbuX8gwXg3dB1yF8UIoVRWPiSTB5E1tRDdF511CxOvoQKqFnEjx7t?=
 =?us-ascii?Q?kEGpNfGOZluFMp7ASdGH/JioZG24JIBgtFgpX010DqYksKwWgipfxHzb/pPA?=
 =?us-ascii?Q?/0LADuqawqWXGLO1m8n3J3ShYakHrnXt5zzRQcoVIzba83kO99p0mCkONX6t?=
 =?us-ascii?Q?Z0GGZTXJ+eGbkrBwnttX5WwQjErEG2DdOc4SasbjrQ3JqpZdwc9c7M+lXrmu?=
 =?us-ascii?Q?R3qU5mlFfWrR3n03fqbpIqVQsCWzu8WQ31hxvHbvwFAC4mS4mK4WmChruwDq?=
 =?us-ascii?Q?ZIP9hC7dytNMtcRjzhlhRem94BQAuh6MdTgEvfcqMj1Yrdlo3aE+BxL1/3T/?=
 =?us-ascii?Q?GhK9a/PxgW6fhx3zs60/VAYqkLmn+ZWHYHQS7Kxuj0umvcpjEjbaybkozypZ?=
 =?us-ascii?Q?Bnh1KgC6dhj68fhDXOhwMDto/l8csx7hJBjRcSwqTpvnjLArx/vLcCbCq/oC?=
 =?us-ascii?Q?cttUO+iyZW5h9h4MC8RbTBx+/xgjrPL5e/OJIq1Z1xqRb/bbBjTlUi3w5lZ+?=
 =?us-ascii?Q?7HArYhqvNo7VtUofEaEZaBJbNMMv14DJ3n/J1JiAYOo2Ft0xpmOTMm3Xo8+1?=
 =?us-ascii?Q?uMciwieVDa8C7PXTNK2ZvOx0xuU9zbGu0rt6r0Y1e7KGrMbwwAtHzIUUwsQn?=
 =?us-ascii?Q?69fqL9WOedkfLGs05AkN6zgKDtN+au2hq4wsaQ0h2KcyuZQvfjX9rTbtRnxg?=
 =?us-ascii?Q?kErvswxuU6oO51joAHF9aY0=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b030bc5c-28c7-44f8-5e68-08db0f415239
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:42:23.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+UgdgUTjqW/8Ye13rdWCgGa10sjj7+H6pzyXCVGSxmlkSL7xMQH04OiKDHHfmNDuE34JW+jprikfFuZRSHo3G7NhQPfkv/FvPkwBazRqeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2034
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14426

This series is a backport to improve multiconfig builds in 1.46 branch. Wit=
hout
these patches, some tasks run more than once for the native recipe, for exa=
mple,
the do_patch task tries to apply the same patch to each machine.  With thes=
e
patches I can't see any duplicate tasks, and it looks like the task was pro=
perly
deferred by bitbake.

Richard Purdie (6):
  runqueue: Fix multiconfig deferred task sstate validity caching issue
  runqueue: Handle deferred task rehashing in multiconfig builds
  runqueue: Improve multiconfig deferred task issues
  runqueue: Avoid deadlock avoidance task graph corruption
  runqueue: Fix issues with multiconfig deferred task deadlock messages
  runqueue: Ensure deferred tasks are sorted by multiconfig

 lib/bb/runqueue.py | 88 +++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 33 deletions(-)

--=20
2.25.1


