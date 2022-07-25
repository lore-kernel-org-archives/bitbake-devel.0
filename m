Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65557C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 08:36:16 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.79])
 by mx.groups.io with SMTP id smtpd.web11.25771.1658738169472337409
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 01:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=exsuI4Is;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.13.79,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjxA1H0mS9qKOx3urhZaInko+8KsaUt9dacdwz0AI3uzJH1rkBODKHakHZYcz/z9cwXVTBs1pzAO1pXfI7geYE+V08+5PoA47A8e6p2adBPXjE1ifbKeSuji4pNKBn/FShpE04MvBGmQTj4WK5VHpPvfkbiY+KL9b1ETFyHWMXfUmNe7TW6kiRrFC8fvldsxUVxwqumsnhwOVLx8ReI/uPXTvfhJFpX042kU+ppaGesfPLdvbT+EnEVxw7+9f9QKZ35dSVYEEQChm+3BEoAxGXpTUcOi969ir1J88MibF4+Cj0MlZz6qNvUkHpN4w7QCgMqalH532b7XE/AAvfbXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MaxSZRHHKF7z5jtnH/SuNfGNVfw96qemDNgDEssCdQ=;
 b=AGtbv8Xb2eqihczfIRxUFTjFZoRsCyM/bTo2d87tpiiqSbZVlMTpxjEgH1HWO2m4t+BRuRayAzggHWV6WUGt6BTrWMbAQOZfRgY19lCmKLXbgy0upEOmUnYXYCaYhy6l7V/vukjhzDuRJGcPIENC8m5q5Yw+QgVQH3ksde9FRMzrW3L1nKn3wA8PIZ3FAeRTL7YPbaak1qUyWif6W+l4fpGbv2dtLPRi58mso3ejzsdRxfO0Zh5L8ouiiY7r+MTMKjJ2QEFGEbubNck6IYcWgsfQjJP7xf/LFJoM63WOdCVk+/zCrgbV9Bwjda9u0PMiPMFzTjM7OWJlKGLHEl4/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MaxSZRHHKF7z5jtnH/SuNfGNVfw96qemDNgDEssCdQ=;
 b=exsuI4IspTo6jpFNHXzGXkCk+5EklyOz9648N/996Y0ImlAvr3tTfgPAcT1VWfWfCUfQ1WJhR7HvzCLuX42MW0PsavdcTYqOu4VOx3Jlw9HJXHh+ShQTZQ/LNSHxVYiDCl0h9n5emqt8D3dH8cW8oY2V8bT4cCG4E78CG1JZvfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by PAXPR04MB8639.eurprd04.prod.outlook.com (2603:10a6:102:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 08:36:05 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4%9]) with mapi id 15.20.5458.023; Mon, 25 Jul 2022
 08:36:05 +0000
