Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68847C05027
	for <webhook@archiver.kernel.org>; Wed,  8 Feb 2023 10:55:26 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.5795.1675853722091436022
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Feb 2023 02:55:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=YicIsfQL;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675853723;
  x=1707389723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R1DeFw6mvFHbFj6ayjvY1ovRUotMH3dzbu5ZydcnTjQ=;
  b=YicIsfQL4uBWGzEgE03BhfxqIESu7ceIMocBu/WAHrRj+HifrYBxHWzc
   Sv8BtJaGVhjUrzPiXE64SyhdWnMCWhDghEk/RRoDPXJ1K4ni1ehbvJppY
   578NDfdr8BOX9aYunGQgzGizTZLH2bev1axVRYR99At2jTiD4bEi93E4a
   3n90E5Jses+MJr10GZ45/9SVLgnWqNfQCAETNMYEXd6BKISnjio8Hy1lX
   EUkJdpqhd9Hnu017LHnd+c7myIqzchntgCfrVztRNgYYoit7i86aRbWZL
   KSaxPJnA5oCcwju68gduQV+N2qwfOeFmNlT7hXT4+6rXx6UCDXnShdYzP
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>, George Kelly
	<george.kelly1097@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [bitbake][PATCHv2] Add NODE_EXTRA_CA_CERTS to
 export list
Thread-Topic: [bitbake-devel] [bitbake][PATCHv2] Add NODE_EXTRA_CA_CERTS to
 export list
Thread-Index: AQHZO0EVw6gPoCEXZ0OZvb9+QmimzK7ExRwAgAAbnQA=
Date: Wed, 8 Feb 2023 10:55:19 +0000
Message-ID: <d23232a50dc648c5b0ec8e6295be0c49@axis.com>
References: <20230207221022.4346-1-george.kelly1097@gmail.com>
 <20230208111456.08b95a45@booty>
In-Reply-To: <20230208111456.08b95a45@booty>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Feb 2023 10:55:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14386

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Luca Ceresoli via
> lists.openembedded.org
> Sent: den 8 februari 2023 11:15
> To: George Kelly <george.kelly1097@gmail.com>
> Cc: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [bitbake][PATCHv2] Add NODE_EXTRA_CA_CERTS t=
o export list

There should be a prefix for the subject, e.g., "fetch2: "

>=20
> Hello George,
>=20
> On Tue,  7 Feb 2023 17:10:22 -0500
> "George Kelly" <george.kelly1097@gmail.com> wrote:
>=20
> > If you are behind a corporate proxy, the npm fetcher uses
> > the proxy IP address already passed in the list of exports.
> > However, it will error if the proxy injects its own root
> > CA certificate. Thus, the NODE_EXTRA_CA_CERTS environment
> > variable must be passed so the user can include their
> > company's root CA as a trusted CA inside node's
> > certificate store.
> >
> > Signed-off-by: George Kelly <george.kelly1097@gmail.com>
>=20
> Your subject and commit message looks definitely good now, thanks! I
> added your patch to my testing branch.
>=20
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

//Peter


