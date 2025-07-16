Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA2C83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 08:47:54 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.17648.1752655666311089096
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 01:47:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dGxpXv9A;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-701046cfeefso94180066d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752655665; x=1753260465; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LzB9931l0MtYYQpaXWGYwCWaMfDkcoznvK9p8f5txRs=;
        b=dGxpXv9AQ9C33nUkRRc6kydGcOFH3s+/pqp4Qptv+9n8CN9n2vbJH3ExXtiBMwjZJN
         krDVwfqxU5Rlsqq7nQb8aSkU1NdQdWlMowzeuBxuJ/VlFYHf0vtQqQGEeYam8oLhX4Xf
         tgm7ZHF8u12vHnMf8ZBkWhR1YUjjH/Hf2yYrgPZtTiWOA8nl7Hps+4rq3PLI0c7N2oYx
         EoHrje7Ll2WrmHTlq0J9PV1FvIb7NfXsyDRCxtamqzFeFlOBICYQnNeLi4fhwdsVYjlS
         6fzLPRA9PojNIZ29sKcWMqYaoURRViA/7H1OPBe35q/d59GbGMAKjQX3xRvcTRzqBScs
         ZBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655665; x=1753260465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzB9931l0MtYYQpaXWGYwCWaMfDkcoznvK9p8f5txRs=;
        b=QqCYj48USHvyJTMm2EWJrIBQhX+ktZbtm6cnZOgOZWYOGf59JV3hyMiRb+D6AM7AnU
         wsMsMpjBf5gdABH3AEhc+WVgxF2qMxqRJDrvgdcokEgScAD5lfzQqb+P/NzmNJg0fIIc
         NlHivJw1lK1ZKRDkqNN9rbhn2h/cdxv6vlTllNZvIeTCs+N+9odpzZ06zvQMX9K3Lwn1
         o8BpDnkDbFr+9p+eUkV/4rtnvBro7cKLZyFO4KqgzBekGqNgjYQyX8GLe93VL0ItacKW
         9FS4d2qqcfjn58aM90UKzlNvlKqKMj8mMmWaD9RxbiD3d8SFmPqP0EELVazpm0nFkAP4
         dB8A==
X-Forwarded-Encrypted: i=1; AJvYcCUdG+vf0H73TCUDRLBDWiBge9XfrtNh2rx/q4aDlmpsCtBePJ5nCCA6ENinbIQ1Gq8wk1B/E8diVEVYaQCM@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy1QC/ObzX2rRiA6qDMO73z6dUqmtlnZ6k78bLMz1wKO7vMBpbG
	MjJp984jxGvqEZ+7MFKYhDzjJF2n7qehzfYYcrbvi+pcTd/fqhmAMdTF2kf1MEw89eM1Qd9sNyV
	H9lFdLxd2D62MnAnmlSyKwnSjnE1bGQI=
X-Gm-Gg: ASbGncuVq7r/qyXpR6w4zWk2MMxnn+DRd1N3FSfAJh4JleJFDbkm9ujSrOVloCC0gyr
	30My6EWpWQMJVyOs1ZbCNyLeCs2otL/vbxXwH8A5MYhJweTXiAcfuJlYyVKCSmlX2rGSk5LuG+9
	dJxLlzd1n/AkRObz6rHZOnlkswEvbeCJnU9CzglYVnlfDf6BnKmsK07MLpZAa725bo4IrrEC6NR
	7rW3F00HIH5kSe8LRT2QloW1S00+PWw4SxcXIBH
X-Google-Smtp-Source: AGHT+IGIlIRtHx+hRWjxKfKbofMleu5mZZRnyoGXQ76eEAdwsVeLd2v7F+Fb2DwQXkRPcy5/gi6ujm0jooRuuZhLJW0=
X-Received: by 2002:a05:6214:4986:b0:6fa:b03f:8a39 with SMTP id
 6a1803df08f44-704f4b006fbmr43910616d6.35.1752655665271; Wed, 16 Jul 2025
 01:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250708124711.3541367-1-martin.jansa@gmail.com>
 <CANNYZj8zpTF-hs2inMOcJ0mJnYKCijgD0VopeP4-_F0NM6rG1g@mail.gmail.com>
 <CA+chaQfrXL8dcSMvprRGUC-X5BGsTBCQyoYQKdoD1q0-K5EGVw@mail.gmail.com> <1852AE7F6903B1B1.8991@lists.openembedded.org>
In-Reply-To: <1852AE7F6903B1B1.8991@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 16 Jul 2025 10:47:34 +0200
X-Gm-Features: Ac12FXyf_5O1yybcab3qBi2AYlqT_7EXG25W800W5FB5TBVfXBUjlW3xp21ss5Y
Message-ID: <CANNYZj-+nr5mNDWYAmkZ61Q0RSQXd4EsMY=QfA3opo7bKSONJQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: zstd: use --force to allow
 decompressing symlinks
To: alex.kanavin@gmail.com
Cc: Martin Jansa <martin.jansa@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:47:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17777

On Wed, 16 Jul 2025 at 10:37, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> That's not what I said. I said we should seek a better solution than this.
>
> A patch to add --follow-symlinks, submitted upstream to zstd, would be
> much better received. Or some way to avoid having symlinks in the
> first place.

I mean, we could also resolve the symlink before giving it to zstd,
right? Trivially done in python.

Alex

