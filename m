Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E211C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 11:45:42 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.140])
 by mx.groups.io with SMTP id smtpd.web10.47290.1740051940168005135
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 03:45:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=xxt/Lous;
 spf=pass (domain: weidmueller.com, ip: 52.101.71.140, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHfSgDiWRwxneD44UNUWnFX72ihTo3X0TWRcawF8nmDRXj92ultO63DVwWVpeSeY7oAKWEJB5iv/cbp17FTvszYK2buSxM9LkdrDfCqh6QR7IRzK13JuQ6snwlJmLtj9K2C2rGHcHzrzMC1SvKVfwxWlk4AV7SwD9hC/Kyjw3zb+c6IV9MPy+5enSxjjr6LE71vhqqyuJx3NwZ/Ai2Xt6HJSGVXFHMp+DmolQqb07cFFhc66ovw5/o66DtZ0CQCcSNB0DD0Fe41pRaWcgVd4jKPO1G9TH2oyJqzh6gNSe3zvGd2aPHk7Jv/CtFrj/huKEs+D241MalvXjJRw1SDXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjr2ILw9EhAwdhZNpodbO6Y7IgQ1vcOlDmHVKstUEv8=;
 b=m06pT8zLqvSBRuTFG7LS1peARZJLRLJgxvoikmKKU7Zp9oj9W+CfvW1wuo4oEQqy6IjVK1/9niHcn1FPwOyjalbkMLi9tMnXEru18JT+JlWH9QOuHIhCNDrroQ69gJhs7QcKzQf6poww2Ul1kd0La3z7AO+7SDLXYH4oCdd4ExdgfWCDqnPxsg4wVVNX81DTFZhJdjkckRdmkkppn9bw+XGgYdna7AKRz8xawPAOzn16q7YB6RGtTwy0eJuDbE4i9kmTm/BVNH9d9cFrxknHepXQIza4GWIGcg5jSfOjA70jzPelqYk8VqF2esLanp+W4grrzPfk5zGj3Vep+RJn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjr2ILw9EhAwdhZNpodbO6Y7IgQ1vcOlDmHVKstUEv8=;
 b=xxt/Lousz4MvmYOoXokpJJe/x4QrFcYLWojM6c07Gf7BNnqiHUeyabgCVKgWsN2LMYhDs/mTPibmkoRlBMQFa3gIMf+27wcwCSotTORrYIQLBMAhVVQ8kKZrA3mzrzoV4KRua3Cm3wZF/20SY90Zxp4wvtDSZd+mmF8S9bzQIw+tBwUuoAwDQO9VhbXXrXSsFCdSMsTqGHxnIWpDAmNo7+4OlQHjn6rEwb6F1EPborK2bhOIvVyyHx/LoWXTx4lkEBmJHKEPC5C1YH/TJ84SpvEzS2mh6U/hlKfFca7TBQuYcJA5rNmlQCPV6WnPOw8PhI/Gmno3ITPQOl++dnmZgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DB8PR08MB5324.eurprd08.prod.outlook.com (2603:10a6:10:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 11:45:37 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 11:45:34 +0000
Content-Type: multipart/alternative;
 boundary="------------xgNJVaab11WuIGirSsqOBznz"
Message-ID: <6d445c40-5f24-47d1-a71a-1060e9b9da16@weidmueller.com>
Date: Thu, 20 Feb 2025 12:45:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement syntax
 explicit
To: bitbake-devel@lists.openembedded.org
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
 <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
 <d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org>
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DB8PR08MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: e647c761-0a08-4972-c50b-08dd51a41593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0tXems2dlhkQ3VGSGVCRHhIaisxOE1HRU9EcCsxOEtsbCt4L096NUxzajZk?=
 =?utf-8?B?OTJYa29Kc3NPSDV3b0RWMFE3UG1iaWduOFZodFoxeUdHUThTV0hZaWRMcVlR?=
 =?utf-8?B?emh3c2poVWJHVzk1UitoUWlObVNSTFJZZWtWcG00aERNVnQ5bEZMT1VpVzVJ?=
 =?utf-8?B?VXphMzRkRkRyZzJEVFp6WERqYTBPWkc3Y25LcnNUcnBKQ0xUTGxvZVQycmFv?=
 =?utf-8?B?a01ITlpZU2o2Umh0a2k2c1NETUlDM1lSNndjSTdDcjI1eWU5SWRMeU5kdm9G?=
 =?utf-8?B?aVd1TmsrV2Q5M0prSldPckErL0JGbmY4dzU2VFNreTVGVGxmS3htZ2lnTlNT?=
 =?utf-8?B?UnJXS3k3V21qVkZhcy9tS3RCZ3hhUjFJNHBvbENwNkRmQVdxbTdYR2JrQlVr?=
 =?utf-8?B?ME1HbGFmY3pSeE1rb0NTcU5TTys0aWcyODczSElMeWQ5MUh6Uk8vVjlPaHlF?=
 =?utf-8?B?eFZBWHdrc0ZJRTMyVFpRWEwrWVpmMEdDRFZBWDI1Tzh1U3FQLzlJc0h4SmlW?=
 =?utf-8?B?bnpkZDh4SUpMWWxDbm94dmdXUW9OY2VybnNLNWxRZExwSWNYMS85Qi9Ra3lh?=
 =?utf-8?B?VjJSbnpPM00yRXlLaElCczQrU2J5VDJoNEtjOWxkTHhrdXpUTE1JaEc3TE5D?=
 =?utf-8?B?SVBOUXZxVC9HUkJ4SGIzK0dpeG9sdkhDNFZyRHdUcGZVQzJZTTA3THVhY1Rm?=
 =?utf-8?B?aHdpSzBJNDJRR29LTDNpSjFaKzZhRDcwVEFZeVYrMVdyV1RDUlNTRVBuTXJP?=
 =?utf-8?B?R21GS1Q5MWJwVXp3RzltNTkwUnNCaER5THBXaXZMQ1FKcG9QdE15dWh1cUJB?=
 =?utf-8?B?ZEd3bFdOblpSd3o5SVMzMkxOTWZrbEMwS2dLRTNIeld5MG00OFlWTEJEb0Fl?=
 =?utf-8?B?Qmh6R3BRNXNKRGxIRnErTmlqU0xwR0hEZzhXMVFiODVDWitpNWlCSE83UEIr?=
 =?utf-8?B?T3hmTS9vRVZyQU9UQ2VXaVNycGluQzRQUkVDNFJKLzg1ellOTHdDOENFWnE5?=
 =?utf-8?B?WTRRQ1pjaExxTThRQkI0elVhZDh3c21YSUU0Zzl4S09GbDlEZmU2d3BrM3Nq?=
 =?utf-8?B?YWV3cll3ZjZWL1BGdFdockFuaVJMU3d6UGlydWJLQXBONUYvL1YvTHEwQVJs?=
 =?utf-8?B?VXdCTloramV1YytrN0g4M2gybDRaU0lrNzk4V3BQWXVNdGNLWXpyTUJ2TzFy?=
 =?utf-8?B?ZVNzTXlSZ0wrZS8zd29tbmo2NVpJSDZDY0c5eWJBSjMrbE0yN1plZE9lQ29t?=
 =?utf-8?B?NFplOEdNcjV0MXhZVFZPZUFPVGJMZktEbWZNT1Joc1ZWWVFuWGg0T0I4WGlK?=
 =?utf-8?B?d2RNeWRJSmZVVVBpNmJNT2ZxbkphVUM0UGM1bG04dzJYZ0cvYlFyWUVkWkcv?=
 =?utf-8?B?cVBHWlJaRXdBSWdvaXA2dVpWVW81Q20vaFFLS3IwTnhFUlZuUENQVnFrUFZP?=
 =?utf-8?B?RjVpMG1FN3FqUFNNSml5UFNSRTBpT1NmM2d5MFE2VDlpNy9XNW9ON1NESTg0?=
 =?utf-8?B?eUVsMStvbmxkTUZGZ0d3Y0gvNmtJRG4zTHlCNWkwb0tmVEdSS1RpWTd5Z2dV?=
 =?utf-8?B?bXlvMndXbEZUVmlwY2MwWmdmTVpiMDJGWE9UNFI3TzM5ekJWVTBGOFBHRXZs?=
 =?utf-8?B?N1FWZFhHdWRsUm43M0c0Vjg4RmpKTy9CQUxOWk5SL3VhdFdZdlNvWEJFVEVG?=
 =?utf-8?B?QVgzZVFBWnlXTm16RWJNUjlES0kvTHdKaU1EaWxGV1AwWSs3MTl4VGUwNXBu?=
 =?utf-8?Q?EgGr0SZ/E0Yt0VkdeAT0u7vpv7AlRwqVkozMBmV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWJGS0hsSkFzYnVxZXVNZXJsZzR3UjVjZ0o4ZFhsdm9jdjdkY2VFSWVKOVBY?=
 =?utf-8?B?Rk1UYk00bkdoaGhxMFNvL3djKzRuYVM2NEFRamhwZmM5U1U3VS8rbnhRZFhh?=
 =?utf-8?B?dnZtL3AweWZTM0dhbkk4N2g2TklnVERrNUlveXdXM2R4RThwb3VqS3ZKbVll?=
 =?utf-8?B?R29xeVh6ZVJBeDlvVEdPQ3l4Tk5KQWxhN01qbTJ1blF3MnJkSzR3bXF5NjVm?=
 =?utf-8?B?Nlp3a1pRUUVlU1pORXZQbXNMSE0rK2YyaHlQbWdYbEdFYnMvMEF5NkwvcnJx?=
 =?utf-8?B?dkZLaEFaVHRKVEdLRXNJMG5kaDh2NkFuYUw3aDRPWFZHSjhKV01OMk1aTUhP?=
 =?utf-8?B?Sm5PMkVrTE1pOThzaENLeEdLVjBGaHUyM1pJaEJsVmI3czRnS2dEUDNWeE9z?=
 =?utf-8?B?aU16Q25HT1NCWW9FTHM1a21uc3ZBQUhBWVdRYzNzM0V1Nm5aL213cXZ2VGFT?=
 =?utf-8?B?K2dFUElwaFNKSHRuOTZNU2FsMkc3d0ZHN3hhaFlGZ2hIN0pyZHF0ZFM3cWxl?=
 =?utf-8?B?T1piR1JaRDA3SmdDRkVMYnloM2l4MjhHU3lxQU5qR2lJeUcvMndUY3AxSkdP?=
 =?utf-8?B?VFVKZWo4OFZydzk5azFiVHFkMCtZa0svS3hKMEo2YnpiRkMyM2xZQ1NBNkF5?=
 =?utf-8?B?ZWliVVVyRng5WTl2ZE91NGxSLzVZbXI0NlhMZ3E2QkhTQ2d3bkNBQUdXaTB6?=
 =?utf-8?B?ZVprdWRKSUlNV3hXRUF3RXJTWXltTDU2dmNKNkRDdmdrZnAvdm9hcWwzYzk1?=
 =?utf-8?B?am4rVHRQUkwzdUd4bzUyQzU3WHRPelgxU3Jid2dqR1JMYzNYcldQK3k4SXFo?=
 =?utf-8?B?SmdSRHoyV0cvMEx2cHllUkVFNXVUemxIc0hsUmZFdFJCa2NxVVdsVzhvOGdm?=
 =?utf-8?B?eUZ2eVk0R0pWbU45YWhzb1lsU24wNWpaSHVYR2hqY3FWUEsrTm5vWlFDV3E1?=
 =?utf-8?B?VVVCUjRzZU55b1pmRzFpZ0JDQzgvTndNajF0citsOXVJOHc1dGh1WjJNTlVy?=
 =?utf-8?B?L0JNSFlsVVluaThZZHNTUlRBd1VVWWFsWU1hTm81bWtrOXBPZlFaL2VjSEdV?=
 =?utf-8?B?NFh4WUpEbzBVc2d4dkF2TXNRb1NHTWxnZVpIaUtEY09mcWc4dVFYM0JRMmlV?=
 =?utf-8?B?Q0E2N2ZMQiswRE1xMlB5bjI5UU1tYS9BU3JoUlQyeTlkUW9mcEV3WXdFOGlT?=
 =?utf-8?B?UGptdWswN2VWS1ViQ1d3QmY3ZkwwSmpJQlNVRFMzNHkzZzl3QzU4N0pKQmhX?=
 =?utf-8?B?YWJFMjR4NnNFSm5oVkNWYzdoczhyYlVpWGxWTERWZVNaYjRseHo3UlE1Q0Jo?=
 =?utf-8?B?bVJWOXozc3Ywclp4TUJmQ1JOYWFpY0M5R0N3U3NzT0xCdnRKSUp4bTJyRlVa?=
 =?utf-8?B?MTVpb3Q0bG5ZeW44dFEvelo2SGROdVRtMVhvVEhLS0xaNVArVFdhdHJybUJ5?=
 =?utf-8?B?MEJjOWpnMzFwZ3Y2SCt2L0hWWjZMKy9HcU1vbG1lL2QwMkNmQ2UxZ2xkU002?=
 =?utf-8?B?cXZOcHJCa0o5OG5nUHBQWFl1VXZTVHlRWXYrUmp2L1NNS3pRNWU3U2h0eFZT?=
 =?utf-8?B?QmlKeHRqTEx5bVVkQ3AvMTF2NmMzQ2NJU3BTdmVodE9mQXdrOHpaSW56UGVJ?=
 =?utf-8?B?ZW1SaVFuUjFpai9KU0p1K0l4Z3NOS2l2ZU9uR1ZtekkzRnRKMVppV0xETjFs?=
 =?utf-8?B?U084enJHSGY4eFYvRzdwOWhKMytjWlZnUk1vd3p2QUtuaWg4ci81RXU3cDFw?=
 =?utf-8?B?OEQwcmRDeVp0Q0J4YmcrRGxWcmpuVFUyYVhiYjhVbFJoNFFsZGwzZExONXVF?=
 =?utf-8?B?VmJDWS8yemNPMGNCVnhDSmpoazlVeDFieTl2UEZ2WEtSTGliQ0tLTnBGZ3BH?=
 =?utf-8?B?USt4aEZ1T3FrR0tRbUZzSFYwZVFQZC9JcW84VTdQM2NISURmekJhQjZwRVNr?=
 =?utf-8?B?OXZNTDhDcEl0WjJUazRDcWl3d3FpaGxrWHdlNTFMTWhVMDE4UTU4OStWQmlk?=
 =?utf-8?B?WG0veGhrQ0QzSmVVZUE3Y094Slo1elVxOS9LNW5ENlVYUDVXUVk2VWJFUUVN?=
 =?utf-8?B?eHZVd2wvaFhOVkFaaWNkUytvWEhEekxINXZySUUvZFRUa09zeFF0MXNqZnN2?=
 =?utf-8?B?bURxN3NXYmNxM1NmazkrUEp6Z05KMFJZQ0I4M01vT0NieTh6cDZvL2FvYUVv?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e647c761-0a08-4972-c50b-08dd51a41593
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:45:33.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VgvtiZjjccTV75DMweusgDxFT9Ar208+9t0bxg0Dp3UjhJWemYpzel4hr+Q6I7ohaghl6zkMNZuGYiTqAi2rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5324
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 11:45:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17253

--------------xgNJVaab11WuIGirSsqOBznz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.02.2025 um 11:22 schrieb Richard Purdie via lists.openembedded.org:
> On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:
>>   Am 05.02.2025 um 11:34 schrieb Richard Purdie:
>>   On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>>>> The mirror replacement syntax contains many implicit transformations.
>>>> The path of the URI always contains the base name of the downloaded
>>>> filename. This makes it impossible to rename or remove the base name of
>>>> the original path. It prevents upstream mirror for SRC_URIS with a
>>>> downloadfilename parameter. The base name of the downloaded filename
>>>> makes it impossible to use the download mirror for SRC_URIs with
>>>> subfolders in the downloadfilename parameter. Altogether the implicit
>>>> transformation complicates the understanding of the replacements.
>>>>
>>>> This series adds an additional replacement named DOWNLOADFILENAME. This
>>>> replacement contains the relative filename of the downloaded file or
>>>> mirror archive for git and hg. This allows the user to explicitly define
>>>> the behavior. The usage is equivalent to the PATH replacement for the
>>>> sstate mirror from file to https scheme.
>>>>
>>>> git://.*/.*http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME
>>>> https?://.*/.*http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME
>>>> file://.*  https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH
>>>>
>>>> Without a replacement variable the mirror will use the same base name as
>>>> the origin SRC_URI. This allows the usage of private package manager
>>>> registry together with a downloadfilename parameter or the rename of the
>>>> base name.
>>>>
>>>> https://registry.npmjs.org/  https://example.com/npm/registry/
>>>> https://example.com/example/1.0.0.tgz  https://example.com/example/example-1.0.0.tgz
>>>>
>>>> The series adds heuristics to keep a backward compatibility to common
>>>> styles. Because of the ambiguity of the old style, it is advisable to
>>>> remove this compatibility sooner or later to avoid unexpected behavior.
>>>>   
>>> Thanks for the patches, these look interesting with some good
>>> improvements in there. A lot of the series looks like cleanups and
>>> those look like good fixes to have. It may make sense to split this
>>> series into two, the cleanups/fixes and the behaviour changes.
>>>
>>> I'm not entirely "sold" on the naming of DOWNLOADFILENAME. You have to
>>> think about this from the perspective of someone writing a MIRROR or
>>> PREMIRROR entry - would they understand what that means vs some of the
>>> other names?
>>>   
>> I’m open for suggestions. Even ARCHIVE or TARBALL are hard to
>> understand because it is only a relative path on the download mirror.
>> Alternative we can mark the lines as upstream or download mirror and
>> give the replacement different meanings. The path could be the
>> original PATH for an upstream mirror or the relative path of the
>> downloaded file for the download mirror.
> I've been giving this topic some thought. One idea I wondered about was
> to instead markup the mirror urls with how they're expected to work
> with a new parameter. For example:
>
> git://.*/.*http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball
The ? could be problematic because it is the separator for the query. It 
is unlikely that the user really use this query parameter but it could 
complicate the code because we have to handle additional query parameters.
What does the "?mirrorformat=mirrortarball" mean? Will it work like a 
MIRRORTARBALL replacement?

How does a simple replacement should look like?

http://  https://

Because of the backward compatible this will replace the basename of the 
path.

> The possible options would be something like:
>
> mirrortarball - mirror tarballs taken from DL_DIR
> flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)
> upstream - layout is the same as the upstream directory structure so a direct url replacement
Do you think we have to handle the mirror tarball explicit? The mirror 
tarball is required for a scheme change.

> If using a mirrortarball mirror url, we'd know to use the values from
> urldata.mirrortarballs. We could add parameters to the fetcher to have
> two parameters, one will be the DL_DIR path and the other would be the
> upstream url path.
I don't understand where this is needed, because the mirror tarball and 
downloadfilename are used by different fetchers.

> One key question I have is how we might need to
> shorted the url path for some mirror urls to add/remove a path prefix
> in the mirroring.
What do you mean by this? The downloadfilename could contain a path 
without any problem after my change.

> I think that would cover most of our scenarios and make the mirror urls
> much more useful/explicit.
>
> It also would give us a migration path as the code can simply error if
> it sees a mirror url without a mirrorformat parameter. This may mean we
> could have a clean slate for the mirror urls and switch to one clear
> format. I think we can make a case for such a breaking architecture
> change.
Does this means we doesn't need a backward compatibility?

Alternative we could make some replacement mandatory if a wildcard is 
used to detect obsolete entries.

> To move it forward we'd need to work out which pieces of mirror syntax
> we should drop, which mirror replacement strings we need (I'm not
> convinced the current ones are right/useful). We'd probably need a some
> proof of concept patches showing it in action and a proposal to the oe-
> arch list explaining why the change was needed and what the change
> would do/look like.
>
> I think this can be done independently of the other fetcher/vendor
> changing but should be able to work for the vendoring issues too.
Sure. I can rework my patch as soon as we have an agreement.

--------------xgNJVaab11WuIGirSsqOBznz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 20.02.2025 um 11:22 schrieb Richard
      Purdie via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;Am 05.02.2025 um 11:34 schrieb Richard Purdie:
&nbsp;On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
        <blockquote type="cite">
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

git://.*/.*&nbsp; <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME</a>
https?://.*/.*&nbsp; <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME">http://downloads.yoctoproject.org/mirror/sources/DOWNLOADFILENAME</a>
<a class="moz-txt-link-freetext" href="file://.*">file://.*</a>&nbsp; <a class="moz-txt-link-freetext" href="https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH">https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH</a>

Without a replacement variable the mirror will use the same base name as
the origin SRC_URI. This allows the usage of private package manager
registry together with a downloadfilename parameter or the rename of the
base name.

<a class="moz-txt-link-freetext" href="https://registry.npmjs.org/">https://registry.npmjs.org/</a>&nbsp; <a class="moz-txt-link-freetext" href="https://example.com/npm/registry/">https://example.com/npm/registry/</a>
<a class="moz-txt-link-freetext" href="https://example.com/example/1.0.0.tgz">https://example.com/example/1.0.0.tgz</a>&nbsp; <a class="moz-txt-link-freetext" href="https://example.com/example/example-1.0.0.tgz">https://example.com/example/example-1.0.0.tgz</a>

The series adds heuristics to keep a backward compatibility to common
styles. Because of the ambiguity of the old style, it is advisable to
remove this compatibility sooner or later to avoid unexpected behavior.
&nbsp;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Thanks for the patches, these look interesting with some good
improvements in there. A lot of the series looks like cleanups and
those look like good fixes to have. It may make sense to split this
series into two, the cleanups/fixes and the behaviour changes.

I'm not entirely &quot;sold&quot; on the naming of DOWNLOADFILENAME. You have to
think about this from the perspective of someone writing a MIRROR or
PREMIRROR entry - would they understand what that means vs some of the
other names?
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">I’m open for suggestions. Even ARCHIVE or TARBALL are hard to
understand because it is only a relative path on the download mirror.
Alternative we can mark the lines as upstream or download mirror and
give the replacement different meanings. The path could be the
original PATH for an upstream mirror or the relative path of the
downloaded file for the download mirror.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I've been giving this topic some thought. One idea I wondered about was
to instead markup the mirror urls with how they're expected to work
with a new parameter. For example:

git://.*/.*  <a class="moz-txt-link-freetext" href="http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball">http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=mirrortarball</a>
</pre>
    </blockquote>
    The ? could be problematic because it is the separator for the
    query. It is unlikely that the user really use this query parameter
    but it could complicate the code because we have to handle
    additional query parameters.<br>
    What does the &quot;?mirrorformat=mirrortarball&quot; mean? Will it work like
    a MIRRORTARBALL replacement?<br>
    <br>
    How does a simple replacement should look like?<br>
    <br>
    http://&nbsp; https://<br>
    <br>
    Because of the backward compatible this will replace the basename of
    the path.<br>
    <br>
    <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">The possible options would be something like:

mirrortarball - mirror tarballs taken from DL_DIR
flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)
upstream - layout is the same as the upstream directory structure so a direct url replacement
</pre>
    </blockquote>
    Do you think we have to handle the mirror tarball explicit? The
    mirror tarball is required for a scheme change.<br>
    <br>
    <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">If using a mirrortarball mirror url, we'd know to use the values from
