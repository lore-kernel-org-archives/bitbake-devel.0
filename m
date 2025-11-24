Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB6CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 18:54:09 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24498.1764010444442879459
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 10:54:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gNSwhn7j;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-882360ca0e2so36312326d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764010443; x=1764615243; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF3xO9ya0xn8KtqFhlIxBxUMtsngskcFDdPO7AmUdPE=;
        b=gNSwhn7jTE7qbkorY5rHG8/mXjUtwepP+xiaN+SvmRvjR/q5s2wHajpDpzkhdH1AJL
         D1cUvjT4nBR+Ln10B5kCmZ08nvzHfj939CCdwcCmm+CPmMf2Z/IZKLXf9vo22rfrf2YL
         KQZacxpvhhoOw6ni8pZefp6u0JWc35CgQfuMs/gprmUA5AQ3vRaUWC6lmM6VbJzq3ovU
         eyTKaaD0LV2MgCMu1akJJOE5jbjRuGWRr4ZJ2kzqP3b/AZlNdbSvSi9NothpVeUQN8Qb
         I7ffD6vqNnMhisZYHhaX4upPpG1ZG9LLL//XIajWgfyLuJXP+z6lNGLNoLqIheA+8KPK
         2HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764010443; x=1764615243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xF3xO9ya0xn8KtqFhlIxBxUMtsngskcFDdPO7AmUdPE=;
        b=CjmEzqdB8W9bUwAFJuJITPH2sBiz3brrydQWK5ULxnG9YjTc71j4tvOHnSuZsXUWH2
         MbBXLjwd4hhbsFJHkcKdSIkP0ldNl6H4Flt6lzdbv3rCWCWCCnAIXCJ5sS2NVx8RGBSt
         oeNgotEr0AnAKiPRuCf4gTgkdBP2v5dsqOhaA2oTwy+1HItfZ61V3N/x6VfWhHJKO5zv
         XKeE/g2AOWhe+lDRBU6/RYfeuMO1GWdGvIpvdfV1g1QzRo2bNiyVlH4kBy/6OvakNn9Q
         pcUad4msr2F1U6dmgwlE4Mdeny5UHqEA5v1BJHMU588YQbb9CPlBKmkhD9d+Pdx/77hY
         8gGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrPsF74851vG1/1S1UjvPf/DK556aJW+JunDfH2PYKULK99twIGoVwaTUJ6kjAzm3cvnC0+STR5caYcD19@lists.openembedded.org
X-Gm-Message-State: AOJu0YycEIHlwZgscI3PrQGh5BtRjsaO6uLx6LXCr9tvuLBJK9LDsYMl
	Sh0BE3/4BL+JzTPFZnNmM9gzI+3MUSM+SINDYqsRnieCGFAc+8a8w1aiwsOdDjQs9payGClKU5f
	E+Qd6znMievYJrMmN4CG+uhjaaY3BmKg=
X-Gm-Gg: ASbGncvgjhH0yWfVUHW8Dzdo5IPNPICjccUkB5aY0l7UKXEE2L1uHQ0KV4ZoJXilL2s
	8o/8fHWfreG6CQxPYT8uSpq6HziAkW834x8E9ZtRUVNGO8HI44SVR8M7mtHxb4qZAWooJFvPIqd
	C+ns4EHbzqNbovpvnLzIcpAqW9la25N6ZXknaPj+jPx6FrWbIR2XHROss7AXYPSvXg2ks2HJJ76
	Ax/E7dxDsVLYR6kqJrJU7GwLRCyNfrq07Cg7ZvE58qdufNXAe+U2Kc9gohpq5Wbw3mWQwWdIb64
	WqjdR+GCnZYGb9m1XKIGQwvR1o0cqw==
X-Google-Smtp-Source: AGHT+IFWbCK3SwVpFagdpUsKKZWeCuTZrpoxihQHGWSjS68vNQXrUCTAiO9flvJbRPUuZl9HiPua605+wiW2ktCZX1I=
X-Received: by 2002:a05:6214:4487:b0:879:f90d:fd88 with SMTP id
 6a1803df08f44-8847c546a10mr162912926d6.66.1764010443365; Mon, 24 Nov 2025
 10:54:03 -0800 (PST)
MIME-Version: 1.0
References: <aSSUtHYFQlychNQk@osama> <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
 <aSSnE0X9kycDc60G@osama>
In-Reply-To: <aSSnE0X9kycDc60G@osama>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 24 Nov 2025 19:53:52 +0100
X-Gm-Features: AWmQ_bmdOIVZ5HSBib7cXdvKc9Ynw2UFBFEZU_XpnqjQUVXKU8KtarLe_t338T4
Message-ID: <CANNYZj9ieQUQUEEjxV7bAznc3=A0rESOSr_+hy=RFragEA1Y1A@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] Proposal: New tool to display recipe
 dependency trees
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 18:54:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18485

On Mon, 24 Nov 2025 at 19:42, Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:

> My motivation actually was so simple, to know why a certain package is ne=
eded in an image.
> The simple way now AFAIK is to exclude it, then bitbake prints backtrace =
e.g.
>
> dnf
>  =E2=94=9C=E2=94=80=E2=94=80 libdnf
>  =E2=94=82    =E2=94=9C=E2=94=80=E2=94=80 libsolv
>  =E2=94=82    =E2=94=94=E2=94=80=E2=94=80 json-c
>  =E2=94=94=E2=94=80=E2=94=80 sqlite3
>
> dnf -> libdnf -> libsolv
>
> libsolv is needed for dnf. so would be good to have a query command or si=
mple tool to show that?
> something like apt-rdepends output.

Yes, absolutely, and this is missing. You can deduce it from 'bitbake
-g', but it requires look at dependencies of particular tasks
(package_write_* if memory serves) and ignoring all other task
dependencies, and then making a mental dependency chain in your head
if the dependency is indirect. This could probably be post-processed
with some filtering tool to only make a tree of those dependencies,
and present it in a human friendly tree format.

One other idea is to add a task to image recipes that would produce a
tree of package dependencies. E.g. instead of making a package repo
and then constructing a root filesystem from it with a package
manager, it would use the repo to write out a tree of their
dependencies - unrolling the top level packages that the image
specifies to install. Probably it could use package managers like
dnf/apt/opkg to assist with that.

Alex

