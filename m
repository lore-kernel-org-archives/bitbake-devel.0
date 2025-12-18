Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42D9D711CC
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 22:39:24 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5058.1766097563269371943
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Dec 2025 14:39:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KfDyzzhF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47774d3536dso9890825e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Dec 2025 14:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1766097562; x=1766702362; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pdf3gBaxOqEwXQRCgsF38PZuQtZnmaVTv3nizNgFXJE=;
        b=KfDyzzhFWEnnmCKzTi+Q+mVKD0Ai33OTp+LuxVAxn84hJA7eUujAPPdd/ynlRZYw0O
         FsmhbWrv8BCZQwyoDeShtPwaEMXSp+6VP31UgBFK9NlmkhvoNwbtRueDq0Yv5Ls9Q24g
         aF/kSqiKJz5kFmxEL1ESZXZInx1eS256lzKIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097562; x=1766702362;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdf3gBaxOqEwXQRCgsF38PZuQtZnmaVTv3nizNgFXJE=;
        b=qU/sx9J1rNUPLfNFOtT7B0paUybW3q5JtUSITnCUQteyQ3F/AKYp1vZXvCFv7om6LA
         s5j+k7p7OMWoUk18VBx7q2JlEUzBChm49eXOTvpvZVFg9BAKeA/Kuqf/GGGOhjNU5h7h
         ZyUk/WICdv+ZY1Aq0QvpnYEnbpTY6sAhqbZ8q2z94Ldv6dOr9wKvIQu0+TavVhzTp/qS
         U4BUqZ5Hz3eUgOT/gLVbFPD0rj1az9TJ8z0TJulfuyBdSfdoCFWYVFFpMWjuaCS3jCqj
         NeKQP4UyZqa+3JWNZ+F32RfOzOAyJyHg8r607oHg3QkPLzVvKhvRm49Ge4hdGL7oUZrt
         lmyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtj9nbia4/lnneMojgVhzEpmA16oC2dmu/FsnWy0kLUknOLcQhJ0ot+Pm3OjiNwDBvdRX0atZJ6I5Hc9hO@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx6N5+dfiKBwLL1y7wdJ51F+wxK0Fd/RY5OoYv9P8tmidWR6nOD
	Z6dkXRs/NnpdKvtAE08LM6Q2v8GM+WOeADJHFEuDIHec8jiJRTqFMO7BlwcK0+Ne4UM=
X-Gm-Gg: AY/fxX6Q+IFDmy/35DOYuIK6/wbom1TQVPBc7wdgUjq8wlTlyAKOUFpeLea0dHuR8Jj
	kLT4mEVpbYFAgxnbvEVEoselbHRVt3T+JImvDFcxW+ABeelwMkcPrjNho0v2HdkFSjIsl3VWigg
	qCJe8Wt8pdyL1bpE4PdQpPNZJBKRxpwzjm0FlRTlHCr0TVqT1HPS2AmYHsGNDBchIX8hSWrkIuj
	CcoT/VknrACMteXbHbyZOjbaPZwtG0K90k874V9gFus4mbeRQ6xG8+WcZBxP5ytZhE7ftHULDvP
	DkNdH0sD8zIHiskbEAKZjs0Wi+rv6WqsXVXNtX4BuI8xHHPxE00/4aYVVcq0OAUi1F727MlWFUF
	c3T8FOlbl+GzGNobuuu7nsF6a6jyczbBgY8Nuu31PjbDUpHkPMnaWg347giRpVh33JJNKeH4B/V
	bAy19GcufA9hFbKsy6/BUe+cFTzvu17JI2Lbmr2oyLF19n93WlBptu/CvhArYGtv39bFjoHvciC
	G9j5TlfIPEUsw==
