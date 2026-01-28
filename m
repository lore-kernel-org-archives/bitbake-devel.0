Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3983AD35689
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:02:43 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13569.1769608953421123856
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 06:02:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fs2uMqy1;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-894723da7dfso106699006d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 06:02:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769608952; cv=none;
        d=google.com; s=arc-20240605;
        b=IDcjUIzTpFoAX2hH2TcPv3lzu6zq+2SA4I/Ut0J9OH2k7Li8KNBnJalQcea4VfDD12
         ypn2XnJvyt9nrg+0UXynxVbkJ5OsMC1TIkZZJKqKKZ2t36L+25/pz2LlMfp1KIF+3X1n
         tr2nfHJyUwFZBafQzgopc2ekBl8UCh/QVw3HodVStnhlIsPBEAzv4TwEruHUS7Olz4z5
         VBF0KYU1jRooIUi3ZSwoAvgurzmpY9xKZlZhY6Bja+61wJ1DHapyHVzv07ZiWm+DMMck
         9GQSUQNHJsayCezzwU58wzD7JW4KX5PwKUm90ZiX7akb/ApIltrf0LqGQeRJ1uvydrUC
         M8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V27tvsmjbAwYUif+6GiauHI8IoaVKb/bKeLhakAG6Mc=;
        fh=YeVbJkliH5eDBh1Er8S35T+UocMXyM0bEWhqLK1eJ4o=;
        b=WH+9cQclgsBsQc9HNg873HHLbKXfFL9nC3ihGblNfeC0C84N2eSs1vtc7TkljhGhrh
         AqH247LxYjZ9uRTOccdWfLyMbW72s9ixZ3dOfiY3SMtS/Y9YeXA7X3ptcauJq5lgZ3Ol
         e+ppWBY12auqNtvCrolMGZVj9qPkdehCOogL3zK5HNq8Yd7s1KAJMUbGVpZYBcCKqZLL
         0YZWSCSBgMHUmHT23XIsAZKnNy4WfR+RbtblYggUAd1C6ocgraT1xGscYYai48KSE5Px
         AfskWZA/DUsK3nzEoVP63QyEG5Uv8MSUOCv0iKE/4/vcMx2SouYMhZBANeqxw3kCXOD+
         MZew==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769608952; x=1770213752; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V27tvsmjbAwYUif+6GiauHI8IoaVKb/bKeLhakAG6Mc=;
        b=fs2uMqy1xT6eUx+QNjf6mXLUfaAqaJvELPypO687uQuoegbK6mLqp+BekeF9NSaxzF
         WK3pf8bDYFEtG2X/I0nolGx7ze/5SAG0tfKql16R0tg8Hc+moFljM4WiUFJzCw2yxKCm
         wmjFIhSHOem3iRLWIh9va22B5dcty5mLoF1whGe3wceaZI80uWPCH0H8gT8uy1nMK1KN
         I0nUH17f6+1d0FAmBdHcdOjTi9uvoPRi/QpJQ/WAKkCxbmR4Ncqp6gKy+q474ry3cIMz
         8nFr7cFeMRwxUOfaCZ1a8ux6v2TFQwWvDYymbvvsLfJ1sUl8CORo0jQC4EgcBorOF5Jp
         fODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608952; x=1770213752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V27tvsmjbAwYUif+6GiauHI8IoaVKb/bKeLhakAG6Mc=;
        b=MZQnuPAA4v7TSL6By0y0SPYHUvvxVQYehCG5E+zcrp/dNKPDRqyjLIKE8HAMnOnQDD
         2KPpmr4FLb+qYdWcokG/+P5lHeg4X8hdP+7STLb6X/GJ1AloYBd8RhAqeKUMUzTsYfx5
         i5wZxqbXRXYH2CTe1ELlZxaau8qlJKBlDBLtCGTb5bJD6VYoIlCFnvh9VEUiPNejdPeV
         TqjFNTZYEen9v9k9tjVdr7L6+kw8sA6ydSee/RyPnOHBQFNNsJWWOXr/l8eoejMbAmJN
         xAZMfFUJD5tkKttw1VrUceh83M7SK80ScpusAbkUBqa0bWW1jBjEBI9Shf3xdwIZxGCd
         lrDw==
X-Gm-Message-State: AOJu0YwE1657gk2e2HQbiEkRymehx9vDgcEPjnjVInwdPq66MuMlY/85
	zA5Lee4cCl585ANyAxZpuUh6kF+DjEsKFJgdCCf6LUFs8n08cmigTX9s43ERrU2QSANxoGqqbqt
	5gkUI/Hr6ODYso71hbJwu0DhB3qWZ9lqkfgIg
X-Gm-Gg: AZuq6aI7Dp1t5td6OsuqrlPidews8QiHX9g7hmLKccLlcn7Pwvt7QnLqr4gF5GYm/6R
	VdigbWeh4AJ8842S2JFM6s3nlNknCrbqBNELniBzIBj1vYqzP/R3yehkuKE4wgK+hNQ5tIXhrk/
	eF90HoC9yoGcgFrBD8qd9lILZET4OHRESCe4LZGGQZ7gZqsJ1I0rrw01gchX46JTI/mq1TPpuKd
	E6MtBE+f5yZkDUfcd039Y3Ouc/opMITyTA9i3xGUxLYGKXuKxYFcKWnssUhCjCl59ejCwRc36TZ
	bMxzAsTH59CrmyVWGoK/DS83K2PXDg==
X-Received: by 2002:a05:6214:2a49:b0:880:471f:2ecc with SMTP id
 6a1803df08f44-894cc886ed8mr71781866d6.29.1769608952337; Wed, 28 Jan 2026
 06:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
 <20260127160508.3392732-3-rob.woolley@windriver.com> <CANNYZj9YWviJ=JDR7On+LfK2RHBs1X77J6UzxPQDzVUV2rxnag@mail.gmail.com>
 <DM8PR11MB5655BCC1A88B3774C374959AE191A@DM8PR11MB5655.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5655BCC1A88B3774C374959AE191A@DM8PR11MB5655.namprd11.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 15:02:21 +0100
X-Gm-Features: AZwV_Qj8QMDWTZboTTfRGGnGX2Dqs2f1ViTdMmM9O_h6qfYWpeBiYfF45jCrfa8
Message-ID: <CANNYZj_n+t1XbCZbUuXEucBa7jFmhKoxHa7vWs3dQBVd+gQkvw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi packaging
To: "Woolley, Rob" <Rob.Woolley@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 14:02:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18916

On Wed, 28 Jan 2026 at 14:30, Woolley, Rob <Rob.Woolley@windriver.com> wrote:
> Sure, I can look into extending the lib/bb/tests/setup.py.
>
> There are system tests using pytest and nox.  The 2 pytests confirm that all the imports succeed and that bitbake-setup --help returns 0.
>
> Nox runs the pytests as well as bitbake-setup --help and bitbake-setup list.
>
>  Should I replace the nox tests with pytest or create new tests?

This is up to you. You can experiment and try different approaches. I
think lib/bb/tests/setup.py is itself pytest based. It's a part of
bitbake-selftest that you can run like this:

bin/bitbake-selftest -v bb.tests.setup
(you can further specify what you want to run in that suite, as
existing tests for bitbake-setup itself take significant time, and you
don't need to run them).

Alex

