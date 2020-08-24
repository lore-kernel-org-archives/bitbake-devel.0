Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.190657.1598256126166008463
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 01:02:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T1zTFCDm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id b17so6901286wru.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ztZbJgVCAcF8hzSa0GmPZRToLXdySRe/ampxnfhJHsY=;
        b=T1zTFCDmt951F7s2X7nFZOnFekdv1wj4fXbgwRnLl8Pv+oIofeFPtutkgUXmn1qmPu
         H1pVyc2Uu67MN/l0PLNs/7BglKUCMxaIw5r/95f6zW+/dewdYBI7g+Et0v8+89O233El
         LmyDS/HRCHO0HOWW0uXVmTJqnCHT07HsyDlLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ztZbJgVCAcF8hzSa0GmPZRToLXdySRe/ampxnfhJHsY=;
        b=OK9tfr1Z1yZG8Og3AucSzVquLmDem1W7gZR404VYHWFxn13IPkIKwlQj+Qndmvjooi
         qs6H07X4GNwNvnbhY5sffeeiVKZGn3T95zTCgluYwIRLFyzpaBIq2yk15z2XfcuL5Pgp
         kQYOVew5HEXQLf3noOrrXknkctVellCPpfoLrhqJ4VNQ+IE+Os6LIDHqnujsWwB/RcU1
         kfe7mgHgQsgb4xY9V2qmU4iYKE4zj1Ts/Wu/hZzZ8jAaBTEW0FwP8qKkSTI5bDrwE+wQ
         buJ/8KIVqieY0sfQhnmGB0eOcQq2bmj6ENlxqLghosrF8bP1aT5C2QMs/Y6lpifwU9eu
         1dkg==
X-Gm-Message-State: AOAM533hXqK4rHIeZUlgF66sMqjL+y8Jk+aksrwirdO9OFZeXmEZtCBv
	NF1E/QxvFgQYq60N9/9jWjiyFUEXphOK7h6m
X-Google-Smtp-Source: ABdhPJyncA18qBy0keh7+EDTNF6IL1mp7XXaPb9zyOQF+r0OkfrjQaOeJGEUKpoFz64MeydSsvYaZg==
X-Received: by 2002:adf:de08:: with SMTP id b8mr4417132wrm.4.1598256124033;
        Mon, 24 Aug 2020 01:02:04 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id h6sm22300181wrv.40.2020.08.24.01.02.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 01:02:03 -0700 (PDT)
Message-ID: <a990e7dd869eb9f9cc5f53f17a36eab181a5c87b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] server/process/daemonize: Use sys.exit(), not os._exit() for server
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Aug 2020 09:01:54 +0100
In-Reply-To: <162D9CC75E66F9C7.7353@lists.openembedded.org>
References: <162D9CC75E66F9C7.7353@lists.openembedded.org>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2020-08-22 at 15:16 +0100, Richard Purdie via lists.openembedded.org wrote:
> By using os._exit() in the server, we confuse python programmers no end
> since atexit calls, along with threading cleanup calls are skipped. We're
> careful about the environment the server is created within so we should
> be able to use sys.exit() here and have things behave as the python devs
> intend.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/daemonize.py      | 4 +---
>  lib/bb/server/process.py | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
> index f01e6ec7cc..0ec5ef3986 100644
> --- a/lib/bb/daemonize.py
> +++ b/lib/bb/daemonize.py
> @@ -89,9 +89,7 @@ def createDaemon(function, logfile):
>          traceback.print_exc()
>      finally:
>          bb.event.print_ui_queue()
> -        # os._exit() doesn't flush open files like os.exit() does. Manually flush
> -        # stdout and stderr so that any logging output will be seen, particularly
> +        # Manually flush stdout and stderr so that any logging output will be seen, particularly
>          # exception tracebacks.
>          sys.stdout.flush()
>          sys.stderr.flush()
> -        os._exit(0)
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 65e1eab527..b03d64391b 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -492,6 +492,7 @@ class BitBakeServer(object):
>              # Flush any ,essages/errors to the logfile before exit
>              sys.stdout.flush()
>              sys.stderr.flush()
> +        sys.exit(0)
>  
>  def connectProcessServer(sockname, featureset):
>      # Connect to socket

For the archives, we can't merge this since it allows SystemExit to be
seen in the parent process, e.g. the selftests when under unittest.

Cheers,

Richard

