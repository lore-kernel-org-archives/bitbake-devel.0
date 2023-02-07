Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190FBC636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 11:17:21 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.52])
 by mx.groups.io with SMTP id smtpd.web10.80951.1675768633353604871
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 03:17:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@theobroma-systems.com header.s=selector1 header.b=gKIBu9Ox;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.52, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdKJXv4JNDTPreEdxp7SeMFSFh/nSwWYNZGRGOp+BJCEvVQw+UzD1/62yPesnQO38l6OxRxpfdlQ4dh3/cmHZBHuSXEko8Pskg4odeHA0E99KrrspMRfOl4gpi5wgdxe+OQzyDxtKWA1XgoTlxEWts/h9PUrxxJYBsmLyVuUKahm6Zh//sLOGxFVK0MGj8zGz50a3Zy7ffBDMcoLqxbAu2xExx37kjLsg+A0aE/qQ8BVaLOnPp/Tl3URuOi9Hcvl+SaOKsLMlhpm8EyoHcWpW7ZoORkrpi2/RnZAYyIMJ0eAdwXiq+HT5MDqIOECeGUgoueTo9POMlX9Mv0Rd2zaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFCQk/lGQByWg0G6Cnm13nxEwwAyEsoxuzx5XCcTjuk=;
 b=Jz9iq4OatI+90JMIysT+7spleAjfmTPxDh+UFbIYQLCeVngEoBSnqWp3/ajsFE8+fjpXoxNcAX523ncAdaHb9FkCJ/nrFRbn3w5qtdxh52EilSeGis4hiNKEpXxpbYJxSU9zX8/pwtdi6cd5E+7ThO+EXXf6SeXDorPfn9zzWNJuVpBJUCBlWLok4PT0fK/iJww2yscvG65jKqs3zahs2w/accKf/RYorwK7BR18IoXeF2Ab+yHqHDsDtDoqAr7ko3HfdsQdnA7SRLFteVT5uYY7Y3vF3LLvNhQUKNnZI5V10veXao1Cjy4cAh/0JNAWpi8pUi7uW6OJZQ4BAx65QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFCQk/lGQByWg0G6Cnm13nxEwwAyEsoxuzx5XCcTjuk=;
 b=gKIBu9OxpTiJxUrP1cgrTaUlFsd1p0xTAafCakotF1+KqA9AQlleIAwA8y0emBt1Ero5cXWM0rgw6AVBVpWCtXfjyAr9rQ8zu29QrPYxPPRcQC1Qjfk50dkYFCfja/x2SaHZ/8GSTmvDtlE1Pu3658lFM1b//x35NrkS7js55p02p12of5KKKXFklDCnQ9NjVysQ1uO9HPxdgk4xw3lPjZiJbueqjNnnp+27SAfXJhmonEP8baGQZMJXSxmGC/Vw9Kn3b43Krq7tZS+FRpd6ZherH6+zREpDCsTlVlSEIlJm093YN5FLt+v3V3cbJtKN6KXh/7siyEe1flqgroLTCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PA4PR04MB9392.eurprd04.prod.outlook.com (2603:10a6:102:2ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Tue, 7 Feb
 2023 11:17:10 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%8]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 11:17:10 +0000
Message-ID: <e2982195-ba32-109f-0eba-311aa590a0ca@theobroma-systems.com>
Date: Tue, 7 Feb 2023 12:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bitbake-devel] [PATCH v2] fetch2: Add path control to
 BB_ALLOWED_NETWORKS #bitbake
