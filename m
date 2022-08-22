Return-Path: <mikko.rapeli@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96941C32793
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 10:51:54 +0000 (UTC)
Received: from esa14.hc324-48.eu.iphmx.com (esa14.hc324-48.eu.iphmx.com
 [207.54.69.24])
 by mx.groups.io with SMTP id smtpd.web10.16843.1661165512237039472
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 03:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@bmw.de header.s=mailing1
 header.b=SiW+WiuV;
 spf=pass (domain: bmw.de, ip: 207.54.69.24,
 mailfrom: prvs=226cd0590=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1661165512; x=1692701512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cT0sCOKZ8yKcjHWY3YHADkcJB3g4wtQ6GDuN7F5kE+c=;
  b=SiW+WiuVslqMeUB7mOaA1Ef/KS+fhTPNW+SM/BVMF1brvet4p+9juFaB
   kCPrWKdrmqqNRsgYh34XzNAANsWC+WvI4/M02LfEuIjnIM6udaN3FyWog
   cTp+UOYDZ/wjCMs29RSBbTAt0KccQfZ2HaNIJecVSmQW/s/CjQOhD+pXH
   4=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa14.hc324-48.eu.iphmx.com with ESMTP/TLS; 22 Aug 2022 12:51:49 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw6.muc with ESMTP/TLS;
 22 Aug 2022 12:51:49 +0200
Received: from smucmp08a.bmwgroup.net (HELO SMUCMP08A.europe.bmw.corp)
 ([10.30.13.67])
 by esabb3.muc with ESMTP/TLS; 22 Aug 2022 12:51:50 +0200
Received: from SMUCMP08E.europe.bmw.corp (2a03:1e80:a15:58f::1:24) by
 SMUCMP08A.europe.bmw.corp (2a03:1e80:a15:58f::212c) with Microsoft SMTP
 Server (version=TLS; Mon, 22 Aug 2022 12:51:49 +0200
Received: from SMUCMP08E.europe.bmw.corp ([10.30.13.71]) by
 SMUCMP08E.europe.bmw.corp ([10.30.13.71]) with mapi id 15.02.0922.027; Mon,
 22 Aug 2022 12:51:49 +0200
From: <Mikko.Rapeli@bmw.de>
To: <marex@denx.de>
CC: <alex.kanavin@gmail.com>, <Martin.Jansa@gmail.com>,
	<bitbake-devel@lists.openembedded.org>, <peter.kjellerstedt@axis.com>,
	<richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Topic: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Index: 
 AQHYs+yI6ZkxFnyDGU+Z/Quo9ksiHa23kU2AgAKy7wCAABsxgIAAC28AgAAOYoCAAAI0AIAAATCAgAAfsACAAASoAA==
Date: Mon, 22 Aug 2022 10:51:49 +0000
Message-ID: <YwNfxKxUohc4TYSw@korppu>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
 <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
In-Reply-To: <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0C08158110AF0499092BF7EED528AEA@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 10:51:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13919

On Mon, Aug 22, 2022 at 12:35:08PM +0200, Marek Vasut wrote:
> On 8/22/22 10:41, Alexander Kanavin wrote:
> > On Mon, 22 Aug 2022 at 10:37, Marek Vasut <marex@denx.de> wrote:
> >=20
> > > > So maybe the easy way out is, if nobranch=3D1 then fetch everything=
, else
> > > > just heads and tags ?
> > >=20
> > > No, this won't do, nobranch expects the commit to be in a tag.
> >=20
> > I don't think it expects that.
>=20
> Documentation says it does:
>=20
> https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/git.py#n45
> "
> - nobranch
>    Don't check the SHA validation for branch. set this option for the rec=
ipe
>    referring to commit which is valid in tag instead of branch.
>    The default is "0", set nobranch=3D1 if needed.
> "

Only the first sentence is enforced. The change can still be in a branch, i=
n
a tag, in random other namespace as long as the commit is found at checkout
time.

Cheers,

-Mikko=

