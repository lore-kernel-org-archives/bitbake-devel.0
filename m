Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD44CAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 21:06:09 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.4798.1759439165258478905
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 14:06:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=KxxufJaz;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b303f7469so10117945e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759439164; x=1760043964; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XbCrjfFW/LMH+CAu4Xu6MANHkxE/vEJ7n8amQKCXZU8=;
        b=KxxufJazgSGBwsRCDU+9Ax5ZQW3TOyD2yrAidzjc6eF4emaBjAPCIcwJOMbAGPdk1s
         LGw6yp4AgxAPT7xRAiy/hmV3s4qkH57qLN5ilzNt4X0R5/JJLR2puc04MeG+m7RPG5vx
         Qy4HC+F+fbEIvTEZOyafmN7S+oiQ5azTOIfbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439164; x=1760043964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbCrjfFW/LMH+CAu4Xu6MANHkxE/vEJ7n8amQKCXZU8=;
        b=XvifrDk2wC7+7naGJFhDztHHQ6Z5+Bmp+qmsluR1AHJKqkCVq5YKpY+56QXFulloq8
         qPb8+XwWhIjyn0K6kyljN0uzlsGINbcJvOVhXyXIVofKBk7HBAw4NHsTnsjENe89O41c
         +yx0S/4ijsfEC5wo8squSeBftj7lXE0U6590QMwTk9K54ujDMCLuPP6Zwya1yOkLoTfs
         MUYpYaoFsl5TTMb82VkXJCkNtYwMJT5lhnW/rtaZrjmxrcYr5ROOFFjwfhafbJfpk36J
         AsBma9Ge/VotUiu373IRCckVacUy4SSSMIFoeVDL50piW0YqilsGMemlD4sf1A5SGd6L
         P3Ow==
X-Gm-Message-State: AOJu0Yx6T/TfDm/8qCdfAqYB/dPfA97Tmokex/KmS8/VtuxaFlEJhjuD
	csEeC+aRcKQjxGHTPRCHDX50ATHZRr5yZRzvWAusU1+cSpkn5CKNRZoquHwjlbuc3k8X6zMaekS
	FaoCgBoOqaNn5LbVUY6LrdLsUs/8vzSt199+SSfitsw==
X-Gm-Gg: ASbGncugT9AOwgLwymjYT1sSrqyhVXjZZAQjBMSwT0amsea5ko/QnP6k3Q2Ws9Mjkz6
	MEMx40E2kIGYe4owlakH4dcY4/ESOMhLtevPcog53QBqo+lOfYchFBdwsaXibVhpx3GZs135R2E
	6iAMaiQ9FnXRmuQhXepNkremOmepRD5nQsoIydQKoz+Zh0wOsGVNVJ8md/EUWCklq4d79+9j87i
	+FkG5xnASf2M0tZO/vh7wRFHn3jfVPRhhjga6HZITMiXwCbZmc0qmNV8LvmkkjMZw==
X-Google-Smtp-Source: AGHT+IFFGVIe54/9DZeIqUp3Yxi/SWdwT0OXk8nXYILde9pPc/6+MQvVkAIL5ihbJ5IDR7jAkvnAhlCLpgVAgn7JRYE=
X-Received: by 2002:a05:600c:8718:b0:46e:3193:fecb with SMTP id
 5b1f17b1804b1-46e7114680dmr4060735e9.27.1759439163542; Thu, 02 Oct 2025
 14:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251002155210.782342-1-yoann.congal@smile.fr> <CANNYZj8RicOLzYbtQ6anggqiMkQMDJ=REBztppNa3CP6dLOkcw@mail.gmail.com>
