Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D63C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 15:44:37 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.93])
 by mx.groups.io with SMTP id smtpd.web10.66107.1707147865869028737
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Feb 2024 07:44:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=UkBKRlN7;
 spf=pass (domain: axis.com, ip: 40.107.21.93, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwJ8Iitl9D7G+b+0gdA8EWxEX+O+e1/5tN8+q1nNuhwKnD7f0MrO5o5kwx4kxXz5SKnNn2eNpN8ZvjbNHWZy14SAhjLMjFwPiaCoXlWD56yuZHNqlp/vQYc8dRGMISCWJnpsHvJFxUz8fWez6hfMxXB9bCIzXAiQBbU4anXa4ff7d8xM0+wBGhR5TD6xneczzd2ZF82Lcv14hpsrgZUSL0Qz57+W9l5IxPNai0zDhAdNlAbIfZW4iC6Gj5IDhSRwGh/C1CBKaVG2ntIPVB+rPLBOXOLKenjluCk80hjafZ8Ff1WY63kTaXMoSdHQBrGKZ5/iXUWyQR7nSgIB7fsCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/BpxVgh6Dzt0BDUVal68l12f4jCifOvxPhQAMyk+ng=;
 b=jbicmRUmfPawFzTLI84auIvooD5Wo+LWWyhB7NCQ6xvXAVbITCsI8SDYT5xiSqC6+GPLdXv0a2jFkee9StDIXGxQkL5ZaY+V4o2qQPSARzBX3WIR7UIz8fIvTUOM04zSWs7KaaAibdNQciqrJ3wwJczIHjm7WC8UmCxCBmmIcFJs3CDQkYf1J4xOWBefmkW6gCbzy6Bz57pEru4MYv8Nrx99VIU4wOUcu8qXdi+YcphApPXr8lKS20NtUImb84xUitptb2LcRxeggmse7wKHTtG7gCNZEwFJI7WwPJTG1kVlH8tOxLX2yBrSBpI9YztSW331UmWXjEPr0H5+prgbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/BpxVgh6Dzt0BDUVal68l12f4jCifOvxPhQAMyk+ng=;
 b=UkBKRlN7Hmq6CGNEZi8BTdOE09B9bnqjcD3W8vuBiR/jezffIJKYrPoFgEMf6wnAN+O+2AuYCmglc/T/nZb3cmHDUeWXQHkoLMTf4wfMz97s4Qz+1iz2EinFvyVpL3Lvqdkvt4q/QymdnzLh+jl+wI9GROS1Tx6i/K5rnaQgYsA=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PA4PR02MB7005.eurprd02.prod.outlook.com (2603:10a6:102:101::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 15:44:21 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906%2]) with mapi id 15.20.7249.027; Mon, 5 Feb 2024
 15:44:21 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "joe.slater@windriver.com" <joe.slater@windriver.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "randy.macleod@windriver.com" <randy.macleod@windriver.com>
Subject: RE: [bitbake-devel] [v2][bitbake][PATCH 1/1] utils.py: add
 var_in_numeric_range()
Thread-Topic: [bitbake-devel] [v2][bitbake][PATCH 1/1] utils.py: add
 var_in_numeric_range()
Thread-Index: AQHaU8f/Ej33LW3fKUuQhtBJTUpXQrD74BMQ
Date: Mon, 5 Feb 2024 15:44:21 +0000
Message-ID: 
 <DB5PR02MB10213F886903D7557413ABCA7EF472@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240130220213.3124647-1-joe.slater@windriver.com>
