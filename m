Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B928AC5DF86
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 10:19:24 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3909.1787134763351323282
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 03:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g5EWf0Wn;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ff20870ac7so8755896d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 03:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787134762; cv=none;
        d=google.com; s=arc-20260327;
        b=Ou7wLTL+Zw1/fdiw35OvH8bc9+MnplFwN75PyMc5irE/T6CZ0sTYAd9O/qDTpoXweZ
         a0bsLyG8Ha0WyQFPSeK1j2anDA68+GVvS1/G/xtsZiMThhHY9GraYGK37l/imCuJQKME
         hcMH7CZf8R/lbaCScrMNPYSN+mOm0qN9biGZHsUy5ahKcca2a+yQNfJgCk8TT6OjN02e
         xQL+ctuAa+C4jhRjGY56eSqdrt5HTdIAG1fT+zvE9M4pmFSOHliKbXiBCdNWDi4RdSW/
         fUiWgWI9Cxvx9zpg3kvbO/JrQUCTSr3gWSS7QUN9GUdO/CJR0hE6UOR+/51k56HQ6/5T
         QlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=owMWTeU9CdmTRRc4sPlow9aOkE847m6CMYNK83ru+6A=;
        fh=sZ+LizO92di32clJ5O4FZQSlrzEWq9dYqe6rVfGtX9Q=;
        b=LGTc7WJA+EAq3zgFaBtSpcycem5stBG7jH5GoaEwqQD6JjaXWZHSQ31wMf5gWMF/B4
         Wbg5HUtspP6l5ph2q38MDI4ejyOP2egSPXkZKJBMu7uH1tjdHXvOWeFiAc04g4uljZjH
         TjY/hqvMCSwZGAFeyneUJATx0+0VxzR90mQ4yIle1VVoY4deZAGjC+/ypi07Uux359fZ
         wBV16D5SkMm/OsL+lOPIkBjMDCS9sbvEk3QHK6CT3mDLO8VcO8KMQyYJI7hQv+MGWWu7
         wi6b1M1DcyvS+SW2W8x3ndPS+I/TFjHvXE4wx/xcpdNEGApEVHrqd8PhO1K0Ddhq1JZp
         ahYw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134762; x=1787739562; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owMWTeU9CdmTRRc4sPlow9aOkE847m6CMYNK83ru+6A=;
        b=g5EWf0WnEWJ2a/JN99PLR9ZnjhVZqZiLBthRRYdiCn7ouwvYdrhzzfmDcrWSOorvxE
         ZAlT2GxhO81uYlpJdqhDVqcl/RxbaWrPtALWCygBRvSLuNSct7kbpp7Drr+UBbEFZO6e
         zI2Bxc7Fw28gAj1LCyyeNEqX0uEkENjwp7dSbVaDPDLa6ste57dE+FYtoVYMoPdTEyp4
         uP3+StwXnW0dcwHivvcRJ3IG4StLT0pvijBE9XhQVRQedKQLku41UVE0Rje0PrJ4DpyU
         4HKzTr1oxoiH5evDvlc82adi6Lr6Dk/u1JUpZ+QGRNHKVo4euDLIbUle5eFH5Ly7cJZ3
         KCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134762; x=1787739562;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=owMWTeU9CdmTRRc4sPlow9aOkE847m6CMYNK83ru+6A=;
        b=LX3TJaJ7Fpk/VpHTlOaxuj5gvppeTE+m3rj3CO5lNMDYpJZQArGeNpai9Sg333glbc
         sSY4MgT3d3XM0SG4lE/Pq6RSim7g2jE/0MESqPESlLSms2tMq3wYFxOo4JlQggWQn0CI
         /zBetXo/hx0gJECP80juRgwn9v8rFJZiySQUHZByuclTKHpLc/Dc/G4Z//WW07Ph6mHD
         OFtyVOTsVT4jp+tJ3GUPgsjmdFLA5FqMgLkFjR3Z86vwh+Mx9GLNqEArLaDBc2nq+t65
         arQXqDX9MtTzd2JgjVkR8jO4sEF/4X8o5DYeku9MjfeK0lpAw91q9Cw0ighn41ZHhUci
         NcoA==
X-Gm-Message-State: AOJu0YykT9QE2TsAwtyFiFF8k9JZHqJZoAtE8+I5y+kfUSNV2DH9ocis
	BVQk3sYWjvAomDzB4c1bMwUV2k3CAcTKcFSxK5BEjhWB1fvHdoeWOun5ZNhOSa+SPrf+hdPAJiz
	JZ87rNyudR/12808cHA4tuf4vX4aVLfw=
X-Gm-Gg: AR+sD10M6ElDubUAxpsu8OeAHRkE7PPoL0ZLZDd0jqaLyaLeEXt6oF8nSiFxiqvSHFX
	wKeuJgp7d+KFBRb8gQCqjgOHLDNrVORQqc+ALhGjtxpB/xysvdUPNQv/VHATBpFhiymKIBmn1W0
	uzTamDCCZcJGynw3rQI3ODbGIo1Mx/hfBXN9Qg0W9Xau/Qr+HCFDj8Y87Pdt0ROTASxhcLcZaZt
	8xHVrs82zU41VEgx0w07i8t1aYFPugQXDOaGFleN+ARIEnoMt2pspGp9stn6EFqJluq6aWq4ut1
	9MVRwrdiNgi9RMzv6eF0Oz2mxda3T3wO9yZrmcbmhHP3IZxw8KP1iQPTQ7aumMEzw5AjPVxDYQh
	V8qc=
X-Received: by 2002:a05:6214:5002:b0:908:23fd:813f with SMTP id
 6a1803df08f44-90c5eaa289cmr24943126d6.15.1787134762183; Wed, 19 Aug 2026
 03:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
 <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com> <CAK46CgSuNHHqd8Nm_9KTEiiad1+4LoQB9sJ-5v89uhzjCcP8Bg@mail.gmail.com>
In-Reply-To: <CAK46CgSuNHHqd8Nm_9KTEiiad1+4LoQB9sJ-5v89uhzjCcP8Bg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Aug 2026 12:19:10 +0200
X-Gm-Features: AcwNN1UIMVnQFhp5r0HFxraWLQtI0KXY8yIJAGw046srzIqQVcn4zUTDjkwX4FI
Message-ID: <CANNYZj_v-WM7ZQOt+ytKGG2KxbE4w_Q9r_w1U1nJTLkfZLy_Ow@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve build config when
 init script is missing
To: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 10:19:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19994

On Wed, 19 Aug 2026 at 12:09, Giancarlo Cicellyn Comneno
<giancarlo.cicellyn@gmail.com> wrote:

> So the motivation is defensive handling of a supported source-update
> failure path, not a failure I've observed in OE-Core.
>
> If you consider the disappearance of `oe-init-build-env` outside the
> supported contract despite the current handling for it, then I agree
> the patch shouldn't be kept.
>
> Giancarlo

Giancarlo,

please do not use AI to write responses in a conversation. I want to
talk to *you*, not to your AI agent. If you do this, then anything
coming from you will be simply discarded on the grounds that you don't
understand your own patches.

Specifically here, I'd like to hear from *you* what instructions you
gave to AI. Was it something along the lines of 'find problematic code
paths in bitbake-setup and fix them?'. You need to be clear and
transparent about it, if you want to maintain trust in your
submissions.

Thanks,
Alex

