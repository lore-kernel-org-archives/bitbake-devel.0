Return-Path: <nick.owens@eero.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4991EE77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 18:55:23 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.484.1736448922277604958
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 10:55:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@eero.com header.s=google header.b=hNvZ9jg8;
 spf=pass (domain: eero.com, ip: 209.85.218.48, mailfrom: nick.owens@eero.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso216204666b.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google; t=1736448921; x=1737053721; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3AyutjwIK24pgyJP8XXfqOYy8Y6VEevTTtoFvEeLXPw=;
        b=hNvZ9jg856hoYqxysOy6X/sH09M7PQaqM78vT4yuiuFYChxuaecZZ3r1XF4vrz4GXh
         YWCl//DauGsEHvjkZYfc39MUb94rL6q2MQZ2/qNMbcMq5Qt0tZ1IECTTkoFic+PPhtyF
         AzQwzlsi+2OZg+7YR1sys4VGo+A/zA9MbiWzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448921; x=1737053721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AyutjwIK24pgyJP8XXfqOYy8Y6VEevTTtoFvEeLXPw=;
        b=SYCGsiPlFy6PUTZM8AeGnWTJvGZwJ8k9YKNEVFOxjxlL7sJetkIIRVp7P3ryeUm6Ed
         /wZdf/Bo24mAGpZwoPp1VgtiBQ61Td38lly1GRV6eG7cmgN43nF9YJnvMrf+9Dyk+aMA
         65exrrkbKmeskIHelTQKUVlh+Nrs4bTdli5vV5yOm/6m//kBFW55gSrQQyDBS2xkhPls
         3yUEZE2HAnzdjtWrH8OXulN4+5h8nAxTil73YDvTb33gRkSZylvS1r3Ntw0H1FGcahxn
         i0IedQNBtUUapC+rx8Pf2ULxJk0/PQ+PWxbQJlrBFBLbYJ5VYXGd9UHIFf8+x0n0cUUX
         gh5A==
X-Gm-Message-State: AOJu0YzePZR+6p3jZnbJMlfvFa/ilNqjIVJxqe6i9caDed9U9cJD1xf6
	OuDncmhROVgEHGMcCogVEJVD1UsKf+RmB2Ptft/WQZzJfo6KYxqOaM4nLxkiZ+iSEYUjgMABsuv
	36OuGNyNi+rVsnGuG0AYvzhOTW+Fe8MaHS5etZA==
X-Gm-Gg: ASbGncs44LSk0V2RuHNkc7+n41tEhi8zXJoO0vndr/U1SvBG5+8BQQqPSLOLknU05Ik
	w0I7ru+cqvrnBkFOxVZfw3KVaAui85NRZECM=
X-Google-Smtp-Source: AGHT+IGSdJdFnRYciNviZVtyhKhMXLOh/xjVxbmFtpQ0x98v5xMEdpZ73Xh6+BEqnOt6zDjQuPfDfavONR4OUV/raDQ=
X-Received: by 2002:a17:907:1b03:b0:aa6:86d1:c3fe with SMTP id
 a640c23a62f3a-ab2ab6705b8mr776359266b.4.1736448920581; Thu, 09 Jan 2025
 10:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20250105021848.3048010-1-nick.owens@eero.com> <d666c407c0ab5a16733869b03acd15e18bcdbfe2.camel@linuxfoundation.org>
In-Reply-To: <d666c407c0ab5a16733869b03acd15e18bcdbfe2.camel@linuxfoundation.org>
From: Nick Owens <nick.owens@eero.com>
Date: Thu, 9 Jan 2025 10:55:09 -0800
X-Gm-Features: AbW1kvb9gicxtu6AjYfnCMELGBjD02jlxr33a4huVLNJ9cI2k8zBqelm3CnYyXc
Message-ID: <CAFQxptVVpB5ASUqo=ZJHhqEmtHwpv7yDMGCAjrem0RyzrmOaRw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] git-make-shallow: use stdin mode
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000151225062b4a85d3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 18:55:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16999

--000000000000151225062b4a85d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

right. i think this is because the transaction model was only introduced in
git 2.27 whereas ubuntu focal (20.04) only has 2.25. and, i think i bungled
the use of the transaction commands by not issuing 'start'. i think
dropping commit should resolve it.

diff --git a/bitbake/bin/git-make-shallow b/bitbake/bin/git-make-shallow
index d0532c5ab8..bead94a766 100755
--- a/bitbake/bin/git-make-shallow
+++ b/bitbake/bin/git-make-shallow
@@ -113,8 +113,8 @@ def filter_refs(refs):
     all_refs =3D get_all_refs()
     to_remove =3D set(all_refs) - set(refs)
     if to_remove:
-        check_output(['xargs', '-0', '-n', '1', 'git', 'update-ref', '-d',
'--no-deref'],
-                     input=3D''.join(l + '\0' for l in to_remove))
+        check_output(['git', 'update-ref', '--no-deref', '--stdin', '-z'],
+                     input=3D''.join('delete ' + l + '\0\0' for l in
to_remove))


 def follow_history_intersections(revisions, refs):

