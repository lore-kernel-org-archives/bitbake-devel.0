Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B94FC41513
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 21:04:45 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web11.12614.1697663078939334708
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Oct 2023 14:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HcLC+fUf;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7c08b7744so88748657b3.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697663078; x=1698267878; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IsT8mScBfFF5L8kaaTWGp0LGCX4xtIFOAoVSPmaZ5X0=;
        b=HcLC+fUfpN1dVq3qi/w0v5D3fF8W/cv2H1VzEBEvoGWJg7r+ofkIk0YosMAAe9bPUS
         Jh3VOeLeIav7F+iIa+g7y3e6yrAGBpOrcteyKKThBtJgMf3ZyGvD9wqcHRRAUAVsyfqS
         0rhjsKzK1xH9m6Gzz7GAmt+bAW2FEUZckIXP/a2pDeW1VRzzUYMb6clzkCEUCFx0e33G
         Bzx97E3vKjEPiW/NAXYSv/XsdopZZqbYPmWMP60zVsl8ewN6UU6u9I/AOJjNHruGpJba
         wVDTYUZ36ee7GQ/ViJSAEnzS1pPWkHvs9Zoz3CFPrE7TrmhDAPiuAhxvlqO9yhCJxjnv
         eiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663078; x=1698267878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsT8mScBfFF5L8kaaTWGp0LGCX4xtIFOAoVSPmaZ5X0=;
        b=LsxfN+ZfG6WZMGj4gAFrGe6fhw/CNaa7OWKEzoe2BvoRql+40knEv33JtVACPy1Cjr
         ypPuLJXk9LzokzHTo/Ty6iOqf6l+PnoULrhAJUH6Bc6RO2KzZPUqmjuA6OrBWXgpWGUr
         v56mWj0Ka743TpK3LH4XrXpzOKAm3gPXl/B7fq3x+2WNMx+WupV7s2OWbvqdI//wmF1i
         3qQEr/WeQhDru7sfKFTRDrsMfNT2RZXAZlj7N70wWNf4cErxqT6cHQ3EMR/PMRyY/yxY
         Em9DjurK4kpAtFDtP0ndMJ0bc86rxatEisOhDWsxKdqzjuhU3xW6+ZjntfgVZGITk+S5
         pSaA==
X-Gm-Message-State: AOJu0YzWgswbykzFemRbVLqju6QaPQ80+5iB6swBt5pztpBk5W1WvFF4
	XWHO8n7NVuuz5OG69ri3qCmIrcPx9oCOVUVaG7w=
X-Google-Smtp-Source: AGHT+IFPLSekg2+O7rOiC+DFom+civwFsUquJN8tfxSKrofeXNKJOhw7RXJ+l+iP4xuXbdirte4rJXLfHKSCBqqS8Nk=
X-Received: by 2002:a81:a0c8:0:b0:57a:8456:3401 with SMTP id
 x191-20020a81a0c8000000b0057a84563401mr502910ywg.29.1697663078078; Wed, 18
 Oct 2023 14:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231018194605.2710214-1-marlon.rodriguez-garcia@savoirfairelinux.com>
 <CANx9H-Df7sm427L8pB50CfraS_Grx6Sj_TG-jUXTX9Qw=N3S5A@mail.gmail.com> <4bf9819abf3e4ee4879f337fc3d9a90a52a627a5.camel@linuxfoundation.org>
In-Reply-To: <4bf9819abf3e4ee4879f337fc3d9a90a52a627a5.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Wed, 18 Oct 2023 14:04:26 -0700
Message-ID: <CANx9H-DAL0LyPuf3i+8O0KGvuZ=DXaeSvY_JRw-DU-KSw+CoMw@mail.gmail.com>
Subject: Re: [bitbake-devel] [Toaster] [PATCH] toaster: add tox.ini file to
 execute flake8 and test suite
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>, 
	toaster@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b79c96060803fcfa"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 21:04:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15262

