Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34DE77181
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 14:36:02 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.71])
 by mx.groups.io with SMTP id smtpd.web11.102879.1733754960580574942
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 06:36:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=kYpc9Wgk;
 spf=pass (domain: cherry.de, ip: 40.107.20.71, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C05l7qNl0EnFeViq4bD7EvefPqeoJ2PzBi0wN2EL+MyusUPA2IX/dMmWTBOJyRr5AqcTSHnwl7NWMgBD+l42rj7Cb0XhgaTEGlwzJgO6ZG8Y4LVOXMBHqm6sBdtiWydAu2EeniBKAZ7j6/Kf6jih5PuUvcjrDFvSK8omxFB9qRoSXbqWuctnKENiAaZXPwhyje6tGkI4z9Bm0ZYI68ptXBEi9MKUgNosibborPB/mfczwUhGgy9X378lDW0qSr7z4ZNsf2fjhKXN2OfQ22Md4FTs5XXHvNHQcPHVSDx9kPxCO3sR0IctRXEQgpTHSgtjBKuna0MptFb6eecy4YmCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJR/pABbdts6HNdrT3+rKFK218gw2ebzqp5dTGOxB64=;
 b=NnOgXV0xk+PeoAasfQCPeYvJrVfH3jupvzU+XgDESBMAP5IdiGupKyFHBS1RuGthJ7uN/u0RVQuV24VaLEc8AYxTsnrNzc33Bp/vAMGICaoVqH3L781mjwrV/HMMmNehuXvcwoHRnXb9qRVGQTjj4HXi7+iAfkZ6Y7lwj641XHZKu/54drfG3muiCMqqklWcEdf7zLFW1awS1Tlnd3Zm8G8B9Ca5kFLp7/3N9ktHYaAVVtSoS+7DIQk6tS3cQQRyb7zJF33A2BYYe9ZN40i6WY3y0jCnYQHYu5ZGg/QtmaIacruWdHG34j5DcDTlV6YmsH0l+6sVznTPoM1/iJJQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJR/pABbdts6HNdrT3+rKFK218gw2ebzqp5dTGOxB64=;
 b=kYpc9WgkeJ2TB4I2wTvwRLTnBQHPgWtyVBFDU0ZDAKlYkVg7k2GDXY6wjm8SOrcp50FAGq67cwziNPSopMimoGc3hPk6uUinkWkMrJY81rdY0Lh2m6NPm1rNNG+JcxtjMEUnnxzHxGSWuzwhltgXj7jGqKj1PTMlzAb+bnOH8KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10395.eurprd04.prod.outlook.com (2603:10a6:150:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 14:35:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 14:35:54 +0000
Message-ID: <e0d3f4c1-f252-44f4-9e45-dbfa13b41996@cherry.de>
Date: Mon, 9 Dec 2024 15:35:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual-metadata: add a
 section about 'addfragments`
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
References: <20241209133053.2494088-1-alex.kanavin@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241209133053.2494088-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10395:EE_
X-MS-Office365-Filtering-Correlation-Id: 517cc78b-cad4-4e89-a7a4-08dd185ec7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGlvemhNb1U4MEdMZXkzam54WkZIMy9oT21RcUI1S044STNJTzF4VVE5bWZt?=
 =?utf-8?B?UUF4dWNTRU00ZWpCeEIwR1FlNDVnUEZ6a3k5QU1SN1BuN0w2T3Vxc29oSGxE?=
 =?utf-8?B?Nk1iMm9vT0ZiTStBVGFtc3l6d0VETFVvK0JpNlFjZDVSWWRrc0JnaEZETlRJ?=
 =?utf-8?B?ekIxL2kvaGJTNWtwSXRFWC9ZTzN4WXNubm9MTGZsWGRzbitwUm5ubDd2dnp3?=
 =?utf-8?B?QTdKaU4wNGwzMmNOT1BFYm0yWnRqQmJtWUlUcHQ4eDNkZ0NrVG50RTVzbFVC?=
 =?utf-8?B?SVV6N0JlVElPT3lXdE5rL3VESno4TUsrdGRWS3Zpb2ZFVzVmZWd5dTJYNll1?=
 =?utf-8?B?UDBXMlRMV28xaWNjNGtlL1lSSXBPcWJOY1pZMm14aFZvTURyK3B6Zm5RK0p3?=
 =?utf-8?B?SjFjQ2pOMFpxRUc5b2EydlNOcDc4RG9velJkWnQ2cXoxWncrNTFuL0NrU1Vh?=
 =?utf-8?B?ZVZaYVVwdmM4WCtaZjArVE01Nm9ra3F6UXJza1dtcjRjYko0MFZrZTN4MW1p?=
 =?utf-8?B?NGtzRHR1MVlFdjFkbDBTQmc0cEhrOTVuaWNsUFdyNGhscUxscHVoNVdrYlJs?=
 =?utf-8?B?REFuejVMTW9XMitlczM4ek1UZ2RFajdXY1c0RTIyMVhwZnBWK1FaNXJZTUJl?=
 =?utf-8?B?U0xUUWpTRUY1RVhyeUxEaGZCeld3bkRvc2dZbG1zWHNOS1ViUFlFbU5KbWFJ?=
 =?utf-8?B?ejBQZnhxSUVKWWJPZ0p2Z3pNSS9VSm00STBkU241dTNraEM4V1hlYmNwRGlH?=
 =?utf-8?B?TmJkdmFqa1Vpd0svQ2hMSTh0OTlxVnpUM0syOWhVU0psRnpBM0hrNkh2STU1?=
 =?utf-8?B?MTlyYkxuSWRkVVg2RHpiczltNEFYYjhkV24rT1Z3RVIvTnlGcklNeGNrYVpU?=
 =?utf-8?B?UUFlVFdCTFdlazBXcDlLQ1hVamFzTURzYlRGWHMwTVAyL2JFVEgzeEpLcUNP?=
 =?utf-8?B?NVpndG1tMy8rdmVDVGZBL0dSd0hGOWNsUWRGU25BOHV2eTdSc2VUS0NXS2tM?=
 =?utf-8?B?ZXVVMkpYOFlVUUl1YldpZmxBMzk1M29TV1lyZkhUQnlvdG44d2JkUDM4NnZq?=
 =?utf-8?B?TytZMjN6NE9LWkVIUFAzdDkvcDZoQWdjMVlwVHVPa0hIUWgxbCtnWjZ4SW5z?=
 =?utf-8?B?R3VOU2ZqZGk0ZTVqcklIN1Z6WkMzQndDelFCWi9ST0lMWk1ISWFKa2pONzR4?=
 =?utf-8?B?YVBxT3UyYmRDSzd0TnVlUW1iTzRqMERuRmRRN3VTSXA0R0hxak1NWjEzRGl3?=
 =?utf-8?B?cUR0dG1hNWc0eWNvbWE2K0Rkc1R1N01qRTZyekRSRGZaWVk4MFVWTytCRzd4?=
 =?utf-8?B?dlk5aXBQb3RneXQwdmlZdGhnc252ZnZTb0R1cXkyeXpBdU1ZVmxUcUtyd0o1?=
 =?utf-8?B?TWpHL21KMGlOcFJEYjBndjE4QWxpSmpwRXh5aGtvdi9DVmZpbVNKb3BHMkFP?=
 =?utf-8?B?MTdyWFZZTmt2WXFva21tVVA5eTlGY0RYODhSQksrZjdoTFdoZkJTWGtQTW5i?=
 =?utf-8?B?ZE9KOEw0QTFUQ296dnZvaGJqY1BGSThvZUhaLzIwMXlDTnIrc0FvV0NUZkY2?=
 =?utf-8?B?SWsvaHc5OXJHd3F3NUNVeUxkT0lIdXpWR0doaGFHODlic2wrMzBQNDBpa0tv?=
 =?utf-8?B?Nk5UMmwwUXhud2tqMitQM0tQbnd3UTlWbERJckhFNkJndWNSWFd1OGw5aHlV?=
 =?utf-8?B?V1dyeDhGaUF1RXViUWVraW5Na05uSlNiL3VLb1ZseUpRNW94ZHRON0kyM1Z3?=
 =?utf-8?B?TzZYSjd4cnJOc1FScXBXalA4NzZXZGI3MXNYaXR0Yk9CUENJYnV2dHpWN1Z5?=
 =?utf-8?B?VWZ1R1JTUnRQVFJmVEpXUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkExMU5UdC9YUDZNOTF0bVh4aHIrV0MxSElnZGswUjYrUDROaC9HSGdBd0ZV?=
 =?utf-8?B?Qnpyd0llWEhRNHZKVDMzN2dPL2FNMGtzUWpGS2hQYmdvU3BjdllZbWx4aUtF?=
 =?utf-8?B?SmZYb0x3RG9PZTZKNXFNbnVnWjY0VklTdldUWS9jSE11MjBSNUd4Ukk5TlpP?=
 =?utf-8?B?dnpqSXNtSis0ZVhPZGxOdko4UTZxQlJQb0lCRzUzbWlPeGNJZDRMd2ppeEhw?=
 =?utf-8?B?YUJER2ZLb09tcG1VeDIvL1Zjc040RmpWSWltOEFZUEkwU0g1OUhNczAydkVI?=
 =?utf-8?B?U3EwdURwV2Nlam41c0FjTzdTdUJsa1U0Ti8rM0R0VEZReGVLdmRISkpVMGxh?=
 =?utf-8?B?Y2pObi9jUm1BU0ZoRmlEODdZcGxvM25aaEdJU0xYRnZTRWg1RHh4TklIaEtR?=
 =?utf-8?B?cVVyV29CT3Z2K1R1OE1ZdlpNbU1VZ0FLOEdPL1d1KzFzQldYRThnZGVnbVc1?=
 =?utf-8?B?TDJCV3I5aDk0Y2tKdXBJMjAyZFJoOCtaWWxTU2xrcW1GaVhjWXhQd2hXcXBv?=
 =?utf-8?B?YXRVK0tvNFJsT25lcVJEVGQvNEI1TDBLaWl6U1R5d1BCR08rY2t4WERIQkN6?=
 =?utf-8?B?NzBjamxNeE9CMjNwOUpMRUx5bGUwL0VqTmF3QzZkR0p1U0loemtVb2pTQkp0?=
 =?utf-8?B?NnE2UnhncFBETVI0eFUxVlRTcVBVZjJ2RTZxaU5aNjRaWlYzL2pUK2Fnb094?=
 =?utf-8?B?blYvbXBGdzVmTTc4Wk5JU0ZWcU02SVd1ZlBuMmsrd2dZeExFZTFKNHVYeDhE?=
 =?utf-8?B?ZkVaTU4wRzdEVDUzNkYwTkx6R0ZMOCtwdVRObkg5WmRzR0QvRTdtTm10QjFF?=
 =?utf-8?B?UzJiTlUvam5mYm85SzFIb0lmdXFVU0ZXV2ZheWNGSVo3aGhjcEV4dW9zUnFo?=
 =?utf-8?B?V0FwWXZmNVlEcXJJVmN5Mktnb1VHejRNWDdhKzN6NWs5NTRwcTJGRjZhSlJQ?=
 =?utf-8?B?ZElES2Vwa2xwM21NUkZHem9Gc3pJM2JnZHFWd0tPbzRvdnVuby9qQ3ZYU08w?=
 =?utf-8?B?RmprMyt2dWxkU1pmV3ovb2dMOUxrckFmdjJKNGNXQWVwdTlWQVRlZUI4Ty9r?=
 =?utf-8?B?UXQzdXhxV2hpdFB6OGVpMi8xc1J3blZ4VlBnS0d6UGxwcEptdkVkMUZrN3hQ?=
 =?utf-8?B?L21RSG12NmUvVm1WVWswTFBCUlAxRExkWW8xdSswQkVtYVBYNGVleFBOc21Y?=
 =?utf-8?B?WW51RlMxQnlGZmRQdklJeUpPZXZnOFI3MHRDbFMzQVpGSFRSNGFXYURwNjJj?=
 =?utf-8?B?aTFVMzJCNGJxV1gzWVA5Y3c4ZkNPMnhUeHZiT0cwUk5yUEpnOE1iclpJRWs1?=
 =?utf-8?B?QVpSQjNYb2Zwek9oRmFyVU44N1NvREZ4Y3hXNCtlSkkvak4xd09ya0lZRnBR?=
 =?utf-8?B?K2pFUDBMQTFrcFF4cEdtNTRZdmdHSHA5c05xa1lXbmxTWjlMQWIwdjZWODho?=
 =?utf-8?B?SkZ1bWNzcHNMTUZhNTN0SlNlTWRmbXRsejd4NjJiQ0tBUTJmWXFwRW94d1JB?=
 =?utf-8?B?UXVTUTVRclN2UCtGRS9MS3FGWTZUUDVuU1hsRmpnK2ZNSGphUnNSMkhUVzFZ?=
 =?utf-8?B?MHNCTURhNVZraFhsK2YxWEE2LzdiL08rNm82enVBNVVkd3FESHJBZCtNUnha?=
 =?utf-8?B?WlhyVXRLOG4vTlRBeFFYODQxalZLVndIZERjMjIzZ2U0WDFpOXBySE1ISEVn?=
 =?utf-8?B?WDRLTUlMQTdnWEMySDFhRzNJV3FuTFBWcHlmQWpkTjdySVpBOE9yd1JJdlQ3?=
 =?utf-8?B?QUlxRUZ5UlQ4dFozcTFVWnNsdmRKRG52cGdhZm1IK1lUZXJwQzF4RFhvc0Fm?=
 =?utf-8?B?Nk9BRFhlODg1K1FxMitETlI5Q0JUV2hNNlYyNXJCbncvcURCcVlMQWxOVkY2?=
 =?utf-8?B?VHNZT092c3dlKzZkeUZJb2daYjlGYkducWJpRkhVZzgyZ2hSWUVxdXA2M01q?=
 =?utf-8?B?YUs1THVXMDRKMUIyenp3NXg5N0psVXE4akQ0bmphMlpMMmVOSXJRZ3ZMOWpo?=
 =?utf-8?B?QmFBS29sUXlwaHoxRXdEc1hUWUpabWx0TmFPcWw0RVdDYTE1TTArNGlrSUZt?=
 =?utf-8?B?eUx1eVdKNTI5QmxQcXE4eTk4TzR1QW5DeEdtRjkvaVVWQWJHY2lZaDI4eG9r?=
 =?utf-8?B?eFRZbHNCVXpVMDc2bVlRMlNpMlU0YUs0dVQydFFma05zZ1VzcU00b3kvT0U5?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 517cc78b-cad4-4e89-a7a4-08dd185ec7b7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 14:35:54.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEi1DhU7YPn4C12TBtErEuGH9gNca8uJOcZZMSyZReXGYa6vGUTubIPyxRky34X+/RLvgYNqn64PvGPHPytJZ5gWvsD9whjmD1WMx5i8y8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10395
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 14:36:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16898

Hi Alex,

On 12/9/24 2:30 PM, Alexander Kanavin via lists.openembedded.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
> 
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>   .../bitbake-user-manual-metadata.rst          | 35 ++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake-user-manual/bitbake-user-manual-metadata.rst b/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 40a0c6f02d9..16e4946b282 100644
> --- a/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -754,7 +754,9 @@ share the task.
>   This section presents the mechanisms BitBake provides to allow you to
>   share functionality between recipes. Specifically, the mechanisms
>   include ``include``, ``inherit``, :term:`INHERIT`, and ``require``
> -directives.
> +directives. There is also a higher-level abstraction called
> +``configuration fragments`` that is enabled with ``addfragments``
> +directive.
>   

It'd be nice if we used links here too for the directives, but since 
it's not the only one with the issue, not a blocker.

>   Locating Include and Class Files
>   --------------------------------
> @@ -962,6 +964,37 @@ the ``autotools`` and ``pkgconfig`` classes::
>   
>      INHERIT += "autotools pkgconfig"
>   
> +``addfragments`` Directive
> +--------------------------
> +
> +This directive allows fine-tuning local configurations with configuration
> +snippets contained in layers in a structured, controlled way. Typically it would
> +go into ``bitbake.conf``, for example:

Missing second colon to make the below line a code-block.

> +
> +   addfragments conf/fragments OE_FRAGMENTS
> +
> +``addfragments`` takes two parameters:
> +
> +-  path prefix for fragment files inside the layer file tree
> +

I assume you can addfragments a fragment from another layer? So that 
would mean this is a path relative to any layer's LAYER_DIR dir?

> +-  name of variable that holds the list of enabled fragments
> +

+space-separated list

> +This allows listing enabled configuration fragments in ``OE_FRAGMENTS``
> +variable like this:
> +
> +   OE_FRAGMENTS = "core/domain/somefragment core/someotherfragment anotherlayer/anotherdomain/anotherfragment"
> +
> +Fragment names must be prefixed by the layer name where a fragment file is located,
> +defined by :term:`BBFILE_COLLECTIONS` in ``layer.conf``.
> +
> +The implementation then expands this list into
> +:ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
> +directives with full paths to respective layers:
> +

Missing second colon to make the below lines a code-block.

> +   require /path/to/core-layer/conf/fragments/domain/somefragment.conf
> +   require /path/to/core-layer/conf/fragments/someotherfragment.conf
> +   require /path/to/another-layer/conf/fragments/anotherdomain/anotherfragment.conf
> +

Can you tell us about a typical case this would be useful? I assume 
there's a reason this was implemented :)

Cheers,
Quentin

