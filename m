Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B06AC54E90
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 09:12:17 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.42])
 by mx.groups.io with SMTP id smtpd.web11.6918.1747818728967801793
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 May 2025 02:12:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FU881r51;
 spf=pass (domain: siemens.com, ip: 40.107.104.42, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylmv5Vr19fXLXjdVbuISfb6Z2JcjWxu3S0OeYZWMHQ44lcHBAzxNxoevoeJhUOeh9UAN+QoQ3Cv5UHMo4ZfwpVh1grV7S9NpWpPyNh01ap3D+pvYjn0ld6cwGkDodNbGnAUf7GexyHwmp9fnR5RZv94bgDbTd6uForBjXTnIXJHTh7tp1XUAVrB6okjTWio3ySXMGgcDbYq4eug43iWyC1KrBz7pS38U8Y5jB+OXX177N4SKBJ5v+57Mf704Hb2a5KckICiQXjnNtOplkrTaiVtPrRxBeT12qHKT1ya9cFf8tc0KUZxfGpB4AgAKcNgp8MAlrI2A14zP7DX4WRo5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/UxF2zdaeRe6+QKEw68CksBXmUipXLRXfIHkDa02p8=;
 b=vJS3OAhltc3SvsYW6CM+XU0x97/6mBPLtlFmFuyCtYwtLqiO29MywyNQAFE1NnEgr+pXpjGwDdiY6y3nw5Tr0E4nx2s4CGtUKC0B4deVWmaiWo4sKjgFN7vLdYcZBA68LoeKrKSL96Wo6jGaLBG2+an3cn76VUouY4jcdyA9lhTxpmcY8Q7Ym0oBcG2oPJ75r1xyw/HrXjvNxzQcEbt3ZOEkv5/DFHK+lEoXsgXlatx8ft8bOPfFWlOEHeWTvZiQbCgKsikrnlxrppiFRjIxoVZALOmxGRfg26ImJ4O2I/Yih6vAGnXr6GgH8HixVXxikjG5YYCxZzxQotBzRK3qww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/UxF2zdaeRe6+QKEw68CksBXmUipXLRXfIHkDa02p8=;
 b=FU881r51lYKJTj4CukqRq0IssrRoUYelbrlRpmp6o36BZ3lLrD0e2ZWV8dCh+BdAEtumcCVdxjMiYmLCwSePzYZRKDe/xOI5yGAg8TjQSHILyuoW4BFCk74L6PM6bRQieZBpnZZTlaqDN3HT8vrhguQD7GxT8StsvaXk8i8uxEgE0f9toYBj9dlw5TuAid+2sFa8k2bZKY3TL9wEyEF1K1PjnNMrVQFMawpkGSo6UohpWKLAKih/nqte505arhAV/ym+XjVsoRlmYLlUyRdHfRnjCs+NV76tzlFfj7EB3PnNmJBMYmQ8j02A7nLMXGzQFF3C0GZBOXQ7AoyX2CxU7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GVXPR10MB8615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 09:12:04 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 09:12:04 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	richard.purdie@linuxfoundation.org,
	liezhi.yang@windriver.com,
	niqingliang2003@gmail.com,
	alex.kanavin@gmail.com,
	quentin.schulz@cherry.de,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH 0/1] fetch2: Ensure a valid symlink in `PREMIRRORS` case when using shallow cloning
