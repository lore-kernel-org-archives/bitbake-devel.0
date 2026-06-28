Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680CC43458
	for <webhook@archiver.kernel.org>; Sun, 28 Jun 2026 10:11:16 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15956.1782641469272990718
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Jun 2026 03:11:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PUOsu9PZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so16334735e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 28 Jun 2026 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782641467; x=1783246267; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSDtRalgFMjXqBspRBCj6xc9mg6Plu1YWPA1Sh6esBU=;
        b=PUOsu9PZv3MCMOrpiBUKG2hv7XmTruLqrsk8dBDG5hdmbxBuSHSZAdw1DEJ/RMFpWb
         o52v5XJDTvQ0iqn/zHGCclm2ALkPlxZilmcNGZrcTcRbQOXVMQBjsZuBQhia0aQfT+4y
         yb7XAqwaSu4tWZblbS0feAJEKPkOJsLFxG5F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782641467; x=1783246267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSDtRalgFMjXqBspRBCj6xc9mg6Plu1YWPA1Sh6esBU=;
        b=UvqtuW62tyuJzg3SIkDFjbZiEMlsk8dxv9snspLTYYShcrzwhn4CjFrQzjOEHRkmyX
         KEZrO+o+VqniVlbhMHi+DzvebRHlh4LeD/Q5ucUIET18NBzK5bDk6kG/eq8f+78EePoL
         Rk2/OgfxBdZii/gkyP7F02LONjcH3ulUnYVoyMTinGMmAyWb55EqXJUVSDWAqQwgK+U+
         3AruCRyBiOGrpEx6rs1f2omOOz95iSwnPm4m0oQ/acbRRrxm8WQKCmSyGk3f1mAGENgC
         4JmRp+Y/SyKyF687X/049KQyojzQIIYMCR+FhKaeFWUWmD7RLem4Q/herv+828iB/ocs
         Baag==
X-Forwarded-Encrypted: i=1; AFNElJ/PMw/dbdylm73GxsQ/QUBX6zXledNcm4lQNXsWC4/Z2+BxxACs2KDM8cfEvYemypbV85gNqtQ4pO230dLh@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw3AjNlYeMPTDk/qFT/NI/+8w9PABGKV0U1UWMgVoSJHJK631F3
	ij+IbpyRH2VM0LZ0pYRR81+UOIS/k2CS7+1YrJQuon5P7FzabIFhhOtzt4n4tf0+gpY=
X-Gm-Gg: AfdE7ckK4jP++iIRkF+Vr/gr4RkQz1X4YnY5lDcjW8xLK/SMaEIMOAx9hyoW58/etde
	8iWwQoJl7ZM2j958Nkd+49+Jy5rYBwabqHQe2cW+UcVLGZiKg5p6E+JGhAf6JoF3McBVGljpysH
	7X/tpXFdLVl9/pyr7C2UqB6BP+QJBimvYGiUBl+mzTuW1JuQUkcKNfS8fxadHRHcA3PGrkHCKqE
	Eg4dNYyy8F8S+G4zBlSWxZMcP0sFYMHj0MLgoyWPENpYZ1scYzDKPyoAr6Ff4O9MB9OUzgxsW8i
	EYevPF+aP6BkahCc1+8JG9vR1PvuA6c0+koFF5/tP185sOGQP22FQo50fYzINCdkKWqce9+GccT
	IkJnF4NQRbLLg5eNllVQIcNIP/olLVLG2Mx1G5tYzgLMFtJrUo3JBjOmk4m/MNzHLMVhXewt6lb
	/rfD2BAQ05xjnRHymUe6aREAfP4erzByWJuGSQgVMdEDZWwbXkXduh51bEK6FcB/9EeRoqRxPE6
	7Qa/SyaOvVap7f5
X-Received: by 2002:a05:600c:4e45:b0:492:6f6f:fa42 with SMTP id 5b1f17b1804b1-4926f6ffa8emr118078365e9.37.1782641467342;
        Sun, 28 Jun 2026 03:11:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a165:6d61:c7bd:48ff? ([2001:8b0:aba:5f3c:a165:6d61:c7bd:48ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4730937e18dsm3733136f8f.21.2026.06.28.03.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 03:11:06 -0700 (PDT)
Message-ID: <672671c32a5845e923ef216fd1a15483328def3c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bb: Add prefuncs and postfuncs ordering
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Date: Sun, 28 Jun 2026 11:11:05 +0100
In-Reply-To: <18BD2E2AC79FBB10.1079487@lists.openembedded.org>
References: <20260626170044.3829734-1-JPEWhacker@gmail.com>
	 <18BD2E2AC79FBB10.1079487@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 28 Jun 2026 10:11:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19800

On Sun, 2026-06-28 at 08:29 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> On Fri, 2026-06-26 at 11:00 -0600, Joshua Watt via lists.openembedded.org=
 wrote:
> > Adds the ability for functions specified in prefuncs and postfuncs to
> > specify the order in which they must execute. This allows specific
> > functions to indicate that they must run first or last (or second,
> > second to last, etc.) without needing all places in the code that
> > manipulate the function list to have to agree on how to order them
> > (a good example of this is sstate.bbclass and buildhistory.bbclass).
> >=20
> > Ordering is done similar to how python list indices work; 0 is always
> > sorted first, 1 is second, -2 is second to last, -1 is last, etc. In th=
e
> > event of functions having duplicate values, they are grouped together,
> > but keep their same relative ordering. If one or more functions do not
> > have an order assigned, they executed between the positive order
> > functions and the negative order functions, and keep their same relativ=
e
> > order (this means that existing behavior is preserved in the absence of
> > any ordering information).
> >=20
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>=20
> I've wondered about something like this for a long time, the trouble is
> it does not scale well and I've always concluded it wouldn't really
> help overall and solve the real problem.
>=20
> It solves an immediate issue of making one thing run first, or last. If
> a second comes along, it can just about handle that. The trouble is
> when you have three or more and they all want to be "last", or "first",
> you can't define that in the metadata. This just gets worse when you
> think of independent layers trying to pick numeric values. This is
> already a pain with layer priorities and I wish we'd never used
> numbers.
>=20
> You can already get some idea of ordering just by the +=3D and =3D+
> operations ordering the data, or reordering the variable contents using
> anon python.
>=20
> You could even define a filter function for the variable which could
> reorder things with a custom order function.
>=20
> So I'm probably against adding this level of complexity when we already
> have enough of it and it doesn't fully solve the issue anyway.
>=20
> If we did something, I'd probably look in the direction of "after" and
> "before" operations like tasks, trying to avoid some of the issues we
> have there.

I couldn't help thinking about this more, the syntax I was wondering
about was something along the lines of:

do_xxx[postfuncs] +=3D "functionC[after-functionB,after-functionA,before-fu=
nctionD]"

which is horrible, but at least explicit.

Cheers,

Richard



