Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E05CD98F6
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:38 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40009.1781867552475337935
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 04:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Q/Ey0BjI;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8db9f25c5acso26610166d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 04:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781867551; cv=none;
        d=google.com; s=arc-20240605;
        b=FpjI70PIRdBp5/pWX//nhVpP3s5DJZnEMjXpErSF+70+xYF6tQVSHS6IGox4xQnSjh
         oK1WUzxW2jCAruhsyLcte20UDof8uH6RnT7dQAcoVhIJyYg+mqeoa5oyoAgtcoNvGEJq
         yXGN1ruegaK8Fyvde+5Co5uONrI/YpZh8hHIcqE23S6nob6VOGt5fjpmdB+MnkgCLuGk
         c0R+jKswDDXniqs7zfw2h941EoapEnhwjIorG9yczp3+BcansQTJfEMg7h+DMvN6tKSs
         u3zoHhkHmFXdZ7uuh1Yrg3RnrTp+vO6UdlgPwyDesc2oU/cbua2gl0ZZ+gHt97yvZnBe
         32Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6LaKeseVX60SOQ5gLl/bjziOPWYYEsvTOcP7OZVA8HI=;
        fh=S70EIw5I6KnwG2JXmyE4WkvLU4aK+s9Srxw9jTjAdcY=;
        b=K0vF0rH3Wfd6T7GOt6QII4aQPK+gsdu4MJrSVYNoIK/YyVllsuz5lbC9i0gGjXjg0/
         nvFFFONNzPWh0ArTzg3G0QmwCLNL9U5/E0XcArXDB+KH3u7ksWa8ZHo71tFeN1i0TA1c
         48haCFFFDK9eqph5O0bx3uG9jLxtGoz2247WC+uzQaIVLO5Y9+d4SItxwUqjZ1wx57pt
         3Uokc+mHWhgpUfU9/DtLmLM0iYnpykhGlzC3D+Pqhvd2m358hG3oU+YSFPWrv8H6b7BA
         JVozQn3TLwdc06hdP19sg3cBSoPUt8vRv8B6WZPbpH+p/As2x1NMv/kULHi/rWVX5iZ0
         LpGg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781867551; x=1782472351; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6LaKeseVX60SOQ5gLl/bjziOPWYYEsvTOcP7OZVA8HI=;
        b=Q/Ey0BjIdvmBesmcc4SIWpi7b8oxBTbZ9NmA4LvB6BDxUh8J1403vwVUMZgTMKel1L
         BAT5v5QfwQxaXLoFqiSYXvSiQ+mLaLvKwp7aBatvunZ7eK3AYnV+ff7b4PewgKO71HE9
         5tx/a3b1XhyMzTNQ0L0ceSEXfuO4G0FRKdb5vmFQMRJkh1s4a/ZI23fqHN6nvi5MULTM
         W5OdhypBLOGUqTbwvJRf1O+Xfu/MTbklBpyteHc/lNTbslFMYENYvXAcTCc9CIgEPpHL
         YQb5caIdnojLxMLu9CCWC6G9j4XTgWgPSczI3D18fvMpWW4fHLa95YoVJNOs0M2m2PLc
         dquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781867551; x=1782472351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LaKeseVX60SOQ5gLl/bjziOPWYYEsvTOcP7OZVA8HI=;
        b=U0uMqbx6X69N5ennxAnmVFUbwTR5SsJwfza8yw+mnw+SY1EwuSTadrn9LX/Cxd19Bw
         YkvQiGpfWd/87AuHoAH0DPZNrPHvP3smydLYjsXZwiYfEMu+plMdAqbDvRe+nitbEcNd
         XIiEK7OFRjrF9FYI5ucG8VFaZfJL4aylua/kZcf25mqhH9Vvfhyu+gfZr3qZBOTX818J
         KTzSgFp2ByaMshqQDHRbTidQnbWtPINmQfUG9Vyua5IkBk1E1sfd/WUbqOkOQN8U933j
         XZdp0WY5sdMTXvJY70j65zcJBkwbf7ZiNYTscNF2bS6i8DBDHLd/42UnYgKHpXn1KrXN
         yUQg==
