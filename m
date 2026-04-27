Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D740FF8862
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 12:35:53 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43836.1777293351347880619
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2026 05:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=CLS9FAM2;
 spf=pass (domain: cherry.de, ip: 52.101.70.13, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8VbNnObcb0JXg4f5lOyQpmiV3yfWeJe2fkyJdEmMl57M+BTj13OsVzcoS2UBaw83tyXk/9qH2ARn0HdfyTjVZp8G3DuCXhixLvK4uLpT9+CwxK2yQbSqIHgSsePGamQI9RYkbiLsb8p9WcPAP9k6UBvMHQqfLaB26QUPRGGqdEDJ836BmUV3qhWxXs5Bl9XnASnGCncijN7Njnmfg1brvB0XkxhlGN2KCB+WP2ewXxOODBMza/9Zhf7+dMen0z3dsjC5dUCSqmBZ9g/wA/PkGGnBxkBiL1KHekFqHmkX2hzsJ5ebYb/tWUKnWhTe00Rn8Mtvj8UQQCcG79Wl3kgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGnj4NFYJ2sO+ICwFgEemfbuf9Ue0/SJytzVkKMy0YM=;
 b=VYxy890AYjjDx1sPk71LUm2xeZ2JqhbwERSBl/+ZJNCEJ295YOsw0qo3+kwOeI11eWtA6bxPypUtON/h2sBm/yRPCiqX01GJLW3CE0/Kb2sfE4jRbOaSiCvpnf/Qm1AEfwyxkAw5/ZZ+dKuNwxdTdrYqZ9ZR0dYrQK+LXb3tFSoiUMkngg86q2z1Ggbt5+gI8vlqrzq25Rm6Qu2RxMqUAP+rhc7ETLskJRFvFtJmQyel6TBlCw1gnAES0g+VY15nFRjXqRoz8+9q8L0i0LtPJimWkfpeqVGaWIosPIUPI8NFgUEJ4Bqp5WWeFxEaPyl7nAIUloaa4EBkAIJxStVM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGnj4NFYJ2sO+ICwFgEemfbuf9Ue0/SJytzVkKMy0YM=;
 b=CLS9FAM2P18LrWHyprop0z6mnZ7z9gIfup7G2JEQix2A9DJ4WD24mnp7ntLuqdzhXrVJ3b9Qa5xYr2F8gXvgJdYSVQJAaw7u64aKSd0kl7+ZQT6qWTELtwINq12EdXhCQOZWS0Uv530EFoSek220eZ9xt7NUjh+xCffw+M2wD/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU2PR04MB9081.eurprd04.prod.outlook.com (2603:10a6:10:2f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:35:46 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 12:35:46 +0000
Message-ID: <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
Date: Mon, 27 Apr 2026 14:35:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH 1/1] doc: bitbake-user-manual-metadata: fix
 inherit_defer documentation
To: bijak.dawid@gmail.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20260424062327.820993-1-bijak.dawid@gmail.com>
 <20260424062327.820993-2-bijak.dawid@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260424062327.820993-2-bijak.dawid@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU2PR04MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d425a8-0f30-4183-2429-08dea45981a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Is46bh07FKbyM8x/aY/bbjPLMfi0oo4zvmJFm1IPTdFyXjOxn2hlUvqXMALlK9yb6MvTXAZ6YJkYfSO/Nwc1Siyb+s3YCRukfhoRKcVLZ1TdbBEj4jU+AmPYnFi1RWYP4zrpHXVh/wnP8MFVr7514vE4C96040HmdDZuHEAqsHA734tGYyQg7Euxs0aET09VEQp5SKqIC2vBqhLOyeKtcyyRMq2NYD2K10CbFeOrXnVFDIMJEO4eBracTWk4baF5clGjofN9HiB/I5VExonDbZwhqcx2nXJKn6UpEUtDhD5rgFaKINktSrfuKWAAXAZs36yNdYxSDHKyxjvArMc5htjZC7kTZzpYl6p865NiHGprQ++oEz9Sqpn+g1bEemYMeookRbfSuaZafvIfYkate2YptKKJP762yOcMElaExg5TIyHyvgYsq3+gzcu56VOVhiRlB6Ry0usSzqQD6+JH5EDioySpKay2hHJeVeR3ejSZurilvqU+9FGhLrs0UZLDFrar56Pu2E3oBOfeKH2vLAgsfqBOgqlmv2LGkZF8sSIr+8GvRe6+ltbQDXDmhEIduVSCygHoKh3DkhOAyb5HF+zoTPLAicMbsB4N+FsgIsHBgT5f+aUSjTneFz3uW+CpHm7eCUaxqdBnF+G5yaZu9ovuC14vFJqtVUuN/oaNj2DwCKtK6T+p6ge1iVpO3cqsevlUK01dPj1+1xbDPk0AZ+QrH/4MMsRLR0/1vv7MRRY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2NaT01tQzNXbmU4T004eTRBdVh4MFVaK3IzRlZEeGxxV1VrV2VNdHlucDdj?=
 =?utf-8?B?RUo3Q0l5K0NtbXByREE4czZlWmdCZXo0QTROUlB3RjNFbEFwZWd6QUQ0VkNL?=
 =?utf-8?B?L2ZhbnFUbmhFWTNINUZXc29Id1dGaDlGYTM1ZTVSZXJHcTk3aXBHVGxycWlS?=
 =?utf-8?B?UWZFOU5rMlFqQ0VHRk96SWFUVldRNUpLQ0xjV1J6QTY0andPb1NSTE5uc080?=
 =?utf-8?B?TVZ2dUFRcXB0d3FuSlhNTU1yblBoRXBSSXBFb3hIMmpnVmRvbTZnQjFRUERK?=
 =?utf-8?B?UXRZWXBzWHdvN3NXZnVIbDdpamhtc21FOGFCdDhXc0RYbU5MK1Jxcm5RalIv?=
 =?utf-8?B?MzQ4Q0tnVzVtZUxsUUptUEZoc1BrWDVGaWRwT3Q4dXV1aWt0SlE4T2IydmV0?=
 =?utf-8?B?dy9rdStLOVl6ckV6SzQvUXRwZjNSZTZ5UGoyTnhhZXJlcyswSnhwSENtTU5k?=
 =?utf-8?B?OWtnTVFIL29HMXQ5bHpPUW5rSEpKOUVDUUJvNlI1VEpvMmVzZXNVWTYrS1pB?=
 =?utf-8?B?RHhqdDlDTlEyWVM4MW5OOSttbDYyb0xmanY1aXNjeVJHNElsNDhxOWF4OXZG?=
 =?utf-8?B?YkFmcWwwV2pLTkRGTG5nZllWZ2Y0ZklFUjFza1JtbzB4MTgrdDlpVEgrcEFl?=
 =?utf-8?B?LzFSVmV2OWFiYmdKVDRMVTFyVTNtZWRZQlI1TCtKcTR1aTZPM2oxTjJYZEFa?=
 =?utf-8?B?SS9VS3hXU0FJb04yMWdDaHROWTVjWlZEZWhYK2RHd0U5Y2VqazZjS0Z4c3Ra?=
 =?utf-8?B?SnpMQ1RrRzM1WFJvbkxWOE1PcS9ES3duRVl3eDYxTW9xMVNqVitmRFhEeXJG?=
 =?utf-8?B?Z2lzZC8xLzMxM2lzTkFXeE1IWDY0MElWSlliVWhiUmF5R2c0ei82Rjhnbks0?=
 =?utf-8?B?Z2FFRlcxaXVJQlNPRksrT01IREZMQ1k5Wk41RXBBdzhpWWJub3BkUWRnZnJ4?=
 =?utf-8?B?a05KdFFPNlRodzNwa2t1RjBGWTZ4YlR1K3ZINTMwMHNXdnYyeE5tcS9Db3h3?=
 =?utf-8?B?ekdveEIxcG1WNDBYaERnUGhuWnJmZlV0K3BDMzJJN3Z4NGt5Nnp5eXI1K2Rn?=
 =?utf-8?B?RTdTNHZmZDJRbzBvWTNkakRsVGxLdlh6YnZrSDl6QVlibXdWSU9kcllCNXhv?=
 =?utf-8?B?TVRKZWNJejdXUGNPbC9qZENwVG1Hc2d3aWR2RDVValdJZ29qQ3NGQWN4aVF1?=
 =?utf-8?B?NzJWTzVCQi9MS2tGSTFKMFJqQUhHQVZWNFJ1VGlBNThvdlQ0SjVEU1pmZ3c4?=
 =?utf-8?B?ejE3MXJSemFEL3B5d2tWeW51RmoveWluT1doTERxVmEzYVBuamV3NkpNcXJF?=
 =?utf-8?B?VGxUS09jejVoTzQxSEZ1RnNnS2RocVRXWXowMXZlbUY0L2h6TE83b29mNlha?=
 =?utf-8?B?MjNhTXo2MWFUcS9oUjY3aGdzY2NkbVF0d2hXV0hGd2VjdVBMZUFxS0RGZFhj?=
 =?utf-8?B?dWVPOHZRZDBvdS9hb0hzbHlLZkVoNjE4S2JBbFRaanFOUE9MaUtBSzhTOVNy?=
 =?utf-8?B?VTVqM0JUdUd3VWFVOXR3NVpBYnN0V3pFZVU4WWY0a0xIdllFbEVSN29kR0l5?=
 =?utf-8?B?NDVRSVdUQU1VMnYrb3ExK04vY2wyOStLVU1YSXNhQzc3dmM5RUVGajNXWitF?=
 =?utf-8?B?cHBoMngwbXRkSFk1bVFLWW03R1J3OXZER1pVeUEvUGZkUTl5LzhuNUIrVU9m?=
 =?utf-8?B?Umdza1JoV3pvVG1xVlNsYXpHdlhRS3c1UVFxMSt3UlBWSmgvV3FhK3MrSzVR?=
 =?utf-8?B?RTAxUG1rUTJGclY5NlE2b01jUnFya1BSdm42VithMklyZEpvQmQ2RDY1Y0tQ?=
 =?utf-8?B?Tjg1b0hXQUtXcVJqNHE2WGxmRnhrQjVXYTI3blgvUkhaZGVjSjNVNmRoZkRT?=
 =?utf-8?B?Zjc0a2tTVUdRYlNwczdZazAyR3JKbTBKUHhXS1paVk91cHZGbjF4OVVYaVYv?=
 =?utf-8?B?ZGUzK0FmMlRsbXY5NDZtRFJQaTNjRTlIZWx3ZDl5dnhsM3BXK1dJSlRsVFhL?=
 =?utf-8?B?TE5JKzJRZ2ZhWEVJbHZwMExMRXlBTlZCUVRjanNWaTlBWDJhVUM0UHVPU2h2?=
 =?utf-8?B?OHlLTEg5Y05pWGJoaUZhRTl2V01FRHhhMkNRK3dMUExiRW5yNEk1VGJGdVBI?=
 =?utf-8?B?WWhmMnV1K3ZWV2pwTXdUUk5jNnpyLys2TUpCM20vVStCcVFGV2tVSzJpWFFp?=
 =?utf-8?B?eksrdWtSTmNKTlB1K2NvWTR5aVc0TmkzTjY5Zlh5U2JhWDdyZkQzQndjdFQr?=
 =?utf-8?B?V2hhNzZmN2t6OTZDM2FtUUdSYUlHSnE3T3lxVzNQZDdvdlYvczRuWG8yajNB?=
 =?utf-8?B?dGhCbmNPUWs2UkZWSkJOeXFzc0c4dHo0eG5pSlNFOTNmWVMzbi9VdTA1cVRB?=
 =?utf-8?Q?sO3jag9Ic5YRMpeawqAOIx5DkDId2Hl6KOf3o?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d425a8-0f30-4183-2429-08dea45981a6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:35:46.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIGicVYqRs2YfIDUQLnN94JxhGd6bZMDDhp/L23zO/8ak5Sqp5IYOo/zUKfUfnzYkce1BMh6DaswMyHzu+yG6C0vTzuCObRNWmTict5G19A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9081
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 12:35:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19393

Hi Dawid,

On 4/24/26 8:23 AM, Dawid Bijak via lists.yoctoproject.org wrote:
> [You don't often get email from bijak.dawid=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The documentation for inherit_defer contained the claim
> 
> "If VARNAME is going to be set, it needs to be set before the
> inherit_defer statement is parsed"
> 
> which is incorrect and contradicts the purpose of inherit_defer.
> The wrong claim is replaced with an example which demonstrates
> the contrast between a plain defer statement and the inherit_defer
> statement by using an override assignment placed after inherit_defer
> 
> Additionally the inline python expression examples have been
> moved from the inherit_defer section up to the inherit section, since
> they apply to both directives
> 

I'm pretty sure the whole inherit_defer thing started because an inline 
Python expression didn't work. I vaguely remember a bbappend either 
adding this new inherit based on PACKAGECONFIG containing a value, or 
having the main recipe with this inherit <PACKAGECONFIG.contains> and a 
bbappend modify PACKAGECONFIG. See commit 5c2e840eafeb ("ast/BBHandler: 
Add inherit_defer support") in BitBake.

So I'm very skeptical this is correct.

> Also add an anti-example showing that the previously documented
> pattern of setting the inherited class name from an anonymous
> Python function does not work with inherit_defer.
> 
> Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
> ---
>   .../bitbake-user-manual-metadata.rst          | 61 ++++++++++---------
>   1 file changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 40cae6b05..38efe6b11 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -803,7 +803,17 @@ An advantage with the inherit directive as compared to both the
>   :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>` and :ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
>   directives is that you can inherit class files conditionally. You can
>   accomplish this by using a variable expression after the ``inherit``
> -statement.
> +statement, as in::
> +
> +   inherit ${@'classname' if condition else ''}
> +
> +Or::
> +
> +   inherit ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}
> +
> +In both cases, if the expression evaluates to an
> +empty string, the statement does not trigger a syntax error because it
> +becomes a no-op.
> 
>   For inheriting classes conditionally, using the :ref:`inherit_defer
>   <ref-bitbake-user-manual-metadata-inherit-defer>` directive is advised as
> @@ -827,39 +837,32 @@ the variable after the line is parsed will take effect. With the :ref:`inherit
> 
>   Here is an example::
> 
> -   inherit_defer ${VARNAME}
> -
> -If ``VARNAME`` is
> -going to be set, it needs to be set before the ``inherit_defer`` statement is
> -parsed. One way to achieve a conditional inherit in this case is to use
> -overrides::
> -
>      VARIABLE = ""
> -   VARIABLE:someoverride = "myclass"
> -
> -Another method is by using :ref:`anonymous Python
> -<bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`.
> -Here is an example::
> +   inherit_defer ${VARIABLE}
> +   VARIABLE:someoverride = "someclass"
> +
> +:ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
> +defers the evaluation of ``${VARIABLE}`` until the end of
> +parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARIABLE}``
> +expands to ``someclass``, which is then inherited. Contrast this with a plain
> +:ref:`inherit <ref-bitbake-user-manual-metadata-inherit>`, which would evaluate
> +``${VARIABLE}`` immediately, before the ``VARIABLE:someoverride`` assignment
> +is parsed. ``${VARIABLE}`` would expand to an empty string and the statement
> +would become a no-op.
> +
> +Note that assigning the variable from an
> +:ref:`anonymous Python function <bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`
> +does *not* work, because deferred inherits are resolved before anonymous
> +Python functions run::
> 

I vaguely remember reading on IRC we're having some issues with 
anonymous Python functions and parsing lately, so that may be related to 
that. I haven't followed anything in that area so maybe I'm wrong or it 
has already been fixed. So I'm not sure if you just happen to try this 
when things were broken in BitBake or if it's really intended to work 
that way.

Cheers,
Quentin

