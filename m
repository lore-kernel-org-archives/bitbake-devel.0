Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847FC433F5
	for <webhook@archiver.kernel.org>; Mon, 28 Mar 2022 10:02:05 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.9168.1648461724292024611
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 03:02:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PyUH/q+y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id d7so19574895wrb.7
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=jcOXW3JBa1wWwGaOHh/PmLNDaSj2NOqQhyAz4E/MxmM=;
        b=PyUH/q+yu++Dh81oJPtwP034L8dum/I5q+tyRmgJIZQS2PnWp2SeKvRgZdfR3d/x+t
         rmN+7HjE5JMRnZYEVBQDkPH4rz6TJL5aVeAoL9tzBMGJpkkPrL3mjSbSGFXvSu1lZV2W
         LL/JOeYlMnhuzhBoCq0o6NSFVhd2ZM3nt/LnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jcOXW3JBa1wWwGaOHh/PmLNDaSj2NOqQhyAz4E/MxmM=;
        b=YJ8pnDaJ2pxStJXqX5nVeP5RSDcU3U/lpzIreLaO3Dcc4teFbc9ywspNB8LSVUUjsS
         yAKP8o1y0CBlPBhOl1IRGa1bUAtv0M6xO/rAjTHPKYhikszY1j7msITpvcaPAw+jxUpF
         j1hmjufkrTBUJ3pcLUYmBlfAPC4cRrvSSMRj1vXfxvjmy/bL+TpbZ9e/CF3QKMxwzw/w
         hdl/dP9epXv0qRASJZFrrA2zKtQNqaAD13TVpj7gh8KCySKD3jhWn83WanHCmyve9dUM
         /xZ0xA+woLWl3LgU5mu2BsZ0rpnL0uLIWlpyuHwv5tTCwcmOnw/pfHRUvs97EIImDiFc
         3U4A==
X-Gm-Message-State: AOAM53062MNqXUXnYaUI3fOMRcwC8P03wD7yoXMCEQ2KGezeBdniwhE0
	WnhppX74Um6Axyi3/ehEay8w8MKMhQSI10oR
X-Google-Smtp-Source: 
 ABdhPJxA21zaMH7lx/Lm2IjKmF8lPKnLYDAgMYCM+5lGX/rwK8gqsfUCSf+KmCxzOwSDGSqiwz9aIw==
X-Received: by 2002:adf:9794:0:b0:203:e074:1497 with SMTP id
 s20-20020adf9794000000b00203e0741497mr23509829wrb.75.1648461722194;
        Mon, 28 Mar 2022 03:02:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:69e0:aa6:3ee0:1c3c?
 ([2001:8b0:aba:5f3c:69e0:aa6:3ee0:1c3c])
        by smtp.gmail.com with ESMTPSA id
 u11-20020a5d6acb000000b002058148822bsm16780680wrw.63.2022.03.28.03.02.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 03:02:01 -0700 (PDT)
Message-ID: 
 <4ad6e62c6f92b94796573201aaea0abf76e9d6b5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 4/6] server/process: Avoid hanging if a
 parser process is terminated
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Mar 2022 11:01:57 +0100
In-Reply-To: <16E008969DDF9BDD.32521@lists.openembedded.org>
References: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
	 <16E008969DDF9BDD.32521@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Mar 2022 10:02:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13522

On Sat, 2022-03-26 at 20:34 +0000, Richard Purdie via lists.openembedded.org
wrote:
> If a parser process is terminated while holding a write lock, then it
> will lead to a deadlock (see
> https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Process.terminate).
> 
> With SIGTERM, we don't want to terminate holding the lock. We also don't
> want a SIGINT to cause a partial write to the event stream.
> 
> Use signal masks to avoid this.
> 
> Some ideas from Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/server/process.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index efc3f04b4c..dc331b3957 100644
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
> @@ -739,8 +740,12 @@ class ConnectionWriter(object):
>  
>      def send(self, obj):
>          obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
> +        # We must not terminate holding this lock. For SIGTERM, raising afterwards avoids this.
> +        # For SIGINT, we don't want to have written partial data to the pipe.
> +        signal.pthread_sigmask(signal.SIG_BLOCK, (signal.SIGINT, signal.SIGTERM))
>          with self.wlock:
>              self.writer.send_bytes(obj)
> +        signal.pthread_sigmask(signal.SIG_UNBLOCK, (signal.SIGINT, signal.SIGTERM))
>  
>      def fileno(self):
>          return self.writer.fileno()

This doesn't work as you'd expect, see https://bugs.python.org/issue47139 where
I mentioned the issue upstream.

Cheers,

Richard



