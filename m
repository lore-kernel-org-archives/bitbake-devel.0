Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.8908.1612535826256492070
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 06:37:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=QSk88c/h;
 spf=pass (domain: gmail.com, ip: 209.85.161.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f41.google.com with SMTP id d3so1654557ool.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 06:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1K7Lp7P3reIBe28U+x7nMEf+XdZCxP0J//h9Ks5Uqjs=;
        b=QSk88c/htm1E/JYez64Oo4rY86dpqR5C3m+1NlHIOXZ56MlSEMRbMMMoP/DA1r1kRz
         q7tQLClns+T85jEbPg9cBsmZ3Q1BCsYTNCUmBJTQ+LcFlbF1+aE0erzIjZ+6XH8yjGxh
         dhifdbFiztbNaB8EAp9ATeRTzwK629d+7kUh3XtJdk2h/8QX1Xo1/BKxU9cSCivcTnYV
         ryoSjqQbsaYzi7BA8qwUUrHXTcMkFvVSZoCepTa3WIUiLFB+C7phFT2OeSTSFGiLCjq5
         h2gv0uNmOBzeXkEZQ6SkVejL7OQR3hOThlt0cXU4ePdSrjzMtosjhdzk+x7hBuSrTrxi
         BKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1K7Lp7P3reIBe28U+x7nMEf+XdZCxP0J//h9Ks5Uqjs=;
        b=S4e1qJEk/xX0J69wMas9zs6p75C+qC53+29wf2XNLqbOFkebKFoAvShPpXwfi81L5w
         502LumLcogPdmGNdsw3jGQCXT939nATvJFMl+mFdXeOz0TqY0+JBQrA+mUt6upHxDOYY
         S8KQA6DHCXO8r6AZiiT/qiEcnby3gySbYLCicsnPm9/QSDlYsObS4lzlNA3ngTk2K0p2
         EkQc8AkjmllTXNSpGxwVLsnnMREuzIJPhW+HQ2U2z9YJYIJi4kpVctyleKtmWT7WkFIK
         Xm3xSdpzeHaGh7kHHjYlYoJPpG1jnh0pW3uQzYTJ2k/Vc59jRMNyt7PmtPFtXMRkk+G7
         /jqg==
X-Gm-Message-State: AOAM533zFrAC8xr7Yepb69H/pCgK8jdDTCO4DTnzwdejlZNbdvtr/U4Q
	oTJf3zHZVLbctVWqM8takxc=
X-Google-Smtp-Source: ABdhPJzfGBjkI5wuGDDDUeN5owmIycRAfCaltZ+larhv0Oy1GqfO1a7xKL9vbVyiw+RRNh8IYX5kwg==
X-Received: by 2002:a4a:424c:: with SMTP id i12mr3639261ooj.85.1612535825569;
        Fri, 05 Feb 2021 06:37:05 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id p22sm1800261oth.38.2021.02.05.06.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 06:37:04 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [PATCH v2 3/8] hashserv: server: Fix logger.debug calls
To: Paul Barker <pbarker@konsulko.com>, bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20210205112611.17167-1-pbarker@konsulko.com>
 <20210205112611.17167-4-pbarker@konsulko.com>
Message-ID: <55dffef6-4b3b-331d-f31f-00f3b4e47624@gmail.com>
Date: Fri, 5 Feb 2021 08:37:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205112611.17167-4-pbarker@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

This patch breaks logging when running the server in standalone mode:

$ ./bitbake/bin/bitbake-hashserv --log DEBUG
Listening on './hashserve.sock'
--- Logging error ---
Traceback (most recent call last):
   File "/usr/lib/python3.6/logging/__init__.py", line 994, in emit
     msg = self.format(record)
   File "/usr/lib/python3.6/logging/__init__.py", line 840, in format
     return fmt.format(record)
   File "/usr/lib/python3.6/logging/__init__.py", line 577, in format
     record.message = record.getMessage()
   File "/usr/lib/python3.6/logging/__init__.py", line 338, in getMessage
     msg = msg % self.args
TypeError: not all arguments converted during string formatting
Call stack:
   File "./bitbake/bin/bitbake-hashserv", line 57, in <module>
     ret = main()
   File "./bitbake/bin/bitbake-hashserv", line 51, in main
     server.serve_forever()
   File "./bitbake/lib/hashserv/server.py", line 563, in serve_forever
     self.loop.run_forever()
   File "/usr/lib/python3.6/asyncio/base_events.py", line 438, in 
run_forever
     self._run_once()
   File "/usr/lib/python3.6/asyncio/base_events.py", line 1451, in _run_once
     handle._run()
   File "/usr/lib/python3.6/asyncio/events.py", line 145, in _run
     self._callback(*self._args)
   File "./bitbake/lib/hashserv/server.py", line 514, in handle_client
     await client.process_requests()
   File "./bitbake/lib/hashserv/server.py", line 171, in process_requests
     logger.debug(1, 'Client %r connected' % (self.addr,))
Message: 1
Arguments: ("Client '' connected",)
Client disconnected

On 2/5/21 5:26 AM, Paul Barker wrote:
> The first argument to debug calls in bitbake should be a debug level.
>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> ---
>   lib/hashserv/server.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index 3ff4c51cc..fa0d3410b 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -168,7 +168,7 @@ class ServerClient(object):
>   
>   
>               self.addr = self.writer.get_extra_info('peername')
> -            logger.debug('Client %r connected' % (self.addr,))
> +            logger.debug(1, 'Client %r connected' % (self.addr,))
>   
>               # Read protocol and version
>               protocol = await self.reader.readline()
> @@ -212,7 +212,7 @@ class ServerClient(object):
>       async def dispatch_message(self, msg):
>           for k in self.handlers.keys():
>               if k in msg:
> -                logger.debug('Handling %s' % k)
> +                logger.debug(1, 'Handling %s' % k)
>                   if 'stream' in k:
>                       await self.handlers[k](msg[k])
>                   else:
> @@ -273,7 +273,7 @@ class ServerClient(object):
>               row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
>   
>           if row is not None:
> -            logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
> +            logger.debug(1, 'Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
>               d = {k: row[k] for k in row.keys()}
>           elif self.upstream_client is not None:
>               d = await copy_from_upstream(self.upstream_client, self.db, method, taskhash)
> @@ -307,11 +307,11 @@ class ServerClient(object):
>                       return
>   
>                   (method, taskhash) = l.split()
> -                #logger.debug('Looking up %s %s' % (method, taskhash))
> +                #logger.debug(1, 'Looking up %s %s' % (method, taskhash))
>                   row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
>                   if row is not None:
>                       msg = ('%s\n' % row['unihash']).encode('utf-8')
> -                    #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
> +                    #logger.debug(1, 'Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
>                   elif self.upstream_client is not None:
>                       upstream = await self.upstream_client.get_unihash(method, taskhash)
>                       if upstream:
