Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.4861.1596802727904730777
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 05:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BvzcrLHv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f67.google.com with SMTP id p14so1556716wmg.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Aug 2020 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=AEWhhG9T2qy7AisRSOhZ4Qvi3z2yQKxhrC+UmBkfcJk=;
        b=BvzcrLHvmvrF3Y3qivA+RYBjFwDq80JN60vWttJsw8ZQy1W8sqkxAn9/C2YZn/I10T
         LqwoIV+tLadptuRr4WjAxbVcvW45/Ul1tEovkdGCSXqF4FJCObiKsXFu+nIvTobQh6K7
         b2cA9g+c29rPuepD8yVQOld5az5IvimtIRoKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AEWhhG9T2qy7AisRSOhZ4Qvi3z2yQKxhrC+UmBkfcJk=;
        b=ugU7rWB9y3KcFGbSArtdLdB4Bv9RAuL8MXjW3StVqaSaiEm/r2QQrMJQOf4re2Iu4E
         L2NoYjiLRufjsbYOfd32e+ny//mh986DMDLpkyxWfagE/74V66ZDQtvGFkT7P0qKB6IP
         Qmdl3gzFeaJxd2Irf+u4TqBR4xPA5huKuYAc5HKQ+aRroVO8E/+FUUKJvzDvFET7SC2v
         jv5paoZv0HqZToeySk9U73EpCbWirdD+OJA0srDZxNBlXrEuw/NK53se8P5lhu5ZSNDH
         7i9V4E44NvD8NDoQrqa3q7QkigwmtNS8DXE9J8hFfV0tOHvSz9fmAlo7ENw78yk27AMM
         +91A==
X-Gm-Message-State: AOAM531aatJgkTtGAaQl8Vj5EAg78XzOoakuwIxitcqQKBnB+oBLHvmR
	9TWVV6OLC1WRcb6cHFXrHGlFkw==
X-Google-Smtp-Source: ABdhPJzlzCTroZoh7V5AFoBG1dOg8L1nmhTqAHVzFKrEStggc+xojm1fgp11a8oXIiFwMDmY4GOXCA==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr11840482wme.23.1596802726118;
        Fri, 07 Aug 2020 05:18:46 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 7.d.f.c.4.4.6.0.3.1.c.1.f.b.1.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (7.d.f.c.4.4.6.0.3.1.c.1.f.b.1.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:91bf:1c13:644:cfd7])
        by smtp.gmail.com with ESMTPSA id i14sm11975269wrc.19.2020.08.07.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 05:18:45 -0700 (PDT)
Message-ID: <75e480197f67f7605180feed70a14f23b4da6f16.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Fri, 07 Aug 2020 13:18:44 +0100
In-Reply-To: <20200802143505.88409-1-chris.laplante@agilent.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-08-02 at 10:35 -0400, Chris Laplante via
lists.openembedded.org wrote:
> This patch series replaces the one I sent Friday. It implements two
> backtraces when a Bash shell function fails:
> 
> 1) A backtrace within the .run file that BB generated.
> 2) A computed backtrace of the actual metadata locations (e.g. bb or
>     bbclass) where each shell function is defined.
> 
> At one point I had both backtraces implemented entirely in the shell
> traps. I moved (2) to build.py because it is easier to implement in
> Python. One nice thing about leaving it in the shell trap would be
> that
> it would still work even if a user was running a .run script
> directly,
> but it seems like not many people do that. Still, if it's something
> we're interested in, know that it's possible.

This does look really interesting/useful, thanks. I have a long
standing bug to add more information like this to functions!

The one piece I can't quite see there is whether things like appends to
a shell function are handled?

I do sometimes run the scripts by hand myself. Another long standing
idea I keep meaning to sort out is adding the correct pseudo
environment to those functions, even as comments the user could enable
for debugging.

Did you finish the other shell trap code? I think we're probably ok
without that but if you had it working it might be good to put in the
archives?

I'm a bit behind on patch review but will get these queued/tested.
Thanks again!

Cheers,

Richard

