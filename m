Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47EFC87FCB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 03:50:31 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.66632.1754970622206224312
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 20:50:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0319aaa3f0=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57C2WI18072133
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 20:50:21 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48fvchg2d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 20:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD865CmEoydUuPILfJCH5EFzvfKC49O/NFTVbRdh1vyJCIdofqujiOVmvlVEuSwYMM5AWoXtq4toh35uN2rh+VjOE5SUhUk3z37rR7fifLmZXYNSzuN0Fq1nFwbm9t55wObT1r9WZA7RmSnj4yCphwYYijG45emnq8L6VIYcBw0zTE3geWUUJfQ5/5neAehOnoFXRrmx3iImClsUcisSxKfL5PKxTVzto6Vr9f3FT18NA46Inz8eT4ZO+jtFrKRYhg3BTOTdGuNouTq0GBblFfDw+3Lljre+sadTrNE1ZA5zV2zpExq2qB226U7P1/WbFfY5cz4hfs6VRnvVn3/8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DExOytQdRi6gk+PLwwCASldd1buPIZJcpMUOO/s2/c=;
 b=WoBxKxczkCNzSxkrkuYphiP7FjrwhZvsme1CUihvfN90CI1pHtKBIvmSiKLLVRS9UBwmGHzUv7CwRewgdJcWHFr0OnqASdxGqIafl372Og3yFvWtrGoY0r5P7VfaBKKdQ9YcwmfsLnNwujBv1N+GVEMzK8ZXygIxo7V/YEQCyohT+R5bze4tINgXcHUmTXjfesOf4MBfHjy8PSHY+s/T+QDvsPHrNb9YWbbFHyjxVnbOej1+g32wUDmFFYjVzOB4WJ67GnIr+JlzsOwk0Ewn1Ya7CXwWYlKhL5dxRjR1y/2q4mTDIpL2DsSB74mZRtMsLKNP5uWv61S/Tg3M73Ev2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 03:50:18 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 03:50:17 +0000
Message-ID: <d749943b-dc5f-4ac8-9d31-01a8b99be2f0@windriver.com>
Date: Tue, 12 Aug 2025 11:50:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2 1/1] fetch2: try_mirror_url(): Skip
 invalid local url
