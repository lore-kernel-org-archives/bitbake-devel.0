Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2261DCA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 21:43:36 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.5718.1755639806486803413
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 14:43:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=PEZzCYYC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=03260e8dbd=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JLJjoL2394041
	for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 21:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=Up3j5GL8GiisSILBInZT+v
	DW1JS53or3ujONxM/aukM=; b=PEZzCYYCyYj+vKv1NNMFU87A9MlFYAKHF5/eSO
	HKs4PPA+w6Im38ThOq80lStLDxwzBdI0hw5sg/N8+RD8cO7YlUqLEqAzyKLyTbvZ
	GR86XDnJUjDXeEQIvoU/v0/M20td0ND8+4kwL269XF28zmT2HvXY14IP4KHwwSQC
	oldr+mBz/Xk3ES/p2lJk4iLkm6kZnt9hglHh3oC//mC7SJGKIFvdY7cZL9wbUftB
	xb6FR6d1zHsH1lsFqs0J3CbFwZBeLzXoHlcS8vggOo32t65mnSQX5nW7el2N7sZq
	T8d0Y4z2dGw5zJNPNuf3e9V6fEGdrP8eSwkHofcnOsvPuk/A==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48mydqr3kf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 21:43:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+BweGq81mDAv5j3pDhbOCKNlNCnU98vo7Hr72B4nnrW7eJX4G2+o0nwj12k0jLKl67+kg1WmobLC7QAfBVoDZqNzV7hVE6er63Iddoe5nBkz6wasFlLDWH02b/n2fJRbr2jdqy3/uEOouyyEfOrYwSDjbqr9J61SCaYboCZ6mEX3ELMaSb2wVccDze2ucb3tOW+wpC647gtGzVCUewg2UwAeruUmgItY7xZYYIOOqFKwlN5CDKjeyJ73hOdGkJqz7a8KuLlLlLxMWLOnhh7PsFinyQ/AU5+/SxKZNedNp+6/zAo6/W4h8AVm3GfS7tcxF7m9fNmrkRnrPt8wOSIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up3j5GL8GiisSILBInZT+vDW1JS53or3ujONxM/aukM=;
 b=wGFpwGoRO9YsAUmHRymbqJtI7IzzhdgaspL3PxZQIt7rr7dc2IPxhY/ydYbbXJWO78DyVk1CwtLauxyYApLPEQnAoX0xpdgjsayTMfCW0iWfwRH/UfItsOFUS11+tg1qYpAWrpnalLo/jSDK8DmoFwAvXLhZc9Mw9O0+SkO6/9Qr7Dv+eFGoPMI7eKIrQMdE4cYPhuAatL4d6WnM9Qmsc67tIs0jLCsbKQMj5jsPfZ4tFFMKD5b9XbepMMKGkOBhL7gsQk0N58F4v+85j88PNYr9iZ6spsPWZNGn1trHtTE1I4fV0Q6lD6r/4UiIqsM7RrTV0cjCKX8q3hem+SOwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 21:43:23 +0000
Received: from CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::cdc3:a646:2a93:9552]) by CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::cdc3:a646:2a93:9552%4]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 21:43:22 +0000
Content-Type: multipart/alternative;
 boundary="------------KzbvtSO3AJ9zTGUvOBHBon0b"
Message-ID: <87cf6ce1-1c50-47d4-bb1b-5b2fb031f844@windriver.com>
Date: Tue, 19 Aug 2025 17:43:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] Bitbake and epileptic seizures
To: william.martin@muxen.fr
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org,
        ernstp@gmail.com
References: <b937fbb5-f398-414a-a440-7020004d91f8@muxen.fr>
 <185D2421C5FD6ED8.4571@lists.openembedded.org>
 <548d93e5583ca1c1808f51a69901e168263e0917.camel@linuxfoundation.org>
 <CAD=4a=Wq9FiyKMXa-fA4NwTYuyCUc1N9KZQyAvAVY8ty3_LvUw@mail.gmail.com>
