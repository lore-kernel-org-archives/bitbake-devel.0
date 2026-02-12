Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B8DEB4901
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 11:12:24 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43200.1770894730610047931
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 03:12:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=fiAYvxQP;
 spf=pass (domain: cherry.de, ip: 52.101.83.55, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxEKuL+UepZROV53AT8Tt18Hd8sAlpjls54RmstHbfBHeU7aXPzEwKW0Slp/O7EfMHB4NbAkYw8CSNZlgZXDkqX8EMjlbRlfrDnw7i1+G97NU84AZElOledNV62COF/k5OKnzdd3NsCnWzf8IQkBSqbJTePbBgSjyH/wPg4M+1IfDnFXdDiNQLuFo24unPlHNiadk6VP3aiR9KK6zsVquY4qrRwVybPcwDYR5UD2xj2Nia9aa1PboD/caEADkQfsPBj6Dl8oeKqHmwJUBJPLlSuzvBrNJy+QMJLXXEF+wfh1A8QKjGfEtVSxzZ23G6sZT2K5dbV7/DAxhcXDILedqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjR+AmRju1lId5V+gEjSazI3ZQe+XXOcic49KqfLVvE=;
 b=qyG+bY1uBXZC9ZlAmw45OQOm4c1Ni71XCTXPNNT3WJfP1xd2JbkAO4R+lCzuBUbdj91wshrwzBDtyiOH6FtISd7hnJRgKD+WQi5qnH48AAimPRe27o0anE6H+vNX6yzxM8upRVZLznqV/xZ1ypfMPwvX9xKHiU8ZkjXVCXNYWJgXY7EgQUtjDcVKB//LdV9BrVApQr9jG1bm9GGbFP/DGthYdzmr+3eDQ1JGfTOIbMQ7qTOxNmw0Pr2DRrw03Srm6ySq1kyuCdgVyB6F5e7sT9fX9yQ7m+XR4HXylziQAV2LXVDoc65JHCD02UuWQKCbmOMSaM6LNzd1IyjaHRU9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjR+AmRju1lId5V+gEjSazI3ZQe+XXOcic49KqfLVvE=;
 b=fiAYvxQP9JAnY34xIKR61H/JNZUNxX0wRG9wWqvnV0ksCXnwGj+PxZm+OT5oNRtwRcZv7StzYQ7E4yRBAPjfHm3Oz/xIeApgsmp26m3LgoSioSVySfbavh6ovrYIpz+0uRvxsAdW4f/50B4/3M/iBKtCZiZc1vI+Bcc+7xWvjaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 11:12:04 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 11:12:04 +0000
Message-ID: <286bfe0e-160c-4b6e-8900-ab821592da86@cherry.de>
Date: Thu, 12 Feb 2026 12:12:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH 1/4] doc: bitbake-user-manual-ref-variables:
 clarify BBMASK directory matching
