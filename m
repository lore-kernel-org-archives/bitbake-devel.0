Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745BC3ABC5
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 06:33:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.95749.1747204423666404722
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 May 2025 23:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=72298db702=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E5xO3m004555
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 May 2025 23:33:43 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbca0p22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 May 2025 23:33:42 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54E6XgUu023562;
	Tue, 13 May 2025 23:33:42 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbca0p21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 23:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfHjbY1EPRnVa0WyYn4bqVpNjdiE6sjzEO2qvQ+GdjNfEABD891JBUjcwwio3A6fw6RKZUxSh0leSjSBDVcXGlXSYGkQiCmyJcJfAQ+XaPTHHtcOj1PSUX2L6yQO+zLTSX+YvbF/XPHEE4f2I8bjcPlqxksdJ/svqXgHPc+I2TMHXx7GVwrPnES71Z6ymAyZFC5H4FsvvwPNDV2QhooWDtpAFXnbqooCHS+f7adNEtlcrl7H4Afs1y9rbNvuh0lO6e/yn4KSsSQ804H4MIqooIAGQKr431K1A3GMGMnWlnkNBJfGdneoMH5M4FjmwHCWGMWfzFqYrr4Ki33QOwXtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG99v/Lk5LUPyJpnxq/nNMbWV/4Eo/s0Aiwz3VGNxbo=;
 b=dH2cGb0lWLBHEJysizITgq89NOT8bnJUJ3ptTibGcs4fmiDePi54HFEezq6S6bL2PMrgyB5yrIAyEg0+k4/aYIF6mm/tGDZoYqPzeBVZKtyt+zm319zcrNc+fPGxItpOETJhl1evfMpbicpSrNkiptu2gHB7+y3lBIu9U1Ht2MYAYImmji65pJMSIiH/cHhCdS3haq8Rx2924F3GdDugXxyZrOcGz0lMb/NKQCWecNZPbdsdT93yQ48JSBDf/II8DI5hkokl3/yWF4lgTeCRfEZXYlkfNM6HuQuWlG2UXeg36IWbNGj35XsJ0s7DyQCR9nA3t3P+edG74ETXsUhILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB6270.namprd11.prod.outlook.com (2603:10b6:8:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 06:33:37 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 06:33:37 +0000
Message-ID: <b680eae5-c7c5-4fdc-8934-d4f8acdfe7fe@windriver.com>
Date: Wed, 14 May 2025 14:33:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] fetch2/git: fix shallow clone for tag
 containing slash
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org,
        liezhi.yang@windriver.com
