Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653AECE79A1
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 20:29:42 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.74])
 by mx.groups.io with SMTP id smtpd.web10.2746.1695673775643541674
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 13:29:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=TiFPZF4H;
 spf=pass (domain: axis.com, ip: 40.107.13.74, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4UR+lbVSB6SLvo/mVelIs5SFCF43j545rnB9X0ZlduJOvYVZq+JeMDSWiepGfovl4B2ZbHs/+X5ApFns9+YDLqY3t2GE1aSYNZtCuph9O+J8oXPpfLYT0tj6V59lqOolgFqSgBWTur04R8Gc5/OZbmypLeopEfzyTh9pAth9msPIYs6hztUnHkDc8WzMOtf+loc0+ZEPcxLli5/J+fMr8IJJGvaelJo4xCAM8mUUywhHXvovZpnBy875dFeiVJm+R9LhF9Eu3eSBXt3fIHMHHaqogLYwpGrwItTOxenlq5hoSvbohWZl4hGaeoOCdawlA0y+WJiY0Dr3mt3ITHK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKoJU0Nr4EW0ArWFuF8W11ifWQpSV3bHaCA75Qpx588=;
 b=kuLqP6z5cbhsZC0pJybfxcS3o/XJ1FaDaVSTplqivsyqV17zhSTiWwHJyL5x5W1fJXJJbueGU5lb8ra7GwGgg5l4aEiimhIPHMFXYjChQMzIfFzVPnSwlO6uS5dCCn97TtjAbjepEI/seu5/6k70AkCjMIY/2ozFyYSqnTBn6inBHnhIfioe3GrBFbRgi/TAGxV68+HbdW7LLjCmRsEHiJME2jXVaMiT/R4TnKmXD3qdu8ckh42ElhSVTMfkqGf7QnummAGTdq9uXS7PQ9YC6/8NdwMTfcSNFPfzY663kwRjDf7dMloyh2CwfSqBPMDjkHg7LesBdkp2cNcCoffeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKoJU0Nr4EW0ArWFuF8W11ifWQpSV3bHaCA75Qpx588=;
 b=TiFPZF4HYyN/QCMuDphVDGyQIitZXxiAeo/GKIYAB0DTGHtASzpRr6FEs/RDToeR5oIQaDTxfLJrppBfI7FJ4eUNFAnBlQHIkfkcTSqRSS/AbmqORiomlfdSfgz3lAauyth7jSP9VNEk5cMWldV3v5USOhS1neNkfi0BPCK+cRA=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS8PR02MB6502.eurprd02.prod.outlook.com (2603:10a6:20b:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 20:29:32 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::46e8:4a9e:ea9a:7861%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:29:32 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Mario Domenech Goulart <mario@parenteses.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
Thread-Topic: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anything
 with --value and undefined variable
Thread-Index: 
 AQHZ75HHLvUupXI6K0yyvOd1GScPw7ArSq9wgAAMr4CAABNswIAAKSuAgAAJ+kCAABqZgIAAJ4tegAAWxtA=
Date: Mon, 25 Sep 2023 20:29:31 +0000
Message-ID: 
 <DB5PR02MB10213A9ED8A52B9A5F08EC48BEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230925032246.1316597-1-pkj@axis.com>
	<2dfb0d4ca6650781ad55e6ba164da4e40d7b41f7.camel@linuxfoundation.org>
	<DB5PR02MB102138720B4A38345285D26BCEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	<35b58142c73b9b22f960a87876f260d10c30b57c.camel@linuxfoundation.org>
	<DB5PR02MB1021381B9F45F71019B89C8FAEFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	<659f37fdb542e410ab6ed039d6cadb2403024350.camel@linuxfoundation.org>
	<DB5PR02MB1021356A2A4354ED39DB5CD96EFFCA@DB5PR02MB10213.eurprd02.prod.outlook.com>
	<4e46959768ee5e6cc6f72a42fa566db267dd5d38.camel@linuxfoundation.org>
 <87o7hqrtbf.fsf@parenteses.org>
In-Reply-To: <87o7hqrtbf.fsf@parenteses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS8PR02MB6502:EE_
x-ms-office365-filtering-correlation-id: d6b202de-5be2-4728-b5ac-08dbbe06200d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 exrw/n+kDjC+/58hc5eah4lYpJFhaLtmQdfVjk+hr/LYHx1zyCpgbitkoMJ5qTDicPixK30Gi1VdpKbvlfpn7VImeeFiWjrHrxMiQQjluBN4ukSOs2GFX3TsShoTWWbq+k+VJStEASh3VeirOedsFDD1B8p1SdqgcEO0czx7bnQextFpSgiHpyKnQSuzSEIB2HX+P2L9TQOA3iLgg9z2jNJAb5/KgqSivVKhR+s5VCF3Ih/3MDF3kpBn+fR0ZDoTTMfSsvnRQqezQqR/hYeoC0fxlIqUqw8BgTJax8i+Get/6YLiTg1XE38O9sHUWDon+yGLbnQya27PkCSKERYmdY1O17JdlD0H7yev8gSmVfOXhk3d9hL05i4pHICMvpF2oXJ2xmq5KUrDNjYXPJ+/ZoSwhEwXPL0PMY1/i64keE/I7RqGSFpgOUnmRR5Cg6gzj6kkwojASvvrcJnUO7uBmWQ7t8hCh+B6jbVE3lw9QHln+p/HaqzveqJX5WoaOpeRee5NY1pqXyKCynuw5tlMwHCt03Wey3zbpzb4XfHSpLtGvfDSagt9H3atHRjAromFkGUiWLkEaFwOl96iZ9DYEcW2H4AiAX2KqvahlOkUAw0VoxT40unIBzMKzNQmwQHI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(83380400001)(44832011)(55016003)(5660300002)(52536014)(66556008)(66946007)(110136005)(41300700001)(76116006)(8936002)(478600001)(122000001)(4326008)(64756008)(66446008)(86362001)(71200400001)(316002)(2906002)(38070700005)(38100700002)(66476007)(8676002)(9686003)(33656002)(53546011)(26005)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sWNr1+1EUr7gmrIsLsF3QOEN2rIvpDLEj5+RkL7+MR5Z/wIfstNpHu8SMGLh?=
 =?us-ascii?Q?xg8H8yQ3VHIOz+Y6BE8ozJd8izTUJBxPcYS0qDVHtO8hMAMihgZDuJJQWwGI?=
 =?us-ascii?Q?kiyKhzvAqiqV89Ww6ioLL2iCwp2vwK1arsevat6UbzHBYHf0YsCCKqDQiHiM?=
 =?us-ascii?Q?zaPgNfne3UzMvYdGzZkB8TDkXMEKmZhoa8ndpb4eciyX/3X7bSo//4kDA5tH?=
 =?us-ascii?Q?y3A6SKztWxAD7FOa4Vsm111/93ZnhprURUKvHDzZs5zMgq0e8B4NUUWfTsgc?=
 =?us-ascii?Q?EuldmdewEhmMy+dTA0nh4W6oewvgH4zRwNV9468ogrEKBH82LNtcSdGfTPFg?=
 =?us-ascii?Q?9RkvIXdIDdNo8eAiIqKP9FK5bC2S/Pf0cg4NpePIpjOIFEqsM5Cc1JV8vYTk?=
 =?us-ascii?Q?4Tj6kNvCGavXJ7OI2pt1hyYIJJD0GaANRivEQFivOugXKUWWlEnJ0eM7ij1+?=
 =?us-ascii?Q?YVmjz2lBEkEk6iZJlhzls93UrLuCkA3seo9iCGvgpitQlYwLgypX5pptDazP?=
 =?us-ascii?Q?ERydr+zpH0hrZMlsEXy+Q2d8wTCQD6VFpAdhXKWO4IMsYgsJx1p8/7Q2C3R7?=
 =?us-ascii?Q?5Za4EydrdmT/pSfXi5MqjzS3sFaMO5Uz848OPREsfb6kymdjDbUxyAy/NRLU?=
 =?us-ascii?Q?2RbqauG7sUK0ccFiLUTmEJ/zkuRV48Q79IuVwDQjMumaGtbjWCgXe3YzVseb?=
 =?us-ascii?Q?J5Uu2UjjFX+ixMO0MUkV+3M2OsZjKSjcNgvjWCP2orVrVQ03UJbJ0tE0BaG9?=
 =?us-ascii?Q?DMgfKxR8CJSUKQefhM2g33D09jPXFxQA6DKSdw8/LpLYEWjcPW2nNteaoxpT?=
 =?us-ascii?Q?p2ElMkdDbHTrjYFYY6j7Gjqbxu1R6bY9TCEjNdAlQhR0QDGjrDGO53BbqxOk?=
 =?us-ascii?Q?Tf3ZIcT8I1vU2ctXw7wXGCtb6E0FbMjkFDzL5/tfUarBYqJc7MHJFoe4QyKi?=
 =?us-ascii?Q?OV2E3rnP9rr8RUj7LyBKoHDujNpMY/mRWx5nibzW7UiVt+iXyMkZprETs9kV?=
 =?us-ascii?Q?T4wnBh8WBJ7xGsB2RyaHi3evhpQoLyqLijDcXGhP1FDI8YB070gaL6TJdNvL?=
 =?us-ascii?Q?LAOMAeNiLr7dd3CK3/SgIypFfF4H9erxMpilF2iUcrMW0jctQEKMhIoWgC6t?=
 =?us-ascii?Q?CbEE7f5e9Ei7y0BwpDA/X640ItD026a3U0+gQwvTR/YoRMbrhWlU5Oz74+sG?=
 =?us-ascii?Q?3K1042lox7lL7CNH1Q0befOt6Y1tT6vuyM7WGdBCyZJi89wE36Cb+he3ClUs?=
 =?us-ascii?Q?eFgPcwugyHXpf4Btm5G+6b7HUPzprg948t4XqupLu31NY/mDTLtF7Dre0wss?=
 =?us-ascii?Q?/+u0fP9WOCE9Qat9sBclH2PgBatZFJlt2gb5NWxJQJHLMWZWAQV4eGTHWxMR?=
 =?us-ascii?Q?gqbOYKTUF3+hCwCqcJUAIuL01t/jYEBOddKuZ4RxJlTgBdge1QwSRwB+37PA?=
 =?us-ascii?Q?boBiCkZsEfG1kUYkKapam2Sp1eU1QuwjZaJtzO/m4gQPQCrg9WB7D39UhVZv?=
 =?us-ascii?Q?6f55JIu0rOC3sl++DIG2Q2CJ/eJnQbwaQL7Gcsj+q9JkbcT5vN72FqFjANiK?=
 =?us-ascii?Q?GCfIuXnTEYtviEcaB1M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b202de-5be2-4728-b5ac-08dbbe06200d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 20:29:31.9653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LaXnJb7nWK3AW9lK8OGaFDl66k1XVxSaFwE81uWbpb7SiRgYs4xll/pHl1FLE1z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6502
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 20:29:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15124

> -----Original Message-----
> From: Mario Domenech Goulart <mario@parenteses.org>
> Sent: den 25 september 2023 20:39
> To: Richard Purdie <richard.purdie@linuxfoundation.org>
> Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-devel@lists=
.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output anythi=
ng with --value and undefined variable
>=20
> Hi,
>=20
> On Mon, 25 Sep 2023 17:17:53 +0100 "Richard Purdie" <richard.purdie@linux=
foundation.org> wrote:
>=20
> > On Mon, 2023-09-25 at 16:00 +0000, Peter Kjellerstedt wrote:
> >> > -----Original Message-----
> >> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> >> > Sent: den 25 september 2023 16:07
> >> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-devel@=
lists.openembedded.org
> >> > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not output a=
nything with --value and undefined variable
> >> >
> >> > On Mon, 2023-09-25 at 13:55 +0000, Peter Kjellerstedt wrote:
> >> > > > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> >> > > > On Mon, 2023-09-25 at 10:16 +0000, Peter Kjellerstedt wrote:
> >> > > > > > -----Original Message-----
> >> > > > > > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> >> > > > > > Sent: den 25 september 2023 11:22
> >> > > > > > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbak=
e-devel@lists.openembedded.org
> >> > > > > > Subject: Re: [bitbake-devel] [PATCH] bitbake-getvar: Do not =
output anything with --value and undefined variable
> >> > > > >
> >> > > > > My goal here was not really to be able to determine if the var=
iable is
> >> > > > > defined or not
> >> > > >
> >> > > > I know, but that is an important detail and whilst it may not ma=
tter to
> >> > > > you, it does matter a lot.
> >> > >
> >> > > Well, as I see it, with my change it _is_ now possible to make the
> >> > > distinction if you really care, where before you could only assume
> >> > > that a returned value of "None" actually meant that the variable i=
s
> >> > > not defined.
> >> >
> >> > As things currently stand it is clear something went wrong through t=
he
> >> > process you yourself mentioned as how noticed. Once your proposed
> >> > change merges, it becomes very unclear what is happening.
> >>
> >> The documentation (i.e., `bitbake-getvar -h`) for --value states
> >> "Only report the value, no history and no variable name". When I
> >> read that, I instinctly assume that it will not output anything if
> >> I ask for a variable that does not exist, not that it will output
> >> something that looks like a valid value (i.e., "None"), but isn't.
> >
> > Please stop trying to convince me the current behaviour is wrong. I've
> > said multiple times, I agree. What I don't agree with is how you're
> > fixing it.

Sorry. I was probably still in "why doesn't he see it my way" mode=20
when I wrote that, before I turned to "ok, we can find a solution=20
for this" mode.

> >> I would be fine with an error message to stderr, but then I would
> >> assume the same result if bitbake-getvar is called without --value
> >> for an undefined variable.
> >
> > I agree with that.
> >
> >>  I would also prefer if it is possible to silence the error for the
> >> case where you do not care if the variable is undefined.
> >
> > I only agree with this if the user specifically asks for that behaviour
> > as I think it is a perfect way to end up with obscure bugs otherwise.
> >
> >> Whether bitbake-getvar should actually fail with an error in case
> >> the variable does not exist is more debatable. I can see use cases
> >> both ways.
> >
> > I can see the use case both ways but I think the user has to
> > specifically ask for undefined to result in "".
> >
> >> > I'm not disagreeing that it needs to be fixed somehow we agree on th=
at
> >> > and I've already said as much. What we disagree on is how to fix it.=
 I
> >> > disagree on this way of addressing it.
> >>
> >> Based on my comments above, here is my suggestion:
> >>
> >> When an undefined variable is requested, give an error message, e.g.:
> >>
> >> $ bitbake-getvar UNDEFINED_VAR
> >> The variable 'UNDEFINED_VAR' is not defined! [on stderr]
> >>
> >> and set the exit code to 1. And the same result with --value:
> >>
> >> $ bitbake-getvar --value UNDEFINED_VAR
> >> The variable 'UNDEFINED_VAR' is not defined! [on stderr]
> >
> > That seems reasonable to me, without the "!" though.
> >
> >> If -s or --no-messages (borrowed from `grep`) is also specified, then
> >> no error message is output and the exit code is 0.
> >
> > I'd suggest only a long option --ignore-undefined. That way when you
> > see it in a shell script, you know exactly what risk is being taken.
>=20
> How about providing a --default parameter?  The behavior of
> bitbake-getvar would then be:
>=20
> * If the requested variable is defined, print its value and exit zero
>   (in this case --default is irrelevant).
>=20
> * If the requested variable is not defined and --default <value> is
>   provided, print <value> and exit zero.
>=20
> * If the requested variable is not defined and --default is not
>   provided, exit non-zero.
>=20
> Rationale:
>=20
> * The proposed behavior/API allows for:
>=20
>   * Detecting undefined variables.
>=20
>   * Controlling when errors should be raised.
>=20
>   * Using custom fallback values for undefined variables.
>=20
> All the best.
> Mario

I liked this idea and I have implemented it (patch to follow shortly).=20

There is one caveat though. For the case when --value is not used=20
and the requested variable is undefined, the code will actually=20
have to inject the default value using d.setVar() to make sure the=20
output is consistent.

And just in case RP does not like this solution, I have an=20
implementation of the original proposal with --ignore-undefined as=20
well. But let's try this one first.

//Peter


