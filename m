Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EEEC02196
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:44:48 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.12054.1738763081658771956
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 05:44:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dtGhPm4V;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso50453895e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 05:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738763080; x=1739367880; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+P1jvZNw1wv7RXAWypJMyR12aFQXipJd6jtVWgCfXU=;
        b=dtGhPm4VzoBFQZdiTEbMwx5qXUiAV/ZOhv9+PymkdeWGJBQ/yQt5W643eplvMudGGq
         dwCeOk9akslzsdGFCdTnaqCW5GD6C5xXBd+0WVTceUmeXM/oNKHR4/xE0DFN9pfHd5xY
         mMCSyx5Sr8TT0H0u/x09oxqjbLbFes/TiNqOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738763080; x=1739367880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+P1jvZNw1wv7RXAWypJMyR12aFQXipJd6jtVWgCfXU=;
        b=ZNg12WMNv0rT9pCGMKNINg/arwirtV1rLnEqwsZDtl9ZVcj3eTwzuvjwSgXHEWyr4W
         7gMawTMPBCJ3NqSUEXysP1fy4Gz0AK7tWtYYbGlBj3qofwveBGOrucmA4xdWwH9eTKot
         gpBYroy7zyKEWc83+oZAnBpDUVPqIM8GuEESiPWuHIqVajFWnba0dc8pQs4F6Rc8eTAJ
         QIRb6cOLDzMtbtOSrO5DLx/ic9DF51NRt99r3/Yuh7eO3/G6cU2h4w/LZ89zI9xDRrzH
         4fDB4VfhauTcSToBcViIti8vsB6XWqHCGdfuw1oWKYVWR9c+M7BhHjM1rxDRHHrrsjst
         EmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvtjU0rIppwquydLXzWRbelcdVLmT5xmTKcGsRTLTxyl9ejibaMzGn9K/JlE1su8sHmc0v0xLB4PFHtyCR@lists.openembedded.org
X-Gm-Message-State: AOJu0YxoHwUcSp+axRFy3ow3ZVE9HgXccN5FMCz4CzlY1Jmrv0ZExuC7
	AcdLrai4A0gtGz+qhDUA6nVHgs0jAt1vrdLGEjxgELgCTDJ6RA3z5cXr+NUjLqg=
X-Gm-Gg: ASbGncsLkRrmZFwLs8TG/h4KUEdtHGF8TXQxa7MEBNqGureaYBOt6B9pTuVtbJvPlXI
	4ooR/pyKAJDv+w9P5tTPH1UrbJ892D1wfNx6cx9ZU2jFk3QE2HBcYOH26WnJOdE2eNnEyrWjNeR
	9mpCxgXZMO3u5mOInBVdx//3QuutYsDe6O0GyhOjMxt9ZtCbzWccOPKWr5qhij3lZsw+k5WVEZh
	d3W1l0Rbs5UwGiCtVq53iSJmqVFgJDvsfdbXzDI2gkhUz1r9b7MeMesPKGkTDqao6TG1MsvDtGY
	PBPih9mTvB1vcw8Nebp8N9X+tZKd987Lbenu3GSA/87JZC5JGV0/s6vXhOkUELyw0z5GPKZazAL
	Q93ul
