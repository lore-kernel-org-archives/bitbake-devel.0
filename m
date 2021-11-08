Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC67C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 18:37:29 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.715.1636396647759354534
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 10:37:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Q7mmneqQ;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1636396648;
  x=1667932648;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hnNgnoirHwPx8BO6uM3z6h+Lx2xEOqog97rlTStklCs=;
  b=Q7mmneqQ4vbmEsIeeK8yLXk/w16kwMJd+nZbGkWfwZrq9OaE8imgEhLW
   2GY6jePBT3EWD2LNl/HQcjmJmgNgY6jVkEJPSmpR7o/XDM0mZZkCjEDwh
   WLtEvNaRJ+36hr7xP973lriGtfQOVeBCFpxGPbpR0P2JXq79+3EbaIfM5
   XH/L63nFXWtO7u4q7nPvUsRdx+u7vRakGSBv0PCSgtV+W5bRa8XIALv7Q
   ij3Y8jd/gLbeThFB1eSa9YCW6GgdpXgi8SrNYlO74djqE7W2hOWDomnKJ
   xjWUnuwCnTmwacaBVJDhNL/MXCwssiQSmTX55w/QdoRzoyJ3EeyB5H7rg
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] runqueue: Fix runall option handling
Thread-Topic: [bitbake-devel] [PATCH] runqueue: Fix runall option handling
Thread-Index: AQHX1L2sIk0psSmaDk683A6A+Wp9sav59V8w
Date: Mon, 8 Nov 2021 18:37:24 +0000
Message-ID: <f66cdbb0b09c49d491bbcbf9abfe5c55@axis.com>
References: <20211108162823.3736163-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20211108162823.3736163-1-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 18:37:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12948

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 8 november 2021 17:28
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] runqueue: Fix runall option handling
>=20
> The previous fix for runall option handling had a small but in it, it

Typo: but -> bug

//Peter

> didn't clear the originally processed task list which meant it was runnin=
g
> too many tasks. Fix this so the list is reset and rebuild correctly.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 7d4cbed775..957c2d1806 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -933,6 +933,7 @@ class RunQueueData:
>              for tid in list(self.runtaskentries.keys()):
>                  if tid not in runq_build:
>                     reduced_tasklist.remove(tid)
> +            runq_build =3D {}
>=20
>              for task in self.cooker.configuration.runall:
>                  if not task.startswith("do_"):
> --
> 2.32.0


