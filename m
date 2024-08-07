Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E87C52D6F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 02:23:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.24230.1722997392856537576
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 19:23:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8949e90ece=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772NCQl001051
	for <bitbake-devel@lists.openembedded.org>; Tue, 6 Aug 2024 19:23:12 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40sm2h36q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 19:23:12 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4772NBBk001045
	for <bitbake-devel@lists.openembedded.org>; Tue, 6 Aug 2024 19:23:11 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40sm2h36q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 19:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD4Ln/LodxhWi8TGM4XBBU9n7WeyZ4OJBtuying+dVl8YudyRKaCxWgv7UMDu8FhNgVmE1pb1PBODaiAq1aNSjkLiN6NQJehRFsdN88jrTKwyyCaQOk71Qc8RIRs0LTjkZ05ld6NA+iHycl9IjZBmQXW8PqS+rC1NLkZIXzOhqKZRQhRZzEiXB6YzFj3rscMAWPZ9IWJYf3Y+Mzq2qk28bmT+z9yigAffyWosA1UT5FU/nFgeyOBtKUDNLjGIB0NeanF4sSd5cD8vnLp8K0Uh8uYlFMuF5a+3uiBp2F0ZQGEDf/XYLHbUiiBvBhylGqoJPpQvycZ/ik85bUAqBxV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLip3pkqEIEjqqYs4IwRwkHMhJuO9UA2l1R8B5DrdaM=;
 b=NCwWi+gnepy854hr6nfiNXvoB6BOsEszGOXdvoIBdsoMQTNAHQVliBtyhDwiAKK1PWWIz8oZLu/Oy270pPOezxnzOTo0sHQsaxkmdnNnUd7Kn9/jXRJ+ktvY4V1TVab0J/x54ghQx+KLsxnqE7DBLSZPs4Lyjcn+kCA19AnfhJ4isoIt3TxfkRu/H6xIdCbJFWdGghWBeU+UWJVMDDvlMfYiKMNAtYH8euiO9zsgN9AH5WU8nxARnUqj76WSpZ8nBNpVciJVyhxYkKL06F8VBjENRxxxx6DsOG2kjXzn3ZAxQvq/EcztT2WlZ5W+wtyYm/lFsTDrGLdUJDKx+8H30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 02:23:07 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%7]) with mapi id 15.20.7828.024; Wed, 7 Aug 2024
 02:23:07 +0000
