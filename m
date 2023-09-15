Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BEBEE6457
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 14:29:35 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.21810.1694788169133453847
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Sep 2023 07:29:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=anXOboPS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so24030405e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694788167; x=1695392967; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F4fHUL34PWhErWd/npcWr+D+KE7/Fhzb4BbkVVfoABk=;
        b=anXOboPSMt57/1Ek8u+s4nr9SHFMp8GtPQzncp2UZd+kPFBUEPKp0qGp/Kf7uFsiWu
         vIqC9JpkLWpPy7rxsy0NXQuMQXJxKgj/49t6XbAGgh0F84EtScntyvdO7z/SeoJ/7QPX
         0EuXF54QNwr0lQS36e4/CwtAdalrwPvq4qiPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788167; x=1695392967;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4fHUL34PWhErWd/npcWr+D+KE7/Fhzb4BbkVVfoABk=;
        b=tedjqOgj5okKhENZM44twynpxvxhtx7TpyDgCXTC/0zUpqfRHConwcmsoPMPGTHKfI
         /kzugk1KsH/gaTT05+iem1B8Hj8J2t3i80zZRw2oBJAA5fi3rKxxqgQGc9t6Y3dqzVvk
         tprnGjQEX71M8kzSPTLwamK4CIw0tCAD2uI3n47j9nU4vEuNf7phaDIk+oxrl8tCxx4i
         zSnh6SjutC2XZXnkNDCgSfJbcUN/9E4hkCJ3ThmsRqp33XqYrhCJ9BP3SKNfsXVqbkJ8
         pgILJ7GvrlCSitb4LWONzSff6uRG4gsd6mRuvg7xF3r7VgsGOTWtTYPq/+19sD4goPRo
         762g==
X-Gm-Message-State: AOJu0YwK3dtxUTSn7RBCf8Vl+JzxW7XhYSXrxxnmbwi7Qt7+p/SCJmPF
	HBHBPzrylRBXSDH1q9d6sbIEgA==
X-Google-Smtp-Source: AGHT+IE2ioGOUHqLAq2GBs83adN+oKwQzqPXeG6eHlNdpCA8H4oTKvU/hjLyjtk8c/tkpC23bfrVWg==
X-Received: by 2002:a05:600c:b52:b0:3fe:2e0d:b715 with SMTP id k18-20020a05600c0b5200b003fe2e0db715mr1824965wmr.18.1694788167633;
        Fri, 15 Sep 2023 07:29:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:93a7:bb97:496b:8932? ([2001:8b0:aba:5f3c:93a7:bb97:496b:8932])
        by smtp.gmail.com with ESMTPSA id q11-20020adff50b000000b0031c71693449sm4620579wro.1.2023.09.15.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:29:27 -0700 (PDT)
Message-ID: <b87ab9a9b4fded469caac48f3c48840cec064076.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] server/process: Disable the flush()
 call in server logging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>
Cc: Philip Balister <philip@opensdr.com>
Date: Fri, 15 Sep 2023 15:29:26 +0100
In-Reply-To: <DB5PR02MB10213747F1C3061D3EC8C116FEFF6A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <1784D0C1F5057432.10618@lists.openembedded.org>
	 <49c3f81299d8153f31b09cfd226cb183097e6c8f.camel@linuxfoundation.org>
	 <DB5PR02MB10213747F1C3061D3EC8C116FEFF6A@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 14:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15069

On Fri, 2023-09-15 at 13:59 +0000, Peter Kjellerstedt wrote:
>=20
> While the problem the patch tried to fix is real, it seems a lot less
> problematic than the result of applying the patch. So from a release=20
> perspective, I would keep the current code and possibly add it as a=20
> known bug to the release notes. Then, after the release is out, start
> the work of solving the fallout from applying the patch, with the=20
> intention to have it solved for the first point release of Nanbield.
>=20
> While not ideal, it sounds a lot less stressful than applying the=20
> patch at this stage.

My concern is the cache coherency issues this exposes.

The 'easy' fix for release is explicit os.sync() calls in most command
paths (everything except ping).

I'm not sure I should really allow such a patch through review though
as it would raise a lot of serious questions and the underlying issues
need to be addressed.

Cheers,

Richard



