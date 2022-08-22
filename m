Return-Path: <mikko.rapeli@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB1C32772
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 09:09:44 +0000 (UTC)
Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com
 [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web11.15694.1661159379950691530
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 02:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=a6+84INW;
 spf=pass (domain: bmw.de, ip: 207.54.68.120,
 mailfrom: prvs=226cd0590=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1661159380; x=1692695380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ze8qCZH4eCNeem5lYs1Ouaem4G5EBzA/08n2mB+b09Q=;
  b=a6+84INWU3fQSEkh8cu7DAJU2xPspy7+tuMLipzIjnmoBAPCg/FS4dRJ
   V+V7TWLG74lXDGZBdYdJ51Ua4GQp+y8bLmKhVEcIcbGmrCToLUhPpvrTr
   reILJmPCRe0/+MqWtxJu6ZTUSSudyWBdsrHXvhskHCi+nAiZGq4Nqg+FE
   I=;
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 22 Aug 2022 11:09:36 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw4.muc with ESMTP/TLS;
 22 Aug 2022 11:09:36 +0200
Received: from smucmp08b.bmwgroup.net (HELO SMUCMP08B.europe.bmw.corp)
 ([10.30.13.68])
 by esabb3.muc with ESMTP/TLS; 22 Aug 2022 11:09:36 +0200
Received: from SMUCMP08E.europe.bmw.corp (2a03:1e80:a15:58f::1:24) by
 SMUCMP08B.europe.bmw.corp (2a03:1e80:a15:58f::22fd) with Microsoft SMTP
 Server (version=TLS; Mon, 22 Aug 2022 11:09:35 +0200
Received: from SMUCMP08E.europe.bmw.corp ([10.30.13.71]) by
 SMUCMP08E.europe.bmw.corp ([10.30.13.71]) with mapi id 15.02.0922.027; Mon,
 22 Aug 2022 11:09:35 +0200
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
 AQHYs+yI6ZkxFnyDGU+Z/Quo9ksiHa23kU2AgAKy7wCAABsxgIAAC28AgAAOYoCAAAI0AIAAARiAgAAH4AA=
Date: Mon, 22 Aug 2022 09:09:35 +0000
Message-ID: <YwNHztTQk9Uu9Sdd@korppu>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
 <0762e114-4233-8b43-b796-cab61e4881bc@denx.de>
In-Reply-To: <0762e114-4233-8b43-b796-cab61e4881bc@denx.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0AF009C300ADC74D8D4A932751DC3BE7@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 09:09:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13917

Hi,

On Mon, Aug 22, 2022 at 10:41:23AM +0200, Marek Vasut wrote:
> On 8/22/22 10:37, Marek Vasut wrote:
> > On 8/22/22 10:29, Marek Vasut wrote:
> > > On 8/22/22 09:38, Mikko.Rapeli@bmw.de wrote:
> > > > On Mon, Aug 22, 2022 at 08:57:11AM +0200, Alexander Kanavin wrote:
> > > > > Can be solved with a parameter to a fetcher perhaps?
> > > >=20
> > > > Frequently developers know to change the git URL in recipes from
> > > > "branch=3Dmaster" to "nobranch=3D1" for their test commits.
> > > >=20
> > > > This could be used for fetching the changes too, to limit the scope=
.
> > >=20
> > > So maybe the easy way out is, if nobranch=3D1 then fetch everything,
> > > else just heads and tags ?

To me this would be the way to go.

> > No, this won't do, nobranch expects the commit to be in a tag.
>=20
> But then, if gerrit works with nobranch=3D1, then gerrit must be generati=
ng
> tags which contain the commits you test ?
>=20
> And since this patch fetches refs/tags/ , then this patch won't break the
> gerrit setup ?

nobranch=3D1 works with any branch or tag or open gerrit review commit id.
At least with sumo and dunfell.

Cheers,

-Mikko=

