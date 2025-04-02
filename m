Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C2C28B20
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 14:19:01 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.4])
 by mx.groups.io with SMTP id smtpd.web10.9704.1743603530666791282
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Apr 2025 07:18:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=gmGlVpXd;
 spf=pass (domain: axis.com, ip: 40.107.159.4, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THGtXqfjp8SbF5FPKtPQ67Z1wDAHWIQjOqlNdi0yAns7UQ0OCdALgRJ3gGvr46yk/BSZqJ8Fw8plk8JmZDw7be+OHI2zye/GU8KGPIlEzqwW34+4YGKg1ulBjhtM2qeGOvufxZzgY9ST4KwrMaQ5fzGa2hQDVEFUa4wpvzpybVc6zljYwj7xKaFqBr5cLr4Zi0IBPq1UpRqRrxgB/EQK3aOC1R9ATchX8Ckn+GOYsNfuEq092RsuwCRxM/bq1oglBAp7S5le7O1F1GmvtiBVFjN1KMej8Ek79ztFNIjUXVkN+sJobLQB5oTiK0TkgVwUlY4b2+HeweMdFHoS1A4Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SA5dtr8GtljOPCSBSATWuovfGkOVJf6LA4CPJBRQHQ=;
 b=YS+D7vqrI9hQ06j+gAB/QJmaoxDOTBUG9iwxtUn1uYKOMz2LDOmrV1XESstk/coYfIledlrF5bTwxb0OI/xBmwVFRRPXK+yOeDKMc3yrN7bP12C1oTHgw5sp/8KcDnoG5KlVkm5c8192xlRHjZ7VF4Gd7m5eHu2Fk+rd3+Jd7xjkzTfcdjhOYO5wh4RrjxLaJguuKTbhqkRc5WoWlMqpIrXqFgrm39JuQ5mM/4XHNRyCs6ePkElk7W9H1OloF5RKeRnIMiRiP9HapDYbEQRJtESY6p4aPR/c5b6h7UvGAvy3fe7SW05BmldmUWrYMu1Wt6RdoOuhNEkuxEmtZzxVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SA5dtr8GtljOPCSBSATWuovfGkOVJf6LA4CPJBRQHQ=;
 b=gmGlVpXdRJIaHTtcJPW2GD1hmYtzRiiYuXZN1ydWEDoti7yKrqELBHZ3llVKVgBuElcDwBBJMq5HYx+h+L/9zeN4aCsQk1yPGJM4KAfE7t9pRjLsASsBgiyCj2GqpcFgl5aSjG78fC4FwsLGOgHS1tDaKerY70Scl/B4U0e5tD4=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DB9PR02MB9729.eurprd02.prod.outlook.com (2603:10a6:10:458::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 14:18:45 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%5]) with mapi id 15.20.8534.052; Wed, 2 Apr 2025
 14:18:45 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch2/git: Handle srcrevs for annotated
 tags in tag check
Thread-Topic: [bitbake-devel] [PATCH] fetch2/git: Handle srcrevs for annotated
 tags in tag check
Thread-Index: AQHbo9e3FaMRgNuVfUa3T5y3bmCijrOQa1AA
Date: Wed, 2 Apr 2025 14:18:45 +0000
Message-ID: 
 <DB5PR02MB102130FD9FE35B95EFA1805CFEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250402140100.2407773-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250402140100.2407773-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB9PR02MB9729:EE_
