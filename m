Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2DDCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 22:44:36 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2360.1762901067620808284
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 14:44:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FpDZj6gI;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471191ac79dso2037605e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 14:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762901066; x=1763505866; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/6Gi9xGBxeQayBKdSIRwB7yhix/3Hf72o0bdforJxBQ=;
        b=FpDZj6gIQV2qGabEWL+tlDj6pvxh3Q1PMaPWVxwmFtyNl4dqdW0J0KHkt4pOvBDEV0
         VeGnAiZf5pHawgjAyY+NthHzfvKTG+89KGxcXueoYxQ8GW2g/51vFf5aRqeVhBQeAxnh
         795IKXTTVB4OajhKbIOW3zGM7fmoQaRaPMMZNi/zQ5jbXF3yXD6ENxTMtdzi+vjzi6xQ
         7FUjdNnJy8H39ArxkH4Lc4GmeIaZxRG2VEbbzLmJc2CqTJpjiy7c/a/p+8W6WpxxWvC9
         EIYlluhYLQHFy29AhnkWmgVxiQEaSzPO8Ze+Rfg4XZZjcA1ktETVriMO6TGEV3GRhZVw
         Dypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762901066; x=1763505866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6Gi9xGBxeQayBKdSIRwB7yhix/3Hf72o0bdforJxBQ=;
        b=LcKUj0lCnbX6V5rsqI9JOCm76tbCv17atWjv1OAjpqhxEWR7bbfjKjwa1AlmsM+RFs
         5FFEi+weVKjl0xD2VFIBWuSP2WVXt6qfcxaTgR2BkTos/pasemEiMlXYJ0hgb/dZxeEp
         cHH4AdM2gF6/3HgC0I+QiEgaxdyWby+kq3Y633oEoIt75y6CpcroMxHXTsR8xGFP2Rp2
         dGj0zLaFA/ZqW06dbjIVrmh7EN+a2cgF3VJpPikQqQZBprhuRt6BdVcKjXm72d5skL8n
         OV5wjCUbLA6Du7zYf1cL7O/bvANUQgIkfirhYvfkZg2oqhl+ZOBFFc8rCpdpBx7z6UHQ
         3/bw==
X-Gm-Message-State: AOJu0Yx+XIx3snfYQCD7jV2U5p65Cm9AsovUOjrfNlQfgcrzdH2Dza8V
	j4cyJC0DrqXtHuroJJ8bQlYORY7yDaTOUy3e9aezVq/ju7kwahfWpF4g
X-Gm-Gg: ASbGncvD7sO6elTdJtyhRwES3l95/FxmruPefDQmHTNrTvfNvZ1eEJJK8OYHIKMve26
	7t+b3t+3bIjE7yVw3XYMKAngVDDpXvjQG/D+tIatoPL1JWaDtxAqYC4ihKYqSk7D/Mj1sRasalj
	iSS7q5RfB04ort/ho4BxHHSz1AJ5Cu3PdXYl2DWKTmcyfHMxp6k27y/49GKz0mK3jNnZEHG+thn
	pMJ6HUKsZiy9HeW3LCP/MOpEVjbKVdzPIn2W85D/l3L061UsVOPy4gFaNidKXnvroa2vvpVssJ+
	m+wXT3QGolmn/4k6RslXz7eo9lpGbBnP6FHJVp5Q9wwbBsMKXgRl7CJS1Dyfh9phDo0PHoFk2AK
	fYRaAe5X3T4Q6fws+PFvppZTf8R+4Ozw3a5z/pN0/+/JsSQIaF3cuqNDs7UvbtOEyxIpCqdrnJP
	FVLF1Mh6Y8bcINWFtaCEDjMXXfMlu3P3U0eGH3b+qHWePrB70Biw==
X-Google-Smtp-Source: AGHT+IEAFfVL8G2MVTFLcv5d7FCnTg4xJVRIa/wqfoMiv9sC2lHvFaQsN3ZU3mB/wPZai49VuY2eCg==
X-Received: by 2002:a05:600c:a41:b0:477:df3:1453 with SMTP id 5b1f17b1804b1-477870a66c6mr9372655e9.28.1762901065807;
        Tue, 11 Nov 2025 14:44:25 -0800 (PST)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b30dd4d86sm21869673f8f.26.2025.11.11.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 14:44:25 -0800 (PST)
