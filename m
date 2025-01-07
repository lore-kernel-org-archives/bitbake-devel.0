Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29163C3DA4A
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 15:15:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.98])
 by mx.groups.io with SMTP id smtpd.web11.22924.1736262932271212229
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 07:15:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=hL8U29YX;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.98, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1PmsZOhxKOohxMI0xJyyY8AtNK563QZzpWO7vc4XRX0Bnh5OXYrt1fV9+PQ7BG8TuOnc00jL4Zz1AhT/SMeOfJeUk6sF4cIFSUSavr/qYAG/XdgAz46G0m3bbDBl7MZdFA+FOcDJcGnLwu7BVjdBgV0NNvLMXTpkTWxQo5OuS5m03jqJHq1sqQaZVmp5qflUJtsTVB2fOAQLyIu8X+c+77gzUZw+2e97ryJP3XXeKGcWw6MG+J5xfy5ElcPRjPP03ZGyeR6rmw5pHlmn/QXesl5LgExMJBPxg63fj70COBlj3RMWwfMAHiqTjUpEP9BIiYtEn/kRT79yly6QaOfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jseacOmijMlKhd88XTUeTIq+GgZ0UY6xK9La967Juqg=;
 b=MyLDuu3v9uhMOdMIvinxXk7FE4+IlRzPf2guY2Cgwjcyjmda3Y1Q7whgObzEOMbxNLBTiQNAo9cZp0VY1P0/X0iedtJbagU4Gl9bT+unmwuN6SC0AVW8qVpdJjzY2nsYu1WhWq63TCt8bCr1R0zUbQn3FSxCrwZVE7mDNc3sMGSMM+7gk3KBX24+aIvbCkD2QsOoYzvsl9Z8OB8d7R8ov1pq09VY31Pcrsm+rA8XUD3vj+xpvHYgQfQcqKZJanZO2Mhz6bmEI5Z1E9jUEOVOX1pM4WIko7ebHcJxLxgfbzRxYULrPuDkYjuGQMjhjAAytscVsgnE73zYoDUka6BXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jseacOmijMlKhd88XTUeTIq+GgZ0UY6xK9La967Juqg=;
 b=hL8U29YXZKKNJsdgg2hSTx1i4qdExqlg58huLIZdd6b2rE46LMFPay6DxLahxbbfIIJIuNMOCOg3aXK8R9FC/jczf2UkeHhJgqzrHpUNMQhg/ndg17o9yq+V3zOsBMU7hfJyggxr+fUdNiE+c3S5bNlSDPr+a1GZEGxYI3Xi3YNRoCVX+x047noVJ1eQTD+LKE3ySiZ1mjKjArBES9HpX7RykXCTThmtboyPGlQWDGStfT4ovCEBDdqDeHv1tEmd086nW851N3MFBIngrp4te7WzNzsUfrsDjLaG4H6dgoSdwjLgv+WG5jnmvHNGj1ndd6XCA2g79PEZ7EhKnKZaHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by VI0PR08MB10538.eurprd08.prod.outlook.com (2603:10a6:800:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:15:23 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 15:15:23 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 0/2] Add Go mod h1 checksum support
