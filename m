Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2739CA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:19:34 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.43218.1754900372988720091
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 01:19:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0318e6e81f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B63iCr1830664
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:19:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48dwa61asx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:19:31 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B8EkY22044969
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:19:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48dwa61asw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 08:19:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6ITt/mBsGX9NBf6nAg0IaDSgFKdXq+jxP8T/DKBK380TMTqTZmQ2EdJqZ+cBzvEME9iyvhe3mvHpdkJhlEOy7wVH/QCnlmCZDfxEwo7kYLjxd9Ojd0lc8AqpbCgLa20qOYWAfs/5GM11nv+7P4q6wGJ3MWgLf0SdURTBGIugB9Ux3eTzWluv+Qgu6qHytdTthdIcv++e7JDqWY5ggk8M/Rtr8ectpJh8YGqA9oeHd7KGpGJOS62uJfOtVXDcydlLKDN8JokV1ZThMhM8CZvddW9gWExlIbhOBL9+0OGptVqHBh4IlVHVMtTXvAbrNT1ZJAZCN7NvgWmO674u080cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsVGnR+DfRKNgPs2GiBCleLe92tXZBuCppwgI5i1/Iw=;
 b=FxZ5C+s0R5nX8PRePZX1qC7d/MFqEFjDUd3muJn2DP0UVLB7WA/nSjF5X1iSYDJPTXhJVVMOZ+KcWdm+a1IFTjWzRVgY+PaI+6jMy7+S0VK9uKiEY6pHun33rDq2r3AoeRJ9cFM/4hYEtcjNd/tEkGpXbLTde3GLHOr54UYNZ1P4jp+cY3UhLeCm+7fggXGLlosMMeeiKIv9FCmnLPWkU6DdTGIDXAD3um1I7V1X6T7nhivhhTEy1OQZ3NyTU8m/9/yEdCAa70JGMcIbUEYnyWbTOe05sNHk2vzWOw+soORE9GrZhK8VEAWWKDEHNcrRmxwaUGIGuKqoM/X6v6kAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 08:19:28 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%5]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 08:19:28 +0000
