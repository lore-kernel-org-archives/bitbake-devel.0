Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2301E8FDBD
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 21:56:12 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.3387.1696370168428231794
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 14:56:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ensw7FCP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3231d67aff2so1457595f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696370167; x=1696974967; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7nZAO8MlZETIjHDZCVc5pYwTTsd75rLBTRc8H6gVqN4=;
        b=ensw7FCPC0G5lO6StoReFYjbtr0RPLF7JpsLcjNZzr0o2ohrHCXLLhYQjeTIJDX5Xi
         BXoVKYU8cpl83UJ6NYLlF8iT8cfn3f0Thx1OXrbGqWAvaPB9UK5Juav7fOH97XKG6N37
         ehe6J38wKOdJXBDZlBpOvSWmjfilVNoXZX/kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370167; x=1696974967;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nZAO8MlZETIjHDZCVc5pYwTTsd75rLBTRc8H6gVqN4=;
        b=unMHXJ3q1vL3h3uIYy99+puh/JPFRHhncA96Cc73OVj/15HBlTe2Hq3SsaAuOdO79E
         L4ioC1c1NkNAVMzBM2F3kDY21U9uKY8Ufz5iYvcaDwJjnMRJVMSjHtYh8GeI+iRjDdgC
         pYhi2LaU7PcGQ8XLgbn/G2oLfv+YyhAM9bz71Pb4tLn3rntlL858TY9wl6zVvSbWqeom
         +2JYZh2klhix6X7aGaseb4jgDm97sfgHSrqfYmIRYram7TO32CIRx47+kPBSqtt/RZSH
         Nx8tnVSeBcbPU7G6Dwpd8Y0UwNu1ckp0/w3YN0c93BhWqgSJE9cTXdrEXQPlJoluE9U+
         ibZQ==
X-Gm-Message-State: AOJu0Yyl1RvAttXYwX3J3Qqb6tM1UjTxbrUwyL8eBiUsApKW3N779W9u
	swAhoNc5faCy3/yjhtQOtUy6UA==
X-Google-Smtp-Source: AGHT+IGZHvyk7A8hZoCwNbUm5rsuDQ7/NsjE0fy9JejRfFNnBnf1i81tnoHsS7UvWP5nZei9ldLnpQ==
X-Received: by 2002:adf:e404:0:b0:31f:d8b3:ea06 with SMTP id g4-20020adfe404000000b0031fd8b3ea06mr478558wrm.0.1696370166858;
        Tue, 03 Oct 2023 14:56:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:cc7c:410f:894f:7a55? ([2001:8b0:aba:5f3c:cc7c:410f:894f:7a55])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b0032415213a6fsm2442055wrw.87.2023.10.03.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:56:06 -0700 (PDT)
Message-ID: <7901b68485c9e4a718865d07b6e0ce194366b042.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] toaster:update selenium version and
 code syntax
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Cc: "toaster@lists.yoctoproject.org" <toaster@lists.yoctoproject.org>
Date: Tue, 03 Oct 2023 22:56:03 +0100
In-Reply-To: <20231003172623.72071-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: 
	<20231003172623.72071-1-marlon.rodriguez-garcia@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 21:56:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15179

On Tue, 2023-10-03 at 13:26 -0400, Marlon Rodriguez Garcia wrote:
> Updated selenium version to latest 4.13.0, changed selenum specific versi=
on syntax elements to accomplish test success
>=20
> Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
> ---
>  lib/toaster/orm/models.py                     |   2 +-
>  .../tests/browser/selenium_helpers_base.py    |   9 +-
>  .../tests/browser/test_all_builds_page.py     |  26 ++--
>  .../tests/browser/test_all_projects_page.py   |  14 +-
>  .../tests/browser/test_builddashboard_page.py |  10 +-
>  .../browser/test_most_recent_builds_states.py |  12 +-
>  .../browser/test_new_custom_image_page.py     |   4 +
>  .../tests/browser/test_new_project_page.py    |  12 +-
>  .../tests/browser/test_project_config_page.py |  29 +++--
>  .../tests/browser/test_toastertable_ui.py     |   7 +-
>  .../tests/builds/test_core_image_min.py       |   1 +
>  .../tests/functional/functional_helpers.py    |  21 +--
>  .../tests/functional/test_functional_basic.py | 120 +++++++++---------
>  .../tests/toaster-tests-requirements.txt      |   2 +-
>  lib/toaster/tests/views/test_views.py         |   4 +
>  lib/toaster/toastergui/widgets.py             |   1 +
>  16 files changed, 156 insertions(+), 118 deletions(-)

At a quick glance this seems reasonable to me but I'm far from an
expert in this area. I've realised that for toaster patches you should
copy the toaster mailing list as well. I'll likely wait a short while
for feedback then merge if there isn't any. At this point our automated
testing won't cover anything here but I know we plan to change that!

Cheers,

Richard

