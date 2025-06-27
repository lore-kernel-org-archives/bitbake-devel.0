Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A2AC7EE2A
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 15:11:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.45])
 by mx.groups.io with SMTP id smtpd.web11.16287.1751037105305488655
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jun 2025 08:11:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=UeuDqYkt;
 spf=pass (domain: cherry.de, ip: 52.101.65.45, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dsnevdx3mx+b64i0fQ+k/4HQaYBxeQN9p0gP0dumzw5uc/+De8YwEQsv5GomeVDpjsxWiJH3rzmzd/9oFPJ/YfjeyLX11vqrcY9vDYYdYaHkp4LnA3Iwb1QK+mmav79w7ZJkgglYOOLxcLqFQ8kUSSdNMTX3Hzyfdl/+D5WFepQirTTIMKbKuwoNCziqfp2fKUOo6FKG0cdF8TAKDCI7CTCL8Vc2qgJUQ/AGySgCfM2RirlHOeSuaobHlYbjf3KmGFGX1vZNGc1SXm5XlK7Pfu8k4BCbwnQRsb8Rgf4/arWNkjPpfCMw7qPErbg9iaETKvM3nU2brXMHUaKwhgPK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAyoItMwoANAv3KIR1wRIe2xzWBzLpBMA4HJP3+8fDo=;
 b=THyNcP7baCtJhI35SreKHkr6Cw81vI/6joEBbZlyn1pnmD/bDUg+7+if1rBy0dJX+mjaifJyyg8MCm8u0r3Qb//0A6BI48ny/FZUE+rIRJNDVg27BHUqwqUcHxt+eGKV8PcqgdqgjrLJiwtHmSlOm2FyHUSDtynk3UcD+zNHvzoAwDsiDlIpKiO00PKf/WLeQTvsLYNSdLfwBLNiAjFVzbjiUIqE0M5qboorpWi1MPljljjJqstY4LlW/ir8S6VmnDnwW2Hzm9mDLStTupiltCKezo7HCGkM4p4B+B1XJp0/tNv0kEbexwvSijatKby5gyvZmoGDYw1UFN1AGQUGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAyoItMwoANAv3KIR1wRIe2xzWBzLpBMA4HJP3+8fDo=;
 b=UeuDqYkt2TFHjRhMVSf6H/Tqh0adYffjjOY+3BA0komOI3WtGEDEjcJPjnhiEkl9KCrncmVThWI6XOTDiXQChz2TdWkIlJlgG/ATgtiMm+0IL9NK24RtJhVMQzsRRPQC8JWZYj6aLnVpN/ZZmw8/5HCmO89TLjlGlOZ6K8L703U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB9341.eurprd04.prod.outlook.com (2603:10a6:102:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 15:11:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 15:11:40 +0000
Message-ID: <73497b5e-721e-4e5f-beb4-c56ab9178c9f@cherry.de>
Date: Fri, 27 Jun 2025 17:11:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual-ref-variables:
 improve BB_PRESSURE_* doc
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250624-improve-pressure-doc-v1-1-37170e441fc9@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250624-improve-pressure-doc-v1-1-37170e441fc9@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR02CA0062.eurprd02.prod.outlook.com
 (2603:10a6:802:14::33) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7056ab-aa06-4f88-74a9-08ddb58ceb51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TzNRdmxmWWhUdTlGWXB2b2lUcW1OdmVlRjRPbDlqb2hBcTNaRlQyMjlMY1hN?=
 =?utf-8?B?RlBVOEphMHBRN2NmVnFJRGJuczZubmlKUnhSd3l5b2xraEVjTUZWd1JwKzV4?=
 =?utf-8?B?Q0VKZk5TZlhYU3NjWUh4ektsajI1SlN4b0ZucEtISFJWbFlUYjZsZE83UC83?=
 =?utf-8?B?UlBMT3FmVnNjRWdvK2NZOU1KLys5MGlHN0hxQStub3FocUFIQWU5VUVNWnJa?=
 =?utf-8?B?Qmx4Nlo5dGNKUExMd25xOE1tWFF5Nzk2amorcFhqSm1WRGJocGlNWUZwNXpi?=
 =?utf-8?B?UERoSERkZTlibG9jYkIwaVphWERqbndsdkVRV0NLeUNId2pURXdUb0V0d1FQ?=
 =?utf-8?B?WTFqQnZ5SjFmd1c5T0dacFhNcEwrL0ZYNU41VVA2alErTm4zdGhpb21VMUJB?=
 =?utf-8?B?SnZ5WURGeHlBR0dvT25FcmxrYU1ZdHVESGFoWkJDSkJ3TnJoeUcxbjJUV2xY?=
 =?utf-8?B?RHNyL1VYNXU5MXVCczk0NzlxaHdlZlJoQzZTMElYN0xaUVJZRkNyU0RieVl6?=
 =?utf-8?B?NTY0WkhCWUI4R3F6NWZ5R2pzMFZiWk5DZ0lFU0lXNWdQTjRTZmdyWjZiS1J4?=
 =?utf-8?B?UFp4QUJ6WXkrbGFXUEx4RXQ3dWJmNVFVVnhjeUJBemFNWjVDSEludmVKQmVw?=
 =?utf-8?B?S0VMMS9aT0FVVitmTENUNzJ1M2IzaVZiZk1YbTJQZWFYK1JTK0hBNVc0dklv?=
 =?utf-8?B?TWpHNFpJUHdiSkNuUGQ2NStaTkEzQWVKaGRyOTllZ1ZhazBTVU9sVTg5eHlT?=
 =?utf-8?B?a0lIRzhHRUJpc0VtdFJienZDU1hVSGc4QWdkVjh4R0FNdWZIcEVJVzFzRTNR?=
 =?utf-8?B?VlR2cWQ4ditrZXJpeG4xWGZMNURPNVJZK3NPT2lrNjJPdjJ3MlZCaXRrNGxS?=
 =?utf-8?B?VUJqV3IrRUZSQkQxdzRkUThiMkFQWEZFMGI1R1hteEQycGFaWUMxRTlvLzhM?=
 =?utf-8?B?ZHdVSHFRZGhrOUFGcmNXa0VJRUJla0MxUjJobHU4MkFqRGtBa1BpOWJMZHFC?=
 =?utf-8?B?ZStUUlhjVWllaUJJZDArRHplNGd0KzRZSHhIc3didldHUEluSFAyY0tTL0ZI?=
 =?utf-8?B?TVEwY0g4NldIY2Q0WXZIOEZja2xrRTQyVDdIZWROWGFzS0lNRFRNcWZhV3Jl?=
 =?utf-8?B?bk1yVkowdEVBdmFaY0VMTW5IdlVhMXp4K2RWQWQwRGZSR1poVzhzaVpKd2lu?=
 =?utf-8?B?UXBML0RzR0krb0Eza2lCOXF1N0FDSWgzMytYZW1ydlJkeHMzZjZoMXJnTkdw?=
 =?utf-8?B?aVZ1MnlBbzFrQk11cHhCRUlsanRGSS9DSVczYW5kdlNmMWgwR1cyUjFqOTVH?=
 =?utf-8?B?cytSaGV3M0M3eGhUa2YzenNkb0Y4THpiYlJ3cHd0NS8yd1podHdMMkpzclcw?=
 =?utf-8?B?QkRTYytzcmV5bllZNld5YXFSa2dSQWFJQnFVT2RjVFE4WEZlbU8xM0lpS0Fy?=
 =?utf-8?B?K0pPTHEyemt1b014d0tva1BjaEF3bk1mVmJzK3ZYN0xTdy9Ia0EwcjM5cmV0?=
 =?utf-8?B?QklJWTFMT2pCc3cwQURodnBuRnFRMUJxbmJaL2ZWeUtCRXVUdVp4clRNcnYw?=
 =?utf-8?B?NmlmS042NmcrNlYwU3R4RVl4bWt0L081OWE5UHFmZmFicDJUeUJMU1dGaURD?=
 =?utf-8?B?MWs3MHdPdFdGcW5BNnRoTFJtQW5PbW9XR2hLRHV4NmY2M3FINk0vSEJVZ2Ux?=
 =?utf-8?B?Qkh2dVliT0REOHRqQ2JVenV0ZEE2Sk12VTE0Q0p2MXhTTFNiOVJvS3RSSnE5?=
 =?utf-8?B?MGVMNTFSaUw5TU96c2d3ZUUxSkY5MUlFbURjVSs0dVl6QTdSK0ZZc3RmYis2?=
 =?utf-8?B?S1Yvek50WjVyL0ZFaFVjeHZpRVkvMUtSdUlHRklJOGV0QmNHV2swa2VzRmYw?=
 =?utf-8?B?bHB2bTI3WnZGSFI2ZnlLZCs0UWk2TURWVXUyejljdVE4SFY3ZllnZk5sMElG?=
 =?utf-8?Q?FRlGOKE+H90=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHloN21yK1J2QUtoSk83SjZJc2EzZi9jbjB0alNsNjFndEhnY0pmL2RZbzdY?=
 =?utf-8?B?UHgrVGJvUG92TVhWbXZqSzE2UDU5bnFBSEJvUFFBak43a1UvWDJDd0l0UkN3?=
 =?utf-8?B?OUZHNzZxVXowYW5wM1E5YzgyUTd6VEdnUldyZkluZjF5bEdyTDhJUXV2VmVt?=
 =?utf-8?B?S2NHK05XbkpxeEJaNjJhNFpjM0o1UFplQjRodjQwYlE2bit4YU42YVkwU3Rr?=
 =?utf-8?B?QWdwbnlwVlhqWldha1ZFTmZxd0Z0a2pJeHR4ODh6VFVGUEpFb3FVZWNpUDJw?=
 =?utf-8?B?dWhIRUEwSzlsbUZLLzdmbHFTK0xGRDNkYTkrU3N5QzBYUTF1eWxTWVhncGNn?=
 =?utf-8?B?RVpVaCtmRk9nQ2dpd1dYdkJOT0tUb3lla3dIay93VytJWGJVb013RFFmTFRy?=
 =?utf-8?B?UEhkUUdOcFMrMmJIeWtHYkhhK0hqdFhaamh5VW9Yc29aRkhEVkh2UHMwcXdo?=
 =?utf-8?B?Y3ZzU2UzYmNZOXZoV1N6Y3AxNWlKYVZud1RhbURXdkVQSnk2UzJNY2k5YUV1?=
 =?utf-8?B?aDlPKzlodnZGWk1iUTBzZDZObVB0YWJ6eUZBT3dyZXlqUUZaN3ZFcTF2VjdK?=
 =?utf-8?B?RittanpIYjc2MVh2d29mV2xEZ2dTNDgrZHEwSHo5T2V6eE16TUJtRUJITmdE?=
 =?utf-8?B?Ui9nZGRRUlNsYzBrYkcxTVJYM0JQZWcrUWpXU3VsaFhWbVdPeE40NXRadWxn?=
 =?utf-8?B?VWx4Q21hTTIvaVJGREZXYXVFQzl4WENrU3RQTU5mVStLcUZjYlBibFFmUGVZ?=
 =?utf-8?B?bEZwelM1Z0c4czVHUnFjaGZsVXMxUHlMRStwZisxNXArSll1Q05yUEI1TWVp?=
 =?utf-8?B?REVDSDBpQjhieG9ERDdaTTE0bk4wcVZSUGN5WnRUU2JzbGZwWXE4QllncnBI?=
 =?utf-8?B?WmxHZjdvNEdsWWxUTUhKb2pYdjdzaVBtaGxMRlFLUWRWWEJITzd1S3M1TVBs?=
 =?utf-8?B?SCtlRWcvMlBTVGFlTzQzTDBJMmRydlVLUmxkNE5zYS84ai9MdGwyYjRHVjdO?=
 =?utf-8?B?VWtnMlRaV0VJamdZNUJ3VXc5Y1pwOHd0VVozc2tSS2JodVR6YkpNODJiMVBW?=
 =?utf-8?B?Ri8zekRnOUVtcFg4Q3F5Vk5Janl2U1QvS2xIL0h1VGd1UWlzY1cyMUpxNTVi?=
 =?utf-8?B?dm80NDZCenpFdTc3SlVTSXhvZ3lyd3E4SkhwRWhZRnhMSVgyN2trUWFXUkIv?=
 =?utf-8?B?U1dBMTZReGFzRUg5N29hOFp1TVZDVk5TaGZwSkl6MnhWQk1HbjF2T2pubUNH?=
 =?utf-8?B?OXFJQTRvMXIxSVd3VG55c1dLbXR0UTFZMHBPMGlIN1V1Y3Y4OGVoTzhRQ0Rt?=
 =?utf-8?B?WEFXSmR3alVZUjdoTGphbDRGNEppd0FEYTh0VnEyOVVJTzNzT2twOUtKdFFS?=
 =?utf-8?B?Snk5QzFSSjJsZGtLWU9hVlI1bGw0N0RBaHNNRUl1c0QyQ05VbzJGWkNXeFZQ?=
 =?utf-8?B?UVl1NzVWcEJUMTVzRVpET1RvcUs2Zk5zRmtHcXB4ck5LemwzSDUyTnFMWERZ?=
 =?utf-8?B?Vnpyam1DSzFzTGZvMEJNTy9CTU0vQmhBVmF4QW9UMDNOd1pNRjBPTmJMRFpI?=
 =?utf-8?B?eFkzSzRTQ1Z3YjA4VGprQ3hVTHRvZnFUb2VhbHJ5cGdkYVh5UWg4RDM5SFdS?=
 =?utf-8?B?TDg4M3hFUG1wcmU1d3Q3LzJnUVNLNVo5dUxhdE5ZcGE3RmhUT2lCdUJlOFE1?=
 =?utf-8?B?UEp1MFozbHZqUGtSMDdNN0lNZkhQRklVQWs0UjNFNmJjMjVMVG94Sm9wOXdu?=
 =?utf-8?B?V0Q4eUNBUVlWclVnTzU0dlNDTTdsWnM2N1FiRUFpRXQ2UjIwak5uVTNnWlRr?=
 =?utf-8?B?WXliaGoweGNjT2VpczF1QldUdCtET0lSRXlGR3FXUHlnVzRBZ0MrNXVpQlND?=
 =?utf-8?B?clU1VmJLb1dzb3pMcEFpbWxiQ0ZVQWxWMHhNeUlHOHBEWS9CaXYrOFk5eHo5?=
 =?utf-8?B?QXBtK3ZtUTluNXh2OVpaSTYvd3ZsT1ZiUGdTTDNPd0pMOXA1b09qZkp1Tzh4?=
 =?utf-8?B?NStibkUvaVBIdlM3MDlMb0pybll6NklENFBNd1psRkdoemVpN3dJSUV0dSty?=
 =?utf-8?B?Zi9vdXBnV29aTTFaakY5OE8zTWhQZnBrR0FMUkMrNENBWlF4Tm9PS3piYisy?=
 =?utf-8?B?SW9YMHdhZkwyS3RJMHlwN0pqVUwvSU1pU0lFakFWbGp1dnJHM2xaL3NFTjRj?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7056ab-aa06-4f88-74a9-08ddb58ceb51
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 15:11:40.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QCNhu2L1dRu1gwvWCsHgnDIA5lSlkTbyDJEnPbUcVyzOSeoqu/8Qm0pxkDVl3a9GnvlWo8ta8HffsmHMYkiegnVn1X1/SCy7XPp8rZw5SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9341
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jun 2025 15:11:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17722

Hi Antonin,

On 6/24/25 2:25 PM, Antonin Godard via lists.openembedded.org wrote:
> The current default value for BB_PRESSURE_MAX_CPU is 500, which is
> really low for most systems. Provide a value of 15000 which limits the
> load average without being extremely slow either.
> 
> Provide similar values for BB_PRESSURE_MAX_IO and
> BB_PRESSURE_MAX_MEMORY. Mention that these should be adjusted depending
> on the need, and warn about the potential spam of messages when the
> value is too low.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   .../bitbake-user-manual-ref-variables.rst          | 70 ++++++++++++++++++++--
>   1 file changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 477443e228..f73e96f168 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -533,11 +533,28 @@ overview of their function and contents.
>         version 4.20 expose under ``/proc/pressure``. The threshold represents
>         the difference in "total" pressure from the previous second. The
>         minimum value is 1.0 (extremely slow builds) and the maximum is
> -      1000000 (a pressure value unlikely to ever be reached).
> +      1000000 (a pressure value unlikely to ever be reached). See
> +      https://docs.kernel.org/accounting/psi.html for more information.
>   
> -      This threshold can be set in ``conf/local.conf`` as::
> +      A default value to limit the CPU pressure to be set in ``conf/local.conf``
> +      could be::
>   
> -         BB_PRESSURE_MAX_CPU = "500"
> +         BB_PRESSURE_MAX_CPU = "15000"
> +
> +      Multiple values should be tested on the build host to determine what suits
> +      best, depending on the need for performances versus load average during

s/performances/performance/?

> +      the build.
> +
> +      .. note::
> +
> +         You may see numerous messages printed by BitBake in the case the

s/in the case/in case/

> +         :term:`BB_PRESSURE_MAX_CPU` is too low:

Did you want the next sentence to be a code-block (missing second colon) 
or does a quote work? (which I believe is what this would do, no 
code-block and text indented).

Considering the other BB_PRESSURE_* have ::, I believe this is missing a 
second colon :)

> +
> +            Pressure status changed to CPU: True, IO: False, Mem: False (CPU: 1105.9/2.0, IO: 0.0/2.0, Mem: 0.0/2.0) - using 1/64 bitbake threads
> +
> +         This means that the :term:`BB_PRESSURE_MAX_CPU` should be increased to
> +         a reasonable value for limiting the CPU pressure on the system.
> +         Monitor the varying value after ``IO:`` above to set a sensible value.

s/IO:/CPU:/

>   
>      :term:`BB_PRESSURE_MAX_IO`
>         Specifies a maximum I/O pressure threshold, above which BitBake's
> @@ -549,14 +566,34 @@ overview of their function and contents.
>         version 4.20 expose under ``/proc/pressure``. The threshold represents
>         the difference in "total" pressure from the previous second. The
>         minimum value is 1.0 (extremely slow builds) and the maximum is
> -      1000000 (a pressure value unlikely to ever be reached).
> +      1000000 (a pressure value unlikely to ever be reached). See
> +      https://docs.kernel.org/accounting/psi.html for more information.
>   
>         At this point in time, experiments show that IO pressure tends to
>         be short-lived and regulating just the CPU with
>         :term:`BB_PRESSURE_MAX_CPU` can help to reduce it.
>   
> -   :term:`BB_PRESSURE_MAX_MEMORY`
> +      A default value to limit the IO pressure to be set in ``conf/local.conf``
> +      could be::
> +
> +         BB_PRESSURE_MAX_IO = "15000"
> +
> +      Multiple values should be tested on the build host to determine what suits
> +      best, depending on the need for performances versus I/O usage during the

s/performances/performance/ ?

> +      build.
> +
> +      .. note::
> +
> +         You may see numerous messages printed by BitBake in the case the

s/in the case/in case/

> +         :term:`BB_PRESSURE_MAX_IO` is too low::
>   
> +            Pressure status changed to CPU: None, IO: True, Mem: False (CPU: 2236.0/None, IO: 153.6/2.0, Mem: 0.0/2.0) - using 19/64 bitbake threads
> +
> +         This means that the :term:`BB_PRESSURE_MAX_IO` should be increased to
> +         a reasonable value for limiting the I/O pressure on the system.
> +         Monitor the varying value after ``IO:`` above to set a sensible value.
> +
> +   :term:`BB_PRESSURE_MAX_MEMORY`
>         Specifies a maximum memory pressure threshold, above which BitBake's
>         scheduler will not start new tasks (providing there is at least
>         one active task). If no value is set, memory pressure is not
> @@ -566,7 +603,8 @@ overview of their function and contents.
>         version 4.20 expose under ``/proc/pressure``. The threshold represents
>         the difference in "total" pressure from the previous second. The
>         minimum value is 1.0 (extremely slow builds) and the maximum is
> -      1000000 (a pressure value unlikely to ever be reached).
> +      1000000 (a pressure value unlikely to ever be reached). See
> +      https://docs.kernel.org/accounting/psi.html for more information.
>   
>         Memory pressure is experienced when time is spent swapping,
>         refaulting pages from the page cache or performing direct reclaim.
> @@ -574,6 +612,26 @@ overview of their function and contents.
>         might be useful as a last resort to prevent OOM errors if they are
>         occurring during builds.
>   
> +      A default value to limit the memory pressure to be set in
> +      ``conf/local.conf`` could be::
> +
> +         BB_PRESSURE_MAX_MEMORY = "15000"
> +
> +      Multiple values should be tested on the build host to determine what suits
> +      best, depending on the need for performances versus memory consumption

s/performances/performance/ ?

> +      during the build.
> +
> +      .. note::
> +
> +         You may see numerous messages printed by BitBake in the case the

s/in the case/in case/

Cheers,
Quentin

