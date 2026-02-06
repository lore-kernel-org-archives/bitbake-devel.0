Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F6ECD9BE
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 02:40:09 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2670.1770345606520692337
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 18:40:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=U2O4GPMx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6497a20563=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616102lJ4007988
	for <bitbake-devel@lists.openembedded.org>; Thu, 5 Feb 2026 18:40:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DZaAN00b7mfmgIt1zIVa9iYoNbJSjbQRR4I43XTRIoU=; b=
	U2O4GPMxCpJiPDeXAUPImFiHVJxSO6gh8XdqFRTlJxvrDii/QtUv6TYmlWdIuYLx
	uEwZisyZEDjkxMsRC2ScNycx54kyK91v/Ku5lK1cZkFVJ5afvEYdnOzCVYgEk2Ps
	5ULMQ7i7DWivFa/XfqbnvTPa48tvnQgUwTapMtKwePRQiCjvfgi+/MhGHByv4O9X
	lpqbZttoZUPVi4ZEDLkoJ53ETk1Qq0fhTv1rhMSVlOyWHDUOXDAjycYlX52p/RqK
	lYYtFwNVf8BFyIAlkmki23UUTBTaFT9C251UU1/PLefXUsOBfiLhKDg/wY9GMxE/
	Lttg2JXzNw8qvw7j248inQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c4jhd1hhy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 18:40:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anFmP0xduwgn8Br3YiU3Xg5IX3U0BRgizaIbwywocmeL2PqkvJQ6TLEALpLsRQrDQXbPEzQ6m/Wc3oT1qy9mc1Ki6VAFLVfFT7I9riIaKTMa3TfDP2Xo8a55wu8QGFqiPD8ecvLIIPwCiOEJCud5/AIwaRMJUohN9I/j89Bp1vRLjmgj1Uz0cYncyKCzd1upCUuCbwfOLpjMa0wLG6Ylm69TNkOHUoECkdKwePoeyudBm2msO+TS3/JBPkIxSyccnIVVNRrGrf8r0mi8IxBHPFumM/nfI7/TUL4HawreMvZKyZCQIEFfpt6QVKC1pavAQJMrTvZ1HPnzLmiIs4cOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZaAN00b7mfmgIt1zIVa9iYoNbJSjbQRR4I43XTRIoU=;
 b=xrcvp5Y2dMObBlWRBsX4C4qJGkezJcg8pSevuwcIInxfGsDyeLD8RmObU1RVGQGdQKncLc9Xcpv1dgHiE1YP/I0KISnaO29ATUKznfDC2lmrZDqKcK6FoRJP6MNlQRdOfzbcZM6lHelTtlfpeEYNcFnW1Vyn+mtp9HTSwoNbo+7/guLZcy2y+ild6iNGKspZ+keNU6PE3c+2Zh2nixyl/TuFdfDuvx9Mr/9is8PjpJw+ufOp5bkvMKRa6AZWV6w/fTRXO5gvuW5J7psgdcp6TYTUMtplwiFgV56yrjgCvwpnParcrh7wCUPgcvVUrou1ZVPFu5C1wy5fkEYkkm7uLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 02:40:03 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 02:40:02 +0000
