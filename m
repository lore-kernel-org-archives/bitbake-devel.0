Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82372C282D0
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 01:58:09 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.4317.1741139886322289900
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Mar 2025 17:58:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=515973b768=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5251HMu2031438
	for <bitbake-devel@lists.openembedded.org>; Wed, 5 Mar 2025 01:58:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 456ct8827d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 01:58:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGGCB+Qo7WwB8tNH3D5U/cdqO4tlkmpvZz1d9BfRdxXw5TSInvGjNLaeYvYcJg6hoclvOuNWhSQmAsv7GqfXSr+qPbbWuy7uClRt3vC2byy3Z08/VhRPE8OvClfuLfTeG6sgNNd5ELZ2eJEU7V8OG2AQhBs8tff9P9uw0hUn8P49p10emc1bJGWddJD78TQSyxz07o2PI5Rq5NAcKOa+CBKWXZDZzQGvNwBI+ZNvpX8Hr1egT/z7Jidt7PFdw0nl1k8yKzQwoH3Esu5qv4HRLend3w0eIDpFyroxwNclMFT2+bt/mXlslsVdqMkQKV8raf5HaUMmAMRLVkqK7v5aWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA4NlTGl+TBEU1/6Qu+ca7FJPfFxc+s+K4UO00t3ZvA=;
 b=nz/rb7wzlagYMeWaIv6YT6CC3un+r7tbMfx9tm2yEbMdwWurDxIIJYW9frHQvLzBSvihOF+oZRLd6tAEfFfTuYVFuEZpFFuEMqqXlRc8LRHXhzW0ISNq1ehgIM1SzzJvGoov+1mx04PL5BDh+rj8YRqIOW/gd2RhmxTY9yk6URHPeGvIOAizwxZ+rWjkurVrQA5L2H/1cZszWw6pEmV3eja+ABIBpCKjL2LgyGmQuyWEQSzesnaC9/eBWIxSY42bPsRcfzkKDKsQc4IVPTTSCCC5DrEaOCOG5Au0uXsVdcqElkU3utCeRdSzy1bZwk97nAQrTRXYXKTxr3sCsXLpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 01:57:58 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9ea3:51c1:edff:4d3a]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9ea3:51c1:edff:4d3a%6]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 01:57:58 +0000
Message-ID: <ff241013-6c0c-43e7-8e18-455eb5e026d4@windriver.com>
Date: Wed, 5 Mar 2025 09:57:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH 4/4] data_smart.py: clear expand_cache in
 _setvar_update_overridevars
