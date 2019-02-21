Return-Path: <kergoth@gmail.com>
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
	[209.85.167.173])
	by mail.openembedded.org (Postfix) with ESMTP id D3C967CBB5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2019 21:45:54 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id s16so94551oih.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2019 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JvTQHiGWorRD/MLpCrY4o+v5IC33tBdFF+266DWNMxM=;
	b=s9qOqajKHVYUt3g5R0iLvQSDeyaVczt9P+N6Ef0wE1DQPTVuMqPpio6r7gLRxUBqU4
	EW/WtNwOcAhjU8Gt6hEcOMi4qdiYvuRNBX04k1zlVWNwWwcw5kHRPoAQp7n2GvLNoN4h
	kbV3ZBKt14WsZF3CI/zs5aMAFjulfTFz+PWU/WgeHytoqCdumOyY+L+sM/WeeGWduEjG
	JqDGB4jkKyhuijgGLzJb+FA5zr2UicoQQ+rG40xcL8uz/3xb4hUv90NHAuSzcXLYl6U+
	xON0KYIEaOqzaOiu6XoJcI8H5n6u9pZhkghUcC1K1F/smPhMi0/37hXLFT3AAHebYnFq
	Bt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JvTQHiGWorRD/MLpCrY4o+v5IC33tBdFF+266DWNMxM=;
	b=JE4NznCJnwcROd2NB+3mVvVNjZebkDoihcfJyzlz1TrjA0fhussJa3RYkXOwMrblJu
	lP5e0jBtfLTsCSLDuABmYhtrwGOM1uy4RuwE44Fgzg8oeJc9/bD3UDenyrU4DiGQCQAn
	mcUIbQMgg9TvuFonKwfKSG3BsRy4JPyTDMzZe0be6D96mf0NG7VOw3z44BrXuxaR+j2/
	25qervllwhfe5ul/X7pRQNuI5wpokcQw6UvGqAliIhXEc6vNcQgkkdXqwjyikL+IkjpO
	eiYXegD/4OnWdKY2vjMtYPD0lBSNwNZrVLRaXjR7egf1Eqaigxy6Le4Vng9zIEscnh1a
	4/SA==
X-Gm-Message-State: AHQUAuY/xY7Hn3Jq+Io4jFmz+NO7XSeXkFzupEiqG3PUYYSXvGpNSfrQ
	C2WSzjqrzFplWAdK9/zkLj4xpkaov3FyUgWOFKVfJ0klvIQ=
X-Google-Smtp-Source: AHgI3Ib8cbs8PGaXZujt7QxIfYLM0agEUbVU80y0w4c1zf9cEga42izNvZ1Bc6Bn8tlQdcYZXhIfdjm+HMM+ujJ4Ndk=
X-Received: by 2002:aca:acc9:: with SMTP id v192mr447056oie.109.1550785555312; 
	Thu, 21 Feb 2019 13:45:55 -0800 (PST)
MIME-Version: 1.0
References: <1538621300-112900-1-git-send-email-chris.laplante@agilent.com>
	<429831d9241a7ec21e84523a354c89f9a97263ad.camel@linuxfoundation.org>
In-Reply-To: <429831d9241a7ec21e84523a354c89f9a97263ad.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 21 Feb 2019 14:45:44 -0700
Message-ID: <CABcZANnnd9BHOHgnxLTU+1u_MMMZqSsUiNisrvxJocceUyEWfg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] build.py: support custom task [progress] handlers
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Feb 2019 21:45:55 -0000
Content-Type: multipart/alternative; boundary="00000000000025b72e05826e66ac"

--00000000000025b72e05826e66ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a great idea, thanks a lot for contribution. As Richard says, I
think using and hardcoding __builtins__ as the injection point isn=E2=80=99=
t ideal.
Ideally I think we'd be able to provide a python module in a layer with the
progress handler, let OE_IMPORTS import it, and then let bitbake use it as
is.

I think we just need to tweak it to accept the full name with imports, i.e.
custom:oe.myprogressmodule.MyProgressHandler. Then if you want to inject it
you can (though I think bb.context is better than __builtins__), or use an
imported module, whichever is preferred, rather than hardcoding the context=
.

Something like `functools.reduce(lambda x, y: x[y], cls.split("."),
globals())` might do for resolving the dot-separated name to the class
object, assuming it=E2=80=99s already been imported.

