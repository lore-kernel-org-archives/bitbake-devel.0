Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3271EC021A4
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 15:38:30 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.92])
 by mx.groups.io with SMTP id smtpd.web10.23816.1739547504501352074
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 07:38:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=WgRP/85z;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.92, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmhNNgNinFeH4pKF5mhLojy857Br7Gc+7010oYn++/1BhY/pEMKhIJ5ONQ6LqdNim+T8j9lXo8XA2Ey2OMNaMLlaQKC7FYmB7qDA83XP8VBNBW1bGdbi9SBV3LaLx7QLdU6aXUtdw4pTWINe5o/JWX6uf2yEmArMp7nmUrJpPsIQtxlC4pvkamQ72PIldm0jqPh7LIAP8v1Vi3gkMrh0QZy6fTj4RP67w5eNpFmewQfEigt8EH6jaG0cl8cCm/wF5ZP8mTVPTq+m0eSzACCdivjMtHk/x+h2K36TO6T1pV06qq6Hp0NiToflhRv2rCKCjyEzLId7HgsCHXi1BGZw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IZcWSAwcqJZV7BKobEW44Z1vG7h45jrzuB6bcaHHUs=;
 b=E+hFSRv66sVAmdppL0Yn7O0lF8rTUtV2VIFQfeunhypXVAwBQdwh3zvUn0318qrd9XQ1VhcN9HbQz7iNcQQiop2MwwDPCZK7TfOj/06VOWuo2AGxJU4Fr/PPCtxtADjmnz8cxtAvbwmmrXKTVXKQWmo9ILvmC8cYjyR7lFFfkTW1uxnveLJQM8ys6KbYVGz0//57kPYW9e7EcX+R3ruH0NXTdwquN/VQKcJM9vxqaGdRuTWPeBdWwit5I4qCbAhrXwfOUlfMPn73N6jmuz1VJUTbQxgJgXqc/+xu/OtPD6dw9HUqlT+cJo4dZj6C1jk0EY204HAWm2qCUB5E+ooOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IZcWSAwcqJZV7BKobEW44Z1vG7h45jrzuB6bcaHHUs=;
 b=WgRP/85zh9JWC15/37RsdMJXVKyC/YbabueT3RpL6cSnl94hAFYx/tijrqZu4UIqD6+VGTbroXI8VJMWkG2Y7bRoNn8u3GlveJ4Zd590snzaSf1tQFVRva5ix+9rkY0WRrHHwrlMvuFOJcYWCTILVYN0s3CqIt8jEN9nI0S5rBMMN0t7EQKx2NJgjwB5v3Immpkweh4GIBPcFaCEJYcwu0AP60sE4RfYNeC8q0HZsA6vlDETTxWKM1xS6taLWv9rpddMs/lLTse2IXIw/znJo+hePIyGpTEaVyklboM03yF3oUmNwNeOShzubtG6gU9rsiohs/CrnMvlAXhRlz5VsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV1PR08MB7914.eurprd08.prod.outlook.com (2603:10a6:150:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 15:38:17 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 15:38:17 +0000
Content-Type: multipart/alternative;
 boundary="------------8p2nGoQnOthvJ0VLMc01QtTX"
Message-ID: <6aeffd3c-988d-4823-a2cf-a0c47e995b5b@weidmueller.com>
Date: Fri, 14 Feb 2025 16:38:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 openembedded-core@lists.openembedded.org,
 Bruce Ashfield <bruce.ashfield@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
 <f0f37aa4-8a69-4340-87ad-18f39bb4f43d@weidmueller.com>
 <977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org>
X-ClientProxiedBy: FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV1PR08MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 293adb68-fe44-4374-5b18-08dd4d0d99eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MFZjaERENWpDckNGbThTZzJlQ012ZjJQaXdYbjhhVGVqRFNRNVJkbk43NHZO?=
 =?utf-8?B?SDhuWkpnQWxTdUVzNVBjMDJqOUtXdjN3aTJIN2xlV1UvSGV2RnpCY0llM3ZL?=
 =?utf-8?B?OXlTb3dVZXJwaUExc2Rkb09nalZiZUVpMU1DdFdjbUgwdE9FZ1FJblpJaUdX?=
 =?utf-8?B?L3Nnam5NOHVGY1c1V0pwYjluaWNZb0twK0ZmNlZlWTBCVGZleGx2cG05Zlph?=
 =?utf-8?B?YXF5RC8xSEU5MU8vbXdqazIzNlZIRGROZ2NyKzRtRTFlclFIZmduQVJLUWt0?=
 =?utf-8?B?blhyQy85VnF3Rld1S2ZlaDR1eThNU3I1TW96c09XRGY2Sk9TdE0yVUx1QUM5?=
 =?utf-8?B?Y3RobUNoTXE4UXB6anFGMTdBbHVQdUNmSUkvU05yaWV3ckFkMm1JeXZnOTg0?=
 =?utf-8?B?eUF2QjJwYzBFK29ldU9hbzE4T1gwd09zY3UxSExldjhwNGltZmlXVVUxR1pm?=
 =?utf-8?B?NXhVTTdkOHdFcmhuMUJ1MTYzMm52a3h4WUxQY1EwOTluL2pPQ0FPb1RlSE9P?=
 =?utf-8?B?MkRaT1pNVGlraTlPT2hhdFJjN2lJM3pORndhOVEwUkt3UjNxRXZQRHE5WUQ1?=
 =?utf-8?B?U01sSktPcENMT2NkeHIraVRNeWh4M0dqQ1FlaFVVcnp2S0E1eGV5cGFkNk1R?=
 =?utf-8?B?TUE2L2R2c1RGeHpzeDNYR1E2Zk9KZDk0Yjk1QkNxUlpWblkwWldUK1BlcWov?=
 =?utf-8?B?M3p3NzhXeDhrbzl6SjRPZlRtK09na2tXS1BuNklLR0NCTC9sUm0wOHJwaGFF?=
 =?utf-8?B?cWtkQkE4MEVBZkpmdHhWK3J6VzdCTk1OMTF4Yk9HUlRvTVhSZ0RrZGdFd2Fu?=
 =?utf-8?B?UVlFMEpTQnZnM290cDIyQ2tKMGFDQ0IzRUFKTGJmZHM2Y0wwbzBRTVptVWM1?=
 =?utf-8?B?TXNUQnIzbnlqZVNVa01oTS9UdHF3a0k5VzZ3UTBrTjdnQjZFWkJYMXBIZkNW?=
 =?utf-8?B?dU9CTWZGd3F1MFczUTJsUHN4ZFJHVmdSTVRMam1YSW5CbVAzaG5oNlBHSUFX?=
 =?utf-8?B?Q0FqcXJ6VVgzZ0ZUMkpVUnlIOEg3dkZvSm4rVmVNa1BBd1R1Ykd6dWFDcy9S?=
 =?utf-8?B?Yjl0OWJTa2FBUGdrTWRRSU5ISGxJWmhzOTg0cWNjaWRxdUpOK1plaDBZdDIy?=
 =?utf-8?B?ZWg2UDRLUGRDN0IyS2xwa0pBR2RKVEZOb09EWFh0bnlmNFhSYmUzblhkQ2Nj?=
 =?utf-8?B?TVN6TkZhWC9kNUNRWDlMOXFFNFNvUTJKOEI3SktoQTNnVVk1UnZjcWQrR3hV?=
 =?utf-8?B?T1Racjl6bGF4cDMrVWFKeVBkcmFOVUZTeFVWRlcrZW5HUXFGemlMRVRkQUhP?=
 =?utf-8?B?NHlQMXlUeGxueWp1RkV2aW9rT1o0MzBjVlc4SXdjSDg5cngwc1ZSRWh4ejFj?=
 =?utf-8?B?RmpPRElEU0NPWDNsSjJUWkIxMlN0OXVNb2ExaDJmbGdVZEpzRy9BTityWDk4?=
 =?utf-8?B?SEZFeGx3TDJKclI1dEVYcUMrekkramQrQ1hOditZcTNJWTZGNkExZUR1clZG?=
 =?utf-8?B?SFFxdGJmTDUyVkJ4S1JlMEkyWHRubEwwSktSK005YTdJS0tDeCt0SFhWNHVC?=
 =?utf-8?B?RElrZ2pFRUZVYzB5T3Vmc1hMVFpTcGdkWFFFNVdPWlIyVHJRY0xaaFI3VlhU?=
 =?utf-8?B?ei9PYWErcGtxaHAxMzNWSmpYRkc1NUQ1Q0k4dkJpblVyVGtvNzB6eHJMcVE4?=
 =?utf-8?B?SDdoc2lnWW9PNkJCUmVLN1kxNGpqVmR6TU5lRWJUWk9BY2ZVK21ia2RZK1g2?=
 =?utf-8?Q?OOKFPSyfU2pVlb9M8VgMHnmOTZS4hU4ABWb5qn0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RTgvaTYxYUp4OFZ1RExXMnlXQ0taWFJ1YnlGU2FzaytWeVpLOWVjc1c4d0xt?=
 =?utf-8?B?anY1TlpCSUVqUEh6eTd2Q3VOWjljakVGS2lkSjRQSHU2cEJXV29wb2VSendG?=
 =?utf-8?B?dUdOTUJXSFNHVHVuYWRWNmdUeXl1SS9YTzRhZkdTUDFCaC80d2hGdG80ZGI1?=
 =?utf-8?B?L2hzWG84dXErY2IwRnEvT1FCbUJ1RGpTLzkwVm95SnU4TnA4aXA5S2xDclpq?=
 =?utf-8?B?UHIyQW9EWGZtVDJFNGxKZ3NtTUtyT29HVENldFNzRkpnZmZiZEd3bXZzRG1S?=
 =?utf-8?B?bWFUQnFvQ1JsUEJPMEtSMHphY0Z6NDdiamlRd3NPL3YyTU95ZEw4YmFMRFBv?=
 =?utf-8?B?T2VHMFkwbjdjY1pnSXlEQjh1cEU4WTEyNlV6Vkh1QUdYYnJHTUlCL3RqeERn?=
 =?utf-8?B?b21QK1hkdTNzYWY2bVE4MEVvSFhxOFpzMVFvUndJd2FUZm1kMU5Fdnlncyt5?=
 =?utf-8?B?dXdsSjFEOXNTQ2U4a0pjaG1SQjZXQWc1NDNNdzNlNUtnTEtjSHhJSU1CSjcy?=
 =?utf-8?B?T1RKelZBME1Ici84OXNnN2thVlFPSzh2L2NmbmVsVW5QeTVIY2EzdWZqVWpL?=
 =?utf-8?B?MnAxeW5kSWJmbGxEeEp4UklrdUE1aWFpMnh5N1ZFTE52R3kySjZqMDQyVStN?=
 =?utf-8?B?Q2ZTRHNid1JvQkRDK1A2NFk1L0RkdE9DdUJKVllxUjhOUzhrOERLMklRMnNC?=
 =?utf-8?B?TEcvM01oazVsN1pKcU0wNXZJNlBESDJaZ2w5Qmlta21MZ3ZEV2lzTVFiM3Jn?=
 =?utf-8?B?a0NUdWVBcE0zMUc3cHRldFNEaWlmaXZrR0xCS0w5VEtuNVc1RUFTVUlnNWIw?=
 =?utf-8?B?YXFuR0xCWU9sbmlXeHhZYVprSUxDRTdXYVkyNjhzSnlRYTZTT1IwbHFGZWUr?=
 =?utf-8?B?WVJCYU9WU1Q0Qm84VDhFRUVoVm82MGsyaWo0VkNwUE5BVkgzNnMzR1d0Ymhq?=
 =?utf-8?B?RHNYWnFPTGxHZW05TmQ5S2YrL1RTK0hLYWdvUnpOaFNRRVpucEVVQjg5elhT?=
 =?utf-8?B?NHpJTW5iSDN0NnArZmxlTDl4ZEswK2c4aDh3UmZOT1dXcENWNXZmdmJ2NFF2?=
 =?utf-8?B?OVZzM3RPTGlGOWlOUWRoVElvR2luVVdrTFBKdjl6MWV1TUY2YXV4eG90djZa?=
 =?utf-8?B?dXdIR1JDV2YzeHNpaVhGVlFISS9xMDA4K1hENzc1ZXNvb2Q1Wm5LaythV2Fp?=
 =?utf-8?B?KzAzYW5JTWtBY09lRG5RNlY0SWwxVWlSQzg2aDZDcVBMZXNlRTM2M1hQWjJC?=
 =?utf-8?B?ektoOGVySGxPU1YvZmtTNlZIUnhVQlpDQ2cxM3BaMzBmMmRlTitWQ01GKzhM?=
 =?utf-8?B?SDRFWWF3VHBUandFMnpZUnlPUjg5WUNIM240eHI4SGV1bC9GaG9hS1AvMWxt?=
 =?utf-8?B?all6ZDFrZU81bXpzM1doRnpiRzNoRVZLQVBEWmwvQmdoWVByclZna3RIWXZy?=
 =?utf-8?B?M2k0K2JnM1VvTFNUaXgveEJOSFVBT1FnMGo4ZGpKTklpZFVOWFdZa0ZiVU5X?=
 =?utf-8?B?THVRdSttVmsrSEdZNHpkQStkTm5jNFE0S3FCMkhJTmZYNmN4d3o5Rzc3UVlY?=
 =?utf-8?B?WU1ZemhkK0pNeWhEcmR0cFJUanBuNXFXYmIrTFdnNmw2d25TNzV1T2oxQm9m?=
 =?utf-8?B?a21iUGFwZmMvbTVWU0ZJd3VKVjZwZG8yUnhtT2ZIRjRqRlR1VjFJc1pPVmJh?=
 =?utf-8?B?enQrRzh4SG0zQTlQdGdLTG5jdUwwK1JSdEdJUWQ0cnR0Uk0yMWtudUNLcXZm?=
 =?utf-8?B?L0VhMDAreVEwdkZ6OGxTUHFlUU5sTEtGVVJmVHVObiszWjFjbWV4dFQvbUZ3?=
 =?utf-8?B?ellxM3M1eWFVN0pnaG42TEhCd1hSVmQyajRqeTlkRWRXTm5oR3N1WmQveVVY?=
 =?utf-8?B?R3ZjeFEwM3JsbERoRW1qb20zaDRnSEU0K2VEaS84WmlaeHV2UkpZQStnZkF1?=
 =?utf-8?B?OHVOaHVzM1dMTEVLdm00cWNzamVVaHpxRzUydTlPZ3hKOWxtcVl2UGhnVm9H?=
 =?utf-8?B?VDRYZWtlRzJGUjArcWhVMWNqMVR3dG5KbjNHeG1jRXZsaGYybTVxMHBTSG1z?=
 =?utf-8?B?V2ZrQyt2bTB5RXJ0YjFneGtCZ21iaXJRcmM3SjJEYUY4djVNOFpyRlZLa0hn?=
 =?utf-8?B?c1k2SFZTTm1VaGFjdE9Fd2NGa0haTEMzTHE1b3BQVVZDa3NTeERtMmNtVHFx?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293adb68-fe44-4374-5b18-08dd4d0d99eb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:38:17.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIM+mMriVX9pI77J5XwycFz+psugfBQeMW2Do3KRF3YLHThPBD0iTLMS0J2P4NK9harwF3vJZsnMNW8E1tPKjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7914
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 15:38:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17222

--------------8p2nGoQnOthvJ0VLMc01QtTX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.02.2025 um 21:32 schrieb Richard Purdie:
> On Thu, 2025-02-13 at 17:33 +0100, Stefan Herbrechtsmeier wrote:
>>   Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:
>>
>>> Most of the concerns I've seen are about how easy it is to understand
>>> what is going on behind the scenes. The move of code to OE and
>>> splitting everything into multiple tasks/stages does do that to some
>>> extent but it does it in a way which I think is going to create a new
>>> and different set of problems.
>>>   
>>>
>>>
>>>
>>   Okay, but please keep in mind that some of my oe patches are
>> reasonable independent of the native bitbake fetcher and it is
>> possible to integrate the steps from the early class into the fetch
>> task.
> I appreciate that and I appreciate the desire to push things into OE as
> it appears easier. It can lead to much looser APIs and less structured
> code and I'm wary of it here as we create a two layered system which I
> think will be harder to understand (and hence harder to debug and use).
>
>    
>>> I'm therefore wondering if there is a different way. The changes
>>> I'm
>>> wondering about would be to:
>>>
>>> a) embrace the single SRC_URI entry
>>>
>>> b) require a checksum of the internal "URL list" that is included
>>> in SRC_URI, much in the same way that we have checksums of
>>> tarballs.
>>>   
>>   The list isn't fix because it depends on the configured package
>> manager proxy or registry. We have to remove this feature. But the
>> user could use a PREMIRROR to redirect the upstream proxy to its
>> private proxy.
> If that is true we have a huge problem.
>
> By list I mean a list of something like (component, version) pairs
> where component uniquely identifies the component and version is a
> specific verifiable version of that component. If we can create that
> list, we can checksum it and use it as above. If we can't create that
> list, we have no idea what is in our builds and we may as well give up
> as it isn't reproducible.

