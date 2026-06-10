Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E7ECD8CB2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 14:11:47 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21306.1781100706076455218
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 07:11:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L70moPKH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bebde89cfd3so873548366b.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781100704; x=1781705504; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aPtlgJSOeSoAL1Zo9lPaQhkuh8EDhnUPlL4uSmCCvlA=;
        b=L70moPKHn3/0zpk2Nh+3uIyKo9UP3cHhrmQhQD7DNg58OTXwxH/DUqfoNIQt55KUZU
         /UNLfFiexVKfOWyy5sk5uWYZlav/HPM0Bq2yPQ79vRu9Kzio4P8cYtl3bjsKqBzYXzTC
         vmSr7hPAdbP53RoKpmZSb0gZxia9FyAXNQ3KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781100704; x=1781705504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPtlgJSOeSoAL1Zo9lPaQhkuh8EDhnUPlL4uSmCCvlA=;
        b=M/4hiRHZBZNW1QidrcqDdltpZOa9crynUgZqTAm14pMb/7Qk/Der7XCkdK3UiixdLg
         PVOnG7mpd7WHqQp9p7rF+ThK9+cQ9VRC+tgWe/+x4hIV1T/oP+a+1tHoeMxvwCAUNLQa
         Th8dGSAlBUImlt8CDj1BJY2tO5SJ5WPFaHnn4+nLWYfMhnrk4SxHK+0dUWwhuqWb+emE
         KkLXJ7p/VsJ5HYsz4qbKtjxUsFav93i+NJr9dzCPYtKLr70Bnw3J5agsUFsfua6Hfznl
         WDXbqJckqGOPUcc6SlN7WQ4Q25f5gscm7OETAOELoGPFkRawh8Slzit+VlVXjqzBzfVk
         547w==
X-Gm-Message-State: AOJu0YzHMpgSlLRMwIrHoqM79lWNocuD3/ssCc3ueLlmlUqDKJjevzOl
	SUlYJVRCM47auKHUh0En7I8dsll6MFtncOrKJLouaRQxBEK0KUYWWrc5P8PfDmEPzuI=
X-Gm-Gg: Acq92OFvLX3aCD/UO5ALynxhsCn9TbauWLIgtwKkxVMEEvVGZA7QoXpCCC1Rb/UbQYD
	L5ezyNNV3RR6Z94Eub58FzwK4bEapINOWwnbVqsNdzlTsvHzbkSKNAo1+H/Q8awt3WOjIQ/xafK
	FikxVAU3+Gad4jsQzsNjRqK64mLN4jZUJBnZrAwdA7gfMqAlGCHZYJJV8GViDVcmmKhg7/U6wn3
	pI01hcxT1EsZJ6djIOlY5KKtUoD7A7bUVeZWmsiBhSqc2Mle7kLLhRzivzh1nVhZ5xMj9cLzFpf
	wVQpc7Bc1KIVSJian854i9JMYp+oYMydwiM1L1VUqGR02oMbi0nlHIy4f1AGLmPkC7CsB7Awb6l
	L7eMW/AMd6awVD4ewoEm5cGvKII8FkUo82QZ0cKQyZqRfTdgbqv0KdCzCaTlivjkRFOfxVeXF/D
	Q1eC3BlToAf1aOQ2nRdrTqWG9hlzypUV1F8NVZWvUj2ODTsNXpLdw5nufbi+uHVh0w0qOQct3eY
	c0uuKzeVyqeq9EHg9H1r09F
X-Received: by 2002:a17:907:96a2:b0:bec:ab0c:243c with SMTP id a640c23a62f3a-bf370f5afa4mr1396972066b.21.1781100704245;
        Wed, 10 Jun 2026 07:11:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e996:5a7:2609:813f? ([2001:8b0:aba:5f3c:e996:5a7:2609:813f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1aaasm1190584566b.59.2026.06.10.07.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:11:43 -0700 (PDT)
Message-ID: <1971a10419fb289fdca2c0bd82d19998467c4cc0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch2/wget: limit auth headers on
 checkstatus redirects
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, anders.heimer@est.tech
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2026 15:11:42 +0100
In-Reply-To: <CANNYZj-=MA6L1w8_zOEngOZqHDqmbuuz74v9Fy=pgxr1D+Vs9A@mail.gmail.com>
References: <20260610074013.558709-1-anders.heimer@est.tech>
	 <CANNYZj-=MA6L1w8_zOEngOZqHDqmbuuz74v9Fy=pgxr1D+Vs9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 14:11:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19642

On Wed, 2026-06-10 at 09:54 +0200, Alexander Kanavin via
lists.openembedded.org wrote:
> Unusually, this was rapidly merged to master almost immediately after
> the patches were posted. Is this a sensitive security issue, or what
> is the rationale?

I did actually mean to merge it to master-next, test, then merge to
master in a bit but there is a security issue in there unfortunately
:(.=C2=A0

Basically we could lead auth headers to the wrong servers.

Cheers,

Richard


