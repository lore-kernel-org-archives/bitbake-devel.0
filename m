Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC0CC0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 12:20:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.116])
 by mx.groups.io with SMTP id smtpd.web11.10953.1738153243935542412
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 04:20:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=arfaV7IX;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.116, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYBIkg/gMWhIg1TXII6L4xwnNm88Zg8LzFunkTvG3KOyAnLaU4Nuj9fQfJFHTl/kSZGw+hxU0rhXwYf5stb35qHg0pJmwonMJBseDKl+W2Y4RNajupJoSvyVRRzuG4L+22+YPHzl9EBAvkhmvgzfPm8pSWXFXqyD8G/b1/zPI74Od/FtLgVRav7hPifGH2MLGVmHp8EXkbdEjTGaziRyw18Xr1bLdJNaNviGbC3Et/Hj9RsYkwQxhEiv2s4qBS1rqB3G4qk8YNMjJ5XrG2bup7jt77eLbBHs539pjp2PKwzQpFTexEclJds/I1bm2M3ZzAWr5ni7rjsWWuIhOyGfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXZ4Ke6Tq8SSLjh8VvzlXgXVFFPgcFv9x8kJcUCSq7k=;
 b=w2ikBCauWEZV7CsC1AwJpKPIbGzHRRkzGIpkHewWEhG7mI5R1PTi3cepbT/JTT/L4z17OE5zK6V33icMc8iIAIet+THcAfthtX4ItuU/R9aiRQz6bPeWcXj3+rJ1IUgk7oDcoZYjzPXKR6VDIh4CzN9JdSye+z5MgUgKifcMLGFSXheZDhlzHzqH/276euiXb3Om02d+p3Qb5jMnPYa2prUBVlQrRD76RhKpsOBspMh3wJ3Of5sHBAI+0YWo3hNY0fXEtDmCxOvhqoNZpb8c3ROYhAQlSmBo0sO2qTCk0Mf7QETRIGH9ezKqgtcMx03OJkxoZul5wI8p5zOBdRu0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXZ4Ke6Tq8SSLjh8VvzlXgXVFFPgcFv9x8kJcUCSq7k=;
 b=arfaV7IXKPtlqor8GMlqo904zgqObxUw/hda+dbsMeGaKc6o9ncEYJyVyB3NTGmioTbdpfg4prUUTVl9+7b8QNaq3z8g8bkYiD13tsiAXqFqP6D2g/K+vvdj53JQXCPZLyIzkB4Lw+ORfGB0OdQdJBS1N8A2llZteeKtTb/4m6cT3QdJwXqMT8shTgS6S5QqfsXQei1AUSTizkSYiqZk1WxGulx7Yg22CQVX/Nk4g+hjHYDrzU5LhDpASU8/Ak3h5XQXSgTR4yqeO+ca0T7PfXzdVGsdpwEJ2xSfp/6XETD0L4MImKHBqJXg2svYbJvPAxzfC+A9rNKg1u/yRt/zeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7621.eurprd08.prod.outlook.com (2603:10a6:102:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 12:20:40 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 12:20:39 +0000
Content-Type: multipart/alternative;
 boundary="------------0zQqD0LozQ5h46GbhUCHg0mj"
Message-ID: <8b6892a3-906d-44bf-bc6b-90048520eab1@weidmueller.com>
Date: Wed, 29 Jan 2025 13:20:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] fetch2: use downloadfilename to fetch
 from mirrors
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250127144314.27990-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <D7DW0EAQZCTP.1YEKGEI110OS0@bootlin.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <D7DW0EAQZCTP.1YEKGEI110OS0@bootlin.com>
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 31212682-20a2-4c81-45bb-08dd405f57db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L05oRUdyZ0NSWVJDc3lqcjRCdCtXbmROSXpUb1pHQWZSb3pmYzNLbnc3d2Vm?=
 =?utf-8?B?Qk1FT0RLUUZKOWMxYkxmZmtqSzBjSEdWSDBvVW1hejE3V2VqUmd3M1hQS1Fq?=
 =?utf-8?B?cDJLWG9wMGtlaWpkOXhyamwxZEd2NGV3WmdiMGFWMVdoU1ZxQlRuazcxSkh1?=
 =?utf-8?B?Q3FkdlF1K25tbldOeTFpdTJXRTRhQVM2bm8vb3BiYjZmZ0JreWxzNjBmK1da?=
 =?utf-8?B?U3lXdzNPTWNDYnJZdG03ZS83dTFpaVF2Q291YkplWTk1cUJXekVXUldZN3Jz?=
 =?utf-8?B?VEYwSTR1Znhsb05DOE0xVnBZZnJYL3RGdzFQQXdiSTNvSGIwYnNQSklla1A3?=
 =?utf-8?B?d3VlR1pQQnArZC84K1ppZjdmVnExMjU0alJadC94a2R1akkxU3RjSWJxWjFT?=
 =?utf-8?B?QmZPbTVSbmk1VVp1cm4vQUpQdk14SzU3eUNwWUJ4V1U5dHFOckkyOTFxajly?=
 =?utf-8?B?Sk92bllEdCtSVjVpUWtjdHNWQW02SUR4aS9wK1I1R0lSMnJFYWhJVlUydVZG?=
 =?utf-8?B?RTFXQytXUjd4ZWZ4bFNWd1lnVmJOUHcybi81bWVsZHJtU08vOTJuN21zSTY0?=
 =?utf-8?B?a1ZRYjk2Sm9mYmN2aE82ayswZS9haGJDajlyWi84bFNEdVVYN0xQb21RNVlB?=
 =?utf-8?B?anBOZDYrdVkxOGpnQ0lmR0JOSVBVRlZqRGRTZVpHUCsrZVJTeEtjank2NVVp?=
 =?utf-8?B?RzFpczl0cU1oci8xOENxenlHZ25SWG9weGg5V0ExNDIvQVJMNDBRM21OQjlY?=
 =?utf-8?B?K0Z5dER2d1RicEd4dWsrdGI5YlU0YVJoanpPU1ZpakVjSGhVS1FTSWduRGlP?=
 =?utf-8?B?NUp5SWhFZklSRm5MZzBmcTFQM3ZhWFZRcnZ5bTdYaVF0YXVNajNKdmZXZmo3?=
 =?utf-8?B?eTVpOVcrcGFOZDBjVXBxSldDVXRLQ2FBTzJ2a2pLTnRhZ05UTE41Z2FUemtS?=
 =?utf-8?B?VXZkRmM2Szg2a2ZlWU1zVStPeG05Rm4xMXJhNlJVQU93c3JhdDczejljbDRV?=
 =?utf-8?B?VVRWbmx2MkRobFFFSVNIcDRxalEwSDlXUlRsb2ZHYklpV1FPU1BHVXRYbHR5?=
 =?utf-8?B?clNmU1d0WmVTNWxpWkl6d1RId2F5VjhmU0VDL1E1VWFtRW1jYVlHdDNxWnoy?=
 =?utf-8?B?ZmNpeFRwcDN5RXN1RVEvTjhGZ2JJYk1sZmd1QzlNTmxUZTVtQXhud25pMzQy?=
 =?utf-8?B?NmJ1Uy9zYVRUMzNqSXExbjhmbzNSUzdLNUlGYWNINlVtWDVLbC8vOU9BMk10?=
 =?utf-8?B?QVQwRit5Y3NOMjErL0RsZXZQM1JGUitmTHo2UnRZYU9TcEVtSnZYeVZ1WmxS?=
 =?utf-8?B?emJ0QWoxR3V0QVJPZ0l3NEVUZmpnN0RwN2hCOFV0ekJFKzkrczZxNUREaGgv?=
 =?utf-8?B?ckFQbTAxL3Z1K0lCcFl3UUFLK3kxTU9EYTFMc3RjakNONnMra1VKaTY0NE9j?=
 =?utf-8?B?TlNhZmlhVlVRWmxxUktZbWltL01pZG9NdllzaFQ2bHVGS2doQ1lqck9WZlZX?=
 =?utf-8?B?MHdFMXNKclRDLzJTWDZyZ1V0eVhjNVFJaG9LMUE0L1BxekZ4NjFpaG5ncmsz?=
 =?utf-8?B?dFp5TGNXQ3VhTkhwRFloKzJZL1dhTGFUbXJhelVFdFZZVmFpb1lKVGxtY210?=
 =?utf-8?B?U1lBcUhRSmI2R28wMjlmQUJpcTA1NHdPZk1TY2MyQXNhNlNsWERRclkvZU1i?=
 =?utf-8?B?Y3hkNWtmTExOR2dVVDU0d3FndXY4WXh1czRyVjVGR1Q0bGorQnpETEhvdVpj?=
 =?utf-8?B?ekk5U3lPa2l2VW1PUGJJNENWZ2tjbElWUERlWjBxSEhyNVIySGZEWXlDUS80?=
 =?utf-8?B?R1hyeTFOR3RPdStmNkNwUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWx2b1VTT20rZGJVUmI1ZVpoTmVBQzl2SitIb1ZnV2tQZmlRbHphUHJ2TzBy?=
 =?utf-8?B?eHF3T1pnbkxiamdSbkJydWFnV2l2VmpCS1dwdXpENU0reWd1c25rY0l1amRz?=
 =?utf-8?B?aFpWcEpxR0diTHI2SXFKZXJndW5ldzlDRjNVMlJ6amxadFdGaHhxV2t2Umdw?=
 =?utf-8?B?c01mQWdkcDc4Ynl4MlJGWnpJeUpMT0VGK2hKVUZmbDFjUEtKYWxYUks3Q2xK?=
 =?utf-8?B?MUNSdWVYd0hpK2JOc0VNR052MHE3ZHdqOVZsZ2tUYXQrOWNRQzZiTzFsUCsz?=
 =?utf-8?B?eThJdElDN01RWWhmeE5udmJYVCtqQjhQS1k4MU5JZXdJWG51NUZjeGFjY3px?=
 =?utf-8?B?cUN6UENNSWV4blYraytrSnZGMWVFWWlPMTFSeHY2a3dDMGY1K0R0TU91bDQr?=
 =?utf-8?B?RVNKTkxlbzU4dkYwcFcvWVBBeHpYbmh3dGhndHZRSVpibnNyK3JaaHlYYlpM?=
 =?utf-8?B?aWlkTURiM3VFN0Y0MHhDYlM0MWZiV3Q5SjhOTlMyOFdDejlRSXF1YTVtL1VH?=
 =?utf-8?B?R1Z1dExDdWpEOVIzOUtCQXg4NFJlTmVKb1dCdTRRRHpWUWRZSFM2K3NBbUZm?=
 =?utf-8?B?djBkUG1oVVhVNHdFc3RoMFAvaVBSQnNKZnhCNGJHa0V6WlAxWmVzamZyZFla?=
 =?utf-8?B?NG5CSld2Q3pkM3lVTnpWNENFQ0hBRjJXcU9uTkZNMkV2S1FFVUpZMThQZGxY?=
 =?utf-8?B?TTlEdE9mbXE4YXd4Ym9YSzM3dytsZmlLWmlISVQ5WFVOMys3U3hPUXRVVGo4?=
 =?utf-8?B?L1BGcWFDVnQ3emg5ZWJWS0lHZjN3bDJVWU1PUThucUhUenhXcWtMRjJOWWZ2?=
 =?utf-8?B?eGRnc005RDVzYnRJV1RDV1dxZ3Q2ZnZMMzNaMnMva040YjVhMlpGMFpTODc1?=
 =?utf-8?B?LzlmWG03b3FEUjRhZXNTZkM3K0tNemw3dU5oN3B4ZS82a2FpbmNvRk9EUjVS?=
 =?utf-8?B?UFgyOXU3RWpqTXUyQmhkQWQwTHMwUXZXT2VIcFdHYjIvTFRtVDJRelhPdWZz?=
 =?utf-8?B?ekNnYzZKUDBBL1NxUnEzbHp2eXdsTU9mamljVC9hUFZRajh1dUJPK0F2ZGxk?=
 =?utf-8?B?cWl1Q2NWalBuN25Zcm16T1dmcGpLNzQvUEE1R3dhL0MvcTVPZTVRU1ZWR291?=
 =?utf-8?B?UzYvVHl5b24yUUovWlVNU1d5cSt1RG5CU1hoL25LN0pXbVlVMFF2bkVmdTdQ?=
 =?utf-8?B?YW44TDk4UlN1OHBGUEhzRFNTZ1NJVGdvNGtIQ29TaTFBU01zN1RxV0poL3Q0?=
 =?utf-8?B?L2JXN1MyV1hTTkllWEU3RCtlbXJlRHVsem5UdWxJZXkwblUvNlNIMDl4M3ZB?=
 =?utf-8?B?Rzh5aE1IUVp4K1ZIVkJUZkZFaklhT29CcUJrQUQxTGpVT0ZJeE1pNW1kejE3?=
 =?utf-8?B?S0I2VERWUVN6QWNNZFM2VzdnakxlS1N1K3duVDBDY2xZSytyTG9SbXZQNUJW?=
 =?utf-8?B?ZmNaWXNhRmFubDJDbWVjSWVvMGptNm9NeVVrWEZveWo0VzJ5NTJOalhvamdp?=
 =?utf-8?B?NllrWEV3L21KdnNKQnhKM1huU2NlVng5LzhyOXIwZXlwZGRaYXdycFB1YURa?=
 =?utf-8?B?WHo4dDEvQkJ3dHlhN3ZxMlJVazNtWWR2Z2dtMGxndUx4WWdQZ0kxUlFVT0JY?=
 =?utf-8?B?NGdYdGRXWjZmeFVablFTNGVkc29vMWRCSzhFYkJuNHVOdENRM1YvWXlwOVNQ?=
 =?utf-8?B?eFBOR255RnQvcFVYMHpURjlQOWVMaDR0ZGdmZHV0WFBOYjRUQVRiNEU5TDJQ?=
 =?utf-8?B?UElYWmdlN0poK2ptcUJXZHhwczBjOEV2ZkZGMzMvMEJoYzgyY0pIeGZoaU9O?=
 =?utf-8?B?NEMvLzlLRlhwdk0rWnQrZzkra3pFcVQ0azArWWdrYkxpMmIyMmw3a3cwR2JT?=
 =?utf-8?B?ZzlLWkZMVXpaN3J3YTFjYmxwRHFVaGVZdEdYSC9JVjgzREI5ZVZSVXdRYTRp?=
 =?utf-8?B?Z09mLzZmeUh5YVpxUW1LOUpONmNmRDJzRjFsZzc4YWhMS3AzeXhTY1BOYnNU?=
 =?utf-8?B?cHE4VzR0VU5QeGFiUGw4QTJRNFNOVlVuV1gwN3k0b1FkOWJDS0lGNFYvSTRH?=
 =?utf-8?B?aElRajg2MThLWEIwTGhGRFZjcURUelE5M1QzZEp1M0lUR0wwZGt3RE5uaHhz?=
 =?utf-8?B?WSs2RWI3ZGNMRHJqNWUrUUsxNDZ1RWdQWWEraHZvSERPTVhydEVYVzdRVTlF?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31212682-20a2-4c81-45bb-08dd405f57db
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 12:20:39.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/br8Cl6fnWGCd6LXVOgUCrQn0aV0mJRYMVUhQvqBAiclu2kKsWzDtu2LrQaxU66ozpYIeaarmeS9bPCrvPEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7621
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 12:20:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17114

