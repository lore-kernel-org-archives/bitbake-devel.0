Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2EDD12663
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 17:54:01 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2244.1764698040017609107
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 09:54:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Hyuq+p8G;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so38381165e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764698038; x=1765302838; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyAodCjAK0l5MJl5WFAczreQ14CRBxtS+6stSjNZ5DY=;
        b=Hyuq+p8GO1AsWvdMTwPFU3wBfBTka3tmVy7KfkHmInm2BM6GXONnZLevlfWvLQDHUe
         UOdbpk5ZWcPU7PKeIfo7qUrafcJQRG3/WFCjaW9ORQntsNxHyeJGW0k3u+HSd1lM5X+v
         e8uK+Nb5xybYF9OmRgT9Gsq6sX529B11HcVrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698038; x=1765302838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyAodCjAK0l5MJl5WFAczreQ14CRBxtS+6stSjNZ5DY=;
        b=ebIAZzYaHtdOFOPdOgOCI/QPzYg4SPcnbdqFcBmDJIlrbkfmpMgni+pwCEdQTWsFdD
         TDn31F1pGqehNtQ3EISajrPVzi/lN2zthShQscDgK0cdhxcka7m/t6wxXjdbKPXGRjAh
         b0NKi5QyMvHKH6T0xFt7yyeElr4zLGEgKW4WPRriyQJZhCfXPWLDyCRz9wTw/Ui01iGL
         4bNH9RgKw0T3UW1auJI/EZsYTDUMOQHzeSSAPZ3S/4yED2H9idSK48GEPNyCqF0DbWCF
         T9jcPw+aOphkjglVrfpurvRP1htfu04YqPDTPMgOKfGHaZajJXvC6eBr3FP95mJXVW61
         yg4g==
X-Forwarded-Encrypted: i=1; AJvYcCXT2e0URC+ep0gLMoi7JpYVi00sXoAsHn9OKOak8udWIVj5IkOeZNiocaXC5Qkn5J3kGnqv3PQwUF7imivo@lists.openembedded.org
X-Gm-Message-State: AOJu0YwOmGrfUlXcxXPgdzBw4XVbXcXmmpFpxCeRJHRPu/hgM5IvkgbM
	UatYb00VYBCYZKiz9zN57Dxv6eMUiFN5JNY1gBinrSLNUgGzXnD1/I88M8Vs3hLDLNVlmi4vB10
	yGk6+wnTO37v4+GNTnYo75Nm5e05bQEnvKOIMwwciwg==
X-Gm-Gg: ASbGncupIz64eWQodkNgCteiOTZFLFKMkv22sjEpqcp3giDW65gPjW+OShSeqiRV7I7
	XDcmMKxGUIvZl1IXIYbdBWlsHK7MOHVky6+Yjdf2tVyHYN/UqfE1CPNyQl+b15q7a+HI/cp3djq
	tBkDBDpUcFbAJBM+Gj07PLK1T2HB+Bu6qZY9qIdEFfCxlbr2SwCwHNsXGyu0F6q2hI3t3tmPf6D
	9bj8AIpS4g904bQkifhJwxovYQuUtN/wDpJMxA+Wc97Y9YVNiu05TldHdulU4ogXRWa6n5zak/m
	ZGzaXzo812UkkOOvzfE5DoqoxFNd
X-Google-Smtp-Source: AGHT+IFnci4qH0nmbZHQi6u3EOAOHzffDkoK1vbWtnND0si9sbFWWMlPdQMhm0RrNj7xsVroQw+hS8NOG8X5zx1sEMA=
X-Received: by 2002:a05:6000:3106:b0:429:c709:7b58 with SMTP id
 ffacd0b85a97d-42e0f358b03mr33699040f8f.50.1764698038307; Tue, 02 Dec 2025
 09:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20251202160402.819060-1-corentin.guillevic@smile.fr>
 <20251202160402.819060-2-corentin.guillevic@smile.fr> <CANNYZj-dNDhzchZU02w6-Q-CLkU2MiFaZ-z-=n7JxsmGdDsgxQ@mail.gmail.com>
In-Reply-To: <CANNYZj-dNDhzchZU02w6-Q-CLkU2MiFaZ-z-=n7JxsmGdDsgxQ@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 2 Dec 2025 18:53:31 +0100
X-Gm-Features: AWmQ_blvoEMe-sAMpYTpXKVpi3n0RBTHBuQoprs-WN_uFImOGqUj6_6m-g5YECE
Message-ID: <CAMSfU+6JeaWFAah4AH_N7Ewpzw8g-WCq=we4-kTVfaNF63MdaQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] layers.schema.json: support 'uri',
 make this and 'remotes' mutually exclusive
To: alex.kanavin@gmail.com
Cc: corentin.guillevic@smile.fr, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b59d8d0644fbc79a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 17:54:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18515

--000000000000b59d8d0644fbc79a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 2 d=C3=A9c. 2025 =C3=A0 17:13, Alexander Kanavin via lists.openembe=
dded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :

> On Tue, 2 Dec 2025 at 17:04, Corentin Guillevic via
> lists.openembedded.org
> <corentin.guillevic=3Dsmile.fr@lists.openembedded.org> wrote:
>  -                                }
> > +                                },
> > +                                "oneOf": [
> > +                                    {
> > +                                        "required": [
> > +                                            "uri"
> > +                                        ]
> > +                                    },
> > +                                    {
> > +                                        "required": [
> > +                                            "remotes"
> > +                                        ]
> > +                                    }
> > +                                ]
>
> I don't think it needs to be mutually exclusive. If both uri and
> remotes are present that's not an invalid combination.
>

That was to avoid weird behavior on "origin" being defined twice: once in
"uri" and once in remotes/origin.
How do you suggest to handle this case, throw an error?


>
> Alex.
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18510):
> https://lists.openembedded.org/g/bitbake-devel/message/18510
> Mute This Topic: https://lists.openembedded.org/mt/116578607/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--000000000000b59d8d0644fbc79a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mar. 2 =
d=C3=A9c. 2025 =C3=A0=C2=A017:13, Alexander Kanavin via <a href=3D"http://l=
ists.openembedded.org">lists.openembedded.org</a> &lt;alex.kanavin=3D<a hre=
f=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.=
org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Tue, 2 Dec 2025 at 17:04, Corentin Guillevic via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a><br>
&lt;corentin.guillevic=3D<a href=3D"mailto:smile.fr@lists.openembedded.org"=
 target=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
=C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;oneOf&quot;: [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;required&quot;: [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;uri&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;required&quot;: [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;remotes&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
<br>
I don&#39;t think it needs to be mutually exclusive. If both uri and<br>
remotes are present that&#39;s not an invalid combination.<br></blockquote>=
<div><br></div><div>That was to avoid weird behavior on &quot;origin&quot; =
being defined twice: once in &quot;uri&quot; and once in remotes/origin.</d=
iv><div>How do you suggest to handle this case, throw an error?</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex.<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18510): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18510" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18510</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/116578607/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/116578607/4316185</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_=
blank">yoann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000b59d8d0644fbc79a--

