Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A5AC54F51
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 08:01:36 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6391.1785312092622811377
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jul 2026 01:01:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hYIWLoP1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15e03c2763so123858566b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785312091; x=1785916891; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fgjpeU6EyIfm332KAlua6wAllck+T+S8E1E2Jf26sig=;
        b=hYIWLoP1V2K67diSXsDCqyGztYYHXct8B+vpSDZ5VqyEpJN4qlDYmeux93PkdShwCq
         BRYgxyGNDo20nOnKT0dFEIy+aKeakKT6e8wLG00uZY4LHWvFANQayd5LLFOr3FlDij6Q
         kUJdFWvTxjIR37cDCI0ZC4Bky+4bIGdzcSNeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785312091; x=1785916891;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgjpeU6EyIfm332KAlua6wAllck+T+S8E1E2Jf26sig=;
        b=crjLJEYtnpz0qgIvTuhg9Ao4GniwPb0QvJkF6lDIm+rBr/X8gsuMCwHWO23lHAWw9U
         mBZQIYWZDw+lv1bAxx6+RniCHkdaY/QIhuJQLu2t0TPQS+hvXhp2IgYKKHTTDV94mnuu
         8HXjYDR9Ya8nSHbw4+jZj5MgHVZmkKCNa+h+Rl0oylSa7ywDjLlJpPkCUEc6KumveBmY
         3Gr5Hzs68nKSeRZbzmDyfvPXYIdYYbetQM6JRjqKlg8k+pO/dqg8/V9K338vhN1iDrl5
         a/wLFfOQHOlke1RQ6IzKMh9g8EjpRikEzVOTgNDhIpGrBDy7xBUX2QCL4nWqNGY1dAhp
         ZdBw==
X-Forwarded-Encrypted: i=1; AHgh+RolJAexTtmMhs1jTSCzraAPfR/z50INcLCg6n4decD3wQN4I4bfICwMo93W5IrELwv4MDAUwZFkbe+sL2bG@lists.openembedded.org
X-Gm-Message-State: AOJu0YxD8wRgy84cPpgMKzgpxfD1rHtxIAEi0BtTpD2R7ACZ0/k0q5Jz
	y0/iuUdP9rDEelbqBohQplo9zurrLlCTgyM/kZh4mCzvKZiHLoDoe2Z0RSkcTDTLRgKjRdpucLw
	B297G0BA=
X-Gm-Gg: AR+sD12zjLi/5/ayG46aa3nTB360uwdYpRFtFOibJ4hiTXKNioLcsvmxIkn414SOG+q
	n5QsCa7gGwwRdFIs+NrgoYh13V6ex6qFQTMUzA4Xbo9E8bTBC/0H7p7egkEuFeTvx6+8I7cfwOr
	N0G2jXj5TeiH4YK7i6I0h0lhqfgxkS5ExsMPPFe5K93gd7erreIke+sNjRinV2Tyc7Xluw1DaJt
	GueXhUhjfpQOLh2pAQ7vNvyMNA485b3ZhmHKQhMPDfmP9NOYHdkb9wwbtsiC8imVYmgyr5JYEQX
	hyuOR7hpijISjfx/2igFDIOl2wvVi0erl3hu02yxGcEuh5QcQZHNsoCMJme+l/iTZlCFBniI7zC
	/uWW/017BCQcDg08JAVwrhkL+brJ48DOmJRoogssVqTQkV7SxbjCboJ5g7gVXSbS7KZg96uToOh
	0D58y3rsBRFFcfgwUCIr/ZoV5jxjr+ncbAgTtg7BSo+Fzplhs++fS+JyLefEuCmRa+0YQPjd5e4
	BBVuXAyRjn8aiK8Mk5u7uVTP9hh4S8l6sSetHCWuAfvmVkKyF2zyw==
X-Received: by 2002:a17:907:3f04:b0:c12:8ede:77 with SMTP id a640c23a62f3a-c1f8cc9661bmr66629066b.22.1785312090474;
        Wed, 29 Jul 2026 01:01:30 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3647:86f2:68ea:efc7? ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f50a4dsm76046266b.32.2026.07.29.01.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 01:01:29 -0700 (PDT)
Message-ID: <f72749cd66f1f9783ceea7586da2320d06c5b3d4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-worker: Evaluate
 exported_vars() before emptying the environment
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alejandro Mery <amery@apptly.co>, bitbake-devel@lists.openembedded.org
Date: Wed, 29 Jul 2026 09:01:28 +0100
In-Reply-To: <45e074c4-c23e-4416-9f18-e9198de17c7b@apptly.co>
References: <20260727172856.2304118-1-amery@apptly.co>
	 <8b324e07c0501a6e613fe197aa6e462422360d93.camel@linuxfoundation.org>
	 <45e074c4-c23e-4416-9f18-e9198de17c7b@apptly.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 08:01:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19872

On Wed, 2026-07-29 at 01:28 +0100, Alejandro Mery wrote:
> On 28/07/2026 22:15, Richard Purdie wrote:
> > On Mon, 2026-07-27 at 17:28 +0000, Alejandro Mery via lists.openembedde=
d.org wrote:
> >=20
> > I did a bit more research and thinking about this and I think I
> > might
> > suggest a new approach. I've noticed that this is the only user of
> > exported_vars() in the codebase, so perhaps we just stop returning
> > a
> > generator?
> >=20
> > It does appear to be causing a lot more problems than it solves,
> > particularly if we just turn it into a list anyway!
> >=20
> > If we change things that way, it seems much more unlikely we can
> > break
> > it in future and the need for the comments is removed.
> >=20
> > Does that seem reasonable? Sorry about the change in direction but
> > this
> > patch just doesn't look/feel right now I realise there is only one
> > user
> > of the function.
>=20
> absolutely. I blindly assumed you wanted it to be a generator.
>=20
> so, for v3 exported_vars() returns a materialised list. what would
> you want the tests t do?

We probably don't need the test case now the problem we were trying to
protect against isn't there.

Thanks,

Richard

