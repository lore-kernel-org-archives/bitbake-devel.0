Return-Path: <mikko.rapeli@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E143C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 07:38:13 +0000 (UTC)
Received: from esa8.hc324-48.eu.iphmx.com (esa8.hc324-48.eu.iphmx.com
 [207.54.65.242])
 by mx.groups.io with SMTP id smtpd.web08.15584.1661153890931160149
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 00:38:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=OkNNP6pA;
 spf=pass (domain: bmw.de, ip: 207.54.65.242,
 mailfrom: prvs=226cd0590=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1661153891; x=1692689891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FJmagnZEQSCIp+kMO76KHHNmuHIJEE1Wau+PZ6Wsb9c=;
  b=OkNNP6pAxZ8HvcjRB9WbFjo9vLCC/BAZLrdLePE5Jb8kRd9GPbgDYW9J
   TDOts9Y75IYBGUxBoahetnTNgkS+4GVVf2Ry4/XdRCTZHKpfGLv5Yidpm
   XVcBTpidQZYaAcCcARefVIBcUz5pukZ2EBgZp5cxgr2Ui2HNiWtHjC/9P
   8=;
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa8.hc324-48.eu.iphmx.com with ESMTP/TLS; 22 Aug 2022 09:38:09 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw4.muc with ESMTP/TLS;
 22 Aug 2022 09:38:09 +0200
Received: from smucmp08b.bmwgroup.net (HELO SMUCMP08B.europe.bmw.corp)
 ([10.30.13.68])
 by esabb4.muc with ESMTP/TLS; 22 Aug 2022 09:38:09 +0200
Received: from SMUCMP08E.europe.bmw.corp (2a03:1e80:a15:58f::1:24) by
 SMUCMP08B.europe.bmw.corp (2a03:1e80:a15:58f::22fd) with Microsoft SMTP
 Server (version=TLS; Mon, 22 Aug 2022 09:38:08 +0200
Received: from SMUCMP08E.europe.bmw.corp ([10.30.13.71]) by
 SMUCMP08E.europe.bmw.corp ([10.30.13.71]) with mapi id 15.02.0922.027; Mon,
 22 Aug 2022 09:38:08 +0200
From: <Mikko.Rapeli@bmw.de>
To: <alex.kanavin@gmail.com>
CC: <Martin.Jansa@gmail.com>, <bitbake-devel@lists.openembedded.org>,
	<marex@denx.de>, <peter.kjellerstedt@axis.com>,
	<richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Topic: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Index: AQHYs+yI6ZkxFnyDGU+Z/Quo9ksiHa23kU2AgAKy7wCAABsxgIAAC28A
Date: Mon, 22 Aug 2022 07:38:08 +0000
Message-ID: <YwMyXi/vfRh3S6bx@korppu>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <638F150AB40C924A8BFBCA17CB178BC7@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 07:38:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13912

On Mon, Aug 22, 2022 at 08:57:11AM +0200, Alexander Kanavin wrote:
> Can be solved with a parameter to a fetcher perhaps?

Frequently developers know to change the git URL in recipes from
"branch=3Dmaster" to "nobranch=3D1" for their test commits.

This could be used for fetching the changes too, to limit the scope.

Cheers,

-Mikko=