Content-Language: en-CA
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <CAD=4a=Wq9FiyKMXa-fA4NwTYuyCUc1N9KZQyAvAVY8ty3_LvUw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8496:EE_|MW5PR11MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1387da9f-bc14-445c-c562-08dddf696ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UnNwYXpJL094LzlwZWRISStMZFdYNXJtSCtyR2dHTHhhcWVLS3p5VFJ6WXd3?=
 =?utf-8?B?ZXAyZkRNQnVNSDJ0K2wwUUpYR3BBcjlncTdBck8veHMxclBzY1d3L1czTjgy?=
 =?utf-8?B?QzBDK0s5QkJEZEdCVkpYV0tpN3liZnBLcDJ4OEQ0U3ZINWZuTStDMVJmMlMz?=
 =?utf-8?B?eTg5WXc0dmdoV04yM1FRckRDb01nOTJGdUk3MVhlQlRJem5MSkdlODNaVC9Q?=
 =?utf-8?B?M1d4VzJKdmNUbU5ERHhhd2ZUYXcvSjBXYk44Q0RPZkVXMXhINHYrMmpJaEZC?=
 =?utf-8?B?SlVhYlc2R201Q2RoYmRWcDVOb0hoZGtKODdZdWJWV2ZuR2h4VVhJdzNkVWwz?=
 =?utf-8?B?NEoyc3EzWmVZQllsd1RPcU16RDQwTXVuMFJFak5QWU5GQjBESThXUlAzeWNI?=
 =?utf-8?B?S0YxRDA0Wm96SG5KSkhYTVRyOUN6SC9jRnJPbXM4N3EyTzUyY0RRMUE0NkQ1?=
 =?utf-8?B?SkVqMnRjK0F4QUhRMXA3ckZHZUw3OGcyTkw3OGgzYmROaHdNdDB1TzJNWDlr?=
 =?utf-8?B?dGsyazl2TXlWQW55OHlJQUxBb2Q0UEk4d2pRa1o1ODFnK3kwOHJ0dklKT1F6?=
 =?utf-8?B?V2pFUkxRWTNObUUvRlZmTmdKWklsTkVvM204eGhwUEZzRDhCaHZUa1RPK1k2?=
 =?utf-8?B?dWdzb1AyU2RDSUVLSGwvOUFoMnVkdy83WndjbTlWdEtqc2h3bXVaM0M2ZW1R?=
 =?utf-8?B?aGlhaGp0WFhhTEJvRU0reUozM2hKcU1KdEFFNXFHWlNucitsYWtlUGMwL3Ri?=
 =?utf-8?B?R1VKcXB3a3czKzdDSmpCMkdNSXd3TjNmelRrTVcwQjByNEFiUlNIc3NOWS9E?=
 =?utf-8?B?UnFxZWY4REJaUUdmblZsVmFZd2ttandHcXpkSGJob0F3RTdibjh3dGhEVmVH?=
 =?utf-8?B?RFZlMUo1aGRqQ0dYZ3JYTC9McXRXR3Q2WlFIM0hXaXBYLzZCMmN6NFlzeGtT?=
 =?utf-8?B?VXFCalE3dzRnaUlqQ05BVldMTkpERXlkVC9aYVIzYXUwbzI4MktrUDlBZk1C?=
 =?utf-8?B?T3lpazVqOXlrK3BUcHdrQmlJTEJjRVhMTk5HaCtKS2J3NEtNVkt4eTRDc0da?=
 =?utf-8?B?NldsejZIdFFHTTkzTHpNTzlPRjVOc25wc3JQc0RMVjlZL01QcnpxSzhvbUhk?=
 =?utf-8?B?R2FpeGtIOFE2YVhXQWFzK2NjendxeTQ5b0hDRHZXVzNyMEpBakxSL3IvUllN?=
 =?utf-8?B?Uk1HL05mSHdIYkRXOXcyaXBFVkxpaDcrZTA3bUtJVEFJL0Q1c1NpZThURDla?=
 =?utf-8?B?STROVENPaFA1QnNlN2k0MHJmbTlqcG44Q2g3U2lHVHJuL0JnQlV0Sm9HVzJr?=
 =?utf-8?B?ZHdvRWJJRUpOSjltZG1YZGNHcWdnZ0R3SXZySWZveG1BL2ZEVUVVSVBRT2JE?=
 =?utf-8?B?N0M2blpPTHlWVG1RcTFxS0IxditqQTl0SjRYcUI5b1k2cTlXUURXV1pBWVhC?=
 =?utf-8?B?RUVUTzh2OUllYktDUGE5enUxOU52VGV6RWlpZnFwMFBjSUw2Y0RCREFxTzUy?=
 =?utf-8?B?N1pkVm9ENkpZbU1XRHpQUi96Q0VudHFyVzJQdzg1NXNvU1RXUHpRMngwWGxB?=
 =?utf-8?B?N0VELzQ4b0JqQjhZVVpmSlM4T2pFT05LQWNLbDQ1TTVKQ1N2MGx2dTZ2VHFp?=
 =?utf-8?B?eFlJSTNSZFYrUXJIbEEzQ0dVYmwxYlhOQlltblV3UWFtYzBScTJvelpjeVlD?=
 =?utf-8?B?SGZJUE5zYk1pbU1Lai9acjlLR1NqZWJJbXlhSlRNemF5dEVvbzV1Z0Q0TVVs?=
 =?utf-8?B?bTJtVU1pd1BCNERTMHAzRzBaZktsdGV0YWVzN3A5TWZnWFJjYTZkNlJ6RUtK?=
 =?utf-8?B?NmZyTmRYM0FpZlBYa0krR2JHYTNWSExsejZOWkxocFhxZVZJMzU3ZDRadGdN?=
 =?utf-8?Q?wKgIb3in7YX1i?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8496.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGZUUHV3KzhkRWJNSS85Nk84RmZVWDB6UnhQa3cxNDNhaE03SHp2MktSdURN?=
 =?utf-8?B?WkR0R0JlOWZjamVTZXNFNGV5ZXdFY1RHSFEzRE05aGM0SXNlM0IyWVg4R1hr?=
 =?utf-8?B?VlM3YkVOR3RFdW5KMTdxQlo1UHNXT3BqcDVzVWxrYTJYWVloTDF1Ulo4M0Ur?=
 =?utf-8?B?bDhtVW53YUl1YU03RmJ3TEwvZGo3T3o2NUhUbkdBcXd0dW4reVYvVDJzajgx?=
 =?utf-8?B?TWx0UElZRlIrTFhjUytSQnJiaE8vVUxYOXNPSllQd05oMXNnTit0TkRNS0Yv?=
 =?utf-8?B?enZNMExpVUExVXFPS0E4cGNXVWdWbmlSMGNzT1dnSUFqMjlSYUx6U09MNklI?=
 =?utf-8?B?Y09PdzYzbGs3VDRpWFBOUFB0ZzVLQzI5TjNkZFNtdmMwVmRTUGM0WnRvL0Fw?=
 =?utf-8?B?K3JXLzFPcVRoRHBLYkNzM0FCdGhWS2VGTlNhbWJEYi9DSXlRREZRR3RhOS9j?=
 =?utf-8?B?TERnOEtXZk5hVno4NkR6dTJnOSt6bTg1R0FaTFBLdG85NUxvNmhaclBSOVNw?=
 =?utf-8?B?d3dkVEZDTnVyN2hvdEZOL2JJeWRWTEd2K3UvcXlCRlp1WHU3NW53RExtWm4v?=
 =?utf-8?B?L3h2YndwRUExTHhSYW16R05nQUNsMVBHVjJ3NTNIWkRYbjcxUFd6Ti9uQ0dj?=
 =?utf-8?B?MTQxdEFTRVJ6ZlJRTk9NODMyOUdtRUE5TVQ3QlVDaVJkdlY5RTh4Z3FYYVVH?=
 =?utf-8?B?T0VWdTY5L3c2eS9IM1IrakFRVmZ1UlZMaHhuMi9Cc3hSOWk1NXFlMWpXd20z?=
 =?utf-8?B?UGcySWxtaldvWC9zMVB5bVNacEloSjZidmVDQmJVTitjOEQrRjZKRjRORzVM?=
 =?utf-8?B?ZlVoWkxGZ2l3RFBWblo4Y2ZJL3Rzcm5Sb0U5akI4cklDYmx4ZHlLNUE1MDhB?=
 =?utf-8?B?ZloxODl1ek1MVXU1c1hEalVSZmk3Skl6L0oyaUYyWHprb0hrVHdDOWtiWFpY?=
 =?utf-8?B?S3FZc0ozc2VNS25uVjV5THRsZFBCZFd5bitIbHJUY1JCWlBnMjdzeUNDSm94?=
 =?utf-8?B?UjBKcUV1VkxGU2VCL3pYN2VPRGszV1c5cy9WZ3Y5RDl0ZGx4ZGxQZjlmMVBs?=
 =?utf-8?B?ZHdzaStUUWFpQnVwVU91WTFhdmhJaDlSbURkN3liVDN0c245ZElDeDRtNGcx?=
 =?utf-8?B?eWhHTk1QelRMZVFWZGt4c0N5MUV2OWhDSkFRSzNCQzd4dnR0bGU3ZzMrNTZn?=
 =?utf-8?B?SUU0RjBreUpIREFXbFN3ckdyN290SmxnVk16a0JWMElhdTBFTUV1bjdtNkFZ?=
 =?utf-8?B?a1hJMWpwNGdJeUZhcEFOcWpBWkgzYXd4YnJINCtLb1hhOGRQL1JWRTlyWG1C?=
 =?utf-8?B?cFM0bzZmbzBXbVFGeGdFeXQ3QzFIaUZzTWRWUVhRK3lyV2ptV29kbGtGOTNS?=
 =?utf-8?B?WUJRMk9pSzZWSHhRTzlZVXlzT2IrMDNpT0lJbHNjeFd3bkxaajFtK0tBYVlv?=
 =?utf-8?B?NDVqdC9VSWVsRUtmaFFPRVIwVVM5eHNLVjV0M3hTL212WXh0WmZlbnhGNWV6?=
 =?utf-8?B?STkvaW1SbEFrZ3ZuMHNaaXF3UGlYQzhOMk5BdCtVNjRoQngxczdPRzArbFVp?=
 =?utf-8?B?dmJ2V2ZkR1dtdVFhczdGUWo0ak5KL2VzK2YwODMvREpCd0swMTM1Sys3alJ0?=
 =?utf-8?B?N2hqSzNBZEJzb09Bd1pubVpmMnBJSWxSMDF1V2puZFJpc0kxdmZJOHlub1RG?=
 =?utf-8?B?RzR3cjdhNGRtdmdCc2d0WU5rNk10UGNqYUtKNGF4cEVaVy83bkZaVUNRSjNW?=
 =?utf-8?B?YXkxMnBNNEJaSnNvUGVxTFp5RVVYamlBbEJFWlQrTFd1cVV2M3BZVVZZQlkx?=
 =?utf-8?B?MVhQdGsxeXFsaE9mc0w5QlZnL2FkbkFCS0hrR2RGZjU0V1pORElVRGhJWEhx?=
 =?utf-8?B?TlJLcHlLZkp2Yk1SemdwQ2RPaC9yK0RCTDNyRmExaFZHejVTTHpkc0tBT3RB?=
 =?utf-8?B?b2w0VVN5L3JVamdqeXZNZ0Q0UXk3VFhUZnhzY05obEJlNGhRWUVMNlh1eXQr?=
 =?utf-8?B?L2ppTGZpZ3I0Umx2RDNKZko2WTlnVS8yWUcyc1lRaGhueExyb2g4RitpeXAv?=
 =?utf-8?B?RHZEcDBGelptTVBTTmFyUDRGQjB5akZ4Mjh5Q0Y4TVdqZE1idmlrN2xEWkFO?=
 =?utf-8?B?bjRGdnU4WVFLckZZKy9qTzJmbm5pdUdLeVhzbXVMTG9KUThGS01yU25HS2hj?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1387da9f-bc14-445c-c562-08dddf696ba4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 21:43:22.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV1HzMzH6r7PzlqLDX2VEaMHAPMjgBrgFSH2Mzys7r+J0yuBFLv/wGok+doriBZ6obU6gtL571VICkgDSBIRkkBxfY7wzvti4NInlminnCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: uyyCsjvVm8_9Wsr_s_XHijKlWnWxT_HG
