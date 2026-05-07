Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8BDCD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 13:53:02 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12540.1778161976448590432
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 06:52:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=XtglK9Tt;
 spf=pass (domain: cherry.de, ip: 52.101.65.57, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmvvnNXp8V+pMO7rinYhXWal8Z4LBPT/Dm6KZEmvA2hadDM+DLqp1/givXrHsjGuLmEfuOYAKtgUjWnxirbNm4Sm4B8uJBOYir+40H21piAKgABryTN8AUkfuacCj89Ex9yKfpkVaOK+fzTZH2Z+iCLA0qb6Ut5hIsPV9zH2SZAiz2aTJ721ALzQmZcHp+HbGbKia98opS2dHeYJaOx3yz62QLxAKQ5nLYMMGDf7giXaNhbNGSQ8CMi/8GwVMHje0gbmX811DuFTU3dAf0Of8kAnbai207Hvu10J1Ixz6skWy9QAzpz/IKrkK+HD4wOxvk2awqJVVm7tExnJrQZ5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCRlRFrvWbWVdv/r8WCiS0unqLfdsB/kCRVoL5GfBn4=;
 b=QHujKBfLfU3nVAjlTDBHRCAsUmdGYgIfNK9z2PXZpmDVbWnYdblUzhZp72bgkihKKtMpNeae7e/Xi2yLoy9Ty8TrFEDqgaN1pQkTI5lEJgCiiZHrPEUnxd1srlTvkF3CaROfg8/Qiwi8EmRaE7w7u8KIoJKiDT9GCYsKk4r43nVR5G6ElyShrsSdUXaEw2jzdL2spZB715EFLg9NCo+YhoQ/yGBiylfLTbOzGD2IknzJZgdtBOYhjgjxlRgEQd4JH7O495dqlizazBjsSP9geEWeDZ7lM+f6gPw/IO/z4PPcs2oS4w1n9CJgKHYeul83ij0bn1oAfT7xBGRAePO5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCRlRFrvWbWVdv/r8WCiS0unqLfdsB/kCRVoL5GfBn4=;
 b=XtglK9Ttgxnqg678VvFGATAQBMPP6z0YMJO+rR/xjrOO22maME4m5f88P+Fzypw6tWoarXQjScEQtLqNm6v3OovOQBj76IKFI++qKOofPE5cDLJUR+7Cxgn58hCjAm/C77os4q7Xviah6R+EHziUzkScoMK+xZppYxKVqIRU3hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS4PR04MB9290.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 13:52:52 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:52:52 +0000
Message-ID: <fec735f6-f87d-4036-a013-384ed7c54701@cherry.de>
Date: Thu, 7 May 2026 15:52:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] doc: bitbake-user-manual-metadata: remove invalid
 anonymous Python example
To: Dawid Bijak <bijak.dawid@gmail.com>, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
 <20260501091418.76994-3-bijak.dawid@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260501091418.76994-3-bijak.dawid@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS4PR04MB9290:EE_
