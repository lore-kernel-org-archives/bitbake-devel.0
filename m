Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC680D2D8F4
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:38:58 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7601.1769510329320778891
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:38:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Nw9XiKQE;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a3d2f3299so59531906d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 02:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769510328; cv=none;
        d=google.com; s=arc-20240605;
        b=D56WXk54AIk0GrMrls70yTJQQ1JKV+SKXMB+2TLm4II9GbHz4ZgB/J2PZVxLXKfhic
         Nyp6+MAkDizBUtuRHAnDlEVnUt3ZgKzn+OckBYX03C7CW/TNg8Plz1SxUfAao0qARHRc
         XCb3KtAv7XZ8cr700cajphDqDaIcDnvqcneo9luMRl61Xgiq+DnZCmh4De1TpFXktle2
         xzHH42v6SzLwfLykANms0TMq+4i8xUDw2ofzhOfHLoU4T2BwdhaB/hiJEW4o86nPbvyH
         dGmhKBUnY8Bz4t+wRu2MvnUwEDEXaj5XwlQgkqPc0WSoqUo7LlC8gKA2sdtfe/cFh7F8
         od5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4v4eSQ8jgTzNdM3sbXh8YrUEq+2TIvFlzsH+VpZCLXc=;
        fh=umA1a24LPGx/1pgYgyDscyd4c4a8k8kCCBoGTYGy/ac=;
        b=QhRj9Li+KP00AWfBxSojbOjPR1lm6inYoh1uEJ9Mij5h/N3Cloq9KQhDcOHTX2xYWC
         MinB3sjzT8z6bb1ZmVMKEtt5AIbV1uTFdwhSomhq1BRN2cnS2r/taMtpXUwTxBOvYMm5
         JEgBDlADRd2gNqK+l+BWhtY7muUCJBAxiF9tkSQl9RgtNhsYLH4+T92R97M3mK3EDusj
         O6j+f6niW2xqQFgx7v9lI58el03z3q2OyqsaGfa3k9JWdCSA8JG3BhJL4VwsECD/HxqY
         ItZTGgCnDCCESPdbob0AU76KKeassOqc8oc/NIwkbw7/WpUfZTIHloJzg8YNB+WnqWN5
         jfgQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510328; x=1770115128; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4v4eSQ8jgTzNdM3sbXh8YrUEq+2TIvFlzsH+VpZCLXc=;
        b=Nw9XiKQEsBV5YkTR6x6j2Jv8TrhaJBgy66rlbP1xJYi9iKW5rkcgSuIZML8eavJuCx
         BjQfU846NWk0Oov8nRqjLhCloV7pAV/raIgVv0Nr1kotzTG0X0FV96tTtIDH0r9Vnyf4
         FV+fFQeGLfaYY3Rgi3rKl+d3nPYbTrwLMMEXAy1B13/GkC8uhgYDQ2kYZkA+3ruUX/np
         cKcsz8rf1As8ZwnJWC/7j5gH7Ise5HC0kBFyhhucOrb4fXCALwLvS5lVKwRwLH7OUYsU
         O+KhHauP++7vaO67kFhTJRlnhpCbYIHjkx6JpbyFZiDd56pSvaa3QJBDS1amUiATuvMU
         1yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510328; x=1770115128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v4eSQ8jgTzNdM3sbXh8YrUEq+2TIvFlzsH+VpZCLXc=;
        b=anAO7YGovg+DNmYgEHWbd+0JlE5pKVLnmSkXypZsLUxuH9mpWsVQVr2pL1pG/Yvko5
         ItKyv6vyy2NeBSgFs2AHjemrZuBsaX4/YLf21+ycFNJzMYOJuzSXzEIfd/FiwDyA5L7s
         GhwVsqB2UsBu4sweRFqCj5So3SJq+0IGLFUDilbMB8lr+hbAOY98ZMuyeDlq+uQL0X88
         myQ12KotAct4Lk9nto1l/5a8onSjkFY3vfGEVw2OKvITQ7TrxepzX3X1sSI2bFqhxssP
         gWIBJgC2ZxxxkGgdfx8D36sqjqVnQ0T5NH5wiia1Yw/LBohU9oX+J/TmWY7PYucwSnT7
         iqbw==
X-Forwarded-Encrypted: i=1; AJvYcCVlS8wEJOeKwfAjsMgOOCB1pOO6XZID9W0yqFWURLga8SSv/J8QH/Y587x5TVwsUCId+4T1gPETV68MEiI8@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw5JNUiC41fAN+XLzkrHbQHTMbhZm+trARvQcqoB1JFEqzUpS/G
	J69w5jKgBznqOxrIBjKNF+5pA5sUKk9vIfGKMmrXnjpOH+6/LsfiUszbcrG4O3FWCm328FssJEX
	sdBuRIdFvmtbYwqdBM5KR+woAQg9IonY=
X-Gm-Gg: AZuq6aJ9x86gM7roAhBJzraHxykjpsf/2IpvZOOpztBllUgnIUJoJu+c7hj6p/wkLIS
	jQQX/8ZYmOq5BYBS43fIt1aneLuOGkYVf1jBwIun8vIzYJyvXYlzR5Xs1G0BKKffgdODtaI5+Zb
	rDPaPGo8L4nEf9C431uh+2MHW5eTWHIZskKqfoCZhqyAo+ttvTRV6LrCDtOofHQ0RJK50DXUZYe
	Y+kb8+RXb5+L3IDSLBnHkz1kwTMDA5ll82aBRjUF5fTtsQYbjjUk9qTC5Layoesj4QU9iBoEjgB
	rF8hTlDcwMWY8pmpE2K3QCDpjySCxQ==
X-Received: by 2002:ad4:5f8a:0:b0:88a:525a:8db8 with SMTP id
 6a1803df08f44-894cc8fdb0fmr14037396d6.35.1769510328192; Tue, 27 Jan 2026
 02:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-2-daiane.angolini@foundries.io> <DFZAUTK11Y5A.1PPDDZRLH02PU@bootlin.com>
In-Reply-To: <DFZAUTK11Y5A.1PPDDZRLH02PU@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 11:38:37 +0100
X-Gm-Features: AZwV_Qh9wDAh7ZfkBuP_MVSxUgfx_u2EDJp2g2Upfs4EyoJabjIAqLHSjjZVZFQ
Message-ID: <CANNYZj_DhwvpzBcG0Vi7E9aYqx7b30uDUxJFkmdE686f1+Zkog@mail.gmail.com>
Subject: Re: [docs][PATCH 2/5] bitbake-setup: Change the output to match the
 terminology in the docs
To: antonin.godard@bootlin.com
Cc: daiane.angolini@foundries.io, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:38:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18883

On Tue, 27 Jan 2026 at 11:29, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> > -    logger.plain("\nAvailable bitbake configurations:")
> > +    logger.plain("\nAvailable Variants:")

To be honest, I am no longer sure introducing 'variants' as a term is
an improvement. Someone well familiar with the terms will get it,
someone running the tool for the first time will be baffled. 'bitbake
confugurations' is more familiar and straightforward.

Alex

