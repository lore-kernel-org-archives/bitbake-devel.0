Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65938FF8860
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 12:47:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.33])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44055.1777294063837160009
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2026 05:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=EIFScYfm;
 spf=pass (domain: cherry.de, ip: 40.107.159.33, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMs1fy1One2ahEHDX3XY09+RrTFyCFYLtYcf8aFSCwYEngpqjRqVU0s+tWoARA4nSta+QRGjDrOPMwLl063ODtWWzUU4qlbAPTkaiNc4BBlxop1IP60U9YMfmcW3nxNthkh0PCtGfHu/eYOPlErXjQK+VKTEnMbArbMVNi5Wpct3qELU8EIFrdFLKtkOulHFJrcr7FJrMOq+rA0PK5cJmlS2GyN1ti5Ps5Zx6T0eSJSaIARhGwtpeYDYvFk3mKTOCfd8OVAgYbBjU4jHUVusnRjV0OFYLSXd+4YGh6Nl6MIm4k7p86ZXpk5sCWUDvYb7tAgkuuB7+hSbxe1VjCHXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzwqF/hEd9+wcXp8jHUqO5y2JIobGz+4XL+JJmaiXLY=;
 b=Xh3B+6Z3Yi82p11+FYm4vnF1GusxH8wcxYnLh8eLbpq0AT+GCVG2qsR//qb4Kr0AseNYme3ZPYIE5kJnomLwYUgKx7uqUgR8llfAxtWzWop76aBYHAvurrRQXvdvmjd9PIpGdq9zaPZptPRobsaOHn2eFW825Y2yh+oaDdpoXRsxOCOfvmf494i6x9kNBBiUsAjmQeo1KCVkEkB9oGIw6L96lFrx7YgRTlqNSfsg3GpPAnjd4gFeoYnxvmmArS3FC2lQdyDEZRKBM1FyV7KEepADjG3eHWUIa5e+lET8x/zUGAT/DH8puSCN7mkYc0wefDftneAkEz4Vtmmp0ZwVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzwqF/hEd9+wcXp8jHUqO5y2JIobGz+4XL+JJmaiXLY=;
 b=EIFScYfm5Ad0TiQe5oSfOm/oqg2wUMViOTda5UFAQ6kA4CQmZdSQ8CeH9AgeXizgTDnGR8XJknreDmf44Yz0U8VyQfkWplo9mRlBGAVrx0gdbQsL5cFSTMfNl7R8s4hrN+/y1q7BsunZ2DEAa15Ccwi752i1Irsab3yByxEfQ8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by VI0PR04MB12662.eurprd04.prod.outlook.com (2603:10a6:800:343::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:47:38 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 12:47:38 +0000
Message-ID: <9720d93e-15c4-4deb-9fa5-1182d83b2e83@cherry.de>
Date: Mon, 27 Apr 2026 14:47:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH 1/1] doc: bitbake-user-manual-metadata: fix
 inherit_defer documentation
From: Quentin Schulz <quentin.schulz@cherry.de>
To: bijak.dawid@gmail.com, bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org
References: <20260424062327.820993-1-bijak.dawid@gmail.com>
 <20260424062327.820993-2-bijak.dawid@gmail.com>
 <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
Content-Language: en-US
In-Reply-To: <c25e0e9a-8809-4ac6-90ee-3687972e03af@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0403.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::9) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|VI0PR04MB12662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2a8aaf-ab4e-4fd5-04ec-08dea45b2983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	z/cdhyoi6k1efJz1/09EgM8EIGjUx2GpUqGHZR7UNGVBcZBjOo/d8umgDNjMZQZNFspu5e8VmZlYcNRwkf4Tg0l5qTf1Xw4yLhM6NmzxvPEcAAZkmZaSa0D/QmonkimIY+beqWAtUSNSBAI4opjBH9p58ydwvl5PxT6krBouuCXOvsxDqIkJhmnNOTsuM7D3rdyJbiaT3SU0kAS+LyD6z/nzAQDxGcHIRrLL98lh41PMKqt6M8QpZHqe76a0LL5n1lF7k9xPnRmjgh5Y9m4PknJW1dYWs+DPkG1U+2DEFH3kux0X1xKY5aPloPEl6GyAT4MOWTdNdUagoPGZ/KcvDmo4QnsyLzqhKJgM21L/mF8zYPhcW34ndVxhYuTI5oB0ueYB+LgV8ZjTaz2BKhoIwRdY0ztYUeDy36sD7BTtgsU5Hqwm2OY7AnNlVAB+VR4hEJKu0QR/eY7CMX9MM8cZJwnZm/Lkp/0VChDiPupOJepwQKyVvTR1gfSZwESCBFQ/xEuqm7eZfRc6h7Ba9RppZ3l8QhgiJpcJYI9N3pA+WUvPEK04rwRpDfBVQYhKI92rrkZQVYC/+7Zktr4wBA3xVGOo6wTd/B2+UfwXZijrzjAE7Qk2NXoNJrqIGHvCxs1DQavb5IALDNzoKr7yNcPE86/16rmW/ckj4Fhoxl3Nt7Icf32mAuKQk16JyS1L3V4WkSjn9wPPk26t26vGGqBK0WkdW5mT96/rmZExOMEm4iU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LL9E1zq8UpMPRKtW5bJ8kyukhCSZZWgrYPXehW0GVSBLpjqw0vcqa0RV4ha0?=
 =?us-ascii?Q?OWxOc82Bdfeo6hPSnkd8avrGeJ+qKcEQ4dEC3l05srRVFD5I52H970AcXog9?=
 =?us-ascii?Q?PL92r9gH2kwPbyyH0jq6w7zLKU8myiNWtrscKg0G7TzOEwUug/AiS4LwOewr?=
 =?us-ascii?Q?z4zFT9Xe4wulvzH8H47PiRQnn4sVYPFarp2nVjAu02p1dbyrT7rCE5zg0EaD?=
 =?us-ascii?Q?1Ybh8vEpMBHjApdSXPfta7b3D/LhOQ+B/nsN7L6KajrxdfDKPRQX5mbrXesN?=
 =?us-ascii?Q?LuC6b976HVJXgRgQ4fhucwXQ4rwcD0g4cxeyWmOpLNqy3uxKHUMJqg+znOg2?=
 =?us-ascii?Q?dHO54LJulbvA2VkqzjOYq5wiR/JkrshZN3uWHgkLQ6dElCBgryypiTPWBFhl?=
 =?us-ascii?Q?8I0NpcBh0+GR4wovaI/zWafKqyJFS28grCS/W98wryBIANQEr2BCn+W/Bt4C?=
 =?us-ascii?Q?0NYS7cml9CJAlgnGFyDScSAy1HysguGC1oWpwV+j+zQHmliMPJjcENDWiXfB?=
 =?us-ascii?Q?88Vq4XhmR2umhL58vd4z6CBgvF29kpLeGT8c/tDzR33KcYtUXxnShNoRQPvJ?=
 =?us-ascii?Q?9rJ4ErKWiQpB5bCcw2AvmY/L2QGXT/L0qQviSJQmck3rNfjOoTOHix8XmPiB?=
 =?us-ascii?Q?FlJhOrOWWrjG3OvRoi49BsRZAmdAX4ZDUV8gG18XVTPCVtyIGWnh3N6WWD1g?=
 =?us-ascii?Q?WFQzAIiPwqPULmRCQstybCXNJjtLNSUKGf3tIbD9Y6+Snhj/sIResPZkd+wN?=
 =?us-ascii?Q?oAFhENYwDrCtgqGMq44uH6oR0rRjMz6SnGB0yjLAJImDl0hPceRt/e/RBJ+1?=
 =?us-ascii?Q?FQv5hZ7/evLV1EDhDDPRjaNaNhvpzErwM3m6ov/z7f1CBhkPgEnM6EXpRzV3?=
 =?us-ascii?Q?94HMr0OPv2NJEIk52L+3x53BDB65FPeUbWJbbk9qW4kqxVevp6ioZkgY429c?=
 =?us-ascii?Q?VQyJAas4L/nz1LD3z3W0D2Ya5hJO+T7Lc6FHbgK1YEt1pX3jD2a5f4Ij3aFP?=
 =?us-ascii?Q?MUryexYI8eZNORCVCXBa3pbzHO0Al33hftNQtGJQpVwSCZw+ePNKOK7uEvSb?=
 =?us-ascii?Q?ZYhINNFlBfZFqhsIn0EkhSHihf6hxBPO/lM7dtIzE9LX1AktppIa/MHZkfyi?=
 =?us-ascii?Q?4XQ1oW4riTcMbsb7slxpUGc1NbND3NEN3XEPHal2MXnyBg1SgnFqwpohZwcm?=
 =?us-ascii?Q?uVe8cUx0ciUHag86eaB4fsB1GQStkbcFCmvyEsK0AxiXCPusPNWaZR/KE6X3?=
 =?us-ascii?Q?B3/20usf0KlDHJLi5uuaRDR8H8K8YqbeL9ViMVRggsRz3ySHzHuTlgekDfOV?=
 =?us-ascii?Q?EJEKzF/GkoucPGjAaRmKWR4613dEAlrsItsqUiWJQUW5NL/5dRGXSezL9vJu?=
 =?us-ascii?Q?kQRdKrVIvnudHrD13cWqVXJ1Ak92oslqfddW7fu6DJiJuFmDiX1ZcywkwRsK?=
 =?us-ascii?Q?cRah1EDeuPhAuVkFeRp/ZYLjljGLHxzTjrr2otoyRO0wjWZzy9T8zw2icx6h?=
 =?us-ascii?Q?gkwj4BD5AmduktcmNsrTUMVKtD5m+K8kr0w1A/JZ4S838+4tKZVIiVxH+NHA?=
 =?us-ascii?Q?3Pzahj4/erQjorKEuuhLzcm23WLjc2pST+j5bSM0iG/r6pvJJqscdeiFlXua?=
 =?us-ascii?Q?HC+yHrHVc2IbH8jHya7mcTJAwLqqiB4ahamNCyWLf6CUVNPGx3BMmJTfbEYs?=
 =?us-ascii?Q?szMsleCFLmVxD6UwfZ2M4WJy4hodC6r8PhVwrARyXOQBJLMbA8Sak5sYkDaf?=
 =?us-ascii?Q?nhMVSZis5hyrGlY0nYE4u84u/urSzU83fY0w6XKRPb9f5cr8syv0?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2a8aaf-ab4e-4fd5-04ec-08dea45b2983
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:47:37.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ROvT/W4lVpch/1+rXqpEGJCE/KHoNeXONSgUqeuDDXFQsVfa6Ujl69O43Ql8ZH60FoDaYaTfDmXRE+G2bR/ivHJzDrlifbecqqCvGf3sA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12662
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 12:47:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19394

