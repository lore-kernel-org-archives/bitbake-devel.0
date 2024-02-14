Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB79CC48BC4
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 11:57:31 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.131])
 by mx.groups.io with SMTP id smtpd.web11.39945.1707911849379602009
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Feb 2024 03:57:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@theobroma-systems.com header.s=selector1 header.b=BjAqSiZ0;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.241.131, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+3d2AzOjRSYTQRiGj4MZgUuY3lYnuOcJAadwepEUcXU3ucPerFXdm6c2JGwsKqrgWGjTUpbo5D6QG3kzgdhhu6rvcsbLgag/Osee+uZ+9/t6GPqKk7NtVzgnyhtKAERgMVVvYQQkEAzOSLSZJKpOIpVOFGcJ5AZs75o3r0RRJFAqdsPaaDSC9RwZUZU0usw9AjvT0v2u1oSMDipPwVuEDx9XKE/E1KARfENo+19rBMcsMAdThXmf8GUfwwrXCgPD2qBTDx+FgbLGRbxBuW/WdpwQyPjGyk86K2/RsbH4obkJP8xvBjWBtVTxXi4MwVlMH8deWKdeff0HPIrNYtlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GKzoZy22lprk+6TmDkQ3HuZA1IkXQBzD8h2e85WETE=;
 b=mOp/Srq5UjV8kqlemESi3yW32/wZTUu2BsH6K4m5fCZdDFjCgRWCu0Bv+IhI4OiK6Bqrl1U7Wb/b8SboOLbB1PgFF6vhDQNJwGpt1YzuE2mOdGyvXoBuAZObG/Hc+3eZ+oQM6RW9ZXeOssNUam+/v7jOloxYlkanttm5H1j5IyMRI5M17ciN5PQv6v+CKysOaazPsYPZ2Gv3r8NuQVlhAdxD45zsilXrMa+42Qped39P/8gTF6XNi64JID2wlO9road1bSxUkdtC1Hh0lTYVrkQjz/SykaAKegI9i2Dki5lfDuosqB9QTpucWA9yfNEzFgR9zurM6YYrwDXTdfYMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GKzoZy22lprk+6TmDkQ3HuZA1IkXQBzD8h2e85WETE=;
 b=BjAqSiZ0VK1BUvDXnIN+CUX+7B+/8zOcLSat3zJb1dRXUFLNuJOwKkZYyGjfZM9rttaJmBE1Ept7o4intROcAaJ8NimIV631Jm5JKeBOiF3T9RRLyiWM7OZGNGlUHNOJw178R3OtnESOWZnrB7eFp63HYVa8siZ+LWquQiW5PNPz3cONC9foajUMOZSmO0KNe06MViKVQZilcwdsTPquWzb86XgKr95FOqLJk5kqRbk+Mp13L1viUt7YM1Uu8F/g+2DYz//6bT1en8qJYOMyzsx3iRJgSI0Y31mPSVyOqSgCR0KILCZ3Ec0goNSbgandngZva6DO1x6X+ljYFy+tWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PA4PR04MB7568.eurprd04.prod.outlook.com (2603:10a6:102:f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 14 Feb
 2024 11:57:25 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Wed, 14 Feb 2024
 11:57:24 +0000
