Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6CDC02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 17:03:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.68])
 by mx.groups.io with SMTP id smtpd.web11.20757.1737479015897895179
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 09:03:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=JnVxbntk;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=JnVxbntk;
 spf=pass (domain: arm.com, ip: 40.107.20.68, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ecUnZNVF5JyGD83fePH+gHhnWCGo1ANzmoZXpFMuSUeBbo01HOyVuKYWAbnF2vkDH8DjUX3dH6zXPHY76zQXqwyujfskQ1ebX1/TrHqCHRAGG0+CAPr09S4UWBUFxp/BCou3pYV6US/KE47mhS2Rrj4gj2xVevKq3YXN49lZeFeXbpegXV93pIMWEeQe+SpCgtuc6CE4Wn8CzOBNBsmlWSgmcv7dnuYHCPo/pENIL+pBHUR3wrhXaQcmkIx4RWi2UV+ibHUlsy28Dp37flspYZz1KlnRdMmnA6yES9H5JwmLdM1ax8iHuNzeepqJj8rBMnXbz6v/nVDlgXHVN/QaWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJBQKkq5kvbjzcjevZ2Bac+gPQPmq2eRF1aOxfbPs7E=;
 b=Iqsk4j+6sxGQyShZcC04Tv/TkSqGFO5xvwTVdqC2Qg2QteztxXJUANJk72O5rZP1ugmU0HYP5zBR5K9b3aTJTf5HVNG8Hee1Fdrs8D5ei+FfDgu3sMHxXvHTfsSideOW12gvjairEksjtNFfwrd9LPaJYu/75SQwOuOzTTvctjJp0kFgHozem6eoltxKVnJryyagvtJl/FTbsvRg2O3Fg0POX+/0dbc4U6WZXJaPG4w0ihmmlJyvBl5QUnG7pnoXJrc48dgiuNdjnXJF4vgR2Cs+93xHhAOoRMzInyhnbjsjqk/wIP4EiP5p23N2wrRX8Gj1OBaYxBhktCSFoltqqg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJBQKkq5kvbjzcjevZ2Bac+gPQPmq2eRF1aOxfbPs7E=;
 b=JnVxbntk8IxfV62GaNv+QKHmhEATAY5MTjUvzxPf+W/1S1F8zQt0jh3DrIrHY6xeTlv//3G1ZalGOOas0+d2gFCRm2tzlVKfYxBqW5buuVjmn2Evoy8UifQbNtHXrOOiyizU0fmng7OYFdCvqat2OqO2UlMjGudOt/HeyMGokPQ=
Received: from AS9PR0301CA0025.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::22) by AS8PR08MB6229.eurprd08.prod.outlook.com
 (2603:10a6:20b:295::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 17:03:30 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:468:cafe::42) by AS9PR0301CA0025.outlook.office365.com
 (2603:10a6:20b:468::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 17:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Tue, 21 Jan 2025 17:03:30 +0000
Received: ("Tessian outbound 5faa93a968f1:v543"); Tue, 21 Jan 2025 17:03:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 847e05e8136ec378
X-TessianGatewayMetadata: P/jXITgRYdO5iPzLDSbm/UTcoXzWOSxHBqXUznbQmDr22HwxEbB5YJsmlpF/J+Rg5l69+iCp7a29b8yzi00bO+TKxPp/17MDVXQhu8wDe09b8nFYRcAs7Y1jkhw6VDs9EqOedPXaXDk46J24ny9ZkRWWNDKhiZ8xr1IyVNrznEo=
X-CR-MTA-TID: 64aa7808
Received: from Ldf119bad6c08.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1B5CDABB-52CD-4087-8762-4EABB7A75946.1;
	Tue, 21 Jan 2025 17:03:23 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ldf119bad6c08.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 21 Jan 2025 17:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vbh9fpNcSMa8qli1BKTxOnmj3DFVokh1SMzdvfWF1Fsabu0pndLcYJCO3tgUPimXfXWLXD71JtMxakzwQTtLtix+9nxHxm7ET65M7gwyuNBd8Ypaoks1oOKjm26hx0FSWJxdcUChC2W08gawSbmeOZxndcqjZB4toLylp+E25NpVeKurSXjeypJN1/pqRRSqSDbWWie3XoC9EdjVvWCDFPx4N4s2bKabEMjh0xPJkCf9APp1Z1aurlG4mCJDGWOssUaWTyJ+JqXeVEC/lUi/D5KquiJkwJPY0c0zu3pbwXfYqK5Nof6wYcVFZJFEN3ksLRcZKfsmt4NeJex+3jX9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJBQKkq5kvbjzcjevZ2Bac+gPQPmq2eRF1aOxfbPs7E=;
 b=E7ICe7DpLS7VhfcNyjUHA8R8ImsXfiZN0BvApZGK2+dST1ZN4XHYwd+aTxzW44W9Zo7P+v6zC5IU6jk8vtjAkIQSYQ0kZIW75SyeBnIc9eMzaKvptJc0BLk/0JLATMNh+/Np1x3r2UpuAb7GcR/fwFM7QiM7gkVQXD2Uu2iAm6XsJ8U57R4B5Fh8WSX604cd0WqRisgEgddNDO2o5sZaDt/851OB8HWM9eyCmQR7NI586ubVBlDSbXF21C9srXvTmTYUaahkqwhhBGfdrxzLsNVxZCUImA3Ty3ilIiGpEDJ3GaOQSMXxZkQ4sS1SDXbmY6trSvBFMAyFF8IUBObtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJBQKkq5kvbjzcjevZ2Bac+gPQPmq2eRF1aOxfbPs7E=;
 b=JnVxbntk8IxfV62GaNv+QKHmhEATAY5MTjUvzxPf+W/1S1F8zQt0jh3DrIrHY6xeTlv//3G1ZalGOOas0+d2gFCRm2tzlVKfYxBqW5buuVjmn2Evoy8UifQbNtHXrOOiyizU0fmng7OYFdCvqat2OqO2UlMjGudOt/HeyMGokPQ=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AM8PR08MB6386.eurprd08.prod.outlook.com (2603:10a6:20b:362::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 17:03:21 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%6]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 17:03:21 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: use default wget
 user-agent in upstream version checks
Thread-Topic: [bitbake-devel] [PATCH] fetch2/wget.py: use default wget
 user-agent in upstream version checks
Thread-Index: AQHbHjgwzEo4qCr0V06Bmr2Z5/gSg7MiEEIA
Date: Tue, 21 Jan 2025 17:03:21 +0000
Message-ID: <D92E13F2-8973-407A-801E-D743AE755FD9@arm.com>
References: <20241014125406.2322310-1-alex.kanavin@gmail.com>
In-Reply-To: <20241014125406.2322310-1-alex.kanavin@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.300.87.4.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AM8PR08MB6386:EE_|AM3PEPF0000A797:EE_|AS8PR08MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a808253-9d64-4cbc-4d19-08dd3a3d87bb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?OVptY1d2N3hTZEd3bGVCd3V6UllBdk51U2pjSDZlVEUrRUlqMGxyaEJGRERX?=
 =?utf-8?B?TDNEeGN1NituOHdSTHArWTJVRzFYTXJUYm0yQncrTkV6QTU3V093d09GVzFP?=
 =?utf-8?B?L3VuYm4vc0U1alNKRDR6Y2dVdW9xSHlIUXlLQVNxNjJDcFBQdkRMZ3ppWGFK?=
 =?utf-8?B?MUxxODBQM3l1OFJwU0RLeDc4ME9tNDVUMnhJM2FwTlU0bEZPYlVhS3pjVjBG?=
 =?utf-8?B?Ung0NXh0VnNBT0IydTZkUlp5NWhzdjdMak8vZ0tIT2t1VmxvdGxBcUlzTzJF?=
 =?utf-8?B?THY4STdCWmpZSnFVb2kxSitWOXpPcHgwelIxWGNsMnVFMlkrYnB5K0svRFBC?=
 =?utf-8?B?TS95WUJoSkgvTmF0MUxmUmFmN0ZFd253R3U4ai92NWVFZWpPMFdBUGR6MjFw?=
 =?utf-8?B?emwvSjgzNlJLRU1uQjJiQTBWYUp4dVozZUpvcTFKY2VQZDZyUFNBNnh5SkNr?=
 =?utf-8?B?Lzg4K25jclU2enlSYVIwaFR4WHFoR2x2Rk92MWw5SS9uMExBcERmTkwrdFZZ?=
 =?utf-8?B?TXhqeFI1S3lrZnJMK0doZWp2WTJEajR5V2ZlaUk1Q0tHREViZVBvWDhiZ3FQ?=
 =?utf-8?B?M0dtQnAxeGlVelBPVlB2OTBpNnV3RGxJMGZjb2VPNkxTSEkrelErWnZYN2px?=
 =?utf-8?B?cTViWlNtSUNhMDlXTUhYdWxuc3VIbVQ2V1QvdmIwajRsbU5vTzdscXNEbEwz?=
 =?utf-8?B?cUYrWnNVaEg1SUNjWVVtVHk3UEE2ZklQVmNxR3owUmZZN1k5Vk5LbU5UUjQv?=
 =?utf-8?B?clExdzhoRkJSTmpCSXJMd1BiNmQ2VlV2bTFFYStwZTc0VWYvODRyUU1ndUFj?=
 =?utf-8?B?NS9xNkN1UU93MEFMMFZGZ1NPdDI2bkZLZjdMdWZpZnlZa0lnV1BrVDlQZHlz?=
 =?utf-8?B?Y0Y4clB1Z00zeFE5MmY2VkhtZHhGbHl0T2J3S1R2VjhHSlA3amszR3NOc3Yv?=
 =?utf-8?B?ZHFDMnl2TCtJMHNmeG51SWJwSFpyeTNybTZaWXVodThRd09yQ01oRkYxU3NR?=
 =?utf-8?B?NEtCb3NtWktKZ1QwZnUrL0dRcEY2T1R3d3NySisyMVlLOWVISGVNZDQxRHRx?=
 =?utf-8?B?QmNIeDRrSk9vMUxMVXZsZ3ZRTHpObG1jdWRsdjhCakxiaWRkSHNBbkt2b2dH?=
 =?utf-8?B?UUw5VFM0MW1Zc0tDM2ZUenptL2VuOHJaakt1cGNnbFRnOTUzVjQydFJ1V2Q3?=
 =?utf-8?B?K0lLU0x2dXlHSVFtUUs0Q1Q1dFJvaUZHTmxhY0doOTlSQmVNbUtwU2xNRVAr?=
 =?utf-8?B?Tm9Tajc0TUF5VERHU0c1R3V5WFRCQW5wUTkybDFFRWJ1anVpQjkveDhBZzVt?=
 =?utf-8?B?OExuVWR3Q2laQVdQMGw4bXI3d3NER1RMY2Q0cGlmSEUvaEVFVjlHeEtxRUx0?=
 =?utf-8?B?Z3RNME8xWUFOdTd0a0VLNkFLbktDRVRXdzBlWFFHVnUxVE51dVdhK2pUSlY4?=
 =?utf-8?B?VjVKTjBsNDZoYWFrNUhBQ3VVTDRnZStoNHA2cVA2VjMrSDV5L0VzRGNyN2la?=
 =?utf-8?B?WlBLMFJGN25jVTVxcXM2OFR2b0N1WVZtL2s3dTVWTHVmVzF4VzkwQlNybU9M?=
 =?utf-8?B?TnhYTjY5Z04xcHRsdFJHL3NPbG8zMTFDRUQwakM3QStQNEhpYVg0a3hwUE1S?=
 =?utf-8?B?dHU2aElZQ1ZmQ0RMSlR1d0FIaTZlSWlPTzRPaGZXMTcxazlwUzRNMktqelZQ?=
 =?utf-8?B?bWNoS0NJL24zNHdYS0swenJwVzhUZ1RaYVovam5rY2NtK3g1ay8rdjJUUi9a?=
 =?utf-8?B?QkYzNmxsTXNVeld2SlJFTi9PYmttV3BDVi9PRkE4T3pjTk9JbitDa2FPSk5u?=
 =?utf-8?B?aXNzTHJOTXd3WVFkYUtCSXlkVkhkZFJFNWFyL1hKK1ZaZ3plQzlFSk1YbnJs?=
 =?utf-8?Q?0sMvl6SIM213d?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <148A168CED037644B9AFF1EDD2E1AB60@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6386
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	1ef07906-b531-4cf7-dce5-08dd3a3d828a
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MVJ0Sk0vRmNxMDdnUm05bW1UckNocHdCVEwrTVlGS2ZSVTROSDNGU1paVlNJ?=
 =?utf-8?B?QjdWUE9rOFVQUkxjd1N4MlZVNWRqY2JMNFJwRWcxWlFSaFMzUHc5alZTN3hW?=
 =?utf-8?B?V2pBbVdmTCtQWGR5NWE5aGZsTWpBYUdzZkJWaUpOWGp0WXU2Qjh0Z2p1VnZG?=
 =?utf-8?B?eWE1azQ0bmtyMmo0eXppN3kvSXJyem1nM0V2OUlTWUFOVnBubmVCYnUrQnJV?=
 =?utf-8?B?STRWaW5POWFzWlptYThUNFFVaXNla08yVkNoUGhLV0w5bHk1QU9hU1M2Rk1x?=
 =?utf-8?B?Q2xXK3l2S0lpTjhQV3FGcm9SN25MYWVheWFIei9lZUxHeEJtVVgxN0FTT2hn?=
 =?utf-8?B?QmRKRW5FSEIzMzNrQXNMNStQdW1BTVpINVVUbWJqVVRJQVJvUVA4NkJMRTFP?=
 =?utf-8?B?YURsVmg5aUhzUDF2aHBwaWNkQmRONHZpNGpxbE9McUVvQkJVT0RqRVdzNHpX?=
 =?utf-8?B?Nnk3VlRMVVdseldQNVBTVE01ZFduTWpUMFNNSVhwUXVkZ2JLRVJ3aTZXMGxl?=
 =?utf-8?B?MFE0aFBpcGZxODRpTzFJT1ZoNCtxN1kwZk9FSjRjUkZHMWhJTUlJTk5jMjZx?=
 =?utf-8?B?Z3M2a2ZVZVdySkN4bXNid0lRNTUvaG9jRFVrU2pJSlZvOXQ5bHVaZFhUcUZW?=
 =?utf-8?B?RmNXWDFjUm50c2pGQUFYM1p1Z3lHamNNSC9hTjNnT1RFdWU0dUhrdVNqNytS?=
 =?utf-8?B?Q1lQUmJ3RUgwSEZLamV2OHV0eUtBMnNGZFNHQWRlMUQzdEV0UThlcnprbmNP?=
 =?utf-8?B?VE80djByNzRvUktxREdMajZHWTh4bjlQelVnZUtaa0RGZy9Ka2pmT1dlbVlu?=
 =?utf-8?B?SVV0am1mN1I3L0ZiS21hZzltVk9DaStmMGUxRXhyZUZYSk8rQWI0Z080UXJR?=
 =?utf-8?B?QTdVeDlDanpGQkdnUGRSUkpMNWVMQjF5TlZFWDRMM0ZmOTFYNUdobDhuaXE3?=
 =?utf-8?B?eGk0ZUhyZU56dENXNWhVOUJTcDhwZWZlbUNvbGY0VGMvZ3RPREZESmMrakNi?=
 =?utf-8?B?RXVaS3NzZi9BeGNFdHRpbDF5WFRsTWtXN09RM2o1NWI2SzdKZ1cxeU03Z0lD?=
 =?utf-8?B?NXlYc0tvWEdXUlJJMU8vL3pGSU1hL3I5SU9VQ0V3QXYvMTdHN0hjalBUT01V?=
 =?utf-8?B?cGhXcnV4dkRRU2E5d3pNaW1MeCtSdCtVUWxCLzIza2pGUTAzVi9hY2pYWnpU?=
 =?utf-8?B?M0J1RWp4Q0VWT1ViUU9ERFlDV21ZbzdFY3pkVDBFK0xsSlVsK0cwbm9keWNS?=
 =?utf-8?B?N1M5WjMwcXNQMFdJdThYV3dNRVJoakhLWmhrY1hHM2pERjUwdHlFM0VGYllN?=
 =?utf-8?B?VmtNVythZmNWcmlLL0Z3ZVUyZHlSK1FoT3RFTXFqUy94eVZ4OWFoQ2RqenRt?=
 =?utf-8?B?Uk0yUnZPNEZFRHRoQjZUTWhtM1BLdThsNHF0V3pzK1ArUEFsQS9wVmRHVEFu?=
 =?utf-8?B?NXZJdFRydTRtR2JvNmFJcGNxOHFyNWdaLzkvRWIwYnlwb25Kc2VmZkp4a2pt?=
 =?utf-8?B?SE1oR3FQdjR5WnB0V2l6Y2YrandNREw0cHBQNkxlSzUzcG1IdUdIaXE2WEJz?=
 =?utf-8?B?bEVidkFPMkM4VVFIOEJ0SzBVN1Fib0ZkVlp0anY5SHhFZCtOSU5NVGNqMkNm?=
 =?utf-8?B?VDlLbnRMWU9qUkFBY1R4NE5jbXgzZnBGcnJsbldjek1XNzV3WkZKbzVXdFoz?=
 =?utf-8?B?OTJGRjRVTGVZME1wbC9JdWhmc3NLNHlBQ2J6dE9LUVdJR2poRzNCUEV4b1VE?=
 =?utf-8?B?VTY1T2xWVkVvYjhTMmF6TDh5UkJoWDdZR05PV0xLY2RsU2Z4UnRZY2xVZXBn?=
 =?utf-8?B?L0xhdFFyU2ZJT2N0RHZZWWs2eVRVT0U4RnFBZFo4Z3gyUFVFRXlHd0ZWQmlr?=
 =?utf-8?B?SWNoWlB5UmFCMFVCSjBiNU1TZGxiczhVb3l5OFlCS0hBTm9FTU51bGtVMmxV?=
 =?utf-8?Q?rIBjVCbxzYUBXwpdR2wPH+sCBjh9EUBq?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 17:03:30.0624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a808253-9d64-4cbc-4d19-08dd3a3d87bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6229
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 17:03:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17044

T24gMTQgT2N0IDIwMjQsIGF0IDEzOjU0LCBBbGV4YW5kZXIgS2FuYXZpbiB2aWEgbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZyA8YWxleC5rYW5hdmluPWdtYWlsLmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQu
b3JnPiB3cm90ZToNCj4gDQo+IEZyb206IEFsZXhhbmRlciBLYW5hdmluIDxhbGV4QGxpbnV0cm9u
aXguZGU+DQo+IA0KPiBUaGlzIGhhcyBiZWVuIHNldCB0byB2YXJpb3VzIG1vemlsbGEgdmVyc2lv
bnMgZnJvbSB0aGlzIHBvaW50IG9ud2FyZHMgd2l0aG91dA0KPiBleHBsYW5hdGlvbiBvciBzcGVj
aWZpYyBleGFtcGxlczoNCj4gaHR0cHM6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZy9wb2t5L2NvbW1p
dC8/aD1tYXN0ZXItbmV4dCZpZD1iYTA2Y2M4OTQzZDAyMWY0MDZjM2QyOTJjZTQxNWI3NzMxOWNh
NWM2DQo+IA0KPiBIb3dldmVyLCBzb3VyY2Vmb3JnZSBoYXMgcmVjZW50bHkgYmFubmVkIHRoZSBj
dXJyZW50ICdmYWtlIG1vemlsbGEnIHZlcnNpb24NCj4gd2UndmUgYmVlbiBzdXBwbHlpbmcsIHJl
c3VsdGluZyBpbiBicm9rZW4gdmVyc2lvbiBjaGVja3M6DQoNCk9mIGNvdXJzZSBmb3IgZnVuIHdl
4oCZdmUganVzdCBkaXNjb3ZlcmVkIHRoYXQgdGhlIG9wZW5qZGsgbWVyY3VyaWFsIHJlcG9zaXRv
cnkgcmVqZWN0cyB3Z2V0L2N1cmwgYW5kIHlvdSBuZWVkIHRvIGZha2UgYSBicm93c2VyIFUtQSB0
byBkb3dubG9hZCBmaWxlc+KApg0KDQpSb3Nz

