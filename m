Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2C89270EE2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 12:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RCphmg031109; Wed, 27 Aug 2014 13:51:43 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tFzFLCbmFEat; Wed, 27 Aug 2014 13:51:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RCpa6H031103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 Aug 2014 13:51:38 +0100
Message-ID: <1409143898.5772.46.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Hongxu Jia <hongxu.jia@windriver.com>
Date: Wed, 27 Aug 2014 13:51:38 +0100
In-Reply-To: <6f9c2a0b17e91a37bc1083c799c3820f50bdf926.1409140298.git.hongxu.jia@windriver.com>
References: <cover.1409140298.git.hongxu.jia@windriver.com>
	<6f9c2a0b17e91a37bc1083c799c3820f50bdf926.1409140298.git.hongxu.jia@windriver.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org, Zhangle.Yang@windriver.com
Subject: Re: [PATCH 1/1] bitbake: runqueue: catch HashValidateFailure errors in RunQueueExecuteScenequeue
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
X-List-Received-Date: Wed, 27 Aug 2014 12:51:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-08-27 at 19:54 +0800, Hongxu Jia wrote:
> We need to catch the failure of self.rq.hashvalidate which invoked
> in RunQueueExecuteScenequeue, and exit in a normal build.
> 
> So we add exception HashValidateFailure for this specific error.
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>  bitbake/lib/bb/runqueue.py | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index e13dc57..b48b02b 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1046,7 +1046,15 @@ class RunQueue:
>                  self.state = runQueueComplete
>              else:
>                  self.start_worker()
> -                self.rqexe = RunQueueExecuteScenequeue(self)
> +                try:
> +                    self.rqexe = RunQueueExecuteScenequeue(self)
> +                except bb.runqueue.HashValidateFailure:
> +                    # While HashValidateFailure, we need exit the normal build.
> +                    logger.error("Hash validatation failed in RunQueueExecuteScenequeue")
> +                    self.state = runQueueComplete
> +                except:
> +                    logger.error("RunQueueExecuteScenequeue init failed")
> +                    raise
>  
>          if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
>              self.dm.check(self)
> @@ -1821,7 +1829,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>                  sq_task.append(task)
>              call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
>              locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
> -            valid = bb.utils.better_eval(call, locs)
> +            try:
> +                valid = bb.utils.better_eval(call, locs)
> +            except:
> +                raise bb.runqueue.HashValidateFailure()

How about:

except Exception as e:
	logger.error("Hash validation failed in RunQueueExecuteScenequeue %s" % str(e))
        raise BBHandledException

Raising the HandledException error should shut down the system
gracefully from there. Adding a custom exception here doesn't help much
other than warning about the exact point of failure as we can do that in
the logger.error message.

I think if you made this:

except Exception as e:
	logger.critial("Hash validation failed in RunQueueExecuteScenequeue %s" % str(e))

then we'd not even need to BBHandledException as logger.critical does
that internally but I could be wrong, I'm going from memory.

Cheers,

Richard


>              valid_new = stamppresent
>              for v in valid:
> @@ -2003,6 +2014,8 @@ class TaskFailure(Exception):
>      def __init__(self, x):
>          self.args = x
>  
> +# Exception raised for a hash validation error
> +class HashValidateFailure(Exception): pass
>  
>  class runQueueExitWait(bb.event.Event):
>      """



