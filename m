Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355AAE8FDDA
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 08:17:20 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.13645.1696407428684793994
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Oct 2023 01:17:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FZd1toR8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so3296495e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Oct 2023 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696407426; x=1697012226; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/lbrxN30A+aviIm+8zleUpEME/y0p1dMbtRoQRBY+I=;
        b=FZd1toR8x+p/T7bXawh2fXEMGTitDraOx5XmwDReHDbG8b5WlubTfQuahbcK4eqmFr
         CwsREmsCiFXryOwa8+NmUvv5I9ngjQd9qR5Jg+ZPpC+cZhxnF+lq5lGHq2cvr6M/Hd5l
         55pHBz2fguGIsSpXs84AZ1nHf1IRiM0Kwo0CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696407426; x=1697012226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/lbrxN30A+aviIm+8zleUpEME/y0p1dMbtRoQRBY+I=;
        b=jlRhA91e6AK3gDoaqyM2FeWukqvLUF2xiazsdqkIK0r+Of1V8nIcNM2gst+Pd0DWGG
         Miq5Kq6v5t/nlvTiUhBDtxoNhdSYi3F+x+7mDv9S6AJB6MIDrae5i77v+lL09qPlNOaE
         qYJ4WyduoM9gTOxirhMUg0ed5RhF95r5nhYP/cS/M07djSWnOWfI7w2yE+bSnsAQTnn4
         XjUz31IRVFOXCpkH3aVuR5QOzyXuwZq3eTCUbv420pTJTgPMxPyOFcfm+SyIM64wetHZ
         pew3tEwBxTV/WbUJYMP+WX9EJNI8US3eB9AbrubLnE5Vx3rOG1G9rx+gBdqVOK2qWbci
         qd6w==
X-Gm-Message-State: AOJu0Yy50O3XGEat2bxC5jDutdgsYa+d19BCw3jfTSmnkkDwc0mhiEYj
	rFYuChQ46/QnuOsqjpQioxYe0w==
X-Google-Smtp-Source: AGHT+IFv5EyLOUmbN5D8aV140NjeXpWffwrZ3dw94TdY2thJ/L1EwG9C4rLuVWN5HQ9yPGyYQ475aA==
X-Received: by 2002:a05:600c:c9:b0:405:3dee:3515 with SMTP id u9-20020a05600c00c900b004053dee3515mr1643419wmm.27.1696407426413;
        Wed, 04 Oct 2023 01:17:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:cc7c:410f:894f:7a55? ([2001:8b0:aba:5f3c:cc7c:410f:894f:7a55])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4d11000000b0032485046055sm3421315wrt.5.2023.10.04.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:17:06 -0700 (PDT)
Message-ID: <1eb0d3b2f485a10a776ad1c136b1d5fc62228efd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [docs] [PATCH] bitbake-worker: add header with
 length of message
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Etienne Cordonnier <ecordonnier@snap.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 04 Oct 2023 09:17:05 +0100
In-Reply-To: <CAHUKmYasZWwwZ_QZmd0WvFx=mE8na+0OCn3ddS1zNCp_O4rRBw@mail.gmail.com>
References: <20230921075658.509846-1-ecordonnier@snap.com>
	 <0d94ff1c8efe8d37471f3c0bfe09403a7d8c5af8.camel@linuxfoundation.org>
	 <1786E57180396CF1.29236@lists.openembedded.org>
	 <CAHUKmYasZWwwZ_QZmd0WvFx=mE8na+0OCn3ddS1zNCp_O4rRBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Oct 2023 08:17:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15182

On Wed, 2023-10-04 at 09:43 +0200, Etienne Cordonnier wrote:
> Is the patch OK? I think it should be merged independently of whether
> the amount of data sent through the IPC gets reduced or not.

With this one, I'm not sure. We're in our feature freeze and there are
a ton of problematic issues which we're struggling to get to grips
with. Given I'm not 100% convinced that we should change this, I don't
feel it is a good time to change this.

I really don't know whether it will/should go in after feature freeze
or not either. I appreciate you'd like answers on that but I'm
struggling with the bandwidth to give everything the time they need :(

Cheers,

Richard



