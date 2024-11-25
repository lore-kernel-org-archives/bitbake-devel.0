Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C5D58D69
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 16:35:05 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.51])
 by mx.groups.io with SMTP id smtpd.web11.23026.1732552502007592260
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 08:35:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=DeNWkSeU;
 spf=pass (domain: cherry.de, ip: 40.107.20.51, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbZqyaLzLrKkMVDT5u6Z8+dtrYXoafvIJahfYKzMHKi2YtlCMY33QnJt6igCrfcplNuXZc4XIcP0VIBT2TC5KAKDlUwV6wfDBoHdkvfpyE/KjpmSNWGtF0fggdwcC5VnGbeahr7MR2xdj5MZnpJqHklUnUgtIoUal5R4Snch3jrkECj8j9UVYGABwSxleq7L5RYBtUli+pRudVU+FNTsFfEJuwXoo1C0vYe4YF2jnUVmfKW7KZl6zohV3R/TYqOhAIkN/VYfSzo2fhvEzohZFPPDma47oQavD6WYPxtvKn0kiQ1CVM254hiDp9zQ/i59hRrG6kb0rmwiobc3wYUgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZgrvuP1rrSJeM+uHHfI+SLL3Lzc78gsxAqYUZ3BWWo=;
 b=qdqlJanAKKGSXoPOk0KLRhsvp42GNBpSOjeG9F642MnRinOI4ecWdNO7ojXZgsqCqno+6xezdx3QNSZbOjNE9cmVkaf7irBHlWrRQxKrAzNgYEcdmnMK8vTrx83fRBJISELnaw6tt4fM5BT2qU9X2IFy8yFe/zDrazr17bH2PRleSlW7HkQuoyz6R2P34RBXdJWQfVHk79/5zoB3o9n0zZvWshQbnWOdm9Lv1Tvvzn1f2fU66neEh/uORY0oVv1LuLdE5pwSnp9TL6qlLrAg3r1EqPMEnhhKlZHyF/BuirBi/3X/LcnpV/piICMIRj8xDZByJo1RQ4u7YoqAy78VQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZgrvuP1rrSJeM+uHHfI+SLL3Lzc78gsxAqYUZ3BWWo=;
 b=DeNWkSeUgLtgQYmzkXHhZRBgog666PYPVK99szLzXY0Kl9PqK9mDi+ILRYz1jeT7auTc1Ao0smlKdMBUCI4femYWXThyrtXpo6dORSg+S6AV9qUoZpMWAfSM934l3HfU7jTzFvkyPYCHudSuMUEd29xc3TROZED8CrZWBsx5ACM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 16:34:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 16:34:56 +0000
Message-ID: <c0592093-5a77-4de2-b9a1-b7e0aa573d5c@cherry.de>
Date: Mon, 25 Nov 2024 17:34:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel PATCH v2] doc: bitbake-user-manual: document
 inherit_defer
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Yoann Congal <yoann.congal@smile.fr>
References: <20241120-inherit-defer-v2-1-e9291b7cf59b@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241120-inherit-defer-v2-1-e9291b7cf59b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f8355a-ac2d-45ec-0cee-08dd0d6f18ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XgwqVITKJyIcDIkw4eRpZC7LD7h46tbY2szPAhXEtmGdZWhK479O6yoc9B4+?=
 =?us-ascii?Q?CS+3ATcx+bXts8Jx1f54/0SRObZrMj7E9D/0ip/AYXfCaAsRAOP8d1J27zs4?=
 =?us-ascii?Q?+fda/5YZaTSE6y1l2WZKxjzI8H3Q68JNV73hOanWMzWxhvfVU4VXE/ZoEpJc?=
 =?us-ascii?Q?zYSHa3X+ih9KkWMBf34dOqJ2HCgiUaOvGTtPfyhrsSKgnvnO/U3zcmKuFrDk?=
 =?us-ascii?Q?kvpF1ww8rK3uL6iUfpPxT+gulHGzU5sS4hZk+4UACxHTajeENtAjiWFC9IDb?=
 =?us-ascii?Q?YsVATwh/o4vdW3uQXV4UChSIzBRlV1yqhjwT1UZOCQWIBi99j0J0b13WOR9i?=
 =?us-ascii?Q?ZmDM3Sf6BwNlG5H0ic+wMG3rIqXREFcovm7y9lBKXM2Luetp2UGecXyog8/0?=
 =?us-ascii?Q?q6dpM/XLqMv3/iRCtleusV5KnVekFfQ7Tnuetbug7bMlFCrgREWSj7li4NHr?=
 =?us-ascii?Q?EYVXlpZv6wa3cv/wM6g03SfBBAJCvOFnG7hlPNybRp/DnzSR77fBmwCdixY7?=
 =?us-ascii?Q?94M0aDlMyUYxeKds59TFJPlFKBuyP5WQRQWUmDBUv+4+SK7RvX2/PB9bGtqI?=
 =?us-ascii?Q?V96B2levbzbiuCfa/apmGnYKu2O7dEsdOjogyubc3DWDac2LRchMivF7NEuZ?=
 =?us-ascii?Q?TP681OeCvwvXK6bqC9/+FnMCD5u7dp9d0vIZlwyfUZHJNmIysxpTDgJYApQG?=
 =?us-ascii?Q?3h+yHJuwf6+JKYm8Ppe7cTIDbp5xhr6eSP3oWrsSLS62KtipBViE+eHFFsrY?=
 =?us-ascii?Q?+CJr24JSr5Glq+lk+jWFXHwX5szLzssPikH4TWuYmxOOpQI64jnxZEw058Jq?=
 =?us-ascii?Q?eXGp7yZl6xm9ba1pY4l0luWqIpr2REXSZJDheRBWnIeGBw9OksoTiSER1DQQ?=
 =?us-ascii?Q?WzdoHDdsnUTwA2v/DuyHx+G+jFsQ6OEsJmifE/1OygFcT/O6D9RoT7mrw2/P?=
 =?us-ascii?Q?io7mDUhR6algSBTsPDAwebMNKXZ/o5iPdrpqn9gibLqILTxp7BypfURQT9mb?=
 =?us-ascii?Q?xyH3iJcBTqQBzPcg31DmFHROq/e8HTdtWA5fOdMmRgMrK/iSevd06St9ieRO?=
 =?us-ascii?Q?OVgKDSk5ctHsgQh+gipr6AFApr6flaJmfCQF2bRwGGPmuEKudCF3mnOpnH9K?=
 =?us-ascii?Q?4hXAtPdUe6WaVnSU1BWrCkocym8zmoBVN4twpg6gV9avFWBJUVyVZKdMKXMZ?=
 =?us-ascii?Q?rzEjVHuILgVHvZnjBLuDNe+Lx29uCBfhagbO//CLYLzPxhGxUGQmhYEMhAnD?=
 =?us-ascii?Q?OKKNLK/GBz5dVBeLIV2w1QtqzVlwc10e8artpFH8mceZdBEKpHPKmvxyicah?=
 =?us-ascii?Q?FYE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vc2MZlisq1PbSSgfWH23S571l6yDjG4tiTZhpZKfIoLJv8lGbPm1fhvMpgG/?=
 =?us-ascii?Q?siua4as/9SobWBdJOlWP9yw29j5nyUnsYBe7IFzbjGAG/GDzoVMRkINOCM9o?=
 =?us-ascii?Q?7VvsIwnO/6CbAlg0Cc4d/U9WGxT+mC2r1j8itiXhZp8eT9XVSmcKJYiL6KDy?=
 =?us-ascii?Q?th4p9gnevb3ZwWQIUjNCQrVuj3U58ONJNHWXBNtl7w732fSUYHrblYCBia3O?=
 =?us-ascii?Q?0O//mIKM4lVD4Ff1LJj8RUQW04dJOvr+8sRJ9DBOiZExHGkjpr4aD5bro2GW?=
 =?us-ascii?Q?5yInFFYhC4OVh3Xwm6m2kROiAUuCmN29a2kc9ppmWxNg7Ehu6CSxcgaRIfmA?=
 =?us-ascii?Q?9ZBWVnhuJeM1a/RRMQLe+oPSU/0N0mucyrmQlcnP5v3iUW2jd6WLM3y2Bbus?=
 =?us-ascii?Q?iI8yvY9FvC1VzEMurR4NaWOVjyuvIDx0ddflvSkhG+5NKIjDnFigIeGW96rW?=
 =?us-ascii?Q?YJl+Esq6JHJJ724RkeTknEQ58P/gsACCbJDoyFyefQ5rZLxU9WRyqpKbZTYD?=
 =?us-ascii?Q?pgz3tnQ8TVtn7pG4c2LFow6p/i1TUPwbe2vBHt7ROG2uRry2uGhVMrF+tmzl?=
 =?us-ascii?Q?yvqrD96xB4XJdpissAv2BEmDWBkpVOQtxZU8m2De932UR9m939TN/mJZ4FZQ?=
 =?us-ascii?Q?8J+yYHgrBGuKDC0mqcHoWqe8UoR4rnQK9MJSMnw3iipV1zOEnywM/PludimC?=
 =?us-ascii?Q?luIW7UStWfvUtzkrlyimNmSbnGhPhRZwdsWJPtFCP6v2Y2EnrdX9H9En19xH?=
 =?us-ascii?Q?W1Or5rmIFz2nTBLPu+yNSNOYXWi45EX+bKU39jj47v4LfFTkI96dm3iYiX1t?=
 =?us-ascii?Q?zaSr3Tnt8cXOK/ejBxGxPJMRph1XLzCRd51nSaNlqdBhupr4tz1SZl7/bfZr?=
 =?us-ascii?Q?AlqjEW6wahmokAVJmoaMbNDhPzMBwZE6g7dXulKahzvrjgmZwgolQgEOTk7P?=
 =?us-ascii?Q?OHYBCVUmc1dcid8IP3MtrfhZbPMWnKevMnQ02yuyCwyxuGoe8CV2dZf4uKMp?=
 =?us-ascii?Q?y5ZtCpnTIOk79heR3p8tj8pWOCfMQwBwrRQdUGe7p5AKlCDekqKPYki0hiI2?=
 =?us-ascii?Q?5EAJgQxu8sMQuGIhC23PtRWqzEQshrdM2m8b9/yAL0v34uK3ludGn6sNjra+?=
 =?us-ascii?Q?etWI4gfR9waaVcdo39vd0rgHOEEX2bvYWLpse0I+AbPj0poc5rerX8kDOPuz?=
 =?us-ascii?Q?V+BMT5QhKidb+sQv8AwotYmZzLbdwPC/8DeNY1OEj3+YQTQDU6T83hM21aUE?=
 =?us-ascii?Q?1KItLa6xqRE5kgp1XOJE9+YMbggh7ZgQXC3J0QbMXTdzzYXLR7O395foOtVw?=
 =?us-ascii?Q?qSSKbDUW/21Y4oqAxzQkU8gzsOxNp2/HX/5xEnB3Tl5beqTZu/wadFsp/fTf?=
 =?us-ascii?Q?/XBAZZdRxylKS7q0GwGNR39HJwQuFy9lfrcum2+WgktY443mPDic1fbmcK3d?=
 =?us-ascii?Q?b8vs4X5vwML9Dv59X+AFKaCv5SRmp5mcGhLTEL+VitrWN0QtE1V+uKMLndV9?=
 =?us-ascii?Q?hGPw7kyTwsELXk/2djOAFzeJFenWhcCRekDmFVe19Yz0UFAwzb0u7LkyzkxL?=
 =?us-ascii?Q?RV4drF+oaisGfM4HlYiojxdFLl8zh8Wee8f5wteancThPll6ej/BxYWzPwD0?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f8355a-ac2d-45ec-0cee-08dd0d6f18ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:34:56.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjIzVdXSob+6riNwb8cnlE9jhAiMThl9RURz3XJ7D5FOJh5ul1C8zuTnNCuxE3o1oHnMJDPLEfpBHHPoDD8TL82lMAXxvj2h8UqPbxAYes8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 16:35:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16827

