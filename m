Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2EACE7A88
	for <webhook@archiver.kernel.org>; Sat, 23 Sep 2023 08:29:15 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.82])
 by mx.groups.io with SMTP id smtpd.web10.16995.1695457749419241130
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 23 Sep 2023 01:29:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=DW02Hheu;
 spf=pass (domain: axis.com, ip: 40.107.8.82, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+4778Z1m9QA3SKnp/6ZISKosxCFI8anAW3CP5dBMkb8l/huNDJIHCBfX/sOkFuZq/DbFWz7kjHaGYpSrwmf2KmKVb870iX+QF2iwFzJMA1ZLcM9UIARJFaEpV7tVEN0LfHB96e5vdgVVBsX/7jIh1TWpBH2zNjrF3XILdTB/VPgqGcW7Nd063XxLvuhC4GWFny5erhjdBSF0PWfJVloxmK7rmGf1LQA4BsEG3l4J0gC+ffDPZ0uwxw5g2Qw4tkaBYRGeOMUmQrcoHcy/S+yFB16aWOuQA0ELEdm2k9eiTofeeO9NEaRncsmLVmDG6c7TcD1BGReh2eEg/NVBLZxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlghlHIeSRva1VwLqoht6KZSGktkZBEdogaJ2/OSmcI=;
 b=E6SR1Ln+XFl/xo/fdXYIz0Ag8B9dk4tQvEnNwX9wM2YxuDg3Vcr+bgY41rBBLVrRxhHjbneJu7w9tcamEYn4JD9NMLe1bioa5WXsV5F9n+0glQ69YPjQJHs1w9Tjlz8OizPvRvI6qeQWLKJbtgor89LtxyQMidxoRnm5fURs1E2s/MO2GOlg3M5695wUaNLYewiYS1jgfGeE33PGSonnaf3X0z1KgAhSizSF8Js4tKXZs3NIfy7afJNSYzV2EYoZhqnDor/rNdziEq6yhohQu8N54U3oXZcerhTJd4Pm2D5FvSln1BQR2aVRybQoeMPGxNNwg8Iqm+oqU8wvNJgGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlghlHIeSRva1VwLqoht6KZSGktkZBEdogaJ2/OSmcI=;
 b=DW02HheuJ7+PIsbnenekomi/eiFNnwmnlzJpkuKeBQunA5BP5CpCd1Tt8cXdSlrkGl/dnWSNiDKILFLAhD9pZUpkZBqb+jmc3+cgII/OlpEGzlZAxR/t6oOMTAneFA0RpZYN46aE6DiJPFpLQF1orxovkwVpbft+qB2HeLtrkh0=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by VI1PR02MB5983.eurprd02.prod.outlook.com (2603:10a6:800:187::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 08:29:05 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861%4]) with mapi id 15.20.6813.018; Sat, 23 Sep 2023
 08:29:05 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake-getvar: Make --value imply
 --quiet
Thread-Topic: [bitbake-devel] [PATCH] bitbake-getvar: Make --value imply
 --quiet
Thread-Index: AQHZ7dEhH1BH5UIqXUqZbsk7vV+FVbAoEsuQ
Date: Sat, 23 Sep 2023 08:29:04 +0000
Message-ID: 
 <DB5PR02MB102139FA77830DCB699348789EFFEA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <17876AA394C6FFFE.21225@lists.openembedded.org>
