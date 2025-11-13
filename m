Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FB0CD8C85
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 15:13:39 +0000 (UTC)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26180.1763046813483014646
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 07:13:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VjMMlmW/;
 spf=pass (domain: gmail.com, ip: 74.125.224.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640f2c9cc72so734782d50.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 07:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763046812; x=1763651612; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M07J+jhVJeByuREkfuTaVlSswD9mr+oQ614s5xfJPls=;
        b=VjMMlmW/t2p2AC0Xomm81+/N0AAA1OZr9unEY/HAV+XbyZWK83mJIx5wN5izZDLBfn
         Um7fAwnPHoH4VodTzlVYoqb/QmRlIP0GYEeuuMq+NIt9dypko78vrq3xONrqSgtwLx3A
         eMav5JaoloITp6Q3A+BDpHsZWncUn7u2aJ+J9QDffMcjtEmn/Z7yBoPYzuXN06N16+C/
         cHNo9YB170zAYfS+x1m6yTM3lcwaYzB0XsD3WUFAX631ucoVfNB/obu6PPKq4Sq45fwt
         dLm8+BwmVXlqgGnGuG7YcJhAK7EaRNPtrvc0KNWVeNtzsoYAmdGBZRSnYf+81kQ5effb
         wppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046812; x=1763651612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M07J+jhVJeByuREkfuTaVlSswD9mr+oQ614s5xfJPls=;
        b=X+dFg3g2xXFQyabgL6j+uT5Jyo1HmirYJdI7rTIRqbQfeh2CroduqdFxwMIaOdDacn
         GviJN27RpGKqlXqzdgVL/FmnRWnThdN2LJq1jvGl+IVNeP/idU2NoVcPAnoDsOnUgceH
         hI0fZi/CbYzpa5lLlVVrMLJeI0YrKx0noMDx35Z0EQrNgGg9knqQ9lUciyzdRmLQMk1p
         0Tx7EQepgTb3lhFI7XGhNqpIva67SdjkNwHXTAr9wBDaMQiwVeKWE8IpXOjeNtzQWROo
         VzlAdBQZagRWdPO5PCW8vNyuGWn8ANbOLbZ2tMxmn2V0EQcPQT3Ba4n5o2Q0XEalBZA6
         LAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyeMsiRjpcR9wawwNzunB5TF4hnr61jdPFq0wc1XxMR4KsS0iY+kGvjVrZMznAD3NnieazCDkQkspyOrsy@lists.openembedded.org
X-Gm-Message-State: AOJu0YzuRiTcdf4A4aqTK7eAT93w+Xb4e9imHNqcnlLGDxFc2rD05DIp
	4jOQqPz0POtbYqf5lfGmPjRHnHqOD5oHhneosGq9pOqImdfGScMd3sZg4M0hkzXuFYBt8HTWx3O
	Wg/7E6EVqc7LZF9Tu3z+TxSUxfwj4p30=
X-Gm-Gg: ASbGncvkaalw3+oANwKkb2y2i0iUWY7hFEWqxTIMHE5DsmDeoNv3ZVy93vRLhIPTa7X
	p85KVQ/HfwdHBFCjnXX7ISafMtucRFUStbh9XC42dqxaFzbvyYSJDtYv1EMypsZmCwyscjSATDd
	puheo1EWa4og1FxEuCx8wM8M1Yt+LSMnsL0m5HytmeJT30fPa8qIH5yR1mnLEnplb3E6Kv0AZq7
	m+XLiV6hWchN6s41M+ZKYKHZMIf6Uosu5guX5SL0dx5KQ53KJl3LrEI6xQ3Nbanb2xm8thp0Bw=
X-Google-Smtp-Source: AGHT+IHype07CIeQ7wT/5Yy7VOAvQwGEihbpz6Uzo/CfvbQNDgkUbOqvxVRKERg6vwwtlDAGr6DCywR93XB7N8eh4PM=
X-Received: by 2002:a05:690c:610d:b0:787:ea39:6656 with SMTP id
 00721157ae682-7881361a243mr117350507b3.22.1763046812311; Thu, 13 Nov 2025
 07:13:32 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
 <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
In-Reply-To: <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 13 Nov 2025 08:13:20 -0700
X-Gm-Features: AWmQ_bmuyPCXwzaXl9INypfQhsVulD9AEvfISCAHDLZd0j5pK72wiqhIgQRpHkg
Message-ID: <CAJdd5GaU0ANma4FLB4wdhLXVQAxHbBOdEGELLE=yXhyhHQT4Sw@mail.gmail.com>
Subject: Re: bitbake-setup steps for release
To: Paul Barker <paul@pbarker.dev>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex.kanavin@gmail.com>, Ross Burton <ross.burton@arm.com>, reatmon <reatmon@ti.com>, 
	Robert Yang <liezhi.yang@windriver.com>, "antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 15:13:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18376

On Thu, Nov 13, 2025 at 6:18=E2=80=AFAM Paul Barker <paul@pbarker.dev> wrot=
e:
>
> On Thu, 2025-11-13 at 11:16 +0000, Richard Purdie wrote:
> > Hi All,
> >
> > Huge thanks to everyone who has sent patches. Having multiple people
> > looking at this and sending them has allowed "parallel processing" that
> > is really moving us closer to release.
> >
> > The review call agreed with the patches on master-next and that those
> > should merge. Not all are perfect and there will be some further tweaks
> > needed but they do move things closer to where we need to be.
>
> I think we're making good progress so thanks to everyone who has helped!
> More testing and feedback at this stage would still be really
> appreciated to make sure that bitbake-setup meets the needs of different
> users & developers.
>
> > There are some things we all thought still needed fixing before
> > release:
> >
> > a) The update command needs to prompt y/n on overwriting bblayers.conf
> > or local.conf and give the users a choice. We need a way for users to
> > update the repos with one command, we can improve the conf file
> > upgrading later.
> >
> > b) There should be a --no-conf-updates (better naming?) to the update
> > command
>
> I suggest --conf-updates=3D[yes,no,prompt] with 'prompt' being the
> default. 'yes' means update without asking, 'no' means don't touch the
> config files, 'prompt' means ask separately for each of bblayers.conf
> and local.conf.
>
> > c) The default build path should not include the machine name. Ryan
> > mentioned his previous patches which have the concept of a format
> > string, or we have a include y/n piece in the json config. Otherwise
> > you can end up with multiple elements like poky_poky.
> >
> > d) We need to tell the user how to change the machine/distro layer as
> > nobody knows about the bitbake-config-build command. Mention "bitbake-
> > config-build enable-fragment machine/XXX" in output when running the
> > tool.
> >
> > e) Add a comment into toolcfg.conf to point at the command to change
> >
> > f) Catch conf file configuration of MACHINE/DISTRO conflicting with a
> > fragment?
> >
> > I'll let anyone add anything I've missed.
>
> I'm still struggling to use bitbake-setup while hacking on bitbake &
> openembedded-core themselves. I've always had permanent working
> repositories in my home directory and more ephemeral build directories
> under a path like /mnt/build which may be thrown away when no longer
> needed. My home directory gets backed up but my build directories don't,
> so I don't want to do my work inside the layers directory created by
> bitbake-setup.

Perhaps bitbake-setup needs a build-dir equivalent to top-dir that
specifies where the build directories get placed (using the same
setup-name scheme)? If unspecified it would just default to top-dir.

>
> I'd like to be able to override the sources specified in a bitbake-setup
> conf.json file without having to create and manage a new conf.json file
> myself. I'm imagining a command line argument that I can pass to
> bitbake-setup, perhaps --local-override/-L, to drop the "git-remote"
> settings for a given source and set a local path:
>
>     bitbake-setup init -L bitbake=3D~/src/bitbake \
>         -L openembedded-core=3D~/src/openembedded-core
>
> I don't think this would be difficult to support and I think it'd be a
> usability win for developers. I'd like to get this in before the release
> if we can, otherwise I'm going to be hand editing bblayers.conf and
> fighting against the tools until we have something in place.
>
> We will need bitbake-setup to remember that sources have been overridden
> so that running `bitbake-setup update` does the right thing.
>
> Thanks,
>
> --
> Paul Barker

