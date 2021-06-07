Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web09.36103.1623073898285084360
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jun 2021 06:51:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hNEUASQT;
 spf=pass (domain: konsulko.com, ip: 209.85.167.180, mailfrom: paul.barker@konsulko.com)
Received: by mail-oi1-f180.google.com with SMTP id z3so18091531oib.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Jun 2021 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+w39TIn8f3GprYzbG1yti++yADgsq8bAI5hj5Kff1rc=;
        b=hNEUASQTf0z+8TCvyE1vtn4CxS7lX2ivMNIEnwNXpviNCkDe+qJQJc03fXNVzQx66l
         2plzVoDPl2Eu9u/KBntNGumN+K2bKf5CKkuaAUNSagJZqVM6reotSp29BGOO/NnI1kvp
         Y9+8hR+VspbjoLwL0O4K/kV6AKff/KgHlklD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+w39TIn8f3GprYzbG1yti++yADgsq8bAI5hj5Kff1rc=;
        b=dlXYKwFFUPvyz/6BKIcdGrNtADb+lswZoCn1mKg/capkRMsOVqlsYin9Xce4z9IbvJ
         O7/UFueWb8u2y7LGw1ZzSMCbUd3aoiGsGC/sKlJzAySaKhymTrFoVfvbXAqLSOrvtqgV
         xzLbeuOjxn001xqgosieGyMtT6h/SVO7PajTfnfPKupNM6EFjJx4yYBGUj8UYgEW9UWY
         ABpezTC+QS9hTr2znMqUPKRIGV5SE+2Xnn/FrTEn+9Vb017cKy6NdLCJUHJawe9EmzEe
         EBECCppqCAifN69xRHXy7SGUHArTme8ZK4W0S+nXNKWUgjxl9Z4ug0GUpEvGth9A7g96
         xd7Q==
X-Gm-Message-State: AOAM530MoMbJzj8occb1HaE+iGfGJxVpH2A5/5soQhIBZ2BgPnMFNqG5
	pQW9HhlNMe0rFc4plov/Sv6WetjohdMcZDLpPgBnAQ==
X-Google-Smtp-Source: ABdhPJw5YAViSX7zw4158qCby2e3G+iWHsuXc9EFR8nrDhw6MZrp9pISKXZHl16KVHzZ5JmJhU9yGqJmUM0fIRplIu4=
X-Received: by 2002:aca:4554:: with SMTP id s81mr8361530oia.152.1623073897675;
 Mon, 07 Jun 2021 06:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210528084209.8408-1-pbarker@konsulko.com> <20210528084209.8408-3-pbarker@konsulko.com>
 <458972f1-0f01-76f3-9f88-d00291f13544@gmail.com>
In-Reply-To: <458972f1-0f01-76f3-9f88-d00291f13544@gmail.com>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Mon, 7 Jun 2021 14:51:27 +0100
Message-ID: <CAM9ZRVtV1v5J5C6hNoPGZRRi2tTH-7=ih0au27C4pqNLOBoVVg@mail.gmail.com>
Subject: Re: [PATCH 2/4] asyncrpc: Avoid duplicate sockets in TCP server
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jun 2021 at 15:38, Joshua Watt <jpewhacker@gmail.com> wrote:
>
>
> On 5/28/21 3:42 AM, Paul Barker wrote:
> > Calling asyncio.start_server with host='localhost' results in two
> > sockets being opened with different port numbers (one for IPv4 and one
> > for IPv6):
> >
> >      NOTE: Listening on ('127.0.0.1', 38833)
> >      NOTE: Listening on ('::1', 42029, 0, 0)
> >
> > This is unnecessary and can be avoided by passing host='127.0.0.1'.
>
> Is this causing some sort of bug? I think it would be better to do the
> expected default python behavior than try to work around it.

The default behaviour confuses me but I guess if it doesn't break
builds then this patch can be dropped.

Thanks,


--
Paul Barker
Konsulko Group
