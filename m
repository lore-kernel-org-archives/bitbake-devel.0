Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7545EC021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 09:48:21 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.99])
 by mx.groups.io with SMTP id smtpd.web10.45862.1740044889853660042
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 01:48:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=lsJkFkIP;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.99, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0SzWvB+amAv+20pTvRTo8HmQKGLl1Wy8aWARCkAfI7CvHL5hlMmIsdBhOzdczLOM9FiGzZHeI3Nn7Yvev3JR3zY79sdUu2LntLi0n4YBdVEve7jRVmNhFbzz9uTCaMF1PBKd0OyUgiRoRfX/7+erozeAKvNjHV/qTa2nKXG2vTSVCI0zOPgXR3Trt8DPFSTqoKj5HuLgVfcLd+f5tkGnm5QnrVlbIooM4xg10ZAwbq8xDslTasOWqIoEyHuaLz9wshxHMkfEMc1D8n3atS4M2zuZgF2sYBEGkIVkYP5asdt1FA+lw2m+qgs555ybcmsXROIGhrd5v7fL5urCxoocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4QvbbE8GH5d3XAhxJNSLGuFBz4QjnXfpVkyVffNDZk=;
 b=NyZXq+djkGJD0O8gmo4Kh4SfZ30EJZkSH67yPhWms00wWq0UHDMCn2MLPtKVQ5NO46esyUDQ/xZe3KGC6Ezevb32EcAJkhXb+Jj777bv1IWwz8J4/sRPhIbhYmMLCwiL69JmLdg3yXB3cpTMdDeDa0qV1vx33QISse63AR2xyKbmk5ryE7vbf9Fzh+GG37ieJHkngZTfmyOEgdZWS5QUeLLofbzzT17Pd1VqPsyN8fC+UkAf+KXPNFTW4nXNAZmzuD8XR6Mlcy+p1PFVdZ4TW615+dIJQziKAP1BMfuXuW5G0cjqZgQesc4Ki2zFMOoI6fIWAYJrAMAqHD+EESaAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4QvbbE8GH5d3XAhxJNSLGuFBz4QjnXfpVkyVffNDZk=;
 b=lsJkFkIPaoImoKGTudVSxiIbF8ARq1H/fNdJ+WpWTh5vBMV6Pdhh5NQnWa2PewTCmYMj4FeU0rD7Ff+jPtqc0ZEtvPUSsRAfTsvV4AEW/jUDqCfy9yI+cwL2xkG8AUEdr7omDJV+vJzx7FKef7yVnmGJgGJph/pIOwmUdk7oNzKC7wE2lv/zORfNVSQwPooRqpYpQcJ1uTdBStc2oLnCSwLPmFrKLf0fgsHsIQ3W3AHnE0I5oVwVNSppFQ57ROBl4pod8K/RU3NcfTyUWLUH7TLObdVSUXh6ikadM8RXPBcYXk3lPFU96+mpnCrcTXO/jC0/vFce8kmAi4eHdK22Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV2PR08MB8727.eurprd08.prod.outlook.com (2603:10a6:150:b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:48:04 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:48:04 +0000
Content-Type: multipart/alternative;
 boundary="------------r97sBUOXx9m48XUvrlDi2vE5"
Message-ID: <0e604b52-e25b-4dd1-98b0-554af2c743e7@weidmueller.com>
Date: Thu, 20 Feb 2025 10:48:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 openembedded-core@lists.openembedded.org,
 Bruce Ashfield <bruce.ashfield@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
 <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
 <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
 <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
 <c2f481ae-327e-43c5-92f5-9753bd5c0138@weidmueller.com>
 <e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org>
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV2PR08MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b9b456-10f7-4c02-cc03-08dd5193abb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UnJCdXFRUGtwV0FMbU8vUnpqRHVqWEZJZWt5VkVQamlUT3kvMlRzMWNwWkF1?=
 =?utf-8?B?K1dsaHJ6NXJQSFBnaDhzdUY4WUF1Q3NyZWV5S2c3MDdOTm45NEJUbTE3THQz?=
 =?utf-8?B?eEliZmRkM3MxcHYrYU1iaDk1bEMwSVVOUU56dUZuMHlpMUJwY1dMS2V2bDh1?=
 =?utf-8?B?ejdMcU5BZWlvTHM3SU83UjFBUDA5eHRVU0dzcEZJT2R5N2JhU0IwOTJiWHd0?=
 =?utf-8?B?aWRzMFBmK21zV3RRZUdHemZFL0p5U1FiSE5VekJ2b1RHekpjTUdyaTR0TS9N?=
 =?utf-8?B?MUpVUEF0OG5IUGlpZHlQaW40NTBYYnJlVHNNOHM3RjlwUFA0clVYbkszWU9p?=
 =?utf-8?B?NlhPa1BucW16NTU4d25YdWI2bHZtWjJGMlhJZGFzanFRV3JFUGdvbjRCcHdq?=
 =?utf-8?B?UHpZYW5qVDlaSkpZUzRkVzFINGNEU3hHOC9xTlkzOTZEZG5kT3l2SUt0VlBT?=
 =?utf-8?B?WStBWUJ2NGhXaHZRUXJvLzB4WkVaQlhHa1EvVXQ1TW9VeHVFNi9aZWh4TS9N?=
 =?utf-8?B?MmFXZnhaRjNEdExVendVQ0dDZmE3Y3V1WXMrUWZUdEdoU3JjaFRCZ0hMVEVp?=
 =?utf-8?B?Z0k5N3VXb3pRZXdFbjZHeFFqaEFHQ2pEKzk3eGZZODJzdk5rVUlncnZLenJm?=
 =?utf-8?B?ZGQyUG52MTRseUUxYXZQa3IwM3JwUFFjcWR0eE5aWGFsNzI5c0Z5TUtGZDN0?=
 =?utf-8?B?YVNxQWQwN21aNlpOYzExUDVGeEJlclpHTy94OENIQnFwRmJMR2xQak5VbG9T?=
 =?utf-8?B?VnpKVjZRa1E3bUowd0EvaC9ra1Y5UHN1VmlRaG03NFpuYWQ4VlhOT2p5cWZR?=
 =?utf-8?B?L0V4RmtiM1g2dzdIYy9wVUM5L0ZZdTlEV28rUm95cnhqYzJ1M2IrdjQvb3pu?=
 =?utf-8?B?TEsxR1BQUVdoRFY2eW1nd0QrSURIdnVnYVg0Q0x4by9ubG1rSlpOU1FkZ0Yv?=
 =?utf-8?B?QkN1RDlOR0ZaVi9xNjlhcUk2a2U0bTlUUHdOV2ZETzV4aWlobjRKZmFhejdB?=
 =?utf-8?B?QzFRdjVwVnZzYkxPcVVuOFlScVdCSUFVbGdaaTRLSDlENS9pNk1vWXc3emRx?=
 =?utf-8?B?WGJSckVwekpqc0NhWXFhU2dYdmdFN0hCTXJRVnhWR1BpMVF5bW5hUWJveHJW?=
 =?utf-8?B?bkRZK3B2MzBRMUtKZUNUR1kzSmhucTVIUHZSbHFxK2lra1YwQi9LL0loZWpo?=
 =?utf-8?B?TE9leHhiMExIdm5NU0MzbkozL3M4dktFbXRxbnJybDdjaExaWnhNdnAxLytC?=
 =?utf-8?B?bUlSeDVacjk1WU40blNoRnBJbkk4VFFnVzF4elg2QTlTQkNON0E5M0Vmamdk?=
 =?utf-8?B?Q0E1bmdNVy9GaW84U2dQb0RPVkxWMkNBY3pCVk9ySDUxdXlQOHJrZUpKYTU2?=
 =?utf-8?B?b1V1RVFJdTlzOVdZTDlBRk8yMWQ0RUJsQzlCY0p6bkN1aGFzQWpxM1JCMlJm?=
 =?utf-8?B?V2pFNUlLd2tPRzBmTTZlVHhLd2d4YXdHSmp6Y3VySTU1UTdnNjVSb3RhOU1n?=
 =?utf-8?B?TktKbDkyQi9lZ2g2dENFZ00xZklnQnpPejVLejJBVWQ5TXFSS1ljcXhhWVRh?=
 =?utf-8?B?WDA2V255Q2NHaUZWV3Zoa3l2QmEwMU8rbFl6Z3hJbjFNOHZiTVFxa0RCMkdQ?=
 =?utf-8?B?QVJBRDhiWXdyYjBGWERkU3JySFZXZXE3VkFXYzhEUUNKNm5JaUk1OWpOeFJr?=
 =?utf-8?B?SDduN3gyM3paTFEyQUtqaVV0citaMzlJQWJWamFzaW9oZkZncVVITStjVG5F?=
 =?utf-8?B?VVkyOEJTYTVpMzZENkdocFFQUW9DWEZZUE14UTVZa09tOGpmeEFSajNhaldG?=
 =?utf-8?B?czRpVHp1L0Z4T3ZjdnY3QzlRR1dYZ2hnTzJPbTJLWi9zTmFsd1JXUEptcVFt?=
 =?utf-8?Q?Y5tgUhMdEhBzc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEZRSTkzNjhjUGl2alMzU2lUcjlDNzdjbnI4d3dINW54dlpWMmhoQ3pjcDdx?=
 =?utf-8?B?V3d2d3krajJIdVcrcERzL1h5ZXJuOG1KWC80dHVnYmEva1ArMlAwbmsyV01L?=
 =?utf-8?B?bzFBNGdtOFFqZE5FOW52T1pRaFFIZ3VKYTJTSitzeTR1WFBrcGFKYTVhcWpP?=
 =?utf-8?B?YlJSNmptZENFc0tLT0liblJwUlEwM0lpWVo0ams5N1J2US9wWklHK2UwblY4?=
 =?utf-8?B?TW1BblRvQVJJcXlNVU9MeDRqMDVhY0hRNkt1Z2JUZ0U3bWx6NTBIa001R2Ns?=
 =?utf-8?B?V096NkRnb2VNcWRVMGJnVU85Yi9pT0N2REVDOVdWSzZXdXp5Rjh3MENOMkdJ?=
 =?utf-8?B?Mk5WQ284UWVUaDd1MDlBODF3d1ZZbkpCd25ENjZTVjNnZVcraWExdEdRKy9W?=
 =?utf-8?B?UVRjSHFFL1lsTUZ1d09XVElmaUVtbWE2Y0VhaW56ODlIbFZBQ0VsNHhhTEVK?=
 =?utf-8?B?SHJXeUtuMnlqVDE4T255VGlBZXVxdHZZYjV1RUc0MkV5cHZkc3RhVmN4Zzg1?=
 =?utf-8?B?Q254ZTBkczFHa2FFY2JkTVZJKzhuZHQyRVRsQm5xSzBxTytBQ1RRUXVhNnJa?=
 =?utf-8?B?SmtVb2xNZE1uSkNXMW1XbWRLQ1NSYXVPVEtWYXVGRUhPWlFXUDAxNzhiM3d5?=
 =?utf-8?B?VGxnbHgzWmhhNzg2SnNFSkZsNG1RV1NjbGl1L0JpWEZYOWs0RXgwQzQ5WWVi?=
 =?utf-8?B?M0szSGFnRnRYQ0NxbVgvUlkwbVJ5U0ZhV1NXM3UwVkM4OSsva2o4My9GWHZj?=
 =?utf-8?B?VTY1MWQzRGY3SkVPY0dtaTBZMHJScGJrcGFncGZBdWw4Y3ZGYnJzZVVsNzNk?=
 =?utf-8?B?SDdNRXQxNzlwVHZIb3YwaFpuMk5kblVVZWR6RFR3d1hSSHczZFpzemtmaXJO?=
 =?utf-8?B?MStxMUh3cFltRGhlUzJRcTc1c3RlRVdoNHdqbnd3bGhlcjVRVzREeUxjTGN3?=
 =?utf-8?B?TkF5ZVJDUndtSC9aL1dMZ05FK2lUK1BlZDhGNEkzMENpS2Z2SUJ5UDRyR3Z0?=
 =?utf-8?B?MnFRY2tnWnY1QXc3T1FLcE5yRGNNSkdlMXo4dzc2ZEJXak9rYXhkYWhFOW9w?=
 =?utf-8?B?Z3UrcVJzSDgzUEk1cWJqc3djdTF6eFZQVFU0SUdINlQ2WlFWMG1NYXNRS0hw?=
 =?utf-8?B?aXRWNXVXVkppckZLRW5aaGNTMzkxUDhPd0JUOUN4VFV6aHBUcnAveGVDaWlB?=
 =?utf-8?B?UmtCS1pZdDlpZmkvNlFvcnB3VWxKOWdFWmxuQXNuai9Hd1lBUGZKbGh2U1Fn?=
 =?utf-8?B?b1lmZ0U3NmdqNzYzV24xb1lJQTdWL0EyL0FZZXVuZmVtelBvdGFBaitoRUtG?=
 =?utf-8?B?dTFkVjlMZWRzT1RqOHZZUlBMUllpZkZPVnFIVnJ0ZW5JZGFTTFhhOW9MMWM0?=
 =?utf-8?B?WU41OUVTWW1BZ3JXOVY1TnFGcjU1ZHlmM01NRURZQXpXOXFJajZXZk5JWEUr?=
 =?utf-8?B?M3BwWVZWbDNaOGxab0Z6alZhVFFpZS83aXpJTENpNU83aHNIQWhJMFg0amE1?=
 =?utf-8?B?ZnlmdG9RSVgxZjR2TXZESnZvbFVueVNhRFRxcDIvUERib0dlaXRsSTJkRHdN?=
 =?utf-8?B?QjZVcTdCRCtlcUpLdkV6cmd1bXlwVFVRdUh2RW5MZVpWNER1RUZpNWNROWZp?=
 =?utf-8?B?b0JZaDdDM0hYZmxra0lMU0JUUjRnKzJ5RkJnRTFSbnBwbTYvYWh2bmk1Nm5Z?=
 =?utf-8?B?YzY5Uy9OMEpYNDZlQ1kyOEY1RkZBemJndytsWks2Q2lkdk1kV2VDS0ZIYXo0?=
 =?utf-8?B?ZktReEo5OHloWDNXM3p2Y2hZemN0N3Mwb3ZYTFhkakFxeGZVRTE3Ymw1NEpT?=
 =?utf-8?B?RUY0MHhsNEtRbGlVWFRsSktPK3NxMkpUSkM1NTQrZXBQSklodFBZOVF5Mlhw?=
 =?utf-8?B?QUIwS0hVbWtxY1hHTXljeDhwblRwTVhHbWlqR0gyeEJoa0tBRkp0L2FjY1VL?=
 =?utf-8?B?eTFvZWZ1eEM3bGdPcFh6ZFl4TG43aDZ6Rk5EMUNlRjBBNWgrVkxPNDkzNFhS?=
 =?utf-8?B?UXBEUENlaTFJM1Nid0J5Q0pRVlpzQzNGMXhvQWp1Y2JENWdXYk5qRXFUN2ta?=
 =?utf-8?B?SkpmdytWT0sraXgxMUpZWG9pSTdrbkwrV0YzdVRQZXM4eld4MTZVYjdVUTBK?=
 =?utf-8?B?RnhEeXJnR1hSeFZNLzZteEp1dXRLbFpwZ3g0aVhIY2d0YWVYazAyU3R6Mmlz?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b9b456-10f7-4c02-cc03-08dd5193abb3
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:48:04.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E73qMso4DGqSJa+rdnK4skIFJYnn5g1M3n5vbdnr0dWa2RqmtPRt9vpili0EHQDAHS4OFoURv8cyJsrbOaijww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8727
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 09:48:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17250

--------------r97sBUOXx9m48XUvrlDi2vE5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.02.2025 um 18:33 schrieb Richard Purdie:
> On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier wrote:
>> I don't change the exception. The exceptions are the reason for the 
>> state of the series.
>>
>>
>> The missing point is that the expectation is related to the end of a 
>> dependency chain and not to a task itself. In any case the real 
>> expectation isn't clear. What happens if the configuration need a 
>> compiled source and it isn't feasible to create a native package. My 
>> series satisfy the following expectations:
>>
>> * All sources are downloaded after the do_fetch
>> * All sources are unpacked after the do_unpack
>> * All sources are patched after the do_patch
>>
> I could try and reply to all your points but this one jumps out as a 
> really fundamental thing we disagree on. All our existing code assumes 
> that:
>
> "All sources are downloaded during do_fetch"
>
>
> which means once do_fetch runs, we have all the sources. That is quite 
> different to what you say above. I fully appreciate it imposes quite 
> some constraints but it doesn't change the fact that this is the 
> situation.

I don't get the point. Do you say that only the do_fetch is allow to 
download anything? So my assumption that I can download something 
outside the do_fetch task as long as the download happens if something 
depend on the fetch task (like bitbake -c fetch ...) is wrong?

I don't understand that requirement but I can fulfill it. The only 
consequence is a complex do_fetch task.

>
>
>> WIP:
>>
>> do_fetch : run_fetch, 
>> run_early_fetch, run_early_unpack, run_early_patch, run_resolve, 
>> run_vendor_fetch
>> do_unpack: run_unpack, run_early_unpack, run_vendor_fetch
>> do_patch: run_patch, run_early_patch, run_vendor_patch
>>
>> The bitbake approach looks like the WIP but makes the run_early_patch 
>> complicated or impossible.
>>
>
> Which is why I'm saying that I'd prefer to do this in bitbake and if 
> we have to drop that patching as a result, so be it.

But this is an essential feature because it simplify the usability. It 
allows inexperienced user to fix a security issue in some minutes by 
simple back port a patch from the upstream project or fix the problem 
with common tools outside of oe.

>
>>>   whether we need to have some kind of
>>> checksum to verify the "lockfile" is correct as originally intended in
>>> the recipe and probably more.
>> I want to prevent us from having the wrong motivation due to a lack 
>> of understanding of the lock file. Why don't we add a look file 
>> across all expanded URIs, regardless of the source of the URI, 
>> because we could have the same problems in the other fetchers.
>>
>>
>>> I'm in the position of trying to mediate things (i.e. see the different
>>> viewpoints and bring people together, trying to find common ground) and
>>> yet at the same time, express views as someone who as spent a lot of
>>> years trying to maintain and improve this code.
>> I appreciate your work.
>>
>> But I sometimes have the feeling that the code is a patchwork quilt 
>> and every attempt to replace several patches with something common is 
>> met with rejection.
>
>
> We have a patchwork where people trust the current boundaries between 
> the different pieces. You want to change the boundaries, and the 
> assumptions made about those boundaries and replace it with something 
> that isn't going to be easily understood by most of the userbase as 
> the concepts are complex and break the existing models people work 
> with. I'm doing my best to explain the problem but either I'm failing 
> at that or we simply disagree on them.