Message-ID: <cbc5cc61-9aac-424a-83a4-f0bc1c21d1d8@windriver.com>
Date: Mon, 11 Aug 2025 16:19:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: try_mirrors(): Skip invalid
 local url
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <cover.1754898959.git.liezhi.yang@windriver.com>
 <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
 <CANNYZj8920r0c1Po9ARajRpWazWw2KNFwFoLUcdNGjkke8EgQg@mail.gmail.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <CANNYZj8920r0c1Po9ARajRpWazWw2KNFwFoLUcdNGjkke8EgQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::19) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 893146cb-780b-4cb2-3fb1-08ddd8afca6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S3dvamc1dzhtMzlNcy9wNEVvNTRWUUhqWTFubXE4SWNwWUZpMC9NRlNhVWNu?=
 =?utf-8?B?TlFMTHVvR3FFTGl0YVZnYjdLd3Z4RHN0M3F5TUZwelAvUjJWS1VYWG1GVEF5?=
 =?utf-8?B?dnE0WkFtcnFXeUx5U0dMVnZkSVpLUjNwNEhscWlSTDBpN2lyUy9RWHRrNlIw?=
 =?utf-8?B?TVRHODhvUHNuZWZ2WDB6T0VUaFlTZFVjNjJUNWJhTnQzd2hUTzhLaFRhNjlt?=
 =?utf-8?B?WWtxVkVoY25haVV2cVk4U1hoTnJ6Ykx0ZzVVeTl1ajNNbnZiM3lCZWVWRzlG?=
 =?utf-8?B?eENPUHdvMEdOVDJQVFVKWXRFVm5RajN5NExxbENhT1FBU1JiOFQ3cmU4eWF4?=
 =?utf-8?B?Mmdnb2YyUWk3UktPWnVsVkhYSjVLbjF3clUyTTdjUnNMd1hMcCtBZTEzZW9k?=
 =?utf-8?B?bjA5MWgvSU5uK0tQaVRTMWFrOEo1VnY4ZVB5MWgybGNSdUg4STdBcHgybW1v?=
 =?utf-8?B?Q2JLOWdsbXhJeFp5cm5TUXVzM2kzZCtZQ0J6eC9iNmJScXJ6My9BUEhzVlZa?=
 =?utf-8?B?TVFuMThnQVFxVHJvQTgwRlA3ZXU4ZUpvcTYvenZwQWk1aTA3VnBua3VTV0Np?=
 =?utf-8?B?OVI2NkhzU2xPUnd3dXJaZGpibjk1YUp0V0NOaVhRNXVab0g2RVpGb3BtcHM0?=
 =?utf-8?B?MVE5M2cvQW1BOHJTMUIrZVVna244aThnWVNsd2xUTGVzWHFvVHdObmFFa0hM?=
 =?utf-8?B?aXhjZ0FpcFRiZkRFTFk1QTR5UjI3ZkZRN0NxM0ZXSkNVcnBydjJnVEU1aVZq?=
 =?utf-8?B?SlBkRFNZZUc4VXB1Y2xtMEhlMkZ5TlQ1Ti9DTzJHcm1MZFM4WUwvOFAvZkZ2?=
 =?utf-8?B?OWNEbk81NGhFY2dwd1hPY1R4V3FhbW95NHNlUjNGVjliSlVtcFBmWHJESFlU?=
 =?utf-8?B?NUc0TlZ5VkdPQzlWcHZPUm9GOWZoL2oxSnRFNHVSM0JZb0ZsOXV6cFpuRzda?=
 =?utf-8?B?K1JqRFJLZTRkU2c2YWF1Z2ZyV1FnM2FFaXhMQlRiZjF5M3k0WW44NWF6Z1FR?=
 =?utf-8?B?b2Z1R1VUNVN5U2Q5bkxGWEZqOVRtL3llc1h5T0JrQ1pJQ3dWWm8vOCs2RlVv?=
 =?utf-8?B?VUdrZ2pvN0w3RnpwY1MrQlg2NlI1NTRGTlA1RG1IRzBnOVUzdnh5akEvaGx0?=
 =?utf-8?B?Z1BydGFaaHFjVGlrZ0xCVWVCMWl3Z1NEOVJkdVVRVFA3NnhwM3R2RkxLZXVS?=
 =?utf-8?B?Z3lsaEhEQUNXckJHWTFxTStYYmJTbkt0MUh4Y2FwK1FiMUkvdjdLTHN5MXNB?=
 =?utf-8?B?NGkrTHFHRjVkTWtzSS80T3N0b1BLSHY5aEpnUDFhUFE1UlRzeW1KYjNWYmhn?=
 =?utf-8?B?Ync1dXY1aFJlbFh2d2k5Y2dYVm1sdHBNUktqaUFjbkNmTG5uZzVuQ2hGYnhl?=
 =?utf-8?B?L0lVaGFTdDBKaEdXeW1xY0xReG1oVURqeDVsWllxRDM2ZFVOdUl3ZGN3WVJm?=
 =?utf-8?B?UjhjeVN6T1Nld1NoSlprUzZaRTk4bThEUVh3OHR6SUIyZDh1ODNjOUdUeGpN?=
 =?utf-8?B?QnBDNjZUVzA4dFBXZVJBMzMzK3ZjWEJ0VDF4MjJGelhZUkxYNXJ2dU5IaU5G?=
 =?utf-8?B?Z2lvdUVoOWNHcmdaclNjR1JDVUV3VysvTXp0aXhOWkN2ZnpsaHpaM1VyblBk?=
 =?utf-8?B?S2lSSGZWZEFwdkxHL1ZBRHVYVzhUbzhiR1kwZWlLbERJNVFLam80UnJ4WXI1?=
 =?utf-8?B?R1V2WDl1TjVtdmFYZUFaRlVPdDh6anpUTFRJV0hrWHJkdjUyLzE3bVJzVXRn?=
 =?utf-8?B?c1Z6ai9qejBQaHIxazF3VmVjR3Z5dXFXdTBIa2xFQ1o5SElSTEx5RGRjQlU5?=
 =?utf-8?B?SHBmL1M2ZVpJdHN2Tmt1bUVYZFZmZVlsTFFMY1RRSGEzVEp6RW1uWHJjTU5W?=
 =?utf-8?B?cktON3ludWRSS1RSYjRIN3FBK1ZNMHZsTkNRMHhZYnlMalE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzNDMG91OUdJNkNSaCtlK1pGdVBqU0doL1ZwSDliTXRwVThQNHZtYzNjdXdX?=
 =?utf-8?B?Uk5lRkYvZitlTkJvc2RQVlRSVE9pbnRqK0xpcS92cmE2UDJxU1FTNVMwM1Nw?=
 =?utf-8?B?YjZkeGVXcXk5ZGZwMHpxelRHczFHODhSZTBGcjJpaE5jUnJ2RmQ4WWxveTYr?=
 =?utf-8?B?NHQzQ1lnSW85VEdXU2ZJRDd4Tmk0N2svNEtTZjd2OWRMQll5SU4zbzAzK1ZP?=
 =?utf-8?B?M0tFRUZaQTVoRlh2b0dqbW1BWmRwbW5CMTdOM3hCcG1OU2pKUmd4dlIxYngv?=
 =?utf-8?B?dVhoK0phQlJYWU9pT0ZoSzdRdkJ1R0gvYkJkWWFjWDdPbjV3NElRbjZyNW1E?=
 =?utf-8?B?dy94UmYyVlYxNld4dTdwN1dTNkQ1Ulk0Vkp3WnJUajVnb3Y4Qkw4cGZzYVJa?=
 =?utf-8?B?U0c2RWU2ZUQ1bzBtMWlnZFArTUlxaVZpUUhOcE9USThhT1hlZWNDK3ZQc0NJ?=
 =?utf-8?B?V0Q1M1R1cDhCMVJ3aGRwbVE0WkFMblhvaUplZkNkN3JFVmFTR25jeGNNS3B4?=
 =?utf-8?B?T2orK1NUZmJnUmdxclJRcDlkcWhya09lUzhtU25ZVG91Qi9UOCszeUlmZk1V?=
 =?utf-8?B?RVVsaUloTHhiRzhFem00TTI1R2h1aEdPVEJGSjhRTzJxcDVEdEszeEcyYVk3?=
 =?utf-8?B?aVBuUDhtUHVPei9zYVFNNnRBcTJPdmZvQld0bGRYcG5uSVhjTTZROXM5MmFj?=
 =?utf-8?B?TytkaWNwNFc0clhNZHpNdFlQa281eW8rR21VejBNYzBxK3o1d0FrQXd6cFNB?=
 =?utf-8?B?R3pCZ0NNTGxzOHlkR2ovaVAyaDVuOHJRNWxkMlE4am1YMWpHWklRVXQxUlJE?=
 =?utf-8?B?SGdQTGhlWVQxRXlsaVZXMEVTejRIcGt3aWo3bEtGcXY4a1ZmaTdyYWw2VEdN?=
 =?utf-8?B?OU1veHhrd1RmcXBJOXpNcVhsMlczY0t4bmxsV2xDNFFqRzI0T0hnQ1dBWUcy?=
 =?utf-8?B?WS9aUlVYK0dCYncrS3BEbkRkdjBrNVN1WlFnRklLNGpkMGRtRjAwVFd0ZEli?=
 =?utf-8?B?T2ZMdWF3VTZOOG05aldTM05UYlBkcG9pNUFPckFEc1BHczNmdGFEZFBlOEhR?=
 =?utf-8?B?QnRuRXdQcER0eDZvLzAwdk1KU09IWTVBT254d1A3cGI0eW11TFE4V2xidU9T?=
 =?utf-8?B?M3d6RG1QZUZyektFc0tlU09maFh1dmhRM20rQVZ3cEpsclcxTzMxTFVFekFF?=
 =?utf-8?B?cm1TcGFqNzk0UWpmVXhHcUU2cHBFTGhLVFg3YmkxYWtxcnhabjJzdnpsWTVp?=
 =?utf-8?B?YkdseHF3YWIvYjdHRFM3ZGthd00zWnJybnNoMXp3QzdPK3lJSytSN0pJSHhq?=
 =?utf-8?B?QWl1bjd2ejNsMjZYYWFrWktNWlIzcXo3SmIwZGl0dHNObHBoQkxmZ3E1L04r?=
 =?utf-8?B?ajZuVUh1eTZpL2xNL1UzL1hQZWFacFk1WXBwVEI1aUlJNC95MkNEY0lQakRr?=
 =?utf-8?B?b3hjV2xtZUsyeGZoMzJGUVNObmh6WnZqMi9XeTgraTQrVHJ1dnVBakdleGVq?=
 =?utf-8?B?TWlUMnN0bnMvRjNDM2hMWFAwNFJnVUoreGQ0Y2U0ellvMFZjeEdRd2RGK09E?=
 =?utf-8?B?MHArSXBkZnV6Tnl0amNLUkRVUnQrN1RTK1cwT1NrNXBYUUUvWTZodkVvWnJ0?=
 =?utf-8?B?QnVHWkVtQXJxc3BTYlFkeHBkNlFWckhTOTkxWURROEtTcGFzZklWT0o2MWpp?=
 =?utf-8?B?R3VaeWUxOUt0U0lmZGFzNkFOenc0bm41VkhSak9STDZ1OXpHd01HdDNBOG9s?=
 =?utf-8?B?ZzR6Q2tlTGJRSDVBUnRORlZ6UC91TlJNZVZIMkNzTW43TVV1aUJlUkp1eGtk?=
 =?utf-8?B?emRibHcyVXRkUlVEWnM5ZmRCM3k1Q1pYZ1R1MWlscG0ySDZUcVdBNi80YXZ5?=
 =?utf-8?B?dzM3ZlRCWVRzckNkZTZ4VlRqbERyd1NaMzgwQnFPN0daajAxVTUzSUVqdXd5?=
 =?utf-8?B?aGV4S2xYVTdnajZLUk5RT0cyc0RqVUN2azUyYithS2JRc2ZxWEhULzF5YTlD?=
 =?utf-8?B?a0VGRGxvcXE5N2lVbkpkNWphaWI3czRmcGkyYW94cUZjSU1JV1ZZOEM5MHBa?=
 =?utf-8?B?MnZoR2ZxRVUzdVJhdFIvTmMrT0NJbko5VXpiT1l0WGZGbGVuNFQ4cHYzZGVM?=
 =?utf-8?B?VWVSN0pzUW1VZFBhNzQrZFJnUTdzbGVXWnNvbElKYXl0cldpaW11bVVXR0pC?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893146cb-780b-4cb2-3fb1-08ddd8afca6a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:19:28.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jcfv5DCpbw/tO/2n0EI8f3iXX6l1WT+I47TxMkmJCMA2cVReWYEI+LfN+5B8Bjfis0koxlSyqK5251KqW2uX6e2nwdjspQp8QmVRY5aljcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA1NSBTYWx0ZWRfXzDJOeQzNtO9o
 04g2EgN3sHG1Q6SsMoV9ArlRUkV1VaEs+PEh+7MI//oyoLOnOFCVl53ir3/muI2al6KopC39pvc
 KguyL5erT4ZacoAH6CR9XFMoiTGgQsY4fr0MBeatWzHB0xuvcxFYNvhyhcV8c/JNT7yDg9XUx25
 egH0kw2cXc6QpQTHPqQ+PsSZX1omez+34DpT1/Q1j1HTTb5+CKqht/q7Znd/hfxV8FqJl5xjsuq
 h4ijXllRmxbLYuyM9J/QF4H6+16EtoMuipnZeNRX0HuV9/PBoKcnVzXYCT19aFfKBMca8M92PEh
 aHUeomKDL+3/j069NZ7MH7ZWKGI9RgM7I+sMvONAKejA+MXxI56rjRRbS4HJsk=
