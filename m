Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421AFCCF2C1
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 15:50:54 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8738.1792252243712219574
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Oct 2026 08:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=VlN+BpbY;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1dec056ddso2353755e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 08:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792252242; cv=none;
        d=google.com; s=arc-20260327;
        b=Qi7wJoG1JTN9kzfYY9YFnwO1ncwmoOBA0c3MlyK3zdKALWVu3SXWKlZazdeYTvTtb/
         1bJlbZfgHCRY185gpiNACkcjI2FcQsQ8TRXS7clN9P3vk3UKIae4Z4z9TmyW2dPoFhuI
         k9XRYLz3W9UNszqAp9TZANDnRaAU4qgQKmKyo5UG+yzfYsa1edMowh4kW5vbMxvo5BRo
         u7aC+V1l99TPLVmIFjRyJU6bYTzc80QcjNFMgQ7PgI09ozRqkTMiC9FzuIAbTJ1O0t+s
         p0UCQuz+t+S1Zgn5gNfhghKYUb4ipWyUrTjEW4nNM4iZuV4zjpEEKXKJcHhDjgt6b9kX
         pNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d+KoZyMWdeZOyBRkYklRzY74GOBxq37Reut4duf1t/M=;
        fh=eCZHu0Kt1OOVwqPCfucqrZ1VJ9bi6ADb8ZocPUNfjLQ=;
        b=hWL9GtsaBqoUyJFDA1Cint+F+iMElLSMbP1QBPsCnv5hREIAhJSKXAcKbAIcGkEEq8
         yApvEsqAij0zFB9cwqrYxYey28hw8WLxRQrTlCgwjxgHJAJTgvevPkFGSjGjgCuEdXgE
         VvxVgxJZdgzS1seON29o2sl1+eChOCdo2rB6HJTIhkpIL+Uh81sH4vENO7p94QnhpQ0z
         8zFVrg/ZmW+z8aKQ+dp/2v77FmAuUNjuiubF+IW4TdkyXd8jFRPUbnpzsjRfrlmYeEAJ
         VRiSvjaZtSuGKHL3Bof12/7LHgRpUUffIopfTDLIYqTaahZgNwAztf7bi5eA053KCZg9
         y5jg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1792252242; x=1792857042; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+KoZyMWdeZOyBRkYklRzY74GOBxq37Reut4duf1t/M=;
        b=VlN+BpbYTM01jMnkS7B/5c/mUgQNHJ2ssL9yNfcNlCGza2aRep6RxDjAIe6Q7t3Xjf
         PchAoK+M8e7/p/23IET1Y8KvxeFjyR4G39lMIndlWFX7lxf/XxZiLwI+WBVhwmmpM9a+
         E1nr1ky6kqUaYPkbMd6GjA2I4QaoLXy4caAfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252242; x=1792857042;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d+KoZyMWdeZOyBRkYklRzY74GOBxq37Reut4duf1t/M=;
        b=kwlcNxS/oUb8mIYIzUUV0wyfP+7OKnp+mpNRkY2298XZgF95d9eaaDTjHf7gfn5h+L
         +nVSopDgIvdyxR9Swj0FcscCM4+r0pRGG6YohxK6af2RqI2ZUMlQi3aB0dppFAAbYHIm
         I1p6EYWcO7nnOvylpyMcVhhGOOeOJX4TG96Le5RWMKzLG7DZNnn+5WjKJYAS8ilaHGMZ
         cIXMM1GPQ76kd35tBaK+Gu4xkxTyuXKv1vtb4N+1ZJPErshZnuc7FrmHOCQkjU+YvAPq
         hEjG/DkP0CHfBh/yem7uZYB1Z9gSHYWs+69iiA5AzyI7XIc+Mn6AefVTPUs9/8CgeBxZ
         Rr5g==
