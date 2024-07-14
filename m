Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FE5C3DA42
	for <webhook@archiver.kernel.org>; Sun, 14 Jul 2024 13:54:39 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.16648.1720965278530515164
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Jul 2024 06:54:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=79255a1817=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46EDsKha017316
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 06:54:38 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40bmv08uxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 06:54:37 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46EDsbl6017877;
	Sun, 14 Jul 2024 06:54:37 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40bmv08uxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 06:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUg/+/tIhpD84eeGLZMuuCHDLXRlWogu+XLT/SZGTsf6peBhonU31DTjVkEYpjC7TaBWNvWend9JunsWkj+VwEpzUn68/wTv8AG/SMEPBbE6ZKISIOPEur667rChJY1lftbeuOG57BLxvZQzGrsSR8tt80FBab7Mj/wtaz3+sG0UaQaY6H/hgW/aEKap1HSIwrO9I63IizD0nPv6o/5U7Z4cFUm7KaCjsczeWIzvKiLVC93IvxpvX0BhNF/ztW41BVDQbxpZSUMDm+kPPVOeeK490Cwi0sEs8vpj11W0VfM+3Vq1BwT0LGRylZz5wikuVziKgDKSo4iPx6a8nxQZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNYdgK0ivwWQ6IXUFwQw2E30nXJmH0Bv9fR4beLcT64=;
 b=gWagu2C9LXpd/G/1pWk9qU1QBdwLINs8iIJu3NF2qSys/UwG/D/v86Kh/TMt6NBYKou4uVpO8hjGSPtAvmDkXZ0hKREXKoSdM+MKA+sX28dAvH29a4R561HlUAkvVghk8/SABveSgIusljj0HpnR6WHAKMzaI7BNKCbHE1+yspTcIsxHhxfyuU33+ynsSMfBid072gmYQFD3Qbsqz4ES5AEw3UV7XVno6ojYpW5T4l/w7FUmEsGWXKKKDkc29o+RQaQBH092Z39xx0DTWbzsXQS4BiE+Vp/juGI88fxz482sGdXVdxoA5j5wyvKUvgKGNhpYcroeSem4cVk2+nTn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by SN7PR11MB6827.namprd11.prod.outlook.com (2603:10b6:806:2a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Sun, 14 Jul
 2024 13:54:34 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%7]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 13:54:33 +0000
