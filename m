Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D2DC433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 22:52:26 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by mx.groups.io with SMTP id smtpd.web09.4130.1635288744986173561
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 15:52:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=f/JEcqY/;
 spf=pass (domain: konsulko.com, ip: 209.85.222.42,
 mailfrom: scott.murray@konsulko.com)
Received: by mail-ua1-f42.google.com with SMTP id f24so1293919uav.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9baU40iRTpCfEosnDFbupWIzsNWUilUrDV7eUxVEAFk=;
        b=f/JEcqY/sUCxUq8pvZwRvJh4o4+HHqII3l3FV95/fYXk/3E4YbUgU3xvzglxN1s+fd
         liY3PD9+qGwEGFQZsEDJjOOfXPXTtHPVBCalAiMzEYPGqhqlFquIyHFM8ycmQYc+WH5T
         mkSzSkQFv9wHvPxh6lNh8bbM/8cG4HvcRIMCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9baU40iRTpCfEosnDFbupWIzsNWUilUrDV7eUxVEAFk=;
        b=gUSdrVapctKA0WRY2J8IcQSmXlOcoCU3aXk8z4aOPq5Y0ai1yFlm/xUWZXY1q6Kox7
         R7BMv54OOv8nnkFTcblNStCUbPjJMvRuZQuDS1d0te5VGFXGuApYkYDyYxnqTgTZxKWq
         pfcaHYDpzfVvJAj/51+pAsRdojN4cXpygzlE1SjnnDaIv8OwxFhVMbZ4X+sP1pScQsht
         ZoBIzXng+ilc7PDIC4t5fURRow0gkR9jfrkYQdT3+Hz/txPU7HvAMXetxyhDAgfUQQM6
         b/KGhSoh5tnZbXwkKeXtFeRLpFCwqXT26y1WJ2j1r04NHniWH9MkWQxdVYpWktRmbrAX
         QCRg==
X-Gm-Message-State: AOAM531/DyYWainUdUxnXfQGPg8PlxCR98ZTjfy2Ts7tAgyzz8OIp+V/
	S+ZQtM8fd+gxnrNweAKQ2GGOtoNXhDWeYIHvZmCOtA==
X-Google-Smtp-Source: 
 ABdhPJw2PkWa9g1RxgK+KW4NyqlD2kisxIgtmkBmuE3Ml4X2vuyq9MXzM0V2O+7IghAbot+r991zxEAfxZsqtfCUHPg=
X-Received: by 2002:a67:2c95:: with SMTP id s143mr19740208vss.0.1635288744026;
 Tue, 26 Oct 2021 15:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <d248a56-a985-952c-363c-7a642761c2b6@spiteful.org>
 <AM9PR09MB4642DA41A9B3F3FCF6CB23EDA8849@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <7aabfa2b-2019-2dfb-3ae0-3ace4c4638d@spiteful.org>
 <16B1B4E0DFE93958.19566@lists.openembedded.org>
 <8bd2e9ff001261ae11beb8794f843965088c3162.camel@linuxfoundation.org>
In-Reply-To: 
 <8bd2e9ff001261ae11beb8794f843965088c3162.camel@linuxfoundation.org>
From: Scott Murray <scott.murray@konsulko.com>
Date: Tue, 26 Oct 2021 18:52:13 -0400
Message-ID: 
 <CAFrvZPWhg6hw0yirR-Sq5=+hJwhuwOg7B+uH1ZYicDBoY18e2g@mail.gmail.com>
Subject: Re: [bitbake-devel] noexec varflag behavior vs documentation?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Konrad Weihmann <kweihmann@outlook.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b1754e05cf49542f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Oct 2021 22:52:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12838

--000000000000b1754e05cf49542f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 26, 2021 at 6:44 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2021-10-26 at 23:23 +0100, Richard Purdie via
> lists.openembedded.org
> wrote:
> > On Tue, 2021-10-26 at 15:54 -0400, Scott Murray wrote:
> > > On Tue, 26 Oct 2021, Konrad Weihmann wrote:
> > >
> > > > On 26.10.21 17:57, Scott Murray wrote:
> > > > > As I brought up on the dev call earlier, the task noexec varflag
> > > > > documentation says:
> > > > >
> > > > > * [noexec]: When set to =E2=80=9C1=E2=80=9D, marks the task as be=
ing empty, with no
> > > > > execution required. You can use the [noexec] flag to set up tasks
> as
> > > > > dependency placeholders, or to disable tasks defined elsewhere
> that are
> > > > > not needed in a particular recipe.
> > > > >
> > > > > (from:
> > > > >
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-ma=
nual-metadata.html?highlight=3Dnoexec#variable-flags
> )
> > > > >
> > > > > However, as I discovered yesterday, the reality is that it being
> set to
> > > > > any value at all disables execution, which Richard mentioned on
> the dev
> > > > > call helps with performance.  The question Richard asked me to
> bring here
> > > > > is whether the documentation should be updated, or if the behavio=
r
> should
> > > > > be changed to match it?  I do not have a strong opinion either
> way, but
> > > > > would like this resolved somehow to avoid others spending time
> scratching
> > > > > their heads like I did for a bit yesterday.
> > > >
> > > > As I stumbled upon the very same, I'd love to see the docu being
> updated - I
> > > > mean implicitly it already does that as noexec can be only
> deactivated by
> > > > putting no value in it - but both cases should be properly
> documented IMO
> > >
> > > Chris mentioned to me OOB this existing Bugzilla:
> > >
> > > https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13808
> > >
> > > I don't see the discussed deprecation warning change in master,
> though, so
> > > I'm guessing it got dropped.
> >
> >
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D66f22c0bd19a81ee7c=
cb49543f24a4f90fc012ba
> >
> > Is that code working?
>
> I did check and with do_compile[noexec] =3D "0" in the bash recipe, I see=
:
>
> WARNING: /xxx/meta/recipes-extended/bash/bash_5.1.8.bb: In a future
> version of BitBake, setting the 'noexec' flag to something other than '1'
> will result in the flag not being set. See YP bug #13808
>
> so it does appear to.
>

