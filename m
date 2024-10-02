Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D50CF6D3D
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 16:42:52 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.478.1727887368979950645
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Oct 2024 09:42:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dzTq0g0B;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so56505235e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727887367; x=1728492167; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTi8gH9vZkOa8Qf0dpTnqPvJmG1cWsRSOQ73UbnlM3Q=;
        b=dzTq0g0BaGm1Ll6iPziWWn7ZugKeByIBrmITRNqwTvhn4E/9sqIRnriv7adGZnUIJ1
         p7X8v1h1WdnOyi3+hH7cfulZjZj374lxYxO2slWhmXFRCdk5wUGIbO+FPuAhtguiM0Ut
         DSD2RQ3vypjI8LvXQO8ftmLKCWtGQ014u0MBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727887367; x=1728492167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTi8gH9vZkOa8Qf0dpTnqPvJmG1cWsRSOQ73UbnlM3Q=;
        b=Lf1VamBgj08t67AbCAZE65j/4cVq7AI7RiwM3ERPFxxujDnvzTBtfz67LHRFO7d2I2
         5e1KKtpSPRelWZcWzuh3y/Y7GfNqXOjLwGDsN/rhdxXaHsfnA9DIxng3QybKt1cdqez3
         fXUhA2au0cFrSBmt3UTrf70QUbeZWV4ZcidhkximGeCImjzxNPlYRfLUIbZqYYSgMiWQ
         rlZIFsrmGG9yMbfIlSYuU5U6kRZhpZV7j4i0hOLuBsoU95c9hAtoVKw7j8PSpNObAIV+
         gJ3bkfkkR1JG3zU5XtkdfYEYFujT5R/zmrcfiCR67Q6/ews15xlZCBHAZj74ibF0uS/6
         KaDA==
X-Forwarded-Encrypted: i=1; AJvYcCXGoLBHpzkI2GhQ8kZRUCaBtQbrF4VKhFpIJNHEp9dMcaJoWswVp9i/CmjW+BaPbTlT4ZAYm9yfT31ZR6Tp@lists.openembedded.org
X-Gm-Message-State: AOJu0YwsHggSc//LD8ZlbB+tNHIO/Du8cv4zwCueZjMz2otH6TAgnaOl
	U6qFnnn64ppnVuQk8p2cLAGfTbdnG222cPgR7SdYgemRaDXFmVrUx2DSPGzc+uI=
X-Google-Smtp-Source: AGHT+IHi2e6FPyCB1MH3K8d0JmePDmuvXdh/BpO3Oc9lkVOOMO+ELB1MvKujxM45N8wod7hld0AJeQ==
X-Received: by 2002:a5d:4d09:0:b0:374:b9d7:5120 with SMTP id ffacd0b85a97d-37cfb8b653amr2215302f8f.23.1727887367102;
        Wed, 02 Oct 2024 09:42:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:33ed:8fde:4d0c:205f? ([2001:8b0:aba:5f3c:33ed:8fde:4d0c:205f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565de3asm14327683f8f.29.2024.10.02.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:42:46 -0700 (PDT)
Message-ID: <15815bbb3b9518dbd9cee9df627e24de74482a17.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake: fetch2: Fix systemd
 template file parsing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: brennan.coslett@bluerivertech.com, bitbake-devel@lists.openembedded.org
Date: Wed, 02 Oct 2024 17:42:45 +0100
In-Reply-To: <6732.1727883773132320625@lists.openembedded.org>
References: 
	<CAAc_J+_bjkedrH1kj2+qHi=OiEnC9TPxCqpZAVSLiqBs7Xsp6g@mail.gmail.com>
	 <6732.1727883773132320625@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 16:42:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16623

On Wed, 2024-10-02 at 08:42 -0700, Brennan Coslett via
lists.openembedded.org wrote:
> Anything more I should do with this if no one has any comments? Do I
> need to convert this to a non-RFC PATCH?
> =C2=A0

It wasn't an easy patch to review without looking at the context of the
file. The decodeurl piece looks ok.

I'm more worried about the encodeurl part and am left wondering what
other character encoding issues we might have there. Special casing %40
seems a bit worrying.

I appreciate the patch solves your immediate problem with that
character but I wonder what other issue remain waiting to catch us out.

Cheers,

Richard

