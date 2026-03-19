Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D33109192A
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 22:02:35 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.127.1773957749417598711
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 15:02:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VSUb+1V9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fda2a389so5161225e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773957747; x=1774562547; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/alXSIZrIMaBATCM7ZTDRfWM3/TKciCAsqDdhdRFgLQ=;
        b=VSUb+1V9/u4xdXbjqGVuxiSDMwZjXjmVbwGQswAo//rKm1qXJ3Xk6iHDaNoq5zOL8j
         A4w/FzPIbixo8gfFwx39t89TvOXD42KNkauDEJnWYCSZ+0mgBzr6NpFW6ggcxmbNoMup
         TWq+ir3efl+dpUSZB7dj/qJ4P68xeLwI/fME4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773957747; x=1774562547;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/alXSIZrIMaBATCM7ZTDRfWM3/TKciCAsqDdhdRFgLQ=;
        b=du6H2RJtjSugC47EdvLGFJHgOSbt5CUo4g3KNsIVXtSsVwCmHF48aZ6YhUniV5vbg7
         yyyYz616zczQCSF4N0MeOWhmEEGcpdEmv9wSvkK+QqYfCFN/cd9Xgh4gWa0SsRQX3elt
         IhDBIY6FzhBSmuE/15bW0Nk8qlrc+6q2FoelPcLhV/3BCsf889cjuV2LatSaPZggKdu8
         IXHnWyHOkmsinmIPI7uQ51wusJBwm3MMfscs4g0t0ExN162/nsUSk8FGb71Ej14AQQE5
         iBftl0ahZ50KVAA4bWsEO0cUsbVUDy7r6Qk/p6JJMIrSA5f+KYlki6RRe6Ia17wZBLmD
         F7dw==
X-Gm-Message-State: AOJu0YxubNhHAaxhDKIbE3lg9ttXxKqiVCHvXz3YrlaHzuZ9D1LOGsVF
	Wu6WnmCGoTi5/l86nj7b1cHJwNjyNEQRjkCRngSrjjLvRQ6Wv1UWJVyFfuacvQkAAto=
X-Gm-Gg: ATEYQzyptV0suKXwdjzZu1DeB4sTO/X0AWUqFbSLtg0D9NvSQ4aCABNWFu84lrW6bfG
	nid3LZLu6mfOQ0ALNACMyHxrKBdlvDWjrcmKQ6SCiPDvHz/CS0ICJokJIKwDRlSUAl/uSHySxgI
	fW5Gv63hXDnPZE/37fxfSFzA3PGDrX/wo4h0aAULn9vLDHn1C395fss3bnC4CZdIn3PTuUp6s+w
	NSYKnnAL7BNX2AlPpxW4MbeWBmDQ2Sdt8Z+TuMZ9Pf2X898CN0Qnf5Ilbi87sn1mMydjfCTntfn
	weJNj1omo/boLXZ9qA1uceonvqKorspjGUEHaHMsaotXJH0lMNmROr2ApRDz5E5oCktHnivgFgf
	folTvvmq14gQgSQowKyPmbrC7FhAm/aeQ6ptccEiPPs0qTyR73y6Lk/ZNJJNyI0MWiIM6T2YbyP
	iozAQYB+w+h6HG38uqTUVd7vPOBe4dOHammKGCsNFc3SQ7pNrldOtQMv/rmF4BG1qXEl1PXokgP
	Bh/82uMuFiz4Ge+
X-Received: by 2002:a05:6000:144a:b0:439:be67:a038 with SMTP id ffacd0b85a97d-43b64270ca8mr1694331f8f.41.1773957747422;
        Thu, 19 Mar 2026 15:02:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:825d:929b:d471:a79f? ([2001:8b0:aba:5f3c:825d:929b:d471:a79f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64711f58sm1692035f8f.29.2026.03.19.15.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:02:26 -0700 (PDT)
Message-ID: <c16464d67528ac1bf90a466eb96b695da1471159.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: Add an 'update' unpack mode
 to the fetchers (git only for now)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Adrian Freihofer
	 <adrian.freihofer@siemens.com>
Date: Thu, 19 Mar 2026 22:02:25 +0000
In-Reply-To: <CANNYZj-dY7PfmJDe7W4KjbRp-WL2iLVBXo3MnLk3OmJ1+QtGsQ@mail.gmail.com>
References: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org>
	 <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
	 <CANNYZj-dY7PfmJDe7W4KjbRp-WL2iLVBXo3MnLk3OmJ1+QtGsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 22:02:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19177

On Thu, 2026-03-19 at 22:24 +0100, Alexander Kanavin wrote:
> On Thu, 19 Mar 2026 at 22:05, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > There is a bit of a debate on this line between Adrian and myself.
> > Should we use:
> >=20
> > git status --porcelain
> >=20
> > or
> >=20
> > git status --untracked-files=3Dno --porcelain
> >=20
> > ?
> >=20
> > The difference is untracked files. The rebase will abort if an
> > untracked file is changed by the changes involved in the rebase so it
> > will allow untracked files to be untouched and should be safe.
> >=20
> > I had thought we should exercise caution but perhaps that is ok...
> >=20
> > Any other opinions?
>=20
> Yes, actually :) The bitbake-setup patch I posted pre-empts this check
> entirely, by first stashing away everything uncommitted, including
> untracked files, with a warning to the user. I want to minimize
> various aborts and errors on updates which will cause them to
> half-complete and leave the checkouts in an inconsistent state. I'd
> rather stash it, make that clear, and have the user handle the
> un-stashing and any needed conflict resolution after the fact.

I was looking at your patch and I'm not 100% convinced about this.
Personally, if I have things lying around the tree I've forgotten
about, I'd prefer it to just error out and make me fix it, then allow
the rebase to happen.

Stashing it make it "disappear" and would probably confuse me more if I
miss the message about it doing that...

Cheers,

Richard

