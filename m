Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D37C761A6
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 13:57:55 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.158972.1680789473739662347
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 06:57:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=T9jeBdRN;
 spf=pass (domain: gmail.com, ip: 209.85.208.176, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id y7so8364858ljp.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680789472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TumWG9YHVdDW40gyDVUQaruR6jZpQH5glA5FcWV1/V4=;
        b=T9jeBdRNQm+zJLJdbjH8DKJrtN7v2Tv6wX9aL0x2Hcc1hKoO0xx2ihj9Wkki3A0WOx
         m1mFVlv7+vbZdwy/YHDSRG32Y/1PFL+FzKxHmPTfK7bLwJXl0yov54Fj0+tecxPExgVn
         5QYaL0UObvU2WZODZVOHOMusXfuNkjDcoriPkUt8nNTr/iT/P2EKIZwClHjE6Wt9Ikp9
         AW+w0AAdj4NJ0+yNp8+xLgSKBjLZ8DH4u9CkhDWTb0OKlJBWDDUvEOiLQkO6W82rXUwr
         sgX/HokwV2j7LZXKUjYuCAkmJfKuurp3rbyyy9O7tz15YOdyEzCXPB/6GAkiAsDaibKr
         yFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TumWG9YHVdDW40gyDVUQaruR6jZpQH5glA5FcWV1/V4=;
        b=3sxA7Wj81i3AFupKcJyGJbRMcJHDpj4H9stpgsg8akop8HfgB17IwMED+L0o5kj9iw
         qasj17uUxVL0du0xDakcDvnNc0Qe0CL/fxERUhvOgpH+DF59m1F/eslFjZ9nHtc3l3N6
         t2gViKFm3C2vz6Xq4cJSSqOgxnvwdS++LtZOqjS2MoyOgauyGxJ6C0iSrTfwGlMuylvj
         ktFpJKzIIL9uD4WeZS7NkG23Zun2S6NtPzVfb+HRWcZsVMF/7i2Oj6w8gNTd/IfAbc96
         iAhvhLNZG7RmYSKVfZoLQEG1wx4NT/mhMh2sk4qkJmWIFTAzlELAVew+bbY674FFVnD7
         SNOg==
X-Gm-Message-State: AAQBX9ctFqncwk9FlIoW1z/R1ZzF+A5nJUylH7F8MtW9Sh6ILORyNOSX
	RTsIi8+U0+loz4ll/OE8LjfG4peqnZekX8k2/p8=
X-Google-Smtp-Source: AKy350Z90LZfXHMbObx9+qytp6Tqfo6O0CHpo4rkoij7Wnq/ubTcom2J+aI5ibcUsgx1CzwP5Oe0LMcLYSC236ZTAiw=
X-Received: by 2002:a2e:9115:0:b0:298:b32c:e4f9 with SMTP id
 m21-20020a2e9115000000b00298b32ce4f9mr3500544ljg.3.1680789471504; Thu, 06 Apr
 2023 06:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de> <17530ADB1695B5D1.3977@lists.openembedded.org>
 <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
 <ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
 <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
 <ly4jptcnwi.fsf@ensc-pc.intern.sigma-chemnitz.de> <ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
 <CA+cAkeqh2HiHQ8nOKhSUgYgddUxso3gU93ipKazmhnNPQ+nqWw@mail.gmail.com> <26b296edba075149fb2e4653887ff18f1a41509b.camel@linuxfoundation.org>
In-Reply-To: <26b296edba075149fb2e4653887ff18f1a41509b.camel@linuxfoundation.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 6 Apr 2023 15:57:40 +0200
Message-ID: <CA+cAkeop_=dsPOF+=xkXG1jg+9ommvQr83huEO2LymSB8XXesQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name' entries
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000642c2605f8ab4bd1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 13:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14674

--000000000000642c2605f8ab4bd1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 6 avr. 2023, 15:44, Richard Purdie <
richard.purdie@linuxfoundation.org> a =C3=A9crit :

> On Thu, 2023-04-06 at 15:00 +0200, Fr=C3=A9d=C3=A9ric Martinsons wrote:
> > Oh my, I see a lot of patches going around at the moment, sorry for
> > the trouble, I didn't expect the changes I made would be so soon in a
> > release
>
> In hindsight I probably shouldn't have taken things so close to the
> release but there are pros and cons to taking or not taking. I thought
> things were sorted out and it turned out they weren't quite done.
>
> I suspect we'd not have had some of the feedback had I not merged them.
>
> I've merged a few changes so hopefully this resolves things for bitbake
> and OE-Core. The other layers should be able to work things out from
> there.
>
> Cheers,
>
> Richard
>

Hope so too.

>

--000000000000642c2605f8ab4bd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le jeu. 6 avr. 2023, 15:44, Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Thu, 2023-04-06 at 15:00 +0200, Fr=C3=A9d=C3=A9ric Martinsons wrote:<br>
&gt; Oh my, I see a lot of patches going around at the moment, sorry for<br=
>
&gt; the trouble, I didn&#39;t expect the changes I made would be so soon i=
n a<br>
&gt; release=C2=A0<br>
<br>
In hindsight I probably shouldn&#39;t have taken things so close to the<br>
release but there are pros and cons to taking or not taking. I thought<br>
things were sorted out and it turned out they weren&#39;t quite done.<br>
<br>
I suspect we&#39;d not have had some of the feedback had I not merged them.=
<br>
<br>
I&#39;ve merged a few changes so hopefully this resolves things for bitbake=
<br>
and OE-Core. The other layers should be able to work things out from<br>
there.<br>
<br>
Cheers,<br>
<br>
Richard<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Hope so too.=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000642c2605f8ab4bd1--