Yes, I did just try it here as well.  I've been working on dunfell and
missed it in master
when I looked through git grep, my apologies.  I guess there's still the
questions of
just when the deprecation takes effect and if anything should be done with
respect to
the documentation in the meantime (since it could IMO be argued it's
incorrect ATM).

Scott

--000000000000b1754e05cf49542f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Oct 26, 2021 at 6:44 PM Richard Purdie &lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On T=
ue, 2021-10-26 at 23:23 +0100, Richard Purdie via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.or=
g</a><br>
wrote:<br>
&gt; On Tue, 2021-10-26 at 15:54 -0400, Scott Murray wrote:<br>
&gt; &gt; On Tue, 26 Oct 2021, Konrad Weihmann wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; On 26.10.21 17:57, Scott Murray wrote:<br>
&gt; &gt; &gt; &gt; As I brought up on the dev call earlier, the task noexe=
c varflag<br>
&gt; &gt; &gt; &gt; documentation says:<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; * [noexec]: When set to =E2=80=9C1=E2=80=9D, marks the =
task as being empty, with no<br>
&gt; &gt; &gt; &gt; execution required. You can use the [noexec] flag to se=
t up tasks as<br>
&gt; &gt; &gt; &gt; dependency placeholders, or to disable tasks defined el=
sewhere that are<br>
&gt; &gt; &gt; &gt; not needed in a particular recipe.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (from:<br>
&gt; &gt; &gt; &gt; <a href=3D"https://docs.yoctoproject.org/bitbake/bitbak=
e-user-manual/bitbake-user-manual-metadata.html?highlight=3Dnoexec#variable=
-flags" rel=3D"noreferrer" target=3D"_blank">https://docs.yoctoproject.org/=
bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html?highlight=3Dn=
oexec#variable-flags</a>)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; However, as I discovered yesterday, the reality is that=
 it being set to<br>
&gt; &gt; &gt; &gt; any value at all disables execution, which Richard ment=
ioned on the dev<br>
&gt; &gt; &gt; &gt; call helps with performance.=C2=A0 The question Richard=
 asked me to bring here<br>
&gt; &gt; &gt; &gt; is whether the documentation should be updated, or if t=
he behavior should<br>
&gt; &gt; &gt; &gt; be changed to match it?=C2=A0 I do not have a strong op=
inion either way, but<br>
&gt; &gt; &gt; &gt; would like this resolved somehow to avoid others spendi=
ng time scratching<br>
&gt; &gt; &gt; &gt; their heads like I did for a bit yesterday.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; As I stumbled upon the very same, I&#39;d love to see the do=
cu being updated - I<br>
&gt; &gt; &gt; mean implicitly it already does that as noexec can be only d=
eactivated by<br>
&gt; &gt; &gt; putting no value in it - but both cases should be properly d=
ocumented IMO<br>
&gt; &gt; <br>
&gt; &gt; Chris mentioned to me OOB this existing Bugzilla:<br>
&gt; &gt; <br>
&gt; &gt; <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13=
808" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org=
/show_bug.cgi?id=3D13808</a><br>
&gt; &gt; <br>
&gt; &gt; I don&#39;t see the discussed deprecation warning change in maste=
r, though, so<br>
&gt; &gt; I&#39;m guessing it got dropped.<br>
&gt; <br>
&gt; <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D66f2=
2c0bd19a81ee7ccb49543f24a4f90fc012ba" rel=3D"noreferrer" target=3D"_blank">=
http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D66f22c0bd19a81ee7ccb=
49543f24a4f90fc012ba</a><br>
&gt; <br>
&gt; Is that code working?<br>
<br>
I did check and with do_compile[noexec] =3D &quot;0&quot; in the bash recip=
e, I see:<br>
<br>
WARNING: /xxx/meta/recipes-extended/bash/<a href=3D"http://bash_5.1.8.bb" r=
el=3D"noreferrer" target=3D"_blank">bash_5.1.8.bb</a>: In a future version =
of BitBake, setting the &#39;noexec&#39; flag to something other than &#39;=
1&#39; will result in the flag not being set. See YP bug #13808<br>
<br>
so it does appear to.<br></blockquote></div><div class=3D"gmail_quote"><br>=
</div>Yes, I did just try it here as well.=C2=A0 I&#39;ve been working on d=
unfell and missed it in master<div class=3D"gmail_quote">when I looked thro=
ugh git grep, my apologies.=C2=A0 I guess there&#39;s still the questions o=
f</div><div class=3D"gmail_quote">just when the deprecation takes effect an=
d if anything should be done with respect to</div><div class=3D"gmail_quote=
">the documentation in the meantime (since it could IMO be argued it&#39;s =
incorrect ATM).</div><div class=3D"gmail_quote"><br></div><div class=3D"gma=
il_quote">Scott</div><div class=3D"gmail_quote"><br></div><div class=3D"gma=
il_quote"><br></div></div>

--000000000000b1754e05cf49542f--

