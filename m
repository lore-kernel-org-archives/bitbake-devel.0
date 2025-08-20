Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB25CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 15:05:01 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.119.1755702292852242791
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 08:04:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BLOlnT+9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so77855e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755702291; x=1756307091; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bKZhIarpW/uZXmN8rBhUQNTl0kvTdZips2upsYjjrxM=;
        b=BLOlnT+9MJjSQKtDtL9fzs/Bo0QcBaZ8zySFQONH0h15NEfHmQGbrs8giEFDdBMPOR
         rCjup+0AgNcp8lhKQVhF3lE/w0qAvnQMVzKvrYFja3UsNpS/fT+JuEG6+OsKnZ2pW7c1
         x5l6wMFJHfrHW0bkYc5OGAC1e1zi5wqypeV5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702291; x=1756307091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKZhIarpW/uZXmN8rBhUQNTl0kvTdZips2upsYjjrxM=;
        b=G1Bu6ujcXapFrLc5wYcLIptmyIlTXnhvxOVEX7R4YhQD8w+2bWN5ZzcIwLCk+qO0PI
         9Z5mplXNDFCvj0OozRilXSJsmo+BwZxaquucX7+tPlW3ymxDFSo8s5DNUMrDETiHk/5C
         6A6C8GU+JSm1elpSBxxG7Y7IbEer5D9r8RH/pe/qTI5sSfXI+N/uu6zmJAKMJ2RyMAq7
         D3u2n04ldVT0E4aFqMxx2RiTWD4GTQzWH9OdKUXPoHKqDfB+dODx3afUs5/ryU9Q++EY
         49oLC1GQ515UY2fh2dhmRZE0o5Nwj/FhzDfYRT5APme+9+AFwtKCqMs0H5whm7lHsctO
         kZ5A==
X-Gm-Message-State: AOJu0YwAeUZQ5zA+BqECJiqdKrZv7ZGcWSGtjkAM/Q8jjnl8ruD6dfgQ
	Zt1tT2H/DT+JVrpzaG6/eoqobCor1BSdmxKAiHkrL9d8KRKNsspfAytXTt2UYhnrscQ=
X-Gm-Gg: ASbGncuIt8dwE72qD93AAEwuHJg7oP2UJrrhe58Dhir/s6Ze7QL7bcdSP1Nr350UF9v
	MHIGFCoKHMWcYIwVaaoE0aTVIQ4bbb840yTqC3psbyBscZ6GQYYTX3n8k+MhWMv2fQtALnWyAZg
	/KngjCrrUuXyfdYH383SNblxua4FBwBQYk38y0kLd+H1+YNhsYcI71qYVoBDTuz/hABK2iT2KZA
	75fecp29WvW3KClhP7mPkPF5okTgeyKGbXujw+lWwPNPei3LlGijmM73lTrDPeX+bt/QrtD3Fun
	g4q0JOiaq2n1S/pg0s6CmtWdvI5vOReRRB/xpDGmJ1cU6AE5+hHFDBlO/ofii0LsTSFBR7Z+x9x
	ItBF/YNAGffHHUAUddpA9qK1lpD07zLpf6SNW7zg4FzJ4muCPMkpjFWDALOP2C5fzUzTlRcjCXv
	SnLTa7FIky495iIaVDnBg5YQ==