Date: Wed, 21 May 2025 11:11:52 +0200
Message-ID: <20250521091153.2445853-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GVXPR10MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0fa02b-9683-4aec-4617-08dd98478d69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wVhapwJoLaEUn7fke6hw5pYQocmQwwMwARpc14nDZECX0S7o/cbmMRTGZ6fW?=
 =?us-ascii?Q?H6grq9/zH05avgaOrTvmd5x1hvNzFFBTRc2QvnQDUWC8/bshQVHZEks3GFu8?=
 =?us-ascii?Q?NP3uIqU+Dou/oYIvKkpcT7fAAwrMrqLQf/5Pp83C6C3zSf6rM7tnn77fw4ba?=
 =?us-ascii?Q?Kkp/oQk/H3VqFPvjFL9QVcwJEmTiJrSVxYjxxcX9ObaIbObDx8taPYIdWlfK?=
 =?us-ascii?Q?kIDN2mEYyXH0G90vF20RW+lVaTt9s2po6l6T+QcZRiZmBYG91NeJ8t2jTtVy?=
 =?us-ascii?Q?6i/z9ObJlv9N5vOy6Fisq7W4V9iQkj/pGoGdZMeP3aKXPJgwSBML9y2Ee0a1?=
 =?us-ascii?Q?v5D+4KDPd9FouOoq9ODnjLUvXPFeipKkWnCg1Dj0DQvhxU94MBO61WOFcFEo?=
 =?us-ascii?Q?GpNWkldF8LvfrbN9bt/gOtiCYn38FkvVc+5r3gIBzFndNc6PuUuUPokaYr+s?=
 =?us-ascii?Q?/1z0dg4v0oJ7IfLh6ttBC6xNcm0I7Q/pmEFCOqIzUeAth6sv2m9khRjWmtNG?=
 =?us-ascii?Q?+FjrF+IF8RkM3FgENfVA6M+UNEC0hel+oYamK0oJyMwzGDczUplJh0fgTott?=
 =?us-ascii?Q?fQJ458MM8GYgMeDAvFrRukPC4R4e8P5wjbbVwUv7LJlzrk4S3ZqQXuJEuHYE?=
 =?us-ascii?Q?NejYMkHPQ0ARQ8X6Yv2YXumtoYc7tvr+eT+QZvGpIbuFuWZtUf6bhIFgr8AH?=
 =?us-ascii?Q?Y1LPwTJcaZklRw7/w7FjpaLCfk7RM7mN4uK9djoqBZvwejUG+d33E7hvHJ4D?=
 =?us-ascii?Q?gsV0LOD4QzK6c5YAyfjvJD+gU60xucZZsgm5q1nD9En32f0f18D86b2CDNwy?=
 =?us-ascii?Q?1lfpAokjt6LKVMxEpZoFlDh0tLiPhR4CO1akTusuBtYXg5pMrjYjoRcDmR+9?=
 =?us-ascii?Q?kM8W5PJbtyHfXH4NJXKrALT096erWdJlz1zgjYfSOXoMdh2wYpjqt4fwxGxM?=
 =?us-ascii?Q?0SmyYGh3n39cNpDUA1HTw2P93OawMyToyGXsPZlM36S2q0hboqZy/HNumKwQ?=
 =?us-ascii?Q?68bBm55kiDp1UgxfLRAubhcMiQ5X9dqBawt535JIjLdC3DZhLOkMpZ+M9hpn?=
 =?us-ascii?Q?04g66htYY4eX8FiJ7GS1Tyq1xgadGjPDWhXBR5r0E69pMN6UNpm3kCj52ak8?=
 =?us-ascii?Q?Suy7MttUMVF4FrbJrsuU8B+Bh56zAZ4ABus6XG9Ru6bGzK2oUZ9pWJaUIRco?=
 =?us-ascii?Q?24znPW1eT1YdhPWtPVxEvxoNhwCRLY7yEMII08rjYJD7a80Rqmx2Q9gTcmD9?=
 =?us-ascii?Q?vUmCZBTYPcEyPcmqm/05b5EAhISEBTTZwpbbMXWhURTcsuSKw/tA+w9XJ3J1?=
 =?us-ascii?Q?f4OznGtQYJd0xb7G9BAhib7yraa8IFhh1IbktVQMHEadqTfLdqx4MqhJvAKo?=
 =?us-ascii?Q?rJAUwD8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ycj9k2RB137jJgf39FK3suUR0tIp41uNei/kxVXCSvyfu1alHqaKT5XEsqnx?=
 =?us-ascii?Q?jBYHw7/qbvbmFEIhOI+bATQ6f/ycdXhabDTfmfsuvVdBUEU1pONkf+PAv9mY?=
 =?us-ascii?Q?nlxbsMO+/KyueNurWvoJHB/BLlR6wQ+8whSnB/XQ1Av7TCfN6O93s3FyAqBC?=
 =?us-ascii?Q?WMJOr5IGubhHB6ugAw4CuI7o/AupCbk99uoGlmTX2UcZzk8Ta8UnwRjm0t0+?=
 =?us-ascii?Q?29m0QcXUilFnSX2GHbjfGHEPsCKu7eqH9e0FsRrKriCm/lDWgNx4SjapCkNA?=
 =?us-ascii?Q?iBn8l87/LNBqvu7S+cLvfLJOAIFcXfpa0W5Vo9KtyaYzzKjk2ogQ0dzpxzwD?=
 =?us-ascii?Q?HGWmDujqQKK4F9hUq4d0U794015sSPy/XDJaLWAeaLVLkJ+4Aisn9T3rFc3/?=
 =?us-ascii?Q?Xf1OebJ6bUa2lsSPQaTwPkEg1p/jD50l0R3Xbd/WDbN5YRlsQxCZZjDDGUZ4?=
 =?us-ascii?Q?eZbJJXVkfqAaIdyKK+DeypPhQE923wyKzMZAxIZQUTmDnS4XLFl5NlAXAmDi?=
 =?us-ascii?Q?J+3AB9ln6QQlrEgerMBqJZgE2VvogKOlVs+8n5cmpwrrsrOkxCwfp/Vw5A4S?=
 =?us-ascii?Q?F20nhoyaPwhfbHelvgWKLq01IuBwEG2/lcvjN+T8j/ye0ixzPyo5ACVF4nOL?=
 =?us-ascii?Q?Z2yfLNJHkxNyfM4iqCZf92Hyu933antvEEFHrauqEDXhc25yLDl6tRYb4Fs1?=
 =?us-ascii?Q?EHB2EeWiA3KFQTTqIMfw6LR94Qaeaj3khnhr+b9mnRrAyB+P6AM4r2ADFC6J?=
 =?us-ascii?Q?6V0opu66qjOKMQ6tkZlngMUT2DOuo3iczDy0D+4qEeQslW5mZMzxdWHDxgNO?=
 =?us-ascii?Q?lG44EwZWsdGSaXzfHFO9Yvs/tH4EM1HCzbv/f8yx/AokubZnc4T1vAWKOkvV?=
 =?us-ascii?Q?y3CH7GQK4dXhTnLmge1maEW2882jIAlkY+WaA0hwPvPl/UYVa1E2XbCyg6c6?=
 =?us-ascii?Q?HhioyJwXOrs4VwgCb/W0TMlHXaCBRPElOHQhxRC/DzBzu24aVPbrEB7jFCoR?=
 =?us-ascii?Q?aNvn+60ow1AXyN2P78Al/kjDe2wwNydyoLqNgi9gCWQ5bWojtOEBm2DOAyIp?=
 =?us-ascii?Q?om8tcLZt2IFeSAzwa1n8u7jxXbxlyWo05WX2m0mvRDHYxBME8HWl3B9/v6pK?=
 =?us-ascii?Q?oX9oqdnsJgp9U/SegpIKjWa2ZyJ7C4KAetaNzdv1H7ISSqHqh0f/kcVvqb+1?=
 =?us-ascii?Q?vbi5DmDTaV1gGAiHFksrg3YbkFWK20WlzGUsK7CsXlFLETqEdMEJINWPK+WL?=
 =?us-ascii?Q?+pf5gocFtpmCmPBk4FmgCARl3PjJYoayPQpquklBZMh8qjGFUKEzcKtEIuLz?=
 =?us-ascii?Q?jMMuSINQQKN3Ffo/qnAaFdw1eMVKR8DwuxEHNeHxnmlM/Zsk8VIe3uEf3S9L?=
 =?us-ascii?Q?AwoFdC+DBYUV/cLws84rXurZEFSDXXVauZfkEzbgHMOk1OdwTOkFibNkecdZ?=
 =?us-ascii?Q?+npjEr95D9xMZPBbmB03dUbgZGgrJc2M0hfk/nWbW0Nr5Mq3wqZsvB7Rcqkz?=
 =?us-ascii?Q?x8EaovA0DPV8gY6hT3+y0NWAxHnkRItRykxNK85B7qrIZp+Rb3nW8dxnOjcQ?=
 =?us-ascii?Q?QV2WvSNHOCEDSE4/KCH0v4mzVkefpFnrlmqtIVoMIOHh95bh0k/PQR5ef7VG?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0fa02b-9683-4aec-4617-08dd98478d69
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:12:04.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92d1jrmUO3OOSazbhJWglEMtuagan9vHVWcy7MKQaAuYKhMq2PyKKzvzjSVNd86guvzlWG+WrG+gP2SSlUEKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8615
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 May 2025 09:12:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17623

Hi all,

I previously submitted a patch series that improves BitBake's git fetch mec=
hanisms:
fetch2/git: Improve shallow, lfs, and tag support
When `ud.shallow =3D=3D 1`:
- Prefer an initial shallow clone over an initial full bare clone,
  while still utilizing any already existing full bare clones.

However, there is an issue when using PREMIRRORS and shallow cloning toghet=
her:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15856

This patch ensures a valid symlink in the `PREMIRRORS` case when using shal=
low cloning.
Since `ud.path` contains in that case the `PREMIRRORS` prefix path, this ch=
ange ensures that a correct symlink is set up.

This patch is a _working_ *proof-of-concept* and should serve as a discussi=
on base on the mailing list.

Patches:
1) fetch2: Ensure a valid symlink in `PREMIRRORS` case when using shallow c=
loning

Best regards

Stefan

Stefan Koch (1):
  fetch2: Ensure a valid symlink in `PREMIRRORS` case when using shallow
    cloning

 lib/bb/fetch2/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

--=20
2.39.5


