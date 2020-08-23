Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.173431.1598186205621155414
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Aug 2020 05:36:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D2FYBnj1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id y8so411249wma.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 23 Aug 2020 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=LgsG1zPQylqASv8lDSJLRfrEfU6vC/6pUctb0wDv9Hc=;
        b=D2FYBnj1IWshtqn9Vbasp2HjDJP3M3X0cX9ZtHyTJXt8iSFcFgMUXlYeQoB2xGTeVF
         fUNeQHFxXDcGiAMvQ/b8k9viKPjZUOuf3kz1+aYNbGuPPgNT9pMEGf+WvgjrBQsuHdYm
         xt4lCHoTqGMtflbPI+l/vLVBmQ23vghffj9F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=LgsG1zPQylqASv8lDSJLRfrEfU6vC/6pUctb0wDv9Hc=;
        b=b0FQdcN535IkCSLJXmudDd/ryVy80x4Ux7gQX1WfPoYtmfNQzGUKcW4RPKrjoSAZ/e
         XI3eamOEAWOvcmrFUb9KoIkYM/FezeDNcB0wKyiT5nw4PCsG4bDHyah1qM0tiVxbEmJ6
         wCGT4IsFp1bvADHW8P1h0bnsH8vEc9kXttRiuiqWltybRlfCWtFB6g8yhSJV0sJIwfps
         3or8kd846MUCs1Fnxpnp3YF9iheZIU2DOtTyoQAwbh5nzUz7iJAu+N2iJ/dcNUgc6Nq8
         ++Fr6o/S2LzUnr41Bf0FZTDLYk7KUtp7j8Rg1Yct7rnRLy7KWrVPqtT6g8I6p0rB5txN
         Vmeg==
X-Gm-Message-State: AOAM533qqa+DphpizUFQ9Uoxdx/ASmf7yi55l+HqyLvniSDtJ9mYn2Hr
	t1K3ONCYxhGJjJkD2wmkm6t5MtntVC29bsmj
X-Google-Smtp-Source: ABdhPJy7pJO3x9EhqEV8v7wHpCImp5rVTprIxpuKcvXklB+cABn1YG+rw9qFbsfTCYeQuOneI8ue2w==
X-Received: by 2002:a7b:c243:: with SMTP id b3mr1363270wmj.178.1598186203676;
        Sun, 23 Aug 2020 05:36:43 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id g3sm18556986wrb.59.2020.08.23.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 05:36:43 -0700 (PDT)
Message-ID: <7f25ddacf4f8140bc8f0c9371ec56f9b8a78069f.camel@linuxfoundation.org>
Subject: Bitbake server startup issues - need a radical rethink?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Steve Sakoman <sakoman@gmail.com>
Date: Sun, 23 Aug 2020 13:36:39 +0100
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The bitbake server startup code is proving problematic. It nearly works
but there are a few issues.

Basically it comes down to us trying to daemonise one python process
from inside another one so they run independently. The python
interpreter simply isn't up to it.

Our current approach uses os.fork() twice. We have to use os._exit() on
the end codepaths rather than sys.exit() as that would raise SystemExit
inside the original codebase inside a second process, meaning execution
happens there twice which is really really bad.

If we use os._exit(), atexit and multiprocessing.Finalize() constructs
don't work. This can leads to unexpected problems as we're effectively
breaking an significant part of the python's behind the scenes
machinery.

We could go back to the setup where we os.fork() twice then launch a
multiprocessing.Process() but it feels like we're relying on a hack.

I'm also noting logging is working differently in tinfoil and knotty. I
think this is due to the state of python's logging in the parent
environment, pre-fork. I really don't like the fact we have an
inconsistent base environment for the server.

This is a long way of saying, I think we need to radically change the
way bitbake's server process is started by making it a new process
execution. That will break the mechanism we determine when the UI is
"ready" and give us a whole new world of races to potentially worry
about but I think its the only way we're going to get out of this
current 'mess'.

I'm particularly worried about what this means for the LTS release
though as I'd effectively be writing these race issues off as unfixable
there unless we take the new process setup code which would seem a
little unwise.

Cheers,

Richard