To: bitbake-devel@lists.openembedded.org, alex.kanavin@gmail.com
References: <cover.1754925741.git.liezhi.yang@windriver.com>
 <e56a4f7e3c7bff7b86cecc32c2fcd43a63db0620.1754925741.git.liezhi.yang@windriver.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <e56a4f7e3c7bff7b86cecc32c2fcd43a63db0620.1754925741.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|SN7PR11MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c561cf0-7304-4384-01ab-08ddd9535a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b29tVENJaUhqa21iMmtoeVJhZzMxK3o1SWpGYnpOZHRxdHRPRHp2NWZITkdF?=
 =?utf-8?B?SlZWTnJSU3F5M1UxelBEOW1vN1J4eG5EUWswL1pKK1h0bDNHUFJFZGdrSDh2?=
 =?utf-8?B?cEdaQVFreGRTOEZVMTkzWnpaLzNURWJBVmNGemFyaXptTmxnN0o3bXlMK3po?=
 =?utf-8?B?SjB6aEY2dWxneCtKd3p4U0F3eTZWd0dDOEVZU0JsUHJVREV3cmRLUjNqclQ2?=
 =?utf-8?B?eU1aV3pnbncyS2V5K2lvc21CSGxUek1HNEpsbnZhOVF1Ly9jV1hLSHIrU2Ry?=
 =?utf-8?B?ZGtyeU5UMnhWd1hDTkpZMmFWcXFTc055d2xjaUprQm1jUXRFU1hlRWt2VjZM?=
 =?utf-8?B?T2lDaUNUM1AxTDFFaHpNM0EzVzlmaHFKQkpvVWFmTXRGTit1RFhCR0JzSWc4?=
 =?utf-8?B?aHZIMGRDT3hBOUFiODgxWjJaVm9rak5IL1JOSk05VktZQjVPNmpQNHpiMDc1?=
 =?utf-8?B?QlpzQ0ZiQkpIMXdhWDVhazJpRjVHNjlsQjkyYUtENnNWZFJTVGZvUFhPbFhP?=
 =?utf-8?B?ZFVvUTArTlVJdVdLR3FNT2NGbGJLUEZmSDBFblhvL3ZneE5CTVovRi9yZlky?=
 =?utf-8?B?LzNObzFLOERFU0hyWmhIUFh2amZmYmJFUWZ5Uy9hTEl1a1cwOXpERFhPZFU3?=
 =?utf-8?B?Kyt3bVhZd2tSRG9DUkpHK21HOGFDUUJiQlAzdGJlQW8xSm53R1N3djA2WWFQ?=
 =?utf-8?B?TTBMSVlJMTNZSEt6aVpSNE1yK3VYSDI0aDJCVTJ4OXhiaXpta01tUG1NK01k?=
 =?utf-8?B?SVh5TjV3Ri9LajdYaVRGZFdIcmtRazQ5WENPTzU0am9aQzhJdVVzNWl6VFVh?=
 =?utf-8?B?bmJCNFJVWDU5Y3ZKNWxQdEk4Y3lHWmFqbWRKditjVWd3cWlCMWt6eHAxTjFz?=
 =?utf-8?B?Mm4wMVhDZDRYekNUL2VNc2JpZHdDbzZPbUhRMUl2MEp3NjJXQVZCWFFOOXpG?=
 =?utf-8?B?bEZ0U2RDZDk5dVN0WGgxSTN5RmpCY2RRM01OQkdwcTBZc0R5R2VJSUFQb3Zi?=
 =?utf-8?B?RDhsN0V3SHh0Qm9ScXRGY1JqQVI5YVVjSEZvakkrNjZ0Y3ZUSWI3Q0g2c0lC?=
 =?utf-8?B?bXdwVmtnOUlHTWZIOEhrUFpPVm1pOGNQRFlWWEdDWkd1RmJ5c1ByWWJ2ME4v?=
 =?utf-8?B?SUlITmVlOGRLc0pDL0cvS1BNL0d1cDBETzBvem94eU5YQkpVVkRVSklhU09K?=
 =?utf-8?B?aFpTUGdSenhrZXR4UDBiSnlaaFFQajh0UmpsUHJrWGhOTExTN2ZJeGJBZkwz?=
 =?utf-8?B?TXV2TjhVZFJNRURrSGdxUXluU2RUSkdVU2cyNm1UbHUrYzlUQS8yTmNCeng5?=
 =?utf-8?B?dkRscGkwSThJdW1VWkdKakdYU0xvSmZrK3c5elM2OUNWMFNKM0h2MHF1R0Nr?=
 =?utf-8?B?U05hZVZNNHFNdExZeWhZU21obUNHcHZqYitDL1UzdUNDNW8vODZVd0w1a3dV?=
 =?utf-8?B?ejFCSS9nUVlIMU5XRDAwbk9aQ0JjU0ttdmdsSUtkN29ZcVQyemFYU0R4V1Fy?=
 =?utf-8?B?YU5uWWQvaDBDdjc3aHpyRjNBL1JJeGdJcklnN1BGZXNCT09CS1ZmaWFndkVF?=
 =?utf-8?B?dHNUQjZJcUJ5Qks1elZZL3pYNmpkZUZkOHk5eXNrL1FxelVBTnpoTnp2Zmhp?=
 =?utf-8?B?aGhaK2IraVpCWThPZGxscmI3c1hlSU5vZGc3MUxiM1h3TE1KUW9MZnRCSFMx?=
 =?utf-8?B?aG9ydHpOakdZQ0Q1U1BxZlF5ekNXcTZhNmN4NzlRVGlzQk9nSFZReEU5dzJD?=
 =?utf-8?B?UmFkZ1ZTVDRnODNHSGUveTRadTlHVlg3OUt0dXVaeU1FUjVCTmNDTS9yYTE0?=
 =?utf-8?B?ZHF6bFloNlpuNlBlQnhaVjQ5dFhvUDBDNStMeTBvTDY3dmJBY1V5VE9reGpt?=
 =?utf-8?Q?M8F+I+iFO2y4D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2l4U3JiRlhkaFBFbzQ2ZDBzZkdXY2ZrVEFoSFZGKzZlWk8rNHNNQjBrSTFw?=
 =?utf-8?B?bEtoRGVGZ1dqR0xud05TZndJdzFaUUVvUVNOWWtvY216YlhIWGhxVVMxUmc2?=
 =?utf-8?B?VGR2MW1kaVFOQzNidVYyVlhseUptRGVackFDUG5zVmVPMGprMGEwZkhnRzRL?=
 =?utf-8?B?Y2Q1dkd1OFBKclJkZE1CTVdobzlObUY4ekRzY2o3cmJFbUFWUnNqT2tpbGJn?=
 =?utf-8?B?LzlFYmhwcDE1MHJ3UzhBbGd0SWNyS0ZGNmQvSWpJeWRid3F4RndrdXY4WElE?=
 =?utf-8?B?TldVbGpUVSt0YVhzWHhZY0M5QmNXdGVDR3JQMldlazZQVXFmQjhQMm1iRms0?=
 =?utf-8?B?T0RabjA5enZ1NGd1blVGb2lwQXd0T0xHazBjRXpDVWN2R296UVBxbG1NUU4v?=
 =?utf-8?B?RDJ3Y3FSaTBnRXE5ZTJwb2lJNk9YalU5NkhZclBZTUtCMDRianhLRDI0QW01?=
 =?utf-8?B?M0U3N1ZtNUMxa0Q3Q3B5WFc5SmRMNzNYdXlpekU3R1E0Zkd5YkZVVFJZdUdF?=
 =?utf-8?B?UmJZaXJWZjdiUkNIbE12TUdFRnlhOWxERWpOSzJ4T2xHU0xpRHpsb3NDanZu?=
 =?utf-8?B?M0EvQW83SXp2OFRsQVlKZ2x2bm9EWWhjcy80L0N2TFFzU2N0NmtlbVdVY1RU?=
 =?utf-8?B?aStjZjVXN1FrRllwMVhOT2grQXlRaXhKY09vWEdxaVlEOTZ5MFpZTzhydGpZ?=
 =?utf-8?B?cjlVMkh1M1p0SDQxVFRhQ092NXRPdzNEWlNmWVExSHQ1Ymw0OTZvNVBXQ3JD?=
 =?utf-8?B?QzNkQkNwVk1zU0hnQ213cFNJTjkxMU9DOWIvdGhSRDJkYkcxNlVPQnIybEZj?=
 =?utf-8?B?Sm56TkJCN0w2cmR3YjJVM0xSdWU5eHpLOWFUeFZQZytZUXFydWx3VTdBNDAv?=
 =?utf-8?B?Um0zNytreGladmgweHB4UHprbUpUb3BidzJhc283bndTZ3VoY28vWm5CamxJ?=
 =?utf-8?B?dFlxdzFGa1NQd3RnTEhhaklHeTdxMm1LMUxKUmRYaWJQRkx2UVhuNVZmNDA3?=
 =?utf-8?B?ZFZubDU5M3g0ZHM0cGNpZDIrNllRZDNBWmFLQXk1SElmS2xzd29SUFVXNXNl?=
 =?utf-8?B?a1JDaWVFUWZaYzRQSnNWN2ZnVnBOQ2xuM0paNUZ3c3N6ZEUzeVJFMHFwZldR?=
 =?utf-8?B?MFlCamRyR1BQTm5YV3dESG91dlROZU15b2FUb2lHYmN6K0p4WDR4c01BdnVp?=
 =?utf-8?B?SDVpbkgxLy9oUXRKZUppK2xNbmdHcjRjZE10OWNXN2JxaVJhQVAyTjJTNlN2?=
 =?utf-8?B?ZWc1YVBlK3FlVjViMDBMdlVjZEdWR2JrRUszMkNBQ1VvMVAwZjRPRkVtSTV0?=
 =?utf-8?B?R1hoK29UeHB5amV3a3hzNG11TE5FYjFLYUtERTBDS3d6MDExUDFZUm9TbDhI?=
 =?utf-8?B?NzBqYUNTYWpoNGgwVTgzMURrN2lBeXNMakcva2FyaXBHejZyUUNJck9jcGxV?=
 =?utf-8?B?SVdCZmhIeEtMcDBhS0RpMkhCUTFxYk9KK0tVQ25XeTRDZzg4SG1hWTdsaEp2?=
 =?utf-8?B?cnVKVCtZcUwxWXp5L1UvaE9xSnN6QUx4eVVINkttMWo2WWVUSVFHdkNGTGRl?=
 =?utf-8?B?ZWhXN3RuZTFaSlZJbTQ4MkF6eVpLeWpTaWwzOUF1by9sNHpnVFkrcm9EZ0Ri?=
 =?utf-8?B?NUNDU2xpODJoMWFJQ3BxM1J4YnI2dVpMRzdTTHN5UlpIdGRVMlpCaVRmYnlj?=
 =?utf-8?B?dC9RQk5PZWJxYnF2bWpLU01vYWlvV1dpcW4vL0FqblNDLzVWKzRsRTYrZDND?=
 =?utf-8?B?QW4xNWNZRVNmSFFhVzBwSmNXWHNyRVFoQ01TaVdpa0taUjgzeEpyYXJwQW05?=
 =?utf-8?B?SWZIaVVVaDBMVWl3T1BiYThhcW85b04zbzBMY28xTFJCOCt1VnZOeHZEOUdG?=
 =?utf-8?B?dThmSFVFMTd2elpyZ2dIODExWitkNFJMeVVsVUkvcWJkUVNMVWp6YkF0QVNP?=
 =?utf-8?B?OGtGQUhCY1dLb0V6ZXVOeWFySnNpYWVhN21KWmk4RUt0U0lrNjNtTUl4VGtH?=
 =?utf-8?B?WDhyalpjTTlmYlYyWWhMUmlOY3Q3SDhkOWwzdDAzM21xajVFQ081ZGNkMlhm?=
 =?utf-8?B?bFRCVmpaOWJNd2NUUWdUVFN5ZEI5VVhNdzYrbGZyRFdXbGZzNVlCVWo0a0hs?=
 =?utf-8?B?TGNsbjRvRFBhT2xHYVhsOU5ENGxUaUs1L05aUmpLTmVQTWNpRUEyaFVzNWNY?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c561cf0-7304-4384-01ab-08ddd9535a2d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:50:17.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN0tSEAXZKU3rT5d26sKdeDZ0NggZO6xoJe6AH7+EfTh1PHYreCiRxOq1kjNGujNa4WUPFxjAGSIG38ezCDIBS3isiy60k6ZP8VmEZ7cDq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: A2BdI3hLaFuS94lhwoWLjqHhhWln5_B1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAzMiBTYWx0ZWRfX8S7+vuNNCDmj
 TRF64VKaWoQnVGNdMo3erNNpE3VPvpWGyuhtz9ZYg1OH58OGMZQfQWtgyKcJU8FrMpe3M+0cTXf
 ChwqypUJpdGVOYk9+GP0YnKbKwGyrgOp9YNKh4ObzTZ2CIgqvNgmdK52nF151Aik13KtMCeA8Ms
 eyNhDR/PjdxJ++Mz1r7QRnBUCps6fhCAmC1lagZAPI+SNIUTwkKdyB1tvyZf4wfmdzeA+aEg5bh
 NEWD3cYI1X9S9Bf8b0Iu9wiGz8JLF0Dfxc7OrpXnaD0Q/kJv5geXlxI+qKm7v5ELD3+SIZ0f7vN
 ZCQNOYeaJXilUPtnWw+PSRkFj1KvhxsGMgZyjxz3KKRhkj1bBh6EOyjxswIUT4=