To: Antonin Godard <antonin.godard@bootlin.com>, foss@0leil.net,
 bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
 <20260211-bbmask-slashes-v1-1-b72161c647ef@cherry.de>
 <DGCUREOACEVG.3QW902HRYGH28@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DGCUREOACEVG.3QW902HRYGH28@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ff1ec4-28e1-4a5b-fffb-08de6a278dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y2Z3MGVhQ2lxZ054b0xzR1ArY0FoNVBtWjAraXVFdTJjVWZjN1M5dGVvZExH?=
 =?utf-8?B?Zm9FZER1WHZKaVJvdW5QTlBBQUtCQ0V3VXd0WHdJWHlNTzR6MFJqSGI2UWJ6?=
 =?utf-8?B?ejZZZ2ZleXZSL0JjbVY3SVBhZXVYZk5aMlVEdW1PTXdEMlhxRDIzRXlBVURu?=
 =?utf-8?B?bEZQTmd1Q2phd214QS9MNkh0RnQ3WWk4cWU4ZkVVNEl2bitTUElHWTFodzc3?=
 =?utf-8?B?TlJUcnJvQllmeVhVQVRZK1QrLzJyZmI5OFpSdjZ0ZGhhd2g4RmtWR1JlMXZU?=
 =?utf-8?B?YmdPV0RUVC8xMEJlMUdDem5xbytFUWhQRk1KY0tmNk1Ga24rWkRKbUZuWm9u?=
 =?utf-8?B?eDF1M0VSdlkrWmRydGxOUHlTZExla2laL3hCQlpybXJ5V1J1d2lScWt2OXZQ?=
 =?utf-8?B?bEJXRW9jOWVSRVRQZWdZV081TGh6L0VOSkNCZWZoKzB3QUx6c2MvSkN5TzdP?=
 =?utf-8?B?SUJiaTJ3cFJKaE1IOFB3WE4rcmhmM0N2ZjQwZFB1RkdkdjYwMXhWUnNPdnBa?=
 =?utf-8?B?akJNbEJHYWJkOFdFZG1UM05MVDd5Z0VUYS9QK2l2enVONVUzQ2MrbXlOMm44?=
 =?utf-8?B?Ni9LTGdCM3F2TGErdmgxd3JHTlNUdm9IYVdDOTd5U3hTQnE2TldHTFJSV2w2?=
 =?utf-8?B?ZGR3UTkzT0FlcS9sd3RkYXRRU0FkbUhVUEVUa0ZpeWt5UWtQKzJnU3lwRTFn?=
 =?utf-8?B?clAveDhyWXAxUWU1WW5sTXc0NEw0Sk14dER4clVhUlZaQ3JmM29DZFBVM3la?=
 =?utf-8?B?ZkhNbjNaRUNXNnp4SzNUdFVXYXRCWTY0R2xWYlVUbkhHSWZyeklFT1dkOGNs?=
 =?utf-8?B?aUkrYWlpUjdwd2tqb1JYMlgzOWE2eW1FM1gwRnl6WTY1djUyWTZYb3FzSkx1?=
 =?utf-8?B?VndoREtqeHBnZmM1SHVWdktrTm5JT0xYdm5aQ1I5L1M0Q21hTldjNFp2WHg0?=
 =?utf-8?B?WDNpMUlsK29aai9XWlFuSTYzYzRpZWZaVkVBTWdBdjFCMXVQZmRvMW8yM0Nw?=
 =?utf-8?B?V0NVVUFnelo3TTFWd21Ga21CRWYwUkphT2xJd3VsZllnZGlaTkthUldkWVZM?=
 =?utf-8?B?dkRiTzRYYzRGWXU3blJUb0hYd1FIeHFGSHRBZndHdGp1cGY4dmx3akJiTk1t?=
 =?utf-8?B?ZkZVbWNFdGU4MFFpRjJEaGtHL3htbnZJTDZPbndEY09YeC93QTQzQmxEMlJQ?=
 =?utf-8?B?Z0crK2RFcVlkV2ZHdytPSzF2OG5JSyt6N3hvYWdHMVR4OS9zQWwvTkR0by9T?=
 =?utf-8?B?VzFPUEtBZUo3S2dtclQ1aks1YXprNG9sOEd2MlNpWi8wYW5NcGwvb28wM0My?=
 =?utf-8?B?TnROV3JjMjVQaVpjcjZSTmVDU2pKVnlVR1M3d2daUnNvOFFiYVArSXVmSjBI?=
 =?utf-8?B?K2crbEVibVdPUlhvRk5nL1pOUEdvdmNkaFNnNUM1WHIvd0JkOVZ3aURBOHI1?=
 =?utf-8?B?U2FkZHQ1NXltVkljN3gzVzlmekNxODNwNWFsUUFCaWNReW1GZVgxelJzbWtD?=
 =?utf-8?B?MHVRMDZmcDc3TStxbXFRMzIvTmx1VDJ3QjVSM2krOFBEZUVGQXZKb3ZGRDZr?=
 =?utf-8?B?Ri9IK3UzYjZWWlNGVHp4UWdseXZQNm5PRU0xY0hVQzJ6WVRlWXl5VEtraGpM?=
 =?utf-8?B?bXdmeU1WNkF1MkVwN2piOXRjWTJQaWRXazVVVy9uWXlaMmlma2laRFhYaVlx?=
 =?utf-8?B?b3laSk9wY05DUU9FV2hZVHlVNXozMjZrZFhxNnV4dHNmVFUzLzZ6QytFanRV?=
 =?utf-8?B?QkJ0dHBuZzhTS0NSeW9YSDYxamZzUlJIdnhHeGFDWm1XTnNqbE1PY1hzWmVy?=
 =?utf-8?B?all5TzlPdzNwa1NaWk9QMVZUZno4Z0tFczE4NmxMMHR5eU00YVVpSjhiTFhr?=
 =?utf-8?B?SS94dGJlbTNodGU5REdJSUxlR3JqVTZyd21nQkRKc3NWcTEyTHdRMzlVUFdv?=
 =?utf-8?B?S1llN2dlcWplMzhCeUkxMnUzUHFvd2gzZTFuTkRYdnc5Vkg3VkNmcmdCVU0x?=
 =?utf-8?B?YVVUYVB0dWE1MTdUTUFCU1JZNlhjUEs5THROTFlHTlRFdEk0YkpBbzNXckN6?=
 =?utf-8?B?VWp3VEkzeVFkb2c5ZVM2dkpGTG80NXNOaUZmSUhOOW9kUnNTejNhVzdYQWZH?=
 =?utf-8?Q?l4LM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmNaVGY1cUZ3QmEzZFFQWmJIS09WbnFGSTUxZEhNTldrSFA4OWUxTFo4SXVp?=
 =?utf-8?B?OGswakJpQjg0ZEFhaGNiMG11YnEveGR1ajBBejZLVHE2V0YwSkpQVURtV21U?=
 =?utf-8?B?bFUwRGhobVkrYjFQTW01eUJ4bzJGNnlsdUFqQXVIelgwYnZsS2VOYnV3WW9E?=
 =?utf-8?B?VHBOdnE4SGZCMitZbnpzZkQyeG5lVHY5c1pRQk5SS21Na1ZiKytOb25SaGdD?=
 =?utf-8?B?cGloaVJlMTRTMktzRXVnZW0rQ3pGczcrd0VqSzlvYzZCZ2ZLU0JQU1VaYWhM?=
 =?utf-8?B?bTZ5QTUwQkhvUWdEZjlGa0dCQXU5NUFiRmlnZkxIRE5rNmhLLzZwRG9SYTVT?=
 =?utf-8?B?Y3V5bm1nOGk2SFZyZkVGRnVqYi9UVk5EbUM5bG95RmR6bHlLTlVpS1gvMkE4?=
 =?utf-8?B?OUhTZXRBQk81MTZUZ3N4UE1TazlkUEZBMWlHcWRIZkxtZlZCRWQvNFVOTlRO?=
 =?utf-8?B?c3JoNENOZUtWRUNpNUM4Q3JycmF0WlRCNkhyL0NYTkxjVGwwM3ovS0pHK2lh?=
 =?utf-8?B?Q2gzM08rVFcwNmJ2V1BBL0VIcjRSTTNURVBDa1dqZXQ5NEFmanowL2hxZ2ZV?=
 =?utf-8?B?MHE5NlpRZ3JhU3J6Q1BQaXBzUFNoT1kyY3ZZS09jRytOenNsSTFFd3NnWXlU?=
 =?utf-8?B?S3NYVFFDd2xDYktRdXErVkwrRmt1d09YWTVNOEZER2JUUXBOU3R5ODh6TGo4?=
 =?utf-8?B?RXVnbmNWcEZvSVJleDcrSy9RTGtySnNnZVhnSWtOWUlRR0RLaTZwbDdSd0x0?=
 =?utf-8?B?enVoek1BU2MyZ0RSUGhiZVA2SWU5OFR1U2xyV1Y4WC9ZM092T3dtNFNRRzF1?=
 =?utf-8?B?SmVRL0RzSExjYkgzVTNnc2ZLZm53b3lsK2hZWVBjQmhaRURpcDdWUFhNWjkz?=
 =?utf-8?B?eFBzZFJwTmY3aFZCN0Jhajl6Ri9qUm1KbUpDSlNOWmNvK1BjWittL01iSk5s?=
 =?utf-8?B?SXRleGNCaFozbTJVZVA3dDlmVysxUFFFeEZTMEk0TXhndENNeWw5RTN5TnhS?=
 =?utf-8?B?SnpaZC9pUEdWMy9yRzgrOW0waE4yOUpIaUozSWFOMUtsaXVaKzZVZkFXa0Zl?=
 =?utf-8?B?NlYwMlM3Rmt4YVAzeHgvVnBtcWNHNmx4dzFpZVZCci9QRjQySmlPd0d5dUhr?=
 =?utf-8?B?YjNUbjFFVlUyVURhTHZkZUVxeitiMDJVMVBYR3FxNWpicmNNUW52UVJEclhh?=
 =?utf-8?B?OER2K3o2TkN2ODZENExXVkR4cTVxWXIweks1YitpcS9CZ3RZQ2sxSnY1TDRw?=
 =?utf-8?B?eHVaYS93Snl5VjlnZHk3QkZ2ZG9YclVYbHU3ZjJzTkxaU3BjaUoxQ3dIdy8w?=
 =?utf-8?B?b3d0R2FGdjdFbU5uaHBxdFhvdzd0V0piK2c0Q0ZhZlU4eExpeGYwT1VEVm1u?=
 =?utf-8?B?ZUptTmx4aWV1aHFCU3FRSEpvZ2tWUGpaTXAxcTNqSDQ4OXFSbVBMWHVaRXQx?=
 =?utf-8?B?aFBubDVBL2V0aUNFd1plUjNjZER1THJ3bWpTb2VKcGd1MlhCVXE1elJ5cHpv?=
 =?utf-8?B?TUJLeGFZM1FVTjgyM0hZSndmbS9KK0ZPNGs0S283dDNSdktGVnRXdkY3bHRk?=
 =?utf-8?B?d01QOVhoQ1pyc3JLYlI2SmlKWjh5Y0EzRkFRMHU5Z0RleXR4c25iRVQvZ3BZ?=
 =?utf-8?B?eThwcDB4UHRDMmRyZDcvK3BaYmxBRUNKUkp1Z2VsVVdQWjhhUlhQdEMvVE9Y?=
 =?utf-8?B?QmZZeE5GRlNlU2dvZ01TL2ZVQ2FxUXB1dGdRdGdHanJPaG5XT1ZCTDB1Zmhk?=
 =?utf-8?B?SVhBdmRiaHRudFpoaVhXRjFmeEV4SjhRbVVFdlBaa0o2bHYzLzM0ZDBjL1V3?=
 =?utf-8?B?NVUxcVBTK201U3l2K25GRFZtVnJxU2VpRFZtUmxHR2ZuMDE5NUgrdXFaVUhU?=
 =?utf-8?B?c1R1R0MrcjJZWTNjOW41bDB0U2l0VjlOcEVsU25hWEMrbTAzenp4anRZblNx?=
 =?utf-8?B?ejIxQlJsY3dQZTBLaUVSZGp4bTV0R0lsalVwaG5SSlJWUlpvSXpZY3UrdmY5?=
 =?utf-8?B?cklBaTdreVpYWjhkSGY2L0xNUnZYTGU0ZjRERGdDVFRkM3pERUxia0szd1FP?=
 =?utf-8?B?QXhDaUYray9OZlFNUFptUTZBMHI3YnRsRmhmd1duRFlNbDY5LzIzV05nbWFY?=
 =?utf-8?B?eEcvbGNSVktzb3FYUDhtTTRla015aGpwMWdhZ0Z2eG9ORFVMR2xic3A2Snd4?=
 =?utf-8?B?TTRjcmxtN3VzU21OekVwcGVseTV3cWdPb3h2SGN0MTZkYjNVRHEwNUhaaHYr?=
 =?utf-8?B?NWxHbnl0eFhhd0xWeWdGcWNHWDdwdnB5MHJwR3BUZUF1WU5HS0pLbjJ5eW95?=
 =?utf-8?B?bmtyelAzSXNqakpTVWlXTmpzSlV4cWR3WjRGQmttUTNwVWpRNFlELzAyYkhq?=
 =?utf-8?Q?PwmDHnciK7vDC+Xlx/i1zmQ0kMqDilpTnvkWu?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ff1ec4-28e1-4a5b-fffb-08de6a278dab
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 11:12:04.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8ptkrnYBDIwtJFMRb5dDxm3EEypaBQyNsQwSGIR/OEtR5M9anbZP1gq2R7+2MOGIPEIk9Naox2Bp6zmP9g3bz1OVKedXuTcVV7tRj+3yyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 11:12:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19016

