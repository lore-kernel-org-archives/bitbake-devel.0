Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5878C5DF85
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 08:36:53 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2578.1787128604190348882
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 01:36:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qyXTnzb7;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-902e4af2d9dso12428996d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 01:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787128603; cv=none;
        d=google.com; s=arc-20260327;
        b=WtgYFq8Z+SWjQjvJGBiBIQQuBRPA2eEkSOUO3EzicSpJLICFdQtSASYzzcq53icc6B
         oL7WrxlTtQEmj27RKtAhdvRzw+9Ner4cs3/DMNRjLIdQ4pgiFv8OSjiylV8Qpw81PWQf
         fDTHPr7Nm/riimWQ2cru1dONeSnqcDYhfUuM2jIKhC4Zml1QOoRZOuN1dTdmecqg+myR
         qeTHNIqlYbnCOY/ZHNItQO2omOR2mJlgE21PFwtI4NkV5fV690sb2YS/mmyXB/XZVD9Q
         YmJhtbae/V9GSWOX6/pp5ncbJi9Rh/bF0kyrEKjNAViHmyScvVf4+aPkT/yFfkYVcJ+E
         10sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zRxyslbBk1rudtqtC3qJUunMYgADteziXBqNYQZ2CDc=;
        fh=ny6PMxHUNo4++t2P141t5Us7uiJHbbzKcxITfHQgk+Y=;
        b=g6UQp6dun2V9b5F4uPL/BRYVFfGt5A0NxXcoE+UuoaKkTAI/XWvMA5zNuU477jumIj
         Rm8fPPyPz2niVEXoUr5u2VGi8Pi9wY2+gRXOLzpWvU1Gqyony5DSlUZ1j+9/Qnrih9R4
         lU4LnGxy9T1G7vNZyMwrytb3TkaLX+s6seVxB/tdPfQp81pZQjgRcNuEqfbwC0MNnwCm
         hlWMpvxNlBTNHVW8n6uPORrMaCbODDLkoijVc8DF8cQiHC5w9Ckw1QmktTEhgelSfJvM
         uBBIGOQZqjHLWwuThU6pnVI+D9Vo/fn2WD6Av36yaDDFx0LrJlx5rk1dMldkY4G8x8Q+
         o+dQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128603; x=1787733403; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zRxyslbBk1rudtqtC3qJUunMYgADteziXBqNYQZ2CDc=;
        b=qyXTnzb7fqy3ymV8XdfCBfZyttiXha1pD9CPmAHMiTmPk2p0QlvkRYUepBYw7QAXOA
         AHT0T69sOcnuU4rIbLJIloxduFjiqxHItDH37UUGa5Mf4cKgQeFZznJyiJGpDnOAi6uu
         PyfUWykCd/1BNF57fhBc3bk2I+rQljFMIxOkjrAtkgZzMwqad/w4ZIn7YPTfaawyFbLm
         siZVZktjRlXpN1A4eeeM/Yl99SY9nqZrM0czfUkWKmnXcpHBpCjQfWGAuoC0a0M/jIHG
         hYPM/WZhSEv/7rk/eFVbhNU3k7bHfN9zyrWax/llhFqEAT4h/05i96skDb9bteUMolBg
         Sj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128603; x=1787733403;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zRxyslbBk1rudtqtC3qJUunMYgADteziXBqNYQZ2CDc=;
        b=idJ7xsMLaRU6hzTtKmRzXJGTruUwf9N27Ch0hbECrA6QlyzrM9j2v0n3xWvmKABKTk
         k3u7DUKtN2Cg5XVsuwBkc1Fv/7Cnzj1hPYROmeRd+34WC0vQy/ePb5l5/6ULG8f5Wq+B
         NsOU6/A6mT/VaVASpOj6kcJHGzmbzi3afWoO+R7p12qyI6GgMQf8wEoYG7oy+TvNdQ19
         4sqaWOmd3RXCEVjLWye447IWq09LxY9rZkIumGlWhzvodShz5GAM8VQE/f1nRUpOHoMP
         KvVHVzSs+VGiRp7l6kSzjXC6EQAamJHVrkUE8Q7gwgSeVKyehz6qrB4kwT3Q0O9b2YkD
         nXsg==
X-Gm-Message-State: AOJu0YyTV2tdFDEQ1dv4FWxvn++hSfjpAowynUQFY5pF34DWCrMEcx5t
	DtNyyQaLhEeAtOFNesbo1tKC5dwKApXT7nDCFEL6Bb4Q3uQNmHQ9Tqw/K8wHZyAewwT8vlofrZL
	gr4DSLR/MaNE8Hs0j9eUM/UaogVfH1MY=
X-Gm-Gg: AR+sD11HF26dRKLQvNVF5fOxGnbDBCEtTYuatbczuHLlcvNTmeLCVT3KmT3nlmCb2yM
	0Cly+wudmg4Ao3PIP+ozjOb7P0Oql+ZeCjB/1y2rwZxWpbZxTbCcWbbtwXoUofAgCzpVdxSMsne
	amFx9Db9NAScbu6yv8+re7c2y2B55bpsheTJlM/dAg27W2ZH6NtEnqZVZBGltS+1f2bFlog3fYq
	31sRlzcj94Kbp5Rq9vngNG4vv6pdiCIWc8L7V/tx9PkdeYPkIGCP4hx1l6vtNFScV01Bz9TfUlD
	Iui+PCz1oj1AzxP/SUqHXT4u+z0BUx06LEGX12mI7dnA5Q4QI5dSDt4NrjNn86N5B3XPhu0ma+K
	EynI=
X-Received: by 2002:a05:6214:2122:b0:8f1:74b0:a4ec with SMTP id
 6a1803df08f44-90c5db78b2emr27274946d6.4.1787128603014; Wed, 19 Aug 2026
 01:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
In-Reply-To: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Aug 2026 10:36:32 +0200
X-Gm-Features: AcwNN1U6MtyKhzJ4uEwv0rCQkYr75LmCtLN8SEyZAq_4GLVeLoQomJ3-GxXAJek
Message-ID: <CANNYZj-FZ5trTVaP_nvZu+sAoEZ--0RZk_cDMUkK6jgrGobTdA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve build config when
 init script is missing
To: giancarlo.cicellyn@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 08:36:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19990

On Wed, 19 Aug 2026 at 06:24, Giancarlo Cicellyn Comneno via
lists.openembedded.org
<giancarlo.cicellyn=gmail.com@lists.openembedded.org> wrote:
> +        os.remove(os.path.join(self.testrepopath, 'oe-init-build-env'))

This seems like a contrived scenario, so I'd like to understand it
better. What prompted you to ask AI to write a patch for it? How can
this happen in actual usage?

Alex