I don't change the boundaries. The boundaries are not clean at the 
moment. Look at the code. Most users of the URIs assume that only the 
SRC_URI exists. Because of gitsm this isn't true. But only the archiver 
bbclass use it correct. The spdx classes notice it but fix it in a wrong 
way. It simple replace the gitsm:// with a git:// and lose all the 
dependent sources. I want to sharpen the concept by introduce a fetcher 
/ source library in oe. The library abstract the bitbake fetcher details 
and provide a simple api on top of it. This allows us to remove all the 
duplicated code. The bitbake fetcher focus on the download and the oe 
fetcher class on the management of the URIs. This allows use to 
introduce new concept for the URI management and allows use to remove 
the repeat instantiation and parsing of the SRC_URI.

Based on the code I would argue that the user base don't know that the 
SRC_URI could be expand to additional URIs nor that a SRC_URI is 
replaced by an other URI underneath. We have to fix this in any way and 
I would take the opportunity to introduce a simpler and feature rich 
solution.

We have a go-vendor bbclass and gomod fetcher. The first use the wget 
and git fetcher and the second add a specific fetcher. We have two 
solutions for the same problem with different concepts.

>>> I have tried to seek help from the people who effectively oversee me as
>>> a maintainer (i.e. the TSC) with limited success. I'm not sure what to
>>> do from here.
>>
>> I really like to upstream my work because I think it would simplify 
>> the package manager support, but there doesn't seem to be much 
>> interest in the community for it.
>>
> People are too focused in their own problems to be able to spend 
> enough time on these architectural type pieces. We do badly need this 
> kind of work which is why I'm trying to help this move forward but 
> equally we have to do it in a way which doesn't destablise our 
> existing userbase, in other words we may have to make some 
> compromises. I'd like to hope we pick the right ones. I'm worried as 
> we have tried solutions for this space before and the fact we're 
> discussing them again shows we haven't got it right yet.

