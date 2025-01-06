Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C1E77188
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 14:43:12 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.128])
 by mx.groups.io with SMTP id smtpd.web11.60636.1736174583697615673
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Jan 2025 06:43:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=1DvHqfun;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKPlvXkGO6dW+N/MuB/CmZMIqYn/eYMCXIDPbSTh3Bm4MxQV2yKfhq6xl6N+Csyy9XMb0kWWyLnbDgIMY4/uzDz62NytKAVRHxcK2HVTbwGVIMz12yO1Z9RwJSZQgKV4zeGFFL1eKNZuj9MYspp5ncTm6WGUxnH815pLPYpvz8EVH4beDYNMkW5TLkQWPqcTTzghvJ5+eczaUqaOQfVxrOBMZEhLdXTPMecmf9HYqcPFVkzXAhSnNvaY4CeP8fW58k+fkqT/lid6+DELm/X6zX6BqlCbQAbMX9FsMPCRYHYARKuMEcwyuHTCSDDEvGxN8yyIAPhhVFYGz46KoreGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X3fALY6eZuHY/CZUih4UUBv6kYLAHhHW1moRoaEq0E=;
 b=QA6bdYrqhUuY4vxTXYeO+ClI2zkSg581KcnTb1S3WzC63I7NxLvkPC3vL6Dbg3kYvXb3OSSnGF54AV4hf8dKmgdO+Gz7VgFQnFuMoLqOBS7M9OLkzu2urr6+Glx81dLOtW2TlF/PFPyZUQlaQyS+1UdGNRTyddZNhcPfcjE3hygioJjz2xtnDkCUGtA59GwXGOyJ12tZA/LlI4GL+DQ5ObFY6RJXoYyaAH0ctsDD+UAd9fkBysvwGC1b7MQLnoysnXCUgFOY56/zLzJwwfUjYHdNH1yoX6QArYy5wS3bvHbBKWGvOccHfbSG7ALh7VNp2iQxO3DSs966C9BsMlKBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X3fALY6eZuHY/CZUih4UUBv6kYLAHhHW1moRoaEq0E=;
 b=1DvHqfunx3LS7XHjbDnjXlYg/jEVdAEox5ihCgTkBypsDYLs5TFT8mDbcgJKqftVx7T01iZJycXh6ETTIIjVOM+GTq204Mnf1E1S7aeLKw3ksJM5JDBVelwzoP/0hz6cfQiwx20UiKC9SYJWScH30zsVvYSwRJZxebaTTh/oAWfeStcPeVVYvpwzRaSyySFm62zC9WVkC0s/+y/gDMGbIwlyUrCvpg34Nk6A1LhSfooQ8/2AybNhqajyNHBUAiqrzs6jXCNrEM6dlgp6dV90W+fIsUkVN9bXYUqpmprv/fmD+3ay8zRn28xDQWy8XaMyHxyLeeU3XMlzCIPj9jpiHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS8PR08MB7790.eurprd08.prod.outlook.com (2603:10a6:20b:527::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 14:42:56 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 14:42:56 +0000
Message-ID: <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com>
Date: Mon, 6 Jan 2025 15:42:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS8PR08MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 394831df-6303-4cd3-aab3-08dd2e60683e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OWE2QXpPK3JTYTNhM0o3QkZuTm5ibS9KdUpROGV5YXVNN3JLN2VKMnBBRWRP?=
 =?utf-8?B?a2tYVndYbWhxUkZjbC9OS1BUWVVOa21idFpON0VZVmpvUE9ETi8wcUNGVm5Z?=
 =?utf-8?B?Wmg0Yml1azJCUjdFbzhvdlhlK1VLa25ad1RVNVlRaElweTdPMDlGQ3FUWHor?=
 =?utf-8?B?N01HK2dUbjU4MG1TNmoyMHFBa1dYL2MrS0ZKanJNZUgwYktZUi9zVVYweVov?=
 =?utf-8?B?MEdPTFZ5cEFvV0VxRStIU2JVWCtOYVRtU09lSGtGSytxTVU5dDRMVHdIeGtM?=
 =?utf-8?B?NjBaakx1WVRORzNoLzdaRzhpV2o4UTZ6empJWmhFVDhheXFIek0vYVI5djJ4?=
 =?utf-8?B?aFBFbTZ5RytVREQ2L2xBY2lWaDN3T3dLdzA1cklFVjIxS0lxVWZmVEpaak9t?=
 =?utf-8?B?d3JyTkh4QTB2aWNMVWVPZUdmQUJ1L3ZGLy84bUk5UkdTeFViNDFocW9sZHFW?=
 =?utf-8?B?NkI4cVNsSTk1Y2dyelVqM2hsb3d4cVcvdGJIQlMzbDhvc0IyOU9uMnFqV2lZ?=
 =?utf-8?B?a2RmalFGK09tYkdQWWxSSG1SOVAxQXltU3h3UFFINW1xcUdYYkxZTklEY0Rs?=
 =?utf-8?B?bDFreDREYjFLc3A2V2ltRFFYdS92MWFseHdGNlpUVTYrV1F3UWlGMVpsNkhV?=
 =?utf-8?B?RHlXeEVXaWRWemZUczh3R1hPVFplM2pBcU8wNTZreW1TcElQYXBDWUJtREtM?=
 =?utf-8?B?SDdxRVVuQUVpUkpBWnFQUVFLcFM4MlBXNFE5WTVYMDRFeVRIZGdtSmMvQXVn?=
 =?utf-8?B?K29vcDlQbnVLamRoSVY1RlVTUWlPSU1UWmtlQzVOa2ZxbWQ3Wmx6N1FZVjRS?=
 =?utf-8?B?VzA3WWE0Q3dvdnp5azVNVVVablhrdFlxSU5tRi91cHExQTFreFg3ek40VjBO?=
 =?utf-8?B?RWtESUJEOGVta1V6aE5ZejIvbk0xeUcwVDhIbzgwT3ZjSjY0TGcrUHV2bG1G?=
 =?utf-8?B?aUkybDZhV3Q5RGhvZ0F5UHZVYTZucnBuUlJYcGJMeURpOVozaE5LM0xOMmdT?=
 =?utf-8?B?QlVjN3RQbjBDSlYyY3M5WWdJSjRJaGpEU05HelZnekw2VndXSjFYRW5IWEtE?=
 =?utf-8?B?dXpEdGpNbUVSenZOcEFjSzAyOW5DdGZtdlcvQ2s5VGtDdUtRTHpWTnFsTEhi?=
 =?utf-8?B?WTlHN3phVEZBZ3lqNnVEYmYxL0hMQ2dOMU1EZFhYeDc3b2JVaStmMC9oTUk0?=
 =?utf-8?B?TFRyRFBtME1NS3RZYTRiOFJZU0Q4NW1WMVBvVHhraU0xN1hWSE1TMDJPQlJZ?=
 =?utf-8?B?Zk9vVkZnNEhZTXlyVTRIbkF0TkdzWjNiR29Pc2dUbi8wdWxFdUNvZGxNNUtj?=
 =?utf-8?B?TWYyblZkcHIwV0tXZzZFLzZlTUI1dDFkcnhRY3VnelpwU0p5dWtwZWZoNzNX?=
 =?utf-8?B?bCs0N3l6Z0FScXpYcXl1NFJXbVR3d0h5eEIrejJ6NWoyb2o1cG1jN0syUElQ?=
 =?utf-8?B?Z3JBZEhNRzlpYkI3WURRN0tIWk5ObmU5V2VsWDZKMDBhRkcwSEozMVBsSW9W?=
 =?utf-8?B?Y3BOSW1RN3dFcUYxZXQveE9Xb0VxYXpQTW5OeUg3dGFYRFlrUEtGdTBEWlJo?=
 =?utf-8?B?bENkRUZLUytUdURKZnJ0NnZ1UXpHQjJTbkNpMU5LMGticjZWVHVnVXJwVEFM?=
 =?utf-8?B?NEZkZGJhVk12RTFCSkNNR0NSZ0ZRQVVKSEprcHp2cG52YjQxNmxpKzY5b3Fw?=
 =?utf-8?B?U0FSZjJmZFZzamFZUVQ5RWFMSDlMMlN5WjBMWm9aL2hqTnRtVjUwWjFHd05X?=
 =?utf-8?B?aDZyNk9samxvL1dreFFLaXU2MmFQc1lDWllLVzRWeGFmTWNUQzNtdEtJbDI3?=
 =?utf-8?B?V2ZPWTNIS0RpTXA2QlNlQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkRzNEc4c0pnZHRBVnMyNkRleXl5WG5RNHh5NmtUajZwWDU2Zmx6QUZQb1Vy?=
 =?utf-8?B?a0R5eWk4THUzQTVsUDJFOElnUEtpZTZ1Q1JReUxoamwwTVpJd05QRDg2cjZY?=
 =?utf-8?B?aFNlU3BqU3JXNzZkOXU3NkVEZTVMVWRZbDE2bE9zaDhpWmdjc1M3N1FRK0xr?=
 =?utf-8?B?YUsvaXRZUDFCRnltS0c1VVRsWmVwcTJxM0xlSUdVckxqTnhOYnJ4Yk9TRksr?=
 =?utf-8?B?Q3BQNmhJcVZTaWZQUXRqbEdUajFIYUYyc2czMU1pSnBhcXZIRDdFQi8xMEd0?=
 =?utf-8?B?bkhvYWxZZTQ1WEtJVFUzWVQ2NWVRb3FWZmFEWG5ZaGcwSDBvS1gxKy9xTTdO?=
 =?utf-8?B?NS9ma2VUSTJhczZyOHVWYnN5RmM5VUhONGsvTmhKNGZXNi9MSzFlR2RhR1ky?=
 =?utf-8?B?WEZuNEVGazZ4eU1xTU5RZ0VFUk52NlhDSzNVTE0yc3hVMmRUQUNVTGQ0Umlo?=
 =?utf-8?B?cjAyQTBZeUVleC9lMTJncGhVUnZBdnFXcnJHTmhsL1krRXMrSnZJK05MSElH?=
 =?utf-8?B?V1hqcEt6Q1JlNGZpeHpoZmRqOS9DT09YZWVSL1NidkpMUm42TnZqK1dGQm1P?=
 =?utf-8?B?eGF0dmw2SXRXWWVjeHpPcEVpRHlFVVY4LzVseExRMVVMRmhNa2h5d2tyeVB1?=
 =?utf-8?B?b1BKMTl0aXUwUmNQdjhMQVRGYkxuamVhQzRNN25pNDFCMndnRE1ocGpPSXVk?=
 =?utf-8?B?MExpSkZzRmU2K252a2k1aXRCVGFKUW8wdDdod2pQWXBjZzhvU2pweFVTV2gy?=
 =?utf-8?B?dkVlV0d3dEF0VkMzTzFhYTRFUVlrTG0xMmtWSGF1bnM1dHFMMVdwc1VKc2RP?=
 =?utf-8?B?Q2lDUTFjSE9aRTJJTDZSWWJxcjR1MGwzRzdRSWRHMUtKMitIaXorRGxFY25C?=
 =?utf-8?B?RDNGYi95MkZiOU5sTjNzZnFjRUpOaG1GSWdzY3RybkFSdFhaL1k5U0wzdElH?=
 =?utf-8?B?WDA5ZDIzQmhXLy9lRHZjZEx5dUxtakFybmRMNXlTUjhSRnFHcFhFN2xiR1hj?=
 =?utf-8?B?em1IeGwvK1RLS2ZDUk9acDFhZEVobkYyUUF3UnoxK0FndTN4NVd4VkNYaHF2?=
 =?utf-8?B?NUZxME93bE5NamNlZWdvbnZjWGg2N0JKUkhBTWxmdVJnZWtUeDhpL295QXlw?=
 =?utf-8?B?QmdoNFFTS3M3THpsSmJEdmJtczIwdGlnS0MrS3ovS0hYMCtFMzR2Q3VCTFVy?=
 =?utf-8?B?RVJWb3RMTTNObHBKZE1aNDNnL2wxNUNJTUpPNDl6WUFNTGwxVjFDWkphc3dj?=
 =?utf-8?B?a3dUcGhUQm15cSsxb1RnWXVTTnRoWHI4V2QwRXNSbHpBWCt1SmVLNDhZY1No?=
 =?utf-8?B?Z3B6SWcrd1FsVjEzNnkwKzhoU05xMnpuOCtIRFlBM25tTG40SUUveEVRMVlJ?=
 =?utf-8?B?QmUxa2kraURsVDRXQlpSTkdRWWZsWFU1WjErd1Awa0xVendlN2I5S1g2Um9s?=
 =?utf-8?B?SXJrb0RLZjJ6dWRjNEwrVVRYeGVKVDNWZ251ZmQwd04wWjVBWW53cUVXTm1s?=
 =?utf-8?B?U1BwNXVDcThzWkpoOWdNN0hFWklDdVRGcjN1Z3FJUFNIMjVBNzNodGJUV2Jo?=
 =?utf-8?B?bzQ4empPSnN0dnpXQ0JybnNlSFoyV05ENFVCbUh5TlRMSzV0UFRlaGhacG16?=
 =?utf-8?B?aWZ2MlN2Mk5DRnllRnhSWndvSGJDbnlqekJZdzQ2OUh2anl0V3dhSEZWV0U3?=
 =?utf-8?B?ZmRRZERmSU1EOTZqVDM3NHljdUFFZ0h4cTc5NGQxMkVyZDVrM0RDMjB3VVlY?=
 =?utf-8?B?dnZnSEZXblZtbnlUQWF4amd6QU5seWNOdGljM3dEREQxMzgzc3J6L1FVZ0V5?=
 =?utf-8?B?Q0RxU3Z0ekZHYjJnU0hnMVJSaVZvN00rVm5xbE8yZnNsU3BBaVpoeGNMZ3l3?=
 =?utf-8?B?dERVRGZXZUVVbUhWcUJ5QnFFK0R0RU1CQWV2SVUycEtMUjdpRzhNbks0cXZB?=
 =?utf-8?B?VGIrSEoxcWdERm9wbTJEMkdhYmFyN3IyUFUzR1pVdEU4YW5hU3JNd2c5WjRL?=
 =?utf-8?B?KzhDTEZvNndmNVlLRFltWDhtV1VTeE4wT0lONHVxdm8rU2ZBU2RQM2dYSlAy?=
 =?utf-8?B?dHA5akJFQnR6TU9JRFh5empFMVVxOVZZblluNjJod253cjh3bVlJL2g3QU16?=
 =?utf-8?B?TVg5OUkyNlMvRlQ1Mmw4RzRvUHV5SHdDUVVyWmN5dWQ5RjNvaXNzZXdOcTYw?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394831df-6303-4cd3-aab3-08dd2e60683e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 14:42:56.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0isPPKNdcwV+TrYbYVvaDpP3E5K7utKepg5Dp4IpkYd98i+CdKLrhaCyPJfTD+ybecAJF3ofgtv4iNlTMUX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7790
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 14:43:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16968

Am 25.12.2024 um 16:17 schrieb Alexander Kanavin:
> On Mon, 23 Dec 2024 at 11:03, Richard Purdie via
> lists.openembedded.org
> <richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
>> Would you be able to check if this work meets the criteria set out
>> there and if not, what the differences are?
> I'd also add that this would benefit from a demonstration with one of
> the real recipes go/rust recipes in oe-core: basically it would be
> good to push a branch of poky somewhere public, and provide
> instructions on how to see the new fetchers in action, and observe
> their benefits.

https://github.com/yoctoproject/poky/compare/master...weidmueller:poky:feature/dependency-fetcher

I have migrate the crate recipes to the new fetcher and improve the spdx 
2.2 class to include the name and version of the crate dependencies.

You have to inherit the create-spdx-2.2 class and build the librsvg 
recipe to test the new fetcher.


