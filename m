Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF2C5DF86
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 10:09:44 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3796.1787134183149609688
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 03:09:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Q5sVHZT5;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so597470a34.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 03:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787134182; cv=none;
        d=google.com; s=arc-20260327;
        b=VOUTh0/hoYYhvQtwo3flgToRAcn47Hyo6XKQQ3pxaqgsFRwTUmRgHNrtr8bEFH/3mT
         dS6ElGaCvAVL8rOL77PCTKmYwuO3PzFNHogKoXC5No/sFus1Mh4JcmHkHRlM6h8ePxAV
         GD+bYfBA9VQKFb8cLbcpUS4gxn9RSxs/Jd8QFUdZvUTt/Rgankz+5I6Njfztbi6D3HiV
         z3j50VBH/Y9lg8PCtVd8szKexQlKz+bAXLT3hKnDfdvQJ+HDh2C4NEpSpN9+udeIQEZZ
         0MFA7yDIV753GcbW4Oo04yWqqkEInP+D0hPCMm7OsRGsQFiJNJPOWI3glDtB/+AuO7bv
         uPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=qLbh+ev6E1Ujpb8GL015ZDJyKi7b0DC/k5Gyiccm79Q=;
        fh=Da0VcnEWTsEJFcxSqb8W58S9DB5DKFhcwZoV1ZLH5nU=;
        b=qUMFQMPqctgA79UoZcQok1Xgj2KwfDbVxkH7R9HlXi9PpO2YYGKPK/mQypqHIXkxsx
         1oQkfZ+mAGjP33hBMpuCkynpQ+6wd+lUA1O5TodwDUqspTuMObgk6EKwoJOWoYoocReI
         BLfpf1hcpdRHFmZ1L3hPyjiXy3Z4O62lh8SvlrODeREksh/BjLOJdQnyiqbIeFiDPtNi
         p+6yeRuKOCe+9miBEcx1G14fihgNpihWDn8gUTMTsQtfx6BKCcpkuVFfppTfH8WWLOxb
         WHl/wj6VDPzjGj5qgyM8NuUyZaspstugVgZSsqdf/8sLce8JKLPhrDumoSMoMKDZ5iyc
         AE9w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134182; x=1787738982; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLbh+ev6E1Ujpb8GL015ZDJyKi7b0DC/k5Gyiccm79Q=;
        b=Q5sVHZT5oXXKQT8wTRa2NfrCSlao6aYdP5NH2alz6EB0nFIsg+3TV41LVxHw1GNIc1
         F3l35C9Xm5bJSe8+hUEAOqBx2Xsm0HfyphfgLCJ8mLqc+haCk2CpJSisWDBiHNj3KeTW
         Jn5SKswTFVBUSQTgk7hudV5NkyvRWkcR3XCxcWOgqHaaO6tAO1OSzkE9uYlhTf41/4aj
         m5Lnu1epvbuSPGU9Oh9h7DaJDHapCnsOnSBoWnwMmXq2oLj/xANzutWg6Z+WkoPmxKGI
         6hKEWdjhmlbmMLDAnoPFjHgCFwSaqtUFz/D5dI/7vh6hnhyofsaCfh3Ce5J/gISTbBIj
         x53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134182; x=1787738982;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qLbh+ev6E1Ujpb8GL015ZDJyKi7b0DC/k5Gyiccm79Q=;
        b=fdRA3vfXEgI9vRRGpjMhVNllDskKoihAWlmJROZLyDWLoRdVFP3w/S2ylBYgCZban2
         w/xRJhivV6EZiVLqTEYuHoVPsezPBpwTn4aQ6itx3D5CRX53glpcwkoI4p6T2RmZlZnR
         Xc+SE/ZW5k/Pny1LJ6m0vZQW5A/0x469jCC84rCxx3V3QYoJFfJ/TdB2SWQIUA1S1p6z
         C3ALREHeV5WixKEZ4lYUalxaaAdQPEsGf/aYlLaq6Iy5WZ0FgumNeFL6HFyhb04tz4LG
         iRsAWRd9zQTQ50IAejv0oHko7VqjJ+O9UwGBi2F0R1CgELbYBSh1RwmArBV6Y5KbelcE
         2ZqQ==
