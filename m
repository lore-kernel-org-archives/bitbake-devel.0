Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11AC636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 14:59:27 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web10.11017.1677077958464605440
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Feb 2023 06:59:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HN66F2ym;
 spf=pass (domain: gmail.com, ip: 209.85.161.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f47.google.com with SMTP id d10-20020a4aa58a000000b0051fed0d7766so755413oom.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 06:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pobgSRFE0RwgMuM/mU04rEjv3c+cL6yLooWXq3o4e6o=;
        b=HN66F2ym88QnSm5vUYATUlGJhci+HVwLwkqVLv56pCIPCEeCzt00f0wAa023rVF1t5
         oX0JmMcMIZCgLRnmbfbEuE0l+L/SVbMMVmZvinDqnV9Py22yA+a5IpSbDrPzpePw5wJS
         wSNPyiuTmFF6SZ500GVZuqueDoLwWu+RUaNiG8qlzBGIQYSfncJTzDGTec+rf4cdJgv/
         5nN3cj64Jl/UlqjEI0dNeEuTmsbhYfCJvgpIwp/dY8xOs8gT0Axios+UkUXBCqm8t92L
         Yi+rO5+CpB43qUVBT/RfMkiSW0Cmk7DWkPobkuhUJwJD1VwUOcXQWKmBXbVVhOxkTgwV
         eTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pobgSRFE0RwgMuM/mU04rEjv3c+cL6yLooWXq3o4e6o=;
        b=53OX3bNGKyVAjKEpV/38p2xZld6QFipvh8/XsnwoQRC3ryCZaBkyyRKNQG+ZYdfsY9
         JBl3AgBUdqUN+DWtLgbePPBEMwp0+m0GbyDdADQoh1rHD5ZWbthKF480jwrFXYXKVn5c
         jZxCmG9W2fbMG5kh/tE0GdGWEF/CiOHFLq7CFCvPdqj5oA2rePJ2gPp5n/YBhmchjAi3
         Vg0PL7dn5NbFZ1RZVj805QD7bThmzvfbmf5/kzVbUClcqEkj5VJDQRZ7EKz6GI9kv9y/
         6+TnKYiyEimKxCTyhSW5EASKyPmsoL3XXA315J8Atz7mN8uYvJGQz6imsku6LyJ6n40O
         IO2A==
X-Gm-Message-State: AO0yUKXhPQQL8Jl5NZqYxaJAyaLkfpVDwWDZCtN40Fm9yNnBldiUL100
	ZNPXxmHsE99USq79PMTY9Ic=
X-Google-Smtp-Source: AK7set9fFSQUp8tOy3FRUrK8XacB2gxoio4UrSaWaPBV7g82NAHbemIiJvYUG0aC4mSXOguaIblA5w==
X-Received: by 2002:a05:6820:1885:b0:513:e572:f843 with SMTP id bm5-20020a056820188500b00513e572f843mr3607997oob.4.1677077957582;
        Wed, 22 Feb 2023 06:59:17 -0800 (PST)
Received: from ?IPV6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id o2-20020a4a84c2000000b0051d13098c54sm1191356oog.19.2023.02.22.06.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:59:16 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <5672f789-0dcc-779b-3158-10235ad661c6@gmail.com>
Date: Wed, 22 Feb 2023 08:59:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bitbake-devel] [PATCH 1/2] event/cooker/runqueue: Add ability to
 interrupt longer running code
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20230222145153.581307-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230222145153.581307-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 14:59:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14479


On 2/22/23 08:51, Richard Purdie wrote:
> Bitbake is now able to understand when a UI wants it to stop the current
> processing. There are some long running functions which currently have no
> mechanism to interrupt them however.
>
> This patch adds a call, bb.event.check_for_interrupts(d) which can be
> placed in long running code and allows an internal state flag within
> bitbake to be checked. If set, that flag will trigger an exit.
>
> This means that Ctrl+C can be made to work in a variety of places where
> it currently would not.
>
> Long running event handlers in OE-Core can also then benefit from this
> new approach with the addition of the function call as well.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/cooker.py   |  4 ++++
>   lib/bb/event.py    | 11 +++++++++++
>   lib/bb/runqueue.py | 15 +++++++++++++++
>   3 files changed, 30 insertions(+)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index b673fe10ee..c631ec7e6d 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -345,6 +345,7 @@ class BBCooker:
>           elif signum == signal.SIGHUP:
>               bb.warn("Cooker received SIGHUP, shutting down...")
>           self.state = state.forceshutdown
> +        bb.event._should_exit.set()
>   
>       def setFeatures(self, features):
>           # we only accept a new feature set if we're in state initial, so we can reset without problems
> @@ -1520,6 +1521,7 @@ class BBCooker:
>               msg = None
>               interrupted = 0
>               if halt or self.state == state.forceshutdown:
> +                bb.event._should_exit.set()
>                   rq.finish_runqueue(True)
>                   msg = "Forced shutdown"
>                   interrupted = 2
> @@ -1760,6 +1762,7 @@ class BBCooker:
>               self.state = state.forceshutdown
>           else:
>               self.state = state.shutdown
> +        bb.event._should_exit.set()
>   
>           if self.parser:
>               self.parser.shutdown(clean=False)
> @@ -1770,6 +1773,7 @@ class BBCooker:
>               self.parser.shutdown(clean=False)
>               self.parser.final_cleanup()
>           self.state = state.initial
> +        bb.event._should_exit.clear()