What does reproducible mean? The lock file ensure that you always use 
the same dependencies.

go.sum:
cloud.google.com/go v0.110.0 h1:Zc8gqp3+a9/Eyph2KDmcGaPtbKRIoqq4YTlL4NMD0Ys=

Cargo.lock:
[[package]]
name = "addr2line"
version = "0.24.2"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = 
"dfbe277e56a376000877090da837660b4427aad530e3028d44e0bffe4f89a1c1"
dependencies = [
  "gimli",
]

package-lock.json:
     "node_modules/@adobe/css-tools": {
       "version": "4.3.3",
       "resolved": 
"https://registry.npmjs.org/@adobe/css-tools/-/css-tools-4.3.3.tgz",
       "integrity": 
"sha512-rE0Pygv0sEZ4vBWHlAgJLGDU7Pm8xoO6p3wsEceb7GYAjScrOHpEo8KK/eVkAcnSM+slAEtXjA2JpdjLp4fJQQ==",
       "dev": true
     },

The URL could be extracted from the lock file or could be generated 
based on the name and version or git revision. The integrity of the 
dependencies is ensured via a checksum or git revision. This means the 
same lock file always generate the same downloads and is fully 
reproducible. We only need to ensure the integrity of the lock file. 
This is already ensure by the existing fetchers.

