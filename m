Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC6C636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:41:46 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.12204.1676457699637178086
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:41:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HGkMfmTc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id h16so18615019wrz.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 02:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix06qdwjGz6kAEQvLukosrZICdZqdbwF/RRosRgLWHw=;
        b=HGkMfmTc3WESDdYnF4LXDHW2NulB6/NWdAwAmELyUP46159t9RNVpjucOa0fr3dz/m
         ucR0N4QPj5VMtLbGgYfRBLzmbBFGM5l02Y3lKURKli/kp9qlL2iFJAtsDOyaaymFuKPS
         6mW8Vf6ptn8zy+zD8Wyk27CNKvsVIh3aG1a3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ix06qdwjGz6kAEQvLukosrZICdZqdbwF/RRosRgLWHw=;
        b=T3oW06BhEc+mu4nFfDd6gcIUccnd5Yn63biENHAhJyzIyEGLiNVu75f6SOkjHxjymP
         AaTX80gqXkUi8HjWX8OmbxEZNrwbOvItmx/Pe8S92XzgG7qEVGt/GQQDfeVzJCPYW/bJ
         jpBFN39kfPrrwHFo4YZ86dEy7AhIFxJLGL+IkVDs3jYqvRinZ5MAw0wfRlhjRUCMh9em
         /vCf7HMPR2SKfymsm5JYjOF/QbAAOiRH3jWCz8pOWQivhN6kQRTP05lIrg0f1sYw1TZP
         YANyGcOSOMz6AlKKQu++ULBsax5bfLyljEoAS7HU//n5OTTthKTaUokHDllyMew3ZWN0
         Q5gw==
X-Gm-Message-State: AO0yUKW+H6Avvzsksy/Rqq6K8DVj8WxmWO/iz9l+5QXbMIf0dZsq12s/
	P4/tlEsOEXDc69pCIDMIgYnnwg==
X-Google-Smtp-Source: AK7set9nBvAc5kOoVTwXbIhA/zbVwh31qwoFPtKWv8ghUjOGHMarXL8/UApqThJS/pLvPCs+VgguAQ==
X-Received: by 2002:a5d:4643:0:b0:2c5:60e2:ed6a with SMTP id j3-20020a5d4643000000b002c560e2ed6amr1385347wrs.0.1676457698039;
        Wed, 15 Feb 2023 02:41:38 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1? ([2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe2c2000000b002c3f7dfd15csm15254370wrj.32.2023.02.15.02.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 02:41:37 -0800 (PST)
Message-ID: <84d237fb56c5db3f7fa8ac433802ec301f78f947.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] kirkstone DEPEND problem
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Feb 2023 10:41:37 +0000
In-Reply-To: <aeeff77922efed8c645fcebb1b91732ba31f1be7.camel@infinera.com>
References: <50f86c1869166da73d083d3c2e86f112faa978b9.camel@infinera.com>
	 <0c4d7472e556e555ef57032d7af7a9377c05fbc7.camel@infinera.com>
	 <913e646320fa02fd174566d8bfc5ca04cae269a4.camel@infinera.com>
	 <e952433b38bd2cbde4efaffd0e2c1699ecfdbe8c.camel@linuxfoundation.org>
	 <aeeff77922efed8c645fcebb1b91732ba31f1be7.camel@infinera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:41:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14425

On Wed, 2023-02-15 at 10:38 +0000, Joakim Tjernlund wrote:
> On Wed, 2023-02-15 at 10:02 +0000, Richard Purdie wrote:
> > On Tue, 2023-02-14 at 14:22 +0000, Joakim Tjernlund wrote:
> > > On Tue, 2023-02-14 at 15:06 +0100, Joakim Tjernlund wrote:
> > > > in swupdate.inc there is
> > > >     depends =3D d.getVar('DEPENDS', False)
> > > >     pn =3D d.getVar('PN')
> > > >     rdepends =3D d.getVar("RDEPENDS:%s" % pn) or ""
> > > >=20
> > > >     if 'CONFIG_REMOTE_HANDLER=3Dy\n' in features:
> > > >         depends +=3D ' zeromq'
> > > >=20
> > > >     if 'CONFIG_SSL_IMPL_OPENSSL=3Dy\n' in features:
> > > >         depends +=3D ' openssl'
> > > >     elif 'CONFIG_SSL_IMPL_MBEDTLS=3Dy\n' in features:
> > > >         depends +=3D ' mbedtls'
> > > >     elif 'CONFIG_SSL_IMPL_WOLFSSL=3Dy\n' in features:
> > > >         depends +=3D ' wolfssl'
> > > >=20
> > > >     if 'CONFIG_JSON=3Dy\n' in features:
> > > >         depends +=3D ' json-c'
> > > > ....
> > > >     d.setVar('DEPENDS', depends)
> > > >     d.setVar("RDEPENDS:%s" % pn, + rdepends)
> > > >=20
> > > > This fails to pick up dep in depends variable, but if I change '' t=
o "" like so
> > > >    depends +=3D " mbedtls"
> > > > then swupdate builds.
> > > >=20
> > > > This worked in dunfell so perhaps a bug i kirkstone?
> > > >=20
> > > >   Jocke
> > > >=20
> > >=20
> > > Correction, bitbake swupdate builds but bitbake lib32-swupdate does n=
ot.
> > > To make lib32-swupdate build I have to add deps directly to DEPENDS v=
ariable:
> > > -DEPENDS +=3D "libconfig zlib"
> > > +DEPENDS +=3D "libconfig zlib lua mtd-utils mbedtls"
> >=20
> > The multilib code changed between dunfell and kirkstone. I haven't gone
> > into the details of how swupdate.inc is calling the code above but I
> > can believe the multilib improvements and fixes made for kirkstone did
> > change the behaviour.
>=20
> Something else that may have changed (we just found out) is python venv d=
oes
> not install the "pip" binary(symlink) into the venv/bin dir. Is there som=
e change
> in kirkstone here ?

That really isn't a bitbake question. I'd suggest looking at the recipe
in question to find out the history, I have no idea.

Cheers,

Richard

