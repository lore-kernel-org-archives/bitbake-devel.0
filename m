Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1BCC5DF9C
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 10:26:32 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13624.1787567183340253803
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 03:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=mt2Hwrh5;
 spf=pass (domain: cherry.de, ip: 52.101.72.9, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft10G4gScaSVeHk7P7ejAGUrJaRZSz2Gi0TT39XEX/jhCoH977bETiW/lfSATEo0jGd9mq7a+5BEI5KsC6gK3xc5T8wAzGXW6QlEcfcuVHLjMFyrxMg9OqZQyJtipiZ/JRREF19PGCVcNTYLBf+JHOhPBUvoig/nJXfFmLRBVQ7bs4mw4aa98ukKtWKkXTdwppNkhHzbHnoSGLq4Zye/U9XwO8wQjSq8jrF+G03tXaAmfK9RJRzp42GuamsukKSCDMkqsgbzGv3gJhW/bO81KDwSJ1mz61o3l+bB443qZHIXArsyx8aU1s491lkeA1p+zWmGEl6s0BmWKzXJSkGI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oIPbbeaRKDta5l01QwUcyHb1ajb15DkDXxHhVDxvmo=;
 b=vNyIEOAF4p+TnDsQneaLOrmavfpIbEmY91xeelhqIGzn9261gFBEF+ZWy1LHEvftLnZxV6hWF4NZopgS+NOX+8ZTaIqetvHmQqwiVrGofyY/AHJvwKECGDULtqIfw7vHtet2O2DYpvG5pUzoR00GazopDnuzjtTosifV4lZky9TB9AkhDguZn4UqOT00r/OIHfVxCpLc3/LVjxgW5gEaIyqqzV1jUqHp0NXm861PxdnuXENg0Hc94J1clyPMKZmEcp5Su29C7keFbGvRnkNFiez5DGD2ef1mDNTEOP5n+W1RUSdovLNUzXMCbtwabgpo+KUkWK9Cjr4nZtiubatkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oIPbbeaRKDta5l01QwUcyHb1ajb15DkDXxHhVDxvmo=;
 b=mt2Hwrh5A5p0FkboujQZ8Yejvoe6MO9rOfTV0iZkyCUxM/SNyE1RdLVckPpnAWleUo5sXZYZ/5bnhRQ2Lhq75BSxvctHzcTJUHQQOWJcbbteREkKggWSASkPxu787/6foaGupzLm43Bo47ZcqbdBWzSYW8nQYX2wWMmiF122S5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA4PR04MB7759.eurprd04.prod.outlook.com (2603:10a6:102:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:26:17 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:26:17 +0000
Message-ID: <ac19f181-f193-4a84-8ec3-94a374c9ee56@cherry.de>
Date: Mon, 24 Aug 2026 12:26:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-ref-variables:
 document PREFERRED_RPROVIDER
To: yann.dirson@vates.tech, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <1787566358.8631fc262581453bbf619ec5b2062170.1a033420133000c4f3@vates.tech>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1787566358.8631fc262581453bbf619ec5b2062170.1a033420133000c4f3@vates.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0265.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::32) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA4PR04MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 79003792-0fb2-4316-6ff4-08df01ca21e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	CpnJTxnAtEwtNYSnIqEXM7jkiANzI/RkYAbscDv4qTQdYK061hmIB7fcrfqTPHwMR+K+xbLQ9ak4eLbt4UMuvhBNAODhWrciApqrSjzK+VqO/Wm+W2yeVcFyzq6Y7VBTGLzfR0mrmmrh3u6IjflnfGH4tl6c0Z3boKyKk6xjI6BHVwCD0byL6CZBvCIaSFeVubuxjz/hYuZ9Xau6LviBrVJIAyZEZqk042R8RD5L5l9Z3MWnICeGOLWUptCFH/8cqf4GZL17EUxdWCwE1tgEERLFGNUzw6n7aCxtZ6qhS3ps6rirqaMB175Bn30VJ/1h+2gT2BE67TzuoWoZ+Z0jGrTU+sqb9Y6+7hASXo6lB0wE8rEkWQLXdeidzHzeApTAST++zwTIFVNByQDV56aRn3ENu75IHoY/G0uPotOi+MGyIJWfgciU5RaYz/gr9sPrCfbU6OfMmiaUQAHQ76PE7hYnsIo3vyspB1ieUDBL8uA8OLkWdGB1481NACkf6en9dkIDgDcjF4xXPxmoxaYbyPzlrlXm8kqLObgWSLSynoWkdyumKVR6kI7wR3a5Od702udFo1n8exicsA9BtpZD4lxxsikHkb/BicYmaEWfPDl31U3j99a/ynrJgY34y59XGCODcXL2PaSaD48zgIDlEj03O9wMqCMQtiwuI5SKF4w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzIwN0dRWXVka2FWYUg2TDBDMGVpKzlyaTVYOHhVVlVCa1hYdkQ0bHM2OEFH?=
 =?utf-8?B?MnRRc0VMZUUwM3hleDN4OEdNRFFraDBHWXJGc0hzRzRlNjdSaUhKTlIxTWg1?=
 =?utf-8?B?YzRtVmR3TUg3bnR4cVFJSzRmaGNVSnREUWx3a29tblh1am1ZMHIyVVJRZTBO?=
 =?utf-8?B?WGl5amUvTjNZeTFqdFBrOG1QMHFPWS91ZGN6eG95UnpPRDRvU2FCRUJVUVp1?=
 =?utf-8?B?SDhaSGd2SHowR2laVS9aWlphd0tZbTB1aytFVVdvUDNYUnJ4RVh3aVNVS1dy?=
 =?utf-8?B?TWxHaTdoMXZwMGlLdWtpN0gzSVA0ZlBEWE9ydGhLQmNzblhWV0dORVB5Q1k3?=
 =?utf-8?B?dks3TmpsaSs2eUpRbXBMOWxaQXhra0VBWm1PV3RkRWFzcHBiUWl1QmpnYjR2?=
 =?utf-8?B?eHp5NjFCK0JIZUdPMU1RTklvblNPb3I5djdnb1BKcnhMd2tWVjRBNWVnZ3Zl?=
 =?utf-8?B?KytVMDdvd0R0elo3ajdyQkhzUERFRHRnR1cwSHlDbFNZN2ZQRHZUUnQ0dCtj?=
 =?utf-8?B?WHlNM1cxb1ZKN1dHOGdzOEsxbng5QU51N0kwN3RNb29tdGpVeWNRWkdQVjBw?=
 =?utf-8?B?aDE2T2FXblNlRVB4K28vMWxzdW5JR3VDVGJ3YU5vMGszdDFoc3YrOW13b1Vx?=
 =?utf-8?B?WXNxMFlEWEFPcXhHVk5BeDZnTDJjVVMxYlgyam1BcWlDYUZuRUVjSjBVMzE2?=
 =?utf-8?B?Mng4S0xwanpEVkZGOGQ1WFVmZmZzU0oyNzJQdWh0WTN2cE8zUzBUUHJyNUpo?=
 =?utf-8?B?TGpicjFZUDRVcTk1QnUxTjA1QTF3TEpYUy9uRVFHSzdkSW52KzlyL2xKSmNQ?=
 =?utf-8?B?Z0d3cFQ5OGRRSDNrVWNrUjVVMkFEMDBVZHhiNnMxb1M4ZDV2UDBvZTVvMVI5?=
 =?utf-8?B?RGdXOFdJQmRFaVdtZEtPRlptTjhUaXJXdEVIMThodVFwV2ExTy92cXF2bEVF?=
 =?utf-8?B?aUpzK3RNc3NiMTBKUnlpWUpHMmZHS3QzcER0NE5XMEg2TUV2NzlyMDBocnVk?=
 =?utf-8?B?ak5CODdmS28wdVQyK1VEcnVPOHBpSytZMDJ5SWo2Qnk2MCtLcnlybUdZUFlK?=
 =?utf-8?B?cThpTHJNYUJNMnNibmhGdEM5RVZhaWJlNnhwQVV6TU5nZnlkQzdvZUJvRjVl?=
 =?utf-8?B?cFcxRWdwQzhGbEtaamRKQUVmZHVxT2ZpSEZBeDBEcGlSZnIxanRjNVFFeGtm?=
 =?utf-8?B?dzVMVlVEc3ZhN1Jld2lwdmxQMk5EUXp0K1A4MFZGV1hTRnpMNWFyelJ3L2xU?=
 =?utf-8?B?TExsM2htazJhcCtZWm5CV0pIdjBabDZhSXovbWgvYzVIYTI1aGloSTVtU0Fl?=
 =?utf-8?B?VlRDem1yUHJGTkJkMVcyb2lpeG95Mkl5cFMwbVRPVDVQZG1YVEdLMU9qWUFT?=
 =?utf-8?B?aThqSTIwZ1BCMVBXNzVwSjUwNEx1ektsbGdDTWZXTW1rZXUveEllaWt4UGtQ?=
 =?utf-8?B?NzJpWTViQ09KMFFGTVNsY1FpTmU1b1lHMUZkMi9lVHJSZEdwWVhrUHRiWDU0?=
 =?utf-8?B?ckNkaGhTQWd2SldXQlN2a0ZkWkVtMnFVcHlSdlFMaVZIQzB6THVUSTlVREFw?=
 =?utf-8?B?MDJyU1JIRTg4OVdMUTFhN2x1YnoxVlJDbk9oWFhsSktOZVYvcEFnbVJWYXdS?=
 =?utf-8?B?Tzl2L0ZadGlDL2Z5a0cvT0lVZTVnWlRROGVaQ2xablY3ZTNqMDQyUGxQUzBx?=
 =?utf-8?B?Z1hHekFGZWVPdHV1QnFEYXRVOTFzTHdvRkZLaWRpN2dSTFpEamtpTTNUREZQ?=
 =?utf-8?B?THBodTRkSDRCSWkybjJ3NGRkZ0daSEJ5dDY5OExrMHpYT2tGaDhVM1JpTG5w?=
 =?utf-8?B?ZmRrNHRhdTlodG44cWE1dkNiQWxYMDF6NWNMSGlhVThNTndDUTkyTkdJUkpr?=
 =?utf-8?B?TUxLMjAzUkNOTXZMVDJ1dUlGYkxhMTFhWkVYZHlQajlpL1ZWRzFzMEdCTlNP?=
 =?utf-8?B?TFRDK1A0ek51R28yc2dROFRFckZNNVZhYnhUeGdXdU0rbnlsQkcxY21jTEIz?=
 =?utf-8?B?QjB1alJqakJqbVVTUC8vZTdzbVo1Q1VDbFVDZkdyTDRDZ1RJU1JWSE5PMzJV?=
 =?utf-8?B?U2syZFFSaGw5SnNOc0M3bGkybHI2eVBGY2ozTHpHRGlQK1JGK3Fwc2FYQldx?=
 =?utf-8?B?K3BlMmlMY21zak1BRDJpdzhYZmtIeFRzWXFUdysvNjhsRzc3QWV5dVk5eEdi?=
 =?utf-8?B?MlU1MXZOTEJxWElKRUNCZDFwWkxFM3BYU3dDZU45RUNHR2ZOMitCc1Q3WDdH?=
 =?utf-8?B?ZUc2dWUzWFJWVmx6cmVNUjRYN0lBZkdwZmRDaWtsVUZqTi9DWUFFZEF6Yll0?=
 =?utf-8?B?Q2hFOTFYOGt4cmQ0VjR0SDEzTXUxcHAvSjVwV295MWtBeTNwRGtwRW9RNUpl?=
 =?utf-8?Q?Sd8aZRVtlnkw8eCYgASIE7s+GIolm73UegRvSZLUTl/pM?=
X-MS-Exchange-AntiSpam-MessageData-1: 2gSBsly/2/dJAA==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 79003792-0fb2-4316-6ff4-08df01ca21e0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:26:17.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huvr4bP5FQl6K4ITd8YUYiU0WkQ0axdfqvrqBveOMvt1VxGKIMnBc+DqHMPomkPPfDjmexl0YqrVriMc27W84LeYoAabDCsfBSfwUqcD2Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7759
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 10:26:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20023

Hi Yann,

On 8/24/26 12:12 PM, Yann Dirson via lists.openembedded.org wrote:
> [You don't often get email from yann.dirson=vates.tech@lists.openembedded.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
> ---
>   .../bitbake-user-manual-ref-variables.rst                | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 5395ce5e3..2756fc0c4 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1558,6 +1558,15 @@ overview of their function and contents.
>            PREFERRED_PROVIDER_xxx = "yyy"
>            PREFERRED_PROVIDER_aaa = "bbb"
> 
> +   :term:`PREFERRED_RPROVIDER` Determines which recipe should be given

Please be consistent with the rest of the file. 
:term:`PREFERRED_RPROVIDER` should be on its own on the first line.

> +      preference when multiple packages rprovide the same item. Beware

rprovide is not an English term so all readers won't necessarily know 
what this means. I can suggest:

"""
Determines which *recipe* generating a package runtime-providing 
(:term:`RPROVIDES`) the same item as other packages should be given 
preference. Some examples::
[...]


"""

> +      this should contain the name of the *recipe* producing the
> +      package that rprovides the item, not that of the package. Some
> +      examples::
> +
> +         PREFERRED_RPROVIDER_initd-functions ?= "initscripts"
> +         PREFERRED_RPROVIDER_virtual-libegl-icd ?= "mesa"

Are you sure this is still valid? I don't see an RPROVIDES for 
virtual-libegl-icd so maybe this is not doing anything?

Cheers,
Quentin

