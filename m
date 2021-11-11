Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD290C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 12:27:22 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by mx.groups.io with SMTP id smtpd.web11.9667.1636633642289649743
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 04:27:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=SMEbXd3W;
 spf=pass (domain: gmail.com, ip: 209.85.222.49,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f49.google.com with SMTP id o26so11490282uab.5
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 04:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zX8URqyZei1kMxKiYzH9dEVPUZ9jKN7W/DnnzM6WAbw=;
        b=SMEbXd3WFXziYZDLM3w6m0OFntPQ26dIHHfyJxlpLrpP/rU1aaQjV1g0UGrjXEHjLe
         a10nnKyZGG1CkcDvr8CNx/5744ryTWDYvselX1vNj72LpQmNiIJXOq8m4OuwaQape7jC
         AaLxHMCXqTdQV92WS9h85pa+fsoKjybmQcVFlRVyirJLpYznsAVW/QUsPUygW4qTmIyV
         c5vJOMv8QxcXxPHEvtcsjAD7DEmJQZrwg8x834IMCkZrgtd5cDTjRlhaTUETM50gtfsg
         4/z3NKP5bHzOTJb7Vahe/o3g6sbwL0YpQi/DxPUzGn7wyNDHLbUxCT8HoYtWjqPl+geD
         ImOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zX8URqyZei1kMxKiYzH9dEVPUZ9jKN7W/DnnzM6WAbw=;
        b=Y+Qxj3+OYA4p3fyMwSuiRdqEHPHpXnZA5n5Q1NAWeB+Da1tscZsGgbLI+67NH9dZpa
         gZP1+MUrmtzRq1aUgLREZb9aNjn2dU6YsfIeNM+CWDBZw8zmDgMDOLtLF0ncTb96QqER
         4CZl4vLetM4Sh7fR6d+GfZxLW0dCyrQia5SsWkp7/mzUrEK+9zcQpeMBoW1ZUEOHQOEr
         Lyobg9INEB1qPjVNVYv8s9egV8XY1RWw0xTTp6Rn0Wuk3+/Tejb3eF8sZSgAE1pxMkpp
         ywdr73GtziE9kYvTiWGZhLiXlWqiEdUEwD2VMHERO7+YcxTRJaNopzffYuUrziRENNCz
         qjvg==
X-Gm-Message-State: AOAM530ek1FY5l4DQJBGD49EsbfBO3paAERhB6roGbi5zH+3anCTu3Jg
	8le5apWlvk8gP8GeAwMkcz3Q91sL7B14xmxpMHU=
X-Google-Smtp-Source: 
 ABdhPJxRrX+KrqwrFciB4Qdsg894HVKj9eXaPrzXlEnE35kwZLSY7O2ixcibdzU34XK7HbiFnMP1GIQZoVw5cPukres=
X-Received: by 2002:a9f:2c98:: with SMTP id w24mr9877474uaj.89.1636633641321;
 Thu, 11 Nov 2021 04:27:21 -0800 (PST)
MIME-Version: 1.0
References: 
 <5b3eb5a7a03a999e37b2ac0aacf2997819c00fd2.camel@linuxfoundation.org>
 <30784.1636633081071526988@lists.openembedded.org>
In-Reply-To: <30784.1636633081071526988@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 11 Nov 2021 13:27:10 +0100
Message-ID: 
 <CANNYZj84=6tPBGvDupuMK=vE5orFQ5U6T6gD1=iHDZh3t_zb2g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
To: gabriel.valcazar@digi.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d1871405d08276d5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 12:27:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13016

--000000000000d1871405d08276d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Are your customers paying anyone in the =E2=80=98community=E2=80=99 for thi=
s work or any
other work we do? Seriously, if you want anyone to pay attention to ancient
yocto versions, you have to support that financially.

Alex

On Thu 11. Nov 2021 at 13.18, gabriel.valcazar via lists.openembedded.org
<gabriel.valcazar=3Ddigi.com@lists.openembedded.org> wrote:

> Hi Richard,
>
> Thanks for the explanation. I fully understand the reasoning behind your
> decision, but I really think this issue requires specific treatment due t=
o
> its nature.
>
> Ideally, customers using our legacy products (and thus, really old
> versions of our Yocto distribution) would migrate to newer products runni=
ng
> newer software, and these situations would be avoided altogether. However=
,
> we're talking about products that are already in production, with several
> devices in the field that require periodic updates. Maintaining outdated
> software, while not recommendable from several standpoints, is oftentimes=
 a
> more efficient approach than migrating to something newer, especially in
> these cases.
>
> Older Yocto builds are still possible for us and our customers via docker
> containers or virtual machines, which provide "old" environments where th=
e
> builds still work, despite all of the missing fixes in bitbake/poky.
> Basically, rather than patching the Yocto stack to fit our environment, w=
e
> adapt our environment to fit the Yocto stack - again, because several
> legacy customers have made the decision to depend on old Yocto versions.
>
> Having said this, I believe GitHub's deprecation of the *git *protocol is
> a special case because, regardless of the environment you're using or how
> many patches you've backported so far, builds will simply stop working
> altogether after the plug is pulled. No matter which environment we use,
> this is an external factor that's going to force changes in the Yocto
> stack, in areas that we have little to no control over. We're going to ha=
ve
> to fix it either way, but it would be a much smoother transition if the f=
ix
> were included by the community, and it's a unique enough case to warrant =
it
> being patched in older bitbake versions (in my opinion).
>
> Forgive me for the insistence, but I truly believe this situation require=
s
> exceptional treatment.
>
> Best regards,
> Gabriel
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13015):
> https://lists.openembedded.org/g/bitbake-devel/message/13015
> Mute This Topic: https://lists.openembedded.org/mt/86764631/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000d1871405d08276d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Are your customers paying anyone in the =E2=80=98communit=
y=E2=80=99 for this work or any other work we do? Seriously, if you want an=
yone to pay attention to ancient yocto versions, you have to support that f=
inancially.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Thu 11. Nov 2021 at 13.18, gabriel.valcazar via <a href=3D"http://lists.ope=
nembedded.org">lists.openembedded.org</a> &lt;gabriel.valcazar=3D<a href=3D=
"mailto:digi.com@lists.openembedded.org">digi.com@lists.openembedded.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1=
ex;border-left-color:rgb(204,204,204)">Hi Richard,<br><br>Thanks for the ex=
planation. I fully understand the reasoning behind your decision, but I rea=
lly think this issue requires specific treatment due to its nature.<br><br>=
Ideally, customers using our legacy products (and thus, really old versions=
 of our Yocto distribution) would migrate to newer products running newer s=
