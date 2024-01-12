Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81E4C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 12:27:53 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.5835.1705062468136364243
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 04:27:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TUNeQCWu;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50ea98440a7so6621064e87.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 04:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705062466; x=1705667266; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoY0vIByT//n+K9EwXns7JxHV9jIqVMi5spQJYzWjkE=;
        b=TUNeQCWuxYd8RfUbZDIqVmF5Y+zu6NoyhZy8plzhmoImhA+W2EatqBUr/DeXflQNRf
         NDOjBFZpQdzf7WJ5Kb9+RPfkEyHsApXHIBz7t1KwrUtV5Ci+cgyxFrcj2WSg9e7Jzzqf
         pvM1izNo45EIlpIJPzwy3R2UfbPiDFoRaG5JXOD1hSibPq3N2pJuH6qfYK4a6Td12kSI
         101E+sE+UP/9dyVt78iQ0IBOD6k0jVfcjyqa8JVh+fQAy42tu0E2E/rTXvYaywzMitB8
         nZ6NzefAvcam2pHXGAmb4HKuwhrDdA9OXss/MbWdyLD9qZrHPHq0pqsoCJWXpYZtdPz2
         kOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705062466; x=1705667266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoY0vIByT//n+K9EwXns7JxHV9jIqVMi5spQJYzWjkE=;
        b=YeMaCGmDx8eICNYGqYwb6ZGaYjYQBZ5NGDKKOskFAxZuuIu1EVxYVf3ZV6vufFLxjA
         NK++EYP7Uexe/Y+b29N6GKEgxkPqnvafsr7CLuseesX1i2+UnS/O6p1PpKHmQPyQAHIs
         Izdjhi8/FnSeYPdMSbQJWsOcS313U/kX+Mrh1DzxbCbns4rUFO+udM0aD7Xr8egJtCAk
         mRMQczOR8PayVYUjKEKQ2L9V+m6t/sHkisQCpbGwsAeC9vLxGuERKpvOSdWEdNAyEhag
         2ObdwCAGIeqXkay6lJKhC3EwokFATUnloPpx7b+ASs/7bSJdsbr8tVsLlsMpZih+iSx7
         /LmQ==
X-Gm-Message-State: AOJu0YzHQ4MY+VH7d1a4sLbI006HwA5rRar2Bfd/pHX1OmyzqKAQGzz1
	+kUJqrS5SSFiATuI8AG4mw2iF0GBLtx5Qs5pkvI=
X-Google-Smtp-Source: AGHT+IFGzWQaHawYFGA5gC3JvIh8LJhhmoBJD3LQNHnxe/d44RHNykQS4rda+XLZGiHBkc9PJ/ivnSTaGRk+Hc9eVvk=
X-Received: by 2002:a05:6512:3d1:b0:50e:7a09:8a6f with SMTP id
 w17-20020a05651203d100b0050e7a098a6fmr370406lfp.139.1705062466067; Fri, 12
 Jan 2024 04:27:46 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
In-Reply-To: <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 12 Jan 2024 13:27:34 +0100
Message-ID: <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 12:27:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15787

On Fri, 12 Jan 2024 at 13:13, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> So nothing specific I can suggest but just my observations/thoughts.
>
> You could pull the event log json file from the build and "replay" it
> with some new viewer tool to see if there is any specific delay
> involved between task executions. The events should be in there to
> allow that.

The troubling part is, I've seen cooker at 100% cpu and not
progressing for minutes locally, on an unloaded machine. Then it
spawns some tasks, which quickly complete, then it does nothing again
for some time. So these might be several different sources of slowness
we're observing. The meta-oe build I've pointed to had just about 6000
tasks completed after some 6 hours, which is surely much slower than
the machine is capable of (and there were no competing builds in that
time).

Alex

