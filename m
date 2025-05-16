Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC0BC3ABDD
	for <webhook@archiver.kernel.org>; Fri, 16 May 2025 06:40:03 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.7365.1747377596556211228
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 May 2025 23:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bxxKRAOX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so13369895e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747377594; x=1747982394; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYVwZ+q3CxrRhtGDgJG67GIWDYkxyFFAcb+S+rlZrsE=;
        b=bxxKRAOXHajACjkvQzsnuXt62ZL4hw5cAnSoofStbhggcFq+0sGG76Q8hG8o9RRVhm
         h2uW9ltxg4mL4W1OyFzbJjxsWomFVAYv/DQNGN83xGjav+7yTQ2xBcqyNujtrxfl/n7J
         PghaGtZs/QGU5axjv/zNnDhqMu77Z173s7xIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747377594; x=1747982394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VYVwZ+q3CxrRhtGDgJG67GIWDYkxyFFAcb+S+rlZrsE=;
        b=FEnX5zcHAyotYCjZZa9PmrhIKt/yzEqNfhJVwomRpEd91hcwmH/VvHcgMAr71xYZim
         tQtDtZNgBE27K5pcQ5lwpZGYolV2Le+IgPFc4iSl37GUrOKRK59xFOH438FsUoFQBL4y
         mF+AnWCNh9IFDrYsoZwU1gHm4oKQcdeEZXpPaiAxBfz6m8NGIEal4CbVNdREA5kEQHhr
         V+eZ/Bm0m1cpm97SZGJuM1ta+f6UXGDrwB9S14Pm8D0nsjO+RM+6XQBCb2uJeuCmCa7V
         EV9PXVgUt6TFlf9KeDf0KT+UCvlEv5WyFSwkkOLeIVWIROKoFZ2kMLpAsB1bRLgjAFbl
         uDaw==
X-Forwarded-Encrypted: i=1; AJvYcCUrYHJbZMdrL4KIuwj8Yy+EriRFiFX0pD0gu7ndPWvuG1GSA0jweNEk2FQK8obhG//DLHZVyoitUEh/OVar@lists.openembedded.org
X-Gm-Message-State: AOJu0YzFLi1kQvUTcW2/qL3SPsBuoZleaiOn5RrTjdyevpM9BRe3hFtU
	s8QiSwlJQ1UdsRjOR/xtILQSlXQfCK/GekNkQ8F5p8e401072B6uKgN0+B8r1SQgASs=
X-Gm-Gg: ASbGnctjekxwbSSnPHsxgvFBbqwfyAXnOvuS9qax2XTsNPkhC774RAa7r+YzSZMXHIU
	hy9CfOmgdmD27t3ivCyzJxVj3+x7aegu35FzmbmcjO/nsOIOWHhszSnQrcqlmhg6VkhAPuztPyq
	6fTXLoxdYil3D5ZmJIbcjFQtQG1LiEpAAHY3FDdsPxesyz7fEj5qyQVWPh+axzaJlPYz46NiPEl
	BSOWzHAv7HNWW8lLd7ksPJD4B3BKWaAg1BVhDX3pjBveTwVVI9JyD86Hj+qNbbKLMrECOD4K00m
	Yf/FtjFqPbwBJHnQHFBC8hdMtf8JBmQ9tnF6/qxwjeHGltUNXS53TKFnGv1zynMd5p7aUVl7usR
	Ti8Q70dQCiWN8vUcsDxcuqRMGpI/Mdp0czeGrGOzcMw8stfnA67w=
X-Google-Smtp-Source: AGHT+IHlyUVSKiM2qZTFx/+juIuaLjs8x5IyfgYD3FkINp0G951awUZhDXUdu2G4NpIq0gvk8bhtSQ==
X-Received: by 2002:a05:600c:154a:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-442fd664848mr16311615e9.25.1747377594508;
        Thu, 15 May 2025 23:39:54 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fa4b:a3c2:43a9:a562? ([2001:8b0:aba:5f3c:fa4b:a3c2:43a9:a562])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f482f1d6sm87907015e9.14.2025.05.15.23.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 23:39:53 -0700 (PDT)
Message-ID: <9433a345bc4be0d854ed651e67ab03ac2e69104e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 1/1] siggen: Support non-compressed
 sigdata files
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: philip.lorenz@bmw.de, bitbake-devel@lists.openembedded.org
Date: Fri, 16 May 2025 07:39:52 +0100
In-Reply-To: <20250515144455.2799533-2-philip.lorenz@bmw.de>
References: <20250515144455.2799533-1-philip.lorenz@bmw.de>
	 <20250515144455.2799533-2-philip.lorenz@bmw.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 May 2025 06:40:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17620

On Thu, 2025-05-15 at 16:44 +0200, Philip Lorenz via lists.openembedded.org=
 wrote:
> Compression utilities such as `zstd` can achieve significant compression
> ratio improvements even when the low entropy data is spread over a
> larger input window. As a result compressing a tarball containing
> uncompressed sigdata files with zstd can reduce the amount by a factor
> of 6-16.
>=20
> Support this by introducing the `BB_SIGDATA_COMPRESSION` variable which
> can be used to control compression of sigdata files. Setting the
> variable to "none" disables compression, setting it to "zstd" (its
> default value) retains the current behaviour.
>=20
> All functions used to consume sigdata files are extended to
> automatically detect whether input files are compressed and
> transparently select the correct behaviour depending on that.
>=20
> Additionally, expose the compression paramater in all functions to
> enable overriding the global setting in some scenarios (e.g. for
> .siginfo files created by sstate.bbclass).
>=20
> Compression results for core-image-sato sigdata files produced using
> `bitbake -S none core-image-sato` on poky
> 122e9a49614b2ddedaae1d90c06004a7a4c43998.
>=20
> Tarball containing compressed sigdata files: 98 MB
> Compressed tarball (zstd -3) containing compressed sigdata files: 76 MB
> Compressed tarball (zstd -17) containing compressed sigdata files: 65 MB
> Tarball containing uncompressed sigdata files: 310 MB
> Compressed tarball (zstd -3) containing uncompressed sigdata files: 12 MB
> Compressed tarball (zstd -17) containing uncompressed sigdata files: 4 MB
>=20
> Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
> ---
> =C2=A0lib/bb/siggen.py | 84 +++++++++++++++++++++++++++++++++++++++++++--=
---
> =C2=A01 file changed, 76 insertions(+), 8 deletions(-)

Whilst this improves the "tarball up a stamps directory" workflow, it
comes at the expense of a significant amount more IO and disk usage of
the build tree during the build itself. For that reason, I'd not
recommend anyone to be running with this set by default or in general.

I'm not a big fan of adding config options which add non-default
workflows, mainly due to the doubling of the test matrix and the fact
that one of the code paths ends up stale/broken.

Further, once you expose this to the siginfo files, you then have to
either add multiple queries for sstate objects, or have extra
configuration to setup sstate feeds. I'm not sure either is a good
outcome. This would also imply there would be a further patch to adapt
the code in oe-core to use this new option for the siginfo files and
again, this is complexity I'd really prefer simply not to have.

How many users are regularly taring up sstate feeds or stamps
directories?

Cheers,

Richard


