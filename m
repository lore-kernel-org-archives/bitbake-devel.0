Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
 by mx.groups.io with SMTP id smtpd.web08.2270.1631045941652992970
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 13:19:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=SvMmaUWw;
 spf=pass (domain: gmail.com, ip: 209.85.217.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f50.google.com with SMTP id bf15so63554vsb.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsmlE/Q7jxvKfLnTvUvq210HgXW13RBmoLm1sQZuQr4=;
        b=SvMmaUWwDcwe+JxgXM8hW3jk0IhfYRE0aU/kzO/EjRzwwbMS9yw5dgs1ukU07a9LGF
         UBRIQUG5gGF6ar7BKEJJ2eYbu6eRWVQfVZ/1CLmAmpIuEfBwQLnWGCqxgt853EeAzS1Z
         y0psMZ5OlT7ZGNw3SS2uLSHLntzjht1T3wC1cbKeQL6eSezMHD9rIe5ElMm0QBLTqBbt
         0Iptva1b60rVIhvHkTH1q7EKOvmOa9kHe8yDRSYqI8+LofyjPTxlwUyvzEQFYUM+ZgVx
         GwEHGvnqiTTW9Z808PNX+9TtB/GBI79tkWpK9jj2q5cqBAxWPSsrq7DRHoavd+0mmDU3
         YcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsmlE/Q7jxvKfLnTvUvq210HgXW13RBmoLm1sQZuQr4=;
        b=kAM1AjldavlkW4UcJKu51optg1ZPB5sfSzOG72tZL9KxidKE3Sl6tb3H1HnjBKSH6Z
         k99jibHZYcvZyXwHpZWVza4tlNkaWOKt3fvH2lFs8vz2FG6zi1y2W2vlsrsyZsMoKQZG
         o/q3VnmUjhP+b3xeuL+SLXXjLzZ50R7e/roujvxWpQHT/omkuVQLBj7Tp8syNppP6HEe
         RmDcuI46GIKMP8Zd0nevNVVqtbvqfNzNJo7jgXrZj6/YnbVO5rdOmzNKlS3EmAchoiV6
         qRverygxecEkWGAHDAG1fnE1Mr7J0pRKWDs3ylDeMEj+qeSkE5xrQ+HBqDEi6X8fUPWu
         im/w==
X-Gm-Message-State: AOAM532YAiziprn1dzUZSM0oYt6iwInPOuUq3yu0OHmRr/XkyUm5d8Ua
	dHj5aggpticba5YIIlrGZN324O7QhdWxFwfmDq0=
X-Google-Smtp-Source: ABdhPJwqMO0Iy+dKBGBgne3ZDV/3uEITouRUY89msnfNIdgGKtuS7sWEXkKaT189D4DUy1BEwS/STR6oT402ogFgdgE=
X-Received: by 2002:a05:6102:94e:: with SMTP id a14mr114962vsi.1.1631045940754;
 Tue, 07 Sep 2021 13:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj88WpKLuHORum8vMnhW6UVWqJMYLDM1vz-+MX3uu3Lh7w@mail.gmail.com>
 <13276.1631032728323594714@lists.openembedded.org> <0945d013a2111bc32698d527ede2fa747a25ad85.camel@linuxfoundation.org>
In-Reply-To: <0945d013a2111bc32698d527ede2fa747a25ad85.camel@linuxfoundation.org>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Tue, 7 Sep 2021 22:18:49 +0200
Message-ID: <CANNYZj-eA=hYnhBNw5gZcJpB3Xy8R7j1ptJJG8kYhxvzL7xadg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000e9411905cb6d79c2"

--000000000000e9411905cb6d79c2
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Sept 2021 at 21:17, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> So you're saying we're showing an "unhealthy form of arrogance". Thanks.
>
> I did mention you can bypass and do creative things with the checks. I
> don't
> particularly want to spell it out as I don't want to encourage it or see
> it in
> widespread use but someone else has also mentioned more directly how it
> can be
> done.
>

By the way, in my previous job I've seen a certain well-known mobile
silicon vendor get even more creative and declare a wildcard yocto release
compatibility for all of their BSP layers, so they would never have to
spell out specific yocto releases. That was literally the first thing I
told them to remove, and no, I am not saying how they did it. One can
bypass all rules if one is determined to.

Alex

--000000000000e9411905cb6d79c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 7 Sept 2021 at 21:17, Richard Purdie &lt;<a href=3D"mailto:r=
ichard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So you=
&#39;re saying we&#39;re showing an &quot;unhealthy form of arrogance&quot;=
. Thanks.<br>
<br>
I did mention you can bypass and do creative things with the checks. I don&=
#39;t<br>
particularly want to spell it out as I don&#39;t want to encourage it or se=
e it in<br>
widespread use but someone else has also mentioned more directly how it can=
 be<br>
done.<br></blockquote><div><br></div><div>By the way, in my previous job I&=
#39;ve seen a certain well-known mobile silicon vendor get even more creati=
ve and declare a wildcard yocto release compatibility for all of their BSP =
layers, so they would never have to spell out specific yocto releases. That=
 was literally the first thing I told them to remove, and no, I am not sayi=
ng how they did it. One can bypass all rules if one is determined to.<br></=
div><div><br></div><div>Alex<br></div></div></div>

--000000000000e9411905cb6d79c2--
