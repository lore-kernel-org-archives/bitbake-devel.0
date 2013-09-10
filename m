Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2B493614F3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2013 13:52:30 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8AE5md6022111; Tue, 10 Sep 2013 15:05:58 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CJ7LATAmoy5B; Tue, 10 Sep 2013 15:05:58 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8AE5sLW022114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 10 Sep 2013 15:05:56 +0100
Message-ID: <1378821132.3484.153.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Tue, 10 Sep 2013 14:52:12 +0100
In-Reply-To: <9e330c1945465cfe7838a940e27cfb3e98f7f0ba.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
	<9e330c1945465cfe7838a940e27cfb3e98f7f0ba.1378743829.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 04/13] bitbake: runqueue, build: event data change
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
X-List-Received-Date: Tue, 10 Sep 2013 13:52:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-09 at 17:40 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> We modify event data to make sure we can match build events
> with runqueue events. This is important because the build
> events supply datastore-evaluated data while runqueue events supply
> bitbake-related data. We get the recipe name and version from
> the datastore, while the file paths and timing information are
> collected from the RunQueue.
> 
> We modify filling-in the information side to take advantage of the
> new info supplied.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/build.py    | 3 +++
>  bitbake/lib/bb/runqueue.py | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
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
> index 002bf76..73dd059 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -220,7 +220,7 @@ class RunQueueData:
>      def get_task_name(self, task):
>          return self.runq_task[task]
>  
> -    def get_task_package(self, task):
> +    def get_task_file(self, task):
>          return self.taskData.fn_index[self.runq_fnid[task]]
>  
>      def get_user_idstring(self, task, task_name_suffix = ""):
> @@ -1787,7 +1787,7 @@ class runQueueEvent(bb.event.Event):
>          self.taskid = task
>          self.taskstring = rq.rqdata.get_user_idstring(task)
>          self.taskname = rq.rqdata.get_task_name(task)
> -        self.taskpackage = rq.rqdata.get_task_package(task)
> +        self.taskfile = rq.rqdata.get_task_file(task)
>          self.stats = stats.copy()
>          bb.event.Event.__init__(self)
>  
> @@ -1800,7 +1800,7 @@ class sceneQueueEvent(runQueueEvent):
>          realtask = rq.rqdata.runq_setscene[task]
>          self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
>          self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
> -        self.taskpackage = rq.rqdata.get_task_package(realtask)
> +        self.taskfile = rq.rqdata.get_task_file(realtask)
>  
>  class runQueueTaskStarted(runQueueEvent):
>      """
> @@ -1845,7 +1845,7 @@ class runQueueTaskSkipped(runQueueEvent):
>      """
>      def __init__(self, task, stats, rq, skip_reason):
>          runQueueEvent.__init__(self, task, stats, rq)
> -        self._package = rq.rqdata.get_task_package(task)
> +        self._file = rq.rqdata.get_task_file(task)
>          self._task = rq.rqdata.get_task_name(task)
>          self._skip = skip_reason
>  

You added get_task_package() in 2/13, added calls to in 3/13, now we're
getting rid of it. Is there not some way to clean up these patches so we
just add the right things? Is get_task_package() still needed? Reviewing
patches where things get added then removed again is rather confusing...

Cheers,

Richard