urldata.mirrortarballs. We could add parameters to the fetcher to have
two parameters, one will be the DL_DIR path and the other would be the
upstream url path.
</pre>
    </blockquote>
    I don't understand where this is needed, because the mirror tarball
    and downloadfilename are used by different fetchers.<br>
    <br>
    <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">One key question I have is how we might need to
shorted the url path for some mirror urls to add/remove a path prefix
in the mirroring.
</pre>
    </blockquote>
    What do you mean by this? The downloadfilename could contain a path
    without any problem after my change.<br>
    <br>
    <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I think that would cover most of our scenarios and make the mirror urls
much more useful/explicit.

It also would give us a migration path as the code can simply error if
it sees a mirror url without a mirrorformat parameter. This may mean we
could have a clean slate for the mirror urls and switch to one clear
format. I think we can make a case for such a breaking architecture
change.
</pre>
    </blockquote>
    Does this means we doesn't need a backward compatibility?<br>
    <br>
    Alternative we could make some replacement mandatory if a wildcard
    is used to detect obsolete entries.<br>
    <br>
    <blockquote type="cite" cite="mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">To move it forward we'd need to work out which pieces of mirror syntax
we should drop, which mirror replacement strings we need (I'm not
convinced the current ones are right/useful). We'd probably need a some
proof of concept patches showing it in action and a proposal to the oe-
arch list explaining why the change was needed and what the change
would do/look like.

I think this can be done independently of the other fetcher/vendor
changing but should be able to work for the vendoring issues too.</pre>
    </blockquote>
    Sure. I can rework my patch as soon as we have an agreement.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------xgNJVaab11WuIGirSsqOBznz--

