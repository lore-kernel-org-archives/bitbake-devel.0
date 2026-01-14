Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2EFD38FF4
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 17:23:36 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15718.1768411408747920100
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 09:23:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Rti2eopl;
 spf=pass (domain: cherry.de, ip: 52.101.66.5, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDmXHDwmcmfzvJrtfgguM/5u96/ADMnJcVI8NUBul+EEyp/5yMgtNc2+H393by60A1m1NsHc5q6BQTEhixsDWU9GQ2an2JoEubnkDiKLQ03/HLMEoSAASUJxnbIYdljF2ovIKVOvyZ3D/4q2/RAiV4bGqMX9grsqPO/wmBp3/6YiyDTUxWHGASYbSzniqy3cGaC5Qz6pZnPaDaFGonG5Wf/8Le99GPb1WlMAAztwUt41zrFQIeXnkeEOAHoo9I9QZU013E+3sjGP9/hPuHo+RML8ikmtvMUXo53YLn8OVIEwMO4N3Ot8Ed+59zn4uV0F87ks18KGTPC8nP3xh0Hpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgJoBTwem9qD7GZMfXmfVgXlkpA7nL9DlSs7A+v81yc=;
 b=O2PLdlW+IjPdsrg5i0ZAWnvKO0MSPMnzUzwpmVEqTJaAFQGoOTl/EsCFGjo6m/A+VtRmMaJE3NpYMKVWAyicTJC1cNIsGeiH0i1mEAZddELvaDfPulksiqO1tGlcJMaliKOSU5lnDdFIIZc+MiB4QsbhBoD5YSy7hs3VtilfRx4b7rtuV2WRnRk3Ak+3bWnQSAyIQIZjoECe+YAUzQgAugvQbYBEfVaVulun8GTn2Dhi4wccicsVTTl6g1V6B3Yrsv9zeab9xRRFSBS3kbYV+RsFwwE75Q0PrHr6eInZnimKs+brKQNQTfZswzYPbIhL2jqUV5udzzdc0alwt4NN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgJoBTwem9qD7GZMfXmfVgXlkpA7nL9DlSs7A+v81yc=;
 b=Rti2eoplTgizOB7b6CTlaaBWNA+OOsh0VQTCsgBppd6/rMbKaJzFKiDuSzorBUA9NlxIjemhULOfohfP62J9uvYHeGKKEbPOGTcHWdrmKdh0zBSzcffwQaBtZc9XRdsEvQM0Uwkl9GFbIoQ2g/T5HSdQVQJxXLSeq+dcJ9SRkIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AMDPR04MB11553.eurprd04.prod.outlook.com (2603:10a6:20b:719::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 17:23:24 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:23:24 +0000
Message-ID: <e1cae2c2-e7f4-4665-b777-45d25ba9e082@cherry.de>
Date: Wed, 14 Jan 2026 18:23:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: fix a couple minor typos in Chapter
 1
To: rpjday@crashcourse.ca,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <134b011e-5652-1609-cbba-4e29e7f95a48@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <134b011e-5652-1609-cbba-4e29e7f95a48@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AMDPR04MB11553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d581ace-cbe1-411f-c0fb-08de53919f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q2hVRk1HUjRLc0NvZEx4VnhSUWVubjNQeUwxVmlvZjRvdm9YZG9WblhWdFRi?=
 =?utf-8?B?MFNWOUtXR1VZN0lNQjQwZ3BUWC9UK3MybUdaMDU0YTR5a05Tb1dWOXcwRnlE?=
 =?utf-8?B?K01ZWlNkSzVENzlRN2xnVC9PZGkzekhleWdlMHFycUd1UjRwZC81Vm5hS3dG?=
 =?utf-8?B?UUczd1BvL3VNUEtmZ1B1aVdxZmhwVEVEelg0Qm93UzYrNnlJVi9lOENzVnFv?=
 =?utf-8?B?OXZQVzloWmFPMmFKZHRZeVJvMVV4ZnpaNndaODlQWFdqQzFDL2Q5ckpXUHhI?=
 =?utf-8?B?YlpDZDM0czZlUHQ1NUIzTW5tMG5oN3N4SlVFVmswRTdNTEhrVUM3TlBpY002?=
 =?utf-8?B?VzJwL3QxRHlkekhIaXNwZXk5VG1mblh3bk05d2dHSkVBWU9NekhFZmlSbUFR?=
 =?utf-8?B?UW9UL2Y5bFRiKzN1RVdCeU5Fc28yWVBlTlEwbWM5OHVCdHdISy9xcEZvSXVx?=
 =?utf-8?B?bnZnRFR2UFVtbkFtc1BHdE5TZ3lvTGlQcHFzcmVYMVoxUHVDYjFGOWtlZ2E4?=
 =?utf-8?B?RUp4YjFkMXFmUEtOY2RtMm5rZ0J1MkVqTEZHNm1lYSt0MXI2QmluT1VCQkJj?=
 =?utf-8?B?MnVvUFR3Z0ZvQUc4VGtKc25Pb09tMER4S3ZuQWVaUmRpNUR1aytkRVRVUWh5?=
 =?utf-8?B?cmZNRUFmSmY0K3BLL0t4VGJjcG92dzZPMW0zalM1UG9GQVlwRWRHOHhJeGw0?=
 =?utf-8?B?Z0l0OXB2dURlYWtZcms2SXFYc1MvV0xHdzFyZ29jS3d2VlJkZHJZVHh2Rm15?=
 =?utf-8?B?Ukc3cjhybGk5VGlYNHNvaUZqUW94WkhVelQ5Y3pBdXR5dlBTRTY2K1hSWVFm?=
 =?utf-8?B?OERxZ0ZIVHZtY2Y4eGI2eUNkVlBUemhyTll1ZHFVbnFGSTRmVmhiRXhmTnQ2?=
 =?utf-8?B?TkJxUVd6NWNXWUFiczZNUnQwVk9Xd0JnZE5LZUNCeGduYlgrNyswRTRDbWMw?=
 =?utf-8?B?SkJncm5zRldWRThrcnV5NnRCQzJnVVBBRkd1M2c4YUFPQUpnWnZ3MjdRbWFQ?=
 =?utf-8?B?TzF3cnZHakpQRmZQZmFSNlR0UlVKQkJlV2Z4WjB5M3Z1aGU2R2FMaWdtNVYz?=
 =?utf-8?B?KzN2d0F5QnVwNVhYYjVpV0VrVk5FWDZTOGlkVGZJWWphYUQvQVE3Z3pjS2d2?=
 =?utf-8?B?RFNQZjBSRnV3eStpVFdPWjJKbUI5NlFIc0VMa0VaSnJ2bG5NczZ0SlNIc29j?=
 =?utf-8?B?eHlYOVdDVGhGSk1BZXl4Nlg0bDN6VkNYRmIyS1NQOTdReVpRSGt5VEJ6NnIw?=
 =?utf-8?B?M045ajhjRkNhWE9tdTV4bVFoSmovMG5JQjNDclZ2Z05jSFJyVzNGbUxuQnZl?=
 =?utf-8?B?a1o0TURVd3IzMXdrRjhDdXV0RWN1MElCL2NHUVcwM3Fydml4anZLYnJTZnFk?=
 =?utf-8?B?WTRNZUQreHdHTXpVVE1LL1NUMzRrMEVIbHNzamkxQlFvcEtOMGlQd25FSWp6?=
 =?utf-8?B?ejgrbUJhTnhpYWt2T2VNWGlUdEh3bU9wNCsrUTFkTFJKdFhRM09WNXQ2QVhs?=
 =?utf-8?B?Mkg2eDFGM2U1RjkyTmNMMXU4d21TVUE0RGhIVnhUZzBacC95Kzl5LzNUbEcr?=
 =?utf-8?B?aHNFaWVnbzRXcUpBSFNMYnJWUjVjNFN0RFh6WTRlVWJheWtZSmJsU2ZNU1dF?=
 =?utf-8?B?cWoxM0FBWWFLbkRwTnVrYzI5VjdqUWNLbjBCbzRlM3JpL0VhVDY3M2UwaVN6?=
 =?utf-8?B?djJ2UlNValZjSkg4RDJYaFMwQlZsclUrSzMxanh0OXJuWnRNL2E1ai9ZRlR0?=
 =?utf-8?B?M1p0anFpajk3Zlo3NFdZUUVlMGtPRUhPZlVYOUNqQ2w2Wm5odFpxMWRSR2My?=
 =?utf-8?B?NEtaQldEaVM2THN1VXlwVGN1dGNndWE0ekJ1c3FnTXRQb2NGOHQxZ09tL2ZW?=
 =?utf-8?B?QllkTmJCMXdxSmtGb3pNWGg4SXdJWDZhS2YxNEJyaXNSUzF5WXdrNHFRSkpW?=
 =?utf-8?B?MjZ5NW40YlNrb1lqNVVXUlovSEw4b2FxVWVocXJLYmRpbzFpUC9WakxSMTl4?=
 =?utf-8?B?dW1md3FVK1Q0SFN1L09VMTdQU1ZSU1JjWlFjNCtucjZqaTM5QzJHSmVQSXo0?=
 =?utf-8?B?Ymw5bWpMYTc3YnlQTXFqSW5MdDE4QUZ5dmd0OG5JZjNQNVBSTEVHOE9lN0lr?=
 =?utf-8?Q?+f3Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ck5WbGN0VDQ2QllsMEFOSHdjczBrVmt3V2lDODR6VExTTWFaUlJaMHc4aTN3?=
 =?utf-8?B?Y05TTUp3bTlmUmFUS21ucGc4cHBIaHd6c0pzcGRmTWFycGlrMGZxUXhLQW5M?=
 =?utf-8?B?MlJ5dXp4RkJjUWZWTTc3WUhGamZhUDZzVEV6aThxUEtwZkowcU5lZzFDYjRy?=
 =?utf-8?B?UW1LeE1CbW9qMm53TUFRelM4SFJ5d1IzSDVyS2VyK05oUjE2OWQvbW93dGMx?=
 =?utf-8?B?K0t2TE4xTFpBMnJ5dGhWaEtEM0VqZ1FsU1E2WDc0TGdzdEIyT3Bka2JpSENk?=
 =?utf-8?B?S3YzajEvcVd6VTZJOFBPdnNabFE2d20yV05GMmxBZWh6R0x4ekpqdVFYWnZE?=
 =?utf-8?B?VUltM0kyeDJEVTZoYTdnUHZ1bEIxVHdqWW14eXlVMUJYUlUwUmdrajhUekp4?=
 =?utf-8?B?UFB5QWIwUjgzb2owTmtkTnNmLzBpbVR0Y2NZajN4elFuR1JQR2xybk1INFE4?=
 =?utf-8?B?WUtjcUNPL1BGWEpRMDV4RU1OZ0FLODhMenpqQmZhaWpiNkh2K3RCZTRzZHB5?=
 =?utf-8?B?MTEzM2MxQXBTTjM3aHpLZXkzMUVsTzVDaW0zTmJyT201Qlp3Nno4ZEdpWHpE?=
 =?utf-8?B?K1dTZk1IZHpFSms4MmZ2ZVZCVEZSbXBvY3pjY1RPbEUvUXduT3VJSGRLdlpM?=
 =?utf-8?B?ZDlsQTRtVHhVYzB3aDRQaVJIV29RQjNxVzV6QXoxUkd5TEozQzVNWndacW03?=
 =?utf-8?B?aFR0WEhPRWJWV1kwbHNrY1BmZDBFc0NqZGs3b2J3SEkzMGMyTXhpbWVSckdE?=
 =?utf-8?B?UmRMVnB4UWpMc01Vc0dKVHgvRTVaSVU2SzdGdmU2R0NQWVVuSmxJZzZ6T1NZ?=
 =?utf-8?B?U1diQ2IxZDlhOS9QWU1YN1NQYVdqS2FrRGUwTmlJQ05FUnJqVlJrTWxJS1ZW?=
 =?utf-8?B?UEUra1JjZXlHbEtWTXM4SGE4RnlQbXpJWjdPWXFwcEN6cHVRLzdZMEVxdkMy?=
 =?utf-8?B?MUtZbEdUdTZJUTR6V3Q3RnRYN2Q1UExLTTk5MzZlbm5YbEVWbmJNbnlWSzNk?=
 =?utf-8?B?Rzl3RkdOQ2U3amU1S3NHSWV0Ti9nUzlNNUpycExJQXZZVWN3TklsR2wvdTFZ?=
 =?utf-8?B?RUtFVmRjaTJOM3hqMkJhOWhHSUI5R2lOUkxzK2JqVmNreVl2cy9BT09HSER2?=
 =?utf-8?B?TUo0NkEzcWJTNjVwV0krTHBMWGREY25PclBUdUJsMXpCelZBRUUrTW5DSGtO?=
 =?utf-8?B?TFBoSGp1aDM3R3ZtSTRRQkhZR1pBck1TZ0xyZ0JBOTZGZ2Nna05DTGdvV2sy?=
 =?utf-8?B?NVpOajY2dm94OU1hTFFiOWxGMHlZL1VEMVNvREgrQkJFQXQrMmhWQTVseVI2?=
 =?utf-8?B?dDhXeUNKZXltNldnRE9rU3lsbHFOZllqVUEvcWRNZU1kenhGQ2JQdmoxb2tx?=
 =?utf-8?B?V1ZlQ0ZwUTZuM213dUdsbWJ0SUlQUC9yZVVHWW93Wkp5ZzExWmtnSFZWcEll?=
 =?utf-8?B?bXU2NmlvaENCWGcvd0k5cVBXaTcrUkxJRjZqRTI2T3JxSGNTVUhYeDl2WC9O?=
 =?utf-8?B?LzJEV0poT3RTNDc5K3RaWDFwWnNSelh2UTl2NHdCaTQvVlBGSU9jZWZpRWdF?=
 =?utf-8?B?U2dzMjFEb3RmT1RPT1RDT3NBdm9RQ0hqR3JqL3l2VUFTMzRNNHYycHU0RzFu?=
 =?utf-8?B?cmo5N1FFMVd1OVN5eEdraGpDR3FQbWU1QVZia2Z4MnZkcU8vMTBXVnIrS2hK?=
 =?utf-8?B?dkNMVzI2aGZmaDhmZU5TUFdiTEUvM3NoK1MrT1dLanA5NnMwYmNOZ2VzM1JO?=
 =?utf-8?B?OW80RkFlWEZXa0Z6VmZIMHhNMDRHaXlqU2RxWFF2dWRmZEx1NkNiRWE0b0RN?=
 =?utf-8?B?RlhoUmZ1Mm1YZFBZczIrOHd4UHg2VU50QWdyM0NONm1FT3RjN0dwQjFYcW9Y?=
 =?utf-8?B?emJuMzhJSUUvWXBMaFF6K0dENkJjSFRaZzI2TFA5TU0wakZvTU9YblpwUThE?=
 =?utf-8?B?Wjh5TEtpQmxucTY0NGZtUHFLQlVWb01tSytXWFNtam1zaW42bkQrMC92VVpH?=
 =?utf-8?B?ckp6ZTZ3aDJVSGo4eWJPSVhUWHhuSzZmTVBZemhWZktsK2NMUFBTdTBYK1lo?=
 =?utf-8?B?eFB5Uyt2V2VHWERpbExrVndNdkVWSVkzMHBiR3Z6Yms2akRreGF3RjF6c3hF?=
 =?utf-8?B?dGJUUEpndVVFSXFGNXhHUFI2bE9IUE5kYUo5ZFo5SkhiLzY5aWZIZUNLeXc3?=
 =?utf-8?B?V3V1SDRvMExqUmFkR3h3THVaQkNjMkIvbzJXWjBITlVhNmw3bDR3MDBEMUV3?=
 =?utf-8?B?RVRmTWV4aVU4ZFJ5TmpnWElWeFlxaTNxQm9aV1RVWGoybGhsUnBBTm1BRzl3?=
 =?utf-8?B?Uk1idlROOThyMnJmQXc0NGhqSXVoT3h1LzFZdGJkd1g3SWVTcjJHdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d581ace-cbe1-411f-c0fb-08de53919f6a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:23:24.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+unoWO6+wb9SXreBmYNA2oHsyOYKldIE3yH50ESTdgIBhLUTyb0DXdul5bS0Dvo2+FH0HnstcDLsSWkvqS6OEqAgo1GiotgDcQBJuiiT64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11553
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 17:23:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18761

Hi Robert,

On 1/8/26 4:44 PM, Robert P. J. Day via lists.openembedded.org wrote:
> 
> Just some verb tense stuff.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

