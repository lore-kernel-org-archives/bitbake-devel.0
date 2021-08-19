Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web12.75340.1629403126842504090
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Aug 2021 12:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=McOjT8M6;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso10108010oth.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Aug 2021 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=wdm9aLZOCvRwKSRz1YcTs+J9bfZA8KS/Bzrqda8EaHw=;
        b=McOjT8M69608hSJklOy8MXX2Z2SFkQ4rj1XqJAGge1wteWbwY8eagjLC3RWY0xhP4E
         kHP3hqo2tV7eY0JsjDgY86lllntktkW8ZBdF4FmTtVOqdflYUgJSKJ7w2+JmWhKAjibu
         oat6ijHvtoPEXeyK9hEU93szAG0WBzKAkddrIbhnyaoaGfWSGWESM9KUT2sKgx8W2gHU
         s/nIfBWo3NZmxGgFKOeVuNTnDDKAMRbQFMAtym0TLyiUQ3EhDSp/gfwHtF0VBzxg2RKb
         cXHJzM7x8z9rO4dVRj97cbYOFdqPAsij4+Vi/Q3DWim8nelgdtRgU0lEVzmP4DuHgMua
         5kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wdm9aLZOCvRwKSRz1YcTs+J9bfZA8KS/Bzrqda8EaHw=;
        b=MgNEYHivX1w6aK3XElg8uGVtYE/dZBw74jJZQJQ1acBGz+JVUS65r7Xi+KA64c8JNH
         jL3wPJHz9gDuju1XPbk3kV0uxxFvAi5aJFBMzUY2Fn6Fm1aZBSbi6tMUHGoOleZj+Mfn
         0s7IqCRficOWPp6GRBUO8wlmWNn/873zUOEg/tXTRSdNgYTOwC+AP59WTjtggKcxS3IQ
         NxJ2mhD+3pQdBMYAKoI8i+YR2BGkQUgemyus8e19Na9Ctr9bnc4z6WRW2f5pSBbeDLZO
         8aAfhVUjZv9+2gMOG0yR3t2fYMR29J9CCKZk244B5fnCG3Ga4urGzqwCMLUPqHL3wBWZ
         Qz4A==
X-Gm-Message-State: AOAM532YAI/iFcqVu/7+83AQG5EiD7Oapf+vszoguv6xIGqqLiFKoAE4
	tRNSuX4KwzAznMhSO5FQQOk=
X-Google-Smtp-Source: ABdhPJz8sxoGJqnPcsDOqzNfjmEWn02H4/zkCCEnzKbAjx2OTriyiP5GAvFrph8Q3FDyxCrT441HOQ==
X-Received: by 2002:a9d:6391:: with SMTP id w17mr12786766otk.19.1629403126250;
        Thu, 19 Aug 2021 12:58:46 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id 67sm888818ota.70.2021.08.19.12.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 12:58:45 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [PATCH v6 2/4] bitbake: asyncrpc: always create new asyncio loops
To: Scott Murray <scott.murray@konsulko.com>,
 bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Paul Barker <paul@pbarker.dev>
References: <cover.1629388054.git.scott.murray@konsulko.com>
 <385ebae0db5851cd4a6094810a794d90a0a85c92.1629388054.git.scott.murray@konsulko.com>
Message-ID: <a9c79a53-5491-e97f-3fb7-15151f7bb223@gmail.com>
Date: Thu, 19 Aug 2021 14:58:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <385ebae0db5851cd4a6094810a794d90a0a85c92.1629388054.git.scott.murray@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 8/19/21 11:46 AM, Scott Murray wrote:
> asyncio in older Python 3.x (seen with 3.7) can seemingly hang if
> new_event_loop is called repeatedly in the same process.  The
> reuse of processes in the Bitbake thread pool during parsing seems
> to be able to trigger this with the PR server export selftest.
> It appears that calling set_event_loop with the new loop avoids the
> issue, so that is now done in the asyncrpc Client initializer (with
> an explanatory comment).  This should be revisited when the day
> arrives that Python 3.9 becomes the minimum required for BitBake.
>
> Additionally, it was discovered that using get_event_loop in the
> asyncrpc server initialization can trigger hangs in the hashserv
> unittests when the second test is run.  To avoid this, switch to
> calling new_event_loop + set_event_loop in the initialization code
> there as well.
>
> Signed-off-by: Scott Murray <scott.murray@konsulko.com>

Looks good to me

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>


> ---
>   lib/bb/asyncrpc/client.py | 10 ++++++++++
>   lib/bb/asyncrpc/serv.py   | 24 ++++++++++++++++++++----
>   2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> index 3eb4fdde..50e60d5c 100644
> --- a/lib/bb/asyncrpc/client.py
> +++ b/lib/bb/asyncrpc/client.py
> @@ -119,6 +119,16 @@ class Client(object):
>           self.client = self._get_async_client()
>           self.loop = asyncio.new_event_loop()
>   
> +        # Override any pre-existing loop.
> +        # Without this, the PR server export selftest triggers a hang
> +        # when running with Python 3.7.  The drawback is that there is
> +        # potential for issues if the PR and hash equiv (or some new)
> +        # clients need to both be instantiated in the same process.
> +        # This should be revisited if/when Python 3.9 becomes the
> +        # minimum required version for BitBake, as it seems not
> +        # required (but harmless) with it.
> +        asyncio.set_event_loop(self.loop)
> +
>           self._add_methods('connect_tcp', 'close', 'ping')
>   
>       @abc.abstractmethod
> diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
> index 45628698..b4cffff2 100644
> --- a/lib/bb/asyncrpc/serv.py
> +++ b/lib/bb/asyncrpc/serv.py
> @@ -136,10 +136,7 @@ class AsyncServer(object):
>           self.logger = logger
>           self.start = None
>           self.address = None
> -
> -    @property
> -    def loop(self):
> -        return asyncio.get_event_loop()
> +        self.loop = None
>   
>       def start_tcp_server(self, host, port):
>           def start_tcp():
> @@ -228,6 +225,12 @@ class AsyncServer(object):
>           """
>           Serve requests in the current process
>           """
> +        # Create loop and override any loop that may have existed in
> +        # a parent process.  It is possible that the usecases of
> +        # serve_forever might be constrained enough to allow using
> +        # get_event_loop here, but better safe than sorry for now.
> +        self.loop = asyncio.new_event_loop()
> +        asyncio.set_event_loop(self.loop)
>           self.start()
>           self._serve_forever()
>   
> @@ -236,6 +239,19 @@ class AsyncServer(object):
>           Serve requests in a child process
>           """
>           def run(queue):
> +            # Create loop and override any loop that may have existed
> +            # in a parent process.  Without doing this and instead
> +            # using get_event_loop, at the very minimum the hashserv
> +            # unit tests will hang when running the second test.
> +            # This happens since get_event_loop in the spawned server
> +            # process for the second testcase ends up with the loop
> +            # from the hashserv client created in the unit test process
> +            # when running the first testcase.  The problem is somewhat
> +            # more general, though, as any potential use of asyncio in
> +            # Cooker could create a loop that needs to replaced in this
> +            # new process.
> +            self.loop = asyncio.new_event_loop()
> +            asyncio.set_event_loop(self.loop)
>               try:
>                   self.start()
>               finally:
