Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web12.1380.1617122949911407568
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Mar 2021 09:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=Kzz2qdSY;
 spf=pass (domain: burtonini.com, ip: 209.85.128.50, mailfrom: ross@burtonini.com)
Received: by mail-wm1-f50.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so8786544wmj.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Mar 2021 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ru3g41kfdWNt4XqwNUrb8Q2keT4Z5dKYMz/fHQVSBKA=;
        b=Kzz2qdSYIhuv6dJBrddxX6LhN6vFlp54aanGnRQ40EwfjyZrfBvgkyxhjdDrk/UzjE
         fTy7s7jIzsmIJ+sCDZPh8Fp+KlCdjwyzZ/IlC6eKyyYr7Ef8aqzleqfKFH8eteswCjkK
         B+s+++K/LW91yRQ9vq92UwL5co89D3SrXGEiHJU0g+5WCE+lbsUYvAuOCQ+FI8jTtJlb
         wRlXImNxN+ECFt9QmGL9GoZAEfaYtq8aINbFi1slJn/NFDGGcUzO+zaPOpYW3giQuCRX
         zGfUfAMmB1CQXCMCUu/3dRebzey1IzTVULq6ZcEEi/SXgCc6f17dCsKVbXEKS0m47+f1
         o4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ru3g41kfdWNt4XqwNUrb8Q2keT4Z5dKYMz/fHQVSBKA=;
        b=nlrWVUJz6PhPTKh97yWt1ozeeAaHf0qstD7xcAPYTFNTtPL1/e+cXqQmWiOMNoyPVV
         xUwH+Ya0hqhO3DWKITRlDWZ3YFIcz/s317W8m4ZlgISRbJi9VC94gdi9znuM8jz6Ci8a
         qvj9UNYESa7DOrKMmOOrKi1Ic4CIJM6mHE7s08f5qTDoF3A7NI8l9d5JQ83lXZ9pvDA4
         weA0xUZf1zxCr+Hw9Lb1CVNNtWZ9Cvh4EBKUa/lfIIL4UZkJ7naxK2iDUr2dTsOtSVCs
         My5voqi1As0V5qC3g/xS2qdHLb3CdZZ3uZ/JiUrUOwkq7SaWgPZ4HDOqv/BUq8ePDZpy
         phsw==
X-Gm-Message-State: AOAM532w1QOAZwJ90emQm0g15gK0WqpVK+e7+GmkR3Pp3uK7npos89x9
	YnkEfwkxJuHXb9vPYuviKPGxUnyJEtz0rDGEOEJrxnuAyPYDR3qY
X-Google-Smtp-Source: ABdhPJzzUsI4FlHP5ID3Uf2nxn5lxS9ngmqI0IDNIdCgCKG1d8gs5qVXwf+ZBT9UHjKFDNDNTdDHWp+sYJUNJiL+73g=
X-Received: by 2002:a1c:6855:: with SMTP id d82mr5127096wmc.169.1617122948281;
 Tue, 30 Mar 2021 09:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210330143049.GA23723@mcrowe.com>
In-Reply-To: <20210330143049.GA23723@mcrowe.com>
From: "Ross Burton" <ross@burtonini.com>
Date: Tue, 30 Mar 2021 16:48:57 +0000
Message-ID: <CAAnfSTtyDJ_LZ=xxnUJREe3fkCXR_jYEPDhEkBQdD7wjig4zVg@mail.gmail.com>
Subject: Re: [bitbake-devel] Three copies of output from failing task
To: yocto@mac.mcrowe.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

This has been bugging me for some time, so I'm keen for you to fix this. :)

Ross

On Tue, 30 Mar 2021 at 15:30, Mike Crowe via lists.openembedded.org
<yocto=mac.mcrowe.com@lists.openembedded.org> wrote:
>
> After upgrading from oe-core Warrior (Bitbake 1.42) to Dunfell (Bitbake
> 1.46), I'm seeing _three_ copies of the log output for every build failure.
> I see similar when using the current state of oe-core master (along with
> the new backtraces.)
>
> To reproduce the problem, I hacked openssl_1.1.1k.bb:do_configure to insert:
>
>  echo "an error"
>  false
>
> and ran bitbake openssl-native. The output was:
>
> --8<--
> NOTE: Executing Tasks
> ERROR: openssl-native-1.1.1k-r0 do_configure: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
> an error
> WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> WARNING: Backtrace (BB generated script):
>         #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
>         #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
>
> Backtrace (metadata-relative locations):
>         #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
> ERROR: Logfile of failure stored in: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/log.do_configure.32031
> Log data follows:
> | DEBUG: Executing python function extend_recipe_sysroot
> | NOTE: Direct dependencies are ['/overflow/mac/nobackup/git/oe-core/meta/recipes-devtools/quilt/quilt-native_0.66.bb:do_populate_sysroot']
> | NOTE: Installed into sysroot: []
> | NOTE: Skipping as already exists in sysroot: ['quilt-native']
> | DEBUG: Python function extend_recipe_sysroot finished
> | DEBUG: Executing shell function do_configure
> | an error
> | WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> | WARNING: Backtrace (BB generated script):
> |       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
> |       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> | ERROR: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
> | an error
> | WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> | WARNING: Backtrace (BB generated script):
> |       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
> |       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> |
> | Backtrace (metadata-relative locations):
> |       #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
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
>
> Thanks.
>
> Mike.
>
> 
>
