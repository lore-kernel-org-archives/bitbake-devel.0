Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19522CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 19:00:35 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.5406.1755716432239838710
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 12:00:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M1z1lepg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so1171785e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755716431; x=1756321231; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6L8CdSifP9EN7NMcdlfqMOEY+r/dTZWKxsKaeP/nrwU=;
        b=M1z1lepg2p7C4TqvUil7BMz0nnHyYrtrhj1YTHPqPXL2TG5PaECs9vxnymc3eSgH9q
         8lgX6N7BHdFD/EWln4t9BpBPJ828+JjL5X2/l03oPa/O8OkIXehFU+lJh5PyJp1cDL5T
         DlqFF+xC8eVKwIH67+Z+ObubGf+SJ1W0B5Ib8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755716431; x=1756321231;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L8CdSifP9EN7NMcdlfqMOEY+r/dTZWKxsKaeP/nrwU=;
        b=I3SUj7QDeOanfZybYdJqqCVeRfeG0/oYOoDnA3Tc+rYIomar2jf/GAnXQJA4G8jSMT
         Yw+3yovpx/LZRPYB/p7ihnbBGpVWsxolWzCUq0z069zmwGisdKVsNuQ6HFObYMcoGCu6
         g+d9MXMVuM1inaJ05DZTSUHu6sfchA5iOUqJxZEO9/lCcm4Qcg2PNON9wtxDUMXFgq47
         5rPICElyiYAZDfM5I10Cd7Ifx/vhJLCsspyrU3+tMl1y8xyraR0HeHWOKpDe5oSdSUL2
         MwbNdFV8CQsh+ksJ21Nqsv93nPU9UDYwXbjGPHCO58+vofwBucSqZGwN9BVYLtSMl32k
         ugDg==
X-Forwarded-Encrypted: i=1; AJvYcCVEoaUh7VneB4iIxMTTUIDFUaVwt9lOQcJhKOnlqbZmHVdN0RWg+aavTa1XfJgNqOwYNX8IgG0F3Hf9RlsD@lists.openembedded.org
X-Gm-Message-State: AOJu0YzpBV4sIazBt1oMaO2IiYTkjgNF3LBYNy7OOsIllzrF4QXRpagd
	0AVTv9hOi1wfWiml06Kk6vJI/x2QcuYu5Rqz3xKH50cj74hge9D6lgl9898MUQrimI7G3Fsr/yH
	q4QOc
X-Gm-Gg: ASbGncuN1YxzZF0p4bOUZ8GS29Ot7bdCmncZf77l8rIzxbhYeaMI9Qac3fk1hJBa6pe
	0rOmo4AHFXtWKu4fN532BNzikatXVhBYqPFfglkyz5OnIXwtG9KbS5/rKO1l+A6XrzTrwXFtE1c
	stjfrEvatOB+Xh9uNVj9AS2oBtCDwibod04Ajagc/UC7gJqPCa1fofkOzWKyqBLW5jJkG/IH4T8
	8fBCyW20DRNo4tPKwK8rnP7vPE2eG43IDFLYHuBb8nxPR9ZIkL0AEJhSIrGpPnldp8i7RfAC/oC
	umNax8y3OIaN9sZ+yKrUe1EojGol6WC14RSgHqgkdebwTrbXznJkgC7VKQ+a2tqytUTS7uCgxts
	nLStLK2hq7DxbTDWyQ5Dgj3xMJ8cy0MKov4Abo/JR8SPoOx1ACnHHYtK6RLCngck35Fmv68X4uM
	MVnZQdwzIZLmsRtkRF0BanYg==
X-Google-Smtp-Source: AGHT+IGMsJlAb5y0WNvlecuwP/KsWLIC/fxnedCUecU2/3YQermOre2ygT0vHswRJFGBjIUeoUCpXw==
X-Received: by 2002:a05:600c:4f92:b0:459:d3d0:6507 with SMTP id 5b1f17b1804b1-45b47a0f1f7mr26358715e9.32.1755716430497;
        Wed, 20 Aug 2025 12:00:30 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2407:63e0:8092:e22c? ([2001:8b0:aba:5f3c:2407:63e0:8092:e22c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c42cf1sm46985715e9.12.2025.08.20.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:00:29 -0700 (PDT)
Message-ID: <8ad6256a6b491b72a1f47892f16bdfadc96f632d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Scott Murray <scott.murray@konsulko.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org, Tim Orling <tim.orling@konsulko.com>
Date: Wed, 20 Aug 2025 20:00:28 +0100
In-Reply-To: <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
	 <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
	 <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
	 <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
	 <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 19:00:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17895

On Wed, 2025-08-20 at 12:42 -0400, Scott Murray wrote:
> On Wed, 20 Aug 2025, Richard Purdie via lists.openembedded.org wrote:
> > On Wed, 2025-08-20 at 11:29 +0200, Alexander Kanavin wrote:
> >=20
> > I agree we should allow this to be configured, I'm just thinking the
> > .config/.cache directories might be the right place to put the
> > defaults. This does move bitbake (or bitbake-setup really) to become
> > more of a distro/system tool. I'm still not 100% sure if we should do
> > that but using the standard locations by default would fit with that.
>=20
> I can see where you're coming from, as this shadows how git config works,
> but the top directory behavior is something I've been on the fence about
> with bitbake-setup, and this seems like it'd maybe make that worse.=C2=A0=
 With
> things as they are now, I fear I'll be having to document passing the
> --top-dir option in any bitbake-setup usage to avoid contamination of
> configurations between projects, and avoid users asking why they're havin=
g
> stuff show up in $HOME.=C2=A0 I'd honestly prefer if it only operated in =
the
> current working directory by default like whisk and kas.

The only things I'd expect to come from this would be downloads and
sstate, both of which should be shareable.=C2=A0

Obviously users can do other things but I'm cautiously optimistic that
if we properly document that, it could work quite well...

There are probably ways we could sanity test site.conf specifically
too.

Cheers,

Richard

