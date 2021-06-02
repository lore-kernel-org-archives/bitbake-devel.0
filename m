Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web09.14120.1622644711368302721
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Jun 2021 07:38:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=SclTtdOG;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id q9-20020a9d66490000b02903c741e5b703so1488348otm.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Jun 2021 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=XvxEOLwMhZ82wCcHK9mAwR4q+NMfFDzySlKWNccDkuk=;
        b=SclTtdOGGaP+4MtZX+eNoI///NvfDJjOW6Yy0hX/ZnIeegGPpmE2fnDhE1AEHTa4E3
         H1xGvpZYUeQRMwr0nvPfBkJQexrU9WOMMQqITSAhX+IzNfH5zWnAeN+gTTX1qLg9a9Vg
         bpK1Ks9aZVpOQYwDS8+uIyNuNqknpnxsq4DoHWK8udactmCaL9EXcAdKgx/dWbcuO7VI
         ye+4PHZUmVXMUPbtmcYq35SIEvckTq9ijsQSPjyhsgiAYKRchs4rVeFg0b4hz5kmjVmt
         Qn8To+4jnpvd2SGy57/APS5eZRRNSk1Wy972pgs47fW9WMVO/hajuicQxUew5zQPOSie
         1vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XvxEOLwMhZ82wCcHK9mAwR4q+NMfFDzySlKWNccDkuk=;
        b=IsLwGRR1OzumYGaGsiSHd1PomQSX/74HWbhxyr9YLQdXjcIpsJRC+Yu9DCpfZRJwgH
         H03vhM+Ijtv4sXsYcw+LLVFpnWjEPFaDJQ6KRsvD1cYn8+3ulPS1PU+2+tGGV7OFtcxR
         tvdiruVlvRhJmxmzkVC5fB+cKK9nfKSU1kec8bqq03dpYxykMtDOewEq5wZZZ+rR/KXV
         hDHI5RHa8gpWY5YxHmr2xN46SRZnC3Eng93SIgQ3JDRiPmhdAJ4O75YhkSSEuN/xdOKZ
         jbyBDl8AWlt4vcsM5bQAVr8ZZ7o0MiSTyvZM1dE8FhHd6JcpVMsrythh2inmZRAXLO4N
         gn4g==
X-Gm-Message-State: AOAM530NuqVU6S31uRKT+l9Jkz78pCQYZE7wLEcWYeV9/6PdTAt2mFkB
	eIBCt5DiysSeufrrgbg9wmI=
X-Google-Smtp-Source: ABdhPJyJXwUMNjZbD33F2bjM/hXNwFiYIFFMfLTIK2axqUpa1cWwEd9gK6P9ppNht2VMhNjkwymCUQ==
X-Received: by 2002:a05:6830:12c6:: with SMTP id a6mr26507440otq.43.1622644710676;
        Wed, 02 Jun 2021 07:38:30 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id l27sm171655oof.35.2021.06.02.07.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 07:38:30 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [PATCH 2/4] asyncrpc: Avoid duplicate sockets in TCP server
To: Paul Barker <pbarker@konsulko.com>, bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20210528084209.8408-1-pbarker@konsulko.com>
 <20210528084209.8408-3-pbarker@konsulko.com>
Message-ID: <458972f1-0f01-76f3-9f88-d00291f13544@gmail.com>
Date: Wed, 2 Jun 2021 09:38:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210528084209.8408-3-pbarker@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 5/28/21 3:42 AM, Paul Barker wrote:
> Calling asyncio.start_server with host='localhost' results in two
> sockets being opened with different port numbers (one for IPv4 and one
> for IPv6):
>
>      NOTE: Listening on ('127.0.0.1', 38833)
>      NOTE: Listening on ('::1', 42029, 0, 0)
>
> This is unnecessary and can be avoided by passing host='127.0.0.1'.

Is this causing some sort of bug? I think it would be better to do the 
expected default python behavior than try to work around it.

>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> ---
>   lib/bb/asyncrpc/serv.py | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
> index fd91aa71a..003a118b7 100644
> --- a/lib/bb/asyncrpc/serv.py
> +++ b/lib/bb/asyncrpc/serv.py
> @@ -142,6 +142,9 @@ class AsyncServer(object):
>           self.logger = logger
>   
>       def start_tcp_server(self, host, port):
> +        if host == 'localhost':
> +            host = '127.0.0.1'
> +
>           self.server = self.loop.run_until_complete(
>               asyncio.start_server(self.handle_client, host, port, loop=self.loop)
>           )
