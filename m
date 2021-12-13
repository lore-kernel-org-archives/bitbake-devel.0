Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D017C433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Dec 2021 17:33:37 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.14197.1639416814956794166
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 09:33:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=nIV8XFPZ;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639416816;
  x=1670952816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kRPMjSBd54INFtclHdhWMZ2k7vBz8CX1fyGo7p4tlpw=;
  b=nIV8XFPZTw6vOSeuMrpaJ+sVEVBANJak5pS7/R6MoIT1FHXMYM9U7xcf
   wrRpBBl1DxQ993dJKNBTVm0XlVvg3A+smrttF26QNEwESjn36R1Hwz1C8
   CBFGh1yIvoE2DcRvSQ5n3qIAidsb4UEjQj8cOZEOdLO1BLR+g3NvaZ73t
   y5BKNhbVewhvjNF6l1BQ4IHC2eBQ3XMmXRR1V2GHYfq4JWMTmOwSkeQYv
   oCemaMuI3VTvD5XFqdrkchP+JkO0m8ee/8rMMf0wUSilEGo+sXjVFGP0c
   /urHEd7LzCRIoj2+7VmavhqCZ+gfBupmrF8oIOKhunjF2O880laynq6uJ
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: RE: [bitbake-devel] [PATCH 2/2] fetch: npm: Use temporary file for
 empty user config
Thread-Topic: [bitbake-devel] [PATCH 2/2] fetch: npm: Use temporary file for
 empty user config
Thread-Index: AQHX8BKdNZROTWa3G06A+FHjCPavAKwwrjwQ
Date: Mon, 13 Dec 2021 17:33:32 +0000
Message-ID: <9941fd47aaad4824b8311084e55d8817@axis.com>
References: 
 <20211213111353.28402-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20211213111353.28402-2-stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: 
 <20211213111353.28402-2-stefan.herbrechtsmeier-oss@weidmueller.com>
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
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Dec 2021 17:33:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13151

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Stefan Herbrechtsmeier
> Sent: den 13 december 2021 12:14
> To: bitbake-devel@lists.openembedded.org
> Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
> Subject: [bitbake-devel] [PATCH 2/2] fetch: npm: Use temporary file for e=
mpty user config
>=20
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> Always use a temporary file for the user config 'NPM_CONFIG_USERCONFIG'
> because npm overwise failed if configs and npmrc isn't set:

Change "overwise failed" to "otherwise fails", and change "isn't" to=20
"aren't".

//Peter

>=20
> double-loading config "/dev/null" as "global", previously loaded as "user=
"
>=20
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
>=20
> ---
>=20
>  lib/bb/fetch2/npm.py | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index d9daec20..b3a3a444 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -79,16 +79,12 @@ class NpmEnvironment(object):
>      Using a npm config file seems more reliable than using cli arguments=
.
>      This class allows to create a controlled environment for npm
> commands.
>      """
> -    def __init__(self, d, configs=3DNone, npmrc=3DNone):
> +    def __init__(self, d, configs=3D[], npmrc=3DNone):
>          self.d =3D d
>=20
> -        if configs:
> -            self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w",
> buffering=3D1)
> -            self.user_config_name =3D self.user_config.name
> -            for key, value in configs:
> -                self.user_config.write("%s=3D%s\n" % (key, value))
> -        else:
> -            self.user_config_name =3D "/dev/null"
> +        self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w",
> buffering=3D1)
> +        for key, value in configs:
> +            self.user_config.write("%s=3D%s\n" % (key, value))
>=20
>          if npmrc:
>              self.global_config_name =3D npmrc
> @@ -109,7 +105,7 @@ class NpmEnvironment(object):
>                  workdir =3D tmpdir
>=20
>              def _run(cmd):
> -                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " %
> (self.user_config_name) + cmd
> +                cmd =3D "NPM_CONFIG_USERCONFIG=3D%s " %
> (self.user_config.name) + cmd
>                  cmd =3D "NPM_CONFIG_GLOBALCONFIG=3D%s " %
> (self.global_config_name) + cmd
>                  return runfetchcmd(cmd, d, workdir=3Dworkdir)
>=20
> --
> 2.30.2


