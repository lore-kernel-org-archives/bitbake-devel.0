Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D34C531DC
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 10:00:12 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.12803.1724407208707709627
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Aug 2024 03:00:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L8wdvrpk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42816ca797fso13907495e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724407207; x=1725012007; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ic/pzG4Ul6Cfc0PqdytK0IhXEPT1FgNNviJcYe/5SD0=;
        b=L8wdvrpkwX0QuLs3YxZtEFQZLanPTQR4G7XzTukGxJMYZC0d9SlFX975zj5eGB63X0
         WYsCAWcXK6dV39cY+GDoDSk5q2JMYadlIPrTfKO4kPpg+0Pn5lnXnoD9Vo0Th7v0Qtn6
         pzFpfThJP9/tyj2cNi9DR1QmtLycrrH0Ma20w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724407207; x=1725012007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ic/pzG4Ul6Cfc0PqdytK0IhXEPT1FgNNviJcYe/5SD0=;
        b=C2nuteX1VY1twgl9SY4UfZQo/HlrVbyuYPZR+ONxSbkVCl0oJY4SRpUVVnc1Rd/YrH
         1OmDOQI9T5R4G/gTz/ugs0KSUqVK+dNJ3blFQwPUpD8W77BuAhndm3FCgr8Pq2L6dVQn
         8+J0J6zCIMSF3lNXASvyD56zSiTb+iTFg+7tLM6jQnJ2eSD/aPAT6paBGTPfGI98Zhr7
         vBMSerSolysiAih+qUHtgVCtFXtmYe10FfJ2HCqzfuF4NuyvBtND2sWe80ehMe3UXaIy
         MOlTjOjFSv2VT10uw3VlICE/Cdp4NZ2DiXV0lNO0NB4EznlV+9cE2GYIdrOwbmtj+cUy
         udBA==
X-Gm-Message-State: AOJu0YzMwtwYHJml4HdI+FrCst1GjgLRVF9v18B9Oar9DL6Lr3KTGVbz
	XXoMAQp/+VC8Tc3cgJxRYAFe4RW0Qn1xrUc3WgwvX7/DhHJZ8Yk7IyHEalSu75Y=
X-Google-Smtp-Source: AGHT+IFKNK5eSgFakmRu49xPY7twKQTMtasVnzBqElYa1SUd61HZYcOgp0r+qaWzPXEMnLMIGQnH6Q==
X-Received: by 2002:a05:600c:3b90:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-42acc8d35e0mr11426635e9.6.1724407206794;
        Fri, 23 Aug 2024 03:00:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f4f5:df28:3cf9:5842? ([2001:8b0:aba:5f3c:f4f5:df28:3cf9:5842])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeba89a5sm92592815e9.0.2024.08.23.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:00:06 -0700 (PDT)
Message-ID: <05b7ed5485e4e6f8c8740e75813a2e890048d599.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] [RFC PATCH] bitbake-setup: add the
 proof of concept implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, yocto@lists.yoctoproject.org, 
	openembedded-architecture@lists.openembedded.org, Alexander Kanavin
	 <alex@linutronix.de>
Date: Fri, 23 Aug 2024 11:00:05 +0100
In-Reply-To: <CANNYZj_iodZF96JEnnUi6_fa5_CqO1UGhZSHYur=iKWjbMA=yQ@mail.gmail.com>
References: <20240502105745.3073153-1-alex.kanavin@gmail.com>
	 <17fdbe98636e4e93ba2f7dfd52e294d2fb479ff3.camel@linuxfoundation.org>
	 <CANNYZj_iodZF96JEnnUi6_fa5_CqO1UGhZSHYur=iKWjbMA=yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 10:00:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16522

Sorry for the delay in replying to this. There are multiple reasons, I
partly wanted to try and give time for others to experiment with this.
I'm all too aware that when something merges, there will be a ton of
"complaints" about choices that were made. I'd hoped by giving people
time, they might be able to experiment with it but that clearly (and
sadly) isn't happening. We'll therefore have to make do with our best
guesses and instinct.

My first comment coming back to this is that I don't think we should
default to $HOME/builds as that is hard to discover (I got there via an
error message). I think we should error saying the user hadn't
configured a default and tell them how to, or to use --build-dir. That
implies the tool will need some user config file, but I suspect we're
going to need that anyway.

I'd also note that:

"bitbake-setup init poky-alex --build-dir /xxx/poky-alex"

crashes (i.e. when the dir =3D=3D config name).

