Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EFC4708D
	for <webhook@archiver.kernel.org>; Fri,  6 Jan 2023 14:20:50 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.14361.1673014847475215206
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Jan 2023 06:20:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=smj0M1LQ;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso3627501wmb.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Jan 2023 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9qhUSMR3uhbFKZc2zUTqc15IOSh3XLffO1bP+ajDm4=;
        b=smj0M1LQbwo/VAe5TrDcU4wFFJ6rehGhoJXlCJ5nufTHF+8al+V036Yn0PmyS+h9zX
         cdXKWTygLcC5EO7fHIy+VWFEr1IhbcagXGl+aWGOogvVqTpyOvngR7HIhcw4ZJ4MV790
         b2eJRj6QYqaBkFbX1tTJzyv4+COLAKg3R+1RDg/8rr9Mbh4V/kwWT27SaqqHWtqEPus7
         k3XiHtJZN3wOzmPhMty6wfj1qDVR0MSZ4+lbyqaSLpWT9XWnDOpXTeqhA44iYIsIcfQx
         fq6OotTI+6ggaEy2mOX/Y34MYbaWY/IvyyqUU8q2MvoH5FuHi5TrBgXb/R7og7F8eiwP
         zCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9qhUSMR3uhbFKZc2zUTqc15IOSh3XLffO1bP+ajDm4=;
        b=gBuaqhZA0XlnntgYSzEUmadXBS8vWlT4OBUlWJsjKrqjZpSCnXtxnsJBL6JIAxLN0I
         iY6XhGXLGEhP4ElscKv4rFGp4WEvjXSJ56PRVUpx3+DGJeTfFFZ/mgJF5r/ahYZ2f0Lr
         p49M26dw7bvsSgwPZ2iKBBlX6ahMRdU/gZyEa+onaSY5L0wZvMeOQI7Y7UNPxZh+eo+m
         HKNFsk8inPT8su7GPqDKYjMeCB42Q2eFyIe7vJyijrgX6jcghqnFMRZOLLywSrA+dUTE
         d+IBoDutIHsgq6nmxbiiu9ws4qszkERBHmZx2IVqpg0EQA0igxk2q/4kLvEOcktlyMPz
         8fgA==
X-Gm-Message-State: AFqh2kqyIr/W8DwvDK7Q8RyXif+rQut+RwazamI7TB6EFemxrfWR8rOV
	oGKbXfOe5R+gTjoE5/DL8dncZabafYVrjhau
X-Google-Smtp-Source: AMrXdXtMIlDKMMSqfXAqd2MrD+KcmxOESYvRD8buPHJVlOgCqHZwMjZSNv3xlggT2yHFTg9A+dWJRQ==
X-Received: by 2002:a05:600c:a4f:b0:3d3:5c35:8919 with SMTP id c15-20020a05600c0a4f00b003d35c358919mr39668182wmq.30.1673014845585;
        Fri, 06 Jan 2023 06:20:45 -0800 (PST)
Received: from [192.168.0.23] (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c6b70a4d69sm2219026wmq.42.2023.01.06.06.20.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:20:45 -0800 (PST)
Message-ID: <bf7521d9-5a6d-c33d-53bc-01dbcfae91c3@smile.fr>
Date: Fri, 6 Jan 2023 15:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] Group and reorder options in bitbake help
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <1737BD92075F06D0.26636@lists.openembedded.org>
From: Yoann Congal <yoann.congal@smile.fr>
In-Reply-To: <1737BD92075F06D0.26636@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Jan 2023 14:20:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14291

