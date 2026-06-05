Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626BACD6E74
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 04:58:39 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1519.1780635511989931224
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 21:58:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=qI28bVIU;
 spf=pass (domain: est.tech, ip: 52.101.66.29, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2FSSqOcmltIHotGZJjqx4dpLE1rj6ICmcyZCQsyS/BK81WWKGwXi2vMjHvpqjLBWjlJp/QKSHkIg9/rfJ30etoURbmXcV6qZ+vT1/58jl4OpWVUoUtp3EsS4529mwg8xpHngdERwSrfWMcqKnst7II7MXadduWxH/sMWKDFHZ8Bv8UIt8UZDBRzsQTmhu8Q53blefZrU8RItYp184xdF7WMusj313owJvd+PweuwA5xmkM7yez+3teTjkZahuFyndsExjWrYbs9E1UazcoNte8yZUZMIhZ9KD9o1ZcXYp8ivHVAe3gA0ok4K64FhMSGQeFspaNSUX7MUcCUVK24DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIh5+t1wXq2FqC8H3uZv9R3flhfTtwOBEcPDDiiTzOQ=;
 b=inaBK1TVPmLyiuHbUOkl/58rg/lvdOaJLM3YtapGvep449aRD+2iJ8V4jEwTYtXQKCkh2zJXB3w7L049yG800WT3FdAI8CLnSXfjWVWz1dpJS01JAOHTAhgL7n3AblQOGeJ/8KG/dtFPbSI332WGAZ2iGOmrsaD2x5+IUZNlfgz8Zv63ZzQv42d7AZC+o7ahbwK+5pGWljZ2V7/EmXHSpnYKVvqf9vkuvMMbXqBZGgQvaxOBSqS0TlxwlvYvXn02BCtxMoo+P+AF5S07iyQ3/A0KEfTf84Bp4r1jsNmz1PANwcadIiz4vP2UB0Kdnm4h/8ctdjCatVYCpbvpd1bKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIh5+t1wXq2FqC8H3uZv9R3flhfTtwOBEcPDDiiTzOQ=;
 b=qI28bVIUn4PP366iGg39sBB3cEhuJ5l/bsrJ3F+dIHkMZYAqw+o8u+Bm145kQ3cmbCPd5z8xzdqYiNsb6oxOjRlRiunzdAzG2SXyElAmwlJ7y6oyjZVwKDqB55DIKMw3loltHmPpSmsecwg15pXc4kGF5tsG2OHpN3U6KJ/rNW6FyHrPdoEZ+U54SDcziEEDYmDTIpeyYjb6VPN/zKIRDcBPXJS4NfBVRIkKLSHe7yRF13ZbLinMSeoQf/49IrgEJGlHvnbILpjKFEvqhxf0ZXVKLgIHvlnQpjclIF9xVEDwNaevDVRmXo49BCBkRRPtgrLOYVJ8Haet0vPzPieUiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 AM0P189MB0785.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:19f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 04:58:27 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 04:58:27 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 0/2] hashserv: tighten unihash handling
