Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EADECFD345
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 18:20:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23693.1764008458521315695
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 10:20:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=JhEmWexv;
 spf=pass (domain: cherry.de, ip: 40.107.159.27, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/42JJEf5Zcx/hgSoxgubPPEA1O/IkrFDbd3lhFheg7PN1Q+84eecXnCzR6RwDgA3Q1o8e2zBx8PleI0mkR3nqnc+e8Kj06lqASIj80jG+raNlsPqjMoxE1NYIdrVA6VFc1Cu5onwMyPe3Ye9ssswmJr1lQOhFXcnKDnkcTN8vcOFpeJ1+GT11m3Wdy2C6zWpTkYnf/X+nqwWEgCNtiaesXXvhgEV5tD8uySnmiXmTmHO53zXgq3DarikV9a+osWwxQEf1OrBobqiA3MZNQ8i8I3ifu8yP2J4cm8hocgsfU9eXxslyp7n5+bJVlRHmZnCQKFSt723OliW4B56JDnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAIZ2zLlK0DdZSGktfgG0gvDqzhhtFCc9BNrsYsSfkc=;
 b=DuPT16o3NAn5UfGKbg5XuRuKV1GFkrD1zgq9ntT3H+I5WxO2XZ2a7xdX9CCL72hqGWWB0yMkhwf2xX1//Ofvv6mkUlmjRiBR4SbH/BeSgbbxb+DQxW+eatR6NEJiwphP+ibjuajLs38hWQJ9nekXr1GpcjdK0TF14tHYFMaMYuLDywAV11lvAPB/9nGQVzcOEjOAYEyKeFoKd/0Rm4gBr4aGT/zbj0mXGndKe0u7umD+oVjv+1+Ch4/mvupJT7ULmDBj4mZJIe78SslxOpFKFS9u+IWZ7W2HhvMQ2L0vTedHRS0CI9OSxKEktI+h+cwuGWnP/rRwisTZVTr9pjWy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAIZ2zLlK0DdZSGktfgG0gvDqzhhtFCc9BNrsYsSfkc=;
 b=JhEmWexvQnp8YMhlwX7/jC1lX9TofIdZQmic8IKDKIfKtW+oxj0EHmqjkpbEbNttQRk0kENEgwQKKFaez9aocDNCyQEsC1vyyAJ2DaJeKtJEPFDuZzO40JP/RZzoj2gnZ9PajzNXFus7AXurQcQYdSF8MM8HESnxluO5AMAqTfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAWPR04MB10006.eurprd04.prod.outlook.com (2603:10a6:102:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 18:20:53 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 18:20:53 +0000
Message-ID: <dd843658-cf46-4858-bb0d-fc78fc25e894@cherry.de>
Date: Mon, 24 Nov 2025 19:20:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC] Proposal: New tool to display recipe
 dependency trees
To: alex.kanavin@gmail.com, osama.abdelkader@gmail.com
Cc: yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <aSSUtHYFQlychNQk@osama>
 <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAWPR04MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: e05a1ff6-7c4a-4bdb-2904-08de2b86342c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZFhzdGg5NGVnMmpJaDZBNEJGQ255WUErdzdGWDk5Z0dMeGxDZVh4MDExSFlu?=
 =?utf-8?B?V1pFTlQ2UDFIVzdjdWxPeHFYY1J4RzdEUjN5ajB4TnZiQlFVYnpOd1FDbUdW?=
 =?utf-8?B?eWRqc29HNFNBN252N0ZNY2pvclZWejJLWXc4SUwrK3daRElDclRXeG1LWXJC?=
 =?utf-8?B?VGsvSmxsbGo5RWZIL2F3UEhteGNNeWVlOUFMRm5rM2hnZ2QxQzRPb3lkS1E3?=
 =?utf-8?B?dHY3QmxXSW5PUTd4M3RJT3R0YWRqZG9rTE1MYk5PK3I1QzBQZ0wrc0JIS3Bm?=
 =?utf-8?B?dFNGK1lrdFJxRWcxaE9Tdmk5RzhlaWhWRU5CK2JVNmRnU2VkVFl2Q1ozMnhE?=
 =?utf-8?B?bThPQmo2SGdXT1JVanhyK1hFYXNFZGU5M2Q4bUx5U1NjVGJRcmczREpONkln?=
 =?utf-8?B?cVpBakFBNlZScmxLWWxNWThHTThoeng2RTNSaHdFQ04xWnFFb2FmNStBQWRx?=
 =?utf-8?B?ZXRpcTdXckVOQWgwdmZDeUdkNDBSWURUdGUveW5qT2hyRG1CdXFqZ2ZKSmZt?=
 =?utf-8?B?TkZPTDJzT1FkTXNwelBQVXg2TEVLREdFZDFDNmllQU9qcC84TWJrOXR3WDQ5?=
 =?utf-8?B?alFuZktCOVVSVzUraUY0WFdpUDZNdnkxOGR2SG9rZkhzRUM0NVFIbCtlYjRy?=
 =?utf-8?B?VGplMXNIM0hReDV4aWlRRE5ZaUNINVZqOEE4UVRXc1p3K0ttR1pBb1lhN01L?=
 =?utf-8?B?ZW50bGtIa3hJWGY4cmM0WG9GTVhXZDNzNXhLTmdaYTMrQy8wTDQ1ODZwQnVB?=
 =?utf-8?B?aDlGRGdtYlBBMXQxUUltbW91Wll4VnlacmZsUGQ1cldWazJVd0VUQkQzWU5x?=
 =?utf-8?B?UEUwY0p2QzlJRU95L0M2QVpKdTRtOWJmTkl4TmV6emRWanVxSkhVQVF2azFo?=
 =?utf-8?B?ZjduNWxUeTVZNWJnblFPUWNLWHVTb1VOYm5UYnRxN1JuZE4xMHdJRC9hZnpQ?=
 =?utf-8?B?TTNnODV2VFlUWnVPaDBPUm1iQVJWUi9DZ3Y5ZXJ6OTdMaTltUHZpeEZJbURR?=
 =?utf-8?B?OHRrN1F0cXJ3WlBqQkpwc0cwNU9nUm5QWWRwUUcyY0ZvdVV6bTZxVStOaVB1?=
 =?utf-8?B?N2hqekhzUWU5Qm1CSEpkc29JUVAxMUlSNHJrMWxPdWRRT25neEQxN3BNc0VP?=
 =?utf-8?B?UEhYVGlWdmtHczhOcWhPQUgxVGliS0cyZWpCVVk3NWNPOWttTHRlS2QvcHlT?=
 =?utf-8?B?Q3hjUHFvWElEN05WWmZSWHBSbUVqR0tnanRMNDZEZWZmSUZkYkV6ekRMSUV0?=
 =?utf-8?B?WUdHaUNmSzFlR1JaY3JIbW5FSEd0NUJDaUNVSFRYT29Pb1ZFNzZVNUt3YllN?=
 =?utf-8?B?YmNyd3lBVlVDbTF4QWRhZFRpcldjb1JmOTlLV203YnkvSnBORm1hSTVwcWY5?=
 =?utf-8?B?TGgya01ndlJIT1JveWF6WGo2ZzFQRzhHbUdPTGIzcktXaHdwTGJIM21XL0ZR?=
 =?utf-8?B?UTVxOG5KMGZuOFcrUUdxOTM4elFFKzlwZ1lEUEV5bTZuWndWdEpzNXZpaEVE?=
 =?utf-8?B?WmJqak9QelpDN3UyK0RZemVjRWFoenB2UEZtTXgzR1NHSDFVcVpkclhZbHd1?=
 =?utf-8?B?bnd5UDZVNjBrR3NELzliUUZMU3RHOE03WGxjeCtobng4RC8raFBESUV1dHcw?=
 =?utf-8?B?SXZoTzNFV1dLZUJoM2JHb2EzY0JBaGs0QmhsY3BkelQ5QUtvRHg0bE5mV2tz?=
 =?utf-8?B?OTgxM01BcnI3UENic05SMXVGdVltUDZvMDJGdGw0RWExVVRDQ21mMzFBVHNz?=
 =?utf-8?B?TU1sRVdQbTQ5dlhtQWRjTzhOL0h5U09rbnZYOXFIVFV2azZzY1NDMThZK2R0?=
 =?utf-8?B?eldDaFNweTBBNmxpWk5EY08vdWJZbWkrTVVoREprYmJtMVgwV2RqaGJJblNy?=
 =?utf-8?B?UDcyMjB5UGV6VnJsekRIYThDYk1Pa1E4b0U4WnNwbXdHL0pCQ2ZnVHJHdjht?=
 =?utf-8?B?dDRaTnlGV1RnRkxzV3h3SkpJanNoQzRqTURCS2xNTUJZSnB5Y3ZQTGZ4YUlH?=
 =?utf-8?B?VitPZ20wdDFLR0pNMHFXRlRKTGtObkNaRzExSVBDUG8vQXZxQlNGcUYweUc1?=
 =?utf-8?Q?TR8N/K?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eXFCSkJJREI1WnRZWEtDbHliajdlK3hValQrOUlaK1RZK2NTTjJDTFdEVkRx?=
 =?utf-8?B?V1V2QmlSUWlPejE5Q28zTUh1TU5MZWY4NVlqdE5OSjhYcThMOTZRaFpqUVB4?=
 =?utf-8?B?VzNCZ3FvdUdBMC95b0hOTEFldnpiTkZtNXB3cjYzRFE5ZGtJTXBwcHA0LzZ1?=
 =?utf-8?B?R05odUh6QklDaXVOcERIMTNZbGtwZzZKajJNdlhqWFBIMFU5eTNrczV0bVVn?=
 =?utf-8?B?OC85ejM3SktuZmFkUkt4K2cyZWlSSlI2S1dVNWl5U1NCcXNRZmJxOHJwei9Q?=
 =?utf-8?B?VFpEbzk0VUpkWU1UY3g4RmRQV3hxSU5POUNvRC9ycG9kMWJsRDhycDY4d2Vv?=
 =?utf-8?B?WWJjUUcrczY1MFVMN3FIaTEwdDkzWEo5VDB5MDVwdm4zVU5ZRG1YaGo4RkxM?=
 =?utf-8?B?djJtLzZMQ1VMU3Z0ZkV2QWlvbjNPdHBMYXdxZlJYdm9ycWQvZXVrK2F3cXVo?=
 =?utf-8?B?RHh0VzBRTVNFcGxGblFhRjVUdkhHNEtjakpqQU94cTV5dDQvQTlsYVZsalBU?=
 =?utf-8?B?cnJqbmU5ekwvQ1ZBYkZ6UmswSFF3NWpyUE9odFFpM2sySXM4dEJSWDdTS0JI?=
 =?utf-8?B?MXluWWlscE53eXVwYVRKRmFWbENUSEdUUEdWQ0RIdkpqZUUwS1E3YTlLRmh6?=
 =?utf-8?B?bUFkZnYvUkVZMnJKYzJNMENDNDROOFhNeTNqMU8zbUMzU0lodGZ1cTFJZ3Rl?=
 =?utf-8?B?ck1UYVFRLzhaL282cm9LbHlKYnE5UEt0VFJUNlRzNlJUcFJLM0lCNTdXY3Bn?=
 =?utf-8?B?V1lET2tUVW1LbkxQTWpFRGhNcWw5K2ZMYnlsdzJ2NEk0MVpaU05IK1BkRGtm?=
 =?utf-8?B?ckZ0S0J0dVR0eDJXL0VDOUZFYlZ6WW1KR1ZhN3ovdmtFTC8zbmlUS0h4L00w?=
 =?utf-8?B?YXEzUFQ1QVZHNjB2OG00SEwxUUszODdTWmlsd0JyYUNwQzNlK1pJQUk3V2ZJ?=
 =?utf-8?B?dEpTcmo1L2lzZWNrL2ZvalE2QlhCdW1ZRVhzdEpTT1ZJRTZtdkZaQi9FQ0Zn?=
 =?utf-8?B?bEpZcHBtZlhodG51WjJYblpURVlmdEFtb29mN3lvZGZhZGN4WVM0TEVJS0o5?=
 =?utf-8?B?b2RDbGxEUkoxNVNqTVY2TE9HZnQ3Yk03TVFkbUhWTFpvTk5WN3lBV1ozei9T?=
 =?utf-8?B?QXRnTjhnVkg5ZXorTHhVb3RydWFiWldwN3ROL1RVVHFwRUtGd0lvcDk5dzB0?=
 =?utf-8?B?UXg4RDZwT3ZOWG81N00rc0JCeEppcmpNNlZjK3RCL1d4amFiRURvMnlucUw0?=
 =?utf-8?B?U2hMb3FlZjNSZXJFV3lzMU1UcitEQTdXWEk5MzgrZnJhT3pDNnlnSFIxUU5I?=
 =?utf-8?B?WFFHeFJFaklvYzNvVHpZSXBMR0xKSHExbzdHTUNOdkZJUEM3c2lhdko5dERq?=
 =?utf-8?B?MnQ2Q0loNDVCUWxxaEo0UDRvb2ZVZ3ZLRnVMSmtGUm9oWVRqVHVWREY3N2sz?=
 =?utf-8?B?UEQyM0RZSzIzS2Q1OUJvVEVaZ3ZJRzZiUWtDZkRDaXdmcWRPNS9IS3BMQVdx?=
 =?utf-8?B?Z0Z3T3ArblJ1cmpNT0tVYW80NHVNRFRjZGEwN1pFYzM5WC91djRrN2JoQlk1?=
 =?utf-8?B?SjNZQnZieE1pclZ1eVFIR2VGK2dJY3pxam02SW15TFN6bmNnVWk4MUtnTTJ1?=
 =?utf-8?B?V1U2WDY3UFdQNUppQVY5Nnl6SWZHY3FpMXRlem9aTjM0TElvL1pIaGw1U1ZZ?=
 =?utf-8?B?b0xwR3JUblNMUThsWW1VWVlnbHJUVEg2WTNJQTlVSEhQOERlNHk1b3pOMk1k?=
 =?utf-8?B?UGdxZmI1OUE0Vk9SMUMrb0FvM2Vqb2lUcHFVRTNLRzNLVXBhaUp6OEFxVHJR?=
 =?utf-8?B?K1FTWDlZcTZmQzhoT3dpUFZ2a1ZjS01QSTRzQm1uOTFpZVBLM1FKai91S2x0?=
 =?utf-8?B?WTlTZXArMEtJTU1SY1FNcXY3cUxIUTdWNnVZNEVzS3BvTW8vNnRjMXcrcG11?=
 =?utf-8?B?djB2eU9vd2ZOM2xaRmNwQ2xPVnBrNjF5MkcxbzJOdy9HN0J3RE9KZFVaT2VL?=
 =?utf-8?B?MDFxRnJuY1VlWUVLb0Z2OElGVDdPZzJDWHJidkNJdzFTZTBMaGc3VHRRZ3Zx?=
 =?utf-8?B?U2NFam5tQS9UVEJvK1daZDZhU3lrK0E0am41NzlzbkFXV3lBRW8zdW9zTjVV?=
 =?utf-8?B?MHp6NHQxR1lWeWozUjJxdjFtaWoycFhRajBsWXVGTkdab0MxN2Q2TW5ncmpt?=
 =?utf-8?Q?s6Mu8XzOYaBLMsY8GPNpO1M=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e05a1ff6-7c4a-4bdb-2904-08de2b86342c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:20:53.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaWjAhynh/n/SdqN/GwYqHa80Rt3a0uSvtx5PJbjlXzA+GdOw3yYU4lAWtGMG+IV9oLU+8EDVzXPAMacrFhuUk38334mIFRkYmvGAUejouU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10006
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 18:20:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18482

Hi Osama,

On 11/24/25 7:04 PM, Alexander Kanavin via lists.openembedded.org wrote:
> On Mon, 24 Nov 2025 at 18:24, Osama Abdelkader via
> lists.openembedded.org
> <osama.abdelkader=gmail.com@lists.openembedded.org> wrote:
>> Should the tool:
>>
>> cover only DEPENDS (build-time)?
>> include RDEPENDS with pkgdata?
>> resolve virtual/ providers?
>>
>> Any prior work I may have missed?
>>
>> If the idea is acceptable, I will prepare a proper implementation and send a patchset to the appropriate mailing list.
>> Thank you for your feedback!
> 
> Hello Osama,
> 
> DEPENDS is a somewhat unfortunate variable name that we're stuck with.
> 
> It does not actually specify a recipe dependency, it specifies
> something more specific:
> 
> - run A.do_populate_sysroot before B.do_prepare_recipe_sysroot (a task
> dependency)
> - within B.do_prepare_recipe_sysroot task, take the output that
> A.do_populate_sysroot produced and place that into B's sysroot (a hint
> for sysroot creation)
> 
> So I feel that any tool that aims to make things easier should
> continue to present particular tasks; there's really no such thing as
> 'recipe-level dependency'.
> 
> In addition to that RDEPENDS is not specifying recipes. It is
> specifying packages that the recipes produce (which sometimes match
> the recipe names, but are otherwise distinct). You really should not
> mix them together.
> 

In addition to what Alex said, you also have RRECOMMENDS, PACKAGECONFIG, 
anonymous python functions, dynamic packaging, etc. that allow to 
specify build or runtime dependencies outside of the more common 
DEPENDS/RDEPENDS, so you'd need to interface with the internals of 
bitbake and not simply checking those variables.

Finally, there are other ways to do dependencies than those variables, 
as highlighted by Alex already. DEPENDS does A.do_populate_sysroot 
before B.do_prepare_recipe_sysroot, but you also have other ways to have 
dependencies, see the u-boot recipe for Rockchip boards here 
https://git.yoctoproject.org/meta-rockchip/tree/recipes-bsp/u-boot/u-boot-rockchip.inc. 
We depend on 1+ binary (TF-A/BL31 and OP-TEE OS/BL32) that needs to be 
available in the deploy directory before building the u-boot recipe.

Cheers,
Quentin

