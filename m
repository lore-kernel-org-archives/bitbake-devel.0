Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FEBC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 23:35:27 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.910.1742340926030204626
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 16:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LzaS8P1n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so38974905e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742340924; x=1742945724; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RfwrfU6VsHDPDSJOcYKQPaHxHh6ArEyX7tyitv3zIE=;
        b=LzaS8P1nxlHN8RXjabC5cXBAICP4aG+RDUxM7A/lxh4SlKC1xOp4k01XuVvsk7ZU6j
         TA+QkSx7aychFjncL+UHXlHrSeDDi8y3rTlvHhO3e4agFa9Zzi8TbWU5lcwvMUo1zTaK
         nruTAgq0lDI05UsSV0I0pYSLsXO1Lfec21CuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340924; x=1742945724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9RfwrfU6VsHDPDSJOcYKQPaHxHh6ArEyX7tyitv3zIE=;
        b=t8XdBJqrXIn+82dlAUgjR9HX/b/pzKErzljgXucpPy/DFyyyiCVTE/mDiSZ291CRx/
         Eh1xbpylWi2H60RrGft+49ama2/0fE8HNXg1Pd2l7k3B09IXTqOdsK6PjvVHJeXR/LxD
         /qUsTQ1NXM9q50IBtuKE/nABh16zixw5FSvizTNW6o/AuJNUwz3rVJi5W8WLppi6C9hT
         Hdmc775Q7eJMsLwgeooA5Or8HXbuM2tJ14AL6ffzxWvdI0uSXHd20+2BzvEuqKIsywSj
         5uOluMXxoXvjDgo3zf64K2x2nUAef9mRT1yajCxe72fzP/GmP9NqZhs5qUYqZLj/8SUk
         IO9Q==
X-Gm-Message-State: AOJu0Yzx80BfLwKcPGZRG0SmwXGv1hUvBMXH7mclWaW2dBfS76e+LQk2
	bK2GawPEoMqeH2PqlC2HBP65/RITRbHCA4OOx6XDceMaXqWbMVYD1LN8qrK+yximDwhSoXtxZ6o
	s
X-Gm-Gg: ASbGncv+JfdCb8mmgFSkVaNBsTgISabHFVrCPVqpf0YWiCSEJzIupYz0mjtoEsOxcki
	FsOaxTxQ1FjQ5CEAelTzU+U71/P9j+z8MmnYBiU953ZeqOSogdclBoUkHp3bDg/Impt6er/ih2U
	2hatARghYFnZcIf1RJLSsHA4jzo/IP4S3acjWq+F/hi8xs56W5YH5NfOdegP7oFY/iYYxK1OUTs
	UTcCUNxgaImUDzpBwGNqLJDyQ+32IaOYILOcY4sLEfva4uLZkpFVwF9P9rgMsFRlfrY6d7ebusI
	x67SC3lOv/Ds85y+K2cpG77bxD0bM5FCqjCS03IJp/UQ0KG8JdcgHrdxKmXEXvUhdg0r/GJXcEn
	+Mw3kOVIKFzya8gALMXihPNrvZpiPNHyvSw==
X-Google-Smtp-Source: AGHT+IHq955zmClaJW81sLOBamBVZDydgvIbv+zJ8yYb+80DTMveYaXuEsii4h0Aoqgix2nFMPXhfQ==
X-Received: by 2002:a05:600c:5250:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-43d437820a0mr3150025e9.6.1742340923667;
        Tue, 18 Mar 2025 16:35:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:686c:8c32:99b8:c349? ([2001:8b0:aba:5f3c:686c:8c32:99b8:c349])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4453227dsm1150345e9.40.2025.03.18.16.35.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:35:22 -0700 (PDT)
Message-ID: <b784d1e68780ab96339ecd5483da8129f01b5743.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch: Drop multiple branch/revision
 support for single git urls
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Mar 2025 23:35:22 +0000
In-Reply-To: <182E09B4ED028568.23745@lists.openembedded.org>
References: <182E09B4ED028568.23745@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 23:35:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17461

On Tue, 2025-03-18 at 23:32 +0000, Richard Purdie via lists.openembedded.or=
g wrote:
> We used to use this for bare clones where a single git url could
> handle multiple
> revisions (which implied multiple branches).
>=20
> We don't use this any more and I doubt we'd want to go back to it. If
> we
> remove it, we can simplfy the looping in the code which seems
> desireable.
>=20
> This patch does change the warning for missing branch parameters to a
> error. The message has hinted about that for long enough.
>=20
> Some test cases are removed since they are no longer needed.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

This patch does break buildhistory.bbclass and some spdx code in OE-
Core. It also breaks gitpkgver in meta-openembedded.

It would be possible to put a fallback in place which would probably
work around those issues.

Whether this is the right time in the release cycle to do this and
whether we should just update the above code instead and have a flag
day, I'm not sure. I did at least want to share the patch for feedback.

Cheers,

Richard

