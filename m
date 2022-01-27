Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F18BC433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 12:07:49 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by mx.groups.io with SMTP id smtpd.web11.27611.1643285268331127500
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 04:07:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ekgFH/Ci;
 spf=pass (domain: gmail.com, ip: 209.85.221.173,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f173.google.com with SMTP id y192so1689165vkc.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 04:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWQQn1Dv5TIq0MtKyx0crrQLBkIW+Ea7DTdWadb0TeU=;
        b=ekgFH/CiMD1QDKj+B6aJZXRmG13o9iHZpLso54dA9IGZRlaACSZFFatodIRHNLBgZ/
         6ZxYwHnsvQKjG9yIbXlgcHNFVTOH+QSmJQoLof6rRrGLIPcog82x3j7rb99laoY9/z/Y
         CgFUuGbn6/DYNfJgL19fswJYZMQWkgavXrE/kN9D4/C5+SHDMVEI6H4300mNZiBU8cap
         smKqohBCjekFQHoLMJEZ/iJ+NqcWqJldh89PwxqpV+kiq+PkZawlntj8jcAxHb83Jlb1
         S+hVW6lz0ZqotJcfB+5GrgBypwuz6SnTadLoRC1A1Lq+ZeCuwxnEvUeMaXRyX663M+3y
         pPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWQQn1Dv5TIq0MtKyx0crrQLBkIW+Ea7DTdWadb0TeU=;
        b=kHTvnfK5PLAKShKnrsXw2U2mJjgOJm9VG6VQ/edIv91AJb4VhYOGHQGowOZjbPQ4R+
         u+fqeDSw89iYKJ5cAkxNIwxGPgK4t2F8QRW4uV1dxloCQ8Xd1cvroDxezHfh+cNmg5o8
         RgAHveMbfbZnM31TPsHrqBAoFnksH8iycReNMqGqsH/3No6C5tSFJPRtpFZvzffcQO8z
         Odsgina919zR2ggOBEKLKfBGYWvbfU9lwxGowKzsm1LecwCLdrJxcwH5i2S6PLAUi+/3
         +m4VJwjW/60vbajo/Ynnqhuy2m7m91JHQT7M7Jl75alqBx4KXWqYzIp/szPiq07lcZQ5
         3M+g==
X-Gm-Message-State: AOAM53361eSp8KehpRVODHwnuAoTpAWVuo6eJ5tlaETv1zylaSXdbix1
	MzWCpYJ5pbIi70DgZBtYiacFb3GFyV2PiKcLlho=
X-Google-Smtp-Source: 
 ABdhPJzOtex0A76DXbIe9nbcFIDv481fwBaJDBwCF1SznhyNwAFz+9qTvjKnwEmLlT+e9cvgdP0/ftNKvgKFzmqncsA=
X-Received: by 2002:a05:6122:218f:: with SMTP id
 j15mr700207vkd.20.1643285267519;
 Thu, 27 Jan 2022 04:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20220119180015.1931903-1-richard.purdie@linuxfoundation.org>
 <b889e360-9b6e-4517-c03a-f31f3168e36e@weidmueller.com>
 <CANNYZj8X3-zB+JBf2aHhiNmgPEBZ6KrrdZCAxBr9gj6WVJwsxQ@mail.gmail.com>
 <c70b25c8-417c-1a67-ae2e-cc717151c198@weidmueller.com>
In-Reply-To: <c70b25c8-417c-1a67-ae2e-cc717151c198@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 27 Jan 2022 13:07:36 +0100
Message-ID: 
 <CANNYZj_+wuv7wmJqFSufcjyogehXkSSsaVgvik5cQx+wUFiEgw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add crate fetcher
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000a29e4705d68f2a61"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jan 2022 12:07:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13290

--000000000000a29e4705d68f2a61
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jan 2022 at 13:00, Stefan Herbrechtsmeier <
stefan.herbrechtsmeier-oss@weidmueller.com> wrote:

> Am 27.01.2022 um 11:53 schrieb Alexander Kanavin:
> > this is already in master, so the concerns you have are probably better
> > addressed with followup patches.
>
> Does this means the SRC_URI syntax is fixed and we have total different
> syntax to specific a repository, package name and version for npm and
> crate?
>

No it means that patches to address the concerns are welcome, and they will
be reviewed on their own merit. Nothing is fixed, and everything can be
changed.


Alex

--000000000000a29e4705d68f2a61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, 27 Jan 2022 at 13:00, Stefan Herbrechtsmeier &lt;<a href=3D"=
mailto:stefan.herbrechtsmeier-oss@weidmueller.com">stefan.herbrechtsmeier-o=
ss@weidmueller.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Am 27.01.2022 um 11:53 schrieb Alexander Kanavin:<br>
&gt; this is already in master, so the concerns you have are probably bette=
r <br>
&gt; addressed with followup patches.<br>
<br>
Does this means the SRC_URI syntax is fixed and we have total different <br=
>
syntax to specific a repository, package name and version for npm and crate=
?<br></blockquote><div><br></div><div>No it means that patches to address t=
he concerns are welcome, and they will be reviewed on their own merit. Noth=
ing is fixed, and everything can be changed.</div><div><br></div><div><br><=
/div><div>Alex <br></div></div></div>

--000000000000a29e4705d68f2a61--

