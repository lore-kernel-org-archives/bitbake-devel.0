Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC392CF9C6B
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 06:55:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.92.91.30])
 by mx.groups.io with SMTP id smtpd.web10.7988.1727160902534000479
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 23:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=iemVqeDC;
 spf=pass (domain: outlook.com, ip: 40.92.91.30, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6/FE2uwIB/+RxB/j7ZTwYs2LkV4WYkporPwyX4YKCfTo7HoDMyxfdfqPAgH9IZ/KvE/yS7WLCdw4NYkLd7uFR3DrB4WFPXAess3Pm3yh4ADNVMPsAkWPQ3xMn8yn1mBcngiWxPr+5HKz0TrPHJ8PlIOE3Fn/hD2cExz2INKPHbDiFBABuwd46g3XFun7qKNAcjtZDwzvgqWesN0o1SJhqfK9SjDsdASxyhqIqqtHSBS5omsTH2e6WIIouqH3900s5yayrlhILceTX3syR4QqSt+IJeuvBvEUROve6moygdl/XVpRQ6lX+WJj38/qMIBk210QX9PuRbBKHJrI8LXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00uo19JUQ28CVMxry3SMSGTqRwLbN9M1+oMmN0r5jQg=;
 b=VNvd4BMWqx7aFvxLO9ro/cObg5VfFLmpvb706jltePHLSD0vHY2tNluvAxT2YWs/mtTGwcw8O0UVQiavS96mgar+FghiSOpBVJPZy882vgiv2xKdf68hPb5DFBKB9fFRL9DbluPESIIhv7LXvw2+bFDje3Nxmdbq3QPmtIVxgq1acTTp7g1vZo1r1OyVMZZXJb0krLtpKcurPrjzWJzLGBI7U2AoqJfXwA7hNsskSHRdELYts0LgBsLH4G5o/dpF+CAUlIOppg/s1jejDj0DzkgL0piZ4XaqddIr2WnHyJ7zfOtDf/yXS5SdgPo8XUX2G8YbG6yvsNVZkzy9o+DACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00uo19JUQ28CVMxry3SMSGTqRwLbN9M1+oMmN0r5jQg=;
 b=iemVqeDCfvi0GuqKiFnPXHGyrqwYtX7lLqxF8osymhi4S/fHxjQvFKf/sxuiCGe6HaC9PlMiByroKMnqRYJWGUkLL2Lhe4KaCzFQBfKjoTR+g133446wrutxpKdedajsc5GvSX+h/UDQNUtvj5T2rgyfeXlSo2IO3HSJhhBmIgW3xzNfIRz7uwkXSkRsnx2/i7bI1HDJwe5RD0SflWmYHpCOLTrodCsEPrcY1NgqpaNOyZhs9p7hlW6YVbmR0NprXT54zCtIQLkZs24+PA3eHwgUkpzwJkYbdVZlwtzBU1ygayiB3jpH5cFUbBll1JgZO7Lk0z87QVSikGevkG6/Vw==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AS8PR07MB8250.eurprd07.prod.outlook.com (2603:10a6:20b:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:54:59 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:54:59 +0000
Message-ID: 
 <GV1PR07MB91207304E3AECA5E809F74E0A8682@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Tue, 24 Sep 2024 08:54:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
 <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
 <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
 <GV1PR07MB91204368C096EDEF0107B58CA86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <06a9081a919ea08fdf0c6a43f82ac695a25f17d7.camel@linuxfoundation.org>
Content-Language: en-US
From: Konrad Weihmann <kweihmann@outlook.com>
In-Reply-To: <06a9081a919ea08fdf0c6a43f82ac695a25f17d7.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <4a3fb7ce-a530-4f9d-9c8e-5cc0c5359bc4@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AS8PR07MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f62e740-1242-4358-2293-08dcdc65ce55
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|8060799006|7092599003|15080799006|461199028|19110799003|5072599009|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 
	8A6NXYQauHl6S+vkHqWl0XydZKRKZZKRQ5WprdnRAmFP12xq5EYP2AwxE7kCypE6LfrbhlIc8yK2NcDXa/Tgk3GJRY3/AvW34t3lq1PHxo43+czGcmlVTVAeY1XwD4x2xln7cMicT7YoVWCowY/qveSUu/0Z8lFmdA+lIxNvWC6BiaZK7RmMfBLApAc9bVs/be1VXZR28d/P+qkyEETAeyRP5E6BCxbLRyLraHM/qQS7U3jY2PZgbNYcyL0IszpXQc3D7FxHrXqFwTpBO2P6GdT4nt1T87kQOj8NY0ffNrPm0Br+4xmoSC/LVxCMIxL2cA+1dGfa01zJ78VrWt9PlGUw9mniUwAKXvbPqckSDw48aqEWc0QepLDosV7bK6J6LjOsL18PwQp6C+VWPxeJV8Y8GOcK0zCjmjgjQPmxdUBLjZXhIjJEElyqw3OkWldztJEdZ+riD1Kd0e7p7mZ4d5bQUyCF56nr1QXMHtnEa8hNGeb9V1I17dpGUu+TGBOloYimbOyipA00jZYD+8fFh/nk+uZJFqXq9zQgvSaZqT8/02lBAXaIl3574VOO0XVf0oZDbea5k+zCNmze/j+JYlh81OqKIbWmwGNOaeb1U0tmgsssdkTlK7x9J9bV03cyl/3pB5jobz4X4OsNT2ZAR6TcrNOoVZUSmnX5gKLlWX/sbN8a4tdzkMpX+g4lc2PpKuUzVLchMPORyC9My09dG/cMBTs8mTsCGHClX8vnI68JJl9czJxyYBrx/RGFX/kXHqU2A0UHlCXat2mJcyqQ4g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmlOdlJxajdFNVd6dmdHb2N4ZktGKzh0OXRjczVNdk05dmN6Z3RSaE9TQWlL?=
 =?utf-8?B?b1dvQkhWRlg1WS9FNnpYMTlmSFo5OFlBSEJYblozdWZvV0NCZG1ON2FOdjNk?=
 =?utf-8?B?azE3V0xodldYSS9IZlhwZkJpTDlGTEl6SWJHZzJXY2ZRTFNzdlVCQUJFMlQv?=
 =?utf-8?B?Qk9UTUU4Z1dzWElJTVFraWpRaFpzRnErMXNGSGEvN2E0VFNBa2dQZVZiQlU0?=
 =?utf-8?B?czNKZ3NnWk5tVTBXZW4wOWxhcForeVBlNWlsbXByWFVmRXc5T0pvNnMxZW1z?=
 =?utf-8?B?Qyt0MHZPb3VzT0IvU3NkbXJyTFFnck9wQ01UdEdMVSt1dXcrNjBEWkJYMXdB?=
 =?utf-8?B?azJrRXpvOTNDUk8zUk5FQ2RBK1lBVWNiY0dHQktFWlRwMUtsVzMyQ05rQTd5?=
 =?utf-8?B?bnVCeXkwTmxVUW9MWjVQSGxMR0RMZlExV2RkWGFicXM0ZmpRRks3Z3FQME1j?=
 =?utf-8?B?YzlXMjZYQ0o4akpCbFB5WkthWGxsaU9qWHdhT0RQZmp1RzVWMFl4MkRUcC9m?=
 =?utf-8?B?LzlUYVBWRTBSUncvdHZXbk9qUEthdFRybzBNTERaU3ZJYzNCeGlhVVhmTTZZ?=
 =?utf-8?B?VDVNb3ZGM1NMT0xOWXB4d0ErVGhPc2xsRHBYOTVkNUJMdUpPUzlSTXYyb1Bw?=
 =?utf-8?B?TVhHYktxd1ZjaGNobG81a2hlcGJpWXBaRkRDNDh0RWFjcy9tK2FjbUVxaVht?=
 =?utf-8?B?cGxzU3dKVWhhajZsUFUyamhGdWdpMWplNVBEQlJMYUdUWTVQQVc4S0lQd3oy?=
 =?utf-8?B?S25PNXlIMm1lNDZLRWNjQ3JJK1loUW1TV0o0azlqMnBvYVdtMUpjdGpkOEhs?=
 =?utf-8?B?UWdRd1BuZ2NSOVhBV1NWT3ZJZlpRaDRheWVUTE1YZXdMVUZUb2QzQjk0akVB?=
 =?utf-8?B?UVlpUjBCWkNPdURxQ3EwOXlLZDNQcExoVEZvbVRKdDNFSmJOZ1ZOUlhFQ0RC?=
 =?utf-8?B?WGM0d1ZuQzY1S0FoNE5kUTBXd1dpZEZ4YldBelMzTjkvbEI1MjJvMUQzcEx0?=
 =?utf-8?B?WTZ4cytXMkpwZis1cUxqSk9wSFZrVDA2RHZoN2tYMHBFTWhPZmpMdElGMnIx?=
 =?utf-8?B?YWV3RDhUdC8rQWl0em1hUUcrTTU2eGVpRCtaYnEweUlhZGFqajRnMlB3YW1M?=
 =?utf-8?B?N05wQVFRTGx4czBycWtmUXBBZGhkZUFUbEVNNWQ0dE9Hc3M1Sk5ibkxrZ0xU?=
 =?utf-8?B?NGJRb203Z0QvSDdYMWJZTit0U1hQYTMyMmNVN1h0K1pULzNZcmtqN3gxQ0lk?=
 =?utf-8?B?Nk5naU0xeHVha2djdi9pekNzOEFLUlFPd1psa0JINTBjRlhIbG5iclZ1UGNi?=
 =?utf-8?B?dkdKRmFKL1NqMHJTY3hhcTM3WVdjaGF5WjdSQ0NWSHprWGp3TmJpRjZ6eHN3?=
 =?utf-8?B?VHdtK3FwMHRNb0dZNE9ITmJnRWg3dVJYc2dDc1lRMW9DcVlpbDJqb3B1cEpG?=
 =?utf-8?B?UzViUkJud3VZZXFjMDU0VkRBUFlQOVhka2tWRFl5Z2QvNCthaWMvTmNLTFZQ?=
 =?utf-8?B?OEUwLys5ZmJIWmpza3pIbStBWlFscXlQR2N3bzFGTXFJQXR4dklYSEpxVEhr?=
 =?utf-8?B?TGYzNG1WN1M4VFE3cWt2bDZ5YWYzdzFmMGYrU0ljRlJJOGxNVUtJcEl2Z2ln?=
 =?utf-8?B?Z0tDRE04L1BZdWVGQkVjeDNaZGU2TmorMXJoYUhxNzBEVlRQemgzeFBqWmdH?=
 =?utf-8?B?emsrOE92a1VxcTd3TU0zbTkwc2ViTmFyRzRPNUJmYUFDNEZHQWx6SFlZV2JK?=
 =?utf-8?Q?7IXtuDvxwECNBy6iG8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f62e740-1242-4358-2293-08dcdc65ce55
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:54:59.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8250
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Sep 2024 06:55:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16595



On 23.09.24 09:49, Richard Purdie wrote:
> On Mon, 2024-09-23 at 09:30 +0200, Konrad Weihmann wrote:
>>
>>
>> On 22.09.24 11:27, Martin Jansa wrote:
>>> What about using precompiled re only in cases where the old "in" is
>>> triggered already?
>>
>> Also acceptable for me - anything that makes the check less opaque.
>>
>> @Richard please let me know how we could proceed from here.
>>
>> My personal take, after digging into all the side effects, would be to
>> remove the check and treat all "old syntax" overrides as merely "typos",
>> hence letting them slip into the datasmart store, but adding a
>> (potentially warning level) note that a certain operation is using the
>> old syntax and therefore not being applicable in the current context.
>> (unless ofc there is some code path that does some bad things to the
>> store when using the old syntax, which haven't come across after looking
>> at the code)
> 
> Old syntax won't hurt the store, the challenge is again performance.
> Iterating the datastore for a search is one of the slowest things we
> can do. That was why the check was put on entry rather than exit.
> 
> My original reply was intending to suggest the patch be tweaked to
> improve performance along the lines Martin suggested (or otherwise).
> 
> In python if you have:
> 
> "if A and B and C:"
> 
> C isn't evaluated unless A and B are true so there should be some way
> to keep performance and improve the tests.
> 
> I did even wonder about dropping those tests at this point, not sure if
> we're ready to do that or not yet...

Send out a v2 of the patch, taking Martin's suggestion into account.
Also a patch is out that removes the functionality.
For latter one a consensus in the a wider community is required, so I 
put it up as a RFC.

> 
> Cheers,
> 
> Richard

