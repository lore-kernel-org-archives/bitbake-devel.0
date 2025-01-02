Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F3E7718B
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 08:04:56 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.92])
 by mx.groups.io with SMTP id smtpd.web10.4359.1735805088148648934
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 00:04:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=JAewWzG/;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.92, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou/wurfblgv0UsRoVWvQ6WfIT6Az5H4gGtaqvV+JSfb56UeDoaEl3hGUtcyI0FtEPRwDQq9OVcsIumfJNL5u3r/9jMX0ZJP8KRThQwZpiNlIZiEAbKWqFc8AkWlvaG9njyTcF8602mi7AQPI3XpSlyHxIQ+LFsnEX8uoZQfQl20vjRZiN3jMfoUzgT8QKhllcXy4AddnW6mZTF0bwMIk8SfUKrru3ZXTyhqNucxK7VS0QOwUKEsJBnmpnimEES4+KrDkygLvbzFpJy6SdKjCNIPT9QE2AGGF8/TLcDXL2pPDrfHn8PzvZ7hdRLSOE4Hmg83srb1ZM5xZq460TrtHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewpyouipH0kB/wjlRQ9jNVwPrxuZjTm2dUnREzP3UKE=;
 b=K5BrqXEmgg2AlwTA6b0fNEIPwP2tRR88foM0As/6z+F/ihXtP/csVkrWOPqfjH6xZeh6NEq6EDUoBf6U2VxvZ23Xx+gEHJN1N3NwYqcCqWHxMuRuQZuxTQY53mNHWZvT7uyLtFNzJXddXQY4FFCv+6EL40mpvCmdckWP3QNbZrGXQowsxpnKG+0+49+EmdHpzQ68h0zfRCsAHBgL7n76GJyvdwlZxwYgvYkEKzNpJB5V3hMlUa6lR4B3utUsnfs0Ti2UBfoYXdK2GhADhmOBeEpCG91ysuXaWkZRNP3oPbQZg3sWt9aA5n82pSPc2OIc5BMJhVR7UHGh/yppgXPaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewpyouipH0kB/wjlRQ9jNVwPrxuZjTm2dUnREzP3UKE=;
 b=JAewWzG/Swnb6J/DvURJZD7l8Oen3oab5emag1ykSh954f7dI4dz83mkXRbCuDwJG8zx7603ksuBxzQNYi4e+LnRT3zpQBJi3LMcGCVdaIw4gK3DJ+QelRkLWg4wWxHhZNL5vFHfNewnLd6DGwel8sg0/2UQGveHPW8ls2no3jG85UAxLJniS/GNMTn6fYEZGCqxGmFJlvfqAxzS5ooYCfrVvZu0XK7gbfc0vafqHnXHLChwA/Fl+3felaZLUA02m2FO5qoWFkPxfOy5TYeOnVI2MLFkZe63UC6/uefAENdhCPA3/qmvEOcdi7PhoBPEtXqjJrypcm0YiZTX7ijJmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS8PR08MB10314.eurprd08.prod.outlook.com (2603:10a6:20b:5c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 08:04:41 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 08:04:40 +0000
Content-Type: multipart/alternative;
 boundary="------------cQz3HLC5klpxCk4SuDW3NQ6a"
Message-ID: <2b8ab392-869c-410f-90dc-fbd0b67b010b@weidmueller.com>
Date: Thu, 2 Jan 2025 09:04:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 09/21] fetch2: add destdir to
 FetchData
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20241220112613.22647-10-stefan.herbrechtsmeier-oss@weidmueller.com>
 <c855bfdf35f81072ded4863673930dbc8aa622fc.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <c855bfdf35f81072ded4863673930dbc8aa622fc.camel@linuxfoundation.org>