Message-ID: <833f4ebf-3bd0-413f-94ce-9d03a4d615f2@windriver.com>
Date: Wed, 7 Aug 2024 10:23:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org,
        Ross Burton <ross.burton@arm.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
 <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
 <e089ca2e-5834-42bb-998b-3515b2fccaed@windriver.com>
 <0aa2cd5ba0a59dfeb5810beb34130a0b9bd803db.camel@linuxfoundation.org>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <0aa2cd5ba0a59dfeb5810beb34130a0b9bd803db.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYAPR01CA0012.jpnprd01.prod.outlook.com (2603:1096:404::24)
 To LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f97031f-f121-47a2-b51d-08dcb687dfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OVgwUFpkbHM3WmpvTUZ3WjFKK1NrMjd4OTd1bXVFQ2FmbWwybCtUMGJQeDlU?=
 =?utf-8?B?Q0VSMVMzNEJ4T2I0UkxEbkVTWitRRUJQeHhCMW1rc1owUlZwbCtPekthVGM0?=
 =?utf-8?B?QXlXMTd6ZmhBTUlzVjBYNFZJREgwVE5vTVpxNnZaN2NxQldIV3lLdTRPRmNn?=
 =?utf-8?B?dGVlMGxxZUdyMjdxa3JCeHhhQTB4WUpQRnRucGUrRjVHVGswcWlaVlJ5eE54?=
 =?utf-8?B?ZGIxQ3R2c0MwQnlWQ2xrcGMvWC9FNGN4MU1ZbTBnd0QySk9DYkJuY0ZObXQx?=
 =?utf-8?B?dzFMVktrZFFSUWVQS0grbDM2Tllvdm4remd1SzYrMWtiRnFSQmU1Z0dDUTAr?=
 =?utf-8?B?WGNVK0VjcXlQMEEwUllCQTlIdll5V0s0U3M1Y2dGSFpJeXZac283WHZVUWtR?=
 =?utf-8?B?L2d6OE1CUUNxSzFWSGFqRHYvdXpuQnY0UzczRE5LNDJJd3lXQWQxaDkva0RG?=
 =?utf-8?B?bHNrbFllRjl4czQ5Wlhhc1NnaFJVTDVkR09vZ2xTVEVPVHBqV0NCSUV1eXp4?=
 =?utf-8?B?LzQ0Z2ZsaVRRUVU1bnJzaTQxamJnZytUMExlR3hFQVc3SzZ6MmpFd0cwR0to?=
 =?utf-8?B?c1hob2tyN1czOWRVTUFYYVZiVlN5RjFQTUlhZWFvclM1bStHZUxpWitBaU9r?=
 =?utf-8?B?YWdWK1BPeDJrNDhGenhQZTZDV0RFVExOZXk1d2hBcG5iWDlnOFQ4YjlDMTFD?=
 =?utf-8?B?RS9Objd4NmVQRXlRK05hNXo0VVlZTHpxejJTSVNTTXlVbFhVMDdEeWErU3A1?=
 =?utf-8?B?WmIrb0tOZS9aZHc4V2NWNmVIVjhUV1dicFF3WTRDN2pxbGFKR2ptTHZoelZh?=
 =?utf-8?B?eW1mc2FSTGRYUFI4Zko5MXdFSUxlbnMxQ1R5YXozQ2YxM2JlWXhGVGFib2J0?=
 =?utf-8?B?Z0dVK1VyQk4yT3NBU0xaMUo3UDhMdWpMY1pyc3MwSHlBZXhnZ3RPaGhSV1lj?=
 =?utf-8?B?RlVwcUgwZVp6cTFHbWRVYmVFMkdVZGhTekN2MG4zVlIyUkVSNHRpRVpCMUNF?=
 =?utf-8?B?eXE2ZWowb284SmZRZ2c3TGNhcFFGNWErMXFyYnNxYXBZYW5TOUYvMjQxUGpp?=
 =?utf-8?B?aW5EQU1HdHlzcU5rejN6UGoxQzFnWWVMUERCRFpPRCtaTXZERFFNcXRINHpq?=
 =?utf-8?B?RXgwcEg4b3JEUUF5YkFSM0gydWZ4NHdJWEplRXp4UzNuOVpIb0dXVEtja3U1?=
 =?utf-8?B?eHRjeEVEaHRVRzQ3dDIxa0xJQzBrOVk2WkxRWkF5SUEra2JtRGJuUS9uVEZR?=
 =?utf-8?B?UUJIN0FzMzFWeXlXc3FoWkcvQ2Y5cmN6bWVVZHJMV0dGaTd1dTUyY2NSd0x1?=
 =?utf-8?B?WlU5aEFnYitMNnBVWis1YjhoTWlXWTgxVnQ1MlNMY1hRVjNtQjhXSlU3TUh0?=
 =?utf-8?B?VWl4N0RwSG1GSFZvOUI5dERFTXBvNFJ6M0ZPMzQydWpYQTFlSTlUWWpSejhk?=
 =?utf-8?B?U2I0VDZDeGhqZ2l4K2dmYkFJU29NWXRYTml1M2NzOTJKU0FhUCtrOFlHbjN1?=
 =?utf-8?B?WWpmQzhoTjBacEZ0VkR5NjRwaHZMQnFWZXdjc2Vkb0h1SDhwUTl1U015NjJQ?=
 =?utf-8?B?K2hlNCtaQmxlTEtFcXlXNUpWRDFLRVdXWUoyNDJXME9qZkdwN1JINVhPRmJk?=
 =?utf-8?B?aERlQnUxTC9aVWl6YTFmUXlMNk14MzlSa3JmSnVmWHNiZmJEL09acHJwaDJn?=
 =?utf-8?B?eFBsQUYzbkVtMkMrdzluY0NJM0Z2M25Jam11dk9wSHlNWTMwQzVocDI1TUdt?=
 =?utf-8?B?emlqRUdCVllUTHIybDgzYk9kK2N5Tm5KcUtGbDk5Mk1INUlnYThDNHVuRStJ?=
 =?utf-8?B?TzY0L1p2RHYrdlRBd3BYdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzFGd0hJMDVZT0xtZ1ZXbWZzcXozYXZRMHphOTBLK3hHcW1ndlc2MXdjaExH?=
 =?utf-8?B?RkIzckV2bFBIaDZqNzVJM2hkK1hKTEVjdmIyUjh3QlM4UldYTytMSzVTUUxV?=
 =?utf-8?B?K3lLQml3T2V1U3A0VHhnYjRoU2RQNURkRHRKb1lQNHBjeEhwOFRzWEpkcGN2?=
 =?utf-8?B?SjBNQTR4Tm1iMEpnUlhtMTNHZEY2Szg5a3lwZksrY2trdTZ1V01VVG1MRng3?=
 =?utf-8?B?eVJSY3JTZVd5SzFrWXVwblRvMG9KcStvbWp1QVRGZis3RDJzNDcybUp0TTR1?=
 =?utf-8?B?YUs4UVdiNWRKVnJjOTN1TjRERlpWZXA4T2lrcjhRNHJRdWthVGpiakVtank1?=
 =?utf-8?B?c0pIa3JzdWdWcUJVYm5uMUN4clBicGR0aERDSzhVVW5qOElIZndQbE1yTy96?=
 =?utf-8?B?dTVaRDd3SnkwVHNadU55YWlBa0UxNHlUS0FQSWhkNmJtTWhSdlpkekpkdTdk?=
 =?utf-8?B?OWMzdVdWclZ4QUVMVVNYZEZQbEZBbzRERVUvaTV4dUl4eHBzNVdLY05nN1Nh?=
 =?utf-8?B?NXdUaTJqOTBXSUVKQ2dBdzIvVW1JOWZldlhyeHF2MXFQbTRUU1M5ZUxpSmpi?=
 =?utf-8?B?dk9PcGpmck95OSsvTjBnZnZLL0dlNHRLMldGQ2NJYnd6emNtTERsZWpmMHpj?=
 =?utf-8?B?QUhvblBHWkpENUtsT2dPWnR2VEgvWkwxODZBRXpUMmNyUysvL1o3ZG5iNllr?=
 =?utf-8?B?djVWQ2dvNDNxQU1jQjAxanZ5OWdVMVA3RWJLWkZIQmZnalErb3RpSXZJaGtY?=
 =?utf-8?B?WVlZYnpwZ2tBYmR1cmVrL1F3UzBQZ25XWEtUcUtwYnlmbXVDbWFJTkhaVDQx?=
 =?utf-8?B?d1hMN0xtL0lENWxwTVZtMEk2ZC9VcDh6cXM1RjdIMnRBclhwNytPZmkySHRq?=
 =?utf-8?B?WWdnTGRLRlpwS2pxbkM3THd4QlFxMXJkWXlyeHcweHB5NWRMOTUzaXdYQW9B?=
 =?utf-8?B?MjZYN0w5VmQzcy9iYnV0UWcxRFIzL01GWHNYSEE0REt2SW8rVEZBdk9OcU1U?=
 =?utf-8?B?SXg2cnNRZnhxMjJ0Vnl1dFZ2Y3dVRW56UG9jbisxa0FNR1lPUnBNZldyelFh?=
 =?utf-8?B?Um0va2lSMXhtaFNYK2NwWjFNMXQ4ZXhQM1l4RGt3NW54QzdUdGlzdDA0clQw?=
 =?utf-8?B?MUQ5NVNUKytGYVpWSHF5N0ZHSHp1SXliMGZ6ZzJqS3dGdmVacFlxWUYwaWtY?=
 =?utf-8?B?cnoxSk1VNnZ5aEhZOUpJOHVtWkU1RTBESHI2cXE3Mm1GenIwZEc0YkVCMkpM?=
 =?utf-8?B?U1BNTEt4ZG9mMkpCcnNrb3dPWmF1YzNocUYxd09XaVJCS1p6VExYMzRFamJv?=
 =?utf-8?B?Zmo5cUZ6TXFxTXZqV1J4UjRPUFRiV3JYckhZejI4a3MwZmdBdWxFZE5pcjQ4?=
 =?utf-8?B?RWNJZ1QxSmU2OFBoRGd3T1RxOUhSaERrTFhQNU9ydFJUVW80OHlCbmJoRG44?=
 =?utf-8?B?Nlo2RkVkcW5kTlIyVXlKR3oxK2dPM3JNSituV0twU3RrKzBZUGZPSjBwQlRq?=
 =?utf-8?B?cDBCYnUrRXg2ZkNBT2tpZ3dDbGZxbzQ0UHlDWXgyWmxzSkQzZ1JlTk5GaHRX?=
 =?utf-8?B?anFQRE5lTkVPdVRMZXhwS2tkbWlsUGpyRVllZk1oU1kxVzJZN3RTWGdJS2pD?=
 =?utf-8?B?SHprdkl1dUI0NHdpNkFGMTZ6SjV1ZER6Szc4RWJYakNVcHQvd0NmNUluR2FI?=
 =?utf-8?B?TUdwRjVIV0lWRjFTYXRzbkxWZ3VqMldEdlQ3SWVIc1BwWFdWdUxsYkZkSkR3?=
 =?utf-8?B?bkxRVysydmkzbGlLZzA0WUQ5aUFPeFZ6dzMwUVRnNFNBTEU2RjNiTWsxRmUw?=
 =?utf-8?B?YWxjcFVJWklSTENBV1pxVFU1WmZBMUxWQ2JoU1R6cHNCb1QrbU9VNWpPbVBm?=
 =?utf-8?B?b2RjdHM1NmlnbTlGS1Z6eHhqOVUwYU93TE1tc3dsMnlqa2pUVFNiSUp1S3Nv?=
 =?utf-8?B?YTdUcEs0ZTZjNDVWbG9GQWdPZVVGUTQvMld6YjZZM1ljZDkzN0ppY0p1cTRH?=
 =?utf-8?B?YlNXWWd2V0t6a21URlNyOUljM0tvUHNqMHNVcWpMNWN3eUVMS1U0OGVrUmo2?=
 =?utf-8?B?dWdKc3loRGdMQnc0NWhackpHNVRPaUhPTzhXQndub2l0WVFzK1hjZlo2ZTho?=
 =?utf-8?B?ekllekhXaG5jdFFRZXg2SFp3SEZTR29mSXR1QmJycWJoRU1YM2xIMGNTUFF0?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f97031f-f121-47a2-b51d-08dcb687dfe3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:23:07.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRcNHJeXbRO4fYq0AyIDeEjEIWHbxbEA2LTfWL/yEnBswn7SabZAWsQBOj/2Xiwx1c+vDWfCWKUTYkJJFKX/zUVpqSediOXF07jJHCXPxrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-Proofpoint-ORIG-GUID: MuyeDvyDSWJmgQ-tBDOIFh2Z0rhN_yV4
