Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C971073CA6
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 12:22:56 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.105108.1775650969138984745
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Apr 2026 05:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gwsionHd;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a210c813f8so47622786d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Apr 2026 05:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775650968; cv=none;
        d=google.com; s=arc-20240605;
        b=VJaxmYoRWdLT5oloBTdysPpRrtojox8jdMOSQbeueE3qxf97wDjYGHmuPwqDOKZvnC
         Fynn8uRMiFh8s824IPEHBDzJZzitDVVA+KdoeFYuTdB2ABNqA75lqDCGZJ1P9DQ6Iqvf
         UoRoRYPO+DFabvqm6eCXfXWLGz5YLpK45LuObNMgtfhZtnP/OupeV9COBTMaMLG02hvR
         hOvwNNpCTVJE1ggljmi8/0PsvrB96kqlSL1F0VabqPQR9/G+A6KI7LV9ibwlCLibJr5m
         U9qErM4yv5TTQHJV7G6Sti9yFD3TdY4Uiay7cvIjo695yQZfmz3YKIctPV1MrrBHBtcY
         CqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Km6ZSNRMN4EpDI7xcXi2tUf+nkDIO8UwypxK0QOIqdQ=;
        fh=t9be2Uk2CNCD6EY0MUbMSR/9GYVzCEQdV7d0/UQTe04=;
        b=gyNDQp/ldCuWu8xA8dxlWZ6NnxaIqtGPsXhOD8mMFz21retFKQEtZ7fEaUOULJdiCz
         HSoOBLAuMXUOAb01hXtG2cvnVNmZVf2CWlUH/RZeEdBq52GzqNO92bY0tI8H4IF28kPj
         hbkzcCM2tJIpSf9pVcDqlI/0z+5F9EKf9AHDiRJVe1H3PpyUUTLW31t5GPfV4a/vbl7H
         eHbSJa0c3kK8LeMh+3jRfsl2FHksbsp96wVXZZ1CgrFTVZajBaISxHc+n3DBO1siaz80
         EsnJTX0C9aFQAc/r5BOXvd6EBfeHdAbT94if8N0s5nI5amqme8i7cmZpm2lD3ZuRVpSM
         FpMQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775650968; x=1776255768; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Km6ZSNRMN4EpDI7xcXi2tUf+nkDIO8UwypxK0QOIqdQ=;
        b=gwsionHdkISdCrCf7r0H/IHA+JcY1aYKG+VdCMvrfVpAToDIn3dCRDwQexpr5q9DeL
         FqBAcrSXUjeP7OhcUSijBcVIwLmfDJHIbQMhUB7LSP7FcAFDjAI+opauxpl7oMWwmhnI
         8/SKJXHLYOdV47rBnngsBfOF0mswp7EpCbLTLwi51sx1jtPgOVjx14L03acU04m70B+0
         qNJaomnMcU3XqoPSHbI2J5BR6jzhJFsdBA9lAbO6upQYzoStdrqyEeyXaLOwy9Ee8/wo
         FfQdblFV/arXb9Ti8zvqSfxDYixohJyXZWCgdNj48Ds+sdQCds2oEQCngcfOTje6rmGh
         UuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775650968; x=1776255768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km6ZSNRMN4EpDI7xcXi2tUf+nkDIO8UwypxK0QOIqdQ=;
        b=b/GH0ay8PIifeLXxz3rQRw7uj6pXq2/mr+wyo3nlYzCm6xvty28dI8bxjvjwbGtWrA
         HL4z8nmTFmyoHxS6u2ZcO0XeNfrqHpvEz3XwcJhekhxjDdk3aJ7ivdUIblcu1AexfRBV
         LYz3LvFDcQUBE7ylv6RF28qjbUmY+/HxdpsUBo3PYEM1+GGR4Y42QltslkStI4kDLw5Z
         KkhDul6Dt6o0UhiONFOmS55TAL5Kc3Jmt2dpWAqm4hIpXHHm+MCc0fisWmKDM1/5qUlp
         +TRsvvRKSQzaYyEh7RaXRolSg8Jrreau9aAqpdvAn0XK5w9T3G3UOBOsi8fodhp00CG1
         n0BA==
X-Forwarded-Encrypted: i=1; AJvYcCXXtjxABM0ZdUV+UsEMyLneANT3DMskOSPzsNKkQCkoexH8heMHfsjO7ClaCZEy9D7yFWqgwVc7Y/qYOEcJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YxdZrKuYqbM/8Ag/WJaxfgDr8DPWI3vIpqFWuqv8vXMBfRssB+K
	RCDh0LBC49/3AsNrlqTwGumAHshZNWisA0rgQ6ygrmzEAIbnvprSUBFzBHrmmqamZ34nHMwrFiI
	Yk4CCE1aSumm2p440xOuMN3MOHhT+oDQ=
X-Gm-Gg: AeBDiev5AsRiaf4b2CRV7W9PgBAeAnk9DkGNp6uaHUvNJKslsbLrO2oADICLmGIRhWp
	xXZNluqz3JxIsNpAgUwt5siVyRAGabey3g+sw5FfA3aKtLqBd2BsuVGrjnJmpzyO9POPeROpr1z
	zl/2IsvlpzJdkfYQObZllqtuLUhTDFs2lZedXEVP9FHfHc5GNKfnfsTphfnpYbzCdhuJnC9HkCM
	7+GTQoLX+KWG/VPsk5Kiw6WPZYzs3pUx/24Hj+lvwzUikheOuQMdjyfAi7pxJNYV+qZm28kF17k
	P6lpkDvjDSA/elhiaGw3/wPq5PdKAHqtGb/z8RaoDA==
X-Received: by 2002:a05:6214:c8c:b0:8a4:21d9:bbf2 with SMTP id
 6a1803df08f44-8a7049c6e94mr327039276d6.33.1775650968111; Wed, 08 Apr 2026
 05:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
 <20260406202430.1856836-2-adrian.freihofer@siemens.com> <CANNYZj-K5KWN9Z9CDZnQyU34bVT+8rkH0uEcfg=FXeOWfm9XHw@mail.gmail.com>
 <6d97488e80b23b08ce5bea25650891f07ff2a9a1.camel@gmail.com>
In-Reply-To: <6d97488e80b23b08ce5bea25650891f07ff2a9a1.camel@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 8 Apr 2026 14:22:38 +0200
X-Gm-Features: AQROBzBAQW487pLZJZ_JRdQOW8rHyeMwg6-07Y76jnv2Lo93wWl7wpphMMlEobs
Message-ID: <CANNYZj8V4ETVtdRLQkwSfydb7SvMJhC0JqXgdRfLw_w_U_TgVw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: update vscode
 workspace always
To: adrian.freihofer@gmail.com
Cc: adrian.freihofer@siemens.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Apr 2026 12:22:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19356

On Tue, 7 Apr 2026 at 21:58, <adrian.freihofer@gmail.com> wrote:

> Maybe this patch is not very important if bitbake-setup itself does not
> change anymore. Might be that I thought this should be improved when
> working on bitbake-setup itself, which is a very special use case.

What I would like to understand is this: what kind of local changes
require re-generating the vscode workspace (when otherwise there are
no changes in bitbake-setup configuration). Presumably the user does
'something' that causes the workspace to go out of sync, what is it,
can you provide examples? Can we write the workspace in a more
'universal' way such that it doesn't happen?

Alex