In-Reply-To: <20240130220213.3124647-1-joe.slater@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PA4PR02MB7005:EE_
x-ms-office365-filtering-correlation-id: 4e583dc3-1d20-4948-769d-08dc26615284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MNl6XDbKn6d0qOgHeb+fRPR2Y+sgYTmmM+vDSDcFmi80mMT8mfarHjFPZABuS7TZJnqKKe1HlrudIWZufWLVWU0jFrkFaQbv++AoCVUH/D3hjPUwAEUu+RXlzq33bcNIIuBu4RTiWXTh0CMHEZyGLaNA/i0dleVKNEygAho1uobn/yu+zZk07zS5nyIRYtVMhDEhoBLl44l5co7rlAubPrjvDRXEd1bhANRFFcMSWJwBiVo4JxQU2h+qe6oyWB4WVWJGMI7C6LskLoaKg0rSSfWUUMrvbA+uHXnLeZ5sb0OTqd5ZPkfhbnSqHLx9L6OFuI7K4T70ZDypWaU6fPApPBJoLgchrkqlKiM/2zcQcyDrfAHEcdMEYzYu2ZyWHJ2xr8vwcCuUn1HZ61IsQ0Yk1UVZ4Jmq8c3tve+JdrhaUdr7VPuL0YjCtEO2/OdFhwDU2jZvelYEa3zs/3sEqdyULQ4kbfUId31R5mYj7RekKwhwfXJA5w0VFpdf5gUfWHlJkNpL53P96HVjQiSiPH5lF6H2hAh+RFSdMbnMgI8AnVllC1qNC0mI2Yo+s6yPUCFSW+KU/wnEXAeuLbuQKoS/rvjrq85OX1BY1Bo8V0y48x3pN9YVBlw1m+X4rx3XUpXB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(83380400001)(38100700002)(8936002)(4326008)(122000001)(8676002)(316002)(478600001)(66476007)(66946007)(64756008)(66446008)(66556008)(52536014)(110136005)(76116006)(71200400001)(26005)(2906002)(7696005)(44832011)(9686003)(53546011)(6506007)(38070700009)(41300700001)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jpeSGTvQ7aiR8R2UB1FmKg4nYVXWn99PcAomkyrJIxGdj2/dh5LZgKcNwqnt?=
 =?us-ascii?Q?6qr9hwRzDCl090GVMJp6xmmxc/CKSDS5SeSsS/fCi8NKnWuJlgwUW2Q/teyA?=
 =?us-ascii?Q?qcVOtZZn1PL92VxG18yy49LYutNVOJUJ6tOrSWWV4XMZpZB0q56rj87BHtms?=
 =?us-ascii?Q?WM1x4b0m+7rr/4S8EfQHmQOvqXHqdwEK5fG/vgVZIX7hkX5IRpdTTibr7aF2?=
 =?us-ascii?Q?w1evfZukD5vp+n4LV2aEf+Sx/cLsr6ndgwYNHfzEaz86F6uGyv+igW3KuyFE?=
 =?us-ascii?Q?ES28P5q1Vu0UDxViQXkFVMxnvkw3/VQlX4uqi5U6EVHuZTAax3Lhg7fUS1qN?=
 =?us-ascii?Q?eMZSMUpo17n/sbaxuAW9iUeQFBRJvRubvN64COdmmJFKOSEHylzmSfzlKEN0?=
 =?us-ascii?Q?ziiRh5vKcEZ+lnWuYJXnpz6/kUby90ebL7InO5aAVTLWs5eucUqBVwkCJqSt?=
 =?us-ascii?Q?TtvkNH0/tGPob8HyTTJs+lUkP0BndT9Mf2oUEsFSnsmgENFt4k0F19VVse9h?=
 =?us-ascii?Q?/De8QyVbKAvWsRFYCeBqXpQYARvbs/aMNdFEXoATKeNQJS+FdYmPFAhZOQ87?=
 =?us-ascii?Q?tRIKti4pDyMr54VD51zZzD33/sUTUAnin2t+ib8GCuAmnGPvemt9ogTd2/Pt?=
 =?us-ascii?Q?T3LzrBBiMqlXNvY8fQJ2ljNmqJIzHvda2LbdA8Zg2cyGtGggrlabAOy0zAHd?=
 =?us-ascii?Q?IDULY65XU7xtbNJF18x6bIxhMQNCMpb++4mUdSlE3Xq8E0YXkPTjhTJUPHvA?=
 =?us-ascii?Q?NWxnggCz0uCqJ2FoPLqjifugTY5P1h2o1/24lPZRQwYKjsfppaE8+CDopjAk?=
 =?us-ascii?Q?ZJ5CV6HFqEIVlVO2lu/0SlXUaZ0V7v7xo2UXYG0ESQ359V5a7f+fJDls+1U5?=
 =?us-ascii?Q?6oHKCR19n44mQGm9PPctKsCiVQbOOioRZuz/HeWVp0jiidNtQRh3SeJxhAZC?=
 =?us-ascii?Q?QD2oBeRNK3tTs2QlSFvp/E0iLyUx5U7k2Z/qXZyAGRORC7Z/+dym60qZIwyn?=
 =?us-ascii?Q?FVIpsInfj5YIgtKGcyZ59CCLCfiqd5omw629dEqNirp2O6xg1vQLxHckLYwa?=
 =?us-ascii?Q?1ukRGNobkVNW1R5pYFfgIv0Sunex7NjpKPOSbGiv8ZbQ9LaziCM/4Tu8CU8V?=
 =?us-ascii?Q?Ileh8Ugfw5bwgNp5VZ6KpfGSy5R3kLyKzskme2sWd7Tv2j/25UZOR+cfelBT?=
 =?us-ascii?Q?SiJLyXzFXrMNWXmrp+9dWsUb50hit4YJkFdPFG07S5xpjYhxq+OtSUCnjFRI?=
 =?us-ascii?Q?KROoXBujr80CM4tBpb0ZuAUT+OLMnfg1ewc69W0kWDZj2Y62WPtDqf3HiC/X?=
 =?us-ascii?Q?mS9D+34kDq/YchhQeHMBH7OH3whFDKHNn+Aa0bQ4jKkmTjP5MY1gRhuE8iRx?=
 =?us-ascii?Q?jBTKKQsp8x43CgwyYzQe3rh08lX0bfGUb09/oXFTWMt9jIJPCsq1vSiDZzPs?=
 =?us-ascii?Q?yC9/NZjbTJFI6rdL3F+JpemBKWWzAqGuw/bU1dsl2DrtfHZriSR6A4x7/IQo?=
 =?us-ascii?Q?Hcns93J1cWqEAZzxRO0bNTtjW4TwNLkr4qvl1p1QPxRH81y5ZRhwteUFCYkJ?=
 =?us-ascii?Q?ZaPIcEiWM7IlLDQkjD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e583dc3-1d20-4948-769d-08dc26615284
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 15:44:21.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwAgKg59W81Wodb4W6GaUexsPu17/6rSuwSrTEMtfGfLy++YXhGI5JlMGG/Q28BE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7005
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 15:44:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15825

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Joe Slater via
> lists.openembedded.org
> Sent: den 30 januari 2024 23:02
> To: bitbake-devel@lists.openembedded.org
> Cc: joe.slater@windriver.com; randy.macleod@windriver.com
> Subject: [bitbake-devel] [v2][bitbake][PATCH 1/1] utils.py: add
> var_in_numeric_range()
>=20
> From: Joe Slater <joe.slater@windriver.com>
>=20
> Add a function returning a value based on whether a
> bitbake variable is in a numeric range.
>=20
> Signed-off-by: Joe Slater <joe.slater@windriver.com>
> ---
>  lib/bb/utils.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 068b631c9..8bb2d5d2d 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1810,6 +1810,17 @@ def is_local_uid(uid=3D''):
>                  return True
>      return False
>=20

