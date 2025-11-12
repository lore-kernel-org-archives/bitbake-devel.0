Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D496CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 05:40:33 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6586.1762926028107899301
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 21:40:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HjPn6YeN;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88246401c9eso4694566d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 21:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762926027; x=1763530827; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AIb/7wqYptVr5uk/94Iuw9PNhqXsJsz9juhrlE6rPFk=;
        b=HjPn6YeN8xRxT/oScZk81CNEOzjsPUyuCXDfmaQ0G9c9TOOjlz36WASZd+I1E6DO+R
         ym2Dxhy5dXgNKDkBme1uqOu2CLeZ2bFd0DQoa/j+Qfco91PiqPyBCZVW0luz9gpYuG/X
         +5GfluChnWYu1GzRvrQGhYnlf/o+QJU7yf6qpG6ThVlShbNmrTRjVVCaPdAkE05e7L+U
         SBBxaLiR2fwraYwzmHlasQk2w9Dk08DKGhoCUKgrC5/AE6dJX8YLWY5YuYS60qy73yfN
         63K+WTb1tWGLA2bJCQqrez09YhpxOCW8+a3uMcbXajzjdsiI5O/PCA89Kz2J6EHx5oGY
         xd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762926027; x=1763530827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIb/7wqYptVr5uk/94Iuw9PNhqXsJsz9juhrlE6rPFk=;
        b=djVrz6c/OffEMn+bxVEiKV3/sDuWlA852hKdD9RnGV6CcJyqmAf1qeSBCnij/7X3kA
         kIW35oqDb+eFFueledbHoRS8h47giA6CZ9ugc9TMYfC0zIlLQKT7ptNOQBu8CnytWlzk
         3OWoADenovcKtNu8jP/jUcspc/TV809wsh6KQXUH5kixaOc+m1k4xk54UaCJNDrz3iXx
         zETMFu0UhirYR1diSK5YlME7JMkjux29Po+A6KzBrV3hqdq2iCIFNsobAOqLYnMoEePr
         IjBrLN4vwh2NysGJi7dmw40PT/ki7qNv3B1+gfzCBz/p/n5agi9kfuWgZCEfHOSrAK4r
         kDzA==
X-Gm-Message-State: AOJu0YxufTzHmutLcvCrDzt5zhBUr7EaKUpZPuZLKUir9pG/t5zApY7Q
	HcrWUeyscHt/j9OAEdF/e/TmGSe/oVR2ZlCiiB7sX5vLHsuDOUYV/hLwpIld1vUn6wcRNfLcqzd
	hutTrcpQyOxrfOFSbMdGisdR3q02JyQQ=
X-Gm-Gg: ASbGnctz4q+3FPIb+sh01ue6gucX3c6RngbhjvdDdPnk7p3NP7hw/3ZUlrs/jNSApAH
	GYgssVHPVHo0FGrqy2iGw+iBEZFOVk1ISsqPi7+rKBH4KF8NoG9078Q3o2eJN/44897Eud0nXra
	S6FU7Ah/mZc/esJHzViRjCc/rksZZEvj2itcNsq0CH+HI1EWX2DGeQwdO0++O6InjQIS8agQ4gd
	SJFcQhmXbPWqZjxFXkTH3Ob6Lojs+qIF7gLYAbXT0mLZbhb9G6kBRO51HkMkjvtE1kMFw==
X-Google-Smtp-Source: AGHT+IHRAVxg+mDwDvloCKvkMw94N1x5tboArtnjEboeU+h0yYVIeCxczPsP0evA9Y889clE5X2thsi0EjgGvy4BNkE=
X-Received: by 2002:a05:6214:252d:b0:880:580e:b3e5 with SMTP id
 6a1803df08f44-88271a22c86mr31010386d6.36.1762926027121; Tue, 11 Nov 2025
 21:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20251111223325.2034322-1-adrian.freihofer@siemens.com> <20251111223325.2034322-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251111223325.2034322-2-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Nov 2025 06:40:16 +0100
X-Gm-Features: AWmQ_blr-srEkKaqYbURpUrgPWA7ErlaO1KsZK1DagjHImb1ktRQi2hJ3QrxVUQ
Message-ID: <CANNYZj-mqAdNKsLF48xMfbopYDmTt_mp=TFdYEFOHj4Hn6TjYQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] bitbake-setup: default top-dir-prefix
 to cwd
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 05:40:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18341

On Tue, 11 Nov 2025 at 23:34, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
> +        # check that the default top-dir-prefix is cwd before any settings are configured
> +        out = self.runbbsetup("settings list")
> +        self.assertIn("default top-dir-prefix {}".format(os.getcwd()), out[0])
> +
>          # set up global location for top-dir-prefix
>          out = self.runbbsetup("settings set --global default top-dir-prefix {}".format(self.tempdir))

Rather than check that default is cwd, and then immediately change it
to something else, the test should actually work with that default,
e.g. change current directory to self.tempdir, and then proceed with
the testing.

Alex