X-Google-Smtp-Source: AGHT+IG9LtYs35y0J26o+Ykv2vjtUbNUVGN5bcbFrJzU1WQ9W4JWQoTjcaBscFC1G+LuyDKGhmJTLA==
X-Received: by 2002:a05:600c:3397:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-47be2999657mr31536865e9.4.1766097561612;
        Thu, 18 Dec 2025 14:39:21 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e1ea:f1a8:619c:15ce? ([2001:8b0:aba:5f3c:e1ea:f1a8:619c:15ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08efsm1366920f8f.29.2025.12.18.14.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:39:21 -0800 (PST)
Message-ID: <f5556fb80c2b70c2ca049dec616f086df1bbdc11.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 2/2] bitbake-setup: share sstate by
 default between builds
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <paul@pbarker.dev>, alex.kanavin@gmail.com, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Thu, 18 Dec 2025 22:39:20 +0000
In-Reply-To: <62e07a47b15a48f0e7d80f2dcb88fd37a52bd4c4.camel@pbarker.dev>
References: <20251215145418.2680311-1-alex.kanavin@gmail.com>
		 <20251215145418.2680311-2-alex.kanavin@gmail.com>
	 <62e07a47b15a48f0e7d80f2dcb88fd37a52bd4c4.camel@pbarker.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Dec 2025 22:39:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18611

On Thu, 2025-12-18 at 19:49 +0000, Paul Barker wrote:
> On Mon, 2025-12-15 at 15:54 +0100, Alexander Kanavin via
> lists.openembedded.org wrote:
> > From: Alexander Kanavin <alex@linutronix.de>
> >=20
> > Nowadays sharing sstate must also include sharing the hash equivalency
> > information and thus, managing a hash equivalency server. There are
> > two ways to do it:
> >=20
> > - starting/stopping the server outside the bitbake invocations, and
> > guaranteeing that it's available when bitbake is invoked.
> >=20
> > - using bitbake's built-in start/stop code which launches a server
> > before a build starts and stops it when a build is finished; essentiall=
y
> > this is a private server, using a database private to a build directory
> > (by default).
> >=20
> > I couldn't come up with a good way to do the first option in bitbake-se=
tup:
> > it needs to be invisible to users, they should not have to run special =
commands
> > and they should not wonder why there is a mysterious background process=
.
> > It's not impossible to auto-start a shared server, but that will quickl=
y
> > run into synchronization issues: if one server is being started, anothe=
r
> > should not be started at the same time. If one server is shutting down
> > (e.g. after an inactivity timeout), another starting server should wait
> > until it frees the socket, and block all bitbake invocations on that.
> > Memory resident bitbake does this in lib/bb/server/process.py with a lo=
t of
> > complexity, and I don't think it should be added to the hash server as =
well.
> >=20
> > On the other hand, hash equivalency database is sqlite-driven, and sqli=
te
> > documentation reassures that sharing it between different simultaneous
> > processes is okay: nothing will get lost or corrupted: https://sqlite.o=
rg/faq.html#q5
> >=20
> > I've confirmed this by running simultaneous builds that way: nothing
> > unusual happened, and sstate was shared as it's supposed to.
> >=20
> > There's a new setting that turns off this behavior for situations
> > where the server and sstate are managed externally.
>=20
> To capture the concerns discussed on the patch review call this morning,
> since Christmas & New Year are about to happen and we may all forget
> things otherwise...
>=20
> The sqlite faq you linked (https://sqlite.org/faq.html#q5) says:
>=20
> =C2=A0 But use caution: this locking mechanism might not work correctly i=
f
> =C2=A0 the database file is kept on an NFS filesystem. This is because
> =C2=A0 fcntl() file locking is broken on many NFS implementations. You sh=
ould
> =C2=A0 avoid putting SQLite database files on NFS if multiple processes m=
ight
> =C2=A0 try to access the file at the same time.
>=20
> We do promote the sharing of the sstate directory over NFS as safe, so
> we should be very careful about placing the hashequiv db file in the
> sstate directory in light of the above.

We've also been telling people they need a shared hashequiv instance if
they have a shared sstate. The number of people who will therefore try
and put this file on an NFS share is probably comparitively high even
if we don't show any example of that.

At the very least we need some kind of test of the filesystem it is on
to ensure it is not NFS as I don't think we want to support that.

Cheers,

Richard