X-Proofpoint-ORIG-GUID: FlPFKOkMx8l157GUtj8BxKv1hKz8BswY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIwMiBTYWx0ZWRfXz4VhTPtpLdSw
 i++D0C2+L2N5L/Pu7Kr/c/LGD4Orw9pRLdvjhJBNrc/Mc2Qk85/Goh2Rm+vKlvazYH/FNiyZJIe
 O144rgzaCyxFWZDE5MHckU/B7GJaErUYyH78Sna/pXDIgcIvLAyNYSoGSBlzbTApnBltRxElVMw
 bELrb2VmLHYEYeTAx9cuxyiBaB7VBS61iex/EXbjBRzdWcW4kzHRC26v8aItR5+foVd3UAQ1rxn
 UMSYphchIaNLxr6N4gHIjtIPuhSB0BeOZW6MGGuWkjd3ONyw1zbKGu34tEbzxW9OEAvdLLkdOCf
 J2dk+70Z77WEERZYZbfErIw4XgPXyrb82ibhEWHRScJgqbFL3oxL4OmUVA4P/ne97BgoQJZkjT3
 WymILFV86yY4hF8VSCXafKEPudakWw==
X-Authority-Analysis: v=2.4 cv=XOhpiQhE c=1 sm=1 tr=0 ts=68a4effd cx=c_pps
 a=z2JJcCkshELlDGyO4lBz5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=GHR8O2WEAAAA:20 a=doFk5lwsAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=lrJr1S9Wf7mQ36jxeVMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8 a=9_iOrmWI5HME61JMZc0A:9
 a=P2ya4v6GBnxFJrSw:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=vej8NfhdRzSHuAaQFHWB:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=HhbK4dLum7pmb74im6QT:22 a=CTwFTDRtctY-zZ8oRDn3:22 a=yULaImgL6KKpOYXvFmjq:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2508110000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 21:43:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17890