oftware, and these situations would be avoided altogether. However, we&#39;=
re talking about products that are already in production, with several devi=
ces in the field that require periodic updates. Maintaining outdated softwa=
re, while not recommendable from several standpoints, is oftentimes a more =
efficient approach than migrating to something newer, especially in these c=
ases.<br><br>Older Yocto builds are still possible for us and our customers=
 via docker containers or virtual machines, which provide &quot;old&quot; e=
nvironments where the builds still work, despite all of the missing fixes i=
n bitbake/poky. Basically, rather than patching the Yocto stack to fit our =
environment, we adapt our environment to fit the Yocto stack - again, becau=
se several legacy customers have made the decision to depend on old Yocto v=
ersions.<br><br>Having said this, I believe GitHub&#39;s deprecation of the=
 <em>git </em>protocol is a special case because, regardless of the environ=
ment you&#39;re using or how many patches you&#39;ve backported so far, bui=
lds will simply stop working altogether after the plug is pulled. No matter=
 which environment we use, this is an external factor that&#39;s going to f=
orce changes in the Yocto stack, in areas that we have little to no control=
 over. We&#39;re going to have to fix it either way, but it would be a much=
 smoother transition if the fix were included by the community, and it&#39;=
s a unique enough case to warrant it being patched in older bitbake version=
s (in my opinion).<br><br>Forgive me for the insistence, but I truly believ=
e this situation requires exceptional treatment.<br><br>Best regards,<br>Ga=
briel
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13015): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13015" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13015</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86764631/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86764631/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000d1871405d08276d5--