X-MS-Office365-Filtering-Correlation-Id: 18823892-75f5-4ff8-106e-08deac3fee9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	YvglJb40DUC5J33Ve62JOYw9tAft8zGPhO9LYoL5NW3iMV7cjmuX6wMapmTStexGYWZIbRyRg5CbdzME63B8W7Kwhsjajpwv94kbxWOrCwA1iI49ysGY3MQT15ADS7ZWJv9D+H0lFHAI8AWRyZDPDjrXmSQo2WIcgIpJVsZ/DnAyojihmlGTVkA3gmPyq3uZtikdy03ksT3PhaRZut/j1URNMHspq8AGSuFbDrxO+aGWOD7B1wuMPsWttWf3/1AQpK01gb5NrNDBagqV2KrTU2pQqIayTuVB6bvoy5crAL7FQd7+kgZFhjc2fjV+yosm6XncTjaFIKLm1HCbj8OOjbIy6nqY3wn1GfyYm0GQjoieDVHlIelRQjdQ6AFEuCOjkEHDEm2j4lTUeBehX6vc8lSirgere2rwL5x/LfnhISWX7+kwvMPv18hq4/whzJqoIHJZY+KA723LZwMAYOS8jps4buJXFo488y8E2DqBeOD86ZpAlwIUVNNcVpGxh+gu5cD+8qiiXY6zX9/xw09mTkMTQkZA7mUUELYP8yOK8CB20wXf0YSXlynny/9t0STWXd5AkK54sq9aKhleyMnp47mr3TDYpganFQeBHCfGFBTstKprrZ4EdxyMnALcI3d2+4ZzQ2lALGyQikWzKjltnpBtj16Tjn9KV5/mSh0iEyi3vCf0UrYquntv1ye0fmE2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGJaMWhqRERTL3FmV1hsM2tWc1krR0hiUmc5NVhIKzlJdytQODV1MktyUDNH?=
 =?utf-8?B?c1dJOFdZZWFKbERKQXdyVjhhcHFGY1p3bFNIVWV1QW8xWk56MU9vRmRtTDZa?=
 =?utf-8?B?bHpPOU5jWURkcHhKOGpSekQraUR0dnhLN2VHSVlWQ0h1Rlk4NnRvbVlQYjBs?=
 =?utf-8?B?WWFZc3RZMDhpZnZhNzIrc1FlN2Y2RkFxd05mTkw3Ryt4UVJlOFZCOTNrbFhX?=
 =?utf-8?B?TUQ4YW1ldkhXSGdPZVlESGE4VzdUeFRtNXhXRVppZjRNS2x3MWcyK1VibDg3?=
 =?utf-8?B?eXkrUjcxVXBrdS9NTHV3UHV2cU1LWTdFaHRDdUoxZDcveEw1Uk5sKzZSNGY0?=
 =?utf-8?B?ZS9qUUZtak1PMjFqUWdOdXR2dXpsNWYxS2JNUXFqM1R1eFgyakRHak8wdkpG?=
 =?utf-8?B?aWxpM0d1OGZLRWF6amFoMnY0SE9HQkF4Q0pYSHh4djUvbnpxQ3BmSGdhNTM5?=
 =?utf-8?B?VzRxTWl4VkFUTGg1WE1zYjNnU0Jaa2p4WnZOR3NKeDlvUWhUYk9qVVRnLzEz?=
 =?utf-8?B?ODJ2NG1nRWhhd3BEcmxjYmU5UkVRSHhlcVJzWWtTM2JPN0doSWxRcFkzQmhs?=
 =?utf-8?B?NXFwUlVldkpBSllkeDlNTk9IdFJJNHBieVlRcUs1OEN1MU1uc2tLRkxGdzNI?=
 =?utf-8?B?TndYU2E4WmxmYllqYm04Vmx2T1pKdDUzWW9LdFpmNkY0dnlmbXZqVUg3cGtz?=
 =?utf-8?B?L2JiMW1RaWdYOUp3YUZraTFaS3BBcU1PNWJkUGVpWCtISmw4YnRoay9lWlBn?=
 =?utf-8?B?dm92N3FGNWx4SDF2aXlVU1lTVXJmVjh5ZmhodEpVZkN0L2hRREZsbTB3dnQ2?=
 =?utf-8?B?REViV2F1OVE2SDZzVWdWNlRWZ0t5Rjg5am5CWEpJUkhCdXpOTTdUOW90OXdu?=
 =?utf-8?B?RWxYY3ErOFFuK093VFp2UFQ0WG1xK01SWnA4Mnl6THhIbGdhMjBQZEZqY3VS?=
 =?utf-8?B?dFZURHRTT2xOQ3dkOHQzR20wZ0hXWFFnNTNMTUtDYVJtaHdaSXJ1VnFBenpY?=
 =?utf-8?B?cE5nSWhLTnVlVzB6blVWWFRqb3dNaUpGQlpMclZsMFZqeS9Fam9rVG1OOHFy?=
 =?utf-8?B?L0NuWlh4T1c4Q2p0ODRPVDhaL25QdjE3QWxuam85WjRxTS9BR1NzT1VIQWpV?=
 =?utf-8?B?SGhyb3hUTVE5U00rYmsxRHIwWG1nbWhZOUhudS9xd2wxdlFQd3hlZEdsV1RK?=
 =?utf-8?B?UkRYcjB5T3NUSkhhK01KVUk5ZS9CMnBrSUM3T1hWRGdTMVJUb0cyUmdsbmdR?=
 =?utf-8?B?c2ZHOElKOHlKTTNSL1BmV3dTYktweWlsUEdUd09jL1dIQTJ2SkFlMFhGcU9Q?=
 =?utf-8?B?Tm83RWJ5NTlMVTBlZXZFZ0QvWGViYkc4dkIzb0RybFJ2Q2UyT0ZvMG5SNkZH?=
 =?utf-8?B?SVVOTDhNVUNPN1VjSHNaM1BQa3ZDaFVrdlhoVWZxTCsyVm5JZkdPWXdaWWQ1?=
 =?utf-8?B?WThCdjhFaTB6NW1JMzErSllEOWlzZmZCaFBLSkRacnhLS2tYcGE4Tk5RVVlI?=
 =?utf-8?B?MXdIKzZybGxlcDlCRVVjSXJnTS9nRm5VcVV0RGVpSnQyRjZ3TEQzNEMzN3hw?=
 =?utf-8?B?TkFnTGtMN1NRUEFjcnI3MENVZy82RkkrUTRHRjl3U3VTeFhvaDJKTDhLMTdj?=
 =?utf-8?B?cUlBdTRkY0d2dGIwSG9JRE82V3NkVmgxUFhKOXJQLzFCbjZ1enhqblMyZ2Fx?=
 =?utf-8?B?Zit0NlJGKzJsRzk1c2FlT2gyTkhWWFY4WXZxVmFBZW9kTDJJSU9PTVNodVlE?=
 =?utf-8?B?QkdaQVBadktDSXQ1aFpSNzM1aG0vSmF1cHNxbm0yNXkxbkFXZHlSV3pRL3ho?=
 =?utf-8?B?T0gzdzNQLzRvdGswUVZYZWVxQzFNNjR6UzFsYTduUHZGODh4aHM2MTllZFpN?=
 =?utf-8?B?MTB5QkFaVUR6VTNKdW5JSnlBSHo3QXJycTc3Wm1sb0haZWg5NlJWZzZpOTRF?=
 =?utf-8?B?cjBndlQzcElsQmZZNTBmSm1BWXZIaVg4K2xxTjlUKzFlaXNmWDRRTUd4QkFN?=
 =?utf-8?B?T3E3dE5nOVhGMDVPNGthMXc4bXVsRHFSdlUxQ3QyVVpGR1IyTFE0bTMzREEw?=
 =?utf-8?B?eUNOODk3RitSM3lEM1BiRnd2bEhMbGVNbndPaUMxQnN3ekNPWDJGWkg0T3lB?=
 =?utf-8?B?c3JxRTNhNnAzNGZJeXZEUEk0cnY5b1o3S2NpYk5KMGNEYnAvYXo0Y1NqR1JG?=
 =?utf-8?B?UUR6UFFHeUJCaTd4UWVaT0JzTVVtZGE1WGpWVHMvQ0x6WGJwOHlwMy9WNkp5?=
 =?utf-8?B?dW5hSEV0MldYY1lkd3U0T1pEcHAzUHZJcm1wT0tOcGlmeW51QlV4V1NuNVhM?=
 =?utf-8?B?SGtCVmhzYy9mZ1hVYzhNV2N5OXhKL2M2RUY5dlNXV0I2KzhOaXJwZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 18823892-75f5-4ff8-106e-08deac3fee9a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:52:52.0431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI5yXcCh7zIH01vWpQq8YRht7aqmvz6x5EU5wLaVRD7OQgPxIFJpk3edRyC4LNxeN11kAwRDnkxGlvFulI7ocKA2qaI6SL6bmFzW88vQ5xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9290
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 13:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19464

Hi Dawid,

On 5/1/26 11:14 AM, Dawid Bijak wrote:
> The documentation for inherit_defer suggested that conditional inheritance
> can be achieved by setting a variable inside an anonymous python function
> and then referencing it from inherit_defer.
> This does not work: inherit_defer is resolved before the anonymous Python
> functions run.
> 
> Remove the incorrect example.
> 

That's fine, but this is so far an undocumented limitation and it would 
be really nice to say it's not supported!

Something like:

.. warning::

    Setting or modifying variables within an :ref:`anonymous Python 
function <bitbake-user-manual/bitbake-user-manual-metadata:Anonymous 
Python Functions>` will have no impact on the value of that variable in 
an :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>` 
directive as the function is run after the directive is resolved.

(untested and probably missing some formatting, e.g. line-wrapping :) ).

Cheers,
Quentin

