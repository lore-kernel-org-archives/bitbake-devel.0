Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBA0FF5131
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 18:28:17 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88322.1775586493621886145
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 11:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lmYKMzN7;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d560ede296so418599285a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 11:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775586492; cv=none;
        d=google.com; s=arc-20240605;
        b=UXs37/4ZIC4Iw8LahrPVMmSWPzkjWBXYrKgfewdqtB352DB8zGa6Mt6hlwWMP23M1e
         6Y67f6SnQmQOqz97grdMGn0xOjuEWS1Og0d6l0QXOJ7bw1+i2R6fE8E5uJIdE+TXd1S2
         l/dw/uctPkQ3KTuVgqrj7Q/qXqBGR7dHxVR9iESrycNCmbO3MXoaN17VV/SH0O6sjDsi
         AMTnSS1njzbrchoKRZn8owjl622a1Mlb7F+FDrWJZA+IAfl1BhzZ3aOZw/uu1bZO3BrV
         dNfxwql8goKC/n61N8zz1I6JKX5yAtQPAqBzgdRruzDnWd1Y0UndEZ1IjL1xS2Tv8LEn
         2yVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ten8bUjJVNiAIevKI7+LHTTN4sPqpIkjBPzw/i4uWXI=;
        fh=DOLoJrvIS0/AyYEovfRse4GhJH+DLZ6vUbc6FSdEJBI=;
        b=baL/FF5l3FEFozLYXW5F2v8IqCVtzZw0gAFRtu614uzUo/+07/jT/W95imFg0zw21K
         tmuOYiVj+M2SYKl2Vlhc6F2WyAzwMHZEHdOv8hc1XxQ2mnPDI/FR5skNEok+Y2D97uhx
         f1hRSGtPfUT2cGgd1wWKdAKuyKsD5VV0muXsJAeN/Uon54ichgSF0cZTCafcho5Al6TE
         lOAjfBwdZrcwhFQdL4vvvFjNE1sTLFHjoQix86EuDP6R/xTgiQf0g2voD00kgd6P+Y5e
         vIEQEGs1L7AQpU6P0fQIXPooOPnnwUMWmLFL73ndey3wCfXltqtR/op171X06KEmoOQR
         hLNA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775586492; x=1776191292; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ten8bUjJVNiAIevKI7+LHTTN4sPqpIkjBPzw/i4uWXI=;
        b=lmYKMzN7OEEv5QKpQU3Ok+3x+SW0wWI0oVI8ExIJdZW6BtK1mbNyPBW9rwdOV0a8uS
         vgM/tgg8CCkmhUjbkOXuGpVElj4EdnmvAl5IAAjSRwr9nJb7prOIumloJigM/xyX1FHa
         c1tfqwN2x4fV6BP2dVa97fc39n1JTIqrBBrRIKYSVql7jJH3LApUlA6/4OZ3DXEjRBVd
         3/xpx2z0/snt2FtbSyBEMe7VXt2ZHAv0qv4CsC4NtVhkfzzJ5flqaw9x12aH2hdD2rF1
         fLfD16am2AzLLrljNcwYMQD4VUgRh0UujgAOsS7+BLFvZk4kWh80ZeBuITN/jr6y46Yz
         ei1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586492; x=1776191292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ten8bUjJVNiAIevKI7+LHTTN4sPqpIkjBPzw/i4uWXI=;
        b=sJ9lBeokC0suBLlzDkM3a7kV6mafV6fUImUOI3iW4Q7vk5A1bG0n4nPrziNoAiXchJ
         +e2CtBviA7MqE/zYK0tEsLmmpv6JpKXgkOayW6iLU9pQfKxIG5mF6szGUDlUePrAiyYX
         7nOgmyXWm59nyaRRKYKVwobzubh4VJeSjMQdLpFF9HJZshslpOp2muafUv8nsVju373Q
         jNzx0LsvvGReiYB9jOAhMuPSYF40zntWYTK3NP/aB/TiPr+Ol1ycaFl1viwpcvFJbc37
         unKwwvoLw3KG26mx3Qbz3Dedlaqubrvv5pll/TlZsdYp9LhLrLt86Jvw1bC94qHbvDVE
         S0RQ==
X-Gm-Message-State: AOJu0YyZQ0ShstPV8+Z7zEcknS2h/Z+issZlZ4Ol7DQ3fe+XohazkY4h
	RRZlSPWfqQUzd1VRgFUJzzghAP60tPgiA6K0/EjVq0cR7JtkSld34F1UEKWWmscIgu+blS13vcD
	VJTa7WIOh1DiKuQt3NzpC0GPJAgRsujA=
X-Gm-Gg: AeBDievrH4boPiXdzCfV4gGaBGit++lA+zx3zHz1pnYazsfuqXC0WBZxYMu2/7rZ+gD
	L9v+kUt0ynlCj6wboqAnvOf1tjSIRjXX/GsxAwaE2fZgJlwMgS1n3TKqLaKtx9LJFYxkK3c83LS
	ZV/QjsVC6da+m1H/+CWq6wJrynZh1KqYE3KqtljOkiRTNvXsy6gm1vxam/9tZJK80dsby91AagL
	p3MOP8nuzQbySieumCgwBN0U4LGP98AsiU+H73rXvE51VAFFtir9SkhZzGtVeMaQZTnIkEoIkT0
	YRAy1wjxakIQOrdBiqZEKVu2OcwKZo6lCIkWuYKQLA==
X-Received: by 2002:a05:622a:90d:b0:50d:9ea9:7083 with SMTP id
 d75a77b69052e-50d9ea98600mr85586231cf.24.1775586492492; Tue, 07 Apr 2026
 11:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
In-Reply-To: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 7 Apr 2026 20:28:01 +0200
X-Gm-Features: AQROBzCUYRZN1sqoMvAbSz9fJlBRqxmsbdobi_6qG7wvc7X5Z2VT_qwHvMLr7QE
Message-ID: <CANNYZj_R8t-Ho6pbNqjnr_91w_x-2i1qgfRAXbsACAO07ZGG-w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/4] bitbake-setup: extra-remotes support
 for contrib push mirrors
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 18:28:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19350

On Mon, 6 Apr 2026 at 22:24, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
> This series contains one small fix and a new feature that may warrant
> discussion before merging.
>
> Fix (likely uncontroversial):
>   bitbake-setup: update vscode workspace always
>
>   The vscode workspace file is now updated unconditionally so that a
>   manually changed build directory is always reflected. Previously it
>   was skipped when the registry configuration had not changed.
>
> New feature (may need discussion / could be postponed):
>   bitbake-setup: add support for extra-remotes in layer sources
>   bitbake-setup: add contrib extra-remotes to default-registry configs
>   bitbake-selftest: setup: add test_extra_remotes

Please do not bundle fixes and RFC proposals like that. Send one as
regular patch, then the other as RFC set.

Alex

