Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ED6FF8875
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 11:15:02 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8772.1777461291855281979
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 04:14:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YWgZI6Zl;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso45365866d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 04:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777461291; cv=none;
        d=google.com; s=arc-20240605;
        b=HBD3V0Kds6dW3WkOsQ5nTdsfJyQX5yPpBI7ul9wasoB0ISjwI0WKFChCTCOKyzvOx6
         DtOeTbZl/hLswLsLVyNnDwoJF9sGlbIPGoTMrON92BTXvkxWUXyT7yphwX1Sql2EC6OB
         WM1O4oKibzqtTGJ5TA/FlggUhOD+9hecigaVWdoOwJ5bt6DPPk47DAmpIjSEJj2ul6y+
         DgRgjKAPmEDufnJNJMR6M/l+pjqyKGXbd+BqtqKVYqbcrtYESVIsIJ0fXurWFCeRf1oz
         Z+0zUeRRMWwCSEXRIJ1y4aKKEFSmZcQmq2QuhCdUMciAx1CXDWKYmXx9263Qqvuo1Cb1
         LvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lxaGUYTJzcMAekOYKEPq5e5uos33yruOe6m2ewmi4T4=;
        fh=210XcDjSW4JLGGT2kvxa/vXYLFPraDxedRqab8Hp1fo=;
        b=RK+q5EHY3GKZA0Bo73+2IB6woHNjDBsYbLLGl9ubpmCEx1tKkIXBqEZ19iXYPvdKB8
         h4IxshI+uUmZ0vnem5TnMLqFE9nYGSpsz10IHah5+vYVWCVh5Hl8yZxtbHFhFFTcREj1
         1a2bou0mKTmpcf7Bkor5XjGlMazcbwRZW0PntNhXj7Oa4hItWc7b96msVEHGchqWB8eZ
         4XfWzXReYAL087uofqXmh6niwav/lfc1YNkVUKDbDo5Y+Np9ZKQ4pnS45OXoUOhczVSb
         5EMAAT+qbYvbA5qwGWi9234tRdE3RQ8LVdtLptvVguutZh/bhnHpoxonj2flIv6SWcHn
         rO6Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777461291; x=1778066091; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxaGUYTJzcMAekOYKEPq5e5uos33yruOe6m2ewmi4T4=;
        b=YWgZI6Zlp0W3mWRsE6iFgmUy00wvSB2h6LqMnhZMYoXaBuaOuoc+GPMYFRoq/aS0hG
         kOAhw5bC8KBxXXVu1C94mULjJTONne2Z9pNYsYN6CjkO7zYzY+H2HLk0Bz09/PZMFlfM
         Dm/l7ofAluWVR4faiV0gG0GauIB8dO57xGrYoppsJ9cNoidSgQlTAfaGblijduc5KLRi
         M08rA811PLfmUrOHZDuejWNAKjJ0ffi+NORQOXXO6FfcPsPMkorRV7exsp+qPC1ITsOu
         ZAUpFN1eN6sXGiAt+DK9w0KpaQJu7XAJjOFKIC/RUFNJxQGBVqe36vElggygFe7O3A3+
         GH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777461291; x=1778066091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxaGUYTJzcMAekOYKEPq5e5uos33yruOe6m2ewmi4T4=;
        b=GV9i8gIcgjXrHdWjQbyuochctTsJ1TnARw5OugBPZvujVQtDQhEpzuF7RfgCZ3o+ZX
         5igG1p472bewJbyoVQKqXyCZ1Nf6j6ePDBNlzfaNbK403mIK9mWif+QiMWN7sh6Afv/U
         0Dv/mV1PDauhlN9GVkz04W+qEKpIMbq4LlvQnqEf38fMAObMWL/dOw6f9qvf0QQxaz63
         vXYZaK/0Y3XBvpwBrJ3iYj/xJcobQRYlZGVZkdrmiPG2A712l9M6X/LnPh9qaJry8TWu
         zyOfYzkNJj/Xuivw4XX8/E9V4CugfiF0zFAarbdzcq48aYkIWrTgb0EKj91I3g8erg7l
         dpww==
