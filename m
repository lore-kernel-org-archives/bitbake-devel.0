Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E99DD1171B
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 17:41:01 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1881.1764697253698637693
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 09:40:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=AjSt8zli;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so59299015e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764697252; x=1765302052; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb3ZbDPnkE2nkvxab+fShyt/iTPaIrNz5+wTQ86lEnA=;
        b=AjSt8zli8L7mLnmxdXFlZCC4I8P1tK2ZgcqAo+2WwS7JniCLtdHgqBxI1RncjlwL4N
         IjfSLtBLCBrC48nebimug3PDR6LzdVgTn/fbuj1uONmD6nC6EoAKj+96gTIFZ8Sw7VdS
         ozQkHcIWg4GT6e2ieua9UEZkfvpgIhCP8/vk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697252; x=1765302052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb3ZbDPnkE2nkvxab+fShyt/iTPaIrNz5+wTQ86lEnA=;
        b=J5hZwvpd08hEGJ+LuxovoYha1At5/vx14R2OyZl3lfiDMRFaLq0AtuPGJSr7gjKFox
         7t7uAp9HdaNaMqByXAmi2KJHfuJxR/dTTUYS+YMpOox0AF6Cj7MWejalSQhrwBBg+Tsx
         Y6es7xkXFbYaSj7JM0wU0LT5wW5rac/Ap81xpVCq1+QvvK2FgR680AZKJ5KGR3tNZLOb
         OyMpg1jQCcp0L8iWMhszHVHwiEIz9ZUvUWlimiwggmH85eNRQJYmpBN5n1wDlj0/hCg5
         fRjuN4qq3cZr5wZHmtNAKhzqyp79BJQBEuZ9s56yGCy6pOsndEdjSZgC36edhakQUyx2
         Zihw==
X-Forwarded-Encrypted: i=1; AJvYcCVlEGnDx7tQDdFASESXpb3LzBKAQpVpjbQc2TBHZBRtxgl2z1D2nPzXDdKaSddiqr+8FkABWWhemBdtVAmo@lists.openembedded.org
X-Gm-Message-State: AOJu0YyywtLC/T1XN0eJ6XqBlI0IMz9bl0RhU/OEgrXx9jrBt5Bhbb9K
	hqMyw72o5EmT+c9EnI006uAPYmU3orQ3zgzVw3qfUSiofEWKyVZIvRo6g5lS8w5FGd2JECPAPgo
	23IhRHVseFDZk4JO5JAguM1RsxTNAD5d2JuNmGHHUWA==
X-Gm-Gg: ASbGncsjDtYWXbZnJye5APBbQYNRsyOSWtDjBF/iSV2NuuQapBW2syQkr9yFA0YvDsr
	cJa/mVCj/TeNTAeOLAdj8yZ17n9DOmV7XhD8Dj27vCdPDQ8IvSyJfkwzoHb1DQWVgjGltsrHoXu
	OWVjryBfAOHp+WQqBJwk/YS7mrjXS910IH90kZSux/14unGBu3ZrsZjtGPMRvgeCkvjfGAz3atS
	7daXVMi3d4hBUobxViPQIQU1NBzf2H23j6yUG8gEmwYv6k/vDgl5E9RLpk4RoaRGcjeLIZ6+2r0
	BMpdQryHlJb8Kb9lPbOehlR8c2/b
X-Google-Smtp-Source: AGHT+IGg9FmiqfshEVm9LPZ975KfvzYZfiRkhpd73TKpEMhdh+cRrLA7YhlG7SA1Ltysgi9bhHg2vfl2f2ntbvMUOK0=
X-Received: by 2002:a05:600c:8b37:b0:477:569c:34e9 with SMTP id
 5b1f17b1804b1-47904b1eda4mr260704245e9.23.1764697252013; Tue, 02 Dec 2025
 09:40:52 -0800 (PST)
