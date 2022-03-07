Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1916FC433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 15:48:07 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web09.28019.1646668085545473763
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 07:48:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ggXDunxm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id q20so7110022wmq.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=MyU1H1LlTXooA7SWvsYEVslseFJYBXvtRCvE5EAPJCo=;
        b=ggXDunxmhIvb4nww9Z0EPer+LzMcTzP407U45tn1JoaOB5AnLWrYKL5qODbqvM1h1F
         OCzObQyCtdHGZMK3dIGktfc/1JNtAJdrMZjt4tlYHUntloOVrXM5PXqCHB8Dh9uBmgw5
         U8vOA/xgKkp6fbdBd37gdZ77N/KLFwoSIfpJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MyU1H1LlTXooA7SWvsYEVslseFJYBXvtRCvE5EAPJCo=;
        b=plEjZUk5wv/Xwv804fN+foKduqzlCn7YH+fcDWwEQG6vmNy/Mr2ZoZxoN86osVGeHY
         uq5w7I+uuBNl5ljHI79aTaa32JH4pLWKdtCeixTfAi5sdywKeAEUXWW4OJkJ2PwqFiQf
         s03do3dRhMjchsIx7M5vplQMLw6ennEocDQM9cV4TOwB1CPAr1SUDt2qrN+H3jpLaR/u
         udz0mOAt2rxoxdxXUf3XhZP1EYu13e3KFjXNkixb9Ju3REcBeryL1Ntt4SG4egPqfIgm
         /9YmepPJ/DwZSpV+llukD5iLXGWsR1+GFtjVdtPPI9zxDppq9Na1KBnBzwFweVQotsya
         kS2w==
X-Gm-Message-State: AOAM533WtxqBht4pkLs6E8ze4Q0D7+toOM+xAFVxQEXVVsTrjyi45uiV
	Oc8OxEXwQoDJ5doNDC/bjVE6bHHUm7vAIUsR
X-Google-Smtp-Source: 
 ABdhPJwEOZDfk3XQc6iVeKuuvMa12SdbpP+IUISGhStU8GcrMvQKBSjSjmiO6Ohx4axAVDXaNukkjQ==
X-Received: by 2002:a1c:a7ce:0:b0:380:eb26:f41a with SMTP id
 q197-20020a1ca7ce000000b00380eb26f41amr18607924wme.105.1646668084119;
        Mon, 07 Mar 2022 07:48:04 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:bb31:2700:8490:fdf8?
 ([2001:8b0:aba:5f3c:bb31:2700:8490:fdf8])
        by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b00381614e5b60sm20957429wmq.34.2022.03.07.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:48:03 -0800 (PST)
Message-ID: 
 <6ce6730badc71ed1d136bf14044a23c038efaf17.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/3] knotty.py: Give the setscene tasks
 their own progress bar
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 07 Mar 2022 15:48:02 +0000
In-Reply-To: <20220307133620.12404-2-pkj@axis.com>
References: <20220307133620.12404-1-pkj@axis.com>
	 <20220307133620.12404-2-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13432

On Mon, 2022-03-07 at 14:36 +0100, Peter Kjellerstedt wrote:
> From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> 
> In commit 8055ec36 (knotty: Improve setscene task display) the setscene
> tasks got their own line in the task output. However, the progress bar
> code does not handle newlines in its widgets, so the length of the
> setscene line was included when calculating how much space is available
> for the progress bar of the running tasks, making it much too short.
> 
> Instead of trying to teach the progress bar code to handle newlines,
> give the setscene tasks their own progress bar.
> 
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/ui/knotty.py | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)

I'd much prefer not to add yet another confusing progress bar as it will just
confuse users more. The real progress to watch is the real tasks one and that
will increase as setscene tasks are covered.

Adding this draws the user's attention away from where they probably want to be
looking. If you know otherwise, you don't need the progress bar IMO.

Cheers,

Richard


