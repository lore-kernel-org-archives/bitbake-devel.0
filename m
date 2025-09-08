Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B33CAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 09:20:23 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.96])
 by mx.groups.io with SMTP id smtpd.web11.8699.1757323215204641300
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Sep 2025 02:20:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=wVb4eAh8;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.96, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKhAnkey2kvpnMVx/96ZcaoJihgQhkXVJ3QLJnOsxY4ZUK3dYsRcg3Enx9zrhCW64iFGU6AcggWFqDVVrP2bmbSAcEQvNN0pAwR7i07YWte8XOjzRdwF23mYoYwTRM782noe3SZkC7Djb42HCTOK/m/CVJUruBGr8vMk9bBt7uVD8tzFg+jnID3/vfx3GlpwmKkah2zF1U8OXMS839egrFUzGxEjL80HYettP/QqKFJSCjGaAfmts3L/z43KnXSGnNLhxoejCyVEez7K1cAIr5BxwOHoDbqwFYzHRrrGMXzbizMAEXN0Osi/DQs0mg0ii4Rb6eNfUQI2WvBV39MNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RYR52gK4JlJU3kuOuCeWgAxBTD/r2/tMufLvPxTePo=;
 b=t1SjRxLJ4w5gUs170i0g+/jJ4K3EcNLybbACKu9bPil4qE7X3sKjm/yulEHywanu+A8UFkNprOVo26ZCoObWUzHDijNU4vl/4U0uFJcDPe/DYcQxxdx6129SueoLz/waMpa3hsdUE0Ln3KTnm1V4vZra8HL4qtop1BxFdHqBFHgXCTJGEmIsi+oGsy9FDOc8456A/xhNI7L2BmnNTfjw3xPJ9fmgdpxFJ/cjipCDnSW2dLhp+ScxyDb/5U0UZR85GIuGsmOqCAlUyWDPZKeCMt6E5hcUmPE2SYnpEJka1I8OLOBS+qEfLR7Wcj3bZCDiKgaZFq3z7bKDuHORPhHcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RYR52gK4JlJU3kuOuCeWgAxBTD/r2/tMufLvPxTePo=;
 b=wVb4eAh8rB8L7WDKaiGsMSC/SP2KyEKIjD5rNsU6rsWDEbBcenmHYZhmLudmDCKDD8K5+kxiVsVUuIxTzvxf/ZKMKbwOkA+q+BJvmEOxgcKDJvSsfDdYlBpGEro7jIMvKcUCt9ROLDDrMz/N9R5WGa2q6MQ1ewuu/XD6Wr28G/muMH4K7kgioZv8VLkTbJGTnxw36i+JtacUfyacsBvp9nbpxVZ7fM+6FTJl8Y7cZpX4S23d9RHaaMpJVAxBTbIw0IN/8u5JpAauDV7O3/ppiOC/UvC5jxSESb5pRORdJTkbgXb1l4TDxfrQRLIrdFL0pzx3koy2eSKJxgZN7Ow8IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 09:20:11 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 09:20:10 +0000
Content-Type: multipart/alternative;
 boundary="------------dP0CWFhQ0pVzOSnimj0aVoQX"
