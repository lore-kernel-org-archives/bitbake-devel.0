Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D8C27C53
	for <webhook@archiver.kernel.org>; Sat, 22 Jun 2024 04:22:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.91446.1719030172587005613
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jun 2024 21:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6903ff9387=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M41NSP028549
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 21:22:52 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yvrmq9dxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 21:22:51 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45M4Mp08024675;
	Fri, 21 Jun 2024 21:22:51 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yvrmq9dxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 21:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHIhy2zAiAnEWe4M/LXi/S/pNXYZfMgmmYxITE3aq5CH8j+8fRSqcB24xH3y/T88EM+YY+2IqiBQQatZUUUksOUPkaICYwoWFHlimcHhBw2KHFFsn9H20x9y1lS0d2pPjsHZtGOFo88fzIFso7LGZ0gWQrzVHi594GSEvRYnD2Fs0iNLYT40W2EuZj0Pn5krFks3Eb0zRK+hKIDODeh0uNRHZ3wB97llTBZu3Hu51iA4wHwDbSHgOLb/m4cMtVVVV5V7WXFswhVhnFBQB2cUzxlDlyiR4DbN1huq9gshJU5ZLFu3SDndT1pj0uFA4HUQHDPqzvb/86VcCnag2PyOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCRF/XmoqODUo/jT1G404ly6yBHBMtdfVuc2TeBi2LU=;
 b=dkgIY9T/wyoqfEBE37fpi3boI152vmWmAWPNN2cHl4GOIcRnNCw/KY85E79G7p7sGtUj9K0fe8cOUlHUjdVLSZPMiZY8B4gNSaV8NO13XXC/jKUaoeNlCFiDOle6ZU1LpRcQV7eajafovpzaeZOz4bUQyXhnBu6TusX6gS0aRrl6Fb2FqlrxwNuI+XX+nQgC5G9W8g41r3pc6QqgrvSJp3DoAA+kctmQK7xDXZDcDx/lmk8j0jbR2nmvdVAGJA73/SJJPRTh0ehpjvSnHXLYLZDz2ps86dOxuKGHlfMkTGwb9/iTHgajoGcIc0BudfEIeWf6JMC29Uq/BN0W8lsg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Sat, 22 Jun
 2024 04:22:32 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%4]) with mapi id 15.20.7698.020; Sat, 22 Jun 2024
 04:22:31 +0000
