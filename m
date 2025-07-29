Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6222AC87FCA
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 22:42:25 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.21340.1753828941061287780
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 15:42:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fObHfT5s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so66018725e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753828939; x=1754433739; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1PwWN9s2GwdxFqZ2HfYjG1iKOmk9sW8JuWIBSAHVJc=;
        b=fObHfT5sVtLHJqWRgGeNvi9JpxsUMWvFSR1TZz9aNWneQdAjl1kTxVm6R/zHOWekEu
         X3ytt1fRba2Bd0iFLXJ6+67KBe4J8pkNw3NVGoVmr4WOg9/+DlYAi5wd/IYSD8TGWQyZ
         sBWaU4Grir6NcVk+llqhNWgvob/aKU89bfhnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753828939; x=1754433739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1PwWN9s2GwdxFqZ2HfYjG1iKOmk9sW8JuWIBSAHVJc=;
        b=LG0FAYwYu+quig75rq306u4ySvdu5Viefjtu/li2rpJKDOuZTzCXOqtpz3G1q4rzmW
         v2txmqCxaowyjzTzJh69yTtG2Gs+95yjd7jgp03e45iZmTUMjRKCADwzotc952hskcUl
         isL3FYGCHHklvjclIHr/rx8pTvq4nHCodQmyq2VepD9dwjfsNJwV/3x7kS+4lOP/qwyk
         sEsIAW1h8qgoxX56L7603jdTIl0sa3sGFkm0X2xkl4BttiDDmnbEOz6a0D08aUS7XwiR
         dnOmA6GKpYtfksLu+re4VhfcAl2GHIoph98Dum0mS5MNaWQpj7gFpCnHNY3Gc8GcYYGh
         ykkw==
X-Forwarded-Encrypted: i=1; AJvYcCW/rmRg0V9uAhTMLHsEsI3W/1BO9ZpQakct//V2cW8ceTwdsjkulU9GXNeCp3D7g94jmeOxiFFnf99B0mb+@lists.openembedded.org
X-Gm-Message-State: AOJu0YwLEdLAKJraiN8KgHQX8fJW30DPkN3+F9YbdtG4DdO7lbvQLO+k
	8NE0Z9hX5GrFbq97hLA+cJolYj8xfFjYi2fw1TJ6W2RP2P6cVZNAtGIXRlpdD2ytsUk=
X-Gm-Gg: ASbGncvs5MdyTRoln6M1l0X4CpyG87ot73NilTcHGxR0yQDzqs4eXLXSzzyH3v0e3Iu
	7fC8ETn+T4St9BHB85vTPx99Vor5ncSWlEEleyTb9m9mrP/0SIl4STCcM3KZVFX8X9ePSMC4sFx
	2QDI37lRSp4QrFeq/rtj6/x/2/HASlL31vflfbdOQWDgX0t6zAU8Ng3LYu4Zzsar0Ku57MjNEvE
	66QEx9fXsVnoxYDwe4/vAlhmmxfFDOJz0qg0bnLrqtGeUxxzNpZhxhHtrcBD36tOaaSIV5+neHM
	urFyU/Z3EWTu28511aZ8SVVK2AY2DqxsIdQsGw3l7FzI9B+IpOclEMxYWzCvOJOK/uhdf5y7gLt
	FDEAutrG8hM+0KtkVWxO1+UTqNwO92G3t8TXMRRjMl02faxIBmloA1l18/5HIb6ESdzcftzZr5e
	4gEL/afn9kAXA=
