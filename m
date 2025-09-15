Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CBCAC592
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 14:19:52 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.25])
 by mx.groups.io with SMTP id smtpd.web11.34952.1757945984167832870
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 07:19:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=k6Mb4wS/;
 spf=pass (domain: cherry.de, ip: 40.107.162.25, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxqxvoDV+MeNxZ6MvoRLrFUdJZsPaU5hFN+smVB9Xkz9F4mbUH7cC8NYBDD8IQn/x3/0v3YfB2xECGkZ1SC+wsHLzwDpmPVzTqRnYYWQO9wTxBC0lb76FIeKshrrgqZhfWrnd+1NBLQKQt1T2PQg71zEqsU6fsAUW8R9RELvJuKQfxSTSEM0cmG+1G1KBbZDt0WZ09zgmHF+bj819YVe+ZbOEOA/tDXd/pzMoebRw8afnqPhC65qs1du4VS2e20ua6/AjNUotVLBw4cHOAYqrMWZ14qoCys2tqsSeIieDirSQgAdGReSCIgqh3FuvCh3min1r7QDb3yUk26VKlrBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4sXsNZiAHdZfIQTRNhv3Ac8y9x8Fq6rv674yoPyEqU=;
 b=pVwbeAI88y1Z7/gDUymvK1We514AG8t8k8A7nTEbtB1vUhj0RQG5x95DEVXhb+Gp1qAIUDGzwiKBe+lTQjbpNPrCXKDQIb+owO0mq92oCsReca9Kv7lUVh6z+lsO6B/CanqvT2BSJqjsIzVW9GaKPUNhcJ6jr4iqpZIgFyXmh4WuwHDYDYkCR3ZZVqb71LZ2AfA+9tnD4NX/hRrZjCSRndCqlopblo0/m3u0cgnCK4hLNdMxY0rOGWtAy/8QMBzGVlp3VdhDfkJ6YOVSRvhB78CJ18KR3v0bijIvR5Ew1ZZuGC1fURbuqwgFqjsuyO+xiyt7F3EIbnWnKtEcIeLgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4sXsNZiAHdZfIQTRNhv3Ac8y9x8Fq6rv674yoPyEqU=;
 b=k6Mb4wS/VLaocjV6z5C47IXDMoMvEWcwifIET06fIVm62urPogBfpxE/XUaKz/ko91ZwSjo+xFGol+f2la5CeroRr6VM72SuRRrj0hGnkqoJhSYaTZNEm6VGF28mRaEICMFvFys/Gf6lYBLs4ac86Z1pz1heOozRxxQildQ3o0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU7PR04MB11188.eurprd04.prod.outlook.com (2603:10a6:10:5b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 14:19:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:19:39 +0000
Message-ID: <b3df67bb-dcb0-48cd-94d9-31d5e82849e4@cherry.de>
Date: Mon, 15 Sep 2025 16:19:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [docs] [PATCH 2/2] doc/conf.py: get current
 version from env
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
 <20250915-fix-switchers-js-v1-2-523ef53fe802@bootlin.com>
 <049595e6-2dc2-437e-b0ab-322f6b943b7f@cherry.de>
 <DCTFDO5WYLXJ.3N9UZ6MKHGPZ2@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DCTFDO5WYLXJ.3N9UZ6MKHGPZ2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU7PR04MB11188:EE_
X-MS-Office365-Filtering-Correlation-Id: 338f22a5-1113-4d30-7e16-08ddf462e7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OGtuR2NrVmowclJqTDBLdGluODF3d3NpYW5EZXEvTFFGRU40WWpOZWxJUnVL?=
 =?utf-8?B?dTkxOVlDYVZFaVFTQk10VWpxQ1VyMXlYaTFYQ2ZmcXVybUc3bW5EK0NEU1Vp?=
 =?utf-8?B?UWZnbld5Wkl4S2ZBY2RGaXhGWVZwSDJRcU1kbkp6Y0F6K3dsWmVEbnpDT0hl?=
 =?utf-8?B?OVM2M0w0ZDF1Z1FhWE5wZFcxQkpJcFBuYVFPQmZDcUlkai82Umxmc2kxQXVh?=
 =?utf-8?B?eHEvelFscktMTFBsZE9iU1hIeXJHNVZqbUZmUWJ3QldvemJxWUYxdXBRMUtK?=
 =?utf-8?B?K3N0VDRMRm1MNk1iOEg1L005N2xLL2RNeVJmZ0NiUmpOOWUwU0VBbXRsNVJn?=
 =?utf-8?B?STFqTEhpMXNEN2FMZDFjMDlsT2lndTFTZjZwOEIrNTFHOHRaTk45RmJmLzhN?=
 =?utf-8?B?QnBnc2I0WFVJbDJ2bkMxS2dJWW9yYzAvakdML1ZsbE9iVW04L21ERUluT21D?=
 =?utf-8?B?djdBdXkvZ0RYTmFHdVVtMTZ3U0lsY3dXMXh4d00zNm5hcjVXazF4Vk81U0c0?=
 =?utf-8?B?STFyM3BjSUQ0cXh5UFdzbEtqODdEenZUeUFSNG8veWlUejU2bW5SNmwrcDhV?=
 =?utf-8?B?MXBnV29vQW5wRkIrTXZveDNRWnpjRHc5R05ycHJ2dVFqUEZuQzVWQXR6NzMv?=
 =?utf-8?B?b3c5M3lIT0Frcks4aXR5ZGJETXphMjFhdnZ4OEpGYnc5YXlLRGU5Q1VJUGh0?=
 =?utf-8?B?SExROHJQSTNoOElPZFJjSEFyR1orUnF3STBSd3UxM1VjZk44Y29LODZYdHly?=
 =?utf-8?B?S25KTThEWUZWK2RQSnk0RThTc1FKemlJVHQ4TnhjNjMzUXVEWFZwQXhPeEhP?=
 =?utf-8?B?TmRkdmdoWFI3dTVVWE9mV3lyNmpQKzBjb1VXVFJPWk9NQSt4US8yRGdmS0xK?=
 =?utf-8?B?WFRreCtsS3VUbC9WQU0yT1EyeFpPVVFsZUtuNDlBUmJQNFdldnpOZm1GdzJG?=
 =?utf-8?B?ZDQ2aE5HQUJveXg3aVFOZlErcEJ6WE9OQllsZGxsWlJIRFJuUWVzZUc2d2pm?=
 =?utf-8?B?WG5lK0p5WTNkS0dpMkVHUjVteWVSaFdBQThxejhwVHYrOHhNdVpGWHpieC9O?=
 =?utf-8?B?YXh2U0FZSTc2Ujg0MEdnZHpPNDBxaEpURC82d1lhVWhMbmVUei9JMnBUNGwv?=
 =?utf-8?B?NldQZU5HT2IzVUVUMVZTOTYyMnRHblIxOUUxU092Z0V1dDRzelRPM2xPZVYz?=
 =?utf-8?B?RktSZFpOUmZiT3BRM1FNbXoycVFibG5IVy9RNTI1MnRyOHh4Q21mKzZ1UjZD?=
 =?utf-8?B?NmlyU0k3b1YyMzIvRW5LQkFTYmxtUmlLaTcwSllYNU9QKzdUa0MzeDg5Unk2?=
 =?utf-8?B?WjFBcHlDTmNScjNGOG5HWlFiRHBST2hQUVkvVnRJZWl5aVM2WUtybWo3djVp?=
 =?utf-8?B?b1AwTVN3TGFjem43VEVGQmRYdi96OFNWQ1VVU0RvQ2crWkZUa0JKTkE0NDBC?=
 =?utf-8?B?QlRPdWFsM1k3NkQ0Q3NWTm4yeU5TYW1OREFDQS9oc3lXUnh4VEphME91KzdL?=
 =?utf-8?B?Qk54amw3RllWZXF2NmxBTEtSU01MNjdKV0JnOWV2ZVo3RUlHQ1BtWE1DQnJr?=
 =?utf-8?B?a2RGVUUwUnBMa0oyMFlhQSs5OWtsNUplb2M1VGtiSlI1U0NiUGhRd1g4Y2tB?=
 =?utf-8?B?T2VlSlFJdHB1U1Q1WlhFSVJFWGtGU0tvWk1sRWNFODhZUWdYK1A2STFENUxU?=
 =?utf-8?B?WVlDNElueGV2OStlb2lKQmVKUzhFWHQ4Q3ZobmpSZXhvVVFWcmd6em9TbGNE?=
 =?utf-8?B?Yk5ZZHFUMkVtTk1kZ282ak11SjkvOTFYNzFpRHJQVGlBNW5Ja3ViSUxvM05i?=
 =?utf-8?Q?RFSAmXb0DCb8EBVsL+2dgkxxXP22BkhonzgGE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTB3MnNwRCtSNTZ2dG92MnJZMHgreFF3TjRNWC9SakhPZTI4Ty8vclk5T3Nq?=
 =?utf-8?B?RXNjQ0J5ZDZMTTZOdGVvbnJNQVFGMGlKV0pjdEpWMFdEdVpaYXg3V0MzdWJo?=
 =?utf-8?B?SjY3Q2NieHl1R1ZJVTdtUlVLZ1czbVJPOWVwNUEzQ1A2Z2MvMS9SQWhHTzlw?=
 =?utf-8?B?Y2FleFllVHV3aWt0YkRGdCtGQnlPTGh0bHNWVWg2VWhYYWhuZG9nRVRieUc5?=
 =?utf-8?B?SDZIa3c2K2ZORTJweWJNYU83QVowQVJWaUMzVWowblp0TEM3RDlFbms5c2l2?=
 =?utf-8?B?QUZ3WXBtQWZIZWZ3VGVJYm5LN3VhUDlqS1N3QU9ZQ0hMdGhwVzlWUG1leHR6?=
 =?utf-8?B?QjJDcDlnUUNNbGR2OTlBbWk1WEhpYVZ6bmJad2hwS2svWXJ1cHlZVWF5dGVM?=
 =?utf-8?B?dzF3VUgwcCtKNnQ5WlBPSEJxSzVjUkM3a1h6OG42VlF5Vi9rSS9QR0tqZ0JZ?=
 =?utf-8?B?OEQreFN4TzRHdEZNYk5Kc2VHSFJWK2FSUW5HdUlCTUs4LzloaVlGUG1CZ0N4?=
 =?utf-8?B?bzJSdTgyck91bmFqVVY0dFRIUFNwd0R3Wjg5Nm5vWHFlMkhidmg4NzVBU24x?=
 =?utf-8?B?RUxEaFhvQ045WHJ6elplL2tkeS9FVGwvalY2Z3BMck8wb0pML1NVazBBSWhk?=
 =?utf-8?B?bTUwSmVBSk5QeGpaUC93TEdNQzYveVA0MTBCVzBHWHNkK2xyci9nWUt2cFVT?=
 =?utf-8?B?U0NGeFcyZ09UMmJCZHpUdTRPbTZydkZmaUxMc3hlRWFtVUpqUEgvbmhCRXQr?=
 =?utf-8?B?ejRnOG1VblhGUFNWc0pHdXFRbWJRMHhpYVJwNFBERU5HcWZvVEZiN1djNHRw?=
 =?utf-8?B?L2FlUnhWZVNZdDBSaFZRK2tNZFBVenVsZXRObXZrU0luems1ZWUyUUxxeTBV?=
 =?utf-8?B?dzMzcittWHptYVllL2tZQkhTM3JYV3p4R0VJMXA3amI5WFpNTHFBN3kvcklI?=
 =?utf-8?B?R09xTE1QMXFjOWVmL3dLZWNNZGt2Yk9GQTVJTVovUnpROEpmbVV3TzkxRVJX?=
 =?utf-8?B?a2Z1dXhEY3J1WmR0ZXlQSi9ENE84WmZJT0tFWFFUWHpJeVFQK2V2RUtzY1BI?=
 =?utf-8?B?ZCtlUnVzWEJoRzArbFJPMlVZRHRjWWtlQ1NNcHpZRDYrSUFxRVFBZHk1OWRI?=
 =?utf-8?B?WkcwRHY2YXJpMzhUOWluSEk2ZmQ1YmVxOVlTejh1dHcxVXpYRVh6UXZ0QU9w?=
 =?utf-8?B?dUowSXV1S1E2N25xYlhjN0lVZWVHQ2M0WjMzNWY3OVM3VDRSTEJ6akM1U29E?=
 =?utf-8?B?UFA4NjAzNmVnWnhVTHpCS2dJenVTdm0vYUNJYkZRdUhyc2dzRzFVS1RWc0tP?=
 =?utf-8?B?U0hBZXlSNUJHVy9yb3ZCeDBsNkdUaHg3SFM4OGQ1S3FPeHdJNWRveXJQN01k?=
 =?utf-8?B?L2U3Zko3eitCcWJ3dmVNd2xXbG9qSGU0RERnenhObXZseFk3cnVpZU9OOEVr?=
 =?utf-8?B?UVFSVE1VbnlCNFJlakpETkN6TGZVR0s2ZU4zVmxoRGE1N3Y1UzNWS1ZDSllG?=
 =?utf-8?B?NHJRV3A3akhIMnhsbkhyNGhVdjNCelU2VlVZWHhJOHczWlV1Zi9XekpPK2Jl?=
 =?utf-8?B?RUVjUjVSc1lOa091VU5aaEdRdk5DS083Smhpc0xMTXFER3NrbWErMmFocTlR?=
 =?utf-8?B?MHpnMEFNT09TcTBpVDFlRDFrc3FGaDdGcThWV3A3NG1GRFhrOXNTT1ArdThv?=
 =?utf-8?B?cFFEYWpiSFYyRFhlNXlnMFp2bWpjRHMzUVlieS83U2lUaEc1enYreUpLTGhv?=
 =?utf-8?B?QnJxcS83TmRZa1NCZ2d1cGxHQTYxL2J1MlQxMFhwS3duelJlZGRTOXBhT09F?=
 =?utf-8?B?T2xNTEVnT3kwNG9LT0hjWjZaLzFRaFB5NXAzZUdUenQrK2ZkRHdIeXdUbWxM?=
 =?utf-8?B?MGY1NTFMamhSVUM1R0phNmdiQ2hydVhpS0M5UWtSRFg1T1M5T05DU2hFUE5S?=
 =?utf-8?B?YlUrZjRxVGdENjFhTVRhZXl1VVVpcDlsRFJCMXFoSEM5cTRZblhWUVN5TzUx?=
 =?utf-8?B?M0l4MVpxTnRvbVFvWXF4MjVkNXluaWlXbzd4djNUanpnT0RZaFZUWlZ5WmRZ?=
 =?utf-8?B?aDlwcDFZU3J6TmtScitpYTFaTnNsbEZQM0E5QTZ6NWR0VTJiMXZGK2dMcDFU?=
 =?utf-8?B?U0tPZkNhb0plL1pNc1Qyenk2VEwyd3NlR3dieWZiejRQb3NpQjZMSU55MHpw?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f22a5-1113-4d30-7e16-08ddf462e7d2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:19:39.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM2pAKpmE4dwwQ5Nc01kIu1yNuUreUU6X/KHd1uq8ykvg/UQCNKzkPJEGsQjst3guZcSEGzgCeFc6BhIZ8fNrYSoLc7TDngwnZiSohh9ack=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11188
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 14:19:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18030

Hi Antonin,

On 9/15/25 3:57 PM, Antonin Godard wrote:
> On Mon Sep 15, 2025 at 3:24 PM CEST, Quentin Schulz via lists.openembedded.org wrote:
>> Hi Antonin,
>>
>> On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
>>> The Autobuilder can also give this information from the run-docs-build
>>> script. Fallback on "dev" if we can't find the information, so we can
>>> still build.
>>>
>>
>> How about following the exact same mechanism as on yocto-docs?
>>
>> Read this info from poky.yaml file which is automatically generated by
>> set_versions.py?
> 
> The idea was to maintain the active releases in one location (yocto-docs), thus

Having a OE component depend on a YP component isn't usually the things 
are done in both projects though, rather the opposite.

Add a comment in yocto-docs's set_versions.py that one needs to update 
BitBake's as well? I'm not sure having to patch BitBake docs once every 
6 months requires to add such dependency between both projects? If 
set_versions.py are close enough in their git context, you could even 
send the patch to both mailing list and apply the same patch in both 
repos at the same time (though I just realized writing this that 
maintainers of BB aren't the same as YP-docs :) ).

> the idea behind this variable. This information is stored here:
> 
> https://git.yoctoproject.org/yocto-docs/tree/documentation/set_versions.py#n29
> 
> How would having an auto-generated poky.yaml.in file fit into that? I can
> generate a poky.yaml from set_versions.py here using BITBAKE_CURRENT_RELEASE,
> but I don't see any advantages to it - unless I'm misunderstanding.
> 

I would avoid the need for BITBAKE_CURRENT_RELEASE environment variable 
which is currently set from set_versions.py from YP-docs. I guess it 
could be acceptable if somehow the build system of BitBake docs provides 
this info?

Cheers,
Quentin