--------------KzbvtSO3AJ9zTGUvOBHBon0b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 57JLJjoL2394041

On 2025-08-19 8:35 a.m., Ernst Persson via lists.openembedded.org wrote:
> I recently saw this merge request:=20
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/4487
> It says the following:
>
> "The European Accessibility Act (EAA), in its Annex I, Section I, 2.J,
> specifies that products "shall avoid triggering photosensitive
> seizures" (see Sources).
> According to the Web Content Accessibility Guidelines (WCAG), any
> element that flashes in the screen must have a maximum period of
> 3Hz to avoid the risk of Photosensitivity Seizures (see Sources)."

FYI:

At first, I thought this could be a case of government over-regulation bu=
t
apparently ~1 in 4000 people are sensitive to this sort of phenomena:

https://www.epilepsy.org.uk/info/seizure-triggers/photosensitive-epilepsy

and that's much more common that I expected.

Thanks for letting us know about the issue!

../Randy

>
> Den tis 19 aug. 2025 kl 12:43 skrev Richard Purdie via=20
> lists.openembedded.org <http://lists.openembedded.org>=20
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org>:
>
>     On Tue, 2025-08-19 at 11:25 +0100, Richard Purdie via
>     lists.openembedded.org <http://lists.openembedded.org> wrote:
>     > Hi,
>     >
>     > On Tue, 2025-08-19 at 11:56 +0200, William MARTIN via
>     lists.openembedded.org <http://lists.openembedded.org> wrote:
>     > > I send you this message today to talk about technical choices
>     that can
>     > > have serious health problems.
>     > >
>     > > Some days ago, we have an external person at our office who
>     have see a
>     > > bitbake terminal building an image.
>     > > We discover that he is sensible to epileptic seizures (he is
>     ban from
>     > > traveling by plane for that).
>     > > The story finish pretty well for him, but we have to ensure no
>     bitbake
>     > > terminal is open when he is here.
>     > >
>     > > I am not sure that refreshing the task list at very high speed
>     have any
>     > > interest for anyone.
>     > > Maybe an update at 1Hz max is enough to ensure the build is
>     working.
>     >
>     > Firstly, I'm sorry to hear about that person. Nobody likes to thi=
nk
>     > something they've worked on causes an issues like that :(.=C2=A0I
>     hope they
>     > are ok.
>     >
>     > The fast refresh rate isn't an intentional design decision but th=
e
>     > result of a number of changes over the past decade coming
>     together and
>     > interacting badly. Those include CPUs with higher core counts,
>     addition
>     > of progress bars to many tasks and time output on the console
>     view, all
>     > of which were developed semi-independently.
>     >
>     > There are some patches that were submitted a while back but
>     there were
>     > issues in the implementation and we've never got to providing
>     feedback
>     > and sorting them out. Sadly that is a common theme for many
>     different
>     > things.
>     >
>     > I am going to try and get this one resolved though given this
>     report.
>     >
>     > Thanks for bringing it to our attention.
>
>     I've merged some patches. They have a 40hz refresh rate right now b=
ut
>     at least add all the code needed to make it configurable and we can
>     experiment to find a reasonable value.
>
>     Cheers,
>
>     Richard
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17888):https://lists.openembedded.org/g/bitbake-dev=
el/message/17888
> Mute This Topic:https://lists.openembedded.org/mt/114778577/3616765
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub [randy=
.macleod@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--=20
# Randy MacLeod
# Wind River Linux

--------------KzbvtSO3AJ9zTGUvOBHBon0b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-08-19 8:35 a.m., Ernst Persson
      via lists.openembedded.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAD=4a=Wq9FiyKMXa-fA4NwTYuyCUc1N9KZQyAvAVY8ty3_LvUw@mail.gmail.com">
      
      <div dir="ltr">
        <div class="gmail_default" style="font-family:arial,helvetica,sans-serif">I recently saw
          this merge request:&nbsp;<a href="https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/4487" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/4487</a></div>
        <div class="gmail_default" style="font-family:arial,helvetica,sans-serif">It says the
          following:</div>
        <div class="gmail_default" style="font-family:arial,helvetica,sans-serif"><br>
        </div>
        <div class="gmail_default" style="font-family:arial,helvetica,sans-serif">&quot;The European
          Accessibility Act (EAA), in its Annex I, Section I, 2.J,<br>
          specifies that products &quot;shall avoid triggering photosensitive<br>
          seizures&quot; (see Sources).<br>
          According to the Web Content Accessibility Guidelines (WCAG),
          any<br>
          element that flashes in the screen must have a maximum period
          of<br>
          3Hz to avoid the risk of Photosensitivity Seizures (see
          Sources).&quot;</div>
      </div>
    </blockquote>
    <p>FYI:<br>
    </p>
    <p>At first, I thought this could be a case of government
      over-regulation but <br>
      apparently ~1 in 4000 people are sensitive to this sort of
      phenomena:<br>
      <br>
      &nbsp;&nbsp;
<a class="moz-txt-link-freetext" href="https://www.epilepsy.org.uk/info/seizure-triggers/photosensitive-epilepsy">https://www.epilepsy.org.uk/info/seizure-triggers/photosensitive-epilepsy</a><br>
      <br>
      and that's much more common that I expected. <br>
      <br>
      Thanks for letting us know about the issue!<br>
      <br>
      ../Randy<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CAD=4a=Wq9FiyKMXa-fA4NwTYuyCUc1N9KZQyAvAVY8ty3_LvUw@mail.gmail.com"><br>
      <div class="gmail_quote gmail_quote_container">
        <div dir="ltr" class="gmail_attr">Den tis 19 aug. 2025 kl 12:43
          skrev Richard Purdie via <a href="http://lists.openembedded.org" moz-do-not-send="true">lists.openembedded.org</a>
          &lt;richard.purdie=<a href="mailto:linuxfoundation.org@lists.openembedded.org" moz-do-not-send="true" class="moz-txt-link-freetext">linuxfoundation.org@lists.openembedded.org</a>&gt;:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On
          Tue, 2025-08-19 at 11:25 +0100, Richard Purdie via <a href="http://lists.openembedded.org" rel="noreferrer" target="_blank" moz-do-not-send="true">lists.openembedded.org</a>
          wrote:<br>
          &gt; Hi,<br>
          &gt; <br>
          &gt; On Tue, 2025-08-19 at 11:56 +0200, William MARTIN via <a href="http://lists.openembedded.org" rel="noreferrer" target="_blank" moz-do-not-send="true">lists.openembedded.org</a>
          wrote:<br>
          &gt; &gt; I send you this message today to talk about
          technical choices that can <br>
          &gt; &gt; have serious health problems.<br>
          &gt; &gt; <br>
          &gt; &gt; Some days ago, we have an external person at our
          office who have see a <br>
          &gt; &gt; bitbake terminal building an image.<br>
          &gt; &gt; We discover that he is sensible to epileptic
          seizures (he is ban from<br>
          &gt; &gt; traveling by plane for that).<br>
          &gt; &gt; The story finish pretty well for him, but we have to
          ensure no bitbake <br>
          &gt; &gt; terminal is open when he is here.<br>
          &gt; &gt; <br>
          &gt; &gt; I am not sure that refreshing the task list at very
          high speed have any <br>
          &gt; &gt; interest for anyone.<br>
          &gt; &gt; Maybe an update at 1Hz max is enough to ensure the
          build is working.<br>
          &gt; <br>
          &gt; Firstly, I'm sorry to hear about that person. Nobody
          likes to think<br>
          &gt; something they've worked on causes an issues like that
          :(.&nbsp;I hope they<br>
          &gt; are ok.<br>
          &gt; <br>
          &gt; The fast refresh rate isn't an intentional design
          decision but the<br>
          &gt; result of a number of changes over the past decade coming
          together and<br>
          &gt; interacting badly. Those include CPUs with higher core
          counts, addition<br>
          &gt; of progress bars to many tasks and time output on the
          console view, all<br>
          &gt; of which were developed semi-independently.<br>
          &gt; <br>
          &gt; There are some patches that were submitted a while back
          but there were<br>
          &gt; issues in the implementation and we've never got to
          providing feedback<br>
          &gt; and sorting them out. Sadly that is a common theme for
          many different<br>
          &gt; things.<br>
          &gt; <br>
          &gt; I am going to try and get this one resolved though given
          this report.<br>
          &gt; <br>
          &gt; Thanks for bringing it to our attention.<br>
          <br>
          I've merged some patches. They have a 40hz refresh rate right
          now but<br>
          at least add all the code needed to make it configurable and
          we can<br>
          experiment to find a reasonable value.<br>
          <br>
          Cheers,<br>
          <br>
          Richard<br>
          <br>
          <br>
          <br>
        </blockquote>
      </div>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre wrap="" class="moz-quote-pre">-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#17888): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/17888">https://lists.openembedded.org/g/bitbake-devel/message/17888</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/114778577/3616765">https://lists.openembedded.org/mt/114778577/3616765</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------KzbvtSO3AJ9zTGUvOBHBon0b--