X-Gm-Message-State: AOJu0YydeA5aTf54M+Zl3K703ddt3dnofauzFeLccg77QPb+RlQ6m/9y
	1pMchJL7OZ/ywG8h4bZn4B3ksQHJCl0Rd3b8SPECabHnJYJEnGTDAgHLtLZwOpY6z6hIYZtpiAL
	CSD8JjNpJkqTuzjkxgCXGT00xD5FAEKq5xg==
X-Gm-Gg: AR+sD11ULBXrJ7nyT3U29N4FCIY+7FNqqLQrQGe0pU/6axs9LpgQUxeA1WFVrw6pfzI
	MP9Oh70hP2Me7loxGHQ/5jA0KHF2vw94/pG+UavIuIbxn1yP11ZvvTuTfP0D+q3w6RS4Dr54zuR
	7xuz/JE8TyB/sc680gt27vdbXlZtWsGiWNOkSIphmpduxCcMssb0mEQcas8cknesWh1g/1b8zIq
	PsJFLxmjoS6QF9QMWh8gC63EPyzG00pHZ5mqZd0KluLLzAAMs6nSV2WpeubTFgjz4p1jQNgxIlo
	CRv7D/Xab/a+h6e13WDncGmyYWDs5EO1IrlWBDLg8p3RQoZV6L6IAuAq3KfDRwvkv62SXHpgbFv
	ufnRy6yumNH6Wg3xZzmZLHVSdN38WHDtOyZFoxTdBTaiqIiubfcs6Da2MaAAApxn3Mm+Kdg/FHN
	9owXCjZVPjiJYxWVL3Pgf1Eh+VgC3kerWVNmGo81aKmA==
X-Received: by 2002:a05:6820:4c16:b0:6b1:858:28a9 with SMTP id
 006d021491bc7-6b13c3853femr3303464eaf.9.1787134182178; Wed, 19 Aug 2026
 03:09:42 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 03:09:40 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Aug 2026 03:09:40 -0700
In-Reply-To: <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com>
References: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com> <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com>
MIME-Version: 1.0
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Date: Wed, 19 Aug 2026 03:09:40 -0700
X-Gm-Features: AcwNN1WOixcXMNgsqPodDz80uucRrlWt0Fe44t0I5zZVWQm9X3Y_7ArCxnfxA30
Message-ID: <CAK46CgSuNHHqd8Nm_9KTEiiad1+4LoQB9sJ-5v89uhzjCcP8Bg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve build config when
 init script is missing
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 10:09:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19993

Hi Alex,

Thanks for questioning this. This came from auditing the failure paths
in `bitbake-setup`, rather than from a reported OE-Core incident.

I went back and checked whether the scenario used by the test is
actually permitted by the setup/update model.

`checkout_layers()` updates configured git sources and selects the
repository providing the setup helpers based on the presence of
`scripts/oe-setup-build`. It then creates `oe-init-build-env-dir`
pointing at that repository, but there is no invariant or
configuration validation requiring that repository to also contain
`oe-init-build-env`.

For a configuration using `bb-layers` rather than `oe-template`,
`setup_bitbake_build()` does explicitly handle a missing
`oe-init-build-env`, so that state is already considered possible by
the code.

The problematic ordering is that on update an existing `build/conf` is
renamed and a new one is generated before that check happens. If the
updated source revision no longer provides `oe-init-build-env`, the
function logs the error and returns, leaving the regenerated
configuration in place; the caller then continues as though setup
succeeded.

The test removes `oe-init-build-env` from the next revision
specifically to reproduce that transition. I don't have evidence that
OE-Core itself has made such a transition, and I should have made that
clear in the commit message.

So the motivation is defensive handling of a supported source-update
failure path, not a failure I've observed in OE-Core.

If you consider the disappearance of `oe-init-build-env` outside the
supported contract despite the current handling for it, then I agree
the patch shouldn't be kept.

Giancarlo

On Wed, 19 Aug 2026 10:36:32 +0200, Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
> On Wed, 19 Aug 2026 at 06:24, Giancarlo Cicellyn Comneno via
> lists.openembedded.org
> <giancarlo.cicellyn=gmail.com@lists.openembedded.org> wrote:
> > + os.remove(os.path.join(self.testrepopath, 'oe-init-build-env'))
>
> This seems like a contrived scenario, so I'd like to understand it
> better. What prompted you to ask AI to write a patch for it? How can
> this happen in actual usage?
>
> Alex

