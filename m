Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8876C4829D
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 21:16:17 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.60])
 by mx.groups.io with SMTP id smtpd.web10.1443.1707426971052990970
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 13:16:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=mwgw340j;
 spf=pass (domain: axis.com, ip: 40.107.21.60, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYmya0Ja5/GokESlVgl3Lu1kdwXs91HYbLJoBSRKgm0i96/aalKtgnguAUL+Bto+8A0/kRqBbliF78jwq7s5rFYAVEI1eUlg8i3fCq5rvna9PwGq0CNHtCiZrvhMqsUHj3+A5L8FekY35yO5hpVTK6+Pe6Z5jXXqPci6ZbKtqaCEmm2WZzzeyVaDHtOofPCaX9+CBcUDtyBmZmzUbdzE/eP5tIGIWxj/7aZrMbAVN6oOkcl6mtun8s70SbavH4FCBr3qWaCkZ7gGO1qzstIol4Uyf9cGYxWwIij68WagYfORPIi9yBd7LG7oJa3cvGn5WbOgiARJLmhCyabWlYcvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZt2CuluaQYB5gdSNHeFqwnzg7tfGDnLUq0TbdLuQdo=;
 b=XxpsSZMqPhNmo6hf5jvxN04qlIp1oABakbwabc/NZpASiby+46s9IogQSVH68fAWUyyiQs0+94tTAZupS3bsu9x9sylExBgi60MHP2C+QK1qBEUoWkhXMxoXFCIB5Ob5yqBzk4C8voaSETlhBosgZOd605UnN5mS11VYbHcu6kKgSHW9kyOhvSo8sOXSGDN/M+wGvCdpwIiw/jMrkybMtj9vjHW9sDincUUTbmu1bj+grrDU9RSuH+1y+ktaxKiITgtXWP2UZt3/oyR4uKNqbiXvZ++57ahzcAsO55373/GhYwTFPNGWCcoUkptSzpyrTVUt/7/Imx5nB+tpw/WpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZt2CuluaQYB5gdSNHeFqwnzg7tfGDnLUq0TbdLuQdo=;
 b=mwgw340jpGf1EqEd2z4Hyz1s7evO4nksI1OVfJfWsdgBHI+s3VkgSvDd1tAreM9W2OgzI0waP/TrFrjAnev8nP4tZ4LCJZI0N3aVa7kC93qMkovv1J7bnrkuXHiGA1KDEfCNDJpLoFb1QEEU/VzzVZNYi18InSbgtlQu9vSen5A=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS8PR02MB8589.eurprd02.prod.outlook.com (2603:10a6:20b:54a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 21:16:07 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906%2]) with mapi id 15.20.7249.027; Thu, 8 Feb 2024
 21:16:07 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"enrico.scholz@sigma-chemnitz.de" <enrico.scholz@sigma-chemnitz.de>, Saul
 Wold <sgw@bigsur.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>, "randy.macleod@windriver.com"
	<randy.macleod@windriver.com>
Subject: RE: [bitbake-devel] Underscore vs Dash in bbclass filenames
Thread-Topic: [bitbake-devel] Underscore vs Dash in bbclass filenames
Thread-Index: AQHaWhQVFSjnyQI4zEOiQKq2vc717LEAle/+gABLVLCAABD2IA==
Date: Thu, 8 Feb 2024 21:16:07 +0000
Message-ID: 
 <DB5PR02MB10213640DC0E0573DB9445CAFEF442@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
 <lya5obge3c.fsf@ensc-pc.intern.sigma-chemnitz.de>
 <17B1FF6690DC06E7.12768@lists.openembedded.org>
