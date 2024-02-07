Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9EC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 19:40:20 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.66])
 by mx.groups.io with SMTP id smtpd.web11.7720.1707334809624499977
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Feb 2024 11:40:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=CX1cp3aO;
 spf=pass (domain: axis.com, ip: 40.107.241.66, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMCX0BFKdropOWS+7WjllznmxXG94Rom+B85hHQsXiA87/El1+MWLllKiD0yQR/WClx3lSVRpQqlhBrd0uCqzdHMR387rVNI8KTWgwjqCpLvgzqNqKVfbW/BOD3Ov48tOX2WAKVl4UTSr7mMg7fkkXSaFI3eJlCMwjyRILTU+k4HEbA29pa1r71pIqGrq1/PqTAnGD/t5HFi3tWnQn0KtvLmV2AcxnvIyQZ2pCr1C36r8Tz+PVNPvA99s0E9AhiEMlBxMjHqmB719+wipSHV+OxLPL87GVuKxotQ6bSzc35yxV+YBCR7s4Sr0F7w+u9jVv57iIwoFQXHWsPNIFalHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUzzfuyCDkJP36srfoE1oxk5SYX97AhuFqhXX8P87Ac=;
 b=dd15pd5/TehEHtP569TexuxIhndRlMvQR541iMi5gyWpYpMHo3jBM10f22bNCfhs/zmpTF1AMMwcv1f7w6KIXvoXoUrZGi9tZ83AO0LFjf7mWPqUyp8LieDRPwlrrVH5w1A1R3OAJVDsMlmkY6QGs4LqelRusV0+IL0idCOmiRAWu7NwO9dkdjuXmPDNrVZfrfLw1D1ahDKo7zmzo9A6o6ULHFIe3GJhP4gFstHnQGupSve69SfZ3C9bLzSZTb4pqB7t5jLUHUbjT3gA1RaGQpBFIAAWDkH0dWKDF9Kgb44/QbRenwgve9h8uw3KCYh07oAo7LvFa/DN1zL5JduLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUzzfuyCDkJP36srfoE1oxk5SYX97AhuFqhXX8P87Ac=;
 b=CX1cp3aOn/QzHSsAlY72J37ZHlv5VxbOOLzn71QUOi0hfTlHDCLyaOR+VYucDxdSWZW68M1VhUFO5atjN+cbP3qOge5A3WD5e/65i40RL/dnPMBmZc2CNdVhOHxoVV4JEyyU/IqcpkZdK5yh97icHVjl2YT1FIjLMzAOT5Ewnqc=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS1PR02MB8230.eurprd02.prod.outlook.com (2603:10a6:20b:471::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 19:40:05 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906%2]) with mapi id 15.20.7249.027; Wed, 7 Feb 2024
 19:40:05 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Ross Burton <ross.burton@arm.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake-layers: add show-machines command
Thread-Topic: [bitbake-devel] [PATCH] bitbake-layers: add show-machines
 command
Thread-Index: AQHaWeoYbsIpT7k35U2wSUDfGvNis7D/Q8SQ
Date: Wed, 7 Feb 2024 19:40:05 +0000
Message-ID: 
 <DB5PR02MB102133760C9A5E0D2C3B97C54EF452@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240207172121.4044574-1-ross.burton@arm.com>
