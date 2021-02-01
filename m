Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web12.34279.1612188401678651375
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 06:06:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=KO2J3E5p;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id j25so18914024oii.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 06:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=N18n63h/8Mv1LPvtqwz2ahSGtXoSepSzk9/5+EoRdxc=;
        b=KO2J3E5pqyWs6Tu+gqVVPKhHQS8p/VrGaedoyugEIChnht8ig5U2ImSKyK9VVeSk9j
         KZxdAYQRr9E25Iv5d/uijmLyclmY9LboHlWa2IiyMjKWpj4N2JPFs3k75tvJ4CUZP6YF
         7HbwJKmQlHL/vX569ULs5iZrW/QfUVjwa2Z9/0/bGgQu2uKTDO1wuJ1oCCX8mQ2NAyup
         /eOeSpG1ApG/6n96UDhXY5Q5PO+zjwIz36fvRt90pxmgStfBezouISmuYZZhYi/YgPq9
         PkbpDBd1EuzmI9svR+9NIzTkN3sqjfAykKJArRsLymNyXiykrti5IGIjuxKAxCxE0Vqv
         SRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N18n63h/8Mv1LPvtqwz2ahSGtXoSepSzk9/5+EoRdxc=;
        b=uPatOY4u47lXI/kGK3GHxW0GwhiH1IPrhHcFkeT5Rh1xN9bsrQOaJ/mjDSWEi0K/n4
         Gex/8ucOILayjchaZWEroKQa1UjI9kMlCQLof0tIbwlvDDScxY1G8nXwxJ8Um6v9FCLT
         elVDTdY9XzYgM34GTQgBetQ8ScBVsDjNjv72eerWjGsvAmjWI5044hjcznU17cfQzxKN
         qn42XFku/0kzW5Mvh0F8hPgOIOckXXONQfTfIlefOOwH2Bi5/Ua9SbroMwxVWblHql5v
         F/ZEGZ+Qcxy9zJMr/UfpAfvTLY1gj0i/bW4K7vhjFGtmZH/GlPY+CfAKQk00WXaR1QWV
         wbSw==
X-Gm-Message-State: AOAM531AFaAOL2jV0bBGDBdNIKEMPt1Hnm+hXtn65d3/0Jmr/uLq0wlA
	9M0bN1VG22Hg1G0ev3vKpw4=
X-Google-Smtp-Source: ABdhPJy0qss7CmN+58V/K4P9KaQaDo1a0coP+XjsGKFK2J2j+OzrovlrpUfAQKK61dJ+Zha+dd8Wtw==
X-Received: by 2002:aca:1901:: with SMTP id l1mr11176379oii.171.1612188400945;
        Mon, 01 Feb 2021 06:06:40 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id z10sm3940608otk.8.2021.02.01.06.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:06:40 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [RFC PATCH 8/8] hashserv: server: Support searching upstream for outhash
To: Paul Barker <pbarker@konsulko.com>, bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20210201115331.13510-1-pbarker@konsulko.com>
 <20210201115331.13510-9-pbarker@konsulko.com>
Message-ID: <8452c958-3f0d-a685-3a0a-75abd88ab539@gmail.com>
Date: Mon, 1 Feb 2021 08:06:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201115331.13510-9-pbarker@konsulko.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 2/1/21 5:53 AM, Paul Barker wrote:
> Use the new get-outhash message to perform a read-only query against an
> upstream server (if present) when a reported taskhash/outhash
> combination is not found in the current database. If a matching entry is
> found upstream it is copied into the current database so it can be found
> by future queries.
>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>
> ---
>   lib/hashserv/server.py | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index 054791b8b..5fb562b52 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -131,6 +131,20 @@ async def copy_from_upstream(client, db, method, taskhash):
>           keys = sorted(d.keys())
>   
>   
> +        with closing(db.cursor()) as cursor:
> +            insert_task(cursor, d)
> +            db.commit()
> +
> +    return d
> +
> +async def copy_outhash_from_upstream(client, db, method, outhash, taskhash):
> +    d = await client.get_outhash(method, outhash, taskhash)
> +    if d is not None:
> +        # Filter out unknown columns
> +        d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
> +        keys = sorted(d.keys())
> +
> +
>           with closing(db.cursor()) as cursor:
>               insert_task(cursor, d)
>               db.commit()
> @@ -387,6 +401,14 @@ class ServerClient(object):
>   
>               row = cursor.fetchone()
>   
> +            if row is None:


if believe you need to add "and self.upstream_client is not None" here 
to validate that the there is an upstream server.


> +                # Try upstream
> +                row = await copy_outhash_from_upstream(self.upstream_client,
> +                                                       self.db,
> +                                                       data['method'],
> +                                                       data['outhash'],
> +                                                       data['taskhash'])
> +
>               # If no matching outhash was found, or one *was* found but it
>               # wasn't an exact match on the taskhash, a new entry for this
>               # taskhash should be added
