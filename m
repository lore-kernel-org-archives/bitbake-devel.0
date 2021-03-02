Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.2031.1614725066813080401
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Mar 2021 14:44:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DaypeNw5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id e10so21323917wro.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Mar 2021 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=R3UvZ7VMA7YGtXCoZ6j2eriiyU4xg4+qMDyWKTS/DaA=;
        b=DaypeNw5mv8zYzE92QN4wA70/TYvkxh3LkUwOUEBKYNuV/GtIurhvdAH8oF86BS1RT
         cb/hTelVEUJOYFscAxk5cWdi3BuQazeUbdnVnzDnWmSGXQqfYn3nQGNknxLIBn75GHp6
         x46ZE7Bl2wNPZV1FCIJDNCXH7z4faKxnbADl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R3UvZ7VMA7YGtXCoZ6j2eriiyU4xg4+qMDyWKTS/DaA=;
        b=meuoVl0Iqf9C+xwCBmxdcmgw6Er6N7bFglQ8u9FqpttLzYlwN6K1N0Ps37LxImWuqW
         rXGKxsoC1doPEyV6Eo82y0dRZ430LFmRcprkHdD5uzWm6XIy03bdnT+ycsVoZ6pk0gMd
         /26X5K273bNHu37ReFwi8TvhAtJZetH2XYn99lJY4lqM0nIY56F793DChoxtYiFkZEEp
         0GvXjbtSowtpZM+TGdlf0Uf/mOWcZOXDxUWJfqqBA4tfr6EjpUlyOecs8NB+Kn3DMqom
         fNIGRgz6C/sx2K/mvFt+MV46wy4TEe8SdmnVpsHgJiUYb7o3hDH3/z7VnHQqGabmhKAe
         MAUg==
X-Gm-Message-State: AOAM531hikLhbXeOhsQ0/XrTwtDJzwm5ytEzjYWp+qGTKBASQz4s5cCC
	2iMQmjSrKz1BEJC2RddsTh/PWg==
X-Google-Smtp-Source: ABdhPJwvYEZNVTADhaHNSXIDD+dnarG+TEgzW/X/3Y/lEXmXS9SxIU9FJYeRAfHo9q7i0EI/HQEQiw==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr21431809wrs.160.1614725065321;
        Tue, 02 Mar 2021 14:44:25 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:fd4c:95a0:62b1:7d53? ([2001:8b0:aba:5f3c:fd4c:95a0:62b1:7d53])
        by smtp.gmail.com with ESMTPSA id 3sm17882967wry.72.2021.03.02.14.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:44:24 -0800 (PST)
Message-ID: <9865e3f23d13ec4e47cdf7299a0c550a1f4e74ca.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] process.py: Increase bitbake timeout and add logs
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Chaitanya Vadrevu <chaitanya.vadrevu@ni.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 02 Mar 2021 22:44:24 +0000
In-Reply-To: <20210302215134.11881-1-chaitanya.vadrevu@ni.com>
References: <20210302215134.11881-1-chaitanya.vadrevu@ni.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-03-02 at 15:51 -0600, Chaitanya Vadrevu wrote:
> We have started seeing "Unable to connect to bitbake server ..." errors on
> our build farm consistently with 60s timeout. Increasing the timeout to
> 300s and logging every 10s.
> 
> Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@ni.com>
> ---
>  lib/bb/server/process.py | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Taking a step back, is it reasonable for bitbake to "disappear" 
for more than a minute? I've not wanted to increase this value
too much as for an interactive user its a pretty poor situation to
stall for delays this long.

We're also seeing these on the project autobuilder occasionally,
they seem load related. Have you any monitoring which says what your
build farm is doing when these timeouts happen? Did increasing it to
300s work?

I have a suspicion its IO load related and probably around syncing
files at bitbake exit that there is the issue.

Cheers,

Richard

