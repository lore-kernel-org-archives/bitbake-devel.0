Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A800DC0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 13:20:26 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.12144.1738156818814265033
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 05:20:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AcR2xNQ+;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8e773ad77so56237756d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738156818; x=1738761618; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=loVC5DLMik8XU48lIjH4pf5L/ML+cYGYIALehs1ditQ=;
        b=AcR2xNQ+BfPDFrLDv3v9ZXUJYMK0biyWYeJff8aTqfhxjd8tJuemTGC8awKAsuRdVZ
         5IuaW5k/jPAIzDsXmIiO2s8ZXAJtSxPe6/sVJ+ZPPeN5pEmeI/07e2PB/i7njv7pyg0j
         NPb5acUs6Z2F19IKXnbKFEjPnblhqISqyFKp4PfHZU/jDeLHPY9AVHR+xk/oiKsNWh6O
         +uoxbFtKHq5yNJjMRx5Pc2rWEiBaTjYSlsGlCZdQOMRXyrBv44NxGfGAE6HDX3kbM/Os
         wxjqZyxBGMJHiW5YN6QzDUxVRz6wHmjHGsKtuoQdjLipsap6FHKjQMbiGO9TfXqymRbb
         NqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738156818; x=1738761618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loVC5DLMik8XU48lIjH4pf5L/ML+cYGYIALehs1ditQ=;
        b=UPMO5RpAJ1Py4a94lsGFbu7In4Jc35kQVkXnYAigRLFClW5A4lhtlKU7heQ06A9wQ4
         Iwc9GAjEVvuz/M7I5h51hm9XdE9k6/y9ydlAtVm4SvRQCPjnbNXu86T7SoM5Vr+D2h8N
         eXBSS9WbgStTqYTS+oA2+wEkrDJruT2dAmNU+6Mj7JXgvgEMnXYTj4gXYkl3anG3Cmvo
         b+dJg2I5zRHVOB31VwnFg8Z+8i5jVkNWWyOKdu49keMkPLvLd2O626xZmhmbgmquzpCt
         aOWC/qcerl4bTj15Vl++tjX+2S0Nmn3yCEWQWBpJPf616mmGBvTLE99c0iJNl9TT//9k
         PvRQ==
X-Gm-Message-State: AOJu0YxXHX0DlAmR8Z6aOzr0LoOzdept6ZEypdUByBVHfLdIoJDFlbsv
	PFEf8BUurz2mHMxIKQYn6urSjhETNw3MhU/oEqTrkBlm46lZxmPE3pVUMg/xi+S2Q5qj6FGSZwq
	kFVUXF0X0NjH/WCkD8xiXcRLLCgw=
X-Gm-Gg: ASbGncsd6jvD8uZiFu1Z6+qP5xrRWJFDFKd7fms3IrKhdlRdNkqj4DM2+PSV8pu9h9l
	LJZKzMho3W0us0PvGzG8C52J1y/Azso+UoXoYbGmmAkchdilDYNV9mr+O8qV5OOLJBL0Z3hg7B9
	tjBqKS8QIQTg9QwTFD0nFTW4dMkBwtHTQ=
X-Google-Smtp-Source: AGHT+IHtP5EmrR6fl/Sm4TXRAlvT8SwPcbdsbL73G/6o2X/dca9UDXsrVImA2AYtfcSgMSISsdmTIogkqJDwgidCt3Q=
X-Received: by 2002:a05:6214:3291:b0:6e1:a4d6:185f with SMTP id
 6a1803df08f44-6e243c9b8c2mr51343696d6.34.1738156817662; Wed, 29 Jan 2025
 05:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com> <20250129112406.1660522-3-stefan-koch@siemens.com>
In-Reply-To: <20250129112406.1660522-3-stefan-koch@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 29 Jan 2025 14:20:06 +0100
X-Gm-Features: AWEUYZk237ZYG6nCFEzLO74wBR-zfgr7ih5e0lhJY1uGZlG_GM0vNiP-FlmSWbU
Message-ID: <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
To: stefan-koch@siemens.com
Cc: bitbake-devel@lists.openembedded.org, simon.sudler@siemens.com, 
	jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 13:20:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17116

On Wed, 29 Jan 2025 at 12:24, Koch, Stefan via lists.openembedded.org
<stefan-koch=siemens.com@lists.openembedded.org> wrote:
>
> This adds support for offline builds when tags are used within `SRCREV`.
> Offline building is enabled when `BB_NO_NETWORK = "1"` is set.

I also forgot to mention there is this variable for the offline builds
situation:

   :term:`BB_SRCREV_POLICY`
      Defines the behavior of the fetcher when it interacts with source
      control systems and dynamic source revisions. The
      :term:`BB_SRCREV_POLICY` variable is useful when working without a
      network.

      The variable can be set using one of two policies:

      -  *cache* --- retains the value the system obtained previously rather
         than querying the source control system each time.

      -  *clear* --- queries the source controls system every time. With this
         policy, there is no cache. The "clear" policy is the default.

Does it not work for you? How?

Alex

