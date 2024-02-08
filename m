Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92FC4828F
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 21:09:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web11.1300.1707426548778132924
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 13:09:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=TWPyf7jg;
 spf=pass (domain: axis.com, ip: 40.107.20.56, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5qEo9f/49Dfo89zBkHavCMdmFSWb9sw54Lwx/rjXGsdNPbcl4dWOF2AAMpbgOhIB6wIkNozsr/ZldPvN+OYixXN42LONqsspGwj+QZDrKxhl3yZewubuSYhPj4FrFdsoEU5P7QKSet7tUplW3k5RVQlMrAzdDmDrDKaPiuzc9rtwVa/zEKbLqcVQgBxJkI4jeY59S2lmEb46cr0tV7kBUNrFX2Na35x6DF4uAMi2kdD7RXMmwoUf02QAGuVC4AoEPv0uDuonOZ2wDVe0WUNUgCcMQX55yFBtHJjDxm8JWwtADdVbKtlZDJ2TFcSGAfemb9nN0RsCmysw2sL5LMatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCAngvpS7XZKONHSuD9GTLOCNNBZAEKPf2xvBLVSbtU=;
 b=fD4m3EyYd7G+RAsIGshJPKhnmdfq5+Y8GtncRoRtQsMhTbblGy+FnLm+T0xMiSP+SNC3wTfGJf+BhQzztGrWc3AEAcT2VTtmeFyzDxcEam0PL6wYN8l48JXCpjcAKn0z27NLn3+uHezzl4UbglaXWk4/kijIRb10pd/WIm1Qr8FoR0wLAqMv9VGrLCbGheoGyQPFyQFws89cOx7EMg8heviMIk4hZv+bHoq9Y0L+xLka2mhOGrZElyOHVk061TXWXJgFUSzlGNgEqUejqS4TL/LMvMiN6rZQg7+yewluBooNph5+SWedUxw9nqRqlSCOqY8iyk/POsDeFnhgtRnCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCAngvpS7XZKONHSuD9GTLOCNNBZAEKPf2xvBLVSbtU=;
 b=TWPyf7jgAqIQtjjjyb5ZzP6QTQBYw3fcbp+Hxa+uTd/5a7e6RGXK3+T6PjYiFJQKLavjsYgp3z/739VkrZyf0cRnphgq/hgFqk0bovIgscjzBMNDcC1Y/PL2qVmZI6iQSwiHHWkRYeIY6E4nQXAFcFFI0Fkbxujj+FCgCC/eLpk=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DB9PR02MB7370.eurprd02.prod.outlook.com (2603:10a6:10:244::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 21:09:05 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906%2]) with mapi id 15.20.7249.027; Thu, 8 Feb 2024
 21:09:05 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "enrico.scholz@sigma-chemnitz.de" <enrico.scholz@sigma-chemnitz.de>, Saul
 Wold <sgw@bigsur.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>, "randy.macleod@windriver.com"
	<randy.macleod@windriver.com>
Subject: RE: [bitbake-devel] Underscore vs Dash in bbclass filenames
Thread-Topic: [bitbake-devel] Underscore vs Dash in bbclass filenames
Thread-Index: AQHaWhQVFSjnyQI4zEOiQKq2vc717LEAle/+gABLVLA=
Date: Thu, 8 Feb 2024 21:09:04 +0000
Message-ID: 
 <DB5PR02MB102131375B22C2E34844DDD80EF442@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
 <lya5obge3c.fsf@ensc-pc.intern.sigma-chemnitz.de>
