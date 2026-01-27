Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFAFD2D8FB
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:50:18 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8031.1769511017911781229
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:50:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YdI/4K2I;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a288811a4so79082406d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 02:50:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511017; cv=none;
        d=google.com; s=arc-20240605;
        b=Usaxq0VQCAJWFD2Mm/HtqO2NaT0IHlQpqQVxMNCiHcIZWojPPZcMwnX8VFgEBGlJG8
         VVm07Gl5nrnfD2FgClxIy2VfibJlS9qE3AcPivNX5SshvLfiuhF0MNEl0mp90eOHp9t6
         4Rno7y9cHXA/Zm9/qLTlU2A+tfW0bj/BRoGg3xZkHRPN/qkRPKj8hBMAygQ/Z4kev8MB
         h92m/pzJa2ydU40prAQxIxrD1zb9jeFGQBaR1bszDIHGa/NPj2jTWf6FldmQNq4dRAZ2
         Q8CY6E9rbq6dhCdWY4HLK12CEkJI15cGNQfySD25yOkfHY3Yz+2XkOkC7OrTItHmvKlD
         Bzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IO2wfGzQCjUd+XEsY9JwDYHRPGLkCN0Yc45qk4bQrTo=;
        fh=VlND7hnPTiS9DZ1gdmdGd5ealKp0uI/PGhF93jUIc7A=;
        b=Pagxb6c4hFT4RGiFsNcQCireXvDlP88oIn9xqByeWYTCZGhaeFu00GwimABedo8p8f
         AUTP/my8cgdFYSclLpH3BcjmPX/wulP3NeSO2MfloVWjEjfZrLraYslrLbUqcIff7tUG
         bWpMu5zkfhFhyFnjeKyvOzjv/YVP26toz/FIsMkiVKiWDSQDxlFyZUG9yEDo6+vmVnrB
         n3RS2arcbdKiQ+//eZPamJmkm6Keps/7VZIYh6/Pv4YyOoZMKhRyjdDN2UOs70w/kzDB
         Hl3swZUeXojU4h4GWTqQ8+UnQArJKEiNkoMTewmT3O4OK3KeukdM27sxvJuchpzOHrnO
         /O3Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769511017; x=1770115817; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IO2wfGzQCjUd+XEsY9JwDYHRPGLkCN0Yc45qk4bQrTo=;
        b=YdI/4K2IxawMU9e2hkrJ9QR26Nt/QoNKAjSRCJECRp/2EqbiRbU83WbTqTtLCpWaft
         X9lVGUpINWA6o5I05hMpaMLkPjo6jXxF7Lb2UYkRW8cmW8LPLi7td4m+ElBYCGInYXS3
         u/aTZVIZCm6NnG7gMC1YviS8uHxkndXTfBuAlZ5cP1pQHtWEsPbl58gheJpSrsmqEZT7
         A9ezTFLYM0l4V8CtOVRBxIYY4udci8Cu+nK7kXTe5QqML3L6GTgVszMk0JZsczc0vaSA
         eEvHPKfKKvZbEObCjAmjUfm5nh/dsIDnUntYonO/4etA9adE/i2pz5tX+kKChUPmdMx8
         CRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511017; x=1770115817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO2wfGzQCjUd+XEsY9JwDYHRPGLkCN0Yc45qk4bQrTo=;
        b=vG6GaqTTH8deOBcMRxU1+9bqkuRJ8i5B+d3pZveLbO97tQtqu+XNxsaoZ0/0cmUtaj
         d4Gn84dXaTa3BNyEdQqO1DSv2gkdlgCn5OZUyfSdI9iNwHByKNPYls10AaqsZSGAXas0
         mkBAZV7CMhQzHFb0BOdzLJy/vyFewkHxsMdybrXIK0GfX7j9JHhTUwgaarILa1WzuZ/7
         vU65jVRrbP1czzYmEi+bnNLM1XUoQrQSTw4eKbNRt5b4hMYwEpPJWvwv/kNhA6hw2L6j
         sSCiOnwhI4SwtsVJ1DMlEkkXIBbCDRX0RetwyW3f5ynM4UlATR2TF0uYWI0ZLz1kUvOu
         x9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX4lNVoWOKd7S1edP0lF5DVKYLKEEyOeeDxSD80KGVHIZHVIGYlNk6beqnNZ2/cxd+D9nL54Pqc4xaPfm8n@lists.openembedded.org
X-Gm-Message-State: AOJu0YxAWeQzNWSwPAUiTzz6WGGK5kTN8zcU0qsmM/W9YszEI8Xeq7/l
	HZ4KTdDt8gHD4r0AqyZpSOmLav54Id1FTnsql8yMDz1pR5A9HMKmmO7V2zGbURv5B0WApwRczDT
	HuOdnexXl3LjmPLO/b0yP9W4ASGDee8U=
X-Gm-Gg: AZuq6aJbZ/QD/fat/Tgqso3p61ehDqcRkTAePrzXyI30S1ckwQ9wW6heZjEHiTvHyNF
	NuKD2Bb2opaZsmDn+MT4CuW8rrkZhWfnjtdSkn9Qwfsp7Q4H+k9uzrDZdkhiyxhj+z4JXlzn7Wc
	N/Jt2hCZvXGkoH+FCQA0Wh/av7uSOLw15Ko2leUKyGmo3klnJEO4WUp/NnqgsdK59I/XKFpmkTF
	lJpQZlGAeGZaLuHpYvsKm0njM19Gt1rXkO1FZlIBGeCMAWCQ1kn11DHmcyc4izZ8i7shdKYx4DA
	HVV2wt2kAX1hfyvJ6HS2fXxyWqNduQ==
X-Received: by 2002:a05:6214:23cd:b0:894:3cb5:2ed9 with SMTP id
 6a1803df08f44-894cc7b9cf8mr14829916d6.14.1769511016825; Tue, 27 Jan 2026
 02:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-5-daiane.angolini@foundries.io> <DFZAULAJWR0S.1RQ0LXOE4BSUR@bootlin.com>
In-Reply-To: <DFZAULAJWR0S.1RQ0LXOE4BSUR@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 27 Jan 2026 11:50:06 +0100
X-Gm-Features: AZwV_Qjrte7R68dz6zv2IKQ0Bb3tjZBb04BwVQu6m76ZrxkhBd11e1etTVZvFks
Message-ID: <CANNYZj_Y1JiRoXK3iW2mwe1Cvga95icXtx3FzByfBzRs4upMuQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs][PATCH 5/5] docs: Fix sources as required
To: antonin.godard@bootlin.com
Cc: daiane.angolini@foundries.io, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:50:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18886

On Tue, 27 Jan 2026 at 11:28, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> > +   under ``layers/`` directory of a :term:`Setup`. Although the list of sources
> > +   can be very flexible, at least BitBake should be cloned to generate a
> > +   :term:`Setup`.

Not necessarily. It's an esoteric example, but one could write a list
of sources without bitbake in it, and leave 'configurations' empty. In
this case bitbake-setup will clone/unpack the sources and stop there.

Alex

