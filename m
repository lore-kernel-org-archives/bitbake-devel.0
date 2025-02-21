Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79094C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:22 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.18730.1740125361000362492
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 00:09:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XJXquC9B;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4399deda38cso10667295e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740125359; x=1740730159; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ve+1Hnfi9ocvTmDZ6ir1/2JtpHCf0FYYdetGvjNtb0Y=;
        b=XJXquC9BKGlnRHiRGkFM+TnopeujmmweCeckD/GFzZXOmjRjLS2C6AFwQrt8HU/dQ4
         V5TAajI8LCPuUQ2zFq5nCxFFLPd/kTKAi4Do0xmIDa9YpjLyNTVsg68taNni08UaOt2m
         fdBETIDfWw1Cyy2/YYwpKPpsFH80OksTrZWhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740125359; x=1740730159;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve+1Hnfi9ocvTmDZ6ir1/2JtpHCf0FYYdetGvjNtb0Y=;
        b=RUIL6SqbLACkyXVv4TyJUvEQ6DaGMq4m0Tef/0Hey5BM91crNXs5ewEdlsH+AGSPvu
         6BAq/f8am+K59uqCihbzgZvjOwt32+f/KCSBcXzKbZpUrO538KKW23iFZjVdJEwXuvDA
         po5REX+vGIywp6mFOp8RvacWdYIVZvnyatXhvlgc08JE9mpn3DUHH2sAj4P3f80yqG1c
         438VidSOim9hXlO/q1Klo4/Qrr56TEInDcXbbsRr7aQgTmsjMtS/SzOa1tzQ+ygmVamM
         rWnBe4RSlVFz2g0gtA+GyjICqPYL3MYGnk9FUAR83Ldg8Afwbel3c2CRnG12IPUgwb9H
         PhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbViEksx/M8E/EFCvAjpYlH3nSAjM+Qp7m6jOTVHOgmagcmV+Dp964tiFRJY83o3p1Wq3xp3zPmJ1UNryU@lists.openembedded.org
X-Gm-Message-State: AOJu0YxnqYppkuVCStr+KpMdjYVTq2Y3LEXVzdq+P6O8q95oELLMQs8e
	Ef6oajTonwLA04mSRR8XPEFQvpZAXJDfsAj+2Iv7dY4LPhyahAdciv4azfg70Nk=
X-Gm-Gg: ASbGncuaEK3BBkK0AV4TBbx0iJLsgUO4pgZoGdvzigAbDKFLuNCNbx0Xrhqnubd1TrI
	3LHtESBM21R10TPGWjbVt6njoa8M2rQ/okiUunIkgSMXRfMLq9XdflTKIyZKvOTWKSG/zFAiY0O
	aOwbGGCTnDh9XNHLyxc3hTOwzvKbSUHlg8lo03+SlMeXte3r0Vht0b/0B5K5cmItPKLKDF+uzXU
	MdG9wlzQVrDHaGSgW/uwk2xK1CzubtGHhAtqf7DwkN3ufGw8ACHz0WrPAOMDSd71U4vJAEDcbWv
	F4y0jBwAYoeTYV3VWzCTajxKm7ovUBFwP/CZjkiOV1OFIDrHcnMzsaXkXsbzGRAwDxkgcEOjhP/
	OrJDPirZ8E3Zf
X-Google-Smtp-Source: AGHT+IF5OgQ5mvAh9wpi77J/Zz9RVzfOix8GdF1rRRWedhWpWXtA2k8xkkf9S5CSj6qrPjejY2qnpw==
X-Received: by 2002:a05:600c:3b91:b0:439:56f3:d40f with SMTP id 5b1f17b1804b1-439ae21286cmr14839835e9.21.1740125359191;
        Fri, 21 Feb 2025 00:09:19 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46? ([2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0371b7bsm9489425e9.33.2025.02.21.00.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 00:09:18 -0800 (PST)
Message-ID: <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
Subject: Re: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Koch <stefan-koch@siemens.com>, 
	bitbake-devel@lists.openembedded.org
Cc: simon.sudler@siemens.com, jan.kiszka@siemens.com, alex.kanavin@gmail.com
Date: Fri, 21 Feb 2025 08:09:17 +0000
In-Reply-To: <20250220172706.3850722-1-stefan-koch@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 08:09:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17270

On Thu, 2025-02-20 at 18:27 +0100, Stefan Koch wrote:
> When `ud.shallow =3D=3D 1`:
> - Prefer an initial shallow clone over an initial full bare clone,
> =C2=A0 while still utilizing any already existing full bare clones.
>=20
> This improves:
> - Resolve timeout issues during initial clones on slow internet connectio=
ns
> =C2=A0 by reducing the amount of data transferred.
> - Eliminate the need to use an HTTPS tarball `SRC_URI`
> =C2=A0 to reduce data transfer.
> - Allow SSH-based authentication (e.g. cert and agent-based) when
> =C2=A0 using non-public repos, so additional HTTPS tokens may not be requ=
ired.
>=20
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
> =C2=A0lib/bb/fetch2/git.py | 100 ++++++++++++++++++++++++++++++++--------=
---
> =C2=A01 file changed, 74 insertions(+), 26 deletions(-)

In testing it looks like this series has some issue on Ubuntu 20.04 systems=
 (both x86_64 and arm):

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/1097
https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1016

This is probably due to the version of git there...

Cheers,

Richard