X-Gm-Message-State: AOJu0YwZNrOr3ZQJVAmc1rCSORgErzSTV+4WPZjh23hs34oQLnfNlBa0
	Z+NvXd+pTvrPjCsIuwMSA3IvAZGwCnI3RhuqYE0Bd2m4l51ytsySd0O65dvr/XF7Lgd0HNj8A3L
	JJeXDuh8KEUUaSBNsp7IYj5tpLDLT9M8aOqg+
X-Gm-Gg: AeBDies+rDXbpvV4ux+TIJ08S4ciE/MVAtkMByCWmQ2ZGC8NNeCNJAJojJIAOmCZrs5
	7tU5pC7+OECQ0O7pw8hAj1r/VqAyEM15lYmYcIsm6IaxfjLekzjDixkSy63xk4rLhpLfgwG3JvM
	RcAcNkGGwlngaU4C3fHvwtN9PEk+Qo9bl0nNieT+WWq21VBSDBLXJEl83qumoc8ilDFMnf7pcJV
	V+y2FSetN2fA2wezqPCVb6ovF45TlXGte9Yi51n1JBoisFXg2iDiPZbpxpvvK3GyY1HKFmGVATs
	b6U/PqCfvSaMZP2Fh4ozvwhjUQHTIvqV7CX4KfdBO2+qpBJ0f9qk
X-Received: by 2002:a05:6214:5098:b0:8ac:a976:f8d with SMTP id
 6a1803df08f44-8b3e300eb72mr110206376d6.22.1777461290704; Wed, 29 Apr 2026
 04:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260429032436.1075831-1-Qi.Chen@windriver.com>
In-Reply-To: <20260429032436.1075831-1-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 29 Apr 2026 13:14:36 +0200
X-Gm-Features: AVHnY4KCwkgsV-s7n-SSyLGnwaD_izANnpyEbihnr6r9jt141vcOdA1dncH7xNs
Message-ID: <CANNYZj-anuHaAL6bJbkpO_bUuqQd-ZLmdRAA8bLf3iSnMYRzdQ@mail.gmail.com>
Subject: Re: [bitbake-devel][RFC][PATCH 1/3] lib/bb/fetch2/git.py: add
 optional major_version parameter to latest_versionstring
To: Qi.Chen@windriver.com
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org, 
	Randy.MacLeod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 11:15:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19414

On Wed, 29 Apr 2026 at 05:24, <Qi.Chen@windriver.com> wrote:
> +    def latest_versionstring(self, ud, d, major_version=None):

...

> +            if major_version:
> +                if not pver.startswith(major_version+'.'):
> +                    continue

This handles one way of versioning bugfix releases (x.y.z -> x.y.z+1),
but upstreams might invent all kinds of different ways. E.g. systemd
is using x -> x.1 -> x.2 -> ...,
or openssh is using x.y->x.yp1.

Let's make it more general. I'd suggest passing in an optional
filter_regex argument that would be matched with a 'candidate'
version. Then the most common use case (point releases) could be
supported like this:

upstream-stable-releases-point.bbclass:
UPSTREAM_MAJMIN_VERSION_REGEX = ... (set from ${PV}, e.g. 3.4.5 becomes 3\.4)
UPSTREAM_STABLE_RELEASES_REGEX = "${MAJMIN_VERSION}\.\d+" (this in
turn becomes 3\.4\.\d+)

systemd and openssh on the other hand could set
UPSTREAM_STABLE_RELEASES_REGEX directly according to their custom
versioning schemas.

Then recipes which are known to do release maintenance (in a way
that's compatible with Yocto stable policy) via point releases could
inherit that class or set regex directly. And recipeutils in oe-core
would pick up the regex from UPSTREAM_STABLE_RELEASES_REGEX and pass
it in to the fetcher's latest version function.

Alex

