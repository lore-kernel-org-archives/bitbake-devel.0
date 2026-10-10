Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F75CA6017
	for <webhook@archiver.kernel.org>; Sat, 10 Oct 2026 09:30:51 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6127.1791624649080117339
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Oct 2026 02:30:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iKySHv0P;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917a64f28d0so34347786d6.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 10 Oct 2026 02:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791624648; cv=none;
        d=google.com; s=arc-20260327;
        b=Kj2rdGs4cOYGwsP3rm1d1aEhfPd1aD0GF9MbLvJ92LHYgUSVYLsoIIWkKonObj9Vzy
         Zb0181BEIXjyAFt/EkBaQ8v66GypEBTRJ0KLndvaknPRHkCw4rcbGb3CLAddtnVaijkN
         iNRYylN6FVk36qfTRbsF9dhAQuZhA8YJrUbfpdIqwkHT/RSEyMcWXp3H7HAQBLJCFcfA
         /5olx7hYhpVJNnfgLR4yhcK2HnjlMtQxDInbsAdmYOfpAV7KSl6AyxHVUVgzDJ0yRQbb
         apMt67cNv3rKs18vHK8WHs3i9MVLQrGMTDY161ao5xAuFdWaU0z4SpArHKdhNXtdoKhu
         Dwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VaeLdrJMLAw9c9trS1NJ9kWBUd3Z3mzspj6KC+QruXI=;
        fh=ArM0XlGIYEJIX6zWzFUqdJ/2vzPaoI4/UmZEiMv5ya8=;
        b=DanDYrSMO21XWO0m/A8Su/ptoKXCF0mhNaguHzzuiF60M/GpbBLecr33LrHeQdsE1C
         6DraZa5saV7Zf6KZjNL825Vwwor2vB6Ngcwg7U6XksS+Xjv2z3s/Ic4XVFU5lfaWUv9A
         YGUbRjirzgoy+ts26SIExxBaX3J5JkROozWwcPqvXRzllwSgM1d4GCsc001ibdOyYZzX
         l7nw0Rig7J0A/zg7APmxv0UBfOu/IUdx71/X6WkLBUKZuqRh7azYzkA2TcRMgbKJcxfR
         IevqLP5RqaA1RzpZsCGbz7FZWCH1x5KLnM8GsCvOC8GFi6etS3gjPvGLwhsfRcHykXCk
         trzQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791624648; x=1792229448; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaeLdrJMLAw9c9trS1NJ9kWBUd3Z3mzspj6KC+QruXI=;
        b=iKySHv0PX1OkyOvgHr8yh9mfItUl7JBm6oV11Dxtl2+CIq7ZalT7Uh72If28jW/ZES
         mYgJhcl2kCSqMM5tJMCYhPczdc25+fPx9myKlUUAg4cTZREYq4IB/4MICfHEru8a5ZLY
         y8BErcMTbjlkvF9t4vynS++/c8gsUO4CnZsI87YOvs00Cu1NsVkniMVGtVyja+fzZoHk
         hFkPN5835FeR9w5fFHaijRWwwBYuhzul/3GlynLNbuzNwjfYq1lDsDQlOfkn6DFmj3ke
         SC+4LG9u8n459jKrf9uLYboc6CspR5LS8VwzFMuv/WfYEw9qN3vnfQQO/Qq1Une/WPE2
         a8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791624648; x=1792229448;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VaeLdrJMLAw9c9trS1NJ9kWBUd3Z3mzspj6KC+QruXI=;
        b=2LCg6rUL4v+My5OQpKViM7gfp0w2e+6zxBda1xlEmxPSe0asyhthVcZZYXQsP9Fh25
         2uxjibInQNpojTuDDwncuprIF5UtexiPiayTHzacjXeiYYNUuQ/qNFhRQDEg6aMSlT+j
         R1dTC+Hp9MGc5XoT/0x477BgOHeqY4B/5Au51dqJnm0UdM0BEmaTs814WgCyrqZaLzNY
         5GjBvnVDllOby0T/uMF49vAx8cEqlC4daYdYCC50euFIhBFX2kuCslrLHF0Sxxx4pi5k
         jo26GKk+4sZarYWnqazE+c9CiVDmjB5nkwbiJTs4QbSiOLi3XPP2OwRKe48vZ2bgxn0l
         f6LA==
X-Forwarded-Encrypted: i=1; AKwUvBwQztu1wOV9dMV4pkUY+4XPe/nvsCYDK37g70QFqir/5dx1Qt9y0T2K6VEZK5KSnfWYz5QmyFZ/ahxQOXlt@lists.openembedded.org
X-Gm-Message-State: AFq9FYJFcJNsEJ4g7s5naCVqgZ3pjK9wh5xYp7h59eQRwgego4Na0l7I
	bhEpoqQRLROdjMXNKCNY5PaKe+W+ahzWedn6qJ4yk79FOQok5XcxgXTUxnBN9nqRhGpsWimC+TF
	mXs28dhsqFGlfF5Fo4Od9ce+eImsmM2M=
X-Gm-Gg: AYBFou0XkJaQCaLwGWmGrn24Bp+buKgcza6Q7xtfm4IJ57MvYHCxEivpwheBDBGgInc
	RfRG+v+sxw9MF36g0WiBiFNRFVm7uXh0Mkyf2UQeeCmWNCSXMldp9GBBHOGU6SrLJT9rH81ul/m
	WM1PR7Rid8Hc+P6MUb2bV5CSEQsYmJjLqdmQ2ifuQdc9rTbU4/KHm2bneCk9z66hFtjOWyb8ZaJ
	f4J+9ujPw4okRJq+i4DjE46sdrmDRGJXCBgxp7t3OvxJrRNM+/wV2P4ySAaaXy+SPhNuVvq9DQG
	z+mMIlsNpGwccUoR4HAGeDEZ9d/OCglQifGhzdZjgMH5KWMwGagH
