Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB2D29FEE
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 11:14:43 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7756.1768389281032626658
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 03:14:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SJNOiI5q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so7056292f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 03:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768389279; x=1768994079; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hNbdJVHa4ycXYzR1ZEqLT6ePUQTFC50lar0cKlADEDg=;
        b=SJNOiI5qBUjUY7yR5RHo/fBu1wJ6Fgmtn3GFB6fig6GWMYDMM1r475Hk89eTipTE7t
         cdV39q3NGdwt2IKJoXeqOkKmJbrCZKK9t5+XidohDNM6SOigQF8lrFmD0XooeeVBfFTr
         Cc6fI2P5j7t7val1yi4MoCY0z585Oso44R5fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389279; x=1768994079;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNbdJVHa4ycXYzR1ZEqLT6ePUQTFC50lar0cKlADEDg=;
        b=RTLAdN4fdXxej2OrysD0kY/QIvMDtxr6KbWzuzBr8moE/zE/kbWRXDq6iFUamDmZfg
         0LAHMTJYAtRQUuRgr/dz/7gbydunbEghTvQrUZebcfroY22m+PwqMf5KZawziTDs70SQ
         QITKv+yNsomeRnAuJ10dNgLkxXFFy9rjwCFjOhxM5oNizJGCeDQk+fZjXcJcP8sxcaLp
         ThmK9JSAHF4a0W/LX1Ww8J3QcFZ5/qS/T2F4JGEgqvyK3Qd6okVyBptYcQ8Tb6YtBVN/
         X4ZXYhMNUThB6XwAU4QYHXYjIGLTg5qF8IezZXvYko5EYutHicz2iDdeFbDFXkqpYqt5
         jjvA==
X-Gm-Message-State: AOJu0YyI6MEgj/4hYzyoOxN40jhTttHo0HyR3AMghMo67Ik5kO0QiUR2
	cO6VBgJQm3LBy534/rjPkSV3Mi/5fEfaCrhu4TUBmUGpOfTycGvDmP4FqLsS2prvzrA=
X-Gm-Gg: AY/fxX7jEUU8uRVGc2yR8x3IL2GGqSzG7u/TZlQbklGffjmwSnhk5hR2KJUvkATski1
	PQ/9TGR9FMtlH4Y8RrUNAToo5Oggy8pdyvdIOoF+ExzPzWajvll+iFdXyMWX45w+usXFlZEIHmH
	6esv6RIxcpavBOprOEl96SlpTX2J9/nS4HfUzSUGFTb52ZpzviObJek2mv8BtrArf8j20qEDQYu
	9vHMxIOoccllpf55eUkbMQCgDZkqw79Qj3RaAnl1SsvVT49wgg06XYlzcvvPBV149CUApHckUUF
	ipNSnq6vK77sYQvCfSoultOM19cMjf0rVU8bjDK9HLahShmegxeHrTDIfzkIbK1iKZ9js9xCOOS
	qa+dcCNiQKBhjzUEIDbHO+cvM5MtLqdWPqoGTQLKxbye9r+zAjcJfJuTy/VeAY1Ca83NHqZQDUW
	ZGkieA8DTIfc0zHTJv6W80eTOMALzUxBkkSlC1Qr1qYJF3DqFAiukBlB3jtYSNzcaK0Vg50Nx4O
	oY=
X-Received: by 2002:a05:6000:402b:b0:431:48f:f78f with SMTP id ffacd0b85a97d-4342c4ee925mr2162984f8f.1.1768389279102;
        Wed, 14 Jan 2026 03:14:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:94c7:73b9:87a6:4747? ([2001:8b0:aba:5f3c:94c7:73b9:87a6:4747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm49141547f8f.18.2026.01.14.03.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:14:38 -0800 (PST)
Message-ID: <31a6956818136b65783063d9b5e946fca25ce49f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: use internal registry if
 run from git checkout, bitbake repo otherwise
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Rob.Woolley@windriver.com, 
 Alexander Kanavin
	 <alex@linutronix.de>
Date: Wed, 14 Jan 2026 11:14:37 +0000
In-Reply-To: <CANNYZj8fqxz+jVu8_eWBaCCGCaZoWA5dO5foPTKWnNOEoH3c4A@mail.gmail.com>
References: <20260114080414.2927046-1-alex.kanavin@gmail.com>
	 <0adf825db9501818398a9ef04752e4000bd3133e.camel@linuxfoundation.org>
	 <CANNYZj8fqxz+jVu8_eWBaCCGCaZoWA5dO5foPTKWnNOEoH3c4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 11:14:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18751

On Wed, 2026-01-14 at 11:46 +0100, Alexander Kanavin wrote:
> On Wed, 14 Jan 2026 at 11:26, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > > +def get_default_registry():
> > > +=C2=A0=C2=A0=C2=A0 internal_registry =3D
> > > os.path.normpath(os.path.dirname(__file__) + "/../default-
> > > registry")
> > > +=C2=A0=C2=A0=C2=A0 git_registry =3D
> > > "git://git.openembedded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;
> > > rev=3Dmaster"
> > > +=C2=A0=C2=A0=C2=A0 if os.path.exists(os.path.dirname(__file__) + "/.=
./.git"):
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return internal_registry
> > > +=C2=A0=C2=A0=C2=A0 else:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return git_registry
> > > +
> >=20
> > Probably a silly question but why not just check if the default
> > registry exists and if not, fall back to the git url?
> >=20
> > i.e. why isn't this just if os.path.exists(internal_registry) ?
>=20
> The idea is to ensure that internal registry is used only from a
> bitbake git checkout. If someone makes a tarball, or otherwise
> installs bitbake-setup in a way that replicates the tree structure
> including the configs, then bitbake-setup should ignore any such
> possible in-tree configurations and get/update them from git.

It might be worth a comment about the design intent here, something
like:

# If bitbake is from a release tarball or somewhere like pypi where
# updates may not be straightforward, prefer to use the git repo as the
# default registry

?

Cheers,

Richard

