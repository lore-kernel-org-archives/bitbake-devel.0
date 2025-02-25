Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492CAC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 08:22:40 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.3647.1740471757813357841
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 00:22:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I9k1sUh3;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ddcff5a823so42757506d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740471757; x=1741076557; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4fu6NZ97e3iTypS1aFVI3HwMk+1wsw9AxScAIewdVQ=;
        b=I9k1sUh3pA1+GrhyKoAXi4Yjf6RMWd4pvLNaxzhpMnSl3j8Wrcv54tHSADBdLSNh+n
         BLklT+HPVfJsr1DzKUL2OQBQR58+hqw1WWWS8+Sx68eYYhKxfDS+nVFGNh+dpn+vzQ1F
         UAg7giuflc9NjG+5tG06Y/RWiDDwbFkw7Ff0htT5RvI2NYbRn5v5+u9RKthavGafhXUN
         ajPF8waNUvcw5dy9YztxB8oftEmCqiHn3vkSz9v/S8tHFissnxNekbgvUB9+jC0Tdvje
         dQoIqSur85H9tQ1Y2NhmzanpE+Ig31WvQ1rheLALiO4P6y+PveZcuXFV7KBkMop2E+XC
         bEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740471757; x=1741076557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4fu6NZ97e3iTypS1aFVI3HwMk+1wsw9AxScAIewdVQ=;
        b=A8dg2xQv3INK3tDs7otft/h+62RhuGX0TnCedupgLgd03zKpvaLZRa77pKyvR/8hyl
         65XemUqd30VOS2K+1GKpQq2M8G8QzjR/GuCZP9nucwevy+RAGBk8g+0uchUq0EvuRJq3
         ugHFXaMRuvrJumeFJl3QLWRR895DvzYEbOLGa06I6eki1uC9r1udafj10lXxDuHJLTsM
         K0T9HTOvv8XjtzUsZzUBRx6zwIf8doZaD6JBFPiq8avGd5vAx0xxg9AsE3IxVZzxYAyY
         hqnIUx9RfaeoVeKb5y/UlMXR1Rsc/ZwePj/13p4WRUz5S2mSVAcNtvH2EDWmJ+zoflzM
         253Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrNBUNWPU1bhJ8SgC8+DBLMnu4QDoUqCG29EpaV6RxsYFz73wZbGPLjLYiZrhaT5ih8fvoFygI7d3kiF+S@lists.openembedded.org
X-Gm-Message-State: AOJu0YwkA1ve1E3gyxmHadl7ZKytBzjX+N5D1NINq1He8w4bAftXkvJt
	qQ33zPtg28ZNrGfNkuzX5Q4uPOrsIuTxhHv5QDVn6g3gpYwoQz/cN+tnYr6GXxbqhrnooBIDR1h
	znxFDZTDJVV1+xDkeJwkRjeF48eo=
X-Gm-Gg: ASbGncvmGs0vP8cybqp9AhYt+9ggoQxc8Bm57LpwSJBuSpZBKj0ZBwVrXZ1pe5K9veQ
	cJcLzlISrfKQDMcc3LT91/Xe96AnZ7LIgtZL+tonY/Qhe8M7IDn7RmTYfsN3v7/efA6lpg4BB4Z
	h0X0yXAARulwZcfUSilquCVBaZfaWbMjpYWeZgUzXY7A==
X-Google-Smtp-Source: AGHT+IG2MEzOpC5HHEgS6oOJyppX7bjVqbgqcjwPE698ZQkLlnMjgxHXg7/3+cg/XrLPswwRiTV390crScPRnYiCxyc=
X-Received: by 2002:ad4:5ccf:0:b0:6d8:af37:ae5b with SMTP id
 6a1803df08f44-6e6ae9ca614mr202025386d6.43.1740471756731; Tue, 25 Feb 2025
 00:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
 <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
 <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org> <CAJdd5GbZh7au+VtM_ueBs4MskkJtcx0pFYJG-36nUFW+=KxD=g@mail.gmail.com>
In-Reply-To: <CAJdd5GbZh7au+VtM_ueBs4MskkJtcx0pFYJG-36nUFW+=KxD=g@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 25 Feb 2025 09:22:25 +0100
X-Gm-Features: AQ5f1Jr1O0XMXuAi27YSstHGNOB8bcDqZV_xH9fXcNLtqIntjvaGbA-SGwG-OLY
Message-ID: <CANNYZj-G+j6yQXm0RCW5M2LcRxqVegsXuAPkLusO9+oueH2t=g@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 08:22:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17308

On Fri, 21 Feb 2025 at 17:07, Joshua Watt <jpewhacker@gmail.com> wrote:

> I agree the error message could be better, and also that buildtools
> should not be on by default. Perhaps something as simple as:
>
>    bitbake-setup --buildtools
>
> could enable it automatically? I think if there is such a simple
> option like that it will make it pretty easy for the end users to do
> the right thing.

How do I put this politely? Such an option is not simple or easy for
the end users, and I'm strongly against this sort of 'solution'. The
problem is that you, me, RP and everyone else here are suffering from
'yocto experience bias', and such suggestions come from that bias. We
know what to do when we see an error that can be resolved by
installing buildtools and putting them into PATH.

Now please try to put yourself into the shoes of the first time Yocto
user. They can't possibly know in advance that they need buildtools.
The set up a build with bitbake-setup, they initialize the
environment, they run bitbake, and it fails in ways that they will
certainly struggle to interpret. How would they discover this magic
option that will solve the fails for them, without showing the error
to someone experienced?

I have to stress again: bitbake-setup is a frontline tool for yocto
newcomers. It has to work. I can kinda see why we do not want to sweep
host specific issues under the carpet by defaulting to buildtools, but
we do need to find a way to clearly point out what the solution to
such fails is, in a way that is difficult to miss. I'm still
deliberating how to do this. Make a statement during 'bitbake-setup
init'? Make another statement in 'build-targets', subject to bitbake
failure? Install tools upfront, or provide a script in a standard
location in the build directory to do so? If installed upfront, use a
separate environment initialization script to enable them, or
integrate that into 'special' variants of init-build-env and
build-targets (I wrote a separate email suggesting that)?

I'm looking for ideas about helping users with this.

Alex