MIME-Version: 1.0
References: <e48f35c8b286c03c0e423ffd5feccfccc995c282.camel@linuxfoundation.org>
In-Reply-To: <e48f35c8b286c03c0e423ffd5feccfccc995c282.camel@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 2 Dec 2025 18:40:26 +0100
X-Gm-Features: AWmQ_blUYZ2VCfHzP6MnsZoIGq-bdL_JlqMYNLQnntETdWyw-SLwVlTbNz1aGuI
Message-ID: <CAMSfU+6-pM5wXcjUc6QNmqYsUX75=74knAUw1iMbaZRnzczjAw@mail.gmail.com>
Subject: Re: [bitbake-devel] Project role announcements
To: richard.purdie@linuxfoundation.org
Cc: openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000d7b90d0644fb98da"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 17:41:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18514

--000000000000d7b90d0644fb98da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 2 d=C3=A9c. 2025 =C3=A0 13:02, Richard Purdie via lists.openembedde=
d.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> a =C3=A9crit =
:

> It gives me great pleasure to be able to announce that we have filled
> the two recently advertised positions.
>
> [...]
>
> I'd also like to announce Yoann Congal with backup from others at Smile
> as our new LTS maintainer as Steve Sakoman takes a well deserved
> retirement. Yoann/Smile have been doing great work on meta-openembedded
> with our various metrics and tracking tools as well as being active in
> various project meetings including bug fixing so many of you know him
> already. There will be an transition period as we transfer the role.
>
> I want to take the opportunity to say a huge thanks to Steve Sakoman
> for looking after multiple LTS releases in a careful, considered and
> smooth way. I no longer had to worry about them, I could just trust
> everything was being handled which is probably the best way I can
> illustrate the job Steve has been doing. So a huge thanks to Steve, I
> (and the project) really do appreciate what you've achieved there and
> you set a high standard to follow!
>

I'm truly honored to take on this role. I hope to run the LTS maintenance
process as smoothly as Steve has. And I know that is a high bar to clear!

We will give it our best effort to carry the torch and ensure our LTS users
are
well supported.

Best Regards,
--=20
Yoann Congal
Smile ECS

--000000000000d7b90d0644fb98da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Le=C2=A0mar. 2 d=C3=A9c. 2025 =C3=A0=C2=
=A013:02, Richard Purdie via <a href=3D"http://lists.openembedded.org">list=
s.openembedded.org</a> &lt;richard.purdie=3D<a href=3D"mailto:linuxfoundati=
on.org@lists.openembedded.org">linuxfoundation.org@lists.openembedded.org</=
a>&gt; a =C3=A9crit=C2=A0:</div><div class=3D"gmail_quote gmail_quote_conta=
iner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">It gives me great p=
leasure to be able to announce that we have filled<br>
the two recently advertised positions.<br><br>[...]<br>
<br>
I&#39;d also like to announce Yoann Congal with backup from others at Smile=
<br>
as our new LTS maintainer as Steve Sakoman takes a well deserved<br>
retirement. Yoann/Smile have been doing great work on meta-openembedded<br>
with our various metrics and tracking tools as well as being active in<br>
various project meetings including bug fixing so many of you know him<br>
already. There will be an transition period as we transfer the role.<br>
<br>
I want to take the opportunity to say a huge thanks to Steve Sakoman<br>
for looking after multiple LTS releases in a careful, considered and<br>
smooth way. I no longer had to worry about them, I could just trust<br>
everything was being handled which is probably the best way I can<br>
illustrate the job Steve has been doing. So a huge thanks to Steve, I<br>
(and the project) really do appreciate what you&#39;ve achieved there and<b=
r>
you set a high standard to follow!<br></blockquote><div><br></div>I&#39;m t=
ruly honored to take on this role. I hope to run the LTS maintenance <br>pr=
ocess as smoothly as Steve has. And I know that is a high bar to clear!<br>=
<br>We will give it our best effort to carry the torch and ensure our LTS u=
sers are <br>well supported.</div><div class=3D"gmail_quote gmail_quote_con=
tainer"><br></div><div class=3D"gmail_quote gmail_quote_container">Best Reg=
ards,</div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"Raleway, reg=
ular">Yoann Congal</font><div><font face=3D"Raleway, regular">Smile ECS</fo=
nt></div></div></div></div>

--000000000000d7b90d0644fb98da--