In-Reply-To: <17876AA394C6FFFE.21225@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|VI1PR02MB5983:EE_
x-ms-office365-filtering-correlation-id: 93451ee3-3f39-4e92-0885-08dbbc0f25f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pPHrPIjphVSwXn7VZljiUEO/DcWZtx5tjejimALTSlduqYCAI+E4lrzLOaXdXMx+g3aYO9OmOgz4JmU4sBi6+I5boW/D43BKNIWPwxcFsEwOga84/P03be09YTUhmqV+hDEbdxIgu1rXz2oxw7ylSms24dvnEPCC/e7wkObHKnFCVSen5kZu7y7GRZKzXc0Ps1cnwiW5w8Eqx55WePfn+1YVJvUx291JmxIIeQWSe+hgGakS2iNcHf5myaeFEPIuEjo4JlZlieMXy6Nrihl8S9zAfBZqArYdlcmJEtkogRWtBXYu70NQwg5XHOyq6jFfL7p7+ldes7dnP+gPRjscHKwDYFa0d3FaFY6GDua98t8CQ0uUGeAt+XM/2o8F1fcPKdmH+1EgXdHR9hGWzWNvosCYvZ25+XZlkQWQ22yTBYao6Wsw8qsSnUQrcCeMdaZZZRRNb6ivFZBh6kx1BxgRUVzoTO3SjYt9WtXNFkdNsA62hqB3U0WbR5D8DGcwJpXjMbP1cwXfW7aVe3nBtsy2lh2Sh2LAQQJplMkSk40GIARSZw6znZEMDsIBQzw6aCTfyFW5IRONfXRkWS9/ZTa31HzMFUkm0LoGeKWcCrwmwxi/q4l2p3KVoKcFVsO137Ii
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(26005)(53546011)(7696005)(9686003)(38100700002)(38070700005)(55016003)(122000001)(33656002)(86362001)(83380400001)(66556008)(66946007)(66476007)(76116006)(8936002)(6916009)(8676002)(5660300002)(52536014)(316002)(66446008)(64756008)(41300700001)(44832011)(2906002)(71200400001)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3jokMRpnJoEWH/JsJPUajtIk3SdgItTaHfImjC5t4gmmE9ZmTaxdHGWfLWow?=
 =?us-ascii?Q?ZCgokjUeXJkcA4N/Kw362cY/7tBYDALoWQ8PJLOuNeI6vqiAx1flqKVqLWcn?=
 =?us-ascii?Q?QmMIfc1Uh0rGQN9MRVjziVSj07TMpN58GlcnS7lAAfLOONuLG9vbT3j861zp?=
 =?us-ascii?Q?vkS0cJkKhBPBrtXRzSaONIeF6qjBdVUECWr87Fs2BHJAnIFuwUZgB6zRQWFc?=
 =?us-ascii?Q?Z82zfhNmiEnPw74n8MimLBnLqEAF1gt1TSrq0ueU6t8E5097mAgHY76UK20X?=
 =?us-ascii?Q?5hXAI78FmicLdrGq6TxHVp1LYYjo2VSs1IF93vGSKjMw5+b9VFIuX0GfamNT?=
 =?us-ascii?Q?pzvZ68MVOfMoOfteSiXuvyABuCzrfA8bq/57a8wp8W/Mna3epPuniWo30azX?=
 =?us-ascii?Q?qg8QU+d6Y7QLeBY+RGj5yax0DniJOWIX2SG5amWCKJUiXAkFDgE3vGe6HgCz?=
 =?us-ascii?Q?Zs7B22U95kFtyyojk8KfnB3LnUTkOgw12FXyCb5midnBZoV3xO2zFuslyhAC?=
 =?us-ascii?Q?oqzhkJLQ1VqrcpOlCnLZhpMIPzMc5DYCxWT/dNFIcbiXMkLao821XC6cY8mI?=
 =?us-ascii?Q?mdZ3mMAZKV1TpAs/iPS4Ad0b1zbvG2I49rVmJGCe38fzObrnOc6+qns5avOq?=
 =?us-ascii?Q?xew5BERnyGoDRii3Pu7oO3rGMLFLB1QJJMo89Q2vwtSV6ERvjud6hTOAxhcu?=
 =?us-ascii?Q?jds3mHFLYZ15FUDtY7LP0yWsJ3h9bVAdJ4u3b8wb/S+yCvxOuGrOs3Y+Xc6M?=
 =?us-ascii?Q?IEqwIpzrIijH90h3oomt0MvU3vIoJDyaRpZre7zsWLZN9h5vPdpd/wYD0/WY?=
 =?us-ascii?Q?ol0H468u2fBup0+N/vaRFL+IniLuzNXo2VHb8p5++XBPrr7b9D59C+k6xQI/?=
 =?us-ascii?Q?kMl7fiZbYOV9G2tAMeEkx87Ul0HKIXa78iqgmAsO7pA7ZWWFs5jTgqD5HHi/?=
 =?us-ascii?Q?4qAKT9BMac0LXBTo9QdlStRCobZaof7ThOZFL9gLcCZ17I1uBcxvrWUDoCPW?=
 =?us-ascii?Q?MDTKAn8al7lQrOPIAWv8mlccpNZInpBBw389SlfYsR1r8j8ILwmVKA/daCRV?=
 =?us-ascii?Q?xruU4hA3NJIFIXvb+z4Cof6K99DFjjD1DLAyrTurxIRc7legJJDBBoAbclW+?=
 =?us-ascii?Q?K+qQ/BVioWe2u3bGFww7hf2maLmuVRHWzrp+ylKpWEGbYabazWx0j448UlF8?=
 =?us-ascii?Q?C3kPqw+PsnVCE4NUvs/c+J/Go32zV4orcyov9Zh/xz3cYbR3veQRPxq/8Dxt?=
 =?us-ascii?Q?vmoNWTKd7SiK6jGYMBY77Dtfy0X1WnlIsOkWCr4g31XtMtUs3Ev96pePQiL6?=
 =?us-ascii?Q?G5QQo2sXJpChcMSXNTEfPTWTktTgRuTHixfeWWPiUXzZdWjFqpudCNXxQ8Bl?=
 =?us-ascii?Q?v/rdby8IcWwBbwtyQMyHaeezCj8N1p4M0uVvvQItbXF+yw+PyxAVOoOeEQnw?=
 =?us-ascii?Q?EWDO1AkDKwGpT1KZJ5Whno0IQ/tPSQaueKggBVKospe97Rkv66ZdzJeIVnD0?=
 =?us-ascii?Q?kox7//AcgIH0q9aOgcBiwzN1WTxZDkonaOPdGyJD+9vlQTWTqzPveJDu/tTV?=
 =?us-ascii?Q?vpWra93qIbmdv1BBpFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93451ee3-3f39-4e92-0885-08dbbc0f25f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2023 08:29:04.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByvE4sBm/WHyDc6mIiVktgpWEF3AdHMmrxTMmhX8GTlac3HZn/4WEvAR0msOQlXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5983
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 23 Sep 2023 08:29:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15106

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 23 september 2023 05:50
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bitbake-getvar: Make --value imply --qui=
et
>=20
> It does not make any sense to get log output from bitbake-getvar when
> the --value option is used as the log output is sent to stdout and thus
> interferes with the output of the variable's value.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/bin/bitbake-getvar | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
> index 4a9eb4f311..1ec90065a9 100755
> --- a/bitbake/bin/bitbake-getvar
> +++ b/bitbake/bin/bitbake-getvar
> @@ -36,7 +36,8 @@ if __name__ =3D=3D "__main__":
>          print("--flag only makes sense with --value")
>          sys.exit(1)
>=20
> -    with bb.tinfoil.Tinfoil(tracking=3DTrue, setup_logging=3Dnot args.qu=
iet) as tinfoil:
> +    quiet =3D args.quiet or args.value
> +    with bb.tinfoil.Tinfoil(tracking=3DTrue, setup_logging=3Dnot quiet) =
as tinfoil:
>          if args.recipe:
>              tinfoil.prepare(quiet=3D2)
>              d =3D tinfoil.parse_recipe(args.recipe)

Hold off on this. I just noticed that using the --quiet option together wit=
h=20
the --recipe option is broken (in the existing code). I have a fix in the w=
orks.

//Peter




