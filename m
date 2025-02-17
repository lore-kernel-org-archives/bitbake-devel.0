Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6762DC021A1
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 11:00:49 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.135])
 by mx.groups.io with SMTP id smtpd.web11.48555.1739790045074428978
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Feb 2025 03:00:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=PhcIIjaJ;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.135, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoetEeg3himcjmLnjNQyLLHHC2Efk67MN5s9fMQi2RsJ3oUhn7fGtRjmSbgy0gan1Nwm1tDOCz7/lji3ixUkqpkYIgeRrLao0jF3x2J4XnkP/c0C4l8Eebw3Lh0xeDSjbKMWERfLqfmLncVUDlNt9NQAkNIcHwlUAuPk+yTJ3lsVpGvfUUYAzDB7giKpRWElJq5IkYEy2p1MwcdEPqAG7kOl4h6Bl80DShnjnzaELNDSuE2AbgCxnHdHGqmdjMkjbcabLsog4CHEDu1chBS+dMG3OZfEtBLdhfD9rfSmlWOqnww2qfFCRS1EIkMAPA/zsWe8cQTmwzJBfZQ5ek7Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av/FpKEi64Nk4Kykvh/UKKjXnFig8hKvJ4ECZJ3hxzk=;
 b=uTfWIEBoigNxmyv3iQjIjM8+hQvyFNkf3ZO4lP6HU7xoFFTCpgz9+3dBONPYgp97/ZtMHmKi370qxbRD7jDXxhkYv7SFSoen2A2JcDe7L3M/Vw9SWRjDGMcQ7ZSk8Tkeg6FNZKaKQSHtPFQFGx6LQTHi8CxlmMV/At/fW0L8ZGig1UF6hIVU7gId1HEfpLQGQqGiEgL3oGy4JWNrkyO2UmQ5vgI/gJsieQkV0WBhzGmGqp0w7qa+Y+4UBg+j/lZa7qVY1ssUTpGCKvK4Q44DCTLd1V15n8TBeg5vNIaks7bt64hF6sKGn94+3HFGut+lDfryyRCLa12yVnEUccaKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av/FpKEi64Nk4Kykvh/UKKjXnFig8hKvJ4ECZJ3hxzk=;
 b=PhcIIjaJL6IDIq514Twgw4bzNg3Dqpt+quQjfLpsc8Xa+Vnsp2YEgOb0yiP22jWIkSNhFEMtyK+zNDBbjHgIVxNHqIgChY6bfPUOzN0DHGyXEoqrqbTOFGE9bIrIdYkPLOlbapozX00b0t00dg5kNSl/m43zC1K1gjS911R4n4WmH5KlVxBzQ4X6D+PTHHjcZCPZIvp+7bHh0kzL0QNK6UwEVYTIQhhE7HKhUi38MCqKeZ1v9yINXeolX9GNkQMnXRmEEkUENWyIk2hhqegRmEppsEEiF+5IH3MrML9uglUIWre8Ml+OxTgrJDqCyOiZYpVRQB7TUxfBxpyecu81dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GVXPR08MB7798.eurprd08.prod.outlook.com (2603:10a6:150:4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 11:00:36 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 11:00:35 +0000
Content-Type: multipart/alternative;
 boundary="------------PAiKfbLXTIJO0ymfF0CWeXA6"
Message-ID: <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
Date: Mon, 17 Feb 2025 12:00:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: richard.purdie@linuxfoundation.org,
 openembedded-core@lists.openembedded.org,
 Bruce Ashfield <bruce.ashfield@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GVXPR08MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 73193bc5-5300-4998-c071-08dd4f424e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dkNETVQ5eGpJa2RoN0NvTzNCNkxZb0oxZTdBZEc0K3U3cGFvNzRpRkp2R2Fa?=
 =?utf-8?B?VkxUTlNvOFlHY1dud0lSN3lLU3ZmUXRqSGVqSkpKUURLeWdFajAyRkhxWTFM?=
 =?utf-8?B?bmlOKy90UUUvb3dxekMyQWFoUzZOeVdiRmpRLzcybnRJQ0cyUTExQjVTWDBC?=
 =?utf-8?B?UnRzaG00ZmU4bmN0a2IwS0VoRWYwYU41cG4rRTUza0pZa2IrR0JETDA2cXdj?=
 =?utf-8?B?OU9RMFVqVUxrQUVJRklaSkczSDNacG4waThPazRLZFczblZCRDZvWURpT3Zs?=
 =?utf-8?B?U3QxaDE2SGhnc0VoalR2RFRUOXRwMUJpSlg3ZVVzOXVGZUdQc1FQTVZVYW81?=
 =?utf-8?B?TGNtUW9XTTVOQnhybkw1eWZFcjBKVkNCUyt6elh2emNWVXJCYkRXcENTRkZy?=
 =?utf-8?B?Njl2RWdiWmhZSk1nUWtZRFdUM252b0tZWDFodW5iM012aVRxOW9xVGQ4Q283?=
 =?utf-8?B?L2dLRS9EdkZRdzVsalNnTWJqMmFEVWM0Q3dpdGhQd0QzcDlJdlcrS1FDOGpW?=
 =?utf-8?B?ekdKem96am1GaEtONy9TMEZ4Yjd5dDFYSFFWRnJFUEtOQSttdmJ2emxXbnBK?=
 =?utf-8?B?N0JVRUVTNVU4NjFPMjlIaFc1Yys0SlhMbWdBRk5jb01ReHJjamRrb3RQS1M3?=
 =?utf-8?B?V2d5VnBoTDlVUmRKdWJJM3dZZzVET3BnaEpqN0pYVkduakIwOTJHUXJyWnM4?=
 =?utf-8?B?R0tva0JXSGo3bHFBRnhEY3Bsc1FQNURVSGFHNkVRNjkyK1lWU1JwZjdLbm84?=
 =?utf-8?B?MUIzNHJINmlDb3NCa3hwUTVuZXJSVHFjVDVXRkJnOUhGUFJEajlaMEdLblI1?=
 =?utf-8?B?WU9yQ1NkKzg3ZkJyN0JmWitsNGlGWFRMWkx0SXl1RmVsNzQyNHBIemxmc3Ey?=
 =?utf-8?B?RDc1NmR6Mm9tTUVXNFkwSmtIU0ppYlFyL1FyTnhTaGNmUEs3QnlnRU1ZTTkv?=
 =?utf-8?B?RzRveHphTnIvWTdFbVZCS0lYVVdxdWwxY3FZTk1sWUJtM3Jtek1VL3QyM0Rh?=
 =?utf-8?B?TGorSXhDUE1OZ2hzTEUzd1VwUmFqVEYzZGwreDNwc1VwZENmNFJwQWhjTTVr?=
 =?utf-8?B?U2diREh5NU0zd0FGRm15bUllWUFDS2xhZVkrZThja1d5dy9GTjI5WXQ2dWlh?=
 =?utf-8?B?Q3RzQzVtNDRCRGN2UzByZzhtejBiRTRLSXJBUEhIVWJldGV0UElCRXdhYnVa?=
 =?utf-8?B?UFNJM3dZRkExN3BsOGU3U2NseVIvY05yL0h5ZkxOUWNnbzd2c2d6Z1hGS2kz?=
 =?utf-8?B?U2ZKalpYc0luYjhSNm52aCtDdFgrWnJvK09oRDhpSTBRTHluOEI1b1NIakgv?=
 =?utf-8?B?dDBQWWpsSUVFbS85UTVXZ3hrL1VhaHhqcVNyWjJMeHhybXNUL1BZRm9DcVZG?=
 =?utf-8?B?cXhFSXIxbjhXR2ZUWjVZUjdVNk1pVzhiRTdyTkUvdVplNVdTMk5ZZW0vUmVC?=
 =?utf-8?B?WlBJRVRYWmpHS2xtK0dRR1pVMUZ2cTFMem13M20vcGVxVXlkanFlMThSNlo5?=
 =?utf-8?B?WE9DaENsNVNaMkVVVkVWaXFmbGMrMXdubXA4aU5jM0ZqOFNLVkZIZHVlcFN0?=
 =?utf-8?B?WC9jK2E4d1RGSU9XR1pYM0JnMmkra3JHVnVRNi9lK0NRRTN6U3pYcXF0NE1z?=
 =?utf-8?B?aXhZL2ttNk9QZC9LNUZPOVVudWIvNTNuTUE2cjdiQm5FU2RTc1Y2cWd0WEk5?=
 =?utf-8?B?RDZDaXEySmt0VDF0TjdOa1lHR0k1UzNmWjlJL0IzNnQwellrNEkvMjM2NE4y?=
 =?utf-8?B?dGZVclF3TUVxN2lpR3NJVm9ueE54YVpOWVNhVmt6YjZNczRRTDFTQ1JVNGZi?=
 =?utf-8?B?QWljWlB3dkgvTm1CMDFlSlZKQ0d6Zk11eGNnRkFzMElvV05XK0k5QktnQ2Qr?=
 =?utf-8?Q?3g6MR1CMASmDW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFdJdE9XOFVrQUFFblc3ck40QkpqemRxSE1LbDlVOXA1WGNvbXI0dXZaOFJj?=
 =?utf-8?B?aCtqRUpZN2E3bUg1WDZVb1kzL2F1cE5VaktualZlY29sYUY0VGFYU2x1d1dm?=
 =?utf-8?B?V1pnWWpOSHd2ZHBiM2pmWFRWaTlSbExjZnRjaEhnMjlIM0Jtb2daZkJxUEh5?=
 =?utf-8?B?SW1UNjVCSGxYZDlyUmJkK0gwSkUzY0dvWEhTdVRLbTd3TFQvazJvTHNhSmhs?=
 =?utf-8?B?UXp6VXRYUmtKTmF0cnNzKytHc3RlVFpBcTY0T3RYWW9zL1p5R1lQMWFKZ01q?=
 =?utf-8?B?cCs0YUFRNmdBVXdmekpNVlhFZUczMGljb0R5QU9rSlI3eUFRWWtlb3hJTDRv?=
 =?utf-8?B?Z2UrRVFPcVZITlFBZDA5b3YxV0FpaWZOczRyUEpPZitqYzBydkNzUFYvQUNv?=
 =?utf-8?B?VEN1VUF2R3gvWGhwSEt2QVVyK2l3NlZHMytOL0c2R2tIZjNzeTdneU5LMEFQ?=
 =?utf-8?B?RnBWNTJxSVhqSjdINExNUUhlS3NiZVAxRHluR3lNOXZqY21QQ0ZzUGpyazlH?=
 =?utf-8?B?MFBIM1dYZWVISEZ6bEM1RWdDMlBVOHl2VG43aTJyYUhEYllpQXNCNWVUamVP?=
 =?utf-8?B?S2RNdXhNQmttYjd0ekxYL05MUWRUaFdSUG5DQlRJc1F6R2JjY1pJRUhlNnVn?=
 =?utf-8?B?clZ6ZXJ5dW1LV29FejYrQmRJRWt3Kzllb3RnK1hGWmFFY0VVcFo4TXlSL3BH?=
 =?utf-8?B?ek9IQjBZZUw2bFdzRWtMWnBsOTJlYVJpNXFYOEtpNzdyYk1jWEE0WllvUWIy?=
 =?utf-8?B?dG9hTDF2UVdNdXZ5dEMybys1YlM1SU82cEovVlBmSHVRaEpuMkNnYVUyNDF3?=
 =?utf-8?B?SVhTb0ZXNWhZY3N6MTlYSTdOWHY3VjB2VUxyS29TOGh3dnFsbnF0MlNGank1?=
 =?utf-8?B?Q1FHajIrclJvTGFrd1BYVXBzS3lmY0NiUnVSN0plNVlvMzcreThlOTB1WEdv?=
 =?utf-8?B?alZydUZmMWNtcm04YjJHQXVrWmJuZlhvb2J5UTJKZjA0dlZvYWFuZXhYcU1l?=
 =?utf-8?B?L0NqNWdqSU4vd1E4aFBjVVZkbjlVaXhNK0tqMW5uTlVqd2Vndzg2VC9CZ1g0?=
 =?utf-8?B?WkQ0WEhRdUlIbFN4RWZVNzBFVFY2SmphbXJqYnY3OEFQZGZBaEszM2F4OWx3?=
 =?utf-8?B?d3VaK3FyYjhqdXNZVmZNdWFBRTZlNUE2NnlvSjNrRjJaTFlnd2puRXUycDlm?=
 =?utf-8?B?YXE1RFUvZ045dTRRMUphTGxhdXRmbDZiTS9oa2tMejFtNXdrTlVUOC9JcTcv?=
 =?utf-8?B?Z1I1Y09RNkZWVVBDUnhJSy9yaFRvaXh6WFlWRWl5eDRKRlFOU3AvdFJLc05M?=
 =?utf-8?B?T2FSdFduT1hJanVKMDBIMmhDK09HQTMxNUxrb2RsaGh1bFNuMFMrbTBKNm9B?=
 =?utf-8?B?QVUyNFBFT2ZtWmduZCtnZjYzdXBPQ2Vuc0hHbFpuR3BPZHRnSC9FMXdrZUZI?=
 =?utf-8?B?T2VTc1VmYVJtaDl2TmRjb2hpeGR1SFJMQmNxZGxWRlRhbUl3R2dVZHBmTzNQ?=
 =?utf-8?B?VzhlTGwxMDhwc0lsK01rUU1FM2x2d0VQWWVveTF6TTd4YVI2Y0p4eDI1Zzhx?=
 =?utf-8?B?bmFaeUNneDg0T2NwYS9vZ1lUMnFLZ3dBQ2lJNGliaG1ReXA1NEw4WjRGS2ZT?=
 =?utf-8?B?K3V0Zkl4S1E2czcrdFJGb3N6dlhjOHFjRlFYbktEdFJoSldOZkRlLzRPNGo0?=
 =?utf-8?B?YUhxT1hvR0NYRmFjWEF1QkFtaE8wUlVLak1ZRTJkOFhmQklkSXdLb1pyY0dN?=
 =?utf-8?B?N2dYV1EzTFpMbDcybnNSaTQwV2VRZW5tbVIwd3RGUkZtNnhrVTAxSWNDcDNq?=
 =?utf-8?B?M0V5MzMxM0o2cVhvYVkwUldIRWJDNVJMNFNJcWZnb0dBa2pFY0dPS2hDbzM5?=
 =?utf-8?B?ZG5vQk5oNitXZ2ZEMnNmb3ZkNDRLL0VHMVR2SkFoVTg0aklFVUdCVGF4N3cv?=
 =?utf-8?B?NzU2QlJVNG1vMEJjNkdVeVgyTldOYmJSQ3pobU8zL0RlaUxHTWhNKzlRRGQz?=
 =?utf-8?B?UE9qQmthSk04MXNzcVdSbUFOYzV5dGpSRW8zZDlBam9MYTl5ZmRGSHpiKzI4?=
 =?utf-8?B?L2FnbFFUYSttRStqcFA0ajFTcmlmMEJKeWJ6dnFRK2xKOFYxM3Fnd25zbVd0?=
 =?utf-8?B?U3RyazM4c2k3cXpEWG5MSVhNYUhZbFJLdkdWQ3JlSVpGaTc1SXhwcmNrcE5M?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73193bc5-5300-4998-c071-08dd4f424e38
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:00:35.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W59KZkuBZ9k2BO44LQs16aeMs2yqI3XN/bEqYrmzOnLGqTC0fZRDSgt+dD/8Jy/Bya68J4XOC1H4R7zbKOk2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7798
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 11:00:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17232

--------------PAiKfbLXTIJO0ymfF0CWeXA6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedded.org:
> e) add the ability to add custom hooks in the fetch process to handle
> the cases of needing to alter the flow for patching the components list

