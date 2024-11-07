Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F1AD35E5D
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:07:33 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.68499.1730974052012176597
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Nov 2024 02:07:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fK7MOuc3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so6351065e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 07 Nov 2024 02:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730974050; x=1731578850; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIu5Tth+0dpk02CNXeQr56xEJJ55QvV03uyFQ7naGkM=;
        b=fK7MOuc3QhanqByI+awqRGaGEImK+eArlviEKU2CRZJFPbjAV6NFSEQOufefkUS4d/
         TaLU5M+ODTKkrWQ1N5+EhLTjhX+HThXqrv9dQ21d9R685GxOqyxUHA6UBPSqKI+xqB3A
         X7ij1E4EGoj9VgBjIoIcj0s1TXdD+IOCGlIs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974050; x=1731578850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIu5Tth+0dpk02CNXeQr56xEJJ55QvV03uyFQ7naGkM=;
        b=AGknkqEomBH90qUtZNxmDp7AlCCP8/klez3zbngU0e4/IhpyGR1koOYhr9FQ/bRh0g
         oTaZs0mac8YakrW96IRjPCw46VbDT+xrb/BMrLw8/iNXHIC5EXodsmL/bEcRuOG1l/Eh
         Y/yM9aetfnk7yriS1rn+J5T7l61lsXwZhuRxGTexVc5qwwNz9JFkk3Pl85F8pBm9/VjG
         PGZ6M2bh+aq1/Jap+Vi4XggtZT7D5boxG8s+Un4sE55HfBU23gCVJTloUmsJsH/Od5ge
         qiory4/27dXV+hiJuuefiqImWjHJKnq+fcR24KDJ6BgjHsH0OX8laPVYV45AMsN8kli9
         h95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJjAxk4L92T9aInX7/BHoZMjKofLonCPbI0rVwaA7hVYIoCe1gffOBH+adHxTTw0G7KL7k20yyF2/7YWPf@lists.openembedded.org
X-Gm-Message-State: AOJu0YwuSpCRYN1BWkphAzsrvrhL5q+zmeIUp/uCkyrs3HKSrA2SfAFc
	mV2mgBz+lV/+2GYTG6SactTaQ4Sy2mPKnmiAw4WzobdJTbP/I8MCBqPo5kSzOxg=
X-Google-Smtp-Source: AGHT+IGccrnrN0QRNpZZetDaEgzmzaplQ78eNSBe+pXjvCAFV1ZuU0OK61ZRZDa9ylHAUe9Sqf7kcA==
X-Received: by 2002:a05:600c:1d16:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-431ae9c440cmr374985685e9.17.1730974050336;
        Thu, 07 Nov 2024 02:07:30 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c2a0:1728:e87f:b86b? ([2001:8b0:aba:5f3c:c2a0:1728:e87f:b86b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5b2dsm53443805e9.1.2024.11.07.02.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:07:29 -0800 (PST)
Message-ID: <9e39870f4f805b52f3d1b5009249e9eabdb1bead.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH v2] bitbake-getvar: Expand keys and
 run anonymous functions to mirror "bitbake -e"
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yoann.congal@smile.fr, bitbake-devel@lists.openembedded.org
Date: Thu, 07 Nov 2024 10:07:29 +0000
In-Reply-To: <20241106202531.1701148-1-yoann.congal@smile.fr>
References: <20241106202531.1701148-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Nov 2024 10:07:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16790

On Wed, 2024-11-06 at 21:25 +0100, Yoann Congal via lists.openembedded.org =
wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>=20
> Create a new tinfoil API "finalizeData" which does key expantion and
> runs the anonymous function to allow bitbake-getvar to have the same
> output as "bitbake -e"
>=20
> Fixes [YOCTO #15638]
>=20
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> RFC:
> * Return type of the API is currently a bb.data_smart.DataSmart instead
> =C2=A0 of the expected bb.tinfoil.TinfoilDataStoreConnector because it is
> =C2=A0 faster in my tests.
> * Tinfoil API adding and bb-getvar usage should be split in separate
> =C2=A0 commits.
> * That bug most likely need a non-regression test.

I was a little surprised this worked. At some point we clearly fixed
the datastore to be serialisable and it can be sent over IPC.

I did some tests as I was curious how much data this involved and for a
single base configuration environment it is around single 1MB lump of
data.

I'm a bit torn but I think the correct way to do this is to keep the
data store on the server side and use the connector to access it as in
the v3 patch. This isn't a huge deal in this case and I'd prefer to
have an example of that in the codebase. I'm guessing that whilst it is
slower, it won't make much difference in the context of getVar.

I did check and the data transferred is a couple of thousand bytes for
the connector approach. The "slowness" is that there ends up being
multiple trips over the IPC to get the expanded/unexpanded forms,
varflags etc. but that is the code functioning as it should.

I did also notice one more thing which doesn't block this patch but it
is something someone will notice and complain about at some point so
maybe a secondary bug we need to file/track.

If you read bitbake-cookerdaemon.log for "bitbake-getvar -r bash" you
will see disableDataTracking() call before finalizeData(). This means
the variable history for anything run at finalize time will be missing.
That may mean the history output for something like DISTRO_FEATURES
will differ between bitbake -e and bitbake-getvar when a recipe is
specified.

The reason for the difference is that the parse_recipe_file turns
history on and off which ends up disabling it. That would be a bug as
the tinfoil session already has tracking. This is a separate bug
though.

Thanks for working on this, I think the v3 looks like the right code.

Cheers,

Richard