At the moment the download URL could be manipulated by an variable 
because it is common to change the registry / proxy / server. The 
"https://registry.npmjs.org" or 
"registry+https://github.com/rust-lang/crates.io-index" are placeholders 
and could be replaced with a local registry / proxy / server. Additional 
the downloads are unpacked into a subfolder of the project. Therefore 
the SRC_URI parameters depends on S.

I already expand the SRC_URIs with a name and version (pn and pv) to 
enrich the SBOM with the name and version of the dependencies. Because 
the name parameter is already in use and the recipe could use a 
dependency in different versions we need to append the version to the 
name. Either we remove the version from the name to receive the real 
name, use an other parameter for the name or use the name and version as 
variable flag instead of the name alone.

It is already possible to create a list of the dependencies.

>>> For better or worse, we have low trust in the underlying tools to
>>> get this right (they are getting better).
>>>   
>>   
>> We don't need to trust the tools. We parse the lock file and enrich
>> it with fix values. The resolve is deterministic. The output only
>> depends on the resolve function, variable values and lock file
>> content.
> This assumes the "resolve" always does the same thing. I'm afraid
> experience shows these can have issues. I'd much rather we have some
> kind of backup in the system which tells whether we did get the same
> resolution which is what this checksum represents.

This sounds like a problem with the test coverage. But this should be 
solved by a high test coverage for the resolve function.

