Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4A9C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 20:29:13 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.3504.1643315351716656560
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 12:29:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=plQ9Owk7;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643315353;
  x=1674851353;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=jTuWXaZcEMk6zCakWQ43SciYpW62knIIz9k2iCQp3Xw=;
  b=plQ9Owk7lQsumddjtz1cJvvBCAMV0sJDr84Al7Vu7VgRAc+WV3dPkwsB
   llQ6CuXegnTlHPkhysBEUOAb9bm0I8vWmhwjbO9mD2j35G+ncABMlGTwp
   P+jyuc/s8C5CL0pyzqJRR7fV6CC38dJ3s7C3ISptK28YQb09SK81cZhwv
   xJL1DdqkBu15hf3im4U1y4eZ/FXjqQbdqAzBe89p2L0l/uyoPabPiAW9k
   GJGu4s/2HVa2H90Zpt8UlpvOUabpDjvkXl/EWOsno5Bpmqn0MULNpewYd
   jKOWVPkfk2qBXt87kGKnVE65WjRRls5FrlJlOfAAyEGPBampQ7BkMkF2x
   Q==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Trevor Woerner <twoerner@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v2] knotty: improve the UI information
Thread-Topic: [bitbake-devel] [PATCH v2] knotty: improve the UI information
Thread-Index: AQHYE7usM+HDB4uD1kmw5V+DC3CLtax3UE3Q
Date: Thu, 27 Jan 2022 20:29:09 +0000
Message-ID: <e8194a2929c44c62bd7865c7586260e6@axis.com>
References: <20220127202243.26972-1-twoerner@gmail.com>
In-Reply-To: <20220127202243.26972-1-twoerner@gmail.com>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jan 2022 20:29:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13292

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Trevor Woerner
> Sent: den 27 januari 2022 21:23
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH v2] knotty: improve the UI information
>=20
> During a build you might end up with bitbake telling you:
>=20
> 	Currently 30 running tasks (2757 of 2757/3476 of 6390)
>=20
> Which, to me, is really confusing. The forward slash separator and the tw=
o
> numbers immediately on each side of which are likely to be interpreted as
> being one unit (i.e. 2757/3476) but they're not. Also nothing is labeled,
> leaving the user to wonder what these numbers are.
>=20
> Add labels, spaces, etc. to help clarify the information bitbake is tryin=
g to
> convey. The resulting line would appear as:
>=20
> 	30 running tasks (setscene:2757/2757 tasks:3476/6390)
>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes since v1:
> - improve the commit message
> - remove the redundant word "Currently" in order to help keep the total
>   line length manageable for users of 80-column terminals
> ---
>  lib/bb/ui/knotty.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 484545a6..c2a7d06e 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -276,11 +276,11 @@ class TerminalFilter(object):
>              print(content)
>          else:
>              if self.quiet:
> -                content =3D "Running tasks (%s of %s/%s of %s)" % (self.=
helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber=
_current, self.helper.tasknumber_total)
> +                content =3D "Running tasks (setscene:%s/%s tasks:%s/%s)"=
 % (self.helper.setscene_current, self.helper.setscene_total, self.helper.t=
asknumber_current, self.helper.tasknumber_total)
>              elif not len(activetasks):
> -                content =3D "No currently running tasks (%s of %s/%s of =
%s)" % (self.helper.setscene_current, self.helper.setscene_total, self.help=
er.tasknumber_current, self.helper.tasknumber_total)
> +                content =3D "No currently running tasks (setscene:%s/%s =
tasks:%s/%s)" % (self.helper.setscene_current, self.helper.setscene_total, =
self.helper.tasknumber_current, self.helper.tasknumber_total)

Remove "currently" to keep the formatting consistent.

>              else:
> -                content =3D "Currently %2s running tasks (%s of %s/%s of=
 %s)" % (len(activetasks), self.helper.setscene_current, self.helper.setsce=
ne_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
> +                content =3D "%2s running tasks (setscene:%s/%s  tasks:%s=
/%s)" % (len(activetasks), self.helper.setscene_current, self.helper.setsce=
ne_total, self.helper.tasknumber_current, self.helper.tasknumber_total)

Remove one of the two spaces between setscene:%s/%s and tasks:%s/%s=20
to keep the formatting consistent.

>              maxtask =3D self.helper.tasknumber_total
>              if not self.main_progress or self.main_progress.maxval !=3D =
maxtask:
>                  widgets =3D [' ', progressbar.Percentage(), ' ', progres=
sbar.Bar()]
> --
> 2.34.1.75.gabe6bb3905

//Peter