To: bitbake-devel@lists.openembedded.org
References: <20250225064853.2406575-1-Qi.Chen@windriver.com>
 <20250225064853.2406575-4-Qi.Chen@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20250225064853.2406575-4-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5611:EE_|SJ0PR11MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffed908-b081-4f46-f8a0-08dd5b892734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VkhJdG9ucjNXcFVncm5OZzRTZXdneHNPR0NzSzB1YWJWU1B4SExqWUJhUVpW?=
 =?utf-8?B?OTI1TzBrbk04bThiemd6OVZXSVBST00wT201MlhyOFFWcXFWRGJSNytsemZT?=
 =?utf-8?B?dVVyb1BnbElwamZ4cCsrN1EyWDRKQUljVytOYXFqdlU2TmFiMjFmWVUreXEz?=
 =?utf-8?B?eDVOWlVmVkVoTHlyN1lhT2Y1TXFQOWtJMmszZ29iYjVDdmxtdFdBZ0lpMVpV?=
 =?utf-8?B?R1NXdHNLS29nU2liVjZDbU44V1FxVGd6OTZ5NlRJN29vSUViVHFqL1FXZzJ3?=
 =?utf-8?B?V0JYWmNtSE1RazBiK08yN1Z6U0E1b1RnK0pvVHVpQmgvUFc4MUdjZ2tzamNo?=
 =?utf-8?B?K0U2bTNJblFOSElWeHVBR0JwNDgrZVZYVW90YXBnRkh5Rnl1N1lKbmEyRklw?=
 =?utf-8?B?RVdkQWhOKzVQRU15dXIzblhWMndySWcxSXVOYzhRT1p6N0hPMHA2QzFQakFv?=
 =?utf-8?B?VzhHdTlIQ0FPQzF3aW1LUnkyVHF0L3VieFl0UXdidHU5ZmIydVErUDh3UDIr?=
 =?utf-8?B?NXlYUC9kS1VtNkRFY25IZ25EOXBBSmwwd3dNYUxHOFhXa25XMUlTanVyVG9q?=
 =?utf-8?B?eVBtMUhTVlM2MjlHU3JtVkVIMXJ3OGhXNy9qSTZncnRhV0l4MDNEV3dHOFU2?=
 =?utf-8?B?OGRoUkl4KzJZbnkwM2tMVXNGU3F3UDZjbjRkNmpBUHpIN25TQ09UYnB5djlM?=
 =?utf-8?B?Qyt4emNUdG1sdTNWMktxOTVJeDlzd0JVSjVxbnIxbi9XcCt5YisyZ0hVQkxV?=
 =?utf-8?B?N3hrUWh3QXBtT0c1LzJ3WmhEZ043RlFIZ0k3SVBFMEozWjkrdWlBeTVKTzVZ?=
 =?utf-8?B?Ykt0RThvSzdNazhUejJ4bzlnQkp5QmYyTWg4OWw4YjREWkw0WklZUFNSWXZ3?=
 =?utf-8?B?dkthRzFITEdiYnRUUzNLV3pvckMwVTNxME5PUW1GOW82TXpUZ2doL3QySW1s?=
 =?utf-8?B?U3o0TVc5ZG12Y0V3MWtTUk0xeVJ1eFVQQmlCMDVCSzM4ZzZDMUFGRzJJRG45?=
 =?utf-8?B?WHlpeHpPTXJwbVZVckRSUFFjQldlaEhXTHFXcVREQndJTFAzWXRPWWFkd0tJ?=
 =?utf-8?B?blB4eWdjTVJNZ2xnK1FBcU5HUnc1OXpyWlkraU9jOWRnT2R6c0NVNWF3Ykd0?=
 =?utf-8?B?eEF4UVZlbldhMzRlWlYyNkV4UmhFcHpkUUZBNFNPd0N3c2J5dW1xcllSQS9m?=
 =?utf-8?B?UVIxdUxMVGdvdmV4dlp4QjE5VnFhUDZLblhDejg0NEI3bUYxT2gzWTBndXBG?=
 =?utf-8?B?QWx5eVBtLzltSVF4dmQ0R1FmenpsaFRONXk1cHE2bTZQSzVaM3R1ME5rVFIy?=
 =?utf-8?B?a1IwcHZ0L3NmTnU0a1owMkRTbktSNXpBaHhpQVhEZ0lYTUcyYTlkWWNPanRJ?=
 =?utf-8?B?aGh4OWxISGdDVDJPVmg1emNtWUxBM3huanhETzBIOUNaYVFCZWRBZEY4TFNa?=
 =?utf-8?B?UVJWRW1iNG5yS29hNWppemhKOXJCWnljMjEvbFk5cy9HM2EvdXlGQnF6NDdO?=
 =?utf-8?B?dEZCeUhwTkNsZWVIR2Z6Mms4NnVucG9RQ0hzbzFVQ2p3VDBEbFBONjJMK3Jn?=
 =?utf-8?B?cENzMEpMWU51WC9BTk1HeTNnL2FlWXB6b0dkWTNwdnVJNXY0SS9vTHViL2d1?=
 =?utf-8?B?aFgvTE9KMHI5TlZ3QTc2bWNYL2hXN2VGZHQ2WFlzcEhkTGcrUUF4Zzk4V0pV?=
 =?utf-8?B?TGc3bkYwR2YxTmorU1RDRE9EcUt6UDhITUFKdHlDMXRkYzF0L0hQZzdhaUlK?=
 =?utf-8?B?dFdxUTYxeEcyaFFzMTE3eENXZ25XMGMzNGswRVFYMVFzNUZSZVJFUXJtUnNr?=
 =?utf-8?B?cWV2Y2tkQjNTc3ZmYUUzQjZycmc2aW1yZHRsd1E5UEdVZ3l5RDNXblRPSmhy?=
 =?utf-8?Q?gn9TsfHzBaVA9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SU5XVzFLeVczcXVRczBBM0EzUDJZKzFkbUhWZDliUk9TQStsa3NnT1NNcnZv?=
 =?utf-8?B?RjN1NytJa3NacmRzYXptSWt2cmRkMVZWT2hJS1VZMUMvd2Zqb0g0WGhGZVhx?=
 =?utf-8?B?N2hYTDZhclozVm1oN1R5dDN2eTA5UGxwbHZpOTRRa0xxWENVMGJURW1oWVUx?=
 =?utf-8?B?a2NtaXlQMGdSTEJaYmNvWEIxWTV0RW8zVmt0MWFhSWZ4ZUdENnVvamk4aDF2?=
 =?utf-8?B?ZDBrT3dSWGVpQXZTVDlLMzVFNnA3bVRJTmVOZEZzd2NacDJyQUpvRkFObGho?=
 =?utf-8?B?V3JHVWhOc0Z5c2tKTExpSi9aR2RmaHpra1hoblhUQ2RTb2E0cXFhWHJxZEhC?=
 =?utf-8?B?OHdwaDhqcmFScFRRUWFCU2VWMFU1a3NMMWVmQW9JRWtubzl4VzdXVEhQUVpN?=
 =?utf-8?B?dzdmYkl6eS8rbFo4eU80djZrL3lnVnc2bndUZHlWQ2t2TDVzTERPMEhYYWFV?=
 =?utf-8?B?SmJKVHZabmZaSFhrakdHcWk1VTZWUHBLOU5uTlVpMzVySzBaeFhKTVBvblRY?=
 =?utf-8?B?TkNBUkoyR2d1TkVOc0dCanAvanVHMlJncFNSekdQem1kdllJR1FveHNENkQ3?=
 =?utf-8?B?RHV3a09ic3ZKeEFYL2RzdU81L1ByK3RFcGVtUUhVOW1LUzhneWdXRmk3Q1Z6?=
 =?utf-8?B?V2haV20yT0tiY2s2MXRueGt2QXFKTUlwWVRyanp3OEt2dFFqU1JCR0RyOE1V?=
 =?utf-8?B?ZnZSa252clRCL0ZsTnpaRFdOYTM5U0dtTHhrYU81dGQ0bWdyQkppZGpoU2k3?=
 =?utf-8?B?ZHZkM3VNd3ZuYVZFNzdrblJxa3dFZ3d5UmpMQlpObHN0NVhFMnRESFY0YkRI?=
 =?utf-8?B?R0RiTHkzWlc2RmhtUXk5dUNXeWxPRGR3WjlHK0ExdHArOWhDSm9UWjc3aUFG?=
 =?utf-8?B?M0cvMVJ0cE1LQXVRTEgyU1haT1VpaThUS0hMUUxldHRYODdHd2RQZUNIK1pG?=
 =?utf-8?B?Y01LQm1UcVZWcjk2S0UwdFEyeW1SYVI1WmxOOEhWSjVUekJZRmFxNVhGbkFz?=
 =?utf-8?B?amxkUkZsOEI4VEhWamZRVEFaSEIzMStrT1M5c1AveHh4OUltaEtKQ1MvTHBi?=
 =?utf-8?B?SDFERFRzT3dJN2JIK2kzMllmbXpiUHpJZi9KWWE4UkdINk5nd2Q4d2hhd1NI?=
 =?utf-8?B?MzFlYjl4TEhXbXJGTlF5MVlsNjNFTnJJVmZZeDM2NGFXZVA5c3AxaEhPQ0Nl?=
 =?utf-8?B?d3V4dE5DSVkvcVpPc1czNytIUVNYUFYxbTZUZ1Q1bnovQU5CSjBncnBYb2c4?=
 =?utf-8?B?cmpEMjlyeXpGQURPMDhrTElNTHNjaG9seUp2T0dBMExLcEZaSVVWTXErRlRu?=
 =?utf-8?B?cUtraFl3aXRQN2E5VFMxbEFrSmtrTFFCWDNTeVFOYVJuM0tHQ2pCLzU2TWtT?=
 =?utf-8?B?V3VBb2JiTTlwUXhMZTJtR2UxUXpRTFFtbEpvWUZlY2Y0b3cySEVJUUY3cllx?=
 =?utf-8?B?K0JrengrOFhDRDhnbnptME5iejFPRm9vck5hd0FsdDdFcWIxSjZFanZsbVpq?=
 =?utf-8?B?N2JrZWJHOVFFd213bm1lTk00YVVzRjRsREhrOEJ1d05jTzdEUnRrczFrWTE0?=
 =?utf-8?B?UXVDU3U4Q2xJbmVBZVdzeDAvc09uQ2VaQ2czNEVSNmttWG9RR25id1J0RWY0?=
 =?utf-8?B?ZFI0ZmRSeG5peW9lbkdrTTY1dHdSak81R3R6b2FTd3Jxb3FKVVRsc3haL0pj?=
 =?utf-8?B?ZkppL2YrM2dKSFQzMFBwenBZeHAwRVFDbFZFb1ZRQStvRS8vajM0OW5rZDMz?=
 =?utf-8?B?Y214bTNMOUNNVk5BQ2hNWVEvWC9ZZCtDRE5lNkt1RFFqMk9nZXJpdXFFYUFB?=
 =?utf-8?B?dWRtM3RJbWJ0M1VxSGlZOWUvZmRFenZ2dVFhcFFIWlpLSHVORkRMMXFzZlow?=
 =?utf-8?B?bmFGQWZiN2N1eTVxWFJRd0wzQVkxa25IMWlxb2xUbzd5c0dxSnpkTmNsWXlk?=
 =?utf-8?B?VWlkRXEwN0k2M1lGb3Urb0dBYVR1U1plOWVLRzY5dXJZbmhodnY4YXN4NmlM?=
 =?utf-8?B?U1kxV25tNkNZOVRHTHEyci9xTXlZbnlYT0NtOS84cEhuRHUxVmdHY2lwckxm?=
 =?utf-8?B?UVRhY2QzSHhSVm5OSWRsZG9IcHRQSTBaRzg0NzU3YjR2VVllOWZCZmNwRU91?=
 =?utf-8?Q?GOUPyvG/NolpclWdQXiXlA3DM?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffed908-b081-4f46-f8a0-08dd5b892734
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 01:57:58.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiUgFQ5aI1BIaImUjeRTNP1/e5bUu4uqOQ60Lh7JUQRZQt4l3VbwFpOFYSvv2sulpfpV3ureU6sIu7JYvWBGXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-Proofpoint-GUID: AT4VUirbY8mWbezP3TUgsn5g5iV6ecjy
X-Proofpoint-ORIG-GUID: AT4VUirbY8mWbezP3TUgsn5g5iV6ecjy
X-Authority-Analysis: v=2.4 cv=D4W9KuRj c=1 sm=1 tr=0 ts=67c7afad cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=bdr57pGcRMKk6sAnQVoA:9 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503050013
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 01:58:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17383