--000000000000b79c96060803fcfa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 1:57=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2023-10-18 at 12:51 -0700, Tim Orling wrote:
> > Can you check if you are sending to both toaster and bitbake-devel
> > lists at the same time? otherwise I have a feeling we are going to
> > miss some communication.
> >
> > On Wed, Oct 18, 2023 at 12:46=E2=80=AFPM Marlon Rodriguez Garcia
> > <marlon.rodriguez-garcia@savoirfairelinux.com> wrote:
> > > Added configuration file for tox https://tox.wiki/en/4.11.3/ that
> > > includes flake8 and the test suite.
> > >
> >
> >
> > We do not have tox in openembedded-core and I am reluctant to add a
> > specific tool, as it has a lot of dependencies. I am not aware of any
> > other python based tools that we author which have tox enabled.
>
> I have been thinking about this a little, I first heard of it on
> Tuesday. It seems we need something to execute various pieces of the
> testing and in the autobuilder context, there are other dependencies
> we'll have to install for testing so the fact we don't have recipes for
> it might not be a big issue? On the autobuilder I'm assuming we can
> create a pip environment we can use with the right pieces in?
>
> This tool in theory helps with the answer to the question "how do I
> execute the tests?" as I understand it.
>

tox.ini is usually used by proper Python packages that are intended to be
published to pypi.org. It sets up multiple virtual python environments and
multiple tools.
The use in this case to run flake8 is for automatic python syntax
recommendations, in addition to some Django environment setup.

If we are going to add this, then please add some basic documentation for
how to replicate the testing environment. We are rapidly moving beyond
anything we have done before in oe-core or bitbake.

We normally would have tests in the oeqa/oe-selftest framework, so we are
setting a new precedent here with non-trivial dependencies.


> Cheers,
>
> Richard
>

--000000000000b79c96060803fcfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 18, 2023 at 1:57=E2=80=AF=
PM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org"=
>richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Wed, 2023-10-18 at 12:51 -0700, Tim O=
rling wrote:<br>
&gt; Can you check if you are sending to both toaster and bitbake-devel<br>
&gt; lists at the same time? otherwise I have a feeling we are going to<br>
&gt; miss some communication.<br>
&gt; <br>
&gt; On Wed, Oct 18, 2023 at 12:46=E2=80=AFPM Marlon Rodriguez Garcia<br>
&gt; &lt;<a href=3D"mailto:marlon.rodriguez-garcia@savoirfairelinux.com" ta=
rget=3D"_blank">marlon.rodriguez-garcia@savoirfairelinux.com</a>&gt; wrote:=
<br>
&gt; &gt; Added configuration file for tox <a href=3D"https://tox.wiki/en/4=
.11.3/" rel=3D"noreferrer" target=3D"_blank">https://tox.wiki/en/4.11.3/</a=
> that<br>
&gt; &gt; includes flake8 and the test suite.<br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; We do not have tox in openembedded-core and I am reluctant to add a<br=
>
&gt; specific tool,=C2=A0as it has a lot of dependencies. I am not aware of=
 any<br>
&gt; other python based tools that we author which have tox enabled.<br>
<br>
I have been thinking about this a little, I first heard of it on<br>
Tuesday. It seems we need something to execute various pieces of the<br>
testing and in the autobuilder context, there are other dependencies<br>
we&#39;ll have to install for testing so the fact we don&#39;t have recipes=
 for<br>
it might not be a big issue? On the autobuilder I&#39;m assuming we can<br>
create a pip environment we can use with the right pieces in?<br>
<br>
This tool in theory helps with the answer to the question &quot;how do I<br=
>
execute the tests?&quot; as I understand it.<br></blockquote><div><br></div=
><div>tox.ini is usually used by proper Python packages that are intended t=
o be published to <a href=3D"http://pypi.org">pypi.org</a>. It sets up mult=
iple virtual python environments and multiple tools.</div><div>The use in t=
his case to run flake8 is for automatic python syntax recommendations, in a=
ddition to some Django environment setup.</div><div><br></div><div>If we ar=
e going to add this, then please add some basic documentation for how to re=
plicate the testing environment. We are rapidly moving beyond anything we h=
ave done before in oe-core or bitbake.</div><div><br></div><div>We normally=
 would have tests in the oeqa/oe-selftest=C2=A0framework, so we are setting=
 a new precedent here with non-trivial dependencies.</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div></div>

--000000000000b79c96060803fcfa--