Message-ID: <c858b3c7-8eb3-497e-b355-f6a1e78219a7@theobroma-systems.com>
Date: Wed, 14 Feb 2024 12:57:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] bitbake: doc: Add section for variable context
Content-Language: en-US
To: simone.p.weiss@posteo.com, bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org
References: <20240211104056.85709-1-simone.p.weiss@posteo.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240211104056.85709-1-simone.p.weiss@posteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR0102CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::47) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PA4PR04MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: decb0cf5-638e-46c6-49c1-08dc2d541be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CYyxJRzpkdWeF1x1EJ+8PwDrt2YrOp79h2HcV/pzavEkEITsrMcatDWc6uez8ktYvgPjpovhZ3SEG4X24gGLhPLN5Mo+vjyFXyB2PRu2k3ErI9fAu+LbExeOk/d3dyESyLe5MaQa2zpuIC5aiCY7qlsr2GLl4MwuhjJuPzjc7zTUm7PmCoWDPShNYlXF3ZPqC/yjBkZR1Fq5HF8rTqlIV5FP6gVMVTVvhfkzd5RxcWlw9H4ZoObwL/6AFydNfz4wR6UpDWfbAJxmKVxuRg5YsfTAWLd/7dA6RKrx3WkobQsGNPeLj0LH75pUrHI46tP0A379Fa2XSHKdNS1aHbWg3Bu0kcJpX9JcU5vDwdJ7Met5iFQ/fPBMzSOxxozjkRiUQKSPV1Ha+TchzHiDeVGSp01RyGR6eoeo9v3Lmt/uouvxCgWZdjFockqzVnZ5309IBgjnsz632AEnEmXJn0CksDs2YMmqAk2P2nwMPyBhLshF8IGEWmAv8E9+d5XJyXl2OqvPcehEKeuag0sd9GD79lzRl/ejzdkuZVLxHsuwSngcNv1zXtKOiIEC6O/gBtxp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(376002)(396003)(366004)(230922051799003)(230273577357003)(230473577357003)(1800799012)(186009)(451199024)(64100799003)(478600001)(966005)(6486002)(31686004)(6512007)(41300700001)(2906002)(8676002)(8936002)(44832011)(4326008)(5660300002)(53546011)(6506007)(66556008)(66476007)(316002)(66946007)(2616005)(83380400001)(31696002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?psqYOsSRYdM+sZ3LKnailc73SVQHhkwCO8AAC4bvH3JMApLQUOQ5NQMCv8Vv?=
 =?us-ascii?Q?fijQ2V+FkQTAG4s7ODlCJoZEMy369Lf/oXdr339r5zlZpeOcDGSeN9taCrjD?=
 =?us-ascii?Q?xbf+Dp1wtJQjpII8Ntp+LhwKK9XClL4CYTG1IsQTLLUErv6wCmQURbq/Y0HB?=
 =?us-ascii?Q?h5rZ+Lyd0DBtg7yD/mFa22f30Pd8p8OTqIWt6q5tZYZ3IU3R8CaulnO4W4mW?=
 =?us-ascii?Q?ND9VRr2xiLDDOwPCOQcmg8SHLICKRjXD6SoyUNeL5H+HZIxrEBV2S61gWdpr?=
 =?us-ascii?Q?q0V4RjRZRfOlrzMLLj6xTbNw3KucWr6b3vZkpViaglI5L+WNzUgLKsY/rpoM?=
 =?us-ascii?Q?C0o2CQ9CW7PkU7SYnVqbrWdykoNN8nP20HG2JSvjC1tm8ikl1dcIVLVem5pr?=
 =?us-ascii?Q?EcNocDK0ci9BWFwdAedk8tTqXx/AHPIQrgpCwugc5yyhQ+z4a6tPwKNwMny/?=
 =?us-ascii?Q?aquZUxQZDYnUT+w81L1ZFdffLSPICfsFeeY0LEzWLaSNMkyDz1b5W4Vtg7TM?=
 =?us-ascii?Q?fFrH/lq+RIhwiH5+NQJbXZghvkqDV5/RKOLXJv+CyXXlARSpuSrjOwpobiCK?=
 =?us-ascii?Q?0Ftx0iCmFRAq+XJzYw3klMajorp42vpyxdDaL8CKBTcG2yxwutVPKhIF7VND?=
 =?us-ascii?Q?yVY8JLaEvwZBXjb1+DYRG9PHwnUzUVYBIbrG/BcnbLBtzEloRR23Lj8YM9m0?=
 =?us-ascii?Q?p1AiaHGB8o8PuAtxFHaXlgo3Y1L4XDzQ9Jcf9RCWOBeo+EZ7YY57SvttWYPX?=
 =?us-ascii?Q?62HIcPBx8wTCB7m7M2lXAbgCYcxk+FxZcwhGrY3ldRXGUOOi60mtoVzfHcSi?=
 =?us-ascii?Q?mQrgwIJI1nj/u0Tt2zfmR1+S7sLwjNbRq2hhYswBNS6gZnsaAcyq91qoREeQ?=
 =?us-ascii?Q?OCNHN6zmNFVqlEI9jzWdCxNFbvHFehGAGQC8PJpvAw92YCEnSme3KzdaNT3k?=
 =?us-ascii?Q?W7kKhXnDXniYqbS6eshBnADOYsZ4qwAIV9fHW63NTFMUXHcush0Mm8T+XSA5?=
 =?us-ascii?Q?0P4dVa2ZsEPpUY9EdgVVXIhUSqzNoroj22OrTIu7wM2EIlJMwD75uRZmzHmS?=
 =?us-ascii?Q?pCueqsQHhAjFWJmFPkw00Jj2AAe48WuEQU2IjPDjvKEOPpKa434mTYbt9k0T?=
 =?us-ascii?Q?NcPFu+QdT5gf92fSgPe25P8MWDya3ucg26yb1Ld/WRXHTzHDbQK6KTWe74bO?=
 =?us-ascii?Q?DXbeMFGshOtwDEQ7UDg0VnIHKmr2d7NajntawWvuBUzKsZ5KVmM1Gouxgo7L?=
 =?us-ascii?Q?RqRczFgu9Hvsto7MoY8wIkSQIxpV8jlKDwITWZUZvsi2AXqiKjS47gnRVkP1?=
 =?us-ascii?Q?g2PF3BOk1TCxxeS58va0y6Txxh+PwzflwM+JUbS9AYf+dzeTA/pX29PYX9c8?=
 =?us-ascii?Q?b0xWJg7nF+41dlkL8KzLfki9cYehKy92UchcPVT3PZcUHtCLElg8Fpkqf7rt?=
 =?us-ascii?Q?eMwbal3vb7QRO77dGw3SH04prHFgGSyKjJGwrbS4PXcSRNUeZxrE4ooBVIOh?=
 =?us-ascii?Q?qFXDaZmAm5Ejl2wQU08nXSVeSZ+XQXTcseTPQe78ewmXyCyFwWK8ddFp0nYM?=
 =?us-ascii?Q?QElzVr1udpSUdN8HdgB/dnKuimLRmt3cFa15VceFDUOKl6Ih6LwrCP6XB32q?=
 =?us-ascii?Q?3ovSqYRCvAGbSJ1bObNYWFykJIrLPoiKM7h2M4QUXjVy1UcKyK2/AOJMvPgG?=
 =?us-ascii?Q?bC2HbQ=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decb0cf5-638e-46c6-49c1-08dc2d541be6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:57:24.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fD+VpqPyjB89jYXTyZjuRZ9ye7TRVL9WtwGchakTMq3awe+pa3ZFumghdiGbNbwDUbOzKGn2f8s4ZJEZ5OKnSMGSgJKZRGg79Vtp+i0StUeLZm7IE0iDSQYls/AuC1dl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7568
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Feb 2024 11:57:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15893

Hi Simone,

On 2/11/24 11:40, Simone Wei=C3=9F via lists.yoctoproject.org wrote:
> [You don't often get email from simone.p.weiss=3Dposteo.com@lists.yoctopr=
oject.org. Learn why this is important at https://aka.ms/LearnAboutSenderId=
entification ]
>=20
> From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
>=20
> This is inspired by the same section in the yocto-docs. It aims to provid=
e

Should we make yocto-docs's point to that new page once merged? I don't=20
like duplicated documentation :)

