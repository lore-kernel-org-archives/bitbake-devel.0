Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D87C53210
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 15:03:42 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.85])
 by mx.groups.io with SMTP id smtpd.web11.65362.1672758211529254499
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Jan 2023 07:03:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=dYoaJovX;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.85, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bddu5AAfrdQaK/5lOZ3JTV2iDsTBnMqHG6DZvSwmtnF33lp2D9cTz4/pRvpvFu6eUVwOfYbetcNVU5zYKW8xch7/8gMoGHEnMoSd4dswLXC8gsvyPpIqazQbsoA3MpEEbfshYuNy0cwc6s1VfmDlSBg2mSYEKOSROlWrx+EYKB57Jl8YxyYXDM+Z+VOeFdc/z4HHvYTkmTKay54fJe/sPLPPTjTj6ikAkvT9Z4/U6xzIsIrS1rZ0rFFPJtqqjDmiIFF+VBqULu2xMHiDJd2T2FqhDX9gBenl5cbXdXGKVJ+r9fMCJyMm5Pg7uVOaP1a37RHOGqQZ6ksDRjhQHs6kRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6D8ASp2ejz0h+DYeFC/v1UScdkyOvcH69a2DANLmjI=;
 b=NA86WH9Z8/GnDgLtCCGpD0UoLuMnTWdyf/saj8MN4dsVibiKd626CNUXCSXzyTg1Bay9LibVV9IlaiPZfuJQHRRErLa0SAFq9j40KLJQ1nAWTISdSg/BCoXVMTYs3jPJi9ehY/tsEg4J/8B4GFPc5Xe4XvPjmBi6xhVdRNvx0WTA6yMskqLJTfNMUR0X6VpOo5vcsdF5swEe+yZnHyjxkE/qDVZGtr/wHte/JYYSxNV9kd8qiymVAVK4t22zeZSSR0tPZdofGRfSGCCrR8lqA1u6wwP1srBEvizLIoPStUbVCxUV7Tx4nCavA7KB+2GwBnodtrlcIxnBDyOm9TTkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6D8ASp2ejz0h+DYeFC/v1UScdkyOvcH69a2DANLmjI=;
 b=dYoaJovX0+Xxa3BrZZIT6DOa5qd2Xy3HHMfc8fq6Nyq+Qn8SjNeu+/w8QCFyzbwDSyETTSudTKm+fNSUvYXXjlFqMycjfD+2X83MR0it7pA8mU2W4jd8ThfnQNtrXwfoBXXStaH5dBaC8Y1lA0xKWa8fmp9ondGxQ9zk4nBSWp/0C4lUowmMTN2I+RZ1xphmHZIn5ezmmCRIHylxuJXu0ORLiHVMqDYf/q/xqBta9hpGAAEWBE79zuyWQ+llr/mUGrIL6KwsIpaxeF5Lr8fuk22GAwETu7gBNqL1w6+p2YNoMm6nzUOO6Sm36EcW10wgj9K7gM1EUe8P9slQhl9MNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8542.eurprd04.prod.outlook.com (2603:10a6:102:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 15:03:27 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 15:03:26 +0000
Message-ID: <10502f22-575d-3917-374a-8c60a7e9bf32@theobroma-systems.com>
Date: Tue, 3 Jan 2023 16:03:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bitbake-devel] Typo on the BitBake Documentation
Content-Language: en-US
To: than.matos+bitbake@gmail.com, bitbake-devel@lists.openembedded.org
References: <bWm9.1672174859052782246.2l5k@lists.openembedded.org>
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <bWm9.1672174859052782246.2l5k@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0179.eurprd09.prod.outlook.com
 (2603:10a6:800:120::33) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: aba4ec16-a39b-4469-c610-08daed9baa11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t5dflD6WqQ581sNEwfDNJFBNyCBLy+T+b+RoQ9awjKhGsf6+DvsQgj26aUFh++4+82SiIWQNbX7A+C3okAvaL6J09AiGJB3a8TZgS+aJng+VTttETrSH9xVmwxeTZCRz4F3ILu8H9TkhgixrsV3qPXZ938ZSpn/K4HtMHDITtVbLSRjASbMzYKCHiXrzeAG5MVHZoA1bUst3TqcJ0PkCOm1jXb4haDexYuswEsRD1l7VMDYJ4blhuknw9OuUZ3URnMs5w/uJuJKWYg8le0Zt3dMjS9r3AuIMZNkHQJSq/XyACufgNIr1KVnMZXPzcaCYtZUUfrY6zRrURVKuhl4VtISMjMdfvALVvE98WPASAOhKBdh/fefpsJ2rbr5WjjbE2q1kzCVUQN/RG55+XEWy43BGUKb6BV/318usFMKGFrBRYoqCjYeSbKsfHZKeWsnAbII5QaW6b55tPNgbK0xwOQqV8lFw//CUa6Hz/BLpJ88gx1t7geJi/6VI2aGwV291H0Jh77N9HsAIAYxLt9K+nrXPNV2aK+1COffgLrsSYOIVh7U71nIip81dIW33k/2l8M2C+vty+X2yotO/R2Q/cfX1DILD42CAfQQHkd/jCxlKB50mQ2HCdFFXLzza2Ru/28WVVqwfJQdSq+KK3FgthL1yvrPhRnEfRZUH6sbF8V4MLedSIopmOPNCQjXnLr8oNj2SoutTXj4tj+7sUc9ArfH+mYRM6Uos4cXWmmeB3NMnswpE0IRX1Szge2rwSFs5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39850400004)(346002)(376002)(396003)(451199015)(5660300002)(2906002)(4744005)(44832011)(31686004)(4326008)(41300700001)(8676002)(8936002)(66476007)(316002)(66556008)(66946007)(6486002)(478600001)(53546011)(6666004)(6512007)(186003)(6506007)(38100700002)(2616005)(31696002)(86362001)(36756003)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmkwQlBlellKc3k2bWpZcUp3TFJsTDh1T2FaeDhreWtJZndnczI4WTlqWmNC?=
 =?utf-8?B?dG9PcGhsQmhuVldaZklhbUsvRTR0bTZ1WXB5OGlIbXRRZitrR01TM0t1OU1v?=
 =?utf-8?B?QkErQlphVHErQ3pHcFlRT0c4ellLSHJudGEwUmdnTzFhVUZodFRIRHkzcGNl?=
 =?utf-8?B?Y0FiWFlLRlA0dDNTSXRQazd5L0hYVXNzRzhDTWRDYk5zck4vZjBsWGhNbzMx?=
 =?utf-8?B?eFFZejBUZEk3Y0JIQnR3dGF1RHdqVkVaMjEva2tFbWplSTFwQndCV3BNNWhL?=
 =?utf-8?B?emFhWFlsRFdVdDFKaUtiSVFVenk1ekZQUEF6VGhPdjZDcklSMjJTb003dHVU?=
 =?utf-8?B?VUo3MGtwTW55ODFXYm5IN0tlMEVmNDZMY0J5TXhtQjlxQmRFdDZEeVpDcWVO?=
 =?utf-8?B?NnNBNVNadmVGTVpYeGZSckEzNWN2WmJ4RE80MmI2dzJJeHFkaXpyTTlTYXZY?=
 =?utf-8?B?N3l1MmxoTUY2bHVmWHZnUzhqbTVhdnFCSWdPUTlGYTNXRjVYR2phVEZSWk5v?=
 =?utf-8?B?M2h4SWdSMTcxbHFndXZSdnA1ZHpiM3Y3NWpBSjZRQXZGMVZldng1OWZaT05N?=
 =?utf-8?B?eWIreFdWZnJFK3MwaUpnY1p4WENjN1dwYWxMSFJIbFpsZ2xDTWZoOGVwaG5u?=
 =?utf-8?B?S3hadWdSUEM5ejdKb3VPbDRrOWtNUjB5djJ3UFR2dSt1NmI5UG9VaWN2OERm?=
 =?utf-8?B?TW9qWTR6YnhFOTh4bityR1ZZaHl6b1plWU01dlhyZzkwMlF4cVhLYXpPTmJu?=
 =?utf-8?B?R2JvQW9wQ0EzcWFrM1VCditmdzl5UzdKV3V5Y0h1QnFkdUZpK2QxUSs0bGtR?=
 =?utf-8?B?d2ZQMUUvQktteDhKdlQwcWRSSHBNd1pTZWx6QWZrcG14YnN5T1VGNytvb2tK?=
 =?utf-8?B?MWZHNEExdWpBdHNKY2p5Y2thQzFPRWJpMnBzOXdGK2hMNGNSRndHTEpnYzFQ?=
 =?utf-8?B?OGdEdkd0bjI4U3Y1bldqSEE4NXZRWDdub3p4WEk4bFpkdmxKeFpLa1dvVC9i?=
 =?utf-8?B?eTZMUko2MjBhT3hmZHFTeU5JY0Nvb0V1V3hQNjREQjRWMWEzeURLM1lITFJa?=
 =?utf-8?B?RytuVHE3ejJrbTlNRkhWOGhFZENVZm12K3VhZWJzbWJvZkhMK2piVlhXbzlj?=
 =?utf-8?B?c2dLMzNSdkl4eHp5WmZrMXJvSGdUVUNVcEFINFpTUmEzMVg1Y2dkMmI1dFJB?=
 =?utf-8?B?ZnZKUFhXSnhtQ0c5eE00OGwvMm9UaXkxQ1gvbitQSGRaSkQvRXFUUnBHVFJ2?=
 =?utf-8?B?SDlmUVc3WEtuNjBYTWd3b045UzVUYVVLakRDZURDTjA3VGx2QUM0ZGJaSHdU?=
 =?utf-8?B?elVmOUhlTWhCeWVoaGRkaFkzM0dtL1BqOEhVcVgySVhGYXQ4VXRBSkU1WHFL?=
 =?utf-8?B?Q05tK2JiakVKTnBud3lvVFNuVkZjMG1NSFgzTm5GbnpBRGpMMzY3b1pzZkpE?=
 =?utf-8?B?MjJiUzc2MVZyUkE3OURoYjF4M0RITFFyeHlJVElIOS9rNjFNSWtteXAxMHN0?=
 =?utf-8?B?UDVuYVlvWHVuQWRxM1VLMUtNMWkydlZEVjlnTnE1TS85SFFpMTU3WHp4clEz?=
 =?utf-8?B?Vk9ZK0g1QkgxVk5kZFVSM3RMS05xbUJTSWR5NnRRbThLN25BcjRxVGtSRkhG?=
 =?utf-8?B?dmw3VW01YWF5bGh4UDMrenl2NEliUTg0L1dDSnRxZTExR29qcFlxakw1S1BR?=
 =?utf-8?B?dnNqeEUzaC9ZWURsdWdENFY1VjdFZjBMekhVSllTakpIV2JoZE9sZWI3Y3k4?=
 =?utf-8?B?MEUvVXpNeFFOeWh2ZVJzTG1mVlVUejJuT2t3QnZaeCs4b2RneUw4U21LWG9t?=
 =?utf-8?B?RWwxZkVBNnpsWW8waUZUL2M3R1BOSkdyQVVLdU5SL01kQ2ZBck5mRnIrVncz?=
 =?utf-8?B?dWJTUUVzb2xjc3ZSU2pwanZTTU93czRLOXdCQzUxVnNXcGp0cXlXeC9XY2lR?=
 =?utf-8?B?Wm94OTdTRklvUjM2QUxPVXdYYU9EU25PVE5KL0NPQ2pZcXQzTzJXRzdSWXFW?=
 =?utf-8?B?Ny83dWt6WXRwWTVhaEN1dVd6bENZcFlrN3ZYQjBUSzltNFRsZWt4Z25TZFZI?=
 =?utf-8?B?SUVFblpoMjdweDJTeFJ1RXVRT0tyY3ZxcUdYTUtERkxjeDY4dU04ZHNCSzhN?=
 =?utf-8?B?UVMrTVRHRHZvYnFaMFArWENaZmVid2orcTA0WTdBdU5iUEc4SXFuVjdIOVZQ?=
 =?utf-8?B?S2pJUDJPTnA1bXIxQi85K2RaUE85aWVQVHhEZS9sU2dEMEZETUNMQkdSVUpQ?=
 =?utf-8?B?cGM5WFVRczQveTYyOXp2QnRIcitBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba4ec16-a39b-4469-c610-08daed9baa11
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 15:03:26.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czJFjpLdQ4ki8Rrt6QDDJO+5Xlj6Ys7TBNECY4H3CCWShsOTVBi2+ycNoIsm2FIUnfJW+Cv5hp1GPq7qznt3FeAQ4XlE0CmL5RfkWwWgLoZgxWwtqA/0aBwq+RJXeJTB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8542
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Jan 2023 15:03:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14281

Hi,

On 12/27/22 22:00, than.matos+bitbake@gmail.com wrote:
> I'm not sure if this is the right place to report and if I'm writing in the wrong place, please feel free to remove this post.
> 

This is actually quite a good guess, just adding the yocto-docs ML to Cc 
recipients to notify people generally interested in docs.

> I'm also not a native of English, but I think there is a typo on the BitBake documentation page.
> 
>>
>>
>>
>> You can obtain BitBake several different ways:
>>
>>
> 
> I feel like there is a missing `in` before the word `several`.
> 

Both feel odd to me, your suggestion more than the current phrasing 
though. I'm not a native speaker either you'd have guessed :)

> Sorry to bother you!
> 

Thanks for taking the time to report this, I'll let native speakers 
chime in and decide for us :)

Cheers,
Quentin

