Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.38016.1608551873454250159
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Dec 2020 03:57:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=F/6HBkQK;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1608551873;
  x=1640087873;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6rsZNf8Zs0/iCzV18TIShSB4Snmgm61lwVjwSlUbtmw=;
  b=F/6HBkQKOSbAXiYpSfbxrBcyeskInOsVsWlQmQ+fCBOg8JNky/RzD5La
   O80dxKjvM3oWZpz25aTU/5FOewGezN8sorWdys4G1f46k9UMEmePR4DQO
   TKliiv2DMkyJSKXhevHyqYhWUDrDlh9/c41O7XcqZvH/MJzTJ29PZcqgn
   iSqmt8wf2TWmOMG97neufHTEiKnxahfNaDtM8tW/dJQH6g5aUwdneEL/r
   LJ8vNeeowjYKM/G3ntlElqA5BgWhAMJlGG5Fxrg88A4nLJtnRcrkFZ1OL
   tFunzNzMHYfqI1MjZH29ZdKwIaEMg/dxNDphCyErLRxJ5OkLL0YGgPZuF
   w==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] cooker: Include all packages a recipe provides in SkippedPackage.rprovides
Thread-Topic: [bitbake-devel] [PATCH 2/2] cooker: Include all packages a
 recipe provides in SkippedPackage.rprovides
Thread-Index: AQHWzOFya8GdC6IY70Ko6Uu+l3RaBaoBhyng
Date: Mon, 21 Dec 2020 11:57:50 +0000
Message-ID: <36393b2bd2584d6ba897b7b54b667e51@XBOX03.axis.com>
References: <20201207213851.3485-1-pkj@axis.com>
 <164E8D0394A02FDA.16914@lists.openembedded.org>
In-Reply-To: <164E8D0394A02FDA.16914@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

*ping*

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
