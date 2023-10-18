Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F6C41513
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 22:10:15 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web10.14191.1697667006412839108
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Oct 2023 15:10:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mRVckNqy;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7b3d33663so98558557b3.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697667005; x=1698271805; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=owz99JVyZVEJYDxSxAjEJlBhLmUC+OMibFAeg75Bo5E=;
        b=mRVckNqytM8swOlLqNk6noynYg0oeaBiC/Sdt3smZXIhTveY4M10Sr5t/0rTPKv2aY
         vY3z5OmacyuJg1Sk/X282M7qHg28zp2TtnvnabzzhTShylR8hkvBNtazOtYzz37/+jPi
         lnr6FRY/uVzHPFJSv7uxEHDGRVEZ+PYmMjNV/WQLXAYzX2jd4HssGHnsS5lVa8fOhhb/
         rU8+cFBuU/5AHN+Nq79IcgmH7JaezuHdfteikfT+kJCBCiOZ4t0D6RPp2oO/s+zLvRAt
         j08h303JIrjzTa+xmgvWc8ltGq7+ozolISWwdEaVdCDX13qz4H6BF5kduEdXUAzeyxC6
         V5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667005; x=1698271805;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owz99JVyZVEJYDxSxAjEJlBhLmUC+OMibFAeg75Bo5E=;
        b=jtJa3sEbinGUntHw29G/3H3yQ8VKDq/MzcaF5JfokHguvbIQnoncPgjjkJnjcfBk5w
         USlr8XIRuBO4eNHjU+AwMAq5stP2SgjNuuSQM/uMsTBHW3Q+7P6C/3dTDmaWfn4LJGYi
         YDhC9KC2fMthtPDw8Xm01lNATMK+qYI26HaulFACN4Wl1Rt00z/mGdVCV3VuL4o0M6dU
         JfCgPzIrloOPJxpuU8nfpJ2gcI3LnUMOo3Zj9qzzANU3VcnKkaKeRcReqv64cmf9DylF
         9BepPvl2pQvE0SOyhz8x+D29Mjz7d9BeagLbXdX3Iydbjx1b/a5gSIUaFI73trw/RG//
         2plg==
X-Gm-Message-State: AOJu0Yzk9hdDY9Wm6YPYlYHRejPZteloT/ZdHz1SS6MGiRhOFfF/RWHq
	heA+I2cIme8c3RdMcQnwbiz5rrnWHoFRMj+v+xbwyXUhnNRnRg==
X-Google-Smtp-Source: AGHT+IFiEkVE1ospCKicSkED9DdA28GRFGLg1ccfcOb7cq9EoDrdwZZ//xEye5Semc5MIl91BmkTfZ9c8obh+0izxVo=
X-Received: by 2002:a05:690c:f84:b0:5a7:b560:12df with SMTP id
 df4-20020a05690c0f8400b005a7b56012dfmr694172ywb.8.1697667005425; Wed, 18 Oct
 2023 15:10:05 -0700 (PDT)
MIME-Version: 1.0
From: Tim Orling <ticotimo@gmail.com>
Date: Wed, 18 Oct 2023 15:09:54 -0700
Message-ID: <CANx9H-Dc7Lh++7ak4jAVhCzEnQRi6PyteP-BLPp1u_RbQM6vWQ@mail.gmail.com>
Subject: Toaster test documentation
To: toaster@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000ce2e11060804e691"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 22:10:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15263

--000000000000ce2e11060804e691
Content-Type: text/plain; charset="UTF-8"

I really appreciate the new effort for updating the tests and improving the
testing situation for Toaster. As one of the few people that have been
contributing in the last several years, it gives some new hope.

However, we need to pause long enough to write out some basic instructions
for how to run the new/existing tests. From a Python UI developer
perspective, using tox might make a lot of sense. So, in the bitbake
environment in which Toaster must be run, how are you using tox? Is it
bringing us benefit over just running the test tools themselves? Are we
certain we want the opinionated results from flake8? Does anything else in
bitbake pass those tests?

