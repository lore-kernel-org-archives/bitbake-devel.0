Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704DAC4828F
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 15:59:47 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.15378.1707494377369004716
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 07:59:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lVmU4IRs;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so20254831fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707494375; x=1708099175; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1DKwlebtrEkiwW2B1HgqnKx163bofGk566v74YjgXow=;
        b=lVmU4IRs7oeIB8ygCR9HDuZKWSB3LjF1GpcXf1xXv/g1CkXxNbxBnsA/qBZAhgqkQt
         gJsDKBY7kMeTGMave6YVbhrTUa99NNV8dBKsVhIfpP2Va4dY2qDdDydgeIG38CepVWMo
         036p5bSKedp+d9TuIwi0vE6egopUel/+tlL5s2OxzKygwj6dYjTgBjJa22lELE2nmrCZ
         cwaXJwp7wbkFgot0lx4nEz4Kf81/GWzuh5+wFSAOVz4LBPpY/bdm9Qomq3lS0KuQALOw
         CpvVkuferE1x1aFRV4ykhjCiuw/Og2dPBtylo1A9sm3BTu4iE0pjInSP8mcVLM1+js/w
         vZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494375; x=1708099175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DKwlebtrEkiwW2B1HgqnKx163bofGk566v74YjgXow=;
        b=dc6jRY3B1ITxEwmm0PVJmhfM0Gn5NLJg2TvfxsD0Lr60ekBa+J5FVuamROEuZNqrOM
         45/nHXxHAA/PV5sjHOLLEPmr6TBErnmkuqTW2POfEcQmH5QY28VkG0XuKL2D/WYaSome
         wQNvm3WntVImG592kw+bTZLP7F3NWcffdn6ou2KwPr1JE5/qT8DHgVk3O0HkDNOe7c8k
         LZ/N0pyftuiCUomMOs4GoWnT9PTpj5T3T4NxBj4yM4LC+z1L7p1jTRfpW3oxrZsqL2lk
         v8qDzGbG67PobePdWohFt3qBnql/0hYAubyJbEgTqmhvf3wc4Y5n6wyymLoQg0t3oLQ5
         CHXw==
X-Gm-Message-State: AOJu0YyF58nd8iUIIbDyouyzWL7DXv/wDu7XzgnWDYk5Ar37QEGrPy8Z
	T54Jror4lyYsn5sFBw+WPK9zNGHZq0Mv21GfnS1iEpmT3uGX+KkyowCuJQ9xa2hRRIQ3mVUusGP
	XK8OajRx1M/DfaKO4nntrRsP9XKc=
X-Google-Smtp-Source: AGHT+IF47vZceVzuTfVaZEEcZ9EluZ6eDR2HRL5hWfigiEqNRkeBBPjakGiBGIsw2R2ybFc9G+4eHt9rFwBGfTf16oc=
X-Received: by 2002:a2e:4c01:0:b0:2ce:f93b:3af5 with SMTP id
 z1-20020a2e4c01000000b002cef93b3af5mr540577lja.9.1707494375399; Fri, 09 Feb
 2024 07:59:35 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com> <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
In-Reply-To: <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Feb 2024 16:59:23 +0100
Message-ID: <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Khem Raj <raj.khem@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 15:59:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15854

On Fri, 9 Feb 2024 at 16:43, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> There is effectively a "main loop" within bitbake, so execute() is
> meant to do one thing, then return, on the assumption it will get
> called straight back.
>
> Since the "continue" makes it faster, it suggests something else
> somewhere is being slow and as you mention, there are a load of other
> code paths which could also have a similar issue.
>
> Could you find out where the actual delay is, since it should just hget
> a call straight back. Or is it the loop iteration itself which is slow?
> Even with 20k entries, you'd think python would handle that.

It's a combination of having 20k entries, and that the loop stops at
each of those entries, and returns from execute(), then execute()
starts again and the loop is restarted from the beginning. So the
result is processing 20000 entries to the power of two. I inserted the
timings, iteration counters and additional debug calls into execute()
specifically to confirm this, and they did.

Alex

