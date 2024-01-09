Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7703C46CD2
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 14:13:00 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.17688.1704809575259631169
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 06:12:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Fy8TzHjX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so34131055e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704809574; x=1705414374; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wazP445OTSlGetWyotZWbeBouSxTOV7JusIATcLCd2c=;
        b=Fy8TzHjXepllaWYzNRXJpANyYOUaWl1v5Jg822wDnoyc+qEFihNbvGiAboaAp1ynQ7
         RJtPdUsu2Gv5EmNZvF3gbf/4DhiLW4Ygq9U/eH7GALDe/PmU9MFAA8rF6GL1g3S44guT
         ei9n85JUtqguv5TySAgw0fb/c/cRB5v13xryo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809574; x=1705414374;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wazP445OTSlGetWyotZWbeBouSxTOV7JusIATcLCd2c=;
        b=oWJmOJsT18S2VhCh9b6AB/JfRt92MKAezqUE/mL6RyN8ZkWZgYKBaatWIxbqtMICp7
         i4Iw1jFbOQB69cLH3EKuiv3GeJmgAQxvmGdajD9zKrQ+LegUu3HqQZlFvwA4CLEehiDY
         P99Jo/SAlDWvVL4jMDDQsvZoGJzO1Sx0lj7qvboGLUsUS16XY4DJJYa/10JWzNrgvb5z
         aVJy/vhf4eDdS9vxkV/oEJ9Dd056DPTs0+D7Zq8F+0nIbw4s3+ks1DihD1EjohMgwTZh
         uQ5hVXjohRxjlZvd6sBIZsxZ4o5BWaH5ofa2N7OXty8tBZg33OwL/qwjTdwn3XT6FWpc
         utGA==
X-Gm-Message-State: AOJu0Yxnwe3yhZxOAmgKvn6qaU1ptgbtTZD5m8zYiaCc7f/Xg+A5kgPV
	nhcbKDSlhiE7BjP5t9ckWTiX/OvvyFMVqg==
X-Google-Smtp-Source: AGHT+IHp/yDbrXJLT0ajQgUdKFlxQL2vm4AUNmXI69MiKv1f73xsI/mknobbxlm4XxcFG+1udWHyPQ==
X-Received: by 2002:a05:600c:b49:b0:40e:4686:a59f with SMTP id k9-20020a05600c0b4900b0040e4686a59fmr1861637wmr.41.1704809573755;
        Tue, 09 Jan 2024 06:12:53 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:494c:2c49:a717:e3aa? ([2001:8b0:aba:5f3c:494c:2c49:a717:e3aa])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0040d79907acasm15067342wmq.26.2024.01.09.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:12:52 -0800 (PST)
Message-ID: <15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Add pressure change logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Etienne Cordonnier <ecordonnier@snap.com>
Cc: bitbake-devel@lists.openembedded.org, Randy MacLeod
	 <Randy.MacLeod@windriver.com>
Date: Tue, 09 Jan 2024 14:12:52 +0000
In-Reply-To: <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
References: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
	 <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 14:13:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15763

On Tue, 2024-01-09 at 15:09 +0100, Etienne Cordonnier wrote:
> how much logging is this generating for your=C2=A0local builds? I'm
> using=C2=A0BB_PRESSURE_MAX_CPU=3D"500", and this patch generates hundreds=
 of
> lines of logs during a typical build (on kirkstone 4.0.15). Is that
> the expected behavior? It makes it hard to read other logs.
>=20
> E.g. this incremental build with 300 tasks printed 280 lines of
> Pressure status change:
>=20
> ...
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 49=
5.3/500.0, IO: 1723.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 985=
.3/500.0, IO: 2201.8/None, Mem: 176.8/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 42=
0.8/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 404=
9.8/500.0, IO: 14719.7/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 0.=
0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 219=
22.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake threads
> NOTE: Tasks Summary: Attempted 928 tasks of which 635 didn't need to be r=
erun and all succeeded.
> ...

It does add a lot of logging. I was torn on adding it but we have
struggled to get the log levels right and this information is useful as
you often need it to get the pressure values right. I'm torn on it.

Cheers,

Richard



