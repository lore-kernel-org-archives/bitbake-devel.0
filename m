Return-Path: <ernstp@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765BCA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 12:35:53 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.12661.1755606952807054356
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 05:35:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cge1BuUr;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: ernstp@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-618adc251f0so6753898a12.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606951; x=1756211751; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7L7mx0lKbLnCv6KKEQ05Z34+4AyQ4HlXZMwnlkueI0=;
        b=cge1BuUrG2fOOt8dRx4B5+Rr55AgrqogO8Q3G+TZZKRX/GxYzQtmIRTS8JJjp7qdVy
         4X7fQrjmrzeXtS46Naxbef+vyjOC+t4HtxDXS3Gk12FLq9NnWoO6CKG/o4LwwTaRIhwJ
         FpLuUwfRBquFUEUSlNwuUTJ1clxBwHgijkTOr2/KEr7FaXc2AEtzT9bJ0kAMJha+a5AD
         +ggh/kL2DodEhWRAYuXsFa6qk+eUg43cq3S81pvQ5Tb6RrzhdI0MnaS5r2rSI8ED7EI2
         HcoDSI5fYTMO6exG8RPzot0VYiTskX7lRQT4XMz8DBzY4Pv3gnvhKpsTxwMrwPN+ljPr
         q3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606951; x=1756211751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7L7mx0lKbLnCv6KKEQ05Z34+4AyQ4HlXZMwnlkueI0=;
        b=lvpb5trUyFUFadfNwCw3WyYRB1U6XndacmutnZz5QKDKb1hOnwDcflI6R1tHbphyLS
         p/vtz+CHUgQGXNrjvfZFZOWDu2trlRHL2kVDNNGgUlg0aTC3JxLIED7aBPTObZRBl4o+
         w5xRsWQWlMV3dec0fk20v1CWz674ZJw3K+fVb8PPmAvOF7QnZjQC8sj4jW8kh3sdCSTZ
         llG1BI2iFtCj6XVd6EwY9nqXOOlMDdYuOJXVXIXzTKVWLlZdsecvkDvZTe/VTfX52DhI
         jQvU86o4gC/96yoErH4K3tMR/d1HVV85l6q1XxJuxNypRKaWzTceklX5rfPMrdjCyRBJ
         z8QA==
X-Forwarded-Encrypted: i=1; AJvYcCUOp1sJ793Zqjw+KuDBW8GPc0RI3xQUwvll/sPqytwpuXIy9LK+lOmyaWB6kwpH/YtzRNvSN62CFngurEB/@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxp3qOfhPglhY+Kqz4nA+MdQlLzKyIVf9gW430G09YKIiMbgThN
	zZZI3It+GBjukI41TXT/t6vabqhuil6m4ME1smwNRyDiYHezyj1JyeIJ+CCXR9CaA/v5fLECf86
	pgLls2ZKH4ZyRLOdVYK2KWecVG6pX4i8=
X-Gm-Gg: ASbGnctLMNM9a/3HdNqxPxnlYHgrPXnk5Ez/NY0/KY9jFYdzf2o1BCRrXovTYXvhb28
	LKCTZ8HPfNgXQr9tI1RDrBuscs8vHLRw/Ak2xodts4IwTYVK/GqEUE3qeoQrZCmdbbmN7BACrMs
	ttwM1SNo6mfurtBvdL866uohW7HvmHu0Hbq1H8d1eTUNlGnszCo5ql0+VdPQFx0ED+A/6SqzzD6
	/SE6zY6
X-Google-Smtp-Source: AGHT+IGeLn1VuatGfcd0/LOmoWr0jVL4Jv08lnE97LiuIUCqUybN+GQKDFo4FeK6fmqPX6IS0+WbltBX2K/dj+qOvIA=
X-Received: by 2002:a05:6402:2110:b0:61a:8956:80da with SMTP id
 4fb4d7f45d1cf-61a89568752mr877797a12.17.1755606950861; Tue, 19 Aug 2025
 05:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <b937fbb5-f398-414a-a440-7020004d91f8@muxen.fr>
 <185D2421C5FD6ED8.4571@lists.openembedded.org> <548d93e5583ca1c1808f51a69901e168263e0917.camel@linuxfoundation.org>
In-Reply-To: <548d93e5583ca1c1808f51a69901e168263e0917.camel@linuxfoundation.org>
From: Ernst Persson <ernstp@gmail.com>
Date: Tue, 19 Aug 2025 14:35:39 +0200
X-Gm-Features: Ac12FXz-U5pnYLar5bmebPp5JC6SlDO0cobYwnSZIRocp6aacwbj1YTTQoj0KYg
Message-ID: <CAD=4a=Wq9FiyKMXa-fA4NwTYuyCUc1N9KZQyAvAVY8ty3_LvUw@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake and epileptic seizures
To: richard.purdie@linuxfoundation.org
Cc: william.martin@muxen.fr, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000abe17b063cb718c7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 12:35:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17888

--000000000000abe17b063cb718c7
Content-Type: text/plain; charset="UTF-8"

I recently saw this merge request:
https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/4487
It says the following:

"The European Accessibility Act (EAA), in its Annex I, Section I, 2.J,
specifies that products "shall avoid triggering photosensitive
seizures" (see Sources).
According to the Web Content Accessibility Guidelines (WCAG), any
element that flashes in the screen must have a maximum period of
3Hz to avoid the risk of Photosensitivity Seizures (see Sources)."

Den tis 19 aug. 2025 kl 12:43 skrev Richard Purdie via
lists.openembedded.org <richard.purdie=
linuxfoundation.org@lists.openembedded.org>:

