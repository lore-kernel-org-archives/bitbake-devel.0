Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7ECCA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 14:22:54 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.15973.1755613372304812425
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 07:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R9tbOeq/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so2583202f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755613370; x=1756218170; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hhzQeuddC7oEm6WRT0DAPg4ch1s3ylHBWE6uPM779QA=;
        b=R9tbOeq/26Z2XX0HpErIbAAbWCrImZAo1WmsCCPLiA8r9dLC4nTCx4QPNe0eBmgEUL
         fNRJPDiDzYW4HWHpakXywzGzY1/sDMCOsCRy6v/ukzPcL2oEZhqXqW2efrUcd1C0CLKZ
         FZR0YmlxzzbH349gS2Isupb89D7yb8OUBDlXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613370; x=1756218170;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhzQeuddC7oEm6WRT0DAPg4ch1s3ylHBWE6uPM779QA=;
        b=LCeFimc29W00BNfqGjhrc0vPZgbD5SVi0Qkv+YJ8YaRzHt9HEDvcYJVWAfyESU0+M/
         OIU0NuuE4dwggaulIHith5OHIFuObzmVE+6vb/vyHNDjLUoLeyp/HLt9GvNJC1/THt+J
         dCdtV/bchrVSbvWojQFZjC+ZI6dXB9gyYiCRd4aWrX8xLjeAmVnZ6yQZ+Bke2FW7kJET
         atTByBkT5YYp5c8pItOseXOLkrDu26Dx3CW/KsmEA0nRwbf3KN/WsDfMJCrn6PBvYQum
         VwFiP9G4ElrQ1QW3WGv9b5u9WrWj6ayd73NNU/5z3eUfeDpQ3Q4gbk/O99VqYL5ENM3W
         hEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyILHjq+hHOa38vY6VGSNhn+eEN8lr37xxAPeuu3Aei0cItXwDUHuT7vdoyMxeTtzOHAijkRKSh0gmRvvc@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw0fYqdXAeCZPsqD6xfsO04g2ctMzzi12sIRpCzHz6wiHUrQrlh
	gELom0i3EhHIhgTKq96tnL9abqMurfHEUA41wxrI7CQriy1uExFo1RSIvsPxPIx2v8I=
X-Gm-Gg: ASbGncv+i9uAK68lYRK/hqztEXyNgRhJ2ssxuLrrk88wFNJLq25ahuRCB4rMPLm59x8
	sSHkvv0SYnP4Rs0cWAnYkCk5fdFATO0xI6PHiAPXLLIGIByd/ZW+QRctd8Dr54TpSyblji748Fr
	Ta566TXsIVVjFZJ++ptilN7E3DGQBi9kJUpBUn7v26lfToil2U32s3t59IHb+y7UK//fTZsgc63
	gbXo78Gb63q/x/3hA8bTU0X0ju62VsIOGvN/DPNyEn6vVKUdYhth/slvacB+uzlpwvgWZMv2x3p
	X05XdMhHzna8cBa87CRnlYekCGQyI40l0EpmdCA2VQSRPlvXCthS3bwmGzItBY3wjH1sR7b1ZuA
	JRLNqztaKNGWRdtAu0QReiGWJZKW9pAWYkE3Avuwnd0Y2sBoq26MzwCidB7nbjshCdeUuK+e0qv
	AB4tC1iehK5pjZHJh1oarGWg==
