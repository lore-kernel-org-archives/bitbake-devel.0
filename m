Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5393BC3DA49
	for <webhook@archiver.kernel.org>; Sun, 14 Jul 2024 11:08:28 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.14414.1720955305181171506
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Jul 2024 04:08:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=79255a1817=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46EApq81024103
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 04:08:24 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40bs3frm6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 04:08:24 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46EB8Osp014087
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 04:08:24 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40bs3frm6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 04:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy01LaMDN2on0H7YrvNo8BFvigZTFBUKyvs1MS7n1UtYfD3b5SIYGX3i/7QrbW/6NLrhYAMAfmW+w6VH14bTgetIRTVopd2IAaWG1CXeKA7Ij8UPND0Gxpz65979m5x7TodZPOGqT6Y/yqJd4qcjBCDCQNNTa/Vu4AjfGHawLi7tAq8zpRIVwPpc5W+NfEL6XrSz2c2xJVeoSna2CxNc4Ww/DAjwvSi45QnXd7XMpa3Q9/uUVy6KpksZ3JcK+nEV6PT96aV8EOBcQ/dXU58RMjUHWbJANO/TLu7sB5gRGu+0fhz8ublbGWIyU692QyscAQFoJbxOR5bQeL1w5z282w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsBTkxVnh6hFr1xNdq29SJ1z7ISHZa32avTQHVHVPUQ=;
 b=PsNWc7MJXQL3YuCQg+7PixSPDn6MUNECSebb7HmmgrOKndPyklc4DoIokq3OObTl9hN+1+/n0aYcyo0eE6lqT1XKlL3H20ua4ZFRB8q9T6DvDWAd7CeGlr4W18KLPyWUa+UtUWGDDoTJHIhSrTk+zfUkuNM7FHAev+hUi0H5yqMXzkp+UYZmfe9EwifjECEAAiHjX5pL0y+BvoIZkG0QhA9mBIOrlnCrv7n2dhWLq+7J8mtTE7ixlfvVOc/2hUnbuK6SnXBfwLYstodrMIWrEQ2lM8zmFaI8hY6AiFCn016vjyBDyH08SV/nQhfR2GiqroJPnDuaEzkkF/oWWu3/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Sun, 14 Jul
 2024 11:08:21 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%7]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 11:08:20 +0000
