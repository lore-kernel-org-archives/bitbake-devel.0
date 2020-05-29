Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
 by mx.groups.io with SMTP id smtpd.web11.31800.1590747133746503810
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2020 03:12:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ovh6i+s3;
 spf=pass (domain: gmail.com, ip: 209.85.208.194, mailfrom: maurofrqueiros@gmail.com)
Received: by mail-lj1-f194.google.com with SMTP id e4so1927726ljn.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2020 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxaPiWaKZ6ibZhagVQPSQ4mgJfxRTg03hK++qiz7huQ=;
        b=Ovh6i+s31hgwO/RNBgdNVgGYGYPXOPwyZeTfXIMsxdlZnllwqq1sgzSZru++ytyQkc
         ZNYTAujzHeyY7uoyfycuvAQYNl4DgNC7nV2uRnVkvwkgbKX9eadmtB0SOdugc59lLBJ5
         WjVf3OwTwbhen0EOb71EHAObHX3FdLYxCnXz8NIg55uQ7McqiAu79B9Yey0piZ9KSep3
         GkgGdc7n2Cxt+omhIdvIWwytF4pHKdwH1rYrut0hu67GJ7Q0xG6XiMhD9ooyw5WJf3vO
         rJth1ruloabMtyeC2tE3kv856UkP5kVZjC6YAyIBurj566L+ekVaoljbkFVdxkwQSure
         U0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxaPiWaKZ6ibZhagVQPSQ4mgJfxRTg03hK++qiz7huQ=;
        b=Hj/9qW+GRdKSVS3gnQh3Q51nSyLbplv3AudDp/nroBDeoufLYzKySuCp9FkRqUwTS9
         Di6wWpJ1nQAe24wdifkCBh5xX4UAvtcMM81fd7Wi1MS4aqeaPB8vTouvHU7BGrcyEbsS
         e+ZAt9Ci75K8ky1k6uzgLE2Z076e1T+rrhBVoe8y3m5Qx6wa+XPmk/eKpZRN9G7iXtUj
         rhT1WswTqtay4/VXN7Kep5yZpt6WPCAvHkWuMUs5CULUgafDHiZ3vSrd1dDzJmV+FnAY
         +6+0FG9yETM3YGn1g6aR52OYj+7ydpJSCYJCZ9rUwhbAOrIxMgXUC6StzlRH8ZkTcYT7
         jGpA==
X-Gm-Message-State: AOAM5302qzr2/itFeAMddwhW08ZxHdtrhgMs1X7+klgekmcVLVpnCUlr
	AQeU0UU0eQTCZy2wqjzWubyqJdnMEL6sg2G6upg=
X-Google-Smtp-Source: ABdhPJyYrmkW1QPZfaQ/vbOEFBm7FXYqyjnF7vWeSvOnWtVDAFKPHN42nxWdWPRLGNrFi+WJGCiFnQRanVS74I4U60k=
X-Received: by 2002:a2e:a374:: with SMTP id i20mr3651802ljn.382.1590747131872;
 Fri, 29 May 2020 03:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200528141853.213890-1-maurofrqueiros@gmail.com> <d373c7f3e2c72c995dbe4af7589f76f3dee9535d.camel@linuxfoundation.org>
In-Reply-To: <d373c7f3e2c72c995dbe4af7589f76f3dee9535d.camel@linuxfoundation.org>
From: =?UTF-8?B?TWF1cm8gUXVlaXLDs3M=?= <maurofrqueiros@gmail.com>
Date: Fri, 29 May 2020 11:12:00 +0100
Message-ID: <CAOev9Bc-ONuYWUKGckpKHm8uey9V5Ssh-x4jYuavVFEVyUjZ2g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] git.py: skip smudging if lfs=0 is set
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b90bba05a6c6aded"

--000000000000b90bba05a6c6aded
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's because I was using .lfsconfig instead of .gitattributes in
"contains_lfs" function. self-tests only use the latter.
I've send v2 patches.

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia sexta,
29/05/2020 =C3=A0(s) 06:46:

> On Thu, 2020-05-28 at 15:18 +0100, Mauro Queir=C3=B3s wrote:
> > Git-LFS objects were being fetched even when lfs=3D0 was not set.
> > This patch disables LFS smudging when lfs=3D0. That way, only the LFS
> > pointers
> > are downloaded during checkout.
> >
> > Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
> > ---
> >  lib/bb/fetch2/git.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 5b3793a7..4c7d388e 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -475,6 +475,9 @@ class Git(FetchMethod):
> >
> >          need_lfs =3D ud.parm.get("lfs", "1") =3D=3D "1"
> >
> > +        if not need_lfs:
> > +            ud.basecmd =3D "GIT_LFS_SKIP_SMUDGE=3D1 " + ud.basecmd
> > +
> >          source_found =3D False
> >          source_error =3D []
>
> Thanks for the patches, the sound good. Unfortunately they cause
> bitbake-selftest to fail:
>
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/991/ste=
ps/8/logs/step1d
>
> Cheers,
>
> Richard
>
>

--000000000000b90bba05a6c6aded
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That&#39;s because I was using .lfsconfig instead of .gita=
ttributes in &quot;contains_lfs&quot; function. self-tests only use the lat=
ter. <br>I&#39;ve send v2 patches.<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&=
gt; escreveu no dia sexta, 29/05/2020 =C3=A0(s) 06:46:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Thu, 2020-05-28 at 15:18 +0100, M=
auro Queir=C3=B3s wrote:<br>
&gt; Git-LFS objects were being fetched even when lfs=3D0 was not set.<br>
&gt; This patch disables LFS smudging when lfs=3D0. That way, only the LFS<=
br>
&gt; pointers<br>
&gt; are downloaded during checkout.<br>
&gt; <br>
&gt; Signed-off-by: Mauro Queiros &lt;<a href=3D"mailto:maurofrqueiros@gmai=
l.com" target=3D"_blank">maurofrqueiros@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/git.py | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
&gt; index 5b3793a7..4c7d388e 100644<br>
&gt; --- a/lib/bb/fetch2/git.py<br>
&gt; +++ b/lib/bb/fetch2/git.py<br>
&gt; @@ -475,6 +475,9 @@ class Git(FetchMethod):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 need_lfs =3D ud.parm.get(&quot;lfs&q=
uot;, &quot;1&quot;) =3D=3D &quot;1&quot;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not need_lfs:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D &quot;GIT_LF=
S_SKIP_SMUDGE=3D1 &quot; + ud.basecmd<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source_found =3D False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 source_error =3D []<br>
<br>
Thanks for the patches, the sound good. Unfortunately they cause<br>
bitbake-selftest to fail:<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/79/build=
s/991/steps/8/logs/step1d" rel=3D"noreferrer" target=3D"_blank">https://aut=
obuilder.yoctoproject.org/typhoon/#/builders/79/builds/991/steps/8/logs/ste=
p1d</a><br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--000000000000b90bba05a6c6aded--
