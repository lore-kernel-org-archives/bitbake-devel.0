Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86916C531D0
	for <webhook@archiver.kernel.org>; Sat, 25 Jul 2026 18:36:12 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2874.1785004563259970251
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jul 2026 11:36:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=z1nTdIYb;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1012210f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2026 11:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785004561; cv=none;
        d=google.com; s=arc-20260327;
        b=gBwJwiYFEWgmu9Lpru0KzGezohty6+oTJ9UN8KM/rpXtJyWXQaf+L0p2jtDg896ac+
         wjH0swV+TA22vLDNaaSXat/dIWmB/GpJnMkZ7mSjAo6b+M3fCfbG4B/RhkWjRXL3FA0w
         keYS1nKN5sGiif3AcP4otRgXCgso4K5n9eEqfGrHQ9cIPPrAwBRVOl3uYs7R7RN+uYK8
         jLW1TkiOMvxeW3eJLzEOR1fLrzLc7XwY7NCz+S6n3WXGhkgGJsyVb10FhrkAJdWf1BfJ
         3Nc/gL6Z5HhTIigKaqaNXzNwwgccRxPu6lqdH3k81ttGKMC75n5Zw0AAnVCEPiO5emAf
         hdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jGeXdk57BBvK2qMmwX8LwemcNhxwBaQlHHZd2Qlxh94=;
        fh=x9llBCne2Rv1aSREIWGvGk36jDFgx0FH5XpV09HeAhY=;
        b=CtUcJuLHoONiwpK8MBVJNuTjRmGaln2TeJ6OslgxcphL3wQvx1ocDubwxkv6K9dJ0v
         1GpzrM3iOIpAKbjsbdJChc3ldELJNqdbAgR8G9tJPkP42L6m4gDfR8u6waOlU8fUsCT4
         RURwkzX1O+2DfFD0e3YLkG9BCPdbBDTSrL2N/t0QWysVm5rgofe9akROCQwdlZWCQIUA
         JqaOOJXx2bWNC6A9cz04RP75FwpODvc/4r3Bn8NxsGDOQ+D1I81501Usq3BCXwgsjYfO
         dP6Otpuv0eP4PLZrlJ0wB7588I8ZaidYdqUCuOwn7fCSoGJ469rQA7x3sht3KDqKKXyr
         N/NA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1785004561; x=1785609361; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGeXdk57BBvK2qMmwX8LwemcNhxwBaQlHHZd2Qlxh94=;
        b=z1nTdIYbuYldvbQaAPYzqt/Ilji9wSwb3dRQdCwq/wjVaLiLP8KL8Q5XhyhFjcILmn
         5yYo3BVr4OtKqAa1z0RJ5skIEPLk54tydMQgEWml4+8Ne4rLHnxO2LPWLxbSbgRDTfFo
         YTyJSqpCWhwuFaHgtV3OXXLUuUO4hagRYggkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785004561; x=1785609361;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jGeXdk57BBvK2qMmwX8LwemcNhxwBaQlHHZd2Qlxh94=;
        b=GBOROCFKgBdYz2rsrsRM3IKZhiyVaFzz1xs3PtPEF7TW5QEyeAOWkCpV6Xboty2kUN
         JkWhOn+6rIRUJTMhJve3guMK/eXGXzdatwAkmOcj5Ypv9FyvSxINCohn4V++IWf0EQ3B
         f8JdgoB1S8ZFeb7fAkFLmB1uCB7xcSQqK2AgHzAUtGiFoz/ZPHaYDWv7VZ8thAJnh9SE
         R//VgmHIhpRu/NmmRV1B3WkGtEtPBUr/S405wCq4XyvZ3iDzx/lVRQ+oDmJGntWCA33I
         xhVqOSwWZlgPU2q61a7B7SCfdIV4rM7kibPkdoOoI5NJkhBh8o1g4pAe7iJ63uaFaZ57
         Tq0A==
X-Forwarded-Encrypted: i=1; AHgh+RotTpRqATi95XgrKuMq7AEwRZkkw2A5BQENGnEgMUVP1OIhFoUTxAfm7CKRiTe2qrnH9tTlmSzHJnUqv+Mt@lists.openembedded.org
X-Gm-Message-State: AOJu0YzTTsp0JDPXpTzedEMgeEbk1aymW0qtEShy8vN6QTn8BXqGJ8VJ
	ve4JzHBfovT2KtcltI2j5VWux7bXUwsohdpbk19C6DClKSPu1qvh2fF6U0ILf0lkx6EaF476hZ2
	FbrzM+dr13nsc8b4hZOUzobF6P25bg9qmdQuGIgkqDxDACpIrJI8+ty0=
