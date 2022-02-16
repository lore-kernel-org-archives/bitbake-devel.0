Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C70DC433F5
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 16:18:31 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web12.1091.1645028310260118947
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 08:18:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XvMI0qn6;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: kergoth@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id vz16so553182ejb.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxyPDN9Ez3RS/8eAsd8LZcysrYvP1p0uCSWNHhkmiqU=;
        b=XvMI0qn68qe5JZjGzSwaWdq7Pl4y+jM3AC5khf0jjUGAlsRLsqtRX06C54DuQlMWRm
         gqgv8mxzTaBw6tPBGGYxaHrXN84AiV+XGqEfJxOE4iwTFyOibSFrHFgK1jYQSpD/lrj7
         Lv0z4Osd2boZFi4L1L2y9EFhg8eni17JqAkwNuDbo7BW2OjYnkDtPeK+rwDUcllJI/XP
         KLMpdXB4mDWYIl92uI5Cp7t0l/V05iDJ/mL+A6/GtMsqyVU7YOy7A3mrW6jMUvOQkJuB
         A5O8tfflDzWz5QMur6hWiLDFbZuH1hRraQKeEQ+rp64c/z/WUllv3Ax2il/oN2F3ofxE
         gmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxyPDN9Ez3RS/8eAsd8LZcysrYvP1p0uCSWNHhkmiqU=;
        b=vlEmRg+sJvjq5WNvs3Kbeq58g9MAdeYF3PVmegX0HD0bT2xspLK3MGYAPAIsEo01Ev
         phVfN2/Qs+JbRtgifWMa5f53+hBHMHc+jMZVNRHbRQJqwW0TH9rBwFgEpxKXt6/K3lUv
         LZna/rLMp7QeKf4RbegMtGiQHFA/iDCXHcSQ37/61JE/UNP+ltmvoqe3WtDeQZzpQpkn
         BTUJF0c1y+4zLq9CndIc/r0Qe4FK01qgtRNKcwjTfxU+0BA3hRjNZN0WxdDayLbVeLsi
         JiOl3G1kJlZLzsNZK/j0RB6mjhq6w47uTcJPNZI7E6sIyPu0uqwfbPIH2ycyyedTwrJG
         7Ykw==
X-Gm-Message-State: AOAM532YWMNr9QS914dfvzk9eHW8zenVPy4caCNpCxnuCgXrWFTYR3QJ
	okhck/TJoTC8UlFgrGZc648s/u31+1OgmTfLhoQ=
X-Google-Smtp-Source: 
 ABdhPJztQpL4kWCFrEgVdCvafI1XDm37hPSrANF+U3oFoxsbxhNDWC64qXq19zfZuP5OQmBmcgDHeT4BUWzKeYwgpnU=
X-Received: by 2002:a17:906:4f0a:b0:6ce:e4fc:34d0 with SMTP id
 t10-20020a1709064f0a00b006cee4fc34d0mr2867926eju.717.1645028308681; Wed, 16
 Feb 2022 08:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20220216154646.2499980-1-JPEWhacker@gmail.com>
In-Reply-To: <20220216154646.2499980-1-JPEWhacker@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 16 Feb 2022 09:18:17 -0700
Message-ID: 
 <CABcZANmeaeGOKLXjon4-dm+TRseWZG7FKeH90iQj3E5govOH8A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] bitbake: msg: Add bb.warnonce() and
 bb.erroronce() log methods
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000fc098005d824ff0c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 16:18:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13357

--000000000000fc098005d824ff0c
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 16, 2022 at 8:47 AM Joshua Watt <JPEWhacker@gmail.com> wrote:

> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> This adds a log level and logging function call to use it where the
> warning or error will only be displayed once, regardless of how many
> times the message is logged.
>

This looks really useful, I've had use cases for this on a whole lot of
occasions, so thanks much for your work on this, Richard!

-- 
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
Industries Software

--000000000000fc098005d824ff0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Feb 16, 2022 at 8:47 AM Joshua Wa=
tt &lt;<a href=3D"mailto:JPEWhacker@gmail.com">JPEWhacker@gmail.com</a>&gt;=
 wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: Richard Purdie &lt;<a href=3D"mailto:richard.purdi=
e@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org=
</a>&gt;<br>
<br>
This adds a log level and logging function call to use it where the<br>
warning or error will only be displayed once, regardless of how many<br>
times the message is logged.<br></blockquote><div><br></div><div>This looks=
 really useful, I&#39;ve had use cases for this on a whole lot of occasions=
, so thanks much for your work on this, Richard!</div></div><div><br></div>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=
=3D"ltr"><font color=3D"#333333">Christopher Larson<br><a>chris_larson@ment=
or.com</a>,=C2=A0<a>chris.larson@siemens.com</a>,=C2=A0<a>kergoth@gmail.com=
</a><br>Principal Software Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Si=
emens Digital Industries Software</font><br></div></div></div></div>

--000000000000fc098005d824ff0c--