X-Gm-Message-State: AOJu0YyEHJu9EBMkISGcRkDpr7UOAzlc48dAQ0n6anxf8USRUK/ApJEF
	oOfGpYK/l+6yvL0532db8xWksgBNKFsnRWqooIfYXCOCwLFFqT/5wZDboTkWkRTCNR/re2wojwl
	yhtT/3/y8U8optaMe1379Rm9xuQwhFfM=
X-Gm-Gg: AfdE7cnHNhUJdtdxxe7qtxzb9YWHKnxRvpwSga2CchwerK9LoO+nqPVy7+9+/1ehiTu
	ltZqiWjVmee9IcHD9i26k6Qnq2cTWmzgLJRDnDkxbC1Fcg7Tp9aKDXexzWe2qCvzIVNeHu1w2ER
	P38emxxJSgSCLWXl0Hi9FO4wcfyEF2KMTzaFOCkBcB7pkLCAnPFw1oiti2gcvzKGVlBCvdKLn3l
	tmJnsMTK426HHo1kbjupvhnsLXHfxtybwre5AzX5xXzZj41ysKEJv1O+yoU3QhPg+v/YnWMuw12
	AcbZA2OG5Xn3pRoim88jGJNhHP4TMrc=
X-Received: by 2002:a05:6214:1c89:b0:8da:f3f8:cb63 with SMTP id
 6a1803df08f44-8de4217265dmr49766196d6.35.1781867551356; Fri, 19 Jun 2026
 04:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
 <20260618-bb-setup-source-choices-integrated-tests-v2-2-66b3b438f073@toradex.com>
In-Reply-To: <20260618-bb-setup-source-choices-integrated-tests-v2-2-66b3b438f073@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 19 Jun 2026 13:12:20 +0200
X-Gm-Features: AVVi8CfpqSHtxtMatdEqDbmXYWlNRp42Tc4R5RvHFGsLI3qV2h78bgFtBliXxdA
Message-ID: <CANNYZj8e8gD0=7V_szu-paBWv8fdvLKf35ZOHFe6Tb=USBrvnA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] default-registry: consolidate OE and Poky
 release configs
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 11:12:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19749

On Thu, 18 Jun 2026 at 20:04, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>  .../configurations/oe-nodistro-master.conf.json    |  47 ------
>  .../oe-nodistro-whinlatter.conf.json               |  56 -------
>  .../configurations/oe-nodistro-wrynose.conf.json   |  48 ------
>  .../configurations/oe-nodistro.conf.json           | 117 +++++++++++++++
>  .../configurations/poky-master.conf.json           |  73 ----------
>  .../configurations/poky-whinlatter.conf.json       |  80 ----------
>  .../configurations/poky-wrynose.conf.json          |  74 ----------
>  default-registry/configurations/poky.conf.json     | 161 +++++++++++++++++++++

Thanks! It isn't yet clear whether the configurations in the default
bitbake registry will be replaced like this, or the new
configutrations will co-exist (for a while at least). A potential
issue is that people have existing checkouts based on the existing
configurations, and they will not appreciate no longer being able to
update them. We'll probably be able to get away with it for master,
but the release configs (whinlatter, wrynose) should be kept. This can
be decided later, this commit is intended to give an example.

Anyway! One thing we should check is: how well does 'bitbake-setup
status' (and 'update') handle the situation when a configuration file
has been removed from the registry, http location, or on local disk?
Does it print an unhelpful traceback and fail horribly? Can you check?
It would be good to ensure this is handled gracefully: e.g. no
tracebacks, but a nice note to the user that the operation cannot
proceed as the latest version of the config cannot anymore be
obtained, and a pointer to where it's supposed to be.

Other than this and the comments I made elsewhere, I think you can
start working on tests and docs, and doing this will take the patchset
out of RFC and into a real submission.

Alex

