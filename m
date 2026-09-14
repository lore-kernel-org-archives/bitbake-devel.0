Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93405C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 15:21:57 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.222.1789399313973129604
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 08:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=coQt0B0p;
 spf=pass (domain: cherry.de, ip: 52.101.70.71, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWaiWJLqhk8XFk6sIILphxdTvnzHogdii+zW7aKki1a8PQcYkKJ9HV7MmO702p9W/32zth/tmit2m7Bgr9M3m0MuWy5S/9B/FKcqDSgkDRSdEULR0PAariUAI1c7Gl2xMRdYTxQ/SRsBp6J+8kA/xyd0F966fnxyBA2ngpq5VQ9JG2lERMBs/qvqzuFFheVDVdZsDSyBZ9qHtnVoL2wWGeU/iwV/si3z99dt6G+5O/Jx58Vz4JLaEnFbjbWDppMfSA8OIlJAfbT7cv3teEz8uMUxI73N1mJ1cZ+1ZqfVpLRaHiA+rOl93C3ox8Qk9XuxymrQ9+bS0YmFJUD97AoH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otFE/+XqgKf65/XFyvkqJ1ERNjJ8zq/tBu37YnzAyYY=;
 b=GvnFyiM5kqS18m7fFiaw1lner1FwN8jY0e1LrsOhadpBecLVsZreKlbQ3V7FXSmnTk87+iHZ+bpeF4yXogpkgfBEaH0Yakr6Em0Fh0qri2fQvuxGulXu4Ul3AZCyTiQaHYby0o8waPXrCgymqngGRAIBryZRAu5GcgXV9TxqEE+y54CDxKwXG4pJR6sS8gmSPxpJ+k51YX5zGj91Ex7UceL0+yM8UJ0i0k7+3rJSSzvuIsHkWila9gKIYjzSJJ7cpLNlbkekbD7l5qVTXHmGk8+ITh0Wgxljzl4CziUI+fjg7t1yknXhs9FQZckdZKasT/5JrLTgKq2vducxOW277w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otFE/+XqgKf65/XFyvkqJ1ERNjJ8zq/tBu37YnzAyYY=;
 b=coQt0B0pv8IBYYu8sqVjCnlC/FABQB5mFBh0vmNF40iDaYOdxOJB+izqVubKcKIdCFUKe1GKRrrcvTxDJtRZQAMlfPJCET0oTuFdODpq103l7tRHWNIjPIs7B27GUUDziSVH2US2e/ctdGMhWx3GM1CB4d1av648GLgp4661XVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA1PR04MB11508.eurprd04.prod.outlook.com (2603:10a6:102:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:21:48 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:21:48 +0000
Message-ID: <d8eedd54-51b2-4d71-a8c8-4dabe0437c63@cherry.de>
Date: Mon, 14 Sep 2026 17:21:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH v2 1/4] lib: rename fetch2 as fetch; invert compat
 shim to make bb.fetch2 = bb.fetch
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20260828162612.753815-1-chris.laplante@agilent.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260828162612.753815-1-chris.laplante@agilent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0094.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::9) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA1PR04MB11508:EE_
X-MS-Office365-Filtering-Correlation-Id: bd96c8cd-0ea1-40fe-c690-08df1273e508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	P1Y390fA7tkSzowk1Yx2fMeQWz1rZw6k2QD6OEVEvG7cIyZBpb7V2Kg8yIBJ1sKHoSgt16hcVLcesZsyJOFqLixhcW2RWLAPWc4+W4S3OVVi9VOXqQj2XQV2RDPA+BAAfmeFws/nf732NyV/rVACuoczREK27DjxkYYWXuR8kUbRBXdFgIcDXJopkpEzRj2hfmYy5XaHxQsIWXn5okExbjfaVV0xAH4opaZm+3aW1fc3K/O5zF9BMMf+L9pEXGQREWmCizjgN6STU3+5mhutgp5LxGTX12UZ3py8ZXefsVLZ57GaOQ+T7DwTE76GT66sTed+jia9mtUa6Cwvhgne4Oi+r7Swu2+1GKvuBbpla84/2fBZSvwQqFUixU7hALXckoxHHHdkfUT/0xSXRlVQQFanZLV7D83QzHDBsltppJVWL4ENx4Xk5sIgGjza4SGqF96/zta4JyiUsnJ76D/SZPRu/qmwk8pLGsY5BMit9DD5QdHa0I7lLf1kXJ7ijlCnxwJCDXGqMExjOWPszbIWBmMyAOwAHlUJ8U/ReNfy1XGC8eogFzmkz6jfS/Hn4Hojts76cDUrFEmiGFyJMx7OPua7cYV5Xn49V2VFlAAB3JO2/X0cfqb61Aev2f4UfBCycmkGhUY0hKgeV+GnHpVtHLfaXwQgSmI8z9uieOZ5V5A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEtVYXAvMVFhRFFWd1UzWHRnWVVRQ2dqNkdkSmVleThtWHg4bGV2L1FTNDd5?=
 =?utf-8?B?MkV3YjYzVkNZbFhCUEh5NllyQVdyZFZLWnJMbGFHWlk5b0YvRk1qbzltU3V5?=
 =?utf-8?B?dTNnOUI2NTlIT1V6M0tReDZ3a3B1cGF0cWVrU0s5TWVtWUxvZDdhcmprbWcz?=
 =?utf-8?B?S0RoQWRqVzJodmtJcWRDOVJERG5IWkdYLy8yd1lVbExweFJVS1p1ZWVPUEFh?=
 =?utf-8?B?eHd6WS9TbWJIb3YwUlNNR0NNa3JLR1pYMVh1Ry93YnJxNjFTUnhPNFFCVE05?=
 =?utf-8?B?aFlJcVRaaEYvUTNWSFkrMnJxUjlLeExJYVFzbG5CNDNWNlp1R1BCU3JXSHRs?=
 =?utf-8?B?QmkrU3pDK3I3VDBZa3B6SS9XUWpqNTV5UTRPZE4xQzZsNXJLYWRaZTFyd3hX?=
 =?utf-8?B?RGx4Mk1zM05VMDllVGxxaklYKzZqczNQNDlLU01IQktRenhjQmNGYWhxRnQ3?=
 =?utf-8?B?Q1lPQnE0dW56c2Y0QmtDaXBQZjE5dUEvdE9ZRHpMS0xVTFJmYzR6MTYzVWlF?=
 =?utf-8?B?dGYvcndaUEUyQit0QTA5M1ByS01OV0NYY0w0dFlNbDRMNVJ5WWpkRXRhajVa?=
 =?utf-8?B?bFYwWExWYm5La29ablhqUks3UXhRS1VOWXdlSmF5d2gwY2FrMS91M2FQU1Bm?=
 =?utf-8?B?MWp3c2VXb0pHUi8rR0VVOVZ6cTJ2ZVp6Z293WWRiNE1oZTU5WFpFMHJ1dlNw?=
 =?utf-8?B?dDRCUFpUUTJjWHlzVVd1Y1BoK08yRE9jMWUweEhmU2tVZzlNVVZSMDFsbXds?=
 =?utf-8?B?U2E2NG5MV0NjUGZqSWRFM2xvT1N0cmJLU0dRK0lGQ0ZDTUlPRXNMVFQ1VWNr?=
 =?utf-8?B?cFd0alFVY2ZhQjd3TXNYVlA1Wi83U0tZUmlkS2RnWksyWjZqMzFCdDU5cFln?=
 =?utf-8?B?c2RCVmJqclI4eVZtVXBEZzRud1lERmIvOU5FVHdhck0rUmxoMVIxT0dmTXEv?=
 =?utf-8?B?WnFMaG1RR09OUWc3aDlPQ3dtNEhyN3RTeXFYRkFJeTE1NVp4R0ttSVR4MXZJ?=
 =?utf-8?B?MlR0WitSUHdmN0hGTzZiVE9paTVjeHl1SUttWDQxaDFaQkRwajRwRkV3OU9R?=
 =?utf-8?B?c1ZuVE4vdDMwMCtDU2NFSnllWlNaRi9sTURkZ3IrbFFZUWZsVGZCc3NGWDlO?=
 =?utf-8?B?dkpqQXR2UlRJZHI1bXY3dVpzdVR1dmJxNEwrWjJCM2RTRURJclhZalR3NVE4?=
 =?utf-8?B?dFJQazByMlBXNGpvNDRXTVdLUTc0b1FDZlFKUjhXVTB1U2E2UEcybEY3M0hR?=
 =?utf-8?B?eEhxVStYS0xHYTJsc3JiMmpKRW81dnNsNGlITkFpQ1loc0FwcUVKK0tjV20y?=
 =?utf-8?B?TFp5VkJaZ2F4cVVORE10UHVqYXMzazVYRUQ4ZXhoUHZzV3NPc1hrWXNSNS9y?=
 =?utf-8?B?cG4vemU2cVF1TFZqRUNnMkg4MTgvS3NRR3NsNFFhRFhTOW5jUHRtOGEydDZV?=
 =?utf-8?B?Y0xJUmZjWE5GYTF5RmJ3T1pJRSs1TzQ5K1hFUW5PbjRkMXY2MDluL0RXcytG?=
 =?utf-8?B?NUFXdzhhTDVtanhOZDRtTnhCd1M3Z1pod1k1UGZ4OVE1bDlYWVFFRXAwTGJk?=
 =?utf-8?B?cU4zaFZhb05LeHNmbEI1NU95ZGZsVWl0RHhqckdoL0F0TFpiUXhWTzd5djBj?=
 =?utf-8?B?U3ZmQWwvdHdDK2l5enh2eGYyT0IzOXhwem5aQ3h1MkUzL2NnZ2REVXE5aC9L?=
 =?utf-8?B?aVBFQm9jM3dybWErUHY3ekxzM1p3OEFwczM5YU5wK0JHMnBxZEJ3YlI4R3Br?=
 =?utf-8?B?TWhkSXFwc3M3eDd3MHF3bjlaMjBGZ2xnYWYxVnRWRU1XbjN1bnhnNzBFMDd5?=
 =?utf-8?B?cHFCWmZONkhMeE1OaVpsd0pOdVl5M1RGanZGdTBJek1MK3RtaTVGaEdhZHdy?=
 =?utf-8?B?ZnB2UHhTMjFVSjFmanpQVVdYUWF6RVg4RTltV2UyczV6WEJibGJmR3dMOHlD?=
 =?utf-8?B?ZlhsTVFldVNWbktSeXhZSTBsMHlIV1hJM2tLZXVqb2NlV2NkdktncXo4RFNI?=
 =?utf-8?B?d1hxUVRwVkYwa2pUb3lwV0hTT3VhRk5pcFJDRUJiOFhkTHh0ZFMrV1BJRnln?=
 =?utf-8?B?UEJ1NFZ1dXhnYXc3VGlBbEY4TGw2dWdYL1U2NmdBSC94N0V5dGhpUmcxdWdF?=
 =?utf-8?B?a2FyTjFNVE8yNWloQkl4MlVqL0wySjhoUnNrb3NKR1hOVWxCNEVHRkh4NG96?=
 =?utf-8?B?TW9rM1VCck04Nkt4L3VvcUdHTzZKcDZnSUNKMDdQaW5SbW9GeFUzUXJTK2h2?=
 =?utf-8?B?VUNsbXVxK1V2UFZ3OEZrU3FoclhkOVhiWnpPcE1yT01ZdTlyT2xVcisxQkU3?=
 =?utf-8?B?elI0SDFNdU5JSitDeTY0T1c4aFhvTnc4S1hQOEEvME1Ybnk3UTFkQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bd96c8cd-0ea1-40fe-c690-08df1273e508
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:21:48.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNKXZp11hLbVcc3lAtFrTFtN+1EpeIIyX6Tb7s4Lp/Jy4/9G2ZBT6YkQRM6mfG26xdq5uEz3v/pnf2AU4aM84PAsNx2wHg6CISkqVeE4vqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11508
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 15:21:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20197

Hi Chris,

On 8/28/26 6:26 PM, Chris Laplante via lists.yoctoproject.org wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
> 
> bb.fetch2 replaced bb.fetch back in 2012, and the compatibility shim of
> bb.fetch = bb.fetch2 has been in place ever since. There's no longer a
> good reason to keep the '2' suffix, so lets drop it.
> 
> We also invert the bb.fetch = bb.fetch2 compatibility shim to now make
> bb.fetch2 = bb.fetch. We do this by creating a new lib/bb/fetch2.py.
> 
> Layers are accustomed to accessing bb.fetch2 without first importing
> bb.fetch2, so we declare a module __getattr__
> (https://peps.python.org/pep-0562/) to keep this working.
> 
> Finally, we add a deprecation warning for good measure.
> 

I see this has merged already but I cannot help but ask "why". You don't 
explain what is the issue with having fetch2 instead of fetch or what 
this is helping with. The only thing I see this changing is adding a 
deprecation warning if you're using bb.fetch2 in a third-party layer, 
and I'm assuming at some point it'll be removed and layers will need to 
adapt or be broken. What's the context? If it works, why "fix" it and 
potentially introduce issues?

Cheers,
Quenitn

