Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.12805.1617719165702691378
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 07:26:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FMllzq+X;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so4302309wmk.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Apr 2021 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=TEcA3G62dDHELO4w2vyiPGu9iLY5eNPWT35RQkxFxO8=;
        b=FMllzq+XOXMXx7QrIuCUEJtUeivPCH2jzwXs8/JYLdohDqhIo6d0Gaq9ex0hduLeRe
         bPH+qgng3YiY0uFxYxugOrv6PvY8FkhD82eIwxhyiWiZp5hRkt3PFE6AI1KVZamGFrTA
         FodKQcqmhhazZqjFJyyHZVDxpVFuz0jtvXEMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TEcA3G62dDHELO4w2vyiPGu9iLY5eNPWT35RQkxFxO8=;
        b=Robdk2Tte5IFFkMCVpvZBSo3ZYaOAG30tx+1in8qNwuM+snHkQ6yveL9WgGiO/prjZ
         AWUO/9uB7N/bRYn/8LV8ifzd8bBeOdFHDB9GFD807Ik+7GN7ei4E9OBF/P2NUqR4UhsT
         RUPV9pdAAtB13rOTlvE9IX/s8dH0gZ68jUfu4wcp9yUyLF6l8CEd5zt7cqZL2xpfHOfG
         gMVUNtZA3Vnr4jqsteq8ww1N1Dhf+GyC+wqXyRRCgtOFkZA5IDL8dyXBzG26G5kxkH2f
         lUTi46qcaWu0PljD9LdbNTtaFXIKGsJKHJ+oTpZw2Cu+ov3fbaE07sTN1kWewEEKOXPq
         zyNw==
X-Gm-Message-State: AOAM533G8lkargUKVoXlkJbfWVa3xJs4unjQS16mTJtWJoLzjGolWp/5
	IxzAoABCw/eq421Fa2tWt32vuw==
X-Google-Smtp-Source: ABdhPJx6muZ/BpHTwxZTrWozV1mttyefHVG5qIXyjX/3xGNic+uQFfS5PdRsXB1Qgtr+ysWzlEKLag==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr4446058wmk.52.1617719163851;
        Tue, 06 Apr 2021 07:26:03 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:7a9e:d3b:5548:6469? ([2001:8b0:aba:5f3c:7a9e:d3b:5548:6469])
        by smtp.gmail.com with ESMTPSA id y8sm3050760wmi.46.2021.04.06.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:26:03 -0700 (PDT)
Message-ID: <91a330cddbd20f81fa40d5f3ce6a3f582f91d200.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Three copies of output from failing task
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: yocto@mac.mcrowe.com, bitbake-devel@lists.openembedded.org
Date: Tue, 06 Apr 2021 15:26:02 +0100
In-Reply-To: <20210330143049.GA23723@mcrowe.com>
References: <20210330143049.GA23723@mcrowe.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-03-30 at 15:30 +0100, Mike Crowe via lists.openembedded.org wrote:
> After upgrading from oe-core Warrior (Bitbake 1.42) to Dunfell (Bitbake
> 1.46), I'm seeing _three_ copies of the log output for every build failure.
> I see similar when using the current state of oe-core master (along with
> the new backtraces.)
> 
> To reproduce the problem, I hacked openssl_1.1.1k.bb:do_configure to insert:
> 
>  echo "an error"
>  false
> 
> and ran bitbake openssl-native. The output was:
> 
> --8<--
> NOTE: Executing Tasks
> ERROR: openssl-native-1.1.1k-r0 do_configure: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
> an error
> WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> WARNING: Backtrace (BB generated script):
>         #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
>         #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> 
> Backtrace (metadata-relative locations):
>         #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
> ERROR: Logfile of failure stored in: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/log.do_configure.32031
> Log data follows:
> > DEBUG: Executing python function extend_recipe_sysroot
> > NOTE: Direct dependencies are ['/overflow/mac/nobackup/git/oe-core/meta/recipes-devtools/quilt/quilt-native_0.66.bb:do_populate_sysroot']
> > NOTE: Installed into sysroot: []
> > NOTE: Skipping as already exists in sysroot: ['quilt-native']
> > DEBUG: Python function extend_recipe_sysroot finished
> > DEBUG: Executing shell function do_configure
> > an error
> > WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> > WARNING: Backtrace (BB generated script):
> >       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
> >       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> > ERROR: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
> > an error
> > WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> > WARNING: Backtrace (BB generated script):
> >       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
> >       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> > 
> > Backtrace (metadata-relative locations):
> >       #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
> ERROR: Task (virtual:native:/overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb:do_configure) failed with exit code '1'
> NOTE: Tasks Summary: Attempted 14 tasks of which 13 didn't need to be rerun and 1 failed.
> -->8--
> 
> Even if I set BBINCLUDELOGS="no", I still get these three copies.
> 
> The first one (without the leading "|" characters) appears to come from
> _build.py:_exec_task (around line 702) executing logger.error(str(exc)).
> This line dates from 2011.
> 
> The second and third ones (with the leading "|") come from knotty.py around
> line 767. They are both in log.do_configure.32031. It looks like the third
> copy is coming from the same place as the first copy, but has been written
> to both the console and the log file.
> 
> If I comment out the previously-mentioned call to logger.error(str(exc)) in
> _build.py:_exec_task then I get the single copy of the task output as I
> would expect.
> 
> Does anyone know what the proper fix for this might be?

Thanks for the report and analysis. I think we should do something about it
but having stared at the code a bit, I'm still not entirely sure what. I think
the trouble is the error is being reported at mutliple levels in the code
and we;re a bit paranoid about doing that as there is nothing worse than
a failure where the traceback isn't shown.

I'll have to stare at it a bit more but wanted you to know I've at least
looked at it and agree we should try and do something...

Cheers,

Richard


