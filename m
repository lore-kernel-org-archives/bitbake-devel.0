Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E2FCD98CE
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 14:26:20 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47016.1781187977889826601
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 07:26:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FFjzU40y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso10964426a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781187976; x=1781792776; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMDjycc6pwZA4S6hFQ/gmEy6loLwOv1lb59P8PuYnLA=;
        b=FFjzU40yR/I/Gq/+7d8P+RVO0dLzkM0Pd6g1MpdnGB4kd0w764cx4qqQfPEqp85Uas
         pX8hsVx7dnHMZgXR2Xz/ts4n4IzXfnwgkIcIoqVeAqM+S9xtAOmApFfjKYnFlgH0xdpl
         MOyYzhWcXL4vPElkVBkq9p3BuvT55DyPDXToI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187976; x=1781792776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMDjycc6pwZA4S6hFQ/gmEy6loLwOv1lb59P8PuYnLA=;
        b=EaBJqhsdiuusCSkrS0KqNcXkcjnNSb5FZkfpuCDXSm9b0mdckfEsIjazKDpio7uftx
         fMxpNL+Hquf/vzA9XXNHL+6qVBO4AcIxdQlECsG8Qri5vBO7IwPMkIiTYLopUvR00KSt
         c/e3Uff0AvxJ7sjHFR96B7v1xuKBAEESzY//4cXHGD6JmfeEL0F++VQPhkxDNDOaRg+E
         B6fXD+A8ZCyYjeY/P4Ou911elJD9pozlwb3mbCrX29rWjLdRYbP8wp3SI/tY+DNZGA7w
         k+f03Qx1ySHGA2MYQ/mZ/TLuDxlkE/UTeiFSwQMYPaOEzG97tJ28eiSMBqbPcnrxmT8B
         pNqg==
X-Forwarded-Encrypted: i=1; AFNElJ+LAf+fYhvq0S6J0dZCc9saKIp1Qpwr6jFyKT4//Snis2+dpKGjeVdv4/kk8T71QgyMuA/K7amjdwk9z+BB@lists.openembedded.org
X-Gm-Message-State: AOJu0YyR53Kcb1/WriwAZbPFzRkc/BGjHFv1f3p4UteTZ5887dt9YSmf
	yFWOM26llQn7w0AX+/HbWz+oa3PGGHUEXy33s/5RHeGJ9eAmU9I7cw8EBaljALirk68=
X-Gm-Gg: Acq92OEn1kSvs4neX/SZTB5xGRUkP1iicXjpAWqlhodB4A1B+RfqvmhPxElrVduRcik
	esuAHFtNE8wQGkuk0+dCbXkd42x3LbIhBL+0cRHBt54huJbV5Xz1PzdnexJpuUh3dXPJxQHlZBO
	bAhPh+u8csXi8tsx5tdCz+8Cv1XS4TKaCrhAyWUNQOxZg6Luaokl+SsaixyC8+JJ78lhw1HU4Bf
	nyubH7od5A30RnP3UTemoQzQZhL3px4qVZ8o7A+mE78xUVoujueEDrqhJ4pWSDtwUK29qQ+D8O7
	m0A6nOIqGbNIXwwY/thxLA1+yDLlLTur7u+XQbUavGdGFQnpy5S1qnzW9oJ9diKhRUuzG2juvRj
	5wLSkKFPEAA3Ny91FCvtjHCLghlE33KYjGX4n0ABNbGweQccj3rJLjeiVTV8+EA+RnHyzlTrQaA
	JOsvSZwqSCsSJ+Vx3kZvObL614CH3I3qYAb+46SU9Kaz26IjZLFi6DD+PeYGRqNvAzywTimPj8J
	kR5GDnyKklCn1qC6soESb8+TEXXrX4WmI/+ag==
X-Received: by 2002:a17:907:a0c7:b0:be2:cd33:2142 with SMTP id a640c23a62f3a-bfc85d877e9mr115086366b.15.1781187976042;
        Thu, 11 Jun 2026 07:26:16 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e596:3a72:77cb:f054? ([2001:8b0:aba:5f3c:e596:3a72:77cb:f054])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb1608a71sm73763266b.21.2026.06.11.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:26:15 -0700 (PDT)
Message-ID: <3ed53ffdad2597c633e5664ae4f7752c12432362.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] lib/bb: Further shell=True cleanups
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Anders Heimer <anders.heimer@runbox.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jun 2026 15:26:14 +0100
In-Reply-To: <5f2ccafd-269f-4bf3-a6b0-1fd1ee12d574@runbox.com>
References: <20260611110523.322273-1-richard.purdie@linuxfoundation.org>
	 <20260611110523.322273-2-richard.purdie@linuxfoundation.org>
	 <5f2ccafd-269f-4bf3-a6b0-1fd1ee12d574@runbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 14:26:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19669

On Thu, 2026-06-11 at 14:18 +0200, Anders Heimer wrote:
> On 6/11/26 13:05, Richard Purdie via lists.openembedded.org wrote:
> > @@ -186,12 +188,12 @@ class LocalhostBEController(BuildEnvironmentContr=
oller):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 else:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if giturl in cached_layers:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.debug("loc=
alhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdir=
name))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._shellcmd("git clone \"%=
s\" \"%s\"" % (cached_layers[giturl], localdirname),env=3Dgit_env)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._shellcmd("git remote re=
move origin", localdirname,env=3Dgit_env)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._shellcmd("git remote ad=
d origin \"%s\"" % giturl, localdirname,env=3Dgit_env)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._shellcmd(['git', 'clone=
', cached_layers[giturl]], localdirname], env=3Dgit_env)
> One ] to much.

Thanks (and Quentin!). I'll tweak that.

> > diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toasterm=
ain/settings.py
> > index d2a449627f8..9d2dbc464ec 100644
> > --- a/lib/toaster/toastermain/settings.py
> > +++ b/lib/toaster/toastermain/settings.py
> > @@ -229,8 +229,8 @@ from os.path import dirname as DN
> > =C2=A0 SITE_ROOT=3DDN(DN(os.path.abspath(__file__)))
> > =C2=A0=20
> > =C2=A0 import subprocess
> > -TOASTER_BRANCH =3D subprocess.Popen('git branch | grep "^* " | tr -d "=
* "', cwd =3D SITE_ROOT, shell=3DTrue, stdout=3Dsubprocess.PIPE, stderr=3Ds=
ubprocess.PIPE).communicate()[0]
> > -TOASTER_REVISION =3D subprocess.Popen('git rev-parse HEAD ', cwd =3D S=
ITE_ROOT, shell=3DTrue, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.PIPE)=
.communicate()[0]
> > +TOASTER_BRANCH =3D subprocess.check_output(['git', 'branch', '--show-c=
urrent'], cwd=3DSITE_ROOT, text=3DTrue).strip()
> If I am reading the correct doc version, the minimum Git version=20
> supported is 1.8.3.1 while --show-current was added in 2.22.0.
>=20

2.22 was released in June 2019 so at this point I think it is fine to
rely on that. Before I added that code, I did check which versions our
'supported' distros have and we're fine there. So we can update the
minimum version, I don't think it has changed in many years.

Cheers,

Richard