> On Tue, 2025-08-19 at 11:25 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > Hi,
> >
> > On Tue, 2025-08-19 at 11:56 +0200, William MARTIN via
> lists.openembedded.org wrote:
> > > I send you this message today to talk about technical choices that can
> > > have serious health problems.
> > >
> > > Some days ago, we have an external person at our office who have see a
> > > bitbake terminal building an image.
> > > We discover that he is sensible to epileptic seizures (he is ban from
> > > traveling by plane for that).
> > > The story finish pretty well for him, but we have to ensure no bitbake
> > > terminal is open when he is here.
> > >
> > > I am not sure that refreshing the task list at very high speed have
> any
> > > interest for anyone.
> > > Maybe an update at 1Hz max is enough to ensure the build is working.
> >
> > Firstly, I'm sorry to hear about that person. Nobody likes to think
> > something they've worked on causes an issues like that :(. I hope they
> > are ok.
> >
> > The fast refresh rate isn't an intentional design decision but the
> > result of a number of changes over the past decade coming together and
> > interacting badly. Those include CPUs with higher core counts, addition
> > of progress bars to many tasks and time output on the console view, all
> > of which were developed semi-independently.
> >
> > There are some patches that were submitted a while back but there were
> > issues in the implementation and we've never got to providing feedback
> > and sorting them out. Sadly that is a common theme for many different
> > things.
> >
> > I am going to try and get this one resolved though given this report.
> >
> > Thanks for bringing it to our attention.
>
> I've merged some patches. They have a 40hz refresh rate right now but
> at least add all the code needed to make it configurable and we can
> experiment to find a reasonable value.
>
> Cheers,
>
> Richard
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17886):
> https://lists.openembedded.org/g/bitbake-devel/message/17886
> Mute This Topic: https://lists.openembedded.org/mt/114778577/4947266
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ernstp@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000abe17b063cb718c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">I recently saw this merge request:=C2=A0<a href=3D"http=
s://gitlab.gnome.org/GNOME/mutter/-/merge_requests/4487">https://gitlab.gno=
me.org/GNOME/mutter/-/merge_requests/4487</a></div><div class=3D"gmail_defa=
ult" style=3D"font-family:arial,helvetica,sans-serif">It says the following=
:</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sa=
ns-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial=
,helvetica,sans-serif">&quot;The European Accessibility Act (EAA), in its A=
nnex I, Section I, 2.J,<br>specifies that products &quot;shall avoid trigge=
ring photosensitive<br>seizures&quot; (see Sources).<br>According to the We=
b Content Accessibility Guidelines (WCAG), any<br>element that flashes in t=
he screen must have a maximum period of<br>3Hz to avoid the risk of Photose=
nsitivity Seizures (see Sources).&quot;</div></div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Den tis =
19 aug. 2025 kl 12:43 skrev Richard Purdie via <a href=3D"http://lists.open=
embedded.org">lists.openembedded.org</a> &lt;richard.purdie=3D<a href=3D"ma=
ilto:linuxfoundation.org@lists.openembedded.org">linuxfoundation.org@lists.=
openembedded.org</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, 2025-08-19 at 11:25 +0100, Richard Purdie via <a href=3D=
"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.=
openembedded.org</a> wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Tue, 2025-08-19 at 11:56 +0200, William MARTIN via <a href=3D"http:=
//lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openem=
bedded.org</a> wrote:<br>
&gt; &gt; I send you this message today to talk about technical choices tha=
t can <br>
&gt; &gt; have serious health problems.<br>
&gt; &gt; <br>
&gt; &gt; Some days ago, we have an external person at our office who have =
see a <br>
&gt; &gt; bitbake terminal building an image.<br>
&gt; &gt; We discover that he is sensible to epileptic seizures (he is ban =
from<br>
&gt; &gt; traveling by plane for that).<br>
&gt; &gt; The story finish pretty well for him, but we have to ensure no bi=
tbake <br>
&gt; &gt; terminal is open when he is here.<br>
&gt; &gt; <br>
&gt; &gt; I am not sure that refreshing the task list at very high speed ha=
ve any <br>
&gt; &gt; interest for anyone.<br>
&gt; &gt; Maybe an update at 1Hz max is enough to ensure the build is worki=
ng.<br>
&gt; <br>
&gt; Firstly, I&#39;m sorry to hear about that person. Nobody likes to thin=
k<br>
&gt; something they&#39;ve worked on causes an issues like that :(.=C2=A0I =
hope they<br>
&gt; are ok.<br>
&gt; <br>
&gt; The fast refresh rate isn&#39;t an intentional design decision but the=
<br>
&gt; result of a number of changes over the past decade coming together and=
<br>
&gt; interacting badly. Those include CPUs with higher core counts, additio=
n<br>
&gt; of progress bars to many tasks and time output on the console view, al=
l<br>
&gt; of which were developed semi-independently.<br>
&gt; <br>
&gt; There are some patches that were submitted a while back but there were=
<br>
&gt; issues in the implementation and we&#39;ve never got to providing feed=
back<br>
&gt; and sorting them out. Sadly that is a common theme for many different<=
br>
&gt; things.<br>
&gt; <br>
&gt; I am going to try and get this one resolved though given this report.<=
br>
&gt; <br>
&gt; Thanks for bringing it to our attention.<br>
<br>
I&#39;ve merged some patches. They have a 40hz refresh rate right now but<b=
r>
at least add all the code needed to make it configurable and we can<br>
experiment to find a reasonable value.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17886): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/17886" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/17886</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/114778577/494=
7266" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/114778577/4947266</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ernstp@gmail.com" target=3D"_blank=
">ernstp@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000abe17b063cb718c7--

