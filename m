Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1315BC433EF
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 16:14:24 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
 [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web10.25855.1637943263168158917
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 08:14:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=d5ZJIpa6;
 spf=pass (domain: gmail.com, ip: 209.85.166.54, mailfrom: ticotimo@gmail.com)
Received: by mail-io1-f54.google.com with SMTP id m9so12112241iop.0
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cnftlr3UPettA22+jAdyipeB/tHBmblZgCcWp2RKZQ=;
        b=d5ZJIpa6+jneJPaDwTC+jaS7CHbKRjcNmIvLi5Y77XrvnFKnx4FhoFRAN7UGhSDLMx
         435B5b9D9wZ0rfU94/Cw9zItlIQpBcHhEl0aNl1eqnQ3D5W5rk1gJ6EvqgZQI1wnqiyI
         V+VOcLUrU5K6HIKwqjIQxguYqNv8olGqmcmMwExEJKkfn+3QGxZH6tK0Q00HGPWZA25a
         bybEr5sdZ+Ei/mH5SjLc0WiY/z7AYZ+zrNTQc7jhvtmNnVw56NZen0f6lBPHovRZTjPk
         8DXtwezcvnyCGZPqE15UqbIcSfLhhJNX6C10Rv6YpkUxHpQvwrcFa9116B0KvxSEKIVm
         2NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cnftlr3UPettA22+jAdyipeB/tHBmblZgCcWp2RKZQ=;
        b=CBkBFyyZ3Vm7zzHaDiMqEaIyfqQCIU2XS7LolcRsFjmzT+dCHX6kvSAEvPyxh3pDjY
         hI6Y0MGD1tmPcKNfwi9SkeECS2g9Zd8/kDdrJu5aUBZnwf10adHSUsQ5Y2+bm4/b4hB+
         Y6uMSPJEDVSMUtHch6f+4tsNzyceovtLcNLsAvW6DtrwKgFHye3I8ih7w3jsreJ4Pw4A
         hHAHwqrYOqArv4fpTF88AqJrIs/5POV5JiAQVQeKOjPjUKFT3jTMtQIaLOVDTsa0iOmN
         1yV5Z8MO6qnjCQsVKDDqjgQYdHSa5zzV2byq5+PWGe5UIavQzyei23IJSaxbxCQ5uYD/
         hPzQ==
X-Gm-Message-State: AOAM5314nP+NhnEKFus0pgQznj6lQ5qASfbW7foNDrLPM5CHbCfv7I+f
	M1DkEHUynTLi8srMKGVB/7wFWDSBYOoC+Z183W4=
X-Google-Smtp-Source: 
 ABdhPJw4Wx63PwkQ44REnWZrnyFaHSTcyYeO0SIkxJ9P+M7wy0rtgS9Zzo5tc73hdiTL7whdkhxssCJgiQBNIWHdUHc=
X-Received: by 2002:a05:6602:493:: with SMTP id
 y19mr37764158iov.126.1637943262480;
 Fri, 26 Nov 2021 08:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20211126051800.2364615-1-timothy.t.orling@intel.com>
 <4cb1cfdfd24814d29dea9308b9bceee6f6054f99.camel@linuxfoundation.org>
In-Reply-To: 
 <4cb1cfdfd24814d29dea9308b9bceee6f6054f99.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 26 Nov 2021 08:14:11 -0800
Message-ID: 
 <CANx9H-DqwpfBovbZUcHAR-GWeDuoGKXnUcNLwavpkREJRMXCvg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/version.py: add from
 distutils.version
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Tim Orling <timothy.t.orling@intel.com>
Content-Type: multipart/alternative; boundary="000000000000528d1805d1b362a9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Nov 2021 16:14:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13115

--000000000000528d1805d1b362a9
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 26, 2021 at 12:21 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2021-11-25 at 21:18 -0800, Tim Orling wrote:
> > In places like sanity.bbclass we currently use
> > distutils.version.LooseVersion, but distutils is deprecated in Python
> > 3.10 and will be removed in Python 3.12 (~October 2023).
> >
> > The recommended replacement for for distutils.version.LooseVersion is
> > packaging.version.Version, but this implies 'packaging' be installed on
> > the host. It is also not the same functionality as LooseVersion.
> >
> > [YOCTO #14610]
> >
> > Signed-off-by: Tim Orling <timothy.t.orling@intel.com>
> > ---
> >  lib/bb/version.py | 347 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 347 insertions(+)
> >  create mode 100644 lib/bb/version.py
>
> I'm wondering if we could switch the usage of LooseVersion for
> bb.utils.vercmp_string(a, b)?
>
> I don't know. I was trying to follow any guidance from upstream CPython
and PEP 632 and this was the simplest way out. In my thread to the
oe-architecture list Khem thought this was ok, so I just went with it to
get the distutils deprecation series out into the wild and get eyeballs on
it. Much more will have to wait until after the YP Summit in terms of my
bandwidth.


> Cheers,
>
> Richard
>
>

--000000000000528d1805d1b362a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 26, 2021 at 12:21 AM Rich=
ard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richar=
d.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Thu, 2021-11-25 at 21:18 -0800, Tim Orling w=
rote:<br>
&gt; In places like sanity.bbclass we currently use<br>
&gt; distutils.version.LooseVersion, but distutils is deprecated in Python<=
br>
&gt; 3.10 and will be removed in Python 3.12 (~October 2023).<br>
&gt; <br>
&gt; The recommended replacement for for distutils.version.LooseVersion is<=
br>
&gt; packaging.version.Version, but this implies &#39;packaging&#39; be ins=
talled on<br>
&gt; the host. It is also not the same functionality as LooseVersion.<br>
&gt; <br>
&gt; [YOCTO #14610]<br>
&gt; <br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:timothy.t.orling@intel=
.com" target=3D"_blank">timothy.t.orling@intel.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/version.py | 347 ++++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 347 insertions(+)<br>
&gt;=C2=A0 create mode 100644 lib/bb/version.py<br>
<br>
I&#39;m wondering if we could switch the usage of LooseVersion for<br>
bb.utils.vercmp_string(a, b)?<br>
<br></blockquote><div>I don&#39;t know. I was trying to follow any guidance=
 from upstream CPython and PEP 632 and this was the simplest way out. In my=
 thread to the oe-architecture list Khem thought this was ok, so I just wen=
t with it to get the distutils deprecation series out into the wild and get=
 eyeballs on it. Much more will have to wait until after the YP Summit in t=
erms of my bandwidth.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div></div>

--000000000000528d1805d1b362a9--