x-ms-office365-filtering-correlation-id: 6365ac73-15f3-43bb-f35a-08dd71f14763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?9ESsLLrcQl4egpXBKv6qPu1xdRQ/gsz6vAup9wzh8RYakI/v9BK18EWT33/8?=
 =?us-ascii?Q?E+uzZ1lxs+WF4aPQfMaikfPGx8V4oCfSgXUMvAHYXVELWpGyJx+4ftJb7I6a?=
 =?us-ascii?Q?ZM+Wys8/05o1DO6LpbCJssdHrOIZZwW2M7TVE/cGDX7dkSqrQnohVIRfmL8K?=
 =?us-ascii?Q?OKSH2G+tcN5DIHR6vG61jiqk0Q6Cd0J+xAzw1r/Q366aAlAxJO493gTkH1CD?=
 =?us-ascii?Q?YgRQfDT9t2vlv2QpyrRDqhb6hKF1JUb3wMoMe/F49R+sb5g/tS8sxXkR6mgg?=
 =?us-ascii?Q?732TggNnSzlCKDIdUXdUp2/7IviVmMXfKdpKqwdRXz0R4E0H9Cqr19NdoPpC?=
 =?us-ascii?Q?OJylquRwTYRw6biIyvU3yXIAKZdG6WGScrKThUEydjyVaMZg9um+9cSFige4?=
 =?us-ascii?Q?AaTRBqG15KApbTQY5W1sSftnW1B+vKtu0Q9Ro4kjeooARY+V8mW5W9X9+Vsp?=
 =?us-ascii?Q?5Xi37aQQR+kGtunwe/UD/wT+lk6ODGrF/tgIUBFrS/O45zD/vpAOg4sHSEvP?=
 =?us-ascii?Q?oKAlYeWtbLenXDkmrmaNqezrxyQLJr2+lgPiOXF6JAcy+Ve09zGTYHPeUbcf?=
 =?us-ascii?Q?0waQKoiNi0d+cuxxNp/jZ0z7eaJ2loNTg/lv3CnDUpVjoTY2xDzBXrJQe2YS?=
 =?us-ascii?Q?EeKyGq8MJKTjNRAlajQYYgYc2GzTR5GpjdYLzpDW5GfB1YOf/BjXDM5nslXu?=
 =?us-ascii?Q?LLF26F8gZGGC9rab2sCYArug0P6QhGTULfImNTNk2kIyKWjLIMXnXi+WsffF?=
 =?us-ascii?Q?++tZ8suq+LDc3bV3TOL8iT66CCTZ/pKk8SGbzWqUaUsleY/fAguKrosVXL1P?=
 =?us-ascii?Q?CCMPf7PnMcVJUH0Hg6juy8tW6yBtfPbjMCnUq4PS+IBkQd8bvxPZ9pjNZG+d?=
 =?us-ascii?Q?9t1L407ShKmKd3BHPng5IwBlth3knz6w+1u6nuNpGzYCnS65n1JAtccGvqud?=
 =?us-ascii?Q?hcB9dVZpOLqTPT8Vnly/NPBZt/ANt96CGV2sK1CsCPuYKozQvU+8t3ab9uvr?=
 =?us-ascii?Q?C4+Ujd7A06Xcg7H3tpJ+4qJbC6+85y2q5YpLysaC07nSGuGAZsT4anlL48Pf?=
 =?us-ascii?Q?avo7KNsKiUpCAto6lxm67R/yCmCxvTCZy/FjrBZDjPEYL8qPqUdgrrtZK8XO?=
 =?us-ascii?Q?4NIVsfsY0pjazMkx7X0mELZP/aH3AQALLtryZuB3ZnvgF/zIa3gdG20Y0y90?=
 =?us-ascii?Q?WK84ChEJmVuyC7UaFAVii5LJHOhGZEjkX3njrZ/Cn4VJHY5tlvAHZWtLk4vA?=
 =?us-ascii?Q?wJu9pwjXQcfeHQ/IHnariy48RiqM3drXQ4InpGXbHJ9BNRM4+eEQGT1NFZqd?=
 =?us-ascii?Q?Ku2LYK/zv6JiRgpWEXh4R8dIBOAllgIsWkFeZKfFT8G0QIR7w8vR4CDY5hLj?=
 =?us-ascii?Q?aWBEjQr6+69mhpBIxkOiVEBOjjT/aysiPqR2btAbKkPwDqcK8HSYrm5tDzgS?=
 =?us-ascii?Q?5Gt+wownsEdBa0mSC563mVGWwjMFPQGW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jzTjGXX4b7sKab6o9edc75jtOolMOjtN3Uw1ymMYJYeG3MLmy3MvgoluGJLX?=
 =?us-ascii?Q?xS8n0/PJ54VunyyejxuAGAJFhh4OGzQajXjabD/0+XjALYA2YvaM8zhQEF0d?=
 =?us-ascii?Q?yEWdAOptz0sPm6Iw0NjZ1kITJztCCzAkWSCWFOIHwNMdEi+r4n0I4fciUf9J?=
 =?us-ascii?Q?jX6skaQNU8YnQ13xEqMMkVgkM8IugXLyLgkvZ2Qn96rYB9PY60i1G2bQQGcJ?=
 =?us-ascii?Q?vXFmBLN/MLqKf75QTiLCi+r4eBkCb0S6BN8JOuodgR0or6EYac1VPd4914tK?=
 =?us-ascii?Q?miujAK373PK/D43j9MevVeIJh3TO1DUAdWpd1U81tsEklwKyiPwVqM3Ph8yV?=
 =?us-ascii?Q?Ny1rNsRKy5M3YcZaCb+CIodXS7Fy2N3WlCBWALxTCinv1GFFv17Ljm6brJ6+?=
 =?us-ascii?Q?Tf/au60fBgpSbrd5MOv/Mpysp/X2BsfcNgNJBsgfQSfBXdqE2XLoTrKXATUJ?=
 =?us-ascii?Q?I4VGOArJGaS6rz5hazq3nwuuevJc9veQipReL2gc3LDeqqo1EdAJGQ6AjVC3?=
 =?us-ascii?Q?4kgDf+clyCBn19HHvQe+tickgd+sHGwA7wUt/kTQtBO9Sc8CuVaqfxCezedk?=
 =?us-ascii?Q?TL6qlUu0dvvlJjvpla+Vtb3+zUTRTfU6qgeuytqbbs6EUCyITpwmk+I58rw4?=
 =?us-ascii?Q?SgbVGdZxVSlbDJX+0RhKSUHsVM6vwTcpVavLPYN+3PzXuZ7RnS45m84bt9QC?=
 =?us-ascii?Q?Qv/jOMbYyVP2MlQegM0KAaDeE/kfn3/lwl2LIfsHqQMjW/q9JyxuA/L10zZl?=
 =?us-ascii?Q?qrjiFh4HEC8GrcPYwisY4PUC0r2gHf/RwpxnXB8UPqXk0yzvm/UUMD00c1OO?=
 =?us-ascii?Q?D3lV1ALK7bV09lT9Jvvr6aFmlmSmm5dYn6xNrtJEs+xks2LWxCzVgR7HBCcd?=
 =?us-ascii?Q?1sFRqrEP2h67ogL7l1y/TP/zd2lo8ca0gszh+0FemnpyD2Iz49xlTQtDvXU1?=
 =?us-ascii?Q?jIYt9w5Kk0YHWjrOrxnSzmbjFXfL4z/Buzo2CtZFMChEO8rH3GJNu3WjA3M3?=
 =?us-ascii?Q?E58x6kVraWBVj2EqeX/Mnc1Ga9B8zraHT3M9k2+QTk+VEEUlqhrsDqrKMDOA?=
 =?us-ascii?Q?mlLxKgt0a3Xq0fBTgqz4JSYN5/TAU3jlTLHL8pkpXWYOL/2yGjlwGebzQvTu?=
 =?us-ascii?Q?ke98kdHU3Yo/iHfpYNR2IgcWTdIfbJksrDFn4o7OFBLlDpx+lnoVtIxwzpLK?=
 =?us-ascii?Q?f7y/8kUJolQFBYdOPze0X4xzvvz0sGpZmDw2pelwy8xu3+RvpRzFaFMOAUsf?=
 =?us-ascii?Q?9pOuUKfqROMCW28kIXbJ8Zz84x8hXLG06MwHuHBdRzYwGAgFqFMoA/XorYps?=
 =?us-ascii?Q?nH3XC5meRnmwUw/BX9DQ7uambp9JRyVN4IZRz+jRR5IDDKjonuMjNOqQs3/e?=
 =?us-ascii?Q?d2N1s33FRLm9FlPoe71KDFfCbTdd14TbFtjvbMAm/tRwexWvpYskrkP1VP5a?=
 =?us-ascii?Q?1ULpjy/Pw1T4oNfdnpEBBt1K5Yc8Kh/5EiLVqb3Li23/k/8NyXEErxJZEcGt?=
 =?us-ascii?Q?wR0Bx5rvPkYPP1lyzGQ4yihPnEC1FJX9Ngcmnl7ID3UmmkWAcKzGf38/o51D?=
 =?us-ascii?Q?vTFPf+N3obl+i9sacn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6365ac73-15f3-43bb-f35a-08dd71f14763
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 14:18:45.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DzcxigN4iTvXZMDxaCC4ar7emwb2/AZxJBiip/7oogTI+PHgRiyht4sE8uWD3dC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9729
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Apr 2025 14:19:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17510

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie via lists.openembedded.org
> Sent: den 2 april 2025 16:01
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] fetch2/git: Handle srcrevs for annotated=
 tags in tag check
