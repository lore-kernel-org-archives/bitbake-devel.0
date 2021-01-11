Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.33270.1610368965308005551
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Jan 2021 04:42:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista-com.20150623.gappssmtp.com header.s=20150623 header.b=lwwTV3Fq;
 spf=permerror, err=parse error for token &{10 18 websitewelcome.com}: parse error for token &{10 18 _spf.google.com}: limit exceeded (domain: mvista.com, ip: 209.85.218.51, mailfrom: mshah@mvista.com)
Received: by mail-ej1-f51.google.com with SMTP id lt17so24559682ejb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Jan 2021 04:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+y3BfU9d4iBekgX98bQwokf5K0O3wsvxgfYrjIH8TY=;
        b=lwwTV3FqWpDAyYogG/7l1XJw/BAjmtklLrNlw2qL8k9zVkmfckzGxfj9A2fOUXmJhg
         BUGw+L85G1CpVKnm+twD5L9UJ/Kzoug/BoMqxVyzypkC/jFAK+ZMt8VsddHr5FUnmX+q
         bCS1jRc26vD9ea6ykVbWa9LepjQbo8e4aTOQa2j3+L/y4qFD+eJW+xCCyNaGochI4VEH
         7Io6Mulm8Bo1jHUGZ27EylfRk6Jx/5MzzIYYBj+L7KIFnJ0x/fa8glstniSPZcf4h/Dx
         GbloBIqpy+Km1f230AsSOBR/Vt3N8n/7xupzwTxGy91Y/nUIOiKBpDx5+4/pPsJERrY3
         uZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+y3BfU9d4iBekgX98bQwokf5K0O3wsvxgfYrjIH8TY=;
        b=OV9T3/sBXeAA1tyZqZ9vOPor9LAZAyjwy5nPMJ25YWvgzAfszppxABlUYvfo00L3Mt
         pS7q89R/GC2sfXDExUh0wC8mDERqHchvluzzdFpz2XtI/l7DqY8vJtgu+LvcUn/cqVno
         MKookPaZyJ+a6vvAmGnpO/AKwqxaHsN8Qcde2EiuPqX8OIkvms1NFQU6+unA9Z3QijUP
         Ox7iYAPLg3IPv058EGbyox+oi9S0w9o+Fjcs7tBObNZBei/lGgmQoDUlP6ULx2i783Fm
         gl7tSs+y6QWt9MYlvDN+oQkdPv+JKVFZtfD6EWOnjL3zDcegIq53AhUuHFYeeJJ8jim9
         HnwA==
X-Gm-Message-State: AOAM530ihG8+c8E9NX/RvABfszHKUFQ7u7k4e6TK7s9vjlA9IJ5x97vd
	4u9VOnKXNsYPJtCzFX8YjU6tJeLkj17+OpjiTHXoqg==
X-Google-Smtp-Source: ABdhPJzASUevI3GgipBvDJsb2iBRRDOpX7TbaOqDPR510ZMMurswCr3hP17DvIxOUHS63ZeifPy44IV+qeuIWFKNjpc=
X-Received: by 2002:a17:907:6e9:: with SMTP id yh9mr10531875ejb.131.1610368963919;
 Mon, 11 Jan 2021 04:42:43 -0800 (PST)
MIME-Version: 1.0
References: <1609839118-2342-1-git-send-email-mshah@mvista.com>
 <CA+=qD9NuCZ7KeAU3YDDnK=kLa8UVeucOMAyPi6CB+wxTf79Mbg@mail.gmail.com> <CAM9ZRVuUY41jaHqMmpnXamQ399g5JepSGJ21_8twHhPUyFE-wQ@mail.gmail.com>
In-Reply-To: <CAM9ZRVuUY41jaHqMmpnXamQ399g5JepSGJ21_8twHhPUyFE-wQ@mail.gmail.com>
From: "Milan Shah" <mshah@mvista.com>
Date: Mon, 11 Jan 2021 18:12:07 +0530
Message-ID: <CA+=qD9OUc+Gr6vMCPd4s9Nfais-kh=-Pasvi71g2RYtZDcBJJw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: utils: add docstrings to functions
To: Paul Barker <pbarker@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Randy MacLeod <randy.macleod@windriver.com>
Content-Type: multipart/alternative; boundary="0000000000000d5aca05b89f3e74"

--0000000000000d5aca05b89f3e74
Content-Type: text/plain; charset="UTF-8"

Thanks, Paul for responding.

I didn't know that it is accepted. Should I close the bug now?

-----------------------
Thanks & Regards,
*Milan Shah*
MontaVista Software, Bangalore, India


On Mon, Jan 11, 2021 at 6:08 PM Paul Barker <pbarker@konsulko.com> wrote:

> On Mon, 11 Jan 2021 at 12:15, Milan Shah <mshah@mvista.com> wrote:
> >
> > Hi All,
> >
> > This is a gentle reminder to review this patch.
>
> Looks like this has already been accepted into master:
>
> https://git.openembedded.org/bitbake/commit/?id=b61ba4a18693a9e553d2a93161feb0bcc1c82384
>
> --
> Paul Barker
> Konsulko Group
>

--0000000000000d5aca05b89f3e74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, Paul for responding. <br></div><div><br></div=
><div>I didn&#39;t know that it is accepted. Should I close the bug now?<br=
></div><div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font face=3D"t=
imes new roman, serif"><br></font></div><div dir=3D"ltr"><font face=3D"time=
s new roman, serif">-----------------------<br></font></div><div dir=3D"ltr=
"><font face=3D"times new roman, serif">Thanks &amp; Regards,</font><div><f=
ont face=3D"times new roman, serif"><b>Milan Shah</b></font></div><div><spa=
n style=3D"background-color:rgb(255,255,255)"><font color=3D"#ff0000"><font=
 face=3D"times new roman, serif">MontaVista Software, </font></font></span>=
<span style=3D"background-color:rgb(255,255,255)"><font color=3D"#ff0000"><=
font face=3D"times new roman, serif"><span style=3D"font-family:&quot;times=
 new roman&quot;,serif">Bangalore</span></font><span style=3D"font-family:&=
quot;times new roman&quot;,serif">, India</span></font></span><br></div></d=
iv></div></div></div></div><br></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 11, 2021 at 6:08 PM Paul B=
arker &lt;<a href=3D"mailto:pbarker@konsulko.com">pbarker@konsulko.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mo=
n, 11 Jan 2021 at 12:15, Milan Shah &lt;<a href=3D"mailto:mshah@mvista.com"=
 target=3D"_blank">mshah@mvista.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi All,<br>
&gt;<br>
&gt; This is a gentle reminder to review this patch.<br>
<br>
Looks like this has already been accepted into master:<br>
<a href=3D"https://git.openembedded.org/bitbake/commit/?id=3Db61ba4a18693a9=
e553d2a93161feb0bcc1c82384" rel=3D"noreferrer" target=3D"_blank">https://gi=
t.openembedded.org/bitbake/commit/?id=3Db61ba4a18693a9e553d2a93161feb0bcc1c=
82384</a><br>
<br>
-- <br>
Paul Barker<br>
Konsulko Group<br>
</blockquote></div>

--0000000000000d5aca05b89f3e74--
