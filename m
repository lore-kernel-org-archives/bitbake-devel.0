Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF2C2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 05:46:20 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.1524.1719467177124011804
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jun 2024 22:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6908b51466=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R5j4Qv014130
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Jun 2024 22:46:16 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ywx4fvdew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Jun 2024 22:46:16 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45R5kF2F015708
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Jun 2024 22:46:15 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ywx4fvdeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 22:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv1N1oy5PFqmNGwzBGnCmFsvDe3JJstnoe/YmRvCBgwCecXRLhVWMNVXK3jIHEJFGOWm5mXC7phSkhMDjPAT1+nhi3sbocGidUwVfiZjIrrZYhMhAoTndceYJwiJIuHRaYXFLL/XuzH+s0b68RYexuNmZvpDUvCjLiqAdpBboH3Oak/uP0QZGIB4yxH/ioa1Nhk5CTl9n7Mq0sPYv+D4AsO7hd73PEwKVZNTc9QRuWkdkmXhBRyUTkai/S1aZ+ibk6E1dsqV+u+VPBFruO9oNKeikMlNWjO6InkMwP8Bsfbe7SkW7TaBWZej2PxVRRfYxCeIKuGTyHs58Oc57dZT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55caTKHzm2oO6ZIplJal7vCm0NKSO4QDQSHc17gUiaI=;
 b=iQhvWnqzxc6sBgm2JUAstZppukf3j7h0LkNP/Te/GApbvegZzIyU87VlZ6852I9agPY0zrz5W70SMckMYE25ixvhLsMK+cWWsEvoWtfx4N0/0dCkKmQEALY/DmcOddVVJtxeiKZjhi8pJ5CpCOYF+UhSPtPMLTagyT2UyT3f9eLGK/sgD2+kBkI4xkfxNwVqNsQf9Zk68m9UuUAPKyuCsjLCrRsbOEmnS7rzCYQFILdVSI9/LmSQX7/Xh84YsWno5T0tm9Jq4B3yfNlet2uwIJi9Lr7MYHiLdbeVkHvqfsx2ArHKTZT1wgzgcDGRPVzJ9M7CSxJC09CrS2+9TaUStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.36; Thu, 27 Jun
 2024 05:46:10 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 05:46:10 +0000
Message-ID: <179dfa77-f266-40d7-b0d4-5ea86bd0f2e3@windriver.com>
Date: Thu, 27 Jun 2024 13:46:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch2/git: Use git shallow fetch to
 implement clone_shallow_local()