X-Proofpoint-GUID: JXfE3X1gX__IBCwxIey9JKOlgt9_gTad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_20,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408070014
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4772NCQl001051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Aug 2024 02:23:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16451

Hi RP,

On 8/6/24 22:10, Richard Purdie wrote:
> On Tue, 2024-08-06 at 21:42 +0800, Robert Yang wrote:
>> Hi RP and Ross,
>>
>> On 8/6/24 19:06, Richard Purdie wrote:
>>> On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via lists.openembedded=
.org wrote:
>>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>>
>>>> The previous code added local path to generated mirror tarball name =
which had
>>>> two potential issues when fetch from local PREMIRROR, for exapmle:
>>>>
>>>> Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
>>>> $ bitbake lsof -cfetch
>>>>
>>>> * There might be "Fix File name too long error" when the local path =
is long
>>>>  =C2=A0=C2=A0 since the path is translated to filename and added to =
downloads/git2/ as:
>>>>  =C2=A0=C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
>>>>
>>>> * When enable BB_GENERATE_MIRROR_TARBALLS:
>>>>  =C2=A0=C2=A0 The tarball name will be:
>>>>  =C2=A0=C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.=
tar.gz
>>>>
>>>>  =C2=A0=C2=A0 The above tarball can't be re-used by do_fetch since b=
itbake looks for
>>>>  =C2=A0=C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the 'path.=
to.local.PREMIRROR' in
>>>>  =C2=A0=C2=A0 the file name breaks the match.
>>>>
>>>> Use os.path.basename(ud.path) as gitsrcname when ud.proto is file ca=
n fix the
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
>>>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/gi=
t.py
>>>> index c7ff769fdf..89d3268f7f 100644
>>>> --- a/bitbake/lib/bb/fetch2/git.py
>>>> +++ b/bitbake/lib/bb/fetch2/git.py
>>>> @@ -277,7 +277,10 @@ class Git(FetchMethod):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedre=
v[name] =3D ud.revisions[name]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revi=
sion(ud, d, name)
>>>>   =20
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % =
(ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').r=
eplace(' ','_').replace('(', '_').replace(')', '_'))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file=
":
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
gitsrcname =3D '%s' % os.path.basename(ud.path)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', =
'.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_=
'))
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcnam=
e.startswith('.'):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 gitsrcname =3D gitsrcname[1:]
>>>
>>>
>>> I did look at this patch again. I'm still not convinced about the
>>> original use case but ignoring that, the patch itself isn't too safe.
>>
>> Thanks for looking into this, the main problem is that we need a way t=
o fix the
>> filename too long error as described in the commit message above.
>>
>>> If you have two repositories with the same name, this can break since
>>> basename() on the URI is not a unique value.
>>
>> If the two repos are identical, then it isn't a problem since bitbake
>> can handle them correctly, if the two local repos with the same
>> name but have different contents, I think that the user should fix the=
ir repos.
>=20
> The trouble is that this doesn't just affect local repos, the contents
> of DL_DIR can and will be shared as a public mirror so it is any two
> repos with the same name, not just two local repos.

