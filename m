Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
 by mx.groups.io with SMTP id smtpd.web10.7664.1594555531155859204
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Jul 2020 05:05:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=mA9FOr1G;
 spf=pass (domain: gmail.com, ip: 209.85.218.68, mailfrom: jacob.kroon@gmail.com)
Received: by mail-ej1-f68.google.com with SMTP id n26so11097529ejx.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Jul 2020 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TG6hLM3MH2SVDvV33eM7Yqqx4Hce/5PXyFwUWRGKUY4=;
        b=mA9FOr1GKyQe/y7tlREMp3BVTV76N6ELxUyr6sw/y82y2G7pGKOKzxITyEtT1W4yXr
         wiG1QlIZ67IHWPQ9BZAJL60Ta6ConmHNmcwr4vd5o+f4B6JKPlchpu6VHWoY15nRwjnw
         eT/l7ryJ04TCOpworqRowITXtTYGyeabeV/OBckURSc8WJ5i4stM46O0b5H1YCPKYEOG
         n1fXAXjyEFiAH22hrrbavoGI1mSIgYigc0j0GLJFdPi6GDQT4lzw09jMJV6SmJgMtveB
         ehibwncjCnhVbNLuMHZt0laMMxCTu/JAau0BMGoaE2/8WvIZewpMHv73JDe+JpDQfhfn
         dxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TG6hLM3MH2SVDvV33eM7Yqqx4Hce/5PXyFwUWRGKUY4=;
        b=lZdYmyicPXqCLjFPpIXQbVIqkYtKc3Vh2kjczRBGK5FUjh0Nnppz4GSaTrHKZon6hp
         w8jCDWpTycK0dHvxN9TFu+ZXW3mmi/avpIeQe853/6Tx79uCEqjKsUQUKZ8NbHLHr4Uo
         m61olb1W4pzklLLHlkMFrm55lgpe8rEpYzhfsvk+8pgxty7jredf0QAmWAjYoC3FWCnM
         t27AoqZORRJXk2IDWp6mnx0d8HG+20lAgCu0qtqe/3zyc9Wo2SUP7wT8A8JHIc5VGv2K
         aRR59p469w/5A+smSmiz1rz65jZS2+hP+w6oikVh9Qjl5t8YlhYgBEmIfBc5rEWN0Dpx
         nK+Q==
X-Gm-Message-State: AOAM533qhykkJx0Hoa8WGMsBDXHVwSpdlnPXr6QwYBRqGm8biZm3LaK6
	RYXkA30Do6p8+9pot6CaBpUEIzbP
X-Google-Smtp-Source: ABdhPJwHKepQAhlqA1HxhAX60J8N5A3gFjTLXJ0ebryQF1m7rZSZvIoYKxL84hiTzs6TwqIW+nx0mg==
X-Received: by 2002:a17:906:3e84:: with SMTP id a4mr66308079ejj.372.1594555529199;
        Sun, 12 Jul 2020 05:05:29 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id d19sm1423337ejk.47.2020.07.12.05.05.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 05:05:28 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH] server/process: Fix a rare lockfile race
To: bitbake-devel@lists.openembedded.org
References: <20200712105516.507243-1-richard.purdie@linuxfoundation.org>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <fa3dd37a-0cf2-95ec-46e0-c7df69f211fa@gmail.com>
Date: Sun, 12 Jul 2020 14:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712105516.507243-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 7/12/20 12:55 PM, Richard Purdie wrote:
> We're seeing rare occasional races on the autobuilder as if two server
> processes have the lockfile at the same time. We need to be extremely
> careful this does not happen.
> 
> I think there is a potential race in this shutdown code since we delete
> the lockfile, then call unlockfile() which also tries to delete it.
> 
> This means we may remove a lock file now held by another process if we're
> unlucky. Since unlockfile removes the lockfile when it can, just rely on
> that and remove any possible race window.
> 
> An example cooker-deamonlog:
> 
> --- Starting bitbake server pid 2266 at 2020-07-11 06:17:18.210777 ---
> Started bitbake server pid 2266
> Entering server connection loop
> Accepting [<socket.socket fd=20, family=AddressFamily.AF_UNIX, type=SocketKind.SOCK_STREAM, proto=0, laddr=bitbake.sock>] ([])
> Processing Client
> Connecting Client
> Running command ['setFeatures', [2]]
> Running command ['updateConfig', XXX]
> Running command ['getVariable', 'BBINCLUDELOGS']
> Running command ['getVariable', 'BBINCLUDELOGS_LINES']
> Running command ['getSetVariable', 'BB_CONSOLELOG']
> Running command ['getSetVariable', 'BB_LOGCONFIG']
> Running command ['getUIHandlerNum']
> Running command ['setEventMask', XXXX]
> Running command ['getVariable', 'BB_DEFAULT_TASK']
> Running command ['setConfig', 'cmd', 'build']
> Running command ['getVariable', 'BBTARGETS']
> Running command ['parseFiles']
> --- Starting bitbake server pid 8252 at 2020-07-11 06:17:28.584514 ---
> Started bitbake server pid 8252
> --- Starting bitbake server pid 13278 at 2020-07-11 06:17:31.330635 ---
> Started bitbake server pid 13278
> Running command ['dataStoreConnectorCmd', 0, 'getVar', ('BBMULTICONFIG',), {}]
> Running command ['getRecipes', '']
> Running command ['clientComplete']
> Processing Client
> Disconnecting Client
> No timeout, exiting.
> Exiting
> 
> where it looks like there are two server processes running which should not be.
> In that build there was a process left sitting in memory with its bitbake.sock file
> missing but holding the lock (not sure why it wouldn't timeout/exit).
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/server/process.py | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 83385baf60..b3a7f8b419 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -243,7 +243,6 @@ class ProcessServer(multiprocessing.Process):
>                   lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
>                   if lock:
>                       # We hold the lock so we can remove the file (hide stale pid data)
> -                    bb.utils.remove(lockfile)
>                       bb.utils.unlockfile(lock)
>                       return
>   

I'm no export on the bb lockfiles, but if this is correct we should 
update the comment aswell.

Jacob
