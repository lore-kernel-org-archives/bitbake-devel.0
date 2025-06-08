Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BCAC5AD49
	for <webhook@archiver.kernel.org>; Sun,  8 Jun 2025 21:35:51 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.45803.1749418543778629645
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Jun 2025 14:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Z+Id/ZfK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so43218155e9.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 08 Jun 2025 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749418542; x=1750023342; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ny2AQXCZ2h1J/8BCN5Fapc14dJux0RiYR7p69jIE6Sc=;
        b=Z+Id/ZfK+yhQhbqViRabgAEaj9iyC1LZ39GMe7NH+YLZEDDguOPtZLJ8sINvyzWfmH
         sFJPlQ2FslOLtuJj+YDy45vfcZvoDLyfp2orGsq0WklxdVMPNM4HjOuCwEW4tnZaWhYy
         CQfipl8Yqz/VTnq4HZchxO5w0JDkc1bORh/Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749418542; x=1750023342;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ny2AQXCZ2h1J/8BCN5Fapc14dJux0RiYR7p69jIE6Sc=;
        b=BaCmVkTGfhGWB1GUe+O6pUJYBuAu6ySc+sPSHCqF9Al75C2BQJgIf74PPDE/Zb3ZsC
         QrKmtjBTA+QB4RVUh8qCFlTkOe1jryK4plzPTWOy6B4WhAZWq1MacU9dyJvzIOx1Y5JL
         O0+goXOqqGD0YcvY5PbOxZUy3xvm1hOhlhxzg6FXhM2iEbox5gGtAH349TpvSxJePDP2
         fVvDtJ30cDuuwK4nfvEAHIgFFKNJxofkHiFxq1/B4j9xrm4S4oBNGkcOILioRC8IEImx
         b3QVhvhIRxLZG9XWLT1rU5Ee9koUzZIMKu1/1rHeBEZdJedxMSJwjm2WLdjhECvwMx/G
         ArGw==
X-Gm-Message-State: AOJu0Yzxiy18bi1gxn0G+fyOtqYxTvlnSNrj9H8bbyQtS4nTXH0U4aGG
	sx52JTEl+OobXU6r8pJgGJd34clDMaixggvTSdzjT5A1H1c+5rFLCeLl0BcgUJLrXvI=
X-Gm-Gg: ASbGncuDa4dOhKEZbOYPX5zyVg840oInMswJ2OYT4Lyc5jjrn2BRZVkZNPtoL8HeuDc
	d8TuhS+p+xUtI2Yx2SFLj6DCMqct/XrQzFIvffftp9uTOMjSks4HtEI8PhgJ0nhu5eHlosAx9Ln
	gQRRZZSQcR3W02Np09RVIW0j0qxNuYzsZgBsfOCYEp2QCUNOaHEmtejo1ZpSOL0OmbB5/uXHcV4
	t3rtsAUHqGvzBS0V7LeJ6DwqKIo56A+SmNd/B84YbjuqXUKGPBeypqpnDGFKsMOR+dXFO46Dnzh
	XU8438IZMI+9/Juqoc8+fCH4WeO4PHlT6fGriGspsQHLViwBbkcXjYnT3od7BzfAhIBdK3KwnXk
	XSwjYdlcpQMHZVzJvCfbbraDhkG5JgPNNls8YuP/kSqr6Li3C
