Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7210FC76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 13:01:15 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.157612.1680786066206897662
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 06:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Htre2A3m;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id h25so50718191lfv.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680786064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHv5AZiMRbavSq30ZvBV5ayWOq8dy2lMP2n0WmyO++I=;
        b=Htre2A3mrF4MRCjTg9ActCJ0kbQoAo15PDLHpUAEZH2Q2KcqU8ggatmJZy0qEhxzaj
         n7SIoe9HT4hDgtXHO0T7V9oy9LjCRdY+YETYqSSQCGu7mdT+pnQgJdoHfrQ6KC7fl/UY
         A+WGj8OyNKYAMAh/9mKy4LPJjy67V3PprUbTNrq2LpfrU3lQNfznF4R0cBJPySk/AMHV
         6LPrbBD7ca74gd5XdBLoWkWpNWeIuf2HmCAGdKD8M8XzdPl5YA7AsDfc5LU/vn0z/LlU
         jGv9Z5KvBuDkTBSo1SGkn1yykiVg5rKj4nvNtHTYg3yywEdb9cXuWHzUNdB0Nevs5b3g
         8V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680786064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHv5AZiMRbavSq30ZvBV5ayWOq8dy2lMP2n0WmyO++I=;
        b=LqRzKA5/Jd0dRfy4ZY5I5CNxCjsfZCQdjbKEHWwuJZUqYrBwkSRN/+DRpLt9KqGXDA
         5kWxw6thYWWILQ3Fb6emh70Ts8y6f02tOmJR8txigADzIoBEN9DEhFCQZC7BZa0UBIH7
         +VSK9XzBogK7BcI40Tmc5qx4OQCKDRpCi01q2luRJl7q9KZ/rcKQKW93pw98yFKz78MD
         c5M5e1K5TWfPVwjtJQ9wBdIvPpegMbPd5jlGzts24MptbWNDM4lc9lDdb8nzAkJ4e1yS
         JB+OHJ0W2Y0B35aZ04MOJsgKNaSfyTzv95tsqAGHupTVhX075cEFFpW+WRyW/vsyni6y
         Z74Q==
X-Gm-Message-State: AAQBX9fvmT/X8GEZbRb29yrUYQnfHFGhT6KegQR11i2F1LcS3YCEXqYH
	Hf+CIlknuvmWOKgfjQ6batScRqVm1a4djliDS1s=
X-Google-Smtp-Source: AKy350arT6rInMP92bnSsGu1riRs46hjCDcHNyeyACbh32GKUlng29h+tVdO/wMVu/GExdtiG7mZPGL4QhT6IUkS0rI=
X-Received: by 2002:a19:5517:0:b0:4eb:2643:d202 with SMTP id
 n23-20020a195517000000b004eb2643d202mr3085442lfe.12.1680786063968; Thu, 06
 Apr 2023 06:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de> <17530ADB1695B5D1.3977@lists.openembedded.org>
 <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
 <ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
 <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
 <ly4jptcnwi.fsf@ensc-pc.intern.sigma-chemnitz.de> <ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
In-Reply-To: <ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 6 Apr 2023 15:00:52 +0200
Message-ID: <CA+cAkeqh2HiHQ8nOKhSUgYgddUxso3gU93ipKazmhnNPQ+nqWw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name' entries
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000049501405f8aa80c3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 13:01:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14672

--00000000000049501405f8aa80c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh my, I see a lot of patches going around at the moment, sorry for the
trouble, I didn't expect the changes I made would be so soon in a release

Le jeu. 6 avr. 2023, 14:14, Richard Purdie <
richard.purdie@linuxfoundation.org> a =C3=A9crit :

> On Thu, 2023-04-06 at 12:20 +0200, Enrico Scholz wrote:
> > Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> >
> > > > > It will break cargo related recipes which were created between
> > > > > 2023-03-16 and 2023-03-31.  Packages before this date do not
> > > > > contain sha256sum and after this date, they have an explicit
> > > > > 'name' (which matches the one generated by my patch).
> > > >
> > > > Ok, I guess these dates match my patches series, if I do things
> > > > rights, I handle all the recipes I know of (in meta-openembedded an=
d
> > > > openembedded-core at least)
> > >
> > > This now gives me a problem as rc1 for 4.2 built yesterday. I'm
> > > guessing we don't want a stable release series with one form for urls
> > > for six months and a different one in master?
> > >
> > > Does this mean I need to scrap rc1, merge this, wait for the recipe
> > > updates and then rebuild the release?
> >
> > To avoid breaking builds:
> >
> > 1. OE recipes without explicit ';name=3D' need to be updated; this can =
be
> >    done by 'bitbake -c update_crates'.  Afais, this affects only
> >
> >    | meta/recipes-devtools/python/python3-bcrypt_4.0.1.bb
> >    | meta/recipes-devtools/python/python3-cryptography_39.0.2.bb
> >
> >    and in oe-meta
> >
> >    | meta-oe/recipes-core/uutils-coreutils/uutils-coreutils_0.0.17.bb
> >    | meta-python/recipes-devtools/python/python3-pyruvate_1.1.2.bb
> >
> > 2. the patch can be applied to bitbake
> >
> > 3. [optionally] change cargo-update-recipe-crates.bbclass to remove the
> >    explicit (and now redundant) ';name=3D' from generated SRC_URI list.
> >    This can be done post-mickledore
>
> I've gone ahead and stopped rc1 since I know in the long run this issue
> is going to cause problems.
>
> Short term I'll merge this patch and the fixes needed to the oe-core
> recipes.
>
> Now I've been looking more closely at this, I did start to wonder if we
> shouldn't just put ;sha256sum=3DXXX parameters onto the crate urls we
> generate though? If we do that, we don't need to name them at all.
>
> That is something we could move to at a later date if it make sense so
> it is less important from a release standpoint.
>
> Cheers,
>
> Richard
>