>>> c) if the checksum doesn't match, we know something went wrong and
>>> error
>>>   
>> Can you please elaborate this point. We already check the integrity
>> of the lock file and we have deterministically resolve the SRC_URIs.
> See above. I'd like to know that the list of components and versions we
> resolve everything to matches what we expect it to look like.

We can extract the dependency name and version from the SRC_URIs to hash 
it but in case of npm the destination folder could also influence the build.

>>> d) require the new modules to write the URL list into a known
>>> location as part of unpack
>>>
>>   Why is this needed? The generated SRC_URIs could be resolved via
>> fetcher.expanded_urldata().
> If someone is trying to debug what the code did or resolved things too,
> suggesting they run python functions to work it out will be a poor user
> experience. If on the other hand they know the result is always stored
> in WORKDIR/xyz/ABC, the know where and what to look at.
>
> The user experience of using this code will make or break it's
> adoption.
Can we instead extend the lock file in the download folder which the 
SRC_URIs? This allows use to use the file as cache and bypass the resolve.

>>> e) add the ability to add custom hooks in the fetch process to
>>> handle
>>> the cases of needing to alter the flow for patching the components
>>> list
>>>   
>>   I'm afraid this will be complicated since PATCH is applied in S and
>> not in UNPACKDIR.
> Then we should work out how to handle that. We could allow the recipes
> to specify the top level dir to apply patches from for example?
Is it okay to use variables like S inside the fetcher or should we pass 
everything via SRC_URI parameter to the fetcher?