References: <20250514050900.2096691-1-Qi.Chen@windriver.com>
 <49e877afefd86763dc916c0f5f6445026986c752.camel@linuxfoundation.org>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <49e877afefd86763dc916c0f5f6445026986c752.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS7PR11MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: d471e0c6-917b-4c69-c41b-08dd92b14233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M3g2aHAzVUN2bXFndllLekVkS1drWnozc25zMHpZSE5OcmswU0g3T2J3SnVF?=
 =?utf-8?B?SzVSSllYZk5pM1dIb0F2Y0s1K3BNb3ByM3RybjVaNXhId2Y4a1RJZ3hwelV0?=
 =?utf-8?B?cWRCSmlGcUVwNThQSEV6OXpTRUFQTDNtV0dkZ3dScjdOcDFBZFhGTU1nT2cx?=
 =?utf-8?B?a2d3dnc5L0RmR0tGNWFGN3VmZUFyMHVnNTdiUEpIZFhSUldPeVVPbklwL0ZE?=
 =?utf-8?B?NWI2ZVA3TWd5VlIrUVR4VHJZalhnWnFtblBtSk80eUZuZmhtK0N6amhLMW9u?=
 =?utf-8?B?bXR5OHpsSU5HQmNIcWhOSEZISjB2VHlSbmFuQXVOZnNiRndxTmtpa1VVdEhM?=
 =?utf-8?B?aUFVVWJ1SUI0a3dSYnlPUlJTOXFCVUpKRTAzRVM1a2xvS1Jwdjd3aFlhZmtH?=
 =?utf-8?B?VGd4ektBcHVPTVUwVHdVMXA4cURKTHd3VGRUSXpsTHZlNmNBaU1rUXp1bkcw?=
 =?utf-8?B?TDZOOU9wTTh5SGhFL01mbzdmTEd4NGVlcEFSRXFlOEFSaUt1WC9XaHNmVlNq?=
 =?utf-8?B?b0xJUjdtUFZWTFk2blRUcDhKanY3TjZtL3ZSK0xhU3VFRTNaNy9rajNTWDZB?=
 =?utf-8?B?cnRDVUd3MGFjcE02MVc2QkJ2VUlIaWRkb3BjVVZiWHZPNmlTNmlXeGlmb3gw?=
 =?utf-8?B?Y1dqR0VyTVpxbmpoMnNvdEdFRTVZMWVhMFgyMnZreUw2SVAyMm5Vd1lqVnl1?=
 =?utf-8?B?Zll5VisycS9aK1VFYWl6S3l5LzVla0xUQVBKbmRWVm5XcU9LY1NwRllFNzRw?=
 =?utf-8?B?Y3hFOEd5K0x1M1BZdFVhdGQ1R2E4TUliaDljNnZmV0s1Z25tS3hFTXFVK0Js?=
 =?utf-8?B?OTA2UjRqTkdVUG9mZUlxSG52MWhOTkhrZ3gvc3NiMHFYUGZXd0ovUkZ1SzJs?=
 =?utf-8?B?d1dubGNaQWdMYUFlUEdsVS95K0Q4VUlmK1hDWVNXWER3cVJ5WDk0OU1ualRM?=
 =?utf-8?B?eUFQaXBSdUI1dmFOUkR5dXNOT3NxMHlEeEg5cVhPd1hOWllwR1ZNdlFnYzhJ?=
 =?utf-8?B?Qkh6eW1qOFp4RnhlWkozS25VOG5vbXE0VmloSkN1YXovRkpIeStMZnJrUVM1?=
 =?utf-8?B?V0JYdmVWUngwWjVJWXJJdGNma01iZFhrTitBeVR1bGdqTU0rL21xV1NDbUIx?=
 =?utf-8?B?eWlrMGNGeGR5K0JSRUxzS2xrTnVnek0xTml3aGhNd1VldXdUTlJzWGxSblNy?=
 =?utf-8?B?YkdrbHpiYXpIMGt1VlRoTzJjNFZQZzNYY2lzWUZyMnVhZmhFTGduamQ0OFla?=
 =?utf-8?B?d3lJMlFhSW56OGptZUg0bFNLN1pNL1lDOWpxN2dFekwrekVORWt5NnZFQ2tO?=
 =?utf-8?B?Kzgvd0c5akFsUDVua0dEYUw1WlBsald0QzBIMWFxS1dEaU5SSEJmMElnRUxp?=
 =?utf-8?B?UW1XRzFGK1BTZ0RrTHZMVFlDb3FjbXNjdENWOU5nNmJJMEJETFN2QW5pMFJu?=
 =?utf-8?B?NEJDdFhKYk1WVFdBSk80ei9td3lNdnZLVFJIQ08zdlIyeU50cWF1YmpkRXh5?=
 =?utf-8?B?VVZ1Y1EwN3BqQVMyL3hEZE54V0wybkdBUGRUTTVQQWVYd05qS2NVTzcrM3Vj?=
 =?utf-8?B?T2YrVGpDV0dZMStsVzA0eFR4Y2pxaDU4Wk5VaTdVWkVpOWhhSitENWdBT1FF?=
 =?utf-8?B?c2JTRGZSZDlBY0gyWW5GVmdRZHpBS0NieEd1QWdBZWF2RlpRd2RDeDlBb25H?=
 =?utf-8?B?dXE1clNTdG5DYXk4NVJJcHNRT2ZnNXZyY05Nck9CWnBHbUEyN1NEbFRuN3B0?=
 =?utf-8?B?M0N1MkJVR1RiNEkxTlVTeVZUV0taVlZJZ1FHVGpwbzlWbDJyTENqU1NXS3FS?=
 =?utf-8?B?VzA5b051U2dmd0JnelFGeHZ2cnRodVArU2x1K1RXaHJCamVuU2FyZmxSMlph?=
 =?utf-8?Q?emKr78xtb4K2M?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnNuTGxiN0VjL05DVnk2WmRQa2U1bmExM2thK1NobmFsYUc2Vk13ck1XVWQz?=
 =?utf-8?B?RVhqc1FubmYwSEZNU1ZBMG9yUjhLNjBPUmZMUkFhRENQWWhLTHhlNTFVSncw?=
 =?utf-8?B?OFFxdWIwbzJUWHk5TEZXTTIzSEFkQmY0NWJQUVBIUkZnY1BWTVRxQmVvWXFI?=
 =?utf-8?B?YmVsLzBUWTRtSkVqRlo5SkpEM0Q0cVBhbDZXek5aZzQxSlNqZW9IZy9haHJn?=
 =?utf-8?B?WjdjZ3BrL1g2YU9lR3hjc0MxdklQTk0rMHlrM0xIWnA5UmpleFNqQXo3RTgy?=
 =?utf-8?B?MWJTemVqbEVXYkI1TnQ2OFJUdnFDbUp1bFR0bFhYWFNyUjVCOFB0RE9sektI?=
 =?utf-8?B?QTU4NTMvK0NPRmR1b3pBRk1VZnk1OC8rYjhUQ3dlcmNEeW5mYkU4VXJEVUVL?=
 =?utf-8?B?SC82Y296WUdpK25DSy9CTzZrQzVZOVdQQ1JzTWhUZ0NiTVZ1c3hPalF6bEly?=
 =?utf-8?B?czhrc2VOeDJGMmxrRzVvY3gyUGQ1VWp1dEIvVDhyWHRhUEE0ajYwZzZqMW9G?=
 =?utf-8?B?Wk42NVp2YnQ2UklwRG80TWJRc3h3WlF4UHdka2lNdVFnUDhXcEloY0o1ak1x?=
 =?utf-8?B?V1QxdUtpUHBRREhXcWlDYU5xeG5TQ2E4YmtSQmptVUFsdENnc0ZsMVV4VTJR?=
 =?utf-8?B?M2ZYUzlxdFcwWjE1dVNza2hTK1RuVTU4UGlTeGhtV3FNZTJDYzBxUUoycElV?=
 =?utf-8?B?cmJHMy9reTVuZno2YWFRU2ZQS3lBenFVUGlCZ1R0QU96R0VPRUFuSXZTWURU?=
 =?utf-8?B?OUc5R1BCcUVwVXJuNjVlU043NG1lZ0FSREY2S2JOc2FEUnUzTTFNNlNEZ21Y?=
 =?utf-8?B?QklnMFRxWFFyMFVQZHUxbm82ODVrQkJEa21INjdiQ1RQVGdHMjVScHlCM3Qz?=
 =?utf-8?B?NVhscWdXMW96Unk4WGlaS3hDSHN2Nzd3Ti9SVStiZWozMldOK3UzeC95VTVP?=
 =?utf-8?B?SEQ1Vlk4eENhOHNXdjRocWdQYzhnL2Q0LzBQVTlzNEwxdGR5L0VURHNJTkJV?=
 =?utf-8?B?VkZtVXI3MjZkbXNROHVXOVU1WGVoUFZGNWdweEpJYURIUGdBcnNlMkFWR1Vj?=
 =?utf-8?B?NlIvWUZzeFNuZGVVWHVJTXlQUUNSSUlpMHJwOWNMemxtQWNiQkNxOTRLSEtq?=
 =?utf-8?B?MnMzZGR5dE9aYnVHOS9LZC94MU02dHh4bHJTclVLOWtWRVNscFZnZ1J1RnJj?=
 =?utf-8?B?U0g3Qld5ODJ1ODNVcyszbUpuYVBHM0ljT1FKN0x5U1Z3TTFOdUhDOTFabmw5?=
 =?utf-8?B?blhJSFQveVlHelZyMFNUZUhFWlg3c0FFYWovYW1OTkg0NHJBcHIyUEQwVDd0?=
 =?utf-8?B?NkxvM0U3WElDci9aWnFzQ0FyLzJtcmU5aXljNHVNcmovMWp2SWN4WDN0NUJn?=
 =?utf-8?B?RkJEdTNudjFuZHZUSFZFeWtmUDBPTGY2MEJ3dEN6aXBZc0JHZGZ2MGZYeXRp?=
 =?utf-8?B?YXptVzdET1dNN2ovT2h2K013TXNTUUg1QTZ1cG9VdnUyazh2eHFXUmh2cW5z?=
 =?utf-8?B?SnIyVUkyRTlUYVFSN1dnNDVZV0NiekdJdU0wMFBRSkpjMmdGTkt6ZFZ2R1l6?=
 =?utf-8?B?ekhzSlZaeTcrdDg0N2dHVjdhYnViWG5pT05LdkgwRnAzZHRNWmZEa1kvRUtR?=
 =?utf-8?B?K3ZmSWlERDU4UWUwbi8xcXQ2cy9pQWRPZXljRGIwRGJxQUdoL2QveHh6cmwr?=
 =?utf-8?B?bzBrRXZqYkNpWllITXBVOFBjSjVVNU5JNVd2S1I4cTFUbDJzQ1o2Yi9NdnI5?=
 =?utf-8?B?RE9RZW1jdWRRaGJqM3BvbGxZQklCRjZ3RGtsT2pkbUlTbGpHSlZXaWVzU21B?=
 =?utf-8?B?WUl2bVg4d3FIZkxFRHhIQ0NReFN6N0JnWVp2aTNUOUtkdmJYZm40MVdFdlIw?=
 =?utf-8?B?WEw3RHNUMjZjOVBtVEhnZTA1RmRVUzZTMWkreXBXMG5ncWZKZGlwSFN5UzRx?=
 =?utf-8?B?aGdBd3JsRWVCdzdDMWE3VEwvaUFKY3d4UDdaMUZxU1hoVFM2MEYwb3NYUVlu?=
 =?utf-8?B?VndOS3hXOGxvcUNlRmw0Zk9qRWtGcEk2dGZic1JQTEk3YVM5NkFpa1VaNGli?=
 =?utf-8?B?V2NmM004WitGenZWSW1SK0pTb2Z4SGlmOGthVmhiSk11eWZleGRjWldlWTVl?=
 =?utf-8?Q?UgUnt06ueoQKihhpgsdgvzk22?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d471e0c6-917b-4c69-c41b-08dd92b14233
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 06:33:37.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n27Holj3+DPn51ghtSm8EYvbmliiJK+XCyObuq7XRrkvdBOh/fw2bUq5uxLUhKjWPZjW7kvaxa7WTmkKuFvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6270
X-Proofpoint-ORIG-GUID: Vu_kYwmpYR7JWu6e-cKsdAf3SB5jmmBN
X-Authority-Analysis: v=2.4 cv=P446hjAu c=1 sm=1 tr=0 ts=68243947 cx=c_pps a=+hq7TYb7Jqj0EztKBnUMzg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=q-hodRoI4bQrUZbdD6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: BUaZ1JAH-sMtOQVHtQOxPAt8VFLMAFNu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA1NSBTYWx0ZWRfX2/C3j0L9dRlm vysg3/zwHJtlLdMP+tCh6TlKMiCIOcGHwKTeM9LuYav+uIrWVAR+U5kJjqwesBrj2lidLqbl3h1 80r/J38amx3Kmll2gsLS379h6xnkO+LP80BpU0SqakznVAgNi1WWlD0bkotHpVAaNCMSzg39/mr
 qGhl/imdEDVwpSuhbHKIArrKhXDwizhRS1SG+y1s7GalFdKSDvQbMTj7FrIVATUGM1EX1HL8RCz iiW6JbYtiskh5h3tUwRh6k8Ohmquk9Dxao7qS3tG7PcnXJAu6dzcCgVspvFnJ3xebN7xK6uusgk cxleNlXgVB1XOnOabN86H1QhZgsZrJkRo4yq34rGgfjH3JFj24Hy9OxqcHBecjc48jxHAi56OxO
 uPeoMscb8ZN/mMsAQgD56WNMbrpG6Z/Z2O88nb5bdJxFr1VS415UdPpvvqGDM0o7IhUaA2pI
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=949 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505140055
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 54E5xO3m004555
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 06:33:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17607

