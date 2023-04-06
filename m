Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF30BC76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 14:46:55 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.160245.1680792414514680166
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 07:46:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Vsypn2O6;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id e9so25662109ljq.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680792413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9esqxvMFdsUU7XXDZ2hc+q/YMdX0F2+Pz6J1HnY0ccw=;
        b=Vsypn2O6hJV0T9NOIlVdFm5uXyrNcg9CZtLevcQL4RREECmmzh3w7ZgMCylEsLS1zY
         ztM8FWkfa6a9MwVSRepXGivlnRZ2Sc1nnjSpaHeI+EZugpCg9H1Pkqx4ak78KDaAlRlt
         45tIcTc13uA09mJlH34xh+cgr1Hvs/I/7Td05zSYewiO3QwxSf5zwaTKQ2eLOPmjpKAN
         fPLceXk6kRIu7Lafhykeg1N2MVkuGLwCJyBf7vH24Q1wR6Rf6su68Pxk854ex1bYteav
         829R1lR2ABwNyRcYMzEeZDKJFEYBJHGt7qYWroqbr5ul0tQ4c5fOBhWjtJiTsSd0GCJ2
         t+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9esqxvMFdsUU7XXDZ2hc+q/YMdX0F2+Pz6J1HnY0ccw=;
        b=iF3KoxcggHsxU+1q/z/M1TK86+bEbPf6gV8Ck1MtFusRvEYuQSLjRQdsc8t/RNMa5W
         uiQ1ydYT4i9Jc1dYsK9TlrCWAOOxt6EOwJMfBveyf8W+pNL6yOa/59tpoDdrTqPNedS9
         F0RoLPXFBxvbXnb0r1Km/s5aTVs/nBMZPC4WJUUJ/zALE0YS0Wc1pwLgNylpbs7U5Rmi
         JeBPd6W7qwvYk+eYGwy8pTrm8rp98gtHhwCzFFM2dMkcpY7ZWXjC3SHw0L1A3vAuVpbz
         E3LdVIkMZo0px471s1N6N3p9sXAZAbgOgayIAJIYGcVwu0ivn9qI7ck43OIGBDdcOow3
         AY9A==
X-Gm-Message-State: AAQBX9d9JNGL+2uy0yjHMBdyxIR2fdSKxL4LElSdqqZYQXrnM7QcPctJ
	PuFIXO8mwDzJ/oOQSBM5qxGlVUS1ne5FMdZg6kI=
X-Google-Smtp-Source: AKy350Zg6iXiDRlWh57QMCaYF3GINzr7lAtxEOt32QSviOfm1XcOoZ4MFxBp5Wy1HGC2ENakqeT7JZPLTwvkL13l5HE=
X-Received: by 2002:a2e:9093:0:b0:29b:d21c:e859 with SMTP id
 l19-20020a2e9093000000b0029bd21ce859mr3451908ljg.3.1680792412485; Thu, 06 Apr
 2023 07:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de> <17530ADB1695B5D1.3977@lists.openembedded.org>
 <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
 <ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
 <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
 <ly4jptcnwi.fsf@ensc-pc.intern.sigma-chemnitz.de> <ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
 <lyfs9daybt.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
In-Reply-To: <lyfs9daybt.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 6 Apr 2023 16:46:41 +0200
Message-ID: <CA+cAkery8jbYQOaGbCWu6LVqGzfGap=yOpLmUowR1wHfhECa-g@mail.gmail.com>
Subject: Re: ';sha256sum=' attribute in SRC_URI (was: [bitbake-devel] [PATCH]
 fetch:crate: create versioned 'name' entries)
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000affc6705f8abfa6b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 14:46:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14677

--000000000000affc6705f8abfa6b
Content-Type: text/plain; charset="UTF-8"

Maybe it missed something in crate fetcher but, providing this fetcher
inherits wget one, and if wget supports this attribute, so should crate
fetcher do.

I quickly look into differents recipe of oe-core, meta-oe, meta-security
etc and I don't
see a SRC_URI which uses sha256sum inline attribute, so it may not be
correctly parsed.

On Thu, 6 Apr 2023 at 16:18, Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
wrote:

> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>
> > Now I've been looking more closely at this, I did start to wonder if we
> > shouldn't just put ;sha256sum=XXX parameters onto the crate urls we
> > generate though? If we do that, we don't need to name them at all.
>
> I just tested this with
>
> SRC_URI += " \
>     crate://
> crates.io/addr2line/0.19.0;sha256sum=a76fd60b23679b7d19bd066031410fb7e458ccc5e958eb5c325888ce4baedc97
> \
>     crate://
> crates.io/adler/1.0.2;adler-1.0.2.sha256sum=f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe
> \
> "
>
> and got
>
> | do_fetch: Missing SRC_URI checksum, please add those to the recipe:
> | SRC_URI[addr2line-0.19.0.sha256sum] =
> "a76fd60b23679b7d19bd066031410fb7e458ccc5e958eb5c325888ce4baedc97"
>
>
> It seems that ';sha256sum' does not suffice but that you have to dup the
> 'name'.
>
>
>
> Enrico
>

--000000000000affc6705f8abfa6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Maybe it missed something in crate fetcher but, providing =
this fetcher=C2=A0<div>inherits wget one, and if wget supports this attribu=
te, so should crate fetcher do.</div><div><br></div><div>I quickly look int=
o differents recipe of oe-core, meta-oe, meta-security etc and I don&#39;t<=
/div><div>see a SRC_URI which uses sha256sum inline attribute, so it may no=
t be correctly parsed.</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, 6 Apr 2023 at 16:18, Enrico Scholz &l=
t;<a href=3D"mailto:enrico.scholz@sigma-chemnitz.de">enrico.scholz@sigma-ch=
emnitz.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundat=
ion.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; write=
s:<br>
<br>
&gt; Now I&#39;ve been looking more closely at this, I did start to wonder =
if we<br>
&gt; shouldn&#39;t just put ;sha256sum=3DXXX parameters onto the crate urls=
 we<br>
&gt; generate though? If we do that, we don&#39;t need to name them at all.=
<br>
<br>
I just tested this with<br>
<br>
SRC_URI +=3D &quot; \<br>
=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/addr2line/0.19.0;sha256su=
m=3Da76fd60b23679b7d19bd066031410fb7e458ccc5e958eb5c325888ce4baedc97" rel=
=3D"noreferrer" target=3D"_blank">crates.io/addr2line/0.19.0;sha256sum=3Da7=
6fd60b23679b7d19bd066031410fb7e458ccc5e958eb5c325888ce4baedc97</a> \<br>
=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/adler/1.0.2;adler-1.0.2.s=
ha256sum=3Df26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe=
" rel=3D"noreferrer" target=3D"_blank">crates.io/adler/1.0.2;adler-1.0.2.sh=
a256sum=3Df26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe<=
/a> \<br>
&quot;<br>
<br>
and got<br>
<br>
| do_fetch: Missing SRC_URI checksum, please add those to the recipe: <br>
| SRC_URI[addr2line-0.19.0.sha256sum] =3D &quot;a76fd60b23679b7d19bd0660314=
10fb7e458ccc5e958eb5c325888ce4baedc97&quot;<br>
<br>
<br>
It seems that &#39;;sha256sum&#39; does not suffice but that you have to du=
p the<br>
&#39;name&#39;.<br>
<br>
<br>
<br>
Enrico<br>
</blockquote></div>

--000000000000affc6705f8abfa6b--