I fear this isn't easy possible and we have a design problem. Bitbake 
and oe-core assume that a patch doesn't influence the fetch and that the 
SRC_URI contains all fetched sources. Many code use the Fetch class or 
the SRC_URI direct and doesn't expect recursive implicit URIs of gitsm. 
In reality the SRC_URI describe the given URIs only and doesn't contain 
the additional implicit URIs. The task flow applies patches after the 
unpack and prevent patches to the gitsm. In reality a patch could 
influence the implicit URIs and isn't independent. I would recommend to 
keep the patching outside of bitbake and instead handle the implicit 
URIs inside oe-core. We could write the implicit URIs into files in the 
work directory and migrate the scattered direct users of the SRC_URI / 
Fetch class to a common oe-core function. This functions returns the 
given URIs and optional any additional implicit URIs. This allows the 
usage of the task dependencies to ensure that the implicit URIs are 
resolved before use. The package manager lock file needs a single unpack 
and patch step whereas the gitsm needs a recursive unpack and patch of 
every successive gitsm. This makes it impossible to use additional 
tasks. We could add the resolve of the implicit URIs to the fetch task 
to support recursive resolve (gitsm).

1. download SRC_URIs 2. exit if no URI is marked as unresolved 3. unpack 
unresolved URIs 4. apply associated patches 5. resolve URIs 6. goto 2

