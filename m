Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D75C433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Sep 2021 14:10:51 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.13148.1633011049946284928
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Sep 2021 07:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=HdVU+B3g;
 spf=softfail (domain: sakoman.com, ip: 209.85.128.48,
 mailfrom: steve@sakoman.com)
Received: by mail-wm1-f48.google.com with SMTP id
 l18-20020a05600c4f1200b002f8cf606262so8567731wmq.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Sep 2021 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05nrqBBd37ffXh5oaw4LR1y0H51Gcche8C2rLUeHOUY=;
        b=HdVU+B3g22kdv9OMxDpv0CgWDV5br+qo9qE3sc4AQaJiITB2g1/aBE3xBD2B1HHpa+
         fr0/puYqAj3Bj+PLuxfVDF6TU9u7T2d2It4dgeL4zgCIeFn8RKnpynOjzCsQj6Z1RgX2
         KqVJKKmHmM4znFZj5o/EJ8YYiglAjxT6nVkOXkVez5s5r2ilKxjhvA5GQ2452JUpEeED
         W2gswlT7WBySh1ewV5pFffsXEF7riHnPQdvpuXbLBZgBiz6kEOdeSG/RSKTCartUO7vX
         l75Av4mBV8ZWiOlIR3XL2YCEa9rD2PYP9pnCtNstIvR81SJhpMexKyxdKXodBbLyQrT0
         Uljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05nrqBBd37ffXh5oaw4LR1y0H51Gcche8C2rLUeHOUY=;
        b=fqLagWh/N8uAeWxqdO/lSJbt9cbDoSvduyKsfJToXJViCs80JTkXhT85GIPObsiKDk
         fpsC6gqdG5zLEOjpxajAgq4JDlrPZ5W9772syzup8FNNYtLwWpUlHhaBEW9FOrVfvAiD
         UnfHHNiuMiB4QfTkSpiELwnVb8x3sPJ3iYT0e/UIyE2KWPU7U/k56GVZwycd9fFzdYDs
         Y5Pazv/V0Rnk2gIXT6nQGw/OQNQw2xCioVKwkOmK125FmATWi9bNF8CMNzAehgPbbOJQ
         bphPTKoo9uE4mB4dezOeTg416xzk0Gd+Yd2eS2gXHrjL7+RJ6pMYr+7pyYk2TaBtJWte
         /sDw==
X-Gm-Message-State: AOAM530egXosR14nzljR5iuY1DQZWPkbpUY0CnptH/L+xg0AnB9s1oN0
	uDC3WltRCX1jg5eaSzm5QqAvY+gcIB8vQmjeHlosZw==
X-Google-Smtp-Source: 
 ABdhPJzcbDqwy7CSaYhhw5IsEg1YGSQYMXgHMrI6daWvVn47rz3L1bue2hjLf+lr1dGFZV30gZagEXjzAXZ++yCLFr4=
X-Received: by 2002:a05:600c:214d:: with SMTP id
 v13mr16090908wml.30.1633011048251;
 Thu, 30 Sep 2021 07:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632493110.git.steve@sakoman.com>
 <e75169f7ef89cca94cefe9f0099a5b427b380a6d.1632493110.git.steve@sakoman.com>
 <CA+chaQebhx9aX1sKGct-XTQdLm-dWvUZpGwpUDxv0fTUmj5iiQ@mail.gmail.com>
In-Reply-To: 
 <CA+chaQebhx9aX1sKGct-XTQdLm-dWvUZpGwpUDxv0fTUmj5iiQ@mail.gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Thu, 30 Sep 2021 04:10:36 -1000
Message-ID: 
 <CAOSpxdbq0pQN+k_QxFgi2LUAPUA+fb7bJKd9voP_NRoShzBtkQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 08/14] build:
 Avoid duplicating logs in verbose mode
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Sep 2021 14:10:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12720

On Thu, Sep 30, 2021 at 12:09 AM Martin Jansa <martin.jansa@gmail.com> wrote:
>
> I'm sorry for late review, but this patch won't work in 1.46 without this commit from 1.48:
>
>   commit 423c046f2173aaff3072dc3d0882d01b8a0b0212
>   Author: Richard Purdie <richard.purdie@linuxfoundation.org>
>   Date:   Mon Aug 24 12:28:27 2020 +0100
>
>     build/msg: Cleanup verbose option handling

Good catch!  Thanks for the review.

Richard hasn't taken the pull request yet, so I will add this patch,
test, and resubmit the series.

Thanks again!

Steve

>
> which defines verboseStdoutLogging
>
> Without this when task fails it shows completely wrong error output e.g.:
>
> ERROR: sysdig-0.26.6-r0 do_compile: Build of do_compile failed
> ERROR: sysdig-0.26.6-r0 do_compile: Traceback (most recent call last):
>   File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line 584, in _exec_task
>     exec_func(task, localdata)
>   File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line 251, in exec_func
>     exec_func_shell(func, d, runfile, cwd=adir)
>   File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line 452, in exec_func_shell
>     bb.process.run(cmd, shell=False, stdin=stdin, log=logfile, extrafiles=[(fifo,readfifo)])
>   File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/process.py", line 184, in run
>     raise ExecutionError(cmd, pipe.returncode, None, None)
> bb.process.ExecutionError: Execution of '/jenkins/mjansa/build/webos/dunfell/BUILD/work/qemux86-webos-linux/sysdig/0.26.6-r0/temp/run.do_compile.69208' failed with exit code 1
>
> During handling of the above exception, another exception occurred:
>
> Traceback (most recent call last):
>   File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line 649, in exec_task
>     return _exec_task(fn, task, d, quieterr)
>   File "/jenkins/mjansa/build/webos/dunfell/bitbake/lib/bb/build.py", line 597, in _exec_task
>     if verboseStdoutLogging:
> NameError: name 'verboseStdoutLogging' is not defined
>
> On Fri, Sep 24, 2021 at 4:22 PM Steve Sakoman <steve@sakoman.com> wrote:
>>
>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>>
>> With "bitbake -v", for task failures you'd see the log output twice. Avoid
>> this by using the existing "did we print info" switch.
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> (cherry picked from commit e2c1afda4cb8023ed4ffeb5dc5bee4f0055659a8)
>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>> ---
>>  lib/bb/build.py | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/lib/bb/build.py b/lib/bb/build.py
>> index 04971636..6e9c064e 100644
>> --- a/lib/bb/build.py
>> +++ b/lib/bb/build.py
>> @@ -592,6 +592,10 @@ def _exec_task(fn, task, d, quieterr):
>>                  event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
>>              else:
>>                  errprinted = errchk.triggered
>> +                # If the output is already on stdout, we've printed the information in the
>> +                # logs once already so don't duplicate
>> +                if verboseStdoutLogging:
>> +                    errprinted = True
>>                  logger.error(str(exc))
>>                  event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
>>              return 1
>> --
>> 2.25.1
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#12697): https://lists.openembedded.org/g/bitbake-devel/message/12697
>> Mute This Topic: https://lists.openembedded.org/mt/85840116/3617156
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Martin.Jansa@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>

