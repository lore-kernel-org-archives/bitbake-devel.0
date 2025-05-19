Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F008C2D0CD
	for <webhook@archiver.kernel.org>; Mon, 19 May 2025 13:19:34 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.50683.1747660767426490097
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 May 2025 06:19:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XJX4DQ5J;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so34662855e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 May 2025 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747660765; x=1748265565; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57cDp3eoUyeBawipJq8a6Ps+YfJywCTk159oY4D4DNs=;
        b=XJX4DQ5JhXUr+TbiUk/YEtqApv/Tnkz7qxmSuC+D6NQ+Um+CBmxmA9s24pPFD6dnFD
         22T0Me0UwAVSuTUjiFmeKU7yXC7RlEsgkC3fU6PigfuqZPV90S+G0NnrLZRLKwy2s10l
         ADgSY0r8PHMLRjkWpH/CmhKH7lNoxxEqMW1uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747660765; x=1748265565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57cDp3eoUyeBawipJq8a6Ps+YfJywCTk159oY4D4DNs=;
        b=TeFQej7ubOiTLH96g6cDWIhay4ymHPUPGJzZK0UXckTjUbLf8JpVxxJwYwER3aQWl5
         LK7dB+uEk2zvKzKIdBrr6zCMPlOLMd/IR9E6frig2zTWJ4E2H+k2NgKn3DZxJNBP0dy/
         iUqEVTpxGRnrMfHCCKIxl8f+SnmfuBgdYne3nv5JmLHq1SUtKInBWc7O7r6J7rklJWh8
         OiXA59oPmYIVOvNoo1ZXbdcjBaLWCm5ZEVm7y/JW4QCefhfYU5DIJ9WdXI8gY0olxzwN
         /iGmtRCub5Iey/OFQTieRzvUzd/gHtzOW3tVDaKE/vWlvNkHfQjyyaGIs53lR+Uy7PiG
         qEMA==
X-Gm-Message-State: AOJu0YyfYgDh21/Dyjw4PzS/sel7+6VcaTWEb7kv2eCG9WPOPSnjivbU
	QF1cJoe3ckzj+GvfY8UBSqI6CsoCRcJ2yy69jS80Xm4DDrRHCUVSzO6Vkg61hpmFhYc=
X-Gm-Gg: ASbGnct+kG0Prr8eC80RsZdsePSj+C6k5w06vZv82shV/rXe9Dh2EfPaDRDt0g6CsK3
	TUk/n7HdvuXOoNgnFid0IH96S8RijmaN1oUmyLK2GdydOg8DebEZTDP05n4qYA27UnBtYp/8/Ta
	4AdncEJ8VjZU7sSP8bOYxOxrZjLrGMfyL3ry5vOi4e+KEsTpElR8xF8phKWjpHTfnb6ohvRiYKc
	91AfOSmyf+IZrFS/TOSPLU/83EQVnhxf2l6WQHzkB+p+4ZwyF0P8keWP+vg9VqF3yftsFI/fhx1
	uvDiHhQprHvfUK+ShBnjheakmvo0vLlERVq2zDgF454RIQBVovwffD9u68Y1hCtU9FQdNeZbqoK
	a5SFVMAmLNDgyxx6g6jy7vO0BKh3IAwC+JeMZAPNe
