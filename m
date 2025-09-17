Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2201FCAC5A0
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 22:33:07 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.42.1758148383618486397
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 15:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G41lHgRs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dec026c78so2711605e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758148382; x=1758753182; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7tMaHV6pb8E88PTghCJg8R+To4kHvkTgSdsB5gzwR8=;
        b=G41lHgRsL2Eiz+ME6ZYKpHAWzR+JJM8SPtcYZAohU2vZ0s8aeD/dk6OjJ/h2osfM42
         vKqJJszo2PGkWiWnkfcrcnxFTGwGgLB1mVaE6PlwLSaZDMkilWAFJkvGWTZ32zeWbmRB
         p7mI8gga810dElwLjjQReY4QWAj5jkYmL0vU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148382; x=1758753182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7tMaHV6pb8E88PTghCJg8R+To4kHvkTgSdsB5gzwR8=;
        b=VmP3e9Yjis43+LlvbE+4y0X/BOihismu9lMRPZ+fDdnWtG6T2njAeM22dY3QDTB/22
         GPrDR+SfJvDj3pBfPmLhtTLokESSylfs1o+RZbk3LIRdt9M+SaFGAqdyHGmgahU7TQo7
         fYaePg0r177oTWdJ1op0riCbvPQTFqQZb/8zhXdLicFFdzcMC74OwX8pNV919ydir0F4
         1kaEpHnA6dwix16Bxwbmo84yJ/SHe/cgx1GkPB7hLFE5olfNfjw9JD7eYKfN/hPkpzsB
         GWagosci9HqSG/whJm4gts8RICt7zDkwGgaA/clk27JQdZWJR8P9PgMYrvRCuB/nd8/5
         W5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWtwKGv3wlnNNJFKxeC9fXyF8/PxmDVi1SvQCDtNUCMAlNmfrT9J0a6sH6ytQt0CtUuIonhdYuENg/hhbyV@lists.openembedded.org
X-Gm-Message-State: AOJu0YxUz8T2ih8Iwn30RiRqzY2ST10JTE91+VPfl9TYIARFCVxtIi7t
	r4+PouBOXzYeVxfRBANsLl1mi9iowF7QYwThezPiKagsI1Yli120vCH7cYB+h9KzetO9DJ87/A4
	/cDkQ
X-Gm-Gg: ASbGncv/TLSYAnEos7sH51jlCHrlaQcYZKnj6ow76Bl1WxjDcqFLK01RJacRRsTrPgF
	w0At4Wggurb9OKyBjCl+z45Gny7svbU8q/WQpL7q+wTaIxJllzvBOxzm/vU3Y9N2TAjwgNevfIK
	AQ4LuS6jnJHOFvJD2xjYK101rkrg62U6q3COx3wWwa3DtN7sr09hmQ3nc+gKX3LkLGoiLOKvefZ
	DwzSeSSrZW26dH6JoyFbDaQfyJL0/3Amo567M5LKG4DmGKYK+PQSjtZTZ01kfHz5cxEzmqipCpt
	vW5zNaJgL7myBm2L2UVPjWNEk7zdkuoGYe4ZHe0rxxhNK7IkpPJ0fF6iozU9Umq5mv9LCJkEGtt
	uJAhVcRUloXwEvUEmkMsJHxz6eJXmUiWCPOqcACUt/lWSml4M4Mo5R//jz+itP0mTC6BBpBFGr0
	TZr2YwqJsOUmwYaF+gQmZyL8Z8niyOvpPlmfyxRwbh
X-Google-Smtp-Source: AGHT+IFG2c89QdEDMDXUM22Gx2k53J/jpvMBP0ypr+bCXl57xcgaL9E23pRArkICL9RFOFjRAx/dwg==
X-Received: by 2002:a05:600c:444c:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-46207897e75mr35767555e9.36.1758148381988;
        Wed, 17 Sep 2025 15:33:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a42a:bde0:2db0:730d? ([2001:8b0:aba:5f3c:a42a:bde0:2db0:730d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm52342115e9.21.2025.09.17.15.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:33:01 -0700 (PDT)
Message-ID: <e47db6c5eab25b2614139d9c33fe7e253962ceb8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [yocto] Documentation around adding custom
 fetchers to layer
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, yocto@lists.yoctoproject.org, ross.burton@arm.com
Cc: "seth.raymond@matrixspace.com" <seth.raymond@matrixspace.com>, 
 bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Sep 2025 23:33:00 +0100
In-Reply-To: <CANNYZj-Sk_VEMa8--q-s3G6KP1zih5KqZC4uv5WJzAd7sQrzzQ@mail.gmail.com>
References: <tEoU.1758053094260077183.1RYf@lists.yoctoproject.org>
	 <9EEFEABC-1B2A-4C76-B0CC-0E0CADAEB744@arm.com>
	 <CANNYZj-Sk_VEMa8--q-s3G6KP1zih5KqZC4uv5WJzAd7sQrzzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 22:33:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18058

On Wed, 2025-09-17 at 11:19 +0200, Alexander Kanavin via lists.openembedded=
.org wrote:
> On Wed, 17 Sept 2025 at 11:15, Ross Burton via lists.yoctoproject.org
> <ross.burton=3Darm.com@lists.yoctoproject.org> wrote:
> > > I'm not seeing any documentation on how to add a custom fetcher to a =
layer, and the fetchers in poky don't provide enough information on how to =
register these fetchers. Is this functionality supported, or will we have t=
o fork poky and keep it up-to-date to add a new fetcher?
> >=20
> > This is a bitbake issue, so I=E2=80=99ve copied in the bitbake list.
> >=20
> > There=E2=80=99s no standard way to add out-of-bitbake fetchers, as you =
say you need to add the fetcher instance to bb.fetch2.methods.
> >=20
> > I guess you might be able to write a do_fetch prefunc that creates an i=
nstance of your fetcher and adds it to the list, but I would not be surpris=
ed if there were more places where that would be needed.
> >=20
> > python use_my_fetcher() {
> > =C2=A0 bb.fetch2.methods.append(MyFetcher())
> > }
> > do_fetch[prefuncs] +=3D =E2=80=9Cuse_my_fetcher=E2=80=9D
>=20
> To be honest, I was going to say that custom fetchers are not
> supported. Doing that would fragment the ecosystem and make people
> invent all kinds of private magic in their builds, and subvert the
> promises that standard fetchers make.
>=20
> Perhaps it would help to step back and look at what this customer
> fecher does. Can we see its source? Or an extended description of how
> the password manager is used, what data it takes and produces, and how
> that data is used in actual fetching? Then we'd think of how to do
> this with regular fetchers.

I'm struggling with time/bandwidth so I'll just mention what I can
remember without digging too much.

There have been cases of successfully injecting extra fetchers from the
metadata, particularly if you do it from the global class code,
probably in an event handler. I think some of the early npm/node/crate
code did this (I don't remember which) before we merged things into
bitbake itself.

There was an open bug for making it easier to define new fetchers from
the metadata and we did get most things working. Sadly I can't spot the
bug. The one area that was problematic was AUTOREV since that happened
before you could inject the fetcher in the class code in some cases. We
never did work out an API which would allow AUTOREV to work and allow a
general API.

Cheers,

Richard




