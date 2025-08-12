Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA6C87FCB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 10:20:33 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.70423.1754994024962263894
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Aug 2025 03:20:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0319aaa3f0=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57C4lBUF268657
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 03:20:24 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48fvk20atb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 03:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkcfuzafwI0x3fufwwk3F0cXqfpbwWy5KXlhcyxjLktlDBODVu8tz9zwCu4OmLwZByAKX+Tr2T5HmkEBim+FLBfGQYssaR/f7uOOcmL38nMrGz+evrPkrb51qBLPCPzyyv8fv+iQcQsGd72iRGT64hT/0AwC/uZAjSKk42EWJpM2xWdruXC+7M7pQ75W3i9lH2pvjkdyNu3G/XfZgCYmoVbpTstNftLz3h9Ey/sSyeBdTmSKkqQeOdaJNj5CclVCGz/Sord5xobqyDjy32TzPhS78o/xhYsiELcRFjLQuyt6MtKPC7A9Urq4sizJf/V9KXFT/dstDmTleJcNq3DrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3LBCfgW1dVK5NgzNCGvT/LEPhfmiG8Rmf39JyY+wbQ=;
 b=tgIAdGYGSUt9SUaopI2A1adpGcl/8RlctYsWQ6klcdTQwUWnDLJAduPFLSPDMI0+l0U4FtWJGGH+c3Qwh+dBALbMpys7U7ZIG04qzhAXseVN8sFw1rdAWR6LuJwbFBqCD+XHRqfmskgCAIoqpZj+vu2cWKkAI4k3uzy52yvIxQlBQFQK3XxZ/64SZRfKrW9NO3jb/mi1j5iyuVrCeD6BkKVz9y6x4WW4fe0ZTp4eOHiw98MrodITAQgdwD7FtLzZez0WWAM9MsnVKSYjGI7y6zaORhmaJ72ldF4vEXlQV7CDyDIYu8IF3Aeytv5rFb9peyPmTV954KHYJP0CfduCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by PH0PR11MB5110.namprd11.prod.outlook.com (2603:10b6:510:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 10:20:21 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 10:20:21 +0000
Message-ID: <b5583234-df87-48fb-8275-2d975e8bf7fe@windriver.com>
Date: Tue, 12 Aug 2025 18:20:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 1/1] fetch2: try_mirror_url(): Skip
 invalid local url
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <cover.1754985648.git.liezhi.yang@windriver.com>
 <fc732bac7b8fc7535e9cbacac05d8b6e118d8e73.1754985648.git.liezhi.yang@windriver.com>
 <2f5167e9cbc03b7235db9268d4a3a9292c773f8a.camel@linuxfoundation.org>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <2f5167e9cbc03b7235db9268d4a3a9292c773f8a.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|PH0PR11MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c8e603-de7e-4f1a-918f-08ddd989d790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MmNmbmhUS1BadisrSytuSHYyMWtoZ2NIbUszcnRlTklyT05qMzVMQXJxVmFn?=
 =?utf-8?B?ODBXS3p5Z0I1cS9Lak5TYXRkOWN2UkZuK3Y5dmFUazJaeGp1U1ZJUWFqZVlP?=
 =?utf-8?B?R2gxWkJwdkM0RDRwRUhHa2pLdHc2UXZKKzl3ckhlOTNDVE16QzVpT21hbzM2?=
 =?utf-8?B?TVNCNU5Fd251UTUzL2xZd285SmVzbWV1RXJGOUlhdGJtK2FrbEw3emw1WnI2?=
 =?utf-8?B?bzVvRVp3Q0JNSTQ5OXFzeEhPZkhQYXFlKytvbk5OYzZlWEZ1eDg0cHBBN1FY?=
 =?utf-8?B?WVUwbUg4ZlJKVzFuRFRtaHJKUzJSOW02L05qakNXMXo2dWhkaGlTeFRkc2Jh?=
 =?utf-8?B?Rzd0OC95S2RsRDB0dlkzNk5aanNDVjBUNGZTcnMzbnFSSkFsNy9nMnI3YUxV?=
 =?utf-8?B?dXFKcExTRFhvejFGazdKQ0IrekI0ZlcxalB1blhETHROZmhrVGxLQldUMzhC?=
 =?utf-8?B?WkNPSDE2NHRJM1RXRWt3RG9GdjJlMFRmV2FZZzF1WUlvc21ydytCYzVVZnlF?=
 =?utf-8?B?QWVCV3RsSDYvZ3NjaFpOV3F1aFYrVWNEbUNMbXYxdWRocW9zL053RWVHdFJi?=
 =?utf-8?B?RG5UcmJnc1M0aENoN0lzL0hhUFJZTnhHbVpadXRoZjBTbnFxTHFaQ3JuaGpD?=
 =?utf-8?B?Ynd2VStMUHZaTm1ZVEhXRzFHZmlRUHZZUUpvc1M2cENjWXkraGdyMlF1Qkhn?=
 =?utf-8?B?S004YTBtNW9MUzhHTmMwQnFVbHBncnpvOGRwajJhdGRWeVd1end0Q2ZqcUtL?=
 =?utf-8?B?dHFsMkt5SWYyY3I1M3Z2NjBlRkd0ZGliNldVSTJGdmpQUTU3eFBpd2w0ZGk5?=
 =?utf-8?B?YVpLUUFHUDdXdEl1UVVPV0docGtsbjhicHFHTk4xYitmUHJGTzBnY1YzdkNi?=
 =?utf-8?B?bDM3NWhzRDJHR0p1NktrUG9KUnlHQ2NxY0RxSDVCZnVnMlI3Kzd4SWJKOTla?=
 =?utf-8?B?VHdZNEVCclc0UjBUaWVzS3RKaHdnRjVHQjB4NHgvRmdOWWs4aU1uYmlBanZH?=
 =?utf-8?B?UkIxVmVPOXc3SW5WS1lVZ3hYZDRmVzlyQzBoS0lNeEVWWnNkd25XMmZTSnRY?=
 =?utf-8?B?MmhmNERXVFFWOHNJQnYzSzd6WXpKcys3bmI4cG9SU2RDeFYzc3gva3ZCL2ZR?=
 =?utf-8?B?THRsL1JEdjBsZzIyREZlVFl6M1RvTm0rdFV0elF1aXBHNzVPTFVrY0s3SUgx?=
 =?utf-8?B?R052R0JBaGFoZDlUL2w2RmlKM1RCZWJUSWFndnpJaDlNdnUyaHNvVWg0bFcr?=
 =?utf-8?B?UGEreVJrMWkvTlZwUUVZNm13dHRzWXJWRUdtTEtSdWxkaDZ4MTF4WmEvZlBI?=
 =?utf-8?B?c01XNkh2c1ZDQUcrZGJiUHVQazN4T2FkK203ZStRS0xuclZldXBYaFdwUDFi?=
 =?utf-8?B?OXlwZ2l4S3RUbVJPUldnZS9tU2RoeS9iSnN0R0hFalRHS3NwVitxQjVaRDcx?=
 =?utf-8?B?c0tuS29YT0dNdXppYWhnYXJjb1FoWDdudXJPTUI3ZDVtRWJkU3plTFhZUHhD?=
 =?utf-8?B?MStRS2F5OVBHMnhReEJRRU5Sc2JSNHpRRXBQRlBsVDdCSmMwYzVTWE9FUjdr?=
 =?utf-8?B?a3U2ZWs2aUlPTFZ6bkNIWWZwZ3F5aW5WcUFGdVJ1aDdmeEgxSzhQTlpSdlAv?=
 =?utf-8?B?a2lmL2xadUtESHVsUTg1YW51UE5yNHNlUzJ6clVSUG8yVmxSTEFPN3RTOHha?=
 =?utf-8?B?bm9WTk9vb2NZZWRHNzlITTdKaUxZdCswK2ZvdWlGaFBXaGRWKzdhalgxNW1a?=
 =?utf-8?B?Q0x6SjNzUmVNdUJqelZSSjVwbWNiWGlPcHhXaWU4L3Y2aFZIU1BGYUhlTDJp?=
 =?utf-8?B?TTFaM2VjTldnS0x0VUZwOXBJYlhiNnZYejI5WGRJR0pQVFp2M2lUenk2Mmxz?=
 =?utf-8?B?QThkUjRJVlBYdzZReFVXNlljWjY1ZmU3WDFaWDZVS282a2pRN3Mxbys1dEY4?=
 =?utf-8?Q?Qs5eoCi/Z68=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2JWdEJiS3RlYlh1WDJPZ3QxR3RNWFN5L3RvUlhnK2dyUllHdUFSUXJNTCtn?=
 =?utf-8?B?UUs3bU9oL2dvK0gvbGErTjBteVVtcko0d1p0RlRhYjJzR3BpcVYyVmlYdTNh?=
 =?utf-8?B?WW5BVnNUbUhiMHZ4aW94ZnI0b0pWNmxBbVZrU0xoMlg4QmNBVHBzTHNmL3h4?=
 =?utf-8?B?ZjhWQUk3Q1p4elVFVy9UZGtMaHNCZE1DbVp4VHpYdk1DdTlOUGE2eHlLdUh5?=
 =?utf-8?B?RVBraFkwRzQ4Nms4aFp5SXczc2ZaemN6LytFbjdmWkxDSlFXZ3MzRno1eGlU?=
 =?utf-8?B?Y1BRMkgrRzFJNWxObSt3bEUxd2VSSm9qSnI5NXMwdFhBd3dsYmNUMnc4bEVv?=
 =?utf-8?B?V1hHaUMzZDYrRlZLYU00SmJVMTFZQTRESGpZdysydEhvTmFUNUNIQU5YQ0dK?=
 =?utf-8?B?Si9uMmNHbFFOSHVRSmZUTFJac1hYUkRzZlZ4elZYVlAxeFhtTVNjdjZhNVk0?=
 =?utf-8?B?eVRuN0phYnBaYXVhMHM3Zm4xR2FzcHFMNFdrNVZQNnpUUDBDeDVUa3ZQdGtL?=
 =?utf-8?B?bzlSQiswSWlmSm1mQXRWSWt0YzdsaURzamhKTVZGWGozV3VtdGhZamJOeHF5?=
 =?utf-8?B?VjFNZ3lRVDVFdXdyV1MyYzRTV1h3RmNmMXdnQnpMVkM4RWM2MW1jamZpaEJw?=
 =?utf-8?B?WlVseFZGRGo1WXhodlpCQWl0Q3JMRGRZUzJldnpvNjRIeDAzWXpFQ0JhbWxI?=
 =?utf-8?B?UFNqZE1KZGYxNTZYK1lwUDlFd2JJRjVidDlPNWVGYkNJVjBnZnpIWnpobXZJ?=
 =?utf-8?B?TFV3VE9jT1Y0SFcwSUN3d0t0OGZkM281Yys5MFVsUGhYeHh3bXdmNlhYd0o4?=
 =?utf-8?B?RVEvNzFJbUxvODNHbDA2OGpwTkVPTnZFYVRVc2pPZ0JOZEFaZWl4QjJPeEd2?=
 =?utf-8?B?TWxwbUhuNDZPSG9zd01jQlZzV05Ob2g3UmhZK0xPbFMzM2J1WjluQVRCOG5E?=
 =?utf-8?B?RDhjRUsxckVJTHZyUFcxVlcwS0VvcmtOQTdyemRKTndGdVJFa01FaTUwRlNp?=
 =?utf-8?B?VDZNclNUNlN6QkpFeTFBQnd0S1ltN1BFR0t0Qkptemt1eTIrYUQ2Ry9kWVhv?=
 =?utf-8?B?aVFLTHB6ZnNXVTRQMEZUdXhub3g0TlpaQXFsclU2KzZibGpnUTVWL0t2dTh0?=
 =?utf-8?B?Yy8vcXloNEJLZVkydSs3c0h3NXJFT3lpZEdNRk5Nb2hManNRODN4TDFmTklT?=
 =?utf-8?B?SEYvTW1KaEl4MU9MUGx0Ly9OZXRuaC9RcW5iY3d4SnFPOXd2R3JzMU9BSlRX?=
 =?utf-8?B?VVltb3djR053Y2ZNVzl2RGRROGs1VTNVaG4xUWdwTVZuZ2o3OUlId0Y4aU9v?=
 =?utf-8?B?Q1llMUZVQjVOejFrUzVkZit5WlFiZ1V1OGVHY2NIYlZQaUhxWUVPQnhFcnp0?=
 =?utf-8?B?S1YrQTRRNkk3SEZWTk8yTitrU3BBS3RBQktQakEydk1FL3JiMTdGTTBHTi9V?=
 =?utf-8?B?cGtOMFpPUnJTeWk3ajAwcytUNDJOWXM3ckkwQm1ZbExYMXhBTDh5M01yYUZs?=
 =?utf-8?B?REtOOW1xcUREZXpTL05kNS95SzYyaElxTVA4RFZQQm5XQ0lKM1daOXBQam5F?=
 =?utf-8?B?YWN2c3BFcUV0Lys4V21SLzNRQTc0bys1a21kdEowMDVlVnNYRkF1MCtwNndt?=
 =?utf-8?B?SlEwNHkyZEVQMFhLVlNDVUdQbVlTa3JTclo3RGNEOEY4WVlVZW5jQlhYbVhL?=
 =?utf-8?B?Y1NRY00xU0NFdFRIY3dQazhDUVpRTzNybStqVlNVOE54eVZFTm82L3dQVHlY?=
 =?utf-8?B?VnloRkxacno3QzZINzB4WTVrWkljMTIrT3ppTEFFQzY5K05EdEJtd01EOHl0?=
 =?utf-8?B?UHZRUDRLOFhqd1FjVDRZcFIrcUduNVU3MERQd0E0Njg5Um45RTA5TE91RU1C?=
 =?utf-8?B?ekpsOExUSXJhandXa01qbk9kUXRxRXcrdVJscDlEQVBHMlFHOVl3OWV6TGtO?=
 =?utf-8?B?ZjlTckhNRHVFdEM2aWNHMnB1QTFCdmVhYWN6d3l5amVwYVZWbVZXTUFhWmZW?=
 =?utf-8?B?VWpKUVorL0FWT3BaTzRHQjI3Sm55MkZYUS9Zd1pSV3BZenI3M1hNTzB2dHlp?=
 =?utf-8?B?Ti9XZTVWV2M1VXM0ZFphWjYwZENTYURwek5SYXoxYUJxK1lmWHNJRnZJK3A4?=
 =?utf-8?B?Z2gyY3A3ZWRveEQ1d3kvQ3ZpNUpWYlNXNFkvVnBoWDVjMjl4SkRjM2RJRkNm?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c8e603-de7e-4f1a-918f-08ddd989d790
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:20:20.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: za6QJtvx4Lv2OR5YTjCnbvF5ReEUddosOjZY1EGGdMoh3qz6y6OHdF99cMphGfMiietFMA+UqPPW1Y0imtzvkzwUs81/3ijzDXoyA7ef5uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5110
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA5OSBTYWx0ZWRfX7GVuMw1VxtC1
 /Bn6E3CZyrCsm/1uhCKCdoOivEigXnIg6LkHfEd3cH+bKGr44UPkyCoqJcYRYa+oiSXbXZke4PX
 C6vPFoJZfg6/z3z8ui3GzOielOUl+fpnP4MbffnafXAF/reirhNYHfu/KDSi+VHEYRvgUZW69N7
 35e1CTbCghW+1YYiEX5FYVEf3OE7ylAMvN7qr2DzvLESLEX6atV13VxR0eEvIujfPhCcbGzLMpj
 8qqNy9ilCJ/6KjBCuUAGgTFChYXPGkRzHIlZSzRhLzHAE5H3E8v/+2njeph4tZjfT8osfi+lt1L
 g592M2p96isEGdYsmKHFzUB9SGu0R0LzxcQ5uUybAHWvCcaUtKB+D59gYEVhVc=
