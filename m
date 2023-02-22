Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB648C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 12:01:16 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.6884.1677067267369028693
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Feb 2023 04:01:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A5huYeY/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id l25so7073067wrb.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 04:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVN7Do1mMdFK0u5ovVy7Zp8w29G3o1S5YXNXKBTdAp8=;
        b=A5huYeY/qo6kZSMRBQKCBCgdGAB7hMf+tWS7CAiNjF2AOqJMfplkNMwKXc5MqNwnaY
         XIBKknrZJ18Zv3P0zMb5Sg6tXL4GTG1+paHe8ViAAP7jY0TAfsLEF6Ba1BA5JJu7XYRE
         is4kqsQVyq+u9LMKILjbb+kJBCPuAqBM4817Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVN7Do1mMdFK0u5ovVy7Zp8w29G3o1S5YXNXKBTdAp8=;
        b=qCZcEu8sXAWb5lMzNtO+2G95hrFy4ZYyYFkBApHXEe8mxIEWTGvhgutp3gj0c2V8f8
         Cgf3x3nFrSlh4sJhTZFHdSEBESPazMWsXqgcZUBFe5wH+yKWVgtSIJV6se3FAefXtS6W
         rW+V9xiJNIDmbFxnZxnKX8MBH2iuUUJk/yJCxyFFKdvbPMSoyKr47iHmWGZQjG30CFB5
         o1BiypkwxjArFeEXjuK/SmESL/o+LYuK/AOUVY+VNX4ErQIqPS9a+Huez/ZxGOJF1eyX
         W6WQQsgvjotHZ5++WqWPm+lXzNnPhojLxT7EMUvHy4IR0g1CdRBrmcoPESoZK+C2yYrg
         m/RQ==
X-Gm-Message-State: AO0yUKWgjKgVFwSKEmxA+TccaZj6BYiBecKfcrbHf6wH0iRC7i4ADKXv
	fZvcw8rtt3bGb6qFv92gzgq/cg==
X-Google-Smtp-Source: AK7set/oXd0VhMjfNwboDGaaOKsPMiq0GgsGV2ukRRnNqxugAuKeyQv80KbUJSWYOsjbiijXYaQCYw==
X-Received: by 2002:a5d:414f:0:b0:2c5:455b:4e8a with SMTP id c15-20020a5d414f000000b002c5455b4e8amr7757452wrq.50.1677067265662;
        Wed, 22 Feb 2023 04:01:05 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab? ([2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab])
        by smtp.gmail.com with ESMTPSA id h11-20020adff18b000000b002c567b58e9asm8981933wro.56.2023.02.22.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 04:01:05 -0800 (PST)
Message-ID: <8ef30c400c868a008d07714cb1656c7c3fa646ac.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/5] tests: git-lfs: Restore
 _find_git_lfs
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <paulo@myneves.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 22 Feb 2023 12:01:04 +0000
In-Reply-To: <20230217170009.58707-1-paulo@myneves.com>
References: <20230217170009.58707-1-paulo@myneves.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 12:01:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14475

On Fri, 2023-02-17 at 17:00 +0000, Paulo Neves wrote:
> Not restoring the mocked _find_git_lfs leads to other tests
> failing.
>=20
> Signed-off-by: Paulo Neves <paulo@myneves.com>
> ---
>  lib/bb/tests/fetch.py | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)

Just for future reference, the shortlog entries for these patches needs
tweaking. For example in this case I'd have written:

tests/fetch: git-lfs restore _find_git_lfs

since that makes it clear it is the fetch test being changed.

In other changes you used both "git" and "git.py", I'd suggest just
using "git" and I'd probably use "fetch/git" to make it clear it was
the git fetcher.

I'll fix up these in the patch queue this time so no need to resend.

Cheers,

Richard


