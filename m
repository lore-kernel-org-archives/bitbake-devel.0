Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B8CE8E94
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 16:38:52 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.web10.1027.1729787923103819562
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Oct 2024 09:38:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jz8xIYK6;
 spf=pass (domain: gmail.com, ip: 209.85.128.169, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e38fa1f82fso10703207b3.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Oct 2024 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729787922; x=1730392722; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yR9ASPdY/HWra9r0DWHRnysKo+xNq070ROEkxYxM9Xc=;
        b=jz8xIYK6ZcztH75iewJr/2ZwA0mneRT1mvxudpPcaGtEjvjbxtInBTxUmJDfz5JA9r
         o2/O+XjCqzDEO+7XdPdepDoQpT6zFuYCVoU0j9Aj5ePLLmU4IrqadsidKLzo74fG92xt
         xLbcQUuWOYhwNOjlHNfKYKkxdX0/JE9Y4eUGr4mmNia8FEWGzjRB85lPwbnAA8HEiMio
         N0QtmKpAUl0ZY09A0mr7IGifiKNDlQRisSWA48EeIYPvvhgu2osJe6AhRU5QJMm16X1d
         w7fVarZNYNWCiWQ2K69k/rcXBS/vot5ML8q2uAETQ7hgpk5hB9RJRsX1GBs4vPKeIM1Y
         juHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787922; x=1730392722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR9ASPdY/HWra9r0DWHRnysKo+xNq070ROEkxYxM9Xc=;
        b=OayhrCarjQ6SMGg/8yoT914qBjobov2+lTWyXwbrUx+8J3utR2/wd+Ar8t9bosUO5t
         7u8l+HDv+LMRHz5gBmLr47w3G8lZ632lCWYqzli4y7mAKs9UwQ8k2k54wNg0+qQuAot7
         XLr753m5AFtpcRQ24dlrgFBslLkLiTQ909IHSyFC7JjCf4mnY5/1QD55yg6aJbBLRYr/
         C5vlooUfJqVs6DXkMjJbJJ5DGG8SL9G7RIS4lFxqS+ZZivjY/FKmAnM/fJQgLQuNu65w
         YvSvvlqip+M3F+ENfI24ASK/UvYRSH+ntdqTJ0OkwVEKWl63oAe6Xp+QD2Leayh6fgLg
         XOPQ==
X-Gm-Message-State: AOJu0YxVFFTP3uy2twBW6msGiiYRTAevy6GoFC05oIdGJFuwPXTqnBDE
	H8uBaFHbAmwMQ7icArzLYaVVi4lgsdOVjXJoGHC27CAKiCbjeT7YpU4cNikiIEDoYdGY5+MBBVg
	0RLL3Z18bjI6DbBMTWUVwcjhKASI=
X-Google-Smtp-Source: AGHT+IGNfn7wM6GX5C9GFWdz01afdQLeTG075rtHYmR9onjTM+H/wYeq9hDuMfJAtgu/vtmKzmEnPruGz/raGoy0Rl4=
X-Received: by 2002:a05:690c:3203:b0:6dd:b7e0:65b2 with SMTP id
 00721157ae682-6e858184304mr24806497b3.24.1729787922112; Thu, 24 Oct 2024
 09:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <00b87e99-7b7d-4cdb-b800-000860eb0263@googlemail.com>
In-Reply-To: <00b87e99-7b7d-4cdb-b800-000860eb0263@googlemail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 24 Oct 2024 12:38:28 -0400
Message-ID: <CADkTA4M9_8vD1ZHZYRVC9rc9SoppLet04AZT+L5JYJquU1-NRQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Stupid Noob question
To: matthias.schoepfer@googlemail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000a268b206253ba25e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Oct 2024 16:38:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16725

--000000000000a268b206253ba25e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:42=E2=80=AFAM Matthias Schoepfer via
lists.openembedded.org <matthias.schoepfer=3D
googlemail.com@lists.openembedded.org> wrote:

> Hi!
>
> I am stepping totally out of my comfort zone and had the idea to write a
> custom fetcher (shall pull docker images O.o). From reading through some
> of the code of fetch2, I would guess there is no way to register a new
> fetcher from outside of the bitbake code itself. Please correct me, if I
> am wrong.
>

Also note that this concept has been discussed for many years now, and
if you did manage to get something like this working, it would be something
you'd need to maintain externally as it would be very unlikely to be
merged to bitbake or even to meta-virtuazliation (if you have cross
container install questions, meta-virt iis the right place to discuss it, a=
s
there is feature development happening there).

Bruce



>
> Thanks and Regards,
>
>      Matthias
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16723):
> https://lists.openembedded.org/g/bitbake-devel/message/16723
> Mute This Topic: https://lists.openembedded.org/mt/109190035/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--000000000000a268b206253ba25e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Oct 24, 2024 at 9:42=E2=80=AFAM Matthias Sc=
hoepfer via <a href=3D"http://lists.openembedded.org">lists.openembedded.or=
g</a> &lt;matthias.schoepfer=3D<a href=3D"mailto:googlemail.com@lists.opene=
mbedded.org">googlemail.com@lists.openembedded.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
<br>
I am stepping totally out of my comfort zone and had the idea to write a <b=
r>
custom fetcher (shall pull docker images O.o). From reading through some <b=
r>
of the code of fetch2, I would guess there is no way to register a new <br>
fetcher from outside of the bitbake code itself. Please correct me, if I <b=
r>
am wrong.<br></blockquote><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-size:small">Also note that=C2=A0this concept has been discuss=
ed for many years now, and</div><div class=3D"gmail_default" style=3D"font-=
size:small">if you did manage to get something like this working, it would =
be something</div><div class=3D"gmail_default" style=3D"font-size:small">yo=
u&#39;d need to maintain externally as it would be very unlikely to be</div=
><div class=3D"gmail_default" style=3D"font-size:small">merged to bitbake o=
r even to meta-virtuazliation (if you have cross</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">container install questions, meta-virt ii=
s the right place to discuss it, as</div><div class=3D"gmail_default" style=
=3D"font-size:small">there is feature development happening there).</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Bruce</div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks and Regards,<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0 Matthias<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16723): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16723" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16723</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/109190035/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/109190035/1050810</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=
=3D"_blank">bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">- =
Thou shalt not follow the NULL pointer, for chaos and madness await thee at=
 its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br><b=
r></div></div>

--000000000000a268b206253ba25e--

