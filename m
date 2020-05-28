Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.21314.1590698184916894825
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 13:36:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ijkGxpa1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id v19so531327wmj.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=K0VJoq3Z/3hBfC31D1lZ++C99KvId6/dgfWzD4xqJLo=;
        b=ijkGxpa1jKn4GrKwGezJfvT8Ka+beCK3qN6qj2CJ6cQPm5AeDRVbIgRIkU/9CoPYVr
         WGitzHYvHQJ3VxqinMiUJe+GX4M0PheGKaDTv790J15GnQ/qN+MbWK0gM/XMwnDAokoJ
         7/RoTOaKgLab8ajhmyVMcgOLqQ6ULI9owzY+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K0VJoq3Z/3hBfC31D1lZ++C99KvId6/dgfWzD4xqJLo=;
        b=gCkGM0p2ELOQgpCmR3WDTmtNAObvR6eLUZte2qll/O/lFgGkQdvxmihWu/Tf/bR0Kk
         HNGWeuO79QyqD4L150wA35Mcvd5QhbT8OLPevuEXY9hl86c7+6hXiOSKPC14NdxBiBm9
         ftsdSbjWeoCKFcfNmu+s6v4KJYrnL1fVEAGTm+zoQxSytFbjyHWU3cSCN/uGvpvLYLFx
         +pYnu3vvQLaK/C6O3EwlO5YOY5bKEM5slvxQWAFrtYiBOwU/tDcOdQp/x4EwPOQLRUZi
         2dmrocUKQgX46zUazjuFelbofWudtr4p/K6pGTBbu1sq623/ARCsNODXpsbu9/v1uzEK
         JThA==
X-Gm-Message-State: AOAM531UnmPbENsGXorW/bjj0kKEvyzMDh9vX5MGi+opOL5imPdn05N+
	hjxjEv3mLcjcCfpz2Xfa2VOTQg==
X-Google-Smtp-Source: ABdhPJzOwxDU3Snw9s5EfvMrRQmixpBIv2R66l1Ve0NBVRmbFAS6G25MZknthjBqtzi3QWw6rohiAg==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr4693158wmj.149.1590698183391;
        Thu, 28 May 2020 13:36:23 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id d17sm6539620wrg.75.2020.05.28.13.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:36:20 -0700 (PDT)
Message-ID: <3a48b3c5f1b6be4a567730bad72c5d91404992e8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] doc: More explanation to tasks that recursively depend on themselves
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2020 21:36:15 +0100
In-Reply-To: <0a785142-e8b4-fd94-f0ca-5598295121a2@gmail.com>
References: <20200528064115.35703-1-jacob.kroon@gmail.com>
	 <bc07f11a32eb98bfac79aa67bcc838cd1271bb4d.camel@linuxfoundation.org>
	 <0a785142-e8b4-fd94-f0ca-5598295121a2@gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-05-28 at 22:27 +0200, Jacob Kroon wrote:
> On 5/28/20 3:46 PM, Richard Purdie wrote:
> > On Thu, 2020-05-28 at 08:41 +0200, Jacob Kroon wrote:
> > > Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> > > ---
> > >   .../bitbake-user-manual-metadata.xml               | 14 ++++++++------
> > >   1 file changed, 8 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> > > index 95a8b95b..069a0ec8 100644
> > > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> > > @@ -2565,15 +2565,17 @@
> > >               </para>
> > >   
> > >               <para>
> > > -                You might want to not only have BitBake look for
> > > -                dependencies of those tasks, but also have BitBake look
> > > -                for build-time and runtime dependencies of the dependent
> > > -                tasks as well.
> > > -                If that is the case, you need to reference the task name
> > > -                itself in the task list:
> > > +                BitBake allows a task to recursively depend on itself by
> > > +                referencing itself in the task list:
> > >                   <literallayout class='monospaced'>
> > >        do_a[recrdeptask] = "do_a do_b"
> > >                   </literallayout>
> > > +                In the same way as before, this means that the <filename>do_a</filename>
> > > +                and <filename>do_b</filename> tasks of the current recipe and all
> > > +                recipes reachable (by way of dependencies) from the recipe
> > > +                must run before the <filename>do_a</filename> task can run. In this
> > > +                case BitBake will ignore the current recipe's <filename>do_a</filename>
> > > +                task circular dependency on itself.
> > >               </para>
> > >           </section>
> > 
> > I'm not sure I 100% agree with the change. I think the original first
> > paragraph is clearer but it is good to add something about breaking the
> > circular dependency where necessary.
> > 
> 
> I've read the original text several times, and I must disagree with you. 
> I think its easy to misinterpret "dependencies of those tasks" as 
> meaning "the tasks that the right-hand-side listed tasks depend on".
> 
> I think it would be easier to understand if we just wrote something like
> 
> "It is allowed for a task to recursively depend on itself by including 
> itself in the list of tasks. In this case BitBake will ignore the 
> current recipe's circular task dependency on itself."
> 
> What do you think ?

After I went and looked at this in the context of the manual it does
read differently to how I was thinking it read. Sorry, this patch
doesn't give the context needed in this case and I was missing that. I
think you're right.

I'll take the patch, sorry for the confusion.

Cheers,

Richard