--00000000000049501405f8aa80c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Oh my, I see a lot of patches going around at the moment,=
 sorry for the trouble, I didn&#39;t expect the changes I made would be so =
soon in a release=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">Le jeu. 6 avr. 2023, 14:14, Richard Purdie &lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfounda=
tion.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">On Thu, 2023-04-06 at 12:20 +0200, Enrico Scholz wrote:<br>
&gt; Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.or=
g" target=3D"_blank" rel=3D"noreferrer">richard.purdie@linuxfoundation.org<=
/a>&gt; writes:<br>
&gt; <br>
&gt; &gt; &gt; &gt; It will break cargo related recipes which were created =
between<br>
&gt; &gt; &gt; &gt; 2023-03-16 and 2023-03-31.=C2=A0 Packages before this d=
ate do not<br>
&gt; &gt; &gt; &gt; contain sha256sum and after this date, they have an exp=
licit<br>
&gt; &gt; &gt; &gt; &#39;name&#39; (which matches the one generated by my p=
atch).<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Ok, I guess these dates match my patches series, if I do thi=
ngs<br>
&gt; &gt; &gt; rights, I handle all the recipes I know of (in meta-openembe=
dded and<br>
&gt; &gt; &gt; openembedded-core at least)=C2=A0<br>
&gt; &gt; <br>
&gt; &gt; This now gives me a problem as rc1 for 4.2 built yesterday. I&#39=
;m<br>
&gt; &gt; guessing we don&#39;t want a stable release series with one form =
for urls<br>
&gt; &gt; for six months and a different one in master?<br>
&gt; &gt; <br>
&gt; &gt; Does this mean I need to scrap rc1, merge this, wait for the reci=
pe<br>
&gt; &gt; updates and then rebuild the release?<br>
&gt; <br>
&gt; To avoid breaking builds:<br>
&gt; <br>
&gt; 1. OE recipes without explicit &#39;;name=3D&#39; need to be updated; =
this can be<br>
&gt;=C2=A0 =C2=A0 done by &#39;bitbake -c update_crates&#39;.=C2=A0 Afais, =
this affects only<br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 | meta/recipes-devtools/python/<a href=3D"http://python3-=
bcrypt_4.0.1.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">python3-bc=
rypt_4.0.1.bb</a><br>
&gt;=C2=A0 =C2=A0 | meta/recipes-devtools/python/<a href=3D"http://python3-=
cryptography_39.0.2.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">pyt=
hon3-cryptography_39.0.2.bb</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 and in oe-meta<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 | meta-oe/recipes-core/uutils-coreutils/<a href=3D"http:/=
/uutils-coreutils_0.0.17.bb" rel=3D"noreferrer noreferrer" target=3D"_blank=
">uutils-coreutils_0.0.17.bb</a><br>
&gt;=C2=A0 =C2=A0 | meta-python/recipes-devtools/python/<a href=3D"http://p=
ython3-pyruvate_1.1.2.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">p=
ython3-pyruvate_1.1.2.bb</a><br>
&gt; <br>
&gt; 2. the patch can be applied to bitbake<br>
&gt; <br>
&gt; 3. [optionally] change cargo-update-recipe-crates.bbclass to remove th=
e<br>
&gt;=C2=A0 =C2=A0 explicit (and now redundant) &#39;;name=3D&#39; from gene=
rated SRC_URI list.<br>
&gt;=C2=A0 =C2=A0 This can be done post-mickledore<br>
<br>
I&#39;ve gone ahead and stopped rc1 since I know in the long run this issue=
<br>
is going to cause problems.<br>
<br>
Short term I&#39;ll merge this patch and the fixes needed to the oe-core<br=
>
recipes. <br>
<br>
Now I&#39;ve been looking more closely at this, I did start to wonder if we=
<br>
shouldn&#39;t just put ;sha256sum=3DXXX parameters onto the crate urls we<b=
r>
generate though? If we do that, we don&#39;t need to name them at all.<br>
<br>
That is something we could move to at a later date if it make sense so<br>
it is less important from a release standpoint.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--00000000000049501405f8aa80c3--

