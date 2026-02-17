Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46534E68164
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 10:18:55 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9001.1771323534045924182
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 02:18:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ManbzEUD;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89505dd3e24so56647636d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 02:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771323533; cv=none;
        d=google.com; s=arc-20240605;
        b=VzssJbm1mt0pes/tCd4nWNpg8OMU4EVA8ZcxlFu7emXMccrQiJSQPtuuD7tRfi+0Dc
         Ge0250CF1ZrbQLWlQRmM2G0FibG6ufWayq+RUzsqAmpZwRrPpxbWPxj4OvV5do3TF79f
         AnZVMNHer0o5BLrhPu8cyhXUsJrBNvwFffb3AhVgEZRqFEYonttY0D+WcZRTU3n5yMLF
         VR5nuZTG9u8K+XuXSur3XvYrACag77ReyJ3wtgFnLhzcm8Qf4uiZuwRc32Er+LcPWXJa
         FHXNum3WUITwGCItWOw2Z+5vGw1ERlXnwlwidlcG3QYVvxE+uKY1mtBsfWsqt/95sGfh
         yozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A2kdcFxt+hJGkqiB13chOVBwoaFsVlU5TOo481UzQug=;
        fh=UJkoOGbn+U5q9XkTPsz9HbukLwUOOXfVEaqD2z76Yx4=;
        b=Jbclo/olCDkjROYIi4ivRb1+u21E8TLg/Rr1tQSdY6SiXSRVPHp+Zo8aaO7/B2rhLK
         dBB3MjKubvspTrz6msCO3014S2oXd8k4JkQe84+iJwThs1FHcD4Q47iuNVFc5M5QdZ9+
         1jlvdFme16mvVjkHhoxQ2CD3VLebtalfJPnXPH1SV5foWcXkrgHrXaLqEDTsU9QwA0nc
         gGqKz0CrkbdCteU3XKKi3Ss58HYoNnTzX6FTc67pSlwUeZNUeuF/9pmnpF1y0vvZMk5j
         ipoF+z0q0bEUe/kwdFGIXIl4LdK80p+0PkJmfdTFlsjHhtXSY4rtEQ0HRv1wl7jz0DAl
         yaMw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771323533; x=1771928333; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A2kdcFxt+hJGkqiB13chOVBwoaFsVlU5TOo481UzQug=;
        b=ManbzEUDYtbnboJGAItRFdkTuIaRv1Tf8fqNGqfcySbPpCte1h0st46opegOsOJL8b
         wFiurb4sUSFiKelcsZ0F6qDWVqg5zrk4zTLk0NODBPGVCtAi2ShkAbh/SYYe8u0jyicD
         tsJ+mGSt0W7ITeIT6w7Fa2H+lFHqg4f7rN40SQJVRuTp00mvpVatM1czmMzBjNw4YC19
         DRfRUgafLrsQ8EORm/HECWJoh+BkPcqpqJBiOF9RsyBakQFMF/H8TT7ZMG69AMLlGncV
         VcF1UFbraccZp8WwAyVr2C4XQZqHh6xa9TKY5I+5qBwoZBBK3zf58agBg3KE7+g9KaJy
         IOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771323533; x=1771928333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2kdcFxt+hJGkqiB13chOVBwoaFsVlU5TOo481UzQug=;
        b=vsdyyKWaBZK+kAukpZ8QCg6ZWs/SyD15wvL4aOTdyz6Wv3m/lxish9ArudaX66tuah
         f2KDNZtS7aCwkYs7Lip8siRqWYZcwnDCqacAqhHW3eknDvsA5A6bH4vv0Sq+AvUqVCO8
         kupvzw6W5xeeep2jk5Jzz6N4dpEq999E8yeFqcSU9q6MJVPzNbZ0KtvVO8ay4lf7VBAH
         jz6oALPNK45JKCOLQpl8P6a8mIov/XGhDM3zRwsG6Gx+Vw4NSc0vk1t3kSwtx8lLZF/7
         A1tyUx3Y27lJ0kU6vU8hfFbCyB0AKpq1wfAhXqTgGSpR0HkzMKK18cCeYLXhLRZOi6A+
         Uy0g==