X-Google-Smtp-Source: AGHT+IHl94jKq21ZZvBLUU4RR5mN4ly5M7YopAK0zGZe0pkbI6FSPiAnlQNRJZfdbfZUjC46+WNOJw==
X-Received: by 2002:a05:6000:40cf:b0:3a3:581f:9af9 with SMTP id ffacd0b85a97d-3a35c822085mr12555709f8f.7.1747660765419;
        Mon, 19 May 2025 06:19:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b05b:f4c9:3a1c:796d? ([2001:8b0:aba:5f3c:b05b:f4c9:3a1c:796d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8cfb8sm12396246f8f.85.2025.05.19.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 06:19:24 -0700 (PDT)
Message-ID: <50c640c556021367b4f558f16468d0b3d5d75654.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 1/1] siggen: Support non-compressed
 sigdata files
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Philip Lorenz <philip.lorenz@bmw.de>
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 19 May 2025 14:19:24 +0100
In-Reply-To: <91dd9a83-5139-4f5d-ad51-e3840271f258@bmw.de>
References: <20250515144455.2799533-1-philip.lorenz@bmw.de>
	 <20250515144455.2799533-2-philip.lorenz@bmw.de>
	 <9433a345bc4be0d854ed651e67ab03ac2e69104e.camel@linuxfoundation.org>
	 <91dd9a83-5139-4f5d-ad51-e3840271f258@bmw.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 May 2025 13:19:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17622

On Fri, 2025-05-16 at 19:29 +0200, Philip Lorenz wrote:
> On 16.05.25 08:39, Richard Purdie wrote:
> > On Thu, 2025-05-15 at 16:44 +0200, Philip Lorenz via
> > lists.openembedded.org wrote:
> > > Compression utilities such as `zstd` can achieve significant
> > > compression
> > > ratio improvements even when the low entropy data is spread over
> > > a
> > > larger input window. As a result compressing a tarball containing
> > > uncompressed sigdata files with zstd can reduce the amount by a
> > > factor
> > > of 6-16.
> > >=20
> > > Support this by introducing the `BB_SIGDATA_COMPRESSION` variable
> > > which
> > > can be used to control compression of sigdata files. Setting the
> > > variable to "none" disables compression, setting it to "zstd"
> > > (its
> > > default value) retains the current behaviour.
> > >=20
> > > All functions used to consume sigdata files are extended to
> > > automatically detect whether input files are compressed and
> > > transparently select the correct behaviour depending on that.
> > >=20
> > > Additionally, expose the compression paramater in all functions
> > > to
> > > enable overriding the global setting in some scenarios (e.g. for
> > > .siginfo files created by sstate.bbclass).
> > >=20
> > > Compression results for core-image-sato sigdata files produced
> > > using
> > > `bitbake -S none core-image-sato` on poky
> > > 122e9a49614b2ddedaae1d90c06004a7a4c43998.
> > >=20
> > > Tarball containing compressed sigdata files: 98 MB
> > > Compressed tarball (zstd -3) containing compressed sigdata files:
> > > 76 MB
> > > Compressed tarball (zstd -17) containing compressed sigdata
> > > files: 65 MB
> > > Tarball containing uncompressed sigdata files: 310 MB
> > > Compressed tarball (zstd -3) containing uncompressed sigdata
> > > files: 12 MB
> > > Compressed tarball (zstd -17) containing uncompressed sigdata
> > > files: 4 MB
> > >=20
> > > Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
> > > ---
> > > =C2=A0=C2=A0lib/bb/siggen.py | 84
> > > +++++++++++++++++++++++++++++++++++++++++++-----
> > > =C2=A0=C2=A01 file changed, 76 insertions(+), 8 deletions(-)
> > Whilst this improves the "tarball up a stamps directory" workflow,
> > it
> > comes at the expense of a significant amount more IO and disk usage
> > of
> > the build tree during the build itself. For that reason, I'd not
> > recommend anyone to be running with this set by default or in
> > general.
>=20
> I benchmarked these changes and couldn't find a significant
> difference=20
> in both IO (my test core-image-sato-minimal build causes 80GB disk=20
> writes) and build time with uncompressed files. Disk usage of the=20
> .sigdata files increases by a factor of 3 (in our typical builds this
> boils down to 400 MB added) which is a trade off that we're willing
> to=20
> accept in the CI context. Are there any code paths that I'm missing=20
> where this would cause significant slow downs / disadvantages?

A better test would be "bitbake core-image-minimal -S none" which
writes out the files without the "noise" of there rest of the build.

It basically slows down task completion and hence is the bottleneck in
task execution overhead of bitbake itself on builds. This is more
significant in builds from sstate or where large numbers of tasks are
being run through with little work being needed.

> > I'm not a big fan of adding config options which add non-default
> > workflows, mainly due to the doubling of the test matrix and the
> > fact
> > that one of the code paths ends up stale/broken.
> I fully understand that (in particular because this change is mainly=20
> beneficial in one particular context). I wanted to share to see if
> there  is interest from others, if there isn't its completely
> understandable to reduce complexity.

Fair enough, lets see if there is wide interest for doing this.

> > Further, once you expose this to the siginfo files, you then have
> > to
> > either add multiple queries for sstate objects, or have extra
> > configuration to setup sstate feeds. I'm not sure either is a good
> > outcome. This would also imply there would be a further patch to
> > adapt
> > the code in oe-core to use this new option for the siginfo files
> > and
> > again, this is complexity I'd really prefer simply not to have.
>=20
> For feeds nothing would change. I didn't include the patch to oe-core
> (which would use the exposed compression parameter) before the=20
> applicability of the main patch was discussed.

It should at least be mentioned as the maintenance burden and impact is
larger if the other patch is considered with this too. I suspect the
oecore change would attract more negative review due to the "forking"
of the sstate config/format and the need for more config.

Cheers,

Richard

