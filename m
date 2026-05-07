Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D0CD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:06:02 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12884.1778162753430476384
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 07:05:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=IVhLSnqD;
 spf=pass (domain: cherry.de, ip: 40.107.130.45, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSnKmLwGBdAO0hYkims51zLCjJSltMEDmiXLgFIeAZelnSe3quDfEjGNMw0BhssqB/bIKHyDemII3rwc9MdrXE1sJJbFNU32x3da4RCWnujgzHITXskgzOyhuJua1JLZoWM16e76pR2EF52bsMa3lI8b9bJ3Tbja4nV+moK4iH/jslLwbYBHk4UezCaZp4FQvSYPJ87e1OvGBO2uulS+K5iRdQRxGJaVphM0XhO2O9/0hswBGAg0fiphxvotqZnkkkSz+B07JTDu7EPbBeIPHAM3+e1k+LvVi/t7bfMdt0UokHxv+403Zon6jkMd/CaRGw/xW+S6JJAdMGFeUHyuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0SnH7/K3Dt0HXFj1NsXVNgePVRJxV2ib45PhUgDpBg=;
 b=sAuAQ8WBiYf1po8jm4bW7uH3PLio+yaxhkW9Ppyhk/NM2LS5KVNsMCPBSf/wmF5Nv3D8Qc03CEGfAO7M1OeEgn5AlQM99ZpO8NYP754z6iv4LwfMR+YXkrjXd/jxpxSvv4n8EF1hrBAuX0PooFoMKW6PZM9QvcAkp0HERlvCOlULtfHu5fzRTd4YroiXYNizQqSqJA4fzyk8qBiHuIKgd6XWammPiRYgPeXBntIBcZo9n4FJShgnOa0u52PoiQiHvgCgWZglcZKhD6mdwZu3TZ+AA5uPq/PHakCPHlaHQ1Uhi6tYP5iggnOqnsCWVfPOgfP636/nMZGOunt0/OYAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0SnH7/K3Dt0HXFj1NsXVNgePVRJxV2ib45PhUgDpBg=;
 b=IVhLSnqDKcyLBnkPJsGVBPw5x8w8Ujjh3gvlr9SWEWVdEZm6C8yBbZB1MZjKIVrlGvm6fkcdWlb/e+A639yKC8MUXBcD1IOWBuSCl/fkhse29kRNRGWRnHRKHmd6CJbRi4QQPcNNtXl0CgAfn1Yt+KuLdfTUgaaas6FLDXHAoGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 14:05:49 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 14:05:49 +0000
Message-ID: <7558cb67-4ee0-4cde-9d43-4ce2b8d1ef5f@cherry.de>
Date: Thu, 7 May 2026 16:05:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] doc: bitbake-user-manual-metadata: move inline
 python examples to inherit section
