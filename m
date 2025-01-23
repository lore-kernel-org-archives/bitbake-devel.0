Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BB0C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 17:26:02 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web10.16430.1737653161773766813
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 09:26:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OA9kDLGx;
 spf=pass (domain: gmail.com, ip: 209.85.219.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5447fae695so2131739276.2;
        Thu, 23 Jan 2025 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737653161; x=1738257961; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBBBS4Cfp2fIg5tXmOz2nZGRj8QOp9SHDDmasUjmU8k=;
        b=OA9kDLGxgVAoN4TlZ6N88deZ3gM4Mw8Kv3mz+Z8vqJwx4FiLeUNv34rprwc+9i3G/n
         Nsr+7NVGmrvujgjWlrAt/jFrJVrbTEZ1c0yzbCuETm1u+JbRt3H9uiplR66y8ceOSyMn
         Y1wp6wLcrnpd4UHb6eq1AgXpz7jx4GvdBIOIi4TKBPm4mETTSFXHklPXpbS02447xqUv
         l8kcbnTCHfQxb/WqsfZ/Anwa0mPUwKO/7vJk7Wr6ajpHa06MkJ7lzkqtTJc4lON3O/2I
         BFzeUwt8/B4FUofiWK/NI3VF+zGZlG8orezA3DB7WCXBQWkakaOwkXl4JQEbVhIeGZsa
         gTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653161; x=1738257961;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBBBS4Cfp2fIg5tXmOz2nZGRj8QOp9SHDDmasUjmU8k=;
        b=YNDteZ74piYW+NWQlgsjADsVqAkvER74qymiZ2XW9D0s6YpAfhowA5RsbL/ejtHMgT
         7NUjmuvQBJ0h+3EKPfUlVUKJF4DN2OVOu0CkXlCzI7QRFHoiL2kts8d/bkMt5FxtOlYN
         oRj22TFKVDG8WKkRvSr6lG9FabtK5TfxLnQzDO+qLVK0p8F0O0IoCyJOgwGJpf6Z+tFh
         1ZET5GannJrSKm88o3pVAKD9qzM/XZFH9zLHY9gaK56S9JVbcA1AogfZPD1r139Pl9KW
         iSoY7IrHV1FG976hEdJIqYYCTts6nRnLMCpm3qC/ok0b+DMNiHVgrVOS6fBFqTtTAPBS
         PSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoWZHx7wQDGbdnWW9jAk19YxRJ+wQubjL0hTwd7C/obsayeE9UP2XCmUTmIY1JLK5Y2Jl+vWZnfX+dlVGt8rOlg5kZ3YSaWDI0@lists.openembedded.org
X-Gm-Message-State: AOJu0YwMqrvNMe4sr0uA6vReiRaj+wK1PZbk1xUgNz+SpSbhtFPBLx9o
	2AnThqQn4FVRzpt4t0sbSjDEMJBx2fXDghftAkdbQ8VDhkjx+aMn/Vu7B9R5zXRWmibN2FQpFmf
	IrYRmqo8QOdbqr861U2fLjdMqfSU3MQ==
X-Gm-Gg: ASbGncu9QiZaTL1RWtck9eoc9/Jqry7sB0XrPsjKFGiX/n28RiE96CH38EoJOlxXEvL
	z3MO6Io3S39ZkJsCdcDgPDAYFKjgvKSMGoqPtFAExZGMtGEVb22wDJ6Z7AFJQ
X-Google-Smtp-Source: AGHT+IEztwtzhDAlesjwmSZ3f48AvBW3DslfAlg7+6wu6RNqXJ0fhglv7NcrCtSXi7erLW2mCAbT35ACQ3lihJ9ef+k=
X-Received: by 2002:a25:d010:0:b0:e58:9dd:fc1f with SMTP id
 3f1490d57ef6-e5809ddfdc8mr6671091276.11.1737653160866; Thu, 23 Jan 2025
 09:26:00 -0800 (PST)
MIME-Version: 1.0
References: <181B8041053EB73B.1562@lists.openembedded.org> <CANNYZj9StZ26LENRbN=Z6mdFhOXsgN_Uf3hMqwL7NXn67Fibpw@mail.gmail.com>
In-Reply-To: <CANNYZj9StZ26LENRbN=Z6mdFhOXsgN_Uf3hMqwL7NXn67Fibpw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 23 Jan 2025 18:25:49 +0100
X-Gm-Features: AbW1kvaGt8fCuIWwPpMO5za-Qm6HV4o5ZcPTCVEYdQfnwDqKhjYPr5nvjkM--Dc
Message-ID: <CANNYZj8SA68ce35NCbwXdFuGKZBoK5sQ9GLC8NoaSJ4LPdKNgA@mail.gmail.com>
Subject: Re: Terminology for bitbake-setup
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 17:26:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17070

On Thu, 23 Jan 2025 at 18:12, Alexander Kanavin <alex.kanavin@gmail.com> wrote:
> - 'top directory' means the place under which bitbake-setup reads and
> writes everything. It makes a promise to not touch anything outside of
> that, unless otherwise directed to by entries in settings (currently
> there is one such setting for fetcher downloads for layers and config
> registries). Top directory can be selected by a command line option,
> or otherwise assumed to be ~/bitbake-builds/

Of course I managed to forget something :) If BBPATH is in environment
(e.g. we are in a bitbake environment), then the top directory is
deduced from that and doesn't need to be specified by hand. I need to
check that bitbake-setup gracefully handles the situation when BBPATH
is present, but the bitbake build is a 'legacy' one that is not inside
a bitbake-setup-made build tree.

Alex

