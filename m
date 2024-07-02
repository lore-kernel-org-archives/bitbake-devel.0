Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB677C3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 07:31:47 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.18959.1719905504023746035
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jul 2024 00:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=791399661f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4622aJY9001931
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Jul 2024 00:31:43 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 402hsg28pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 02 Jul 2024 00:31:43 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4627Vh3B023284;
	Tue, 2 Jul 2024 00:31:43 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 402hsg28p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 00:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn2BvL/g/c5AJILF5x1hBNXOFjSecD63+7A/olSRVKXTjbrNNv8wC291drNLMJRkUXkN0wpGkkEssCNiHFh2XHrcwRi2+nvwdb5aRnTuT56OehWa+wlKWqz6X6ZqUEiphX11YupZO163yIXQ46Q3WLmS4x2fe44f7vG9t4UJqbsw34pfuN/59AMmjnr8vTarHqUtXt66+pURBosCggNebsaigFYOcGJ8YZkZFsfnQqANCZJCuY+PM/qZNf99QExCv1os4sNBUfKOq5A7jj9iFqfagVznP/L/yH6iUNScpr2wxEdOXCM4WbdoZQQfIwaVNgE62gOPUjk1bBGxI7/OGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPZ5m2zNgVKpGUWsmaKqqpGzVtTJ/39SGPO2qihizCY=;
 b=S32v9V+LtH1zHibxA+aHKu5GgN2iLTuMeOT10FsF4uLBVLys7ZlmLEWJ6LUNZifFgwZs2Ci9aatuHYZgG+0dVMWkhw6+MGTzHS2ygi8n7XgZSBfTY1WewkV34weAkY5CkFcwuHXMsAPLqlVtzoiq/xy5EUEi63cy+B64XXOe9vAGTrUuhr/oohzS0ALB8v2sbNydHm2zAhq4sppmmXzc5fXe0Fr4OeXhUomaAoFqvn+hnSPiPazv+AQ6UmSZBgs+o7DfEh4sY5/CcHPeo/c1pltojIj5A612SA+tq7wO70eNy2aF8mOOJDnoWZ3uylqIrpkSBjmxqc/OxDqoigrbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by IA1PR11MB6146.namprd11.prod.outlook.com (2603:10b6:208:3ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 07:31:39 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%4]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 07:31:39 +0000
Message-ID: <afe47796-7e3d-4666-8bda-c6c0e6486c02@windriver.com>
Date: Tue, 2 Jul 2024 15:31:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch2/git: Use git shallow fetch to
 implement clone_shallow_local()
To: alexandre.belloni@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, andre.draszik@linaro.org,
        kergoth@gmail.com