To: Dawid Bijak <bijak.dawid@gmail.com>, bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
 <20260501091418.76994-5-bijak.dawid@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260501091418.76994-5-bijak.dawid@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA1PEPF00005B97.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::62c) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c56793-6c02-467f-229f-08deac41bdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ecZQh1X4CTe2rx37sxVGYQD4OtH6NZosX2a8T7/3+OjIQyQ0GKsaoqVpjyss+lucSZ3EeXZtVSfbTj4GWc1pV9J/uJxpsT/cIbPO5p12M1EJaFauJy1XI8L1BaPatPml3D+7l3A1SHS3gj1kPiA/EK0CU+LqJ+iQyrZKfnnxqGj5eYdx6Mgkdlan+x6ISm9IkDoo2XpbbEyJQNacraLlaSNxTKETrdjfnq3P4oiR+UaDw+EtE2bHpl2Fv6zgcaIqja429hJNQGrP63eq8dxxGLD8wfj6M94W9v2CbUjxh4oRfpgg50eDWS0sxHZb/iwohVLhEE0vhKBVhDEzwyY4FV9pwNHCKxyV9q5QTk3iBfEolrNo0RrKVA1CUpqjBqfZ70Cmg2oOY6G890KCvwumRM9JFg5ce2zrL1hGRdE7gx+Z8V5PFfVob7lPh1N1c0HRl+Zrd9TG7wvvDhMIfJ73BC1hBKPgcSLSJw66Q1gvqK+Tnzjiew++czsBh2D5cPUBs9fAjqo7X34zuC7o3nFk5B7b6+Fd5ObutiSv3mKTTvYeDV7zpPphdq0kKsrbriEy6ttJ9hskYRjme8kzarvB4v+olozlSzyfFIAGmXKJh9AvyheZziaFp6vavDJbZl0am3sxEad9iALclKQjnGTE+jBcZ+VhL1hauT8RvkjR/vg9dp3BDkPxd1rByhQpcQpi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qI74fWBDc70dMROGGIfEynJkyDE78KO+XiPIHQno6arLdeapBrDEtFFkde+N?=
 =?us-ascii?Q?UCUyMYvBqkmKryb3Ky5jLgk+eHPUrsc2RKRzE4Ywq7NIRyfwudjXSMKJM7OU?=
 =?us-ascii?Q?/Gygv4FtERmoI1tUA2kMbTcf13bRPJe18jyFqYWr3kFQN9n9kRvT+/uKi26k?=
 =?us-ascii?Q?/x56fcvTt09UDbHAvo6qHr1RqOzisw5FG1LVfRL0TGkrhhUeRGtsGYxqfERI?=
 =?us-ascii?Q?R+t6u+U4HwqKMNaaH26/krQKkkyjq5DRG7RWiQHNO+IfM9q3Jee8R1e1aium?=
 =?us-ascii?Q?VDi5t8m98OWMbyWNvO8RxNdLvdLrWPoT/u8o6KHueR2eTDOapaW9Q2/Ts8oX?=
 =?us-ascii?Q?3qMU2b7etQNQbViLNk8R5L8RgDwBCV9yju6C5hYHQXw37tbx9m8z4JvIWhTh?=
 =?us-ascii?Q?ddCnI3rqfBD0KnjO07bWW9SSJDWscSSOp6Qu+OUP69nKWrQl4zjiEytkGYP6?=
 =?us-ascii?Q?883JJ+cKr47Y4X1+QK4Bz5aO2sy8PjdZvK94ehq8miUIQzDKAey/BxHI7G0f?=
 =?us-ascii?Q?EXWprg4L1HEPFats2S2vBmOC/B2xotUWx+POs2tD3QwMonOoUAGwYhTdmqvg?=
 =?us-ascii?Q?ZCwzAe0BPzHqYqy6tTv6elbYg1a6c6/qBy9pEdxyoFlWV0IlZX61uOH707an?=
 =?us-ascii?Q?KzNk7LdipQ8tqFI0t58jqT0D8HMgBcPi9uM9zHrqGcT3Nig4oF8L0YGtvv9g?=
 =?us-ascii?Q?+GXeTrLiCkRvlWpW4Hue1yxctAropJl51ELsNTiomlh3+xsrl9nILtyzohJi?=
 =?us-ascii?Q?JDeCiBmsr6Nkq81WfiyKbYZNGyY7NZNa8yNp4vgY9yY1ruJ07Tqvm6gBblfT?=
 =?us-ascii?Q?JltE9NQQFT4jKskt7hyOQ6uF9zxb+5jfomjYqDMCSAl/VMjg+uzz/32Ktgdc?=
 =?us-ascii?Q?3jMqdEz1tLPgoDSAvMq8p99F9PXAVW33uCJIqiIe8oozeOHmWKBEGR+t40sd?=
 =?us-ascii?Q?/Sg3YLbhUULCdzM5WhS7cMuWsP/pj81AMW1CUTNxiBG+rut9IxP/APMRXZvj?=
 =?us-ascii?Q?htnRiEGM8qAy1vMbqbX7WI8er3YE6sPkNixSnTk+FQ0hrJXPMM8TZuzouI9/?=
 =?us-ascii?Q?QFRDL8B7Qu0Jzl4ik7Qao3ngLIUjbATdUjkjLb6oD2pJrvaGYeRNXMqC+dZW?=
 =?us-ascii?Q?vMKc2eLHNsvMxZjLNfVu72L+QgYq07tf+7F045gbbyGo5X9Vu7CsaexsvXjP?=
 =?us-ascii?Q?5DtWE3GDyanMUVBZ8MbfddSWNmNc7LqCc6q5DyIUAwZM793HgHxCReDszeFx?=
 =?us-ascii?Q?Z53fM76R2g8p5BcLhN3yQ9MQ+fOhQl6WvhON1e4CEBBuF+PWYc665Ys//1E+?=
 =?us-ascii?Q?PPD3H+YKUAy3wDuu53fzq0vOB8iTSZUrgabHPBxk3JtZzLLeurNsMY64Fhrz?=
 =?us-ascii?Q?pHEcduS++iCtjyU7Su40z9AJCieovSYwoeqtcapGqRAwIJfEWd0VpMJ3RpCO?=
 =?us-ascii?Q?qeWnql4QN1D7FfWjRKgLc73MZSFZ5FjkIgGVbOvfMmgEtDTO6RQuRqExEE8U?=
 =?us-ascii?Q?vx6MEi6uZW7VEvlgC+YE6yal+AGDG31ym9f729PMiCqK8YIu0QVsHW7+94mi?=
 =?us-ascii?Q?tKT/g/GkH7SM6Gd0m+wpalb6F1BSbzXInSy+fILfCUHhOPfnCLTHQrCJ1e5d?=
 =?us-ascii?Q?hyqVKoX2xBlqpeMhk4XqZ600k9IvZ9e8zKfYkDndxohQU5jeroHo4obAwegv?=
 =?us-ascii?Q?gs0I3P15la9pSYGDcneIFx5eUKlgiFpTuvJ+f7dhpEzjrw9Ff066/OCJjlTh?=
 =?us-ascii?Q?5Xnnplt0KA=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c56793-6c02-467f-229f-08deac41bdd2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:05:49.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2nRWbAQw0NAEKW4gHREuDJZBewZ9Ws4l03QGrUY0BMDgofoRMPuM98/ebHeFISkaoqSJbokRvNf1iixyOuifkoM6iv0JeiCCzydHGOjWJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 14:06:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19466