I always try my best to not break existing users. Therefore I keep the 
old behavior of the existing tasks or function calls. But we need to 
sharpen the concepts and unify the code base. We have different 
solutions (like go-vendor.bbclass and gomod.py) for the same problem and 
partial integration of features (like expanded_urldata).

I think we have to much theoretical discussion and to less code. I would 
like to integrate a Fetcher OE library to remove the redundant code, 
unify the codebase and use the extended URIs where appropriate. This 
would fix some existing problems and could help in the next step 
independence of the solution. Would that be okay with you?

--------------r97sBUOXx9m48XUvrlDi2vE5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 19.02.2025 um 18:33 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org">
      
      <style>pre,code,address {
  margin: 0px;
}h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}</style>
      <div>On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier
        wrote:</div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <div> </div>
        <div class="moz-cite-prefix">I don't change the exception. The
          exceptions are the reason for the state of the series.</div>
        <p> <br>
          The missing point is that the expectation is related to the
          end of a dependency chain and not to a task itself. In any
          case the real expectation isn't clear. What happens if the
          configuration need a compiled source and it isn't feasible to
          create a native package. My series satisfy the following
          expectations:<br>
          <br>
          * All sources are downloaded after the do_fetch<br>
          * All sources are unpacked after the do_unpack<br>
          * All sources are patched after the do_patch</p>
      </blockquote>
      <div>I could try and reply to all your points but this one jumps
        out as a really fundamental thing we disagree on. All our
        existing code assumes that:</div>
      <div><br>
      </div>
      <div>&quot;All sources are downloaded during do_fetch&quot;<br>
        <br>
      </div>
      <div><br>
      </div>
      <div>which means once do_fetch runs, we have all the sources. That
        is quite different to what you say above. I fully appreciate it
        imposes quite some constraints but it doesn't change the fact
        that this is the situation.<br>
      </div>
    </blockquote>
    <p>I don't get the point. Do you say that only the do_fetch is allow
      to download anything? So my assumption that I can download
      something outside the do_fetch task as long as the download
      happens if something depend on the fetch task (like bitbake -c
      fetch ...) is wrong?<br>
      <br>
      I don't understand that requirement but I can fulfill it. The only
      consequence is a complex do_fetch task.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org">
      <div><br>
      </div>
      <div><br>
      </div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <p>WIP:<br>
          <br>
          do_fetch : run_fetch,
          run_early_fetch,&nbsp;run_early_unpack,&nbsp;run_early_patch,&nbsp;run_resolve,
          run_vendor_fetch<br>
          do_unpack: run_unpack, run_early_unpack, run_vendor_fetch<br>
          do_patch: run_patch, run_early_patch, run_vendor_patch <br>
          <br>
          The bitbake approach looks like the WIP but makes the
          run_early_patch complicated or impossible.</p>
      </blockquote>
      <div><br>
      </div>
      <div>Which is why I'm saying that I'd prefer to do this in bitbake
        and if we have to drop that patching as a result, so be it.<br>
      </div>
    </blockquote>
    <p>But this is an essential feature because it simplify the
      usability. It allows inexperienced user to fix a security issue in
      some minutes by simple back port a patch from the upstream project
      or fix the problem with common tools outside of oe.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org">
      <div><br>
      </div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <pre> whether we need to have some kind of</pre>
          <pre>checksum to verify the &quot;lockfile&quot; is correct as originally intended in</pre>
          <pre>the recipe and probably more.</pre>
          <div> </div>
        </blockquote>
        <div> I want to prevent us from having the wrong motivation due
          to a lack of understanding of the lock file. Why don't we add
          a look file across all expanded URIs, regardless of the source
          of the URI, because we could have the same problems in the
          other fetchers.<br>
          <br>
          <br>
        </div>
        <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <div> </div>
          <pre>I'm in the position of trying to mediate things (i.e. see the different</pre>
          <pre>viewpoints and bring people together, trying to find common ground) and</pre>
          <pre>yet at the same time, express views as someone who as spent a lot of</pre>
          <pre>years trying to maintain and improve this code.</pre>
          <div> </div>
        </blockquote>
        <div> I appreciate your work.<br>
          <br>
          But I sometimes have the feeling that the code is a patchwork
          quilt and every attempt to replace several patches with
          something common is met with rejection.</div>
      </blockquote>
      <div><br>
      </div>
      <div><br>
      </div>
      <div>We have a patchwork where people trust the current boundaries
        between the different pieces. You want to change the boundaries,
        and the assumptions made about those boundaries and replace it
        with something that isn't going to be easily understood by most
        of the userbase as the concepts are complex and break the
        existing models people work with. I'm doing my best to explain
        the problem but either I'm failing at that or we simply disagree
        on them.<br>
      </div>
    </blockquote>
    <p>I don't change the boundaries. The boundaries are not clean at
      the moment. Look at the code. Most users of the URIs assume that
      only the SRC_URI exists. Because of gitsm this isn't true. But
      only the archiver bbclass use it correct. The spdx classes notice
      it but fix it in a wrong way. It simple replace the gitsm:// with
      a git:// and lose all the dependent sources. I want to sharpen the
      concept by introduce a fetcher / source library in oe. The library
      abstract the bitbake fetcher details and provide a simple api on
      top of it. This allows us to remove all the duplicated code. The
      bitbake fetcher focus on the download and the oe fetcher class on
      the management of the URIs. This allows use to introduce new
      concept for the URI management and allows use to remove the repeat
      instantiation and parsing of the SRC_URI.<br>
      <br>
      Based on the code I would argue that the user base don't know that
      the SRC_URI could be expand to additional URIs nor that a SRC_URI
      is replaced by an other URI underneath. We have to fix this in any
      way and I would take the opportunity to introduce a simpler and
      feature rich solution.<br>
    </p>
    <p>We have a go-vendor bbclass and gomod fetcher. The first use the
      wget and git fetcher and the second add a specific fetcher. We
      have two solutions for the same problem with different concepts.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org">
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
        <blockquote type="cite" cite="mid:7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
          <pre>I have tried to seek help from the people who effectively oversee me as</pre>
          <pre>a maintainer (i.e. the TSC) with limited success. I'm not sure what to</pre>
          <pre>do from here.</pre>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>I really like to upstream my work because I think it would
          simplify the package manager support, but there doesn't seem
          to be much interest in the community for it.</p>
        <div> </div>
      </blockquote>
      <div>People are too focused in their own problems to be able to
        spend enough time on these architectural type pieces. We do
        badly need this kind of work which is why I'm trying to help
        this move forward but equally we have to do it in a way which
        doesn't destablise our existing userbase, in other words we may
        have to make some compromises. I'd like to hope we pick the
        right ones. I'm worried as we have tried solutions for this
        space before and the fact we're discussing them again shows we
        haven't got it right yet.<br>
      </div>
    </blockquote>
    <p>I always try my best to not break existing users. Therefore I
      keep the old behavior of the existing tasks or function calls. But
      we need to sharpen the concepts and unify the code base. We have
      different solutions (like go-vendor.bbclass and gomod.py) for the
      same problem and partial integration of features (like
      expanded_urldata).<br>
      <br>
      I think we have to much theoretical discussion and to less code. I
      would like to integrate a Fetcher OE library to remove the
      redundant code, unify the codebase and use the extended URIs where
      appropriate. This would fix some existing problems and could help
      in the next step independence of the solution. Would that be okay
      with you?<br>
      <br>
    </p>
  </body>
</html>

--------------r97sBUOXx9m48XUvrlDi2vE5--