In-Reply-To: <CANNYZj8RicOLzYbtQ6anggqiMkQMDJ=REBztppNa3CP6dLOkcw@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 2 Oct 2025 23:05:37 +0200
X-Gm-Features: AS18NWCRsLiN_I4UUIEIlxjc1Zysv8wAFl2jDcoalh-tN-4ys4ls5t_6nSF0MgU
Message-ID: <CAMSfU+52JC1=3q=G=eEjoh4rGtAKJO590tOYw8sLEgpqUOMRTw@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: optionally support
 JSON5 (e.g. comments) format
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000058df390640335aa3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 21:06:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18126

--00000000000058df390640335aa3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 2 oct. 2025 =C3=A0 18:22, Alexander Kanavin <alex.kanavin@gmail.com=
> a
=C3=A9crit :

> On Thu, 2 Oct 2025 at 17:52, Yoann Congal via lists.openembedded.org
> <yoann.congal=3Dsmile.fr@lists.openembedded.org> wrote:
>
> > +                        ],
> > +                    },
> > +                },
> > +            },
> > +        ],
> > +    },
>
> I don't know Yoann, these still need to be perfectly balanced and
> they're still visual clutter (admittedly not as bad as xml was), which
> is what yaml frees one from.
>

Yes, I agree with you on JSON visual clutter.

I pushed JSON5 to not stray too far from the python-stdlib-supported
default JSON.

But, thinking about it, we could use the "install an extra module to read
better but incompatible config format" idea to switch to YAML. Should I
send another RFC patch to see what that looks like?

Another idea I heard was to support a plugin mechanism in bb-setup to let
everyone implement their own format but that sounds like a maintenance
nightmare.


> What's the particular need for comments? You said someone else wanted
> them, what did they say?
>

They said nothing in particular but here is how I would use them (same need
as comment in code) :
* provide documentation (in the case the "description" field is not enough)=
,
* giving the intent of the author,
* // TODO: ...,
* "temporarily" commented code blocks,
* a licence for the file,
* a small tutorial on how to use the config (should be in the README next
to it though)


>
> Alex
>


--=20
Yoann Congal
Smile ECS

--00000000000058df390640335aa3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 2 oct. =
2025 =C3=A0=C2=A018:22, Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavi=
n@gmail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=
=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, =
2 Oct 2025 at 17:52, Yoann Congal via <a href=3D"http://lists.openembedded.=
org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a><br>
&lt;yoann.congal=3D<a href=3D"mailto:smile.fr@lists.openembedded.org" targe=
t=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; +=C2=A0 =C2=A0 },<br>
<br>
I don&#39;t know Yoann, these still need to be perfectly balanced and<br>
they&#39;re still visual clutter (admittedly not as bad as xml was), which<=
br>
is what yaml frees one from.<br></blockquote><div><br></div><div>Yes, I agr=
ee with you on JSON visual clutter.</div><div><br></div><div>I pushed JSON5=
 to not stray too far=C2=A0from the python-stdlib-supported default JSON.</=
div><div><br></div><div>But, thinking about it, we could use the &quot;inst=
all an extra module to read better but incompatible config format&quot; ide=
a to switch to YAML. Should I send another RFC patch to see what that looks=
 like?</div><div><br></div><div>Another idea I heard was to support a plugi=
n mechanism in bb-setup to let everyone implement their own format but that=
 sounds like a maintenance nightmare.=C2=A0</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
What&#39;s the particular need for comments? You said someone else wanted<b=
r>
them, what did they say?<br></blockquote><br></div><div class=3D"gmail_quot=
e">They said nothing in particular but here is how I would use them (same n=
eed as comment in code) :</div><div class=3D"gmail_quote">* provide documen=
tation (in the case the &quot;description&quot; field is not enough),</div>=
<div class=3D"gmail_quote">* giving the intent of the author,</div><div cla=
ss=3D"gmail_quote">* // TODO: ...,</div><div class=3D"gmail_quote">* &quot;=
temporarily&quot; commented code blocks,</div><div class=3D"gmail_quote">* =
a licence for the file,</div><div class=3D"gmail_quote">* a small tutorial =
on how to use the config (should be in the README next to it though)<div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</div>

--00000000000058df390640335aa3--