In-Reply-To: <17B1FF6690DC06E7.12768@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS8PR02MB8589:EE_
x-ms-office365-filtering-correlation-id: 82de2d9f-4df8-4c62-e434-08dc28eb2a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YpMzAoG+urVmAvF07wbVgszCKJVl08YFYkXjE+Pxgsw0Q5kTcyCk3RnlPTPfCI7QmpFRRs/hSTNsKMeawWYP1l/Ufy/ArQIxiZQNRiS8el1gpAMk2bWLzmyw/U7jMBK2X4JL8rPwxGm9qg7cl/YG/8NiMyuTrrv4HylutKoUvY2QAZkuhNF/mVrDVTRa9TNnpyMqGA7Ov6YwtAT5ORofjHwEs4NU1BWC53l6kqA2cbCNf7ToWuMMQFxhqJmslVuaz6dHKeT+Z9FwcmFiDoYOe1Cuyu2tBU3ZOzARkpJvDqMSGDLzo2Cy463AofKYOkaKarUVjt99y/F1s+c0dDUz/8hb79m7BK8Ocr+46beKDqTmWgGJ4B7/och30i4uQi9uTFPKu7krD8LDSbYeRA/qlS297NRNwGNTPOVMmhBjo+Gtem3L0DyhhiwEhZkezyCvO9/vmkIch+r+4z5qccO12DA8h0OUxwKrh7m8GkWmFGtsMrYPRTJ080Wv7Oa0uXdVO3tf34OxF6p4iQvxw7jhjiCFxXDSnV6pdsA8Vw5DGldBOgPZ0A3k6eczDvmVqdrIDu1Jd9cBWx+/Ji6uEdAxb4CNmUtJ1Dpd9CXVfvv9+xGOMQAl2+ilS3VJUlS3ux3C
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(55016003)(71200400001)(86362001)(122000001)(83380400001)(26005)(41300700001)(5660300002)(4326008)(53546011)(33656002)(52536014)(9686003)(8936002)(6506007)(7696005)(44832011)(8676002)(64756008)(76116006)(66446008)(66556008)(110136005)(66946007)(38070700009)(2906002)(316002)(66476007)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?F4RDN4R67B4wTO7X6ZZBxEYhnSzHlpVs7yPGAKojMCwwgNbQfrE0tRUX15rx?=
 =?us-ascii?Q?sijfJdHz+G4FAf6OSW4smzclhTlH1Rp8ajOhrvEiO5f196MBdp3ReFmFyUZ7?=
 =?us-ascii?Q?Q9BfPusNiA8nm873zxtPBNRvXCg7fp1ejVCg+b5BYk8RA5nfx2po7SApseH0?=
 =?us-ascii?Q?gxvR850CaBF1tAahs3y9+ydVryka7GF0VQWud3QKmrAvdAPNKMb+6MCO8KEY?=
 =?us-ascii?Q?9yruxM6wIW2Dazx0PggAQvhVkwEno7vzpUjpHyPUkyl8uZt3f7l6ZTUvCv8S?=
 =?us-ascii?Q?dShBXdNij1C34A91ZLBpr3NKi4TiZjOVl86zvpymQlPj+8LN6ARtPzRnyzrS?=
 =?us-ascii?Q?OGpaYw+gTKZI1i5gtZdvH6nlIGKY5bXhdHfQkZcOKHL8kmxmxoNssFNrEk3O?=
 =?us-ascii?Q?dJMaIa5jOKq2W3uE0+lrX+gF6tjimzTlbb7x5tS5To2RjCWVmpqmDJevFqTz?=
 =?us-ascii?Q?3+ANXfYc0hsFdUe+WGAWofKNMq8AeroqjFs5fyV5HZM/EjUFoXigBC1a3iVS?=
 =?us-ascii?Q?4uQ5slDHTLxdZRcCq6WQSBy0OTSm1uAqD61MdcwOTSa6an4fzJWjMOL8oTlo?=
 =?us-ascii?Q?EJWC2utXNDZSbxUIUieLD1pbJ3OctXeuxfrO/fxELR+Jk1yh75HQn8bcgd7A?=
 =?us-ascii?Q?vY4WQENsVMI96aBObhsl2mLTladQmtKJltwrMdI7Mz6+Akqz5cXm7a51QkB0?=
 =?us-ascii?Q?lGkMy+U0Hu/0ZXVjAevyL7xa43vVc6c8Quxr0qH0RJIxzuQi7PzbUa4s8/11?=
 =?us-ascii?Q?ZkFCDc1sbAyY+B8p8PpnCWajdAW1sQVmchajvuWNpiolMQ1A8t4USFHLckn2?=
 =?us-ascii?Q?P7Kqc5fs1KjWW6gTQS4PBL6jPXMAg08uyxrDA4670/oohmh/IJ4LjEWwXCJ0?=
 =?us-ascii?Q?ebil/M9QJw42USFT8/sXafcho+SNYkGTzdmWNA8GXG/CS5ExOdg9ZYn3SAYU?=
 =?us-ascii?Q?jzk6hjNvATUqt715rrCtVkErLXuJyBJ88pkd9bISHmDQEtBkl+WbsC3XxbYL?=
 =?us-ascii?Q?C2QqE2RVWA06nwIrWSB4WLPQMCkGbVoDQyxAy5dKpinznp++ptaObDOMOs2l?=
 =?us-ascii?Q?XfXeMWV44Leuqe+tLFXuNwZqQkhmPOIJ8XhL+rrxQAa2LGBDBM/d+lvdANqs?=
 =?us-ascii?Q?d9Iphkb8tzswWz7dbSq3gq6XxQfLm7T+QAtqqs5Vf4oZg5tY+JYAPrJdUnWp?=
 =?us-ascii?Q?+P8bdSyhtMbvyDdF+QiZONhZoFrbMsvFE3NMoGzka4AmyCDajDpRJ3xwWeeU?=
 =?us-ascii?Q?qbx+Dom0VvzhQZ+Fc41CT1RebSchifQ3J4T+gf3EaX2qskG0yTKuas2fWWJa?=
 =?us-ascii?Q?wa7ik9RlG7UU15lDBwVqCLr2IK9VcPbja2z03qvadaahs8rTAAzXPnD09tlb?=
 =?us-ascii?Q?UlvaXhHO8WfsfOTiG1baVEtRkmLD+XIxVRb47XAur36phUGnn+YBqvsKGPxq?=
 =?us-ascii?Q?ioPzm6p0ipvroSssqdYI2jndIvynjj0zVKqmRtoXMRL6xbbnluzj2NLYSTLO?=
 =?us-ascii?Q?lK/By7QZi2wYAFc1ZODR4lP/ZSo9rIAdcErOPTBXqzgSgu2trUf4HH4YnUms?=
 =?us-ascii?Q?brbIv6vndIwLKAaObcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82de2d9f-4df8-4c62-e434-08dc28eb2a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 21:16:07.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ByIPwhaRW0D+jjwRO5lyPbMnYmbFnqopXm8GRBGEC3CES+Tovwk7b8bA77EKr8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8589
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 21:16:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15846

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 8 februari 2024 22:09
> To: enrico.scholz@sigma-chemnitz.de; Saul Wold <sgw@bigsur.com>
> Cc: bitbake-devel@lists.openembedded.org;
> richard.purdie@linuxfoundation.org; randy.macleod@windriver.com
> Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames
>=20
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Enrico Scholz via
> > lists.openembedded.org
> > Sent: den 8 februari 2024 16:39
> > To: Saul Wold <sgw@bigsur.com>
> > Cc: bitbake-devel@lists.openembedded.org;
> > richard.purdie@linuxfoundation.org; randy.macleod@windriver.com
> > Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames
> >
> > "Saul Wold" <sgw@bigsur.com> writes:
> >
> > > I was looking into Bug 14235 [0] and had initial patch based on
> > > Randy's original recommendation of using dash (-) which was a basic
> > > python/tinfoil script to check existing bbclasses in the BBPATH.
> >
> > why not make it like rust and replace '-' by '_' when generating
> > symbols?
> >
> > Enrico
>=20
> Taken alone that would open up for problems in case there is both a
> foo_bar.bbclass and a foo-bar.bbclass (which is kind of ridiculous, but
> it is at least a theoretical problem). However, if you combine it with
> the rule that classes should only use dashes in their names, then it
> should work.
>=20
> Actually, if we want bbclass names to only use dashes, what I would
> suggest (and this may sound odd to some given the recent discussion on=20
> breaking changes that I have been involved in on the=20
> openembedded-architecture list) would be to change the bitbake syntax=20
> to only allow alphanumeric characters and dashes in bbclass names. This=20
> may sound like a huge breaking change, but it actually isn't. As long=20
> as Enrico's suggestion is implemented, it is then just to change all=20
> class names in OE Core, meta-openembedded, etc. Yes, this will break=20
> other layers, but changing them is trivial. And if one has layers that=20
> need to work both with nanbield and master for a transition period (like
> we would have), it is easy to just add some oneliner wrapper classes in
> one of one's own layers for the new names that inherit the old classes.
>=20
> At least I find that a lot more appealing than adding some check script
> with a lot of hardcoded exceptions for the currently existing classes.
>=20
> I realize it is probably too late to do something like this for Scarthgap=
,
> but I think it should be considered for Scarthgap's successor (what ever
> it will be called).
>=20
> //Peter

I forgot to say that regardless of whether the syntax is changed or not,=20
I would really like to see Enrico's suggestion implemented for Scarthgap.
That would make it a lot easier to transition to the new naming of=20
bbclasses even if the new naming policy isn't a hard rule in Scarthgap.

//Peter