X-Proofpoint-ORIG-GUID: pxDbkxg41s7cMLFR5Pehc1bejChBwdI-
X-Authority-Analysis: v=2.4 cv=RPGzH5i+ c=1 sm=1 tr=0 ts=689ab9fd cx=c_pps
 a=QUtXFPAb5mKcHpv79NJyxA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Q4-j1AaZAAAA:8
 a=t7CeM3EgAAAA:8 a=zUmbyakpW4_9nEET40kA:9 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 03:50:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17864



On 8/11/25 23:41, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> There can be multiple PREMIRRORs each PREMIRROR contains specifics sources for
> each layer, each recipe will try the PREMIRRORs one by one until succeed, but
> the trying would be failed if the PREMIRROR doesn't contain the required
> sources, so return it immediately to make log.do_fetch clean, and tt also can
> fix a warning when BB_GIT_SHALLOW and is enabled and failed to fetch the source
> from the PREMIRROR:
> 
> Fast shallow clone failed, try to skip fast mode now.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>   bitbake/lib/bb/fetch2/__init__.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 0ad987c596..1bab8f7f57 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1067,6 +1067,10 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
>       # Return of None or a value means we're finished
>       # False means try another url
>   
> +    # Skip fetching it when the local url's path doesn't exist
> +    if ud.parm.get('protocol', '') == 'file' and not os.path.exists(ud.path):

Sorry, this patch is incorrect, I need check repo and repo.git because git works 
with or without .git suffix. Will send a V3 for it.

// Robert

> +        return False
 > +>       if ud.lockfile and ud.lockfile != origud.lockfile:
>           lf = bb.utils.lockfile(ud.lockfile)
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17861): https://lists.openembedded.org/g/bitbake-devel/message/17861
> Mute This Topic: https://lists.openembedded.org/mt/114649737/7304958
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