X-Gm-Gg: AR+sD134GViHvwJt8XPTkQkVbXP+hucG5BWb4uy0EUzFV/oRA7ArFbF4Q8I9d75Higy
	Gd5w6vMt4ncCgv6wzFfNjhpqLlV/vjm3FyEKDPTpu4u/15pridqXVrek3HxuW6AtPJrj/Tqg9uJ
	QIB+niLG0mVsUyqki5RK1peGrv1LNGtndBCAFDut2phS/9GRIK33J+MC2On6JyCsneTq95sauO4
	PzRpxCWuyaChNs4auE4GcUPGHUYsYddL0p89cCbKf4RaRj7OZP0cBkwaAIqhI4=
X-Received: by 2002:a05:6000:4013:b0:47f:8603:a879 with SMTP id
 ffacd0b85a97d-47f9fe901e9mr3618193f8f.11.1785004561364; Sat, 25 Jul 2026
 11:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260720195834.2496647-1-amery@apptly.co> <859e14e2c6da1c914ae3ec7f2c2065424cde8f10.camel@linuxfoundation.org>
 <1d7573cc-035a-49d0-b978-d8bf06dbbfea@apptly.co>
In-Reply-To: <1d7573cc-035a-49d0-b978-d8bf06dbbfea@apptly.co>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Sat, 25 Jul 2026 20:35:50 +0200
X-Gm-Features: AUfX_mz02f5q05XT6_35f-RSEfBreBasluWEeGn9Xr5ON28gekrHOizMJFI5Ycc
Message-ID: <CAMSfU+72wmY=nzD41=_=eg7sKDLLyXJcFsBTCw_wLx8G3Gb3ZA@mail.gmail.com>
Subject: Re: [bitbake-devel] [2.18][PATCH] bitbake-worker: Evaluate
 exported_vars() before emptying the environment
To: amery@apptly.co
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000cd9005065773c23b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2026 18:36:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19860

--000000000000cd9005065773c23b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 25 juil. 2026, 20:01, Alejandro Mery via lists.openembedded.org
<amery=3Dapptly.co@lists.openembedded.org> a =C3=A9crit :

>
> On 23/07/2026 07:06, Richard Purdie wrote:
> > On Mon, 2026-07-20 at 19:58 +0000, Alejandro Mery via
> lists.openembedded.org wrote:
> >> exported_vars() returns a lazy generator. It was bound before
> >> empty_environment() cleared the process environment and only iterated
> >> afterwards, so any datastore expansion deferred until iteration ran wi=
th
> >> PATH already wiped.
> >>
> >> Recipes whose exported variables expand a command during that loop hit
> >> this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git whil=
e
> >> PATH is empty, so the git wrapper on PATH is bypassed and the real git
> >> runs directly. Under pseudo this fakes uid 0 against a repository owne=
d
> >> by the real user, and git aborts with "detected dubious ownership",
> >> failing do_package intermittently (only on reparse, when the value is
> >> re-expanded rather than served from cache).
> >>
> >> Materialise the generator into a list before emptying the environment =
so
> >> every expansion happens while PATH is still intact.
> >>
> >> Signed-off-by: Alejandro Mery <amery@apptly.co>
> >> ---
> >>   bin/bitbake-worker | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> >> index aa14ef191..0db1531e0 100755
> >> --- a/bin/bitbake-worker
> >> +++ b/bin/bitbake-worker
> >> @@ -290,7 +290,7 @@ def fork_off_task(cfg, data, databuilder,
> workerdata, extraconfigdata, runtask):
> >>
> >>                   # exported_vars() returns a generator which *cannot*
> be passed to os.environ.update()
> >>                   # successfully. We also need to unset anything from
> the environment which shouldn't be there
> >> -                exports =3D bb.data.exported_vars(the_data)
> >> +                exports =3D list(bb.data.exported_vars(the_data))
> >>
> >>                   bb.utils.empty_environment()
> >>                   for e, v in exports:
> > Thanks for this. Nice work in tracking it down!
> >
> > I think in this case we need a couple of things, firstly will be a bit
> > more explination in the code with a comment about why we need a list
> > there.
> >
> > The failure case is so unusual we should also probably write a test
> > case to make sure we test for and don't regress that issue which we'd
> > add to the existing tests in bitbake-selftest.
> >
> > Help with that would be welcome or we'll get to it when we can...
>
>
> I'll send a v2 soon
>