To: anders.joergensen@advent.energy, bitbake-devel@lists.openembedded.org
References: <tRzV.1675761464866849302.d3iU@lists.openembedded.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <tRzV.1675761464866849302.d3iU@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PA4PR04MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: db702fac-181e-425e-8218-08db08fcdab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yofY/kQPt/zOr0dhMYNzUvqKtac+N2nnsFK4pSulquHVwjmUN0BHqxJ90GUZOLaMOlTs5ygN57kkgrC34xw/DCxNffsXR82wiyonn2rIGQiB5TpVp9hLKqYCP1ctX4YDgt0NhHtFlbHmTvwm4LoNpZ+Zeth4zm93omz2RI0q8T8cMyu5MNfhzhszxrKG5xZI/Chc6fuC/boWWHUrVkTZ7G3+VjRFE2n+ktAa0mlPmFOfBoTI4LiYD9BL29W2bN98Ul3Csk6wwFQsRzjrGEuK1FHNAk2f8Dv4m0aOiWzwR0cmZQakjsj+Z8B84ydBMcT4QXV4aRBJuq+hFVT+xq3mF3z+nT7xExlm51ovuclt5k5ijSekN23lyiEAGtrkcdQ3c1f08p8evj7OXDCPkX3doVCwNmEXGGCQmFAIibRvNLr/TERC1e+KH5K4NQYf8YkmIOQAmCPVNDAxHau8PO74ugQyiPShhO/PtZJTvqL8Rrpgokbod/6r8uh2OTPTYwcYvljpDNEnPskJR72sp6EFmOolGcsYw4EGOPdowb0hRRH0bvjLz+7m+VhEcwdy8hcpSwhmPFOc5LHZ8FwqaBMIIB1DeyuuNuPkDlHeT70DdYI8bsccXkstqgh05Rdd/bOFDHQoSa9jkPHABp2iYyZWex0IQ4NYXezqaDMrXpRipPSDdH2FW/w3ihCB9gmDQ1BXFQYdlhgDelUlBYdVSu3ZsLVT7BCRHXJ/uKK8x7gWmL1+Ik8FqD1FoEhOI6FTZcN8OKxo/jl23RQfZVZfvFGkzw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(451199018)(38100700002)(66574015)(36756003)(478600001)(5660300002)(41300700001)(86362001)(8936002)(6486002)(316002)(83380400001)(2906002)(31696002)(186003)(6512007)(44832011)(53546011)(84970400001)(6666004)(66946007)(31686004)(66476007)(8676002)(6506007)(2616005)(26005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lKp5HMZOJDSdaP0bzqbRmyCTWDWrNcplLH10F8MiqDWdZt0cspF1FS8c0y/l?=
 =?us-ascii?Q?OXkIv46C0FcBAsdvPSLBXR0+3QeKOE3f9s6zo8tEywkXqZ2WV4ciuVjNxnrR?=
 =?us-ascii?Q?nSkfv9DOLUWFSRcn0rKTC6MWJqYPzQCK4JE/+5Fp8Uqdmt4qTgIlaqYir4tE?=
 =?us-ascii?Q?VQ5qwWELMjA1VQLaMAdDaqsaYxkdRtL6NGRwQsuXxqrGDsakRPwbSDzSdUbR?=
 =?us-ascii?Q?MK3XVnNuZetDxSY4DQnuYxIx0otaYjKy5JrQp+/Q+w7iP7Oj7tvk3GY61J/y?=
 =?us-ascii?Q?yLRvPfWwWnjDOArUjD5kjm+azLiOlaGmP9HtzXIeoFdo/uwcFzwoy0/lKctH?=
 =?us-ascii?Q?DhYABFn3ts8yZupFrEQPmAYSydmT9KFa3fn3oKYVv3PJQu0Y7A3caCDkHgp6?=
 =?us-ascii?Q?9UP95JaGN22nKdSPzcvR5xkrTMmKFOmtBJB/yW85E+vjryqyw/YbltQKV+vY?=
 =?us-ascii?Q?U/GiSH47eK+0ENx9DKqbIHq6K9gX15RG7MI7A3mHaNBTmv3J1mwyyLGTOopa?=
 =?us-ascii?Q?TawTUjS+e92ajIpxEkU9+xIr63dgMqfu5VyI/ufWq4cAYAOIjNhjoDKhwizW?=
 =?us-ascii?Q?yq8nPpA8t35tJ+j/CQ+VSmLuRGs3yy5ndXgYY9dekVsJamuSWUUVc6t1sA+K?=
 =?us-ascii?Q?hUhht1m+sZB0vqbsCKbrJUGHOuvHHImy9NPeHutuC/cbr/f6TrJLFFdQ47j/?=
 =?us-ascii?Q?lEaK3gVKK929LWhsMAnnTzuYIR49Rq5w3oy64BIqn4kPZtm4jJ/S9iTZ1vGY?=
 =?us-ascii?Q?uvsjApOIs4OjPpaezkDDl83VSz2vvV2xm5OaXQoIx5IWHNcpSmGC+EeNLiSz?=
 =?us-ascii?Q?ozOH39XTZMW59cFIaCNv0FHHBVBKsgeebJuZCP8qpWcxQ97i+t0hMj1tUTzU?=
 =?us-ascii?Q?fcCkgi6VWvr+99cjOzQBqNqh+8COif8mPDRGwY2VOfXy6CyLQmv1ewLR2ZaS?=
 =?us-ascii?Q?EfRR/h0UkTd7hdVzyhIhrlSGoCglkru+JQx6ohXs0diAe2VjNkx4K626//oT?=
 =?us-ascii?Q?ZqQ7v5VveG/N4lxM+pFuAGlWB38gQjiAhfn4pHzkCmYbSw9pVAGgSH6IWvD8?=
 =?us-ascii?Q?B0ujylGujtN0id6Daml0MQU81xUBR73LJVctHz+IS7UQvOG65VSPoYhwmbpR?=
 =?us-ascii?Q?mRWZGNvTKwMPuZ68pR2ytzznxHiF5M/Z5VFkmZNHAy72keHy5xEwCuo5ONj7?=
 =?us-ascii?Q?wR7zi9oJAAXsOJgkusc2hOKHBqRVxfshHH0MXMI1HBcPL2WpYoVl2Dx+sa4J?=
 =?us-ascii?Q?mXy6bGDU2R9jACoD/37w4wR7E2sBeotF/3hi2DaMXy34IMe2bfp+kchH9GZh?=
 =?us-ascii?Q?h03Tg0jHe8ELGxEpPQX620VHhsaaynFgEwIQ8dinfVXcsrYGO09yICnk1llL?=
 =?us-ascii?Q?a4tHUugabY/6GzqM5lNRUxl4LPHpX57exHAjb+uEYxQC6etuufFq4aH03LQv?=
 =?us-ascii?Q?paY5qh7oaoa89VW30Jk09KDrBW87cGWcrn1Kyu87JuTpFeOgwM3mSsApsHVi?=
 =?us-ascii?Q?vBMuL9gZ6yGAcbloblTNBhhiKL6GS7FfRkz17upOO56dlAFGcekwpCavf0eW?=
 =?us-ascii?Q?1bQy2t5T8K3uPqpQ3PVWT1R+cvrv38Vr1ZRi/I2TTOLid9VtQsJJX9rbYBwU?=
 =?us-ascii?Q?c7MKCKdlximVOPj8oresYH8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db702fac-181e-425e-8218-08db08fcdab1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 11:17:09.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tco9QJSNYBe0nIsCJ47yOpFRv2KTeObOuAycLMX3ShNSjcYXJgoIj21Obc/JqGU1gl0zzx9BEF/0BSGSJu3HyghJXTxzEf2SOmAVMDS6+AMS8niI06twU3oqnMeKzDCA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9392
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 11:17:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14377

Hi Anders,

On 2/7/23 10:17, Anders J=C3=B8rgensen via lists.openembedded.org wrote:
>  From d08ab52c29cda8969b9f9e198d1ef2fd11d06ca4 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Anders=3D20J=3DC3=3DB8rgensen?=3D <anders.joergensen@ad=
vent.energy>
> Date: Wed, 1 Feb 2023 13:08:11 +0100
> Subject: [PATCH] fetch2: Add path control to BB_ALLOWED_NETWORKS
>=20
> Make it able to add path control to the allowed network, so e.g. it is on=
ly possible to access own repositories at a given host
>=20
> Eg.
> BB_ALLOWED_NETWORKS=3D"bitbucket.org/your_company"
> The fetcher will be able to download from bitbucket.org/your_company but =
not from bitbucket.org/other_company
>=20
> Signed-off-by: Anders Joergensen <anders.joergensen@advent.energy>
> ---
> .../bitbake-user-manual-ref-variables.xml=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++=
++
> lib/bb/fetch2/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 +++++++++++++++----
> lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++++++
> 3 files changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xm=
l b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
> index 66d8f844e..b0c129000 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml

This file does not exist since Gatesgarth and Dunfell 3.1.5, please=20
develop and test on top of the master branch when submitting patches.

(But thanks for updating the docs at the same time a feature is added,=20
much appreciated)

Cheers,
Quentin