In-Reply-To: <lya5obge3c.fsf@ensc-pc.intern.sigma-chemnitz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB9PR02MB7370:EE_
x-ms-office365-filtering-correlation-id: 6c6e033e-574a-4af1-1542-08dc28ea2eaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2EHjZWcE2j5fndKFiC/qDOgxhJw5yrbDP0/Be2iPPFGTs9dnScemXwOpj/gk3VFH9gC1/XOncugRWaFP69urqXT6lpPEr21CBAyc5n7zM9mjm+O/Oa/JCOCp56/fS9XXMNi5rrtWvaenNnp/da5Cs+wff6ShYxX2P1IllF+xfVz94M7T2F9Az2wcG5t5vE5jhRQKoX+Ul9xhi0Q9DHyVaTGb6HCtqYVSFOQwRMRvR8ezsEtY/KMcBSyO6b6w6q89jOut9bh5sBdCb4J/IRkY+5XK2JH9b8vPoX7xre/IgEtbYEXCn1HYdWhW6aHuFS+LXXOVEEt+SHQEKTNazDlH8b7wOTTYlM1PiI/MwBMWj92q7LFO8MLnLM+NPz+ToKpirUoEi5fbg/xLShIAb9rR0sYLILnpBESUpjFG4U6Vrjh0LubuwZ/CIi4ZZEw7VpH/6Sfkyt8shBAIZn3tF3czeCC1QWnSO1rErh+EmyoiyCI2q2quGr72Ayk9PooRmsGEDYHsw6SdWhH+5rGSjnPftfAZBeX0t/AwzWSPU/BGMjjZMSOrfUYyJe6+ZI2mwQQzfJxJkshvn2UvcpumP58F74lLKpzuO6j+tP7FRt8Od8LSOl/oKie6Swn6q32HGEgN
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(52536014)(5660300002)(55016003)(8936002)(41300700001)(8676002)(4326008)(44832011)(83380400001)(86362001)(38070700009)(26005)(66476007)(64756008)(66556008)(76116006)(66946007)(53546011)(7696005)(6506007)(71200400001)(478600001)(66446008)(110136005)(122000001)(54906003)(38100700002)(316002)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?oWtO5yPXJ3zu8+JDRR5YAz9sFqsL8ozjPbhCETi0LaekV8R2Y70ndNzqFltO?=
 =?us-ascii?Q?FVUg3mPIActOjn7KR/WP8ewG2af/+4JSrqCI+uB9MgBDskTHIyb86RTSXnYZ?=
 =?us-ascii?Q?IQtBBWciV3gX2c5RV2RNtHpmy85/8PdeqQzedenGCpMnk0595kP9jiKf3Y/T?=
 =?us-ascii?Q?kjUDwH2VAjHIFuF5rRnXFGYqAe3YT/sbXjMMRsClGpas6pcJewd8DlJertUy?=
 =?us-ascii?Q?MicUV0F3gXOgfMNBNmzVLS394DRFgXr8pJxtvY4u9MvdLYqSPwId/gljrDmK?=
 =?us-ascii?Q?S+qamLQC7Fr+PZKeVIpR6rKyNlWjLJ+T3OolvuAq0fZ/nZJHGwxC3VKu8Zxj?=
 =?us-ascii?Q?9R9qKRoOd9GoEHNcuY6iYPzAlI0HR1Lz/o4gx4At4Of9Jg7UoV53IxoThezX?=
 =?us-ascii?Q?GagfEo0/nwc2OdKtDO8Z1P5lYJXYFaJvW/L04kgOEr1ojbd5lN2b9K7dDHLL?=
 =?us-ascii?Q?1Ft3OzkvqlCoeUBl/q2lenu0dQNfDKMsydxTAiNULLBXGY+YIotdgM8b+P3+?=
 =?us-ascii?Q?1kx/b2lcwDgSAHcEfnEEfnZ2ykR/hjwEBXVdOBuqUIR8eONeje5xFUfIpt0N?=
 =?us-ascii?Q?SOCtHQUNlAOJhdDeTibThNOQL7I8CW3wzaixM/opwu1M2NVYjykcUsI6sMA2?=
 =?us-ascii?Q?3KC1ngbE+vu6+hgzGR+EE5bxvvcSZh/xc/4h3KzajZCT9qCxICyggXhvK2EY?=
 =?us-ascii?Q?+G4P3MA89Yz2RLSCG+kZQ/hUFpkRZNkoEyTaDXYyKKsYbdvihcA5mamgZkOy?=
 =?us-ascii?Q?jBcpms7n3RPsfKHQje+gI28ViXVC55PRzRpLnlVs63u3bU/z/nNM7FEFfZFF?=
 =?us-ascii?Q?Hn0QHUWZIhp+2JCbICEu2D9FL5PpRTAbOb2wwrOYrWBONdsi/Suc6K4w59DJ?=
 =?us-ascii?Q?ObbGgDH9auR3aXbhJx/nwfThZBk+KtH4xYGZS2j+wsIBDjoZldzVy6EBwMmW?=
 =?us-ascii?Q?lH1m8vEdjE2feA3Xxidi4R7tH5K//TfvFFYjXXa9VsEYQtuhGrTrMKyTJFag?=
 =?us-ascii?Q?qsd29tneAxIOSVahqukLQ82MZwLo2AmGlqO3wdik7gwBWZcVtXzuGtBKuDIg?=
 =?us-ascii?Q?UYvfwY1txTKsg97Pag1lnJ54rU8r+lpF0P5Vzb7MDH7FqOzi73o9Z8pgeLzg?=
 =?us-ascii?Q?91Y8VkK7NKE7OyDWSECRRIyf6MU0lnL2MplzPLMuwHx6OkV5SUwstIhCp8D3?=
 =?us-ascii?Q?I7ow5GMzW9sRoxI5n20vh868sAHBjQPNXu0VEIzC/34jzSAWuf0QCbmhxH3W?=
 =?us-ascii?Q?SKYmff0sG9kYsekSWoKPNUWvnjP8GbAfyrlEMJEgy6NIVsGvPOTO+hUkhh5p?=
 =?us-ascii?Q?dyz9to4cP2vQiPZoSk/dNuZS1iRFVVJ9Tsl9S73hYxnu+tz0k9js0gA2h4yG?=
 =?us-ascii?Q?BOkkxUQCc0EM4VZVC1+CmpVg7JDOqgeyinGXSTq9jB1cspKnpIeTElIvmsfR?=
 =?us-ascii?Q?WV2ySGmxnFDMtZYgwmEXLR52gCc6a9lbzf4WmH9d8h5Ty0h4bps+Z4DMgtvg?=
 =?us-ascii?Q?tAEzqCUulpQSdggT4lE15Q3bzlMIjjLS6QPeFelyRfY9C6fOl6lWFgnyWujM?=
 =?us-ascii?Q?ee9Qosv9waqmBOgKtAE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6e033e-574a-4af1-1542-08dc28ea2eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 21:09:05.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSa7TMErTEA1DYh0i3pw6v9zbaZGsXGdQnBNLS5OiqjbF+S36ru37rzhn0HqoIqY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7370
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 21:09:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15845

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Enrico Scholz via
> lists.openembedded.org
> Sent: den 8 februari 2024 16:39
> To: Saul Wold <sgw@bigsur.com>
> Cc: bitbake-devel@lists.openembedded.org;
> richard.purdie@linuxfoundation.org; randy.macleod@windriver.com
> Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames
>=20
> "Saul Wold" <sgw@bigsur.com> writes:
>=20
> > I was looking into Bug 14235 [0] and had initial patch based on
> > Randy's original recommendation of using dash (-) which was a basic
> > python/tinfoil script to check existing bbclasses in the BBPATH.
>=20
> why not make it like rust and replace '-' by '_' when generating symbols?
>=20
> Enrico