This only affects protocol=3Dfile, without this patch, the

git://path/to/local/path/gitrepo.git:protocol=3Dfile

after do_fetch, it will be:

downloads/git2/path.to.local.path.gitrepo.git

The above name can't be used on public mirror because it can't be matched=
,
unless different people and projects use the same local path, but this is=
n't the
reality, for example, my local path is:

git://home/robert/to/gitrepo.git;protocol=3Dfile

When I upload it to a public mirror, it will be:
home.robert.to.gitrepo.git

For you, it might be:
git://home/rp/to/gitrepo.git;protocol=3Dfile

What your do_fetch looking for is:
home.rp.to.gitrepo.git

So it can't be fetched from public mirror, unless you use:
git://home/robert/to/gitrepo.git;protocol=3Dfile

But this isn't the reality

>=20
> This is partly why I still think mirrors of local file repos don't make
> sense.

It's not only for mirror, but will cause "Filename too long error" for no=
rmal
build's do_fetch when:

len(/home/robert/to/long/dir/gitrepo.git) > 256

You can simulate the error with the following command on Ubuntu
20.04 or 22.04:
$ touch $(for i in $(seq 1 30); do echo -n longpart$i; done)

File name too long

This is because the current code changes the path to filename, and
len(filename) > 256.

// Robert


>=20
> Cheers,
>=20
> Richard
>=20