The fetcher only knows its SRC_URI. This means we have to add the 
patches to the SRC_URI parameters or pass it via additional function 
parameter to the download function.

>>> f) create new tools that allow the fetcher to be stepped through
>>> and
>>> for example partially run, or run with clear debug output showing
>>> what
>>> was happening at each stage (show the list of components?). This
>>> may be
>>> standalone tools, maybe a devtool module, I don't know. We may want
>>> to
>>> make the fetch/unpack logs more useful in general as right now you
>>> don't get much useful data about what it is doing.
>>>
>>>
>>> If we do those things, where does that get us? How much buy in do
>>> our
>>> different stakeholders have?
>>>
>>> FWIW I am leaning towards having this code in the bitbake fetcher
>>> as a
>>> first class citizen as to do otherwise is going to create layers of
>>> abstraction and we probably have enough of those already.
>>>   
>>   
>> The advantage is that the SRC_URI still contains the dependencies if
>> you expand the urldata. On the other side the integration of the
>> patches in the fetcher sounds complicated.
> Patches would stay where they are in the system in do_patch and use the
> code in OE-Core. I'm just thinking we could add some hooks in the fetch
> process to allow adjustment of things like the resolved component list.
> It doesn't have to be a patch, it could be a function passed data.
Please take a look at the following patch to fix a security issue in 
librsvg:
https://gitlab.gnome.org/GNOME/librsvg/-/commit/aaaa6b68b024b2adbfdf5f8493dfce1f60e5e331

