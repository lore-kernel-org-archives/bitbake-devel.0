Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39435CAC5BB
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 08:13:25 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.4022.1760083995630637084
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 01:13:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GzHKesYz;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-879b99b7ca8so20617406d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760083994; x=1760688794; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxZpQUs351tz3w5GjZHGe5w2kRtOzAspanyRC6iEvK0=;
        b=GzHKesYzsUuCNUco3sJQ5eKQZ7RcSqyEa7tyXeZLQEr3rWmNLHgSw3Q9vrJ+CcjOol
         PL/69P6BU4plZHRTdiBbCCLA8NZTgU/kPcjAkalzAxx5P3vzwg5I+NHyBeUVFm7T9Skg
         G8GPT2zFAN5haNx+zvDa8eRczCu2f5aIdaRho4I2J4zuvTs0L151I3C8q/xeE4Ng7MQI
         PzXX8wDFyQtqCI9D8Ch8DNf1KbTrBNEoOuC2w0xbpTkItsB8IaTGT0ZHboqQTwK6hBP1
         pUjCYmgLo8CtcR4jnEk/ksisny2ICq8tordoC0NnNMuHsPRSB25NDnVMgmoQGuiS9xD8
         uy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083994; x=1760688794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxZpQUs351tz3w5GjZHGe5w2kRtOzAspanyRC6iEvK0=;
        b=ZYrlC9fOZ6QPHJNYPCiHqmEpMyM9CXKA6aKISFIZMKQicQBv3kxDA5SgKG4dWNY9dx
         125aSpMgkikm2Hvc25YClRJ3d9wJPKS6RFbLaTBnXPPF7gb4hg+8OnNXYAR0Hh4ueeCp
         2bvHmI+JMsMFutUnNXumXuNZxE2fU8XPQDFFb4TofzxNmN+O12EVnBCz5cXQyN0AeszI
         Nf6jXpHvQchwGw8stk21GlcXNT5a9hf/hjhyGVLgkkw6HqjE8M7bHekk4KI0/aXcF4tj
         5/3lNHekzaQrnAR/7FMfs9GwDA4CpWPGwk01Gd12ynj0y1Qxfxl1Tw7tHFFa0aDxUNyg
         qF/Q==
X-Gm-Message-State: AOJu0YzWHVNEXUMUXperqULLkF23iDZwTPxOWu0Bu/UNo+6I2K73U+Vz
	ZF8XEY3nmD6tLqLmYuuxy/s2PGponOVhUnweyWC/xyT8Do3VKGUBNsv8DfxjQGlPpWEDR7sRXjU
	ScOYj5FgVJJhS+TzDFPU/DBGxwY8ygXPMDw==
X-Gm-Gg: ASbGncsBQCzp0bY3dL2Hz06NxjTsWQv49eoE6a/eb79fcfgn39PP2M2VVwRh/1S106U
	aE7B7epazCbYmAvhHWkDB7F3X7kwgN4I5o+RbNMUZpuvZCudvSQKf+rHSTIivCI79bA56UVbYJV
	0s4q/xxngC83y4026RWB42vXwMgi3xKSY1NLq+tdYzPjqAX2q+Xepe1IpCXXGWQK+GIZaYnQ6SJ
	A+CMav0XH5BbC+8BvfNRQ9U17pA2MfWYMOc4lrqg+O8biYK3cNHjIekUd0h3ZEVHbeDAgd77mz/
	jy9EkcO04F6VQYn1irtTM2DY4OMGcfm6dAimgz+z4RiWH6yRS6o1PO3h6WvhwmbKak9UMg==
X-Google-Smtp-Source: AGHT+IFhT6r5DsTsRsSSxG9WASlrFJaO8jRQ0U0hH55OrpsuDlAWlZ+NqUnH2dTNcJ8jG64zJDLwyNy1Xd3ngQ07WC8=
X-Received: by 2002:a05:6214:4115:b0:77a:29ba:1b67 with SMTP id
 6a1803df08f44-87b2103c736mr138498816d6.13.1760083994574; Fri, 10 Oct 2025
 01:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251010080619.2688482-1-yoann.congal@smile.fr>
In-Reply-To: <20251010080619.2688482-1-yoann.congal@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 10 Oct 2025 10:13:03 +0200
X-Gm-Features: AS18NWB_FEgogPAP3NDFDJKUu864vCDcwR3R7bZy87ctD8QsfNTSWn_ZH3Kcq6g
Message-ID: <CANNYZj8CNarGn6vv6CyVepDnYwPmyL4HM2nb30WNug+TDj+D7A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] ast: Warn on multiple builtin config
 fragments for the same variable
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 08:13:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18165

> Added warning looks like:
> WARNING: Multiple builtin fragments are enabled for OE_FRAGMENTS via vari=
able machine: machine/qemux86-64 machine/test machine/qemux86-64. This like=
ly points to a mis-configuration in the metadata, as only one of them shoul=
d be set. The build will use the last value.

...

> +                    % (
> +                        self.fragments_variable,
> +                        builtin_fragment_key,
> +                        " ".join(builtin_fragments_list),

You need to put these into correct order.

Alex

