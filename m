Return-Path: <Mark.Asselstine@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9BFA560797
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Oct 2016 16:07:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u97G7DKe021666
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 7 Oct 2016 09:07:14 -0700 (PDT)
Received: from super-penguin.localnet (128.224.21.208) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.294.0; Fri, 7 Oct 2016 09:07:12 -0700
From: Mark Asselstine <mark.asselstine@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Reply-To: <mark.asselstine@windriver.com>
Date: Fri, 7 Oct 2016 12:07:09 -0400
Message-ID: <2081508.WgDnl3Zsm2@super-penguin>
Organization: Wind River Systems Inc.
User-Agent: KMail/5.1.3 (Linux/4.4.0-38-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <1475825208.30475.614.camel@linuxfoundation.org>
References: <1475825208.30475.614.camel@linuxfoundation.org>
MIME-Version: 1.0
X-Originating-IP: [128.224.21.208]
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Optimise task id string manipulations
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
X-List-Received-Date: Fri, 07 Oct 2016 16:07:14 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, October 7, 2016 8:26:48 AM EDT Richard Purdie wrote:
> Some task id manipulations were suboptimal:
> 
> * taskfn_fromtid and fn_from_tid were effectively the same function
> * many calls to split_tid(), then taskfn_fromtid()
> * taskfn_fromtid() called split_tid() internally
> 
> This patch adds split_tid_mcfn() to replace split_tid() and returns the
> "taskfn" variant being used in many places. We update all core calls
> to the new function and ignore the return values we don't need since the
> function call overhead of the split_tid wrapper is higher than ignoring
> a return value.
> 
> The one remaining standalone use of taskfn_fromtid is replaced with
> fn_from_tid. I couldn't see any external usage so it was dropped.
> 
> There is external usage of split_tid so a wrapper remains for it.
> 
> Combined together these changes should improve some of the runqueue task
> manipulation performance.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Thanks Richard. As per our discussion on IRC yesterday these changes are 
inline with what I was expecting. After sorting out the encoding on this email 
to get the patch applied I was able to confirm that we do get some performance 
improvements. For my specific test configuration of ~4500 tasks I am seeing > 
1 second performance improvement and 1/2million less function calls. (when not 
profiling that will be 1/2second improvement since profiling is doubling my 
runtime). With the cleanup of taskfn_fromtid and fn_from_tid I will be able to 
put together some additional performance improvement patches and send them out 
for discussion in the next few days.

Thanks again,
Mark

> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 934072c..42831e2 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -748,8 +748,7 @@ class BBCooker:
>                      depend_tree['providermap'][name] = (pn, version)
>  
>          for tid in rq.rqdata.runtaskentries:
> -            (mc, fn, taskname) = bb.runqueue.split_tid(tid)
> -            taskfn = bb.runqueue.taskfn_fromtid(tid)
> +            (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
>              pn = self.recipecaches[mc].pkg_fn[taskfn]
>              pn = self.add_mc_prefix(mc, pn)
>              version  = "%s:%s-%s" %
> self.recipecaches[mc].pkg_pepvpr[taskfn] @@ -772,8 +771,7 @@ class
> BBCooker:
>  
>  
>              for dep in rq.rqdata.runtaskentries[tid].depends:
> -                (depmc, depfn, deptaskname) = bb.runqueue.split_tid(dep)
> -                deptaskfn = bb.runqueue.taskfn_fromtid(dep)
> +                (depmc, depfn, deptaskname, deptaskfn) =
> bb.runqueue.split_tid_mcfn(dep) deppn =
> self.recipecaches[mc].pkg_fn[deptaskfn]
>                  dotname = "%s.%s" % (pn,
> bb.runqueue.taskname_from_tid(tid)) if not dotname in
> depend_tree["tdepends"]:
> @@ -843,8 +841,7 @@ class BBCooker:
>                  tids.append(tid)
>  
>          for tid in tids:
> -            (mc, fn, taskname) = bb.runqueue.split_tid(tid)
> -            taskfn = bb.runqueue.taskfn_fromtid(tid)
> +            (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
>  
>              pn = self.recipecaches[mc].pkg_fn[taskfn]
>              pn = self.add_mc_prefix(mc, pn)
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 0483b95..3b674ba 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -49,30 +49,30 @@ def taskname_from_tid(tid):
>      return tid.rsplit(":", 1)[1]
>  
>  def split_tid(tid):
> +    (mc, fn, taskname, _) = split_tid_mcfn(tid)
> +    return (mc, fn, taskname)
> +
> +def split_tid_mcfn(tid):
>      if tid.startswith('multiconfig:'):
>          elems = tid.split(':')
>          mc = elems[1]
>          fn = ":".join(elems[2:-1])
>          taskname = elems[-1]
> +        mcfn = "multiconfig:" + mc + ":" + fn
>      else:
>          tid = tid.rsplit(":", 1)
>          mc = ""
>          fn = tid[0]
>          taskname = tid[1]
> +        mcfn = fn
>  
> -    return (mc, fn, taskname)
> +    return (mc, fn, taskname, mcfn)
>  
>  def build_tid(mc, fn, taskname):
>      if mc:
>          return "multiconfig:" + mc + ":" + fn + ":" + taskname
>      return fn + ":" + taskname
>  
> -def taskfn_fromtid(tid):
> -    (mc, fn, taskname) = split_tid(tid)
> -    if mc:
> -        return "multiconfig:" + mc + ":" + fn
> -    return fn
> -
>  class RunQueueStats:
>      """
>      Holds statistics on the tasks handled by the associated runQueue
> @@ -135,8 +135,7 @@ class RunQueueScheduler(object):
>          self.buildable = []
>          self.stamps = {}
>          for tid in self.rqdata.runtaskentries:
> -            (mc, fn, taskname) = split_tid(tid)
> -            taskfn = taskfn_fromtid(tid)
> +            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>              self.stamps[tid] = bb.build.stampfile(taskname,
> self.rqdata.dataCaches[mc], taskfn, noextra=True) if tid in
> self.rq.runq_buildable:
>                  self.buildable.append(tid)
> @@ -289,7 +288,7 @@ class RunQueueData:
>          return tid + task_name_suffix
>  
>      def get_short_user_idstring(self, task, task_name_suffix = ""):
> -        (mc, fn, taskname) = split_tid(task)
> +        (mc, fn, taskname, _) = split_tid_mcfn(task)
>          pn = self.dataCaches[mc].pkg_fn[fn]
>          taskname = taskname_from_tid(task) + task_name_suffix
>          return "%s:%s" % (pn, taskname)
> @@ -511,9 +510,8 @@ class RunQueueData:
>          for mc in taskData:
>              for tid in taskData[mc].taskentries:
>  
> -                (mc, fn, taskname) = split_tid(tid)
> +                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>                  #runtid = build_tid(mc, fn, taskname)
> -                taskfn = taskfn_fromtid(tid)
>  
>                  #logger.debug(2, "Processing %s,%s:%s", mc, fn, taskname)
>  
> @@ -529,7 +527,7 @@ class RunQueueData:
>                  #
>                  # e.g. addtask before X after Y
>                  for t in taskData[mc].taskentries[tid].tdepends:
> -                    (_, depfn, deptaskname) = split_tid(t)
> +                    (_, depfn, deptaskname, _) = split_tid_mcfn(t)
>                      depends.add(build_tid(mc, depfn, deptaskname))
>  
>                  # Resolve 'deptask' dependencies
> @@ -611,7 +609,7 @@ class RunQueueData:
>  
>              def generate_recdeps(t):
>                  newdeps = set()
> -                (mc, fn, taskname) = split_tid(t)
> +                (mc, fn, taskname, _) = split_tid_mcfn(t)
>                  add_resolved_dependencies(mc, fn, tasknames, newdeps)
>                  extradeps[tid].update(newdeps)
>                  seendeps.add(t)
> @@ -774,8 +772,7 @@ class RunQueueData:
>              prov_list = {}
>              seen_fn = []
>              for tid in self.runtaskentries:
> -                (tidmc, fn, taskname) = split_tid(tid)
> -                taskfn = taskfn_fromtid(tid)
> +                (tidmc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>                  if taskfn in seen_fn:
>                      continue
>                  if mc != tidmc:
> @@ -885,14 +882,14 @@ class RunQueueData:
>          self.runq_setscene_tids = []
>          if not self.cooker.configuration.nosetscene:
>              for tid in self.runtaskentries:
> -                (mc, fn, taskname) = split_tid(tid)
> +                (mc, fn, taskname, _) = split_tid_mcfn(tid)
>                  setscenetid = fn + ":" + taskname + "_setscene"
>                  if setscenetid not in taskData[mc].taskentries:
>                      continue
>                  self.runq_setscene_tids.append(tid)
>  
>          def invalidate_task(tid, error_nostamp):
> -            (mc, fn, taskname) = split_tid(tid)
> +            (mc, fn, taskname, _) = split_tid_mcfn(tid)
>              taskdep = self.dataCaches[mc].task_deps[fn]
>              if fn + ":" + taskname not in taskData[mc].taskentries:
>                  logger.warning("Task %s does not exist, invalidating this
> task will have no effect" % taskname) @@ -946,8 +943,7 @@ class
> RunQueueData:
>                      procdep = []
>                      for dep in self.runtaskentries[tid].depends:
>                          procdep.append(fn_from_tid(dep) + "." +
> taskname_from_tid(dep)) -                    (mc, fn, taskname) =
> split_tid(tid)
> -                    taskfn = taskfn_fromtid(tid)
> +                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>                      self.runtaskentries[tid].hash =
> bb.parse.siggen.get_taskhash(taskfn, taskname, procdep,
> self.dataCaches[mc]) task = self.runtaskentries[tid].task
>  
> @@ -1099,8 +1095,7 @@ class RunQueue:
>              except:
>                  return None
>  
> -        (mc, fn, tn) = split_tid(tid)
> -        taskfn = taskfn_fromtid(tid)
> +        (mc, fn, tn, taskfn) = split_tid_mcfn(tid)
>          if taskname is None:
>              taskname = tn
>  
> @@ -1134,8 +1129,7 @@ class RunQueue:
>          t1 = get_timestamp(stampfile)
>          for dep in self.rqdata.runtaskentries[tid].depends:
>              if iscurrent:
> -                (mc2, fn2, taskname2) = split_tid(dep)
> -                taskfn2 = taskfn_fromtid(dep)
> +                (mc2, fn2, taskname2, taskfn2) = split_tid_mcfn(dep)
>                  stampfile2 = bb.build.stampfile(taskname2,
> self.rqdata.dataCaches[mc2], taskfn2) stampfile3 =
> bb.build.stampfile(taskname2 + "_setscene", self.rqdata.dataCaches[mc2],
> taskfn2) t2 = get_timestamp(stampfile2)
> @@ -1247,7 +1241,7 @@ class RunQueue:
>              if not self.rqdata.taskData[''].tryaltconfigs:
>                  raise bb.runqueue.TaskFailure(self.rqexe.failed_tids)
>              for tid in self.rqexe.failed_tids:
> -                (mc, fn, tn) = split_tid(tid)
> +                (mc, fn, tn, _) = split_tid_mcfn(tid)
>                  self.rqdata.taskData[mc].fail_fn(fn)
>              self.rqdata.reset()
>  
> @@ -1297,7 +1291,7 @@ class RunQueue:
>          bb.note("Reparsing files to collect dependency data")
>          bb_cache = bb.cache.NoCache(self.cooker.databuilder)
>          for tid in self.rqdata.runtaskentries:
> -            fn = taskfn_fromtid(tid)
> +            fn = fn_from_tid(tid)
>              if fn not in done:
>                  the_data = bb_cache.loadDataFull(fn,
> self.cooker.collection.get_file_appends(fn)) done.add(fn)
> @@ -1319,8 +1313,7 @@ class RunQueue:
>          valid_new = set()
>  
>          for tid in self.rqdata.runtaskentries:
> -            (mc, fn, taskname) = split_tid(tid)
> -            taskfn = taskfn_fromtid(tid)
> +            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>              taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
>  
>              if 'noexec' in taskdep and taskname in taskdep['noexec']:
> @@ -1408,7 +1401,7 @@ class RunQueue:
>  
>  
>          for tid in invalidtasks:
> -            (mc, fn, taskname) = split_tid(tid)
> +            (mc, fn, taskname, _) = split_tid_mcfn(tid)
>              pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
>              h = self.rqdata.runtaskentries[tid].hash
>              matches = bb.siggen.find_siginfo(pn, taskname, [],
> self.cfgData) @@ -1512,7 +1505,7 @@ class RunQueueExecute:
>          taskdata = {}
>          taskdeps.add(task)
>          for dep in taskdeps:
> -            (mc, fn, taskname) = split_tid(dep)
> +            (mc, fn, taskname, _) = split_tid_mcfn(dep)
>              pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
>              taskdata[dep] = [pn, taskname, fn]
>          call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
> @@ -1569,8 +1562,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
>              tasknames = {}
>              fns = {}
>              for tid in self.rqdata.runtaskentries:
> -                (mc, fn, taskname) = split_tid(tid)
> -                taskfn = taskfn_fromtid(tid)
> +                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>                  taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
>                  fns[tid] = taskfn
>                  tasknames[tid] = taskname
> @@ -1589,9 +1581,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
>              covered_remove = bb.utils.better_eval(call, locs)
>  
>          def removecoveredtask(tid):
> -            (mc, fn, taskname) = split_tid(tid)
> +            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>              taskname = taskname + '_setscene'
> -            taskfn = taskfn_fromtid(tid)
>              bb.build.del_stamp(taskname, self.rqdata.dataCaches[mc],
> taskfn) self.rq.scenequeue_covered.remove(tid)
>  
> @@ -1617,7 +1608,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
>          for mc in self.rqdata.dataCaches:
>              target_pairs = []
>              for tid in self.rqdata.target_tids:
> -                (tidmc, fn, taskname) = split_tid(tid)
> +                (tidmc, fn, taskname, _) = split_tid_mcfn(tid)
>                  if tidmc == mc:
>                      target_pairs.append((fn, taskname))
>  
> @@ -1713,7 +1704,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
>          if self.rqdata.setscenewhitelist:
>              # Check tasks that are going to run against the whitelist
>              def check_norun_task(tid, showerror=False):
> -                (mc, fn, taskname) = split_tid(tid)
> +                (mc, fn, taskname, _) = split_tid_mcfn(tid)
>                  # Ignore covered tasks
>                  if tid in self.rq.scenequeue_covered:
>                      return False
> @@ -1761,8 +1752,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
>  
>          task = self.sched.next()
>          if task is not None:
> -            (mc, fn, taskname) = split_tid(task)
> -            taskfn = taskfn_fromtid(task)
> +            (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
>  
>              if task in self.rq.scenequeue_covered:
>                  logger.debug(2, "Setscene covered task %s", task)
> @@ -1842,8 +1832,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
>          while next:
>              additional = []
>              for revdep in next:
> -                (mc, fn, taskname) = split_tid(revdep)
> -                taskfn = taskfn_fromtid(revdep)
> +                (mc, fn, taskname, taskfn) = split_tid_mcfn(revdep)
>                  pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
>                  deps = self.rqdata.runtaskentries[revdep].depends
>                  provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
> @@ -1999,7 +1988,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>          # e.g. do_sometask_setscene[depends] =
> "targetname:do_someothertask_setscene" # Note that anything explicitly
> depended upon will have its reverse dependencies removed to avoid circular
> dependencies for tid in self.rqdata.runq_setscene_tids:
> -                (mc, fn, taskname) = split_tid(tid)
> +                (mc, fn, taskname, _) = split_tid_mcfn(tid)
>                  realtid = fn + ":" + taskname + "_setscene"
>                  idepends =
> self.rqdata.taskData[mc].taskentries[realtid].idepends for (depname,
> idependtask) in idepends:
> @@ -2063,8 +2052,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>              noexec = []
>              stamppresent = []
>              for tid in self.sq_revdeps:
> -                (mc, fn, taskname) = split_tid(tid)
> -                taskfn = taskfn_fromtid(tid)
> +                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>  
>                  taskdep = self.rqdata.dataCaches[mc].task_deps[fn]
>  
> @@ -2135,7 +2123,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>      def check_taskfail(self, task):
>          if self.rqdata.setscenewhitelist:
>              realtask = task.split('_setscene')[0]
> -            (mc, fn, taskname) = split_tid(realtask)
> +            (mc, fn, taskname, _) = split_tid_mcfn(realtask)
>              pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
>              if not check_setscene_enforce_whitelist(pn, taskname,
> self.rqdata.setscenewhitelist): logger.error('Task %s.%s failed' % (pn,
> taskname + "_setscene")) @@ -2199,8 +2187,7 @@ class
> RunQueueExecuteScenequeue(RunQueueExecute): task = nexttask
>                      break
>          if task is not None:
> -            (mc, fn, taskname) = split_tid(task)
> -            taskfn = taskfn_fromtid(task)
> +            (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
>              taskname = taskname + "_setscene"
>              if self.rq.check_stamp_task(task, taskname_from_tid(task),
> recurse = True, cache=self.stampcache): logger.debug(2, 'Stamp for
> underlying task %s is current, so skipping setscene variant', task)



