Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FEC3601A
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 14:23:41 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.9819.1743603816199695916
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Apr 2025 07:23:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DqSYDi0T;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so1755851f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Apr 2025 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743603814; x=1744208614; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZWSyH+W8BvW8ee13KLM51H/9PsKPirlXKB9zY7/4eg=;
        b=DqSYDi0TOJYUTWU36AJ1yrRAA9szd35kKr0PR9DOEEXphTRz9GZ6NPqVnPjExTxOUv
         /r/bJzHHWmwG+gyQLgAORmT2DylWAOATcGjoPtqBgZd04kUEwEajbkFUaStUo5FPIYwZ
         ELv6rqIA6+UGGOOMgPtJpifmnmhXAej7yqmys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603814; x=1744208614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZWSyH+W8BvW8ee13KLM51H/9PsKPirlXKB9zY7/4eg=;
        b=OtqPwA6KxfRjiVhUuIWGM0uUDMfJ7h3dJrPZXg6UjUlAlE7H8Jv3tKgiZ8Lz96foel
         u3Gnzk4vGWhTTvPsTtV3UgKXfo9FOGnlVQVXxfBUMbHYDEHybJtu28/JAXeOAKb5UKYF
         upMWbSwsU9rUR+oZa/YT7DCRIvJSa1nLWKRsRraqYHZU2dgjgM8MWYtGpbvJo59U5phr
         0SZnK9700zZwFkgevIPAOQbOT3wDX8nihw4whh5Rq0K5E9j5xSvaea2jvXNZnL89fiQO
         XGpSkJtw7Y2Xww209He6hGyyPJ/ZankgCAkwUJMWGfP40EqIsiGmTWGSticWqmXmJXUx
         Z6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUWUbzDSnORMs8lEHhNzpJPEZL6nIoHcLLYz5Lvyld3kRXsyJdoP5v31fE6VWQVhKAG7CG+PfOwGWZCxer@lists.openembedded.org
X-Gm-Message-State: AOJu0YxRMrfnsWkQNr8TwOO5gJ1q1Jqx1iDkNd+53VW9KhjD8mDUtwkE
	uMB9x7KXr5pPnPDGV46bHleNhxFzWCe9D0ywFAdLPGIzFgGr1BG3T1f2vxb5aP0=
X-Gm-Gg: ASbGncuPa2RqEV+4+JnTKl+ONQ4nAjd5nK5xk2Mu2scuxR4U6rG215Y+jEcuraVuVSz
	yBDXNWW6HeMQIpADnYWGd2Arp0IO+1nwlDn71jFEzphbOd8xJOD+eWe4tYuMK8KNKR76GqrwR0A
	v5SegyAgLVuWjmE2IIf68P/miyK0tKH3NfqGFnca/VEYacXv74G/8uhT6AIHM5omF40j5Sko/jy
	JM6DvI/eNBVo68XkMvmcV/3NkEjf8LKrsZ1fQwbPIz7XJ+4xQhF651sZaxHIX/pxvhUzKElczKV
	PQpBdUOZtcXsF7NHsa6I9nAjXrsP7vx6wDmNNjluohuoG4c49ABPWD0C3GuGW9+pPoKz+H0a4c6
	C/7EUveqq1t3WQdqARnnocP1Yqq2aefRhIUIEXWWEW+1S
X-Google-Smtp-Source: AGHT+IHHRWyFDEnMody1f6/TIkp4bwlrE9oVCGac/16byBNcer8m74Qs3eFmRfDDpVe36+84I/yUJQ==
X-Received: by 2002:a05:6000:4023:b0:39c:119f:27c4 with SMTP id ffacd0b85a97d-39c29767c83mr2359413f8f.30.1743603814628;
        Wed, 02 Apr 2025 07:23:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:24b8:b374:749c:8558? ([2001:8b0:aba:5f3c:24b8:b374:749c:8558])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588e9sm17559418f8f.14.2025.04.02.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:23:33 -0700 (PDT)
Message-ID: <e1c6f06bffa75b930e829677b13964edbdfb5f11.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Handle srcrevs for
 annotated tags in tag check
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 02 Apr 2025 15:23:32 +0100
In-Reply-To: <DB5PR02MB102130FD9FE35B95EFA1805CFEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250402140100.2407773-1-richard.purdie@linuxfoundation.org>
	 <DB5PR02MB102130FD9FE35B95EFA1805CFEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Apr 2025 14:23:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17511

On Wed, 2025-04-02 at 14:18 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org=C2=A0<bitbake-devel@lists.op=
enembedded.org> On Behalf Of Richard Purdie via lists.openembedded.org
> > Sent: den 2 april 2025 16:01
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] fetch2/git: Handle srcrevs for annotat=
ed tags in tag check
> >=20
> > If SRCREV points at an annotated tag, the comparision code can fail
> > as the resolved tag might not be the same sha.
> >=20
> > Handle this by also resolving the SRCREV. We only need to do this if
> > they don't match in the first place for a minor performance win.
> >=20
> > Also add a test for this.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0lib/bb/fetch2/git.py=C2=A0 | 7 ++++++-
> > =C2=A0lib/bb/tests/fetch.py | 7 +++++++
> > =C2=A02 files changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 3a4ae6df45..5f4ec6128c 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -730,7 +730,12 @@ class Git(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 output =3D runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd, ud.parm['ta=
g']), d, workdir=3Ddestdir)
>=20
> I recommend using Git's syntax for getting the SHA-1 for the commit=20
> directly from the tag instead, "tag^{}". That should work in both cases:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output=
 =3D runfetchcmd("%s rev-list -n 1 %s^{}" % (ud.basecmd, ud.parm['tag']), d=
, workdir=3Ddestdir)

We can't know if the srcrev used in the recipe is the annotated tag or
the commit sha so you have to potentially resolve both and I'm not sure
how this helps?

Cheers,

Richard