X-Google-Smtp-Source: AGHT+IF7a68r1zXM/IY8n3EQyUfK/J6HlxkHwxh4ICzmsIKvW63qiUl4emu9RXh16JGvQUjuvDNkMw==
X-Received: by 2002:a05:600c:3d94:b0:43d:fa59:a685 with SMTP id 5b1f17b1804b1-4520141bbe1mr86191735e9.33.1749418542126;
        Sun, 08 Jun 2025 14:35:42 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d119:abb1:116:3de6? ([2001:8b0:aba:5f3c:d119:abb1:116:3de6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209bc6c6csm94128335e9.2.2025.06.08.14.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 14:35:41 -0700 (PDT)
Message-ID: <518ee0f0eef4e155c93ccba344a5ea1e6102b37b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mike Crowe <mac@mcrowe.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sun, 08 Jun 2025 22:35:40 +0100
In-Reply-To: <aEXier1YxgCzOv1F@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
	 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
	 <aD2ByO73juj7zy7I@mcrowe.com>
	 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
	 <aD3TP6hIE9vvFaAo@mcrowe.com>
	 <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
	 <aEXier1YxgCzOv1F@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 08 Jun 2025 21:35:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17688

On Sun, 2025-06-08 at 20:20 +0100, Mike Crowe wrote:
> [
> =C2=A0Snip explanation of building first for MACHINE1, then MACHINE2, the=
n back
> =C2=A0to MACHINE1 again with the same PACKAGE_ARCH and relying only on th=
e task
> =C2=A0hashes being different to ensure that the right files end up being =
used.
> ]
>=20
> On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> > > > > > My guess is that the problem here is that the stamps from the f=
irst
> > > > > > machine build weren't removed during the "SECOND MACHINE BUILD =
1" step
> > > > > > above. If I remove them myself then the problem goes away. Is t=
hat
> > > > > > theory correct? If so, then I can start trying to work out why =
and any
> > > > > > advice would be welcome. If that theory is not correct then doe=
s anyone
> > > > > > have any idea where I should start investigating?
>=20
> On Mon, 2025-06-02 at 17:37 +0100, Mike Crowe wrote:
> > > I was hoping that someone would just know the answer to my first ques=
tion
> > > above off the top of their head. If so then I'm willing to try diggin=
g into
> > > this myself to see what I can discover. I just need to make sure that=
 I'm
> > > chasing the right part of the problem.
>=20
> On Monday 02 June 2025 at 22:04:39 +0100, Richard Purdie wrote:
> > I've avoided answering this as I think you're right but I'm not 100%
> > sure and I don't want to send you off in the wrong direction. There are
> > reasons it might not wipe out stamps and those reasons may be
> > intentional but without looking at what is going on I couldn't be
> > completely sure. So I think you're right and I'd chase that way but...
>=20
> It turns out that you were right to be hesitant.
>=20
> Stamps are only removed if they were generated by the current MACHINE due
> to oe-core#5634f2fb1740732056d2c1a22717184ef94405bf from 2018:
>=20
> > sstate: Ensure a given machine only removes things which it created
> >=20
> > Currently if you build qemux86 and then generic86, the latter will
> > remove all of the former from deploy and workdir. This is because
> > qemux86 is i586, genericx86 is i686 and the architctures are compatible
> > therefore the sstate 'cleaup' code kicks in.
> >=20
> > There was a valid reason for this to ensure i586 packages didn't get in=
to
> > an i686 rootfs for example. With the rootfs creation being filtered now=
, this
> > is no longer necessary.
> >=20
> > Instead, save out a list of stamps which a give machine has ever seen i=
n
> > a given build and only clean up these things if they're no longer
> > "reachable".
> >=20
> > In particular this means the autobuilder should no longer spend a load =
of time
> > deleting files when switching MACHINE, improving build times.

Well, that makes sense and I think that change still makes sense. It
does raise the question of whether/how we could detect your scenario
and give better information to the user (and/or error?).

> I'm not sure if the situation the change describes can still occur.
> genericx86 (which is presumably what was meant by generic86) no longer
> seems to exist and TUNE_PKGARCH should be either i586 and i686, so the
> stamps and work directories won't overlap with each other.

genericx86 definitely still exists:

https://git.yoctoproject.org/poky/tree/meta-yocto-bsp/conf/machine/genericx=
86.conf

however it is now core2-32.

That doesn't mean the architecture issue can't exist but the default
tunes have changed. genericx86 and qemux86 still probably share
architecture compatibility and one would try and remove the other.

> This commit was also in Dunfell though, so the next question is why doesn=
't
> Dunfell suffer from the same problem? The answer surprised me: Dunfell
> appears to have been looking for mismatched stamp file names (for me at
> least).
>=20
> In Dunfell, the build for MACHINE1 creates a stamp named:
>=20
> =C2=A01-r0.do_populate_lic.sigdata.14708a9f021d264f7c0a9c5c33a93417c6cb20=
ba936c5805ff96083a9cb05ee9

"sigdata" files are information only files and not actual stamps. This
file contains stamp information but is not the actual stamp itself.

There are two possible versions of the stamp, either setscene or non-
setscene. On my local build, for linux-libc-headers I see:

./core2-64-poky-linux-musl/linux-libc-headers/6.12.do_populate_lic.73e166a4=
f76ae90f2785472dac9e88264c920aaf98ac2b43b71e0e4b9bec8469
./core2-64-poky-linux-musl/linux-libc-headers/6.12.do_populate_lic.sigdata.=
73e166a4f76ae90f2785472dac9e88264c920aaf98ac2b43b71e0e4b9bec8469

but I could also see:

./core2-64-poky-linux-musl/linux-libc-headers/6.12.do_populate_lic_setscene=
.73e166a4f76ae90f2785472dac9e88264c920aaf98ac2b43b71e0e4b9bec8469

The sigdata file provides information on the 73e166a4f7 stamp hash.
Stamps will have zero file size.

> The first build for MACHINE2 creates a stamp named:
>=20
> =C2=A02-r0.do_populate_lic.sigdata.23cae22087dda59b5d9aad048411200dd4a3ab=
b3308a241f9a89be65b7071d01
>=20
> Yet the debug log for the second build for MACHINE1 contains:
>=20
> =C2=A0DEBUG: Stampfile /.../build/tmp-glibc/stamps/aarch64-oe-linux/licte=
st/1-r0.do_populate_lic.14708a9f021d264f7c0a9c5c33a93417c6cb20ba936c5805ff9=
6083a9cb05ee9 not available
>=20
> It's looking for the stamp file without the ".sigdata" in the middle and
> doesn't find one.

It wouldn't ever look for something with sigdata in it. The code
doesn't really use sigdata files, they're there for debugging.

I suspect in dunfell these files are created somewhere else in stamps.
I have some vague recollection the do_populate_lic files were somehow
shared between arches and we dropped that idea but I don't really
remember...

Cheers,

Richard

