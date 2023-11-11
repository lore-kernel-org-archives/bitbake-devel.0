Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5DAC4332F
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 12:51:53 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.51146.1699707106520380334
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Nov 2023 04:51:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20230601.gappssmtp.com header.s=20230601 header.b=B10TLXVR;
 spf=pass (domain: smile.fr, ip: 209.85.218.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9e4675c7a5fso437634866b.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 04:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1699707105; x=1700311905; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HB1cVEV/knmzmw7I5SV/ncp/aAwLxWSJ1xU6in5uF54=;
        b=B10TLXVRD9NeImwUX7zlEuOdbBaJF5o2jJphc3FAZQuqX5YOqbPavEu0bl5Z0AVDbD
         zs0Ws7tqPxEry+PMQRpC+g9CKDIVVYIoGf2+TXwsESXMJi9iKbrj4G2Z4jr4fJ7cZkfW
         H+C84X1qzsqRbzqeRKd1SwNGYPu9jOsHfUXjwqeEtcCr0cDOX/iB8PMraNj/O4Mk+aLU
         q3tQDP1qUgqOj/3ENNz0jdSGFmxnjWOi7s09b7FYOQKGmeuBD8WCJYUYd1rRY9O3bLLN
         DZhI9gviJ8pc193vk6dSPJA0AtPUuf1u5yOaSmDLc3FcU69iDRs1ckX6k9xU+MnS/jwE
         UH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699707105; x=1700311905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB1cVEV/knmzmw7I5SV/ncp/aAwLxWSJ1xU6in5uF54=;
        b=nUHF751lKuydIwVWvBcFcdtghCgF1hTDxjdBgC9JCoD8WT7REJMrScgWbXZv48URvt
         YqwcsShzkeXPtrUbaWSNhd/ySW/zBLF9Hxb42RF+GUdyX01EhSL1NbVvJZhQhyVswfAA
         shXgqmBREqoSTJ5GWZZ1iHEIwnV4t+y3fexnj/rETos4YTniGHZE6AMVueiEdCIzXiKK
         dXOXHnXVcLve4lnMCb8eYpWjRvxmTigII0SkeJhi5iZpXEFi9Rd27DEY9KwtTfuDkhxG
         TsnBmUI27cucVo8eeXgsvhXKiZ9i9p3dLD//70A7jsgYK5RtDVjQoldvnKwa2uoWiwk/
         x9/A==
X-Gm-Message-State: AOJu0Yx94ZVcaHUg+TBoEDpcxgnAZyJWREzZnI+gtzWULpPybKk8CU32
	rxaQzm6wNB5QnpT3CB/8G9xozRt7CmAdcj/JzHJzuQ==
X-Google-Smtp-Source: AGHT+IGRJxIL0dNTR5/3pU6yEYycbRUys2bYKmh72Tvpqk4s86Wnq5btRefSWAb9RBZje0IRXIkaUhBxI0fjZ8uPJO8=
X-Received: by 2002:a17:907:9703:b0:9df:e39d:e0ed with SMTP id
 jg3-20020a170907970300b009dfe39de0edmr1711258ejc.24.1699707104940; Sat, 11
 Nov 2023 04:51:44 -0800 (PST)
MIME-Version: 1.0
References: <rd62.1699703693217578896.TOFk@lists.openembedded.org>
In-Reply-To: <rd62.1699703693217578896.TOFk@lists.openembedded.org>
From: Yoann CONGAL <yoann.congal@smile.fr>
Date: Sat, 11 Nov 2023 13:51:32 +0100
Message-ID: <CAMSfU+7jpjMGRJMym6-1U0vw7tNbRXvT_pasC2cj=raDdSJvsA@mail.gmail.com>
Subject: Re: [bitbake-devel] Problem when adding own tasks
To: athragared@proton.me
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000003665ce0609dfe6dd"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 12:51:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15515

--0000000000003665ce0609dfe6dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le sam. 11 nov. 2023 =C3=A0 12:54, athragared via lists.openembedded.org
<athragared=3Dproton.me@lists.openembedded.org> a =C3=A9crit :

> Hello everyone, this is my first mail here, I hope this is the right
> "channel" for my question.
>
> I am currently using the 'Kirkstone' branch of yocto and I have
> encountered a problem. I have written a .bbappend file for *systemd* in
> my own layer. Here I have written my own python function as follows:
>
> python do_my_own_function(){
>     # do something
> }
> addtask my_own_function before do_install
>
> This seems to work most of the time. However, I would like to execute my
> own function *AFTER* the do_install. However, this does not seem to work.
> If I delete the build folder before building the image and then look in
> the *log.task_order* file I see that my own function is NOT executed.
> Other people on stackoverflow
> <https://stackoverflow.com/questions/76234388/bitbake-addtask-deploy-afte=
r-do-install-not-working-from-image-recipe>
> seem to have observed this problem as well.
>
>
> So I wanted to ask how to solve the problem or debug it further?
>

Something needs to depend on your task for it to be called :
addtask my_own_function after do_install before do_build
This should make your task called on your recipe build.

You may need to choose a different "before task" depending on what your
task does.

And beware of cache : bitbake might consider it does not need to run your
task if it has done so already at some point.

Regards,
--=20
Yoann Congal

--0000000000003665ce0609dfe6dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi,<br><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Le sam. 11 nov. 2023 =C3=A0 12:54, athragared via <=
a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;ath=
ragared=3D<a href=3D"mailto:proton.me@lists.openembedded.org">proton.me@lis=
ts.openembedded.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><p>Hello everyone, this is my first mail here, I hope this is=
 the right &quot;channel&quot; for my question.<br><br>I am currently using=
 the &#39;Kirkstone&#39; branch of yocto and I have encountered a problem. =
I have written a .bbappend file for <strong>systemd</strong> in my own laye=
r. Here I have written my own python function as follows:<br><br>python do_=
my_own_function(){<br>=C2=A0=C2=A0=C2=A0 # do something<br>}<br>addtask my_=
own_function before do_install<br><br>This seems to work most of the time. =
However, I would like to execute my own function <strong>AFTER</strong> the=
 do_install. However, this does not seem to work.<br>If I delete the build =
folder before building the image and then look in the <strong>log.task_orde=
r</strong> file I see that my own function is NOT executed. Other people on=
 <a href=3D"https://stackoverflow.com/questions/76234388/bitbake-addtask-de=
ploy-after-do-install-not-working-from-image-recipe" rel=3D"noopener norefe=
rrer" target=3D"_blank">stackoverflow</a> seem to have observed this proble=
m as well.</p>
<p><br>So I wanted to ask how to solve the problem or debug it further?<br>=
</p></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Something needs to depend on your task for it to be called :</div><div dir=
=3D"auto">addtask my_own_function after do_install before do_build</div><di=
v dir=3D"auto">This should make your task called on your recipe build.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">You may need to choose a dif=
ferent &quot;before task&quot; depending on what your task does.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">And beware of cache : bitbake migh=
t consider it does not need to run your task if it has done so already at s=
ome point.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div=
><div dir=3D"auto">--=C2=A0</div><div dir=3D"auto">Yoann Congal</div></div>

--0000000000003665ce0609dfe6dd--