Message-ID: <4f5f6b60-b7ad-497a-ae46-2507805a4fef@windriver.com>
Date: Sat, 22 Jun 2024 12:22:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Fix File name too long
 error
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
References: <cover.1712565610.git.liezhi.yang@windriver.com>
 <02074341b8914bf7d1bf44291ec50a77853a4c5b.1712565610.git.liezhi.yang@windriver.com>
 <202404101701466483c16e@mail.local>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <202404101701466483c16e@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|LV3PR11MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e3f5c2-b204-4ac1-476a-08dc9272ef1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|4022899006|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NVlJaFFhTE9FVmZJeXljakhXVzNwYVRYQnFLK09Hb3dYcXNkdW1RRERRS2FU?=
 =?utf-8?B?U0ZpNkNPTlpTNGJTSmg3eStoSkRGVExqQnlYL3plZkp3NElINnprckd4N2Fm?=
 =?utf-8?B?QzV2ZGJuVkdid3NKcW5rL0ZZY3A3ME1MY0ZhZzlqVG5MS29XNGRMUnJkUDBO?=
 =?utf-8?B?Zy9jaUx1bHBKZFVkZU5RbnZnd1ZucjlYbFdxd2s1NVA2N0twZ1dUWm5ENG80?=
 =?utf-8?B?OWlralJ0YWRVQVFUVElqYjBMYWxnVzludjdFSlMwZWlaaC8wMTI5bmh0dDVB?=
 =?utf-8?B?dU0rZWRmYkxQbmkxQUZoQkxvNTFucmF1UTdpQXdvcUcwQkJtYU5meVViZXhM?=
 =?utf-8?B?aFVaYVc1K2ZGSGdySTJQQUNIMURjYzJ3enRmcHdEYkJNNWgwTFVrcFE1Z04v?=
 =?utf-8?B?QlZLdUlvL0Z6QmRuK3A3OFA2TFFTNDB5emh2eUJXaFNKdGYwbmYrRUdtZlh6?=
 =?utf-8?B?SEgyMzNEWmc3Uk5ERDduKzZ2alF4aWlrQ2w5MHFidlluamE5Zkh4dk4vL2RR?=
 =?utf-8?B?TnRjTG5KTjBPRkhkdENtOVlHM0xmbHBZcDhiQ096cUhsa3FxcEVabE92eDdG?=
 =?utf-8?B?aFYrOVBXZWYvQnpmSVhRaG9ldUl4QXhPY1NSL1RQZU1qRk1RbmhsTmNjZFJp?=
 =?utf-8?B?ajV2VEUvZ3lmZUlRcEl3OGdydVNWeC9TNjl5WjVaYnlpQzYyRlRCTTB1OWdI?=
 =?utf-8?B?ek1kenA2YUZLMXI0OHRyTXVsZGdaRkI0WmZmSDc3WW5wYkFSa2lXNWxjYktK?=
 =?utf-8?B?bGpwRzk5OW5WRUNhUE5ncExwc2FXRWUxR0hXTWdNblNTV05RN09nbDBZaWZJ?=
 =?utf-8?B?M1BJYks3WjFXZGhkL0J3NWovbnVVTlEwbk9VWEtEV293TWJ5RjdHUDJLT1NH?=
 =?utf-8?B?aWpHVjFnaTZ4dFdnWHpiSzFTMjgrazhYSGVDZkRLUkZxNjBJQS8rZFQ4Tllo?=
 =?utf-8?B?aElIejROSldFVnlscWpydTlCV1lIelUzSCtjQ1JIUC8vS3Jyd2NjUzRMbDVl?=
 =?utf-8?B?S0U1ai9EWGhYRDc2Q2FGc3pDYzlqUS83NEJsS3lRY214RkFzQUkrZ3c3bkVI?=
 =?utf-8?B?TVJ4WmdhdDF6b2JRN0llWUU2OGdnTFNHRitFdGlyMGx0c0ZVUmkyZ0Z1MnVh?=
 =?utf-8?B?TTZpMG43Y3J1UU0yajQ3bUEyanZwbkJnMmVIdUkxMnBzT1c3S0FJTlBySlVP?=
 =?utf-8?B?UHJPeGhPN1d3SkxqVU56Z1E2UkpCTlU3MW5iTTR2aTBMaDBjZ2F6MUpERk5T?=
 =?utf-8?B?Rm9DWWFCR2NCdG9JMUJwVy9ubFJRMks2d1Zmc2VsQTdjTWF5YXBib1dsSzlI?=
 =?utf-8?B?Q0JIaTlpWUdjelBBaEsxRUhCdFVodnEya2I3dUVIUCtEZjFpeWdLbDJnYlls?=
 =?utf-8?B?NmtuMTZqQ1NrazhHaXJWU1p6Y1dDOWw5ZGZ2L0g4czlqK1kxUDJOdGQydjBy?=
 =?utf-8?B?cEtVQkZiczFadkhkYUJKUVpOeTZRRGpqOXRKTkJDRDdDa3cvK2p5TlUwWTBX?=
 =?utf-8?B?dFJMbGFDdEFNY0xtNlJEVUN0SWxaVnB6N2s0cENGNUhkUEJlMVEra2l2cit5?=
 =?utf-8?B?ZDBTL2Jib0hxcHI4Q2V4YkdINEhzZlZUNkNJc1lGY3R5dTg2eVIxUTMzWFJm?=
 =?utf-8?B?YUY2NnNzZVFiMEFNNHAzbFBxbzh6YWx6aEhHTGhjVGsvY0N6aWlsMll0YmhY?=
 =?utf-8?B?TmlaMTg0N1pERVVZOFJWZjh2bzkzbXplTWtXTGhGSUl0UCtnOWxBS1h3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(4022899006)(1800799021)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFlTSlFzeGIwK1c2aFJZeE03RGtWT3YyaTNPSzhWWWE4bDYrZ2hyN0MvMVFE?=
 =?utf-8?B?V0xybDl6ckY5Y2NzZUxqSStydEhhclJXTlladHE0K3hTUFVjMEoydUM2YWpl?=
 =?utf-8?B?RnJ4cmN2OWkrdThFU3JCT3Ywd2RvcEJ0VjN0UERBYnBtQmFka0NxS0ZYSTRt?=
 =?utf-8?B?ZEhrbVVGalNBTVkwOGdnSm5wZk5zeVZWWUZjTlRISFJNQmZqcThIcDhQTHM4?=
 =?utf-8?B?Z1RqUDJzbjZLcjVYVlk0ZSsyczlLR284UkI4S0dXbk81dlhiTkpGQWZWVEhq?=
 =?utf-8?B?d3ROa0Z1QUYxT3NGeTNJM1VCdUNRelYrOVNwcnBsSHlyZVAyT21YM2lLOVpy?=
 =?utf-8?B?YjBjQSt5WXl1S2ROOXVWcjROVE4xQ3NwM0hsb2k4MndaTDUwU3ZnRXlZV0xv?=
 =?utf-8?B?ZFVVYVJsTVNrWDFBZ0VHODR3UWxOWC9iemd6SEFHZUpWSmthZk54NkZPMXBk?=
 =?utf-8?B?MUlzUmx6UGV2SXN6ZG1KSXU4S1Z3NHFiRFBmSUd0RUNSa1BoajV2OTFNcTNY?=
 =?utf-8?B?NmtqSEF4c2NFdWpPdkNQL3RSK3JJZ2J5anJyVmpqNTBHaHAyZSttSWZHTWpL?=
 =?utf-8?B?a29ZMGF2amFqVFhxdEVrdTJLaXlMbGpaQW5rejB1NjVCRFVrbmtsNC9VNmRT?=
 =?utf-8?B?dy9ydENMRXdva1B2UVk3N0JYczVsRUt6OGpYMVl2RERYdEgvbFNsU3N5dWtT?=
 =?utf-8?B?ZnlXc0lraFNVMU9yaEVGTEtzYkJKdnlKWUpKL1Y4cjhJa1pkOEsyOTJpcXM0?=
 =?utf-8?B?V2laRnp0WThFNjVnTEpvUUU0b3JEK2hCQTNPT1FYMkxUTVJJUHNwY2laVi9T?=
 =?utf-8?B?TWVCbGY2ZXExY01RdzFWVVJpeDdRamRQS1dxQlNzMVBWNHpGbnd2ajVEZnFY?=
 =?utf-8?B?eVVQaEd1bXFldzlKUEsvVExGRjNmNlNrMk85M3ZSeHd0OU4xb0IzOHlHN25z?=
 =?utf-8?B?eU9CaXJ2bUFpZ0JpM0RpM0NJSjh5bTVIbGJnWDEvdU9mQlA2R3ZSdE96Z3ZG?=
 =?utf-8?B?MlE0ekhDWXJTOHhDM0krM05tajFtcnlBOXBXbjdLdG9TQzIxOGRISVVqQVVv?=
 =?utf-8?B?SE9yNWQ3bmRMbzF3cFJ1WnBubVlycUpnTFRsSnFYWHVuK2tYRlQ0UzliOVQ3?=
 =?utf-8?B?ckdwTDQzcmxpUm50VGxqRVdFazBPajFsbTIwNFZRZ1Z0ODZQUUZ5TWRUT250?=
 =?utf-8?B?bVJ1SVlMalRXVlQ1ckRpVE0wVHRJemxvdm81Y0gzV29rYUYreDNRUnJyM2k5?=
 =?utf-8?B?M1BhS2NGRThYRlR1bjJUa1NVUnpXc1RkRHp0TFJRUytVcERZckVEd3VRcDhW?=
 =?utf-8?B?ZGQrbjlZemdSV3lza1cvUnkxRjVLM0x4OWgxSnF0ZjdTNnpXUTU4NG5aSWVP?=
 =?utf-8?B?Ny8yMnRpOWJxaEdYSFZIalNybExOZFhtMDZtQmRNUUQvZ013eWtmdU9NWkgz?=
 =?utf-8?B?Mk56aFhDYlBQZjFzZU11NWhjTTNHMHNzbGZwMlk4bEV0VzNRenljSmUzZ2ZE?=
 =?utf-8?B?dHVBakVYL1Z6d2xzUGhrNFgvU3c4STFic0toRGpDUnI2V3hJb0dkV01XR2w3?=
 =?utf-8?B?dEh0S1pJK3d2eG1uZjRjUkxydVN3K2NHY1o2bnhtR2FVb1o5c3E4TFh5RFp0?=
 =?utf-8?B?OUpxcXJFRDdKUVVhUXY0R2ZXUEZXbHdlNElOZFdkNXRMd0NpdG1aUDRkUTAr?=
 =?utf-8?B?blNIeDlEUHZBd2FZQUI2dWNQT1Zpc3p0ZTAyak1XbzlzWDE3eTc0aEZEVkpx?=
 =?utf-8?B?UkNYZDg2YkVTc3cvMnMxR3NPZTVmN0VucU95M0FobHQ3ejl0V2UrQzkyWHpu?=
 =?utf-8?B?Sk8zTEVQSzdTTy9lWSttdjZ6bHZhK08vNTRGc3c1a1lmL3hxd3NOa0tPKy8w?=
 =?utf-8?B?WlJIam1OMTVPNDJvL1NrN2xVbkp4TVA4dWV3UCtFVTZHZ293cjAreHJnV0xt?=
 =?utf-8?B?NFdJR3BjVjY1Tlo3a1lJT3ZKaEZ4NGdGdW1CYU5sVHFvbmFObEUzZ3REUExQ?=
 =?utf-8?B?aENhc1BieGhmUEJzMUlSMlF5ZUtDelNHVVZ4Syt0bGtKS3VHVXhUVmhMUSs2?=
 =?utf-8?B?V0Q3ZXBHK1ZFYTVEc0k4dUlsQlBhRnpBVEpscnFuTkF3VnI0dHdqSndmdmxi?=
 =?utf-8?B?d1BFK1hNVmlTazhRVFFZKzA1SFhBVHdQaXJ0MlViQWF1VW5sQ2dVZERWeitX?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e3f5c2-b204-4ac1-476a-08dc9272ef1f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 04:22:31.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAi+KJemEd6wGNU9dhU1YBUZDijZzRDwA3Mk4gH1ttco9c0HW7ZzMt5CJhNaei+Aj/1sAJ1DOxB0nK7FGvBhCfemJazKsaOeUfQHtD7lt6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-Proofpoint-ORIG-GUID: 2hzpi_8KYt4AGqJRZmmY8DQB46PbopGP
