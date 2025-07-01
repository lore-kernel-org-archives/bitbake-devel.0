Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF3EC7EE30
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 12:16:33 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.9181.1751372183730550467
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jul 2025 05:16:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RJeIWDwL;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so31578126d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Jul 2025 05:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751372183; x=1751976983; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=14UCz8SaKCRPiSFBmh4OJogka+GJuwTaLkEyvzechcU=;
        b=RJeIWDwL0ueC28Y7bHmM9hNWwyu1Oj6HJ3S0oj5zBXHuruy8Csidz+r8ACyK9OfHZK
         Hy6bMjtrZU56gLImdXxXcoZcnDD+YySNPHhR6dwYFi1nv+GQxQIEKknBgb/S21BdAnMw
         iGJ+fiX/LBkkx+2ftlzqOv4NGhfsZlYRhfxYjETfTTWkObbUsxlkPElgZ609rLywPeqv
         ctED8GU+Cm2xAMffiZqhe8mkFJ6LV8+lhxV3WDFAeaFrwM1aJq8e9hhKZWVzifauYDGU
         cv8C2ASi9a/1G7mOl03HGBJTozvTtMthKx9sFOplzX8HjCbwuo9YHhopfubFJmgHtSB0
         x1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372183; x=1751976983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14UCz8SaKCRPiSFBmh4OJogka+GJuwTaLkEyvzechcU=;
        b=AymPpollafmyLjWQjZsx9Ic/X5NwrCt1wk9z2UNG5Bs5JeckI2cLc9WLdx+3of759c
         Ug4nF57nenk8jnE8833MqLR4isjg/1vdBD/zFF11XCwlpBgrrpGvaTWgnlQKw6+Dz+RJ
         ZS9b/fKGsrbg7rwUqEBw6VTtwhk2Qz0uJzVHKIWLiuqa+VLpRvF8qJ9cYMPJnDWvgVu7
         zwpGiOyLtKje1E+zptIMjqcqN8UiOWgFWJruwO1ARm2VdXbmrnKZKsbwU8KlW8cWvOXQ
         srmt47wG+oaJDtZ5tdRaTr0Mu0PUg2IcJbntwCf1/2Idz6TLROkv03nW2xGi7kzqWthx
         1/0A==
X-Gm-Message-State: AOJu0YxkmgB5OcyyT+XFF6jOJ/Vsgfukvydvqyab5Vq9mrPAkSt1SJj1
	hYRlFTDoI/tpfecq6cdzJ0tsA3dDKLBsyIjOy8EuxeZR0/59d81Bwp/4BjXkRXfXmfCZa3ss3sg
	y5tzqfCPMJze2JwspKINyhjoPGhEcamU=
X-Gm-Gg: ASbGncun7IApvbzysAe5dtjjKOOtv6lkYkiggXiCr2lpQJrxgdnoAgumKIPrmqN9CoW
	FOMv8nz4vjiBEQGRWuhQ8TBqZz/x7cmOxlS8+ROBft9B4nEbetULO2vjY/SNUHOMv8qSN+4vUng
	k/GRqRtI9qVYV3mvpc0PFwYRO6efbEJ3rwH2mesSm35DbN/cOWvYC0DNVdl977saterQba7DXUs
	BE+Bw==
X-Google-Smtp-Source: AGHT+IFnwQ5CF/Igoxe5Fmj0TcGfaaP/YINBNhsQbABQCYpyDgYvdHlECqmwo+QA6poO4Fnmq+TVhdC1QijpkjKIZgE=
X-Received: by 2002:a05:6214:c48:b0:6fa:a724:8769 with SMTP id
 6a1803df08f44-7000291853fmr249889036d6.35.1751372182583; Tue, 01 Jul 2025
 05:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250701115935.23596-1-michalwsieron@gmail.com>
In-Reply-To: <20250701115935.23596-1-michalwsieron@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 1 Jul 2025 14:16:11 +0200
X-Gm-Features: Ac12FXzIhSzKEj1H7w_k6Hsj3YvLqVfMgKQvcT9zrb-elCnKEoVvxpXBi2TzLsM
Message-ID: <CANNYZj-YAK4b-gWxteO_rT86VND_3LYWgOXxrXSPWCUddCUy0A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Make checkstatus respect try_premirror
To: michalwsieron@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Jul 2025 12:16:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17733

If someone isn't already very familiar with what try_premirror() does,
they wouldn't understand the issue or the fix. A better commit message
should include that information.

It would as well help if you explain in detail how to observe the
issue. Do we need to add a test for it?

Alex

On Tue, 1 Jul 2025 at 13:59, Michal Sieron via lists.openembedded.org
<michalwsieron=gmail.com@lists.openembedded.org> wrote:
>
> Otherwise we might be hitting premirrors for repos that exist only
> locally.
>
> Signed-off-by: Michal Sieron <michalwsieron@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 0ad987c59..b5e8bfac0 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1975,9 +1975,13 @@ class Fetch(object):
>              ud.setup_localpath(self.d)
>              m = ud.method
>              logger.debug("Testing URL %s", u)
> +
> +            ret = False
>              # First try checking uri, u, from PREMIRRORS
> -            mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
> -            ret = m.try_mirrors(self, ud, self.d, mirrors, True)
> +            if m.try_premirror(ud, self.d):
> +                mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
> +                ret = m.try_mirrors(self, ud, self.d, mirrors, True)
> +
>              if not ret:
>                  # Next try checking from the original uri, u
>                  ret = m.checkstatus(self, ud, self.d)
> --
> 2.50.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17732): https://lists.openembedded.org/g/bitbake-devel/message/17732
> Mute This Topic: https://lists.openembedded.org/mt/113925872/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