On Thu, Feb 21, 2019 at 2:13 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2018-10-03 at 22:48 -0400, Chris Laplante via bitbake-devel
> wrote:
> > To use this mechanism, you need to inject your progress handler (i.e.
> > something derived from bb.progress.ProgressHandler) into
> > __builtins__.
> > Here's one way to do it (from recipe-space):
> >
> >     def install_my_progress_handler():
> >         from bb.progress import ProgressHandler
> >
> >         class MyProgressHandler(ProgressHandler):
> >             pass
> >
> >         if "MyProgressHandler" not in __builtins__:
> >             __builtins__["MyProgressHandler"] =3D MyProgressHandler
> >
> >         return "OK"
> >
> >     _INSTALL_MY_PROGRESS_HANDLERS :=3D "${@install_my_progress_handler(
> > )}"
>
> Sorry about the lack of review.
>
> My concern on this is the fact we have to poke around __builtins__. I
> understand why, I just can't help wonder if there is a better way
> somehow.
>
> I'm not sure I have a better one, not sure if Chris or others might?
>
> Cheers,
>
> Richard
>
>
> > To install on a task:
> >     do_task[progress] =3D "custom:MyProgressHandler"
> >
> > To install on a task and pass extra arguments:
> >     do_task[progress] =3D "custom:MyProgressHandler:my-arg"
> >
> > Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> > ---
> >  lib/bb/build.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/lib/bb/build.py b/lib/bb/build.py
> > index 3e2a94e..2e14572 100644
> > --- a/lib/bb/build.py
> > +++ b/lib/bb/build.py
> > @@ -387,6 +387,14 @@ exit $ret
> >          elif progress.startswith('outof:'):
> >              # Use specified regex
> >              logfile =3D bb.progress.OutOfProgressHandler(d,
> > regex=3Dprogress.split(':', 1)[1], outfile=3Dlogfile)
> > +        elif progress.startswith("custom:"):
> > +            # Use a custom progress handler
> > +            parts =3D progress.split(":", 2)
> > +            _, cls, otherargs =3D parts[0], parts[1], (parts[2] or
> > None) if parts[2:] else None
> > +            if cls and cls in __builtins__:
> > +                logfile =3D __builtins__[cls](d, outfile=3Dlogfile,
> > otherargs=3Dotherargs)
> > +            else:
> > +                bb.warn('%s: unknown custom progress handler in task
> > progress varflag value "%s", ignoring' % (func, cls))
> >          else:
> >              bb.warn('%s: invalid task progress varflag value "%s",
> > ignoring' % (func, progress))
> >
> > --
> > 2.7.4
> >
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--00000000000025b72e05826e66ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">This is a great idea, thanks a lot for co=
ntribution. As Richard says, I think using and hardcoding __builtins__ as t=
he injection point isn=E2=80=99t ideal. Ideally I think we&#39;d be able to=
 provide a python module in a layer with the progress handler, let OE_IMPOR=
TS import it, and then let bitbake use it as is.<div><br></div><div>I think=
 we just need to tweak it to accept the full name with imports, i.e. custom=
:oe.myprogressmodule.MyProgressHandler. Then if you want to inject it you c=
an (though I think bb.context is better than __builtins__), or use an impor=
ted module, whichever is preferred, rather than hardcoding the context.</di=
v><div><br></div><div>Something like `<font color=3D"#262626" face=3D"Helve=
tica Neue"><span style=3D"font-size:12px">functools.reduce(lambda x, y: x[y=
], cls.split(&quot;.&quot;), globals())` might do for resolving the dot-sep=
arated name to the class object, assuming it=E2=80=99s already been importe=
d.</span></font></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Feb 21, 2019 at 2:13 PM Richard Purdi=
e &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@=
linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-styl=
e:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, 2018-1=
0-03 at 22:48 -0400, Chris Laplante via bitbake-devel<br>
wrote:<br>
&gt; To use this mechanism, you need to inject your progress handler (i.e.<=
br>
&gt; something derived from bb.progress.ProgressHandler) into<br>
&gt; __builtins__.<br>
&gt; Here&#39;s one way to do it (from recipe-space):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def install_my_progress_handler():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from bb.progress import ProgressHandl=
er<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0class MyProgressHandler(ProgressHandl=
er):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;MyProgressHandler&quot; not =
in __builtins__:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__builtins__[&quot;MyPr=
ogressHandler&quot;] =3D MyProgressHandler<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;OK&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0_INSTALL_MY_PROGRESS_HANDLERS :=3D &quot;${@install=
_my_progress_handler(<br>
&gt; )}&quot;<br>
<br>
Sorry about the lack of review.<br>
<br>
My concern on this is the fact we have to poke around __builtins__. I<br>
understand why, I just can&#39;t help wonder if there is a better way<br>
somehow.<br>
<br>
I&#39;m not sure I have a better one, not sure if Chris or others might?<br=
>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
&gt; To install on a task:<br>
&gt;=C2=A0 =C2=A0 =C2=A0do_task[progress] =3D &quot;custom:MyProgressHandle=
r&quot;<br>
&gt; <br>
&gt; To install on a task and pass extra arguments:<br>
&gt;=C2=A0 =C2=A0 =C2=A0do_task[progress] =3D &quot;custom:MyProgressHandle=
r:my-arg&quot;<br>
&gt; <br>
&gt; Signed-off-by: Chris Laplante &lt;<a href=3D"mailto:chris.laplante@agi=
lent.com" target=3D"_blank">chris.laplante@agilent.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/build.py | 8 ++++++++<br>
&gt;=C2=A0 1 file changed, 8 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/build.py b/lib/bb/build.py<br>
&gt; index 3e2a94e..2e14572 100644<br>
&gt; --- a/lib/bb/build.py<br>
&gt; +++ b/lib/bb/build.py<br>
&gt; @@ -387,6 +387,14 @@ exit $ret<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif progress.startswith(&#39;outof:=
&#39;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use specified regex<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logfile =3D bb.progres=
s.OutOfProgressHandler(d,<br>
&gt; regex=3Dprogress.split(&#39;:&#39;, 1)[1], outfile=3Dlogfile)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif progress.startswith(&quot;custom:&qu=
ot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use a custom progress han=
dler<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parts =3D progress.split(&q=
uot;:&quot;, 2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _, cls, otherargs =3D parts=
[0], parts[1], (parts[2] or<br>
&gt; None) if parts[2:] else None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if cls and cls in __builtin=
s__:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logfile =3D _=
_builtins__[cls](d, outfile=3Dlogfile,<br>
&gt; otherargs=3Dotherargs)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&#39;=
%s: unknown custom progress handler in task<br>
&gt; progress varflag value &quot;%s&quot;, ignoring&#39; % (func, cls))<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&#39;%s: inval=
id task progress varflag value &quot;%s&quot;,<br>
&gt; ignoring&#39; % (func, progress))<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt; <br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv>

--00000000000025b72e05826e66ac--