I typically avoid Event because it's easy to forget some the assumptions 
it makes, but I think it's OK in this context because it's never 
possible for set() and clear() to be called out of sequence (or in 
parallel on other threads).

>   
>       def reset(self):
>           if hasattr(bb.parse, "siggen"):
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 8b05f93e2f..37cc630c63 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -69,6 +69,7 @@ _eventfilter = None
>   _uiready = False
>   _thread_lock = threading.Lock()
>   _heartbeat_enabled = False
> +_should_exit = threading.Event()
>   
>   def enable_threadlock():
>       # Always needed now
> @@ -86,6 +87,16 @@ def disable_heartbeat():
>       global _heartbeat_enabled
>       _heartbeat_enabled = False
>   
> +#
> +# In long running code, this function should be called periodically
> +# to check if we should exit due to an interuption (.e.g Ctrl+C from the UI)
> +#
> +def check_for_interrupts(d):

why the addition of 'd' here?

> +    global _should_exit
> +    if _should_exit.is_set():
> +        bb.warn("Exiting due to interrupt.")
> +        raise bb.BBHandledException()
> +
>   def execute_handler(name, handler, event, d):
>       event.data = d
>       try:
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index e5bd9311f2..e629ab7e7b 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -655,6 +655,7 @@ class RunQueueData:
>   
>           self.init_progress_reporter.start()
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Step A - Work out a list of tasks to run
>           #
> @@ -803,6 +804,7 @@ class RunQueueData:
>           #self.dump_data()
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Resolve recursive 'recrdeptask' dependencies (Part B)
>           #
> @@ -899,6 +901,7 @@ class RunQueueData:
>               self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           #self.dump_data()
>   
> @@ -980,6 +983,7 @@ class RunQueueData:
>                   mark_active(tid, 1)
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Step C - Prune all inactive tasks
>           #
> @@ -1019,6 +1023,7 @@ class RunQueueData:
>                   bb.msg.fatal("RunQueue", "Could not find any tasks with the tasknames %s to run within the recipes of the taskgraphs of the targets %s" % (str(self.cooker.configuration.runall), str(self.targets)))
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Handle runonly
>           if self.cooker.configuration.runonly:
> @@ -1059,6 +1064,7 @@ class RunQueueData:
>           logger.verbose("Assign Weightings")
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Generate a list of reverse dependencies to ease future calculations
>           for tid in self.runtaskentries:
> @@ -1066,6 +1072,7 @@ class RunQueueData:
>                   self.runtaskentries[dep].revdeps.add(tid)
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Identify tasks at the end of dependency chains
>           # Error on circular dependency loops (length two)
> @@ -1082,12 +1089,14 @@ class RunQueueData:
>           logger.verbose("Compute totals (have %s endpoint(s))", len(endpoints))
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Calculate task weights
>           # Check of higher length circular dependencies
>           self.runq_weight = self.calculate_task_weights(endpoints)
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Sanity Check - Check for multiple tasks building the same provider
>           for mc in self.dataCaches:
> @@ -1188,6 +1197,7 @@ class RunQueueData:
>   
>           self.init_progress_reporter.next_stage()
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Iterate over the task list looking for tasks with a 'setscene' function
>           self.runq_setscene_tids = set()
> @@ -1200,6 +1210,7 @@ class RunQueueData:
>                   self.runq_setscene_tids.add(tid)
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Invalidate task if force mode active
>           if self.cooker.configuration.force:
> @@ -1216,6 +1227,7 @@ class RunQueueData:
>                       invalidate_task(fn + ":" + st, True)
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           # Create and print to the logs a virtual/xxxx -> PN (fn) table
>           for mc in taskData:
> @@ -1228,6 +1240,7 @@ class RunQueueData:
>                   bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.dataCaches[mc])
>   
>           self.init_progress_reporter.next_stage()
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
>   
> @@ -1240,6 +1253,7 @@ class RunQueueData:
>                       dealtwith.add(tid)
>                       todeal.remove(tid)
>                       self.prepare_task_hash(tid)
> +                bb.event.check_for_interrupts(self.cooker.data)
>   
>           bb.parse.siggen.writeout_file_checksum_cache()
>   
> @@ -1483,6 +1497,7 @@ class RunQueue:
>           """
>   
>           retval = True
> +        bb.event.check_for_interrupts(self.cooker.data)
>   
>           if self.state is runQueuePrepare:
>               # NOTE: if you add, remove or significantly refactor the stages of this
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14477): https://lists.openembedded.org/g/bitbake-devel/message/14477
> Mute This Topic: https://lists.openembedded.org/mt/97160913/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/8021544/3616693/382565666/xyzzy [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

