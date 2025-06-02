Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF3C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 10:16:15 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.32])
 by mx.groups.io with SMTP id smtpd.web11.46372.1748859364532673292
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 03:16:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QcM98LKn;
 spf=pass (domain: cherry.de, ip: 52.101.72.32, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn/BsRgxgNuIa8kk/4pz4XOowewToqXPpdQ3KSDPTq9FGICkvRErB6BV0Gtsp+N7+Jm+vHsP4K6/o+FhvJkTInkNlwlzuY1bd/+RROU+U92J/JtyN0lNKoGLbKGGo6v5Fm8WcIdPPYQBiphNfA0iC5W0noWG3ExmtbLqzbwjSKiEnI4BhjGPS+9rYs8cba8JBkls334UEXHwbUY/v7gYhMFogAUrW8ZxVL7UdLalq3lYStuAht6h8t3QfGEMX8flmtJWL2gi2KJfAmKjKGyFmiFABQ6Rqi7Giya59qnGrYZlDOELqqB5kyWgZsmzqQU0qzj1kJQjwr9mPRA5fnqkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndr8u3BSRXqoyAFPpmdCEnISn+bhuA5QDDTyPDZdiNc=;
 b=nfAtbmiT24ClRPueo1g4QpMFFjzBE5IeqAjM7bIn7MkMuIqhB+OTOVktwDtmpubTPG80bWGbnuUjuknYqZ4C4+gxP2hudI/4R2x4CSzu5454OMCd10SQcgFBZevYKfmifzJqyxwIFCHvlKjuRlHLVsSA9Tba731aRDnx9VgTyTLx63UbEXW03SaVU72+8Axcuu6CjF5qnuU82isOOivUDaTgdTEqqyYLCNC/ZjO2qYGoyUX4bDLMitMQimq7Fb+/zvVdmfr2RHFkULNiWKs5yO3jDva+VrcEi36HzeyYgAlWQnz7tlMgsPV+V5x9s8sD9M7SZ9SyUFAWdLUpLH1ufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndr8u3BSRXqoyAFPpmdCEnISn+bhuA5QDDTyPDZdiNc=;
 b=QcM98LKnpcCbx42dcTOGk+YR6tCdB2NBCnaMXhBE2Sm4YGgWIC/lzFWpW2JsLeX3iZzXAg6NANAFds2fkZAG5fKirR3/2uvkovaijS74RdYxaNtJ97lSDSf4ZDsV3MqYnRgFj9jhzR3fS36jxaKQ9YTtX4wWQz62QXC1OCCfOQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10660.eurprd04.prod.outlook.com (2603:10a6:150:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Mon, 2 Jun
 2025 10:15:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 10:15:58 +0000
Message-ID: <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
Date: Mon, 2 Jun 2025 12:15:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
To: mac@mcrowe.com, bitbake-devel@lists.openembedded.org
References: <aDnoNJFkC535qqiI@mcrowe.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aDnoNJFkC535qqiI@mcrowe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: PR0P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10660:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b63e36-f51b-488e-40bc-08dda1be77f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHZ2Smx1RTdoNjJsWU1MWVBlVUFDY25PRFp4a0w2dFVFY2duanpzYnRDWG50?=
 =?utf-8?B?cFNBUGZLTGtzbHpINW1aSnpTWVhlcy9yakNmd1hDVWtDQncveUcycDI2bTh0?=
 =?utf-8?B?Znp6d0loU1ZaSGdpVlZIRWpMR25INVkwYTJFZlZoaHdRZlJha1pWNHp6S3Vj?=
 =?utf-8?B?UGVSampmeUwwODE3TlRFTDFVNXJ0dGFSeVRjSHRjWmVJSFdzWXAvTmovTVUw?=
 =?utf-8?B?NDBVUmxuRFF3dEdNdmJRU29oMkZFZUVuOXBFaUszTGY4RHRYNy93Y0xJa3k0?=
 =?utf-8?B?NmtJWGFqNW5id0hnWnBvdlZ5OXBFNHdJdk5FU0c3Vyt4aTB5dDVUL3dxOXov?=
 =?utf-8?B?MkV3bVhtejNaYlRqVlN5NUVGVXVMMXZEV1ZIeURTampUdEt4L1dqOWF0bkVl?=
 =?utf-8?B?LzZzMDRRa1B5cGVlUXA4U0g3RVI3YVJlMkJpRmd0cGpnZ05VOGRqRXkwUlM4?=
 =?utf-8?B?VWZ3QVd6RXd3SHdSdENXT0hrNk1JUkY5Z2VxT1FuZHNINTJaUlhpRTBZWmU3?=
 =?utf-8?B?bm1hVE9QY251Y010UmRqTEpGaUdkVlo3NDNJbzZoaVg4eXV3T1FYTHZ5VTl4?=
 =?utf-8?B?aXIyN24zYmt5Q244T3llYkpZNWtOekxWd3FZNnRaWjVwQzQvUWhjSVNManRo?=
 =?utf-8?B?NUNZMVVOVmtBM2FQY1l6bXAvRjJKOEU4V3FSdEYrNHhIeEZ1ZHZkNlpUT3hE?=
 =?utf-8?B?U0VPeWhIeEN6M2lSSHBXVTFPMWdZU0JlQzdlcTB6dGt4dkUwWHR5amV5dDJl?=
 =?utf-8?B?SktWWWlEWm5oZ2J2WmVMNUZWalJsVlN6Z2h5OVZGVExPeWh1T2ZZQlUzOXFl?=
 =?utf-8?B?QVl0RENyY3FuQUtFcVN4UVlVckVta3VVT3NKdXA3YW9SUWdUbzF0WEVZU0sz?=
 =?utf-8?B?ZzlLUng3NEErOHYxN3hFK09NOHFMemtaWlFRMDhDcFJGWWhneUFEcmZLdXNv?=
 =?utf-8?B?UUM3WmcwSUEyRUV3Y2VPcFFjeE5TQ01UYVJwM1MzVVlqb2JaWHVuTnlOL3Qx?=
 =?utf-8?B?QmFocTJuY25KRm8vVXNsTjlkM2ZrMUswKzk2WFBTcjZBaWUyUFdxbCtRcTBZ?=
 =?utf-8?B?RHRyWG5HZ1VWTHAyWVpidkEwRlFaYWtySlVqdkdXc2hKaGxsUTR1SGhrQlEz?=
 =?utf-8?B?SkJmZFlhMDlnRXpxWmxHa1ZxRERZMlQ5ZkF4ejVOYTJma0grdVhzeFRzZkow?=
 =?utf-8?B?MnM0UWEySTcvRkdaQnJYamdQZHNsRjJsaVFRV0grSEdLU2IySTYzVk5XN2Ey?=
 =?utf-8?B?UmZEcEdaY2dVOXRRRExGQUhwWnh1K1NmQWFGbFo4WHF2VlhZNlRGZjFTQ01W?=
 =?utf-8?B?NC82U2hhTnpGMlRCeXFjOEZITi90RlZyQzBvM3R0WUs3c04vTnY0bWs3S29L?=
 =?utf-8?B?dGJrWlA1NlNheDF1SWtpOUJLNHFhVlVZMWhDbmUwOXJCRlJCaHdieE9nK2I2?=
 =?utf-8?B?OVAwQkkycWZyNjRhZzBqcjZDN05ucW1OdnArbGxEWGwyZDk2SnRpWUJWckJo?=
 =?utf-8?B?WW5ldndzbjRTK2JkV3ZQYWxuMGttNVhiczhlVXdOS0M2eFhWaitoQ0puTG1s?=
 =?utf-8?B?cTBlNUFqcDJ5N0NBbEp0RVhXMS9BQlZwdWRTS0U0V0NwSXd2RW5IL2EzajMr?=
 =?utf-8?B?TU5lc2pUWWpNcVlOek9yKy8zSCthWEo0UVFndUxZT3JCSzZjNzFOZHA5Q29u?=
 =?utf-8?B?bjR0Sy9Eb21iWkFBREtDdVhqUnVWM0wrbG5yUDlWNHNaeGR3YkdFSWdqT3Zj?=
 =?utf-8?B?Vktsa1NmYmNLcDVJc1BZbVFETi9EM3RMYzJSVnk3MkJZVGNHenJidy9Ndkts?=
 =?utf-8?B?c2xmM2hoa21JTFFGaDVKRnFNQU5OekF5VkV3YmFORzFXVVBWV2Z5bUJDaG95?=
 =?utf-8?B?dEo0Y2VhaWVpZU1iSFVGcWJNK2U5QTV2M1hoUUQ0emk1eDhXNVF3NEF4V3lG?=
 =?utf-8?Q?NmzjJJXjMqY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1RYeTEvbmR2K1JEOEViME1mMTk2YUNCUnBLUWJSajF1dTNqSXU4TUxVdDUx?=
 =?utf-8?B?S2RBaXZ0UW0wVXRxd0VTMXYzbTF2UDAzSm5RUlk2Q1V6eFpweWFiVkc1RjRn?=
 =?utf-8?B?d2ZaMzgrbHovVWd1TnprSEVYbjRjNVB0WC9HeGVQSjF3eW1ZOEtvdWU5L1J5?=
 =?utf-8?B?SFVkV0JIZ0RNN1hVSW1kZXMrdDUxdjUyWS8ydVVheW8yby96UjZPaHpHTHpN?=
 =?utf-8?B?ZnA3VnRiNkJrZHpQcExVK1MzbVpyYStwUlFlNXlSZU8yV2ZEMVJLcjV1RWs3?=
 =?utf-8?B?VW1LaEt2T2JLRmFEK0FwQzFkS3NJQ0VqbUovMWRtTUEvUU16TzJqZjJPa2tO?=
 =?utf-8?B?QjA2eExNZWIrNHgzamlTRjNaZDdmem5BZ0hhVytEWC9tRDl0ang5bXNkYkJv?=
 =?utf-8?B?RWgvNUVkdDNUN3d3M0xqYkVGNzN1eHl4TmJRSXk1dWNZNnhoY0JDem93WHFl?=
 =?utf-8?B?Q1BvZjFlbkRqN1M4b05YcnFOSWtkZnltd3hzb2Q1bklqaFF6OFhTU04zRVZl?=
 =?utf-8?B?UW9QTzc4VWswSTdFZWsvb1M0NFJMT1Nld3FPQnpIcm9lM01aY28vOWd5alFR?=
 =?utf-8?B?cXFMRE5VTzc1T0hURjFrRFNYZFRnQ0lRemtBRzF3U2lTMElHTUsyTklzOGRF?=
 =?utf-8?B?T1JTUlJXWldGaFZJSkZRanRJLytkclZ0UE84M1RWQ3FvL3NrUmkwcndWQnJu?=
 =?utf-8?B?U01RL0wvK3c0Z1NvcE5DMmQzZy9Hb0NHTk1GS3JBamRvMXJraVB5N2F0ZWlE?=
 =?utf-8?B?ZHYvOUJJeVpsYTAyWVVhbHpoT2lZUHJIdTJVOUl4Wk93TGR4SmNQcmlZSnU3?=
 =?utf-8?B?RldSSWkxaW5kYkNKcmU4czIzNUVZR1lmQ0Q0cDFxU1JVSEFUdEVMTFlCMTFF?=
 =?utf-8?B?eXFVUFVNV0FKY3B3SHE2MFhQQ0NsSjB3NTNidVZCdEoveHV2TnMzRWZpdmo0?=
 =?utf-8?B?NUE5M3JEeEx4VG5NRFNNVWFvSFRBTElURnNkaXFqdGhIanErbVk3dkY5OUgz?=
 =?utf-8?B?UnFyaWhaQXAzVjBaUWVhT0VZWFJ6MWxhTzdlZU5SODNKTVRHUnB6NGpnUU8y?=
 =?utf-8?B?UGZ2cFhXOStoNzlKQkROZ2hSMW5tMkdFcHlnM3RRaTNsMWgyZFVqRDB3T3VY?=
 =?utf-8?B?VnplZVllMW4rNWpEc0hVb3dTcEpuMWxFSGdyRlFKMlVHS3BoU1BDM1doUlBl?=
 =?utf-8?B?ZkJCMWxKWmRMRWo4M0FxbVBHZXdUTW9pT21QU0FST3JpZmpyUGFOMEIzTzlv?=
 =?utf-8?B?V1NkTkphWmpxVGN6d1B2SnFpMjloNTJETUJVWmVRcENIbXA4UTZWRDA4b2tI?=
 =?utf-8?B?Q0Y2cG8zMDhtbzlDNDhlQUczNStUUWdRb0VFM1hhdCtPbDAwcHF5ajZGRGtH?=
 =?utf-8?B?dWlmWFAvQWoxRlI3YkRDQ2VDbi80NEU2RHIzR3A4bG1UY1dOcEswR29hSnVY?=
 =?utf-8?B?RjZvVm9lNW84Y1YxL2ZTb09WcGpiRTFBV1RjN0Z3U2NoWENNVjZpNG1LMDJB?=
 =?utf-8?B?eTN4NUw1RFZhTWJUYzc4R0xWTVF4MmtQMlZTbGZJVGtSY1FPbEVkTDNlcmZQ?=
 =?utf-8?B?Y2ptTWVpV3FiT2gyWkI2UktCM0pxT1grNGlWeW5QZG5IKzNtQkNDWEY0VXlm?=
 =?utf-8?B?SWRMN3NwT1J0bE5lblBZWmFzeHhsL2U2S0VnQ2I2aUlneStSSm90WW1scnU1?=
 =?utf-8?B?VmtHN3BhUTVGQnNPemZrbUZxNUdoeWwxRmw1MTJWdzJKandJRWsxUTJEQ05O?=
 =?utf-8?B?NVRiS3dkUHJXd0krTVdNU2drU0tpR0poNTVka2l2NTVmVENZQW8rNWRoeGNp?=
 =?utf-8?B?eDJEOVNwaXJuNnpUeE1LVzVxcEdHNklQaXdGb1NvZDQ2bFRrK3NQN3ZPcVA1?=
 =?utf-8?B?RkRTaEY2V1FGZEdBYitqYlE5RHpCZ3NRVE8xb0ZyNWJZQmNBWmp0aWxrbzlI?=
 =?utf-8?B?UHBHRi9rN3hhM3h5TWhrRnZ2c25iRDlSVVNVMlJaamVmTmtYc2VERERsdCt4?=
 =?utf-8?B?SkhiTmRCQ1pmT2ROSmhXaEFmamdWQXlUc2lkSSsyaGc4a1F0SlN4VTFYOTR5?=
 =?utf-8?B?OTUzZTEwWlF5U24rRzlPNy96Ykg0aExWVDdqMndncHBJM3FTUk1pQk5rWG4v?=
 =?utf-8?B?WWNZL3VwK2xUVXlaeGVWS1NjVTBURkd5K3N1d2NRWTRNdGRXZitDdXg3M0M3?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b63e36-f51b-488e-40bc-08dda1be77f6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:15:58.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ND+auyGVLlEYwIVLvEVekQ3E4QWYr9W4Pl94N3K1bDMYBj8MK7VONFKiOvrf5kxi+KAynfO3MQaLsEIhk6rAcVtxeWsRkHxvZsrgLofYBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10660
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 10:16:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17670

Hi Mike,

On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> I seem to be running into a problem in Scarthgap that relates to outdated
> stamp files not being removed. I think this results in tasks not running
> when they should in later builds. I don't believe that this problem happens
> with Dunfell[1], though it does still happen with current master (both
> Bitbake and openembedded-core) too[2].
> 
> In case my description below isn't clear, the files required are available
> in
> https://github.com/mikecrowe/openembedded-core/tree/stamps-not-removed-repro
> though
> https://github.com/mikecrowe/openembedded-core/commit/8fd8055ab3e1d2d429c6076481952bace251750c
> is probably the most interesting to look at.
> 
> My reproduction requires a package to have two different recipes with
> different COMPATIBLE_MACHINEs and swapping between building for those two
> different MACHINEs. I'm using dummy recipes called lictest_one.bb and
> lictest_two.bb because I'm able to reproduce this problem with licence
> files, though I suspect that it is not limited to them. I have two machines
> named qemuarm64 and qemuarm64b.
> 
> # PREPARATION
> 
> I first start by running the cleansstate task for the recipe for both
> MACHINEs in order to ensure we're starting from a sensible state:
> 
>   MACHINE=qemuarm64 bitbake -c cleansstate lictest
>   MACHINE=qemuarm64b bitbake -c cleansstate lictest
> 
> # FIRST MACHINE BUILD 1
> 
> I build for the first machine:
> 
>   MACHINE=qemuarm64 bitbake core-image-minimal
> 
> At this point tmp-glibc/deploy/licenses/cortexa57/lictest contains the
> licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest/ contains

Intuitively I would say that your recipes also need to have PACKAGE_ARCH 
= "${MACHINE_ARCH}" set and then this wouldn't be an issue at all I 
believe (because different directories for each recipe). I'm not 
entirely sure what is the recommendation for when to start using 
PACKAGE_ARCH = "${MACHINE_ARCH}", like what's the thing that should 
trigger this addition in the recipe?

I'm also not saying that this isn't a bug or a bigger issue, even if my 
suggestion may work around the issue.

Cheers,
Quentin

