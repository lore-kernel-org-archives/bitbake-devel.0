Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C699C79FA0
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 19:58:37 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3958.1788811109948039634
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 12:58:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YDaifLm/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso42985735e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788811108; x=1789415908; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z+TLm8tfOVHgNaSRj0ED6eM+EC/NtEA0T3+RMmFg/VU=;
        b=YDaifLm/hSl14XknihBEDMmlDwDhdCFXqaHTAY/dDSk0N/468DL3vKFzj4wPVzgDbo
         XpQrP8uvrcuwT9byxXeS5kAIJQcYWPfeqHXQQf5p0/s4JkrQ8N1bb1D5fnQ5sSJOj12K
         BMU1wKMjL5lYIhIyM5jleUFXjA5DtPWbwiaQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788811108; x=1789415908;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+TLm8tfOVHgNaSRj0ED6eM+EC/NtEA0T3+RMmFg/VU=;
        b=Vqve+BnphMtTnhQ8HubG9400ppYkWbcg+M0vq+8EVEj0n6jxIvfpzuKrl8zV1Rh31X
         aoipMTKkQbFJBn/2bFzW7OLPY/lPzq4nlBFtG1tT2nCVXM3Mz8iQErMLL7IavmcVNQMf
         Bz8WNVuCPwZLXfgiCYo2mrF/SjC0MdnLxiKZ1HGYsaH+r6ioDFR9fMNWJjoFDvRzomis
         Q6EcNTURtP/e04DcsT565swxKCRir/3GmbxnqoiNTdkFtNCrgge6qefC4AcfjsPEKLJo
         paQXmmyS3yD0KDuaD6hHvsaKKXrg55ofTlpDZ7aIZVhsL2pN8N0ti5idoJuxDLKF7HN6
         oZOw==
X-Forwarded-Encrypted: i=1; AKwUvByAThbuPUq/k9Efrh63wqEd08hkN79cmujYA1tsUL83b3+QBLNCvEtbmQby5OsOrLJSHrjPrNZaiQZi7El4@lists.openembedded.org
X-Gm-Message-State: AFuF++lKOE1dwvENe5IukA9X5acKH1DdlEHsedhDgm/ash67wW5v8lu/
	8UbnNrKhZ78aJj31BVILK4SbMP0QmNgxtQV3ne9O7hIKfw93Bl8vrUqNdzdvlrL9ZJg=
X-Gm-Gg: AYBFou2YlVAcWjvsfRyCo355b4JsSJJtxSI42+r8DBo/pVITrzGO2t2pjzJVPSLzmhV
	0bsXntTnalyx4dHiTPWG5z8+oN3gYEMzh6uG8Qh87YzB15fcOu4L1zLw0M1wofTXAioTg1tKXLr
	/2EZmLfxzJCGgapXnNuLIBkFQ0yL5WbwHyDnzaaKQc4kMuL8XhQxaNM9NfZrvaoaUFDo2f8nrx8
	t1hF57nIMZoo07ExnkhbiaEjThbF7f+17xyn0jXmBs02pUO5qHj9S9yHcFc7hBMsNjmeEGOGZhh
	sh0FkEe7vLQFxWK4eH0sgMaKSy8p3+v2+bEAz537ySj/KYxOsGhxerb9RCuCpuWej0yEjWJb4MP
	pZIucCraw5T8mrL4h0WUAAwGg2R/Ab1rhsfnn6y98ZAvBF2tCudGIPeh24pck6JkUN36+gbddrC
	UH8dF85fwW9NhzrzzrlHkSXnHzJETZgzoJzbKUC8xc8o2EHudsAtbPVRh242DSs/WSBvu5HApBt
	b/ZBHyVqcIq1HDh0hzNKgcZAif2u/nCC9ma9cpalM1ML1N6FPt/xBUsLL0cRfjC
X-Received: by 2002:a05:600c:3f0a:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49cf81e4a10mr242563565e9.3.1788811107975;
        Mon, 07 Sep 2026 12:58:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153? ([2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm289060175e9.3.2026.09.07.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:58:27 -0700 (PDT)
Message-ID: <c842e0a047d06841610d0087df00b76b94cc1114.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] prserv: add --status to list running
 servers
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bbnpreetsingh@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Date: Mon, 07 Sep 2026 20:58:26 +0100
In-Reply-To: <20260824045011.7-1-bbnpreetsingh@gmail.com>
References: <20260824045011.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 19:58:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20169

On Mon, 2026-08-24 at 04:50 +0000, Baban via lists.openembedded.org wrote:
> bitbake-prserv could start and stop a server but not say what is
> running. Add --status: it reads every /tmp/PRServer_<ip>_<port>.pid,
> reports each server as running (with its pid) or as a stale pidfile,
> and exits 0 if at least one server is alive, 1 otherwise.
>=20
> Extend the ScriptTests start/stop lifecycle with status checks in
> both states.
>=20
> [YOCTO #10865]
>=20
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
> =C2=A0bin/bitbake-prserv=C2=A0 |=C2=A0 7 +++++++
> =C2=A0lib/prserv/serv.py=C2=A0 | 23 +++++++++++++++++++++++
> =C2=A0lib/prserv/tests.py | 16 +++++++++++++++-
> =C2=A03 files changed, 45 insertions(+), 1 deletion(-)

Thanks for this, I've been meaning to do this for a long time!

Unfortunately this patch does seem to be causing failures in our
automated testing:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4607

I did wonder if the code needs to cope with the port already being in
use too?

Cheers,

Richard