Message-ID: <c813bd89-d225-485d-bdd1-b6be5e4cde07@windriver.com>
Date: Sun, 14 Jul 2024 21:54:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <cover.1719033434.git.liezhi.yang@windriver.com>
 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
 <96618974b45a07b06a312079646c6bf49c1474d8.camel@linuxfoundation.org>
 <6b671da0-070e-4f1c-a7cb-a3331f363a05@windriver.com>
 <2fd20e75418badc5562e1f2faf340fae0e7ab891.camel@linuxfoundation.org>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <2fd20e75418badc5562e1f2faf340fae0e7ab891.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP286CA0106.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::13) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|SN7PR11MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 41de7ad5-3307-4e56-cb24-08dca40c7d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|4022899009|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c0JNdUdqQ01DWTI5NlFwSmZ3bmxQOTNqdUlGN2NyNXNNWVV6RG1mRVpxWjFo?=
 =?utf-8?B?dTVxU2I5dkttd0RRRXE5MU9jU2ZxaHhpUXdTbnI5UVhEQUpSMkJ1MjB0U05T?=
 =?utf-8?B?eUpaQXJFMXhyVHA3TENBbnc0amJvSFNFYjVVTzFDWlVqS1l1cTZPMjFVSnpG?=
 =?utf-8?B?dUhuYTZTcVZhMXpmakU3Y3lPWXJSMk83bWxGMUtKSnVSWXJYeUVIMUpqVnV0?=
 =?utf-8?B?b0Ria3RKL1dhV0VZY2hxdnpSdUFFNDBPemRzbG1jQ2NpNXRCRkxML0Jmbng0?=
 =?utf-8?B?MkZnMnAvN0R0TEJBcFlvdityUkVRSHZiL3h0MDRqWkxYcUJoZFlYamJZOGc5?=
 =?utf-8?B?MXN1OGJ3ZnZQOEF4YllVK25hY1Zra2RMTFAzb0RCNmRRWEJxZUh5NWNwbEtP?=
 =?utf-8?B?ZVdaUHVScUM5c1p6NFNzaTFXZVYwdDNIYnFLNnZmY3VhUHllSVVaVzZrMUVs?=
 =?utf-8?B?RndRSGg2WjJhZWg0L3EwdXhaN1FZZGViejl3bFdpR0tySjFlZkc2ZGZtNUZx?=
 =?utf-8?B?N2FDTmZTQTRYTWU1QWJLamZaQ0NWc1AzMWh6dFVMRFhOREM1N2Y0WVUwcFNQ?=
 =?utf-8?B?YWNoSzUrWmIvWVhpbFFNbmJmRnJVV0t5YjdSNUlmVjZYcVlidWlDVG5wckEx?=
 =?utf-8?B?Uk1pODZOWW9Wb3VYWk95RXhJdEJQWThEMHFPdDZ3OG02SFhnWlVLeVNLVWFm?=
 =?utf-8?B?Y0lEV29WWER0dytoTytaUE5XenY2UVR2L3E0cFpRTFcvRFh6TmhnNDlLR2pW?=
 =?utf-8?B?UGs3d0ZvVzB6c0hrMTBpYmNlR1ZJS0lGNlg2ME9JcGRPbkE0Mk8vckU5djNC?=
 =?utf-8?B?U0lsNFlpR05uODllajJIOFhBVDBiUndTTHBlVGtXMzcraTEyclloMUxza0ZG?=
 =?utf-8?B?Wi9BSHhQRmNDN2JjeXYzb3hNZXZ3MFVqeG9YaG93WFBzOXZmaGxyVFg4blNP?=
 =?utf-8?B?YnpBeUpScHhTY0diRkd2bXhkK0tzd2ZPQ3VmellmRmNQUkpxOHN6SXIvaHd1?=
 =?utf-8?B?Vm50YkJPWDV6Tk1ReGQvZ2dkcG96WHR6aVE3a1BZV0dkWnFyRW13OGhDeHpo?=
 =?utf-8?B?S0s0TTVVUVhzQXZyZ3dNSU1ZWUdBS3lZd1owRUZFYTNUQ1JzQzV4QXNzVEdU?=
 =?utf-8?B?NVRrMHFkaWF5bUxqQjhRVDR6ZWVuajZIZ0owbmhRa3VFT1Q4UGpIYnFycUlw?=
 =?utf-8?B?cGdzNXB6TjlNQWZoRHpWM3U0UXlaemFHNHhUcy9zRDJGNUUzZTVHNTNJNEhO?=
 =?utf-8?B?eDg3T0NFenJCM2ZLc1BPWkFHYys5SUd0blE2dW1qU0hlR1R6N3p5d0I3aUl4?=
 =?utf-8?B?ZCtqZXFoRWVTN2xvTGVKUzVVc1p1Qit3MWx2U080Tmhmb0NuMnpISE1zajNT?=
 =?utf-8?B?Y1lGMWgwNWdlTnhOb3lmNXcwcmNZeTRMb3NlRHQvbHdBUEZGS216cTBvZjRH?=
 =?utf-8?B?VHZZdnNkVUs4YmRWblc0ZzMyQzVJQ3FYOG93Y215K29xR21uTmJXN1hqVlV6?=
 =?utf-8?B?ckhPWU1vVXRYTGVhTysxaWNISlFNMGx2WHJKbUtxRXZZM1JBUi9IMUQvT2sz?=
 =?utf-8?B?L09PN3dpRUt2a0EvRFVZQThUY1R3cVdiUU9hR2s2eklRcDg0c2RVKzB5QTRW?=
 =?utf-8?B?cVJ3cERNZ0h5djZRaVJMZkFDN3M5SzlvTGQ4UUxEaVJCUXlaQ1U0bU9wemdS?=
 =?utf-8?B?NmJzMEx2cDZzS0tCMUNVSlp3VXg5SHUwV2J3d1B4a0UxbDRYd1BPc1FLZlI1?=
 =?utf-8?Q?Q2a1Jm9c28WfQRBE6C1mXFj9kJ+BEpF1sooLNy9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RENDdmRlMldzdEhBV25WVy84SDFJdEQyVHVRaG1EY2RHWlhsTVRYcG1BVG9H?=
 =?utf-8?B?a2YweFVsU3Z4QXdsTVRKL29LMVZZN0txMVJpV0JLUk9vcTlsdkhqWjQzZFBm?=
 =?utf-8?B?NTBxTjd2cy9sNGJXNG5jeVp5MVlFaFBBbDFaNkdXSi84ZEZ5ejR1ZVhlT0lQ?=
 =?utf-8?B?aE1FRjNaYVVhYmRtRXVoSGE5ckREVXRUYnppYTFNMkdwWUpjU04yaTdlbGg4?=
 =?utf-8?B?KzN3dUcxblVlY0Z6ZGdPV01VMGxPR1Q4Z3dLMjNoeGlSYmRpeGFmUFZKRG9S?=
 =?utf-8?B?bC9BS1N2cVE5SXZZQmdLTnhNdVd4YnU4cGRMYWFCcUFMWmh1SkNlVXBEZHYx?=
 =?utf-8?B?NWJCd2ErcmhwaytEb1IwTmZ6YkZTQjZxdHJGRWZHTitLV1l0ZXV0UDdRbEE4?=
 =?utf-8?B?MW02Q05wa3dmWll6TXRseGFWRHZkM2Y1ZnBhWERzcmF3VEg0RjgrUU1qZEdN?=
 =?utf-8?B?cGsrTzQrZ0ZnR2ZuREZXeFRvUFEzVUxsM3JteE1DOTVaYVdIQXhNaDlET3Vo?=
 =?utf-8?B?VUV4TGpVNWc5VWd1a2lTdVYra1VQOVBXaU9Ba3MreFlXRVg4T2oxSWdsL1p6?=
 =?utf-8?B?R3R0TXVKUXJVS0dxbUM1Y3l2YUtQMkxCWnBVMG1kNVgwd3IrRTMvelkzcXlH?=
 =?utf-8?B?M3BjSDg5ZTRBam9idjdRSVgyRXNoaE00a3U1ejkzbjcxTTNNRmJpcmxDUDJS?=
 =?utf-8?B?Q0tEbW1uYzBhMnFHWmJQU2hLYS9peWtsbk9FN1NoS3pRWFN1M3VSejc0MmZj?=
 =?utf-8?B?TXNXb1F6dU03VWR3ZTJRSWdEQW1ZS0RtL0l4dUJKQVAvbXRIZzgxZHluaXE3?=
 =?utf-8?B?MVhNcllPb3hreGtDYm9vNGJSNmtvQjVhc2FuMm1NZXBSVFpzaUpVVVB3UTAx?=
 =?utf-8?B?SWQ3U3J5UU90MGtCQ0lCRzBQaTJLWm5LK2hmRCtCV0pUU3RSMmEyaVJSTzJU?=
 =?utf-8?B?ZXpWSVc3NGtxa1N5WHJrVExRVGRiYjNaYm5OMVBqOC9zNHZXNkJrMkhWRWc4?=
 =?utf-8?B?OTc2U3NwVUN6MWJLOVk5UWFYL040QTh5c0todTBtQ0lQUURwVGhiVnB4VjFq?=
 =?utf-8?B?QUw1eGxyZThWa3ExK1ZkMlRGWEVvR21RMG5NUWQ5TGc3RW8wRVhDWXZJOEZv?=
 =?utf-8?B?OU1YemVRNGF4NitOaVBzWjVsajhvTi8vNUNOdDVXdmxJQzNsaUVZVXFZbERH?=
 =?utf-8?B?azVkY1MzZ1QwTmJaamlrQjJsUldYQUptTmZSWUl5Y3A4dWRGZDZ5aDExeGZp?=
 =?utf-8?B?UWl1MHN4T1lzRzFwYXl4clJ5YVQyTmFRMFY5TW9tU3o0WGgvL25JQ3hoUlhs?=
 =?utf-8?B?eFZQRDNGeS9rNnUrc280OEVZUUdabC9ZazQ3RXZ0bFp5VmpNUmpMT29tc2lI?=
 =?utf-8?B?VlQ2bExDSnptMHFtSzdLS0xqald5ZVUvS3hkQk5uNCtDd1ZYQjdEVm9Gd1gz?=
 =?utf-8?B?cnBvN216VjduSnhRSkk5UERyWWxNYytvOEpoSHdQQnRmQ1pJRnRMYzAvdENI?=
 =?utf-8?B?U2ZYQ2hJT0Y1VWpxRE5VWjZuQ2NHd29zV0JXZjZNWHFERTQ1V0Z3MXJMWVZn?=
 =?utf-8?B?d1ZpbUdTQ1VISG0rSDBSckMyVHl4aUNYcVFXSGFQZTJLZnhoRjVPTjIvd3BW?=
 =?utf-8?B?c25UNHVJVkg2NmZIRVVyTTVQc0xZdWlpcUIvS2dUbmM5V25oWUtiSnJqeGhr?=
 =?utf-8?B?SmV2RUZ1UzNzUFhXRyt4SHYxMEdNTWlFK0hMWTJ3VTM0ck5naGs0SHFIaU9q?=
 =?utf-8?B?K09hTGJoVFphR2pZNEtYY2RVSFR4K0pQRHM0dUpQT3R2Z3ZDRlFINnZxbXU1?=
 =?utf-8?B?eFFBTlpmbXlDOWorMkZOb24rakE5aTRxamI0ZzBFd2J3Sy9CVGhPeFhhSTZS?=
 =?utf-8?B?V1AzV01udnZKcVZBaW1icGl2QnNEWlVDM2MyNlY0aTh2RHBOb3JSTFVrS0lN?=
 =?utf-8?B?c3ZlNW1JRFQvV0VmaU1mQVNORk9NWlQ3aVoyZ1JwdkxUcE8wWVBsb0hTVkIw?=
 =?utf-8?B?TkxzZHhhbE5oSSs5UkZnUHN3bW5KbGJoak8vZmNkMXNjOXFYcUcyUlRUT0JW?=
 =?utf-8?B?UU9WOThhSVVvUU1BUDZGdHZZNGRZemVXNUovMnRMdW94M2NHMEVvaHR1Skwv?=
 =?utf-8?B?M0VhRkJwU0xtekc4UTJNcVFsazV5Zng1NHdqWUFNSjJpZU0xYVhQbDkxWVBC?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41de7ad5-3307-4e56-cb24-08dca40c7d97
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 13:54:33.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNpZJtNr9dyfLzCkKl3UHWY40oKHNRVHWA0PPZCUBDHHNK/bn9l+h6qQ751/LQFpueCrLh4WxtJ+62T/cMXhf57F363mlXFtYr1x+n1yO0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6827
X-Proofpoint-ORIG-GUID: 8SJFZhPhHQgx13iKeARlX3nHuKGOxEyY
X-Proofpoint-GUID: 9_D6SOYvxKRkyJPm29QrlgQ7Xm1EJbDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407140110
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 46EDsKha017316
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 13:54:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16422

