Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54742CCA473
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 11:48:07 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.89])
 by mx.groups.io with SMTP id smtpd.web11.26982.1658749677513940104
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 04:47:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=pQ90khG7;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.89,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br6JswiRkp1RJYT7s+cP64vjy6kt/zKXEXOYshPL27673IH0V1aAydu5JL7epNO6qctk0SuPCqGxeVIWlVnrVPZuDsSDmLbt9Jcwxvhl95vEz/s2thd9sANrafcxkgM+rB3ypYJXrQoP2owCjn0E5HiNgPnFPxkz60J52zF+TYTCW98EgNhC0qHUEyBYQHU/WdNSf7PTiWLBxnC/CcdR3TXTgjNezBlkq6giWB9C5TfDbgmrqopexVRghB47V1P/r9aksycub3ljlwVeb3Tta98k9ZtfETjVV/LWPRY8oTorZo5x50UXPF+8QgW/JP6xV7TvSvrT3s9BUL+raJfvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc7XfYXQYK2UHyn8H48EbZpGYiQwoo4t9Ns85W326Es=;
 b=YBNGPGjrxAc3KtBRhdUGJOWiIXMxiuyoPPrFg2YSNxhGfGV1VtBoUN7mYnRx/X/qm/e+X3fSKBiIpbnpcvYTi0wTVPdItioyWf2iBDhSVi5KwiFxiycXrGZe+6BGySrJRDAidztalUWB5+Fba0espwPj9nyunumoJrTHvAZvlX+Cl5Y5jBatgY12NcdhVmGveQlO1OqNTuqaFfQOrmz7GNQWbYABqOMLHGuZnR7jfEjj75/2POqLvusJEj/Z29/K2R8zB6tfLJZsMjxHIvkqWRWMUAmsD1EmqxqMZLfJ7TuKWlXI3qR3RvYDyxt03d9M63IwTc6R8fvsVrzlPkIt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc7XfYXQYK2UHyn8H48EbZpGYiQwoo4t9Ns85W326Es=;
 b=pQ90khG7OOj87LTdujFOxWG/14qlTi2uV0oPbroqlHlHfCPbhaU/12D7vav0KPW3GZMl0nSyZF40fz+Pnp4XXLmkaksz01n/i8C1OS4rVhjLA/XuHkRMHCaYPuZMm8p61qEM6OwK2afuppoUBuq0jmFRQ2c7ouS0hkmNKlgJFwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 11:47:54 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::5c3:766e:66e9:8c4%9]) with mapi id 15.20.5458.023; Mon, 25 Jul 2022
 11:47:53 +0000
Message-ID: <0897938e-df44-2c3d-95ce-ca7474b1c810@theobroma-systems.com>
Date: Mon, 25 Jul 2022 13:47:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-user-manual: Document override
 :append, :prepend, :remove order
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss+yocto@0leil.net>,
 Martin Jansa <martin.jansa@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220725105715.89474-1-marex@denx.de>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220725105715.89474-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::15) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e97dd4-d3c1-4feb-240b-08da6e33826f
