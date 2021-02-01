Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web10.34266.1612188571990890657
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 06:09:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Cu9dE/8a;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id y72so4271931ooa.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 06:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=297vikbPqj0azIjNneh/tagb/fKVgIFwLLeIA+4W1RU=;
        b=Cu9dE/8apDXIahhWuqVep71yWsITjrS8iwrrbn79C/N8efvDwtsFLkPtUhUvDwP91W
         mJxZiJD2fDHASY5CZXAgiwey0USOZeZP2WLZKHDYBCjB9hrwGxepWldiLQZCm3i9ZuLI
         IC43AKh0mDr23Fmo92mrP0gjk82JbiE9oOc6PzbGEEu3W2pb0ANl7Cx+sHWrweh38c6X
         9EqenNhZuYSviMy+aYxbVpdfBlKMKcYAQ92Q9ZAQ4SD8+egb53Ls9fZRAD/NZ8tYlnfW
         RkbgA4/660TdkzcjJ2offHlJB5gm3oHK0CVdwblieMAKsEWebVJuYzf7LMWKBeRlNI+w
         zG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=297vikbPqj0azIjNneh/tagb/fKVgIFwLLeIA+4W1RU=;
        b=rSblTsQ3lvC1hD5M1jprCLJnlFguyXQpKw+kF5VeTGSz6vf/aqPe1L02rEF3OEXrbt
         Li8N+hWZkJu/0QXiSR35VNKmoD61fjsfy0P/MloMuyZrMlDkumt16RjDE95id66z+XMX
         iJ9S3fO/ytBGNLZxMM1TbrBvvA2Y2skag+D4x1wXrLJRiGUD20KE5t4iszZtL4x+2gyw
         UMJVJBtZ4gWidtu35UbPs7crrYJSm5Tsgo+GCtWjF/XP6WoWG9pj+osd87xK7zqCOgyj
         Gls0XtznRO9Of94d5uqt0LISUTjSn1MldMSR1fFhkBUVwQRHvFxGGroM35MJ6y5uI7ob
         4eGg==
X-Gm-Message-State: AOAM530L4tDe+aJPh7UnaZ9KqHa2C5gBaWy8VziQ7aTPzDatsdpUw0N9
	3FDU4QWb8QM9WGZteG82uZQ=
X-Google-Smtp-Source: ABdhPJxMzwRsFvVqCr58DWnUt1qRjkQv1TqJxYv1soD64O5Fl5LpPvNzo//ldmjhfqLIdlcRLakiHQ==
X-Received: by 2002:a4a:dcc6:: with SMTP id h6mr12137650oou.89.1612188571280;
        Mon, 01 Feb 2021 06:09:31 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id f139sm2047111oig.28.2021.02.01.06.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:09:30 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [RFC PATCH 7/8] hashserv: Add get-outhash message
To: Paul Barker <pbarker@konsulko.com>, bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20210201115331.13510-1-pbarker@konsulko.com>
 <20210201115331.13510-8-pbarker@konsulko.com>
Message-ID: <2f0effbe-7839-0814-0de5-503d5a741998@gmail.com>
Date: Mon, 1 Feb 2021 08:09:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201115331.13510-8-pbarker@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 2/1/21 5:53 AM, Paul Barker wrote:
> The get-outhash message can be sent via the get_outhash client method.
> This works in a similar way to the get message but looks up a db entry
> by outhash rather than by taskhash. It is intended to be used as a
> read-only form of the report message.
>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> ---
>   lib/hashserv/client.py |  6 ++++++
>   lib/hashserv/server.py | 28 ++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
>
> diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> index 0b7f4e42e..e05c1eb56 100644
> --- a/lib/hashserv/client.py
> +++ b/lib/hashserv/client.py
> @@ -170,6 +170,12 @@ class AsyncClient(object):
>               {"get": {"taskhash": taskhash, "method": method, "all": all_properties}}
>           )
>   
> +    async def get_outhash(self, method, outhash, taskhash):
> +        await self._set_mode(self.MODE_NORMAL)
> +        return await self.send_message(
> +            {"get-outhash": {"outhash": outhash, "taskhash": taskhash, "method": method}}
> +        )
> +
>       async def get_stats(self):
>           await self._set_mode(self.MODE_NORMAL)
>           return await self.send_message({"get-stats": None})
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index b1e8b2f89..054791b8b 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -152,6 +152,7 @@ class ServerClient(object):
>   
>           self.handlers = {
>               'get': self.handle_get,
> +            'get-outhash': self.handle_get_outhash,
>               'get-stream': self.handle_get_stream,
>               'get-stats': self.handle_get_stats,
>               'chunk-stream': self.handle_chunk,
> @@ -289,6 +290,33 @@ class ServerClient(object):
>   
>           self.write_message(d)
>   
> +    async def handle_get_outhash(self, request):
> +        with closing(self.db.cursor()) as cursor:
> +            cursor.execute('''
> +                -- Find tasks with a matching outhash (that is, tasks that
> +                -- are equivalent)
> +                SELECT * FROM tasks_v2 WHERE method=:method AND outhash=:outhash
> +
> +                -- If there is an exact match on the taskhash, return it.
> +                -- Otherwise return the oldest matching outhash of any
> +                -- taskhash
> +                ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
> +                    created ASC
> +
> +                -- Only return one row
> +                LIMIT 1

Since this is the same query as handle_report, lets pre-define the query 
like we did for FAST_QUERY and ALL_QUERY so it's not dual maintainence.


> +                ''', {k: request[k] for k in ('method', 'outhash', 'taskhash')})
> +
> +            row = cursor.fetchone()
> +
> +        if row is not None:
> +            logger.debug(1, 'Found equivalent outhash %s -> %s', (row['outhash'], row['unihash']))
> +            d = {k: row[k] for k in row.keys()}
> +        else:
> +            d = None
> +
> +        self.write_message(d)
> +
>       async def handle_get_stream(self, request):
>           self.write_message('ok')
>   
