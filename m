Return-Path: <alexandru.damian@intel.com>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 1409B601DB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 14:32:27 +0000 (UTC)
Received: by mail-ie0-f181.google.com with SMTP id tp5so7719856ieb.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 07:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=dt4fIgFf1WaaXp9IwiAMQHhILA2PY/jlgFkvtyPtVz8=;
	b=dKkiy6XBFSUSbbcVpINkJW2YF9GvRACcOBp8W8832/t+cJ2QNudcoHR9R+bRU372we
	ACp+JLNRF0Lzi9k+ely4naht2cP0R0dv66kHD7Up3oKt7V+IFRqARDTLV45IHsaYbBme
	g4Bxndm/CF9iBhCCVU8Ue40JJKUPleZ4kJu+WUrKaWRkWudJL0+4jm4xfD7XlyvaJGGQ
	h/JvXunaAF0Tqc7hj8UHp5MzvY3LmTPbM2osrBfNJqxKDWwMDBskmqpCFzuw65QTzIGQ
	HhRodwOcz2xvm8Av+Zobpuo3ZRI8GTgr9SCqX46qceISVV1DxKFqj0FEFPzRLnIgTQat
	YQYQ==
X-Gm-Message-State: ALoCoQlPNi2tMPWTaR5cgkYBNu21Hnb00s5qxNNKOMGLpWvaLkWvWaveA3Xq9l5DmvsLhrzu+Fy+
X-Received: by 10.50.61.241 with SMTP id t17mr6450981igr.28.1379341948789;
	Mon, 16 Sep 2013 07:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.229.169 with HTTP; Mon, 16 Sep 2013 07:32:07 -0700 (PDT)
In-Reply-To: <1379341468.3484.313.camel@ted>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<8a649ee0aa5cd852e54078b3d980b99d37ecad7b.1379338189.git.alexandru.damian@intel.com>
	<1379341468.3484.313.camel@ted>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 15:32:07 +0100
Message-ID: <CAJ2CSBu5EzYkLruQDFDM+TE_ZGiWs3UXGg2QYvitukWpvYQScw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
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
X-List-Received-Date: Mon, 16 Sep 2013 14:32:29 -0000
Content-Type: multipart/alternative; boundary=047d7bdca968e1bbb604e681125f

