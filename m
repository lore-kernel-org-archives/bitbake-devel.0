Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB49C433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 17:37:56 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.1703.1636393074633197746
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 09:37:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=o9WcMd7c;
 spf=pass (domain: gmail.com, ip: 209.85.208.42,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f42.google.com with SMTP id x15so34486880edv.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c6prMmuqUg5k4p7rvyQihHUk23i4PyKVh2VkcbZvAWU=;
        b=o9WcMd7c8DHJvEzZjx++tvyaGLuLrBLIKyB1ejhZD6EBjjMdJdkiMhYd8QeMgmZzUZ
         JXx8dIaO3C6tO87JJCgChqGqUga74qrexDH97537Ca1KtWceFu76G7YI9YTlSl7SIAOL
         p+T8qjvcT7xztQGS/ACJV40Qdf8eJx35HY05L2dRiI4AQn8z8Cig1uBgfmFrloCkTrV6
         y9wBa+vtNiV2DaxJcjSsd18Vx2qUFcCVDVxBetJcN336wLsHGN/xQqTNEc2N3saLbIab
         RDvrRYEoE83OSil0XE2bX/bYEhRgXW2SIDpZeb256A+JarPdZpKWyWdOcDzBD67WhMYR
         92MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c6prMmuqUg5k4p7rvyQihHUk23i4PyKVh2VkcbZvAWU=;
        b=eXrpbXRqPQQKSZm/qNxETFGWcsmGCXCsRE7UskCXZ/jA39VTZu11Gko3Ika7IbmuNf
         YvoPEuo1yCDlYcLP4Qx4jS1TcJemaDf/QzSJeoCzsn3Q5gjHA3LoiRx3hV4h/GFPNHkk
         z0Di3FUUsROKJbZcD4fhvjVID9Z6Btkwy0SfXJN61RqJxJlDd6HI98+FPrBGmAq0eQeH
         N2RnRGzrQ6OgehBDZg6HdVWsFsv9hITjNnGxztsl/+55ybbR+LhCk9qh7UKJR2ZmMFST
         hvyL93aHoxqWK+k21+5vBfpR71b63FxuCJkM1o1kCM31quotdAd3pLakNKcdlgFIXnkR
         z1kA==
X-Gm-Message-State: AOAM53397zl+0ENl9pA+wEE9o1onYHq4gTMpzT4tvbHH2giEhN4HnrBu
	bupGMhvFeh2OWDDbuxXv4OyvVdzHw0lG1T9JWjY9hJZr
X-Google-Smtp-Source: 
 ABdhPJwLDI+AN/CaWbjtl1ip/lepsGBOesQezA5v2Vmnx8hIGa8H0Az8eTUaw/N2UaulHkvlIdPTNx7s3Fye72nce54=
X-Received: by 2002:a05:6402:d09:: with SMTP id
 eb9mr1047206edb.69.1636393073179;
 Mon, 08 Nov 2021 09:37:53 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
In-Reply-To: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Mon, 8 Nov 2021 18:37:42 +0100
Message-ID: 
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
Subject: Fwd: bitbake style/workflow
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d6fe4305d04a73bf"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 17:37:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12946

--000000000000d6fe4305d04a73bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey there,

Is there a plan to switch to some more modern ways to collaborate on
bitbake, you know, like, gitlab/github/gitea with issues, PRs and so forth?
I mean=E2=80=A6 it=E2=80=99s late 2021 and sending MRs/Issues via email fee=
ls reaaaally
outdated, slow, intransparent, ineffective (how to you do reviews, code
comparisons during reviews, insert suggestions, etc.) and indirect (where
is the CI pipeline that I trigger when pushing something somewhere?). I
threw a search engine at =E2=80=98yocto bitbake CI=E2=80=99 (and similar) b=
ut didn=E2=80=99t find
it. I=E2=80=99m 110 % sure that there is a CI pipeline but it would make
contributions, reviews, etc. so much more efficient if I as the
(hypothetical) contributor would see the outcome of just a linter*. Maybe
it=E2=80=99s somewhere documented where the CI is hosted but then: No other=
 project
I contribute to needs documentation about these things. They are just there
and obvious.

Don=E2=80=99t get me wrong: bitbake is awesome. I=E2=80=99d just love to co=
ntribute but the
burden for collaboration here is not really up to date. So, is there a
strategy to improve the on-boarding and workflow?

Greetings
Marius


* side-note on bitbake style/linting: It=E2=80=99s violating PEP8 in a coup=
le of
ways and TBH PEP8 is the bare minimum I would accept these days for
collaboration on projects the dimension of bitbake. So an additional
question: Would you be up for a PEP8 compatibility overhaul of the source
code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a patch via ema=
il ;)

