Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A2EC433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 17:47:37 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.1756.1636393656598448857
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 09:47:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=a8n1zVOj;
 spf=pass (domain: gmail.com, ip: 209.85.208.44,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id ee33so66128708edb.8
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 09:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cHHsiqa//jvnFvl/j8hwyuDcy0vBLPxEHSqktFLgXKs=;
        b=a8n1zVOj6hchGvAOmBlew81N1Ie68TncvqfCF1PBSGn1XNjABZrCv0k0pC8XESCfNN
         B7t+ZxOapMPY3aVzMvAdr09K95laSwsvyGn4vGaPtxkSVPpPgiizIERp5XIUQ7C9P2CC
         E+VWaBLPv2r/DCfud3iFFOOF33pSip0MTUhRA9yx77EfUzIRyJ0SW3umzlOdrYe5ImUJ
         b59gFhHukr+I9rEFV9rfWvxu4cCVSaTWaFiQCTLWruE80fqpAY5Sz3xKjOvhlkM7OV28
         OsB69oHokS/tiux29YO6+GV3ACA7xzq5aVxXKXvp+cgj1VrLsJVIq+LSy2ts1vG/fqe1
         a74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cHHsiqa//jvnFvl/j8hwyuDcy0vBLPxEHSqktFLgXKs=;
        b=rBRL+LmBaV/1S6m6IXsqnp5U6Jro4LFK0lmcnzkYTTdhLtiyVSqswZ1E96wDGKZD14
         ChiQQmyh3Ca5ls5wCe8x0d3S7YPrwgUb5QnxZLkyLrXn00DQm0biR4e2fUH0fylfZbUl
         jD8hzDmP3zCRqNb5tGQLJaeUCav/ClAcETA6FOd6An2V0HrFk5b2clPVQCo7urnXU1LO
         ID6L6DlIxLt0aB/UpkklpOfTaTJeb3BXWYQO0gTELqxiQjyTOvQxE2lnR5T3ftXZ9B8G
         cJNTLCbItCo7/8Ho0LRoUNvkNzRTePGN3Jyb3Rhnz9MDo5flhQyWbJaBt4+AwUNlE996
         yKPg==
X-Gm-Message-State: AOAM532422tOdy1A7nCE3/kEl9orK1sOlUGG3V/+OiSEbcTx9bA2Y0vO
	j79jd+4mSfbH/0pW33afhsRyaPe/ghmHzzXFM2j3R8S8jF4=
X-Google-Smtp-Source: 
 ABdhPJxy6AjxGloCRnM8JNJcCE3sqHkJ51kOnDDm47azx2hNLJpKAtXGnGFOpc9bwRWz7kirvSENP6iiHnhqA/D4eKM=
X-Received: by 2002:a17:906:ce2a:: with SMTP id
 sd10mr1312161ejb.154.1636393654538;
 Mon, 08 Nov 2021 09:47:34 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <16B5A2D4F6DF9F42.26193@lists.openembedded.org>
In-Reply-To: <16B5A2D4F6DF9F42.26193@lists.openembedded.org>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Mon, 8 Nov 2021 18:47:23 +0100
Message-ID: 
 <CAMaS9hMuG1c2gW66L5sP9BMk07ReuWpnrDJP2xi9VQvS+XFTug@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007dd69a05d04a963c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 17:47:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12947

--0000000000007dd69a05d04a963c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

okay, I don't know why I didn't come here ->
https://github.com/openembedded/bitbake <- directly. Maybe I was misguided
by some remnant documentation roaming on the internet?! I don't know...



Am Mo., 8. Nov. 2021 um 18:37 Uhr schrieb Marius Kriegerowski via
lists.openembedded.org <marius.kriegerowski=3Dgmail.com@lists.openembedded.=
org
>:

> Hey there,
>
> Is there a plan to switch to some more modern ways to collaborate on
> bitbake, you know, like, gitlab/github/gitea with issues, PRs and so fort=
h?
> I mean=E2=80=A6 it=E2=80=99s late 2021 and sending MRs/Issues via email f=
eels reaaaally
> outdated, slow, intransparent, ineffective (how to you do reviews, code
> comparisons during reviews, insert suggestions, etc.) and indirect (where
> is the CI pipeline that I trigger when pushing something somewhere?). I
> threw a search engine at =E2=80=98yocto bitbake CI=E2=80=99 (and similar)=
 but didn=E2=80=99t find
> it. I=E2=80=99m 110 % sure that there is a CI pipeline but it would make
> contributions, reviews, etc. so much more efficient if I as the
> (hypothetical) contributor would see the outcome of just a linter*. Maybe
> it=E2=80=99s somewhere documented where the CI is hosted but then: No oth=
er project
> I contribute to needs documentation about these things. They are just the=
re
> and obvious.
>
> Don=E2=80=99t get me wrong: bitbake is awesome. I=E2=80=99d just love to =
contribute but
> the burden for collaboration here is not really up to date. So, is there =
a
> strategy to improve the on-boarding and workflow?
>
> Greetings
> Marius
>
>
> * side-note on bitbake style/linting: It=E2=80=99s violating PEP8 in a co=
uple of
> ways and TBH PEP8 is the bare minimum I would accept these days for
> collaboration on projects the dimension of bitbake. So an additional
> question: Would you be up for a PEP8 compatibility overhaul of the source
> code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a patch via e=
mail ;)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12946):
> https://lists.openembedded.org/g/bitbake-devel/message/12946
> Mute This Topic: https://lists.openembedded.org/mt/86911583/6547911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> marius.kriegerowski@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000007dd69a05d04a963c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>okay, I don&#39;t know why I didn&#39;t come here -&g=
t; <a href=3D"https://github.com/openembedded/bitbake">https://github.com/o=
penembedded/bitbake</a> &lt;- directly. Maybe I was misguided by some remna=
nt documentation roaming on the internet?! I don&#39;t know... <br></div><d=
iv><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Am Mo., 8. Nov. 2021 um 18:37=C2=A0Uhr schrie=
b Marius Kriegerowski via <a href=3D"http://lists.openembedded.org">lists.o=
penembedded.org</a> &lt;marius.kriegerowski=3D<a href=3D"mailto:gmail.com@l=
ists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div clas=
s=3D"gmail_quote"><div dir=3D"ltr"><span style=3D"color:rgb(0,0,0)"><span s=
tyle=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant=
-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration:none;display:inline;float:none">Hey there,</span><br style=3D"font=
-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal=
;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;text-decoration:non=
e"><br style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font=
-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;text-decoration:none"><span style=3D"font-family:Helvetica;font-size:12px;=
font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none;display:inline;float:none">Is t=
here a plan to switch to some more modern ways to collaborate on bitbake, y=
ou know, like, gitlab/github/gitea with issues, PRs and so forth? I mean=E2=
=80=A6 it=E2=80=99s late 2021 and sending MRs/Issues via email feels reaaaa=
lly outdated, slow, intransparent, ineffective (how to you do reviews, code=
 comparisons during reviews, insert suggestions, etc.) and indirect (where =
is the CI pipeline that I trigger when pushing something somewhere?). I thr=
ew a search engine at =E2=80=98yocto bitbake CI=E2=80=99 (and similar) but =
didn=E2=80=99t find it. I=E2=80=99m 110 % sure that there is a CI pipeline =
but it would make contributions, reviews, etc. so much more efficient if I =
as the (hypothetical) contributor would see the outcome of just a linter*. =
Maybe it=E2=80=99s somewhere documented where the CI is hosted but then: No=
 other project I contribute to needs documentation about these things. They=
 are just there and obvious.</span><br style=3D"font-family:Helvetica;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;text-decoration:none"><br style=3D"font-fa=
