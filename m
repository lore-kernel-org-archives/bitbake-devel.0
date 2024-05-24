Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C492C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 16:28:50 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web10.34.1716568129798813255
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 09:28:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V5ZTRFZC;
 spf=pass (domain: gmail.com, ip: 209.85.161.44, mailfrom: raj.khem@gmail.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b2a2ef4e4cso4785227eaf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716568129; x=1717172929; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agQQ4J0zNPPJOfj+u47BkaM2oLgBvotRcehNAXJgApM=;
        b=V5ZTRFZCUE0JJRTpJt8w9ERaHPe8W8/6biZ3EkE7tRi5hXWsElpH55UKNOi1r8sDKi
         CwTwMhD24PF1qjpt8/NuwkYiFkKBLCYsOAhrFKgIc0D1zDzEuWa28pQXNmvkET8QWoLs
         erVfRSEMBrdZZpmxB/ZGiGMxvK0p6U8Lhi5umSK7RNgYa8hXKZM9WY7Sh0YuNtqZoM7v
         l64+eBHZljXH/5VLACpmW2U3bIcsROdHcBPrCXcx+Eg5JJXhUeDUjRfqrPMvwHRc2iGz
         MyNiC+aYtFtraUuwd2Iy6CtFTa8krJDK2NoN7Pmb0+y+x5cv+X7fx/eyBQdqWdXwI52I
         UCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568129; x=1717172929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agQQ4J0zNPPJOfj+u47BkaM2oLgBvotRcehNAXJgApM=;
        b=s0sF4kqP9KPZxYLrl1KR6KymgeYJDxapA4GmHXzPBKXyU8Bk+bA2digNTpSl0GHK7o
         B3l/tbP6L0vLSzBjeCWgOb6CESvo3lUeLVaS7C6TOTZgVdNb/AOoPKpkbEOKpO61EBWM
         kED70LXXnU+iJwzjUgJjrJxr8yNlZLCwB455ooQaJrB5qm3DJBKjExoS405zTNaWhHR3
         IctzvxOuXS3nr/F9UrO8QPpPPyIP/9X4n2MHtfKYigTYMOIvxCs6XeK/j8hYEceq1G3M
         hW8DoylBIx53/JP5G21wOuAp09uc/Pea5n5tbesAAlqtOB+zAAM2ukNZSOUWzeJ4qx5U
         Ztig==
X-Forwarded-Encrypted: i=1; AJvYcCWQ52XY4V5O/nlZTFCXk1WPCAHTN0EtmgbmY3wt2b1s2Iac1Qn81pJis/s2V/U1JsVsO558dblxGalSF1fBRwZ4ebbI3nICBLWJNy5iZPIxmsvckvE=
X-Gm-Message-State: AOJu0YxYAMnuKto0UQpiquam0xY365+dQf1PO7Sihw36Osw82g4y0ylu
	hTuHqLhxVViYSIjRuv6Hs0FBWffx/geBh4Wo+2ZHcUiR8rOYlgYDTYR+/ZoKirYhl2TBFEyAGjv
	0seEDxZUEzx/adc5sK0A78l0VlDc=
X-Google-Smtp-Source: AGHT+IGpKXsCCx+arOAgpTboFIz+xZfI3/sJxfZvIjh2IV+YWVc3uzzD2BoUG6cC/wt0bPaiMVHVcr9dIol72fO/Q4k=
X-Received: by 2002:a05:6870:d107:b0:22e:c434:ec with SMTP id
 586e51a60fabf-24ca1498cf5mr3045128fac.56.1716568128955; Fri, 24 May 2024
 09:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
 <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com> <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de>
In-Reply-To: <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 24 May 2024 09:28:22 -0700
Message-ID: <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: foss@0leil.net, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 16:28:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16264

On Fri, May 24, 2024 at 8:33=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Khem,
>
> On 5/24/24 5:18 PM, Khem Raj via lists.openembedded.org wrote:
> > On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
> > lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> wrote:
> >>
> >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> b4[1] is a very nice tool for mail-based contribution. A config[2] fil=
e
> >> exists to set up a few defaults. We can use it to set the Cc recipient=
s
> >> to always add, in our case the mailing list.
> >>
> >> This shouldn't be necessary if we had a script that b4 prep --auto-to-=
cc
> >> could call to find the mail address(es) to send to. While we could do
> >> that, this opens the door to people trying to add a way to notify some
> >> people (e.g. a MAINTAINERS file) which is not somewhere the project
> >> wants to go right now, and this also makes sure the address is always
> >> added even if one forgets to run b4 prep --auto-to-cc (which is part o=
f
> >> the typical workflow for U-Boot and Linux kernel, but is not necessary
> >> thanks to this patch).
> >>
> >> [1] https://pypi.org/project/b4/
> >> [2] https://b4.docs.kernel.org/en/latest/config.html
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> ---
> >> This adds a basic config file for b4 to avoid to have to add the maili=
ng
> >> list by hand. For documentation patches, one will still need to run
> >> b4 send --cc docs@lists.yoctoproject.org
> >> manually for sending it to the docs ML as well.
> >>
> >> Note that b4 supports patchwork, c.f.
> >> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration=
-settings
> >> though I have no clue what it does with it as I am no maintainer, but
> >> maybe something worth having a look at if some maintainer of this repo
> >> wants to use b4 to merge stuff?
> >
> > I use b4 regularly for meta-openembedded maintenance and it also update=
s
> > patchwork when patch is accepted, I have this config.
> >
> >     [b4]
> >      pw-url =3D "https://patchwork.yoctoproject.org/"
> >      pw-key =3D "<mykey>"
> >      pw-project =3D "oe"
> >      pw-review-state =3D "under-review"
> >      pw-accept-state =3D  "accepted"
> >      pw-discard-state =3D "rejected"
> >      send-series-to =3D "openembedded-devel@lists.openembedded.org"
> >
>
> Thanks for the example! Would it make sense for me to add the pw parts
> to this patch as well (in a v2 for example)?

Maybe, it can be documented like this but I would leave it to the maintaine=
rs
to promote using b4 not.

>
> I'm perplexed about the pw-key though. This is very much something we
> don't want to version nor potentially leak by mistake. I assume it is
> not possible to add to the global ~/.config/git/config or ~/.gitconfig
> because the URL would change for example between projects (I assume we
> may have a different patchwork for OE and YP, but for sure if people
> maintain kernel stuff as well, then they would have one for kernel.org
> for example). Mmmm but maybe a simple
>
> git config b4.pw-key "<mykey>"
>
> from within the local git repo would be enough :)

right, it must be documented clearly. setting up b4 is not simple like a pu=
ll
request merge.

>
> BTW, I see you have -to instead of what I sent (-cc), is there a
> preference here? (I took Cc since this is what we document in the README)=
.

I used --to because at times to field was being left empty.
>
> Cheers,
> Quentin

