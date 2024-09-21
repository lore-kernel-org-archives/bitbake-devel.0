Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7AFCF9C68
	for <webhook@archiver.kernel.org>; Sat, 21 Sep 2024 22:15:51 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.5155.1726956946003324370
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Sep 2024 15:15:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hCtZcJMq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cafda818aso29692265e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726956944; x=1727561744; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O7Z9NTlfcZhpB8oxqWtLBH6c11ZXtFTaO7VJ5sFcD9w=;
        b=hCtZcJMqfZdcZoTwXjbTa33I+d58HdPsdRj+xVfgRlF2mP+qxaMcOKAiksBPtpeixp
         dLmuWlIVecAriEGl9mbJQ2NFcWvPdwRr2M4xWLpNLgxeTp1ps75XYcomBmwsRbcJc9eZ
         dIu5SyXPFtAFBP8ftzFGMmDsdeDpFqHw/bGqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726956944; x=1727561744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7Z9NTlfcZhpB8oxqWtLBH6c11ZXtFTaO7VJ5sFcD9w=;
        b=RsDmdKjyIJhSHwJIe+elNaAiuxyHd1Tyfrl1tsOx9DA9Asv35SFUqcMfmrRUpGPx8l
         LvVqIlEIxqKxs3y3lzdnffVwZGJaZ3FPWAJmZbXjLj7DwGgvFWYoqxiVABIyxWXD8gf5
         yjFCTsl30HRNombQ1XzCUmAa16C4gZ60UMMvJnz40DxfiAqWnjm/M2+J4wNkWKLNuIDM
         ct9wO+W2cAyo/fhalZ9PY5uxUHcnn1fLlmZKPX4MHrUpjxrKPcOtDZaW5wfxCvUUowuE
         6qk+JncogKueS0u9ia/HMB7FxQuVSZtaL0SwEspAujUBi+az5lCCV2cGwDSxKjICX7h8
         v0/Q==
X-Gm-Message-State: AOJu0YwEalGOs4Q8i/A9DMqqecNK9Bw4o+9d8sq36iE5TSjoE0e6Dwnd
	YMybwPAR+KRAtv+AujOCedWbWOsG/I1gjzOC85yAZ1MqVyjjvzsRGV9+fB8s/Wo=
X-Google-Smtp-Source: AGHT+IENhWYCPBDo1dc/uZts/7EW02+y9uzQqqcA5XSoHt2n7Xri1TO2Nm0wJfF2ODSWcr/cKtV/Mw==
X-Received: by 2002:a05:600c:5126:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42e7c16e8f6mr51405295e9.16.1726956944190;
        Sat, 21 Sep 2024 15:15:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4f6a:2d77:ed0c:6809? ([2001:8b0:aba:5f3c:4f6a:2d77:ed0c:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7543f3f4sm86634935e9.16.2024.09.21.15.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 15:15:43 -0700 (PDT)
Message-ID: <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Konrad Weihmann <kweihmann@outlook.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sat, 21 Sep 2024 23:15:41 +0100
In-Reply-To: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
References: 
	<GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 22:15:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16583

On Sat, 2024-09-21 at 22:43 +0200, Konrad Weihmann wrote:
> Richard, this is in my opinion wrong.

Noted.

> It's preventing, for no reason, valid tasks.
> I agree that it's an expensive operation (potentially requiring to
> making it precompiled), but I honestly don't follow your take that
> this will be of any significance when taking a full (ordinary) build
> into account - the penalty of the operation is in a millisecond range
> while a typical task/image build is more considered within a minute
> range.
> If that "penalty" is unacceptable I at least would expect the
> documentation to explicitly name this limitation (currently I don't
> see that anywhere).

The penalty I worry about is against parse time. That *is* a serious
concern for usability. Lots of small changes like this mount up. I
happen to know (as someone who as done a lot of performance and
profiling work against bitbake) that setVar is on the hot path.

> So either way we would require a change, it's just unclear to me
> what's the consensus in the community.

No, we don't *require* a change.=C2=A0You're asking for a change, I'm sayin=
g
I don't think it is good for the performance penalty vs the gain.

> My take would be to prefer precision over performance - not sure how
> others think about it.
>=20
> Side note: the original patch never got any selftests, which just
> kept hiding the problem IMO

FWIW nothing is requiring you to have tasks named like that.

Cheers,

Richard