Message-ID: <3839828d-f538-a865-8e87-64ce8d04ac21@theobroma-systems.com>
Date: Mon, 25 Jul 2022 10:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: Document override
 :append, :prepend, :remove order
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220723011305.311655-1-marex@denx.de>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220723011305.311655-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::18) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5bab70e-6e81-4826-0dff-08da6e18b6c4
X-MS-TrafficTypeDiagnostic: PAXPR04MB8639:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4MUJKO/wlMwPG+mp+GxGbwB5HKbhlvn1pyQ+dJK2UHnPEbWYvw5tCVaGzY/Qi8uOu8cJMsAxvrw8JSSI9Vmnxh3aWKSJEuM6MuuD+u+D61LywkOkj2Lp0ho8uOFHeexTq0Qr/fkVQdKBTgSkeZlmFo+POzzxqpTl+fkyIlfLlsbgqL1rTA/Xg1RiBTb7j6gzxvozWA9ndyL8yKWwYoqPURjGNFzUPcg/BoJteY5anbT2le+nyH0/fvvCWYnSeQnLcHI0wHvyTALA2oJvfRO6WfM0l1kxy8uEMZNCk8/wTBLH1a/nbPhg4LVkaIWW0p5AvbYnCN1dHR+joiDhmG44onjz+tq7C8C4SZz+pnEM3Z3kskYx0nmCmfo+G/aZ/+Z7eTwgbMBLIYKszSrYDgBVD9mE7CPS1OQJ5jRiILY1Vk/2I+/O+DnlUzBEv/KVVCVYoz9NPoR+ehumggCPvHd0NaXY/CPPBjaXQtQRTGBmTytpZ378zerz7L5Y05Du9BfmtNXVRgal5Oq/5EAJgtxoTyVkV9rmW8nwQzy03VcaIb7YJ8mVK9eZY0zHwm3vLKePmRBh5d9tKSA9R/kAnS344U/ZvtzpNxlyZGCAAGjejIK8p42BbX/ItTjNaNcrImd25GIKW5ZoRzTBYlsJ5VX1QMp2rMXjMky+dwZa1u9gWaSzRrCEUTmAAq86/X7TVzlmWYNzKSUzv6yLEnFYiEys0u3veTOnZZ6dmAr6+ahgC6h66aEEPzn/Spqgb0eYuz4BhTd/Lrigfg9tmY0pyeyvBw2+RQNC/R72QlWM0Rx0F4fAeFr9rt7JmAlWU+ky9b80r6SkP661avSPk5LnbY9LBfTqdmCjKMSKUZweBtyf5uY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(346002)(39850400004)(38100700002)(316002)(36756003)(31686004)(186003)(2616005)(2906002)(478600001)(44832011)(8936002)(5660300002)(6486002)(966005)(26005)(86362001)(41300700001)(83380400001)(66556008)(4326008)(66946007)(66476007)(53546011)(31696002)(8676002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHc5eDBTZ2NlNHUxNlQxQ2FYUzJtYUpqeXkyQTdKNG9FMGtpWkJxVzVLbjNI?=
 =?utf-8?B?NkEvZjhKZk5YalAvSzVRVlZJS1p3S3EyT0dtMUNzRm9jTzFFRWZkK09qanpk?=
 =?utf-8?B?amFoc2grTjZtblNhOFNOdTQydUZHeFYzNkZBeDVQNlVhMXNGZmdScDhVemR3?=
 =?utf-8?B?U0tZRHlud2swSU9OQTU4Sm1Fc25ZOGl0QVhsUjM5VTZLT2lmSitUd0puZW5L?=
 =?utf-8?B?R3JBTWtPdWZTaGpDMkx5YmYxYkNvcjJ2SW1iQTVOdk5vVTZZK3hBdFdicTlI?=
 =?utf-8?B?NjdFMDFiK2FNV216Z2VCQlNqYkh5OW1qYTI0TEhBUjBGekhYWTdueGIycm5o?=
 =?utf-8?B?U3hDbUhHWGNWQW5veWNBblNqcWIwSU9kMkFaWkNFY2hVL24vOTVycmhVQnNC?=
 =?utf-8?B?NzMvdUNNdHl4Wk5xK2dJZGR1SzN0Y0R0d0g5dGxXNUlTZHVRTnJ4ZjE5ZjN5?=
 =?utf-8?B?MHQ4VlAyazRSU3A0Z1pmUS9pTzhIb2NwRENKNnZJNk9YYTlaUVZQLzBNUlZP?=
 =?utf-8?B?bytNNmRRQ1dXWGc2Y1B2dDFBOUxGM1Z6aVJxa0Y0a05ISlhQc1dtQlNUeTVk?=
 =?utf-8?B?SmlXSFgzNnRFTG84TzhKNkU4bkJlcWpxakl1djliaDVJTWdPVUx2Umo4MHdz?=
 =?utf-8?B?VlRGdHRxY3ZkOWk0SldvT05xTkh4QllUVnJyWWJsYjBETXRGVi9FWW9Vb290?=
 =?utf-8?B?Y29rWTQ5eXhTcnNFOXNXWnJWcnlGaFRybnNtUjJKcHFkV0ZvTS9jWGUyT3I4?=
 =?utf-8?B?dGFEUFQ3Z1EyenFDWUFPY2swRS9NV1UxYjJvS0lSMmZuNU9senlaZ05Bamwv?=
 =?utf-8?B?aUt2bCtiQlM4MExUY1cyQkg5YUlrRDlQNDRsNUJUcFBzK0YvS2dsdnhCNm1X?=
 =?utf-8?B?SEI3ZWROdzN1aGYxS1B6NXVGRWZMdlNWSWRQK2NDZWxtdFFRTERPdnZHNGVw?=
 =?utf-8?B?OVhLMHc5NWtVWUtRLzFZQjRDTnhQR0sxWUk2M2VBUUsxOC9qK3VMSXNkTEpu?=
 =?utf-8?B?bHNBelB3SnAzb0NWUGxEM1VuS1FlNjNXbGN1TEZlUFRNT2FrTjl6TWl2ZkNv?=
 =?utf-8?B?MVUrNExWb1lHYlNHN2lvQS81MUFkZUUyd3kvd2xOMlRiNFkwMkxBNXRZbnJi?=
 =?utf-8?B?Q3RoZVgxc1FKM0VQU1VJOUMzRDBxYTRHenZDdDExM09ZQ25jZ3RHM1VuMllT?=
 =?utf-8?B?elhybzlNZXRydVI1ZnpwR3BsV2RtQTFKcjF6UTlRTHBsQ0R3Wnk0aDNFSVBY?=
 =?utf-8?B?WnRWZGlycXdVRlpjVHJRdFk4VmhuQSt5bzh0YmJET3JUMHlFY2xSdTZ0NFg1?=
 =?utf-8?B?SCtPNDVoK2VFemZpSmpYV3YrRVFacG0yV205UFBJSCtiNHB0QzVycXhnTm9i?=
 =?utf-8?B?ZUM0NGMxUFJvejFnaSs2cHlNNDMrRTFZZXNtWENwbDFIRE1Sa1d3dU1JeURK?=
 =?utf-8?B?WktBcDVpQjJlaFpPY1llWE5GdDY2Ymh3cUZxdXBQT1pXOC9OUmtmRHAyYmVX?=
 =?utf-8?B?RjMrcWw3ek0ya3VJdUMvWTNkM0tJbXh4R0hObVl2bzJicm83SGJDMEU3cmZy?=
 =?utf-8?B?REFJSEc2M1FvbmNGNGRXeFArMTNDWkRZaWRYNjBoamRCQXBOZzFTeHErdlgv?=
 =?utf-8?B?RC9VTnhITEZCRHM2cmdWdmErOHpYYVNJeDVRTWhocnFJNTBNRHZuM3ZnRy9i?=
 =?utf-8?B?Y2ZPek10c0xqVmVvUHFxSXhkaU1Sc3N5RzQ3OEdZSy8zSWYwbGN5WE9oMytQ?=
 =?utf-8?B?dFdnQnlsMWhGVUNZc2FKdGRKNWgvUG9lWkRrUGFOOThvMExtWEJPNnZpQTlp?=
 =?utf-8?B?b0hwQW5uYVpZaEFkdmR0VU5lalVlZjlCUEJIRU83NnUrVys2eUtlTm1YNnZn?=
 =?utf-8?B?QlRXWC8wYTJWVVBwRlNnU2JIeEMyY0ZYR01xd0ZtZDNFUU95ZytmdjNVSTVm?=
 =?utf-8?B?SS9LamxCTUZ5MEszQjRaUm1PdVNRbUlqbXBjS3dMMHUxZFRDNWw1QVg2eXZm?=
 =?utf-8?B?bUVSaHltQ3hLZk1xUGhpYVdicWdyN0kzMEVWMURDdDZCSFJoQ3I0dmVCOGhz?=
 =?utf-8?B?WllybG5LZjQ0elJPbURhV1UxeWcreFE3UWVDMkNLVzNmbkh2M21ObHNQdWJo?=
 =?utf-8?B?aHEwV28rTkRFZmZNVmFRRm9oS1IreDZ3YmxkZ0tRTXVsOFR0KzVLcnJRdy9a?=
 =?utf-8?Q?lGxg9pILUev1EFJN8QK0ddI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f5bab70e-6e81-4826-0dff-08da6e18b6c4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 08:36:05.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 26ZtzQfhRaouQtA8pJtjuwJrX1I1YrIR0XEEbd/TsaOYv6bGR/9ZZawclfAKJiTSRC28PP6WVO55Nz+hf7KYdSFyFSAIblYN4jFLhHqt2zJwRPyM8gm9UuMU75pWwWZn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8639
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 08:36:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13839

Hi Marek,

On 7/23/22 03:13, Marek Vasut wrote:
> The application order of override syntax :append, :prepend, :remove is
> inobvious and undocumented. The order does not match variable parse
> history, i.e. output of "bitbake -e", either.
> 
> Add note documenting the exact order in which :append, :prepend, :remove
> are applied to variable in lib/bb/data_smart.py getVarFlag(). Add note
> that this order does not match the variable parse history order. This
> is mostly to prevent others from running into this and scratching their
> heads, trying to find out what is going on.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   .../bitbake-user-manual-metadata.rst                 | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 33782161..651116ce 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -351,6 +351,18 @@ The variable ``FOO`` becomes
>   Like ":append" and ":prepend", ":remove" is applied at variable
>   expansion time.
>   
> +.. note::
> +
> +   The overrides are applied in this order, ":append", ":prepend", ":remove".
> +   This implies it is not possible to re-append previously removed strings.
> +
> +.. note::
> +
> +   Override application order may not match variable parse history, i.e.
> +   the output of ``bitbake -e`` may contain ":remove" before ":append",
> +   but the result will be removed string, because ":remove" is handled
> +   last.
> +

I can suggest a more concise note, since I don't think we care about the 
actual order of append and prepend:
```
``:remove`` is final. Any string appearing in ``:remove`` cannot be 
added back regardless of when ``:remove`` was parsed.
```
Up to you :)

Otherwise, welcome addition thanks :)
Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

I'm surprised this was not mentioned in 
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#removal-override-style-syntax 
and 
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#appending-and-prepending-override-style-syntax, 
so adding a few words there would be great too :)

Cheers,
Quentin

>   Override Style Operation Advantages
>   -----------------------------------
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13837): https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_13837&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=rAdWPF-nAT2ooJM9hyieW5jHTZRB2rlSJfhuxJeBaS29jNG06J_Qzv4xTP81zwUH&s=SzPrWDNzoIr-MjT-x6vXbW8rxAt0l0odSFygeF4NjTE&e=
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_mt_92560243_6293953&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=rAdWPF-nAT2ooJM9hyieW5jHTZRB2rlSJfhuxJeBaS29jNG06J_Qzv4xTP81zwUH&s=UaYe1Ue7jye5Pir7dZS1iHXBrTN_mWaZkOBIxibHJHA&e=
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&d=DwIFaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=rAdWPF-nAT2ooJM9hyieW5jHTZRB2rlSJfhuxJeBaS29jNG06J_Qzv4xTP81zwUH&s=qYGfFmF6YZwURBbgyGUOFrulcscOXAZUk22WrexXNA8&e=  [quentin.schulz@theobroma-systems.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

