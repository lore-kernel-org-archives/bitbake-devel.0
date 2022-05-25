Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F5BC433F5
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 18:53:17 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.10756.1653504795593497541
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 May 2022 11:53:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=jEAPGq1/;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1653504796;
  x=1685040796;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=a+icPKV/9Wp4D7ucJkHK7Hl0XztUembwR9WlrLs8bck=;
  b=jEAPGq1/AZHzXhzz/2D+DtOwnJK1MaGgpggHN8oQpLbjfsZ1xivnNmDt
   DD/Y7axNq5zKNpP2tyG+IrEuIp2dQItTPzGFFR9o3VVc48k5rJjKp6RBp
   emko/WnRR2ZYsE+iS4L5QUJ10D/bvbXdmYc6YH8wPhkR/iKbgm5lht63S
   FKI/oifeO0KtE+Wbk8LNHqR7AHIEA0dldZ8qq9Nwct4/ElXfsLGEA/9oL
   9wSWNDWWNbS7+lOcfxtgffw/c9qTU/MZy9u2LjLXvcUURbLWZtRgVJ7sH
   f+pNTb0ETCY4OaO/NETMwqQDwV3dfj40o3zl+cXXlno3S0pkyodaiS8px
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Reyna, David" <david.reyna@windriver.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
Thread-Topic: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
Thread-Index: AQHYcAAm4OQt25afr0OENtumUZKtGK0v7q/w
Date: Wed, 25 May 2022 18:53:13 +0000
Message-ID: <b17960eece2c4985b066539792242c23@axis.com>
References: <cover.1653448549.git.David.Reyna@windriver.com>
In-Reply-To: <cover.1653448549.git.David.Reyna@windriver.com>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 25 May 2022 18:53:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13714

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Reyna, David
> Sent: den 25 maj 2022 08:25
> To: bitbake-devel@lists.openembedded.org
> Cc: David Reyna <David.Reyna@windriver.com>
> Subject: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of taskexp.=
py
>=20
> From: David Reyna <David.Reyna@windriver.com>
>=20
>=20
> Added since demo at YP Summit:
>  * Protection against window resizing
>  * Line art (with ASCII line art as backup)
>  * Additional internal documentation
>  * Tested against misspelled recipe errors
>=20
>=20
> The following changes since commit 13d70e57f8693e506aada946ae9b2e0997e4c5=
f0:
>=20
>   migration guides: release notes for 3.4.3 and 3.4.4 (2022-05-24 13:58:4=
7 +0100)
>=20
> are available in the Git repository at:
>=20
>   git://push.yoctoproject.org/poky-contrib dreyna/bitbake/ncurses_taskexp=
_14814
>=20
> David Reyna (1):
>   bitbake: ncurses version of taskexp.py
>=20
>  lib/bb/ui/taskexp_cli.py | 1302 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1302 insertions(+)
>  create mode 100755 bitbake/lib/bb/ui/taskexp_cli.py
>=20
> --
> 2.35.1

May I suggest using a name that does not include "cli", because as I see it=
,=20
this has nothing to do with a command line interface, rather it is a text=20
based UI. More appropriate may be something like "tty" or "ncurses". Or to=
=20
complement "knotty", you could call it "tetty". ;) (Though I guess it may b=
e=20
harder to remember what that does compared to "taskexp_tty".)

//Peter


