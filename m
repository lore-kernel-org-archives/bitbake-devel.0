Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A163C43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 12:15:21 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8312.1784031317865802805
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jul 2026 05:15:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O4sk0b8K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4759b4f0897so517801f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Jul 2026 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784031316; x=1784636116; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2o4u/lR0sCJZ6aBC0AuiA+4nNDkGUC8xg6At5EmZWDY=;
        b=O4sk0b8KLzW6WyC2e5sM+kwaoQXf4fFoRs9knyEog+i3L4bj4FP68VVsjj9lfINzFI
         CMcg8M03CkVI4aWUmrzUw6YAfdxWQeyNjqOmMYNWK4xMuzlHbZm0uUfKbcPQFye3OS58
         nuG91H4WYCMruXzhvoaCR6pKl2Biu/YXFIflA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031316; x=1784636116;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2o4u/lR0sCJZ6aBC0AuiA+4nNDkGUC8xg6At5EmZWDY=;
        b=s9CiKeefdVl+BvlaBS8PaUeWg7M/c9ivuUUM9crNNSc98p03tWbINutq/icZMUA8FZ
         z6jJxpeLDn/pcRDLoM3vw/Y9SJMbek7hB+gEwJe97cslGjMuRDQ5kBrbiv2UL3mNFVwx
         r6vD1qj4RJyII22Oousj4bOOsicfHtReTmYk6AtvBi9Aj6Ioq8CnvNRChvyUrg1DH/D+
         6z7XABvcpe+Des1t2E3G5nROwIz7Elp3CbkjrxLlEJwE77ks3Ggx188OkrIpDfZwIswx
         AqBGPbf5SJE5AKc0iPNUbgnaZIvkYBzBcHucZGEHNWMr5cbMDNWdcYXPUfCxgyLKqcO/
         /ZRw==
X-Forwarded-Encrypted: i=1; AHgh+RqZRfBY5P9faglPTvMvkVt/zowhmH+oxyxOMFw6ooE62nNaPljRgadl9ZI1vl7+6zuqRKomu6oghsmh936G@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxf40tM6+Z8nSdKaT8iawyrYP0wubyifmV2J5NV5QIH83eRzAse
	xeFUkMyf+bHyQSNEQRBFX1TswNc4XX+yl+yGrykP0xgosXLvKKrifoXCdLm85mKnV2g=
X-Gm-Gg: AfdE7ckeFU3AqZx5L3nDlpmt2RJmkRs9dEznuPklfVpuso+CmlnMb97r8jE9JL4bZIe
	rtacq7KyVQq2OG4W1RBZ3yWGbnHUFQYxLFXRVjDnXaYOGp8Ea/1aZ+o7nWghmzQrAzbNAM66wbH
	9ReNfDiFIpp1idRxslF3erMEIsMrPFsRMbmZo6Ew0KXKANC4F4TsuSYyBFrJSb9DOXEtIVNPvgc
	DWDgVhUXAdnRsylcxatpA0muHx6f03nKCRPGfbIA8iJQpjx3tdhge3WY+CHmhLexDoCJl4HLp9X
	ECB3KNpOj+zXXQlH9eeqokMAj489XtLxKO8oo3kH9g0s5rdoNBSsLZ4v3oAuILVZMZ09rJxY3tL
	RlO0YGHP8PbHUx7J+h+tnGReZ2zbxRNmefje7t2csKw60z9GJU6ExwCnRmWHsWzTGTOFoPJj8s9
	NovM7BDBChTmt7INgZWGWpTXv8FoYyYOZQjsxKaGsNjB9CDJan00nrwa2AHgbjN9u6+dcMrzonM
	HfQz/zHiMeQVr+H
X-Received: by 2002:a05:600c:621b:b0:493:faf3:3ead with SMTP id 5b1f17b1804b1-4952cc3c566mr30102685e9.4.1784031315610;
        Tue, 14 Jul 2026 05:15:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:63d0:a687:a2eb:2715? ([2001:8b0:aba:5f3c:63d0:a687:a2eb:2715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f9402sm75910365e9.13.2026.07.14.05.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:15:14 -0700 (PDT)
Message-ID: <420910a84c6d51c2c3742223e2507229d5a93716.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch/{npm,npmsw}: fix security
 issue and re-enable fetchers
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: thomas.perrot@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 14 Jul 2026 13:15:13 +0100
In-Reply-To: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
References: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Jul 2026 12:15:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19837

On Tue, 2026-06-16 at 15:37 +0200, Thomas Perrot via lists.openembedded.org=
 wrote:
> The npm and npmsw fetchers were disabled in 355cd226 (Jan 2026) because
> the npm fetcher retrieved checksums from the remote registry rather than
> from the recipe. This series fixes the root cause and re-enables both
> fetchers.

Thanks for the patches, I'm not 100% convinced the issues are all resolved =
though.

For example, even after the patches are applued, test_npm has a version
in it but no checksum, yet the test passes, test_npm_premirrors also
has no checksum and so on.

How are we verifying the fetched sources in those cases?

Cheers,

Richard


