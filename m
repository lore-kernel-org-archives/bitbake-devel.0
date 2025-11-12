Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB1CD1297
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:57:10 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.650.1762963029487300072
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 07:57:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FGn92wnQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso7544435e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762963028; x=1763567828; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P18GHdmm8qef2Ad5vl6nP7nCl3Mz7iwdzrfmGopF02Q=;
        b=FGn92wnQT4wc9LFkLGgrCOTFPPysLHoMkXYrH7iHLVRDI+BebtWZhdkeZsA0Tpz+ak
         nHFPSTJShTPkRIKLzqbY8K0vnOqmHzlZtC8jBTmpQ42L890ePUSvbb1TJ2oiEmYZ9SRo
         zyF/8cyJJhFaohmsCmGzYqzObDIftcoFsl3jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963028; x=1763567828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P18GHdmm8qef2Ad5vl6nP7nCl3Mz7iwdzrfmGopF02Q=;
        b=lDPE+Kj5ZjtdXVkp5dtPKrmhTbv5PMgWjldekTgHnd+s18oHk7tGHqnttopIGxFiN1
         IcukpImZAkrKn/sgQbJh6yRBOxcb6OZpyFQZWJZeqkNXWAmQNtWFYfzjluXAZlyHO+Cq
         ZXHz4WbdZaflIc8SKtKOnnU2V83BAEgaC6c7TKZ3XrNBpXY8jQGqTmMz2bGW68qliAoy
         r3U4/rOOF8aQXMO6BhEzDtegQXDvdTSBWVM2Nyg+39q6Yc+GKfbNXe4H0O70gq9v/MYA
         7U+tZzLdvRKeEyDoQcDdkjinGf3CHJfwYe4crqTDfp/6ddTxfsEVC9gMUvhXd7gUjo1K
         00Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWg25+qGoxHyOGWUM4BPAqiW8NxvaH7UuwsOtdwcNPyjeUMtHT2xXR4X3XsPBBDydEYw8cpRC4+Ke6diyzW@lists.openembedded.org
X-Gm-Message-State: AOJu0YzMouxFBqzH0WTsF1049U5VAzF01IGg6KYAJ2MHdhL4seYJXdp2
	fDrMqV9/XwCYx8vy5Y+xEjBUAvOM8VfF/k2f2JEJawJOc1/u5v87j06kNIrmeKqpOe8=
X-Gm-Gg: ASbGncvakdGU7zGH0N3t6rPEHZAByRDmHZMt9k5HB/SnRmmzijExr3cAjwY/vkfOKwP
	SUIZG99tPjVaYC2tC04MSoq11GfOcg02tcMUP8npsG8JB7WHk1rYcGzL8Ve5i7qVwBAH/V72ggk
	X3xAdQbDLo7QHSJNC2Durdw+nlfoWjV/6xJVcQKBml7KgUyRccQ3VFclW9YZqgsFGWExEu+yfZW
	zToB78szLP5e4KNvagdVEE8xPltn2/ys1PdFXJ7ugJpRd7gOnA2DD6njfgi8tDFGah7AdlpKzxH
	T6OKvOtjROd7H3R6vSGFHmzoQtVySFs2OV3HE4ZThupkXAuAe165sFbSLXuuhDS3W8jDD2JyNy4
	hlw8inFWqMvQm05Gp1X7Sz13zMybNea/EZZS5qUXIr/RJTmf6mLD463+RxDJZmZBRkLOF2b1I56
	nzwLsvb+tPFMev0oPXhEjKcRdlCl7VHllUFiChjnXyPvdYQOBJqe0jYufj3u6iet6f
X-Google-Smtp-Source: AGHT+IFNYx0hJvOMmTe5OY70Aua1IdSIMekhw/AM5/BxQ8Glb0jtlyFlNxCuQtsT0Hkt/HxpMBjzXQ==
X-Received: by 2002:a05:600c:6305:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-477870a6bc2mr37957735e9.30.1762963027818;
        Wed, 12 Nov 2025 07:57:07 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:8876:d08f:2a0c:d6ff? ([2001:8b0:aba:5f3c:8876:d08f:2a0c:d6ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm35500621f8f.40.2025.11.12.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:57:07 -0800 (PST)
Message-ID: <6c4906cefa9846025d944edc02351bcfc9f3f42c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Combining PREMIRRORS and downloadfilename with
 wget
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: isaac.true@emlix.com, bitbake-devel@lists.openembedded.org
Date: Wed, 12 Nov 2025 15:57:06 +0000
In-Reply-To: <f0f7ae6b-33f2-402a-86f2-4714f07af30e@emlix.com>
References: <f0f7ae6b-33f2-402a-86f2-4714f07af30e@emlix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 15:57:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18357

On Tue, 2025-11-11 at 16:55 +0100, Isaac True via lists.openembedded.org wr=
ote:
> I'm experience some confusing behaviour when trying to add PREMIRRORS to=
=20
> use an internal proxy for source files fetched over HTTPS, and I'm=20
> wondering if this is the intended behaviour or if this is a bug.

It is a known bug. It was mentioned in the weekly status reports for a whil=
e.

Basically nobody has been able to find the time to dive in and unravel
things to make everything work as it should.

There may be an open bug for it (I hope!) but if not we should have one
open.

We may need to introduce a new parameter with different semantics and
remove the current one to properly solve it, going from memory.

Cheers,

Richard

