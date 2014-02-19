Return-Path: <alex.r.damian@gmail.com>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
	[209.85.216.44])
	by mail.openembedded.org (Postfix) with ESMTP id 267A76EFA1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Feb 2014 17:31:33 +0000 (UTC)
Received: by mail-qa0-f44.google.com with SMTP id w5so971796qac.17
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Feb 2014 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=I/73/TEjwk/tFv7RzQJI0WH7W87m3tgFV9ZQknK2eLc=;
	b=pBKAmB9N4aFu/bCUqbfleAdOZ3RM5RHBTJ+iWKNCQ7TeBUpaap3TKgXrAMiUQs+EhX
	r1TWBZO1ebELyAXppuWonXkD5Kf7Ewa2jIOwCWz0XNThTcJ5Wp068deiC+wl9T1O/Clm
	NsfaCPYvQaYwPuAKyKS6D0MDB433x0YzlHKkjD3+d2e/nGEx1LCTT4xs6melgNnx7eRA
	SJkv2P1u+svSrFhGa+Ocj6x3HWIpsuTJaKdKQpySiEQDpp1kUZTI3Nt0gz7u2iQWct9U
	oZZqq98IRgXpyhVl9h2z0qqQEDBu/MPZ+KAgKzP8aRbRBrsNy/G9EFekm4kN8Xe0TWLG
	Wx+A==
MIME-Version: 1.0
X-Received: by 10.140.100.240 with SMTP id s103mr48212350qge.38.1392831094495; 
	Wed, 19 Feb 2014 09:31:34 -0800 (PST)
Received: by 10.224.8.9 with HTTP; Wed, 19 Feb 2014 09:31:34 -0800 (PST)
In-Reply-To: <1392803554-27957-1-git-send-email-marius.avram@intel.com>
References: <1392803554-27957-1-git-send-email-marius.avram@intel.com>
Date: Wed, 19 Feb 2014 17:31:34 +0000
Message-ID: <CAL7ttbeiZFQWFm_C1DN5BkFxAEVJzb+1PV4V6Fi1D8fj6hi3dg@mail.gmail.com>
From: Alex Damian <alex.r.damian@gmail.com>
To: Marius Avram <marius.avram@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: time data for tasks differ from buildstats
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
X-List-Received-Date: Wed, 19 Feb 2014 17:31:37 -0000
Content-Type: multipart/alternative; boundary=001a11c16ccc9e9cb004f2c5c2c0

--001a11c16ccc9e9cb004f2c5c2c0
Content-Type: text/plain; charset=ISO-8859-1

Please hold merging this patch.

I have discovered a unrelated problem processing bb.build.Task* events
which will affect how this patch is structured.

Alex


On Wed, Feb 19, 2014 at 9:52 AM, Marius Avram <marius.avram@intel.com>wrote:

