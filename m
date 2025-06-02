Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B9C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 13:57:56 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.11])
 by mx.groups.io with SMTP id smtpd.web11.50473.1748872666275552792
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 06:57:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=FTYyYwJd;
 spf=pass (domain: cherry.de, ip: 52.101.72.11, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXtBpArfu8nvNlPg3YeasUBAQjN85u3oXB9ISLyZCmGARzpl38NsqYqBkyFYAcSExdo8joB8kHDkrKezAS6sZATzs8925lbCYUnjCuO3G8w2vG3lVQQoY0q352MwwnTpZgz68pXPEydqxjQknm6eHLdd4sj81GsqujtlHJjZzSJ6/2wd/wHfSrlvol/jfpMw9zaUNjc46b0wjrYOzmSHCsfqRwQsztMmDBsMyLCrmautlHHZwguU4rKJte1vYmUggKrDdl0E3l65uQd8vKWDb5S/pHZD3cy9qgbm80Cos7Hafa4HpG0YJloVdzmBXk1w2hSdd6Pd8dknypXd99vfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV07N21ChUYm7HbWVY0Pa7sbUsUVJV2UIcdFmvB+RZU=;
 b=x8+nXjhauFr2C+Y0ub9S86JfFqp5CYeoxBF1ZEMDPZGkvLeA3ieJdhka0yqWVpUxbDt/P2Fl24eg3ANc+EZxnvw4M5TWCpUxWdMsVJqydX3W8pRmDpzI4XA7/Q8sIby28rd12CbIJAbjjYOe2S+0HcEYBYaia3XQs3fjWVo9v4N1kle2mYQ9QACboI1F/BIWti/S2RQFg7s/cH2mg8eCS7r5CdbS7nvB45kVc+Bsd4JXe49ub6HZPGTNFj2BevMsKOGEzNL16lRyGu2+ZKRmbevWThKX+fTwUDDnPM7afN1hqfGzH9tiy53AunHb6LVAc05GwlOATLQeELYxsKXCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV07N21ChUYm7HbWVY0Pa7sbUsUVJV2UIcdFmvB+RZU=;
 b=FTYyYwJdOc+QM7N72NLbZTvqc0CvKMPCzaZuxJoNfrMo6Wzrs0GT3JbpcJTKoRxwE3GtQECmzPe/kBiNRowHpZWMzWDyfu6OraA0SWY7bDf7ZCD8i3VGFs6oLudHgmfGqYOw8yy41fRzL4JtYWUWfpLNlRot9+10u+TVqb5mjzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9201.eurprd04.prod.outlook.com (2603:10a6:102:232::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 13:57:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 13:57:40 +0000
Message-ID: <37097686-48e5-4a0b-93fa-62152fe50dc0@cherry.de>
Date: Mon, 2 Jun 2025 15:57:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] clarify how bbappend files work with an
 unversioned BitBake recipe
To: rpjday@crashcourse.ca, YP docs mailing list <docs@lists.yoctoproject.org>
References: <562c3a8a-2cfd-a4cc-7dc8-0126b5b02a86@crashcourse.ca>
Content-Language: en-US
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <562c3a8a-2cfd-a4cc-7dc8-0126b5b02a86@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:208:be::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: a6678e07-2a4a-4bf3-a5b8-08dda1dd70b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SGkxc3lsVURGdEMzczhYVkJ1dFg0Znp6bzBiR1hKazFYRXEzRW1KYjFLMmlS?=
 =?utf-8?B?cHhoejZZblU4UVFUS0lmUnRpbG5ZZitOS3J5SjBvU28xeW0vQitlN1hVcXpX?=
 =?utf-8?B?bFdzVzVYU2lEeFNydGxJQStoSVFEemZ5dWE0K203NjZNSDZ4WE81VUxvOVY0?=
 =?utf-8?B?NFByckVpU1VqUHZVMWVXUmtvWHZCZkwxZGwwZjFJWVVQRkdrWHA3K1NzR28y?=
 =?utf-8?B?V1F5SzA4UzdtWUdvZVBVQ0pBSnMxWE9US3FrSm4raldKQTFVcGxFN3lDOEpZ?=
 =?utf-8?B?eGRvblRXeXJ5dk0yWllLVWxXZjVTaEpmUWxqQWl2b1hOc0x1Z21ZYmJoREFa?=
 =?utf-8?B?SWZwcENCNEpZVkRaRkZxQm1RQUlteG1tVEVYaTZEb1g0OTYwajBFTlRxOWts?=
 =?utf-8?B?cEhFOXhadWNKTktsaFRubDZaLzN6cTRUQ2kvMnBscG5lWVFqS1RjdExvT2Rj?=
 =?utf-8?B?WE43M3BOQ1h0eWlMbDJPU2pYb3RsNVFzS2toSi85emJHOWJMM2V6NnRRbGZu?=
 =?utf-8?B?ZzFCbVBESmhtSzY4Z01sb2U2QURNczJKaFpBWURJZjR2MW9idjQyUWF3WDJ4?=
 =?utf-8?B?dkhQMk5sc21UWVVUckJpWm9lbmZERXYvUTVRRkVnLzVLK2MxMzJqOHBFNlNT?=
 =?utf-8?B?SkEyaVlYYWQ5QmkrNVJXcDZZUU5hTUlKZDdTOTdKdytJVmFUSFB2eUZSd2FM?=
 =?utf-8?B?M2ZTU2NCUkM2azNWSGNOVWJ6QWg4Vnh1SGZoQ0lLcC9IaHpEcmN3MU1OdnAz?=
 =?utf-8?B?Ymw5WUZpTkVxRWgrRGJRTkZIWHVwenpBN1M2OHE2UVZBaW5WK1gwZUJHQkZR?=
 =?utf-8?B?ZlFXRVJINDZXY1NWMjRKU1BGdHoydGJzZ21lRkZrQXQ0OHpSTDNiUEtVRjZ5?=
 =?utf-8?B?ZDJkNnZsSjZJMXBQUlR1YStXVG1vVEhDSFdEbmt0QmJqQThOZERrOGFUaU9t?=
 =?utf-8?B?Z1ZYR21TYzZUNXFJeTNSRHRMbGZLSExkU2hVdllSN0tUaFZlb1ZaS0w5VktL?=
 =?utf-8?B?QjU5ZkxqNzlGNE85TjNPZFdNdTJ3VGNmaTNqQVNGUmxGVWovN2JVcWt2OFhI?=
 =?utf-8?B?SnkrdmZJS1lHSTJrbW9pckM4RmM2NnlLWEpvcHRNYnVPa1pXTUIwWFpVeXFJ?=
 =?utf-8?B?T0Nwbk90NHNvS2F5ZUVZcVBWTTdOSFRBZmZoczhscTFkR1RQNC82Z2VDYXFz?=
 =?utf-8?B?SFhJV1ludkxiM1YzNGQ2ZW5JNHlEYk5uaTVZeE5kWndlMWgvZG1kVkpCc2ZW?=
 =?utf-8?B?eGRmMm4yUnd1SXpyUmVTRHkya3RuVTBRUmN6dFNHTm9VUTFNRHE2UFNwbmhR?=
 =?utf-8?B?UjF6YnA5Z0s3SmNBMUNDVExQWG5iY2JxNW5TdWhLZXQrL0dRTTRsNy9XN0Fl?=
 =?utf-8?B?c1NzNmk2VjBBNnF2a0RVeW1qTm50YldQQS9ZdExsd3FyeVZxTW5UNE15Y0gz?=
 =?utf-8?B?TGxEVHlKU015djh3N0NzQWZyNDdFK0theXh2Rkh4Q1Nxay9yYUR2S0ZTa0pC?=
 =?utf-8?B?Z1FIMVR3S1Z2aGFQTkNPaUZBeXVwUjZ5d0trR0pYR3c5cjFLdUZ4ZE9wbHRP?=
 =?utf-8?B?bk42a1ZsV1EzdGRUcnMrZ3hlSVBPN0I5N1FoLyt0VmNBZ2ZaVWZYZERoelZy?=
 =?utf-8?B?b0pGKzFhMVVwNWFxbFZSQ1VRWHNacXhWSVJTMkZVZnlRa3FhUzd3Uk54a3Fs?=
 =?utf-8?B?Y0JuMXVxUlNSQ0lBckg0U0VEaWhITklKZmI0K3IvY29WZ21OYnF0TmI3SHpC?=
 =?utf-8?B?LzB2QVJDcmYwL2lGME1nTXJZYVgwS2pMOEhYSDA5dk5pRzdnaEtVU0VPOFFw?=
 =?utf-8?Q?czusVcKsSgg/1W6tU04ISSYllsWUQ3uIF7jLs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0ExSGpHL3pnOElFWk9aaTRyUTJRZjlBeU9QWTVMU3NsTXlQUEtpWENxU2tV?=
 =?utf-8?B?ek44UTRwR3gyK3BwL1hhQkpZL2FMSnpVT09MbVpwY2hZTHphbTJvSmwweS8x?=
 =?utf-8?B?Z2ZJdkg5ZTFUUXV6S0I1ZlFyMmUwc3VmWDB0Z0Q3MnJRbWJWaWhVakVZQUpj?=
 =?utf-8?B?dndXRlgwMjVMRTdrVUszSHZ1WEdDWlN0Rzk0ekpNcEhRWTArZGVqVllXUEJY?=
 =?utf-8?B?Q2xRczdkM3IyNGZCVjYxUDNxeHhoamdUbndFZ0F6WkMwcW1QU0tkeFgzd3l5?=
 =?utf-8?B?ZDg4Y3lZU1Y4aUFDNmxIOUNXV2hLMDl1b1hkMlVvVHlXYkhnb2x1ZEN2YjlY?=
 =?utf-8?B?U24zNzk4YUowbE9YMDZFVXZ6OEt1VGorTDl5SUxZVjBvNVFzSVZCRlZyTDZX?=
 =?utf-8?B?OGlTa2JpYkdWMU9tckdHWnpENmEvdGNvVnJVcEcwaDR5Z3lzMVprNGdONzhq?=
 =?utf-8?B?MzZTK01YSGI0ZFMrMGVObUhhNXZINmhjeW11c3VPZzFjQUNBbmJSV1NFbnp3?=
 =?utf-8?B?UjVIS3lEMXUrTklnRkZPYXR1MmFGaElQcDJsSkJocHBHK2NPdkxKUG9kbkxO?=
 =?utf-8?B?MDdsbGUrTXI2SzFhb2JpUkt5TUl1YVlJOXdabUVSMkUrcUFCSlZIWXBzVDFV?=
 =?utf-8?B?NGNwZjFkdkM5YUJrdEFHRkJTWFl3Vms5TzJlV29BV0J6ZGY5Mkp3QlpmUTdh?=
 =?utf-8?B?SzZkSFBRWFdCSk94WHBJbURTVUsweldUaTNtakFCQjVGZXB1aWxpNXF4cE9N?=
 =?utf-8?B?YldYa3hneGd6ancvWHFqSmcwK3lhT3hDdU5tczFrNmI2RFdpaG44NEFkYjVI?=
 =?utf-8?B?QklJbFZOV2YyVkN5WXFocUxSUVZBaWJiMW1lZVNBakQrZS9LMnQ3VmR5T0NB?=
 =?utf-8?B?aGNKMTZzWWM2SGtkelVPc056WWdpOTczbFYwL3dtL25TcHFnMDdxajFCZUFy?=
 =?utf-8?B?TUUrSEswTWxXMmlPZmNlR3IzWENJakI1M2RQb3owVW5SbmpxcTluMVM4RndI?=
 =?utf-8?B?RHFkMHU2VHdxaFZGUW1Dd082bWQxSDFUdFpIamU3YWxHY3p5WjJpRUlsS3pm?=
 =?utf-8?B?NngvNHhoWUw5M3UzTkxiWEJPMy8yeVhKeDlTZlBUVllhckloOWVSR0NlZTdT?=
 =?utf-8?B?RWRIUkx5SUsvNytUVnBRK3p2TGQvczRGT2FybCtyN0tOeE1mbWV6anlxWlhJ?=
 =?utf-8?B?OUtCMEJKWVhIeEg3TzR2OG1sNTdjZnk2eEJ5Zm9IaHNVdWYrOEpiM1BjYkVz?=
 =?utf-8?B?QzVQOURPYk0rb3RDd0t6RGJ2ZXNjMEluZTZwR2R3SUpWT3MzVkt0dEE1Qi9H?=
 =?utf-8?B?VnRRT0lxR1dMRTZzbU1SRnFqYlNTM1AxZUE2bUoxYXl0R1lLZm9wc0s4SHlF?=
 =?utf-8?B?Q2Z0cUNwdEhhaW9XQWs5UldONFczYnpoZWdVVkJobERkeTROUVNQN1hpZ3BE?=
 =?utf-8?B?NjJOWGNFcHM2T3JvbU9WQnE3SEhKVzVlRDQ1SEJUSUNSVEN0U2UwSDZFZzBn?=
 =?utf-8?B?UkFOZHl5Q3lwZnpFTHQwcHFNeHpGRm4wOVl0S1JWSHlxYUE1cWNNSFVQYmk5?=
 =?utf-8?B?TFlaVnlhY3JqQlZIRGhZYjA0cVcrczVBQjZqV2xXYkxkcjFSNmpPSSt6MVdm?=
 =?utf-8?B?bkRSVG42VWN6MFNRTklpNWtvQ1ZMR0lSSU5hamg3V2hNekp6NEk5VVduYzMz?=
 =?utf-8?B?TXdwd0d4Q0ZLUnpVaU5WcHVMMVBGTW9vQnBUU0tZb3RHcWNaeFFKSjlyN0Rr?=
 =?utf-8?B?ZEl5MSsyRkJMRm5IMzFIWGZzdEhKS1FEbHBXTnk0NWl1dXpuQmpTODJEaWlt?=
 =?utf-8?B?dWpsY3ZkY01FWXl3R2NpQ2Y4dDFwa3dQdnFBQWVyK2pTRmxTT2tpN0tPNnpV?=
 =?utf-8?B?SitOYXBMdU5meGVFaCttM3RHc2hudCtLTlViNzRsMjM0K2VweUNjMjQvcVhX?=
 =?utf-8?B?MDE0bGg3Y3d2OWQ3TGZDUGMrQ1VJT0NPOHpLR2FRbjNRYTZkVERidEo0bXJz?=
 =?utf-8?B?aUlvMDVObTkxY21qVUNKSUFKQ1k1NWxvRjkxMStZOXFIWVN4a2diSHhFSTFw?=
 =?utf-8?B?a3ZCSTVQYW9QZEJZeXU2U2k4cTVRRDg4dE5SdnlPT0UwUm9kN1BuenZWYVYz?=
 =?utf-8?B?cEhXTks5bWlSQ2ZPaXRzdm1GZlBZQmpod3NEQ0pwQStPWm9aalMrOWp2ZlNK?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a6678e07-2a4a-4bf3-a5b8-08dda1dd70b0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:57:40.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6bUudjBm3RJDx+42ehGtlCXdJaRDFwFI7DWx/Rsn+TchSdL+YE6rFhcXqo8eL68Fw4AAjnFAAcCph1zhMU4wcMcjec2ivFZqlQltubUYlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9201
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 13:57:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17672

Hi Robert,

Please Cc the bitbake ML as well. The Yocto docs community reviews the 
patches but it's up to the BitBake maintainer(s) to take the patch.

C.f. https://git.openembedded.org/bitbake/tree/README#n29

On 6/2/25 3:28 PM, Robert P. J. Day via lists.yoctoproject.org wrote:
> 
> Add a short note to the BitBake intro manual chapter to clarify that,
> given an unversioned .bb recipe file, the matching .bbappend must also
> be unversioned.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> index 539bb62d8..1c3faff0e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -272,6 +272,12 @@ append name would not match. However, if you named the append file
>   In the most general case, you could name the append file something as
>   simple as ``busybox_%.bbappend`` to be entirely version independent.
> 
> +.. note::
> +
> +   In the infrequent case of an unversioned BitBake recipe (such as
> +   ``linux-yocto-dev.bb``), the corresponding append file must be similarly
> +   unversioned; that is, ``linux-yocto-dev.bbappend``.
> +

I wouldn't make this a note. There are a bunch of examples, all of which 
aren't in a note, so we should do the same here.

I could even see this being mentioned in an even sneakier way, e.g.:

"""
BitBake expects every append file to have a corresponding recipe file 
(e.g. ``formfactor.bb`` and ``formfactor.bbappend``).
"""

What follows in this paragraph is actually pretty explanatory I believe? 
"The append file and corresponding recipe file must use the same root 
filename. The filenames can only differ in the file type".

Though we contradict ourselves a few paragraphs below where we say we 
can use % to do some less strict matching :)

Cheers,
Quentin