X-Google-Smtp-Source: AGHT+IHIxwQBWto8ru8KtB+OPbcoMgxj5qGxYJjtOM9PrgOZrWpIvRY1ITtjnm5P55c8TOOPaMbTcQ==
X-Received: by 2002:a05:600c:1c8c:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-4390d55fca6mr19685875e9.22.1738763079983;
        Wed, 05 Feb 2025 05:44:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:be8c:5293:84c1:352a? ([2001:8b0:aba:5f3c:be8c:5293:84c1:352a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94dba7sm21536525e9.14.2025.02.05.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:44:39 -0800 (PST)
Message-ID: <6e43bf6563a06db487fff96144fd2e61dd3d97cc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] add basic support for b4
 contribution workflow
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz
	 <foss+yocto@0leil.net>, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Date: Wed, 05 Feb 2025 13:44:38 +0000
In-Reply-To: <e81c3992-5da5-42f4-b629-3288c63d00a8@cherry.de>
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
	 <abd86c0a-0c57-4425-b4c0-b8c9ba21cbea@cherry.de>
	 <7b5e158cc6d983ec0aac8c13365572fe5a44b3d2.camel@linuxfoundation.org>
	 <e81c3992-5da5-42f4-b629-3288c63d00a8@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 13:44:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17156

On Wed, 2025-02-05 at 14:38 +0100, Quentin Schulz wrote:
> Hi Richard,
>=20
> On 2/5/25 2:34 PM, Richard Purdie wrote:
> > On Wed, 2025-02-05 at 14:11 +0100, Quentin Schulz via lists.openembedde=
d.org wrote:
> > > Hi all,
> > >=20
> > > On 1/17/25 11:44 AM, Quentin Schulz wrote:
> > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > >=20
> > > > b4[1] is a very nice tool for mail-based contribution. A config[2] =
file
> > > > exists to set up a few defaults. We can use it to set the Cc recipi=
ents
> > > > to always add, in our case the mailing list.
> > > >=20
> > > > This also adds a wrapper script that is called by b4 to figure out =
which
> > > > addresses to put as Cc recipients. Considering that patches to the =
doc/
> > > > directory also need to be sent to the yocto-docs mailing list, this
> > > > wrapper handles that. A limitation of the script (lsdiff actually) =
is
> > > > that it doesn't know how to handle empty files, but those should be
> > > > of rather rare occurrences.
> > > >=20
> > > > While the wrapper script should be enough by itself to add the bitb=
ake
> > > > mailing list to the Cc recipients, one still needs to manually run =
b4
> > > > prep --auto-to-cc for that to happen. Therefore, let's add an expli=
cit
> > > > send-series-cc so that at least that mailing list is always there.
> > > >=20
> > > > Because we currently do not have anything to check for patch validi=
ty,
> > > > remove requirement for b4 prep --check to be run before sending a p=
atch
> > > > series, via disable-needs-checking in prep-pre-flight-checks.
> > > >=20
> > > > [1] https://pypi.org/project/b4/
> > > > [2] https://b4.docs.kernel.org/en/latest/config.html
> > > >=20
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > > ---
> > > > This adds a basic config file for b4 to avoid to have to add the ma=
iling
> > > > list by hand.
> > > > For documentation patches, the additional mailing list will be adde=
d
> > > > when running b4 prep --check, as is required for each new series ma=
naged
> > > > by b4.
> > > >=20
> > > > Note that b4 supports patchwork, c.f.
> > > > https://b4.docs.kernel.org/en/latest/config.html#patchwork-integrat=
ion-settings
> > > > though I have no clue what it does with it as I am no maintainer, b=
ut
> > > > maybe something worth having a look at if some maintainer of this r=
epo
> > > > wants to use b4 to merge stuff?
> > > > ---
> > > > Changes in v2:
> > > > - add b4-wrapper for auto-detecting patches that are to be sent to =
the
> > > > =C2=A0=C2=A0=C2=A0 docs mailing list as well,
> > > > - disable forced b4 prep --check for each b4-managed series,
> > > > - Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c=
4334c36cc7@cherry.de
> > > > ---
> > > > =C2=A0=C2=A0 .b4-config=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> > > > =C2=A0=C2=A0 b4-wrapper.py | 38 +++++++++++++++++++++++++++++++++++=
+++
> > > > =C2=A0=C2=A0 2 files changed, 42 insertions(+)
> > > >=20
> > > > diff --git a/.b4-config b/.b4-config
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..0b699f204c414099f21=
18ffdbc9f7b24454e4a4e
> > > > --- /dev/null
> > > > +++ b/.b4-config
> > > > @@ -0,0 +1,4 @@
> > > > +[b4]
> > > > +=C2=A0 send-series-cc =3D bitbake-devel@lists.openembedded.org
> > > > +=C2=A0 send-auto-cc-cmd =3D ./b4-wrapper.py send-auto-cc-cmd
> > >=20
> > > All the above should be to instead of cc, will fix in next version.
> > >=20
> > > @Richard, is the b4-wrapper.py below (this one for BitBake and not
> > > Poky!) fine in BitBake git repo? I believe it should since it needs t=
o
> > > be called even when one develops from "vanilla" BitBake git repo and =
not
> > > poky combo repo. Just asking for confirmation here (and maybe you wan=
t a
> > > different name too?).
> >=20
> > I guess the location is ok but can we call it b4-bitbake-wrapper.py
>=20
> b4-wrapper-bitbake.py to follow the same naming scheme as for the one
> for poky that is stored in OE-Core maybe?

That makes sense, might as well try and be consistent :)

> > please? This is so that if someone sends patches, it is clear which
> > wrapper the patch is against. Top level files in repos can sometimes
> > get interesting for that, even if b4 should be helping make sure the
> > right patches go to the right lists in future!
>=20
> One could have the interesting idea of contributing patches to the=20
> b4-wrapper-bitbake.py script without using b4, so a unique name across=
=20
> the code bases makes sense to me.
>=20
> Looking at it, do we want the script to be in contrib/ in BitBake repo=
=20
> maybe?

I'd wondered about that and would be fine with it. It would reduce
"clutter" in the top level directory which already has too many files
to me!

Cheers,

Richard

