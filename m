Return-Path: <robbinvandamme@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1669CC3ABB2
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 07:21:14 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web10.1363.1748589672553963508
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 May 2025 00:21:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Cqdexu2B;
 spf=pass (domain: gmail.com, ip: 209.85.167.177, mailfrom: robbinvandamme@gmail.com)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40337dd3847so1087907b6e.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748589672; x=1749194472; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGCWy11IqBfI2z7oeXoFJsLPHWU6cmEIrHzjJ3ei2Ts=;
        b=Cqdexu2BHZDXD1z/r9QxeBKsJuMKb79b6UYZqFgvvtH/Cmv5x0sVgh6JdzikiU4Csu
         653kTnj9ll0bJgHnXNJvRpygpnBmzPBqCxg80BcSVs5CCoOfgp6UpFxOrfzz/P6YnSYy
         3nAtHlxe7nQzu9tFPETEXvvvc6UmI5G86UZRPgduPMGLAoSV3lsyiCiYl+Urmkf1UNVA
         qtPqHxZ0F40u2JjrAEPjfCuh/+yUYU9DlMVr0dSztnprtwa0G+46ARmGy3cy6HW8OZce
         VBFYXLHUPhxEdDzYSAp1Jxmfdc+GxntijZ5aDXGsyGrnxbz2/bexqYau8yF1gBLKfKnZ
         Bm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748589672; x=1749194472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGCWy11IqBfI2z7oeXoFJsLPHWU6cmEIrHzjJ3ei2Ts=;
        b=p08g6kV4UOf7aMNvqnnhfxLWmdSI58U+PRM/sBqwKBHKf9dotGFbrdCuwpRyfnbqQZ
         L0DQfSeVMxGzsEJwVuLxTsekIBPMcWl78WuaLDE4NBL7InwGJ2RuGXDyaUq/WjzvwYDJ
         BJpJsfuyPemKB7mXsTqavzXdLe09rg9SKK4qZJ7Hb4jrTq8st+gXvdFV/M1iPSacrdtZ
         pDD8gKeYki3jBpVGhSC3LEr/aD4q7i4bz1XzrnNvBLbPPd//E15PG818hjobN0f6Wrrv
         PBx6flfLOizgzTryJ8keRid2GxxXayEknLOFYP3xrrCZ3PI13z1Ed/ojIdIQ6oElOwhA
         t5Qg==
X-Gm-Message-State: AOJu0Ywm4hO/9SptzP5gR3GR0PWXMykyTW6qTwLXodWbwSV9JBCUN+0K
	KRef+V0tnGk9C6Iz/AGZ5k8hXZHH4b+Xj5KGpeP4qFT5ueDPtzaPIeF5NaYlUQEufedEc+8vDl8
	rbLPI/pIinJZbxHRuALYy1vODfPdnX2M=
X-Gm-Gg: ASbGncsRjmDKh2kBAPjOAk4olDQCOYPHN/v/zUkIGMe1J/6xtmUuc4wPEXzqI+KGV4Y
	UOWLi+SlkGlBYwZuz8w84q3x2y0zF9sxqpk3+zJYNjcAkHOlagfkoGJXjBWDJMHCylD44T1ZNno
	bLQQXXGe26MqRBBpm+MDQkjutgDLaELz8=
X-Google-Smtp-Source: AGHT+IEUcs/YN+S17Ir+oBiaAoSr7VvPZTkV2sAA1pja+dMu1QQLcvCrR6B1bdXwrI9UAadm2b6UX94P1dDKLoQyaak=
X-Received: by 2002:a05:6808:1c09:b0:404:c04:e38e with SMTP id
 5614622812f47-4067e6b293amr570395b6e.30.1748589671601; Fri, 30 May 2025
 00:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250529141418.1939172-1-robbin.vandamme@renson.be> <9ae97e78-1fdb-45dd-8746-122f6e5a919f@gmail.com>