How should the integration into the recipe should look like and how long 
does it take to integrate the changes into the recipe? In case of my OE 
series you could simply apply the patch and mark it as early:

SRC_URI += 
"file://0001-update-url-crate-to-get-an-updated-idna-rustsec-2024.patch;early=1"

We need support for plain patches. Otherwise it is impossible to back 
port patches to fix a security issue or to reuse common tools.

The advantage of the OE based implementation is the possibility to patch 
the lock file. The bitbake based implementation only support a complete 
local lock file to manipulate the dependencies.

Any OE specific solution (.inc or hook) is useless because of the 
complexity of the dependency update. The lock file is a temporary flat 
view onto a dependency tree with inter dependencies, replacements, 
constraints, compatibilities and other meta data. A change without this 
information could lead to anything. It's like the list of git 
repositories of recursive git submodules. It isn't useful to change the 
revision of an arbitrary git repository in the list because the change 
could recursively influence other git submodules.



--------------8p2nGoQnOthvJ0VLMc01QtTX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 13.02.2025 um 21:32 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Thu, 2025-02-13 at 17:33 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Most of the concerns I've seen are about how easy it is to understand
what is going on behind the scenes. The move of code to OE and
splitting everything into multiple tasks/stages does do that to some
extent but it does it in a way which I think is going to create a new
and different set of problems.
&nbsp;



</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;Okay, but please keep in mind that some of my oe patches are
reasonable independent of the native bitbake fetcher and it is
possible to integrate the steps from the early class into the fetch
task.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I appreciate that and I appreciate the desire to push things into OE as
it appears easier. It can lead to much looser APIs and less structured
code and I'm wary of it here as we create a two layered system which I
think will be harder to understand (and hence harder to debug and use).

&nbsp;&nbsp;
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I'm therefore wondering if there is a different way. The changes
I'm
wondering about would be to:

a) embrace the single SRC_URI entry

b) require a checksum of the internal &quot;URL list&quot; that is included
in&nbsp;SRC_URI, much in the same way that we have checksums of
tarballs.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;The list isn't fix because it depends on the configured package
manager proxy or registry. We have to remove this feature. But the
user could use a PREMIRROR to redirect the upstream proxy to its
private proxy.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
If that is true we have a huge problem.