--------------0zQqD0LozQ5h46GbhUCHg0mj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 28.01.2025 um 18:37 schrieb Mathieu Dubois-Briand:
> On Mon Jan 27, 2025 at 3:43 PM CET, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>> From: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>>
>> Use the downloadfilename to fetch from download mirrors. This allows
>> fetchers to store downloaded files inside a subfolder.
>>
>> Signed-off-by: Stefan Herbrechtsmeier<stefan.herbrechtsmeier@weidmueller.com>
>> ---
> Hi Stefan,
>
> Thanks for your patch.
>
> It looks like this is causing some issues on the autobuilder, with the
> oe-selftests:
>
> 2025-01-28 08:46:33,938 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
>    File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oeqa/selftest/cases/sstatetests.py", line 261, in test_sstate_creation_distro_nonspecific_pass
>      self.run_test_sstate_creation(['linux-libc-headers'], distro_specific=False, distro_nonspecific=True, temp_sstate_location=True)
>    File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oeqa/selftest/cases/sstatetests.py", line 131, in run_test_sstate_creation
>      self.assertTrue(badperms , msg="Found sstate directories with the wrong permissions: %s (found %s)" % (', '.join(map(str, targets)), str(badperms)))
>    File "/usr/lib64/python3.12/unittest/case.py", line 727, in assertTrue
>      raise self.failureException(msg)
> AssertionError: [] is not true : Found sstate directories with the wrong permissions: linux-libc-headers (found [])
>
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/815/steps/14/logs/stdio
>
> Can you have a look at this issue please ?

