Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C44CD3420
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 16:18:39 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1249.1762964316556451442
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 08:18:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VYoaI6tD;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88059c28da1so9220796d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762964315; x=1763569115; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T2mS3nilELRvWZfofXOr6cK1cO8giEkkmfLfsgiqDLI=;
        b=VYoaI6tDRNkz6267GTZ2vUOFutSJwh9CKUFMU08kaxAizfO1pXy60XmQkoVHT0zFln
         RVAR0fMPNMhzVNnCSjsWa5JFfjBcpwuPVKHDztxCQT4KSct6OtjPm7D+L3U1V1K/2AeZ
         72sbEUzp9qRCmsmW4+ggfAkeJamcBCb5GpQ4daGZh88EHNvn8zPEZ09F9JjMW1G0Ucse
         zjK9sssm0e6GOa7aD4gQbar0wSt0hkS/Mjet3z1XjGhAOWd2Zg+zdi/UOuc2QmksgZ6Q
         3z3+i5vnKflkwT9bj0EocCe2RLBKeJHJLaZPopyv7KFG6URzWQxkHLgS3p19vtkZ18FM
         c+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964315; x=1763569115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2mS3nilELRvWZfofXOr6cK1cO8giEkkmfLfsgiqDLI=;
        b=kxsCcpKtTZvXun3ZhirYo2DHdU5NtUjEabpaQII2eac9AmdYkto6NwPS9+AanYUSyC
         BOgDTGkyUdxAEb7N54IJIfRdOpUCwtRJ1CfTmI+T6CKZyeFyvAuYkiqYsiJiAgFGFl/N
         n0aos3jQczmQPE4ATd6i+zn/qpIBldKYL3SzuxobyOljPNDCKQ6Q9F3F3V0eunE9tcN4
         1o8cuP3nnJPetnryyjENfbVOuGTDDHnHg+047+0FX3QzZIsRb1qfH+WXC488q5HwLm67
         KowmxYzj6uFZBjkPsPyvLK0yGK6eDoiwcrQLWUOPA0E+ojLqmGCPAbC+iEeV3lzJT/k1
         RZ7g==
X-Gm-Message-State: AOJu0YwlxV1poH/R+vplw7fUewDvHcxJc31yXqVFRIo8AmCqIoq5Ese9
	yabI/sE3AweTLdBNOkPrGqA5iIrHM4wTG8zajdT3s+vY5DyNN3yJ3OUMYcmUkPFBzR9pKWMvO+L
	ARbx2T6Wo3EAd00OK4p/rkRVSDxl5zk0=
X-Gm-Gg: ASbGncsg3UqJWQI79ohM2pYOmkGmxXifJlpZ3ieBuz60kCHU0m8Vnm9uFlSyVUfr0ov
	9YmousPe3Z0wgai5gURum1yCJgr7bPRTOzNThjcdzV6+hjK47KGPOgk3S9uzOP4kSIMUqNRilRw
	iLXi5cJCJV05QZi/Bgy2reR6+5x8Prny4CqBufkALIj8s078Z+FA0hmK4IbJE/llw7NEerhpwUt
	R6B9wyE6GtZix2M/wgd3t0Cgk0GASNcGipP+Y8MeV+u1TL7Qvp0D1u3nBg=
X-Google-Smtp-Source: AGHT+IGztLdQt8Tr7iLwZTlyf9sbQPIUvpiYsjPco4lZdWuA/8VVlO+cQjLqJShzSWnZIHhBlblxwSsgB2K2X8vj8Pg=
X-Received: by 2002:a0c:f119:0:b0:882:762c:6b84 with SMTP id
 6a1803df08f44-882762c735amr24999136d6.35.1762964315530; Wed, 12 Nov 2025
 08:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20251112154121.3750738-1-JPEWhacker@gmail.com>
In-Reply-To: <20251112154121.3750738-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Nov 2025 17:18:25 +0100
X-Gm-Features: AWmQ_bmQeVSgnL8yKsLdrRdQbvwALWzyAh3omJz12SYoWuIwZWj2r1WZV5KG7eM
Message-ID: <CANNYZj_4xCdBiMmEpfsW9myGA1G3ZMa2iC2B1rM01nv2mkQvXQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake-setup: Set DL_DIR and
 SSTATE_DIR in default site.conf
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 16:18:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18360

On Wed, 12 Nov 2025 at 16:41, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
> +                    DL_DIR = "{dl_dir}"

This I agree with.

> +                    SSTATE_DIR = "{top_dir}/sstate"

This needs further discussion and should be taken out of this patch
and added separately. Particularly:

- it should be a setting like dl-dir, and not hardcoded to top_dir/sstate.

- if it is shared in this way, shouldn't we also figure out how to
share the hashequiv server? Right now each build will start their own
private server, which will use their own private database, which will
lead to baffling lack of sstate reuse, despite builds sharing the
sstate dir.

Alex