Message-ID: <b6ef29f5-277c-4df6-8f1f-a48274600cd7@windriver.com>
Date: Sun, 14 Jul 2024 19:08:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 0/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
To: bitbake-devel@lists.openembedded.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <cover.1719033434.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 063be95f-6a77-4c40-0653-08dca3f54523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|4022899009|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aEIvQm5aSDJETmtuWlpOWDYydHd5bExaVlllZmlZaTY3blpQSU9lMTIzdGND?=
 =?utf-8?B?WHFBQlZpMUFaU1l0M2tqck5FZGR3ZEVaR3o1ck5tVEtFV1A4MFB0Wk1FZWd1?=
 =?utf-8?B?S2pieGUvMm9qd3c0djZZMjdrS2JudXJVbjZtMTNFeGdrSmNKcUlBbm9QdE9P?=
 =?utf-8?B?NjU2TWJNWG41bXRnK3kwdkFoUzFFb24yYjhaSU5TcEZBcHB3b2VXckZnNllK?=
 =?utf-8?B?Z1E3UTg1ZE4wcTc3NE1BMnhQNUROaksyY1AyV25BM2xEdW12NUIyM1NEejZO?=
 =?utf-8?B?aDZVREdWRlB4TlNYdmwybWhhci9nZ0FQcEs5WWRkSlBvSTB1cS9MUnlHaHpC?=
 =?utf-8?B?eUo3Q1FhNTJ4RVVTS2FCd0VMWFpocXdGUHE0eU5XeGhGWnl1dHNrdWRJV3Vm?=
 =?utf-8?B?cjVvekFtUkYrQ0VqVFlTQTFXRE9DT0RpSzZTY2NDRURBTHNSZVFXdjdzYVVw?=
 =?utf-8?B?WVBLMUVDRDBQMXlja2x1RVByUmdrWms1RTIwaTlmR2ZsOVNlclZ5SmZFQkkx?=
 =?utf-8?B?d2tNamNZQkJKeU4ybTF1dXJPYVA3RVlkS1RzTjEvdTc4Y2xpLzEraDRvbWcz?=
 =?utf-8?B?U0JYb05ZQVlsenNLUlN4a2FGaEdHTXk2dm5QZW9JYU9CSE9hb1BvVTdmRldN?=
 =?utf-8?B?QzMvV3dUSGRSTjNyMkpBblBLdnBRQXZHeG5vY2drOG9nUUpNWXpsKzF0TkZC?=
 =?utf-8?B?ZkRtSWlsemRTUk1uN0FSQkNjNEhFcUl6T1ZKT0NKaE1FNVZiN0RzVXp3WXRv?=
 =?utf-8?B?dVdzZFVWZzBZTFpUMWJjT3FqemozMlJRNWM0WHhCZisrM2tMeGRrcmNxOTJF?=
 =?utf-8?B?NDk4VHJiTHdvRkdqaVNwS0p3a0g0UXNBTWJkYTFRZnp1bS9BRk81eU9ySFBy?=
 =?utf-8?B?SHdDMmg5V1lSaGhzTE1ZRVJacmhWZCswQlpSaWJyUVZGcFVGeXVBOVA5bFFL?=
 =?utf-8?B?VUI2UFVkckUwRCszUkxnRWlJVGNSUnVTMVNkVURjLzJyWlRCOUhFM05UYU81?=
 =?utf-8?B?VEdvOFVMTEE4cVBnbk9ycUNQY283dG1JWDd1UkNlVTlYQ1Y2cW9BMEVsQVVv?=
 =?utf-8?B?WUxqZmlESG90L2J3RG9MRkFSbldmLzBHNXRaSVdBSkRMc043TWRZN0xaWFVo?=
 =?utf-8?B?U1lmRW0vNEhOVVV4M2FIRDRzR3J1M2xXS0VPL3RjTTRNSFhZLy9CUEk3YVdJ?=
 =?utf-8?B?c3lWWDFWUFhwWXFPUG9XSUVBVDc3ZEdzSXJwWGdRV1czWDM2Wlg3aFpJcnQ5?=
 =?utf-8?B?TVVzSzhpS0srd0Rpc25lUmRNN0l1MTBScXBZMW1QSHRmdFA0TjNpcktOcWN2?=
 =?utf-8?B?ZW0ya0g4QW1SNXZ6VnJvT3k4NS8xRmNkd1JuVlhzMkZxZGJsMnRVMW9sMW1E?=
 =?utf-8?B?d051Q3liYmZUb2tLSUhJZFlUYTJkQTR2TnE0MC9FUzZLaGFNUUM2ZTVialR6?=
 =?utf-8?B?UkViUG1JM1BVUGNBSUpXS3cxMzZqUURqU1hZRDRUT05QbzJuNjlENnA1a1Vp?=
 =?utf-8?B?K1BGcW01M1l6bXJwa0pYSmNaUmRJeXVYbDl3N1lZUTlrd29maWNrV1R4VXpx?=
 =?utf-8?B?SXd2bk5qUW1sWW81QytwQXlYOUUvVll6RHZxVnFRQkdMWkEyeEwzbkZ1TEg3?=
 =?utf-8?B?eWZvOVRJdGQ4Rm9rNWJjTEVBaUZyRTJXVndtejhJcHNOTWRJNWdFSk5uWHJG?=
 =?utf-8?B?UWYyazlzaUUvZjRIUDZyZk1mbTdGUnB1cTQrallncE1QTlpZWWlmN1NJTUJD?=
 =?utf-8?Q?mNzMnNbQxw5xWOvGR0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eExiWkNCcU93SEhGV1lWYituZmNhTUFuSFpueXE5Nkh1a3ROK3h2a3lFRlo4?=
 =?utf-8?B?VFBEeUFKdThRZjZyMWNYd1dDL1FCZ0xmWkhNMEZzRnFLSVpwcVpKRlA1LzNo?=
 =?utf-8?B?VG9aZ2hxRmRyMU5nWW5OL2NWaGZUN1BCNVN4VURESS82TEpGWDdQSHR2MDFW?=
 =?utf-8?B?cWRpaUtiUE4xRjFadTJ0Nm9hT2pmTzVaaWFmbGlISUpsanVkM2Y2V3hNVHZI?=
 =?utf-8?B?L0dyTzJYU0NkMGZ5ZWN3aXdHVVRqWFBLVHhWVll0dm1BTmszMjZvVjY3RlF3?=
 =?utf-8?B?akxjZG1FamNtUFFqVnowZnk3ZzgxS0lJcnZRMkZGTHdTazFmZnBZTVpIOUJ3?=
 =?utf-8?B?N0lwZURqVE9PWitrZXo0aEdZMmtGMEZ3RlR4RXRYNTE0UTYyb0NlRTdYeFMy?=
 =?utf-8?B?amRaOEwwRzFaTHlKRGVNaDFyTnd2R2RsVUVlK0cvY0NwdzJidUxoWnhZbm9Z?=
 =?utf-8?B?K1RMek9UUTJVZStwN3NyWHh4OHg0V1Vpb0JFYURsTjhQZmZOOE1acmlBVmMy?=
 =?utf-8?B?RTZKZFR6ampRb1g1Qmk3QVF0NnVpdTRydXA3WVM3Vk8vUE9XcHZlQW56RUlG?=
 =?utf-8?B?TUF2STRqY3VkREFCNXNraWFtL2ZkQjNjSkVSaVQrRlFuMWxOYXNmT0ZTTi9a?=
 =?utf-8?B?ZG4rS2hCUU4wbzg1Q0JEUDhMYkNGR2QyNHZCVW1veUNITE5qQVUxWEV1RHhV?=
 =?utf-8?B?K3JVcWFPeVBpSlFoYUJnNWFESVU0cHJwaXRHMHEvVFlYUHY3T1dia1VQSk50?=
 =?utf-8?B?a2IvNVBrRStCY3MyNXhDT1JCM1FmSFgvRVJGTGVHWmI5ZHNYQjZVbmwwWVpa?=
 =?utf-8?B?OE8yWGpZWW80VGE5WDhKb0gzUExxTGRGckpXV3dKd2ZMa0NZemtnazFKL2c0?=
 =?utf-8?B?azg1Qno3VDlPSlI5OW94aXU0UlJ0b281WFNyZmNQcUxNVzV6SUNMakFJdEJk?=
 =?utf-8?B?bDJFeVFJcTNlRFlaSC9aT1k4MS9Ycmh3OWdOYUdlNU54dU1Cb0oyM2lSamw0?=
 =?utf-8?B?NGg1WTVTZ3I0NDJSakhjVllWdU9jazFJRDZrQjFBWWloNWxMNDBTeEl5bDVU?=
 =?utf-8?B?VjNqYjVpSTNwYjB6ZXRESEZTd0pKWU0vSDlhTTJaN3Q2eGZNYlNuK3kzSDFO?=
 =?utf-8?B?OVBBdTdwZmhuOUtRTE1ZNlE5K250Z1FER0NkbGo0cW1tZFNBN24xSm1QL3gw?=
 =?utf-8?B?bk82M01ZOEtER1N4bjYvQWJXMUVUa0ljRzBVYnBhMExFaitBcUpXQ2dDZ3FW?=
 =?utf-8?B?OGtKdTYyekwvTlVRVUwwRkhidE1uMTZSWlYrUFROb0JlQzc3a1o1MUVMTmk5?=
 =?utf-8?B?dGlYUFFVYkJ4UXpZVWRhOHM2TmY1Y0tnTFRWcDEvTGZlZDBGeHcyYXUyR3B6?=
 =?utf-8?B?d2xqOHZqWWpTYWZmYVpXbWJyZDRXMDVZdTFTUTRxOHpFRXJwOE9WOWNSZ3Fh?=
 =?utf-8?B?ZUVUaGc4ZjJXS1kvcEVsY0orR1VzTnIzQ3F2ZlFGZmNHU3M1bFVsRzNUZU9T?=
 =?utf-8?B?aTljVUl4aTJsa2xLcVgrckxsQUp1VlZzSlNPY1ErR3FkOTk4VU9DNjNCc0p2?=
 =?utf-8?B?Ri9hSWdKZmt1eVJvQTNKbVRiM0NqVXZmZk1hYndLU2NnOFplWXQzSE43N2k4?=
 =?utf-8?B?TFVFeThENlpPVisxNVhoZ0l0V1EzWVhFTEJOaFNvZzNCK3VkdVhQejVwY2ZQ?=
 =?utf-8?B?U2piUWxlZjVtN0RFTllhZU91SEpoQTJsUzVaTG5XVys3aWRkR2hCb1Z2eENW?=
 =?utf-8?B?UFlVeTM2OXNCZjBJeGlTNFRxelgwRGQwdzhWa0dzODAyMXlkYXRzUC9pMVpM?=
 =?utf-8?B?ZXB1ZU81ekNkVlJLbzdjTUQ5U1M0dTVkVnJTN01lMlhTOEJlNGhDQ05ZNFdP?=
 =?utf-8?B?aUNSb29jcHZkT3gxNll1NGk5UW9hd0FndXgvakF2NVVLaWtIVW4yd09iVXNB?=
 =?utf-8?B?dXNOS1ZwZVNJZFp6WUNwWXh3NmV5V3pDeHlqRGZ4bml2ekUxTERpaGZHVFpT?=
 =?utf-8?B?Mng5MFVlVjNxR1l3OXh6MWF4bWo2bkNNR0tjblNZWUZVa29wOXRqa1pYMUE1?=
 =?utf-8?B?R1FpWlBpRHQ4YVkwazNjU1c5T1RvK1ZLdVJYcTIwUmROditsZ0xncFU1ZTZF?=
 =?utf-8?B?bzVMU1djWGRoZGZRQlJjaVozRFNPOXFvQ1dqa0x3MVZaNC9Pdm8vYjQ1STR1?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063be95f-6a77-4c40-0653-08dca3f54523
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 11:08:20.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTXwLPJ0lzLvuhTxqpRixyvRYxAHjdJu4curIIoKGNpKg8pzHPKUXt7d/ieIZX6cmGJwhJXzZrdW6Fq2v6HImRof/4F8edGXRQC6tPE9lTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-Proofpoint-GUID: pP9GL_Gsj4k1PwXoF0llm7ep5oIpTO2P
X-Proofpoint-ORIG-GUID: gs8e-dJrSkaHvtuL4uXBWzqVsL0UAuc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407140089
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 11:08:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16417

Hello,

Any comments on this patch, please?

// Robert

On 6/22/24 13:20, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> * Test info
>    - bitbake world --runall=fetch works well when BB_GENERATE_MIRROR_TARBALLS
>      and BB_GIT_SHALLOW are enabled or disabled
> 
>    - bitbake-selftest works well
> 
> // Robert
> 
> The following changes since commit 5d88faa0f35f0205c1475893d8589d1e6533dcc0:
> 
>    bitbake: siggen: catch FileNotFoundError everywhere and ConnectionError also in get_unihashes (2024-06-18 08:45:22 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/robertlinux/yocto rbt/fetch_git
>    https://github.com/robertlinux/yocto/tree/rbt/fetch_git
> 
> Robert Yang (1):
>    fetch2/git: Use basename for gitsrcname when ud.proto is file
> 
>   bitbake/lib/bb/fetch2/git.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16371): https://lists.openembedded.org/g/bitbake-devel/message/16371
> Mute This Topic: https://lists.openembedded.org/mt/106812685/7304958
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