kindly ping

On 2/25/25 14:48, Chen Qi via lists.openembedded.org wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> At the end of this function, self.overrides is cleared, which means we'll
> construct a new self.overrides after this call. And a new self.overrides
> will give out different expand_cache, so the old expand_cache should also
> be cleared to avoid any wrong value.
>
> Currently, there's a problem revealed by recent recipe specific virtual
> provider patch. If we enable multilib and set "OVERRIDES:prepend" in local.conf,
> things don't work.
>
> Here's the error message:
>
>    ERROR: Nothing PROVIDES 'lib32-gcc-cross-x86_64'
>
> Below are reproduce steps:
> 1. Add in local.conf the following lines:
>     MACHINE ?= "qemux86-64"
>     require conf/multilib.conf
>     MULTILIBS ?= "multilib:lib32"
>     DEFAULTTUNE:virtclass-multilib-lib32 ?= "core2-32"
>     OVERRIDES:prepend = "some-override:"
>     (Note that using :append and :remove also reproduces the issue.)
> 2. bitbake -n lib32-sysstat
>     (bitbake -n core-image-minimal also reproduces the issue)
>
> The expandWithRefs calls getVar, which fills expand_cache. So when setting
> OVERRIDES:prepend, this will fill the expand_cache. When overridevars are updated,
> if we don't clear expand_cache, we'll retrieve wrong values.
>
> Previously, things happened to work because there's a call to expand
> PREFERRED_PROVIDER_virtual/${TARGET_PREFIX}gcc, which in turn expands
> TARGET_VENDOR. Now what we expand is PREFERRED_PROVIDER_ virtual/cross-cc,
> so the problem is revealed.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   bitbake/lib/bb/data_smart.py | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
> index caef93ff4f..1c867653f3 100644
> --- a/bitbake/lib/bb/data_smart.py
> +++ b/bitbake/lib/bb/data_smart.py
> @@ -635,6 +635,7 @@ class DataSmart(MutableMapping):
>                   nextnew.update(vardata.contains.keys())
>               new = nextnew
>           self.overrides = None
> +        self.expand_cache = {}
>   
>       def _setvar_update_overrides(self, var, **loginfo):
>           # aka pay the cookie monster
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17301): https://lists.openembedded.org/g/bitbake-devel/message/17301
> Mute This Topic: https://lists.openembedded.org/mt/111373619/7304865
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


