Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E62DC4167B
	for <webhook@archiver.kernel.org>; Fri, 30 Dec 2022 15:44:34 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.20723.1672415071119811657
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Dec 2022 07:44:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=g3jFSm1q;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672415071;
  x=1703951071;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lcjkEOSKo/eo8FQuXcZQQ6/TUPjUl7IW4YBfiQyGqUY=;
  b=g3jFSm1qYtsZZt3UFqyu8HKcnLzxoab/h5b2Vzw8hgOJ6ISczvYrZkaT
   tB/K8jhqAYmGM9mSTZea3yNzDxKaNWUFCbv4yTMKsorTY95mPLCC7wt45
   58jzmyKFX/Wx60/D2bdMYDlDMujIJAA27vGV+rCANEnBpj1oQEd71KRrn
   nvU5Dvd/BqI7ZVrw9NMOBFuiNEu/gpiV+8dZrQCRIyQUtw+g+k4Y+z8TF
   +452OTThVNv24bH7Dr7pID1HvWWiPCQZDMzW0g1W3FLcxtQpadphMppuO
   WjtKw1ntSGoOqYn2v0D0BDiZrU1WChShaO2UPKQWfxHUKE4K9LeAi1Mqw
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 03/15] knotty: Ping the server/cooker
 periodically
Thread-Topic: [bitbake-devel] [PATCH 03/15] knotty: Ping the server/cooker
 periodically
Thread-Index: AQHZG6gUWwj7UuAFPk+ehS9R1tc1Pq6GkvvA
Date: Fri, 30 Dec 2022 15:44:28 +0000
Message-ID: <616e8bd535e74fd39d8ed3dab0840249@axis.com>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
 <20221229170728.880367-4-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221229170728.880367-4-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Dec 2022 15:44:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14259

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 29 december 2022 18:07
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 03/15] knotty: Ping the server/cooker per=
iodically
>=20
> We've seeing failures where the UI hangs if the server disappears. Ping

Change " We've seeing" to either "We're seeing" or "We've seen".

> the cooker/server if we've not had any events in the last minute so we ca=
n
> check if it is still alive.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/ui/knotty.py | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 61cf0a37f4..ab1a367be0 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -625,7 +625,8 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
>=20
>      printintervaldelta =3D 10 * 60 # 10 minutes
>      printinterval =3D printintervaldelta
> -    lastprint =3D time.time()
> +    pinginterval =3D 1 * 60 # 1 minutes

Change "1 minutes" to "1 minute".

> +    lastevent =3D lastprint =3D time.time()
>=20
>      termfilter =3D tf(main, helper, console_handlers, params.options.qui=
et)
>      atexit.register(termfilter.finish)
> @@ -637,6 +638,14 @@ def main(server, eventHandler, params, tf =3D Termin=
alFilter):
>                  printinterval +=3D printintervaldelta
>              event =3D eventHandler.waitEvent(0)
>              if event is None:
> +                if (lastevent + pinginterval) <=3D time.time():
> +                    ret, error =3D server.runCommand(["ping"])
> +                    if error or not ret:
> +                        termfilter.clearFooter()
> +                        print("No reply after pinging server (%s, %s), e=
xiting." % (str(error), str(ret)))
> +                        return_value =3D 3
> +                        main.shutdown =3D 2
> +                    lastevent =3D time.time()
>                  if main.shutdown > 1:
>                      break
>                  if not parseprogress:
> @@ -644,6 +653,7 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
>                  event =3D eventHandler.waitEvent(0.25)
>                  if event is None:
>                      continue
> +            lastevent =3D time.time()
>              helper.eventHandler(event)
>              if isinstance(event, bb.runqueue.runQueueExitWait):
>                  if not main.shutdown:
> --
> 2.37.2

//Peter