X-Proofpoint-ORIG-GUID: vFlMC6U2im54NJAVz_uWldSymtZEeYet
X-Proofpoint-GUID: XPqeRNr1pHTtCfxsFbZ6AuhCMkxTaEUY
X-Authority-Analysis: v=2.4 cv=Qcpmvtbv c=1 sm=1 tr=0 ts=6899a793 cx=c_pps
 a=2B8SwtIiMkeKkMQ5OzRnDQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Q4-j1AaZAAAA:8
 a=Q7ttZOGDWdbGWpjQ6nEA:9 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:19:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17856

Hi Alex,

On 8/11/25 16:04, Alexander Kanavin wrote:
> On Mon, 11 Aug 2025 at 09:58, Robert Yang via lists.openembedded.org
> <liezhi.yang=windriver.com@lists.openembedded.org> wrote:
>> Skip fetching from an invalid local url since it would be failed.
>> -        ret = try_mirror_url(fetch, origud, uds[index], ld, check)
>> +        ud = uds[index]
>> +        # Skip fetching it when the local url's path doesn't exist
>> +        if ud.parm.get('protocol', '') == 'file' and not os.path.exists(ud.path):
>> +            continue
>> +        ret = try_mirror_url(fetch, origud, ud, ld, check)
> 
> Can you please explain the use case? I'd think failing is the correct
> action, so that the invalid url can be removed from configuration.

There can be multiple PREMIRRORs each PREMIRROR conatains specifics sources
for each layer, each recipe will try the PREMIRRORs one
by one until succeed, but the trying would be failed if the PREMIRROR
doesn't contain the required sources, so return it immediately to make
log.do_fetch clean.

// Robert

> 
> Alex


