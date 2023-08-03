Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA97C001DF
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 06:19:36 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.8256.1691043569882175967
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Aug 2023 23:19:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FH7xEQmW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-317c1845a07so372901f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Aug 2023 23:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691043568; x=1691648368;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+qndaQD4tiEO+Tc8pdINf5NHW7ozQ0S7vxFJ7YQLdwk=;
        b=FH7xEQmWt++BQ8cWqc3VTRULeowszDOp2+3Q07swLC+PR32ffQuPQz8CBn1XKIIp00
         LkwdcXDQ0P2qG1lMJQ9p7tFhTEclxQMk8QztQNc7uN49Tz5+jQinPZdFGFphMJvoMHk0
         Rd7WUBxLvdPU1Uue5qU3/Dq2GnFUwhom1P/zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691043568; x=1691648368;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qndaQD4tiEO+Tc8pdINf5NHW7ozQ0S7vxFJ7YQLdwk=;
        b=AP8nW5t/VBepkkOeFYcvtHfw6S5L5X2IXryshEPZ7E0oc96pdWWpLdhXvtXFVQjLly
         heTs6WB8DYViYCkNVRA8NgZTXMCNrxM/rcx2cJ6FKTEVZ1Odn9uWx/rIu6Q9d052EMRY
         MUNyZuaOdV58msRfFeVQQKAv1Zjbx8tYWFE5SRRTfrywfG5l8gwy0VyKN5tPltZyngTd
         zCd70oGvm0C6jyd9AMHzs1oM992RIgqJeHFu6Uh7DzpbKtG7/9wIwwb1reKqNKE8RCwE
         Af4xNAdUx1MxwPxyh6wTnbJZnSohz1zEbfs7ZuPxnqBnSGbvPPNQM+c7bkwO5KHbyhGT
         kA/w==
X-Gm-Message-State: ABy/qLYWy7qKh1/cpQKxhrRI1joXkTv6ly+slwtFrIiaOf1X8w9dHHuc
	H8rK/GTanc0E5/b4PqKvFQbkAA==
X-Google-Smtp-Source: APBJJlEWQmaAunAciKeHnpntgdtJ+y4gB9yzlM7rTLY2RqKf8KPkd1j9S2OXUTY1dKSM9xEMbnDEgA==
X-Received: by 2002:a5d:51cc:0:b0:317:6846:2341 with SMTP id n12-20020a5d51cc000000b0031768462341mr5971281wrv.21.1691043568041;
        Wed, 02 Aug 2023 23:19:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:77a:9511:9fbe:72b? ([2001:8b0:aba:5f3c:77a:9511:9fbe:72b])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000050100b003141f96ed36sm21053692wrf.0.2023.08.02.23.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 23:19:27 -0700 (PDT)
Message-ID: <24aea6c874b03d9993b0d84dddc207afcdbccb4e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V3] runqueue.py: fix PSI check logic
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com
Date: Thu, 03 Aug 2023 07:19:26 +0100
In-Reply-To: <20230803051916.1640841-1-Qi.Chen@windriver.com>
References: <20230803051916.1640841-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 06:19:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14910

On Thu, 2023-08-03 at 13:19 +0800, Chen Qi via lists.openembedded.org
wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> The current logic is not correct because if the time interval
> between the current check and the last check is very small, the PSI
> checker is not likely to block things even if the system is heavy
> loaded.
>=20
> It's not good to calculate the value too often. So we change to a 1s
> check. As a build will usually take at least minutes, using the 1s value
> seems reasonable.
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

I think the challenge with the 1s difference is that it will cause two
different behaviours.

The first is that when it limits pressure, it will keep limiting for at
least one second afterwards. That might not be too bad, it would
potentially just delay a build slightly.

The second issue is that when bitbake starts executing tasks, even if
the pressure of the system spikes, it won't be seen for one second and
bitbake will likely have executed BB_NUMBER_THREAD processes in that
time, likely pushing the pressure on the system well above threshold.

I suspect we're going to have to come up with something different to
handle these issues...

Cheers,

Richard