Is this for master? In that case, please remove the [2.18] tag.

Thanks!
--=20
Yoann Congal

>

--000000000000cd9005065773c23b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><br></div><br><div class=3D"gmail_quote=
 gmail_quote_container" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">=
Le sam. 25 juil. 2026, 20:01, Alejandro Mery via <a href=3D"http://lists.op=
enembedded.org">lists.openembedded.org</a> &lt;amery=3D<a href=3D"mailto:ap=
ptly.co@lists.openembedded.org">apptly.co@lists.openembedded.org</a>&gt; a =
=C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br>
On 23/07/2026 07:06, Richard Purdie wrote:<br>
&gt; On Mon, 2026-07-20 at 19:58 +0000, Alejandro Mery via <a href=3D"http:=
//lists.openembedded.org" rel=3D"noreferrer noreferrer" target=3D"_blank">l=
ists.openembedded.org</a> wrote:<br>
&gt;&gt; exported_vars() returns a lazy generator. It was bound before<br>
&gt;&gt; empty_environment() cleared the process environment and only itera=
ted<br>
&gt;&gt; afterwards, so any datastore expansion deferred until iteration ra=
n with<br>
&gt;&gt; PATH already wiped.<br>
&gt;&gt;<br>
&gt;&gt; Recipes whose exported variables expand a command during that loop=
 hit<br>
&gt;&gt; this. A gitver-style PV such as &quot;${@get_git_pv(d, ...)}&quot;=
 runs git while<br>
&gt;&gt; PATH is empty, so the git wrapper on PATH is bypassed and the real=
 git<br>
&gt;&gt; runs directly. Under pseudo this fakes uid 0 against a repository =
owned<br>
&gt;&gt; by the real user, and git aborts with &quot;detected dubious owner=
ship&quot;,<br>
&gt;&gt; failing do_package intermittently (only on reparse, when the value=
 is<br>
&gt;&gt; re-expanded rather than served from cache).<br>
&gt;&gt;<br>
&gt;&gt; Materialise the generator into a list before emptying the environm=
ent so<br>
&gt;&gt; every expansion happens while PATH is still intact.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Alejandro Mery &lt;<a href=3D"mailto:amery@apptly.c=
o" target=3D"_blank" rel=3D"noreferrer">amery@apptly.co</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0bin/bitbake-worker | 2 +-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/bin/bitbake-worker b/bin/bitbake-worker<br>
&gt;&gt; index aa14ef191..0db1531e0 100755<br>
&gt;&gt; --- a/bin/bitbake-worker<br>
&gt;&gt; +++ b/bin/bitbake-worker<br>
&gt;&gt; @@ -290,7 +290,7 @@ def fork_off_task(cfg, data, databuilder, work=
erdata, extraconfigdata, runtask):<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # exported_vars() returns a generator =
which *cannot* be passed to os.environ.update()<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # successfully. We also need to unset =
anything from the environment which shouldn&#39;t be there<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 exports =3D bb.data.exported_vars(the_data)<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 exports =3D list(bb.data.exported_vars(the_data=
))<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.empty_environment()<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for e, v in exports:<br>
&gt; Thanks for this. Nice work in tracking it down!<br>
&gt;<br>
&gt; I think in this case we need a couple of things, firstly will be a bit=
<br>
&gt; more explination in the code with a comment about why we need a list<b=
r>
&gt; there.<br>
&gt;<br>
&gt; The failure case is so unusual we should also probably write a test<br=
>
&gt; case to make sure we test for and don&#39;t regress that issue which w=
e&#39;d<br>
&gt; add to the existing tests in bitbake-selftest.<br>
&gt;<br>
&gt; Help with that would be welcome or we&#39;ll get to it when we can...<=
br>
<br>
<br>
I&#39;ll send a v2 soon<br></blockquote></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Is this for master? In that case, please remove the [2.18]=
 tag.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks!</div><div =
dir=3D"auto">--=C2=A0</div><div dir=3D"auto">Yoann Congal</div><div class=
=3D"gmail_quote gmail_quote_container" dir=3D"auto"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
</blockquote></div></div>

--000000000000cd9005065773c23b--