Date: Tue,  7 Jan 2025 16:15:12 +0100
Message-ID: <20250107151514.8115-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|VI0PR08MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bc7323-fa63-4c8e-91a5-08dd2f2e1b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wdIEAtl0Dn53PRin6G3qUFSi+6wnsZqNlxrp3indmp+J/XdIsMGrOz/rEJ9J?=
 =?us-ascii?Q?h0A4jvOQU/0fI4UWzJ88ie18Yk+MoMHxszoojC1ZZgYcfdViTF66XCIxSyWE?=
 =?us-ascii?Q?Cm2RF5ftq2kpfetvW/2bqVY9MWH+o9KZtFkXbD48cchQYBp+UJN3nR77SO8w?=
 =?us-ascii?Q?BJCDU41ww38MTg0y0BICZir0Kh4nfbqQwmp6u47i/2IUtWhcB8heGie/O6t+?=
 =?us-ascii?Q?F+QV6D6rICn27Y6dcLrd2qiWTTk3Shv4JWv2S+CvWtSG2DmZZqdvkixLXM0G?=
 =?us-ascii?Q?l3iBvRoCxr70FcoDpGl6NWOZg1em6f9+oGhfrxndsJn5HwleSXE3OBg1WEiq?=
 =?us-ascii?Q?G4EwSC9eBP2txYPBkJHHFHp/2v03hxqN592vfXt2CnQs1q0PDIrmumrATMVh?=
 =?us-ascii?Q?xHFV3bfOw1B+j8GBoGNjaAMLr7qdIbQX8Zlfvi1uAhvr/s65pVL7V0w0JzVG?=
 =?us-ascii?Q?o8U13J+vvyYfrPilJc6neud8vm83MeqxeAfoJzgdKYRfSx6gJn/vuAUxDONj?=
 =?us-ascii?Q?vzeg6TPpRvzhltLQUQQMw0uDlCg4WMFYx/a6M+7Y3cHJs20PJBx35jsvYx3u?=
 =?us-ascii?Q?GvNJIAJNd2blzJuTlSS6ix1mVRy8QQlYiQ0V7v6MUKRbmMVQ/r3jTltYPtLa?=
 =?us-ascii?Q?cF8pZx6filQVw1G0c+uB04uzwRMet8DNyKYm9Qu9ubdN2NCgT4Soho3bM64N?=
 =?us-ascii?Q?dFHtf5SjT54h5pZZjN8zt494X3SCCEvf/av7wBJQlxWr58llj5OeRAVBTKUO?=
 =?us-ascii?Q?Ex26xa4DWoi8f+JsU0QBre2KMCjr4P2B/v+oBDs3R6+2nes2jus2rJSHHe4A?=
 =?us-ascii?Q?L5kFQR4bcEOSE0cZZxwypt6ijIJA5dHweY/TWQhI0rJrYwlxgYCLee8jzX8w?=
 =?us-ascii?Q?klYMGXRraBag98i6KfNjNsEBcvhOhLiA8UjYa956myPJRQPGOEDKzdL0Gyu0?=
 =?us-ascii?Q?KBuR0QrKcrpBUroHFLVB9LPbufOJ//hjmz28jlQ4BX4dzd2gLUbCian259yB?=
 =?us-ascii?Q?/x/GUhvKZrJrWO27B6aMhpg5QJ/2ym/ng75DKhr3cixHzJyvZmvJR2VChtjz?=
 =?us-ascii?Q?flFGC3prIzr7KfGwFt4LIgvKncmLeey4cdNMpJ8fk0wnihJrIcq+8A/uWj1E?=
 =?us-ascii?Q?T6PjsKaqABVTaQvp2DswPzA9dZjBHCOdUckLYG3r6cwiSOc65rD1I5FBTTDQ?=
 =?us-ascii?Q?uTrVdytFrEiB6lt3KOyU+JaSjy5pysbqP0CX1tqK0heJtB7Ec/RlUuVd3pMZ?=
 =?us-ascii?Q?6jnJQIGRzxZcAdDwBWXpwcNqTFfEJenVQkXHRsgYsusA05YDrK3qbvbDbJn5?=
 =?us-ascii?Q?jDja4dNfYqk73fk3GLsZhdcbqOxziBylzN6T8XJDSZEJOYymbdA1NoGwdItU?=
 =?us-ascii?Q?G+WH0u6lXL9zI4+CgGYjvWC7Ehs5HVWSUEx8kYuqK3S5N7bKeU+xD4Go39AA?=
 =?us-ascii?Q?oRwVBvOlkLLiI5nYyl9jSWwWJXLotGb6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vJxA0Ena289MKal1PbeckAKBXwbA/motyE3cfKmV6STQ4xA1NKRJU25Nvx4i?=
 =?us-ascii?Q?ofYDEg2ezjzKuag2ZnJ1NUE9o7FepkihCiyvX8zxjkvEPvz6P3b84ii97EVC?=
 =?us-ascii?Q?2wgjBw6QVcx50cYFXIWrVqJ5L1I1QwB/PgXJ5QZHMv0giIaXuVrLMEKOojOD?=
 =?us-ascii?Q?02yHnAh20lktek+Y8yx+H/+QtKZljPuboLS/1gx/LxGyR3vheLuB1TlJwPZO?=
 =?us-ascii?Q?Wyz+vc75TNoX41anjOJrvyHUmoV3B5eMom6LtpbabmQO/K07ZiakuWXCzWKp?=
 =?us-ascii?Q?09CnhkFkOCdQCkhuRFt+pfE8Pn+9vgIWLD0o2UmRZEIvP36F0EHEPZ1jn291?=
 =?us-ascii?Q?8Q0+K91QV5vw8b+buSyX9vGuANXTVBtzvEC4HaOpAIJVUQUgKunByMc96qHf?=
 =?us-ascii?Q?a+2YHFwm/3u5hnwT/F3j8rMiSzT5g/ZGA6lzM5+lv7cokkHIz4f0gQKB4bVq?=
 =?us-ascii?Q?nj3eJhm6j5kkPMhHm8KE4FVrm3s5CKL0vjf2jNKKlm2M5zA1EnkutUiDUQ27?=
 =?us-ascii?Q?8LaAD38EUuWi1UwX/36COxT427LP80Sx/OSxAE9kkpyxNw8kTAm9/ghNV9i5?=
 =?us-ascii?Q?6TaRc/f8YMxYqiRxq+dJSEuNAVAHefkkhl9FaKBJCsYz3SRDQydFoFJnpqIn?=
 =?us-ascii?Q?jHxt7GaRMAuInUW4pUMxyGEiEGwYNZDxDtJWzw2f8yBq6lvP/ivQ0AWChnIT?=
 =?us-ascii?Q?Bk5qozi6u7SJeA1gD75ypd9B6RLKs0lFskLZDIqxnTndq+FQ12Vcob9kuLO8?=
 =?us-ascii?Q?cmC+MrOVy8B1OusqajYVNJKgOPU/YqJpApyC97NJlDERXqO+YjosnPRG577g?=
 =?us-ascii?Q?YvX02reCMFoMG3AF5LgX7kGiB9HT8b2gKaxJfR0dhM7lQTetUfPQt/JjUo4t?=
 =?us-ascii?Q?q4eJxy9xlSJNoVPXnMVAHP+LjFtIISDSw5RHhyrW+t5pyKGH15e/dBp9xtTx?=
 =?us-ascii?Q?qPzXJpG6jhb4vIZEeAIFr7T+5QZz8e7CiIHmjj5tuOrfITqmnUsxdmCOPazb?=
 =?us-ascii?Q?RcKKi7XjmJ1xClSBy3tBlsdqV6aVWdiatQu4Ha+2IOgrji6lNmmO6iU+zfTq?=
 =?us-ascii?Q?ixyZuPNFCWHHNVYlWNAAfzRBtELVahyf7PYnXXBjX7EyAda2x770hrECmwFX?=
 =?us-ascii?Q?rhJndo7wA7SPwdJgwtrHhQPEA/4miUA0Avk/nxbQDKd04GKUp4fy4jwvJCDJ?=
 =?us-ascii?Q?1wLNh330W7eMOJwIf6corH37ITf6S++shMdFfchZvPjoOCVAzwe96gTEzlZj?=
 =?us-ascii?Q?nlfKnchebTWT/Y9RVdVzLWcfTPBvXk1I6OniHueZQrf5ErA9C+TSpRNidles?=
 =?us-ascii?Q?dH8/wmzUije+W8pAe6esVvvcWgW7S+p2UG7yEGAnU/m3dBwGn0Labcox2ZGZ?=
 =?us-ascii?Q?t78jNLg37IYh2xDYfDdon2ZvyNs/5/Qi8GRi8iLuMMHw2YKp2VBcByLVOQM0?=
 =?us-ascii?Q?jxXGZUFfjwkZJ2UtF5g9HKvmZar/PDMCv/SrCu/vj81UyIabVgaRrRCf47KS?=
 =?us-ascii?Q?Db+PVGKBY8oJ8yEogG5WrqmE6agLhyYQZ7P0tCQMM1P9cmuqbzuiNpNFTfgc?=
 =?us-ascii?Q?lHjZXI3AyQNTx3w6yJK3gfgCG3Hw8LyAyhg6hZ7hr+uZW+kzUvHAvncahGYX?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bc7323-fa63-4c8e-91a5-08dd2f2e1b92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:15:23.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRUqCzjGPcN37ZaAMFQUDS54xxXvp/tptnZ4gezqoUMWvZfuRmzLlQ97Zha2tbun3rzJJiWZWFoJUkyIK9gj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10538
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 15:15:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16978

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add support for the Go mod h1 hash. The hash is based on the Go dirhash
package. The package defines hashes over directory trees and is uses for
Go mod files and zip archives.


Stefan Herbrechtsmeier (2):
  utils: add Go mod h1 checksum support
  tests: utils: add test for Go mod h1 checksum

 lib/bb/fetch2/__init__.py |  2 +-
 lib/bb/tests/utils.py     |  8 ++++++++
 lib/bb/utils.py           | 25 +++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

--=20
2.39.5


