Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B0BC0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 11:34:45 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.10595.1738150480606698675
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 03:34:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EucFaN2G;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso64684426d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 03:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738150479; x=1738755279; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/megH1iPKatLL6j6dOM0NmgwBIkryLDqkRyNdNS9KY=;
        b=EucFaN2GsmGKxWdCg27UbhvXPkKTu1uaj0bNqqgN38mn8EuXKMKV/Ussx40uOMhUcn
         V7oddbJO8IqtTiXq+CGXLMRrZu8wPPe1KyZ1Oei51rIPQcsvr6DeQD19nxfFucprFZ71
         VqRwCeh66PUZKbHsUR6Q8NaxKIj/GVND0GhU6GeQ2egxHpmrqfUNfq+CWyeX91UBIm11
         k3ZR7vJeiM4CNLkCC5GKJJoKgzWP+xkeQF4RdrJDwmjOr91DWFNFjO1GRlBmOsQIXJ1f
         fjliMI3k5DRfoDgEZIyQYG8+Sjh28oBeYrwKujbvMWe+RTvsZZjRRZzA5v8nS/2VqtKq
         8Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738150479; x=1738755279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/megH1iPKatLL6j6dOM0NmgwBIkryLDqkRyNdNS9KY=;
        b=MvXs66NUopsD7AMSZKvR//TD6pC7+dRzy22NPARTyXuijwpkFbSU/ZRGALY+tmV08a
         VnLHUAfvVxpZqs+y8kYf7nx/V1Km7qDxtG6kBoA7M2M0paxsMWVY9s76J/NL0SqQxUTU
         A5bVw8ipMh0dpaLGKS4wNp62la24PDIIjDzEazpCxvneCB5tWbb5GI3n5IL9UxgPsTWy
         1RmVj6d0m4zaFnvcuYDHVLNTOEODh7KkiOenTFx/WhhdUUxobuZzcrSuu8WEF8RAkNId
         UkeLt7lkxONF3ReWB92M0epdXPBDFiIIsxoOJl9OnHFhsI+pilxRaQkjIAx24r7KGCkZ
         RY5g==
X-Gm-Message-State: AOJu0YwosvNs/HJnl8VizMwuQKqItzT5Vrdxogrt6N2k6v7TKuA2VqT3
	fPHA6yDn8sEl4wMKntItdcSqITGXjbqBLEdAwwOaFhJA7IDquNZoEDIZP6BD2aEJbUp13J5npmQ
	skHz2N45NujmgbuLuRSn8bOznMIc=
X-Gm-Gg: ASbGncvH5sGYPR3B9wUySNQt3XaqVw1PQuAGZ7I+kfQUNt+4Q4QtKEE2wxqYu4wbQiK
	9f9r9P+kJby+Uu0nJZueiZy6gyy8ew7FXHO/jo4XmdKlPoi2wWNwUJ7CqrZeyYqBD5eQt9zejXf
	Re2+9JQiFQ/CJIgK2GKLgaUP23rXnCWy8=
X-Google-Smtp-Source: AGHT+IGAlyCfgLdH1zb6bT8HQBIYbRT1dXgNLn75IBp1NslKWco3XSlRotsn6iSNFgSU/TS5VF1ZcMUS+K7u3W3tjtg=
X-Received: by 2002:a0c:c444:0:b0:6e2:485d:fde6 with SMTP id
 6a1803df08f44-6e2485e02ccmr16618916d6.15.1738150479719; Wed, 29 Jan 2025
 03:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com> <20250129112406.1660522-3-stefan-koch@siemens.com>
In-Reply-To: <20250129112406.1660522-3-stefan-koch@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 29 Jan 2025 12:34:28 +0100
X-Gm-Features: AWEUYZlt1_9RzMytS5NOHRerc9Uw-FuJPM7At5iwojb9K1H0AajVjSdqGM0AjFI
Message-ID: <CANNYZj_N4fK5TrxurZk_2Vro6rgzZSSoqMNGBqC893a6g60Q9Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
To: stefan-koch@siemens.com
Cc: bitbake-devel@lists.openembedded.org, simon.sudler@siemens.com, 
	jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 11:34:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17112

On Wed, 29 Jan 2025 at 12:24, Koch, Stefan via lists.openembedded.org
<stefan-koch=siemens.com@lists.openembedded.org> wrote:
> This adds support for offline builds when tags are used within `SRCREV`.

I'm not sure I understand the use case. Why not just specify commit id
in SRCREV?

We discourage using tags, as they can and do move around, breaking
reproducibility.

Alex

