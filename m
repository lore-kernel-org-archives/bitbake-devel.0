Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.50416.1612262940550775595
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Feb 2021 02:49:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iIeux1Pz;
 spf=pass (domain: konsulko.com, ip: 209.85.128.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f54.google.com with SMTP id l12so877057wmq.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Feb 2021 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bzr+q6EepaUHnj5lncXCxLWh2JijU9HA+orByrB6BzE=;
        b=iIeux1Pz9iwXHv9/Yyp3snN5QM1dY6F96VRuXqzMxs5GvQOrhRnjbmyPP5dtJcogrb
         hxVYRRcyQ7Dz0u5XgzTkLRVp7sIkrmuetpgB7FT5N6STOvu/gwv1AxCAHBV7Th6bioXE
         KuN2hghHHYhB4xr9lFhsF2yxCIZmUNjfuGIzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bzr+q6EepaUHnj5lncXCxLWh2JijU9HA+orByrB6BzE=;
        b=okUAZQ+YB0bbyyF8Jk3c1VKqRLbBGJ1t9aRMxPboOrZyUpCX6XDtSdQN2YTctSboJg
         sxiyVT755u/SaLU+voFZbwYqJTkTGpoGX44KDO6aPNvZhWNs76lZToBEUPcBmiijGNVd
         BBmNhhN/EXzZ0toucyB18o2ssPpRcUN46ex1crHx/Z1MyghczyGSVqzLfrFue2NOp60f
         /TCjYj09R8gs+3oDROMVhc9/cSrzyiQWAbCMavnWTF58+RJaLhedfAdSUCi4t8Y2OSXP
         RLBHuHTAzVSWstRcNbNCBWn5JCCc+q4qCKS/Kp3uhVRfg49/obzMUHT+zuYyp+2F4C+2
         pXng==
X-Gm-Message-State: AOAM532LSojCHNlstiK6coYxYBLElunXKDCShJkJVIH45Kwspw7Oe+AV
	BsKUb465DjpaAthZivTbmHCk1A==
X-Google-Smtp-Source: ABdhPJyg02cj6dRyhIrgJ46R+DznvS4JHAsrCvekiUzEEoqvapCtKkY7caO5lZnhYEmpQ1AE9fImTw==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr2916910wmc.35.1612262938831;
        Tue, 02 Feb 2021 02:48:58 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from localhost (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y24sm2334203wmi.47.2021.02.02.02.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:48:58 -0800 (PST)
Date: Tue, 2 Feb 2021 10:48:55 +0000
From: "Paul Barker" <pbarker@konsulko.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Richard Purdie
 <richard.purdie@linuxfoundation.org>
Subject: Re: [RFC PATCH 8/8] hashserv: server: Support searching upstream for outhash
Message-ID: <20210202104855.00005b94@konsulko.com>
In-Reply-To: <8452c958-3f0d-a685-3a0a-75abd88ab539@gmail.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
	<20210201115331.13510-9-pbarker@konsulko.com>
	<8452c958-3f0d-a685-3a0a-75abd88ab539@gmail.com>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Feb 2021 08:06:39 -0600
Joshua Watt <jpewhacker@gmail.com> wrote:

> On 2/1/21 5:53 AM, Paul Barker wrote:
> > Use the new get-outhash message to perform a read-only query
> > against an upstream server (if present) when a reported
> > taskhash/outhash combination is not found in the current database.
> > If a matching entry is found upstream it is copied into the current
> > database so it can be found by future queries.
> >
> > Signed-off-by: Paul Barker <pbarker@konsulko.com>
> > ---
> >   lib/hashserv/server.py | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> > index 054791b8b..5fb562b52 100644
> > --- a/lib/hashserv/server.py
> > +++ b/lib/hashserv/server.py
> > @@ -131,6 +131,20 @@ async def copy_from_upstream(client, db,
> > method, taskhash): keys = sorted(d.keys())
> >   
> >   
> > +        with closing(db.cursor()) as cursor:
> > +            insert_task(cursor, d)
> > +            db.commit()
> > +
> > +    return d
> > +
> > +async def copy_outhash_from_upstream(client, db, method, outhash,
> > taskhash):
> > +    d = await client.get_outhash(method, outhash, taskhash)
> > +    if d is not None:
> > +        # Filter out unknown columns
> > +        d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
> > +        keys = sorted(d.keys())
> > +
> > +
> >           with closing(db.cursor()) as cursor:
> >               insert_task(cursor, d)
> >               db.commit()
> > @@ -387,6 +401,14 @@ class ServerClient(object):
> >   
> >               row = cursor.fetchone()
> >   
> > +            if row is None:  
> 
> 
> if believe you need to add "and self.upstream_client is not None"
> here to validate that the there is an upstream server.

You're right, that is needed. I'll include it in the next version of
the series.

> 
> 
> > +                # Try upstream
> > +                row = await
> > copy_outhash_from_upstream(self.upstream_client,
> > +                                                       self.db,
> > +
> > data['method'],
> > +
> > data['outhash'],
> > +
> > data['taskhash']) +
> >               # If no matching outhash was found, or one *was*
> > found but it # wasn't an exact match on the taskhash, a new entry
> > for this # taskhash should be added  



-- 
Paul Barker
Principal Software Engineer
Konsulko Group
