Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B7E810D4
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 11:41:51 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.15389.1695814903259392223
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Sep 2023 04:41:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KGh227oC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40535597f01so108781425e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695814901; x=1696419701; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPEVFvaOnyya1mLYmA3GU6fOWVFmEkHHbf7OENSmXkM=;
        b=KGh227oC8pcivupCOFqaqYasizyiAyzrxMf8DN+pse2Guu48Uq2adVoDvC3sSPJ+S7
         4iEAlYqmbZ5XS7ie19FkVtZ3mMz58BVZHiWTpRwa0siMexWsFyvX2KlnC//f1nq92CWh
         MgticdIM45bpoLwuC1SQsdZGLBb59DDVptn20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814901; x=1696419701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPEVFvaOnyya1mLYmA3GU6fOWVFmEkHHbf7OENSmXkM=;
        b=p06gxfUwhcaAt3kfoTxCHMwcTgjwH443pqnGTdSfUUr+OVC6DP+GjKHJ5kFoiyUNLS
         luuhKRZ5i4e0r293cJ+ELBgDG97AtgvMcl+c7Pd01Vuq0TWQ4yQxqB/j2djO9nGvj+MD
         AIYUkAwxu/tnnyfKMoCWUkk4KhDX2+OWXZ3UoTBP+gDFcUYWI9jPRX7L73XYoDv/EOHM
         fmLvCET2yg5r6Vn6IQwCS9lI1p4scAhR8e3hFwFl4wkFEjRVnqLzboI+dZP9HLLWAqkB
         /lWNJVso/Y2yTGIo24jyV/dlm4mWFCwSC7gThTnRFj1DSpntJa7LVgi24cpruRYaTGd/
         jqUA==
X-Gm-Message-State: AOJu0YxrhZ0VyrU0JCKJ/qI39YtoEGWS4qc4Zyc2tLj3mgX0QGhqNjXa
	65wgajgQbuC8DIozpsSimFvusQ==
X-Google-Smtp-Source: AGHT+IFsxTWJH/kehHaSQbaRvbZgpXwemvJWviaD1/v17Qdrj304gjjiaOiOxkb4VRzGyXw1m/dUVQ==
X-Received: by 2002:adf:f005:0:b0:317:5168:c21f with SMTP id j5-20020adff005000000b003175168c21fmr1670351wro.31.1695814901499;
        Wed, 27 Sep 2023 04:41:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ab67:eb18:db89:ef9a? ([2001:8b0:aba:5f3c:ab67:eb18:db89:ef9a])
        by smtp.gmail.com with ESMTPSA id p14-20020adfe60e000000b003197b85bad2sm17053942wrm.79.2023.09.27.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:41:41 -0700 (PDT)
Message-ID: <f5feb7f61e67b89f298cc0a8051d2e1547e2a45e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCHv2] bitbake-getvar: Add an option to
 specify a default value
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Sep 2023 12:41:40 +0100
In-Reply-To: <20230925203128.73512-1-pkj@axis.com>
References: <20230925203128.73512-1-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 11:41:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15135

Hi Peter,

On Mon, 2023-09-25 at 22:31 +0200, Peter Kjellerstedt wrote:
> The default value is returned in case the specified variable or variable
> flag is not defined.
>=20
> In case no default option has been specified, bitbake-getvar fails with
> an error instead.
>=20
> Suggested-by: Mario Domenech Goulart <mario@parenteses.org>
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>=20
> PATCHv2: New solution based on the discussion after the previous patch.
>=20
>  bitbake/bin/bitbake-getvar | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)

I've been thinking about this and I did poll a few others.

The logic for implementing the "default" is pretty ugly, I understand
why that was necessary but I'm not keen on what it does to the code, or
the potential confusion on the output on the normal case without --
value.

All things considered I think I'd prefer to add the --ignore-undefined
option, with None being translated to "". That is at least really clear
at the caller sites.

Cheers,

Richard