I have found the problem and a simple fix but need to clarify the 
correct solution. Please drop the patch for now.

--------------0zQqD0LozQ5h46GbhUCHg0mj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 28.01.2025 um 18:37 schrieb Mathieu
      Dubois-Briand:<br>
    </div>
    <blockquote type="cite" cite="mid:D7DW0EAQZCTP.1YEKGEI110OS0@bootlin.com">
      <pre wrap="" class="moz-quote-pre">On Mon Jan 27, 2025 at 3:43 PM CET, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>

Use the downloadfilename to fetch from download mirrors. This allows
fetchers to store downloaded files inside a subfolder.

Signed-off-by: Stefan Herbrechtsmeier <a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier@weidmueller.com">&lt;stefan.herbrechtsmeier@weidmueller.com&gt;</a>
---
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hi Stefan,

Thanks for your patch.

It looks like this is causing some issues on the autobuilder, with the
oe-selftests:

2025-01-28 08:46:33,938 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
  File &quot;/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oeqa/selftest/cases/sstatetests.py&quot;, line 261, in test_sstate_creation_distro_nonspecific_pass
    self.run_test_sstate_creation(['linux-libc-headers'], distro_specific=False, distro_nonspecific=True, temp_sstate_location=True)
  File &quot;/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oeqa/selftest/cases/sstatetests.py&quot;, line 131, in run_test_sstate_creation
    self.assertTrue(badperms , msg=&quot;Found sstate directories with the wrong permissions: %s (found %s)&quot; % (', '.join(map(str, targets)), str(badperms)))
  File &quot;/usr/lib64/python3.12/unittest/case.py&quot;, line 727, in assertTrue
    raise self.failureException(msg)
AssertionError: [] is not true : Found sstate directories with the wrong permissions: linux-libc-headers (found [])

<a class="moz-txt-link-freetext" href="https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/815/steps/14/logs/stdio">https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/815/steps/14/logs/stdio</a>

Can you have a look at this issue please ?</pre>
    </blockquote>
    <p>I have found the problem and a simple fix but need to clarify the
      correct solution. Please drop the patch for now.<br>
      <span style="white-space: pre-wrap">

</span></p>
  </body>
</html>

--------------0zQqD0LozQ5h46GbhUCHg0mj--

