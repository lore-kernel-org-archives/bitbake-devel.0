Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB6C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 10:58:29 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.10195.1720522702900742775
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 03:58:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YxWDtrwk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.180, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so50402141fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720522701; x=1721127501; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3lcUW3CU7wpf7AaK7kv9OKfv758b5i0YuOqC/ouEdQ=;
        b=YxWDtrwkvYO9jWDb7Brc9A3UzhQTK5lNLgqECczAoYHWjRIn9UFU04IEdOwLnJCV4S
         b1UYPoww50J0+J86MdYcNYi9GS4zeow+OyyACJrMEnjSNGZb+rf3iZk5GMj/RbVZ8T9n
         LTLvGwd8BIvemKoCdTxeEiMdadUGzaJnNKuCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720522701; x=1721127501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3lcUW3CU7wpf7AaK7kv9OKfv758b5i0YuOqC/ouEdQ=;
        b=QHuS79iB5kAMp5MeDmLnRrQkMFwoMt0TesmT+ckw58rfJT4yiRwwQ4ks09+gOdzcS3
         ieZYakAeHdeg2co3aKPoxG4q/LloMmBwU+nJsHvioRNYJZ8wVYxhlpvueYEB5lTpreWh
         GVTN/CwbIosQwRjdZiMIV9I/aI0GjjuNevxDv9dvSUgj1QbJGNNus1F8F4Fs//BZwBfO
         COO4yn1dkOkDB3x4vNZEAhqWrCyVpDrlILX2IS+4HpE1DxQSo6rTxKe9JGjeFadcZLou
         KUkdWYdaUbBgMtHYdoLY/qR3dX99z3eb+UZpNgWTpj5itE2rqTOBuQfxaO9AwBZpimwt
         pnMw==
X-Gm-Message-State: AOJu0YztBiVXco70IFyozE08iCywxGzxGEkApyktil5uXcG6Uqa1OX4L
	2QQRCvtKBloGfNnNUMuEdNp35MJgxfoGERvq7Y2kUkNdlRiiwZIpIlzoC8IeLu4=
X-Google-Smtp-Source: AGHT+IHdscyB6URNp0dK0OR2mvC15otvZUGDNZyVNzvbeFeTSd1WFKYyd7VepLwws5Tn6Z0njfEadw==
X-Received: by 2002:a2e:b6d4:0:b0:2ee:8d07:3d64 with SMTP id 38308e7fff4ca-2eeb318aab5mr14465821fa.41.1720522700925;
        Tue, 09 Jul 2024 03:58:20 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:eb12:75be:8387:683a? ([2001:8b0:aba:5f3c:eb12:75be:8387:683a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab80asm2200991f8f.109.2024.07.09.03.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:58:20 -0700 (PDT)
Message-ID: <ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable
 network when unprivileged userns is restricted
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: changqing.li@windriver.com, Alexander Kanavin <alex.kanavin@gmail.com>, 
 ChenQi <Qi.Chen@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 09 Jul 2024 11:58:19 +0100
In-Reply-To: <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
References: <20240708081034.1474312-1-changqing.li@windriver.com>
	 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
	 <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
	 <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
	 <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 10:58:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16407

On Tue, 2024-07-09 at 10:41 +0800, Changqing Li via lists.openembedded.org =
wrote:
> =C2=A0
> On 7/8/24 17:25, Alexander Kanavin wrote:
> > On Mon, 8 Jul 2024 at 11:12, ChenQi <Qi.Chen@windriver.com> wrote:
> > >=20
> > > This problem has reported to Ubuntu for 4 months. It was discussed on
> > > the Yocto mailing list. People seem to be waiting for Ubuntu. I'm not
> > > very optimistic about getting a solution from Ubuntu.
> > >=C2=A0I do not agree. The last comment  (#10, added two weeks ago) in
> > https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555 shows
> > how to create an apparmor profile specifically for bitbake, so once
> > this is added to apparmor upstream and makes its way into Ubuntu the
> > problem will be solved. At that point the forced network disabling
> > will become unnecessary and damaging. Ubuntu release notes imply
> > they've done it for things like Chrome and Discord, but they expect
> > more to be added:
> >=20
> > https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-no=
tes/39890#security-improvements
> >=20
> I think applications like Chrome, thunderbird etc are commonly used appli=
cations by user, so they are might in
> ubuntu's package repo,=C2=A0 so they will support it and add profile for =
it by default.=C2=A0 But for bitbake,=C2=A0 it is mostly
> for developer and and not support by ubuntu.=C2=A0 And considering=C2=A0 =
there might be many other softwares meet this issue,
> so I am not optimistic that ubuntu will add default profile for all these=
 softwares.=C2=A0 so maybe we are still on our own.
> One option is using this patch,=C2=A0 so users don't have to=C2=A0struggl=
e on this problem, don't need sudo, don't need an apparmor profile etc,=20
> but have the side effect that skip disable network,=C2=A0 we need to bala=
nce which to choose.
> One option is document or=C2=A0 notice message in oe-init-build-env,=C2=
=A0 suggest user to disable unprivileged_userns or write a profile for bitb=
ake.

I do not want to just stop disabling the network silently so the patch
as written isn't an option.

I'm also not keen to make oe-init-build-env too complex, it is meant to
be just enough to get us into bitbake, nothing more. Adding sanity
checks there is the wrong place. This could happen in the normal
sanity.bbclass code but we need to make sure it triggers when a user
upgrades their existing distro.

I think we should open a new ticket with ubuntu specifically about
adding a profile for bitbake and see if we can get a definitive answer
on whether we can add a profile for it or not. I'd suggest a new ticket
so we don't get confused with the comments in the one linked above.

Cheers,

Richard




