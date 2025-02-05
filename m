Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA668C02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 12:30:57 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.124])
 by mx.groups.io with SMTP id smtpd.web11.10885.1738758648080715335
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 04:30:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=IhBYN3Ry;
 spf=pass (domain: weidmueller.com, ip: 40.107.249.124, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYSJdG+rgAETh5TV/OMjVSAn9NBDQFKeTG+qDhqN1PkMTYp8Revq7mfykuleqNYPBsgfWeGFXwxIlqgrc6Sj9tWwUic/PxGqdDyh3EqKVRChjz62ZdJv134dxSjcxoo8CxMCjMMBMby+hHbjmOlXttrf3zK4vjcYWXcEPfxvtXnmBL9mYnNP+5vEdQ+WNaWldfFqrTDFK8/zvdzABrjm4HVmABb2fT2r24NAyDg7As9/hA1yDU6h7HVemSNxCb6vuQ6EJskc6YXXvbeG9m0DZT+YbPvH6MY68J6zJ5EnvF0/BhOuxxFQZHFEp7imVr52q/ihqsNbHXLf3ZZqKNURpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Te0PHVUIPoBzomCouRsWRE/mBvKts8eIvCpQ/IrP2A=;
 b=moV8DoiWn79+jIqdUE/ec+ZReP9bU4ri1toHHcUOPhalGKTHy/7W/1TD04Wsi1AYFFFeFIlDNkp/d9Z9TnreISM1R+5sJMjmDB3JOg8nXGHGxisoVN8tIxbF5I688msbUCW5h9ECnH571CHQdL6QcAcBVvWsx8lYsGAe8T/VRCKKCInAAP3g1i4FEil/WmrTP7aPDIblPPRljljUB7MpFnVAA/xUcmX82mNSemTLhB1ax0is69d1HqmdwFYINpkKbbZYW2q3km+EnOnCmy2f4EnQTkRfEHpXyYn7bb3sqiKKv1WsxCP2bQua7yUuJiXnl5N3E+ZDyDQlKDUvbUxkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Te0PHVUIPoBzomCouRsWRE/mBvKts8eIvCpQ/IrP2A=;
 b=IhBYN3RyM27E9tjeJumGcezSXWBWm9PfF98ABqE50lBicaekvJ0FL5pDHJu3ZYd6cjNI1yv0amneZQ7sZR8conHJsFXmcNm1bKixrDuido+H4F+vLPd4ChZ3di8xBlBOHILruVpoxsqwWhIKnCovCnkV+KphnuV5GHKL/EVnMhU0jLjKhyrHdR+dbvEFxW8ifjfIWcgEE0IqEb4Cko/h1EW1W7TR0+iuLLnLKqgPuMu9fjO6i6Aw5A9hz1ajqZILgsYMwlcMQSb/EXN4HdbwwPXA3mnayqwhFrb6Msj2F5fMWM+1KqvrocRiVYqyILroEZH/aaw9sHtgbeZfe6G0jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5863.eurprd08.prod.outlook.com (2603:10a6:10:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 12:30:44 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 12:30:44 +0000
Content-Type: multipart/alternative;
 boundary="------------qWpL0UKJ9QbjeuMhqbCs0OLS"
Message-ID: <f30b9dba-868f-4692-8fb4-44b13047546b@weidmueller.com>
Date: Wed, 5 Feb 2025 13:30:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement syntax
 explicit
To: bitbake-devel@lists.openembedded.org
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
 <18214EC364EFB1B6.18160@lists.openembedded.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <18214EC364EFB1B6.18160@lists.openembedded.org>
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 782faac8-d60a-4d30-1c60-08dd45e0e8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NFBMbXI3QmRMYlhocFRHdHRCOUJ6bTVvK3RRd2RqK05XRHZMb1p5T3cwSFRZ?=
 =?utf-8?B?ZmQwWVI3dDRvbG9QSU5wazJvVmF5UkVCbHVoRkFPNzFZbUFiZ2xCUXRwYkxz?=
 =?utf-8?B?M1c0emNObkxYVlBHSllRRllVeHMzOGRGR0V3MWpuZjlDZjRTejJUYXFEWm1v?=
 =?utf-8?B?a0tXcTJxRUR2UlR5NGxJZjJaNFg0a0QzZFBmQjFReUV2cEFTd1pDTzlHRHdK?=
 =?utf-8?B?ZTE5dHQzWkVreUxwenU3U0U5OWR1akZqYk96VDJGQU1SOENYb0hyNDJOcE1R?=
 =?utf-8?B?bzI4bGdNK1ByMm8rK0JYdmRrYjRRUVlER3B5RkMwNm1rTldiVXl5ekVKdnR1?=
 =?utf-8?B?aks0MFhVdEc4S1dxRUhka1drRkp3MDhrY0MrdmdraEhoNnVjUHBaL1pleFF6?=
 =?utf-8?B?RUN1N2pLaWtEcjRDNzZvT1R1alpGdG54N1FKM0g0L1BqZFdLSTk1emwrUHlj?=
 =?utf-8?B?WWptRU1xN01JUVV4SEgvaDkzNnBBdDdpV2wzZzJRZzYyVGdSMXltcUgyT2Zq?=
 =?utf-8?B?YzQ5QzMwNjMweWZtV3Q1SW9UWWNScHZVdEk5UHk4NlI3Zi9ud29IZy9tMnFO?=
 =?utf-8?B?cW43Mnk4bVRNWGluZVVGLzd5MHNiOTh0TmtKUkw5ZVpvdnFaaFE5M2ZLL1Jm?=
 =?utf-8?B?OUQwQ0swdG1RSU5PMWZ6WmNGQktLRm9SNUtmQVErOXZMalk3eGlialcwa21F?=
 =?utf-8?B?cStCL205OUhmMnJmcWlWclA0MDZBT3ZpTzJQOXk3TlFyaFNQOUVHMlhFYm4z?=
 =?utf-8?B?QlJoSnFOeDlMdTN0SUpsSFpXVWtzaHF3RlJSZWhJMmxnb0dpdjBKcXB5YWtC?=
 =?utf-8?B?SzFlSWl5b2x3VjB0RHJtYU1xbGNrYnR5WmdtZmF5UjRlSGJkV01lazhjdmxR?=
 =?utf-8?B?M0ZyRkZvcSs1MldqZm9hOVBLc1VhWmpaQ245N0pRVnZ3Vm8zYUorZy9PeDVt?=
 =?utf-8?B?Mno5RFVsOVc0NUJDK20zdnFRdnRMSlBoMkFLaTRFQ3d6QzRRY2d2dDhEeFM2?=
 =?utf-8?B?Y3VOR3AwN09PdWRoTFlDR2NBL2xZYkg5TS9oQ3ZJTXcxQmM0Ny9PRUdTdHBu?=
 =?utf-8?B?SXdBaHFua0g0S3VCeW41QVNIWHJqUXFaVmpXWkpJK3owdzJzdkNNUVExbTdw?=
 =?utf-8?B?bEsyTUppOS9kZ0JEWHgyTHV4VUtUL3hXTU1jb1AvRG55M1VaRjQzY3c0Mis5?=
 =?utf-8?B?QnQ3dlA4ZDNueGRyMk52SDZQRmpVUWNVSWxMeEVTaXAydXFPcjNJNkdhOElH?=
 =?utf-8?B?TEJIT2JteVY0QU9VcC9wbXp5MEQ4RHF6VS9RUk5RVnM2WVZDVVpCQlgyVkV2?=
 =?utf-8?B?M21oaUFEeWhMa0N5cGU5bFFSamdvL3lQR0Y5Vk9LT1M4K1VQNlJReXlMRkYy?=
 =?utf-8?B?K29pZ0xjeHhVa1NvMzE5ZklPeHY0VStUeUljZSs3dHo2L041QXhXOVBWU1dL?=
 =?utf-8?B?VXcvOVZJL2o1WmhBOG1DamhhS2Z2TGs1eWgzZGtKcjF4TEN4bEQ1cGJMcDhi?=
 =?utf-8?B?S2hVbVl2T3FFTzA2dHpTVWlMdmg2aUJZeFNIdnlDV1NNREtMenkyQmphVkxD?=
 =?utf-8?B?MDdSRko0Vllkd2NtNm5iSEVKdzdybTZsdEJLK1hxOW13QzFFd014OEdhMlJl?=
 =?utf-8?B?NGVQa1FnUWFXT1p2Sk9zcUhsU0VwWFV6VWZYZHloM2o4eU04WmY5MktESXFE?=
 =?utf-8?B?NzBwb2Z5cHArQXhOb29HYy9CSVJlS29KMkpKd25nNjNUMTZNQksyckxYZHdt?=
 =?utf-8?Q?Lupa2hHBtrecfoRFikdpuSepwP1nCZv2RhZQYkq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emZPK1FGb0xSSTM3UTc0eityVmRLZGlRenhFZnhnVnJGZmJkanZUcFB1THRB?=
 =?utf-8?B?c1VzQmRibUxGNzE4VnVva2VHVzZZalFET0diM0ZSd0k4Kzg1TVpkeS9Cc05E?=
 =?utf-8?B?dzBaV2dLVXdDQm1NOFQ4WEFZVEJUVWF1NlduNkllYjVJUjJJNTF6M2Z0OWRY?=
 =?utf-8?B?TkN1YnpCY2hnRXNXcS9JMU8veFZyWml0RVgwQWQ4SUNhSkRQTktSUDNZdXNH?=
 =?utf-8?B?YzBsZmx3NE43c1ltQXhmWk1xazR4MnhqYTByMlZzYyszMkl6T3k3QWp1dUda?=
 =?utf-8?B?Rm8zbWJiTDc4UGtFOWVOTVNwbU51OU1JK295M3E5T1l4ZXlsTjdmYnVWd09B?=
 =?utf-8?B?a0JpbzgrUFNDK0ZWUEVSRG5YNXNtb2ZaYVZQSEhrSUNKekpaSXZ6U2pESlhv?=
 =?utf-8?B?WStPUk5QNGNXa25yV0JkYlFyNWx1bFdGWWRyUHNES2Y1Ull3aW9SQ2Z0c0Rh?=
 =?utf-8?B?Z0pmME9xVkVwU2d3VWRUUXVLWDVZYUJqTFZ0d1dyWWpTdXZyNkx1UlVYZlNT?=
 =?utf-8?B?aEJMa1pYYUhHNWt2bkRsb0xjdDVYSVE1RXl6dTF2UVFZcnZYNytjaXdQU3Qx?=
 =?utf-8?B?M0lYaCtiNFBLWlNsR1g1aStJNFh2dVd3cnVjRTdoZmFmeXozWmFta0V4d2xB?=
 =?utf-8?B?dWpocktjV1dIV3o3bVRpZ25EbU8wQWtDN1lsR2FzQ1BGa1lKTC9vYms5TEpr?=
 =?utf-8?B?aVorcmNhVTZrMlJTLzMxOEJ6UFp0WGJLWEk5S0tWRGMwaG9CQ0lqVTBWc3ph?=
 =?utf-8?B?TmM3SVRkKy85cDFhcGdmRlRkUVh4TW90OUFtOFNFa1d4d2dxbFJIZzBuQXhK?=
 =?utf-8?B?MFZVRE5KczQ5RFBBKzFDVTEwTHNtY2ltcGVMN1BIa0tVNm44bjNqRUE5QlhL?=
 =?utf-8?B?dENjbk1hbllCWGxQM1I4WDdTTjhhNkg2Ty8yR1ZESzJpVzl3dkMveVJrMGNK?=
 =?utf-8?B?U0JuaUNQaVo2bWJ2ZHFzSlRLMkMrUXBEUGl6Zm1wY0JPNzIrN2k4SzZrUHpW?=
 =?utf-8?B?clJWMEtpZUdGeGFKYnMvRTlmQi82NmJEajBKa2VnWHRkUDdLRlIzSnY4Q0RM?=
 =?utf-8?B?L0ZHbTJxb1dlYTFseGFtNlJZRk1nVFkxdFA5aGVUd2xoK2o5dURZcG9OL0t2?=
 =?utf-8?B?THY0elM1ai9xME1sRHJpSGFhajU2U2NXSXd2eDFNL1ljZGFvZDhSS3MwVjFi?=
 =?utf-8?B?ZWlpQWlVRm1PWXh3YlFtTVZWRCtoWHBSMzFXa3hEV0IxdXhMd29RSHJOOUxF?=
 =?utf-8?B?eC9TTkpBdlVhQ1g1aXNtQXJOaFBiTWsxblRTZEdUQ3dLVjI5Mms3TCtvcHRX?=
 =?utf-8?B?V1EzaFhLUFBYUU9WYmw4RmZoWmpVU2QvSkVmdDNOcVk3Q05rMnJnQzAxS3l4?=
 =?utf-8?B?aHdqOHcxMDRMYXgramR2azlDVUtmYkd6bGwyUlNrTUdEcXFZdFhwb2hTeHVY?=
 =?utf-8?B?UytqWC9lMGZYR1F6NlBxYkY2a3Y2emN4SzUvNjZzSjNCMFAzT2hUSG10QjNX?=
 =?utf-8?B?QkxkRFpFQ0t5d2N5eUlZSGRsWDBPeXNRaTdFa21rUDVvaVRJQnJtZ1ZZcGpI?=
 =?utf-8?B?UWluL2hYQnhoWHZFK0FNT2FMS1cyUDRYUFFWSE1tUHdUVThwcHNLb1RpNGVZ?=
 =?utf-8?B?a0E3RlREOW50QWQ1YjlMKzFTWUFCd00rOElacnozaWt1Zlp2bkJEa0VZLzdE?=
 =?utf-8?B?MTVnVUx4RnJVZEFoOVFCWGVSZWpHY2JpUmw5Y3Erd3lhdWdwN2lIeVVaYjhq?=
 =?utf-8?B?Z2NRU003MUQzdXdBN2pBWEdVOUM5Vm5JTkdYSFgxZUdRbG9YRjZuMW1iaXB3?=
 =?utf-8?B?RERLdEIvZGJ6eDFJeUxCOHpzUEVmK0RzQUlHT01Jd0tVTTJKQmtOUjNZQjM4?=
 =?utf-8?B?U01QcFJBaVF5TG1SemREVDdSRkgvTjlrd3pWNmlBdWNFM2pFSWJCNWlIQXRT?=
 =?utf-8?B?YWZlNWcwbWdKekRlTGc4dDYzL0ZaZ0RWTXJlVTFYUitWNndmQjArQmFXVGQ2?=
 =?utf-8?B?cGU0bm9rd0JLRzhMRzZzNEN2M0ZJamhYaDhIZXN2ZnZ2M0dybVpsdGtsSzJW?=
 =?utf-8?B?dGloWkZmYk1ibU5sZXk5YmY1aDVpclNxTCsxT0dYdGFJRTdScndsWXk4WEZU?=
 =?utf-8?B?L1A5UEgzcWtpYVZTcHBVZnpud0ZNdUppK2xOZjJoby9tZ1VQVnVzdkFQOGNn?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782faac8-d60a-4d30-1c60-08dd45e0e8d1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 12:30:43.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAh8j+VKl7TN4QJlKFejj2WZ8Efr7L3HxJ+30ODzgZvYHmZ7EPgp2Xfmh0y5mdJb0CUhJzy06ajOnFNv9zGqew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5863
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 12:30:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17152

--------------qWpL0UKJ9QbjeuMhqbCs0OLS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.02.2025 um 13:12 schrieb Stefan Herbrechtsmeier via 
lists.openembedded.org:
> Am 05.02.2025 um 11:34 schrieb Richard Purdie:
>> On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>>> The mirror replacement syntax contains many implicit transformations.
>>> The path of the URI always contains the base name of the downloaded
>>> filename. This makes it impossible to rename or remove the base name of
>>> the original path. It prevents upstream mirror for SRC_URIS with a
>>> downloadfilename parameter. The base name of the downloaded filename
>>> makes it impossible to use the download mirror for SRC_URIs with
>>> subfolders in the downloadfilename parameter. Altogether the implicit
>>> transformation complicates the understanding of the replacements.
>>>
>>> This series adds an additional replacement named DOWNLOADFILENAME. This
>>> replacement contains the relative filename of the downloaded file or
>>> mirror archive for git and hg. This allows the user to explicitly define
>>> the behavior. The usage is equivalent to the PATH replacement for the
>>> sstate mirror from file to https scheme.
>>>
>>> git://.*/.*http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME
>>> https?://.*/.*http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME
>>> file://.*  https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH
>>>
>>> Without a replacement variable the mirror will use the same base name as
>>> the origin SRC_URI. This allows the usage of private package manager
>>> registry together with a downloadfilename parameter or the rename of the
>>> base name.
>>>
>>> https://registry.npmjs.org/  https://example.com/npm/registry/
>>> https://example.com/example/1.0.0.tgz  https://example.com/example/example-1.0.0.tgz
>>>
>>> The series adds heuristics to keep a backward compatibility to common
>>> styles. Because of the ambiguity of the old style, it is advisable to
>>> remove this compatibility sooner or later to avoid unexpected behavior.
>> Thanks for the patches, these look interesting with some good
>> improvements in there. A lot of the series looks like cleanups and
>> those look like good fixes to have. It may make sense to split this
>> series into two, the cleanups/fixes and the behaviour changes.
>>
>> I'm not entirely "sold" on the naming of DOWNLOADFILENAME. You have to
>> think about this from the perspective of someone writing a MIRROR or
>> PREMIRROR entry - would they understand what that means vs some of the
>> other names?
>
> I’m open for suggestions. Even ARCHIVE or TARBALL are hard to 
> understand because it is only a relative path on the download mirror. 
> Alternative we can mark the lines as upstream or download mirror and 
> give the replacement different meanings. The path could be the 
> original PATH for an upstream mirror or the relative path of the 
> downloaded file for the download mirror.
>
>> I'm also a bit nervous about breaking compatibility with the older
>> syntaxes. It is unclear to me how or when  we'd detect/deprecate older
>> formats. I do agree we probably do need to remove some support for some
>> syntax and move to something new though as what we have is turning into
>> some kind of nightmare. FWIW this is really old code that in many ways
>> predates my involvement so probably 20+ years old.
>
> The only possibility is to mark the new format because it is 
> impossible to know if a replacement want to keep the base name of the 
> path.
>
> As example the following replacement is used in the test:
>
> file:///some1where/.* file://some2where/
>
> The plain regular expressions replaces the complete path with a new 
> path but the old code appends only the base name of the path. What was 
> the desired behavior?
>
> file:///some1where/ file://some2where/
> file:///some1where/.* file://some2where/BASENAME_OF_DOWNLOADFILENAME
>
The BASENAME_OF_DOWNLOADFILENAME is wrong because the original is a 
local path and not a downloaded file:

file:///some1where/.* file://some2where/BASENAME

> The main problem is that we have to keep the bugs if we keep the old 
> behavior.
>
>> I'll continue to give this some thought. If you could confirm which
>> patches are "cleanup" that would help though, we can see if we can get
>> those in a bit faster.
>
> The first 8 patches are cleanups.
>
--------------qWpL0UKJ9QbjeuMhqbCs0OLS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 05.02.2025 um 13:12 schrieb Stefan
      Herbrechtsmeier via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:18214EC364EFB1B6.18160@lists.openembedded.org">
      
      <div class="moz-cite-prefix">Am 05.02.2025 um 11:34 schrieb
        Richard Purdie:<br>
      </div>
      <blockquote type="cite" cite="mid:f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org">
        <pre wrap="" class="moz-quote-pre">On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The mirror replacement syntax contains many implicit transformations.
The path of the URI always contains the base name of the downloaded
filename. This makes it impossible to rename or remove the base name of
the original path. It prevents upstream mirror for SRC_URIS with a
downloadfilename parameter. The base name of the downloaded filename
makes it impossible to use the download mirror for SRC_URIs with
subfolders in the downloadfilename parameter. Altogether the implicit
transformation complicates the understanding of the replacements.

This series adds an additional replacement named DOWNLOADFILENAME. This
replacement contains the relative filename of the downloaded file or
mirror archive for git and hg. This allows the user to explicitly define
the behavior. The usage is equivalent to the PATH replacement for the
sstate mirror from file to https scheme.

git://.*/.*&nbsp; <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME" moz-do-not-send="true">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME</a>
https?://.*/.*&nbsp; <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME" moz-do-not-send="true">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME</a>
<a class="moz-txt-link-freetext" href="file://.*" moz-do-not-send="true">file://.*</a>&nbsp; <a class="moz-txt-link-freetext" href="https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH" moz-do-not-send="true">https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH</a>

Without a replacement variable the mirror will use the same base name as
the origin SRC_URI. This allows the usage of private package manager
registry together with a downloadfilename parameter or the rename of the
base name.

<a class="moz-txt-link-freetext" href="https://registry.npmjs.org/" moz-do-not-send="true">https://registry.npmjs.org/</a>&nbsp; <a class="moz-txt-link-freetext" href="https://example.com/npm/registry/" moz-do-not-send="true">https://example.com/npm/registry/</a>
<a class="moz-txt-link-freetext" href="https://example.com/example/1.0.0.tgz" moz-do-not-send="true">https://example.com/example/1.0.0.tgz</a>&nbsp; <a class="moz-txt-link-freetext" href="https://example.com/example/example-1.0.0.tgz" moz-do-not-send="true">https://example.com/example/example-1.0.0.tgz</a>

The series adds heuristics to keep a backward compatibility to common
styles. Because of the ambiguity of the old style, it is advisable to
remove this compatibility sooner or later to avoid unexpected behavior.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Thanks for the patches, these look interesting with some good
improvements in there. A lot of the series looks like cleanups and
those look like good fixes to have. It may make sense to split this
series into two, the cleanups/fixes and the behaviour changes.

I'm not entirely &quot;sold&quot; on the naming of DOWNLOADFILENAME. You have to
think about this from the perspective of someone writing a MIRROR or
PREMIRROR entry - would they understand what that means vs some of the
other names?</pre>
      </blockquote>
      <p>I’m open for suggestions. Even ARCHIVE or TARBALL are hard to
        understand because it is only a relative path on the download
        mirror. Alternative we can mark the lines as upstream or
        download mirror and give the replacement different meanings. The
        path could be the original PATH for an upstream mirror or the
        relative path of the downloaded file for the download mirror.<br>
        <br>
      </p>
      <blockquote type="cite" cite="mid:f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org">
        <pre wrap="" class="moz-quote-pre">I'm also a bit nervous about breaking compatibility with the older
syntaxes. It is unclear to me how or when  we'd detect/deprecate older
formats. I do agree we probably do need to remove some support for some
syntax and move to something new though as what we have is turning into
some kind of nightmare. FWIW this is really old code that in many ways
predates my involvement so probably 20+ years old.</pre>
      </blockquote>
      <p>The only possibility is to mark the new format because it is
        impossible to know if a replacement want to keep the base name
        of the path.<br>
        <br>
        As example the following replacement is used in the test:<br>
      </p>
      <p><a class="moz-txt-link-freetext" href="file:///some1where/.*" moz-do-not-send="true">file:///some1where/.*</a> <a class="moz-txt-link-freetext" href="file://some2where/" moz-do-not-send="true">file://some2where/</a><br>
        <br>
        The plain regular expressions replaces the complete path with a
        new path but the old code appends only the base name of the
        path. What was the desired behavior?<br>
        <br>
        <a class="moz-txt-link-freetext" href="file:///some1where/" moz-do-not-send="true">file:///some1where/</a> <a class="moz-txt-link-freetext" href="file://some2where/" moz-do-not-send="true">file://some2where/</a><br>
        <a class="moz-txt-link-freetext" href="file:///some1where/.*" moz-do-not-send="true">file:///some1where/.*</a> <a class="moz-txt-link-freetext" href="file://some2where/BASENAME_OF_DOWNLOADFILENAME" moz-do-not-send="true">file://some2where/BASENAME_OF_DOWNLOADFILENAME</a><br>
      </p>
    </blockquote>
    <a class="moz-txt-link-freetext">The BASENAME_OF_DOWNLOADFILENAME is
      wrong because the original is a local path and not a downloaded
      file:<br>
      <br>
      file:///some1where/.*</a> <a class="moz-txt-link-freetext">file://some2where/BASENAME<br>
      <br>
    </a>
    <blockquote type="cite" cite="mid:18214EC364EFB1B6.18160@lists.openembedded.org">
      <p> The main problem is that we have to keep the bugs if we keep
        the old behavior.<br>
        <br>
      </p>
      <blockquote type="cite" cite="mid:f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org">
        <pre wrap="" class="moz-quote-pre">I'll continue to give this some thought. If you could confirm which
patches are &quot;cleanup&quot; that would help though, we can see if we can get
those in a bit faster.</pre>
      </blockquote>
      <p>The first 8 patches are cleanups.<span style="white-space: pre-wrap">
</span></p>
    </blockquote>
  </body>
</html>

--------------qWpL0UKJ9QbjeuMhqbCs0OLS--