> The BuildInfoHelper class was measuring separately the time for a build.
> This was causing many difference in the time measured by buildstats class
> and
> the time measured here. The main problem is toaster does database
> operations
> which delay the arrival of events.
>
> The simplest solution, which is implemented in this fix, is to keep the
> time
> of creation for every BaseTask and calculate the duration by making a
> difference between the creation time of TaskSucceeded and TaskStarted.
>
> [YOCTO #5727]
>
> Signed-off-by: Marius Avram <marius.avram@intel.com>
> ---
>  bitbake/lib/bb/build.py              |    2 ++
>  bitbake/lib/bb/ui/buildinfohelper.py |   17 +++++++++++------
>  bitbake/lib/bb/ui/toasterui.py       |    6 +++++-
>  3 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 50a28dc..03e7996 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -30,6 +30,7 @@ import sys
>  import logging
>  import shlex
>  import glob
> +import time
>  import bb
>  import bb.msg
>  import bb.process
> @@ -75,6 +76,7 @@ class TaskBase(event.Event):
>          self.taskfile = d.getVar("FILE", True)
>          self.taskname = self._task
>          self.logfile = logfile
> +        self.time = time.time()
>          event.Event.__init__(self)
>          self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True),
> t, self.getDisplayName())
>
> diff --git a/bitbake/lib/bb/ui/buildinfohelper.py
> b/bitbake/lib/bb/ui/buildinfohelper.py
> index da777f1..093d685 100644
> --- a/bitbake/lib/bb/ui/buildinfohelper.py
> +++ b/bitbake/lib/bb/ui/buildinfohelper.py
> @@ -102,10 +102,9 @@ class ORMWrapper(object):
>              elif outcome_task_setscene == Task.OUTCOME_FAILED:
>                  task_object.sstate_result = Task.SSTATE_FAILED
>
> -        # mark down duration if we have a start time
> -        if 'start_time' in task_information.keys():
> -            duration = datetime.datetime.now() -
> task_information['start_time']
> -            task_object.elapsed_time = duration.total_seconds()
> +        # mark down duration if we have an end time
> +        if 'end_time' in task_information.keys():
> +            task_object.elapsed_time = task_information['end_time'] -
> task_information['start_time']
>
>          task_object.save()
>          return task_object
> @@ -448,6 +447,10 @@ class BuildInfoHelper(object):
>          task_information = self._get_task_information(event, recipe)
>          task_information['outcome'] = Task.OUTCOME_NA
>
> +        self.internal_state[identifier] = {}
> +        if isinstance(event, bb.build.TaskStarted):
> +            self.internal_state[identifier]['start_time'] = event.time
> +
>          if isinstance(event, bb.runqueue.runQueueTaskSkipped):
>              task_information['task_executed'] = False
>              if event.reason == "covered":
> @@ -468,8 +471,6 @@ class BuildInfoHelper(object):
>
>          task_obj =
> self.orm_wrapper.get_update_task_object(task_information)
>
> -        self.internal_state[identifier] = {'start_time':
> datetime.datetime.now()}
> -
>
>      def store_tasks_stats(self, event):
>          for (taskfile, taskname, taskstats) in event.data:
> @@ -507,6 +508,10 @@ class BuildInfoHelper(object):
>              else:
>                  task_information['script_type'] = Task.CODING_SHELL
>
> +        if isinstance(event, bb.build.TaskSucceeded):
> +            task_information['start_time'] =
> self.internal_state[identifier]['start_time']
> +            task_information['end_time'] = event.time
> +
>          if isinstance(event, (bb.runqueue.runQueueTaskCompleted,
> bb.runqueue.sceneQueueTaskCompleted)):
>              task_information['outcome'] = Task.OUTCOME_SUCCESS
>              del self.internal_state[identifier]
> diff --git a/bitbake/lib/bb/ui/toasterui.py
> b/bitbake/lib/bb/ui/toasterui.py
> index e469d93..58abfd3 100644
> --- a/bitbake/lib/bb/ui/toasterui.py
> +++ b/bitbake/lib/bb/ui/toasterui.py
> @@ -109,7 +109,11 @@ def main(server, eventHandler, params ):
>              if isinstance(event, bb.event.BuildStarted):
>                  buildinfohelper.store_started_build(event)
>
> -            if isinstance(event, (bb.build.TaskStarted,
> bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
> +            if isinstance(event, bb.build.TaskStarted):
> +                buildinfohelper.store_started_task(event)
> +                continue
> +
> +            if isinstance(event, (bb.build.TaskSucceeded,
> bb.build.TaskFailedSilent)):
>                  buildinfohelper.update_and_store_task(event)
>                  continue
>
> --
> 1.7.9.5
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a11c16ccc9e9cb004f2c5c2c0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please hold merging this patch.<div><br></div><div>I have =
discovered a unrelated problem processing bb.build.Task* events which will =
affect how this patch is structured.</div><div><br></div><div>Alex</div></d=
iv>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Feb 1=
9, 2014 at 9:52 AM, Marius Avram <span dir=3D"ltr">&lt;<a href=3D"mailto:ma=
rius.avram@intel.com" target=3D"_blank">marius.avram@intel.com</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The BuildInfoHelper class was measuring sepa=
rately the time for a build.<br>
This was causing many difference in the time measured by buildstats class a=
nd<br>
the time measured here. The main problem is toaster does database operation=
s<br>
which delay the arrival of events.<br>
<br>
The simplest solution, which is implemented in this fix, is to keep the tim=
e<br>
of creation for every BaseTask and calculate the duration by making a<br>
difference between the creation time of TaskSucceeded and TaskStarted.<br>
<br>
[YOCTO #5727]<br>
<br>
Signed-off-by: Marius Avram &lt;<a href=3D"mailto:marius.avram@intel.com">m=
arius.avram@intel.com</a>&gt;<br>
---<br>
=A0bitbake/lib/bb/build.py =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 ++<br>
=A0bitbake/lib/bb/ui/buildinfohelper.py | =A0 17 +++++++++++------<br>
=A0bitbake/lib/bb/ui/toasterui.py =A0 =A0 =A0 | =A0 =A06 +++++-<br>
=A03 files changed, 18 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py<br>
index 50a28dc..03e7996 100644<br>
--- a/bitbake/lib/bb/build.py<br>
+++ b/bitbake/lib/bb/build.py<br>
@@ -30,6 +30,7 @@ import sys<br>
=A0import logging<br>
=A0import shlex<br>
=A0import glob<br>
+import time<br>
=A0import bb<br>
=A0import bb.msg<br>
=A0import bb.process<br>
@@ -75,6 +76,7 @@ class TaskBase(event.Event):<br>
=A0 =A0 =A0 =A0 =A0self.taskfile =3D d.getVar(&quot;FILE&quot;, True)<br>
=A0 =A0 =A0 =A0 =A0self.taskname =3D self._task<br>
=A0 =A0 =A0 =A0 =A0self.logfile =3D logfile<br>
+ =A0 =A0 =A0 =A0self.time =3D time.time()<br>
=A0 =A0 =A0 =A0 =A0event.Event.__init__(self)<br>
=A0 =A0 =A0 =A0 =A0self._message =3D &quot;recipe %s: task %s: %s&quot; % (=
d.getVar(&quot;PF&quot;, True), t, self.getDisplayName())<br>
<br>
diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/build=
infohelper.py<br>
index da777f1..093d685 100644<br>
--- a/bitbake/lib/bb/ui/buildinfohelper.py<br>
+++ b/bitbake/lib/bb/ui/buildinfohelper.py<br>
@@ -102,10 +102,9 @@ class ORMWrapper(object):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0elif outcome_task_setscene =3D=3D Task.OUTCOME_F=
AILED:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0task_object.sstate_result =3D Task.SSTAT=
E_FAILED<br>
<br>
- =A0 =A0 =A0 =A0# mark down duration if we have a start time<br>
- =A0 =A0 =A0 =A0if &#39;start_time&#39; in task_information.keys():<br>
- =A0 =A0 =A0 =A0 =A0 =A0duration =3D datetime.datetime.now() - task_inform=
ation[&#39;start_time&#39;]<br>
- =A0 =A0 =A0 =A0 =A0 =A0task_object.elapsed_time =3D duration.total_second=
s()<br>
+ =A0 =A0 =A0 =A0# mark down duration if we have an end time<br>
+ =A0 =A0 =A0 =A0if &#39;end_time&#39; in task_information.keys():<br>
+ =A0 =A0 =A0 =A0 =A0 =A0task_object.elapsed_time =3D task_information[&#39=
;end_time&#39;] - task_information[&#39;start_time&#39;]<br>
<br>
=A0 =A0 =A0 =A0 =A0task_object.save()<br>
=A0 =A0 =A0 =A0 =A0return task_object<br>
@@ -448,6 +447,10 @@ class BuildInfoHelper(object):<br>
=A0 =A0 =A0 =A0 =A0task_information =3D self._get_task_information(event, r=
ecipe)<br>
=A0 =A0 =A0 =A0 =A0task_information[&#39;outcome&#39;] =3D Task.OUTCOME_NA<=
br>
<br>
+ =A0 =A0 =A0 =A0self.internal_state[identifier] =3D {}<br>
+ =A0 =A0 =A0 =A0if isinstance(event, bb.build.TaskStarted):<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.internal_state[identifier][&#39;start_time&#3=
9;] =3D event.time<br>
+<br>
=A0 =A0 =A0 =A0 =A0if isinstance(event, bb.runqueue.runQueueTaskSkipped):<b=
r>
=A0 =A0 =A0 =A0 =A0 =A0 =A0task_information[&#39;task_executed&#39;] =3D Fa=
lse<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0if event.reason =3D=3D &quot;covered&quot;:<br>
@@ -468,8 +471,6 @@ class BuildInfoHelper(object):<br>
<br>
=A0 =A0 =A0 =A0 =A0task_obj =3D self.orm_wrapper.get_update_task_object(tas=
k_information)<br>
<br>
- =A0 =A0 =A0 =A0self.internal_state[identifier] =3D {&#39;start_time&#39;:=
 datetime.datetime.now()}<br>
-<br>
<br>
=A0 =A0 =A0def store_tasks_stats(self, event):<br>
=A0 =A0 =A0 =A0 =A0for (taskfile, taskname, taskstats) in event.data:<br>
@@ -507,6 +508,10 @@ class BuildInfoHelper(object):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0else:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0task_information[&#39;script_type&#39;] =
=3D Task.CODING_SHELL<br>
<br>
+ =A0 =A0 =A0 =A0if isinstance(event, bb.build.TaskSucceeded):<br>
+ =A0 =A0 =A0 =A0 =A0 =A0task_information[&#39;start_time&#39;] =3D self.in=
ternal_state[identifier][&#39;start_time&#39;]<br>
+ =A0 =A0 =A0 =A0 =A0 =A0task_information[&#39;end_time&#39;] =3D event.tim=
e<br>
+<br>
=A0 =A0 =A0 =A0 =A0if isinstance(event, (bb.runqueue.runQueueTaskCompleted,=
 bb.runqueue.sceneQueueTaskCompleted)):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0task_information[&#39;outcome&#39;] =3D Task.OUT=
COME_SUCCESS<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0del self.internal_state[identifier]<br>
diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.p=
y<br>
index e469d93..58abfd3 100644<br>
--- a/bitbake/lib/bb/ui/toasterui.py<br>
+++ b/bitbake/lib/bb/ui/toasterui.py<br>
@@ -109,7 +109,11 @@ def main(server, eventHandler, params ):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0if isinstance(event, bb.event.BuildStarted):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buildinfohelper.store_started_build(even=
t)<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0if isinstance(event, (bb.build.TaskStarted, bb.bui=
ld.TaskSucceeded, bb.build.TaskFailedSilent)):<br>
+ =A0 =A0 =A0 =A0 =A0 =A0if isinstance(event, bb.build.TaskStarted):<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buildinfohelper.store_started_task(event)<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0if isinstance(event, (bb.build.TaskSucceeded, bb.b=
uild.TaskFailedSilent)):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buildinfohelper.update_and_store_task(ev=
ent)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.9.5<br>
<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br></div>

--001a11c16ccc9e9cb004f2c5c2c0--