X-Google-Smtp-Source: AGHT+IH8l/PMTtq3WUVye6WhCVmlqxh8BPzrnH+ekj/wmFTbOJU7gJNc4WlKNVmMNbd0S87zbH5YVw==
X-Received: by 2002:a05:600c:45cc:b0:458:bd08:72a8 with SMTP id 5b1f17b1804b1-45b4749ab7bmr28751845e9.13.1755702291007;
        Wed, 20 Aug 2025 08:04:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2407:63e0:8092:e22c? ([2001:8b0:aba:5f3c:2407:63e0:8092:e22c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47d8ee86sm33636615e9.15.2025.08.20.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:04:50 -0700 (PDT)
Message-ID: <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Alexander Kanavin
 <alex@linutronix.de>,  Tim Orling <tim.orling@konsulko.com>
Date: Wed, 20 Aug 2025 16:04:49 +0100
In-Reply-To: <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
	 <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
	 <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 15:05:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17893

On Wed, 2025-08-20 at 11:29 +0200, Alexander Kanavin wrote:
> Thank. I didn't polish the UI as I wanted to get the 'new
> functionality' out as soon as possible. I also already want to tweak a
> few things in the output.
>=20
> By the way here are the slides I'm going to show in less than a week
> in OSS Amsterdam:
> https://osseu2025.sched.com/event/25VtR
>=20
> There's a nice hand-drawn chart of how bitbake-setup puts all the
> pieces together in creating a build/conf and layers checkout for
> bitbake to be able to run. If you can take a moment and take a look,
> I'd appreciate.

I will take a look, I can't right now but remind me if I don't
remember.

> > I think we should probably be "properly" integrating into the user's
> > HOME, i.e. create ~/.config/bitbake/bitbake-setup.conf and
> > ~/.cache/bitbake/downloads by default out the box too, we may as well
> > make bitbake appear a "proper" citizen if used this way.
>=20
> I'm not sure about using ~/.config and ~/.cache.
>=20
> I introduced the concept of 'top directory' (where everything else is)
> on purpose, such that there can be multiple top directories, each with
> its own bitbake-setup settings file and site.conf. If you look at the
> settings file:
>=20
> [default]
> registry =3D git://github.com/kanavin/bitbake-setup-configurations.git;pr=
otocol=3Dhttps;branch=3Dmain;rev=3Dmain
> dl-dir =3D /home/alex/bitbake-builds/.bitbake-setup-downloads
>=20
> there can be conceivable use cases where users would want to have
> multiple such files, each with its own registry location and dl-dir
> (and site.conf items in a separate file). E.g one for builds internal
> to their organization and another for upstream yocto work.

I agree we should allow this to be configured, I'm just thinking the
.config/.cache directories might be the right place to put the
defaults. This does move bitbake (or bitbake-setup really) to become
more of a distro/system tool. I'm still not 100% sure if we should do
that but using the standard locations by default would fit with that.

> > Let me describe what I think it needs to "say" to a new user and see
> > what you think. I suspect the interaction should look something like:
> >=20
> > '''
> > $ bitbake-setup init
> >=20
> > No previous bitbake setup configuration detected. Configure bitbake-set=
up in /home/XXXX/.config/bitbake y/n?
> >=20
> > Configured a common source downloads cache (DL_DIR) at XXXX.
> >=20
> > A common site.conf file to use in builds can be created at:
> > =C2=A0=C2=A0=C2=A0 /home/XXXX/.config/bitbake/site.conf
> > <symlink this into a builds site.conf position?>
> >=20
> > No configuration registry specified, using the default of:
> > =C2=A0=C2=A0=C2=A0 XXXX
> >=20
> > Fetching configuration registry into:
> > =C2=A0=C2=A0=C2=A0 YYYY
> >=20
> > Configure a build at XXXX ? <let the user change/confirm the path>
>=20
> The above configuration sequence is fine, except I'm reluctant to put
> the settings and site.conf into ~/.config as explained above. Maybe we
> could use that as 'default', but also be able to have a custom
> location?

I do think making it configurable is fine. I was kind of assuming that
would be the case.

> > Available configurations:
> > 0. yocto-master-nested-configs=C2=A0 (future) Official Yocto configurat=
ions: poky, poky-altcfg, poky-tiny, for qemux86-64 and arm64 (defined with =
nested configurations)
> > 1. yocto-master-options (future) Official Yocto configurations: poky, p=
oky-altcfg, poky-tiny, for qemux86-64, riscv64 and arm64 (defined with opti=
ons)
> >=20
> > Please select one of the above configurations by its number:
> > 1
> > Selecting the only available bitbake configuration poky
> > <Add blank newline>
> > Available target machines:
> > 0. machine/qemux86-64
> > 1. machine/qemuarm64
> > 2. machine/qemuriscv64
> > Please select one of the above options by its number:
> > 0
> > <Add blank newline>
> > Available distributions:
> > 0. distro/poky
> > 1. distro/poky-altcfg
> > 2. distro/poky-tiny
> > Please select one of the above options by its number:
> > 0
> > <Add blank newline>
> > Run 'bitbake-setup yocto-master-options poky distro/poky machine/qemux8=
6-64' to select this configuration non-interactively.
> > <Add newline>
> > Initializing a build in:
> > =C2=A0=C2=A0=C2=A0 /home/alex/bitbake-builds/yocto-master-options-poky-=
distro_poky-machine_qemux86-64
> > <Add blank newline>
> > Fetching into: /home/alex/bitbake-builds/yocto-master-options-poky-dist=
ro_poky-machine_qemux86-64/layers
> > =C2=A0=C2=A0=C2=A0 bitbake
> > =C2=A0=C2=A0=C2=A0 openembedded-core
> > =C2=A0=C2=A0=C2=A0 meta-yocto
> > =C2=A0=C2=A0=C2=A0 yocto-docs
> > <Add blank newline>
> > New build directory created:
> > =C2=A0=C2=A0=C2=A0 /home/alex/bitbake-builds/yocto-master-options-poky-=
distro_poky-machine_qemux86-64/build
> > <Add blank newline>
> > Usage instructions and additional information:
> > =C2=A0=C2=A0=C2=A0 /home/alex/bitbake-builds/yocto-master-options-poky-=
distro_poky-machine_qemux86-64/build/README
> > <Add blank newline>
> > To start using this build:
> > =C2=A0=C2=A0=C2=A0 source XXXX
> > '''
> >=20
> > What do you think? I'm throwing a few ideas around here...
>=20
> These tweaks are fine, I'll do them.
>=20
> > I'm throwing an idea of how to handle site.conf in there, which we
> > could use to set DL_DIR and SSTATE_DIR defaults. I like the idea of
> > some other bitbake-setup command to change those values. We could
> > direct the user to run "bitbake-setup configure" before running init
> > for the first time and move that setup piece there? Commandline
> > overrides would make this part skipable if we have all the info needed?
>=20
> Yes, this could be a separate command, but init could run that
> sequence first as well when needed. site.conf handling I agree with.
>=20
> The only sticking point is ability to have multiple bitbake-setup
> settings and site.confs which I'd like to preserve

See above, I'm fine with making it configurable. I'm curious if others
have opinions.

To be clear, the patch set is making huge progress and I think we're
getting there. I'm really happy with the direction. As ever, the detail
is now what we need to get right but it is very much going where I
think we need it to go/be.

Thanks!

Cheers,

Richard



