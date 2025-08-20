Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF365CA0EF8
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 09:30:00 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.15836.1755682193250988528
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 02:29:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LSj5O0o2;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a88de7d4fso48668146d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755682192; x=1756286992; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5lteX7LyJAUtcoQJHuSg9J9veTN15ao/IJnnnoHH3gY=;
        b=LSj5O0o2mJbw6n5Sgp5OeBwPTATvQ4upNBnABsKiaaciTG+Y4ABn8738MlwU2y2OjI
         g0JdXBCW3g86RnFL/fddqfg9mE8b9oE21VCBUcbUVW0Frf9zituhQp9lN+FVEX+Xi//l
         6cOnIDWA7DTjEJjc7rI9ibnZdR5DkA1pKHt3OlRDeMmNPZ78A4VSNkayaj8I1r0WXdMy
         8UcvqZPi1dMVT/AmQtrQxWcPsEtvJzhsNfHAFDTzlm+M0Octa7K6P/N2Ptws3YkDl/iq
         jye1dJrWijImnlgHtdoAcWY3rcextu7TMcnZ2V8DFc4eaWJR7+LGES4nERt6CJr/XIt2
         eM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682192; x=1756286992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lteX7LyJAUtcoQJHuSg9J9veTN15ao/IJnnnoHH3gY=;
        b=iXvBp0XQry2z6LS3+s2Qt4en//RplZwX1BVMZLgXuQa/7dtoMsrkkvnGo7+Fx4Ql3J
         2WzsAVv7gsalyCNv0j3m3V9O+Dw2dt01FjFCy96pV6k2sw+Lced/csZjnyCYR8xnlZGr
         7eWkMyFJkjN5J7O7s5rz+asozKJIJmD756mdCNtgoccEPkPBsspDPHhw9Xi6GS+NMfZC
         f8AN+e4xT4utd6p71U0VqLJbM4kyGKdNdiiVP3KhH3r9hni2KbJSwWiDv6XTcNPvZJyn
         91zOThy82h+K+W9pKQaGfO8waI6f8+XO7VLhtrBV04dx6pXdLAmGJCtIFrQD3ErUJedA
         4uLw==
X-Gm-Message-State: AOJu0YwxO5o6uzqnGzoSLWMlGOoayUHYooq/I5WX9gF4wNaQXv2ecCoR
	mWN9LVKKHjiSxq6HTvAKz0gMoH2RGznBrR4j+S7cXXNR5vq5lXMF7DKbWktSdXPHrNlP8N9VU6O
	Al6fYI2feCNBtCvOJdu8ZEdDmivkpr0Q=
X-Gm-Gg: ASbGncsNVf99/bnY0vuoA2/s7YjqtMv8aVnS9ceRcS3WJE94g/qKZaKAKhoUvHXw4Vs
	x6++KAtT/JbMK4Vfwd/o0hq284PhiJgxMDOde1HYQCiZdvCHGLVnP5R0uqeh4ll/D9dkck++nhH
	hfn4V2UTbSg3un2wHcR55m4enbnX7//bmZp5KAlO0EM/NJsFkr9G1xvLqDtGoIiLHglVEG2UWC4
	XB/WvcxT1BRj2dzF3RRe5B+NANMGi7Pksk5ZlJg2A==
X-Google-Smtp-Source: AGHT+IHQurPW/oJxxM3U0fMLDl8XffnzEqtVt5Dt8asoWdUHVJro2nC33pAofS4zLPebKoY3y612RJ3NUnteeAhayqw=
X-Received: by 2002:a05:6214:c21:b0:70d:6de2:1b32 with SMTP id
 6a1803df08f44-70d7719304amr22035286d6.62.1755682192194; Wed, 20 Aug 2025
 02:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250813151523.1855287-1-alex.kanavin@gmail.com> <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
In-Reply-To: <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 20 Aug 2025 11:29:41 +0200
X-Gm-Features: Ac12FXxUAbEPiEib6p-FODHZIaRXdlpOdv1tjnM9Pds9exHxFBQYDNVk0alaia0
Message-ID: <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial implementation
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Tim Orling <tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 09:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17892

On Tue, 19 Aug 2025 at 16:22, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Thanks for continuing to work on this, I like it a lot and it feels a
> lot better than the previous version. From a "what it is doing"
> standpoint, I think we're getting there. Where it still needs work is
> in the "telling the user what it is doing" part. I say this as someone
> who knows bitbake/OE quite well and I still had to look at the files on
> disk to work out where things are.
>
> A big chunk of this is actually whitespace and formatting on the
> screen. Putting paths onto newlines with indentation will help
> readability, as will some blank newlines to separate out things.