X-Proofpoint-GUID: qnq9Po6PgSgTZmj_RRZ85qPoyNpv7TkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_02,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406220025
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Jun 2024 04:22:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16370



On 4/11/24 01:01, Alexandre Belloni wrote:
> 
> I believe this causes the following error:

Sorry, after more thoughts, there are two issues:
* The generated mirror tarball can't be used since the local path is added to
   to the tarball name.

* There might be file name too long error when the local path is too long.

It doesn't make sense to add local path to the generated mirror tarball name,
but causes the above two issue, use basename can fix both of them.

I will send a V2 for it.

// Robert

> 
> ======================================================================
> FAIL: test_shallow_submodules (bb.tests.fetch.GitShallowTest.test_shallow_submodules)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/tests/fetch.py", line 1946, in test_shallow_submodules
>      self.assertRevCount(1, cwd=os.path.join(self.gitdir, 'gitsubmodule'))
>    File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/tests/fetch.py", line 1728, in assertRevCount
>      self.assertEqual(expected_count, actual_count, msg='Object count `%d` is not the expected `%d`' % (actual_count, expected_count))
> AssertionError: 1 != 2 : Object count `2` is not the expected `1`
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/6634/steps/11/logs/stdio
> 
> On 08/04/2024 01:42:58-0700, Robert Yang via lists.openembedded.org wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> There are "File name too long" errors when local PREMIRROR/MIRROR
>> is in a deep directory (len(path) > 255 (The NAME_MAX)).
>>
>> This is becuase ud.path.replace() changes the path to filename, and
>> the errors when happens when len(path) > 255.
>>
>> Use hashlib.md5(ud.path.encode('utf-8')).hexdigest() can fix the problem and
>> avoid potential file name conflicts, now the files are like:
>>
>> $ bitbake mtd-utils-native -cfetch
>> $ ls downloads/git2
>> 1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git
>> git.infradead.org.mtd-utils.git -> /path/to/build/downloads/git2/1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git
>> git.infradead.org.mtd-utils.git.done
>>
>> The 1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git is gitsrcname.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/git.py | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>> index c7ff769fdfe..7ed51af336d 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -83,6 +83,7 @@ import subprocess
>>   import tempfile
>>   import bb
>>   import bb.progress
>> +import hashlib
>>   from contextlib import contextmanager
>>   from   bb.fetch2 import FetchMethod
>>   from   bb.fetch2 import runfetchcmd
>> @@ -277,7 +278,10 @@ class Git(FetchMethod):
>>                       ud.unresolvedrev[name] = ud.revisions[name]
>>                   ud.revisions[name] = self.latest_revision(ud, d, name)
>>   
>> -        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
>> +        if ud.proto == "file":
>> +            gitsrcname = '%s.%s' % (hashlib.md5(ud.path.encode('utf-8')).hexdigest(), os.path.basename(ud.path))
>> +        else:
>> +            gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
>>           if gitsrcname.startswith('.'):
>>               gitsrcname = gitsrcname[1:]
>>   
>> -- 
>> 2.42.0
>>
> 
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#16064): https://lists.openembedded.org/g/bitbake-devel/message/16064
>> Mute This Topic: https://lists.openembedded.org/mt/105397591/3617179
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
> 
> 

