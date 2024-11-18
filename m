Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF48D4923F
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 15:44:29 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.84])
 by mx.groups.io with SMTP id smtpd.web10.44165.1731944659161508915
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Nov 2024 07:44:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=R1BY23u0;
 spf=pass (domain: cherry.de, ip: 40.107.22.84, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsxPKXKbU2SK1qhAm2sS5FdqgSY/V4huNgAhdZMvED/DLXU6CXW53bAWa+xJ4aR1zWBSstc0aHNH8JyGrsJQ5S/ynQzwrUPfh8iVXLUXIMQXE/64VUM0OL3JzrorqVyw1ntbWXUIr7LnV30m9C1TKfH32BjNAqtSFa3CCcWWMPh05GkMcVU2SeWD7uoaMOPNHG2LWZ43cAFWF01T3ARhriaWiyPkeuLNGZ3riJDA5kYWLMy7Vf+sfccZE0vUUk9rUgNHsI8CQNrguQA7cQMVAhqSAz0poofUfdHaat7IcXkBBqdCM0der69wew7YHBF0+3OKk9nzjI9WY31+fL5XNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAFcRmeQZwCQ2QDsvpLbDdQQjmFLSqIkBzMKI65vNoI=;
 b=n3X4HqCL5osekG4rSptNwDCdxaTf+iP++NrafmPfug3wlgmUbhQ8lmzZmqFVWGfv9ICU9mqC7PInbDifGGiB4DAQmLbh2OO7l292tHOgQnn+1noRtVXxNnIiyJo0GF8eujbgvEnx5AY3MagSs+GZJOl922z/1blRD/xZNOgqjqslteATq1Eihhxlg0U/wXMQ6N+AAmeSzjNDGkPMLUSLdZRT1dpv/ZGZ5BGbE4PP1TW77dTOW4iZkLjGAeIMeOke+BanreY47ZKCLqTUQRD77RtPPynwW7eB151tHDv9bksVt0PzZl7qYwovmic8kt/eQm/D6xn/54SyS5dvBlKwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAFcRmeQZwCQ2QDsvpLbDdQQjmFLSqIkBzMKI65vNoI=;
 b=R1BY23u0trKQUyoxEWd4nbC018senSQHiar7e3mY0vZtV7Dr4/SRr4HljqzIZGWGtHt6hqNbHT/2UrjiXAjaIF8ZqqYRzGtyjLfUZVMQXZlMrxbkfZoBceCFk6m3Qeco4n9tpeDafmHlY/d5a6S5fpvYdMVb/NKcYXdcso9baVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GVXPR04MB10610.eurprd04.prod.outlook.com (2603:10a6:150:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 15:44:12 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:44:12 +0000
Message-ID: <672b93e1-54d4-4af8-84e3-de0912770b7d@cherry.de>
Date: Mon, 18 Nov 2024 16:44:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [bitbake-devel PATCH] doc: bitbake-user-manual:
 document inherit_defer
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Yoann Congal <yoann.congal@smile.fr>
References: <20241118-inherit-defer-v1-1-26866a60ab1b@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241118-inherit-defer-v1-1-26866a60ab1b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GVXPR04MB10610:EE_
X-MS-Office365-Filtering-Correlation-Id: b05bfd82-6660-4b28-d577-08dd07e7d987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGpNbFgySlB4elJtd1hhRDJ6ZVF6eWRSOUhuNUJlUkVxdm05cERzTjRKQ0Fi?=
 =?utf-8?B?ZVYrTFU0M0M3eDMwN3p5NWwzTWY1R24zQjhTTjF5NnYwT2poM1lJY3RaNkRy?=
 =?utf-8?B?ZEZ1Ni9rNjRUOWc3QVVBc3Y0Y082VlNaTUNFbGdTSlh5TFBzOVRNZVpZdTlP?=
 =?utf-8?B?V1plNWlvbmVsbVl3bHZhVkV6T0ltUGhvb0lzR2VqUkNLOHpoZEthR2wzRXVE?=
 =?utf-8?B?dU9FR3ZnNFVlcjlQb3RFZUt0U0RvLzlUNWsyNktaSUVLbXRXKzRaNlh2NDlO?=
 =?utf-8?B?MUI0SDVuRDZXVlpFMG10b1FZWDBZbEV4a0VVUG1PMGt1U1hTeWVVSGJyWkhD?=
 =?utf-8?B?TE5zUGtEUkdtSDBQZHh2TGlvZHpMY2NCU2pzZHJRTHE1OGk2T1Fpb2ZraEVI?=
 =?utf-8?B?RDlGZjV1R0tpUldkL1FjUVorV1FmeGVNT2RndTFCL0ZZRUhSdWhFT0ZTRHZW?=
 =?utf-8?B?YldkVndQbTRLUU9jNWJnUUhjMWt5a3BtSzZLZElTMkdDWTJscHFUM3VLdDJo?=
 =?utf-8?B?c0lZNXJXbEJLemxRQ2ovelp1cVlnelNTNDBVNlZhZHM2YWtqZ0NGeDQvdzE2?=
 =?utf-8?B?NzFJTGxGTDZaZUZabVN0d1VLOWVaaHlHbWg5K0FLWEdGV0F3N0tFU3hOTEdN?=
 =?utf-8?B?OEhJNGJLazhHcFY2QUdOd1F1cjkzZ2xzUEt4ME5aZnhvWXUwZmQyWW42bFBI?=
 =?utf-8?B?VU1Mci9oY0dxczhjTnlxdEtQMUdVVVZJUUt3T0VEcENDR2RFN2dPTW4rN3Y4?=
 =?utf-8?B?TFFGeU5OdE9iNGg0UVlkSFFieEprYjlnL1RRNytnbGZqQUpjVW84UlpBZHJI?=
 =?utf-8?B?b0RZR0dHNUcvcmNJYnZYYnlRM0M5QnQvYXdrSFo4a1Nuc0VUcS9ubGJhSUUy?=
 =?utf-8?B?NzEyb2tlZ3JTVTFJb3QzaFlqUnkveitOdFg5T2tDQmtXbXB3VjdDSS8yanBM?=
 =?utf-8?B?ZzIrQ2tuZDQ3Z2ljV2dncXZMdjBmNzJlZEVKbjQ1Zno5Qmd5TnY1VGxFZGtY?=
 =?utf-8?B?QUp0TWcwcTBJTktnc0dFYVdnczMyMHV2QjVYR3JRc0xtK1dVVmlHNGQrUWxF?=
 =?utf-8?B?MFJUMzNkZ2IxcjlIY25NdHhKTmFjZDhXd3lZa082aTJzaWZqZFkzdk1YMlNk?=
 =?utf-8?B?WnZMUjg1d0dlSjFPWE96N0lWK1pCUk83aEoxanJZVitvNTNTaVdWVTErVVpS?=
 =?utf-8?B?QXVYNFAwR0pTM0lvSzJnUjA1dG5MU1YzdTZjU1pZUjJIN2dRSFFUZE9ER0s5?=
 =?utf-8?B?SzEybkhWd2VqL2QwcGcwUVd4Ni8zaVpDakpZU3BBNFZSR0FUV0NIbHJkV1N5?=
 =?utf-8?B?ejBVSXZJZGFQZXNibFU1L2lwc2k1T2prN0FiRjQxUXUwZXBlNy9zVzlEekJP?=
 =?utf-8?B?alVsc2ZrQXIvR0xrTUxseDRpeW5Wb2pUM0tEdVhYdmNqKzRoM0FNaTFnUVNT?=
 =?utf-8?B?SHI1bHFtTGV1dEIvbXV2d0owcktjR0tzUnYrMTRYbmk4Q1MyQ2J4dGN2dUtW?=
 =?utf-8?B?UFRDaWRMVnNib25jNzE0VmQrUk91QmpaMjUrYWlSVjkyQ2szaFBreXZCMGZj?=
 =?utf-8?B?RjVNTlROaExSVWdraFc3UTM3VVBaY3BsNzBoSURCNkhWVWoxS1FyNVJBSVMw?=
 =?utf-8?B?dUFUQncrTFkyZndYUUR1eXNTL0drMnk2T0UyNzVCTXVBVWFBaHZJaWNvNHhO?=
 =?utf-8?B?d2xwdVpLZDJUZEc5V09teUZaTXJVNUY0cUg5aVd4b1ZvNTUwekhwOTJGLzB4?=
 =?utf-8?Q?OlspEli9ul/TIJQJ8rcB8Ge4tCDNFkG57fFfgXR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjlWTFhQQTZMaVVvOExVaC9iWFRuMW5QOHE0MVVSOGU5cVZjcFFrbjRlVEZk?=
 =?utf-8?B?M2IvaG9rbmxTTStNZ3lZZjVRODU5UlY0WmhCVVpCQUFZYnBWYUUzU1ZBWFpO?=
 =?utf-8?B?NzZUMFB1RCtvaWUwN2pmRyt3OHY5c0RHblY3ckJidjFNbWdPU3NoVmhuWER5?=
 =?utf-8?B?S3d6blJvNlI2OS8yYnZvd2F2d0J0bW5zcjRJelBVcWZmNHlMR0tZN3BSTXhj?=
 =?utf-8?B?OHM0OStYNTBqNXZyaHU1S2cvODlCdGVaRldmdTl4YUZaMTVlOXFpMmppc2M1?=
 =?utf-8?B?NlB0YkNSZXByRUlJQTQwdjhvNitNOXhRT0J1Y3Q5S1JxRTU0SDJncjZNSVY3?=
 =?utf-8?B?Snk1ajdYcjRZY3Y1NnpZRjdtbFBUWUFocTdLelRXVU9WTkxZUFFpdHJnY0xn?=
 =?utf-8?B?WmhaOTJnNFhpb3dtemxKRFVrbzJLanM3eStLanNxcitiVFRIaU55Zkl5Q1Fw?=
 =?utf-8?B?OHVGM2NoYmlxRDYzOTcyNmR3UjRYYm1zRjVITnBQd2pTcGdhZ0tYLzJkSzRa?=
 =?utf-8?B?bU9iVXlZVWxCSm9pc0xuSWRqeXJFc1VRYVVUVTJmZG9vTVBUaEtYcER3QmpD?=
 =?utf-8?B?UkJ6WXlENWJWWmhjRCtxUEdCZjVyM1RyTmlzUklVSTVwWlRPU1NualZBb013?=
 =?utf-8?B?d242UmlWRnpwaUR5WUV1V1hTbHhtSUYxUUxPbDFOdTlEb2UrN3gyUkRvbjl3?=
 =?utf-8?B?VmEzYkZTV01SNUd5MENTcTZTVHhyQllxUnFhM1JCMUtDbTBuMzVOMUx2ZEwz?=
 =?utf-8?B?QVErYkcwc1NXZFRySjNRU21JeFU5MUtwRW9raEZSTlFvdStTTXdsc2Vqdng3?=
 =?utf-8?B?dmZLditpYXZpYm5ueEJhQndBTCt3d0pwS2kxay9QQm9wQlM5bGt6TDJZaHZ2?=
 =?utf-8?B?RW44UEhEU1gxYmdySzNwWU5JSHdQbHhlWUZjakw0eVladzFSdUtUWFdoNFNP?=
 =?utf-8?B?T3VKcTNib21CN09rdkxYd0ZyTGp4Y2NuSFR3d25BbmlKN1liV0YxcTlZRXlZ?=
 =?utf-8?B?RVR2UGRIN1NMSFVzL2QyWHZ3cmJ0S1BVTnIwM2dZeGZOZkFIN25Obkh5MzV3?=
 =?utf-8?B?dUVoSTRocGFEeXBzU3l0Yjc2Vno0RmhnSkNsZWVjL2VBUk5sdVpRSSszMXVE?=
 =?utf-8?B?NWcwWEkwSFh0cENoSHlFUW1DSWtTVU5TT3gwc240UWw0YVp0ditURzN4dWxG?=
 =?utf-8?B?VFV4WTJ3T1Q2Qm5yVlZBemw1bEp4Sm56Z2wzU1E1ZGpIeWR1WG5uS1E1cHlB?=
 =?utf-8?B?a3ZPYXVJZi9saWd0ZVh6WUtCS2tBaWlQcERDczVxRWJ4cUZzZFJKckh1OGpY?=
 =?utf-8?B?Z3pjclJmSHk5NDE4VGhzeHpvSHpkM24wTmhCc2J5VDlOVzlBd0tNaDFicnVO?=
 =?utf-8?B?YTM5NDVNck90YlllNDhxeWVQK2xNaGpydXBjbXduN0NNblJ6SVFHL21HMS9L?=
 =?utf-8?B?a2RPeS9nQkRWRWxpQkgwOVBwd05VdFdWWHQ2U094YWJWSlVYMG12ZWRsQ2th?=
 =?utf-8?B?TFkzTGlPclZ4TnZxS2FMZU9jYy9Ma3JQcE5NanFUMGlwdzBoMzhaN3RrVSsy?=
 =?utf-8?B?UjhIZlBMYzBsdmg4MFVmSmRoT3FucU1lZTZValRKNDMxcU93U002b0tXVzVR?=
 =?utf-8?B?LzY2Y0I5K1pIbFFWaCtOdzJUR3MvU2lKK3ltUWNuWUlXK3hueHg3QmZGOC9X?=
 =?utf-8?B?TWMwQnQ0N2xjY3Y0M2pLZkcyWEJtMkxBbEdQeHhQVmxYT25MM1B1TDV0ZTU1?=
 =?utf-8?B?bWdpVWhLeU1wc1lCbWZjaGF5d29ad1NlK3A0Z2NqMTdNcVJVZWltQW5DNE92?=
 =?utf-8?B?eUllVEloSHVGcDZjVmZhbUp6T2k5dEdST0lrZzBsOWZDMmN2ZWxlaTF2Smtt?=
 =?utf-8?B?Q0x4WENqS3ZjQXUvbnhXNHdVSWF6MWxNSHdLSUloY2NqRkExTHZnb1BBSDFh?=
 =?utf-8?B?SGI5eTJJSFhPS3QyTTdmNld4Wk83TFFFK0VvSjgyVnRwRDU0VWYxeXY2VU8v?=
 =?utf-8?B?V2lsTnFQdnhvOExybE5jMCtSMDBtVEVjaEdNSkgvU3VrOGFPTVh1cW5RenZJ?=
 =?utf-8?B?R1Jyd1ZwcXRnRnVReFJtZ3dzdFNyR1VqVFU5eFVKZVgySlowcExLN3ZyY0hC?=
 =?utf-8?B?ZndwMlU4UE1MN2FDVU5BOHZYMjZMa1V6SThkNHhpZ3hkS2FKbjVtZlh2aG8w?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b05bfd82-6660-4b28-d577-08dd07e7d987
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:44:12.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCkMPc4NHTRLDrpUg263ZHO3xkXbIVc9pPjbysLEDp7f/kh1i5qoFI1m5F9O/A/l0882LJD87aawKWl4W/Z3HWanOMlk+w9CD7d6jDodzVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10610
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 15:44:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16805

Hi Antonin,

On 11/18/24 4:36 PM, Antonin Godard via lists.openembedded.org wrote:
> This was added in 2.7.2. Add it as a subsection of the inherit
> directive.
> 
> Fixes [YOCTO #15640].
> 
> Reported-by: Yoann Congal <yoann.congal@smile.fr>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 58975f4c88ce549a2fd27136c0cb37b636bafcdb..ab16ddde3cf837092d4c43e467b4becceae23b27 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -840,6 +840,19 @@ In all cases, if the expression evaluates to an
>   empty string, the statement does not trigger a syntax error because it
>   becomes a no-op.
>   
> +``inherit_defer`` Directive
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``inherit_defer`` directive works like the ``inherit`` directive, except

add a ref here to the inherit directive section?

> +that it is only evaluated at the end of parsing. Its usage is recommended when a
> +conditional expression is used. For example::
> +
> +   inherit_defer ${@bb.utils.contains('PACKAGECONFIG', 'python', 'python3targetconfig', '', d)}
> +
> +This allows conditional expressions to be evaluated "late", meaning changes
> +to the variable after the line is parsed will take effect. With the ``inherit``
> +directive this is not the case.
> +

OK so I don't know if this wouldn't also typically apply to "inherit 
${VARIABLE}" if VARIABLE is set after the inherit?

Ahah, I believe this is actually specified in the inherit directive section!

"""
An advantage with the inherit directive as compared to both the include 
and require directives is that you can inherit class files 
conditionally. You can accomplish this by using a variable expression 
after the inherit statement. Here is an example:

inherit ${VARNAME}

If VARNAME is going to be set, it needs to be set before the inherit 
statement is parsed.
"""

Also, I believe we very likely want to remove the last few paragraphs of 
the inherit directive section?

i.e. from
"""
One way to achieve a conditional inherit in this case is to use overrides:
"""
to the end of the section.

I guess we could replace it with "if you want to conditionally inherit, 
please use :ref:`inherit_defer`".

or something along those lines.

What do you think?

Cheers,
Quentin

