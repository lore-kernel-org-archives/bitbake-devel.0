Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A6C28CF5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 09:57:43 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.10837.1643191061615949642
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jan 2022 01:57:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Ch+pihql;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643191062;
  x=1674727062;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=a7HkMjuxTa8em3C/Ps5rLmA7XSFOSj272jbeXJ15Pbw=;
  b=Ch+pihqlBiIb0WLeDRT3ZcFlnlzfabZAbZzFqJAEWCDfxkWt+qLJEdIy
   pJPk/5B2sGxfS8qbKPqdHzvgIBLvTzwhowaTwpS5p/g52L1tijk7JutXe
   xSFHYqjjtBuISHRE8fMotfGmwoEdgdUPuuLpaX8r8EqaZiUIOC6s/mVNp
   rgy249deu70qc3Ki7cV+WmNcuV6VAiPKksaoco6bgVfrW+/7KyUBxMnkL
   9dG30D01XnEC4TOS7h2eIuyhc/4TNE3CN8PgHkot8nMw1hx2UvCI4NELm
   yyq2L3vvrIuwhTSkIWRY/4aLFxwufuOwHG+jzNtur0T/JOIQuIEGf4Ynp
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Trevor Woerner <twoerner@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] knotty: improve the UI information
Thread-Topic: [bitbake-devel] [PATCH] knotty: improve the UI information
Thread-Index: AQHYElJ4tceEoWI+s06Mf4TNHUujAKx0hwLA
Date: Wed, 26 Jan 2022 09:57:38 +0000
Message-ID: <456a90b823214b2685283370409e1f7a@axis.com>
References: <20220126011708.24391-1-twoerner@gmail.com>
In-Reply-To: <20220126011708.24391-1-twoerner@gmail.com>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Jan 2022 09:57:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13284

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Trevor Woerner
> Sent: den 26 januari 2022 02:17
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] knotty: improve the UI information
>=20
> During a build you might end up with bitbake telling you:
>=20
> 	Currently 30 running tasks (2757 of 2757/3476 of 6390)
>=20
> Which, to me, is really confusing. For one the forward slash separator
> and the two numbers immediately on each side of which are likely to be
> interpreted as being one unit (i.e. 2757/3476) but they're not.
>=20
> Add labels, spaces, etc. to help clarify the information bitbake is tryin=
g to
> convey.

While I agree with what you are trying to achieve, the suggested line=20
is very verbose. If my calculations are correct, that leaves only 5-7=20
characters for the progress bar in an 80 character window. Here is the=20
original line:

Currently 99 running tasks (12345 of 12345/12345 of 12345) 100% |##########=
####|
No currently running tasks (12345 of 12345/12345 of 12345) 100% |##########=
####|

And here is the updated one:

Currently 99 running tasks (setscene:12345/12345 tasks:12345/12345) 100% |#=
####|
No currently running tasks (setscene:12345/12345 tasks:12345/12345) 100% |#=
####|

Dropping "Currently ", which is not really needed, would be a start.=20
That would also give the "No running tasks ..." variant the same=20
formatting:

99 running tasks (setscene:12345/12345 tasks:12345/12345) 100% |###########=
####|
No running tasks (setscene:12345/12345 tasks:12345/12345) 100% |###########=
####|

Personally, I would have preferred the even terser form, since I know=20
what those numbers represent:

99 running tasks (12345/12345, 12345/12345) 100% |#########################=
####|
No running tasks (12345/12345, 12345/12345) 100% |#########################=
####|

but that might be too much to ask. And I don't have good alternatives=20
to "setscene" and "tasks".

(And if anybody wonders, I love watching those progress bars move=20
across the window, which is why I don't want them reduced to only a=20
few characters.) ;)

//Peter

>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  lib/bb/ui/knotty.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 484545a6..1150a6ab 100644
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
>              else:
> -                content =3D "Currently %2s running tasks (%s of %s/%s of=
 %s)" % (len(activetasks), self.helper.setscene_current, self.helper.setsce=
ne_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
> +                content =3D "Currently %2s running tasks (setscene:%s/%s=
 tasks:%s/%s)" % (len(activetasks), self.helper.setscene_current, self.help=
er.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_t=
otal)
>              maxtask =3D self.helper.tasknumber_total
>              if not self.main_progress or self.main_progress.maxval !=3D =
maxtask:
>                  widgets =3D [' ', progressbar.Percentage(), ' ', progres=
sbar.Bar()]
> --
> 2.34.1.75.gabe6bb3905


