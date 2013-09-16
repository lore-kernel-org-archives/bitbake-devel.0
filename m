Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D8E476007B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 14:24:47 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GEclGv015852; Mon, 16 Sep 2013 15:38:48 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qdDLiD1X_udQ; Mon, 16 Sep 2013 15:38:47 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GEci5a015834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 15:38:45 +0100
Message-ID: <1379341468.3484.313.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 15:24:28 +0100
In-Reply-To: <8a649ee0aa5cd852e54078b3d980b99d37ecad7b.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<8a649ee0aa5cd852e54078b3d980b99d37ecad7b.1379338189.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/7] bitbake: runqueue: add runQueueTaskSkipped event
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
X-List-Received-Date: Mon, 16 Sep 2013 14:24:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Adding a runQueueTaskSkipped to notify all listeners
> about the tasks that are not run either because they
> are set-scened or they don't need an update (timestamps
> are ok)
> 
> Adds RunQueueData functions to get the task name and task
> file for usage with the runQueue* events.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/build.py    |  3 +++
>  bitbake/lib/bb/runqueue.py | 27 ++++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index a53aba9..1265bdc 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -72,6 +72,9 @@ class TaskBase(event.Event):
>      def __init__(self, t, d ):
>          self._task = t
>          self._package = d.getVar("PF", True)
> +        self._file = d.getVar("FILE", True)
> +        self.taskfile = self._file
> +        self.taskname = self._task
>          event.Event.__init__(self)
>          self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
>  
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index aa2f147..2ab4405 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -217,6 +217,12 @@ class RunQueueData:
>              ret.extend([nam])
>          return ret
>  
> +    def get_task_name(self, task):
> +        return self.runq_task[task]
> +
> +    def get_task_file(self, task):
> +        return self.taskData.fn_index[self.runq_fnid[task]]
> +
>      def get_user_idstring(self, task, task_name_suffix = ""):
>          fn = self.taskData.fn_index[self.runq_fnid[task]]
>          taskname = self.runq_task[task] + task_name_suffix
> @@ -1328,9 +1334,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
>          if self.rqdata.taskData.abort:
>              self.rq.state = runQueueCleanUp
>  
> -    def task_skip(self, task):
> +    def task_skip(self, task, skip_reason = ""):
>          self.runq_running[task] = 1
>          self.runq_buildable[task] = 1
> +        bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq, skip_reason), self.cfgData)
>          self.task_completeoutright(task)
>          self.stats.taskCompleted()
>          self.stats.taskSkipped()
> @@ -1355,13 +1362,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
>              if task in self.rq.scenequeue_covered:
>                  logger.debug(2, "Setscene covered task %s (%s)", task,
>                                  self.rqdata.get_user_idstring(task))
> -                self.task_skip(task)
> +                self.task_skip(task, "covered")
>                  return True
>  
>              if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
>                  logger.debug(2, "Stamp current task %s (%s)", task,
>                                  self.rqdata.get_user_idstring(task))
> -                self.task_skip(task)
> +                self.task_skip(task, "existing")
>                  return True
>  
>              taskdep = self.rqdata.dataCache.task_deps[fn]
> @@ -1783,6 +1790,8 @@ class runQueueEvent(bb.event.Event):
>      def __init__(self, task, stats, rq):
>          self.taskid = task
>          self.taskstring = rq.rqdata.get_user_idstring(task)
> +        self.taskname = rq.rqdata.get_task_name(task)
> +        self.taskfile = rq.rqdata.get_task_file(task)
>          self.stats = stats.copy()
>          bb.event.Event.__init__(self)
>  
> @@ -1794,6 +1803,8 @@ class sceneQueueEvent(runQueueEvent):
>          runQueueEvent.__init__(self, task, stats, rq)
>          realtask = rq.rqdata.runq_setscene[task]
>          self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
> +        self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
> +        self.taskfile = rq.rqdata.get_task_file(realtask)
>  
>  class runQueueTaskStarted(runQueueEvent):
>      """
> @@ -1837,6 +1848,16 @@ class sceneQueueTaskCompleted(sceneQueueEvent):
>      Event notifing a setscene task completed
>      """
>  
> +class runQueueTaskSkipped(runQueueEvent):
> +    """
> +    Event notifing a task was skipped
> +    """
> +    def __init__(self, task, stats, rq, skip_reason):
> +        runQueueEvent.__init__(self, task, stats, rq)
> +        self._file = rq.rqdata.get_task_file(task)
> +        self._task = rq.rqdata.get_task_name(task)
> +        self._skip = skip_reason
> +
>  class runQueuePipe():
>      """
>      Abstraction for a pipe between a worker thread and the server


Please rebase this one off
http://git.yoctoproject.org/cgit.cgi/poky/commit/?h=master-next&id=39c70d0ad00afa05d343dc19aa557a092db7c963

since we should do one thing in a commit, not three. I renamed _skip ->
reason since its not internal and its a skip event, we know this, the
field is the reason.

You need to separate out the runQueueEvent changes from the TaskBase
changes.

Why add self._file to TaskBase? Surely just taskfile would be enough?
The _ is meant to indicate internal use only and aren't the above events
inconsistent with each other?

Cheers,

Richard