X-Google-Smtp-Source: AGHT+IHwYDniHyoWpfQsfS+QsQmSKbAb2r5H2UXwlbBQ9gWadrkm+cMomRaIOi8rSTzZI5w3X3+BXA==
X-Received: by 2002:a05:6000:26c2:b0:3b9:1684:e10 with SMTP id ffacd0b85a97d-3c0e6f4ec63mr2013825f8f.23.1755613370160;
        Tue, 19 Aug 2025 07:22:50 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80? ([2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c07496f3f5sm3865625f8f.12.2025.08.19.07.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:22:49 -0700 (PDT)
Message-ID: <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Tue, 19 Aug 2025 15:22:48 +0100
In-Reply-To: <20250813151523.1855287-1-alex.kanavin@gmail.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 14:22:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17889

On Wed, 2025-08-13 at 17:15 +0200, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> Preamble
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The latest iteration of this patchset is available at
> https://github.com/kanavin/bitbake
> I recommend taking the patches from there to ensure that
> you are not trying out outdated code.
>=20
> For the rationale and design guidelines please see this message:
> https://lists.openembedded.org/g/openembedded-architecture/message/1913
>=20
> Left out for now but will be done later:
>=20
> - handling site-specific settings. There was a discussion about it:
>=20
> =3D=3D=3D=3D=3D
> > Finally, a question, how do you recommend to handle my local SSTATE_DIR=
/DL_DIR?
> > Setup with bbsetup, copy a site.conf with these config inside the build=
, then
> > the proper build? ... or is there a better way?
>=20
> This is an unresolved question. I'm open to proposals. Or code.
>=20
> I guess it will be something like 'bitbake-setup change-setting
> default site-conf /path/to/site.conf', and then bitbake-setup will add
> that to every build that is initialized. Site.conf need not list site
> settings directly, it too can add a fragment maintained in a layer.
> That way CI settings can be specified and maintained in a layer, but
> they don't need to be added to a json config, as that would impose
> them on everyone using that config to reproduce builds locally.

Thanks for continuing to work on this, I like it a lot and it feels a
lot better than the previous version. From a "what it is doing"
standpoint, I think we're getting there. Where it still needs work is
in the "telling the user what it is doing" part. I say this as someone
who knows bitbake/OE quite well and I still had to look at the files on
disk to work out where things are.

A big chunk of this is actually whitespace and formatting on the
screen. Putting paths onto newlines with indentation will help
readability, as will some blank newlines to separate out things.

I think we should probably be "properly" integrating into the user's
HOME, i.e. create ~/.config/bitbake/bitbake-setup.conf and
~/.cache/bitbake/downloads by default out the box too, we may as well
make bitbake appear a "proper" citizen if used this way.

Let me describe what I think it needs to "say" to a new user and see
what you think. I suspect the interaction should look something like:

'''
$ bitbake-setup init

No previous bitbake setup configuration detected. Configure bitbake-setup i=
n /home/XXXX/.config/bitbake y/n?

Configured a common source downloads cache (DL_DIR) at XXXX.

A common site.conf file to use in builds can be created at:   =20
    /home/XXXX/.config/bitbake/site.conf
<symlink this into a builds site.conf position?>

No configuration registry specified, using the default of:=C2=A0
    XXXX

Fetching configuration registry into:
    YYYY

Configure a build at XXXX ? <let the user change/confirm the path>

Available configurations:
0. yocto-master-nested-configs	(future) Official Yocto configurations: poky=
, poky-altcfg, poky-tiny, for qemux86-64 and arm64 (defined with nested con=
figurations)
1. yocto-master-options	(future) Official Yocto configurations: poky, poky-=
altcfg, poky-tiny, for qemux86-64, riscv64 and arm64 (defined with options)

Please select one of the above configurations by its number:
1
Selecting the only available bitbake configuration poky
<Add blank newline>
Available target machines:
0. machine/qemux86-64
1. machine/qemuarm64
2. machine/qemuriscv64
Please select one of the above options by its number:
0
<Add blank newline>
Available distributions:
0. distro/poky
1. distro/poky-altcfg
2. distro/poky-tiny
Please select one of the above options by its number:
0
<Add blank newline>
Run 'bitbake-setup yocto-master-options poky distro/poky machine/qemux86-64=
' to select this configuration non-interactively.
<Add newline>
Initializing a build in:
    /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine=
_qemux86-64
<Add blank newline>
Fetching into: /home/alex/bitbake-builds/yocto-master-options-poky-distro_p=
oky-machine_qemux86-64/layers
    bitbake
    openembedded-core
    meta-yocto
    yocto-docs
<Add blank newline>
New build directory created:
    /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine=
_qemux86-64/build
<Add blank newline>
Usage instructions and additional information:
    /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine=
_qemux86-64/build/README
<Add blank newline>
To start using this build:
    source XXXX
'''

What do you think? I'm throwing a few ideas around here...

I'm throwing an idea of how to handle site.conf in there, which we
could use to set DL_DIR and SSTATE_DIR defaults. I like the idea of
some other bitbake-setup command to change those values. We could
direct the user to run "bitbake-setup configure" before running init
for the first time and move that setup piece there? Commandline
overrides would make this part skipable if we have all the info needed?

Cheers,

Richard







