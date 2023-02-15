Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32BFC636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:02:45 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.11756.1676455357384761007
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:02:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ikjAfCKm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1144822wms.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 02:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3NfKbL8zwc9YxA4GCrVr5eT+1KkEg3F+L7EruuAp10=;
        b=ikjAfCKmW232yyZPzM5V+seVKvyRlbxyH3QxxKs8dPsHGTclZFfuyV79ZKIu9lbQiK
         ZqFSmdS2N07rJyQk22l51sBlLMC+Ym92Ryp3JUVQO7YIyj2IFeX+syDKxARUWudhzHuc
         OA9pE6jO2qM9+AwMeNsFRtM6Yc+1XFUGX1x9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3NfKbL8zwc9YxA4GCrVr5eT+1KkEg3F+L7EruuAp10=;
        b=U+muJRX19aeIl+3zQaMPqENIuEt6Sbuo1bCOb9cX06E50dc6xkj0+Upl0i3r3FkAdL
         3L8NsllVuFdgEgUZhlYOvn0/PE4h19+CJoN63L+fJOLZypFEZsHK8PZKcm9njanDlvWH
         lhPpvqdaveoJ+jWxuIIHaz3kiUNjYG9seeh+4F0BEIZk3cdQ5xCNwzK12fR5/sKLtjAH
         Ec/AKDJVdGLih/b1TtvVItxoy6cW7s3tQQqH6z4yCdKuh8aR4+tsFujTuhbqolrCYsvr
         SOZSoDxLUh0GmIrYoReShLGCuAOxrItnNJxCijryJh3cPu5oFPFZtW+aUUCOMSu2Lnok
         GDyA==
X-Gm-Message-State: AO0yUKXooZgx2FhFCVuFk+/qL54EOdvgvk7ThzTHfRHXAJmqRAqtZ+jT
	GXvmTiCegcSU3/GAPxSXjUmg2w==
X-Google-Smtp-Source: AK7set8wacA2u5/5UmLsjZLCyYTfoZG17n9PVt0wxbISAKOXlcVazwVbbtOTPpuuQRtnKB0SMRKrkg==
X-Received: by 2002:a05:600c:16c4:b0:3de:e8c5:d826 with SMTP id l4-20020a05600c16c400b003dee8c5d826mr1480699wmn.28.1676455355740;
        Wed, 15 Feb 2023 02:02:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1? ([2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1])
        by smtp.gmail.com with ESMTPSA id iz17-20020a05600c555100b003dc4b4dea31sm1547768wmb.27.2023.02.15.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 02:02:35 -0800 (PST)
Message-ID: <e952433b38bd2cbde4efaffd0e2c1699ecfdbe8c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] kirkstone DEPEND problem
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Feb 2023 10:02:34 +0000
In-Reply-To: <913e646320fa02fd174566d8bfc5ca04cae269a4.camel@infinera.com>
References: <50f86c1869166da73d083d3c2e86f112faa978b9.camel@infinera.com>
	 <0c4d7472e556e555ef57032d7af7a9377c05fbc7.camel@infinera.com>
	 <913e646320fa02fd174566d8bfc5ca04cae269a4.camel@infinera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:02:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14422

On Tue, 2023-02-14 at 14:22 +0000, Joakim Tjernlund wrote:
> On Tue, 2023-02-14 at 15:06 +0100, Joakim Tjernlund wrote:
> > in swupdate.inc there is
> >     depends =3D d.getVar('DEPENDS', False)
> >     pn =3D d.getVar('PN')
> >     rdepends =3D d.getVar("RDEPENDS:%s" % pn) or ""
> >=20
> >     if 'CONFIG_REMOTE_HANDLER=3Dy\n' in features:
> >         depends +=3D ' zeromq'
> >=20
> >     if 'CONFIG_SSL_IMPL_OPENSSL=3Dy\n' in features:
> >         depends +=3D ' openssl'
> >     elif 'CONFIG_SSL_IMPL_MBEDTLS=3Dy\n' in features:
> >         depends +=3D ' mbedtls'
> >     elif 'CONFIG_SSL_IMPL_WOLFSSL=3Dy\n' in features:
> >         depends +=3D ' wolfssl'
> >=20
> >     if 'CONFIG_JSON=3Dy\n' in features:
> >         depends +=3D ' json-c'
> > ....
> >     d.setVar('DEPENDS', depends)
> >     d.setVar("RDEPENDS:%s" % pn, + rdepends)
> >=20
> > This fails to pick up dep in depends variable, but if I change '' to ""=
 like so
> >    depends +=3D " mbedtls"
> > then swupdate builds.
> >=20
> > This worked in dunfell so perhaps a bug i kirkstone?
> >=20
> >   Jocke
> >=20
>=20
> Correction, bitbake swupdate builds but bitbake lib32-swupdate does not.
> To make lib32-swupdate build I have to add deps directly to DEPENDS varia=
ble:
> -DEPENDS +=3D "libconfig zlib"
> +DEPENDS +=3D "libconfig zlib lua mtd-utils mbedtls"

The multilib code changed between dunfell and kirkstone. I haven't gone
into the details of how swupdate.inc is calling the code above but I
can believe the multilib improvements and fixes made for kirkstone did
change the behaviour.

Cheers,

Richard