References: <cover.1718886475.git.liezhi.yang@windriver.com>
 <2024070122132747f143a4@mail.local>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <2024070122132747f143a4@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::9) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|IA1PR11MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 7730e532-4163-49c0-b269-08dc9a690330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|4022899009|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TE9lMCt0bmJKMVhoTE1qVThSamg5dXl0ZlN6dlJ6aWRiNk1zbEM5OE9oeldG?=
 =?utf-8?B?dkxLdXl4WVdvU2hudWpUa1hiTzBQOWU5ZWdkcVlFNjJYSTFUd1hkekU2cWZS?=
 =?utf-8?B?R0dyNEhKZ3l6RWk4MEZLY05uQW1HVWJyT2gxWktEUGNuWGNveUFkcG8waHVM?=
 =?utf-8?B?eWhKeXB1c2FpdDVoQXdWblQ4RjRhS25zYzJWUGdpc25OVHRtVnd6SEZwcU1J?=
 =?utf-8?B?TkZrZ3V0c1hSTmw3NjM2alIrb2MvN3V1U1JHVENaQzdSSGI0cTlRdzViZk16?=
 =?utf-8?B?cVA5SER6QTF4ekhTRklWMDZDdWo0ZzFrcGNvTXRneDFoVEY4Zk0yODQ5Q0VP?=
 =?utf-8?B?VGlVQWxiZ1Ura0VOd2VXZVgzTG91blFMaVlLaUF1MUFKVTB6WWk3TS9USFAy?=
 =?utf-8?B?TnpoRVQvRGlmMTRNb3lPSU40OVQ2UEhYTUlNcTdNdnBzK0xlZk80UGUydFYz?=
 =?utf-8?B?eFBpS2w1ck0zaW93NFR3c1F1Z0V5NEpCVVpLdXUwUldiUlN0dXlGUmpJNjNi?=
 =?utf-8?B?VE95eUxHWDRSSVBmRVlwMFFNdi9wak50V1MzQ0R3NUV4YW80Z0E5N1UzWndR?=
 =?utf-8?B?SlRyT1hwZ0RvL3pNaUoydmR4MjYvVythU3lVMUpEWWtzL1FuMDdDU3JoMHU4?=
 =?utf-8?B?am1RR0NMYzkya0swT3RxbmhMTE5ma2tXak1FQ0NZQ050UTZjaWZ4YnNyclVQ?=
 =?utf-8?B?V09yL0w2b0syTjJ0SEdYK2t0Q1RXR0xSMytKMzdQU3BPMEVwcnIxMDltSzNs?=
 =?utf-8?B?RDZvN0U1TUpNWGlXTEdtdFp3eTZLZzdJZmpueWNEZFhUZ1grSVJ0bWRVVHFv?=
 =?utf-8?B?OTdWZWt2eVZzelNyaEtMV2M4eXFON3RtTUhHMXlBcXQzbHRvYnhBa1FNNVVv?=
 =?utf-8?B?b3hoeVlVQ1NCWmx4eWZJd290eW1CalMraVpYTTZZR25CWG5oRzNwbWpmTCtQ?=
 =?utf-8?B?UnhZMzVFNnNVQzRJZ0UxczJWc1R6U1ZaTjdFREZZczJIbmthWkdzR2dQOXBi?=
 =?utf-8?B?ZnVrLzlUR0l3dTFQOUNDak5yWjJwTmJ6aFpqTXVySnFLT0tkamQzWVArWlBI?=
 =?utf-8?B?UkcxOXdpSHV3Q2lSZy9HeS9OZ0tGdHk4YVFEUlIzNWtPbG5hZWNWSE5pclBk?=
 =?utf-8?B?RjZwTjJxZTUwT1FSb0RFSGRmYWNudWVTQno2aWJ4UVpKWHpVQzNndFhsSXo5?=
 =?utf-8?B?MzNtU3doZVRSOTV4SnFNZVhkZkc2SVFZVmdxYlVOYmRFTzdTVUdqNFNRbzJs?=
 =?utf-8?B?Q3FDMnB0T2Z2ZmJpODc1QytGZnN6TmVuZFFrTG45OGJYb1lBM1hvVjFRbjFt?=
 =?utf-8?B?eU5HSENEZUN3MS9DczUzMERkWkY5VFNDRjJlS0owRDM3ZDhTblNjTTk3eTFu?=
 =?utf-8?B?cHdaTnJHODNaLy9rYktSS2lpVEFXemh6eDd1SWNqR1krV2hVZWVybXNIV1NG?=
 =?utf-8?B?dlBETVdjaTNSYkVUbVZ6bnRGRnJWY2JHZitCL0lOUTNlY3o4NFhnK1hLZFl3?=
 =?utf-8?B?eFZPZ01hV1g1dmZRaDYrNDZtRTNHUTNPaEFTMUF5bEZ0eEo2Qm02dCtvTzJT?=
 =?utf-8?B?OFAzeWs1VE1YeTV5Z1JvWUpUaVNTR2thLzNjQW9kYlptYXEzeWgzUEpRNUZY?=
 =?utf-8?B?T09oRmhpRlFQRnZZRFpNeUVwZjFGZXJHL1NPQ21aRVJuc20zODRuc29vRmZE?=
 =?utf-8?B?NlQxamxIRFJUSlNxSytxaTRNb3JhWS9hcENieTNHOEUzRHpscE1kMVd1TUdz?=
 =?utf-8?Q?sRRndRwp1P8Fw/5Q1c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TERjd3RGU3NvOFJ5Qm4zakk2SkI0bm8vRUN5ZnhOVHJLNHZTUE5vYVN0ZHRz?=
 =?utf-8?B?SkxmY21GQTBKMXN3TklMVmViNTkydzdCRGcvaHdaSy9WLyt0M1p2UUh2b2kw?=
 =?utf-8?B?VHVKVGo2KzltWXBIdlVKVVl6S2M5N2RqU0QwN3RJYkhnbW5kUFlRamZjQzRn?=
 =?utf-8?B?SUFkYVFWSndqOXlZY1RrSnA4MEtIZ1h3Z2ZxU0c4TXlrZEFPc3VlV3FYZ1k2?=
 =?utf-8?B?SWliRlArV0ZqU2VnRm1oRmpsWXFvN2xRUkM2RVUrUlFPTWR2T1R2T2V6Sncr?=
 =?utf-8?B?ZjQ2ZFVWdWxHWjhINlhlS1ltUU9UOFVGdkU1cU44blhUQWJhMkFDSUVJNTdL?=
 =?utf-8?B?QVFSdi9RWnBaVmp2c0tQc2pSSWhEWFlldkhEbGRITG9FQ1FzUzc4aUlQVWZt?=
 =?utf-8?B?YmRwdkJqQlhWdVo5NktuWmtIY2Y3K2t3UXRTd2V2NFEyN1NDWGJWSFgyTnFK?=
 =?utf-8?B?UnRKV0lwQWV6a0NxanN6bkZ5UElVemlvKzkvRWh4ajQ4aFVGMmZRbzJtcmdZ?=
 =?utf-8?B?Vk1qU09lT0ZabDZzVHdDZzdxSTFrMmdkVDE2di9rOEdrNUVNcWNudk43Nit1?=
 =?utf-8?B?VnNEVzEyamdUL3pPQVJSOE1LUGprbkQzTVlKN3VWYUJwQkZkdlZHaG9JNW80?=
 =?utf-8?B?bDJMZ0JEVE53NXFRTXF3M3VYWndhZmZsZTRxaVhVWDFCWlhOUzVzWkZDRGZu?=
 =?utf-8?B?UmROZVA4L2txTnFkelJ5T1BNWnNwNkdRcXUxYXZTY1RlZUs5MWNiTHBKQWtw?=
 =?utf-8?B?V0pib1ZoeVRzNk45a2FyeWsvYmMzMUhDdHIrY1pxbkpIQk4rWHpncGdjUFZN?=
 =?utf-8?B?dUFSTU0yRHZ6RFF2V0w0d2IzaHJnMlYrMnhTRGU1NWJSSVNaY09UOXp3dHMz?=
 =?utf-8?B?MXZKT2srTXBoMUZiazNpdnMzZGVncEIxdlNqYzlzMTRNQW0wcm13Y1NoWitU?=
 =?utf-8?B?NHBYY3JGVHJ6VXRoaHpxZUJSME9RT1A0RStpb0hpaVBOdDRlbEFkUG4rcDE3?=
 =?utf-8?B?cnlWaGd3aXNhdGNta1VkekNpTW9rOXFURGZyRFZiTWxwWnRpSTllTFkvWUQr?=
 =?utf-8?B?Sk1GQys4VDFNTDU5SzNtYnoxNDkrQXBOQzFET0plTFVhWjQ2b0ZXYW5TSGdF?=
 =?utf-8?B?QkYzM1A0NVpXNTM1eXcwUnJBTnZsc1lYVkVZNW1KUGN3djk0bHlwSzNlSmxp?=
 =?utf-8?B?Q0RUVHZJdHlQUWFqdnBuT0dyVzE0N2VORXIvaFgzeTdIU1lrQ0dweDFacW9j?=
 =?utf-8?B?SWZhdjVxdXJrQ1REMTVzYXpvU1FRZWxNby9KVkdvZk1jNVFUbFJKV2lVRmtE?=
 =?utf-8?B?WVRHak5TVVpibWk3OVVDZndyd0daVkJ5WTl5a01zeGxnMTJpdURUWGU0My93?=
 =?utf-8?B?WW5PQk12Y1hlZ3FscDZrczVTMEl0Q1pZRUJGZnRkR0hycXFRYldBSkFGMmpS?=
 =?utf-8?B?RnJZVEQ2MVRzQlhHUXJsMjQ2c05LK2JpYlhEOTkvQWF6YWxTYnBDeWZDYkhm?=
 =?utf-8?B?eWhYazdJeXNPaDUyRzE0VGxoNk5hVjhVWUNrMmlGYzY0WFczUCtxS2dnaDhQ?=
 =?utf-8?B?aHNhTzEzQ0w2S2Q3RVJISlNRYWJPS3JScVNDM3Z2MDliZFVXeC9BMEJGU1Q5?=
 =?utf-8?B?T01zUmkwOGQzTWoxcU9uem9rQjV4YmZGUU9yZmlYMGsrUVRER2orS1ZzVUV2?=
 =?utf-8?B?ZFVVTGhyc3Q2UkFZa1Ewc0RLWU5sR2s3LzRkUVVzTHFXaTNsUkRzT0lJblgr?=
 =?utf-8?B?Q2dOSU5VZ1FDVGltTFcyK2N2Z3A4a2hndnYwd3BveXZIWUFRYksxVkpaNDdz?=
 =?utf-8?B?NjRhTVMvRy9DenY2UFp6RlRoRy9sVnAyc1JwWFc2eFR6UGxQb25nVk1WTUhO?=
 =?utf-8?B?V0IveEllTFNvM0gzR1IzOHp4N2NweDUwc1dUelVhd1VhR3N0RTkrNFhOYzhp?=
 =?utf-8?B?cUtUT0tDcTJYaEsyY2JGemJRYStFUFlYY3oza2pBWEV4UDZCKzNPaHNwNXhG?=
 =?utf-8?B?MlB2YnBocEJxYU1hNnRLMElhalkxSE5ndWZuNS9zNVgyck5jQWNrRGdzZ0w4?=
 =?utf-8?B?b1hVTG9NQ3RKcmxLbWdsNFJSVmVpckp5NW9HSEhMYnZ6V0FrTHRhTkRGZmFn?=
 =?utf-8?B?NUVsS0Fla0hZUFRCNkVPbS9ocnhMeURJSEVWUEVhWDRLTjcxVUJmV3VlNXNR?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7730e532-4163-49c0-b269-08dc9a690330
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 07:31:39.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlZ+tbXBnoF2ZbO7nvn2I9ROK1hIju7DPoKgdzr15dWUndfSsDvZyOxiHUgfJ9SNfEcqH6vOKUy67IqD9Hyx2lXeUGEG12Pr2MPIMaxusyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6146
X-Proofpoint-GUID: RBriqTiJFZ1crd_v3VKN8e_fFohxCfn-
X-Proofpoint-ORIG-GUID: HxVQHBEZmqScNFtipjA7_JH-bn4aaeRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_04,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=903 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407020056
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Jul 2024 07:31:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16384



