Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
	[209.85.218.42])
	by mail.openembedded.org (Postfix) with ESMTP id 079A665C5B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Oct 2016 04:10:35 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id m72so44664085oik.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Oct 2016 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=1UAh+PGJ2pmBOQ8h8ADHwcKq/XN/V668RRzLrFzJgKM=;
	b=DDutROfjs1porQ3yLSsgkyepDH2vKsQfPv1IJlOYtOGjtmqCzHV2fp1PvUa2gd4jN6
	8+UR0E078iC/1TC8+mX+hRsPIuA3QQKlsPFD+F6OoF23hxAR+p+vDtRPFqgJyJZIq6dG
	BiQpNaqHCR7fP57AJlTI9Wall7RMtSRS7gw4MvUDKusVx0ag1q0BUh6lwlb80nZnlxXI
	3eOxF7oBii2MPGEVPf1aFLpUegjhE64A8fYMLAiEfB9olR9bdd9uZYziUVJhHDH3/sK2
	3x3R7JrD6ZIEB0ET4NatxQsLlroUaIFgJy+jMjKQc2DDS19LHzMu1qRkzp2BReSHCkV3
	Le/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=1UAh+PGJ2pmBOQ8h8ADHwcKq/XN/V668RRzLrFzJgKM=;
	b=ImzeLgyHloPOoqxTOKxtZILKUYu4t9jnzDb6Lw3peoUCCeTfbrauEwy+lVo2Yy8xBR
	b3Lw1kUcWB1/31frAe9e94LQ5ul57AEu/V+aEpm8ay+y2pp0rn2eVxa0jjQKlunWS+x2
	JT3g2nXS5pBVzGbwgjMB/YMP/sxqLJ/1ABJV8HH0lgNzWpvRIs9O7ysUpcyy6NnILHuA
	wBIxMkYgwquQJ2iKzypW/IprWx+9f3lm1yckL4mgZrNuovCalsSgbp5ItHKtTbq+z3Ig
	b1KDuKO0xXCN6NiTMcWctxPxjsdgzjThKUJRWM48bm6lTqStuWdG3GQ3kKb34GYuI1Jw
	GQ5A==
X-Gm-Message-State: AA6/9Rl+VE4PQnvCj30WreJ+/kXqw29O/ipZeFYIwI4HApt4a/VB6+3giFfX5ivhhMbmuIh2+KRxgVTEXExuYg==
X-Received: by 10.202.80.202 with SMTP id e193mr12506881oib.65.1475813437060; 
	Thu, 06 Oct 2016 21:10:37 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Thu, 6 Oct 2016 21:10:16 -0700 (PDT)
In-Reply-To: <1475813261-10429-1-git-send-email-kergoth@gmail.com>
References: <1475813261-10429-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Thu, 6 Oct 2016 21:10:16 -0700
X-Google-Sender-Auth: F_I_xacgX_pjVkcVpt2A0e5mv_0
Message-ID: <CABcZANk3gGcxOc4fd7E2RqSa0vDketXex8hBp=XGbdOjicoyOQ@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] bb.runqueue: fix unexpected process death logic
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
X-List-Received-Date: Fri, 07 Oct 2016 04:10:36 -0000
Content-Type: multipart/alternative; boundary=001a113b0244abbcd8053e3e9760

--001a113b0244abbcd8053e3e9760
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 6, 2016 at 9:07 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> `if w in self.rq.worker` when w *is* self.rq.worker doesn't make a great
> deal
> of sense, and results in this error:
>
>       File ".../poky/bitbake/lib/bb/runqueue.py", line 2372, in
> runQueuePipe.read():
>                              name =3D None
>         >                    if w in self.rq.worker:
>                                  name =3D "Worker"
>     TypeError: unhashable type: 'dict'
>
> Most likely this was meant to be 'is' rather than 'in', but rather than
> checking after the fact, just include the name in the iteration, instead.
>
> While we're here, also clean up and fix the broken error message.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>

Ah, no, it wasn=E2=80=99t meant to be is, clearly this was a missed w -> w[=
mc]
replacement, so it was meant to be in, just with a different value. Still
worth simplifying that handling a bit, regardless :)
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113b0244abbcd8053e3e9760
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Oct 6, 2016 at 9:07 PM, Christopher Larson <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":tq" class=
=3D"a3s aXjCH m1579d536b7ba2cda">From: Christopher Larson &lt;<a href=3D"ma=
ilto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
`if w in self.rq.worker` when w *is* self.rq.worker doesn&#39;t make a grea=
t deal<br>
of sense, and results in this error:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;.../poky/bitbake/lib/bb/<wbr>runqueue.py&qu=
ot;, line 2372, in runQueuePipe.read():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if w in self.rq.worker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D &quot;Worker&quot;<br=
>
=C2=A0 =C2=A0 TypeError: unhashable type: &#39;dict&#39;<br>
<br>
Most likely this was meant to be &#39;is&#39; rather than &#39;in&#39;, but=
 rather than<br>
checking after the fact, just include the name in the iteration, instead.<b=
r>
<br>
While we&#39;re here, also clean up and fix the broken error message.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</div></blockquote></div><br>Ah, no, i=
t wasn=E2=80=99t meant to be is, clearly this was a missed w -&gt; w[mc] re=
placement, so it was meant to be in, just with a different value. Still wor=
th simplifying that handling a bit, regardless :)<br>-- <br><div class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Christo=
pher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded,=
 OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graph=
ics</div></div>
</div></div>

--001a113b0244abbcd8053e3e9760--
