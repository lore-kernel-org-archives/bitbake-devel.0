Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.12440.1590673600682081777
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 06:46:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZdJSBj+O;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id f5so3248232wmh.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=e/j5P7GnpJ2CyO5iv7B7uanJSyYCBrZleNrMEJ/cXrY=;
        b=ZdJSBj+OABevZIeFogIjAglVe8hSZj05oBJicU1nclEkT0xZod6P4IbC7ZMKhVjCMJ
         Sv0eYorkfY8bh8IDb+UpzbOOjVajeSVnYnwlrwbAurB252O2S+RkodZNde4hDzGKL51W
         wOihI+dsCPADx9ndNE4/K+tI/SzKsotv/5+6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=e/j5P7GnpJ2CyO5iv7B7uanJSyYCBrZleNrMEJ/cXrY=;
        b=PjW3GBK1QJzdbYVyGqKijkqWBw7SyZo8wu7Z77cvnQ062XZUZP6+vDAu81ihz3rOVT
         ZU7t/F/aXKe6aWMF6AbZlZauk76f/TCsEfqSbZIwYX+TcsdrBPMNEEJyp8epyvkocBxD
         k0buTo1l5kGgfFjzTh3YRdRp/oNjBqurvs2iBFKdZS1JoCjFVUhG29z5ckJGVmdZqGB9
         +/Juat3oXyJyOrgPTga3Ve2dC05WaT6Gqm4S341BHLtb4ivNWXxAd7uOGUKSn/86udIh
         mTGtv2UPWvcU6WmUJhJ09wJpgAjVvVGcy+x/t6Sb97/859RVeDwNKQDAw1sMWsNh/mHx
         J9Pg==
X-Gm-Message-State: AOAM533qld8SGiX9j2OJvZDeirKSnDrTXviQh10/qS+l2EyTY7jsgDQv
	8RD7U3Bxhzy2qnhk4si6LvSdpQ==
X-Google-Smtp-Source: ABdhPJxd6DX+b2Zghsl0YPap3BQZvaiJqn1jgt0oA83IDD2HPkVtNpIu4LikFe+WXXUBpqXyNkTVqw==
X-Received: by 2002:a1c:9817:: with SMTP id a23mr3717774wme.133.1590673599127;
        Thu, 28 May 2020 06:46:39 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id b132sm6900289wmh.3.2020.05.28.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:46:38 -0700 (PDT)
Message-ID: <bc07f11a32eb98bfac79aa67bcc838cd1271bb4d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] doc: More explanation to tasks that recursively depend on themselves
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2020 14:46:37 +0100
In-Reply-To: <20200528064115.35703-1-jacob.kroon@gmail.com>
References: <20200528064115.35703-1-jacob.kroon@gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-05-28 at 08:41 +0200, Jacob Kroon wrote:
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
>  .../bitbake-user-manual-metadata.xml               | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> index 95a8b95b..069a0ec8 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
> @@ -2565,15 +2565,17 @@
>              </para>
>  
>              <para>
> -                You might want to not only have BitBake look for
> -                dependencies of those tasks, but also have BitBake look
> -                for build-time and runtime dependencies of the dependent
> -                tasks as well.
> -                If that is the case, you need to reference the task name
> -                itself in the task list:
> +                BitBake allows a task to recursively depend on itself by
> +                referencing itself in the task list:
>                  <literallayout class='monospaced'>
>       do_a[recrdeptask] = "do_a do_b"
>                  </literallayout>
> +                In the same way as before, this means that the <filename>do_a</filename>
> +                and <filename>do_b</filename> tasks of the current recipe and all
> +                recipes reachable (by way of dependencies) from the recipe
> +                must run before the <filename>do_a</filename> task can run. In this
> +                case BitBake will ignore the current recipe's <filename>do_a</filename>
> +                task circular dependency on itself.
>              </para>
>          </section>

I'm not sure I 100% agree with the change. I think the original first
paragraph is clearer but it is good to add something about breaking the
circular dependency where necessary.

Cheers,

Richard