In-Reply-To: <9ae97e78-1fdb-45dd-8746-122f6e5a919f@gmail.com>
From: robbin van damme <robbinvandamme@gmail.com>
Date: Fri, 30 May 2025 09:21:00 +0200
X-Gm-Features: AX0GCFveJ-3Oqf6RQsrNdlFF6T4paWzlL_1Q2_dMwX7L5wnvDIZMM_Ge8OXjUxo
Message-ID: <CAPon-EbnAEjXL0AWSthzvdrXrazG0P07ov=6GG70pVdmsC+hmA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] [YOCTO #15882] Add question mark to
 mark the start of the AZ_SAS query parameters.
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Robbin Van Damme <robbin.vandamme@renson.be>
Content-Type: multipart/alternative; boundary="0000000000003bdedb063655424a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 07:21:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17658

--0000000000003bdedb063655424a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Ok thats fine.
Lets forget this patch then.
I submitted other one with update of the docs on how to use the AZ_SAS.

kind regards,

Robbin


On Thu, May 29, 2025 at 5:34=E2=80=AFPM Gyorgy Sarvari <skandigraun@gmail.c=
om>
wrote:

> On 5/29/25 16:14, robbin van damme via lists.openembedded.org wrote:
> > Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.com>
> > ---
> >  lib/bb/fetch2/az.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
> > index 346124a8b..327273379 100644
> > --- a/lib/bb/fetch2/az.py
> > +++ b/lib/bb/fetch2/az.py
> > @@ -36,7 +36,7 @@ class Az(Wget):
> >
> >          az_sas =3D d.getVar('AZ_SAS')
> >          if az_sas and az_sas not in ud.url:
> > -            ud.url +=3D az_sas
> > +            ud.url +=3D f'?{az_sas}'
> >
> >          return Wget.checkstatus(self, fetch, ud, d, try_again)
> >
> > @@ -62,7 +62,7 @@ class Az(Wget):
> >          az_sas =3D d.getVar('AZ_SAS')
> >
> >          if az_sas:
> > -            azuri =3D '%s%s%s%s' % ('https://', ud.host, ud.path, az_s=
as)
> > +            azuri =3D '%s%s%s?%s' % ('https://', ud.host, ud.path,
> az_sas)
> >          else:
> >              azuri =3D '%s%s%s' % ('https://', ud.host, ud.path)
> >
> I think that this is going to be a documentation problem.
> Though not mentioned in the commit message unfortunately, I believe I
> see the issue: the url has the classic
> "protocol://domain/path?param=3Dvalue&param2=3Dvalue2..." format. The AZ_=
SAS
> variable holds the "param=3Dvalue..." part. The original commit message[1=
]
> does contain a (not too strong) reference that it should start with a
> question mark, however this didn't reach the documentation, and it gives
> an example without a question mark[2].
>
> I think the documentation should be updated primarily. Of course the
> code could be a bit smarter too, for example if az_sas doesn't start
> with '?', then maybe emit a debug message and prepend a '?'
> automatically. Though I don't know how many people rely on this fetcher,
> but I don't think the current behavior should be changed with suddenly
> not expecting a '?' in this variable.
>
> [1]:
>
> https://git.openembedded.org/bitbake/commit/lib/bb/fetch2/az.py?id=3Db103=
b02f2ce2f8f5079f17ec1a854f904c2110a4
> [2]:
>
> https://docs.yoctoproject.org/bitbake/2.6/bitbake-user-manual/bitbake-use=
r-manual-fetching.html#az-fetcher-az
>
>

--=20
Best Regards,

*Robbin Van Damme*

*E *robbinvandamme@gmail.com

--0000000000003bdedb063655424a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div>Hi,<div><br></div><div>Ok thats fin=
e.</div><div>Lets forget this patch then.</div><div>I submitted other one w=
ith update of the docs on how to use the AZ_SAS.</div><div><br></div><div>k=
ind regards,</div><div><br></div><div>Robbin<br><br><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 29, 2025 at 5:34=
=E2=80=AFPM Gyorgy Sarvari &lt;<a href=3D"mailto:skandigraun@gmail.com" tar=
get=3D"_blank">skandigraun@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 5/29/25 16:14, robbin van damme via =
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> wrote:<br>
&gt; Signed-off-by: Robbin Van Damme &lt;<a href=3D"mailto:robbinvandamme@g=
mail.com" target=3D"_blank">robbinvandamme@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/az.py | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py<br>
&gt; index 346124a8b..327273379 100644<br>
&gt; --- a/lib/bb/fetch2/az.py<br>
&gt; +++ b/lib/bb/fetch2/az.py<br>
&gt; @@ -36,7 +36,7 @@ class Az(Wget):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 az_sas =3D d.getVar(&#39;AZ_SAS&#39;=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if az_sas and az_sas not in ud.url:<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.url +=3D az_sas<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.url +=3D f&#39;?{az_sas}=
&#39;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return Wget.checkstatus(self, fetch,=
 ud, d, try_again)<br>
&gt;=C2=A0 <br>
&gt; @@ -62,7 +62,7 @@ class Az(Wget):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 az_sas =3D d.getVar(&#39;AZ_SAS&#39;=
)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if az_sas:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 azuri =3D &#39;%s%s%s%s&#39=
; % (&#39;https://&#39;, ud.host, ud.path, az_sas)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 azuri =3D &#39;%s%s%s?%s&#3=
9; % (&#39;https://&#39;, ud.host, ud.path, az_sas)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 azuri =3D &#39;%s%s%s&=
#39; % (&#39;https://&#39;, ud.host, ud.path)<br>
&gt;=C2=A0 <br>
I think that this is going to be a documentation problem.<br>
Though not mentioned in the commit message unfortunately, I believe I<br>
see the issue: the url has the classic<br>
&quot;protocol://domain/path?param=3Dvalue&amp;param2=3Dvalue2...&quot; for=
mat. The AZ_SAS<br>
variable holds the &quot;param=3Dvalue...&quot; part. The original commit m=
essage[1]<br>
does contain a (not too strong) reference that it should start with a<br>
question mark, however this didn&#39;t reach the documentation, and it give=
s<br>
an example without a question mark[2].<br>
<br>
I think the documentation should be updated primarily. Of course the<br>
code could be a bit smarter too, for example if az_sas doesn&#39;t start<br=
>
with &#39;?&#39;, then maybe emit a debug message and prepend a &#39;?&#39;=
<br>
automatically. Though I don&#39;t know how many people rely on this fetcher=
,<br>
but I don&#39;t think the current behavior should be changed with suddenly<=
br>
not expecting a &#39;?&#39; in this variable.<br>
<br>
[1]:<br>
<a href=3D"https://git.openembedded.org/bitbake/commit/lib/bb/fetch2/az.py?=
id=3Db103b02f2ce2f8f5079f17ec1a854f904c2110a4" rel=3D"noreferrer" target=3D=
"_blank">https://git.openembedded.org/bitbake/commit/lib/bb/fetch2/az.py?id=
=3Db103b02f2ce2f8f5079f17ec1a854f904c2110a4</a><br>
[2]:<br>
<a href=3D"https://docs.yoctoproject.org/bitbake/2.6/bitbake-user-manual/bi=
tbake-user-manual-fetching.html#az-fetcher-az" rel=3D"noreferrer" target=3D=
"_blank">https://docs.yoctoproject.org/bitbake/2.6/bitbake-user-manual/bitb=
ake-user-manual-fetching.html#az-fetcher-az</a><br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><span style=3D"text-align:-webkit-auto;border-co=
llapse:separate"><div><font face=3D"Verdana" style=3D"background-color:rgb(=
255,255,255);color:rgb(34,34,34);font-family:&quot;Lucida Grande&quot;;font=
-size:medium">Best Regards,</font><br><br><font face=3D"Verdana" color=3D"#=
000000"><b style=3D"background-color:rgb(255,255,255)">Robbin Van Damme</b>=
</font></div></span><span style=3D"text-align:-webkit-auto;background-color=
:rgb(255,255,255);border-collapse:separate;font-size:medium;font-family:Ver=
dana"><span style=3D"font-family:&quot;Lucida Grande&quot;"><p style=3D"fon=
t-family:Verdana;margin-bottom:12pt;font-size:10pt"><font><strong><font col=
or=3D"#666666">E=C2=A0</font></strong></font><a href=3D"mailto:robbinvandam=
me@gmail.com" style=3D"color:rgb(17,85,204)" target=3D"_blank">robbinvandam=
me@gmail.com</a></p></span></span></div></div>
</div></div>

--0000000000003bdedb063655424a--