On Wed, 2024-06-12 at 10:46 +0200, Alexander Kanavin wrote:
> On Mon, 10 Jun 2024 at 13:22, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > From the init command, it isn't clear what build.sh is for. I think it
> > should also mention the traditional build env file too, make it clear
> > where that is.
>=20
> The printed note is: "Run path/to/build.sh to build using this configurat=
ion."
>=20
> Can you suggest a better wording (I have ideas, but want to hear how
> you would put it)?

I think the init process needs to tell the user what it is doing.=C2=A0Part
of our aim here is to shortcut things for the user but to also give
them the option of learning how/what to do for themselves.

At the moment you get a load of git clone output but not a real idea of
*what* it does. I'm thinking improving the output to something like:


**** Cloning OE-Core and layers ****

Cloning XXX to /dest/path

[git clone output]

Cloning XXX2 to /dest/path2

[git clone output]

**** Configuring build defaults ****

Adding layer XXXX

Setting up configuration in /dest/path/local.conf

**** Summary ****

Metadata setup in directory: XXX
Build directory configured as: YYY

Shortcut environment: ". /xxx/init-build-env"
Expanded environment setup: ". /xxx/yyy/oe-init-build-env <builddir>"

Run path/to/build.sh to execute the default build targets for this configur=
ation
or source the environment to run builds from the commandline.


We can always have a quiet option for people who don't want some of
this but I think it should default to telling people what it is doing
and in particular, *where* on disk it is putting things which I think
is my real aim here - let people navigate.

> > I struggled to find the --build-dir option to init, I tried to specify
> > a direction as the next parameter but that has to be named.
>=20
> I wanted to keep build-dir as an optional argument, so that users
> don't have to specify it and the tool will decide for them.
>=20
> This can be re-done as an optional positional argument (with
> nargs=3D'?'), but then everything else would have to be done via named
> options (e.g. picking one configuration out of several - note the json
> nests the config in ['bitbake-setup']['default'] to allow for multiple
> entries and alternative tools in the future).

I suspect leaving the option is probably the best option but we need to
resolve the "default" issue as mentioned above which is perhaps my
bigger concern.

> > For the cloning of repos, I wondered if we should have some config file
> > in HOME with a pointer to a central downloads/clone cache? The
> > autobuilder will certainly need something like that. Whether we could
> > use a common cache with DL_DIR remains to be seen too.
>=20
> Having a tool config on disk crossed my mind several times, but I left
> it out from the prototype due to uncertainty about how writing to it
> should be handled by the tool. There is a spectrum of possibilities:
> from a rich 'git config'-like UI to handling it as a strict read-only
> item that needs to be manually created and edited. The config could
> contain other entries which are currently hardcoded in the tool=C2=A0 and
> can be overridden from command line, e.g. the location of the default
> configuration repo.

I think we're going to need some kind of config even to resolve the
issue above so this is going to be a must have.

> > I'm not sure I like the build config being moved out the way when
> > updating. The tmpdir "ABI" and conf file versioning should protect us
> > from the worst problems?
>=20
> Yes. The tool could back up the previous build/conf when that has to
> change, but preserve everything else in build/.

I like the idea of backups and leaving it around. In theory we should
have compatibility.

> > Also, once you're "in" a build environment, can we can bitbake-setup
> > without parameters, i.e "bitbake-setup status" and "bitbake-setup
> > update"? Effectively that means teaching init-build-env about the
> > environment it is in so that bitbake-setup can then read the right
> > config from the env.
>=20
> Yes, I'll look into it.
>=20
> > For demo purposes it might help if we could add a "poky-ng" config,
> > which would be poky, but built using the config from the individual
> > bitbake/core/meta-yocto/docs components. That shouldn't be too hard to
> > add?
>=20
> I think so :)
>=20
> > I'll be experimenting a bit more but I wanted to give some feedback now
> > I've taken a look.
>=20
> Thanks :) I can do a v2 once we settle the above points.

Hopefully my above answers make sense.

> Irrelevant but hopefully amusing implementation note: I've written
> this with 'nano' like pretty much everything else over the past 25
> years. I'm that first person in https://xkcd.com/378/=C2=A0.
>=20
> Don't be shocked, I have reasons:
> - too lazy to learn a 'real' editor or install an IDE. Emacs in 1998
> made a *really* bad first impression, sorry.
> - lack of 'modern' features like syntax highlighting, code folding,
> cross-referencing etc. forces me to be concise and get to the point,
> and don't write more code than I can fit into a single brain (or that
> can be read from a github webpage and fully understood that way).
>=20
> I can fumble my way through vi when I'm forced to, but otherwise nano
> all the way.

I'm not shocked at all, I use mcedit a lot myself :)

Cheers,

Richard

