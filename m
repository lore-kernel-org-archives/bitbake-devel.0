Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E31FC77B75
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 23:52:56 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.7904.1684799574962026937
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 May 2023 16:52:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=ktTIkHPU;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684799575;
  x=1716335575;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zvMaAsnBLAM2vmq5yNhU7HwijZpyv2JhHCpy/3XI4sQ=;
  b=ktTIkHPUAOxSRtXCIlNbuRu/bqFFFZv4zPmddDLgoyq8SMpVKo7bSiZX
   bs3c4BOOlP1WlyKSBdDnP//kgEJFPXMfF8Sd5jWtHqWHqUCDzgouqOTAI
   ugvSHywgjsTR+tCITS70WXQoLYWvRgJxKea7gARYJkmyQItoL+yZtF8HN
   32ogqld/8Pnovtc3GmZyWUfxzq89RMvn74WR9xlHGsz9YbgPB/PcZtO4W
   /LyiM6DSWYoa6oladiB2xCWhen7MmgDJVmLgTQTyi5xaBWA26qKgBmcds
   V5o9LJMsVDvVH6HYqoMmqBIKJHRYe6rpIP7OtWrkgsn7jDAWuxnP7QGP4
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl/Wmcn5J22hYAtfLGezOfkggMkhZf+w2HDWdkW/29BtjSBNMcmS8+w3J1UoCquyQDJvIoMAcrbI1y0t/E3geDE3oZEVA+NcFhfVRx3l8EojPcnGJHzEkwyX26Pjrm7pOl6j+X5eMzK3K3qlcXRdSdIx4b/7x9q+l2+iYdDe66FoBAqwKTrLbZMEc8BJOA3tYrVuIIP35k7ZbJG60k8i/AkLFQNKblQ5jvQVnGrPZ4oalLx8DeDbKkGzYvhDTEThR2yuszIeg2Ls8JWcGS5SfhjnnMHP4XpBL9Q6oIMF749+eg8yi+24G2WioQKYP/i9RTxEskwGto3G3BqVsGVJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvMaAsnBLAM2vmq5yNhU7HwijZpyv2JhHCpy/3XI4sQ=;
 b=Ik4/Vz3MyYTV8tMPPyX3SsYpySMyx+efvqXBeNbrKym2Hw6VoFo39PoPd3Zawtp1h/CXwZnqELF+L/JjebU1Pd7uBLCaK+gnSOFSrcBHqJMX2ZsS49wEA3VY3ADbj9OLuVvGX0TYxsfku8XfI65xcQttPPNptv3RSC0Tw9JIqfG/t6pO8nDCW5B+eHdiM8sNotivdp3T6XFB9A24qc6bf9maLqShNi7njm/+Ar1Un96535SFgjH4W0jHz7S5piPaLMLhOiDFvWiRTFQE2cau/0DWgbsm2xlTP57dGskjZB1OoYPSK8Rz500Mw1rXf0ojJwftSTPQajKRSRuoCPsTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvMaAsnBLAM2vmq5yNhU7HwijZpyv2JhHCpy/3XI4sQ=;
 b=SNEy5KHYEqchVbbyO4MyWTKSDzEuwf0cnT10shBCcdgewpSC5yCyQtScg1/dzq9ajGm92y64+/h3j3thPG2DJt+kLaqyTNZ24oj2nu+FSwcnFSQCDMuF33qNcMneDeTULxbk9EREAKLVHhwsvXYXYTjZfPr+hixumE2uzTXoUyU=
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [master][mickledore][PATCH 1/2] fetch2/crate:
 Simplify extraction of crate names and versions from URIs
Thread-Topic: [bitbake-devel] [master][mickledore][PATCH 1/2] fetch2/crate:
 Simplify extraction of crate names and versions from URIs