X-MS-TrafficTypeDiagnostic: PAXPR04MB8269:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E/j510GPof5tqHEdUMtDDhAsA4/WdRijkkYY3BObCV82fRSxgBsEjje8RfPiWcTv0J2ENH1AUKlNxe4vhnVvPeSXLvfpG6FuHEYNYG6qIl+syfkc0tMsf5bvgBYdOT9hu8OJTeczNbEklrbIr4dkpdGrC3ZJIIv5xAF2RrlH+cMBk6oFOtTKeV/FfvQZDmopQjy84hZnTtsC0Drr8a0IFq6cRNwwvRnS7vYQg82pMcC4nIfd/XfSCGR8Ps3DzqbvoqNn6TUDQ+qVsPpuyshmpGLn0SaEQpW1Z/Wqo2imB7wczEhXAxhIpzBWVftTI7YJ32cwBXVqVjpWSnMcs6WbZ/Yp9Njj3D+n0kfhl4Sr1nLgkkXUMQggSbMCDszuPkQkE/1L1keBbNPisE7Rj0uxfTXil4UMhlFOMcoA85k14Jlkfc4s5Wrdkfn0wQcXLNekbWZ95IF8aKke4T7oKKkKzcJ8zeQ739JvgAj4F1fAMfSWi6eiIYnGMPjbah6SNSdb4PMb7IesY4BOeCRKBy0qrGs0rFcFbbZzoTyVOahcPd/dykR/oGfxN9S/xYw++SiXEDqTyvdzVFp9gCX865X9AFrjxAfWl9p+5f2ki9oFj36N4U4f1RAp24CdjhIpuk4AbCUI4F+AS0kuuZRNLaCZtdshYyWR958sOhszrXRQk3gM9DNDsjQWgARhDC16NSSU6j//NMwHn8AHaxv12Q6GZyLmTLFmFa0sx7ylGsH027WDfuTikASCCj9yYQSvqn7Bzngjj9VMurI/QE60xfy1LdoKIYaFYB2LpAp+aaa/PDl4O+jiQM0ynRRe2uWrKH2ZZqTdeeCWwiRNv5HMs1Th+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(39850400004)(346002)(366004)(83380400001)(44832011)(8936002)(5660300002)(38100700002)(26005)(2906002)(54906003)(478600001)(6486002)(66476007)(66556008)(316002)(66946007)(8676002)(186003)(2616005)(41300700001)(6512007)(53546011)(86362001)(36756003)(6506007)(31696002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkdUT1ZMd3pxbGZZQ0VZUDFqU2pqYnY5RlhVdkJLNzRPN1BFaENnVHBtWDMx?=
 =?utf-8?B?VXFBZ3A5R25SNFgrbjVXNEtwKzJrdVp1azBscXlVVGlsa0pRS25yY2lNRm4v?=
 =?utf-8?B?ZEdoM2FXYkd4UkFEeWdndU5MTzZuUWZVYys3N2RHVndsaEpYcVlvZ3hIekJT?=
 =?utf-8?B?NlZvam5LRC9jeisrcHdYZFhwKzVyaFc5TVVaaUdhOFdWT2lsZFl6WGN4VWEr?=
 =?utf-8?B?UjNObktJdlhYeVBDcXVtU1RQK1JwM2laeFErOUQxY2wxSUVVUG9NdmV6SHNS?=
 =?utf-8?B?aFlzL0pJL3EvQ1BSZUdyMEJ1Z0p4Mkk4THN5WEN5Q04xTjA4S2RwWjdNeTMy?=
 =?utf-8?B?MWpsdFRPbVcrWnRyNDE2MzJpeVZVQTk3cnZtRzNONkpkVVBZYVVGd2VhSkt1?=
 =?utf-8?B?OHA3bE5PaUZxNEM5WVNUSnNRYTA2YXBtVE1EZW5jcFAvbkg4d3NSaDl5ZVBx?=
 =?utf-8?B?UWFXb01nMXVGTDZHVGlrTkpsRlI1NjZBWm95SFFjRWFFYWJxekxJenFkWmxF?=
 =?utf-8?B?UHJQNjFaTU5CMUluN2cxRUJDWm9icnNnTk56d2R0Nkh1d0Jsdi9HREFBQTZn?=
 =?utf-8?B?Z3NXODB6Y21xc1c5UVRjU1lnSVBDamVweWI3SU1kUUhoQVFLTU5SbktwL05C?=
 =?utf-8?B?TWd2eHBXSUlnMDN1a24xcXB1U3pmbUZ5cmdJS3ZBTkMxemJkZDBtK1NKODlO?=
 =?utf-8?B?VHQxQlVpOCtuS0lQVzFwVm5tZHljYWl4MEI3dlBOVHdLUzFsOHdpNXRSd3p1?=
 =?utf-8?B?MUFTQ1d2YVRLVlZhVVJ5UDgrQ2liMWdhZVduazVqbXdhQ1h3Tm13ZXEwKzQ0?=
 =?utf-8?B?a2h2Rnd4Uk5pQWFEd1VTZDZWV2RYbWE0aUozZmRLQTRXaXFrbFA5YVovNW0w?=
 =?utf-8?B?SDB4RHo5N0hPaTV0UWdhTVVDdC95WnY5OHlIUjNwWEM2Q3ViNG9Id01zT1d6?=
 =?utf-8?B?d1RrOFV5VllXSXJtN1NEUE5HR2oxd3dIMU5tM0RJc2lrVmIvU3J6UDUvbXhy?=
 =?utf-8?B?Z1NQaXVRUFc2M2FpWVF2SUJBbFAxcHlSRXVMbkJrSm05M0wwd2g5L2FrYTBt?=
 =?utf-8?B?WndPdTRRZ094RlpEK0d6aFBHTlZUcHdnQ3VzejFaV0pqUGVHUitmYVR0UEpE?=
 =?utf-8?B?MkRJeEZqSWVBNDRhUmlRcDBoTW1OUUkwQzM2MjdHNjQvZ2tHY3pSWHU5bDdi?=
 =?utf-8?B?aXkvU3ptMXNaT2E5N0R3UnZNU2xXRjByWUZ0UWFkdEpxUjIzc0J5WThQaFZx?=
 =?utf-8?B?a2VoaUJNRzlsbjZyNlhhYnhVbGZseVdIallKVFlVa2pSaTkwY0RPd1l2K3lF?=
 =?utf-8?B?alNEZFR0OW81dzBpbEUwU28yNE42eFRndy82WGtYZHc4cGU1Tyt5MXVZZ0E4?=
 =?utf-8?B?L2tJbG94YXRpODYrL2ZUTWVoOXAwS0Joa0xsa1czWEl3OW1WZDBUUnpwai9V?=
 =?utf-8?B?VEREMlNjbG1GWDVMbXVZR3BYOW9GOW1CcEpBc2hPU2trWnpHbnUvNGFtcmpn?=
 =?utf-8?B?akFWTkV1UUlNUndWajFrRVdpYUxaTVlnbE5BMmdST1BSd0g4ZGNxczZRRkxX?=
 =?utf-8?B?RVFWWDFIU1hyTG5GWkY0anVhZ0lNL1pSZ2s2VExRRklRMmU1UEdIb0lNZHVF?=
 =?utf-8?B?ZjJnalFTZ21kbUZSYTJZeFlFNFhBYUNkalJ1MHIxSkJSOW5FUlRqWFpvY1NZ?=
 =?utf-8?B?ckxUMU9RNGZkUVJLd0VyTnBYa0N1YlYrays3dEtFK3NJQTdickM5NE1ic0NM?=
 =?utf-8?B?bjVxZDd6SG83SzkxTS9EcHdkeW9Da0lJSlFWeEdBQXc5cU1mSmVwbFJFNENq?=
 =?utf-8?B?dElSY1JSbkhxbEZYYlh2elNVQ1F0SlUrVDJ5T0E3WTJyWDR4eHRQcmpGcUlj?=
 =?utf-8?B?ajlnYTBraVNQUHpndWxkQjh6S2svTUxEKzJMcU4vb21oVDZ3RzVTS3Npc1Zy?=
 =?utf-8?B?VDhOYVJXRE1iT3hsQlhFV0ZCVGl2dzIwcEFuMjBqVGtPaTlrNytNVUhpRnZt?=
 =?utf-8?B?R1BJVHQ5SGtmc3dranhrcm1ScmxsMmhLSHpjM1VseDFIY1luUkVlQmd1Tksv?=
 =?utf-8?B?aGdLeUFhZGozQWt3YUJYQndkV0pEcUtjUWpZelE4aXBZWTMyOFYrRXBhZDBn?=
 =?utf-8?B?UEY0SGc5TVlDRlZ4eENQK3pGL1AxcW1KWlZPd1VmckZRbTZmVy8wSmFoeXNS?=
 =?utf-8?Q?plgUF/n99CVn2JVVD1UwRNA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b5e97dd4-d3c1-4feb-240b-08da6e33826f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 11:47:53.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 CX9CiiHr1uDzwqSXL+gLvS66kkTu/d/NkphkOK75dWJNi7MKBRWvNSfKu0KNC5SHE6tt3Aq+T86ZzcA1Kifbs+4V97I5UZqlOrlu6zdbLVnaQ5mBvbMi/WMdyKaJeon7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 11:48:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13843