X-Gm-Message-State: AOJu0Yx9qf+9BTQlJGLSA3v9Wmode3BcdgoyaX2KMsqSbDTZACi05i0M
	JWIHhs0IDnGhnfe8Ko6Z/OPWBW2wGtm50XzwWPM6murCCl5+RO/1bgy6lkalHFKl96ijdX3h6AA
	rz6V+tPhUVgcRDtfq0lizV4U3Xm4UL4E=
X-Gm-Gg: AZuq6aKm8+RadCBb/ei75wupoLxt+UEaN1zp27A392xDCIoC+uyDKWp45pVbNWaMJgB
	ixNkJ4ExJK/Cy593S87BCYDZqM7QB/gy6/vzvWnvYRr/kZN7j1Ch8r7bm0wSjDHjBQgq7LpkJOH
	VglIp0jN837nGKQRCnZnS93FCrSOu9DsKYMY+8WoqhxNqAW8maPl3fX5JdL+R3bT2iQ0LCYopBo
	X0Jk+oPpKegh5OVVQc/dsp40AmHPGezzl+r2GjlKnus3yz8VZM/G2Dn3FW0morSVqJuqr5Z5goF
	MWOYeg/8/sQOmAK6Jl4VaFhw7oQEiSrcOhIThujxng==
X-Received: by 2002:ad4:5c4b:0:b0:88a:57db:8e04 with SMTP id
 6a1803df08f44-8973606edfemr150795576d6.8.1771323532919; Tue, 17 Feb 2026
 02:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
 <20260213-improve-bbsetup-readability-v1-3-41cec3b06992@bootlin.com>
 <1894D252853C99A9.200918@lists.openembedded.org> <CANNYZj94DXwkDaucq4Du2Pnvv+PD084SmHU+URb6djKFuUf4Pg@mail.gmail.com>
 <DGH4W65QBJ7Q.3NRH3Z4SBANMN@bootlin.com>
In-Reply-To: <DGH4W65QBJ7Q.3NRH3Z4SBANMN@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 17 Feb 2026 11:18:41 +0100
X-Gm-Features: AaiRm52W_AX1ypnFq07EPVwRKE2qzWlV45ZqvYalvD6JRjoGnDFaPXEwYhqBz1s
Message-ID: <CANNYZj-Ta+QKHXpzCyPS0eLOX6irVadGGEO1T7RJSTeAKGzpvA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/4] bitbake-setup: print plain messages
 in quiet mode
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 10:18:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19047

On Tue, 17 Feb 2026 at 10:36, Antonin Godard <antonin.godard@bootlin.com> wrote:

> Actually, when I was testing things I was in interactive mode. Previously,
> passing --quiet in interactive mode would just leave you with nothing printed
> on the console (only warning and errors), which is strange for an interactive
> progem. However I forgot than in non-interactive mode you may want that to
> happen (nothing printed).
>
> So maybe, we should look at the --non-interactive option value and print nothing
> (i.e. leave the current state, only warnings and errors are printed) when True,
> but raise the loglevel to have at least PLAIN messages when True? Or give the
> user a warning that running the init command shouldn't be run with --quiet?

I'd suggest that we start with setting clear criteria for using
various printing/logging levels:

- any interactive selections and prompts should be using
logger.verbnote (which is higher level than plain or info, but isn't a
warning).
- regular messages right now are using a mix of plain and info -
what's the difference and criteria for picking one or the other?
Should they be unified, or do we still need to use both?

Then, modes could be defined like this: quiet mode prints only
verbnote and higher. Regular mode prints info and higher. Debug mode
prints debug and higher.

One possibility with modes is to actually remove --quiet altogether -
is there really a use case for it? Bitbake-setup doesn't flood the
console, and what it prints can be useful in finding out what went
wrong, in addition to the actual error.

Alex