Message-ID: <be5703d4-00ee-45be-9183-7bb4a327ed79@weidmueller.com>
Date: Mon, 8 Sep 2025 11:20:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 0/6] fetch2: add support for implicit
 urls
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org>
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f36afc2-40ae-4475-1a15-08ddeeb8e8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RDROL0o5U2N4M0Uyb1UrN0hSSW1rQ2xod21rZWJHc3A2U0xPT0tvb0JBMjlS?=
 =?utf-8?B?T0tCVUh4WFgwaDRZckFFRHA4RnFVSHgzQS9ZZGJkdTJzTlZLNUtlY0NXcnJ4?=
 =?utf-8?B?b0F6eCtWQmN5SkRpUHNaWHhVSlFqaU85ZGhJL3Mxb29GbVI1LzMrS2JRdHpP?=
 =?utf-8?B?RjlSSjU3QW04VktwNC9VU0dGQ2JwWitIN2NPcEQ2cFhRN0tLcWRsN1RvQXBh?=
 =?utf-8?B?akNOMWY4Zm1IWXpubjhyMm1XRU54TVM5dlhZV3g3YUhOWCtIT3hGbnMyUi9S?=
 =?utf-8?B?ZDV6YmwrMm9ZY0EvYUdVc2paSkFMQ0xyV1c2bnFWTmtrVnJYMEwwU1NlUmxp?=
 =?utf-8?B?ZHQrUkEvUW1jZTFuVTFjODVXWi9VYkpick9yL0M3c1dTMVZLN3p2dEVDbGZF?=
 =?utf-8?B?d2xBWUw2L3diQ1NhdHJBK0VSUlp4UngrTm5MajU3d2hmTE0zaS9GMEgxS04w?=
 =?utf-8?B?b3pQdWlLekpuSnQ4MDNjRTF3VmZXeVk1Q1ZjRVlEUXZpRlNCZ0NtT3NpMHJQ?=
 =?utf-8?B?ZWV1T3Myd1I0THdHVkNZNnJJR0JzRVlMd21wMkZCZnpLNlVHMkFwSUxQcDd2?=
 =?utf-8?B?N25CbFZnVWhMMXdEUUNoUTlvQjBhZFN4TEwrT0VrZVQxcTVVcHNuemFCUk10?=
 =?utf-8?B?anV0U0JOSTNiSjVad0x3WmxQRmczV3ZBN2pGcmEvMzJ1MWRWM2N3RmdXbWcw?=
 =?utf-8?B?Rk1sNENOT2JPamdjNzN0UUdOZW9lNUhhV0F2UUo5RUMwN2kyY1o5S1lkL2VV?=
 =?utf-8?B?SlprRUZXMUlOV3lMeWxtWEpkdzJsYVNWUXYrZSsrRGh4cWVjeldIZnVybFhl?=
 =?utf-8?B?Ukx4dVZJVm16NkEya000WWtFMTJwOGgwajF3WWxndmRERndDMW9jckY3dVdP?=
 =?utf-8?B?aWRwNHR4dU9ZM1hIQXVJZTJqQmRUZzQ1N3BqL1NpZjA5UzUyRElOckdLZ01G?=
 =?utf-8?B?SXJWK0RmWHg3aXBhN2F4ZnlqZmpzUnppMzlCV2xBRkxpNkJnNjhxdWdTUDY5?=
 =?utf-8?B?c2JIZjQvMnA3QWd3TmtKV1JOZEFBVGNTMGFvaEpMNndaUjJHV1VvVlNrcWdk?=
 =?utf-8?B?QjF2bitnQ0c3cHNMWDVWT09RREhVbktNVERQT0dXcytSd2h6M3JlVi9QZGgv?=
 =?utf-8?B?U25rcDJsSWc3QjhDVGVZZTN0ZEZBR05kWEQ2cUYvdW1rcGFlcjZUcUtDaEVz?=
 =?utf-8?B?OUE2b0M2N3RMODdMWnVXaGlWTGhIWGxRSzFwTWRhUEpYSXRibk1WaEtQUXJV?=
 =?utf-8?B?ekR6VUg3YnBKbW1ZU1RiV0dtYmJNRDBvaDhva2JBYXNRenhVbko2U0RpZFhV?=
 =?utf-8?B?d2IySUVuVmNsdityblFSU3RzMDlwaXdqeWY2NmZGWkRnNHBqY2UvUzBHaTN2?=
 =?utf-8?B?NndZSWQ2L0FlSHBXYnZMelhCRU9pV0ZPSVAreW90L2NoSmllMndZZVFqK2dV?=
 =?utf-8?B?STZxODA2eXVLTllGUjFSbFBac2Vqb0VNbUZPUVY0WGlRLzJEY2Z6M3pPZDRX?=
 =?utf-8?B?ZzZGMno5SmV2K3c5bk5sRzRHelg1cXZLT1VSRlo1NnNXck5raGJyWHNEUFRP?=
 =?utf-8?B?YTl0dkFlRFRwTndlQTA5bTJaT1N2ejVuZEJHV3d4d29reUFHZHMrT1p1YnhT?=
 =?utf-8?B?ME5vMkxYeS9kRFZtbmxrK05abWE3eWpLaUdPN0RuUHJMZTFIVnNCUVhGUStC?=
 =?utf-8?B?L1J6YSs1UHA0K0wxSWhZcmhRdzh2ai9zOGphU3p1U0ZqaC9uTGpEdmdCa0lU?=
 =?utf-8?B?ekowWHlXZGxQaWViTFBvZmV0a3FMZ2VsMEJiemJxNkx6dGZtU2RrVXN3Q05h?=
 =?utf-8?B?d0o2Ym90Ni9QTVh1OC9DYkxuOFFaRzFnanc2VHl2NzJGVFVGUHl1SG9Ea3RS?=
 =?utf-8?B?MEQ1RFlPWSsycHg3Nys1TnhxdUkxZS9KdnQrVC8ybENTNkc1dXNONld0elg0?=
 =?utf-8?Q?ZN8MEGLmBPE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFdPSGVkakZVUktoVUlIZnB1STFoMDVMZnZyTnN0M0YrSEhGeG53Q0hLYi9p?=
 =?utf-8?B?R2p5WkpTWnNkbGZjVGtaRFNTSEZyVHRCM2wwbE41TUJLMnIzNmh1aWVpTXFQ?=
 =?utf-8?B?SDJURzg2dzhHRUVuMEZFK1EvemlGT1BUNWZRWit4NEo0dS9UdzI2OWJJSmhZ?=
 =?utf-8?B?QUpXMGcyNWlPQlh3K1M5R2hPdnZkUmZCS2lSd2ZaTC9GLzA5TFJOTzhrUTNI?=
 =?utf-8?B?Z2dUUXlvdlBBaUJPajcrWmd5QTNMdEVNYlNCMHRmYm5NQjBjSkpEUS9WeXBW?=
 =?utf-8?B?U3lkaWp5elM2NmJYdWhkbFBUbkJwd1VadDdzcUF6ek5yeGlNRURYQUs2U2I2?=
 =?utf-8?B?cUlWT3Y5WktJQi8wcU0rZzZUc0s4RXByaDhTVFVnNEtGbUh6NWZtUzY1WVBO?=
 =?utf-8?B?blpWSHZnR0JEWEpoZnVGRi9SVndSdDF5eHJrKy8vTE55c1R1YjlVV2hYYms4?=
 =?utf-8?B?L0htTFlCMDlKVTdjOENsbHd1WHcrV1FuS0ROWDBOZE5CRGtjYkorekNpam9k?=
 =?utf-8?B?Tm5tZDNVUWZaMXh5NzA4VjFMVnE1ZFR4YWtaeHJLUWRqeXhLenduT2h3N0d3?=
 =?utf-8?B?QXI2RzQxcU5kREdydmxWUU1qcWhUQUpKdmlobTF6RmtVbEExbGs0TjBGdVpi?=
 =?utf-8?B?STMrM0JTNktvekVtOHlaZ2NMV1NPQ3hVamhURkN5SzBsSGhlSFZwMFBVbVJC?=
 =?utf-8?B?c3VoMllnTE5UaXRpWERTbjRsdll1RVBwSlJweXYrcFA3bGdaN3J0VFBGSnd1?=
 =?utf-8?B?dmo1U0dRUVZ0Qm1rUm40MDQ3VG9PNkFYZi9RNDlFSUVzcU1NM1F5a0hLejJX?=
 =?utf-8?B?QjRrdm5TMzNYcnNvZnNXS2tDMkJ2OE5Va0oxN2lNZEZtRFpadWErbjhMSkNQ?=
 =?utf-8?B?Y3p2Qi85TG92NXExMktmUXVUUXdrUTJoSStKU25Oa0RMLzhEMDZwRmNMOSs1?=
 =?utf-8?B?UEt4V2FZRThGWkxvMmJqRmV5UytMVXZ5SWM1dWt0eDhXNlJUQU5SdCtXMS9P?=
 =?utf-8?B?b283QXRsQWRDWVFwOU5US2hoS0FEdVZITTVHWTkxaGJQYXB2VGlrY1VCcTly?=
 =?utf-8?B?NHJobzRWSy9qbE5LWkxtMmJ2M0Rqa0l4QkFHcnpDcm1DOEpLc3NVN2VIbzhU?=
 =?utf-8?B?VlVrQkNZUDhoZi9KVVhWQ1p0LzBqcU9WS0ROYjBPN3NONnJ3ZThELzcxTTl1?=
 =?utf-8?B?Y2RKZ1drS3FyYVNFQW41UHBIQU1oekcyNG9UQ2IvbVF3UXFKbllvb3poTjQz?=
 =?utf-8?B?UDNVQm1MNE43SW5HVjRVVkhLVDl4YW5RcGQvV1gyRDRIaTYraXhEbmljV3pu?=
 =?utf-8?B?L1dWNGNYSXUxRVpscHJVekdzU09rUTUyaFVxUTlENEJuSEYrNFRVRGtzdnQ3?=
 =?utf-8?B?cU9tQXVOY25HWGhmUkRndFhSKzAwK0s2a080cWpoN3BDZ2VUa1FHSHQxRHZz?=
 =?utf-8?B?WGcyaTQvOUFSbVc3VmRLRzBrUnBuOXZ5ZXJFbXZKdnNNRjc2WFZLazR3RWZ2?=
 =?utf-8?B?ZXFqUi84ZWtvZU1sS2lNRmlrRmxQT3BvMU9CZU9pTlp0d2I2VjVxN3NuTzRu?=
 =?utf-8?B?RU1KcmdPSWpwM1RTU0pya3ZoU0Q1cTNDbFlqYmhyUStOV2FYVTJyaFJ5VHlD?=
 =?utf-8?B?VDlpcG5ydnZDdU93eDJZUG1oQ1Y0cjBXaWdROUZGSkk4SDVTMFJDT0JsV2Mv?=
 =?utf-8?B?WjloSVFoTmQyeVRUQlhwZFg4RU1VRml6SU42SE1ZM21sRXRtSTdzdUg2V3R2?=
 =?utf-8?B?bDhjdWpLTGE5SXZWcWVlVFdYcjdlcTBBeWhIY0wyWFNpVWpOWFBVZjNudjhB?=
 =?utf-8?B?SkcwYzRTa1RuMm5XWlBrdndXVm9keWd1bCtHTzNTckdmdFZJSi83dmk1a0U4?=
 =?utf-8?B?cVcvTHRaMTFVend4cHNTa0RwOHorcE15WVlxY1VPVnBKN0xWaHA1cVBySUN0?=
 =?utf-8?B?MmJ6dGFXaWhvN3FpN1JQYWFHVGMrbTNaZlpXa255VzdZM1pZbGp3Q1NqcWR0?=
 =?utf-8?B?RWRtM3k3a2hpc2JxMG5OcXpFRWNtWGZIUG1sSGRXb2IzaFFwZ0VFZVVISmRR?=
 =?utf-8?B?NzhXQU9Vdi9yODQxMmlUMDhBNnZZeklaSlIxL0Q3ZVNSeUV2ZEFzNjNsLzlR?=
 =?utf-8?B?M3h1M2oxUnFvOFFTcUVrLzgwQTM4bkFRNGRYWUxlcksvVVdFT3l2VzRRUndm?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f36afc2-40ae-4475-1a15-08ddeeb8e8e0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 09:20:10.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM6qkL5rnn+FJG5OZZLit5o0Q10urYqZ40Zmgq6DD2slzmKG46uPtORqVlafzqr/kvZ7ep5gDE9puPeaPHlx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 09:20:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17985