X-Gm-Message-State: AFq9FYKlk9QSNl32UHYQpxH8QkgW2zNvt+yzWcA0szUoTSdlz052RKvS
	TgS4RsQzCNTmc1Sp67uriR7Od7jZMzrCUIt6D48vK9d+PnBQDaxqCO/4BFyiXd+o1GJE1hSyqz4
	w5S2xMGv+ol5vxMkJDOhL61gLWomDdOFm2qMOe2jKhA==
X-Gm-Gg: AYBFou3xC3cz8Rt7YChDw4wKHXJgLK9CGuqGn+uK4WCp8K+DqlipLF/y5k7kHRrZRgv
	LtgAU+1td5vDFEkjq1CsIBRieyrlg4WY2ZTiYsONIOx9HOorePYTCuXn9VesE1+Om/bFOoIZN9f
	l93eNFXF9eyiUOBBEsMVWh4jObWpK7HOs0HKqD+LJINe++cAUogi7UvKQarQ6VXuIP/wq6zL8mO
	8zVJy4ubbvPU+WH/m6D6E6nyKNfjxvM8wa9MQqlARWb7X8fbwMd2Wq13O1EInEgkFFSd4UX1NS3
	akNUVdZ7VQcYDifm0l2aKQjV8a+BEH7WZ5X39NeJXyPePjhSLNYvAw==
X-Received: by 2002:a05:600c:524e:b0:4a1:db17:c7e6 with SMTP id
 5b1f17b1804b1-4a1db17ca8cmr37348405e9.2.1792252241224; Sat, 17 Oct 2026
 08:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792191269.git.yoann.congal@smile.fr> <8c77cdccbbef939d980d80c07376c9808e37fc5f.camel@linuxfoundation.org>
In-Reply-To: <8c77cdccbbef939d980d80c07376c9808e37fc5f.camel@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Sat, 17 Oct 2026 17:50:29 +0200
X-Gm-Features: AclHuK_2dJ0wQG7q4OaSorXUx7_LDC_5Ar2xQWUPVKf1b9iFqDkfyvBy-wlw63w
Message-ID: <CAMSfU+5o1-peBH3NLrfqNMTMiXpBMGXiPuHg2WefWXFKqRXyLw@mail.gmail.com>
Subject: Re: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter only)
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000002fb8fa065e0b3ed0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 15:50:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20358

--0000000000002fb8fa065e0b3ed0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yoann Congal
Smile ECS

Le sam. 17 oct. 2026, 17:18, Richard Purdie <
richard.purdie@linuxfoundation.org> a =C3=A9crit :

