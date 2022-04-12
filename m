Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E2C4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:42 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web08.8465.1649752786533651964
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 01:39:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=geNkE/5o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id t1so8906795wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=7C0JXwWvqL4quv5wMQs1D3IVO6umfc5mNseHhq3iS4U=;
        b=geNkE/5oEBrDM/orshXoMLaUO14YwP7A+gCveoewwJmBN+MY5wTTSEw7o+Js7Fw2ni
         ZPBILCgHHXXk7pJyObpD4haJ6kMPNEdG4tiUdAEWCE1HXlijRNKedjSc13Pdf2W3dFHq
         hlf1iM1tELfRddWbIRgyZyPgX9N3Bo0cZvHYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7C0JXwWvqL4quv5wMQs1D3IVO6umfc5mNseHhq3iS4U=;
        b=mZ/K3vY3P+HO0DK21vJwz0XA3F0g+TcLfzbIuEpKbPUouIu8UsArg/25GLtmtrTOVZ
         qCvpjryiGDKxIt+yDBA86vVYsIAnow62JQQpcv+Idpl9cC4C0BWWHK65lXmacImcabO/
         EzmXEAadYfJFKkHlrl2EDEOAhzz22fi1SChk1RAtSuV7Y/zLRh0jDBTBEYfybKv9/gmf
         ApsHh1fWNiByVa2A0D5DaOmcdMAjaNH7rwzDkXjbpqzjnZvRMIT/V9TwZHGeP/oX/FVf
         g8CweuBfoRuw5l7xTIz8pX5cvscqNHHvDCA76YUWkJWLDAto48dW2F+8JddQ+vqfYe/W
         79eg==
X-Gm-Message-State: AOAM530X+N9bC8aFi8MAL6t5h7hZuT8AltU/dyErWoQpS2iHTR69WWLe
	d4s5rX6+9yg77qNC3vCFM0ZmHA==
X-Google-Smtp-Source: 
 ABdhPJzTOnwWc5xe3jxnu4pWd7E+Jqu9f9qGoLWCgx+D0/17StzYLHRazwg4CaEObsMAt41NqI1VeA==
X-Received: by 2002:adf:d1c4:0:b0:204:b9d:a840 with SMTP id
 b4-20020adfd1c4000000b002040b9da840mr28115021wrd.285.1649752784963;
        Tue, 12 Apr 2022 01:39:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b168:4a11:27d6:cd01?
 ([2001:8b0:aba:5f3c:b168:4a11:27d6:cd01])
        by smtp.gmail.com with ESMTPSA id
 m7-20020adfe0c7000000b002060e7bbe49sm29315234wri.45.2022.04.12.01.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:39:44 -0700 (PDT)
Message-ID: 
 <77442b51b5b9fdd47a1815b7d6a8804e7b7dd309.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] pyinotify.py: Simplify identification
 of which event has occurred
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 12 Apr 2022 09:39:43 +0100
In-Reply-To: <20220408144430.29768-1-pkj@axis.com>
References: <20220408144430.29768-1-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Apr 2022 16:46:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13606

On Fri, 2022-04-08 at 16:44 +0200, Peter Kjellerstedt wrote:
> Use bitwise operators to manipulate the received event mask in
> _ProcessEvent.
> 
> Also minor clarification & clean up of the related comments.
> 
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/pyinotify.py | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/bitbake/lib/pyinotify.py b/bitbake/lib/pyinotify.py
> index 5c9b6d0fe2..3c5dab0312 100644
> --- a/bitbake/lib/pyinotify.py
> +++ b/bitbake/lib/pyinotify.py
> @@ -595,24 +595,23 @@ class _ProcessEvent:
>          @type event: Event object
>          @return: By convention when used from the ProcessEvent class:
>                   - Returning False or None (default value) means keep on
> -                 executing next chained functors (see chain.py example).
> +                   executing next chained functors (see chain.py example).
>                   - Returning True instead means do not execute next
>                     processing functions.
>          @rtype: bool
>          @raise ProcessEventError: Event object undispatchable,
>                                    unknown event.
>          """
> -        stripped_mask = event.mask - (event.mask & IN_ISDIR)
> -        # Bitbake hack - we see event masks of 0x6, IN_MODIFY & IN_ATTRIB
> +        stripped_mask = event.mask & ~IN_ISDIR
> +        # Bitbake hack - we see event masks of 0x6, i.e., IN_MODIFY & IN_ATTRIB.

What worries me a little is the above is part of the upstream we took this from.
That is why I copied the style below too although we don't have to do that.

I'm torn. Aligning with the upstream code is good but equally it appears
unmaintained now :(. There are other inotify extensions for python but this one
seemed the best for cooker's needs at the time. If we did adopt it, there are
probably things we could strip out as we only use a subsection of the code.

Cheers,

Richard


