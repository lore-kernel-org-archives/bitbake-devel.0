Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461AAE7716D
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 17:46:45 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web10.21263.1733334400636956238
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 09:46:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=UdcgBtcH;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=UdcgBtcH;
 spf=pass (domain: arm.com, ip: 40.107.20.76, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PILqkhLOzkhZ0tzfTY/0jz1P22pIzRm+keIMyQ845SFLpnPqBM6oXxBUeHbHwq/5DgupACG/9us+T6VezXEXROit41lH/E/AH5rchGm/3HQkNCSQPV0o1dWef1DgX8A7AAtjKsA4s73K5twZG/w2PyEui1TsZxPzCwDlQNjoU4AN/FUtI6ywg3U0oi6k/lzxFtTbNDD1fl/KlQZzCWQ8DrV54GocbbiqUB2AOWJb6WQIoTFGv6CAopyatWqzoOWc3oNuhXShqPYnXy+BDgO1dVKfJCQDdELgM0segGkU82erpcIu/qfR3PyJQRekgE2Gb8kIeZBXUA0YV7+1AhLWug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVGaN2FsWUeg8n8NwVVWALQ9KJ2NGABN/hLGqOKte28=;
 b=KtOKWEw9bWAYuy5/sq21ft22leMbcZFk3HDahYXPT/q4bBymgW10iNmo5p68/drvaOHBiK0TC+ayrEtreg+tgAfs4aYkbc2RKrZQ166ILZljNycBYh3EG9PJTY4BYT/OJ97xFsx3unO5xeEOHPp6dYDxMZcMb7Wt2v7KROzfquHgctxNDLxT1yg4Er1nQqtJEDY6BzyhGcBwwvNYY1ZcKVvhIr/9u/jyt8MXQ0/uNJ8TUzAynSAM0GTvG7bUxFNBs42nIhFCoPQ9zPWi4wgV4X8U7aB8N8YdhJAx4d9ESy2Wno+vFMDjFqoNSQxFdm/TWEtS/fuwQHs1DGu7TH5aSg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVGaN2FsWUeg8n8NwVVWALQ9KJ2NGABN/hLGqOKte28=;
 b=UdcgBtcHJdZcD4q1v7qHY71q9L5+wPPeud1Rl4hMbPDcR85EHvmfakXtMJE/qVExGh9fU8NmCNOQgXOeNe9b+mJs8UP9XXwu5iPzHV3GlO+7Av9e7ENMRviS6jC/mZujYB9eTNR23vY8g5Ecoh2Bw/vMAenjqxBOZIrmeQPbPy0=
Received: from DB3PR08CA0009.eurprd08.prod.outlook.com (2603:10a6:8::22) by
 PAWPR08MB9006.eurprd08.prod.outlook.com (2603:10a6:102:33f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 17:46:34 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::d0) by DB3PR08CA0009.outlook.office365.com
 (2603:10a6:8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 17:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 17:46:34 +0000
Received: ("Tessian outbound e5f180d9e249:v522"); Wed, 04 Dec 2024 17:46:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3d9ee869294614d8
X-TessianGatewayMetadata: N9KbB7yBDjOmj00nISlPtSEJzyNhGeKxuZ7WOTDAUkaI3qvb/YCzBYXPEEHr/D4ez1kqcRXkll1HI5rago/ja2sJibG3ylyCTYTrwOswwoZjXmiQNIRmkINSU/0c8w8y3wD8ldgWuoAs4G7w8hVMRUWX79DblizycgeTyXViAzo=
X-CR-MTA-TID: 64aa7808
Received: from L7fd40cfc2c4b.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8261B867-B4DE-4466-B515-539A7D94A6DB.1;
	Wed, 04 Dec 2024 17:46:28 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L7fd40cfc2c4b.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 04 Dec 2024 17:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nge07kZTKff7oZ+CI5WBYR2yZMNq/BcIAzDmjtA70wg0zvDY6HKQhBy0lFXjxRfT5KH2gySmTjAeC4bT7XyjPkvZhezgRyS8Df9P44pA2OXNvjx562f0d6WhxZBbYq9zooDjyL9VsLmkrz+TGonjRS7OMcxHaVqYZeDX8UfD4Ska/WemFpfltv5GgPttS8Ts3+aRf9DH9lQNElPe0mgmexVi4kVDhjN2bh2jFa2uYOQprz/M2uWB3BqRHHkkyf42VQnMlChIA79wcGdPAEHCysRVH4XdZkR5QWQk1Sb7lVaRqQ4xn6j9XIp0dVAWCKMK7wl6PAI1pkjfAe3C62/T7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVGaN2FsWUeg8n8NwVVWALQ9KJ2NGABN/hLGqOKte28=;
 b=pXFZc10QwSBNRJ3LfwEgv+E5pD7SY4fXsdxgsTXl2cZcSxUx9+z3Ue2QQw1KzOKZQhnDI81wntQXz23IKfq0hqkgzxoEfaRD/TKkTgiJDteZDpfJRav5yhAIXduevXTiW/yN3S9DQQ9vsioVXYqOQKjJq1F81oWv18A575BCAY25GPAyDx2bNlhBCVmP9nsBG6B59N0ee97X2VZBsDaBVKgbiu4KYgH2j03AEncfjfGSlYYVXuTOASGzizWNt7Cue4sdzIRinoh1VvJBCy7uNJs4xkLQzPwlFUmSqGx33iisU3RQcVZUFyS7SaFVJsTpQG4i57lG225IZcFoWDf06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVGaN2FsWUeg8n8NwVVWALQ9KJ2NGABN/hLGqOKte28=;
 b=UdcgBtcHJdZcD4q1v7qHY71q9L5+wPPeud1Rl4hMbPDcR85EHvmfakXtMJE/qVExGh9fU8NmCNOQgXOeNe9b+mJs8UP9XXwu5iPzHV3GlO+7Av9e7ENMRviS6jC/mZujYB9eTNR23vY8g5Ecoh2Bw/vMAenjqxBOZIrmeQPbPy0=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AM0PR08MB5507.eurprd08.prod.outlook.com (2603:10a6:208:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 17:46:26 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 17:46:25 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/tests: use bb.build.listtasks()
 instead of __BBTASKS
Thread-Topic: [bitbake-devel] [PATCH] lib/bb/tests: use bb.build.listtasks()
 instead of __BBTASKS
Thread-Index: AQHbRjYGDtf0XjsOckWwZOdfEIEBt7LWV7cAgAAEsYA=
Date: Wed, 4 Dec 2024 17:46:25 +0000
Message-ID: <3DE84A08-9293-4587-9723-CE1852CBB7B4@arm.com>
References: <20241204101911.1218039-1-ross.burton@arm.com>
 <D633ECVEQJPV.RW45QS9AIPTJ@bootlin.com>
In-Reply-To: <D633ECVEQJPV.RW45QS9AIPTJ@bootlin.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.200.121)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AM0PR08MB5507:EE_|DU2PEPF00028CFF:EE_|PAWPR08MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3745e3-1477-432c-a50d-08dd148b984e
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?SmtFRjV3Nk5lQkZOYkdpTmNIaG1laklRS1Q4Z05LWHFQbzdlL0N2UFF4TW5k?=
 =?utf-8?B?Rm5VbTFvMXR0a0dNL0Jsd0d1aUY5YjFyQ1JpeFc5WDdBRCt5dmZCY3RoSGpp?=
 =?utf-8?B?TzNZYVpEQ09VVE52M3V0cDNyZC9LemRYc1paa09mNk0wM3pMZU14K0p4SUND?=
 =?utf-8?B?U1NEVFE1UG5Nb0M0VFZoMFNoZ3hhMUQ0bnhyMGNJYXVwSDdkazFGUmpsUnJI?=
 =?utf-8?B?M0NkdkZCWVVOZ1pWeXVqeU5WTmRZNlkvOEE1cnBVd2xkTXJDOXU0YlVvdVYw?=
 =?utf-8?B?V2JiZGR2QXh4WlFiTVkybElaSnF5S3pqRlJna1lQK3pEMjBEQXV2ci9lNHlG?=
 =?utf-8?B?Y291MXo4TDVmSVJFTWx4RUZHSVQxQ0hndmVKRjc5WElNWjllbTdJYk8zZk52?=
 =?utf-8?B?emI3Y3k0NVNTWXR2Z2xXa3dYczdHWVM4NVdYcnorOXovdXpFbkhEbTlBV1FE?=
 =?utf-8?B?QVVtUnlxRFRCVnVCNmhkbDYxUjNvcHUxMjlUc0VZYzltVkxBcFpJUzhnZnA2?=
 =?utf-8?B?eExNdldmOExTa001UzNXd3dUVUh5YzlZRTJISFZERjRYNnJ3c2wydnNUaFdY?=
 =?utf-8?B?TTM3UElXc0hQVnBTd1BRZmN5eVFmQmJaN1BmTmNuSThFSDY3MkxWUTN5T1Ri?=
 =?utf-8?B?T3EvUjFIOExkLzNqVGYvZ2FmUVZqeWFMbDcxallwSEk1U0RKMmgxQ1FpS0M2?=
 =?utf-8?B?azRBVzFQeTVMYXAvdmVMb2ZCbnZId1hmdi9Oem1zK2NUaGdrY1dPYysrY0JO?=
 =?utf-8?B?Mk45ckpzZkRWNHp5aGlUYmRLaURkZjQvbWhJbVgvLzFLRnNKOTVDVy9Bdlc2?=
 =?utf-8?B?T0dFY2tZUkNtTEd6dThiTmF2Wk9UQWhmbGU5QTZFaDRzZlY3c1J1MDkvVC90?=
 =?utf-8?B?ZDBNR21NMVE3cDk3VFI1d05uR2lPZ21hMkZabjlnSlBYYlVpOWdkSnNDNnN6?=
 =?utf-8?B?dTRKcGlaS1RLMDAxUDlEOUlJRnR3UHdZUUVHcnIycHo3bzU0ZzFMZ2JUTkFy?=
 =?utf-8?B?QVhQamIwc1FKWEYrZk5tSS9lbXpEaGxSVGpvVFJkYnVTS3R4RDFXUHZKMHVm?=
 =?utf-8?B?SDhsa0FTRVVUOWZyczRIUEdPWUR1TEdiczhEcjZjTjVXeVN0K0xuU2E1Vmo4?=
 =?utf-8?B?eUlFa0tsNFF5K2t2L0U5RERTblRHNm9pWmVZazcwbVVVZ0xVa0ZWRkJvQzhG?=
 =?utf-8?B?UXFydWRQVm5JYzdVdEFCTHFTL3l0TDRmSWNQNWNvT0RSbkYwc0NoWE52UHBY?=
 =?utf-8?B?QjRhUWFPUm1HSkdKbVIvS1Z0R2g2NVZqZEJqYlJ6dHkxZENQNTZzbU0yT0FE?=
 =?utf-8?B?bHdUVUpZYlRpTkQ5RVVVSFpqbnJydnNPSjlaN2NGdVRubmRGMVZkWjR4cVVk?=
 =?utf-8?B?NVZVeEpra2xwVU1QYUNnVk5rdnY5VnhQNlNPNUx6cEdXTjZnK2E3Qm1RTnBN?=
 =?utf-8?B?WmJad0RuV1BpMkxrQjJQT2tFNnN0K29DKzVIcFlpZUxjVHNYMFAreGZrQ3lq?=
 =?utf-8?B?ZlBvYjBFdkViWk0wZUJFcHZ0aXlxbXlHT0RPOXZJRXcxR3l0RytiV2p5OFdQ?=
 =?utf-8?B?MFdLYndoVXB1MzNrekFCMHJucnNBODZMWGVxeTVyZXMzSWhtOGlHek5RejhR?=
 =?utf-8?B?OGtmbnFrQ3NPQWQxUGQ4Y2xPRmtHZDh2RnkydDZtMWlDa2xOVFVNV3o5a0RH?=
 =?utf-8?B?aWpkbHFBV2xwc2d1WHBJVmQ4dUVTOVFzckhNakRhVEVSQXF2OTJoNUgyZWFs?=
 =?utf-8?B?aWsyVUVTQk9GNm9mTHVUNEVxSHluM1ljQVkrRWYrODVpT2YzSUZaM1diMlhp?=
 =?utf-8?B?SW5RUFVnMktiN2oxblpRZlk4eHdQWnR1bUJhUnZNRUlabWw5VkwyaGhOcStB?=
 =?utf-8?B?QVZiMG9Dd2doNUdEalMxK1lTM0lVa29uRHJWZytHbFpzaFE9PQ==?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C9AE48CC6DB354FA5B16F8344E02485@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5507
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	19b60525-cba9-4fa4-3cf0-08dd148b9332
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?LzZYb2phNGNLcGlGQ1kwOWxJa0x2aUZDQ1A1Z1JhSnVNYU5keTZ6Ym56QmdY?=
 =?utf-8?B?M0dvZGp4T09EcUQyRVRMRWFNMjRpaE0weENsZlJSWWVLcmNPelpIcnp4MVpY?=
 =?utf-8?B?N0Z4R2xwdWJBWFdCbGFBTzJJK3BlRVJFVThsQ2lPL2pKZmVoTzFCMFVZMitY?=
 =?utf-8?B?RFZ2TGxsS1h3WkRSb0tQUEdub0doY3dPRE1hN0IzNTdXbGRqT0g5TnFMM0w4?=
 =?utf-8?B?VTRjWm8zTFk4eW1JSXJEcGhzVURNMlduMjBLSXJCQmxkQlJua0tieUVkSkFH?=
 =?utf-8?B?Rkl0alBwN01FekNjcFowUDJFSHlyODVIOVExc3QwN09GcVIweTFlaFNlcExT?=
 =?utf-8?B?Wmo2elJlbTVDdExaQ3c4c1dNYTU3VERjQW01MlNuL0RpQzY0aCtYSi9uQ0pD?=
 =?utf-8?B?Vi9FSzlpRnJMeVE4aUIyeVhrVVBPRVRsN0FYWjd1SUVaclNURFpqQzFndm1O?=
 =?utf-8?B?VUVyMFAybmVmZGZsUzFYUVltQkJWNzJSQlp2RzR2MWZBaDhZUHBEdXdxSnFw?=
 =?utf-8?B?RWMzSXlsUXl1Z2pEVmFXeTM0Q0poN2lWcTRaTWN1NW5JT0hpR2pNaFF1L0xG?=
 =?utf-8?B?bzA0SHgzVVJMcTNHWENCWnA0RVhvNGlzMnRXa0plV3NjaENnRzZncmRqamR4?=
 =?utf-8?B?MG1SU0NZeVRHQTdUaW9qQkJiMXVjc2JyaWtkNnlQeG9ma01FYk1vQVMxV3Ir?=
 =?utf-8?B?VFlKcUtFbXNKSjhQeWRwc3lrdXNFc2dFS3lzOUJYTWh6UWhKdlRYOXMxaUlw?=
 =?utf-8?B?K2NrcDNWNm54Vkd1MitNb1B4YWZqbkxaYXRZeW05MkFSd05CWWdFOXhpcm45?=
 =?utf-8?B?SkEvWGJUc29JSUR1bWkrcDBiQlpUdXF6SkxCOVpESjRuRDFVYVZSckZrUmls?=
 =?utf-8?B?cWo5TUxXTTc2VDJHQXgzSTF1bEdkc0dFU3lNUEtnWFNyZUViODNGeG9Zajlw?=
 =?utf-8?B?cGVJT3FrcE81aFpxN1ZuUFF3SWZ4ZVZDOUFpVkNSY1JCNDd0d2xxa0RmSTkx?=
 =?utf-8?B?Q3ZySkwwaTV3V2tMWE1PYTRiMXBLeHdib2JjcWdRNEx3VTBnL3FDUDY0d2VS?=
 =?utf-8?B?ZWMxNWtGTFMraUxUMmswVll4M0JMOWgxd0k0ckNtMDNEM3VvTUpsVFJsQW1U?=
 =?utf-8?B?RHJ4UDlybXNkeU5wN0l1NlkxeDZNZFhNSUFqTGVYRkZrdEVUaHlvOVRrdXVT?=
 =?utf-8?B?Vlp3TFgzUGVyRjd0dUVEZE9iSHdPYVM1dVlaUmYrcC9vTWFZVzVZd04rNDN3?=
 =?utf-8?B?VXhkL3dLVmRyejRxQWJ3Q3E1Rko3SWZEcVdiY2FraWNxam9iTFFtOUVHZHlC?=
 =?utf-8?B?cVo4M3NST1B4eHNjQnRUQzZndFNEeldQOEhHL1VPQVhLV3F6UTZTTEE1SnFw?=
 =?utf-8?B?NHR2L3hQemtETWtMaGRlQklKUGtybjhSQlNKUEdWQ0hGc2p4T0traHorSzVL?=
 =?utf-8?B?SmNVSFloUmhzY2VZQm5JNVR6ZjBVa1ZXaEpGbnY3Vk5veGZDYkVGWk9FTUhQ?=
 =?utf-8?B?QkMwY0VPOCtWT2diTnUxVi9DcHpaeVBiUGF3OVlUR011SUczK1VEaTNoS1hq?=
 =?utf-8?B?aHA1N3lmVzFXdFBHRjY4N1hHd3RIdEwwWUVXbGs2aDZXTmdsc3hKcHZRSm1Q?=
 =?utf-8?B?bUwwdEJmVnJwVURlVnpheWFXVVBzdzZoTEFQUXgvUjdNbExUZnQyQWVRQ0Uz?=
 =?utf-8?B?dVlQNDREejB0TS9nZEZWWFQrVVl3L3ZURXpXM084emV0dHN6YlZFUUtlMlNR?=
 =?utf-8?B?eXVaemF5Y3FvcDZEb3JBRXUvRW5nUVJJbDRTKzMzSXo4c3hjQWl0Ky83OVYx?=
 =?utf-8?B?eGFqSVBIMlNBY2VRZUtwVmI1YThwc2FOakVMUWlZcWtXMlYvblVKclhDV3M4?=
 =?utf-8?B?bjNwL3QrL2tqTjlqQTNrbm5CYVBkNnI0cklzbGFWNk1XdlBXckNCN0c1Si9l?=
 =?utf-8?Q?1qFGonPujK3c50GO7Vr45hHp5W0id4x2?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:46:34.4466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3745e3-1477-432c-a50d-08dd148b984e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9006
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 17:46:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16868

T24gNCBEZWMgMjAyNCwgYXQgMTc6MjksIE1hdGhpZXUgRHVib2lzLUJyaWFuZCA8bWF0aGlldS5k
dWJvaXMtYnJpYW5kQGJvb3RsaW4uY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCBEZWMgNCwgMjAy
NCBhdCAxMToxOSBBTSBDRVQsIFJvc3MgQnVydG9uIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
IHdyb3RlOg0KPj4gVXNlIHRoZSBuZXcgbGlzdHRhc2tzKCkgZnVuY3Rpb24gKGludHJvZHVjZWQg
aW4gMTg1YzRiKSB0byBhdm9pZA0KPj4gYWNjZXNzaW5nIGEgcHJpdmF0ZSB2YXJpYWJsZS4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogUm9zcyBCdXJ0b24gPHJvc3MuYnVydG9uQGFybS5jb20+DQo+
PiAtLS0NCj4gDQo+IEhpIFJvc3MsDQo+IA0KPiBJIGJlbGlldmUgc29tZSBvZS1zZWxmdGVzdCB3
aWxsIG5lZWQgdXBkYXRlIGFmdGVyIHRoaXMgbW9kaWZpY2F0aW9uLiBJDQo+IGhhdmUgdGhlIGZv
bGxvd2luZyBlcnJvciBvbiB0aGUgYXV0b2J1aWxkZXI6DQo+IA0KPiBGQUlMOiB0ZXN0X3BhcnNl
X2FkZHRhc2tfZGVsdGFzayAoYmIudGVzdHMucGFyc2UuUGFyc2VUZXN0LnRlc3RfcGFyc2VfYWRk
dGFza19kZWx0YXNrKQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRyYWNlYmFjayAobW9zdCByZWNlbnQg
Y2FsbCBsYXN0KToNCj4gIEZpbGUgIi9zcnYvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9vZS1zZWxm
dGVzdC11YnVudHUvYnVpbGQvYml0YmFrZS9saWIvYmIvdGVzdHMvcGFyc2UucHkiLCBsaW5lIDIw
NCwgaW4gdGVzdF9wYXJzZV9hZGR0YXNrX2RlbHRhc2sNCj4gICAgc2VsZi5hc3NlcnRFcXVhbChb
J2RvX2ZldGNoMicsICdkb19wYXRjaDInLCAnZG9fbXlwbGFpbnRhc2snLCAnZG9fbXl0YXNrJywg
J2RvX215dGFzazInLCAnZG9fbXl0YXNrNSddLCBiYi5idWlsZC5saXN0dGFza3MoZCkpDQo+IEFz
c2VydGlvbkVycm9yOiBbJ2RvX2ZldGNoMicsICdkb19wYXRjaDInLCAnZG9fbXlwbGFpbnRhc1sz
OSBjaGFyc11zazUnXSAhPSAoJ2RvX2ZldGNoMicsICdkb19wYXRjaDInLCAnZG9fbXlwbGFpbnRh
c1szOSBjaGFyc11zazXigJkpDQoNCkkgdGhvdWdodCBJ4oCZZCByYW4gdGhlIHRlc3Qgc3VpdGUg
YnV0IGl0IGxvb2tzIGxpa2UgaXTigJlzIG1vYW5pbmcgYWJvdXQgdGhlIHR5cGUgb2YgdGhlIGNv
bnRhaW5lci4gIFNvcnJ5LCBJ4oCZbGwgZml4IHVwLg0KDQpSb3Nz