On 5/14/25 14:28, Richard Purdie via lists.openembedded.org wrote:
> On Wed, 2025-05-14 at 13:09 +0800, Chen Qi via lists.openembedded.org w=
rote:
>> From: Chen Qi <Qi.Chen@windriver.com>
>>
>> If a tag contains slash, e.g., debian/5.22, then shallow clone
>> fails because it's using a wrong ref.
>>
>> To reproduce the issue, add the following lines in local.conf:
>>
>>  =C2=A0 BB_GIT_SHALLOW =3D "1"
>>  =C2=A0 BB_GENERATE_SHALLOW_TARBALLS =3D "1"
>>
>> And then run 'bitbake debianutils -c fetch'.
>>
>> What the original os.path.basename(ref) wanted to do is to remove
>> the strings such as refs/heads/. So we do it explitly to fix this
>> issue.
>>
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>> ---
>>  =C2=A0bitbake/lib/bb/fetch2/git.py | 2 +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.=
py
>> index 11cda2007d..784a45bda2 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -639,7 +639,7 @@ class Git(FetchMethod):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extra_refs.append(r)
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for ref in extra_ref=
s:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
f_fetch =3D os.path.basename(ref)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
f_fetch =3D ref.replace('refs/heads/', '').replace('refs/remotes/origin/'=
, '').replace('refs/tags/', '')
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 runfetchcmd("%s fetch origin --depth 1 %s" % (ud.basecmd, ref_fetch),=
 d, workdir=3Ddest)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 revision =3D runfetchcmd("%s rev-parse FETCH_HEAD" % ud.basecmd, d, w=
orkdir=3Ddest)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, w=
orkdir=3Ddest)
>>
> Thanks, I just saw a few people reporting this.
>
> Would it be possible to add a test case to bitbake-selftest so we can
> esure this doesn't regress in future?

Got it. I'll add a testcase and send out a new patch.

Regards,
Qi

>
> Cheers,
>
> Richard
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17606): https://lists.openembedded.org/g/bitbake-de=
vel/message/17606
> Mute This Topic: https://lists.openembedded.org/mt/113103962/7304865
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.C=
hen@eng.windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


