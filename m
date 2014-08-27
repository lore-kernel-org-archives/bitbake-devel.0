Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1F4A3710CE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RAnaSY025422; Wed, 27 Aug 2014 11:49:36 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZxiVl2HL7bVu; Wed, 27 Aug 2014 11:49:36 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RAnW97025419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 Aug 2014 11:49:34 +0100
Message-ID: <1409136574.5772.37.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Hongxu Jia <hongxu.jia@windriver.com>
Date: Wed, 27 Aug 2014 11:49:34 +0100
In-Reply-To: <4ce3cc607c61c23904de8f3844e7e8b360375557.1409136202.git.hongxu.jia@windriver.com>
References: <cover.1409136202.git.hongxu.jia@windriver.com>
	<4ce3cc607c61c23904de8f3844e7e8b360375557.1409136202.git.hongxu.jia@windriver.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: runqueue: terminate build safely while RunQueueExecuteScenequeue init failed
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
X-List-Received-Date: Wed, 27 Aug 2014 10:49:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-08-27 at 18:44 +0800, Hongxu Jia wrote:
> While RunQueueExecuteScenequeue init failed, the exit of build is mess.
> Here is the example while bb.fatal invoked in RunQueueExecuteScenequeue:
> ...
> Traceback (most recent call last):
> |  File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py",
>   line 1824, in RunQueueExecuteScenequeue.__init__(rq=<bb.runqueue.RunQueue
>   instance at 0x7f87dd7d5050>):
> |                 locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname,
>   "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
> |    >            valid = bb.utils.better_eval(call, locs)
> 
> |    def better_eval(source, locals):
> |    >    return eval(source, get_context(), locals)
> 
> |  File "<string>", line 1, in <module>
> |  File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/__init__.py", line 102,
>   in fatal:
> |         logger.critical(''.join(args))
> |    >    raise BBHandledException()
> 
> BBHandledException
> ...
> 
> We should terminate build safely while RunQueueExecuteScenequeue init failed.
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>  bitbake/lib/bb/runqueue.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index e13dc57..c7b1dc0 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1046,7 +1046,12 @@ class RunQueue:
>                  self.state = runQueueComplete
>              else:
>                  self.start_worker()
> -                self.rqexe = RunQueueExecuteScenequeue(self)
> +                try:
> +                    self.rqexe = RunQueueExecuteScenequeue(self)
> +                except:
> +                    # The RunQueueExecuteScenequeue init failure
> +                    # terminated the build safely
> +                    self.state = runQueueComplete
>  

If the init fails, shouldn't we show a traceback and exit with an error
status? Does this happen in a normal build and if so, is there an
underlying cause we should fix?

I'm worried this would let errors go unnoticed. Except clauses in
general should catch specific errors not every exception so this really
can't merge in this form, sorry.

Cheers,

Richard