>=20
> If SRCREV points at an annotated tag, the comparision code can fail
> as the resolved tag might not be the same sha.
>=20
> Handle this by also resolving the SRCREV. We only need to do this if
> they don't match in the first place for a minor performance win.
>=20
> Also add a test for this.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py  | 7 ++++++-
>  lib/bb/tests/fetch.py | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 3a4ae6df45..5f4ec6128c 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -730,7 +730,12 @@ class Git(FetchMethod):
>              output =3D runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd, =
ud.parm['tag']), d, workdir=3Ddestdir)

I recommend using Git's syntax for getting the SHA-1 for the commit=20
directly from the tag instead, "tag^{}". That should work in both cases:

            output =3D runfetchcmd("%s rev-list -n 1 %s^{}" % (ud.basecmd, =
ud.parm['tag']), d, workdir=3Ddestdir)

>              output =3D output.strip()
>              if output !=3D ud.revision:
> -                raise bb.fetch2.FetchError("The revision the git tag '%s=
' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag'],=
 output, ud.revision), ud.url)
> +                # It is possible ud.revision is the revision on an annot=
ated tag which won't match the output of rev-list
> +                # If it resolves to the same thing there isn't a problem=
.
> +                output2 =3D runfetchcmd("%s rev-list -n 1 %s" % (ud.base=
cmd, ud.revision), d, workdir=3Ddestdir)
> +                output2 =3D output2.strip()
> +                if output !=3D output2:
> +                    raise bb.fetch2.FetchError("The revision the git tag=
 '%s' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['ta=
g'], output, ud.revision), ud.url)
>=20
>          repourl =3D self._get_repo_url(ud)
>          runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.q=
uote(repourl)), d, workdir=3Ddestdir)
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 8de6862482..196d93c414 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -3139,6 +3139,13 @@ class GitTagVerificationTests(FetcherTest):
>          fetcher.download()
>          fetcher.unpack(self.unpackdir)
>=20
> +    def test_annotated_tag_rev_match(self):
> +        # Test a url with rev=3D and tag=3D set works
> +        # rev is the annotated tag revision in this case
> +        fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;=
branch=3D2.8;protocol=3Dhttps;rev=3D6d363159e4b7dc566fc40d069b2615e61774a7d=
8;tag=3D2.8.7"], self.d)
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +
>      @skipIfNoNetwork()
>      def test_tag_rev_match2(self):
>          # Test a url with SRCREV and tag=3D set works

