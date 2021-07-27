Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web12.408.1627388791600662902
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 05:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=encpgw0U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso1838600wms.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=dZEdfQlXR1yG4jFCUEuqhW15c+wiaXL675jRPyf69Ug=;
        b=encpgw0UIi0+40UH61smZNJE6NKuNRMA5bwigecm9AfUIfWW4r+JWOb+pmccDWqcXM
         Xd2xNBFU0uj8M65oKSGJO8QDGUlvQoqAJUgoIX/GOILGlVQYjYVR5SYYTnMED5JuPHms
         WhHWWiK4fIw8vGub8+IGfCaDD6fV/SpKDAoGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dZEdfQlXR1yG4jFCUEuqhW15c+wiaXL675jRPyf69Ug=;
        b=hsT9CfBHmPHMPOdSKUyQRSbDWBqbKHKxwmA0gaQD/CdFEqU0sNr8/mJodn7dW0c38i
         Hw09XHn+L1Fa8MxH+6tdAHCl7QIkUKw/rO2obeGbQuZbLZODZAfKdXJSG+lOjkhMIage
         O3C3oIhxIwwazZiVn+Ev57y9215fGI61A3yUu1OjH7O90zyoBrnF1JX70P9yjHLod4UQ
         UssUmlhaIeCS4DWkQyPAPCi0NAueFkQeUOhRyaz25p4D6E1+u2h3yIunDP1gyUbu6zAG
         3vRQ8WUepX4jSo6PUHsZJd2uYCP6wt1VcY96lp4I65l8Xl1b6Tah26xsolU92fnZe+r4
         j4Ng==
X-Gm-Message-State: AOAM532DQYidz+RXZ3i8Wm2zGizntZP+9Ep3iNtovm/iBFNAqtXs4UnD
	+Ia6g3Zu3iq2HPadDdQuyCboCw==
X-Google-Smtp-Source: ABdhPJzQZj8BqbQxKotuDlNZrP9mtowfrABbTx1UaG0XQSdD/oKx+aMtePk4PSIBcvtkRQi7YffgRQ==
X-Received: by 2002:a1c:1dcf:: with SMTP id d198mr3836132wmd.103.1627388789969;
        Tue, 27 Jul 2021 05:26:29 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4? ([2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4])
        by smtp.gmail.com with ESMTPSA id d14sm2927816wrs.49.2021.07.27.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 05:26:29 -0700 (PDT)
Message-ID: <81fe43acefcf91432e662a0c45a9cbd3e0d7a89b.camel@linuxfoundation.org>
Subject: Re: [PATCH v4 0/5] Re-implement prserv on top of asyncrpc
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Scott Murray <scott.murray@konsulko.com>, 
	bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>
Date: Tue, 27 Jul 2021 13:26:28 +0100
In-Reply-To: <cover.1627352176.git.scott.murray@konsulko.com>
References: <cover.1627352176.git.scott.murray@konsulko.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-07-26 at 22:37 -0400, Scott Murray wrote:
> These changes replace the old XML-based RPC system in prserv with the
> new asyncrpc implementation originally used by hashserv, and add a
> read-only mode to match the hash equivalency server's support.
> 
> Changes from v3:
>   * Scott Murray taking over upstreaming effort from Paul Barker.
> 
>   * Dropped patches which are currently applied to master-next, this
>     series should be applied on top of the current master-next branch.
> 
>   * Patches 2-4 updated by Scott Murray to rebase on top of 3983643
>     ("bitbake: asyncrpc: Catch early SIGTERM").
> 
>   * Read-only PR server support patch added to stack to get it into
>     the review process.
> 
> Paul Barker (5):
>   asyncrpc: Wait on writers to close with Python 3.7+
>   asyncrpc: Ensure that asyncio shutdown is clean
>   asyncrpc: Handle exceptions
>   prserv: Replace XML RPC with modern asyncrpc implementation
>   prserv: Add read-only mode

There is an odd failure on the autobuilder which seems related to this.

https://autobuilder.yoctoproject.org/typhoon/#/builders/75/builds/3746

and looking at the bitbake-cookerdaemon.log:

1958 12:03:42.046562 Running command ['clientComplete']
1958 12:03:42.046659 Command Completed
1958 12:03:42.047003 Processing Client
1958 12:03:42.047061 Disconnecting Client
1958 12:03:42.047215 No timeout, exiting.
1958 12:03:42.147541 Exiting
Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'
Caught exception: type object '_asyncio.Task' has no attribute 'all_tasks'

with this last line repeating a 'lot' (log is over 1GB in size).

Cheers,

Richard