Hi Marek,

On 7/25/22 12:57, Marek Vasut wrote:
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
> Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Martin Jansa <martin.jansa@gmail.com>
> Cc: Quentin Schulz <foss+yocto@0leil.net>
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> V2: - Add RB from Quentin
>      - Mention un-remove implementation
>      - Reference :remove order in append/prepend override syntax
> ---
>   .../bitbake-user-manual-metadata.rst          | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 33782161..4da18826 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -319,6 +319,10 @@ The variable ``D`` becomes "dvaladditional data".
>   
>      You must control all spacing when you use the override syntax.
>   
> +.. note::
> +
> +   The overrides are applied in this order, ":append", ":prepend", ":remove".
> +
>   It is also possible to append and prepend to shell functions and
>   BitBake-style Python functions. See the ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:shell functions`" and ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:bitbake-style python functions`"
>   sections for examples.
> @@ -351,6 +355,27 @@ The variable ``FOO`` becomes
>   Like ":append" and ":prepend", ":remove" is applied at variable
>   expansion time.
>   
> +.. note::
> +
> +   The overrides are applied in this order, ":append", ":prepend", ":remove".
> +   This implies it is not possible to re-append previously removed strings.
> +   While it is not possible to re-append strings, it is possible to remove
> +   strings from separate variable which contains the string remove list to
> +   achieve the same effect using un-remove::
> +

I can suggest:
"""
However, one can undo a ":remove" by using an intermediate variable 
whose content is passed to the ":remove" so that modifying the 
intermediate variable equals to keeping the string in::
"""

I specifically want to avoid "un-remove". Not sure my suggestion is 
easier to understand as I'm usually pretty good at unwillingly writing 
convoluted sentences.

> +     FOOREMOVE = "123 456 789"
> +     FOO:remove = "${FOOREMOVE}"
> +     FOOREMOVE:remove = "456"
> + > +   This expands to ``FOO:remove = "123 789"``.
> +

Did you test this? I think there's an additional white space (because 
only 456 gets removed but the spaces around it stay).

Cheers,
Quentin

