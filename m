Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.50366.1612262988130628684
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Feb 2021 02:49:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Q0qM4WIT;
 spf=pass (domain: konsulko.com, ip: 209.85.128.51, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f51.google.com with SMTP id f16so1931854wmq.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Feb 2021 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=G0jhARm7oE+u8ry1BnFykiI7ily8QEq4V3m6zHEzXpI=;
        b=Q0qM4WIThMIvG9ZR3F/LLVTGYlBu2PiDJIucKTWXlf6lZat8YGf0KY+LUgfBMnQona
         t/NSkoko/a793IeUYRMuEOhYgS2WN5+m9fostUet/b7FsMCFxTQx/817NtKK+QJLDUmq
         qWtmJQySnPjPyvh6LiD9K2lsa3JA+sumcubKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=G0jhARm7oE+u8ry1BnFykiI7ily8QEq4V3m6zHEzXpI=;
        b=l7uRV1H3lIUbuO9sFFjhWAojdOudAznkOiJK0Qddg7WF5bSF4fzf8pJAfaF3wOjzkQ
         MqPeDLVXF0oiUjp7rDFWRAmV+G7w56nMPguOQZwbtRrAm8BpL3FQCDxQRS2a+1aj2WPP
         Kjq4QDCSrNfAmuYXevhixfeqepeqDKaykJbWGZFAeVh9u+mBzsZ/cQ/hQAhDYrmLtONl
         TGeN/OeF3w5KGGflqmW5x0scOWU5MN4bnPpgmbB5CkZqsPAkqkf2MJTnJAaW79G+V/rP
         1qeeVHZWYEeZ0zj/wcbOOq0djS57GrNtsDbTN6NS6AD4Tw9H9uGXTsfpAnO4Dhnl25+q
         GXsA==
X-Gm-Message-State: AOAM532ybW3ovQW1qBzhm8YfHtS7rIPdC/R+jzR7hyJB0GZjpGSOZO5v
	74D1bq/pj9sDIJyZEdv90ejEjd+k3AcZk71L
X-Google-Smtp-Source: ABdhPJxGOnuHSjc1iekRyP8IL5BJp4f+2/5sccZ0aZZljf3LBnfKcZP7Lhcem0xuj6PC50xBRFt06g==
X-Received: by 2002:a05:600c:19c7:: with SMTP id u7mr2968197wmq.122.1612262986735;
        Tue, 02 Feb 2021 02:49:46 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from localhost (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id e16sm31134640wrp.24.2021.02.02.02.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:49:46 -0800 (PST)
Date: Tue, 2 Feb 2021 10:49:43 +0000
From: "Paul Barker" <pbarker@konsulko.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Richard Purdie
 <richard.purdie@linuxfoundation.org>
Subject: Re: [RFC PATCH 7/8] hashserv: Add get-outhash message
Message-ID: <20210202104943.00002a37@konsulko.com>
In-Reply-To: <2f0effbe-7839-0814-0de5-503d5a741998@gmail.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
	<20210201115331.13510-8-pbarker@konsulko.com>
	<2f0effbe-7839-0814-0de5-503d5a741998@gmail.com>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Feb 2021 08:09:30 -0600
Joshua Watt <jpewhacker@gmail.com> wrote:

> On 2/1/21 5:53 AM, Paul Barker wrote:
> > The get-outhash message can be sent via the get_outhash client
> > method. This works in a similar way to the get message but looks up
> > a db entry by outhash rather than by taskhash. It is intended to be
> > used as a read-only form of the report message.
> >
> > Signed-off-by: Paul Barker <pbarker@konsulko.com>
> > ---
> >   lib/hashserv/client.py |  6 ++++++
> >   lib/hashserv/server.py | 28 ++++++++++++++++++++++++++++
> >   2 files changed, 34 insertions(+)
> >
> > diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> > index 0b7f4e42e..e05c1eb56 100644
> > --- a/lib/hashserv/client.py
> > +++ b/lib/hashserv/client.py
> > @@ -170,6 +170,12 @@ class AsyncClient(object):
> >               {"get": {"taskhash": taskhash, "method": method,
> > "all": all_properties}} )
> >   
> > +    async def get_outhash(self, method, outhash, taskhash):
> > +        await self._set_mode(self.MODE_NORMAL)
> > +        return await self.send_message(
> > +            {"get-outhash": {"outhash": outhash, "taskhash":
> > taskhash, "method": method}}
> > +        )
> > +
> >       async def get_stats(self):
> >           await self._set_mode(self.MODE_NORMAL)
> >           return await self.send_message({"get-stats": None})
> > diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> > index b1e8b2f89..054791b8b 100644
> > --- a/lib/hashserv/server.py
> > +++ b/lib/hashserv/server.py
> > @@ -152,6 +152,7 @@ class ServerClient(object):
> >   
> >           self.handlers = {
> >               'get': self.handle_get,
> > +            'get-outhash': self.handle_get_outhash,
> >               'get-stream': self.handle_get_stream,
> >               'get-stats': self.handle_get_stats,
> >               'chunk-stream': self.handle_chunk,
> > @@ -289,6 +290,33 @@ class ServerClient(object):
> >   
> >           self.write_message(d)
> >   
> > +    async def handle_get_outhash(self, request):
> > +        with closing(self.db.cursor()) as cursor:
> > +            cursor.execute('''
> > +                -- Find tasks with a matching outhash (that is,
> > tasks that
> > +                -- are equivalent)
> > +                SELECT * FROM tasks_v2 WHERE method=:method AND
> > outhash=:outhash +
> > +                -- If there is an exact match on the taskhash,
> > return it.
> > +                -- Otherwise return the oldest matching outhash of
> > any
> > +                -- taskhash
> > +                ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE
> > 2 END,
> > +                    created ASC
> > +
> > +                -- Only return one row
> > +                LIMIT 1  
> 
> Since this is the same query as handle_report, lets pre-define the
> query like we did for FAST_QUERY and ALL_QUERY so it's not dual
> maintainence.

Agreed. I'll do that in v2.

> 
> 
> > +                ''', {k: request[k] for k in ('method', 'outhash',
> > 'taskhash')}) +
> > +            row = cursor.fetchone()
> > +
> > +        if row is not None:
> > +            logger.debug(1, 'Found equivalent outhash %s -> %s',
> > (row['outhash'], row['unihash']))
> > +            d = {k: row[k] for k in row.keys()}
> > +        else:
> > +            d = None
> > +
> > +        self.write_message(d)
> > +
> >       async def handle_get_stream(self, request):
> >           self.write_message('ok')
> >     



-- 
Paul Barker
Principal Software Engineer
Konsulko Group