> On Sat, 2026-10-17 at 00:55 +0200, Yoann Congal wrote:
> > This is the patch from the last patch review:
> > https://lore.kernel.org/all/cover.1792020468.git.yoann.congal@smile.fr/
> >
> > Passed a-full on autobuilder:
> > https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/493=
4
> > * reproducible failed with #15898 =E2=80=93 New sstate.yp.org CDN revea=
led
> partial sstate reproducibility tests false-positive error
> >   But the test warns about a missing sstate object from the reproducibl=
eB
> >   build that is supposed to rebuild everything anyway, then, rebuilds t=
he
> >   recipe. So, there is no issue with the series.
> >
> >
> > The following changes since commit
> d3b32587c2314febf96897f97e0172790b4fc1cf:
> >
> >   toastergui/views: Replace os.system call with improved parameter
> handling (2026-09-28 22:25:53 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://git.openembedded.org/bitbake-contrib stable/2.8-next
> >   https://git.openembedded.org/bitbake-contrib/log/?h=3Dstable/2.8-next
> >
> > for you to fetch changes up to 6b443060ee96a62efb94723c97f22b51c9b20507=
:
> >
> >   prserv: commit new revisions when a request succeeds (2026-10-11
> 23:40:57 +0200)
>
> Do other branches need that patch?
>

I think not.

The patch says:
This is specific to the 2.8 branch. The server was reworked for master and
2.10 ("prserv: enable database sharing" and the commits around it), which
commits where values are stored and uses WAL, so master does not have this
problem and the commit cannot be backported as it is.

Other supported branches are 2.18, 2.20 (all above 2.10 and the referenced
patch)

I checked the 2.10 commit and it looked like it matched so I took the patch=
.


Cheers,
>
> Richard
>

--0000000000002fb8fa065e0b3ed0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div><br></div><div><br></div><div data-smartmail=3D=
"gmail_signature"><div dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Co=
ngal</font><div><font face=3D"Raleway, regular">Smile ECS</font></div></div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">Le sam. 17 oct. 2026, 17:18, Richard Purdie &lt;<a h=
ref=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfound=
ation.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Sat, 2026-10-17 at 00:55 +0200, Yoann Congal wrote=
:<br>
&gt; This is the patch from the last patch review:<br>
&gt; <a href=3D"https://lore.kernel.org/all/cover.1792020468.git.yoann.cong=
al@smile.fr/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.=
kernel.org/all/cover.1792020468.git.yoann.congal@smile.fr/</a><br>
&gt; <br>
&gt; Passed a-full on autobuilder:<br>
&gt; <a href=3D"https://autobuilder.yoctoproject.org/valkyrie/?#/builders/2=
9/builds/4934" rel=3D"noreferrer noreferrer" target=3D"_blank">https://auto=
builder.yoctoproject.org/valkyrie/?#/builders/29/builds/4934</a><br>
&gt; * reproducible failed with #15898 =E2=80=93 New <a href=3D"http://ssta=
te.yp.org" rel=3D"noreferrer noreferrer" target=3D"_blank">sstate.yp.org</a=
> CDN revealed partial sstate reproducibility tests false-positive error<br=
>
&gt; =C2=A0 But the test warns about a missing sstate object from the repro=
ducibleB<br>
&gt; =C2=A0 build that is supposed to rebuild everything anyway, then, rebu=
ilds the<br>
&gt; =C2=A0 recipe. So, there is no issue with the series.<br>
&gt; <br>
&gt; <br>
&gt; The following changes since commit d3b32587c2314febf96897f97e0172790b4=
fc1cf:<br>
&gt; <br>
&gt; =C2=A0 toastergui/views: Replace os.system call with improved paramete=
r handling (2026-09-28 22:25:53 +0100)<br>
&gt; <br>
&gt; are available in the Git repository at:<br>
&gt; <br>
&gt; =C2=A0 <a href=3D"https://git.openembedded.org/bitbake-contrib" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://git.openembedded.org/bitb=
ake-contrib</a>=C2=A0stable/2.8-next<br>
&gt; =C2=A0 <a href=3D"https://git.openembedded.org/bitbake-contrib/log/?h=
=3Dstable/2.8-next" rel=3D"noreferrer noreferrer" target=3D"_blank">https:/=
/git.openembedded.org/bitbake-contrib/log/?h=3Dstable/2.8-next</a><br>
&gt; <br>
&gt; for you to fetch changes up to 6b443060ee96a62efb94723c97f22b51c9b2050=
7:<br>
&gt; <br>
&gt; =C2=A0 prserv: commit new revisions when a request succeeds (2026-10-1=
1 23:40:57 +0200)<br>
<br>
Do other branches need that patch?<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">I think not.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">The patch says:</div><div dir=3D"auto">This is speci=
fic to the 2.8 branch. The server was reworked for master and</div><div dir=
=3D"auto">2.10 (&quot;prserv: enable database sharing&quot; and the commits=
 around it), which</div><div dir=3D"auto">commits where values are stored a=
nd uses WAL, so master does not have this</div><div dir=3D"auto">problem an=
d the commit cannot be backported as it is.</div><div dir=3D"auto"></div><d=
iv dir=3D"auto">=C2=A0</div><div dir=3D"auto">Other supported branches are =
2.18, 2.20 (all above 2.10 and the referenced patch)</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">I checked the 2.10 commit and it looked like i=
t matched so I took the patch.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_co=
ntainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Cheers,<br>
<br>
Richard<br>
</blockquote></div></div></div>

--0000000000002fb8fa065e0b3ed0--

