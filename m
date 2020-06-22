Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.3478.1592857087272655188
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Jun 2020 13:18:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BNf8BMyp;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id t194so836663wmt.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Jun 2020 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=LedjVQOlO0FtlXs+67JO2KTLYhfAUHd2sbhDwO7cdCc=;
        b=BNf8BMypnEdl3RpcCsPyVDS+xcvOperCxj1L/K4uTNKI6dKYKgKHK5Ci35tVtR+YJf
         UWpqi4jpFQFjuX1qLXV+kc5rA3kfilUT6n26ltpLv75zUtI86yCpK0DlOwGwLh/nNodI
         K3vss6RD8D5+aZOPXyHqigkvOJHPwi1Ku03qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LedjVQOlO0FtlXs+67JO2KTLYhfAUHd2sbhDwO7cdCc=;
        b=raEFPrhm0/4BUuu6NzREbwx3HDlgmXYWy07FdGfxOZ9XqTOpvt886YxOJJucSO3z8I
         PxJ5yk37M9OZ9x906wD2LVye+tr71gjOzEYGU9DpcF0mgBpSgun7T4Jcv+kvwj3IemTq
         sYB3/sjb8aAwEAeb3aac9UDc7xT2w22tNobCaLFO8l/VjSB8bDfy8alHZl9fMDgVV6qy
         /+sp47ycMvK4gFa/6rJ8c5C7A8BdOHS0bAGx7QdgjGnGScrJQc6ylcWdXq7z3TCGYG5p
         yZM5CY+foHivspZTWYG6nX5xV6vQN1L6e0gWh6PNFB4LC2G2XMeg1iNKO+DudL5ikhn/
         2nMg==
X-Gm-Message-State: AOAM533uHQ0VZ2gQb27+ycOdXIAp57tLSYtgA5w1yvxHIZUjQcyIaRYX
	3pmHwY9wSH6d1iCAmkmCnMYLrw==
X-Google-Smtp-Source: ABdhPJzcz8VczmpCJoHW0mBAiQ2GBT/EdQXfw62NdSBWBHXyQe6Qwxp9LZJ2R8MuL5Yq8glKRq7SEA==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr21297623wmh.175.1592857085856;
        Mon, 22 Jun 2020 13:18:05 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id l1sm20839026wrb.31.2020.06.22.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:18:05 -0700 (PDT)
Message-ID: <aa5431eddbc52496d0cc0a2a848489dad6fd0d01.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [fetcher2] perforce fetcher download dir
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Alexandru N. Onea" <onea.alex@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 22 Jun 2020 21:18:04 +0100
In-Reply-To: <CAJgSc4zktj90d5DXXoSa8vE8=F58puwKD0YKUTMA0etGn3U=XQ@mail.gmail.com>
References: 
	<CAJgSc4zktj90d5DXXoSa8vE8=F58puwKD0YKUTMA0etGn3U=XQ@mail.gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Sat, 2020-06-20 at 15:33 +0300, Alexandru N. Onea wrote:
> I just started using the perforce fetcher and I am a bit confused by
> how the fetcher implementation handles the location of the downloaded
> sources. In particular, in cases where SRC_URI points to a directory,
> expressed by the typical "/..." termination, the below code seems to
> prepare the final filename by only taking into account the part of
> the remote path which would follow the "/...".
> 
> if depot_filename:
>     if ud.pathisdir: # Remove leading path to obtain filename
>         filename = depot_filename[len(ud.path)-1:]
>     else:
>         filename = depot_filename[depot_filename.rfind('/'):]
>     filename = filename[:filename.find('#')] # Remove trailing '#rev'
> 
> This comes with a limitation: if one has multiple perforce SRC_URI
> entries, one ends up with a mixture of files, not
> necessarily belonging together. Moreover, the comment is a bit
> misleading, since the value of filename after the removal of the
> leading path is not actually the filename but a filepath, stripped of
> the "visible" repo path given in SRC_URI.
> 
> Of course, there might be a strong argument in favor of this
> behavior, however I failed so far to find it. I am writing to you in
> the hope that someone can help me find the argument and understand
> the rationale of the current implementation.
> 
> If there is no argument in favor of the mentioned behavior, I would
> like to prepare a patch for an alternative where the user has the
> option to either keep the full remote file path (similar to how a
> perforce client would sync the files) or strip the visible SRC_URI
> part of the path, but specify a subdir name for each perforce SRC_URI
> entry in order to keep things separated. 

Unfortunately the perforce fetcher is a bit of a black box to me and
most other bitbake developers, we don't have the tool or any repos to
use/test with it.

We're therefore reliant on users reporting and fixing issues they run
into.

Thanks for your patches I saw yesterday, at a first glance they look
reasonable. My only real concern is whether they overlap with any of
our unpack options. I also wondered if we should be updating the
bitbake manual with any of these new options or more information about
the perforce fetcher?

Cheers,

Richard