This will eliminate the need for the partial implicit URI and gitsm 
support in bitbake and makes the fetcher code simpler. The patching 
could remain in oe-core and patches could be applied to gitsm and 
package manager lock files. Additionally we remove code duplication and 
simplify future changes to the SRC_URI determination. It will add an 
indirection for the SRC_URI but the current code already shows that this 
makes problems. Only the archiver class uses the expanded_urldata 
function and all other classes including the spdx class ignore the 
implicit SRC_URIs.

--------------PAiKfbLXTIJO0ymfF0CWeXA6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 13.02.2025 um 11:43 schrieb Richard
      Purdie via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">e) add the ability to add custom hooks in the fetch process to handle
the cases of needing to alter the flow for patching the components list</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">I fear this isn't easy possible and we have a design problem. Bitbake and oe-core assume that a patch doesn't influence the fetch and that the SRC_URI contains all fetched sources. Many code use the Fetch class or the SRC_URI direct and doesn't expect recursive implicit URIs of gitsm. </span>In
      reality the SRC_URI describe the given URIs only and doesn't
      contain the additional implicit URIs. The task flow applies
      patches after the unpack and prevent patches to the gitsm. In
      reality a <span style="white-space: pre-wrap">patch could influence the implicit URIs and isn't independent.

I would recommend to keep the patching outside of bitbake and instead handle the implicit URIs inside oe-core. We could write the implicit URIs into files in the work directory and migrate the scattered direct users of the SRC_URI / Fetch class to a common oe-core function. </span><span style="white-space: pre-wrap">This functions returns the given URIs and optional any additional implicit URIs. This allows the usage of the task dependencies to ensure that the implicit URIs are resolved before use.

The package manager lock file needs a single unpack and patch step whereas the gitsm needs a recursive unpack and patch of every successive gitsm. This makes it impossible to use additional tasks. We could add the resolve of the implicit URIs to the fetch task to support recursive resolve (gitsm).
</span></p>
    <p><span style="white-space: pre-wrap">1. download SRC_URIs
2. exit if no URI is marked as unresolved
</span><span style="white-space: pre-wrap">3. unpack unresolved URIs
4. apply associated patches
5. resolve URIs
6. goto 2 
</span></p>
    <p><span style="white-space: pre-wrap">This will eliminate the need for the partial implicit URI and gitsm support in bitbake and makes the fetcher code simpler. The patching could remain in oe-core and patches could be applied to gitsm and package manager lock files. Additionally we remove code duplication and simplify future changes to the SRC_URI determination.

It will add an indirection for the SRC_URI but the current code already shows that this makes problems. Only the archiver class uses the expanded_urldata function and all other classes including the spdx class ignore the implicit SRC_URIs.

</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------PAiKfbLXTIJO0ymfF0CWeXA6--