Hi Dawid,

On 5/1/26 11:14 AM, Dawid Bijak wrote:
> The two inline Python examples,
>=20
>    inherit_defer ${@'classname' if condition else ''}
>    inherit_defer ${@bb.utils.contains('VARIABLE', 'something', 'classname=
', '', d)}
>=20
> are presented as inherit_defer-specific techniques, but they work
> with plain inherit too. Their placement under
> inherit_defer suggests deferred evaluation is required, which is
> not the case: the ${@...} expression is evaluated when the
> inherit line is parsed in both forms.
>=20
> Move the inline Python expression examples from the inherit_defer section
> up to the inherit section, since they apply to both directives.
>=20

As said in V1 and in this form: NACK.

What's the raison d'=C3=AAtre of inherit_defer if inherit "works just as we=
ll"?

To quote Richard in v1:

"""
It works, as long as you are sure that COND won't be changed after the
inherit. When mutliple files altering the variables are involved, that
is often unclear. I think the doc's intent is therefore to recommend
anything with variable accesses is therefore deferred, unless the user
is sure they know what they're doing.
"""

The commit introducing inherit_defer in BitBake is also pretty explicit=20
why it was added, see 5c2e840eafeb ("ast/BBHandler: Add inherit_defer
support").

So it may appear to work for you in your specific usecase, but it=20
doesn't always. We are very careful to not add unnecessary complexity,=20
be it operators or directives so I trust Richard to not have merged=20
something that does nothing that isn't already supported by another=20
directive or operator. Yes, inherit_defer is useful for the native class=20
which we always want to be last, but it's not why this directive was=20
added in the first place, it's only piggy-backing there.

So, as said in v1, we are not using footguns as examples. We can however=20
say that something may appear to work but is a footgun, as suggested in=20
v1 where I said "You can provide an example if you really want to in the=20
inherit section, and add a big fat warning after it that it'll break in=20
some scenario so you really shouldn't do that and instead use=20
inherit_defer.".

Cheers,
Quentin

