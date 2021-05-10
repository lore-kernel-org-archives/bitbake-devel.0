Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.3677.1620681083483427790
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 14:11:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S9KLeQ3l;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id h4so17998589wrt.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=oe0hJYgL6sq9OnqNtxzHjZaqjLDePax2HcXzxUq2Fuw=;
        b=S9KLeQ3lQ9PJYNWRYMMioKMRRDXKkb4863/I3opBhtbh6vBmJPexi7tcf+XW0OIsiG
         vEUyhRhKnvRZYvmd6XqP9uYa6jiAicgN8tlyjJPwVq3jlyusplu2UR15XTeOIB/8sf5g
         EsjP8rR/RAzLk7MkxC5ulMN7oq9LRPutLjqz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oe0hJYgL6sq9OnqNtxzHjZaqjLDePax2HcXzxUq2Fuw=;
        b=sWKc4g34lzFWLr9fQrqj3XR6SMLEU+7p+6iwGEJaCtqYJ32ywZTOzbDyQSfa98TQN4
         G+a14pmtk8NfSxAHAcRFUhm8mCHFDQ2qnf3cGWCLTtqEcqH7Tv5RHSN2eONwNGe/V0sB
         LlVoQ7ZCGOJq7SCessEkctmrTi8FnvJFdI/hsqmtntmSLkOwrD51BIMiEiAc3owYbNXs
         al4ID1TBRDQDlnIIF3MxJVnYE9W8PTYR0Wm6d5ONOH9Eea6oC5E4TRZ8ky4cnNl9fly7
         jaevzlnuWsJ3qA7lV12g7h/+6QuRWG7b3j2TQntegq8Gwdh2OUV8zXlY+S7xU9UBdjz+
         Wqbg==
X-Gm-Message-State: AOAM5338KpJa5LK5vroml5i0pasyI9Tc+5pAYFG0ZRkRSzJbqAxJ226a
	UgzHopQQSQlrOtQuakW7dSb51z9b/SWzNg==
X-Google-Smtp-Source: ABdhPJxXxQRhwsKG3ApJMY0OmgJz0eL5JQjKpKfFqVOWRvN8EplOkCHGN9CaHUJoG5GnnXTLK7K9Lg==
X-Received: by 2002:adf:aa9a:: with SMTP id h26mr33164329wrc.419.1620681081948;
        Mon, 10 May 2021 14:11:21 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:29c0:3873:464b:b647? ([2001:8b0:aba:5f3c:29c0:3873:464b:b647])
        by smtp.gmail.com with ESMTPSA id k6sm815058wmi.42.2021.05.10.14.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:21 -0700 (PDT)
Message-ID: <008ee8e752e12b71edeb2b59062bec7a32a22bac.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 3/4] runqueue: Fix deferred task issues
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Steve Sakoman <steve@sakoman.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 10 May 2021 22:11:20 +0100
In-Reply-To: <99fa63415cabf3129f149c2cdb557ec18b06b98a.1620655927.git.steve@sakoman.com>
References: <cover.1620655927.git.steve@sakoman.com>
	 <99fa63415cabf3129f149c2cdb557ec18b06b98a.1620655927.git.steve@sakoman.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-05-10 at 04:15 -1000, Steve Sakoman wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> In a multiconfig situation there are circumstances where firstly, tasks
> are deferred when they shouldn't be, then later, tasks can end up as
> both covered and not covered.
> 
> This patch fixes two related issues. Firstly, the stamp validity checking
> is done up front in the build and not reevaulated. When rebuilding the
> deferred task list after scenequeue hash change updates, we need therefore
> need to check if a task was in notcovered *or* covered when deciding to
> defer it. This avoids strange logs like:
> 
> NOTE: Running setscene task X of Y (mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch_setscene)
> NOTE: Deferring mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch after mc:host:/A/alsa-state.bb:do_deploy_source_date_epoch
> 
> where tasks have run but are then deferred.
> 
> Since we're recalculating the whole list, we also need to clear it before
> iterating to rebuild it. By ensuring covered tasks aren't added to the
> deferred queue, the covered + notcovered issue should also be avoided.
> in the task deadlock forcing code.
> 
> [YOCTO #14342]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 3c8717fb9ee1114dd80fc1ad22ee6c9e312bdac7)
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  lib/bb/runqueue.py | 4 ++++
>  1 file changed, 4 insertions(+)

I've now got mixed feelings on this one. We are seeing problems in master
and this change isn't 100% right.

Sadly I don't have a patch which is working in all cases either. I'll aim
to try and work on it further this week. There is a better patch in master-next
but it isn't right.

Equally, the behaviour in dunfell isn't right either :(

Cheers,

Richard

