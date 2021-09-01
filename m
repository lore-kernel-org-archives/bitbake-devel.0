Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web12.5493.1630487689374096790
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Sep 2021 02:14:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=GWT/CPha;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id lc21so5116093ejc.7
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Sep 2021 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzxPS8N4rNWyXTS2o2bOwqKLW3LWm8krGZzVBRTf+QI=;
        b=GWT/CPhahvjuK2JqkZ6ql9PYxxt5/UDN/QTUkWEp6P+nFirNnh6DLwIyD8d4ln518c
         gX2aD3R2lRWehtDL/AiX18/HS6bff8kFgnDKlImvywnM0FuLwmP5j0iEJCUT8puyAXT/
         BldMXpp6vuKnbmGK5grzzvE+9heoxFWixwmKOZjnHDGaKMH8Q8tDPCIVYnXS3wT0SBh7
         dOtaSyVPT1RcKprnhx+hmkO3fCa13/9TP2e6ZA7VQkhTcbEfMBlmNwMxRuTOrv/21A75
         FJ7D2OuV+3L7siayKH4W6pjyGI0YgodmGRbNagnr9ULW9AbmyJ1XtviVKhHM5b1QSvBQ
         t5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzxPS8N4rNWyXTS2o2bOwqKLW3LWm8krGZzVBRTf+QI=;
        b=O0+GKsoTL7LgeRj3E8I2MumRcgRT6DT9u+GnMajk0MqJH/AHr1YuaCPtoUTGPvlvjQ
         CvNGhSCci5s0ehOWULP249gnCYQqJfG65lZi8/TDOn+8anJwOyMZizU9fh60sB9Hk1EN
         SnSCrpLaRMt5MFS6Tkg/L2XmS2Q2BVGm/T+BWil2gb0uZW+F0QRq+Gp5SPSaXxY8dSqd
         qnR8Q5SHRkWcvIz0QLdedd592tntojDfggBLpuLAkTzxjw1dMfzEM9cykA1BBRzTMirx
         eYSJZPUGPFojuqdw6cyZy2VLjRQ/IDQRC3GkQYeSk44N1gJHe77gJTpbCtJ+U6tbkHjR
         XPsg==
X-Gm-Message-State: AOAM531885n0SV/VXlfqPVaebG9/ERJxWy28G6m2DM4CT+Hdu0Ehd4ch
	Xo4jbfR/rVb2gPJwyqpJI3tWm8gmDeYqXg9ajVg=
X-Google-Smtp-Source: ABdhPJxqp01c5lxPP+LONUHIO3LuYeucjrBUXxgrlj90oS41c8HnKhWdIKBuKZxWctbRvzfQJW6m1VthfUBCXZNG7Yw=
X-Received: by 2002:a17:906:34ca:: with SMTP id h10mr35843686ejb.137.1630487687657;
 Wed, 01 Sep 2021 02:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <16A04D855643B3E7.30479@lists.openembedded.org>
 <20210831074807.5972-1-mingli.yu@windriver.com> <f3b29ae8-7582-4b3b-abaf-8e1eb08bf54@spiteful.org>
 <d3e95bfb-593d-0fd8-bcb8-65af9537f5ea@windriver.com> <CAJdd5GaViYYCa6XovSO7n6ceSjBemn28bhN7TjSaCQgXkYpmuw@mail.gmail.com>
 <af883af8-192c-0550-76ea-ee5190ba54c1@windriver.com>
In-Reply-To: <af883af8-192c-0550-76ea-ee5190ba54c1@windriver.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Wed, 1 Sep 2021 11:14:36 +0200
Message-ID: <CA+chaQe2yEvPr9X86X-YYWypXhu4JHLM8TsHLpWpbfxPqQqe+g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] prserv: make localhost work
To: "Yu, Mingli" <mingli.yu@windriver.com>
Cc: Joshua Watt <jpewhacker@gmail.com>, Scott Murray <scott.murray@konsulko.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000006efd2e05caeb7faf"

--0000000000006efd2e05caeb7faf
Content-Type: text/plain; charset="UTF-8"

>
>
> > I think that was because IPv6 support had been incorrectly configured
> > for Docker, perhaps that is the same thing happening in your setup?
>
> In the same docker, the PR service works with PRSERV_HOST =
> "localhost:0" before, but it begins not work recently after some code
> restructure for prserv part.
>
> BTW, the ipv6 is disabled in the docker of my env.
>

Check your /etc/hosts

There is ::1 localhost localhost-ip6 even when ipv6 is disabled in docker's
deamon.json.

And that makes bitbake (asyncio) to try binding to ::1 instead of
127.0.0.1, if you remove "localhost" from ::1 in /etc/hosts in running
container, then it works again OK.

My patch allows you to use 127.0.0.1:0 explicitly and still keep the same
behavior (as autostarted prserv with random port) as when localhost:0 is
being used (and also for consistency).

Your patch is IMHO good addition to that (that the localhost is resolved in
python and then people don't need to use 127.0.0.1 explicitly).

Regards,

--0000000000006efd2e05caeb7faf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
&gt; I think that was because IPv6 support had been incorrectly configured<=
br>
&gt; for Docker, perhaps that is the same thing happening in your setup?<br=
>
<br>
In the same docker, the PR service works with PRSERV_HOST =3D <br>
&quot;localhost:0&quot; before, but it begins not work recently after some =
code <br>
restructure for prserv part.<br>
<br>
BTW, the ipv6 is disabled in the docker of my env.<br></blockquote><div><br=
></div><div>Check your /etc/hosts</div><div><br></div><div>There is ::1 loc=
alhost localhost-ip6 even when ipv6 is disabled in docker&#39;s deamon.json=
.</div><div><br></div><div>And that makes bitbake (asyncio) to try binding =
to ::1 instead of 127.0.0.1, if you remove &quot;localhost&quot; from ::1 i=
n /etc/hosts in running container, then it works again OK.</div><div><br></=
div><div>My patch allows you to use <a href=3D"http://127.0.0.1:0">127.0.0.=
1:0</a> explicitly and still keep the same behavior (as autostarted prserv =
with random port) as when localhost:0 is being used (and also for consisten=
cy).</div><div><br></div><div>Your patch is IMHO good addition to that (tha=
t the localhost is resolved in python and then people don&#39;t need to use=
 127.0.0.1 explicitly).</div><div><br></div><div>Regards,</div></div></div>

--0000000000006efd2e05caeb7faf--
