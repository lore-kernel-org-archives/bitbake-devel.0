Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web10.9367.1625155167917758042
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Jul 2021 08:59:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=WU6y4bla;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id b2so7813017oiy.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Jul 2021 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Z1rvkr45+SERUVXypz/hFx5i82vIDElCOKLmtYYebmg=;
        b=WU6y4blaBi9xACCOvVXQOcYCbEqrpAOwCwNJK6jAi1xrWP4GS/Bk8jpW0nQxumKLGC
         vHUwS8agXudSQemU2zt1Q19uJ1p4ZdtqGcUT6ZQrQxx6e+Gw4pkfoA+pFftFitvZHDGc
         9ATNsBNld3sJxA2GgY+/wMhz0vvNOGCIgs3VCgYY5ObfCcXlQLvlm6a+5Kc4xyj5+6xs
         0TI6ITGVpp/6VPiXHWGGyTqysOBx2jhfWOZQzvEc6EUCnEHwWjwVG3dEq7zsmLDsuWV1
         87BRcjdEZ8dff+WZ55vDLiczbzZT1dHI9UJTAY+ijFCsu7FSscM+OSBq2mutODnNvl3X
         7ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z1rvkr45+SERUVXypz/hFx5i82vIDElCOKLmtYYebmg=;
        b=XjT8tXPwSJbvD9ii/lGugqbeUMk2/Wj/cf1rwIe3mRavfRe46JPZ9GtbQKuLZnNj4T
         cSuX10PyfaDVIKfbPeEonaL0gJFLiN7kISM+Es2hTiqUfhUCrq+EIwku9YMnXfcZY4X/
         rfcfQ7/yR34vCSx8bvIGKbF7e1bN2t1yVkFIle8e5495JfnxKT9GpmWjdaET4t0b2xqI
         dQp0gQcLySQ6OmOixgFnqEPk5mHwX0zLP5nODlWKD+cUIjzH7DXLD7+QRrbE98mCiITm
         n2BA/G2SR7rqlH2inuHyw/fohn7tWJXuPxg1Xs6GZ3dxtLyQi3psuTxEX0r5LNxi1u8S
         5NsQ==
X-Gm-Message-State: AOAM532Zy1KY+a1NgP7byyZ70YCR+p/6USw2niRorQPtrObNFoVREL1Z
	w6vdeD0DguJrQO1aV4iv8os=
X-Google-Smtp-Source: ABdhPJw27cTkCrxxjFEAbTqf5mngqovKIGjjs1vgKBQYpqKzONrhtVs5MG3SwZ0+7MfB3SnIa9HEQQ==
X-Received: by 2002:a05:6808:13c5:: with SMTP id d5mr166617oiw.164.1625155167304;
        Thu, 01 Jul 2021 08:59:27 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id r186sm70745oia.6.2021.07.01.08.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 08:59:26 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [PATCH v3 2/4] asyncrpc: Ensure that asyncio shutdown is clean
To: Paul Barker <pbarker@konsulko.com>, bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20210628041356.2676-1-pbarker@konsulko.com>
 <20210628041356.2676-3-pbarker@konsulko.com>
Message-ID: <996945f9-27a7-9fd8-3bd1-70d7b78c29a4@gmail.com>
Date: Thu, 1 Jul 2021 10:59:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210628041356.2676-3-pbarker@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 6/27/21 11:13 PM, Paul Barker wrote:
> We should ensure that all async tasks are cancelled and then allowed to
> finish gracefully before closing the asyncio loop.
>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> ---
>   lib/bb/asyncrpc/serv.py | 33 +++++++++++++++++++++------------
>   1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
> index d6e3df2c5..0cdae5327 100644
> --- a/lib/bb/asyncrpc/serv.py
> +++ b/lib/bb/asyncrpc/serv.py
> @@ -198,25 +198,34 @@ class AsyncServer(object):
>                   await writer.wait_closed()
>           self.logger.debug('Client disconnected')
>   
> -    def run_loop_forever(self):
> -        try:
> -            self.loop.run_forever()
> -        except KeyboardInterrupt:
> -            pass
> -
> -    def signal_handler(self):
> +    def handle_signal(self):
> +        self.loop.create_task(self.shutdown())
> +
> +    async def shutdown(self):
> +        self.logger.debug('Server shutting down')
> +
> +        # Stop accepting connections
> +        self.server.close()
> +        await self.server.wait_closed()
> +
> +        # Cancel all active tasks
> +        tasks = [t for t in asyncio.Task.all_tasks(self.loop)
> +                 if t is not asyncio.Task.current_task(self.loop)]
> +        for task in tasks:
> +            task.cancel()
> +        await asyncio.gather(*tasks, return_exceptions=True)

Do we need to clean up all the client sockets here with .close() 
.wait_closed() like we do with the server socket?


>           self.loop.stop()
>   
> +    def run_loop_forever(self):
> +        self.loop.run_forever()
> +
>       def serve_forever(self):
>           asyncio.set_event_loop(self.loop)
>           try:
> -            self.loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
> +            self.loop.add_signal_handler(signal.SIGTERM, self.handle_signal)
> +            self.loop.add_signal_handler(signal.SIGINT, self.handle_signal)
>   
>               self.run_loop_forever()
> -            self.server.close()
> -
> -            self.loop.run_until_complete(self.server.wait_closed())
> -            self.logger.debug('Server shutting down')
>           finally:
>               if self.close_loop:
>                   if sys.version_info >= (3, 6):
