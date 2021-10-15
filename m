Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C34C433F5
	for <webhook@archiver.kernel.org>; Fri, 15 Oct 2021 13:23:29 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.9238.1634304207838875091
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Oct 2021 06:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=ZG+cNYeG;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1634304208;
  x=1665840208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tCFu98HRx4r/x9IUtm9+GvdVG9hfPXgjfwmCLJdJwac=;
  b=ZG+cNYeGlwTKAPaojxIp7kv4291RusjzOKL1ABisFrBitL1YTzsEdj2A
   OPcH7wpi1MwWgVlex9N6si7FCfvMZWw4OrWbmAOVh9BafuchNw7RRO9MC
   PBBQmaKijxpScg/U5y82ncKIH1VjK53vlyQ12Z/yf5uW3FFhM4QmintyO
   ERlzmHZldtEPoczHuauyEkqNxUQpoPwAakPhYiqt1vA86IXcZIdC6nR7C
   2G9bbjo5d7cN1nP52PWnlXvWveg8M+a3v09tKIFfjwgCUckf4YTzOoPiu
   FW4wv9eFjmFaydQILLwC78W0pRR0OeHfDpua6x22TKP0ZL7dW6mIS5B0o
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Scott Weaver <weaverjs@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
CC: Chen Qi <Qi.Chen@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH] fetch2: fix downloadfilename issue with
 premirror
Thread-Topic: [bitbake-devel][PATCH] fetch2: fix downloadfilename issue with
 premirror
Thread-Index: AQHXwYxoEzLa6WXuAE6qios7E/cWSqvTzNwAgAAZ3QCAACMzEA==
Date: Fri, 15 Oct 2021 13:23:24 +0000
Message-ID: <7adc2cf47b594660ba47904da244275c@axis.com>
References: <20211015061753.70640-1-Qi.Chen@windriver.com>
 <582824039f6ac8e11b9a5ff91256ee591372c1ec.camel@linuxfoundation.org>
 <YWl9LqGlSO+eB7Kp@popos>
In-Reply-To: <YWl9LqGlSO+eB7Kp@popos>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Oct 2021 13:23:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12785

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Scott Weaver
> Sent: den 15 oktober 2021 15:08
> To: Richard Purdie <richard.purdie@linuxfoundation.org>
> Cc: Chen Qi <Qi.Chen@windriver.com>; bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel][PATCH] fetch2: fix downloadfilename issue
> with premirror
>=20
> On 21-10-15 12:35:24, Richard Purdie wrote:
> > On Thu, 2021-10-14 at 23:17 -0700, Chen Qi wrote:
> > > The following commit to fix [Yocto #13039] causes regression of
> > > the behavior of PREMIRRORS.
> > >
> > >   "bitbake: fetch2: fix premirror URI when downloadfilename defined"
> > >
> > > Take meta-openembedded/meta-networking/recipes-
> protocols/freediameter/freediameter_1.4.0.bb
> > > as an example.
> > > SRC_URI =3D "\
> > >
> http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloa=
d
> filename=3D${fd_pkgname}-${PV}.tar.gz \
> > >     ...
> > > "
> > > With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
> > > freeDiameter-1.4.0.tar.gz. This makes
> https://downloads.yoctoproject.org/mirror/sources
> > > not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.
> > >
> > > The commit above tries to avoid fetching from invalid url such as:
> > > https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
> > > And its solution is to make basename to be 1.4.0.tar.gz, thus causing
> the
> > > regression.
> > >
> > > This patch fixes the above regression. For Yocto #13039, it now tries
> > > to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.
> > >
> > > Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> > > ---
> > >  lib/bb/fetch2/__init__.py | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > > index 666cc1306..000b49a50 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace,
> replacements, d, mirrortarball=3DNone):
> > >                      # Kill parameters, they make no sense for mirror
> tarballs
> > >                      uri_decoded[5] =3D {}
> > >                  elif ud.localpath and
> ud.method.supports_checksum(ud):
> > > -                    basename =3D os.path.basename(uri_decoded[loc])
> > > -                if basename and not
> result_decoded[loc].endswith(basename):
> > > -                    result_decoded[loc] =3D
> os.path.join(result_decoded[loc], basename)
> > > +                    basename =3D os.path.basename(ud.localpath)
> > > +                if basename:
> > > +                    uri_basename =3D os.path.basename(uri_decoded[lo=
c])
> > > +                    if basename !=3D uri_basename and
> result_decoded[loc].endswith(uri_basename):
> > > +                        result_decoded[loc] =3D
> result_decoded[loc].replace(uri_basename, basename)
> > > +                    elif not result_decoded[loc].endswith(basename):
> > > +                        result_decoded[loc] =3D
> os.path.join(result_decoded[loc], basename)
> > >          else:
> > >              return None
> > >      result =3D encodeurl(result_decoded)
> >
>=20
>=20
> Hi Richard and Chen,
>=20
> > I've been meaning to reply to this thread as the regression wasn't good=
.
> We need
> > to be able to use DL_DIR as a mirror.
>=20
> It's my understanding that DL_DIR is always the last mirror attempted if
> downloading the artifact from a SRC_URI, MIRRORS and PREMIRRORS fails.
> In my testing, this still works.
>=20
> What we're saying is that we want to be able to copy or use an exiting
> DL_DIR as a PREMIRROR.

This is basically what the (relatively new) mirror mode of the=20
archiver.bbclass does.

> If this is the use case then, yes, this is a regression but I'm just a
> little confused because I always think of a mirror as just being an
> alternate site where the artifact defined in the SRC_URI can be found.
>=20
> Once that artifact is found and downloadfilename is defined it should
> save the artifact using the name defined in downloadfilename.
>=20
> My apologies for not understanding that downloadfilename also needs to
> be tried when attempting to download from a premirror. I was going by thi=
s
> definition:
>=20
> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#var=
-
> SRC_URI
>=20
> --
>   - Scott

What's important to remember is one of the reasons for using downloadfilena=
me=20
is to support different files with the same name but from different sites=20
being downloaded. This needs to work whether the file is fetched from the=20
original source, a (PRE)MIRROR or the DL_DIR, without the files overwriting=
=20
each other.

//Peter