The only real documentation we currently have for running the Selenium
tests is:
https://git.openembedded.org/bitbake/tree/lib/toaster/tests/browser/README

Since this tells us to `pip3 install selenium==2.53.2` we already know it
cannot possibly be what is being done to run the tests. So what else is
wrong in those steps?

To make it possible for folks to review the new contributions, we need to
pause and at least write out a simple list of the history of commands run
on the command line. Otherwise all the new patches are taken on faith with
no logs, no test reproducibility, no evidence that they are functional.
This is a precarious position.

The only testing that has been run on a regular basis for some time now is
from https://github.com/crops/toaster-container, and this has caught
breakage in bitbake/oe-core several times (usually after the fact). It's
not perfect, but anyone should be able to replicate the tests. Likewise,
anyone should be able to use the current
https://git.openembedded.org/bitbake/tree/lib/toaster content to replicate
the new test patches.

Regards,
--Tim

--000000000000ce2e11060804e691
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I really appreciate the new effort for updating the tests =
and improving the testing situation for Toaster. As one of the few people t=
hat have been contributing in the last several years, it gives some new hop=
e.<div><br></div><div>However, we need to pause long enough to write out so=
me basic instructions for how to run the new/existing tests. From a Python =
UI developer perspective, using tox might make a lot of sense. So, in the b=
itbake environment in which Toaster must be run, how are you using tox? Is =
it bringing us benefit over just running the test tools themselves? Are we =
certain we want the opinionated results from flake8? Does anything else in =
bitbake pass those tests?</div><div><br></div><div>The only real documentat=
ion we currently have for running the Selenium tests is:</div><div><a href=
=3D"https://git.openembedded.org/bitbake/tree/lib/toaster/tests/browser/REA=
DME">https://git.openembedded.org/bitbake/tree/lib/toaster/tests/browser/RE=
ADME</a><br></div><div><br></div><div>Since this tells us to `<span style=
=3D"color:rgb(0,0,0);font-size:13.3333px">pip3 install selenium=3D=3D2.53.2=
` we already know it cannot possibly be what is being done to run the tests=
. So what else is wrong in those steps?</span></div><div><span style=3D"col=
or:rgb(0,0,0);font-size:13.3333px"><br></span></div><div><span style=3D"col=
or:rgb(0,0,0);font-size:13.3333px">To make it possible for folks to review =
the new contributions, we need to pause and at least write=C2=A0out a simpl=
e list of the history of commands run on the command line. Otherwise all th=
e new patches are taken on faith with no logs, no test reproducibility, no =
evidence that they are functional. This is a precarious position.</span></d=
iv><div><span style=3D"color:rgb(0,0,0);font-size:13.3333px"><br></span></d=
iv><div><span style=3D"color:rgb(0,0,0);font-size:13.3333px">The only testi=
ng that has been run on a regular basis for some time now is from=C2=A0</sp=
an><a href=3D"https://github.com/crops/toaster-container">https://github.co=
m/crops/toaster-container</a><span style=3D"color:rgb(0,0,0);font-size:13.3=
333px">, and this has caught breakage in bitbake/oe-core several times (usu=
ally after the fact). It&#39;s not perfect, but anyone should be able to re=
plicate the tests. Likewise, anyone should be able to use the current=C2=A0=
</span><a href=3D"https://git.openembedded.org/bitbake/tree/lib/toaster">ht=
tps://git.openembedded.org/bitbake/tree/lib/toaster</a>=C2=A0<span style=3D=
"color:rgb(0,0,0);font-size:13.3333px">content to replicate the new test pa=
tches.</span></div><div><span style=3D"color:rgb(0,0,0);font-size:13.3333px=
"><br></span></div><div><span style=3D"color:rgb(0,0,0);font-size:13.3333px=
">Regards,</span></div><div><span style=3D"color:rgb(0,0,0);font-size:13.33=
33px">--Tim</span></div></div>

--000000000000ce2e11060804e691--

