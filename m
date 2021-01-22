Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.14598.1611344317237703930
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Jan 2021 11:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=KN75zvaz;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1611344317;
  x=1642880317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bALjND22NaY2HTxuXIgFGkql5qaQ6qJ7gCESAlkx6UE=;
  b=KN75zvazz4auusJ1GrCpGBhwZ+qeYPcDLGfzY8GTVLCZHy5cE99tuKoN
   xgPdb3n3EhXvVFEwcAQaI4WSuf1UoK4N95CpXhMxW2+wyVmeSWjfP4s9M
   QWF9+k8+jN+/LBuVPvfnw/C+4BKTEeLbIUAIz6UER27IV9y1d4PQKyarH
   flpLLh6xgEo/pejOueJQrfS2C7CeYTR4U0h2mazCTfuBNcXI4Jxiucwxc
   a0HBtPS3A0tJviIEwBOh9bxkJXThACrkBcqGVWLVt5JXhYYh+m0Ob3XDx
   1YnspnAHnkGIEYWIYcFgG/bF2c5c4rZzMmbPu/nnmGhVDKmyvV7ZRDOFq
   w==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: Steve Sakoman <steve@sakoman.com>, "Mittal, Anuj" <anuj.mittal@intel.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] cooker: Include all packages a recipe provides in SkippedPackage.rprovides
Thread-Topic: [bitbake-devel] [PATCH 2/2] cooker: Include all packages a
 recipe provides in SkippedPackage.rprovides
Thread-Index: AQHWzOFya8GdC6IY70Ko6Uu+l3RaBao0UIyQ
Date: Fri, 22 Jan 2021 19:38:34 +0000
Message-ID: <988a93ff67e74345881df1bbb3990a17@XBOX03.axis.com>
References: <20201207213851.3485-1-pkj@axis.com>
 <164E8D0394A02FDA.16914@lists.openembedded.org>
In-Reply-To: <164E8D0394A02FDA.16914@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Return-Path: peter.kjellerstedt@axis.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Can these two bitbake patches be backported to Dunfell and Gatesgarth?

93d01614565bd540d05fbc1791dd66e46723d683
efd026c26a377b826a49b945a8212bf7de8a480a

For Gatesgarth they should apply without any conflicts.
For Dunfell there is a conflict in bitbake/lib/bb/cache.py due=20
to __cache_version__ having changed.

//Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 7 december 2020 22:39
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 2/2] cooker: Include all packages a
> recipe provides in SkippedPackage.rprovides
>=20
> The provided packages by a skipped recipe are supposed to be listed in
> SkippedPackage.rprovides, which is used when generating a meaningful
> error message when a build fails because of a skipped package.
> Previously this variable only contained the contents of ${RPROVIDES}.
> However, most recipes don't define RPROVIDES, they define
> RPROVIDES_<pkg> for each package they provide. Additionally, the recipe
> provides the packages in PACKAGES without them being included in
> ${RPROVIDES}.
>=20
> Before this change, having a runtime dependency on a skipped non-recipe
> package would result in a build error stating that the build failed
> because the package was skipped, but without providing any reason for
> why it was skipped.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/cooker.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 1f4cc1e96d..83cfee7fb4 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -73,7 +73,9 @@ class SkippedPackage:
>              self.pn =3D info.pn
>              self.skipreason =3D info.skipreason
>              self.provides =3D info.provides
> -            self.rprovides =3D info.rprovides
> +            self.rprovides =3D info.packages + info.rprovides
> +            for package in info.packages:
> +                self.rprovides +=3D info.rprovides_pkg[package]
>          elif reason:
>              self.skipreason =3D reason
>=20