X-ClientProxiedBy: FR0P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::9) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS8PR08MB10314:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca2dfcd-a8ab-4471-6336-08dd2b041bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MlFVdjVLOWFHaGw5WGFBYTN1cGhwNTdwLzNCMlRJK0pOWHJsbXZPZ0FCb0dR?=
 =?utf-8?B?NGEzOHlLRCtWc2RzZU43OG15ZWVwMTJPUG9CandUc2pEbm56NXhIaC8zdXBa?=
 =?utf-8?B?OE96bVFneDIyV1FRWVNxM1dCZkFpL2JxaFRSeWlDMXZlaHZSbUhQMjB3UjV6?=
 =?utf-8?B?Tk4zSHhvc2hPNHBBdU5aaE5CMmFyTEpVN3pIQTYvTldzQXUxbWNScjFac3BZ?=
 =?utf-8?B?TEJ5OEFhbXdxZjh5YW1iQllVaUFPNWhtTWhibjJRMkEybVpNaDRJZXA4ckln?=
 =?utf-8?B?ZE03Tm1yUndHbW1JRDlBdXAvVS9uQWlrREFVZ1Y5ZW5DWnZyUThoUmh2R1RZ?=
 =?utf-8?B?dVJVODlKTWZPc3J4THZsdDBCSGdaQlZ1RkV0aWllVDFXM3RlcDkyVm9reC9G?=
 =?utf-8?B?cWNBT3YwQ1N3U1NvVkdQa2ozdkZrdlZZVjFTRzk1RUk1blhxM1IvM0FXM21s?=
 =?utf-8?B?b3FYd09IVUlmYmdjbkF4YTdIdXBIdnl1em1lZXo5a2dhaTUwWEFmVWk4S1dS?=
 =?utf-8?B?SnQvc25xcU5hL3htQzdaUUF1Z2RaL0Vwb2hmeVpGc2YrcTZ4Z1liTDBIQ1c5?=
 =?utf-8?B?djJ3R09CRkltRjIwV0h0S3B4WG9qMWpOeDJQUUh3c25RSzE3V0EzTnM2aUpO?=
 =?utf-8?B?UDRyYzJuMWRPcGhINEtVa0VwU1ZIOUVtVkVHNE1OMTc5N2FQNWIwVHpoclZN?=
 =?utf-8?B?WVRmMGZjQ2pHdWVXVUMzYjZaM1RvanhpZXkwdEVGQ3BicWZvWkJPc290Z1pl?=
 =?utf-8?B?MEl2NEpnSDF1cHNrQWQrbjZrNEFJNGJmdHM5aERmeU5JM3lHcWo2TjlQY3M0?=
 =?utf-8?B?eFJoaExmQkMxbnhoUUFVeGF1SklxbFpGOFd4SEg5QWNNMFVxaHpxQmVKVjdH?=
 =?utf-8?B?RUxBR1d3cmgxdXBlbDAyNzNrN2tNZFduaFNhMXBTWmoyNVZuckJ0MnJCOTc3?=
 =?utf-8?B?TCtZaUhkdlU3M1c4WVFiZ1liU0RLWVpVSGZHU0ZGVVNvZFNyamJ4VjVDSjZC?=
 =?utf-8?B?L0h0SDh5TFlSMkxWcW9FVy95UnZOaGcrNU8zVW9yVUdMWHd6NXJhVVhySEhi?=
 =?utf-8?B?bDBxd01VWW83RlpXeEZMRnlodmVwVit6dTJUb2V6c0hrQlVKUTl1Y3hULzdN?=
 =?utf-8?B?L095ZmlrYzBxUVVZVmlpSmlVendoRVZoQUxZbjM5OENDcktsa0hZT1dJZVFs?=
 =?utf-8?B?UllrTXZOTDRueHJ1S0lzUW1PUS9URVpXOUI1NzR0NHNQY1lTMzM0R1JJVFdK?=
 =?utf-8?B?QVlpa3pRT1EwQ0JDYTR3bGwxdWEvZjZsTnNpTVJSczUrdnRkN2ZlRWlRMW95?=
 =?utf-8?B?YmIzNjgxMHNDWGVsTDQxY1dRdTdpS2dOUk1ud0FDRFp6MjVSSDlZcHlNOE5m?=
 =?utf-8?B?eU1rSm1KanRLMmhxUVd3NTltVkpwTUtjR2VYdnNpQVB5RjFmazluVDdjS25I?=
 =?utf-8?B?bmNnY1NwT1Z0QzVhZVYvaXR3NFJybzcrSGZvR05YaEZXcUdzeTdRYWFpcGRo?=
 =?utf-8?B?REw2Qzl5ZnpqT3BQMW5VWTZNM0o4Z3AzeEhpSWFwYVYzYmtKajRPZytWUXNI?=
 =?utf-8?B?ZEJ3TFhvcUhabW4yYk82Q1lRS3o0U0tpUERUeGQ3d29HdmhsYUVOR0lYL2tj?=
 =?utf-8?B?NHBVS0xXbkFFQmc1Vy9CSTVCT3hkWUlJeEE3S2FEdW1hUE84a1NNMFhab3Vs?=
 =?utf-8?B?d3ZLNGlrWUI0VHpPb3pDVllpMUJPeUhuYTRaK1Jwb2p1QlpoODNxZk5nTHBu?=
 =?utf-8?B?cHByQjlJN29rZzQvWERxdFFpUncvalZxcjZhSms2aVIvdVNUTWxTaWhuRm0w?=
 =?utf-8?B?c1BUbkNGTHpZRnhGMVFhL3JoTEcvYWgwUUFNRWRwdHhOYzlmMUFZQ0lnbE9I?=
 =?utf-8?Q?iQ//G/8Y6OYfn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2FLcXBVNDF0ajNvS0NsUm1oNDhEakppY21Nd1VubElxT1NjZVNJTENGWDMz?=
 =?utf-8?B?OStMQURCS3JOcFhaVDlNT1YvU2VodTNybjlUdll0R21hT1M4MHMvUlI2b2dx?=
 =?utf-8?B?eVI2N05WZEc5N0RhTHVlZVQ2RzZocGU3ZC8ranEwS1FXTlJybEt4cFNxR2cz?=
 =?utf-8?B?K3VsdTNmbHlpTU5HbGRRekR4WFZqWDRpeG5aTk0wWW53K0dOTjZyMWVrL3Az?=
 =?utf-8?B?MEpqNTVqTTdBcUdvVFJ5UU9ES3ljNytQR2pFeHJvQlNnTDZGMnhyeVo1TlY5?=
 =?utf-8?B?OU03czJBMXJjOVovSSs0MzZsUklFemE3cTNtdnhxVmxyeVhYbXFJRWhhaXBJ?=
 =?utf-8?B?N2g2WE80RzRJc3JMMDJiT3ozTmNxazRrWlFqNll6S05GNXpvRzdSaGNjMWJY?=
 =?utf-8?B?MW10ajRqZm5reGtEdkVYdzFKbkRNRjUyTmV0RE0yc1B4bUNORWJ5YXJCRHZu?=
 =?utf-8?B?Qkc2YVlSemRCVm9weUZ6ZFlwWEo2TjVBN1k5WlhUMXNwUnBDZDNNcWhBUXRW?=
 =?utf-8?B?UEJYRmFBMzVablBQSjIreWlhKzRndXRTRlp5NmZsSUJTMnorMFB1bzhZZnFT?=
 =?utf-8?B?K0Jvek1qemZKSkk3R1ZqWTNDNzdNckFad3QwVG5ETWxmTzFkenV1a1QzTmp1?=
 =?utf-8?B?UVlxbllhcjNUQ1oyZjdqMUhCQ3RqamxBcVRFUC9sRXNCR0RpTnJaWWEySXJB?=
 =?utf-8?B?eU1abHpXbENkQ1piUlkvWDRmT0hJT2Z5LzRhT2xQa1B3ZkFzZmswREdmTE1U?=
 =?utf-8?B?Q1BDZC9aOXRGM0xMTHp5c0JPSS9YSUI2MW83RHV3Q01LVysyWXhacEpkZzhX?=
 =?utf-8?B?ejU4RDViRHNkSUs0anp0WEtLa1N2NTRzQzlQejhwa1JvYm03bzUrSXdISXBP?=
 =?utf-8?B?K01Kc3F1ei9xaDhYejZpQlpOMGlxazcwWEM2a2l5RlZZNHVueGtEWTdVMXRY?=
 =?utf-8?B?K1BHL1BNUkQ4dHZ1UXk3R2tpSE9BMFJlMmg2SEprREZCZXA0cGNkQ3R5Vml6?=
 =?utf-8?B?c1lCMnhERDNNWmtBdm1PUERjZjE0RkdLNERXTWFCTnV3MkJuOXFIbmN3WU9C?=
 =?utf-8?B?MHNvYkJrNzJCMWN6YUxiZ1JqRzRRMStzTzVZeVNDYnBoNjRkV1Fya2pRTnZH?=
 =?utf-8?B?MVROZ3NGRWxFZmRGczhxUDZGR243ZkgwVW05dERNa3lrQURPR1lDMGVwNG1P?=
 =?utf-8?B?OW5lRzAweHJrRENQdUhyZzFjWUJ0RVJVSENkMTlRNmVjUXlJZDBrZUcwazVa?=
 =?utf-8?B?b1NPVUxZeTk2ZUYyZDdOTWREZng4WDdhQXE4ZndiemJFd2NlZHdQRmQ0WG01?=
 =?utf-8?B?UHphWHZhVUdLcFZ3S3hLTUE1UEtuaHpEMHYrbzZuaThNZU1UWFZWSDBVYlp1?=
 =?utf-8?B?VndhS2crQU1Xb0hrRk1TS09xbFZFWHJWNUpKM0hSbkdZREtqWDYzUWJhc0Vu?=
 =?utf-8?B?R2JvL3ovVmN4VkhYMlM3S0dHMWlnSUhrc0YzSUNkOGI3MnhZa2FUajhmcjhN?=
 =?utf-8?B?bWhOTlFwUUlVelU2blpYMG9YQzhRQWRES2JRR01wOW9VN2E3OGwwZkhKZ3Ix?=
 =?utf-8?B?YXV6VlBTZnZiTmRRYTJGdU4rQVkrTU0zLzVJUlJtTHRMd1dHZHlnRUJDQXdG?=
 =?utf-8?B?ZEk5OExmdU1jazZ5c1BxZ09xTFQ5R2ZhNXd0dE11d0o3N3Y4a0VpY241ZkVm?=
 =?utf-8?B?UDlDTkVGanB0YUYzWWwxbldGRGJZbElaWFdOOTV2ODZnMlBSK0NoL0pwa1dx?=
 =?utf-8?B?UlFjaXdoR0NqRkhpQkwzUXhlYTVpOXhKWjFHWmVGVzQ2NWphSTFrTTQ3WkNv?=
 =?utf-8?B?UFdwL1NkSnB1S1FLUTNEek16aUtNVnhpN05OWC9Wcm5SN2s5M0FRTy9jVmox?=
 =?utf-8?B?NkJncmQxZDdJQjFCUjc3b3IxbGUvcmlSbjdZL1V3TVpXK2ZYdW1teWN1TmxH?=
 =?utf-8?B?WFlsYWMxNlIwMXRjN3VhY09WYkREaGNLSER4VmhHeUhqUmhCOVZLY0l6Ynpj?=
 =?utf-8?B?SjArQzR4SS9TcFNSaHZ3ekdQK0I0djAvcytXZ3JEM3l2ZmYrVld3YmxrQ21O?=
 =?utf-8?B?a0JRdVRIQ0Q5TWVhVmZmSklqRmRrd0xLQkhqT3B5RGNXcnNIRHd2V1MvLytX?=
 =?utf-8?B?TjNEMmw2NldlanpFMllOVTM1VmJQOXZRaURIVjlFWUNxcDhYeS9yWlNDVTRU?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca2dfcd-a8ab-4471-6336-08dd2b041bf3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 08:04:40.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB5rYFWdEcTfck6yu7ap6Z5D9MrhDfzcAt5ycGJ0oIVt8LZiyhL2cs0/yZ/zdIUeZZg+SL1pVM+PO97PO4C3TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10314
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 08:04:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16953