Thread-Index: AQHZejk/QIndnbPjQU6WgL7r1QEbCq9nHCfw
Date: Mon, 22 May 2023 23:52:50 +0000
Message-ID: <DB5PR02MB10213D4D7A76EB1E3022196E3EF439@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <175A434F8636122B.26969@lists.openembedded.org>
In-Reply-To: <175A434F8636122B.26969@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB4PR02MB8558:EE_
x-ms-office365-filtering-correlation-id: 1cd17ae9-1d30-4ac4-9fc5-08db5b1fa6a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mp/gupxurK2gpU9nsbsuqJkViDwiag2SxbZlV5rP3PL2hUjfurGXNVangFU1+pvaMOt7goQDh6aVvviFEyRfZazO3e06Smum85QCkQ2bs0tS17lhtpV8upHy+MOdAiIX3IG77Nu+vSssRoV7xqaoOZ5ycmtqcUfCqH8CCJIEswT4gZI0X+GWDTjdpTYx9nK+8GWCAwAWk79W0unFrYUZhLyORGMzCrQSJzVbd1VnTVS5sCLp84+B62tGl9ypAZDQlgV+wzV0PT3xqqAdE5e/MIjoqBp99FhLFBFsoQqXRPpieLfXk98NsucKXKJGP0dFjaoRS951qMLBXcM7ldg8RTuoLnWl1HFZXFRe0Vq1EMHJo9h7r7TD9nVNwhUxXI6zA+hrB3LcNbc32L1QB1KoV/aRSYuzOVE5fH/2UI+33r4oHKcJ+a7eQgHnM9wCEpIuRf3q8pY2HCCTYhezwk4GnndZAzHueeHXUbMPxlAn5jbhH76arCBMFfT/7AwuEBdmzaBkiqyZwQzkP9ygRO7zQAyZAoVLr69igtG1Ysh3TDXm+CoBK+fzMVVMHYKswZDmRAoCdmwQJXHxOoDD2U9H/0szpTUMLg2DJdkyar2uOHqbMYGWFfMjBus63AnNU9pK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(451199021)(8936002)(8676002)(52536014)(5660300002)(44832011)(83380400001)(53546011)(186003)(26005)(122000001)(9686003)(6506007)(86362001)(38100700002)(38070700005)(41300700001)(71200400001)(7696005)(55016003)(33656002)(478600001)(66946007)(66556008)(64756008)(66446008)(6916009)(66476007)(76116006)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ld2hTYKa+r5k8IFdCLCsYW+0cIFH0+4BWSfbWpbXl/cnzY4VcNdoqUnCry3o?=
 =?us-ascii?Q?SDV9GHskCqJ0dsz4JQihoGlMWqIDSi1I9jKxH3hU4UCcWCnMIZlqfPp8MNXm?=
 =?us-ascii?Q?OSBBEVyy1/jz2I9ZUKKX0x5Lk1Ui7b1c+ZBgZqlq6+KcQyzCWsOU8Dt8nlGs?=
 =?us-ascii?Q?yPsBhDMwtOqnbE7sFa3S0gd3aqaDifdJ0XbmtYG1xQVUUAzElGGlcLkBQK2O?=
 =?us-ascii?Q?NlCdOFyAu80oFC+NHk8GIhQxvvgC9G5YRjPMpwwL5CQB5ZDcS7478RFhLbbi?=
 =?us-ascii?Q?pJbT4jgcRTPOV7CkGYNLlhxS1F/2lFRKHnUaoiYTtCy8UociGjUIDyymsYmA?=
 =?us-ascii?Q?F7oQyGJELyDTUn6cDF63OBnuHdyk8w2i26QxPGAKAHfIWWWlbJ5orXpIL7ve?=
 =?us-ascii?Q?EGo6/nHt+A+euxNJLsKP1ylbUPYap4p/xSm6zmaCpJV/orXMBAVF0xHhmO7C?=
 =?us-ascii?Q?BbgCfI5pRRYu49H0csS1G7F2hZNofYxD0/s2ccTmwiuRlH60BRKTZVgrWnRK?=
 =?us-ascii?Q?o6iAKhhUiF+5g4usNxNylB8di76yC/jL4223OeVhbdpOauEcMht78OLOTBW+?=
 =?us-ascii?Q?y17s/z1j3Rl41HKFhunzkjyqBy19EcRR8QE4GqvffKWz+ATvdL1qW6AYcgjf?=
 =?us-ascii?Q?OPa/uemtqwaKVkC+9VtS4w5zakZK8WMWuYkgQcF5Zs6cPRJoqnpMggzaIAjk?=
 =?us-ascii?Q?ciBPPVHxLpIQ3ycoTAuaYHdZ7Qom0hkupix4p5jHK7u+HiG1eeoN8+oeJcRE?=
 =?us-ascii?Q?s+rTpay+Bzkxjw/6GxC1/CwmM+SMFzanUiu+2iGePf6vw1aI2RjQ0xtJXGRw?=
 =?us-ascii?Q?3jbl+dz/sGzuW8igvYJdTucxWjDS1EUNVDQ0qhRZSnaVufm1IqdHjh8P4LcY?=
 =?us-ascii?Q?E794ad64jYmFPU1YXOctsYpk+l2xO1EIlGdCGTw7GkAQLYeSHY+vPvN4Nz9D?=
 =?us-ascii?Q?dJIuc1zrChk4NtgdY2DdK9l6PHNRgUqNmLU2PTdJs+1qvOiz4aV9eH/yTTgG?=
 =?us-ascii?Q?HjvXs9FY5XrFFUA6CQEzMgy0hkm3J/i8RrrI8cHExszRhkVqKHjb8hw7453j?=
 =?us-ascii?Q?fv24pDsoy8Ju5kqy/xSK39Z1q2fZIIb/UiusM3nZq+wV3V6RdhjPxYd1v1xg?=
 =?us-ascii?Q?NlXp2nALrGZ5JWUjVhvoneVWbyNUlwc6uG+nXN+PpkFhQwyen+labS3sEFpz?=
 =?us-ascii?Q?lYrm9LsZsppNRkHOGN1qrVD3b0fe5ac42arxHU8RWyUIXAmGYNtY3KMaQ4U4?=
 =?us-ascii?Q?IKRo7zgmFUTLT/hyxFsUYf5ogDZgijSF+UBAXNBQkIbGPdPleMe+P3L6DoEu?=
 =?us-ascii?Q?S1SDgwoI+WE/qv4VnNX4Olvtyjim8VwSpPY7RJYFgUALDYji/DrdC/J4eS51?=
 =?us-ascii?Q?9RjR46O0X0u3YijyTondmsoVsrFHN48Xs+dUuxJY5D5BYo2q+EMEDc8gaMrI?=
 =?us-ascii?Q?Tv9KMQzfWtulTtPp9PMTwIEzm69M7kKBoaqAOJUqTGHDAz+gWDNjw5rhvJHP?=
 =?us-ascii?Q?0nb/ID1OmCpvqlmoOBUs/LjjAgRaP5nrvrW7fSIOYhqICjno6txtkifETEsP?=
 =?us-ascii?Q?vHYH6GykO2o69JwwyI8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd17ae9-1d30-4ac4-9fc5-08db5b1fa6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 23:52:50.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS5llRlrmapZTdcXCKMcHZvml7gAKn34P8ALT6H9tttxX0yHdO1aPa6jZniCkoTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8558
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 23:52:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14797

