Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB184C64EC1
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.15237.1648925109772147982
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 11:45:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M3jKzd1J;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id
 bi13-20020a05600c3d8d00b0038c2c33d8f3so5311156wmb.4
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=J8QtfolajWT/UbrMD7cKcliDANxjZ0JKDkBe7i3cKGA=;
        b=M3jKzd1J7BqD6PIGo6u1wvejptTv8dlUJzR6Ot5AQ+y6CL5HatlmzEg5pPaJRAnlw4
         v0vMBdOVpi5dKcFPIhae45zREocLUcC+tsLTsri/pRYnnk1L3MswOey/YqVkul9YclKS
         DIUs7LGgCPhXEcTqdgh3dzSGHqaHFrs8qqiek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J8QtfolajWT/UbrMD7cKcliDANxjZ0JKDkBe7i3cKGA=;
        b=8LeIHjW75F8sW7uZv8tM3VEGEDl/vhAbSb2gfv4JBeEzGz1wzaYJF5xQJLwAu6NbEq
         eNr5btm+YPFhbqN05l1yVy8DlEjrKfUztLVCNeo6VF/sFsuGTcDDbzvyLTF97FIeI0Sf
         iAl2uSl5vHR8raGsb4513zOByp4ThJXBas2kWwcktxLsAEGxG4u9YJ6ZU1BTijY22EjL
         jdIGX+7ok3I6i30/hK8JskrxWQXB89rCeQQ8uy/JdeNf09QQRf6Xezgn2XZydn/e4k3X
         UcckpQu5ZUE5AycRBhTxGymNc9BK5Lw2GXsepStFuIdVSz8oYCZoNj+YmdaCXV3HP1y2
         knrg==
X-Gm-Message-State: AOAM530VktfMhFKyuqaMdM9O8mTymR2asLrh7Nt/gEVvLrwWwi1RnAHt
	OF+NlhrsOV1pOPPPUyOWgtT7yg==
X-Google-Smtp-Source: 
 ABdhPJwy52z4HNfP0l6JCQsi58katm5HibxuqeFnnQyWBqTjpk7hea0eXmQivAvIa6uTK5TeQGpO0Q==
X-Received: by 2002:a05:600c:1989:b0:38c:b8b3:8fa8 with SMTP id
 t9-20020a05600c198900b0038cb8b38fa8mr13662882wmq.18.1648925108219;
        Sat, 02 Apr 2022 11:45:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c5e1:7b92:5e42:dfdc?
 ([2001:8b0:aba:5f3c:c5e1:7b92:5e42:dfdc])
        by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c4f9400b0038cbd13e06esm13305923wmq.2.2022.04.02.11.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 11:45:07 -0700 (PDT)
Message-ID: 
 <9011cfbd05f3af7a3b8dd09bca6eb6d004f2e1cf.camel@linuxfoundation.org>
Subject: Re: gc warnings lock bitbake server
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 02 Apr 2022 19:45:02 +0100
In-Reply-To: 
 <CAJdd5GYENUxOvMPRh8bx_2VJSVFuQrJFuXQPdoShDDuTGx1R2g@mail.gmail.com>
References: 
	<c776f10054370657c09189ec43090250c9fe8887.camel@linuxfoundation.org>
	 <CAJdd5GYENUxOvMPRh8bx_2VJSVFuQrJFuXQPdoShDDuTGx1R2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13570

On Sat, 2022-04-02 at 08:53 -0500, Joshua Watt wrote:
> 
> 
> On Sat, Apr 2, 2022, 3:44 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > I noticed yet another hung oe-selftest on the autobuilder with memres
> > bitbake
> > enabled. I was able to log into the system and backtrace the hung bitbake
> > process (gdb -p <pid>, then py-bt). The result was the trace below.
> > Basically
> > it
> > shows python doing garbage collection within our locked critical section in
> > the
> > event handler.
> > 
> > The cause of the issue is a warning message being thrown up by gc for an
> > unclosed asyncio event loop. I have patches in progress to try and fix that
> > event loop issue but this does show that warnings triggered by gc are
> > painful
> > for us and we need to address that.
> 
> Nice find. So IIRC, there are two issues: The first is that asyncio is
> creating a lot of warnings, and the second is that warnings from the garbage
> collector can deadlock bitbake?

Yes, exactly. I've added couple of patches to master-next to try and address
this. One disables gc when we're taking the lock. The other tries to stop the
asyncio event loop issue as I think I spotted where we leak it.

Unfortunately -next is showing an inotify issue now which doesn't make any sense
:/

Cheers,

Richard


