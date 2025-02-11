Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88453C0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 17:20:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.5091.1739294401805214646
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 09:20:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=O4Qtnm+v;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43957634473so2234105e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1739294400; x=1739899200; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GU5VVRgE3V9GYadMgfT9kDppPJC6MQlq3yRHoz9P80c=;
        b=O4Qtnm+vqr09yY1z/SJ1AuDZU+ayojOTX6XiZyLkBmmoYu4N7QzB5rHb1LhHcwgPpN
         U0MZb+umOokN9tko5TWdhV+kQGJYeaMWK2lUZvAR8KDdxsGDadIcNQSET91KHys8aUjX
         HkbYL4bJuiVQ/AwgQrkt/ah8s/jkEaQfIcPuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739294400; x=1739899200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GU5VVRgE3V9GYadMgfT9kDppPJC6MQlq3yRHoz9P80c=;
        b=Hlx/sPaqZ790fjYit3zBblhCpIFYAMs+jhxcmNGOaww+Hy7NAlpjE/hMO3RfVHDndv
         eBst3DH0oCNnNsEO/eDt5SZxZ9fF0PxwD23npaiZytCOJUg7VICt2FuLaoH7EV2j158r
         qxbp8Umt6z+l7IGClMxAr3CjSyLm7dtnee/nRl7D72UJkxGXvx50E0vqtesPEFXKCWSl
         TUlRtqVeVEYJ0daP2XEmVq5EOEY+QoDTI7XH2z6JtR5W95cvYrYbYcEn6OOKxNTUc7lk
         49IZpql0jYlwR6Ie7qXlPEFJOJAqaluiOpqUp3TD1E/5cDvfgbbt0C1Yqnr4aNVCJvY+
         q4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV9y1S2Ymh2CFeO1zRNI8sUPi9SV791y16yfWflyG1M9w9WXtrZGECvM0SeIDOp/C97MdgQUdTbnILcSYam@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx8eV9XUxZVHLQWRw2UJAMLCKUFYPahXEDDZWrZnJ+R95bbTocG
	nZT0mD1Zkk/fGsDcdjdLBfan7J/OgbMkOKxPM8UFdbTzptoaAlFEetGVBdEucJTK4JdBxhUuTZz
	smffcTdyQwKP3KhJ88H5V8fEaKrKfWGZgQ095Mw==
X-Gm-Gg: ASbGncs6DIhAltWr1zdKV6cMZgyTUIYPmbfHnJmL3uPSKnF+AzmC95rcc19BmZJmasq
	6E/hYqiUZ4z09KVG83OfOt5j2OZ5lT13kkfmaAGKjHXJWoad6rqbp2J1/zwsqJSXnTDYmNOCZ
X-Google-Smtp-Source: AGHT+IFy1cN1PD6kRs/qU3R0nUpfEIqZz8mZymWp73kEhJaQVaaJcy33fa1BiF0ulStqOVpypvqJTlp+3PczHGsRjPs=
X-Received: by 2002:a05:6000:1448:b0:38d:b2e4:6d97 with SMTP id
 ffacd0b85a97d-38dc9343d93mr16820630f8f.41.1739294399991; Tue, 11 Feb 2025
 09:19:59 -0800 (PST)
MIME-Version: 1.0
References: <c0723d2e-7742-4746-bc78-b0aee82fb8ed@syslinbit.com>
 <CAMSfU+4cpu9nqUuAS18+1MTBpOnJPd52Yt1jK3XKH66ywJ09+Q@mail.gmail.com> <AS4PR04MB9316434BAC675FF7E4B83781A9FD2@AS4PR04MB9316.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB9316434BAC675FF7E4B83781A9FD2@AS4PR04MB9316.eurprd04.prod.outlook.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 11 Feb 2025 18:19:34 +0100
X-Gm-Features: AWEUYZlwxMfgzFxA0R5s-tw-zs03VHnS_dIG68tgHuT9aTpCXj6aTwZEjaBhKLs
Message-ID: <CAMSfU+6NiWiQfGQE1kt1XSSOB6=vFTuC=e1=z2Tub7NDZNtvmQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [scarthgap] backport request for ??= operator for
 variable flags fix
To: Louis Rannou <louis.rannou@non.se.com>
Cc: "louis.rannou@syslinbit.com" <louis.rannou@syslinbit.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, Steve Sakoman <steve@sakoman.com>, 
	Pascal EBERHARD <pascal.eberhard@se.com>
Content-Type: multipart/alternative; boundary="000000000000df2be7062de108f9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 17:20:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17195

--000000000000df2be7062de108f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 11 f=C3=A9vr. 2025 =C3=A0 16:33, Louis Rannou <louis.rannou@non.se.=
com> a
=C3=A9crit :

> Hello,
>

Hello,