Message-ID: <1a45c3f2-378f-4dc0-a648-84f9b82b2fc2@windriver.com>
Date: Fri, 6 Feb 2026 10:39:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1885DEB2FD4F0640.2047557@lists.openembedded.org>
 <188C9E9E281EE6E7.3547823@lists.openembedded.org>
 <be5f86b4-22ca-4690-8438-8541843d4c05@windriver.com>
 <DG62GYSI7PCT.1DNGYSVW66L6W@bootlin.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <DG62GYSI7PCT.1DNGYSVW66L6W@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SN7PR11MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: ded0047b-54c3-4fee-46ff-08de6528ff4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z2ZOR2M5TkVzMGZKYk14bXZuSDNDU1ZHckZybElJeUN0KzJHdHZ2Y05QRUpV?=
 =?utf-8?B?a3d0T0ZtdTJuR2JySys1SHVmOHdVOTY5cmduUzJOSjBIck1MamZDRnIrMTVX?=
 =?utf-8?B?U1hPcGJPNndzWnJZcTllVkVIUTJhTnowZFg2RURYWnBxT1ptK2dSTGZzSTdU?=
 =?utf-8?B?TDNnTWQ2Yk9FaTFnQ04rdTdwQjBOdGRxaTlEK2Z2R1ExWjhPZkwwcHltbjNr?=
 =?utf-8?B?KzVHYWt6dXgyeFNpRXlkVTEwSXdzeGdubCt5by9mZGNnL1QyOVd6VzR6UW9B?=
 =?utf-8?B?MzJJT20vUFpkUGpmaEdialR6cnQ0VDA3VjdnTW5LYVdRdEg3Yi9tRGZsSm0v?=
 =?utf-8?B?SjBTVWNiMldqV1E1cUhUM0Z5azE5ZEJMSE5Ic1lPclhmV29oRS95S2l1WHFX?=
 =?utf-8?B?ZHdhbmhRMkJ5bzVMV0IwVkVNdlpST1E4d1NobkVNWEF0RHNPbWNEekR5Rzhh?=
 =?utf-8?B?cEQzOG9iS0ViZGNrT2F4ZmtoWTkwaVAwd2lpSVkzMysrMysxVW9JbGxTUE1J?=
 =?utf-8?B?ZDJqUXpWQU1lUndGaEN5QTF2N1EvSm9aRjZieTlUN1lQT01iZUhrMi9nL3Qv?=
 =?utf-8?B?OEtSdkt2djQ2T0hMSlRDYWdSZ1FXOGJZTGRodi81ZE91YlRMSnZ6WlRlQzcx?=
 =?utf-8?B?di9Ud0dXNmdtUGZwZml2RStHbS9PSnBJS3U3ZnlnL0M3ZzJjL3d4d0J4b3hD?=
 =?utf-8?B?QldUeGZCY2MyYUVYT2lzVnVBbE04dmloY05HcVZxRlVNcDQ5ZEpidVlpT1dG?=
 =?utf-8?B?WFl5Vm9BVVpQQk8wSlJkNFVkNmNUZzFKSjV6YTFjSkJJUDFGMFpsYlE0REFH?=
 =?utf-8?B?eGcrZXJ6cnFjNnA4UkI0NUxyRTAvV2JXNWlmK0ZqSjY5L2x2eTlrTldvQXFH?=
 =?utf-8?B?eEdQOVRQZnJaMS9YN2VIZFdEa3llT2FpL013ZGl2dXNDZVpjemhFWDMzeExl?=
 =?utf-8?B?QmNvd2FTZ01jT3VNMDdZR21PWmxoSFlGTHl5bGFXWUplYXdiUm1jZzQ3TGxh?=
 =?utf-8?B?RjVJRGhYUFZ3d3BPelNtV0N6ZkVEa3VXQVRZMkVtUkV0dXVJSmhGeUVQN0Mz?=
 =?utf-8?B?blNQWkJaeEFPVkNnbjVXaGhMWjBwU3NFKys0THFzZlN3TE9VMTRLc0tieC80?=
 =?utf-8?B?MXo4YmhqNXZwMDg3SmtkZlcvRkMrcWR5NFRsbEIvMS83VUpKZFFkZzlYRzFG?=
 =?utf-8?B?MlBhaWxZT1hBWDhscDBLZXYxSm1TUHhhT0xtaDQ5VXRTTVFsVENVZ2xHM01r?=
 =?utf-8?B?akVJbkJ1cVpSTDVkcnVaeCtmNG1NQkJBQW9wMXFzdXY5NzhQbStUd2lVUUVJ?=
 =?utf-8?B?TytUQWJGbGVZMUhudm5ZV1hMRytFYllYVGIrSXo2MGhORHBmbTBUMWIrdGdp?=
 =?utf-8?B?dTBDWk1JZUtldW41WlAxL1oyMHc1ajZVRnJiVVhUTTJwVnFMWHlFT3VQTzlG?=
 =?utf-8?B?c09Ka244cVdjVWxyeG5WbDdXVGJIZXpldkJpUW1nT0tZMVU3UmxyNmF4Smpl?=
 =?utf-8?B?aDg5M0l1REdkb0VoSnNuMjFYVlY3YnB0TDlmbUE2UDM2ME9wZHNiejBPN29J?=
 =?utf-8?B?ZUpQY3hvelJrNmVTajB1QTRYMklKVW1iNURRcFJoSnJKQkRwZG9TUXJYcE0r?=
 =?utf-8?B?c0I2ajhrSFFmOTZ1RndjQ2JOR0Vwdk1sbjl2YllJZGVGUkh2UUtKRVFKWEh6?=
 =?utf-8?B?bVdhSU83Umo0aXIzckJLMXJSTWk4ZlNKc0JFUG5sSzhmTUg3ZkcwbGJPcHIy?=
 =?utf-8?B?QU1kTnFrdzQ5SEVpSkdTSmdWS29Sb0Q2NFBjWForc3FtRm92a3JUMzF1bjNZ?=
 =?utf-8?B?UVdMUlpsempPZEdRaXJtQjFQYjAyd3hCVGlXZXZzN2JzRjNzWWlhVVJ3ZjVk?=
 =?utf-8?B?d084UkkxdDV1dHFzamRjeklLNmt2Zm9oMWVuSGlWZGUxd1haM2U5eGl2NjBU?=
 =?utf-8?B?WGZubVowUlQ3d09EZXArZm1lTE83RVhBY0NWRWVwV0N2dTN4UGplWElDTE9x?=
 =?utf-8?B?TmVtRGMrUEFhejRnQzlUaGx4c1NWVkI2UkJJSmNHSlZYWXE2WVVzcS9hMFRZ?=
 =?utf-8?B?RVB5SUJjbnN0NEFyWGN1WFhNb2FlWFc1NzdreUlLQTRnNzF0VzJpcTJBRHJR?=
 =?utf-8?Q?lloU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SEwyMnc0Wjh4RkZJcE5uN3prYmw4NnFSRmkyd3BLemxYYnlqTFdtY1ZFdnk4?=
 =?utf-8?B?bHBQajhrcFRLM1U5Nkx1YUUyYzVXRGpTaVJvdnNIOWFyQ2NySzFaNm00bzBC?=
 =?utf-8?B?Rmpkd2hQN2MvU1dkaFF0MEtmZStmdWZ4M0o3OWZSTTRIY2JWZmpZU2l5Nlk2?=
 =?utf-8?B?VTdHZFRIbTBZQ2NNNVdsY3YyWDZJY21PcTJnbmphOU1tNlUzT3lwQTU2N05Y?=
 =?utf-8?B?eXNLY2t3dWh4TjZvZzM3d2NWWUZiQzZ4c29OM2dlbnB3ejhzRXkwQmZ4ay9Z?=
 =?utf-8?B?SXBmWFdybjh4UG9rSWRuVWErQ3NIUkcranl5c0NJSGlwcGVuTWw5cWIrSzBr?=
 =?utf-8?B?cHREbmRQd2NKZDhrbVduVC9lM0RjcEQ5WHFTNzNsR1pQZUlvVjM0VnVrVEJY?=
 =?utf-8?B?eFMrcWt1TXFMQWpPYlNBMkNoYWlMTWYzb3o3aExIMy9NZ1RoM29qcUFzbm96?=
 =?utf-8?B?RTg3YTU5c0FPbXc3MTQyRlFSODRMMmVzM2NNMGkwd0dWVFUxOTJpeGR4cWVl?=
 =?utf-8?B?VHo4NTQ4cHVxaXZtSjBMR1l0bE9rV2dEa3pWWGNKVFdab3UwNmhwTFhyL2w5?=
 =?utf-8?B?V1NpcFk4MTEwaC9SZGpmR0M1L0Zob0FlcnYrL2xQYTJCbTN6Q2dyWEtCTjFa?=
 =?utf-8?B?dGdpY0R4MVhwVHR3ZnAyakZuM1BhVHpDNkppaXRGWWtKUU9MTUxsZ3c4TmEv?=
 =?utf-8?B?Zm4xeWF3TnRDVGhCV0hHdE8xSzRzZjNsc3pMZGdVQStEaU95MnB1V3JYQjla?=
 =?utf-8?B?TVVnTDR4UWtzZmZ6M0twakxuVkpFWGVEV2lrNm8vT2FwTU03RlA4OTE2ZHNY?=
 =?utf-8?B?ejRvQW9PN3N1N0c3dnFyVmpIS3BQcW9zQjZnSlo3NlFJWVViZFVwNWVmdTNq?=
 =?utf-8?B?cHQvQ1NRWTNnVHFJZHBTbTd3eGpZNlRqNmpXeWh3R2VtVjJvbmFWS0hONEww?=
 =?utf-8?B?U2FZcnRHdTZSNDVSVzl1NzZDSWU5UE1iTFVpbllNWVZieFJBKzFVL01Oajda?=
 =?utf-8?B?dFFiTDVBbHEydHlJUEl4eGptQ2duS201VjIrc2dNbXkrd2l2cHNtdmswdWd3?=
 =?utf-8?B?Y2gxakhLWSt6R0UzWnVZUkp3RG9hVkRyS0RObWxicHZOMXRIY2pTbzN4dHZa?=
 =?utf-8?B?eDhXU2dGWjA1RkRCaUVDYnIvSUQvYjF2K1FIVkVBUHFETXU5VDNCVjNXZFRZ?=
 =?utf-8?B?aTJ3bjJyaDR2eWlLTEgwOUkzNzZLcmVxZy9iOFZTMVoxQW5VSG5iM011dWVL?=
 =?utf-8?B?eGlXOTkzU1JuR3h3YjA5TUdZVU4xN3pLcTkzc3EvNEtEZnVzZTNSN0VJU0J1?=
 =?utf-8?B?cjQwT21UYXlIVkFZN1RybEFVeGNYdzRrRkVHUXowQnFBd2VmTVlMNUxYTGtH?=
 =?utf-8?B?Zi92Vm5WVnh3Yy9PY2hpb3RKOWdkMXdmTVhtamFPenhUVjdPaGl6QXZ2a1Jq?=
 =?utf-8?B?MDg5SmZITUs3Mk5wR2hTNjMyMTUwRVhOR3FsdUVybjJIQld0TVU0cnJWcTRo?=
 =?utf-8?B?NWJwYVpLenNkY25TZ2lrYjFLQXB5cmVTTTJTUEwzRExZZ2twUjdMT3FySHlD?=
 =?utf-8?B?dDJLWjNJNmxNV1A3WlBvK0ROWXpmSWJja1FNZ3BZci9jMXQvbnFQYkdYZSs4?=
 =?utf-8?B?VzN5ODBacXdtNHA2N1kwa3ozOHJZdmpPMVgwM3MwWkp6ZFM1SEJuWWdXWEQ2?=
 =?utf-8?B?MWRlYi9jWTFrZGN2V0hKWnQ0T28vN3FUamR3NmszRlExc0YvbDY1R09HVFdV?=
 =?utf-8?B?MHJ2WEJtR0NZUXdQVXFpMUJ5Rml6SzdycGNiTFJHSGFiTTA3OWlraVRxT05F?=
 =?utf-8?B?NWtlbmVWd1YwTW11aVRIMEI1bHQyYXNtb01pUzJ3eExDcENCSjNTTFB4Mmlt?=
 =?utf-8?B?VVVsN01JSXpXdm9FZmQyRDhPOGZCNldiUXdMRHQ5UWlqbGNOb3c2b3hlL2cy?=
 =?utf-8?B?Z01ackcxREVvajFsUVRHRllTQU8rUld2bDJqWitqNFBpNCszNXIweHZ0VXJa?=
 =?utf-8?B?UXFNMno2Vi9vc3lTNWpPUG16d1NWRVMvVStBTllrTDVwbTA1d21YTFdpeGlh?=
 =?utf-8?B?RUJ3Ymx2MGNzUnpnc2U2Nlhxdm84b3FzdUhPNmQxRXhaNjQ1REViYWs1dFB1?=
 =?utf-8?B?YWlPdVBIZDBIQmp5WFFBOW41OTk2Zms1Ui9sLzdBVDNjZXpOV1VaK2Mvb0h2?=
 =?utf-8?B?M29jaWY0eFlpR2NOSmJJeUlEb1Yyb25BbGZTdThKN1ZwMVBCNjY1V29KVDJW?=
 =?utf-8?B?T3VTK3V1dll0QkEyYkl6L2hOV0NBTEpENFk3Ym9QZmpXSkE2Q3hpeHNZb2hB?=
 =?utf-8?B?OWtCeXFkdFVueUVBdm1ydlhUa3pHNmc5cVYwYXB4QlVqV2pPTEFMUT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded0047b-54c3-4fee-46ff-08de6528ff4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 02:40:01.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2Oz3QcgD6yem3N/8Y4Ki1ZTXA4/AiOevH3uF1hncNaHo48ztpzpHHWOU0ELTebkHusdwLv4AkmH4NO3V9KK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDAxNiBTYWx0ZWRfXyDXRInxhjWse
 zpJCkwPgxS3ukSJooEGlw28TyopHrJjUwq5Cb3CKZfv6L4/FiDUrsp9YjgUnpZmJ2+6nBJJrk5R
 VVdGpLsO7jpqzZksdLg0kU3gpKfSx/8DB3jdr0V9Ln580/mSQ+kTAeM4PqWpLOJ0YJPCSBK/L2Y
 FeUwnj3wtaZ26/THzUizB0+L1zCjqc0WJSjAgpKufpLy0hKoSmuZNcUxvDkZyYTAYmgvYNXBwKp
 /tn0Xkdnlr1gMU0p8ye3uPyKO+P7xQbMcUIqXfxuG28lvro954HHRFXeqX1PZvNToZOXS8hUiwX
 dyV7AJDGfUVeOimoElv8v96HNeB+ywwRIW3miM8kutI8gBAWg4wFp3+VbMtS7UPldABgy9nV+oN
 Lx13cjlL0LymyGJ9y1lM5zLpicDfaZqbF4d8Wu4qWtHq1NtDZJW5s13VrzwhJE4U7jDEdeZXo/J
 jc/zCWaBHi4NT+7X7yg==
X-Proofpoint-ORIG-GUID: Y8Yip2n8EpGyDbmHTNYkjOmHq4-RKmhF
X-Authority-Analysis: v=2.4 cv=CdgFJbrl c=1 sm=1 tr=0 ts=69855485 cx=c_pps
 a=SpR4UuZ//oCsNj7RudjQzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Q4-j1AaZAAAA:8 a=MStZdXsezwRBZ4mZGhEA:9 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-GUID: bP9ZKLTekxwhLRMu--975slzupeq-Ati
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_01,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 02:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18975

On 2/4/26 17:23, Mathieu Dubois-Briand wrote:
> On Wed Feb 4, 2026 at 3:23 AM CET, Chen Qi via lists.openembedded.org wrote:
>> ping
>>
> Hi Chen,
>
> Your patch is still in the queue, but the backlog is a bit big these
> days, particularly on the bitbake side. It will be reviewed in the
> coming weeks.
>
> Thanks,
> Mathieu
>
Got it. Thanks for the info.

Regards,
Qi