Message-ID: <ca1702deed8121bbff7a1a0e7c22634817fbd65b.camel@gmail.com>
Subject: Re: [bitbake-devel] My bitbake-setup testing notes so far
From: adrian.freihofer@gmail.com
To: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Nov 2025 23:44:24 +0100
In-Reply-To: <CANNYZj_yCNufCfYC8BgcZQkepyYrvPfe0qUz9k4WX-csC6jzYg@mail.gmail.com>
References: 
	<a94dfade878b881bbd8c0524a99675983b8b20da.camel@linuxfoundation.org>
	 <CANNYZj_yCNufCfYC8BgcZQkepyYrvPfe0qUz9k4WX-csC6jzYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 22:44:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18340

On Tue, 2025-11-11 at 18:51 +0100, Alexander Kanavin via
lists.openembedded.org wrote:
> One thing from the tech call that should be written down is that
> top-dir-prefix should default to '.' (with code and tests fixes to
> ensure this works, as tests set top-dir-prefix to some tempdir). This
> would match the common expectation that tools write to cwd if not
> instructed otherwise. If anyone wants to take this, I'd appreciate.

Here are some patches to address this:
https://patchwork.yoctoproject.org/project/bitbake/list/?series=3D40256

Adrian

>=20
> Alex
>=20
> On Tue, 11 Nov 2025 at 16:17, Richard Purdie via
> lists.openembedded.org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> >=20
> > I've noted down a summary of my recent bitbake-setup testing notes:
> >=20
> >=20
> > "bitbake-setup update" moves local.conf changes out the way. I
> > think by
> > default there should be a warning about out of date conf files and
> > a
> > y/n to move. There should be a command line option not to do this
> > as it
> > really isn't what most users expect/want. I do understand why it is
> > doing it from an upgrade perspective.
> >=20
> >=20
> > As Joshua mentions, we should just error for non-global settings
> > that
> > won't do anything.
> >=20
> >=20
> > When we set a top level dl-dir, it should filter down into DL_DIR
> > in
> > the builds, we do want to share that.
> >=20
> >=20
> > There is a related issue with sstate-dir (and maybe hashequiv DB?)
> > not
> > being shared between builds by default. We have an opportunity to
> > fix
> > this right now.
> >=20
> >=20
> > The message:
> > 'Bitbake-setup is using /XXX/bitbake-builds as top directory
> > ("bitbake-setup settings --help" shows how to change it)"'
> > is misleading. If you run that, if doesn't tell me. I need to run
> > bitbake-setup settings list and know which one to change.
> >=20
> >=20
> > I'm starting to wonder if there should a "--quickstart-help" which
> > lists a set of examplecommands to run like:
> >=20
> > bitbake-setup settings set --global default top-dir-name poky
> > bitbake-setup settings set --global default dl-dir
> > /media/build/sources/
> > bitbake-setup init poky-master poky distro/poky machine/qemux86-64
> > --setup-dir-name build
> >=20
> > The reasoning being to give people an idea of needing to set some
> > global values for thing like dl-dir.
> >=20
> >=20
> > When I run init, the I should be able to edit the default build
> > directory name more easily. "poky-master-poky-distro_poky-
> > machine_qemux86-64" is a little nonsensical in that I can change
> > DISTRO
> > and MACHINE in a build without changing the build directory. Could
> > we
> > simplify the default? Should we give the user a hint about how to
> > change the MACHINE/DISTRO? I think we do want to be able to
> > encourage
> > users to switch some settings in their builds.
> >=20
> >=20
> > For settings, is there anything other than the default section?
> > Should
> > we perhaps default to default to simplify the commands?
> >=20
> >=20
> > We also don't have a good way of mimicking something more similar
> > to
> > the older poky layout with bitbake-setup. The autobuilder is the
> > closest on that but with some horrible commands, I think we might
> > want
> > to find a way to allow that more easily/obviously.
> >=20
> >=20
> >=20
> > Any one of these issues in isolation isn't a blocker but together,
> > they
> > all make the experience a bit jarring and not what people are used
> > to
> > from us. We get one chance at users of the tool, I think this will
> > break it.
> >=20
> > I do probably have more thoughts, I'll try and keep more notes as I
> > go
> > and find things. I'm sorry not to have come to some of this earlier
> > :/.
> >=20
> > Cheers,
> >=20
> > Richard
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18333):
> https://lists.openembedded.org/g/bitbake-devel/message/18333
> Mute This Topic: https://lists.openembedded.org/mt/116239397/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