> information in what contexts(recipes, .conf, bbclass,...) a variable is u=
sually
> used. For that I tried to group similar variables, so that a short overvi=
ew is
> given. This was inspired by [YOCTO #14072], but of course does not implem=
ent a
> warning if a variable is used in an unintended context.
>=20
> Signed-off-by: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
> ---
>   ...bake-user-manual-ref-variables-context.rst | 77 +++++++++++++++++++
>   bitbake/doc/index.rst                         |  1 +
>   2 files changed, 78 insertions(+)
>   create mode 100644 bitbake/doc/bitbake-user-manual/bitbake-user-manual-=
ref-variables-context.rst
>=20
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-vari=
ables-context.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref=
-variables-context.rst
> new file mode 100644
> index 0000000000..9b94e09299
> --- /dev/null
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-c=
ontext.rst
> @@ -0,0 +1,77 @@
> +.. SPDX-License-Identifier: CC-BY-SA-2.0-UK
> +
> +****************
> +Variable Context
> +****************
> +
> +Variables might only have an impact or can be used in certain contexts. =
Some
> +should only be used in global files like ``.conf``, while others are int=
ended only
> +for local files like ``.bb``. This chapter aims to describe some importa=
nt variable
> +contexts.
> +

I think we have to be careful with the variables set in classes,=20
especially because if I'm not mistaken the ones in meta/classes-global/=20
are to be defined in the conf context? and the ones in meta/classes/=20
could be either defined in the conf or in the recipe context?

> +.. _ref-varlcontext-configuration:
> +

Trying to figure out if the l is a typo?

> +#.  **BitBakes own configuration**: Variables starting with `BB_` usuall=
y

s/BitBakes/BitBake's/ I think?

> +    configure the behaviour of BitBake itself. For example, one could co=
nfigure:
> +
> +    - system resources, like disk space to be used (:term:`BB_DISKMON_DI=
RS`),
> +      or number of tasks to be run in parallel by BitBake (:term:`BB_NUM=
BER_THREADS`).
> +
> +    - how the fetchers shall behave, e.g., :term:`BB_FETCH_PREMIRRORONLY=
` is used
> +      by BitBake to determine if BitBake's fetcher shall search only
> +      :term:`PREMIRRORS` for files.
> +
> +    Those variables are usually configured globally.
> +
> +#.  **BitBake configuration**: There are variables:
> +
> +    - like :term:`B` or :term:`T`, that are used to specify directories =
used by
> +      BitBake during the build of a particular recipe. Those variables a=
re
> +      specified in ``bitbake.conf``. Some, like :term:`B`, are quite oft=
en
> +      overwritten in recipes.
> +
> +    - starting with `FAKEROOT` configure how the fakeroot command is han=
dled.
> +      Those are usually set by ``bitbake.conf`` and might get adapted in=
 a
> +      ``bbclass``.
> +
> +    - detailing where BitBake will store and fetch information from for
> +      preservation between build runs like :term:`CACHE`, :term:`DL_DIR`=
 or
> +      :term:`PERSISTENT_DIR`. Those are usually global.
> +
> +
> +#.  **Layers and files**: Variables starting with `LAYER` configure how
> +    BitBake handles layers. Additionally, variables starting with `BB` c=
onfigure
> +    how layers and files are handled. For example:
> +
> +    - :term:`LAYERDEPENDS` is used to configure on which layers a given =
layer
> +      depends.
> +
> +    - the configured layers are contained in :term:`BBLAYERS` and files =
in
> +      :term:`BBFILES`.
> +
> +    Those variables are often used in the files ``layer.conf`` and ``bbl=
ayers.conf``.
> +
> +#.  **Recipes and packages**: Variables handling recipes and packages ca=
n be split into:
> +
> +    - :term:`PN`, :term:`PV` or :term:`PF` for example, contain informat=
ion about the
> +      name or revision of a recipe or package. Usually, the default set =
in
> +      ``bitbake.conf`` is used, but those are from time to time overwrit=
ten in recipes.
> +
> +    - :term:`SUMMARY`, :term:`DESCRIPTION`, :term:`LICENSE` or :term:`HO=
MEPAGE`
> +      contain the expected information and should be set specifically fo=
r every
> +      recipe.
> +
> +    - In recipes, variables are also used to control build and runtime
> +      dependencies between recipes/packages with other recipes/packages.=
 The
> +      most common should be: :term:`PROVIDES`, :term:`RPROVIDES`, :term:=
`DEPENDS`,
> +      and :term:`RDEPENDS`.
> +
> +    - There are further variables starting with `SRC` that specify the s=
ources in
> +      a recipe like :term:`SRC_URI` or :term:`SRCDATE`. Those are also u=
sually set
> +      in recipes.
> +
> +    - Which version or  provider of a recipe should be given preference =
when

Spurious white space between or and provider.

> +      multiple recipes would provide the same item, is controlled by var=
iables
> +      starting with ``PREFERRED_``. Those are normally set in the config=
uration
> +      files of a ``MACHINE`` or ``DISTRO``.
> +

There's another context which is the task context. It's also important=20
to document it as a variable that is added, modified or deleted in a=20
task will NOT be present, NOT be modified or still be present in another=20
task.

I think a nice visualization could be concentric circles.

The outer one is the conf context, it applies to everything but can only=20
be modified from conf files (distro, local conf, layer conf, machine=20
conf, etc...). Then the one inside would be the recipe context, it=20
applies to everything within THAT recipe and its bbappend, it can only=20
be changed from the recipe itself or bbappends. Then the one inside=20
would be the task context, it applies to the task only, it can be=20
changed from within the task itself or via an append/prepend of the task=20
itself (maybe prefuncs/postfuncs too?).

The outer circle would be one big circle (for one "kind", e.g. native,=20
target, nativesdk,...), then inside you would have a plethora of smaller=20
middle circle, each for a recipe, and inside each smaller middle circle=20
you would have a plethora of even smaller inner circles, each for a=20
task. This would make it obvious that you cannot modify the context of a=20
middle circle from another middle circle, they are completely different.

Cheers,
Quentin

