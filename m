Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F195FC433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 08:14:11 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.5188.1666772044306039857
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Oct 2022 01:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=KMMyAJPG;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id y16so14576738wrt.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Oct 2022 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsP6JWkgRKYE9uClKu1DnA7WVSDcE/B3jvNPrJuOQxI=;
        b=KMMyAJPGA160VDuLAtfKd7EVqdJRqDHtHL16awqM03EHADw5v13HEfZxHN07nquGeC
         n7UFrgd66JQ+MKWHZGL85StsNlzYPM8SkighVJNSFXRjU0QvTtyJYunJyS3/fGRtCL1/
         9/aQcy71PrRbgMCnpTbSFlK/bWxSRGSexIClcpuaijpXJTkXilDqSIpXqdeYHeVjKOFc
         Cf0yvKAfEgQq3YutAvj0RcvjgY5tHk+KPSrXI7bxvZWHoEdzsEB0+SiilFcZvpe5y6LR
         iRIM8pHK8oCQOsOvGbtpl1jM9s2ALtE2iHfnhxrH7PA/mziQn+nD4KbOy3/9ng2CpXVm
         RocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsP6JWkgRKYE9uClKu1DnA7WVSDcE/B3jvNPrJuOQxI=;
        b=z13PH3RSBC0ycx7jFlrVLhyIoDEn8rz/o60ihjKCn0iucQAhp4rvWi3Bpz3X1MXLp4
         N213wliSOXhxqnzm6/lBdvN6JOJfukClICeUIhvqoI8sEhXbvtuQdDs2Qz2C47W9V6tE
         ulLE6erAnXSOUHBa8vjhDniGKxzvIFdS6RE9kjiMVJUETs+ZyU1Scpm3Y+bdQ2+LHISs
         ghu5AVhgAzi2FaO7AlS3d5o2E7fwFIj2oxUsAaFPxBETJMfgoQuhA4um3Q76I9Ur9oMu
         ms2Deh2O3F8sUEo1Rk8c9h6/zqVE//K3TL2qUv6zoOESg3PoeB+QQfsed94YIt26u1Qx
         KS0Q==
X-Gm-Message-State: ACrzQf27U9tSucyDogYx4jHybtCUL3T95uF/8pjBUtK6FlhNfZDR7S+Z
	/4xJv8FknuGNyKVQQ6I5Pc5x3NTth6hdkISSMok=
X-Google-Smtp-Source: AMsMyM7i0yBu/1fjffgpbbuV23mQ6sH7QHzbZNCKgC8X27XWzxcLqAeCpkQqXoIK7XNevtBhNjB2fORISjZZFyqrpsI=
X-Received: by 2002:adf:dd12:0:b0:236:6ef7:dacf with SMTP id
 a18-20020adfdd12000000b002366ef7dacfmr10594361wrm.204.1666772042344; Wed, 26
 Oct 2022 01:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221017132026.88753-1-Martin.Jansa@gmail.com> <321b3611966533c6083eb40ed4300971f9e0a347.camel@linuxfoundation.org>
In-Reply-To: <321b3611966533c6083eb40ed4300971f9e0a347.camel@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 26 Oct 2022 10:13:49 +0200
Message-ID: <CA+chaQf62vb2M-KzSNmrjHvFHvf3kN-wvi8sx1YShC-Oir609g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] gitsm: pass lfs parameter from main repo
 to all its submodules
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000816d4305ebeb9b02"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Oct 2022 08:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14051

--000000000000816d4305ebeb9b02
Content-Type: text/plain; charset="UTF-8"

Hi,

yes, that might be better default, but this change alone doesn't resolve
all issues with git-lfs still :(

as documented by added test:

https://patchwork.yoctoproject.org/project/bitbake/patch/20221018193746.3599845-1-Martin.Jansa@gmail.com/

I don't know what is expected behavior which would be reproducible (not
affected by user's .gitconfig and git-lfs installed or not-installed).

Regards,

On Tue, Oct 25, 2022 at 4:21 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2022-10-17 at 15:20 +0200, Martin Jansa wrote:
> > * it might not be ideal in some cases where we might require LFS objects
> >   only in some of the submodules, but still better than no way to set
> >   lfs for submodules which causes git smudge issues in e.g.
> vulkan-samples
> >   when LFS is enabled in gitconfig
> >
> > [YOCTO #14938]
> >
> > Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> > ---
> >  lib/bb/fetch2/gitsm.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > index 25d5db0e..36f0464c 100644
> > --- a/lib/bb/fetch2/gitsm.py
> > +++ b/lib/bb/fetch2/gitsm.py
> > @@ -122,6 +122,7 @@ class GitSM(Git):
> >              url += ';protocol=%s' % proto
> >              url += ";name=%s" % module
> >              url += ";subpath=%s" % module
> > +            url += ";lfs=%s" % ud.parm.get("lfs", "1")
> >
> >              ld = d.createCopy()
> >              # Not necessary to set SRC_URI, since we're passing the URI
> to
>
>
> Shouldn't that be:
>
> ud.parm.get("lfs", "0")
>
> i.e. default to off but pass if present?
>
> Cheers,
>
> Richard
>

--000000000000816d4305ebeb9b02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>yes, that might be better default, =
but this change alone doesn&#39;t resolve all issues with git-lfs still :(<=
/div><div><br></div><div>as documented by added test:<br><br><a href=3D"htt=
ps://patchwork.yoctoproject.org/project/bitbake/patch/20221018193746.359984=
5-1-Martin.Jansa@gmail.com/">https://patchwork.yoctoproject.org/project/bit=
bake/patch/20221018193746.3599845-1-Martin.Jansa@gmail.com/</a><br><br>I do=
n&#39;t know what is expected behavior which would be reproducible (not aff=
ected by user&#39;s .gitconfig and git-lfs installed or not-installed).<br>=
</div><div><br></div><div>Regards,</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 25, 2022 at 4:21 PM Ric=
hard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richa=
rd.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Mon, 2022-10-17 at 15:20 +0200, Martin Jans=
a wrote:<br>
&gt; * it might not be ideal in some cases where we might require LFS objec=
ts<br>
&gt;=C2=A0 =C2=A0only in some of the submodules, but still better than no w=
ay to set<br>
&gt;=C2=A0 =C2=A0lfs for submodules which causes git smudge issues in e.g. =
vulkan-samples<br>
&gt;=C2=A0 =C2=A0when LFS is enabled in gitconfig<br>
&gt; <br>
&gt; [YOCTO #14938]<br>
&gt; <br>
&gt; Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.c=
om" target=3D"_blank">Martin.Jansa@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/gitsm.py | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
&gt; index 25d5db0e..36f0464c 100644<br>
&gt; --- a/lib/bb/fetch2/gitsm.py<br>
&gt; +++ b/lib/bb/fetch2/gitsm.py<br>
&gt; @@ -122,6 +122,7 @@ class GitSM(Git):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url +=3D &#39;;protoco=
l=3D%s&#39; % proto<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url +=3D &quot;;name=
=3D%s&quot; % module<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url +=3D &quot;;subpat=
h=3D%s&quot; % module<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url +=3D &quot;;lfs=3D%s&qu=
ot; % ud.parm.get(&quot;lfs&quot;, &quot;1&quot;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ld =3D d.createCopy()<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Not necessary to set=
 SRC_URI, since we&#39;re passing the URI to<br>
<br>
<br>
Shouldn&#39;t that be:<br>
<br>
ud.parm.get(&quot;lfs&quot;, &quot;0&quot;)<br>
<br>
i.e. default to off but pass if present?<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000816d4305ebeb9b02--