--047d7bdca968e1bbb604e681125f
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 16, 2013 at 3:24 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >
> > Adding a runQueueTaskSkipped to notify all listeners
> > about the tasks that are not run either because they
> > are set-scened or they don't need an update (timestamps
> > are ok)
> >
> > Adds RunQueueData functions to get the task name and task
> > file for usage with the runQueue* events.
> >
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > ---
> >  bitbake/lib/bb/build.py    |  3 +++
> >  bitbake/lib/bb/runqueue.py | 27 ++++++++++++++++++++++++---
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> > index a53aba9..1265bdc 100644
> > --- a/bitbake/lib/bb/build.py
> > +++ b/bitbake/lib/bb/build.py
> > @@ -72,6 +72,9 @@ class TaskBase(event.Event):
> >      def __init__(self, t, d ):
> >          self._task = t
> >          self._package = d.getVar("PF", True)
> > +        self._file = d.getVar("FILE", True)
> > +        self.taskfile = self._file
> > +        self.taskname = self._task
> >          event.Event.__init__(self)
> >          self._message = "recipe %s: task %s: %s" % (d.getVar("PF",
> True), t, self.getDisplayName())
> >
> > diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> > index aa2f147..2ab4405 100644
> > --- a/bitbake/lib/bb/runqueue.py
> > +++ b/bitbake/lib/bb/runqueue.py
> > @@ -217,6 +217,12 @@ class RunQueueData:
> >              ret.extend([nam])
> >          return ret
> >
> > +    def get_task_name(self, task):
> > +        return self.runq_task[task]
> > +
> > +    def get_task_file(self, task):
> > +        return self.taskData.fn_index[self.runq_fnid[task]]
> > +
> >      def get_user_idstring(self, task, task_name_suffix = ""):
> >          fn = self.taskData.fn_index[self.runq_fnid[task]]
> >          taskname = self.runq_task[task] + task_name_suffix
> > @@ -1328,9 +1334,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
> >          if self.rqdata.taskData.abort:
> >              self.rq.state = runQueueCleanUp
> >
> > -    def task_skip(self, task):
> > +    def task_skip(self, task, skip_reason = ""):
> >          self.runq_running[task] = 1
> >          self.runq_buildable[task] = 1
> > +        bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq,
> skip_reason), self.cfgData)
> >          self.task_completeoutright(task)
> >          self.stats.taskCompleted()
> >          self.stats.taskSkipped()
> > @@ -1355,13 +1362,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
> >              if task in self.rq.scenequeue_covered:
> >                  logger.debug(2, "Setscene covered task %s (%s)", task,
> >                                  self.rqdata.get_user_idstring(task))
> > -                self.task_skip(task)
> > +                self.task_skip(task, "covered")
> >                  return True
> >
> >              if self.rq.check_stamp_task(task, taskname,
> cache=self.stampcache):
> >                  logger.debug(2, "Stamp current task %s (%s)", task,
> >                                  self.rqdata.get_user_idstring(task))
> > -                self.task_skip(task)
> > +                self.task_skip(task, "existing")
> >                  return True
> >
> >              taskdep = self.rqdata.dataCache.task_deps[fn]
> > @@ -1783,6 +1790,8 @@ class runQueueEvent(bb.event.Event):
> >      def __init__(self, task, stats, rq):
> >          self.taskid = task
> >          self.taskstring = rq.rqdata.get_user_idstring(task)
> > +        self.taskname = rq.rqdata.get_task_name(task)
> > +        self.taskfile = rq.rqdata.get_task_file(task)
> >          self.stats = stats.copy()
> >          bb.event.Event.__init__(self)
> >
> > @@ -1794,6 +1803,8 @@ class sceneQueueEvent(runQueueEvent):
> >          runQueueEvent.__init__(self, task, stats, rq)
> >          realtask = rq.rqdata.runq_setscene[task]
> >          self.taskstring = rq.rqdata.get_user_idstring(realtask,
> "_setscene")
> > +        self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
> > +        self.taskfile = rq.rqdata.get_task_file(realtask)
> >
> >  class runQueueTaskStarted(runQueueEvent):
> >      """
> > @@ -1837,6 +1848,16 @@ class sceneQueueTaskCompleted(sceneQueueEvent):
> >      Event notifing a setscene task completed
> >      """
> >
> > +class runQueueTaskSkipped(runQueueEvent):
> > +    """
> > +    Event notifing a task was skipped
> > +    """
> > +    def __init__(self, task, stats, rq, skip_reason):
> > +        runQueueEvent.__init__(self, task, stats, rq)
> > +        self._file = rq.rqdata.get_task_file(task)
> > +        self._task = rq.rqdata.get_task_name(task)
> > +        self._skip = skip_reason
> > +
> >  class runQueuePipe():
> >      """
> >      Abstraction for a pipe between a worker thread and the server
>
>
> Please rebase this one off
>
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?h=master-next&id=39c70d0ad00afa05d343dc19aa557a092db7c963
>
> since we should do one thing in a commit, not three. I renamed _skip ->
> reason since its not internal and its a skip event, we know this, the
> field is the reason.
>
> You need to separate out the runQueueEvent changes from the TaskBase
> changes.
>
> Why add self._file to TaskBase? Surely just taskfile would be enough?
> The _ is meant to indicate internal use only and aren't the above events
> inconsistent with each other?
>

[Alex] This is the idea - I actually tried to make TaskBase-derived events
consistent with runQueueEvents in terms of class fields, so the code that
reads them is easier to follow - I just have to look up for the same named
field regardless of the event type.



>
> Cheers,
>
> Richard
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--047d7bdca968e1bbb604e681125f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Sep 16, 2013 at 3:24 PM, Richard Purdie <span dir=3D"ltr">&=
lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">=
richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On M=
on, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:<br>
&gt; From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.co=
m">alexandru.damian@intel.com</a>&gt;<br>
&gt;<br>
&gt; Adding a runQueueTaskSkipped to notify all listeners<br>
&gt; about the tasks that are not run either because they<br>
&gt; are set-scened or they don&#39;t need an update (timestamps<br>
&gt; are ok)<br>
&gt;<br>
&gt; Adds RunQueueData functions to get the task name and task<br>
&gt; file for usage with the runQueue* events.<br>
&gt;<br>
&gt; Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian=
@intel.com">alexandru.damian@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bitbake/lib/bb/build.py =C2=A0 =C2=A0| =C2=A03 +++<br>
&gt; =C2=A0bitbake/lib/bb/runqueue.py | 27 ++++++++++++++++++++++++---<br>
&gt; =C2=A02 files changed, 27 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py<br>
&gt; index a53aba9..1265bdc 100644<br>
&gt; --- a/bitbake/lib/bb/build.py<br>
&gt; +++ b/bitbake/lib/bb/build.py<br>
&gt; @@ -72,6 +72,9 @@ class TaskBase(event.Event):<br>
&gt; =C2=A0 =C2=A0 =C2=A0def __init__(self, t, d ):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._task =3D t<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._package =3D d.getVar(&quot;PF&=
quot;, True)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self._file =3D d.getVar(&quot;FILE&quot;,=
 True)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskfile =3D self._file<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskname =3D self._task<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.Event.__init__(self)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._message =3D &quot;recipe %s: t=
ask %s: %s&quot; % (d.getVar(&quot;PF&quot;, True), t, self.getDisplayName(=
))<br>
&gt;<br>
&gt; diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py<b=
r>
&gt; index aa2f147..2ab4405 100644<br>
&gt; --- a/bitbake/lib/bb/runqueue.py<br>
&gt; +++ b/bitbake/lib/bb/runqueue.py<br>
&gt; @@ -217,6 +217,12 @@ class RunQueueData:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret.extend([nam])<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0def get_task_name(self, task):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.runq_task[task]<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0def get_task_file(self, task):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.taskData.fn_index[self.runq_f=
nid[task]]<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0def get_user_idstring(self, task, task_name_suffix=
 =3D &quot;&quot;):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fn =3D self.taskData.fn_index[self.r=
unq_fnid[task]]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0taskname =3D self.runq_task[task] + =
task_name_suffix<br>
&gt; @@ -1328,9 +1334,10 @@ class RunQueueExecuteTasks(RunQueueExecute):<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.rqdata.taskData.abort:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.state =3D runQ=
ueueCleanUp<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0def task_skip(self, task):<br>
&gt; + =C2=A0 =C2=A0def task_skip(self, task, skip_reason =3D &quot;&quot;)=
:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.runq_running[task] =3D 1<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.runq_buildable[task] =3D 1<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.fire(runQueueTaskSkipped(task, s=
elf.stats, self.rq, skip_reason), self.cfgData)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_completeoutright(task)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stats.taskCompleted()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stats.taskSkipped()<br>
&gt; @@ -1355,13 +1362,13 @@ class RunQueueExecuteTasks(RunQueueExecute):<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if task in self.rq.sce=
nequeue_covered:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.d=
ebug(2, &quot;Setscene covered task %s (%s)&quot;, task,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rqdata.get_user_idstri=
ng(task))<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_ski=
p(task)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_ski=
p(task, &quot;covered&quot;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return T=
rue<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.rq.check_stamp=
_task(task, taskname, cache=3Dself.stampcache):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.d=
ebug(2, &quot;Stamp current task %s (%s)&quot;, task,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rqdata.get_user_idstri=
ng(task))<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_ski=
p(task)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_ski=
p(task, &quot;existing&quot;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return T=
rue<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0taskdep =3D self.rqdat=
a.dataCache.task_deps[fn]<br>
&gt; @@ -1783,6 +1790,8 @@ class runQueueEvent(bb.event.Event):<br>
&gt; =C2=A0 =C2=A0 =C2=A0def __init__(self, task, stats, rq):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskid =3D task<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskstring =3D rq.rqdata.get_us=
er_idstring(task)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskname =3D rq.rqdata.get_task_name=
(task)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskfile =3D rq.rqdata.get_task_file=
(task)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stats =3D stats.copy()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.event.Event.__init__(self)<br>
&gt;<br>
&gt; @@ -1794,6 +1803,8 @@ class sceneQueueEvent(runQueueEvent):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runQueueEvent.__init__(self, task, s=
tats, rq)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0realtask =3D rq.rqdata.runq_setscene=
[task]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskstring =3D rq.rqdata.get_us=
er_idstring(realtask, &quot;_setscene&quot;)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskname =3D rq.rqdata.get_task_name=
(realtask) + &quot;_setscene&quot;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskfile =3D rq.rqdata.get_task_file=
(realtask)<br>
&gt;<br>
&gt; =C2=A0class runQueueTaskStarted(runQueueEvent):<br>
&gt; =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; @@ -1837,6 +1848,16 @@ class sceneQueueTaskCompleted(sceneQueueEvent):=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0Event notifing a setscene task completed<br>
&gt; =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;<br>
&gt; +class runQueueTaskSkipped(runQueueEvent):<br>
&gt; + =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; + =C2=A0 =C2=A0Event notifing a task was skipped<br>
&gt; + =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; + =C2=A0 =C2=A0def __init__(self, task, stats, rq, skip_reason):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0runQueueEvent.__init__(self, task, stats,=
 rq)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self._file =3D rq.rqdata.get_task_file(ta=
sk)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self._task =3D rq.rqdata.get_task_name(ta=
sk)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0self._skip =3D skip_reason<br>
&gt; +<br>
&gt; =C2=A0class runQueuePipe():<br>
&gt; =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0Abstraction for a pipe between a worker thread and=
 the server<br>
<br>
<br>
</div></div>Please rebase this one off<br>
<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commit/?h=3Dmaster-nex=
t&amp;id=3D39c70d0ad00afa05d343dc19aa557a092db7c963" target=3D"_blank">http=
://git.yoctoproject.org/cgit.cgi/poky/commit/?h=3Dmaster-next&amp;id=3D39c7=
0d0ad00afa05d343dc19aa557a092db7c963</a><br>


<br>
since we should do one thing in a commit, not three. I renamed _skip -&gt;<=
br>
reason since its not internal and its a skip event, we know this, the<br>
field is the reason.<br>
<br>
You need to separate out the runQueueEvent changes from the TaskBase<br>
changes.<br>
<br>
Why add self._file to TaskBase? Surely just taskfile would be enough?<br>
The _ is meant to indicate internal use only and aren&#39;t the above event=
s<br>
inconsistent with each other?<br></blockquote><div><br></div><div>[Alex] Th=
is is the idea - I actually tried to make TaskBase-derived events consisten=
t with runQueueEvents in terms of class fields, so the code that reads them=
 is easier to follow - I just have to look up for the same named field rega=
rdless of the event type.</div>

<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div></div=
>
</div></div>

--047d7bdca968e1bbb604e681125f--
