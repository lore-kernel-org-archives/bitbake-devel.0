Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF2BC4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 19:02:09 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.1121.1701457326645337130
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 11:02:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MNeFYpa0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F93CFF803;
	Fri,  1 Dec 2023 19:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701457324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYjmdqt/qwfe3Gd2zgKYlXnMkxP/sbLWr+0lEqGMT04=;
	b=MNeFYpa0nKidbaEzGmrUy69t8EJq9GB1oRfzvSKk2cBaWcZEg4ojIPSmR7P7TykV+f8PHC
	bIYKvEOg90YRAhxCvIgBMt33gpJwpcEPsn8Kzhi3PnDtGewwgknunOIQoe2ye6Laml4T35
	rBGAzUC6QVg0vk9TydbBzFeVy9eiIKMf4mi2VSeV0HBMvdm2+4mSRE9AMBGXmdohHuM1gK
	1pubtU7Oh1Lcx5bxqCGwEnRvTVg0q6N3T8wxjl3OYwFGc5a3qdMPysdcKU/sUgLW5xhmeA
	aGzMtHP8ZB83SNTZ6ORKJG6aM3cvCQj3LhQhY+Jqp5RpnKTO0OSo0pv9kUxRrg==
Date: Fri, 1 Dec 2023 20:02:03 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] runqueue: Improve inter setscene task
 dependency handling
Message-ID: <20231201190203a0cd89c1@mail.local>
References: <20231129214644.536837-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129214644.536837-1-richard.purdie@linuxfoundation.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 19:02:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15603

Hello Richard,

This caused all those failures:
https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6269

On 29/11/2023 21:46:44+0000, Richard Purdie wrote:
> The way the code currently handles dependencies between setscene tasks is fairly
> poor, basically by deleting chunks of dependencies and adding reversed dependency
> relationships.
> 
> This was once the best way to handle things but now a lot of the surrounding code
> has changed and this approach is suboptimal and can be improved.
> 
> This change firstly adds debug logging for "hard" setscene task dependencies since
> previously the codepaths were missing from logs making them very hard to read.
> 
> The changes to the setscene dependency graph are removed entirely this these altered
> graphs were a significant source of problems. Instead, if a hard dependency is run
> into, we mark the hard dependency as buildable and defer the task until the hard
> dependencies are met.
> 
> The code now also skips the check_dependencies() code for hard dependencies since
> previously that code was having to list all possible hard dependencies. We don't
> need to do that as we can safely assume hard dependencies are required.
> 
> With these changes to runqueue's behaviour, we stand some chance of being able to
> fix other bugs in OE-Core related to useradd for example.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 02d7ff9768..8a5a2d2e9d 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1813,6 +1813,7 @@ class RunQueueExecute:
>          self.build_stamps2 = []
>          self.failed_tids = []
>          self.sq_deferred = {}
> +        self.sq_needed_harddeps = set()
>  
>          self.stampcache = {}
>  
> @@ -2140,7 +2141,10 @@ class RunQueueExecute:
>              # Find the next setscene to run
>              for nexttask in self.sorted_setscene_tids:
>                  if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
> -                    if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
> +                    if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and \
> +                            nexttask not in self.sq_needed_harddeps and \
> +                            self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and \
> +                            self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
>                          if nexttask not in self.rqdata.target_tids:
>                              logger.debug2("Skipping setscene for task %s" % nexttask)
>                              self.sq_task_skip(nexttask)
> @@ -2148,6 +2152,18 @@ class RunQueueExecute:
>                              if nexttask in self.sq_deferred:
>                                  del self.sq_deferred[nexttask]
>                              return True
> +                    if nexttask in self.sqdata.sq_harddeps_rev and not self.sqdata.sq_harddeps_rev[nexttask].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
> +                        logger.debug2("Deferring %s due to hard dependencies" % nexttask)
> +                        updated = False
> +                        for dep in self.sqdata.sq_harddeps_rev[nexttask]:
> +                            if dep not in self.sq_needed_harddeps:
> +                                logger.debug2("Enabling task %s as it is a hard dependency" % dep)
> +                                self.sq_buildable.add(dep)
> +                                self.sq_needed_harddeps.add(dep)
> +                                updated = True
> +                        if updated:
> +                            return True
> +                        continue
>                      # If covered tasks are running, need to wait for them to complete
>                      for t in self.sqdata.sq_covered_tasks[nexttask]:
>                          if t in self.runq_running and t not in self.runq_complete:
> @@ -2780,6 +2796,7 @@ class SQData(object):
>          self.sq_revdeps = {}
>          # Injected inter-setscene task dependencies
>          self.sq_harddeps = {}
> +        self.sq_harddeps_rev = {}
>          # Cache of stamp files so duplicates can't run in parallel
>          self.stamps = {}
>          # Setscene tasks directly depended upon by the build
> @@ -2907,6 +2924,7 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
>          idepends = rqdata.taskData[mc].taskentries[realtid].idepends
>          sqdata.stamps[tid] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
>  
> +        sqdata.sq_harddeps_rev[tid] = set()
>          for (depname, idependtask) in idepends:
>  
>              if depname not in rqdata.taskData[mc].build_targets:
> @@ -2919,20 +2937,15 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
>              if deptid not in rqdata.runtaskentries:
>                  bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
>  
> +            logger.debug2("Adding hard setscene dependency %s for %s" % (deptid, tid))
> +
>              if not deptid in sqdata.sq_harddeps:
>                  sqdata.sq_harddeps[deptid] = set()
>              sqdata.sq_harddeps[deptid].add(tid)
> -
> -            sq_revdeps_squash[tid].add(deptid)
> -            # Have to zero this to avoid circular dependencies
> -            sq_revdeps_squash[deptid] = set()
> +            sqdata.sq_harddeps_rev[tid].add(deptid)
>  
>      rqdata.init_progress_reporter.next_stage()
>  
> -    for task in sqdata.sq_harddeps:
> -        for dep in sqdata.sq_harddeps[task]:
> -            sq_revdeps_squash[dep].add(task)
> -
>      rqdata.init_progress_reporter.next_stage()
>  
>      #for tid in sq_revdeps_squash:
> -- 
> 2.39.2
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15579): https://lists.openembedded.org/g/bitbake-devel/message/15579
> Mute This Topic: https://lists.openembedded.org/mt/102881792/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/10431315/3617179/474273136/xyzzy [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