On Thu, Jan 9, 2025 at 12:35=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Sat, 2025-01-04 at 18:18 -0800, Nick Owens via lists.openembedded.org
> wrote:
> > when there are many refs to delete, using xargs to exec git can take a
> very long
> > time. make this faster by only running git update-ref with stdin mode.
> >
> > for a repo with over 34000 git tags this makes git-make-shallow finish
> > in 2 seconds instead of 3 minutes for me.
> >
> > Signed-off-by: Nick Owens <nick.owens@eero.com>
> > ---
> >  bin/git-make-shallow | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/bin/git-make-shallow b/bin/git-make-shallow
> > index 9de557c10..8ad704fae 100755
> > --- a/bin/git-make-shallow
> > +++ b/bin/git-make-shallow
> > @@ -115,8 +115,8 @@ def filter_refs(refs):
> >      all_refs =3D get_all_refs()
> >      to_remove =3D set(all_refs) - set(refs)
> >      if to_remove:
> > -        check_output(['xargs', '-0', '-n', '1'] + git_cmd +
> ['update-ref', '-d', '--no-deref'],
> > -                     input=3D''.join(l + '\0' for l in to_remove))
> > +        check_output(git_cmd + ['update-ref', '--no-deref', '--stdin',
> '-z'],
> > +                     input=3D''.join('delete ' + l + '\0\0' for l in
> to_remove) + 'commit\0')
> >
> >
>
> This sounded really good and it merged however we're seeing intermittent
> failures:
>
>
> https://valkyrie.yoctoproject.org/#/builders/54/builds/725/steps/11/logs/=
stdio
>
> https://valkyrie.yoctoproject.org/#/builders/23/builds/810/steps/11/logs/=
stdio
>
> This appears like it might me python or git version specific, there is
> a deprecation warning in the log which I also wonder about...
>
> Cheers,
>
> Richard
>

--000000000000151225062b4a85d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>right. i think this is because the transaction model =
was only introduced in git 2.27 whereas ubuntu focal (20.04) only has 2.25.=
 and, i think i bungled the use of the transaction commands by not issuing =
&#39;start&#39;. i think dropping commit should resolve it.</div><div><br><=
/div><div>diff --git a/bitbake/bin/git-make-shallow b/bitbake/bin/git-make-=
shallow<br>index d0532c5ab8..bead94a766 100755<br>--- a/bitbake/bin/git-mak=
e-shallow<br>+++ b/bitbake/bin/git-make-shallow<br>@@ -113,8 +113,8 @@ def =
filter_refs(refs):<br>=C2=A0 =C2=A0 =C2=A0all_refs =3D get_all_refs()<br>=
=C2=A0 =C2=A0 =C2=A0to_remove =3D set(all_refs) - set(refs)<br>=C2=A0 =C2=
=A0 =C2=A0if to_remove:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0check_output([&#39;=
xargs&#39;, &#39;-0&#39;, &#39;-n&#39;, &#39;1&#39;, &#39;git&#39;, &#39;up=
date-ref&#39;, &#39;-d&#39;, &#39;--no-deref&#39;],<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input=3D&#39;&#39;.joi=
n(l + &#39;\0&#39; for l in to_remove))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0che=
ck_output([&#39;git&#39;, &#39;update-ref&#39;, &#39;--no-deref&#39;, &#39;=
--stdin&#39;, &#39;-z&#39;],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input=3D&#39;&#39;.join(&#39;delete &#39; + l =
+ &#39;\0\0&#39; for l in to_remove))<br>=C2=A0<br>=C2=A0<br>=C2=A0def foll=
ow_history_intersections(revisions, refs):<br></div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, Jan 9, 2025 at 12:35=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On S=
at, 2025-01-04 at 18:18 -0800, Nick Owens via <a href=3D"http://lists.opene=
mbedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a=
> wrote:<br>
&gt; when there are many refs to delete, using xargs to exec git can take a=
 very long<br>
&gt; time. make this faster by only running git update-ref with stdin mode.=
<br>
&gt; <br>
&gt; for a repo with over 34000 git tags this makes git-make-shallow finish=
<br>
&gt; in 2 seconds instead of 3 minutes for me.<br>
&gt; <br>
&gt; Signed-off-by: Nick Owens &lt;<a href=3D"mailto:nick.owens@eero.com" t=
arget=3D"_blank">nick.owens@eero.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bin/git-make-shallow | 4 ++--<br>
&gt; =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bin/git-make-shallow b/bin/git-make-shallow<br>
&gt; index 9de557c10..8ad704fae 100755<br>
&gt; --- a/bin/git-make-shallow<br>
&gt; +++ b/bin/git-make-shallow<br>
&gt; @@ -115,8 +115,8 @@ def filter_refs(refs):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 all_refs =3D get_all_refs()<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 to_remove =3D set(all_refs) - set(refs)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 if to_remove:<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_output([&#39;xargs&#=
39;, &#39;-0&#39;, &#39;-n&#39;, &#39;1&#39;] + git_cmd + [&#39;update-ref&=
#39;, &#39;-d&#39;, &#39;--no-deref&#39;],<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input=3D&#39;&#39;.join=
(l + &#39;\0&#39; for l in to_remove))<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_output(git_cmd + [&#=
39;update-ref&#39;, &#39;--no-deref&#39;, &#39;--stdin&#39;, &#39;-z&#39;],=
<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input=3D&#39;&#39;.join=
(&#39;delete &#39; + l + &#39;\0\0&#39; for l in to_remove) + &#39;commit\0=
&#39;)<br>
&gt; =C2=A0<br>
&gt; =C2=A0<br>
<br>
This sounded really good and it merged however we&#39;re seeing intermitten=
t failures:<br>
<br>
<a href=3D"https://valkyrie.yoctoproject.org/#/builders/54/builds/725/steps=
/11/logs/stdio" rel=3D"noreferrer" target=3D"_blank">https://valkyrie.yocto=
project.org/#/builders/54/builds/725/steps/11/logs/stdio</a><br>
<a href=3D"https://valkyrie.yoctoproject.org/#/builders/23/builds/810/steps=
/11/logs/stdio" rel=3D"noreferrer" target=3D"_blank">https://valkyrie.yocto=
project.org/#/builders/23/builds/810/steps/11/logs/stdio</a><br>
<br>
This appears like it might me python or git version specific, there is<br>
a deprecation warning in the log which I also wonder about...<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000151225062b4a85d3--

