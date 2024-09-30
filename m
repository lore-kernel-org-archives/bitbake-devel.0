Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3DACF64B3
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:57:11 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.53612.1727701027736986063
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Sep 2024 05:57:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ow/rDOwd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so38303455e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727701026; x=1728305826; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0BaLWRcevc/+mJje1g9aXqqsfpP42pwxHxgaZg+O+A=;
        b=Ow/rDOwd8aSNF/21BjwOGk05m5ov7MUI3/qC6Ac3l0UBdmr748SWS5uiIzxnD4a34P
         zwaXvn/E6AN6q8xESsiDRsgBQtdye+fgyCku3tm61R6TtkfJo9xr36CHLtauEN/CrQ6S
         HmmdAl7iQtsV2b1KbXL+g1NTt1QJQB2m6bdbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701026; x=1728305826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0BaLWRcevc/+mJje1g9aXqqsfpP42pwxHxgaZg+O+A=;
        b=J/0g7zxJbZ6cmC6+zT99EED+g9FGy4PkO89EkybpU9Lko4SVmFPKKRI1QvjJQPlS/G
         ZuP2fiaLuU2/4Hd6frKOSz/amiNZCuioXZoaZPVptyOFcLQ6+O23QLPJqOckBlv4SDuI
         k6a2w3m1zMVsshub01CpWoQDIMKl2mzhimHJPXeAXZO2NEtQ7XCfU8Bm4K5MUNmbBDjL
         orOnzYqvT/r2692NrOVm/nc+TwOgO4G+sZMHsBfu+y3QKUlflpR4hkvYLDxJQjs1QoRs
         rni2ids4QPoxyWu4DZ2lH3RcEpFqZAsSdaiicutR7K1Rp6WWJbnmi0DkveVNHtFTJn9C
         q8fg==
X-Forwarded-Encrypted: i=1; AJvYcCWns8JfuXsQL8LfXsJ+TPdxqCb5O2VrrOR/uaz+MNVUIy67UImrrof0/5p7Uyb3857AYV6V2fRumG8fs1Ko@lists.openembedded.org
X-Gm-Message-State: AOJu0YwiYKrDGczfL4O6tQMRjty9vKlFoZkBt+6AFc3Q23+NS8pr8iU3
	GUiDQgBWvWexZcPhd4vMKv6VJiHDRBnx/XEOtMF6kFF0+NK3ynU3Pa63EdW4Ivs=
X-Google-Smtp-Source: AGHT+IEBE1YtleUlbra3PwB9CcV85ugtZ+zxNMSKGBspBwTaTLcRcREwaSr7cJYp4HwoaD0zfvZE8A==
X-Received: by 2002:a05:600c:3581:b0:42c:b4f1:f281 with SMTP id 5b1f17b1804b1-42f584973e0mr92643025e9.34.1727701025970;
        Mon, 30 Sep 2024 05:57:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bbd1:92ec:a53b:af7d? ([2001:8b0:aba:5f3c:bbd1:92ec:a53b:af7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d287sm9059214f8f.11.2024.09.30.05.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:57:05 -0700 (PDT)
Message-ID: <a61e5d9ef44ecc34a6251f33ec53d4c008100b53.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 2/3] bb/data_smart: fix override
 syntax warning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Konrad Weihmann <kweihmann@outlook.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 30 Sep 2024 13:57:05 +0100
In-Reply-To: <GV1PR07MB91202E0541450DC69A204E4FA8762@GV1PR07MB9120.eurprd07.prod.outlook.com>
References: 
	<GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
	 <e6694732a1e929e0a33aeba62713433019ea1dc4.camel@linuxfoundation.org>
	 <GV1PR07MB91202E0541450DC69A204E4FA8762@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 12:57:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16619

On Mon, 2024-09-30 at 13:13 +0200, Konrad Weihmann wrote:
> > Also, I would still prefer a pre-compiled regex. I appreciate python
> > just have a last used cache but I'd prefer not to rely on python's
> > implementation details which can and do change.
>=20
> Wouldn't that have an overall penalty on the runtime behavior (I know
> it's only once)?
> With this inline expression, it would actually only be applicable on the=
=20
> pattern in question, so for an already converted layer set it runtime
> penalty is +/- 0, while with the precompiled expression we would add=20
> something on top for all users.
> Just want to make sure that is would be acceptable for you, as my=20
> understanding was that any penalty should be avoided

You'll see a number of regex compiles at the top of data_smart.py. I'd
imagine one more there for this wouldn't be noticed.

Cheers,

Richard

