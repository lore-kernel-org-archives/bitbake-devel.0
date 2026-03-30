Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E181061B28
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 22:51:58 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8155.1774911111359245045
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2026 15:51:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D1VpOssl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fe655187so65583465e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774911109; x=1775515909; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jQDG0fZer1hDCV3PVb+ieqSrBj7UJXCEQdiZzuFMnig=;
        b=D1VpOsslRq80k8Gkuv3o6uR/JZki8EzRTdVKfuA1edOsAfcb9ZmW6+9WHj552J8Phq
         N9LHVxmKwUxv5oGSyNExg+wZLjwjc+Xd//sz9CHgYzDkfN7IUjzZgXLxa6dSfl81W4xX
         y4LiPRuq2/ecMS8x7YvqF92Vny7QGUnfXc6gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774911109; x=1775515909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQDG0fZer1hDCV3PVb+ieqSrBj7UJXCEQdiZzuFMnig=;
        b=HNwEAyGVOIGHiq4cHD8g/C5NwHrRN8G8Midnq5pYZMLfvEvMQ9TXNWLOvvLIMVOD59
         KspBeq/2PmRe6TL4raP7Zqkl8F5cFOZnmEYSvIMa6nFvz2sdngfgVN6MaxgIo5ZIexds
         GLhDE38T5s47d8OfQE1zb38UvgGSUDnWqO07W9vPTqdfgihFhQpq9prskkilaaBoOoxN
         M9XQx6q2qArPId37SHfqcfhlmWQvpHASdTIn9R8SfUaD36usia6inQy+gAxYYTCd5HRl
         BO/lakCCAAaHAoKeN1JbtXBGLwS5cKB50HfGwcXeVdjsMoHYitQGttttcQObLPYeVWaE
         nmGg==
X-Forwarded-Encrypted: i=1; AJvYcCVQim9hdfEXWKkilCguuaV9p/NDLhYHA2o56BjTFzOWG6a/nFt2/scyY02HMnFty+UzBHtfyduOFj+uaX/i@lists.openembedded.org
X-Gm-Message-State: AOJu0YzLHisQNIpTgaAQqN45m7nag6e8peH95AQ3Ti8DYv+yWNegR7tc
	bqf5A+XC79rCXk+IO4ObHawFIKFOeQu7VR2dnk3LE/9R7Qrl7hHBHaZpOtz5dhjSuHI=
X-Gm-Gg: ATEYQzwRErUdolGoRUcAmzl5HjqJFpMR7eqZJa9lUkA/5qKOUNaXKWpnF9g8sLZHO5w
	V99LuRxnKRaDDFqztsTbB+lNH3yx1QyC9Mkf+/I19qaPSu+2zKGQbVrNfrRAEHPH/oB9IJbcDte
	/+/GJ2HWgvPw51TUoUyED5uUi6rBipttcU5NlMXokHbnfZTXQwR+7J1fsfyPXR8TWn0SbqCi6GZ
	M6nB0NKPh7uR7Hji3a3Pw44/Rbhir+h7Lgs3OVgzhbr3tvaolLyBrQ1BdBpi7IEzmh+xP1vzdnv
	93ccvro1vB9USOX4auDWlpYOiTeeZCyHRjn/KWJ6OohNSiAd9DBNV6gv+DHK84nt5Vv/kw659Gt
	RMT+Oiug6w9Dr+fgfBH02WNRDiEwkbqiXIb07wrP0QtRKM5FOkq8ciwiJ+vLmQ+Zx4FmkYCS5HG
	vV6cLPnARguov8294m+Fe/aqjpEGlyksN9fnRVJWhJVIbPKvZ/hydDXwsz41UkMfg2RXgEESY6g
	qraiPNUROf/Z1OZ
X-Received: by 2002:a05:600c:1d1f:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48727eb81bbmr263096105e9.17.1774911109601;
        Mon, 30 Mar 2026 15:51:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2691:4cbb:4dcd:ad31? ([2001:8b0:aba:5f3c:2691:4cbb:4dcd:ad31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b6230sm729265e9.24.2026.03.30.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:51:48 -0700 (PDT)
Message-ID: <0a7e52d678db59c049d3f45e4b3778bf8412cc46.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 10/11] bitbake-setup: Set function
 default to None
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rob.woolley@windriver.com, "adrian.freihofer@gmail.com"
	 <adrian.freihofer@gmail.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Date: Mon, 30 Mar 2026 23:51:46 +0100
In-Reply-To: <DM8PR11MB56557582516EAE23B0AA187BE152A@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
		 <20260326185742.542268-11-rob.woolley@windriver.com>
	 <fcac19e4dff25335679496878b691fa73bcb7485.camel@gmail.com>
	 <DM8PR11MB56557582516EAE23B0AA187BE152A@DM8PR11MB5655.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 22:51:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19285

On Mon, 2026-03-30 at 21:49 +0000, Rob Woolley via lists.openembedded.org w=
rote:
> Thanks for pointing this out.
>=20
>=20
> As far as Python 3.9 is concerned, it went end-of-life on October 31,
> 2025.=C2=A0 I recognize that some supported hosts (like Debian 11 and RHE=
L
> 9) may have it by default.=C2=A0 Do we increment the minimum Python
> version when the language runtime goes EOL or when the supported
> hosts do?

This is not an invitation to discuss the minimum python version this
close to release, particularly on a relatively trivial change like
this.

I'd rather just remove the typing than start trying to work out minimum
versions of different systems, how that combines with build tools, the
docs updates needed and so on.

Cheers,

Richard