--------------dP0CWFhQ0pVzOSnimj0aVoQX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 07.09.2025 um 17:52 schrieb Richard Purdie via lists.openembedded.org:
> On Tue, 2025-09-02 at 08:55 +0200, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>> The patch series add support for implicit URLs inside the fetcher. The
>> implicit URLs could be defined inside a source like a version control
>> system (git submodule) or a lock file (package-lock.json, cargo.lock or
>> go.sum). The integration of implicit URLs beside explicit URLs
>> simplifies the fetcher classes and avoid bugs because of iterations
>> between the Fetch and FetchMethod classes.
>>
>> The series remove most methods inside the gitsm fetcher and only leaves
>> the parsing of the git submodules and the unpack functionality. It
>> allows the gitsm fetcher to use the premirror only feature. The current
>> implementation leads to problems because the download of the git
>> submodules is triggered via the download method which is called deeply
>> inside the fetcher code.
> We had the discussion a while back and the conclusion seemed to be that
> implict urls were disliked by a significant number of people as the
> were too unclear about what was going on behind the scenes and also
> made things like software manifests harder.

It looks like I miss some discussion and especially the conclusion.

I assume you mean recipes by software manifests.

>   There was a strong
> preference for metadata helpers and explicit lists of components which
> we have for crates/rust and now for go too.