In-Reply-To: <20240207172121.4044574-1-ross.burton@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS1PR02MB8230:EE_
x-ms-office365-filtering-correlation-id: 3cd3d53f-cfab-4c39-0c45-08dc281495c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 m0qbFp8NwJWlpXjAD/oohoBHpIgEo1iRz4VpLJKu1DpL7oXRvArigNCuov2wS/g5wTJoTmD7XaXI88sYxpxM8WC+3dEKC0sq3KjXcQMtI34+/JzFPvxVBFSDRAVTuybvSBsUB2MJqgxLCxhssnIBu0y+qfKSu52MGmaiUhXx8+WEJsPm+3SS4T5CRuNfkrj6ZewUg/NiJtCwtKE6fe8xD5lscTqiCqiUIWuDEBImReK0q6RDyFoeUB1arMJLqQ5kvaL6W8w1EsERamMUdQ3z9guve3gsOchzB/HZEA7F3+O6LwbB2WZCs3tFsMBCXSPTlhZCXZyq6ctIi5y/lLfWqOdiNiKx3mVnKuwu00Vc+xHsWV2S5AxchtYGd5MCBpQ+roqplx54wU8xbpkpWOc3JUf2wYjjv+56DHEI9wozMyIWnyg0qo9ui7uM6RvSrzAVMKvluWKHRQWZ4+FR/FbLPt7AsB522WCPFiDyv+YASo/qdqWLJQoK0+hOxI49hI0v2LyTNenhA0zRo9xItV1/p1HxZ4wU+wuB6fG0hBvxIvspRIyMolwGqihV0UgQFXo2d+o/RUVVpi04A4+1Spv0ltH5nx6kGB1FZ7/SqgRPiJz1S3QDeGxe/Q9RVjxEOMGO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(83380400001)(122000001)(8936002)(76116006)(8676002)(52536014)(66946007)(66556008)(66476007)(64756008)(110136005)(66446008)(316002)(44832011)(5660300002)(2906002)(9686003)(26005)(53546011)(71200400001)(7696005)(6506007)(478600001)(38070700009)(86362001)(33656002)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?nI6C3IifJfb2uku+FK1H76Juou83Bcc1aWMyEUvWDYXXwhSvUay02+4t49g4?=
 =?us-ascii?Q?Lq7+g0SF4JgmoE7ZJYAu8R1nW+E9vG9B9KeS23Tbbs8nhQorkDcvaMmHPvSM?=
 =?us-ascii?Q?qvcfuHn5MERYKoLv2h94Aaqk7nYRS/gtd8rI18i03WiMnmyCKhUhTFT4A0sm?=
 =?us-ascii?Q?YnJDfBopmmRZqHtBY1E4P4aZ+RXBSz8CoqBydaWugbF8ujzTPnpQ6TlGt48r?=
 =?us-ascii?Q?KOcckZIMptlCaexhxeuQt4/2g14mZl3BsmZPUk9dPSgPyyQeHSvoQ4DmRWt0?=
 =?us-ascii?Q?3Wtlvp35HoP3LJ7JRciFZc6z8KTWBd4+ya7Lq++uJ3Q4/dGLTc6UVdvECzue?=
 =?us-ascii?Q?rz4IhlEnES7pFjZ9hrs9lTTuw5/KZTvdmWQeEKomaXVuIp85ERa09UAyUchO?=
 =?us-ascii?Q?mlkAOmNbeQClvWPtuntlauvx3qju9RwGmJsssjF/65aQdKEHGgBMSa0tU1M+?=
 =?us-ascii?Q?nExPl9QY27f4C/R7NIUC3splx7bt4BDW2AJFiGya2/WJuER5OvEncNVf83Ra?=
 =?us-ascii?Q?fGMA0EtuuBNTiIKvRgUV4WJV8PEe2bEJou6KXfEVtep03eWaJOLMecnsEPJ3?=
 =?us-ascii?Q?bZTMPJWfUmQVHVl3yLyaSU9ZNU/ShbreLAfIblb1YvkB/KJ4wq5QDqd1Ywmr?=
 =?us-ascii?Q?hRFqiFBowd8Wdiv9wA4kt2aEbtYQjTIZOeWWjCBcjI7yI/5sZ9ohWacBOBpp?=
 =?us-ascii?Q?qHVvvKYa4KWKA42h161xdC66IXa3JZod9IKMNeMK1GVgJXDuiNux5DnpXKME?=
 =?us-ascii?Q?So+aVjD15f4P+fGtv3zXJNAXJnFl+Mi/JQsO9oX6mVqhuNAg1YbPlK/Nmt9m?=
 =?us-ascii?Q?ZwtOC24u2jZgr/Dhah4oildOrLXjcbHam/WSErEGiOYNOxXxidzSFt606/Ce?=
 =?us-ascii?Q?NNIBYxLX6nJQCdVAwvre1IXLofjJbC46EDaOGbrmBlEe9GVO/01J+pfs+YPu?=
 =?us-ascii?Q?sKx7RRizU/pKpQqSjFPFdaSObxmz/JAm5xzYrF/fE0S0q2H0s6xcnuPIBp75?=
 =?us-ascii?Q?2SkTsIIqxsmOU32tKXYPPu41StrgiI44MliE8ax8X1Y1lriFX71PxlZIxEFA?=
 =?us-ascii?Q?7/B2vfYy7QVgK7qeblIvYMMcmQHSVeMeR0gfnmx4vC1OX4aish48i7NF8bww?=
 =?us-ascii?Q?0Knz2h20l47eKQxSke39uwNpR1PUjxcczffqueptmu1wj1eLqS69Isujq7Ie?=
 =?us-ascii?Q?s5/RAjKuEjcoOKkwyPNKamaEjIrrZm2ksixGca3u+gL6QesVQhJ5Wc7lka7i?=
 =?us-ascii?Q?ygenvx3ci+dyNOX+7pETJV7ynA5t2NgcfbeymcFOyfHrOcAuLnhUz+jBicFN?=
 =?us-ascii?Q?HdQsQh9PCdQCS1zYMh7PbqVMsi85hjlXa2g/PniYYzVMAzdpF4uGPa8JtUkA?=
 =?us-ascii?Q?yD5RlYKJEcp9Ck0Hsh5hHwPvIgFFZnIC5XRraKH7nU3Clh2hln/qs94V514M?=
 =?us-ascii?Q?+BY2cQjSh0/XoYb1nIgphEIXRJMaSce8+DLaGlsxv9RxRFKHxAK55be33awd?=
 =?us-ascii?Q?tsuh3wELDgMwG2/iTjyscFTR4yGQMfRLHOjCJMWruSCWVyd4a3EVd415JbG6?=
 =?us-ascii?Q?iuM/w2WAgS/yZq7by0k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd3d53f-cfab-4c39-0c45-08dc281495c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 19:40:05.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE6w90TmW0WTWl3zNdUki+yjJJQFO4HUXIq1TWLOkoB0ARnsFHtESMh/HwSFCjak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8230
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 19:40:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15834

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Ross Burton
> Sent: den 7 februari 2024 18:21
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bitbake-layers: add show-machines comman=
d
>=20
> From: Ross Burton <ross.burton@arm.com>
>=20
> Add a show-machines command to list all of the available machines in the
> currently configured layers.
>=20
> By default it includes the layer name, but for machine-readable uses
> this can be hidden by passing --bare.
>=20
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  bitbake/lib/bblayers/query.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.p=
y
> index bfc18a75939..3080763abfd 100644
> --- a/bitbake/lib/bblayers/query.py
> +++ b/bitbake/lib/bblayers/query.py
> @@ -10,6 +10,7 @@ import logging
>  import sys
>  import os
>  import re
> +import pathlib
>=20
>  import bb.utils
>=20
> @@ -515,6 +516,19 @@ NOTE: .bbappend files can impact the dependencies.
>=20
>              logger.plain("%s %s %s" % (f, keyword, best_realfn))
>=20
> +    def do_show_machines(self, args):
> +        """List the machines available in the currently configured layer=
s."""
> +
> +        for layer_dir in self.bblayers:
> +            layer_name =3D self.get_layer_name(layer_dir)
> +
> +            for p in sorted(pathlib.Path(layer_dir).glob("conf/machine/*=
.conf")):
> +                if args.bare:
> +                    logger.plain("%s" % (p.stem))
> +                else:
> +                    logger.plain("%s (%s)" % (p.stem, layer_name))

If --bare is specified, then the machines should be sorted over the whole l=
ist.
Otherwise the output will seem random. And the same is probably true also w=
hen=20
--bare is not specified, since the layer name is in the second position.=20
You might also want to format the output in columns to make it easier to re=
ad.

And one more, if the same machine is available from multiple layers, should=
 the=20
output include them all (when --bare is not specified), or just the one tha=
t will=20
actually be used?

> +
> +
>      def register_commands(self, sp):
>          self.add_command(sp, 'show-layers', self.do_show_layers, parsere=
cipes=3DFalse)
>=20
> @@ -540,3 +554,6 @@ NOTE: .bbappend files can impact the dependencies.
>          parser_show_cross_depends =3D self.add_command(sp, 'show-cross-d=
epends', self.do_show_cross_depends)
>          parser_show_cross_depends.add_argument('-f', '--filenames', help=
=3D'show full file path', action=3D'store_true')
>          parser_show_cross_depends.add_argument('-i', '--ignore', help=3D=
'ignore dependencies on items in the specified layer(s) (split multiple lay=
er names with commas, no spaces)', metavar=3D'LAYERNAME')
> +
> +        parser_show_machines =3D self.add_command(sp, "show-machines", s=
elf.do_show_machines)
> +        parser_show_machines.add_argument('-b', '--bare', help=3D'output=
 just the machine names, not the source layer', action=3D'store_true')
> --
> 2.34.1

//Peter

