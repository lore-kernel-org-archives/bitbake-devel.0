Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A4C2D706F1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RE5Nxm002426; Wed, 27 Aug 2014 15:05:23 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HfnaNMs37Kg2; Wed, 27 Aug 2014 15:05:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RE5LVu002419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 Aug 2014 15:05:22 +0100
Message-ID: <1409148322.5772.52.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Hongxu Jia <hongxu.jia@windriver.com>
Date: Wed, 27 Aug 2014 15:05:22 +0100
In-Reply-To: <482f226a680a13d96157e6d437fb9b8d237c68dc.1409147456.git.hongxu.jia@windriver.com>
References: <cover.1409147456.git.hongxu.jia@windriver.com>
	<482f226a680a13d96157e6d437fb9b8d237c68dc.1409147456.git.hongxu.jia@windriver.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, Zhangle.Yang@windriver.com
Subject: Re: [PATCH 1/1] bitbake: runqueue: catch hashvalidate error in RunQueueExecuteScenequeue
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 27 Aug 2014 14:05:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-08-27 at 21:57 +0800, Hongxu Jia wrote:
> We need to catch the failure of self.rq.hashvalidate which invoked
> in RunQueueExecuteScenequeue, and exit in a normal build.
> 
> So we raise and except bb.BBHandledException for this specific error.
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>  bitbake/lib/bb/runqueue.py | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index e13dc57..59e4188 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1046,7 +1046,14 @@ class RunQueue:
>                  self.state = runQueueComplete
>              else:
>                  self.start_worker()
> -                self.rqexe = RunQueueExecuteScenequeue(self)
> +                try:
> +                    self.rqexe = RunQueueExecuteScenequeue(self)
> +                except bb.BBHandledException:
> +                    # While hashvalidate failed, we need exit the normal build.
> +                    self.state = runQueueComplete
> +                except:
> +                    logger.error("RunQueueExecuteScenequeue init failed")
> +                    raise

Do you still need to do this with the change below? runqueue didn't
complete, it failed so the state doesn't seem right...

Cheers,

Richard

>          if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
>              self.dm.check(self)
> @@ -1821,7 +1828,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>                  sq_task.append(task)
>              call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
>              locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
> -            valid = bb.utils.better_eval(call, locs)
> +            try:
> +                valid = bb.utils.better_eval(call, locs)
> +            except Exception as e:
> +                logger.error("Hash validation failed in RunQueueExecuteScenequeue %s" % str(e))
> +                raise bb.BBHandledException()
>  
>              valid_new = stamppresent
>              for v in valid:
> @@ -2003,7 +2014,6 @@ class TaskFailure(Exception):
>      def __init__(self, x):
>          self.args = x
>  
> -
>  class runQueueExitWait(bb.event.Event):
>      """
>      Event when waiting for task processes to exit