Does this mean the npmsw and gitsm fetchers are obsolete and should be 
replace by a metadata helpers to fix open issues?

> It feels like this series is moving us back to the other direction. Is
> that correct and if so, what has changed in the approach since the last
> discussion?

Do you mean the response to my last RFC? In this case it wasn't clear to 
me that the project is against implicit URLs and that the npmsw and 
gitsm fetcher are the wrong direction. This series is only a cleanup of 
the existing functionally. The gitsm fetcher uses implicit URLs but 
doesn't work correct because of the misuses of the download code. It is 
useless to start the discussion again. The project doesn't like implicit 
URLs. It prefers a special task as a replacement for the separate 
recipetool. It decides against the on-the-fly parse inside the fetcher. 
How should I proceed? I have working code which parse the cargo.lock, 
go.sum and package-lock.json files and only use Git and Wget fetchers. 
The code uses the vendor feature of the package managers to create a 
patchable folder of the sources. It simplifies the npm class and add 
additional classes to build packages. The code integrates valid URLs 
inside the SBOM and creates components with name and version per 
dependency. Furthermore, I have rework the gitsm fetcher to hopefully 
fix some open issues. I can convert my cargo, go, npm and gitsm parser 
into metadata helpers but this is useless if the project dislike python 
functions to generate URLs like the pypi class or prefer package manager 
specific code inside the fetcher. Regard Stefan

