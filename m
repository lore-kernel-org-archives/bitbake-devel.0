Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03469CA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 10:18:58 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.35436.1725272332212134107
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Sep 2024 03:18:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RHoCJc4x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so3769053a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725272330; x=1725877130; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdOZ6a6aJcOVALQV5EuUPQM8VBx82dgm9yB1azkvxWk=;
        b=RHoCJc4xkveRTdrITnmq077WW3g1glZCNc0Bph81zl51euiLUH+P1ECpmLQcqMDfUI
         eGKBCl8t5XOvcnmYxj4SEP+KoyouyNE6EisaJhQH/sD2ZTc5szXKailXqwsDcFrBXs5j
         mn/h9aOWpwtGAvzQCK4wZIOiZxVWjMm0gBC2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272330; x=1725877130;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdOZ6a6aJcOVALQV5EuUPQM8VBx82dgm9yB1azkvxWk=;
        b=CKrptGHlz5Mm72iYL/fyVV0p0iln5iGZiIQH5H6V8m9KCtWt47c7bcrk0+eHvYOxJu
         62BPwWQ0VnPp44Zwf5tDQRhe7jBx+OQCI7fo8V44k4jjzRiZoJs+857lB/oDbVhkZUwD
         4FWy+2buhk4B2cGwJp+RhB1OJVw5hIceP5LPetniJKQbCHMYzaby5pQnzwK2vhEfbtJY
         zexXQQziipyVflTbiT8lofpsiPyEr3r78kUQIMD0JQfsJ5mD5ZEWcrHKT83LBlBEy2Y8
         LFqzfIWUdnh1wCUqu70tJk/GJBtvCczKPE9L4oWTi/unetP8dJ66dCRxtp+B2pX373q+
         6Fig==
X-Forwarded-Encrypted: i=1; AJvYcCXJVuWC3Vn1By9MV60V7k6WHOBB32yTJrYgEnzXOYZv1AC6iuN2Fru1Ugpf7P5witIuvFaQ0lI25N6kLE/J@lists.openembedded.org
X-Gm-Message-State: AOJu0YxhaObIu/t/92KdRCr0JU9/K7FSN5SASi7S3cafip8tFIvikBZE
	QzOkBlgJLd1VAn+QD2SDLKpg+dp3Y/le5qrgVemFzQNFKfrhlC8l3f1AhsZJPuYp7OuTGfguRYN
	w
X-Google-Smtp-Source: AGHT+IEha7lgjer6WDb9S19rsvLpu38Tu/OP0+AWBkZ8rKJ7YkGFY6rRqpyIVX2/uQ5DDUyZgty9kg==
X-Received: by 2002:a17:907:608a:b0:a86:7a59:55e9 with SMTP id a640c23a62f3a-a897fa7360emr951270466b.55.1725272330365;
        Mon, 02 Sep 2024 03:18:50 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ed45:1ec7:2c83:ff6d? ([2001:8b0:aba:5f3c:ed45:1ec7:2c83:ff6d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892225bbsm539745466b.199.2024.09.02.03.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:18:49 -0700 (PDT)
Message-ID: <d5b067dffb623ef16fc9bfd410297cc0a92de47d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: Add gomod fetcher
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: christian.lindeberg@axis.com, bitbake-devel@lists.openembedded.org
Date: Mon, 02 Sep 2024 11:18:49 +0100
In-Reply-To: <20240902091323.2241464-1-christli@axis.com>
References: <20240902091323.2241464-1-christli@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 10:18:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16533

On Mon, 2024-09-02 at 11:13 +0200, Christian Lindeberg via lists.openembedd=
ed.org wrote:
> From: Christian Lindeberg <christian.lindeberg@axis.com>
>=20
> Add a go module fetcher for downloading module dependencies to the
> module cache from a module proxy. The fetcher can be used with the
> go-mod class in OE-Core.
>=20
> A module dependency can be specified with:
>=20
> =C2=A0 SRC_URI +=3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=
=3D..."
>=20
> Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
> ---
> =C2=A0lib/bb/fetch2/__init__.py |=C2=A0=C2=A0 4 +-
> =C2=A0lib/bb/fetch2/gomod.py=C2=A0=C2=A0=C2=A0 | 116 ++++++++++++++++++++=
++++++++++++++++++
> =C2=A0lib/bb/tests/fetch.py=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 73 ++++++++++=
++++++++++++++
> =C2=A03 files changed, 192 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 lib/bb/fetch2/gomod.py

These changes look interesting and I'd be interested to hear review
from other people more used to dealing with go.

I see the code using GOMODCACHE in unpack(). In general the fetcher
tries to work off url parameters and we try not to have environment
variables unless they are truly global config. This looks to be a per
recipe local setting.

I guess this is something which any code using go is going to have to
have set into the environment anyway so perhaps it is ok but I'm not
sure I like the precedent.

I also noticed that there are two fetchers in the code, one which
subclasses git and one which subclasses wget, the difference between
them is a direct=3Dgit parameter in the url. I did wonder if these should
just be two url types (gomod:// and gomodvcs://)?

It may also be helpful to document in the code exactly what changes to
the underlying base fetcher are being made. I'm a bit worried about how
changes to the git or wget fetcher might break this code, particularly
as it isn't going to be heavily used/tested as far as I can tell.

Cheers,

Richard