Hi RP,

On 7/14/24 21:32, Richard Purdie via lists.openembedded.org wrote:
> On Sun, 2024-07-14 at 21:03 +0800, Robert Yang wrote:
>> Hi RP,
>>
>> On 7/14/24 19:17, Richard Purdie wrote:
>>> On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via
>>> lists.openembedded.org wrote:
>>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>>
>>>> The previous code added local path to generated mirror tarball
>>>> name which had
>>>> two potential issues when fetch from local PREMIRROR, for
>>>> exapmle:
>>>>
>>>> Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
>>>> $ bitbake lsof -cfetch
>>>>
>>>> * There might be "Fix File name too long error" when the local
>>>> path is long
>>>>  =C2=A0=C2=A0 since the path is translated to filename and added to
>>>> downloads/git2/ as:
>>>>  =C2=A0=C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
>>>>
>>>> * When enable BB_GENERATE_MIRROR_TARBALLS:
>>>>  =C2=A0=C2=A0 The tarball name will be:
>>>>  =C2=A0=C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.=
tar.gz
>>>>
>>>>  =C2=A0=C2=A0 The above tarball can't be re-used by do_fetch since b=
itbake
>>>> looks for
>>>>  =C2=A0=C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the
>>>> 'path.to.local.PREMIRROR' in
>>>>  =C2=A0=C2=A0 the file name breaks the match.
>>>>
>>>> Use os.path.basename(ud.path) as gitsrcname when ud.proto is file
>>>> can fix the
>>>> the above two issues, now the file name in downloads/git2/ is:
>>>> github.com.lsof-org.lsof
>>>>
>>>> And the generated tarball is:
>>>> git2_github.com.lsof-org.lsof.tar.gz
>>>>
>>>> Or when BB_GIT_SHALLOW is enabled:
>>>> gitshallow_github.com.lsof-org.lsof_2e4c7a1-1_master.tar.gz
>>>>
>>>> And the tarballs can be re-used by do_fetch.
>>>>
>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>> ---
>>>>  =C2=A0=C2=A0bitbake/lib/bb/fetch2/git.py | 5 ++++-
>>>>  =C2=A0=C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/bitbake/lib/bb/fetch2/git.py
>>>> b/bitbake/lib/bb/fetch2/git.py
>>>> index c7ff769fdf..89d3268f7f 100644
>>>> --- a/bitbake/lib/bb/fetch2/git.py
>>>> +++ b/bitbake/lib/bb/fetch2/git.py
>>>> @@ -277,7 +277,10 @@ class Git(FetchMethod):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedre=
v[name] =3D ud.revisions[name]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revi=
sion(ud,
>>>> d, name)
>>>>   =20
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % =
(ud.host.replace(':', '.'),
>>>> ud.path.replace('/', '.').replace('*', '.').replace('
>>>> ','_').replace('(', '_').replace(')', '_'))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file=
":
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
gitsrcname =3D '%s' % os.path.basename(ud.path)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'),
>>>> ud.path.replace('/', '.').replace('*', '.').replace('
>>>> ','_').replace('(', '_').replace(')', '_'))
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcnam=
e.startswith('.'):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 gitsrcname =3D gitsrcname[1:]
>>>>   =20
>>>
>>> I started to review this, then I started wondering why we have
>>> mirror
>>> tarballs being created for local file:// urls? Does that make
>>> sense?
>>
>> This patch fixed two issues:
>>
>> 1) "File name too long error" when fetch from PREMIRROR
>> 2) Git mirror tarball contains local path when file://
>>
>> Create git mirror tarball for file:// doesn't make much sense, but
>> the problem
>> is the first issue, there would be the error when len(path) > 255
>> (The NAME_MAX).
>=20
> I understand that. However:
>=20
> a) why it is looking for a file:// url in PREMIRRORS?

This is a little WRLinux specific, we release git repos with the product,
and set PREMIRROS as:

PREMIRRORS:append =3D " \
      git://.*/.* git://${LAYERDIR}/git/MIRRORNAME;protocol=3Dfile \n \
      gitsm://.*/.* gitsm://${LAYERDIR}/git/MIRRORNAME;protocol=3Dfile \n=
 \


> b) why does it consider mirror tarballs for a file:// url?

I found the issue when I tried to generate shallow tarballs from the abov=
e=20
PREMIRRORS.

// Robert.

>=20
> I'm not sure it should be doing either of those things?
>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16421): https://lists.openembedded.org/g/bitbake-de=
vel/message/16421
> Mute This Topic: https://lists.openembedded.org/mt/106812686/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liez=
hi.yang@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