--------------cQz3HLC5klpxCk4SuDW3NQ6a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.12.2024 um 10:56 schrieb Richard Purdie:
> On Fri, 2024-12-20 at 12:26 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>> From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>>
>> Add a `destdir` variable to the `FetchData` class to record destination
>> directory of unpack method. Users of the `FetchData` class can use the
>> directory to unpack additional content into the directory. The git
>> fetcher class already records the destination directory in `destdir`
>> class variable of `FetchData`.
>>
>> Signed-off-by: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>> ---
>>
>>   lib/bb/fetch2/__init__.py | 3 +++
>>   1 file changed, 3 insertions(+)
> Where/how is this being used/needed?

The git fetcher already set the variable. The variable is useful to know 
the destination directory including subdir and destsuffix parameter. 
Otherwise the user of unpack must handle the parameters manual (see S 
variable). The dependency mixin unpack the main source to process the 
dependency specification file and need to know the destination folder of 
the content.

> unpackdir is only used during the do_unpack task and we've deliberately
> kept this out of FetchFata since in general it is meant to be
> independent of the target location.

The unpackdir depends on the subdir and destsuffix parameter of the 
FetchData and thereby the target location isn't independent of the 
FetchData. Only the unpackdir root is independent of the FetchData. 
Would it be acceptable to save the relative destination directory inside 
the FetchData or to add a function to determine it? The function could 
be used to eliminate code duplication inside generic and git specific 
unpack.