Thank. I didn't polish the UI as I wanted to get the 'new
functionality' out as soon as possible. I also already want to tweak a
few things in the output.

By the way here are the slides I'm going to show in less than a week
in OSS Amsterdam:
https://osseu2025.sched.com/event/25VtR

There's a nice hand-drawn chart of how bitbake-setup puts all the
pieces together in creating a build/conf and layers checkout for
bitbake to be able to run. If you can take a moment and take a look,
I'd appreciate.

> I think we should probably be "properly" integrating into the user's
> HOME, i.e. create ~/.config/bitbake/bitbake-setup.conf and
> ~/.cache/bitbake/downloads by default out the box too, we may as well
> make bitbake appear a "proper" citizen if used this way.

I'm not sure about using ~/.config and ~/.cache.

I introduced the concept of 'top directory' (where everything else is)
on purpose, such that there can be multiple top directories, each with
its own bitbake-setup settings file and site.conf. If you look at the
settings file:

[default]
registry = git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main
dl-dir = /home/alex/bitbake-builds/.bitbake-setup-downloads

there can be conceivable use cases where users would want to have
multiple such files, each with its own registry location and dl-dir
(and site.conf items in a separate file). E.g one for builds internal
to their organization and another for upstream yocto work.

> Let me describe what I think it needs to "say" to a new user and see
> what you think. I suspect the interaction should look something like:
>
> '''
> $ bitbake-setup init
>
> No previous bitbake setup configuration detected. Configure bitbake-setup in /home/XXXX/.config/bitbake y/n?
>
> Configured a common source downloads cache (DL_DIR) at XXXX.
>
> A common site.conf file to use in builds can be created at:
>     /home/XXXX/.config/bitbake/site.conf
> <symlink this into a builds site.conf position?>
>
> No configuration registry specified, using the default of:
>     XXXX
>
> Fetching configuration registry into:
>     YYYY
>
> Configure a build at XXXX ? <let the user change/confirm the path>

The above configuration sequence is fine, except I'm reluctant to put
the settings and site.conf into ~/.config as explained above. Maybe we
could use that as 'default', but also be able to have a custom
location?

> Available configurations:
> 0. yocto-master-nested-configs  (future) Official Yocto configurations: poky, poky-altcfg, poky-tiny, for qemux86-64 and arm64 (defined with nested configurations)
> 1. yocto-master-options (future) Official Yocto configurations: poky, poky-altcfg, poky-tiny, for qemux86-64, riscv64 and arm64 (defined with options)
>
> Please select one of the above configurations by its number:
> 1
> Selecting the only available bitbake configuration poky
> <Add blank newline>
> Available target machines:
> 0. machine/qemux86-64
> 1. machine/qemuarm64
> 2. machine/qemuriscv64
> Please select one of the above options by its number:
> 0
> <Add blank newline>
> Available distributions:
> 0. distro/poky
> 1. distro/poky-altcfg
> 2. distro/poky-tiny
> Please select one of the above options by its number:
> 0
> <Add blank newline>
> Run 'bitbake-setup yocto-master-options poky distro/poky machine/qemux86-64' to select this configuration non-interactively.
> <Add newline>
> Initializing a build in:
>     /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_qemux86-64
> <Add blank newline>
> Fetching into: /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_qemux86-64/layers
>     bitbake
>     openembedded-core
>     meta-yocto
>     yocto-docs
> <Add blank newline>
> New build directory created:
>     /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_qemux86-64/build
> <Add blank newline>
> Usage instructions and additional information:
>     /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_qemux86-64/build/README
> <Add blank newline>
> To start using this build:
>     source XXXX
> '''
>
> What do you think? I'm throwing a few ideas around here...

These tweaks are fine, I'll do them.

> I'm throwing an idea of how to handle site.conf in there, which we
> could use to set DL_DIR and SSTATE_DIR defaults. I like the idea of
> some other bitbake-setup command to change those values. We could
> direct the user to run "bitbake-setup configure" before running init
> for the first time and move that setup piece there? Commandline
> overrides would make this part skipable if we have all the info needed?

Yes, this could be a separate command, but init could run that
sequence first as well when needed. site.conf handling I agree with.

The only sticking point is ability to have multiple bitbake-setup
settings and site.confs which I'd like to preserve

Alex