X-Google-Smtp-Source: AGHT+IGwM40c1obhpl+xlSxliReK4kNnS6As8TruV1p+WDSPCxathQvbaBbhGyPrVDiTmClKnwweiA==
X-Received: by 2002:a05:600c:1e12:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-45892bde4f2mr10597275e9.26.1753828939126;
        Tue, 29 Jul 2025 15:42:19 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fca2:de45:2a66:accc? ([2001:8b0:aba:5f3c:fca2:de45:2a66:accc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953e9b1csm2826185e9.22.2025.07.29.15.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 15:42:18 -0700 (PDT)
Message-ID: <697d62f631f9d6fad12c3bb220cea1d0d79a66cc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Date: Tue, 29 Jul 2025 23:42:17 +0100
In-Reply-To: <20250729144906.1665908-1-JPEWhacker@gmail.com>
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 22:42:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17827

On Tue, 2025-07-29 at 08:47 -0600, Joshua Watt via lists.openembedded.org w=
rote:
> Implements a new layer-specific variable called
> BB_DANGLINGAPPENDS_IGNORE. This variable is similar to the removed
> BB_DANGLINGAPPENDS_WARNONLY, except that it is scoped to a specific
> layer, and it also causes appends to be completely ignored instead of
> warning about them.
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
> BACKGROUND AND RATIONAL:
>=20
> I was fully on board with removing BB_DANGLINGAPPENDS_WARNONLY, since it
> was pretty bad that it operated on all layers if any layer set the
> variable. However, I did mention at the time that it was going to cause
> us some trouble, but not wanting to hold up a good change, I indicated
> that I would attempt a fix for it later. Later is now :)
>=20
> After much poking around in our setup and deliberation, the conclusion
> that I came to is that we do actually need _something_ along the lines
> of being able to ignore dangling appends, at least in a few specific
> layers.
>=20
> Our setup is that we have a "disto" layer that we need to maintain
> against several version of Yocto at once. In this disto layer, we make
> policy choices that sometimes are tied to a specific version of a recipe
> found in a specific version of Yocto using a bbappend; and often that
> version is only in one or two Yocto versions, which means that the
> bbappend will be dangling in the others.
>=20
> dynamic-layers doesn't work here because we are keying off the Yocto
> version, not the existence of some layer (unless there is something I'm
> unaware of).
>=20
> BBMASK is also a less than satisfactory solution (IMHO). Part of the
> reason we have structured our distro layer in the way we have is to
> reduce the cognitive overhead required to maintain our dozens of
> products that more or less need to behave similarly. Keeping all the
> distro stuff together makes the quite easy to reason about, but having
> then again to track (probably quite complicated, and possibly
> per-product) BBMASKs erodes that maintainability.
>=20
> We did go through and eliminate as many dangling appends with other
> methods as possible, but at the end of the day, we ended up with some
> for which we didn't really see a viable (and maintainable) solution.
>=20
> I'm open to suggestions if this change is entirely reprehensible, but
> our primary goal is to keep the maintenance of our cross-yocto distro
> layer simple.
>=20
> I also decided to simplify this to just ignore dangling BBAPPENDS, since
> I suspect anyone setting this is simply going to ignore the warnings
> anyway, but that can be changed if there's a strong option to do it
> differently.
>=20
> =C2=A0bitbake/lib/bb/cooker.py | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 1810bcc604..349e27d538 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -953,7 +953,11 @@ You can also remove the BB_HASHSERVE_UPSTREAM settin=
g, but this may result in si
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
appends_without_recipes[mc] =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
for _, appendfn in self.collections[mc].bbappends:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if not appendfn in applied_appends:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 appends_without_recipes[mc].appe=
nd(appendfn)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layername =3D self.collections[m=
c].calc_bbfile_priority(appendfn)[2]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignore =3D self.databuilder.mcda=
ta[mc].getVar("BB_DANGLINGAPPENDS_IGNORE_%s" % layername,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 False) o=
r "no"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ignore.lower() not in ("1", "=
yes", "true"):

At least use bb.utils.to_boolean() so this behaves the same as any
other true/false value we have.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 appends_=
without_recipes[mc].append(appendfn)

I'm torn on this. On the one hand I do want to support our user base,
on the other this is adding back some API we decided we really didn't
want. I appreciate it is different in that it is layer specific and it
is silent rather than warning, but I'm not convinced either of those
things sell me on the idea that we want to encourage people to be doing
this. We did consider making this layer specific and decided against
that at the time it was removed.

The choice here is between defined and explicit configurations and
"mashing a load of stuff together" and hoping it works. We directed
people to BBMASK as that is much more explicit. I suspect with some
distro version overrides, BBMASK can be made to work but it will be
more effort that just ignoring any mismatches.

Cheers,

Richard