> Please abort the request as I found some issue in relation. The attached
> patch should confirm the issue.
>
> Weak values are now omitted in getVarFlags (while they were incorrect but
> present before 052746da9a7e96b43ec45a04322e8576a6cbaab7.
>

Hello,

I've reoppened https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685 wi=
th
your infomations, thanks!

Weirdly, not all your emails appear in the archive :
https://lists.openembedded.org/g/bitbake-devel/topics
... which means, only CC'd people received it.
You may want to check that both your mail addresses are subscribed to the
list.

Do you plan to work on it? If yes, don't hesitate to take the bug or add
more info :)

Louis Rannou
> Schneider Electric
>
>
> General
> ________________________________________
> De : Yoann Congal <yoann.congal@smile.fr>
> Envoy=C3=A9 : mardi 11 f=C3=A9vrier 2025 11:07
> =C3=80 : louis.rannou@syslinbit.com
> Cc : bitbake-devel@lists.openembedded.org; Steve Sakoman; Pascal
> EBERHARD; Louis Rannou
> Objet : Re: [bitbake-devel] [scarthgap] backport request for ??=3D operat=
or
> for variable flags fix
>
> [External email: Use caution with links and attachments]
>
> ________________________________
>
>
>
> Hello,
>
> Le mar. 11 f=C3=A9vr. 2025 =C3=A0 10:31, Louis Rannou via lists.openembed=
ded.org<
> http://lists.openembedded.org/> <louis.rannou=3D
> syslinbit.com@lists.openembedded.org<mailto:
> syslinbit.com@lists.openembedded.org>> a =C3=A9crit :
> Hello,
>
> May we apply the commit following commit to scarthgap as the issue also
> exist:
>
> commit 0329a7e3ac694737f2d2c1861f65492551360663
> Author: Yoann Congal <yoann.congal@smile.fr<mailto:yoann.congal@smile.fr>=
>
> Date:   Sat Jan 11 15:13:51 2025 +0100
>
>      data_smart: fix ??=3D operator for variable flags
>
> I suppose the other commit that came along for tests is also fine:
>
> commit e3536b3c67ad1a4195fcbd5485d2dc8308014fff (HEAD -> 2.8)
> Author: Yoann Congal <yoann.congal@smile.fr<mailto:yoann.congal@smile.fr>=
>
> Date:   Sat Jan 11 15:13:50 2025 +0100
>
>      tests/parse: add test for ?=3D and ??=3D operators for variable flag=
s
>
> Here is the path link for details
>
> https://lore.kernel.org/bitbake-devel/20250111141351.3993834-1-yoann.cong=
al@smile.fr/#t
> <
> https://lore.kernel.org/bitbake-devel/20250111141351.3993834-1-yoann.cong=
al@smile.fr/#t
> >
>
> Thanks,
> Louis Rannou
>
> To clarify, you target the "2.8" bitbake branch (the one Scarthgap poky
> uses)
> I could not find the doc for this but we usually have "[2.8]" in mail
> title for bitbake backport requests (for example:
> https://lists.openembedded.org/g/bitbake-devel/message/16872<
> https://lists.openembedded.org/g/bitbake-devel/message/16872>)
>
> You may also want to state explicitly that this is related to the bug
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685<
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685>
>
> Thanks (always nice to see my patches getting used :) )!
> --
> Yoann Congal
> Smile ECS - Tech expert
>


--=20
Yoann Congal
Smile ECS - Tech expert

--000000000000df2be7062de108f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">Le=C2=A0mar. 11 f=C3=A9vr. 2025 =C3=A0=C2=A01=
6:33, Louis Rannou &lt;<a href=3D"mailto:louis.rannou@non.se.com">louis.ran=
nou@non.se.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hello,<br></blockquote><div><br></div><div>Hello=
,<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Please abort the request as I found some issue in relation. The attached pa=
tch should confirm the issue.<br>
<br>
Weak values are now omitted in getVarFlags (while they were incorrect but p=
resent before 052746da9a7e96b43ec45a04322e8576a6cbaab7.<br></blockquote><di=
v><br></div><div>Hello,</div><div><br></div><div>I&#39;ve reoppened <a href=
=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685">https://bugz=
illa.yoctoproject.org/show_bug.cgi?id=3D15685</a> with your infomations, th=
anks!</div><div><br></div><div>Weirdly, not all your emails appear in the a=
rchive : <a href=3D"https://lists.openembedded.org/g/bitbake-devel/topics">=
https://lists.openembedded.org/g/bitbake-devel/topics</a></div><div>... whi=
ch means, only CC&#39;d people received it.</div><div>You may want to check=
 that both your mail addresses are subscribed to the list.</div><div><br></=
div><div>Do you plan to work on it? If yes, don&#39;t hesitate to take the =
bug or add more info :)<br></div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
Louis Rannou<br>
Schneider Electric<br>
<br>
<br>
General<br>
________________________________________<br>
De : Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_b=
lank">yoann.congal@smile.fr</a>&gt;<br>
Envoy=C3=A9 : mardi 11 f=C3=A9vrier 2025 11:07<br>
=C3=80 : <a href=3D"mailto:louis.rannou@syslinbit.com" target=3D"_blank">lo=
uis.rannou@syslinbit.com</a><br>
Cc : <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_bla=
nk">bitbake-devel@lists.openembedded.org</a>; Steve Sakoman; Pascal EBERHAR=
D; Louis Rannou<br>
Objet : Re: [bitbake-devel] [scarthgap] backport request for ??=3D operator=
 for variable flags fix<br>
