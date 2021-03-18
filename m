Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.1127.1616101183316964601
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Mar 2021 13:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=BflHql9s;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: kergoth@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id va9so6136564ejb.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Mar 2021 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+nNQQvSTfkfWnHt2ZtwSO5BHFSg963dbkOjOyCQ2aw=;
        b=BflHql9sZAmgpQUEf1MtbdMP5laTZrwsIgjXlyiA434ndoeKn2ftGb480Q8kG7W7Vt
         xwg1luOa353DAcNKlcKZSvxrpWd8VTtc3cwAc1S2bOUgyLz5cNkZgAakNdg9E2XqbRgi
         68NXBSxO80qV5Q6lU3R9TizqdEeow8LOeKenYTH4cYpIC4lRBQEOZtFGXSmIv2HaHY9h
         F5Ba0pn7NZFiG2K3oKtc9yz2Q36CG+wROqBmrUukMjC5S90bKnmNz4OEhBuY/0DWouhh
         q2BH8SxSbI2QPh9hbc2l1A0w/qPrs/KrBeB/oTi7lvfPsiPP8jm1cgTGQdqgcU2YvCkf
         Yj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+nNQQvSTfkfWnHt2ZtwSO5BHFSg963dbkOjOyCQ2aw=;
        b=ZoF4jmlA2bV5b5aLaLY12SPnBcO7YRnrGx5Bg0NPoqTS64eQOZy5/fgjyCrmY3lR0u
         CW3PQ0MNq0durA1eE1i/CvPz8E7S+h0F+2Eec4jfq/OXLg2EvPuYuSIdOoNrsLnWu+Sf
         hrMaUFXQfJjTCj2LO2ptohzXh6/Qn2dvnk16ORRjmA/0N2SKp1cPxyrTjFDW7WPOFV1o
         0Cqf5hHwxPFnDtX+CbBNSiHYeHfl0ysDJykGkPAokZbz8mi5XwHHBPWtR87eATAuA7wE
         2Zif37cjrLMb721J9mThXHp0Q1sZd1JcPPo1SyjUvI+Tq0ASTu7rCfuRWXr2vTkX1ofi
         tKgA==
X-Gm-Message-State: AOAM532PGka3l/7CBQXuoVhXdV9HsRoTBSOEPfh8t8E3cbZ3s+h4MhKj
	E3AfyNPBtSUdj1r0C867N1SM/UOQTL0kuXLhuwI=
X-Google-Smtp-Source: ABdhPJydHRC3lqEyrhLi61Sv1mcOCWhsHrImKDkEI9Y6Io42wGJ40lq/2FTFRdz79lFIDSUuwFFmNzmX2+qhhdGp3Lw=
X-Received: by 2002:a17:907:a04f:: with SMTP id gz15mr492161ejc.293.1616101169630;
 Thu, 18 Mar 2021 13:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <1616099999-47367-1-git-send-email-denis@denix.org>
In-Reply-To: <1616099999-47367-1-git-send-email-denis@denix.org>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Thu, 18 Mar 2021 13:59:18 -0700
Message-ID: <CABcZANnxk4ZM3QxbrwRGGSFuoG7aJnx_Cav50WWkMH5wRJevZQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: make sure clonedir is empty when trying next fullmirror
To: Denys Dmytriyenko <denis@denix.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000291b0005bdd5e0b7"

--000000000000291b0005bdd5e0b7
Content-Type: text/plain; charset="UTF-8"

Nicely spotted. Do we have a test for this case?

On Thu, Mar 18, 2021 at 1:40 PM Denys Dmytriyenko <denis@denix.org> wrote:

> When first mirror returns an outdated fullmirror tarball, its clonedir
> stays
> behind for successive mirror tries. Even when latest tarball gets fetched
> next, it doesn't get unpacked, as clonedir already exists. Cleanup old
> clonedir and unpack the new fullmirror tarball, when the old clonedir is
> no good and requires update.
>
> Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> ---
>  lib/bb/fetch2/git.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index e3ba80a..cb62dcc 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -337,7 +337,8 @@ class Git(FetchMethod):
>          if ud.shallow and os.path.exists(ud.fullshallow) and
> self.need_update(ud, d):
>              ud.localpath = ud.fullshallow
>              return
> -        elif os.path.exists(ud.fullmirror) and not
> os.path.exists(ud.clonedir):
> +        elif os.path.exists(ud.fullmirror) and (not
> os.path.exists(ud.clonedir) or self.clonedir_need_update(ud, d)):
> +            bb.utils.remove(ud.clonedir, recurse=True)
>              bb.utils.mkdirhier(ud.clonedir)
>              runfetchcmd("tar -xzf %s" % ud.fullmirror, d,
> workdir=ud.clonedir)
>
> --
> 2.7.4
>
>
> 
>
>

-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000291b0005bdd5e0b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Nicely spotted. Do we have a test for this case?</div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Ma=
r 18, 2021 at 1:40 PM Denys Dmytriyenko &lt;<a href=3D"mailto:denis@denix.o=
rg">denis@denix.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">When first mirror returns an outdated fullmirror tarball=
, its clonedir stays<br>
behind for successive mirror tries. Even when latest tarball gets fetched<=
br>
next, it doesn&#39;t get unpacked, as clonedir already exists. Cleanup old=
<br>
clonedir and unpack the new fullmirror tarball, when the old clonedir is<b=
r>
no good and requires update.<br>
<br>
Signed-off-by: Denys Dmytriyenko &lt;<a href=3D"mailto:denis@denix.org" ta=
rget=3D"_blank">denis@denix.org</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/git.py | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
index e3ba80a..cb62dcc 100644<br>
--- a/lib/bb/fetch2/git.py<br>
+++ b/lib/bb/fetch2/git.py<br>
@@ -337,7 +337,8 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.shallow and os.path.exists(ud.full=
shallow) and self.need_update(ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.localpath =3D ud.fullsh=
allow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exists(ud.fullmirror) and not os=
.path.exists(ud.clonedir):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exists(ud.fullmirror) and (not o=
s.path.exists(ud.clonedir) or self.clonedir_need_update(ud, d)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.clonedir, re=
curse=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(ud.clon=
edir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(&quot;tar -xzf=
 %s&quot; % ud.fullmirror, d, workdir=3Dud.clonedir)<br>
<br>
-- <br>
2.7.4<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christop=
her Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, =
OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></=
div>

--000000000000291b0005bdd5e0b7--
