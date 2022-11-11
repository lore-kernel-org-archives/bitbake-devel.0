Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05210C4332F
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 23:01:37 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.3173.1668207689228727008
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Nov 2022 15:01:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Lm7E7R4/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id w14so8151668wru.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Py/a3IWmfUgK+FX85cOGWkCD3VMj7Md8i52nD4vKxNw=;
        b=Lm7E7R4/LFz1Hls4L4m+0DpSWMP5ttiJVYL33xhkZdyhM/OnX72cdC1NFY43oxSNYX
         /sNPx6XeRrdRaReuCjkOoizabwRE8pyDg+hc23kdboMNBtcle+Pv+qn+LjNxgm/DAGT3
         9FFOO/Zf4tSYpJXqG6hON2KpeP/gxIpeBGa+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Py/a3IWmfUgK+FX85cOGWkCD3VMj7Md8i52nD4vKxNw=;
        b=FOzE1a3q0Qi1/5lXrK9VqXMw8JyOLqffrm1SfEJeFVm5Rdp8CTxndGMB4bp/HKfG3h
         GzEtBSNsvr/FWPqYzziZNCBZuxj3EFr2FQt/PjeXkr9cdSpT9ccPVp5vH9zS/isv1zT1
         o+TBrYC9/QOhG8akvZeHrf3MmRRuTVWjESKgDg2JeA5mYLOGbKhtJW6Tl+14pqUas3GN
         a16nCvjpKsQXAdtcgD3/hh7jx1DQTnm4Tuj2NK6L9SL5upJL6+sbSEmQqLq5xIpRuMEv
         4qO3ptjPaO2YnTYsM8WEaOVGWSl2wM86QB1CL3hGwkYTPmNQPFtuxfmIHLfCigyMQ8hS
         zXaw==
X-Gm-Message-State: ANoB5pldMjXOy7PjaGGcley1MdQ1t9EK00DEG5fnlBnBSiRWX57HYJf+
	bdiVQ3h2sI6p33ibuw8cnpQPqg==
X-Google-Smtp-Source: AA0mqf7Vu2HRKiNN8EUcJ58+pU8qAgJ3yk7o41nkonWO/uIin9KPL6zAgMZ/X+d3HKDW0wvSAWnWyA==
X-Received: by 2002:adf:f38d:0:b0:236:61bb:c789 with SMTP id m13-20020adff38d000000b0023661bbc789mr2318162wro.594.1668207687660;
        Fri, 11 Nov 2022 15:01:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ab23:323b:7deb:e214? ([2001:8b0:aba:5f3c:ab23:323b:7deb:e214])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b003a2f2bb72d5sm12840499wmo.45.2022.11.11.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:01:27 -0800 (PST)
Message-ID: <2fff136f04c1c9976dc83c3644227d123e3f3068.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH 2/2] build: log when the task is locked
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jose Quaresma <quaresma.jose@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: ricardo@foundries.io, daiane.angolini@foundries.io, Jose Quaresma
	 <jose.quaresma@foundries.io>
Date: Fri, 11 Nov 2022 23:01:26 +0000
In-Reply-To: <20221111185849.2458457-2-jose.quaresma@foundries.io>
References: <20221111185849.2458457-1-jose.quaresma@foundries.io>
	 <20221111185849.2458457-2-jose.quaresma@foundries.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 23:01:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14074

On Fri, 2022-11-11 at 18:58 +0000, Jose Quaresma wrote:
> This improve the bitbake UI when there are tasks with
> lockfiles waiting to run.
>=20
> In such cases one or more tasks are waiting because
> there is another one with the lock acquired.
> The bitbake UI shows that all the tasks is running
> which is not true and can confuse the user.
>=20
> This patch will shows what are the task that have the lock
> acquired.
>=20
> Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
> ---
>  lib/bb/build.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index ae781c8c..6c0b07a1 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -253,6 +253,9 @@ def exec_func(func, d, dirs =3D None):
>                  pass
> =20
>      with bb.utils.fileslocked(lockfiles):
> +        if lockfiles:
> +            bb.verbnote("Task locked with lockfiles")
> +
>          if ispython:
>              exec_func_python(func, d, runfile, cwd=3Dadir)
>          else:

Can you show what the console looks like with this active? Whilst I
understand there is a usability issue here, I'm not sure printing this
in the task which has the locks is going to be particularly helpful in
this way. Instead the user really wants to know the other tasks are
waiting on a lockfile?

Cheers,

Richard