On 4/27/26 2:35 PM, Quentin Schulz wrote:
> Hi Dawid,
>=20
> On 4/24/26 8:23 AM, Dawid Bijak via lists.yoctoproject.org wrote:
>> [You don't often get email from=20
>> bijak.dawid=3Dgmail.com@lists.yoctoproject.org. Learn why this is=20
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> The documentation for inherit_defer contained the claim
>>
>> "If VARNAME is going to be set, it needs to be set before the
>> inherit_defer statement is parsed"
>>
>> which is incorrect and contradicts the purpose of inherit_defer.
>> The wrong claim is replaced with an example which demonstrates
>> the contrast between a plain defer statement and the inherit_defer
>> statement by using an override assignment placed after inherit_defer
>>
>> Additionally the inline python expression examples have been
>> moved from the inherit_defer section up to the inherit section, since
>> they apply to both directives
>>
>=20
> I'm pretty sure the whole inherit_defer thing started because an inline=20
> Python expression didn't work. I vaguely remember a bbappend either=20
> adding this new inherit based on PACKAGECONFIG containing a value, or=20
> having the main recipe with this inherit <PACKAGECONFIG.contains> and a=20
> bbappend modify PACKAGECONFIG. See commit 5c2e840eafeb ("ast/BBHandler:=20
> Add inherit_defer support") in BitBake.
>=20
> So I'm very skeptical this is correct.
>=20
>> Also add an anti-example showing that the previously documented
>> pattern of setting the inherited class name from an anonymous
>> Python function does not work with inherit_defer.
>>
>> Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
>> ---
>> =C2=A0 .../bitbake-user-manual-metadata.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 61 ++++++++++---------
>> =C2=A0 1 file changed, 32 insertions(+), 29 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst=20
>> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index 40cae6b05..38efe6b11 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -803,7 +803,17 @@ An advantage with the inherit directive as=20
>> compared to both the
>> =C2=A0 :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:=
=20
>> \`\`include\`\` directive>` and :ref:`require <bitbake-user-manual/=20
>> bitbake-user-manual-metadata:\`\`require\`\` directive>`
>> =C2=A0 directives is that you can inherit class files conditionally. You=
 can
>> =C2=A0 accomplish this by using a variable expression after the ``inheri=
t``
>> -statement.
>> +statement, as in::
>> +
>> +=C2=A0=C2=A0 inherit ${@'classname' if condition else ''}
>> +
>> +Or::
>> +
>> +=C2=A0=C2=A0 inherit ${@bb.utils.contains('VARIABLE', 'something', 'cla=
ssname',=20
>> '', d)}
>> +
>> +In both cases, if the expression evaluates to an
>> +empty string, the statement does not trigger a syntax error because it
>> +becomes a no-op.
>>
>> =C2=A0 For inheriting classes conditionally, using the :ref:`inherit_def=
er
>> =C2=A0 <ref-bitbake-user-manual-metadata-inherit-defer>` directive is=20
>> advised as
>> @@ -827,39 +837,32 @@ the variable after the line is parsed will take=20
>> effect. With the :ref:`inherit
>>
>> =C2=A0 Here is an example::
>>
>> -=C2=A0=C2=A0 inherit_defer ${VARNAME}
>> -
>> -If ``VARNAME`` is
>> -going to be set, it needs to be set before the ``inherit_defer``=20
>> statement is
>> -parsed. One way to achieve a conditional inherit in this case is to use
>> -overrides::
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0 VARIABLE =3D ""
>> -=C2=A0=C2=A0 VARIABLE:someoverride =3D "myclass"
>> -
>> -Another method is by using :ref:`anonymous Python
>> -<bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python=20
>> Functions>`.
>> -Here is an example::
>> +=C2=A0=C2=A0 inherit_defer ${VARIABLE}
>> +=C2=A0=C2=A0 VARIABLE:someoverride =3D "someclass"
>> +
>> +:ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
>> +defers the evaluation of ``${VARIABLE}`` until the end of
>> +parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`,=20
>> ``${VARIABLE}``
>> +expands to ``someclass``, which is then inherited. Contrast this with=20
>> a plain
>> +:ref:`inherit <ref-bitbake-user-manual-metadata-inherit>`, which=20
>> would evaluate
>> +``${VARIABLE}`` immediately, before the ``VARIABLE:someoverride``=20
>> assignment
>> +is parsed. ``${VARIABLE}`` would expand to an empty string and the=20
>> statement
>> +would become a no-op.
>> +
>> +Note that assigning the variable from an
>> +:ref:`anonymous Python function <bitbake-user-manual/bitbake-user-=20
>> manual-metadata:Anonymous Python Functions>`
>> +does *not* work, because deferred inherits are resolved before anonymou=
s
>> +Python functions run::
>>
>=20
> I vaguely remember reading on IRC we're having some issues with=20
> anonymous Python functions and parsing lately, so that may be related to=
=20
> that. I haven't followed anything in that area so maybe I'm wrong or it=20
> has already been fixed. So I'm not sure if you just happen to try this=20
> when things were broken in BitBake or if it's really intended to work=20
> that way.
>=20

Reading my mail backlog, I just stumbled upon=20
https://lore.kernel.org/openembedded-core/CANPvuRk19e3PhcVXxLUJTjaPE9bMXO-0=
4MLytqGNpA0=3DPEzeeA@mail.gmail.com/=20
where Jose links to=20
https://git.openembedded.org/openembedded-core/commit/?id=3D6b553a5042b9d58=
28a9da675ede16e10f06dae90=20
which does indeed mention this is a known limitation:

"""
Anonymous python is executed after all inherits including deferred=20
inherits are processed.
"""

So this part is fine :)

Cheers,
Quentin