It would make more sense to put this function after filter() so that it is=
=20
located together with the other similar functions?

> +def var_in_numeric_range(d, var, first=3D1, last=3D0, truevalue=3D"", fa=
lsevalue=3D""):
> +    """
> +    Return a value depending on whether a bitbake variable is in a numer=
ic
> +    range.  Conventionally, 0 as the end of the range matches all values=
.

You should use None to indicate no limit instead. That way you can do likew=
ise=20
for first so that it too can have no limit.

I would also recommend to better match the APIs for the existing functions,=
 e.g.:

def var_in_numeric_range(variable, first, last, truevalue, falsevalue, d):

or even:

def in_numeric_range(variable, first, last, truevalue, falsevalue, d):

since neither of contains(), contains_any() or filter() are prefixed with "=
var_".

> +    """
> +    try:
> +        v =3D int(d.getVar(var))
> +    except:
> +        return falsevalue

Since the function is named var_in_numeric_range rather than var_in_int_ran=
ge,=20
you should support any numeric ranges:

    try:
        var =3D int(d.getVar(variable))
        f =3D int(str(first)) if first is not None else None
        l =3D int(str(last)) if last is not None else None
    except ValueError:
        try:
            var =3D float(d.getVar(variable))
            f =3D float(str(first)) if first is not None else None
            l =3D float(str(last)) if last is not None else None
        except ValueError:
            return falsevalue

Using int(str(first)) above rather than int(first) makes sure that if first=
=20
and/or last are specified as decimal numbers, then all the calculations wil=
l=20
be using floats.

> +    return truevalue if v >=3D first and (v <=3D last or last =3D=3D 0) =
else falsevalue
> +
>  def mkstemp(suffix=3DNone, prefix=3DNone, dir=3DNone, text=3DFalse):
>      """
>      Generates a unique filename, independent of time.
> --
> 2.25.1

//Peter


