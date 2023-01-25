Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D9BC27C76
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 17:55:48 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.52404.1674669337685690061
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jan 2023 09:55:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QHJgSouQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so1917973wmq.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wekOrDb54A8XRP+5f9OytbU88PP6oDcHOY9y7GRNKXE=;
        b=QHJgSouQkWvl/8ZS9gkmpp2n9Q7FRGseG7hQFAtT12EcqMYGhUGtzO8F7oQ49KhNWO
         n0fak718ZwrN5wL314fWurVUJxtHujCDn/ibZ8mL4byuPy6xGzuJwTFYwUcL239Re0ul
         is/KqpgBxUBqJW4yctlBRNUCC6o8FVtbZNZxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wekOrDb54A8XRP+5f9OytbU88PP6oDcHOY9y7GRNKXE=;
        b=YTbo+EON2ZvWdGpcj0FHVoyyDfiFZaL35WxX6sZWIOYqr4FZhFEQK4a6XRZWcZHGsH
         wuzuOMIpYxSYCcjgicxCv9hya/n7U3G3EEm3wM9KGWdrHrCbneyZYZA2FPmPsNaNn6ky
         MmHsxuJVNGJ5A9SOTegf6CuomxCnblYoKr9tbrVac86mJ6SJzDFZ1oHVLWCVGJBW/RiP
         NfvAabHxFVdNzEbJV1DsvJ79a32wbA4KmP9FTJoVfPpLPjQNMJsO8TLYHzsI3VpnAEgo
         tFvWzINWKtU2KM8VBi53TO1O69PPAfcHeOWAycKJf2hhco4XC6IhBWPhK3MFv0FChJEQ
         3efQ==
X-Gm-Message-State: AFqh2kqTcuRO+f0I3R9yf9YhpBn5Z7gt+u976iUIgmnrNOOEAvovZ9nU
	lwtu9oYZVti1nfZsYefiKNaBmksgh94srWj5
X-Google-Smtp-Source: AMrXdXsrEdoGFRnymUx51rNfLs29nW4YgyqYl5nJsA7oTBFw4g4CItThGvKdy9FeWdYRhKtbJ/zTQg==
X-Received: by 2002:a05:600c:1c1b:b0:3d9:ebf9:7004 with SMTP id j27-20020a05600c1c1b00b003d9ebf97004mr31043128wms.29.1674669335575;
        Wed, 25 Jan 2023 09:55:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3356:3b1f:dd00:4e1a? ([2001:8b0:aba:5f3c:3356:3b1f:dd00:4e1a])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d664c000000b002bfafadb22asm4520180wrw.87.2023.01.25.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:55:35 -0800 (PST)
Message-ID: <8f03e675ecb19ea938428c52431cd1fc384b5cb3.camel@linuxfoundation.org>
Subject: Bitbake overrides optimisation in the datastore
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 25 Jan 2023 17:55:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 17:55:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14342

I mentioned recently that the override "cache" data in the bitbake data
store has some potential to be optimised. The data I'm referring to is
"self.overridedata" in data_smart.py. To explain what it does, some
same data helps:

RDEPENDS =3D "A"
RDEPENDS:${PN} =3D "B"
RDEPENDS:${PN}:class-target =3D "C"
RDEPENDS:${PN}:qemumips:class-native =3D "D"

Some code might call:

getVar("RDEPENDS")
  -or-
getVar("RDEPENDS:${PN}")

and this data cache exists so that bitbake doesn't have to iterate the
datastore for all keys, checking for variables starting with the
expression.

For the above, currently bitbake will store data against each of the
combinations, the code is in _setvar_update_overrides(). Taking,
"RDEPENDS:${PN}:qemumips:class-native", it would place a cache entry
against:

RDEPENDS:${PN}:qemumips:class-native
RDEPENDS:${PN}:qemumips
RDEPENDS:${PN}
RDEPENDS

since any of those being requested by getVar needs to return a value.
It would cache the needed overrides against these, they're stored as
strings. Effectively this means d.getVar("RDEPENDS") can be redirected
to d.getVar("RDEPENDS:${PN}:qemumips:class-native").

To work out what d.getVar("RDEPENDS") should return it goes through a
few steps:

a) see what possibilities are "active"

This means for RDEPENDS:${PN}:qemumips:class-native it would check for
set('${PN}', 'qemumips', 'class-native') is a subset of set(current
OVERRIDES). The actual code:


        if flag =3D=3D "_content" and not parsing and overridedata is not N=
one:
            match =3D False
            active =3D {}
            self.need_overrides()
            for (r, o) in overridedata:
                # FIXME What about double overrides both with "_" in the na=
me?
                if o in self.overridesset:
                    active[o] =3D r
                elif ":" in o:
                    if set(o.split(":")).issubset(self.overridesset):
                        active[o] =3D r

b) for the active possibilities, work through in OVERRIDES order,
chopping off the right hand part each step. The actual code:


            mod =3D True
            while mod:
                mod =3D False
                for o in self.overrides:
                    for a in active.copy():
                        if a.endswith(":" + o):
                            t =3D active[a]
                            del active[a]
                            active[a.replace(":" + o, "")] =3D t
                            mod =3D True
                        elif a =3D=3D o:
                            match =3D active[a]
                            del active[a]


The code in question was designed for "_" as the override character,
which may or may not have indicated an override. We now can know what
is and isn't an override so I think we can improve things.

So far, my feeling is that we can optimise things by:

a) Only caching the entries that would apply to the initial part of the
variable, i.e. have one cache entry for RDEPENDS rather than all the
combinations.

b) Have a pre split version of the strings so we can avoid the
split/join operations.

Challenges:

* sets don't hold order and part of our code is order sensitive
* we do want sets for comparison with the currently active overrides
* sets/lists can't be used in the current dictionary overridesdata
structure as they're mutable (could use a tuple)

So at some points we need strings, sometimes lists, sometimes sets and
we need to "chop off" sections from the left/right sides of the
expression.

I'm open to ideas on how we could/should be handling things.

Cheers,

Richard