*ping*

Were there any problems with these two patches, or were they just missed?

//Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 29 april 2023 03:23
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [master][mickledore][PATCH 1/2] fetch2/crate:
> Simplify extraction of crate names and versions from URIs
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>=20
> @Steve Sakoman: Since this is a clean up patch, I will leave it up to
> you to decide if you want to take it for Mickledore once it makes it
> into master.
>=20
>  bitbake/lib/bb/fetch2/crate.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/crate.py
> b/bitbake/lib/bb/fetch2/crate.py
> index a7021e5b36..2b8b6bc7a1 100644
> --- a/bitbake/lib/bb/fetch2/crate.py
> +++ b/bitbake/lib/bb/fetch2/crate.py
> @@ -59,11 +59,11 @@ class Crate(Wget):
>          # version is expected to be the last token
>          # but ignore possible url parameters which will be used
>          # by the top fetcher class
> -        version, _, _ =3D parts[len(parts) -1].partition(";")
> +        version =3D parts[-1].split(";")[0]
>          # second to last field is name
> -        name =3D parts[len(parts) - 2]
> +        name =3D parts[-2]
>          # host (this is to allow custom crate registries to be specified
> -        host =3D '/'.join(parts[2:len(parts) - 2])
> +        host =3D '/'.join(parts[2:-2])
>=20
>          # if using upstream just fix it up nicely
>          if host =3D=3D 'crates.io':

