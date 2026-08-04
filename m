Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FADC55838
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 11:38:01 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14372.1785843479857389071
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2026 04:38:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D6RoweA6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so28409185e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785843478; x=1786448278; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pwlVk/XkBKmXjQKs9AZ74Hum7oJhrs39Wmb4dN8FIvI=;
        b=D6RoweA6EpkegQlmSI8MbfwQKz79CU7I/XNs80fK3nct++nuFX5itsuYWwU3Nqf1vv
         KwRKONrkKyEenl5zoaqV8bHPcH9WGdExWrFioerkC2/BLfA9HhZS1m7bQXCCDAyiln2Z
         wo6Sd82aM0iYHLpaLNfwBcqmTJrRYRm1dDYCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785843478; x=1786448278;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwlVk/XkBKmXjQKs9AZ74Hum7oJhrs39Wmb4dN8FIvI=;
        b=S5nFZGxzYAOeyn93fdEDl1RFU7EOEDLCfHDCSrTYawqFRbr6duOG9ca8Lm8QSshWaF
         R1qIvKVFHP1dIC/mBHFZY/L1IPlWkgstgBjZyy5MgsDODJuXpx6rjvGy1lSq5AcSB8tE
         FIPHo/pPaG7L/tDTafQJj2r8183kK/CWcDbn3o5jyfmVSV3j16LNqOE+H3A2UZz87cL0
         pDsn+nC+wb4eZaYvlTK2Sx75QwQX3NguErD2kmRxDn2OsLau8vzGMHUDXJRvCFAwOyXZ
         zS7xbQqRLth91THbQyDVEdO0ZOrtcKjicQPxyEAqTJQE+9vOK9SsS92Efek+MjMDjNy5
         e4bg==
X-Forwarded-Encrypted: i=1; AHgh+RpqvLB2QJcWhe4fl3Kyl2FQq7ml0ofID29EtdbAv1zvQp/33EIGGg5/nphsQpTcNDjuUwQ0Fd2DAVEYwRMN@lists.openembedded.org
X-Gm-Message-State: AOJu0YzOJE2/7Dk7muf6+7vaVo29VKmqCVtfvj67YThaTm8yVNFF1IuK
	5dNB5Zn1eiPMsE4wyhvXD0rVkO0J5Wf3QPC8xT6Q0D/7JSaqXCU3eJImce2qR+FaHNk=
X-Gm-Gg: AR+sD10XCCK8J3XOSLqV+zFngPt1gsBZqovVpg+LU72gRjqegHvwFF0B7aNtjzn30Yq
	p1rALt3DGBhyZHWpLV6fKTW1GoMA45+hVkgrugINRSyqux7M2lnccYDCwhwrFEMqCeV8TTRWyhD
	LgugnaSAGCa0W7rVL9+N2EuMLwRaX2xB50nHYuOpCU2+CzzJLR/eCz0kELEmfCkFr3SgTToFcFZ
	nC3x1IR8zZ36yISDmXk+W68wJu5dWLIrJyCQ595FDb/icr+vp6sq7kOgUv2LJcAvx+Vb3v4FYwA
	J8j/1n/Bxgk8rV5nKih5ITxFbuQDhnjoR2Yh12bLrqEwZR56FA7HIZUYgZ4Yr6qRFjYcng6zt8S
	xVVf+HmbANh+zh3XOmFRmIvl/Q7sC3Lk0fOvBtPFvN+aTaw2igYSZIe6IdWyobEDlMooaC6vS1d
	SMiUlMgK6vTQeiYpcYBSCWPL3mmmJLdpMooWjSIwQ+a4Tau7ApOU1x/dch6yfLJUKM0+CRma4et
	vjmAKLaEGcGDwh8ekaRpyJ42D697WWJ4lVa4XJC+LuZiLxveGjbiw==
X-Received: by 2002:a05:600c:2294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4980c67af97mr261900895e9.15.1785843478022;
        Tue, 04 Aug 2026 04:37:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ce15:a763:9e16:7bb4? ([2001:8b0:aba:5f3c:ce15:a763:9e16:7bb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2b98sm85952875e9.2.2026.08.04.04.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:37:57 -0700 (PDT)
Message-ID: <34211867d74a9757b5b0ff10e7ac3c0b4811ceda.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: warn on trailing whitespace
 after line continuation backslash
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 04 Aug 2026 12:37:56 +0100
In-Reply-To: <9a3bc50b-89a8-439c-aa44-1b2707a88ca4@est.tech>
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
	 <056c55ee98f7d48caa6bf45152cd63115b9d3132.camel@linuxfoundation.org>
	 <9a3bc50b-89a8-439c-aa44-1b2707a88ca4@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 11:38:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19900

On Tue, 2026-08-04 at 12:37 +0200, Jaipaul Cheernam wrote:
> =C2=A0=C2=A0Hi Richard,
>=20
> =C2=A0=C2=A0 Fair point =E2=80=94 it doesn't break parsing itself and the=
 code churn is
> larger than ideal for a warning.
>=20
> =C2=A0=C2=A0 Would you prefer if I just submitted the oe-core fixes to cl=
ean up
> the affected recipes instead and dropped this bitbake change? That=20
> solves the immediate problem without adding complexity to the parser.

You should definitely send that clean up for oe-core.

I was toying with the idea we just make whitespace after a line break
character a fatal parsing error. Most of the fatal errors are inside
feeder() rather than where you changed the code.

I then looked at the code further and it isn't just trailing whitespace
after "\" that is an issue. For example, after "}" closing a function
could also be an issue in the same way. I didn't look in detail beyond
that, there will be further similar issues though and that does mean
your patch is incomplete :/.

> =C2=A0 Alternatively, I could reduce this to a bb.note() (debug-level) so
> it's only visible with -v, keeping it minimal.

I think this needs further thought and some wider testing of how
widespread trailing whitespace is.

We might just want to make any trailing spaces a warning since we
currently just swallow and hide it unconditionally?

Cheers,

Richard