By list I mean a list of something like (component, version) pairs
where component uniquely identifies the component and version is a
specific verifiable version of that component. If we can create that
list, we can checksum it and use it as above. If we can't create that
list, we have no idea what is in our builds and we may as well give up
as it isn't reproducible.
</pre>
    </blockquote>
    <p>What does reproducible mean? The lock file ensure that you always
      use the same dependencies.<br>
    </p>
    <p>go.sum:<br>
      cloud.google.com/go v0.110.0
      h1:Zc8gqp3+a9/Eyph2KDmcGaPtbKRIoqq4YTlL4NMD0Ys=<br>
      <br>
      Cargo.lock:<br>
      [[package]]<br>
      name = &quot;addr2line&quot;<br>
      version = &quot;0.24.2&quot;<br>
      source = &quot;registry+https://github.com/rust-lang/crates.io-index&quot;<br>
      checksum =
      &quot;dfbe277e56a376000877090da837660b4427aad530e3028d44e0bffe4f89a1c1&quot;<br>
      dependencies = [<br>
      &nbsp;&quot;gimli&quot;,<br>
      ]<br>
      <br>
      package-lock.json:<br>
      &nbsp;&nbsp;&nbsp; &quot;node_modules/@adobe/css-tools&quot;: {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;version&quot;: &quot;4.3.3&quot;,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;resolved&quot;:
      <a class="moz-txt-link-rfc2396E" href="https://registry.npmjs.org/@adobe/css-tools/-/css-tools-4.3.3.tgz">&quot;https://registry.npmjs.org/@adobe/css-tools/-/css-tools-4.3.3.tgz&quot;</a>,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;integrity&quot;:
&quot;sha512-rE0Pygv0sEZ4vBWHlAgJLGDU7Pm8xoO6p3wsEceb7GYAjScrOHpEo8KK/eVkAcnSM+slAEtXjA2JpdjLp4fJQQ==&quot;,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;dev&quot;: true<br>
      &nbsp;&nbsp;&nbsp; },<br>
      <br>
      The URL could be extracted from the lock file or could be
      generated based on the name and version or git revision. The
      integrity of the dependencies is ensured via a checksum or git
      revision. This means the same lock file always generate the same
      downloads and is fully reproducible. We only need to ensure the
      integrity of the lock file. This is already ensure by the existing
      fetchers.<br>
    </p>
    <p>At the moment the download URL could be manipulated by an
      variable because it is common to change the registry / proxy /
      server. The <a class="moz-txt-link-rfc2396E" href="https://registry.npmjs.org">&quot;https://registry.npmjs.org&quot;</a> or
      &quot;registry+https://github.com/rust-lang/crates.io-index&quot; are
      placeholders and could be replaced with a local registry / proxy /
      server. Additional the downloads are unpacked into a subfolder of
      the project. Therefore the SRC_URI parameters depends on S.<br>
      <br>
      I already expand the SRC_URIs with a name and version (pn and pv)
      to enrich the SBOM with the name and version of the dependencies.
      Because the name parameter is already in use and the recipe could
      use a dependency in different versions we need to append the
      version to the name. Either we remove the version from the name to
      receive the real name, use an other parameter for the name or use
      the name and version as variable flag instead of the name alone.<br>
    </p>
    <p>It is already possible to create a list of the dependencies.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">For better or worse, we have low trust in the underlying tools to
get this right (they are getting better).
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
We don't need to trust the tools. We parse the lock file and enrich
it with fix values. The resolve is deterministic. The output only
depends on the resolve function, variable values and lock file
content.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This assumes the &quot;resolve&quot; always does the same thing. I'm afraid
experience shows these can have issues. I'd much rather we have some
kind of backup in the system which tells whether we did get the same
resolution which is what this checksum represents.
</pre>
    </blockquote>
    <p>This sounds like a problem with the test coverage. But this
      should be solved by a high test coverage for the resolve function.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">c) if the checksum doesn't match, we know something went wrong and
error
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Can you please elaborate this point. We already check the integrity
of the lock file and we have deterministically resolve the SRC_URIs.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
See above. I'd like to know that the list of components and versions we
resolve everything to matches what we expect it to look like.
</pre>
    </blockquote>
    <p>We can extract the dependency name and version from the SRC_URIs
      to hash it but in case of npm the destination folder could also
      influence the build.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">d) require the new modules to write the URL list into a known
