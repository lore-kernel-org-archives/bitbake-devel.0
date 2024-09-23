Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253B1CF9C6F
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 10:57:13 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.51])
 by mx.groups.io with SMTP id smtpd.web11.33897.1727089024389601827
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 03:57:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Nn/pa6z1;
 spf=pass (domain: cherry.de, ip: 40.107.20.51, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7nF52FKDjtHTUhzTglCcI6JbPUHi9faErlztP1ze5qq2YRqOjLBA3eMUkMtV4YqXjNjSEniwRrrQA87zCqWQh2cqWy4JYGRCoVSuVADipYhi8+0RdA86+wAhsG1AmuL7xiUEf2oNNEwSdK3ffqxMrjZSCiSbR/l1pXMRw2es4oefbZQgl/T+xwrb/FM52Qp1GwEIvtW36r6zX9HQKd1pyIz56MgfTEJ0LYxiHPHmityA3rnNQx4OZIkdtPSnqr41nM29AppkMSZyRx5e+DWKEhDJpWZV684lsn52+HX2Ld7GtLZUFIb3Q0JUZ27GZ24N4sISuWIWaPgcBCsBsG98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAF+9uShybrL817i+NxofSVyielKmZU3i5t5IAhaS/U=;
 b=PdTU1IUN3SRIPYgNvt9GGxBZl1iSMlkvkdM0KfUWMpbjCueCPoppVNRfo7BCZP+2fxCWFbdohELUqXdXuhlr/M2lqeHZSsoF1IkDm588kW5YLuT/KOr+ccuGJAi8cquTk4NQWxrlzcjC0oYz93pm+apEQTw9dkeotOe/o5QXniBUTsKqs4DfJgph8BiL+5UlWW7ygwIRhAosmrE9ug+HP6hT4Dhi1yP1O18+kE2lr+TtxZi301eHDnuCujKyy3hrLdgr7i3Ov37ZWttXCEcaRRcsfsDJ3q0cVLyTbxjrler2wXpHOCa8AXATVfjdgf+SpqnzSYeXHuf6zaoPakvG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAF+9uShybrL817i+NxofSVyielKmZU3i5t5IAhaS/U=;
 b=Nn/pa6z14CSmSG5+AElFdLudMaTuoofqAXFZX1n6DaLyJTP227/7eFPr4o5qH+xYTCNk+Nzw0fvdaqqmo/qpMDtvyCU2fBy1TD3fZHT/Yq9aWXY1ZApBTzjRaLPUxPbrvBGUqC13Q758nzlvEqGY0gftadSJLEalVYyMwt7+yek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10986.eurprd04.prod.outlook.com (2603:10a6:102:489::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 10:56:56 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 10:56:56 +0000
Message-ID: <b69d0035-b4a2-420d-8ab3-d9df94f119d3@cherry.de>
Date: Mon, 23 Sep 2024 12:56:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
To: richard.purdie@linuxfoundation.org,
 Konrad Weihmann <kweihmann@outlook.com>,
 Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
 <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
 <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
 <GV1PR07MB91204368C096EDEF0107B58CA86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <06a9081a919ea08fdf0c6a43f82ac695a25f17d7.camel@linuxfoundation.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <06a9081a919ea08fdf0c6a43f82ac695a25f17d7.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10986:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fc7780-f69b-4a89-817b-08dcdbbe70e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UU16VFdUeXJGdmJRN2tXNEpueWlkVE1VUlpuYmNYcVlyZWlnZFlNcFdGS0hJ?=
 =?utf-8?B?SUxyTVRTaS9PQ245bGtITVJwSEl3RDZrK3c5VXdEN2lDMkVQSDZBWitJdkpX?=
 =?utf-8?B?V0wzS3ZFYnROa2J4K1dVYjhWaWFjQlVrOHVTSTFFcTZGRzRUczFDK0pkR1BI?=
 =?utf-8?B?TXRpeGRLWkVDL1M4TjNXaDN5Q0lrVGJTdVFaRk5rTTd4bU13blhQVklmemhj?=
 =?utf-8?B?OXg2Q25mV2JHcVN2alNtNFFlOTRTTWlLZFdHdFNQUkNTR2lGZENUbWRFdk50?=
 =?utf-8?B?LzRnVVF0YXpBajNNdGRzSjRtTFFUdTh1M01PODFkMFdocFZjQUhLTEdiL2dv?=
 =?utf-8?B?WXZqNDQwKzhhTUlZL0RnMlJiQXVObmprSjBCd0pVc09rWm1GckMyWVVoaVNx?=
 =?utf-8?B?b014N2wxSlREblY4VC9uNHdlK1M4SHVqamZscjVUMnd5MDRCSm51SWJhNDZh?=
 =?utf-8?B?VXhSMldLVGVHRVBoQXRvMjlkMzMxR2NRaGZzeVdnV0ovVS9zUWwzYTJoQi9Z?=
 =?utf-8?B?WXRTemZwdm1wWEhJb3oyendOaEFCaXpEMFM5TXovK3FkZGF6cFMyREZocklh?=
 =?utf-8?B?NnNObXE2dzN2ZWovaWVFV2ZFZEwyN010YWFJR3QyRE5XNG9Ec1FJOXhyQ1Iy?=
 =?utf-8?B?ZTA1V3Btd3J3NUpYdDQ3NVZ5U3F3ekd5M0lJQ0FqbzZjTlZqWTdRUlBjNnk4?=
 =?utf-8?B?Qnh1ZkN5TDIwSlVLcnJWTlNjN1hGRCtLbXFXVkdXU2d1ZXhnUEpTT3pzd0Rj?=
 =?utf-8?B?U0dMNzYyY1ZCSmZYQk5xY2FuUXF6MXRCSHc2QVpZTXhwbi9Oc2R6OVBwWldw?=
 =?utf-8?B?ZW1PUC81d0l6ZjJRV3pnQ2xvWmZqN1BTM1M1aUxzWVBXTlowZWJ2dWhYbjhL?=
 =?utf-8?B?eUtYSWVUMWtwNUZxbXZMcFJEc1Q4T2lUS01QbE1QbUJPaXlUREMxUVBwMU1p?=
 =?utf-8?B?ajFuZTU4MHhsRkZ5UjhYbWtFeFRtN1JVeEhKaWpSZThlTU9ueXMya1RBODZE?=
 =?utf-8?B?SlJPc3U3WjBQeWZBdFM1Wlo2ZzZsQTU5T0lBOGJBV3d4b2syTm54c2dWMWlF?=
 =?utf-8?B?VUhYbVNacTk0cmhycU9VSGJ1T1lBTUIvMXNoK2VZM0hrdVBkMGxjb0d2MC90?=
 =?utf-8?B?cUlCY2I5UjNVOWozSmVnUmV5b3NzMFhBWU0xUTVZNlRlc0JXVWQ0VlZpN1g5?=
 =?utf-8?B?dnhmNzZPVHZFMVBCS1l3M0xXMkJnVzE4a0czN3BPSlZ1dlZHckYrdHMybzRF?=
 =?utf-8?B?cGdQQXJCNHY3Umg1azBJQ0d0YWR5empCNEdJa3FteHNDbldzSWNxTHJHdC9x?=
 =?utf-8?B?ckwzdnVRTEFaVWszY0RvcTV0anRIMzhPS1FIQy9BRWZPTmc1VWJRQnlHYk9D?=
 =?utf-8?B?VEhNM3JTVWcvMGQ5cDZhSGZnUXZ0RUpWcWk3emdHdE5Hbi8zS0NmMGFLTmlL?=
 =?utf-8?B?MHpLUk1LWC9UYm4xWVZjZVhMMWJWdUZOTE0reWlGWnFWRW52UWVPcFZoYUsr?=
 =?utf-8?B?RGlISVh6cTl2SDY0SlRPUkdGanJWYWJFQS96a3BmQldxSXErQnNNQTdwRHVO?=
 =?utf-8?B?TXFZWFFpUnNZZkJWV3BCT0FBV1MxQXlkTGN6RXdwVWEwZnZqeW42ei91Zk9E?=
 =?utf-8?B?dE9BRVhjLzYrUHVxQ2haczV1RXkwa2VQa1Z6MUFMUW9NdUxWWFZCdUFBVzM4?=
 =?utf-8?B?ajA5WmNMdzQ2RXc1MTU4SU5BaXF2VEIzN1RRckJDVGZocDRMYmtENU5JR2dW?=
 =?utf-8?B?VWN5ZUMyMm0zcFVVSU1ubzQ0elhUQ2NrOHp0cTdXVlp0VXR2T3dNMTNBMStl?=
 =?utf-8?B?WTVYcUVFbk9UbzFPd2pSdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVljWmpFS0hadnBGZE1BVldENURPL2N0MzV0OFJoaXlYTklsSXEyZUhDdVB0?=
 =?utf-8?B?by9FQkdsUDlqdnRLbG1PaWJ3RzJRYmZyNTBFOHNiUFR6MjZ6K0FBWWVqT1o5?=
 =?utf-8?B?L2VjWUE4ODIwUlBBMEg2RXJCcGI4Z3paaUVzbzNKVlFCWldEejRUNjQ3UC95?=
 =?utf-8?B?dWsxZEU2V3NVQUYxTHBWUzh3bDRFK2g2UlZnV05CQzl4MXpxWE1uSklEM2dt?=
 =?utf-8?B?bnJwNlpydGlGRFVnM3RQMVpyclIvNFhrQ0hhNXZXUWVpS1ZxUXppODBMSEdO?=
 =?utf-8?B?bFlGdm1GdUwyQzRhOG9LMnhhMS9NUWxIKzNtakpLZnROR1NwTTN0OXNsMDBV?=
 =?utf-8?B?N0Y2YmJIQWFQZGpUc0VCRHh0UW5tRnBVU1lpazdCRm5FcHNRVHJZVkU0Vm4w?=
 =?utf-8?B?TTd4TGxseEllSGVZeWwvSTlrMHl3bzhoeXNZays5MHlRbFU5SDdHampLMFN3?=
 =?utf-8?B?ZEtwZ0RNQnNVK1l0WDhFOFZLM0I2R3FLK25wNkUxcDhMeVI1ZEw2Q2Q2aDZ0?=
 =?utf-8?B?cmZKS1pSMTRuZHpZeWhFUDcwQjdjZnQ3UjdqejdkR1BQSmRYS3V0Ym5OSEVy?=
 =?utf-8?B?bnd3ODlNMXdMKzN4TXZzakRMcFd0UWR5eWkxdTVHVXdvSkFhYUlxVzd0ZnFv?=
 =?utf-8?B?SmxJOVl3YnIzZEpkNXpLa21RVXlBVzNiUHVkekpBdGpMTGhsOFd6aVloWVBj?=
 =?utf-8?B?RjdMRW1rUmNBMHlhK0FEeDdFMUR3bHFJRlVOa3NWdTBLVFh4aGpGUlVkWnJR?=
 =?utf-8?B?ZTlTRGdRUFYwZitWSFo1NHFaMnUwT1pBNHM4aC9CdXJEK3RLbmZVNHdvM2tj?=
 =?utf-8?B?b1BkS1o4ZSsyWTlsZTVwaTRoV1NYTGJiYkI1Ymo5SFFKWmhxN2xWNEx1MzNC?=
 =?utf-8?B?QjlkNkx6RS9hNXM4N3QyN1VhTFB2bVh6NEh3TXBnYmlGY1A1TjRwcW1leUVS?=
 =?utf-8?B?REY2NHdXd2hkSjFmM3ZzeTdmZThLZ3lUb2M0SUZRUjl0VTdsa3h2c24wVUE2?=
 =?utf-8?B?K3p1d0RvVFJtU2VyL3lGK0N1RVBmeXBvVkpsbjlUNkU0ZWhQTXFwWUZUblA5?=
 =?utf-8?B?dWs2dWxPdXJvbG1adWgrdmNlYnVIenNGMUpmRGpTdlNtNmV4QzdTVjhkV2M4?=
 =?utf-8?B?aVRsMHo2SlZha0c2TXFqTFhKNmhFamZWM2FXYVI1blQ0VGVUOFFOdFQyamp2?=
 =?utf-8?B?dFFhTDFKVERsK1JXQUhUNG5IOWlVQmtjMURjMzhLazlXV1JTOTcrKzhoalRr?=
 =?utf-8?B?T0NSaUlhdzcrNk1KN0NZeEdRNitlR011MWlrekNjeWRiYnFtTXI5SU1kV2J1?=
 =?utf-8?B?RjNvaXkwV1ljbFUzVEhVc2MyaEJBcUE3NTg4Y2N1TGNkVTF1MkVKSWpZeXli?=
 =?utf-8?B?NlB5aU9NYjNMT2NqeEFyVjhLWHlmUkFTdnk3bHZBY2RJd2FzcXJIbFNBMW5T?=
 =?utf-8?B?M0p1bk4rd1pQaXRKVlJyZUNTdE5SbUpIOE1LSzlIZWJpc3VhS3dEcU5iRDdz?=
 =?utf-8?B?alBFYVFDRTcvTTdyRlRpaXl4N3lHSTJXMC9tTXI5amkvUjNQeE9JUlVjTTBq?=
 =?utf-8?B?b29razR4Z0I3K0pkc2VkMDJ1WERRRFljdC83TmxObmJ3N1NyWXlBRGgwYlla?=
 =?utf-8?B?dkw4Q085SEU1d215bEh4WjJRUlNYZHFuQjFJSGV0aEhleHREYjVueWxUbkN3?=
 =?utf-8?B?SU5Ra0lrMytHa0UvdWtlK2N6eEJvd0s1SFd3cTM1eHBHWnJxSFF4Vlg2STZX?=
 =?utf-8?B?S1V4cjlDWjBuQWJITjhnUVNiNVM3SGJ0UFJnVUYzaXBOczdDN09TUFVYVFN4?=
 =?utf-8?B?MjRaZitlVFNWV2c4NXlWYUxVbEN5YVp5ck4yM050bzN5aVBpc09CcHJMOXo4?=
 =?utf-8?B?OU9wYm43bGwyUjJFbGdHc3hzT1Jidnh0cC84YWtMNHNXbzBWYnBVTG4xbHh3?=
 =?utf-8?B?dURzRG1nWmt6UlVLMlFqMlVnWjQwekxEQ1ZqbndVdDFLRFBtUlRLSUdWZUNu?=
 =?utf-8?B?dGFhQ2ZXNGNxMmFHU0hrcUE5bzB5eVNSaUZ3UlRhSjMzZTUwNDNqalp1U0or?=
 =?utf-8?B?REJnQi9jcHl0b0VXd05VNVM0YlB6YTc5TXJ2OTg5WkpHQ2hLdlVQSi9hN1Vm?=
 =?utf-8?B?YjZva0RYRkh5bzJOTXRsa0hQVndIMmJQRjIwNHYrVWVDNU41a1NrejlIODBW?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fc7780-f69b-4a89-817b-08dcdbbe70e5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 10:56:56.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCJlYkp0MipRngqVbcSY0x3WU/obo3+EEkqWE+lcnc+JcTMNIx54pXfG5FtAy9qGnzPzOwE5Ge5MJCcjOnnT5U4RzlU7QMN4bDwj5Ffvf50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10986
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 10:57:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16590

Hi all,

On 9/23/24 9:49 AM, Richard Purdie via lists.openembedded.org wrote:
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
> 

May I suggest doing a split on _ and then check if one of the reserved 
keywords make it there?

e.g.

any(x in ("append", "prepend", "remove") for x in var.split("_"))

instead of using a re string for that?

I tested with:

 >>> s = [1, 2, 3, 4]
 >>> def test(x):
...     print(f"{x}")
...
 >>> any(test(x) or x % 2 for x in s)
1
True
 >>> any(test(x) or x // 2 for x in s)
1
2
True

in what I assume is CPython (python3 in fedora40), 3.12.6. It seems it 
stops at the first found True so we save a few checks.

Now I'm wondering if var.split("_") creates the whole list at call time 
or if it's a lazy iterator, e.g. using yield internally so that it's 
actually doing what it needs for each iteration of the loop and not more.

No clue if this is consistent for other implementations of the python 
interpreter such as Jython.

Additionally, this still wouldn't fix the presence of _remove_ in the 
task name triggering the check. I could e.g. see a 
do_remove_unused_files() in an image recipe for example. So I would 
agree that adding some info in the documentation would make sense to 
discourage people to name their function this way.

Cheers,
Quentin