On 1/6/23 15:09, Yoann Congal via lists.openembedded.org wrote:
> Fixes [YOCTO #12018].
> 
> Also, I have included some small fixes:
> * added a '.' at the end of sentence where it was missing
> * split some long lines
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>   lib/bb/main.py | 222 +++++++++++++++++++++++++++----------------------
>   1 file changed, 122 insertions(+), 100 deletions(-)
To help review/discussion, here the new generated output with the patch 
applied. Please note there was a discussion in 
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12018

  $ bitbake --help
usage: bitbake [-b BUILDFILE] [-s] [-e] [-g] [-u UI] [--version] [-h]
                [-f] [-c CMD] [-C INVALIDATE_STAMP] [--runall RUNALL]
                [--runonly RUNONLY] [--no-setscene] [--skip-setscene]
                [--setscene-only] [-n] [-p] [-k] [-P]
                [-S SIGNATURE_HANDLER] [--revisions-changed] [-D]
                [-l DEBUG_DOMAINS] [-v] [-q] [-w WRITEEVENTLOG] [-B BIND]
                [-T SERVER_TIMEOUT] [--remote-server REMOTE_SERVER] [-m]
                [--token XMLRPCTOKEN] [--observe-only] [--status-only]
                [--server-only] [-r PREFILE] [-R POSTFILE]
                [-I EXTRA_ASSUME_PROVIDED]
                [recipename/target ...]

It is assumed there is a conf/bblayers.conf available in cwd or in
BBPATH which will provide the layer, BBFILES and other configuration
information.

General options:
   recipename/target     Execute the specified task (default is 'build')
                         for these target recipes (.bb files).
   -b BUILDFILE, --buildfile BUILDFILE
                         Execute tasks from a specific .bb recipe
                         directly. WARNING: Does not handle any
                         dependencies from other recipes.
   -s, --show-versions   Show current and preferred versions of all
                         recipes.
   -e, --environment     Show the global or per-recipe environment
                         complete with information about where variables
                         were set/changed.
   -g, --graphviz        Save dependency tree information for the
                         specified targets in the dot syntax.
   -u UI, --ui UI        The user interface to use (knotty, ncurses,
                         taskexp or teamcity - default knotty).
   --version             Show programs version and exit.
   -h, --help            Show this help message and exit.

Task control options:
   -f, --force           Force the specified targets/task to run
                         (invalidating any existing stamp file).
   -c CMD, --cmd CMD     Specify the task to execute. The exact options
                         available depend on the metadata. Some examples
                         might be 'compile' or 'populate_sysroot' or
                         'listtasks' may give a list of the tasks
                         available.
   -C INVALIDATE_STAMP, --clear-stamp INVALIDATE_STAMP
                         Invalidate the stamp for the specified task such
                         as 'compile' and then run the default task for
                         the specified target(s).
   --runall RUNALL       Run the specified task for any recipe in the
                         taskgraph of the specified target (even if it
                         wouldn't otherwise have run).
   --runonly RUNONLY     Run only the specified task within the taskgraph
                         of the specified targets (and any task
                         dependencies those tasks may have).
   --no-setscene         Do not run any setscene tasks. sstate will be
                         ignored and everything needed, built.
   --skip-setscene       Skip setscene tasks if they would be executed.
                         Tasks previously restored from sstate will be
                         kept, unlike --no-setscene.
   --setscene-only       Only run setscene tasks, don't run any real
                         tasks.

Execution control options:
   -n, --dry-run         Don't execute, just go through the motions.
   -p, --parse-only      Quit after parsing the BB recipes.
   -k, --continue        Continue as much as possible after an error.
                         While the target that failed and anything
                         depending on it cannot be built, as much as
                         possible will be built before stopping.
   -P, --profile         Profile the command and save reports.
   -S SIGNATURE_HANDLER, --dump-signatures SIGNATURE_HANDLER
                         Dump out the signature construction information,
                         with no task execution. The SIGNATURE_HANDLER
                         parameter is passed to the handler. Two common
                         values are none and printdiff but the handler
                         may define more/less. none means only dump the
                         signature, printdiff means compare the dumped
                         signature with the cached one.
   --revisions-changed   Set the exit code depending on whether upstream
                         floating revisions have changed or not.

Logging/output control options:
   -D, --debug           Increase the debug level. You can specify this
                         more than once. -D sets the debug level to 1,
                         where only bb.debug(1, ...) messages are printed
                         to stdout; -DD sets the debug level to 2, where
                         both bb.debug(1, ...) and bb.debug(2, ...)
                         messages are printed; etc. Without -D, no debug
                         messages are printed. Note that -D only affects
                         output to stdout. All debug messages are written
                         to ${T}/log.do_taskname, regardless of the debug
                         level.
   -l DEBUG_DOMAINS, --log-domains DEBUG_DOMAINS
                         Show debug logging for the specified logging
                         domains.
   -v, --verbose         Enable tracing of shell tasks (with 'set -x').
                         Also print bb.note(...) messages to stdout (in
                         addition to writing them to ${T}/log.do_<task>).
   -q, --quiet           Output less log message data to the terminal.
                         You can specify this more than once.
   -w WRITEEVENTLOG, --write-log WRITEEVENTLOG
                         Writes the event log of the build to a bitbake
                         event json file. Use '' (empty string) to assign
                         the name automatically.

Server options:
   -B BIND, --bind BIND  The name/address for the bitbake xmlrpc server
                         to bind to.
   -T SERVER_TIMEOUT, --idle-timeout SERVER_TIMEOUT
                         Set timeout to unload bitbake server due to
                         inactivity, set to -1 means no unload, default:
                         Environment variable BB_SERVER_TIMEOUT.
   --remote-server REMOTE_SERVER
                         Connect to the specified server.
   -m, --kill-server     Terminate any running bitbake server.
   --token XMLRPCTOKEN   Specify the connection token to be used when
                         connecting to a remote server.
   --observe-only        Connect to a server as an observing-only client.
   --status-only         Check the status of the remote bitbake server.
   --server-only         Run bitbake without a UI, only starting a server
                         (cooker) process.

Configuration options:
   -r PREFILE, --read PREFILE
                         Read the specified file before bitbake.conf.
   -R POSTFILE, --postread POSTFILE
                         Read the specified file after bitbake.conf.
   -I EXTRA_ASSUME_PROVIDED, --ignore-deps EXTRA_ASSUME_PROVIDED
                         Assume these dependencies don't exist and are
                         already provided (equivalent to
                         ASSUME_PROVIDED). Useful to make dependency
                         graphs more appealing.

-- 
Yoann Congal
Smile ECS - Expert technique

