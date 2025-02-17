Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEEAC021A9
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 12:43:59 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.50218.1739796231811133938
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Feb 2025 04:43:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DmoYZ5CS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so1915965f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739796230; x=1740401030; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnbThpu2FgeXbKCDl/0h2brJ3hIkwTpNk/p0MnXuA3I=;
        b=DmoYZ5CSOeNQ7B9U+zdRXg4d5OHYwmKQ2SQalk/em3hrZftoR0m8dXoJRqwd/Aww9y
         RtatNmNH+JBSBbnxJfkbWQYbtMQGAY6Qx9PmCwfnJCeY6pcr5dkh/RDQFw8eOkZ3utnF
         dlF7+JoUyJTfyIZRQtbEFt5xoUWcMhVhjerGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796230; x=1740401030;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnbThpu2FgeXbKCDl/0h2brJ3hIkwTpNk/p0MnXuA3I=;
        b=k3IGKpqRk9f3Nu4H8NThJ+NXsTGai3V3qIOTobr9/HA3tvG/qpMcS3QzsQBk4JRqsy
         +09giLdrydFEXPqdWXeZHvSnaCd760mAeCe3JJPWIy8MyQTnjz2vQXsKqXornZf0m/zL
         vGrYQ61Ps9/p233XYAMboqMGgP2EZS1X3G44r6BuqI8voRynSe92PqAFJWdxSVdtdMwc
         seuOirk1/NeW2kyVw7jVNOZ71n92sY+VjSNuF4IWF5ArDYclZRoVVS3mDZGUKIbQxoOH
         zcbx//e7Mh2sAcYlKPzo/oHkkxP4ltxJR65slv1n2X75rMRdDWxBg/9QdnS+eADgVLrM
         tFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRPLdPQ9sai9ZUepBcwhQmZjczhvPMSQDisbv6n8P2fHR3ZQjbLCMN4054s4/t7QfbNioJWhRozYyM3I5N@lists.openembedded.org
X-Gm-Message-State: AOJu0YwdSv07/f65Ad6y/8Re9A30xqZFDM5Tq2b6YnzdEAyRQuvnTHvc
	mk2pT3DawbGQxF51lz3+Lflt3jXJksxlu6DNFyF+3BtYGnK65qQvmOm2F5e7bIw=
X-Gm-Gg: ASbGncuQK+qNxJAuKYiQib3YCN5cnkwSD1xske/KVhHDhGquXIk/SSIGQwAJ7zl1c+p
	N44zFuDdzW5ak6MPt5AdFujmE6PGQCzJ0G+OlzeKEaE9MWg+qLH0xLa0NO6xVqUr74a/ZAbL5xN
	LwpKW44fGmVV+tqrKSMkWSOk9LNUKyBCX4E3+Ju2kuZSubhb2yya60aiT2I+qNiRFkXxDWOedni
	69h0U1ElMCAq63bUComv+kmjIHaRRCtOvB17YpOm6BnJX0z4+9eC51+ByRgW/Zt61tqgvc14G1P
	H6YvG/LwhRfss1pzMt46TfjZcSduNV6vhS3rTmYJ6XMoxMMYgKO/EqcEnLwuwjmwPT2PFGCXW34
	0r8TT
X-Google-Smtp-Source: AGHT+IGWMAV5WJUBi1rUZcIUO0HOPVVYgMIjDntnPXz6gAiMxCleybYHkaWy7me6JX2SKKtqzrm6/A==
X-Received: by 2002:a05:6000:1f87:b0:38f:23f4:2d7a with SMTP id ffacd0b85a97d-38f33f43751mr9181376f8f.40.1739796230203;
        Mon, 17 Feb 2025 04:43:50 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:12f2:fcaa:2c32:45fc? ([2001:8b0:aba:5f3c:12f2:fcaa:2c32:45fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc7ecsm12022251f8f.49.2025.02.17.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:43:49 -0800 (PST)
Message-ID: <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	openembedded-core@lists.openembedded.org, Bruce Ashfield	
 <bruce.ashfield@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Feb 2025 12:43:48 +0000
In-Reply-To: <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
References: 
	<4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
	 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 12:43:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17233

On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:
> =C2=A0Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openembedde=
d.org:
> =C2=A0
> > e) add the ability to add custom hooks in the fetch process to
> > handle
> > the cases of needing to alter the flow for patching the components
> > list
> > =C2=A0
> I fear this isn't easy possible and we have a design problem. Bitbake
> and oe-core assume that a patch doesn't influence the fetch and that
> the SRC_URI contains all fetched sources. Many code use the Fetch
> class or the SRC_URI direct and doesn't expect recursive implicit
> URIs of gitsm. In reality the SRC_URI describe the given URIs only
> and doesn't contain the additional implicit URIs. The task flow
> applies patches after the unpack and prevent patches to the gitsm. In
> reality a patch could influence the implicit URIs and isn't
> independent.
>=20
> I would recommend to keep the patching outside of bitbake and instead
> handle the implicit URIs inside oe-core. We could write the implicit
> URIs into files in the work directory and migrate the scattered
> direct users of the SRC_URI / Fetch class to a common oe-core
> function. This functions returns the given URIs and optional any
> additional implicit URIs. This allows the usage of the task
> dependencies to ensure that the implicit URIs are resolved before
> use.
>=20
> The package manager lock file needs a single unpack and patch step
> whereas the gitsm needs a recursive unpack and patch of every
> successive gitsm. This makes it impossible to use additional tasks.
> We could add the resolve of the implicit URIs to the fetch task to
> support recursive resolve (gitsm).
> =C2=A0
> 1. download SRC_URIs
> 2. exit if no URI is marked as unresolved
> 3. unpack unresolved URIs
> 4. apply associated patches
> 5. resolve URIs
> 6. goto 2=20
> =C2=A0
> This will eliminate the need for the partial implicit URI and gitsm
> support in bitbake and makes the fetcher code simpler. The patching
> could remain in oe-core and patches could be applied to gitsm and
> package manager lock files. Additionally we remove code duplication
> and simplify future changes to the SRC_URI determination.
>=20
> It will add an indirection for the SRC_URI but the current code
> already shows that this makes problems. Only the archiver class uses
> the expanded_urldata function and all other classes including the
> spdx class ignore the implicit SRC_URIs.

I'm a bit worried we're getting caught up by the terminology. We don't
necessarily have to "patch" the component list so much as allow
something like a function to hook and adjust things. That then removes
the need for it to be a specific task.

I'm also not sure that drawing gitsm into this is a great idea when it
is effectively already working  quite well. I appreciate the desire to
have neat abstractions applying accross everything equally but I'm not
sure we can achieve that with the level of usability we need and I'd
rather improve usability at the cost of the inclusion of gitsm, which
is the most functional fetcher we currently have in this group.

I will repeat again that I do strongly feel that a strong API in
bitbake is going to lead to an overall better design that something
bolted onto the fetcher in OE-Core.

Cheers,

Richard