To: bitbake-devel@lists.openembedded.org, kergoth@gmail.com,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: andre.draszik@linaro.org
References: <cover.1718886475.git.liezhi.yang@windriver.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <cover.1718886475.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::20) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 270ced51-826d-4345-17ad-08dc966c728c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?REdXV2tHeC9zMjhLNHIydDlLMVQ0ZlZUa3ZwRUxOZmo0Um1sK3hzV1hQM0dS?=
 =?utf-8?B?M2tqTnRKMk12aE9kdThUVEVld0hvYXhRcFhDSDgyM3I2NWxIQ0N6dXloT2JT?=
 =?utf-8?B?QktiMG1SQWN0SHBwRmRHM0F1N2ViZHJmQzVNM3g0ZkkxYm9JL2VRbkhGVXdH?=
 =?utf-8?B?L1JUdHd5N2xDTlFVa3EzN29EUFB5UExObFVpUU16Nkgva1VXcit1MHAyOThT?=
 =?utf-8?B?cnBqc0Z2N3JJeHhibE9WMFBOQUQ2MFdlZFJTcUt0SDhLVmxjbFZNVHVSeDNS?=
 =?utf-8?B?VXV4NmFWM1Qxb0c5bk0wSW9OdWlUeE5sTzJBc0ZFR1czbnorTG1VcmZCZlZY?=
 =?utf-8?B?cTlrZHoxOUk1eHBUQ3UrSkNZbHJZR2M4THhKNmRsbnZuZnFJK2x1ODM4WVJy?=
 =?utf-8?B?T1ZLNmlMSmg0Z3N1bGRrVVBtbFBmNm1iTE1HZGpWbkpZR2Z4NllPNzF5Wktj?=
 =?utf-8?B?SDhsTC9mRkhkVkxZcGVEci9DdHNvcFhxdVFCOUhqR2czbnJRYXI3Yk1rZ0h4?=
 =?utf-8?B?Wk9wdkNUME00NCsxM0R6NHd0VkV1S1luL2JNYTdXUmV1M29LaGFiaWRReHVR?=
 =?utf-8?B?OXl1THpXTjZqNysrTGtLUFozanBxeUxGL1VGZ1l2Q3BlZko5a3pONHk2cTFR?=
 =?utf-8?B?cUg5WlpJK1NkanBSK2JXTnNjU21WMmMrYlIxb3RDVHNOeFRKMlFReXJEQWE1?=
 =?utf-8?B?THJxaVA0cVFqNTN1RHVrbWRKb1dGVFZQcHk4QlNRV1dtSmhveFpaQkJISEtv?=
 =?utf-8?B?b3pRTnl1VmswbDRlWXREVlNTUDNjaDVCUWkvS3ZzN09nVVMzK00rcHRBbS9Y?=
 =?utf-8?B?WVdFQTg1Sk41UVJ2aXU5MytPVVR3ZmFmS1ZFTkFEYVUxMkJGS1FBZmhWUE42?=
 =?utf-8?B?cDhQSjdQUkRxSDhGSVBTWVQzMk9pK3N6L29iNDJFVVA0NFMvR2pDQWwwdEJU?=
 =?utf-8?B?UDBtalc3TTNrTlV4NTlLSkpjTndDMWZvVFdGTHo1dTRvZ2pSbFo3TUdNMVRl?=
 =?utf-8?B?S0g2dlFhV3VLYzNIYzZycHYrL3JnZDZ4L25tZE9MOUdEK1VIbVRkQnJnLzZY?=
 =?utf-8?B?MVp4aW5hd3d2UlplRjZ5aldxMENtckwza0pobTNNaG8rUkdyTEEvOWJOVXRH?=
 =?utf-8?B?Q1B3NC90MWk4cjA2ZDIxbzByS0tFZkdHQ2RLQ3RIMWxITm01eklGWWNiTy8x?=
 =?utf-8?B?N3JhTVltalgycUJockFpZXFJQlZGeEMzbzFiQTZlWkZjbjEwMXgrQXlIUStC?=
 =?utf-8?B?RmRLY2pUY0F5WFN6OVNTVXFKc3dQTGdCb2Q5MGVZZytmK2NSaEE2V1lRcWZG?=
 =?utf-8?B?SXJQbis5WllyNk53c003WEs0clU0dlZSSGdZNjFzVjRIMTdURS9SRGxSVUJ1?=
 =?utf-8?B?eHpXYmZscVo1K0NFdkp6L1RPT2FGYWZLMlJ4ZGQ4MTV6NlNnakt4YTNVUlFv?=
 =?utf-8?B?V0Y2cEEvM1I1enFBb2ZvQjNIcnhLcTVMMitlWWtxZEdBZFVONDVCRXNncG1X?=
 =?utf-8?B?Tk5qOTlDdWJRVUU2L0ZlRnc0em03QVE5bXJZdVBCeFhFQkFnajBjWXorTHVD?=
 =?utf-8?B?dEU2T2FiYktZYjZhSEt3WURGM05FaGRwQ1cxcXZQZyt1SGdoOGV3M1F3T1l4?=
 =?utf-8?B?VEhCU0w1azlVTEpNSDk0VFpFcG9vbTlBWXpCV0QvZ05zUEpLSGhXanZtcXNw?=
 =?utf-8?B?ZWd4VWtsY1ZrVExwZFR3ekk1RmxwTjA3N3NQVE1sSGtoMm8xZWkrU0Fkb3E4?=
 =?utf-8?Q?X2X68kG48DIV+LT1Dg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVNIUUlJWjRYbDdyZlhQSjk4YU5wY0RPZ2JEaGxaL1JJZmxYa2JKaWJ1WHRo?=
 =?utf-8?B?clhVbDFVd3k4OWhHbDJ4dGw5Y3NoNnVueWVzWGNUb0E2MDU0NHZiQzhqQ0pM?=
 =?utf-8?B?RWIreUZXUklZQnVKalUrSGdGVDh0ZjNsTFZsRHhUUHYwVmlZakhIMUxJL2U0?=
 =?utf-8?B?ZDgwMWdpaHcwZ2F1ZWRqTlFsUHlHbDRIanZQV3hYR2NMd3lUdk0zMXQ1MXVS?=
 =?utf-8?B?aEp1V0ZLYWtkdDBDVEQ4d295UXJNWVVHd2NIdUJmSCs2TVZkalJSZEJBWlQ0?=
 =?utf-8?B?U3lvdVBrVzhLcTRxQ3FSTzRhNEw5QkxTZVZRS1djQ0RNNGRMWjRxTWhrUnhw?=
 =?utf-8?B?dXNDRHRldEc4blF3RWRsVkFsUmtCWjZwbkdZcHRST2pRQ3ZreFdicGkyM3dI?=
 =?utf-8?B?WGZyZEl3aWd6ZDJaRjFsZWpLMXZpU3lpdUIzc3cyalFCZi9rT2VPRnN6TnZH?=
 =?utf-8?B?VFBhdkdldlV5MUdVUUpycjBPTWQwcVVjTVgyOGxIZ2JERy96dXFFaFRrT2JK?=
 =?utf-8?B?NXRNYlBSbWhrUzBKK3dmUzErRXQrWmJBTmJ1dGR0R0hLSHMyMnRYa1FPN3Bw?=
 =?utf-8?B?b2RnK05KNk1DbHVpT2NXSEF4UE5VbFI1QitDQ2psdGZqNnVsMFpnZnQrdmhh?=
 =?utf-8?B?OEYyVmttZEgrbE9vNGVaWlhGK0hzb0QzU3Z2U0VoNzY4blN5U1JFVkI2RkFu?=
 =?utf-8?B?dFg1aUVUdGJyM1FFSTlJUFdYS2N0VG9QWnVkcXlZaWFQWG1iN3hISGxHb2hl?=
 =?utf-8?B?OHhGVUlNTGNLK09ackVEQ1IvUjRHQ1hkQVo1dENndTdlUWRpSDN0ckh6N2p1?=
 =?utf-8?B?Rm5xYmEvcGJJeURRV2pBZnhOdDVHZktyNEM5RG5VT2JzK1RvcVFJWHFjdVhj?=
 =?utf-8?B?d2tLZ2RMcEFaUWd0KzR4bFpBc242V1ZaTGM0M3RrRjFSUURQMXZuUGVDaklZ?=
 =?utf-8?B?T2JZLy9LZWFDNFdXQnJBejRiVVpLNG4xY3Y4Z1ZrWFh2T1k4YmZUYUUzRXdY?=
 =?utf-8?B?dHh4VjVLVlZMR25YbEZqU2dXZnZYYWt5NmJEUEhqb2ZCSFFvL2cySUFjNGt3?=
 =?utf-8?B?RG9YNUZQRU9na081MWxWdnV5YWF6RjVCVTJFUGlSZml4VzZUNS82WmFoWkl3?=
 =?utf-8?B?RktyMnlHaDdaenRnMmNTcVBzaW53QUJzbi9xV1l4RFExbFlXRkRPSjU5SU1K?=
 =?utf-8?B?aDNMZTRkM1ExcjU5TzJMMXdaREc3THFiWDQwQnlYZGZoYTBWTGZXOGFlbndi?=
 =?utf-8?B?SmxNa1drcUs4T1Era21pUUNpZ1BIVlFxSEdmaWIyWEcwTElUMTViVDRLVVJ2?=
 =?utf-8?B?cEYwelU3RnNpZ3ExdHlIYVY1MzVXakc0L3kzVHlaU3E5dVV4TDRnTThDdUtK?=
 =?utf-8?B?K0VjK085MGNSWlppZDVrYjlRVFpLcWh3TWFZMWp3WHR4dUlCNmFGTitiOGhx?=
 =?utf-8?B?NmpJczlKUHVua29IaGFvQmtoM1FsckdCdkZydXFMajN1TGlPOVVYamd5TkFP?=
 =?utf-8?B?aCthM211VjMxVEY2aTh1Z3RNZ2ZDdEVJSDdDbkdRREsvSXEwbDVKVGZ5WEFK?=
 =?utf-8?B?elIyVERaM0FRL3dSYi9wek1OZUswN0ZiQWdkbG9jNFliMUNDRVVMay9jZHhR?=
 =?utf-8?B?MTFaZU9XWHMzVG8zQU5CVEsvRFU2Q3g1NDI5YSt0QkxJeGQvb0pWa2VNMFdE?=
 =?utf-8?B?YkFJbnJDZFBiT0F1VEJZbmNNMnEwR3RTTlM2R1A4U0UzTGZ5WDhVZzlvVXFz?=
 =?utf-8?B?N2hOR0liazdGdStlTkRYcmpVM3ZxdHFpdWJZOXhzUXBYbVMzQXFXVHh6emxU?=
 =?utf-8?B?NTNCWnJWWmNQS3B0bGsxdStFMlQrS0JFdCtYZ1ozRWZyZ1ZaY04xUU1qZUpr?=
 =?utf-8?B?Lyt1T1pCSllwbktmci90K2I2T3JBYy9QNnhDTDVrSDBDWkFRUHRHOC8wN0Fv?=
 =?utf-8?B?MFdlRU11S0N6RUdoTDJTaTRwTHhVZjBnTW1aWVpteUFuZStuSEVJbnhoOUdL?=
 =?utf-8?B?S3VzSkltZVp6QUkzM1FXSzc0UUhIK0JGUGF0dzc3NitQbDZ1NUxkMDRwanNm?=
 =?utf-8?B?MC9rK0dVV0lKYkI4aGNVeitxNGFVMnRnTDdKRnpBRVZCOXJlM0kwZ2ZYc2ph?=
 =?utf-8?B?YVRCdzFYNjFQeXNCeDJjLzRaK1V4YXVybUlkRXYzMUQwR2Z1SDFGMTIxTzhn?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270ced51-826d-4345-17ad-08dc966c728c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 05:46:10.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZYlVjHEnpmTiW0nXL4LpN60xJxRwbDwX9BykEdsVfDAdwuqYInm6F2FnX1DBzF9xlMWtReN0mLqIBQcBjsVoyKztakyNijNqyhNn7V+lbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-Proofpoint-GUID: isLDdBXiJJVKelRH5786Z3-JmJElwvww
