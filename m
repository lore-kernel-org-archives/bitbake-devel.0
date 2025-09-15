Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A8CAC58E
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 09:51:26 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.28851.1757929883280042659
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 02:51:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W0SEwzeM;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-812bc4ff723so370739785a.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757929882; x=1758534682; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RpgHKrBHIlQHzFueGQWK+eyGUG6RCtCRBxUZk8Atxy4=;
        b=W0SEwzeM6gVhsaV6L4HBeMga+p5aBgm+kx9X1c/M0Dmc1SIG+L3k1jZ5n1zR7UC8/C
         9jkg0H5Jt2Kv77rz0+IcZiiKiT+QucAbHr+2DHGLBMrp5BrFSumcF4YVXafZFGY3f0t3
         6A2wp7OHHgXli3TPb8VfQJ57HRviKDa6dUy5aNG1vA1pHm8OqwqmxDF+9Ev+8ZKyjUT1
         Aj/J8ULrdBwBfpiDNAhoNhRFsqfnZM0CZqnNIYVLUtjmvEsNOObInRDUZAo37AnzTc4F
         897iR2QOZXnTXKxlCwth7fhD+WUXwwfIkVaenZsPgiEiViZbRJ904f3DyyyHvgLvQtAt
         xQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929882; x=1758534682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpgHKrBHIlQHzFueGQWK+eyGUG6RCtCRBxUZk8Atxy4=;
        b=sIaTFvrwvoioFxqZ1e+c6oqInLmB3A1J5gXOX1xK4+ZgisqY/VjQHcMFdug9ER91ny
         BpEhFqYveSXC9mPP0CE4JGZ2nwTI184gKGV/xWi8PC/PI4AWI/uphbxDrQxn1BTdRyq4
         q/UHFu5QSrQwG+3agmj/IcFXibWoLxttaK9umYEi3pvJM90GPIbkibhw9jRXjVZFkUf6
         A3UERv1XFvr5bea+lzNPNbRO/55akkxheT7xV/6oLFCm6d+9RNTUuoeJMzVFXOhAV0xW
         Qq5w0swI+KJHIsqtSKLYFeST/hotb76MpyJ02pXrnh+Z3xV1CM44enRBNF1Q7LytadtE
         DZgw==
X-Gm-Message-State: AOJu0YwZxzdmYvKO2kt9jzZa/Y23DRjACwkjswIb9zkYsJUVJwChfjEJ
	rdxaIAL12xYQYFTa1Heu2aAymfnMXgMbxsBSATrFBmhwU81oSJkRSy1UJKHX1+G/rvTVo+ricom
	k0Uiqd8FRt/ckfen1cSwxtYTiZd+YrEuOfg==
X-Gm-Gg: ASbGncvOvUVUASrWV06tQEloP3RLpJgUXMDPeMVMWuTXA+KkCZ6iLVhiUXHNPWBdwfQ
	+PeGIc+jWfTTbJ3eZQq7QXdzcHHMypb48ynIupic9LYYiWR9HfavmTp4KIA1jxNPKu1anPloR01
	yPR82cwPZhBgfJzTax8Yf2z+0UvjLkClMa/pxOlF1/G/LNCVjMbCKTUDcsA+N9WM999G1sxM+mn
	vscD7TwM9fDkc7UkQ5fg0xyxCFJlw0WwsTDMtthDx2d04RDMphO3S7N9OmBoH0DGS9Rs2lUc0r8
	fa8g
X-Google-Smtp-Source: AGHT+IF/fphqKoge+WnGSDoNH+4l/hneT5kEa04WU7HU2q+YYVu9GaKduc91Rz//75ZQ0W7Lo1cOIiSjDsGN/3sNMuQ=
X-Received: by 2002:a05:6214:5298:b0:72e:d34:573f with SMTP id
 6a1803df08f44-767c215fe50mr184136036d6.39.1757929882266; Mon, 15 Sep 2025
 02:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250912204559.10360-1-reatmon@ti.com> <20250912204559.10360-2-reatmon@ti.com>
In-Reply-To: <20250912204559.10360-2-reatmon@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Sep 2025 11:51:11 +0200
X-Gm-Features: AS18NWAQrgxhk74F7lls_7PPBDEalbScq0rKMJPkaNmznivPQnP88W6KAZTAZw4
Message-ID: <CANNYZj-f5oM19NRJebFgkZvFR1_EdUa1jyB915o_Ux3TqHM7XQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH 2/3] bitbake-setup: Fix
 extracting config name
To: reatmon@ti.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 09:51:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18020

On Fri, 12 Sept 2025 at 22:46, Ryan Eatmon via lists.openembedded.org
<reatmon=ti.com@lists.openembedded.org> wrote:
>
> When extracting the config name from from the filename, just splitting
> on . does not allow for . in the config name.  For example:
>
> coresdk-11.01.08-config.json -> coresdk-11
>
> when it should be:
>
> coresdk-11.01.08-config.json -> coresdk-11.01.08-config
>
> os.path.splitext() already does this logic correctly, so use that
> instead.

The files are explicitly expected to end with .conf.json. Otherwise
the tool could potentially pick up unrelated json files in registries.
There's probably a missing check for that condition somewhere?

Alex