--------------dP0CWFhQ0pVzOSnimj0aVoQX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 07.09.2025 um 17:52 schrieb Richard
      Purdie via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Tue, 2025-09-02 at 08:55 +0200, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The patch series add support for implicit URLs inside the fetcher. The
implicit URLs could be defined inside a source like a version control
system (git submodule) or a lock file (package-lock.json, cargo.lock or
go.sum). The integration of implicit URLs beside explicit URLs
simplifies the fetcher classes and avoid bugs because of iterations
between the Fetch and FetchMethod classes.

The series remove most methods inside the gitsm fetcher and only leaves
the parsing of the git submodules and the unpack functionality. It
allows the gitsm fetcher to use the premirror only feature. The current
implementation leads to problems because the download of the git
submodules is triggered via the download method which is called deeply
inside the fetcher code.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We had the discussion a while back and the conclusion seemed to be that
implict urls were disliked by a significant number of people as the
were too unclear about what was going on behind the scenes and also
made things like software manifests harder.</pre>
    </blockquote>
    <p>It looks like I miss some discussion and especially the
      conclusion.<br>
      <br>
      I assume you mean recipes by software manifests.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre"> There was a strong
preference for metadata helpers and explicit lists of components which
we have for crates/rust and now for go too.</pre>
    </blockquote>
    <p>Does this mean the npmsw and gitsm fetchers are obsolete and
      should be replace by a metadata helpers to fix open issues?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">It feels like this series is moving us back to the other direction. Is
that correct and if so, what has changed in the approach since the last
discussion?
</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Do you mean the response to my last RFC? In this case it wasn't clear to me that the project is against implicit URLs and that the npmsw and gitsm fetcher are the wrong direction.

This series is only a cleanup of the existing functionally. The gitsm fetcher uses implicit URLs but doesn't work correct because of the misuses of the download code.

It is useless to start the discussion again. The project doesn't like implicit URLs. It prefers a special task as a replacement for the separate recipetool. It decides against the on-the-fly parse inside the fetcher.

How should I proceed? I have working code which parse the cargo.lock, go.sum and package-lock.json files and only use Git and Wget fetchers. The code uses the vendor feature of the package managers to create a patchable folder of the sources. It simplifies the npm class and add additional classes to build packages. The code integrates valid URLs inside the SBOM and creates components with name and version per dependency. Furthermore, I have rework the gitsm fetcher to hopefully fix some open issues.

I can convert my cargo, go, npm and gitsm parser into metadata helpers but this is useless if the project dislike python functions to generate URLs like the pypi class or prefer package manager specific code inside the fetcher.

Regard
  Stefan


</span></p>
  </body>
</html>

--------------dP0CWFhQ0pVzOSnimj0aVoQX--

