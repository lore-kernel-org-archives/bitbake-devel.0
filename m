Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA9CE79A9
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 15:37:48 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.12930.1695137862969624437
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Sep 2023 08:37:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ig4SSxTe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40476ce8b2fso53259385e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Sep 2023 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695137861; x=1695742661; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o7wRx0SZNyUgiKvzxDzHeAXhNJn42ZPedhnYddXVxvY=;
        b=ig4SSxTeJC3HbVSIxCI7RU5i4sQc1FfXe4pMmi1Cxzug4tzflnFy8pn+ueulwNSnmD
         Yu67Pfl1vdKxzzrt8TF9SzL+A5mn/cwZrKP/58F0qfNG/fc+E09RJmtDhnapwTs+vdtZ
         LocKU0eEM1S6JPzedHAu4vjwuHeOrH4wxSTTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695137861; x=1695742661;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7wRx0SZNyUgiKvzxDzHeAXhNJn42ZPedhnYddXVxvY=;
        b=AHfa6fkqGyoQbsx/eY63mLzuPdhY+NNJhNHLQoWYU6q8UEuJjziRtHA4In/LWV2DbG
         8LRSWOs297HYzBOk0/C2RL63KCWtr8p8adtTQU88kaA0+IfGnfBGw75rtf7SLV81Qi1K
         d9dskRTGgy+dNPyBfbTNd/pEi2RugeskwL5iqOecUl8NfOxWKwKQHwldbRrYmhzPmwqM
         tODUeLvsQV7/LxK9KwYS9cKmXqbySRmQoxWjiA3vZAy6N9SE+ZUgvVF0Kyk+7BSCskyA
         AwmjFxgNaWFmMvMtxlUXkugNR6Eox1equo/f9lCho+avMobU+/Dh2vnbWW/yMIcN2GAv
         BNMQ==
X-Gm-Message-State: AOJu0YzlAJvEgAdSAf+p8+3GjkYdEznGjpnw25dz74Ar0eWIBz2zazkb
	5AWTTjAm/Cjzb/xHv5NL4v2zRQ==
X-Google-Smtp-Source: AGHT+IGK+UOmay1cvltWgpZHAELfspaFoNI+SvKKSJmGudKaOeK2Xn8zs8MLa7YU+XJuN9jehXceXw==
X-Received: by 2002:a1c:4b19:0:b0:3fb:b5c0:a079 with SMTP id y25-20020a1c4b19000000b003fbb5c0a079mr114785wma.21.1695137861407;
        Tue, 19 Sep 2023 08:37:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f50:2b60:4068:dda8? ([2001:8b0:aba:5f3c:f50:2b60:4068:dda8])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b00402f745c5ffsm15522728wme.8.2023.09.19.08.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:37:40 -0700 (PDT)
Message-ID: <69f16f4b0e73e26167228c258f5517c1a8f61698.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake overrides optimisation in the datastore
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"JPEWhacker@gmail.com"
	 <JPEWhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Sep 2023 16:37:40 +0100
In-Reply-To: <DM8PR12MB543076EDCFDB6931B7B2BBD58BFAA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<8f03e675ecb19ea938428c52431cd1fc384b5cb3.camel@linuxfoundation.org>
	 <CAJdd5GZKqXyETj4trusWAz2YyXheWeUj3p8ZLCwMz0NhJrnqZA@mail.gmail.com>
	 <DM8PR12MB543065CF83FA3B4D5453D11B8BE5A@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <DM8PR12MB543076EDCFDB6931B7B2BBD58BFAA@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Sep 2023 15:37:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15085

On Tue, 2023-09-19 at 15:04 +0000, chris.laplante@agilent.com wrote:
> > I find this idea very compelling.
> >=20
> > Has anyone put any work into implementing the datastore itself as
> > some kind of
> > graph/tree? It "feels" like it should be possible.
> >=20
> > I think it would be most similar to the task of implementing a
> > spreadsheet
> > formula evaluation engine. Spreadsheets deal with expanding
> > arbitrarily
> > complex formulas. The expansions can involve non-deterministic
> > procedures
> > (such as getting the current date/time). Seems highly applicable to
> > DataSmart.
> >=20
> > My testbed would probably be bytebraise
> > (https://github.com/agilent/bytebraise). But as it says on the tin,
> > the goal of
> > that project is just so that I can better understand bitbake
> > internals by
> > reimplementing them, then ultimately feeding any improvements to
> > upstream
> > bitbake.
>=20
> For posterity: I discussed this with a colleague yesterday and our
> conclusion was, 'no', it is not feasible.=20
>=20
> In ByteBraise itself I am planning on removing my own implementation
> of DataSmart and just using the Python implementation in BitBake via
> RustPython.

Thanks for the report back! Given my experiences with that code I
suspected this might have some challenges but it could have been
interesting :)

I would love to get back to the optimisation work but sadly other
issues have been more pressing.

Cheers,

Richard