Taken alone that would open up for problems in case there is both a=20
foo_bar.bbclass and a foo-bar.bbclass (which is kind of ridiculous, but=20
it is at least a theoretical problem). However, if you combine it with=20
the rule that classes should only use dashes in their names, then it=20
should work.

Actually, if we want bbclass names to only use dashes, what I would suggest=
=20
(and this may sound odd to some given the recent discussion on breaking=20
changes that I have been involved in on the openembedded-architecture list)=
=20
would be to change the bitbake syntax to only allow alphanumeric characters=
=20
and dashes in bbclass names. This may sound like a huge breaking change, bu=
t=20
it actually isn't. As long as Enrico's suggestion is implemented, it is the=
n=20
just to change all class names in OE Core, meta-openembedded, etc. Yes, thi=
s=20
will break other layers, but changing them is trivial. And if one has layer=
s=20
that need to work both with nanbield and master for a transition period (li=
ke=20
we would have), it is easy to just add some oneliner wrapper classes in one=
=20
of one's own layers for the new names that inherit the old classes.

At least I find that a lot more appealing than adding some check script wit=
h=20
a lot of hardcoded exceptions for the currently existing classes.

I realize it is probably too late to do something like this for Scarthgap,=
=20
but I think it should be considered for Scarthgap's successor (what ever it=
=20
will be called).

//Peter