On 7/2/24 06:13, Alexandre Belloni via lists.openembedded.org wrote:
> Hello,
> 
> This fails on our ubuntu 20.04 workers:
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/6923/steps/11/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/3542/steps/11/logs/stdio

Sorry, it might because the git version on ubuntu 20.04 is old, let me check how 
to fix it.

// Robert

> 
> On 20/06/2024 05:44:39-0700, Robert Yang via lists.openembedded.org wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> * Test info
>>    bitbake-selftest works well
>>    bitbake world works well with the shallow tarballs
>>
>> // Robert
>>
>> The following changes since commit 5d88faa0f35f0205c1475893d8589d1e6533dcc0:
>>
>>    bitbake: siggen: catch FileNotFoundError everywhere and ConnectionError also in get_unihashes (2024-06-18 08:45:22 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/robertlinux/yocto rbt/shallow
>>    https://github.com/robertlinux/yocto/tree/rbt/shallow
>>
>> Robert Yang (2):
>>    fetch2/git: Use git shallow fetch to implement clone_shallow_local()
>>    bitbake: tests/fetch: Update GitShallowTest for clone_shallow_local()
>>
>>   bitbake/lib/bb/fetch2/git.py  | 71 ++++++++++++++++++++++-------------
>>   bitbake/lib/bb/tests/fetch.py | 13 ++++---
>>   2 files changed, 53 insertions(+), 31 deletions(-)
>>
>> -- 
>> 2.45.1
>>
> 
>>
>>
>>
> 
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16383): https://lists.openembedded.org/g/bitbake-devel/message/16383
> Mute This Topic: https://lists.openembedded.org/mt/106779045/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