mily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;fo=
nt-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;text-decoration:none">=
<span style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none;display:inline;float:none">Don=E2=80=99t get me wrong:=
 bitbake is awesome. I=E2=80=99d just love to contribute but the burden for=
 collaboration here is not really up to date. So, is there a strategy to im=
prove the on-boarding and workflow?</span><br style=3D"font-family:Helvetic=
a;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:nor=
mal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;text-decoration:none"></span></div>=
<div dir=3D"ltr"><span style=3D"color:rgb(0,0,0)"><br style=3D"font-family:=
Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-we=
ight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;text-decoration:none"><span=
 style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-varia=
nt-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;display:inline;float:none">Greetings</span><br style=3D"fon=
t-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norma=
l;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:no=
ne"><span style=3D"font-family:Helvetica;font-size:12px;font-style:normal;f=
ont-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;text-decoration:none;display:inline;float:none">Marius</span><br style=
=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none"><br style=3D"font-family:Helvetica;font-size:12px;font-style:nor=
mal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;text-decoration:none"><br style=3D"font-family:Helvetica;font-size=
:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;text-decoration:none"><span style=3D"font-fami=
ly:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font=
-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;text-decoration:none;dis=
play:inline;float:none">* side-note on bitbake style/linting: It=E2=80=99s =
violating PEP8 in a couple of ways and TBH PEP8 is the bare minimum I would=
 accept these days for collaboration on projects the dimension of bitbake. =
So an additional question: Would you be up for a PEP8 compatibility overhau=
l of the source code? I=E2=80=99d volunteer if I don=E2=80=99t have to send=
 a patch via email ;)</span><br style=3D"font-family:Helvetica;font-size:12=
px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;text-decoration:none"></span></div><div><span sty=
le=3D"color:rgb(0,0,0)"><br style=3D"font-family:Helvetica;font-size:12px;f=
ont-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;text-decoration:none"></span></div><div dir=3D"ltr"><=
span style=3D"color:rgb(0,0,0)"><br></span></div>
</div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12946): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12946" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12946</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86911583/6547=
911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86911583/6547911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:marius.kriegerowski@gmail.com" tar=
get=3D"_blank">marius.kriegerowski@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000007dd69a05d04a963c--

