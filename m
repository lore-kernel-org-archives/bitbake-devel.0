Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936B2CDDE63
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:46:30 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.5940.1729680387322980667
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TwLDdoUf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so73069685e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729680385; x=1730285185; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnAe2AH/EgLzlk0D4eeHQ2Rydzp5OEhNcDn/FQOZO88=;
        b=TwLDdoUfn/BXq0WEBq3gnWpLClSI0cB+8x8/DmSzuT/tUdsu0psm/3t7WBSgfJsdi2
         yykr/IGTJSLBfRQJS76Ab156HNm1a6LE8+SwPg7UGvk47Gjrzc2PSlVwpWmNuj+0PQWg
         blpOP84FtH4BhkCUo3v5Jle4fJEYsoS5b9ly8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729680385; x=1730285185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnAe2AH/EgLzlk0D4eeHQ2Rydzp5OEhNcDn/FQOZO88=;
        b=EkgF6afyJz1OTX+yEzs9cvxA2d/uau1t/gnG51ptJgQEYLnc1/vAG+5NYJsVWk34RK
         21umvD7gOzs/w0lMseGoC/vG5XuYixNYikUTK0dzVuAot/v7YHEJ2jbbSvWaGULBwk6A
         pw56G1CAh96F1/7IUfCri4qD89p6iiFFLHI1BsG17TFwAgppAnWTSU1K+lYJWB0nXK4b
         KX1Bmc+xkkM7KD8cfso/U349ozFc+JD2NLovlxRpy5L28OOrNPH4bHHuR3giuy2vbPzm
         XoKZt4HvrNOpKQQK3NSg8bMAAFleulbfl2XW8/pT8MLHSnohOxNkqYYuIp4IeGoViwsJ
         migA==
X-Gm-Message-State: AOJu0YzXoeWLs2iGT5qtoWHMeK8Iv832AS/J5nzC9NaUukdAkseuV7bM
	UavhRNBD8PQJPOmzx6NyoKrdDIPHX3dD2M1FzIKza5uMY5Gaiq2VoREoslzDPDsM6dtdplPsIbd
	3
X-Google-Smtp-Source: AGHT+IHktYP8EGwzQAnwO6Looq4FoZuT5mhbnj0jVhuIoCBPGRF6mkjCNCJOs8GpwhE3d+/pPXU80A==
X-Received: by 2002:a05:600c:1907:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4318413e287mr19771995e9.10.1729680385417;
        Wed, 23 Oct 2024 03:46:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f? ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186beff77sm12689425e9.23.2024.10.23.03.46.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:46:25 -0700 (PDT)
Message-ID: <095e6a1845c0946773aa78ee5aa541c31633becb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster/tests/functional: Improve
 project creation tests
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Oct 2024 11:46:24 +0100
In-Reply-To: <18010F0CB9861BA6.17315@lists.openembedded.org>
References: <18010F0CB9861BA6.17315@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:46:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16721

On Wed, 2024-10-23 at 11:44 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> Mixing database access and access via a running server is fraught with
> danger and problems. The "django_db" marker means the transactions are
> dropped at the end of the test but the transactions made via the webapi
> remain so the database ends up confused at best.
>=20
> Drop the database accesses and use the server API. This means slightly
> abusing the typeahead to get lists of projects in the database.
>=20
> Add code to delete a project if it already exists. This allows tests
> to re-run against an existing database. Deletion is done using the
> server API but this means handling CSRF tokens.
>=20
> Add requests module requirement to requirements file since the project
> creation code now uses requests.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0.../functional/test_create_new_project.py=C2=A0=C2=A0=C2=A0=C2=A0 |=
 28 +++++++++++++------
> =C2=A0.../tests/toaster-tests-requirements.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 22 insertions(+), 8 deletions(-)

This was meant to be at the start of that 28 patch series, sorry. I had
an off by 1 error when sending. I decided not to spam the list with the
whole thing again...

Cheers,

Richard

