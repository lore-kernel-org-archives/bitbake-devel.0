Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ED4C433EF
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:52:12 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.7583.1648565531615104251
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:52:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NzwM3xsB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id
 k124-20020a1ca182000000b0038c9cf6e2a6so1671303wme.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=MuyEc0VBH8srKqrodcOXdJf+rbEI4soLiYM8eHIKF1o=;
        b=NzwM3xsBKpho5RGKKMcbVeldZNgxTep6RXNOFXvD/lF+UETY9qKn0KQZu4xUPWjLe5
         Y2BJdjxjI56mXcnSwaMT0nBOPWbRz1xVjrJWBK1+o/RkuHIGw8GQSwP2idT5lM+8EeeX
         xCUws1EvfYnZ7f3Gu/ATMpjdcLs+Vez8W6uv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MuyEc0VBH8srKqrodcOXdJf+rbEI4soLiYM8eHIKF1o=;
        b=ao15+Hw9OjDR8PepOPqPqOMS1B1aEZ4RsOxQRLehFqD5pdbGUsF6QbajCL2tkGTOsS
         tvLBS/U0ZPgGOEegBxq3jiCed7FAenzzeU6pIPgqIIswYz0f5X2wgfq1PQLpNywBVr+M
         adNHCQc+5rA+P9QKV+JsUoe8pvM8AHnrNZsCP/7HCE2LZScK972YyTAYpUCatuw+3LZP
         eKuSDcPlfk1z+QAlI4AJsdRj+nCVvh9RmP+C1UQDpw+bi1xrN3kumwCUaX1y8lyLBgOc
         V48Km0lSxuc8Bhbs2XwMO3eKEYSCgzz+eCEVBFMQOodVMPVdrCMrhz6xAqfcx6NWWRgv
         PoKA==
X-Gm-Message-State: AOAM532H+MjcALrBjgDjbsYBJ3ivanPUwHWkOu2V95m/21/6zATzc7XT
	rcFJMGfylUnUmY6WzA9QQsYkptnOMbyiPb7t
X-Google-Smtp-Source: 
 ABdhPJzKwr+LVqH/zXpr22MyT5knoPXAsH9jt6pQFGl+Lpj07AMCR6MIZ+qDPXgaIxKK+on+YbyOLw==
X-Received: by 2002:a05:600c:2185:b0:38c:9091:892 with SMTP id
 e5-20020a05600c218500b0038c90910892mr53506wme.14.1648565529609;
        Tue, 29 Mar 2022 07:52:09 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a144:3266:4a07:b254?
 ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 d20-20020a05600c34d400b0038caf684679sm3495092wmq.0.2022.03.29.07.52.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:52:07 -0700 (PDT)
Message-ID: 
 <050cc4f32cac444d6ff4da309d2f4e4e4c15708c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 4/6 v2] server/process: Avoid hanging if
 a parser process is terminated
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Mar 2022 15:52:03 +0100
In-Reply-To: <16E0852D83889B52.4597@lists.openembedded.org>
References: <16E0852D83889B52.4597@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:52:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13547

On Mon, 2022-03-28 at 11:38 +0100, Richard Purdie via lists.openembedded.org
wrote:
> If a parser process is terminated while holding a write lock, then it
> will lead to a deadlock (see
> https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Process.terminate).
> 
> With SIGTERM, we don't want to terminate holding the lock. We also don't
> want a SIGINT to cause a partial write to the event stream.
> 
> I tried using signal masks to avoid this but it doesn't work, see
> https://bugs.python.org/issue47139
> 
> Instead, add a signal handler and catch the calls around the critical section
> which is heavier but safe and seems to avoid all the deadlocks I was able to
> trigger.
> 
> Some ideas from Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/server/process.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index efc3f04b4c..f59a0ed5f6 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -20,6 +20,7 @@ import os
>  import sys
>  import time
>  import select
> +import signal
>  import socket
>  import subprocess
>  import errno
> @@ -736,11 +737,25 @@ class ConnectionWriter(object):
>          self.wlock = multiprocessing.Lock()
>          # Why bb.event needs this I have no idea
>          self.event = self
> +        self.signal_received = []
> +
> +    def catch_sig(self, signum, frame):
> +        self.signal_received.append(signum)
>  
>      def send(self, obj):
>          obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
> +        # We must not terminate holding this lock. For SIGTERM, raising afterwards avoids this.
> +        # For SIGINT, we don't want to have written partial data to the pipe.
> +        # pthread_sigmask block/unblock would be nice but doesn't work, https://bugs.python.org/issue47139
> +        oldsigterm = signal.signal(signal.SIGTERM, self.catch_sig)
> +        oldsigint = signal.signal(signal.SIGINT, self.catch_sig)
>          with self.wlock:
>              self.writer.send_bytes(obj)
> +        signal.signal(signal.SIGTERM, oldsigterm)
> +        signal.signal(signal.SIGINT, oldsigint)
> +        for sig in [signal.SIGTERM, signal.SIGINT]:
> +            if sig in self.signal_received:
> +                os.kill(os.getpid(), sig)
>  

For the record and maybe my future self wondering about this, you can't call
signal.signal unless you're the main thread/process, you'd get a ValueError
otherwise. This leads to silent hangs of some builds, e.g. in devtool workflows
in oe-selftest.

Cheers,

Richard