--------------cQz3HLC5klpxCk4SuDW3NQ6a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 23.12.2024 um 10:56 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:c855bfdf35f81072ded4863673930dbc8aa622fc.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Fri, 2024-12-20 at 12:26 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

Add a `destdir` variable to the `FetchData` class to record destination
directory of unpack method. Users of the `FetchData` class can use the
directory to unpack additional content into the directory. The git
fetcher class already records the destination directory in `destdir`
class variable of `FetchData`.

Signed-off-by: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>
---

&nbsp;lib/bb/fetch2/__init__.py | 3 +++
&nbsp;1 file changed, 3 insertions(+)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Where/how is this being used/needed?</pre>
    </blockquote>
    <p>The git fetcher already set the variable. The variable is useful
      to know the destination directory including subdir and destsuffix
      parameter. Otherwise the user of unpack must handle the parameters
      manual (see S variable). The dependency mixin unpack the main
      source to process the dependency specification file and need to
      know the destination folder of the content.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:c855bfdf35f81072ded4863673930dbc8aa622fc.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">unpackdir is only used during the do_unpack task and we've deliberately
kept this out of FetchFata since in general it is meant to be
independent of the target location.</pre>
    </blockquote>
    <p>The unpackdir depends on the subdir and destsuffix parameter of
      the FetchData and thereby the target location isn't independent of
      the FetchData. Only the unpackdir root is independent of the
      FetchData. Would it be acceptable to save the relative destination
      directory inside the FetchData or to add a function to determine
      it? The function could be used to eliminate code duplication
      inside generic and git specific unpack.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------cQz3HLC5klpxCk4SuDW3NQ6a--