--000000000000d6fe4305d04a73bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><span style=3D=
"color:rgb(0,0,0)"><span style=3D"font-family:Helvetica;font-size:12px;font=
-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;text-decoration:none;display:inline;float:none">Hey ther=
e,</span><br style=3D"font-family:Helvetica;font-size:12px;font-style:norma=
l;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;text-decoration:none"><br style=3D"font-family:Helvetica;font-size:1=
2px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;text-decoration:none"><span style=3D"font-family=
:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-w=
eight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;text-decoration:none;displ=
ay:inline;float:none">Is there a plan to switch to some more modern ways to=
 collaborate on bitbake, you know, like, gitlab/github/gitea with issues, P=
Rs and so forth? I mean=E2=80=A6 it=E2=80=99s late 2021 and sending MRs/Iss=
ues via email feels reaaaally outdated, slow, intransparent, ineffective (h=
ow to you do reviews, code comparisons during reviews, insert suggestions, =
etc.) and indirect (where is the CI pipeline that I trigger when pushing so=
mething somewhere?). I threw a search engine at =E2=80=98yocto bitbake CI=
=E2=80=99 (and similar) but didn=E2=80=99t find it. I=E2=80=99m 110 % sure =
that there is a CI pipeline but it would make contributions, reviews, etc. =
so much more efficient if I as the (hypothetical) contributor would see the=
 outcome of just a linter*. Maybe it=E2=80=99s somewhere documented where t=
he CI is hosted but then: No other project I contribute to needs documentat=
ion about these things. They are just there and obvious.</span><br style=3D=
"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:n=
ormal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none"><br style=3D"font-family:Helvetica;font-size:12px;font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><span style=3D"font-family:Helvetica;font-size:=
12px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;text-decoration:none;display:inline;float:none"=
>Don=E2=80=99t get me wrong: bitbake is awesome. I=E2=80=99d just love to c=
ontribute but the burden for collaboration here is not really up to date. S=
o, is there a strategy to improve the on-boarding and workflow?</span><br s=
tyle=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant=
-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration:none"></span></div><div dir=3D"ltr"><span style=3D"color:rgb(0,0,0=
)"><br style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font=
-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;text-decoration:none"><span style=3D"font-family:Helvetica;font-size:12px;=
font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none;display:inline;float:none">Gree=
tings</span><br style=3D"font-family:Helvetica;font-size:12px;font-style:no=
rmal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;text-decoration:none"><span style=3D"font-family:Helvetica;font-s=
ize:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whit=
e-space:normal;word-spacing:0px;text-decoration:none;display:inline;float:n=
one">Marius</span><br style=3D"font-family:Helvetica;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;text-decoration:none"><br style=3D"font-family:Helvetica;fo=
nt-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;text-decoration:none"><br style=3D"font=
-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal=
;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;text-decoration:non=
e"><span style=3D"font-family:Helvetica;font-size:12px;font-style:normal;fo=
nt-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;text-decoration:none;display:inline;float:none">* side-note on bitbake s=
tyle/linting: It=E2=80=99s violating PEP8 in a couple of ways and TBH PEP8 =
is the bare minimum I would accept these days for collaboration on projects=
 the dimension of bitbake. So an additional question: Would you be up for a=
 PEP8 compatibility overhaul of the source code? I=E2=80=99d volunteer if I=
 don=E2=80=99t have to send a patch via email ;)</span><br style=3D"font-fa=
mily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;fo=
nt-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;text-decoration:none">=
</span></div><div><span style=3D"color:rgb(0,0,0)"><br style=3D"font-family=
:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-w=
eight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;text-decoration:none"></sp=
an></div><div dir=3D"ltr"><span style=3D"color:rgb(0,0,0)"><br></span></div=
>
</div></div>

--000000000000d6fe4305d04a73bf--