Hi Antonin,

On 2/12/26 9:49 AM, Antonin Godard wrote:
> Hi,
> 
> On Wed Feb 11, 2026 at 7:06 PM CET, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> BBMASK matches files in the directories matching the regex, and also in
>> their respective subdirectories, so make that clear in the wording
>> leading to the example.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index 4b3b10d46..18bbd638d 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -1051,8 +1051,8 @@ overview of their function and contents.
>>         documentation at http://docs.python.org/3/library/re.html.
>>   
>>         The following example uses a complete regular expression to tell
>> -      BitBake to ignore all recipe and recipe append files in the
>> -      ``meta-ti/recipes-misc/`` directory::
>> +      BitBake to ignore all recipe and recipe append files in
>> +      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
> 
> If I follow: this will mask multiple occurrences "meta-ti/recipes-misc/". How
> could there be more than one in practice? How could this ever happen?
> 

It's simply a path. There are no rules as to which layer can be named 
something. It also doesn't have to match a layer if the directory has 
meta in the name (meta-ti isn't a layer for example). There are no 
naming rules for where to put your recipes. You could very much have 
BBFILES with ${LAYERDIR}/appends-for-meta-ti/recipes-misc/*.bbappend for 
example.

FYI, there are two meta-rockchip layers in the wild. One maintained by 
Rockchip themselves, one maintained by Trevor. So it's not 
**impossible** (both share the same BBFILE_COLLECTIONS so you won't be 
able to have both included if I'm not mistaken, so that doesn't really 
apply here).

Also, I have written a meta-bsp layer in my vendor meta-cherry-es git 
repo, I'm probably not the only one having done that. What matters is 
that there's no BBFILE_COLLECTIONS name clash I think?

I hope this is better explained starting patch 3?

> Wouldn't:
> 
> """
> The following example uses a complete regular expression to tell
> BitBake to ignore all recipe and recipe append files in the
> ``meta-ti/recipes-misc/`` directory and its subdirectories::
> """
> 
> be less confusing?
> 

It's factually incorrect.

Cheers,
Quentin

