Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4D7D729F4
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 18:05:46 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.120101.1732903536296122024
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Nov 2024 10:05:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fCcNb8qY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a45f05feso23638265e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 10:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732903534; x=1733508334; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dARY4UWfaMK5KlmdIBDbuxs67x7Z2OJfCPG0HHJk5H4=;
        b=fCcNb8qYXiz+pKzSpa9XHEOAhHSKrbA2jfG+I/6yfOu+G1wJaVaWmLJflvQGUeBCdN
         vxVfKXcCBQQWAzHIL+1LpigwBJFt0+T1ZlFb9N0YrF9VYpk9QaWGWCzBHbZ/Clvq+bGB
         Ws5BhSYpDBVRq/wOsMiTS7+3YT4n5nRinXUjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903534; x=1733508334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dARY4UWfaMK5KlmdIBDbuxs67x7Z2OJfCPG0HHJk5H4=;
        b=qfrDa/Lz6Rucv0hyELlKCbFLR+58OSJt8IbF4gFUCSBmFN+/lj8rYCTioTnUTxkqdn
         zpWExlWWUxwdKKWuZyV+NtQs5/RT3QWc/4qc0f8GmwQ7e7mZqJNQWhdk27sEpvDgSGvo
         65r96pOHlCwym0w8VlXmocievuEVSXmTOhyK33tFTAtmcEnTeXhXnur4UpHNco3Dw8pO
         TJLHMsWF1urQB4/uJZ2JtaHJ3cvadXXY7PbIMU12H0RsgIxe5PP7x1up36pGfbcqnF0Q
         MdQzRHOypaW4u6BRcTQMOunylxJAXS16V9Y8lvzC+KUezbzGa6kxo2tTGba1VAoEkevM
         ZYMQ==
X-Gm-Message-State: AOJu0Yx1ByJbc4om7X6U7u02Du4sFfMFY1NU4TG0cGrAFiaT6ZH4k/Bn
	Q1JJoVYY2UlNpD5aRB3yNLMl5NnLzFNwrnRyRLjny9qiTyAnjX4gP7Lp2hqVLtas8ZOoIYMMVyU
	d
X-Gm-Gg: ASbGncvJ5pNeXC2IL74wgiv8yt1t9PrS3gmuKR0QHH15nuc/Zi+cvHwgW14zpsf4675
	eFW6z1+12I22sybPz930+g02GjZ0jS4/79WeaGGVYssOdp86aatqy+npVZunCSYGeUghcXVGQRk
	UGiyiguT3Z2K4PTOBkWmcnp5dC5BMsBAf3EO7muPFLlBecxvJOQHWUx7asonUwMJsciCoGF6/uZ
	T3fP3A/OvqfpD4CvIBfqIYTiqb4Wff6mVZ9iBhrvoEHGoO6c/0mLdhDUikfR286ncIRIv6DJYgN
	tVyNRyHB2My7CcoXce1aiAY9YP1rRHkHVVR1lxw=
X-Google-Smtp-Source: AGHT+IFq2goOfsp0acqj9Uch6quC+QqeoweNdbziSwYycVXByGD+MrmTup6daQqKByngo4q2cnc4Rw==
X-Received: by 2002:a5d:584c:0:b0:382:4f7a:7a87 with SMTP id ffacd0b85a97d-385c6edd128mr12688907f8f.48.1732903533595;
        Fri, 29 Nov 2024 10:05:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1083:22d7:abf5:ae6f? ([2001:8b0:aba:5f3c:1083:22d7:abf5:ae6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a6a6sm5004582f8f.56.2024.11.29.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:05:32 -0800 (PST)
Message-ID: <5d5f3ab9c2f7091de5827e40cf9f7c7e7917708f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Fix performance of
 multiconfigs with large overlap
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 29 Nov 2024 18:05:31 +0000
In-Reply-To: <CANNYZj_sJuUFJc9V37yhvjeFukqQ-A7GRC5SUwc+WMM24bvSeA@mail.gmail.com>
References: <20241129125524.131362-1-richard.purdie@linuxfoundation.org>
	 <CANNYZj_sJuUFJc9V37yhvjeFukqQ-A7GRC5SUwc+WMM24bvSeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 18:05:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16850

On Fri, 2024-11-29 at 14:12 +0100, Alexander Kanavin wrote:
> I noticed that particularly 'bitbake core-image-ptest-all' tends to
> sit for significant amount of time without spawning tasks. I
> cherry-picked this patch and it doesn't seem to be helping :(

Is that with an already populated sstate cache or empty? Hash
equivalence enabled locally or remote?

Does:

https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&id=3Dd8620795a780=
0801f52b098fe3f9508e9f3f26f2

help?

I'd like to try and reproduce if not...

Cheers,

Richard