X-Received: by 2002:ad4:5d4d:0:b0:919:5896:e93b with SMTP id
 6a1803df08f44-91b5d595eccmr59048766d6.19.1791624647941; Sat, 10 Oct 2026
 02:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20261009133418.215223-1-ross.burton@arm.com> <CAGAhMByanL8TzBt=EPnW15bdPOaY1mjY4JtTv54ghie7AZx=Tg@mail.gmail.com>
In-Reply-To: <CAGAhMByanL8TzBt=EPnW15bdPOaY1mjY4JtTv54ghie7AZx=Tg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 10 Oct 2026 11:30:36 +0200
X-Gm-Features: AclHuK_W_eQrfAUQT6aphV8KtrNMxRwXThTe_HnLgRDBERpstgleia4c8ZyvUMc
Message-ID: <CANNYZj_jwXcqc1tqViGvGCmJX6PZqZQaJLD4ToNt+c7uk3aMCA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] packaging-pypi: make bitbake-setup depend
 on websockets
To: rob.woolleywr@gmail.com
Cc: ross.burton@arm.com, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b624e8065d791e7e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Oct 2026 09:30:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20312

--000000000000b624e8065d791e7e
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 21:29, Rob Woolley via lists.openembedded.org
<rob.woolleywr=gmail.com@lists.openembedded.org> wrote:

>
> I think this would add the websocket module to the bitbake-setup package,
> even though it doesn't deliver the bitbake code that uses websocket.
>
> I looked at the bitbake code, and it seems to already cover this failure
> case in a commit from Alexander:
> https://git.openembedded.org/bitbake/commit/?id=2d15e6fc93f6a73c9c84e399613f931f1c783922
>
> It looks like it should output the following message to the user in this
> situation:
>
> Unable to use hash equivalence server at 'websocket' due to missing or
> incorrect python module:
> websocket
> Please install the needed module on the build host, or use an environment
> containing it:
>  - if you are using bitbake-setup, run 'bitbake-setup install-buildtools'
>  - openembedded-core layer contains 'scripts/install-buildtools' that can
> also be used
>  - or set up pip venv
> You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result
> in significantly longer build times as bitbake will be unable to reuse
> prebuilt sstate artefacts.
>
>
> Is there a use case where the user won't see the message?
>

I think the intent (which I fully support) is that when a user runs 'pip
install bitbake-setup', that would install both bitbake-setup and
websockets. So they never even see this message or have to figure out what
to do about it. Ross's fix is right, if it adjusts the dependencies of
bitbake-setup package to include websockets.

I've just done a demo at bitbake-setup at ELC/OSS and there was a slightly
awkward but mercifully brief moment where the message popped up when I
tried to run bitbake, and I had to 'pip install websockets' and rerun
bitbake. Let's eliminate this.


Alex

--000000000000b624e8065d791e7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, 9 Oct 2026 at 21:29, Rob Woolley =
via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &l=
t;rob.woolleywr=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail=
.com@lists.openembedded.org</a>&gt; wrote:</div><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><br><div>I think this would add the websocket module to the b=
itbake-setup package, even though it doesn&#39;t deliver the bitbake code t=
hat uses websocket.<br><br>I looked at the bitbake code, and it seems to al=
ready cover this failure case in a commit from Alexander:=C2=A0<a href=3D"h=
ttps://git.openembedded.org/bitbake/commit/?id=3D2d15e6fc93f6a73c9c84e39961=
3f931f1c783922" target=3D"_blank">https://git.openembedded.org/bitbake/comm=
it/?id=3D2d15e6fc93f6a73c9c84e399613f931f1c783922</a></div><div><br></div><=
div>It looks like it should output the following message to the user in thi=
s situation:</div><div><br></div><blockquote style=3D"margin:0px 0px 0px 40=
px;border:medium;padding:0px"><div><div>Unable to use hash equivalence serv=
er at &#39;websocket&#39; due to missing or incorrect python module:</div><=
/div><div><div>websocket</div></div><div><div>Please install the needed mod=
ule on the build host, or use an environment containing it:</div></div><div=
><div>=C2=A0- if you are using bitbake-setup, run &#39;bitbake-setup instal=
l-buildtools&#39;</div></div><div><div>=C2=A0- openembedded-core layer cont=
ains &#39;scripts/install-buildtools&#39; that can also be used</div></div>=
<div><div>=C2=A0- or set up pip venv</div></div><div><div>You can also remo=
ve the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly =
longer build times as bitbake will be unable to reuse prebuilt sstate artef=
acts.<br></div></div></blockquote><div><div><br>Is there a use case where t=
he user won&#39;t see the message?<br></div></div></div></blockquote><div><=
br></div><div>I think the intent (which I fully support) is that when a use=
r runs &#39;pip install bitbake-setup&#39;, that would install both bitbake=
-setup and websockets. So they never even see this message or have to figur=
e out what to do about it. Ross&#39;s fix is right, if it adjusts the depen=
dencies of bitbake-setup package to include websockets.</div><div><br></div=
><div>I&#39;ve just done a demo at bitbake-setup at ELC/OSS and there was a=
 slightly awkward but mercifully brief moment where the message popped up w=
hen I tried to run bitbake, and I had to &#39;pip install websockets&#39; a=
nd rerun bitbake. Let&#39;s eliminate this.</div><div><br></div><div><br></=
div><div>Alex=C2=A0</div></div></div>

--000000000000b624e8065d791e7e--