location as part of unpack

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;Why is this needed? The generated SRC_URIs could be resolved via
fetcher.expanded_urldata().
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
If someone is trying to debug what the code did or resolved things too,
suggesting they run python functions to work it out will be a poor user
experience. If on the other hand they know the result is always stored
in WORKDIR/xyz/ABC, the know where and what to look at.

The user experience of using this code will make or break it's
adoption.
</pre>
    </blockquote>
    Can we instead extend the lock file in the download folder which the
    SRC_URIs? This allows use to use the file as cache and bypass the
    resolve.<br>
    <br>
    <blockquote type="cite" cite="mid:977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">e) add the ability to add custom hooks in the fetch process to
handle
the cases of needing to alter the flow for patching the components
list
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;I'm afraid this will be complicated since PATCH is applied in S and
not in UNPACKDIR.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Then we should work out how to handle that. We could allow the recipes
to specify the top level dir to apply patches from for example?
</pre>
    </blockquote>
    Is it okay to use variables like S inside the fetcher or should we
    pass everything via SRC_URI parameter to the fetcher?<br>
    <br>
    <p>The fetcher only knows its SRC_URI. This means we have to add the
      patches to the SRC_URI parameters or pass it via additional
      function parameter to the download function.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:977d6eb4f27c47c19a7a9852fe61bea9e5af0968.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">f) create new tools that allow the fetcher to be stepped through
and
for example partially run, or run with clear debug output showing
what
was happening at each stage (show the list of components?). This
may be
standalone tools, maybe a devtool module, I don't know. We may want
to
make the fetch/unpack logs more useful in general as right now you
don't get much useful data about what it is doing.


If we do those things, where does that get us? How much buy in do
our
different stakeholders have?

FWIW I am leaning towards having this code in the bitbake fetcher
as a
first class citizen as to do otherwise is going to create layers of
abstraction and we probably have enough of those already.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
The advantage is that the SRC_URI still contains the dependencies if
you expand the urldata. On the other side the integration of the
patches in the fetcher sounds complicated.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Patches would stay where they are in the system in do_patch and use the
code in OE-Core. I'm just thinking we could add some hooks in the fetch
process to allow adjustment of things like the resolved component list.
It doesn't have to be a patch, it could be a function passed data.
</pre>
    </blockquote>
    Please take a look at the following patch to fix a security issue in
    librsvg:<br>
<a class="moz-txt-link-freetext" href="https://gitlab.gnome.org/GNOME/librsvg/-/commit/aaaa6b68b024b2adbfdf5f8493dfce1f60e5e331">https://gitlab.gnome.org/GNOME/librsvg/-/commit/aaaa6b68b024b2adbfdf5f8493dfce1f60e5e331</a><br>
    <br>
    How should the integration into the recipe should look like and how
    long does it take to integrate the changes into the recipe? In case
    of my OE series you could simply apply the patch and mark it as
    early:<br>
    <br>
    SRC_URI +=
<a class="moz-txt-link-rfc2396E" href="file://0001-update-url-crate-to-get-an-updated-idna-rustsec-2024.patch;early=1">&quot;file://0001-update-url-crate-to-get-an-updated-idna-rustsec-2024.patch;early=1&quot;</a><br>
    <br>
    We need support for plain patches. Otherwise it is impossible to
    back port patches to fix a security issue or to reuse common tools.<br>
    <br>
    The advantage of the OE based implementation is the possibility to
    patch the lock file. The bitbake based implementation only support a
    complete local lock file to manipulate the dependencies.<br>
    <br>
    Any OE specific solution (.inc or hook) is useless because of the
    complexity of the dependency update. The lock file is a temporary
    flat view onto a dependency tree with inter dependencies,
    replacements, constraints, compatibilities and other meta data. A
    change without this information could lead to anything. It's like
    the list of git repositories of recursive git submodules. It isn't
    useful to change the revision of an arbitrary git repository in the
    list because the change could recursively influence other git
    submodules.<br>
    <br>
    <br>
    <br>
    <span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------8p2nGoQnOthvJ0VLMc01QtTX--