<br>
[External email: Use caution with links and attachments]<br>
<br>
________________________________<br>
<br>
<br>
<br>
Hello,<br>
<br>
Le mar. 11 f=C3=A9vr. 2025 =C3=A0 10:31, Louis Rannou via <a href=3D"http:/=
/lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openemb=
edded.org</a>&lt;<a href=3D"http://lists.openembedded.org/" rel=3D"noreferr=
er" target=3D"_blank">http://lists.openembedded.org/</a>&gt; &lt;louis.rann=
ou=3D<a href=3D"mailto:syslinbit.com@lists.openembedded.org" target=3D"_bla=
nk">syslinbit.com@lists.openembedded.org</a>&lt;mailto:<a href=3D"mailto:sy=
slinbit.com@lists.openembedded.org" target=3D"_blank">syslinbit.com@lists.o=
penembedded.org</a>&gt;&gt; a =C3=A9crit :<br>
Hello,<br>
<br>
May we apply the commit following commit to scarthgap as the issue also<br>
exist:<br>
<br>
commit 0329a7e3ac694737f2d2c1861f65492551360663<br>
Author: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D=
"_blank">yoann.congal@smile.fr</a>&lt;mailto:<a href=3D"mailto:yoann.congal=
@smile.fr" target=3D"_blank">yoann.congal@smile.fr</a>&gt;&gt;<br>
Date:=C2=A0 =C2=A0Sat Jan 11 15:13:51 2025 +0100<br>
<br>
=C2=A0 =C2=A0 =C2=A0data_smart: fix ??=3D operator for variable flags<br>
<br>
I suppose the other commit that came along for tests is also fine:<br>
<br>
commit e3536b3c67ad1a4195fcbd5485d2dc8308014fff (HEAD -&gt; 2.8)<br>
Author: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D=
"_blank">yoann.congal@smile.fr</a>&lt;mailto:<a href=3D"mailto:yoann.congal=
@smile.fr" target=3D"_blank">yoann.congal@smile.fr</a>&gt;&gt;<br>
Date:=C2=A0 =C2=A0Sat Jan 11 15:13:50 2025 +0100<br>
<br>
=C2=A0 =C2=A0 =C2=A0tests/parse: add test for ?=3D and ??=3D operators for =
variable flags<br>
<br>
Here is the path link for details<br>
<a href=3D"https://lore.kernel.org/bitbake-devel/20250111141351.3993834-1-y=
oann.congal@smile.fr/#t" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/bitbake-devel/20250111141351.3993834-1-yoann.congal@smile.fr/#t<=
/a>&lt;<a href=3D"https://lore.kernel.org/bitbake-devel/20250111141351.3993=
834-1-yoann.congal@smile.fr/#t" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/bitbake-devel/20250111141351.3993834-1-yoann.congal@smile=
.fr/#t</a>&gt;<br>
<br>
Thanks,<br>
Louis Rannou<br>
<br>
To clarify, you target the &quot;2.8&quot; bitbake branch (the one Scarthga=
p poky uses)<br>
I could not find the doc for this but we usually have &quot;[2.8]&quot; in =
mail title for bitbake backport requests (for example: <a href=3D"https://l=
ists.openembedded.org/g/bitbake-devel/message/16872" rel=3D"noreferrer" tar=
get=3D"_blank">https://lists.openembedded.org/g/bitbake-devel/message/16872=
</a>&lt;<a href=3D"https://lists.openembedded.org/g/bitbake-devel/message/1=
6872" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g=
/bitbake-devel/message/16872</a>&gt;)<br>
<br>
You may also want to state explicitly that this is related to the bug <a hr=
ef=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685" rel=3D"nor=
eferrer" target=3D"_blank">https://bugzilla.yoctoproject.org/show_bug.cgi?i=
d=3D15685</a>&lt;<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?=
id=3D15685" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproj=
ect.org/show_bug.cgi?id=3D15685</a>&gt;<br>
<br>
Thanks (always nice to see my patches getting used :) )!<br>
--<br>
Yoann Congal<br>
Smile ECS - Tech expert<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS - Tech expert<br></font></div></div><=
/div></div>

--000000000000df2be7062de108f9--

