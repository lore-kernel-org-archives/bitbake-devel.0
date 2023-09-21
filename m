Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B502E706E3
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 08:22:18 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.11243.1695284533360381215
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Sep 2023 01:22:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g8eOTNoQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso6863475e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695284532; x=1695889332; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yj5nnGeSPQCBGg8jLtlS3NzJvcaTMH9JnF1MIl824bo=;
        b=g8eOTNoQ/3TJtA39vfpwp8+X2CG5jnBXmFVOZVhAw/DXEA6McM9bZN8MNhVx6WZq4M
         R2sH5P14a4fep91FdCdibVY5sKdk06qPdfTYSpjI8VlXw1Q4ExvE1ENwz5qNIkAoO75C
         sVtUAer/qXzUVagwVtfHQHiNCNQqY+aJn9ZgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695284532; x=1695889332;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yj5nnGeSPQCBGg8jLtlS3NzJvcaTMH9JnF1MIl824bo=;
        b=lf5JwS+1U3IT3Ws/gDcAP14mR+Ns8XfkPU4+Cmm3v7RIL/Xx/CHcVKWUtiy9XCdSfx
         xZbTUV20IR9YeEJyxqTHWnHWQd73t5UQyFrupIML0SbmXfpBLq+ApenDLqOakmcQk5qq
         MU6JLiA/yHcGK/2Vfs5cuqU6V4OOPPGMtM1qakFTQxaaU9nE4R5gBi0aOL1L3Zpe0fSR
         z3UoGn1+3rOJsuYd+3pcMVDb2+FirMf4NSf6jg0+Rysi+6MHytsWCCvtc6BzICPXkCao
         Ax9NUIFGPg9cj80HpNlcE1fdG0J/hiYAqQmx6kjCxVbSk7887YxkHvIIR/qfW+dZrpeY
         YbEQ==
X-Gm-Message-State: AOJu0YzbuCdrTkqo+MZQyCGEWdQ3+jh0UNlM/gB2k/NQQZBejmOpGgg7
	FS5Gh1SKNyT5jUgOaIB9hF4GHg==
X-Google-Smtp-Source: AGHT+IFRZIWN7upxPZPJ9/9epqwaSjwUouWNTZ5jf92qoG7AkVaIAk/UXrw22t/axslwS9sYmqJuCQ==
X-Received: by 2002:a05:600c:24e:b0:401:8225:14ee with SMTP id 14-20020a05600c024e00b00401822514eemr4416480wmj.41.1695284531627;
        Thu, 21 Sep 2023 01:22:11 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a109:22f2:cbec:fa4e? ([2001:8b0:aba:5f3c:a109:22f2:cbec:fa4e])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c21ce00b003fefcbe7fa8sm1239799wmj.28.2023.09.21.01.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:22:11 -0700 (PDT)
Message-ID: <0d94ff1c8efe8d37471f3c0bfe09403a7d8c5af8.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH] bitbake-worker: add header with length of message
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ecordonnier@snap.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Thu, 21 Sep 2023 09:22:10 +0100
In-Reply-To: <20230921075658.509846-1-ecordonnier@snap.com>
References: <20230921075658.509846-1-ecordonnier@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 08:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15099

On Thu, 2023-09-21 at 09:56 +0200, Etienne Cordonnier via
lists.yoctoproject.org wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>=20
> The IPC mechanism between runqueue.py and bitbake-worker is currently
> not scalable:
>=20
> The data is sent with the format <tag>pickled-data</tag>, and bitbake-wor=
ker
> has no information about the size of the message. Therefore, the bitbake-=
worker
> is calling select() and read() in a loop, and then calling "self.queue.fi=
nd(b"</" + item + b">")"
> for each chunk received.
>=20
> This does not scale, because queue.find has a linear complexity relative =
to the size of the queue,
> and workerdata messages get very big e.g. for builds which reference a lo=
t of files in SRC_URI.
> The number of chunks varies, but on my test system a lot of chunks of 655=
36 bytes are sent, and each
> iteration takes 0.1 seconds, making the transfer of the "workerdata" data=
 very slow (on my test setup
> 35 seconds before this fix, and 1.5 seconds after this fix).
>=20
> This commit adds a 4 bytes header after <tag>, so that bitbake-worker kno=
ws how many bytes need to be
> received, and does not need to constantly search the whole queue for </ta=
g>.
>=20
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  bin/bitbake-worker | 34 +++++++++++++++++++++++-----------
>  lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------
>  2 files changed, 45 insertions(+), 23 deletions(-)

This does look interesting. The IPC mechanism was never intended to
carry large data and it has changed over time in ways it was never
really designed for.

I'm guessing just one of the objects is particularly large? You mention
lots of files in SRC_URI causing the issue, I'd like to better
understand that.

I'm just wondering whether instead of improving the IPC, we could avoid
some of the data in the first place?

Cheers,

Richard

