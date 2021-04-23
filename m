Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.2164.1619196079840349776
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 09:41:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=BSJmlkg+;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id g9so32977156wrx.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Apr 2021 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n9zldnP/hKa4nP9JJ1mHuCjoPXJkS2AQq2X3874W0eo=;
        b=BSJmlkg+0tWinMtZ0jI/uMfTlqwdlHuH6vNUTGYIUGnn3I2t1gSmsT/GShe0MACnBR
         OvXpGpgD+xiCOgsLBchsvB0RaRfa/61BNrvc0LHLY+rJfTpquVeAx0baFaL63o9qRgW7
         m4jtdasut2qMFt9vodaAPVR7ytSIFJb7qHUIQli0Qf0d/yqyAZ3g4VJm2UKKMY1heTNd
         UsDX74G7XLbiYyS9FoN7fVQCoDGe1Kxf/vWe4Bhzq10SdTneQj8McMhZJT4ICporfbE7
         MKOjz0ivLjVU5uIYsUV204tFHgrtjw2QG+RNXDiHWF20UQmTSfOo95c8tK8vFWgAVhyj
         N2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9zldnP/hKa4nP9JJ1mHuCjoPXJkS2AQq2X3874W0eo=;
        b=I4jDL73c4/r6PPakmbiEUZtg6THQ5iaxDi+d7bIXK+hqV4D1CW0LAVIQbfKtj74wNd
         j83AzFdyFfUka2yby0CkniaZc67Bdv3pyhBC7mWbQ/wSr9YROow+tSU0vVVn1H+byrDc
         zYaYzGCN73LXY3PCS/3JlBgHYhHmp2J0wKxq+a+6vvMfwne6xb+PJ0LBIbn72Sx7ryfj
         juXHQtgqnGTNKoFoRreq13YG4e+h7JQ+Xrq8pdFuC9Sy3gDzcjOwFcwFGSuWelN3URTN
         JH1wan6xtxKO1BSDtV0pV41hU1R8SybSxJtCg8ww3UYKFrNVGgoW+JyYAuQN4ECONIaY
         9MxA==
X-Gm-Message-State: AOAM532NSWc6Sqq8nX2kNd9wQWu21bcfXGH/tdXd1a4yrF9kf7zWxltG
	dQodimOOx5vGoCO0QEjH3sk=
X-Google-Smtp-Source: ABdhPJzovvVTSuhikqa1DfkM1OIjfcs4rSo2/c6qmQBYEofFPqp+isFzC/Wb2EC2QtlkVSc/ViZWxg==
X-Received: by 2002:a5d:4acf:: with SMTP id y15mr5751446wrs.245.1619196078354;
        Fri, 23 Apr 2021 09:41:18 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id q20sm37866146wmq.2.2021.04.23.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:41:17 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Fri, 23 Apr 2021 18:41:17 +0200
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [PATCH] README: update/fix contribution guidelines
Message-ID: <20210423164117.xf4qafojdrqrezll@jama>
References: <20210423163108.338904-1-michael.opdenacker@bootlin.com>
 <167889E551A803AE.3436@lists.openembedded.org>
MIME-Version: 1.0
In-Reply-To: <167889E551A803AE.3436@lists.openembedded.org>
X-Groupsio-MsgNum: 12243
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c63kaheubfjelyg4"
Content-Disposition: inline

--c63kaheubfjelyg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2021 at 06:34:41PM +0200, Martin Jansa via lists.openembedd=
ed.org wrote:
> On Fri, Apr 23, 2021 at 06:31:08PM +0200, Michael Opdenacker wrote:
> > - Ask to CC the docs@lists.yoctoproject.org mailing list
>=20
> it adds 2nd --to
>=20
> which is probably fine, just doesn't match with commit message

And more surprisingly this e-mail to docs@lists.yoctoproject.org was
rejected with:


Message not delivered
Your message couldn't be delivered to docs@lists.yoctoproject.org
because the remote server is misconfigured. See technical details below
for more information.
LEARN MORE
WarningThis link will take you to a third-party site

The response from the remote server was:
510 5.1.1 Your email address, martin.jansa@gmail.com, is not subscribed
to that group. To subscribe, send an email to
docs+subscribe@lists.yoctoproject.org, or visit
https://lists.yoctoproject.org/g/docs


Not sure if it's really misconfigured or if it's just quite confusing
way of gmail showing that I'm not subscribed (which is shown in small
font bellow big warning box about misconfiguration :/.

https://imgur.com/GMDE3IQ.png

Regards,

> > - doc/README: fix the command to generate the manual
> >=20
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > ---
> >  README     | 5 +++++
> >  doc/README | 2 +-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/README b/README
> > index 96e6007e..5034a9bf 100644
> > --- a/README
> > +++ b/README
> > @@ -26,6 +26,11 @@ branch, type:
> >
> >      git send-email -M -1 --to bitbake-devel@lists.openembedded.org
> >
> > +If you're sending a patch related to the BitBake manual, make sure yo=
u copy
> > +the Yocto Project documentation mailing list:
> > +
> > +    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --=
to docs@lists.yoctoproject.org
> > +
> >  Mailing list:
> >
> >      http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> > diff --git a/doc/README b/doc/README
> > index cbb5215d..1f8e0f6e 100644
> > --- a/doc/README
> > +++ b/doc/README
> > @@ -47,7 +47,7 @@ To install all required packages run:
> >
> >  To build the documentation locally, run:
> >
> > - $ cd documentation
> > + $ cd doc
> >   $ make html
> >
> >  The resulting HTML index page will be _build/html/index.html, and you
> > --=20
> > 2.25.1
> >=20
>=20
> >=20
> >=20
> >=20
>=20



>=20
>=20
>=20


--c63kaheubfjelyg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCYIL4rQAKCRA3VSO3ZXaA
HIn7AJ0dsgrT2uUM+bqr6j+LPKk2+4uFUgCbBYYbyoNelsCJuaXJe6FtrhftZ/o=
=gGfH
-----END PGP SIGNATURE-----

--c63kaheubfjelyg4--
