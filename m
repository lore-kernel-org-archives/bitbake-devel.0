Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9817FC433F5
	for <webhook@archiver.kernel.org>; Tue,  7 Dec 2021 09:39:15 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web11.64956.1638869954996973734
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 01:39:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oC+kRh18;
 spf=pass (domain: gmail.com, ip: 209.85.222.54,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id p2so25274635uad.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkMNzw2JB4EFWU6IDaR+wAH7GFw9iTkwDf9jgKT32X0=;
        b=oC+kRh1845jPqgP6gRf045Jm8PFlPH1CxDpoNqJO5wC+QOc7M2KC3SyQK61rQKZzeh
         nSI2yceU1dFqHCuQkBJEEXW7PZJQlFbHY5pO0VbMEDxuTNWY069lZAijLO9qRbh8DTe1
         EWC3yoidUfKcWBB0gnzL3SSwnbp6xilpFtOZUvq5G268j+TzrZjMusKfZoiMfFEhIE0z
         DEVetpzOzwLkATzqg4lWTJikaEV9YpfLf85SfYDBbtPe76M/2EXBW7bSjpKgyK/Pg5t1
         u8DE862pgdZn/ABupWedigzxJK/+1eWyD/RJqEf4eYK2DllB0XdI7L29Pqj28gT7l5d9
         mIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkMNzw2JB4EFWU6IDaR+wAH7GFw9iTkwDf9jgKT32X0=;
        b=v+S8mWNvZirqneCHXsXTVDbs3MNis3QLJOVvJ/9VI6qniIQtgMPyE1cx5DLH1hVkHR
         Pj+Hb+cyJ/xuKv6buo6Gw+BjtxkQJJSGfH8b1DQlqNi2e28po+/1w42rR0d69jPzmVI0
         kgyDMAi0KOUOoZKLkg3UakIy4QG5pRozaHwEUZ6Jb9XSJ4HnCIPyUJaHndLAzs3L7CcM
         yjRlbLqMlzc31MBVgc/AKN3mwg+hn5fETzXQMxgeI9XPwJNqJkg49aoH7GUpltklzce1
         DqJjJCNQhZAra9uwiPUhUAIUp239kCzel4YoevLOabmHU+W8OzQmoFuvRbnW3+Y9zBr8
         EqZg==
X-Gm-Message-State: AOAM531S9NRv5mtAtDK2WfcySiLkXFr0Ey1zsIIRYUxbjPN04XkZOVfD
	rc+VU3CBfPdGrXeWnWSWC939tWHPkCw8HUUL0dw=
X-Google-Smtp-Source: 
 ABdhPJxbPltFf+C9OVhPDcMwlv03wcTfxJnPWMcHRNkC6Ra+s1NqaSik645lmUJJbecSVSbTyFyvdCetJf931vMjTXU=
X-Received: by 2002:a67:7105:: with SMTP id m5mr43881356vsc.81.1638869954188;
 Tue, 07 Dec 2021 01:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20211206164119.4076119-1-alex@linutronix.de>
 <4ff493233f785384ac845b2b712388155a328bab.camel@linuxfoundation.org>
In-Reply-To: 
 <4ff493233f785384ac845b2b712388155a328bab.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 7 Dec 2021 10:39:03 +0100
Message-ID: 
 <CANNYZj-=TU6QNRDE4u13cc28F_PxnzCeMSd7txRh6N2pMTmspw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: do not hardcode tarball
 compressors in version check
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000073d75905d28b25ec"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Dec 2021 09:39:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13138

--00000000000073d75905d28b25ec
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Dec 2021 at 23:47, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> >          # match name, version and archive type of a package
> >          package_regex_comp =
> re.compile(r"(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
>
> Looks good, is there something we should be adding to
> lib/bb/tests/fetch.py so
> that we don't forget this lesson?
>

I don't think so, 'test that various tar.something suffixes are ok' is
already covered, and it's not possible to make a test for 'any tar.suffix
is okay'.

Alex

--00000000000073d75905d28b25ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, 6 Dec 2021 at 23:47, Richard Purdie &lt;<a href=3D"mailto:ri=
chard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # match name, version and archive type of a=
 package<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 package_regex_comp =3D re.compile(r&=
quot;(?P&lt;name&gt;%s?\.?v?)(?P&lt;pver&gt;%s)(?P&lt;arch&gt;%s)?[\.-](?P&=
lt;type&gt;%s$)&quot;<br>
<br>
Looks good, is there something we should be adding to lib/bb/tests/fetch.py=
 so<br>
that we don&#39;t forget this lesson?<br></blockquote></div><div class=3D"g=
mail_quote"><br></div><div class=3D"gmail_quote">I don&#39;t think so, &#39=
;test that various tar.something suffixes are ok&#39; is already covered, a=
nd it&#39;s not possible to make a test for &#39;any tar.suffix is okay&#39=
;.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Ale=
x<br></div></div>

--00000000000073d75905d28b25ec--