Date: Fri,  5 Jun 2026 06:58:24 +0200
Message-ID: <20260605045826.2052909-1-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZP191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::18) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|AM0P189MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: 958b445d-8cc5-4988-bd19-08dec2bf14c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	HviP2T6/fAMEd0aG/37ukq9tI61bubgzXQogKQs/Ud3EaVh5WeUZY7wJX126pv7QeNzL7awH4/PJUlv1KM+zOsEZBKFKT1IzirZ8Rw/J2W/inGcy1AlPp8SJ02P5fnHfERIfEyGsNfzqmwYByr4xU1g9lHJJ09sjqtYv42QRXZLvSPr29d7A2XyLHxtIrtXBw0QxGvrdQKsmiZUlWTCgeTUeAmq9+Mw91crb8bNtBUFF3TLaP0LZcoTlXyFZ7lpPvCkmXbAYeAUMKvYZ0K6Digstrgy0G53Oft1ialWVegcIs/P1m64ityTSx0pdwVGJFdA1ONHboGyRLKMv+N8mHoTpjEkcynlajdkOtTGCiSE2hCQJ+cVjVGz3FrSoTbejaAh/EJM241y1XyRcRiY4uGieKgwSdGWpc4mwTfor77pL3Dsvnio6pwxpwobV/f8Qk+QHUNYOizy9vJmd5GzJlqpGXcoU9l6LzPdPK6A7HfIOGhs8AH7zEN2WBEHzmlKetV7fL5314V4sqcdR2Vu1lMUSuf/RRgWa4KskOCxbVhFpzu/75MMXtE/AVyb2/KCQPi+SuSPgXTvmm7cB7aExM5krb3H30XJnHRyqFpmRE3k6Y7BE5WCSq4KJeZL++MM8GG4f+EZ/2NK+SjRiRQMoJF0zMjkCPXQrsuehmKFbJsKgc++Ip+j1m1nTjuKZVKE3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GbUb3GG0Y7+qFw5zkxT5r4CYSDs6bynYRjB+v7DrASXsaBDc3VqGLjmIx7C4?=
 =?us-ascii?Q?omzHb+WEekuOFTm4ZYvev+252oluPiR07JvctSfMAvKsMtae7Tsnwu8uHOpC?=
 =?us-ascii?Q?QI07hc2o5A7wM0FCp5xwghQsPah6PxyCphd5jkYVar3paxDPrerminBzIVUg?=
 =?us-ascii?Q?cnirkUxw8jFmAq9/yxy+HImp3ISenrByl2MYETSfU2zXzX9n13sGgxQbiJCO?=
 =?us-ascii?Q?68NPisXnxczXZTT9iV4uMnqCvg3gsX8+0XHZXN8xFF9O7HzeAuJt0PxVimdZ?=
 =?us-ascii?Q?2hItsmjg4RQ2rdq4DytSQB2mQdkLUPP3eOAJ8Nuqwy3tQNVCfK7CdS9Hkj/9?=
 =?us-ascii?Q?ICEXGHaW07M4+iRPjwgBtZS1Wbhzw7JGwalZmZ26krZOqzfO9sBbZ0K1hmrw?=
 =?us-ascii?Q?AlgBNVUUk95W2s89WzWg7wCjKCHl+YbT/nWh1tMyZm0yYngmhd4iAG67WLQW?=
 =?us-ascii?Q?nHvyBkgVi+0OSkIylbROGSDma5HLWOgq3NJbsUHue6SInZ209r+g+XT/80v4?=
 =?us-ascii?Q?5baZyRHKQpvgcncyl3oRddcRBwELd2Xd5fc0zOQpnH933vN+P+gC3U8qqs9w?=
 =?us-ascii?Q?Bn4vxeiZBddT+hpAGMFsW3hbDuJ3ItkYf2zK3XGuy9dDen14DLGOGAowq/ff?=
 =?us-ascii?Q?kdKXHPUab9378oRhIoNGuflklZklaBkdCRjwxkfhxrI4Wv0W/z7BBvl85uw5?=
 =?us-ascii?Q?BuqjB/HJP+4tqzmRwlkMttLulJuVYBBm5vepaK8gnJcUFmQ5j2TbIVuIfpL3?=
 =?us-ascii?Q?TPoaa4vVsl2vc3wnn/hVOr//Or2o/0UWNea3KmLBoi5scAntpC7mjtA0Gaa3?=
 =?us-ascii?Q?0p7o53XUlnQvZXpLz6fgAlPTSP1YfquHFkCn2vWGjK93HQS/4rlr894DcKIj?=
 =?us-ascii?Q?3Fs+rnnoc61fcxJtpR7bTxDcfo7QwKmPt+zAkX3YALZ/iXrPbGRJc4D9F34R?=
 =?us-ascii?Q?iAfbHs9LSkjePriSx3yqKc9BDnmJXy1M5P70ruxGiuLbu/VY4LQv6lKvneui?=
 =?us-ascii?Q?fKCK1wwFTAwyyG3Aq/+eCNixeXDmigsBjLzmhkX+mTdOqko3MXnTBjHdy92F?=
 =?us-ascii?Q?6Mn9FHFCVezHY+dC8z3WK5m4LuKJmAXjULjd4ViSayMZfP5vFwWhNrgdV+fl?=
 =?us-ascii?Q?Y/y63WjfyUb7WRO36jAaIqqRVI1QdlNljZ8h1JpnsWURpBmyZlKnTxsowGyL?=
 =?us-ascii?Q?7F/Cx59MrwT7yxewONi9UqyH4IkcQUSA4ZFJzhYXqx78PoAOK9JIIuCgAAjX?=
 =?us-ascii?Q?YdM/aXKenalBLB7MFVAeKVRF+RXsuwA8Ys/ZuzL2zTQDlJhalE7PXJQ1t+Ej?=
 =?us-ascii?Q?dS+wMHeqY4fMNZfV95PUY2q6g9oSYQz9CHtShW0+uqLH5+t3nUpoM8i3s9WE?=
 =?us-ascii?Q?zpVWY3LQZDrQvwkhiD2lf63OmX5kv3HmpCc6EBNAQE6h2yBd3bbT1KRZpOC5?=
 =?us-ascii?Q?r3+vVOWokMP8n+o4r4Jtj0MMap6ZitBM7OdJ0zKPzlFGwaE+mmgxNxQgu6gq?=
 =?us-ascii?Q?qxBTZ0kQNxwRFhRfK/ASUeW2Ou/9dZn9ycSVd5dIe/SCiPZlQEPIi8VD/F1X?=
 =?us-ascii?Q?nd1KDMAy8Xql7qOUDUOtH3crQvlTXM86tflV8hl6qMZIw9Qbzq8PfSNE3ZBP?=
 =?us-ascii?Q?RcqaXd7XHyfj80mEUdEmD5qZzjBXYOC9Q6HPtpE5HRb3iedAxalV7h4rNmQk?=
 =?us-ascii?Q?vEIvc0lsbtHjUpl3qlAtJfVfppIKLfRRMvVZuFlw65L5DC4cRckP20tmTXEs?=
 =?us-ascii?Q?YrcdqTjrxw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 958b445d-8cc5-4988-bd19-08dec2bf14c8
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:58:27.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaWSyvh6vjMBJQw4ZWQUvGdXSl8Lmb3eB0NQqhIW+wu7a8dvf7WFmXp1pr9fc0hpayVeMZpdTPQKTa7SpXL7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0785
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 04:58:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19612

This series tightens unihash handling so hashserv accepts and stores only
valid lowercase 64-character hexadecimal unihash values, and BitBake treats
BB_UNIHASH as literal hash data when reading it from the datastore.

The first patch updates existing hashserv test fixtures to use valid
64-character unihash-shaped values.

The second patch adds unihash validation and focused coverage for hashserv
report paths and BitBake siggen handling. Invalid unihashes reported to
hashserv, or returned by hashserv to BitBake, are rejected before use.

Validation:
  - py_compile on touched Python files
  - focused hashserv/siggen tests
  - broader hashserv and siggen regression tests

Anders Heimer (2):
  hashserv/tests: use valid 64-character unihashes
  hashserv: validate unihash values

 lib/bb/siggen.py         |   9 +-
 lib/bb/tests/siggen.py   |  47 ++++++++++
 lib/hashserv/__init__.py |   7 ++
 lib/hashserv/server.py   |  27 +++++-
 lib/hashserv/tests.py    | 194 ++++++++++++++++++++++++++++-----------
 5 files changed, 224 insertions(+), 60 deletions(-)

--=20
2.34.1