Hi Antonin,

On 11/20/24 10:30 AM, Antonin Godard wrote:
> This was added in 2.7.2. Since using inherit_defer is safer that inherit
> when inheriting conditionally, move the instructions about that in
> inherit_defer.
>=20
> Fixes [YOCTO #15640].
>=20
> Reported-by: Yoann Congal <yoann.congal@smile.fr>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Changes in v2:
> - Move the instructions on conditional inherits in the inherit_defer
>    section, since it is a safer call
> - Link to v1: https://lore.kernel.org/r/20241118-inherit-defer-v1-1-26866=
a60ab1b@bootlin.com
> ---
>   .../bitbake-user-manual-metadata.rst               | 43 +++++++++++++++=
+++----
>   1 file changed, 36 insertions(+), 7 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 58975f4c88ce549a2fd27136c0cb37b636bafcdb..40a0c6f02d9c35297dbb51da4=
65efda83d832917 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -771,6 +771,8 @@ In order for include and class files to be found by B=
itBake, they need
>   to be located in a "classes" subdirectory that can be found in
>   :term:`BBPATH`.
>  =20
> +.. _ref-bitbake-user-manual-metadata-inherit:
> +
>   ``inherit`` Directive
>   ---------------------
>  =20
> @@ -809,19 +811,43 @@ An advantage with the inherit directive as compared=
 to both the
>   :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`inc=
lude\`\` directive>` and :ref:`require <bitbake-user-manual/bitbake-user-ma=
nual-metadata:\`\`require\`\` directive>`
>   directives is that you can inherit class files conditionally. You can
>   accomplish this by using a variable expression after the ``inherit``
> -statement. Here is an example::
> +statement.
> +
> +For inheriting classes conditionally, using the :ref:`inherit_defer
> +<ref-bitbake-user-manual-metadata-inherit-defer>` directive is advised a=
s
> +:ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>` is
> +evaluated at the end of parsing.
> +
> +.. _ref-bitbake-user-manual-metadata-inherit-defer:
> +
> +``inherit_defer`` Directive
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>=
`
> +directive works like the :ref:`inherit
> +<ref-bitbake-user-manual-metadata-inherit>` directive, except that it is=
 only
> +evaluated at the end of parsing. Its usage is recommended when a conditi=
onal
> +expression is used.
>  =20
> -   inherit ${VARNAME}
> +This allows conditional expressions to be evaluated "late", meaning chan=
ges to
> +the variable after the line is parsed will take effect. With the :ref:`i=
nherit
> +<ref-bitbake-user-manual-metadata-inherit>` directive this is not the ca=
se.
> +
> +Here is an example::
> +
> +   inherit_defer ${VARNAME}
>  =20
>   If ``VARNAME`` is
> -going to be set, it needs to be set before the ``inherit`` statement is
> +going to be set, it needs to be set before the ``inherit_defer`` stateme=
nt is
>   parsed. One way to achieve a conditional inherit in this case is to use
>   overrides::

I don't think this is correct. It is the case for the inherit statement=20
but that's the raison-d'=C3=AAtre of inherit_defer, so that this actually=20
doesn't matter anymore?

We could however provide an example of using inherit that doesn't work=20
(redefine the variable after the inherit) and show it doesn't work. Then=20
use inherit_defer and now it works even with the variable later=20
overridden. We can provide a typical usecase for that, which is to be=20
able to modify this through bbappend for example. I believe this was=20
born out of people parsing PACKAGECONFIG to figure out which class to=20
inherit (e.g. python) but this wasn't working with bbappend modifying=20
PACKAGECONFIG, because it happened too late in the parsing.

Otherwise, looking good to me!

Cheers,
Quentin