X-Proofpoint-ORIG-GUID: hn9vOs22RBJUQ-DnnyB0C5GZv3RCDT6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=842 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406270042
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jun 2024 05:46:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16379

Hi RP and Christopher,

On 6/20/24 20:44, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> * Test info
>    bitbake-selftest works well
>    bitbake world works well with the shallow tarballs

Do you have any comments on the patches, please?

// Robert

> 
> // Robert
> 
> The following changes since commit 5d88faa0f35f0205c1475893d8589d1e6533dcc0:
> 
>    bitbake: siggen: catch FileNotFoundError everywhere and ConnectionError also in get_unihashes (2024-06-18 08:45:22 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/robertlinux/yocto rbt/shallow
>    https://github.com/robertlinux/yocto/tree/rbt/shallow
> 
> Robert Yang (2):
>    fetch2/git: Use git shallow fetch to implement clone_shallow_local()
>    bitbake: tests/fetch: Update GitShallowTest for clone_shallow_local()
> 
>   bitbake/lib/bb/fetch2/git.py  | 71 ++++++++++++++++++++++-------------
>   bitbake/lib/bb/tests/fetch.py | 13 ++++---
>   2 files changed, 53 insertions(+), 31 deletions(-)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16368): https://lists.openembedded.org/g/bitbake-devel/message/16368
> Mute This Topic: https://lists.openembedded.org/mt/106779045/7304958
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

