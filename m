Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B254CCCF9F8
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 19:00:10 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web10.3230.1761937205664286760
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Oct 2025 12:00:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XTJ1iLJ4;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab6fso27162697b3.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 31 Oct 2025 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761937205; x=1762542005; darn=lists.openembedded.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8UCdeyc5d8qj1ndELXL9CiLyJIoLJFA1ru0IHUGUcY=;
        b=XTJ1iLJ4zYPj5zWuBckN7ZL2oxUsnfXeKzPKW1GODPm9z46+rb1w8L6Wo7t/Cb5Vuw
         DXpbY+iKyUubCIbuyg05XT0rK4g034RrxxoPtCh7RTudMkVoHfsbjfFnXB+RlLJDExyZ
         NG+GDH0B78nZ5Nxlq7hWQcJfvEyAsF7FnBrYCBCchhf+2QW+1ajTNYkdODjZ22apdzZs
         PKlqx1A8DzXAuXhkTpf/QeWnb5/56nZ1f9yI3RcpFCuodEuvQHXgXA9LhwXwtITzFTU5
         Ylhepl0vGfSVgIlyi++AORB2lZ6DxHc0UNlVmXcmVhxZpNre1ubK2EWUzhQl+SLVfXox
         gtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761937205; x=1762542005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8UCdeyc5d8qj1ndELXL9CiLyJIoLJFA1ru0IHUGUcY=;
        b=s3zF1EtFydJm2sKogm2TI6//B1f3hiHcqe9/KnmuFXzb1Dw9OnN4t14Kz41GEkdNOf
         N6iYJWtYQ3cPco5rJWwJ33dAAuj51aBSsvdISZh3GFC1L3zt+ErITw1o4TOj47yFWgnx
         +UVFgfvU5uHmPxhku13IQ/KXCjK/eKpE7D9tVm/sdTyVXkREet9oxS9lvLqD0mQ0eBSp
         KJZozWoLP38eNnUFODxZdP1RY0MGSpg5mUfTjVh5lNN209RgLwdW9x4bVycZG4Z69wyg
         WK22ohj0m4Jg+Nz8X6KzxntXBqc1PlfFAche1mQBZBaC0HCO44uvq3NbDFE5xX6Ni4i0
         y54g==
X-Gm-Message-State: AOJu0Yz218JXuWJq3HcDboUm8rzEtI9j2uBtVj9EbriaIiYcz2aeapXt
	qnVBQnrpS7/63ba00qi1J7KIxzI4b+cYWPCL+kGD2cxCHC1AjSNLO5NWZ16GEu8h8GsYU2MnonF
	1c94avi/kIT8fzH4KEJqMma9nYQC5S1kNkXHd
X-Gm-Gg: ASbGncsmjuyBoQMZm/VNlq6uXUt1ugs9PBJfWaSiv6L+c4stE0M+o1JjDc8xMAaAEbW
	G4kraXlEqr0/vYQ2RBa6SCwEvMyjuzwchIphm3QPFK8KMTHcvQNqSKTbVhzn929SFw0BlOYb+/U
	DvDO8o50RLSFslPckwq4L+Duq/bf+wuGKAe0UoYcjLu0lASOusKdUNuYS81NrD/4G/YCXQRr0UV
	d2bBaBKA18xQryesCm4QDxY8FaMyVU/0gkbYuh65XuZfYPFu5lTQKBc2ICI6cDbMpxsQRPtlQU=
X-Google-Smtp-Source: AGHT+IEI0m9mWJfSXTPURaJuaPrnhuNhX6zvxiRthKPGITCTfah0T9AKYIZcrbjYjQzUcbCyKsVydC5sSP7+LJlx73s=
X-Received: by 2002:a05:690c:318:b0:756:f0bc:44a6 with SMTP id
 00721157ae682-78648456a18mr34724437b3.30.1761937204537; Fri, 31 Oct 2025
 12:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CAJdd5GbA5G+2of5NzN52gFP0iYGp=Q+q5cQTn7gXv_zY_FEpXw@mail.gmail.com> <CAJdd5GbWr4izQ8J4Lkt66-+JZk62GBJMxZCekTrGU0by+OjeGA@mail.gmail.com>
In-Reply-To: <CAJdd5GbWr4izQ8J4Lkt66-+JZk62GBJMxZCekTrGU0by+OjeGA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 31 Oct 2025 12:59:53 -0600
X-Gm-Features: AWmQ_bm0xqk-NEupyPH3-Bsv7g0W7cahu_RVGxOTObCsbKhT7j3ApogHDSnm_N8
Message-ID: <CAJdd5GYM4dtB+cQy10d22bQdG4pCX+Qt2ZzNMRv2Sne6vL+HLQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Oct 2025 19:00:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18232

On Tue, Oct 14, 2025 at 2:08=E2=80=AFPM Joshua Watt <jpewhacker@gmail.com> =
wrote:
> however, so it shows up when you do e.g. `bitbake -e openssl`).
>
> As far as I've found, there isn't any variable or mechanism to get
> either the file name of the base bb file name, or the version _at
> parse time_, unless someone is aware of something else I should look
> at?
>

It turns out adding the information necessary to do this at parse time
is pretty trivial. An RFC patch to bitbake is available here[1] that
makes the "originating" recipe available at all times when parsing.
Using this, I can effectively "work around" dangling bbappends by
doing something like this:

  $ cat recipes-connectivity/openssh/openssh_%.bbappend
  include openssh_${ORIG_PV}.inc

Which pretty much effectively reimplements bbappends as .inc files,
but allows them to dangle. I think we can make this work if this is
the preferred approach.

However, if the argument against a per-layer variable to ignore
dangling bbappends is that it results in bad layer quality, it could
pretty easily be argued this method is actually worse (from a layer
quality perspective). bitbake tracks .inc files less than .bbappend
files, so enabling this sort of behavior allows any layer to do all
sorts of strange things that we can't really check for in an automated
fashion, whereas a per-layer ignore of dangling bbappends in the
layer.conf A) is easy to check for in yocto-check-layer, and B) is an
easy indication to consumers of the layer what they are getting with
the layer.

As a particularly egregious example of what you can do with the .inc
files, you can look at the following recipe:

  $ cat recipes-misc/reimplement-bbappend/%.bbappend
  include_all ${ORIG_PN}_${ORIG_PV}.inc

[1]: https://lists.openembedded.org/g/bitbake-devel/topic/116030483