X-Proofpoint-ORIG-GUID: aelOahsJ-QxOTESogn0GEtKizRPwszuv
X-Proofpoint-GUID: YG7r6bUzhYyerhwqnMBp4JRv2dVwXgsI
X-Authority-Analysis: v=2.4 cv=PsOTbxM3 c=1 sm=1 tr=0 ts=689b1568 cx=c_pps
 a=FgPGhj3J+O9Iw+SmPTbx0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Q4-j1AaZAAAA:8
 a=t7CeM3EgAAAA:8 a=eQLL5yke5VAxEMMXBoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 57C4lBUF268657
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 10:20:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17870

Hi RP,

On 8/12/25 17:12, Richard Purdie wrote:
> On Tue, 2025-08-12 at 01:04 -0700, Robert Yang via
> lists.openembedded.org wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> There can be multiple PREMIRRORs each PREMIRROR contains specifics sou=
rces for
>> each layer, each recipe will try the PREMIRRORs one by one until succe=
ed, but
>> the trying would be failed if the PREMIRROR doesn't contain the requir=
ed
>> sources, so return it immediately to make log.do_fetch clean, and tt a=
lso can
>> fix a warning when BB_GIT_SHALLOW and is enabled and failed to fetch t=
he source
>> from the PREMIRROR:
>>
>> WARNING: Fast shallow clone failed, try to skip fast mode now.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>  =C2=A0bitbake/lib/bb/fetch2/__init__.py | 16 ++++++++++++++++
>>  =C2=A01 file changed, 16 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/fetch2/__init__.py
>> b/bitbake/lib/bb/fetch2/__init__.py
>> index 0ad987c596..6149b1726a 100644
>> --- a/bitbake/lib/bb/fetch2/__init__.py
>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>> @@ -1067,6 +1067,22 @@ def try_mirror_url(fetch, origud, ud, ld,
>> check =3D False):
>>  =C2=A0=C2=A0=C2=A0=C2=A0 # Return of None or a value means we're fini=
shed
>>  =C2=A0=C2=A0=C2=A0=C2=A0 # False means try another url
>>  =20
>> +=C2=A0=C2=A0=C2=A0 # Skip fetching it when the local url's path doesn=
't exist
>> +=C2=A0=C2=A0=C2=A0 if ud.parm.get('protocol', '') =3D=3D 'file':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found =3D False
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_paths =3D [ud.path]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Git works with or withou=
t '.git' suffix
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.path.endswith('.git'=
):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
eck_paths.append(ud.path[:-4])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
eck_paths.append('%s.git' % ud.path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for check_path in check_pa=
ths:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 os.path.exists(check_path):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 found =3D True
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not found:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn False
>> +
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if ud.lockfile and ud.lockfile !=3D origud.l=
ockfile:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lf =3D bb.utils.lock=
file(ud.lockfile)
>=20
> Absolutely not.
>=20
> This is adding git specific code into the main fetcher functions and
> the whole idea is this kind of thing is meant to be abstracted.
>=20
> The fetcher logging is a mess and we should probably be improving that

The problem is the following warning:

WARNING: Fast shallow clone failed, try to skip fast mode now.

So how about move the code into git.py?

Add the code to __init__.py can also reduce the logs in log.do_fetch, so =
I added=20
it here.

// Robert

> up rather than trying to add special cases to the code.
>=20
> Cheers,
>=20
> Richard


