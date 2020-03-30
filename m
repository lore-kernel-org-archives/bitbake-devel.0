Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.52510.1585581535177424775
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2020 08:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=GHSPeDjq;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id d5so22198702wrn.2;
        Mon, 30 Mar 2020 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e2h8VOz0p4Pg+RzOQEkI6HqOfuafCjE03DiyPGhlj/s=;
        b=GHSPeDjqyrc92C5TXQRtrLoava7sDow/dr5oyKQHPxiSqg31ZiiS+cYdcoN4U26PM8
         pL5XLB+OZlfT19TvPo6gvdpIb87YhlDOQJjCx9KS3YKS8bdTmgziFcYiCld7jBlyHpHf
         WtJPLeS4etwbjhqMwUe0hhCOTDE9QOFYaY8nESX4puO1imI59XyaCbFUG0Iq9RhWX9o8
         JclPqW+5AyhL5U8bLFQUOec9JWTSzAwjDnajCoecjdOIo6c70WNwNAdc6MwOt/1RMzuo
         30syidzxGf7C3W/uqyngq1FNYXg+bWQFgA3YZXlqdoNUY7o3nBDzMElCqtRwOSCAwWRn
         3tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e2h8VOz0p4Pg+RzOQEkI6HqOfuafCjE03DiyPGhlj/s=;
        b=fXxmCGs683WnPYLSjTEjKjPKPBOmYcX2AnRn4D+P8oyUdnLfNMoUd6LgAQj5E0AfsT
         PVA1PYeQYJ+yy/Sjxbod04UTgJV6VoXoONUjps9X0ACVb95hK3dB6eX/A7Ct9TYLoeo7
         vNIjyklyy7fy9StbTqXLXCz6sdrvQ1daoRVf/5guXLseP36HOEviAlaxAPpoqC/83eUR
         KEEohaKBYYZ121wfBjfiwc4/7O2HDZ5xHBVS+XhOBB2TmhH3+hs1AqNzJk6miJP0lGMC
         YpiF9SqHGa5+L6BjWfK8u2CgBnIjg/9Vfk/bNOA10S7imiM9VLM5dwUfETgFwd1ChYCp
         BE9Q==
X-Gm-Message-State: ANhLgQ15hLjaVu5Xefwb0WQFuEFBfz96PPO5JFfW2QOv90TZdUhkM8Hs
	CgU/ZKEdPIscHPmKbR2jW90=
X-Google-Smtp-Source: ADFU+vumv9AAIwecRYd3Le4a8dNU/fCiX1mqxopYDHpoirPlfUEj2WgnDruM4/G7yhIR7HuCdY0lAw==
X-Received: by 2002:adf:94c6:: with SMTP id 64mr15735724wrr.386.1585581533734;
        Mon, 30 Mar 2020 08:18:53 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id y7sm25157307wrq.54.2020.03.30.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:18:52 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Mon, 30 Mar 2020 17:18:52 +0200
To: Michael Halstead <mhalstead@linuxfoundation.org>
Cc: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org,
	openembedded-core <openembedded-core@lists.openembedded.org>,
	openembedded-architecture@lists.openembedded.org,
	openembeded-devel <Openembedded-devel@lists.openembedded.org>
Subject: Re: [oe] [bitbake-devel] Mailing list platform change March 20th
Message-ID: <20200330151851.s4p24hkg4kbrysd4@jama>
References: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
 <CADfgfoYCjVip=oc_U0TdFzOVst5U-KU+R31JhdckRv77APzQ-g@mail.gmail.com>
 <CADfgfob4=Zeh=jn9b9uMqq6Wnt83oGmJ-8yf1wSXYEFTppv2Bg@mail.gmail.com>
 <24a37655-8c0b-ca10-543e-90a32bc6bdb9@gmail.com>
 <CADfgfoZRZCM_Dvot5_z4YnG+OOyMg6xvDE13XQOK50wpucZWFA@mail.gmail.com>
 <20200325150325.yq5jtofhnxaui6he@jama>
MIME-Version: 1.0
In-Reply-To: <20200325150325.yq5jtofhnxaui6he@jama>
User-Agent: NeoMutt/20180716
X-Groupsio-MsgNum: 11227
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bztawwnrdg3bwbdj"
Content-Disposition: inline

--bztawwnrdg3bwbdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 04:03:25PM +0100, Martin Jansa wrote:
> On Fri, Mar 20, 2020 at 05:44:36PM -0700, Michael Halstead wrote:
> > The migration to Groups.io is nearly complete. All functionality is rea=
dy
> > to use and you can send e-mail now. Archives are in place except for the
> > most recent from the Openembedded-commits list. Those are continuing to
> > import.
> >=20
> > There is no need to update your address book as the list addresses have=
 not
> > changed.
> >=20
> > If you encounter any issues please visit
> > https://www.openembedded.org/wiki/GroupsMigration for the latest
> > information. If your concern isn't addressed e-mail me directly.
>=20
> Hi,
>=20
> thanks Michael!
>=20
> Can you please check if git hooks sending e-mail notifications still
> work or need some change (possibly related to this)?
>=20
> There were new commits recently in couple repositories, but last e-mail
> from git hook I see from Mar 19th.

There was one e-mail today, but it doesn't seem to be working correctly:
https://lists.openembedded.org/g/openembedded-commits/message/186006

Cheers,

--bztawwnrdg3bwbdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCXoINjQAKCRA3VSO3ZXaA
HNKmAJ0XgCK+F1JhVq4FZrozxZ33Oda0qACeIsKD5SbCsgZsxdMLorxFe9WTHiA=
=b2wI
-----END PGP SIGNATURE-----

--bztawwnrdg3bwbdj--
