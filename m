Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45392E7719A
	for <webhook@archiver.kernel.org>; Sat, 11 Jan 2025 14:09:47 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.15869.1736604584763898289
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Jan 2025 06:09:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=v6cryprs;
 spf=pass (domain: smile.fr, ip: 209.85.221.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385de59c1a0so1488736f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Jan 2025 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736604583; x=1737209383; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9BDMe84sD0u7GY+k9ey+QHM18m3CqLhHOZMK0L/j2M=;
        b=v6cryprsws5ztbycxjh3KfBSDiUFBGKP/JnOgNCxTNBjCZIYckndqrpbAF+MHWIrec
         Vlk4JZ0DPEu0viy4Jz1iWW4ooTDpnXSM9PvLaBvef1lVr+jJpHc0MsCu+0eT1NiiPtRa
         mdLH9UThal2Ji1OHGV9ma3L9rz/noTeOuPYBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736604583; x=1737209383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9BDMe84sD0u7GY+k9ey+QHM18m3CqLhHOZMK0L/j2M=;
        b=WPj+mdcwpVLNVNnsNEH66x60sBN6r4pMGveAjK1L8xDlixn6BOqQcqsgGoyZqAORdi
         P4Xq30XzqUYXx00E4ZxAkRiqs2B/8GuN2ObCSuAQgIhZ3E1xyFy6RqgTpt0LTXAo08sD
         NUs3nOmn98HVKUG4FDiYNqEMzAjrjGbQlKMICSngHtpwmTgatFA/wVTHeDeuw2rBDLIJ
         mhLj4IcX9T7fM0w3GSVm4avJzCvBCxSMlDVtzz/4O2/tUU63sxK5dm+TmgRbGy+VbTxH
         GPxRZ5d3e8M6zSlMHdmWiqrqp81B1ORPXlXPAV8CRpLO8NMOTZOKpU00HlwWI4x9a/oF
         56EQ==
X-Gm-Message-State: AOJu0YyJTw5P0VomLHDRcirPe0KcNbUT/Xuv2WuRTmztOkKfLrDUgGjX
	QD5M49CWMiibFzqlSstW+nS75qigngROPHNjR69IqBJfu6e1JXd4swCumaJZXXnCvwvTbinnlqv
	1Q3c42cb9LiHuf/f58uWavk+A4lr+TK2kzBDv1g==
X-Gm-Gg: ASbGncvfKsuOGuatL26hozNpd+mLoQqMAydf29kcZb2I4Pc161RDJ6wuyPvogk8NE+G
	8jFkj/BwwIf/6y483/X+szs9j93OhvEtCi6deXw==
X-Google-Smtp-Source: AGHT+IFuIm1nqOuYZZs+7JGhsyGdWzkGhdPME9xUAiMnf17KMRJICp95PImRcelM9XbrGKTC425IObLb/lrGnXsBAao=
X-Received: by 2002:adf:a3c7:0:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38a88bebd18mr9900757f8f.5.1736604582103; Sat, 11 Jan 2025
 06:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20250110225652.3892828-1-yoann.congal@smile.fr> <DB5PR02MB10213447117C48CCE33E10BD5EF1D2@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB10213447117C48CCE33E10BD5EF1D2@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Sat, 11 Jan 2025 15:09:15 +0100
X-Gm-Features: AbW1kvauKfxFWb4lZjRTgW6RpGsELfzWpW0SpYTFvuTYr9n-L8qzSSR7mWKPe1k
Message-ID: <CAMSfU+7d0NrADhhfhXD91EA=xmmpOHO3xp1t8hQ1pk_M677NoA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] tests/parse: add test for ?= and
 ??= operators for variable flags
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>, 
	=?UTF-8?Q?Ghislain_Mang=C3=A9?= <ghislain.mange@smile.fr>
Content-Type: multipart/alternative; boundary="0000000000003b6ff8062b6ec3d3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Jan 2025 14:09:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17014

--0000000000003b6ff8062b6ec3d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 11 janv. 2025 =C3=A0 12:06, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> a =C3=A9crit :

> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <
> bitbake-devel@lists.openembedded.org> On Behalf Of Yoann Congal via
> lists.openembedded.org
> > Sent: den 10 januari 2025 23:57
> > To: bitbake-devel@lists.openembedded.org
> > Cc: Yoann Congal <yoann.congal@smile.fr>; Ghislain Mang=C3=A9 <
> ghislain.mange@smile.fr>
> > Subject: [bitbake-devel] [PATCH v2 1/2] tests/parse: add test for ?=3D =
and
> ??=3D operators for variable flags
> >
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > Run the test with:
> >  $ bitbake-selftest bb.tests.parse.ParseTest.test_parse_defaulttest .
> > ----------------------------------------------------------------------
> > Ran 1 test in 0.001s
> >
> > OK
> >
> > This is a test case for [YOCTO #15685]
> >
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > Reviewed-by: Ghislain Mang=C3=A9 <ghislain.mange@smile.fr>
> > ---
> > v1->v2:
> > * More comprehensive test cases with =3D, ?=3D and ??=3D combinations
> > ---
> >  lib/bb/tests/parse.py | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
> > index 56eb66be9..38c3e3253 100644
> > --- a/lib/bb/tests/parse.py
> > +++ b/lib/bb/tests/parse.py
> > @@ -75,6 +75,47 @@ unset B[flag]
> >          self.assertEqual(d.getVarFlag("A","flag"), None)
> >          self.assertEqual(d.getVar("B"), "2")
> >
> > +    defaulttest =3D """
> > +A =3D "set value"
> > +A ??=3D "default value"
> > +
> > +A[flag_set_vs_question] =3D "set flag"
> > +A[flag_set_vs_question] ?=3D "question flag"
> > +
> > +A[flag_set_vs_default] =3D "set flag"
> > +A[flag_set_vs_default] ??=3D "default flag"
> > +
> > +A[flag_question] ?=3D "question flag"
> > +
> > +A[flag_default] ??=3D "default flag"
> > +
> > +A[flag_question_vs_default] ?=3D "question flag"
> > +A[flag_question_vs_default] ??=3D "default flag"
> > +
> > +A[flag_default_vs_question] ??=3D "default flag"
> > +A[flag_default_vs_question] ?=3D "question flag"
> > +
> > +A[flag_set_question_default] =3D "set flag"
> > +A[flag_set_question_default] ?=3D "question flag"
> > +A[flag_set_question_default] ??=3D "default flag"
> > +
> > +A[flag_set_default_question] =3D "set flag"
> > +A[flag_set_default_question] ??=3D "default flag"
> > +A[flag_set_default_question] ?=3D "question flag"
>
> I would like to suggest that you add tests that verifies the behavior whe=
n
> the same operator is used twice, e.g.:
>

A[flag_set_twice] =3D "set flag first"
> A[flag_set_twice] =3D "set flag second"
>
> A[flag_question_twice] ?=3D "question flag first"
> A[flag_question_twice] ?=3D "question flag second"
>
> A[flag_default_twice] ??=3D "default flag first"
> A[flag_default_twice] ??=3D "default flag second"
>

I was not sure what the expected behavior was in these cases, but the doc
is clear (kudos!) :
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manu=
al-metadata.html#setting-a-default-value
:
A[flag_set_twice] =3D "set flag second"
A[flag_question_twice] =3D "question flag first"
A[flag_default_twice] =3D "default flag second"

I'll add these in V3, thanks!


>
> //Peter
>
> > +"""
> > +    def test_parse_defaulttest(self):
> > +        f =3D self.parsehelper(self.defaulttest)
> > +        d =3D bb.parse.handle(f.name, self.d)['']
> > +        self.assertEqual(d.getVar("A"), "set value")
> > +        self.assertEqual(d.getVarFlag("A","flag_set_vs_question"), "se=
t
> flag")
> > +        self.assertEqual(d.getVarFlag("A","flag_set_vs_default"), "set
> flag")
> > +        self.assertEqual(d.getVarFlag("A","flag_question"), "question
> flag")
> > +        self.assertEqual(d.getVarFlag("A","flag_default"), "default
> flag")
> > +        self.assertEqual(d.getVarFlag("A","flag_question_vs_default"),
> "question flag")
> > +        self.assertEqual(d.getVarFlag("A","flag_default_vs_question"),
> "question flag")
> > +        self.assertEqual(d.getVarFlag("A","flag_set_question_default")=
,
> "set flag")
> > +        self.assertEqual(d.getVarFlag("A","flag_set_default_question")=
,
> "set flag")
> > +
> >      exporttest =3D """
> >  A =3D "a"
> >  export B =3D "b"
>

--0000000000003b6ff8062b6ec3d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"auto"><div dir=3D"a=
uto">Le sam. 11 janv. 2025 =C3=A0 12:06, Peter Kjellerstedt &lt;<a href=3D"=
mailto:peter.kjellerstedt@axis.com" target=3D"_blank">peter.kjellerstedt@ax=
is.com</a>&gt; a =C3=A9crit=C2=A0:</div><div class=3D"gmail_quote" dir=3D"a=
uto"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; -----Original M=
essage-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" rel=3D"n=
oreferrer" target=3D"_blank">bitbake-devel@lists.openembedded.org</a> &lt;<=
a href=3D"mailto:bitbake-devel@lists.openembedded.org" rel=3D"noreferrer" t=
arget=3D"_blank">bitbake-devel@lists.openembedded.org</a>&gt; On Behalf Of =
Yoann Congal via <a href=3D"http://lists.openembedded.org" rel=3D"noreferre=
r noreferrer" target=3D"_blank">lists.openembedded.org</a><br>
&gt; Sent: den 10 januari 2025 23:57<br>
&gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" rel=3D"nor=
eferrer" target=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt; Cc: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" rel=3D"n=
oreferrer" target=3D"_blank">yoann.congal@smile.fr</a>&gt;; Ghislain Mang=
=C3=A9 &lt;<a href=3D"mailto:ghislain.mange@smile.fr" rel=3D"noreferrer" ta=
rget=3D"_blank">ghislain.mange@smile.fr</a>&gt;<br>
&gt; Subject: [bitbake-devel] [PATCH v2 1/2] tests/parse: add test for ?=3D=
 and ??=3D operators for variable flags<br>
&gt; <br>
&gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" rel=3D=
"noreferrer" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; <br>
&gt; Run the test with:<br>
&gt;=C2=A0 $ bitbake-selftest bb.tests.parse.ParseTest.test_parse_defaultte=
st .<br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; Ran 1 test in 0.001s<br>
&gt; <br>
&gt; OK<br>
&gt; <br>
&gt; This is a test case for [YOCTO #15685]<br>
&gt; <br>
&gt; Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r" rel=3D"noreferrer" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; Reviewed-by: Ghislain Mang=C3=A9 &lt;<a href=3D"mailto:ghislain.mange@=
smile.fr" rel=3D"noreferrer" target=3D"_blank">ghislain.mange@smile.fr</a>&=
gt;<br>
&gt; ---<br>
&gt; v1-&gt;v2:<br>
&gt; * More comprehensive test cases with =3D, ?=3D and ??=3D combinations<=
br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/tests/parse.py | 41 +++++++++++++++++++++++++++++++++++++=
++++<br>
&gt;=C2=A0 1 file changed, 41 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py<br>
&gt; index 56eb66be9..38c3e3253 100644<br>
&gt; --- a/lib/bb/tests/parse.py<br>
&gt; +++ b/lib/bb/tests/parse.py<br>
&gt; @@ -75,6 +75,47 @@ unset B[flag]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;=
A&quot;,&quot;flag&quot;), None)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVar(&quot;B&qu=
ot;), &quot;2&quot;)<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 defaulttest =3D &quot;&quot;&quot;<br>
&gt; +A =3D &quot;set value&quot;<br>
&gt; +A ??=3D &quot;default value&quot;<br>
&gt; +<br>
&gt; +A[flag_set_vs_question] =3D &quot;set flag&quot;<br>
&gt; +A[flag_set_vs_question] ?=3D &quot;question flag&quot;<br>
&gt; +<br>
&gt; +A[flag_set_vs_default] =3D &quot;set flag&quot;<br>
&gt; +A[flag_set_vs_default] ??=3D &quot;default flag&quot;<br>
&gt; +<br>
&gt; +A[flag_question] ?=3D &quot;question flag&quot;<br>
&gt; +<br>
&gt; +A[flag_default] ??=3D &quot;default flag&quot;<br>
&gt; +<br>
&gt; +A[flag_question_vs_default] ?=3D &quot;question flag&quot;<br>
&gt; +A[flag_question_vs_default] ??=3D &quot;default flag&quot;<br>
&gt; +<br>
&gt; +A[flag_default_vs_question] ??=3D &quot;default flag&quot;<br>
&gt; +A[flag_default_vs_question] ?=3D &quot;question flag&quot;<br>
&gt; +<br>
&gt; +A[flag_set_question_default] =3D &quot;set flag&quot;<br>
&gt; +A[flag_set_question_default] ?=3D &quot;question flag&quot;<br>
&gt; +A[flag_set_question_default] ??=3D &quot;default flag&quot;<br>
&gt; +<br>
&gt; +A[flag_set_default_question] =3D &quot;set flag&quot;<br>
&gt; +A[flag_set_default_question] ??=3D &quot;default flag&quot;<br>
&gt; +A[flag_set_default_question] ?=3D &quot;question flag&quot;<br>
<br>
I would like to suggest that you add tests that verifies the behavior when =
<br>
the same operator is used twice, e.g.:<br></blockquote></div><div dir=3D"au=
to"><br></div><div class=3D"gmail_quote" dir=3D"auto"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
A[flag_set_twice] =3D &quot;set flag first&quot;<br>
A[flag_set_twice] =3D &quot;set flag second&quot;<br>
<br>
A[flag_question_twice] ?=3D &quot;question flag first&quot;<br>
A[flag_question_twice] ?=3D &quot;question flag second&quot;<br>
<br>
A[flag_default_twice] ??=3D &quot;default flag first&quot;<br>
A[flag_default_twice] ??=3D &quot;default flag second&quot;<br></blockquote=
><div><br></div><div>I was not sure what the expected behavior was in these=
 cases, but the doc is clear (kudos!) : <a href=3D"https://docs.yoctoprojec=
t.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting=
-a-default-value">https://docs.yoctoproject.org/bitbake/bitbake-user-manual=
/bitbake-user-manual-metadata.html#setting-a-default-value</a> :</div><div>
A[flag_set_twice] =3D &quot;set flag second&quot;</div><div>
A[flag_question_twice] =3D &quot;question flag first&quot;</div><div>
A[flag_default_twice] =3D &quot;default flag second&quot;</div><div><br></d=
iv><div>I&#39;ll add these in V3, thanks!<br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
//Peter<br>
<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 def test_parse_defaulttest(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 f =3D self.parsehelper(self.defaulttest)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 d =3D bb.parse.handle(<a href=3D"http://f=
.name" rel=3D"noreferrer noreferrer" target=3D"_blank">f.name</a>, self.d)[=
&#39;&#39;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVar(&quot;A&quot;),=
 &quot;set value&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_set_vs_question&quot;), &quot;set flag&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_set_vs_default&quot;), &quot;set flag&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_question&quot;), &quot;question flag&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_default&quot;), &quot;default flag&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_question_vs_default&quot;), &quot;question flag&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_default_vs_question&quot;), &quot;question flag&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_set_question_default&quot;), &quot;set flag&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(d.getVarFlag(&quot;A&quo=
t;,&quot;flag_set_default_question&quot;), &quot;set flag&quot;)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 exporttest =3D &quot;&quot;&quot;<br>
&gt;=C2=A0 A =3D &quot;a&quot;<br>
&gt;=C2=A0 export B =3D &quot;b&quot;<br>
</blockquote></div></div>
</div>

--0000000000003b6ff8062b6ec3d3--

