Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.5039.1631832227746339660
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 15:43:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lORIScXH;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id v19so5610954pjh.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VQ4OLy7zyeKNb4Alcv5ZHQqW6ZkUsDD8+G/nLsXqnM=;
        b=lORIScXHpZiHNsOHoIWhbfRbPpkbgp6EaMA5eZziw6rC1uRskRYh6FrGIZ4A2vikP4
         +FZOhu0dqeonqqw231hL2ha8V7InAj+2XYwYSrMU9z1ZOT+hQe1PZWj7fofHbJeVjzM0
         u/yID7j/d9TvPcflaVXEYzpbw64M1FtlF9HR8kpfUBJ5eJLZuzwwRsRH8+/5JIMoCT6o
         HKvKfMmb9X8tEnxLyMjdk0M6b749Z4sPpCy5S5vPzLcwRuR/dw/Z/XzWhjG0u7InMx6+
         A1gnSb0tkq5rC/8ujGdyQtnj/WA/Fs7Rzzr/uYbUMBo5YW8bRgf+BECiezcMruwVuDIV
         41/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VQ4OLy7zyeKNb4Alcv5ZHQqW6ZkUsDD8+G/nLsXqnM=;
        b=S1+plvygr7Wo1nACbHBzHVdQgcR15nZfyeHAvjuzGyKh4w46HFOwIM3v1zvaFkNShL
         4cqw5uY8IxLU3YD8vDBr8BFWRcREbaSzBzfIx6eJ+8x19Lwhzzt/7NGFKOdsPOGEhdt2
         OtpVGmZ+ExHa7z9UJWL08ztqFyTjptbDU1ZotZf4lB4IgnmxMAO0gpHkl+TJDmnQb4YF
         7Jw3fSjtHM8GgIxn33veUCH78bdNX40cHxhNdkfdk1VeZygYfZICO6jE4gyxgcsKRzU2
         T4P7C9D7XlsH1FuNB4l3zat9XzPHR8rQRbV7Wf+nZZ2LFQ+GGJUeFgR0VvKvIAo2lPOh
         pt4g==
X-Gm-Message-State: AOAM532JfQmGFJwFj74Q81NY0qbrPxK4gw1zCmcjcrqK5ZgQIfJCA4b1
	Rkd4Sl7n7rJbNwg1mEwZCfUFh42O+hhueKpTohh84iefFhw=
X-Google-Smtp-Source: ABdhPJxBndOcVV/TM/U4R/7UIOC1YP0BnnqL5bBATQ8/99uvLBDarvcC3Jy/lO66VL8UHS2Sa3oMpJPo1IMWK3mPit8=
X-Received: by 2002:a17:90a:130f:: with SMTP id h15mr8755382pja.183.1631832227133;
 Thu, 16 Sep 2021 15:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210916121505.1445997-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210916121505.1445997-1-richard.purdie@linuxfoundation.org>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Fri, 17 Sep 2021 00:43:36 +0200
Message-ID: <CA+chaQeNWYZN8eCx0KRafQ0wxv1JLccofv4ZCe9E6L8zz71gyw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue/knotty: Improve UI handling of setscene task counting
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000003b3bae05cc248c08"

--0000000000003b3bae05cc248c08
Content-Type: text/plain; charset="UTF-8"

Thanks, LGTM

Tested-by: Martin Jansa <Martin.Jansa@gmail.com>

On Thu, Sep 16, 2021 at 2:15 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The recent fixes to merge setscene and normal task accounting in runqueue
> fixed some display issues but broke the task numbering of setscene tasks.
>
> Add new accounting methods to the stats structure specifically designed
> for setscene. This accounts for the fact that setscene tasks can rerun
> multiple times in the build.
>
> Then use the new data in the UI to correctly display the numbers the
> user wants to see to understand progress.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/runqueue.py    | 21 ++++++++++++++++++---
>  lib/bb/ui/knotty.py   |  2 +-
>  lib/bb/ui/uihelper.py |  2 +-
>  3 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 6ce0ce80f6..10511a09dc 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -85,15 +85,19 @@ class RunQueueStats:
>      """
>      Holds statistics on the tasks handled by the associated runQueue
>      """
> -    def __init__(self, total):
> +    def __init__(self, total, setscene_total):
>          self.completed = 0
>          self.skipped = 0
>          self.failed = 0
>          self.active = 0
> +        self.setscene_active = 0
> +        self.setscene_covered = 0
> +        self.setscene_notcovered = 0
> +        self.setscene_total = setscene_total
>          self.total = total
>
>      def copy(self):
> -        obj = self.__class__(self.total)
> +        obj = self.__class__(self.total, self.setscene_total)
>          obj.__dict__.update(self.__dict__)
>          return obj
>
> @@ -112,6 +116,13 @@ class RunQueueStats:
>      def taskActive(self):
>          self.active = self.active + 1
>
> +    def updateCovered(self, covered, notcovered):
> +        self.setscene_covered = covered
> +        self.setscene_notcovered = notcovered
> +
> +    def updateActiveSetscene(self, active):
> +        self.setscene_active = active
> +
>  # These values indicate the next step due to be run in the
>  # runQueue state machine
>  runQueuePrepare = 2
> @@ -1735,7 +1746,7 @@ class RunQueueExecute:
>          self.holdoff_need_update = True
>          self.sqdone = False
>
> -        self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
> +        self.stats = RunQueueStats(len(self.rqdata.runtaskentries),
> len(self.rqdata.runq_setscene_tids))
>
>          for mc in rq.worker:
>              rq.worker[mc].pipe.setrunqueueexec(self)
> @@ -1786,6 +1797,7 @@ class RunQueueExecute:
>              else:
>                  self.sq_task_complete(task)
>              self.sq_live.remove(task)
> +            self.stats.updateActiveSetscene(len(self.sq_live))
>          else:
>              if status != 0:
>                  self.task_fail(task, status, fakerootlog=fakerootlog)
> @@ -2087,6 +2099,7 @@ class RunQueueExecute:
>              self.build_stamps2.append(self.build_stamps[task])
>              self.sq_running.add(task)
>              self.sq_live.add(task)
> +            self.stats.updateActiveSetscene(len(self.sq_live))
>              if self.can_start_task():
>                  return True
>
> @@ -2462,6 +2475,7 @@ class RunQueueExecute:
>                  self.sq_task_failoutright(tid)
>
>          if changed:
> +            self.stats.updateCovered(len(self.scenequeue_covered),
> len(self.scenequeue_notcovered))
>              self.holdoff_need_update = True
>
>      def scenequeue_updatecounters(self, task, fail=False):
> @@ -2495,6 +2509,7 @@ class RunQueueExecute:
>                          new.add(dep)
>              next = new
>
> +        self.stats.updateCovered(len(self.scenequeue_covered),
> len(self.scenequeue_notcovered))
>          self.holdoff_need_update = True
>
>      def sq_task_completeoutright(self, task):
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 65ff2727dc..8df745d130 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -753,7 +753,7 @@ def main(server, eventHandler, params, tf =
> TerminalFilter):
>                  continue
>
>              if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
> -                logger.info("Running setscene task %d of %d (%s)" %
> (event.stats.completed + event.stats.active + event.stats.failed + 1,
> event.stats.total, event.taskstring))
> +                logger.info("Running setscene task %d of %d (%s)" %
> (event.stats.setscene_covered + event.stats.setscene_active +
> event.stats.setscene_notcovered + 1, event.stats.setscene_total,
> event.taskstring))
>                  continue
>
>              if isinstance(event, bb.runqueue.runQueueTaskStarted):
> diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
> index 40c7c5a5ef..52fdae3fec 100644
> --- a/lib/bb/ui/uihelper.py
> +++ b/lib/bb/ui/uihelper.py
> @@ -50,7 +50,7 @@ class BBUIHelper:
>              removetid(event.pid, tid)
>              self.failed_tasks.append( { 'title' : "%s %s" %
> (event._package, event._task)})
>          elif isinstance(event, bb.runqueue.runQueueTaskStarted) or
> isinstance(event, bb.runqueue.sceneQueueTaskStarted):
> -            self.tasknumber_current = event.stats.completed +
> event.stats.active + event.stats.failed + 1
> +            self.tasknumber_current = event.stats.completed +
> event.stats.active + event.stats.failed + event.stats.setscene_active + 1
>              self.tasknumber_total = event.stats.total
>              self.needUpdate = True
>          elif isinstance(event, bb.build.TaskProgress):
> --
> 2.32.0
>
>
> 
>
>

--0000000000003b3bae05cc248c08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, LGTM<div><br></div><div>Tested-by:=C2=A0Martin Jan=
sa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com">Martin.Jansa@gmail.com</a>=
&gt;</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Thu, Sep 16, 2021 at 2:15 PM Richard Purdie &lt;<a href=3D"mai=
lto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he recent fixes to merge setscene and normal task accounting in runqueue<br=
>
fixed some display issues but broke the task numbering of setscene tasks.<b=
r>
<br>
Add new accounting methods to the stats structure specifically designed<br>
for setscene. This accounts for the fact that setscene tasks can rerun<br>
multiple times in the build.<br>
<br>
Then use the new data in the UI to correctly display the numbers the<br>
user wants to see to understand progress.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/runqueue.py=C2=A0 =C2=A0 | 21 ++++++++++++++++++---<br>
=C2=A0lib/bb/ui/knotty.py=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0lib/bb/ui/uihelper.py |=C2=A0 2 +-<br>
=C2=A03 files changed, 20 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index 6ce0ce80f6..10511a09dc 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -85,15 +85,19 @@ class RunQueueStats:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0Holds statistics on the tasks handled by the associated=
 runQueue<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 def __init__(self, total):<br>
+=C2=A0 =C2=A0 def __init__(self, total, setscene_total):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.completed =3D 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.skipped =3D 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.failed =3D 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.active =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setscene_active =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setscene_covered =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setscene_notcovered =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setscene_total =3D setscene_total<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.total =3D total<br>
<br>
=C2=A0 =C2=A0 =C2=A0def copy(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D self.__class__(self.total)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D self.__class__(self.total, self.setsce=
ne_total)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0obj.__dict__.update(self.__dict__)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return obj<br>
<br>
@@ -112,6 +116,13 @@ class RunQueueStats:<br>
=C2=A0 =C2=A0 =C2=A0def taskActive(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.active =3D self.active + 1<br>
<br>
+=C2=A0 =C2=A0 def updateCovered(self, covered, notcovered):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setscene_covered =3D covered<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setscene_notcovered =3D notcovered<br>
+<br>
+=C2=A0 =C2=A0 def updateActiveSetscene(self, active):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setscene_active =3D active<br>
+<br>
=C2=A0# These values indicate the next step due to be run in the<br>
=C2=A0# runQueue state machine<br>
=C2=A0runQueuePrepare =3D 2<br>
@@ -1735,7 +1746,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.holdoff_need_update =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sqdone =3D False<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stats =3D RunQueueStats(len(self.rqdata.r=
untaskentries))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stats =3D RunQueueStats(len(self.rqdata.r=
untaskentries), len(self.rqdata.runq_setscene_tids))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in rq.worker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq.worker[mc].pipe.setrunqu=
eueexec(self)<br>
@@ -1786,6 +1797,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sq_task_=
complete(task)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sq_live.remove(task)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stats.updateActiveSetscene(=
len(self.sq_live))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status !=3D 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_fai=
l(task, status, fakerootlog=3Dfakerootlog)<br>
@@ -2087,6 +2099,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.build_stamps2.append(s=
elf.build_stamps[task])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sq_running.add(task)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sq_live.add(task)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stats.updateActiveSetscene(=
len(self.sq_live))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.can_start_task():<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<b=
r>
<br>
@@ -2462,6 +2475,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sq_task_=
failoutright(tid)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if changed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stats.updateCovered(len(sel=
f.scenequeue_covered), len(self.scenequeue_notcovered))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.holdoff_need_update =
=3D True<br>
<br>
=C2=A0 =C2=A0 =C2=A0def scenequeue_updatecounters(self, task, fail=3DFalse)=
:<br>
@@ -2495,6 +2509,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0new.add(dep)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next =3D new<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stats.updateCovered(len(self.scenequeue_c=
overed), len(self.scenequeue_notcovered))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.holdoff_need_update =3D True<br>
<br>
=C2=A0 =C2=A0 =C2=A0def sq_task_completeoutright(self, task):<br>
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py<br>
index 65ff2727dc..8df745d130 100644<br>
--- a/lib/bb/ui/knotty.py<br>
+++ b/lib/bb/ui/knotty.py<br>
@@ -753,7 +753,7 @@ def main(server, eventHandler, params, tf =3D TerminalF=
ilter):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(event, bb.run=
queue.sceneQueueTaskStarted):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://=
logger.info" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;Run=
ning setscene task %d of %d (%s)&quot; % (event.stats.completed + event.sta=
ts.active + event.stats.failed + 1, event.stats.total, event.taskstring))<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://=
logger.info" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;Run=
ning setscene task %d of %d (%s)&quot; % (event.stats.setscene_covered + ev=
ent.stats.setscene_active + event.stats.setscene_notcovered + 1, event.stat=
s.setscene_total, event.taskstring))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(event, bb.run=
queue.runQueueTaskStarted):<br>
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py<br>
index 40c7c5a5ef..52fdae3fec 100644<br>
--- a/lib/bb/ui/uihelper.py<br>
+++ b/lib/bb/ui/uihelper.py<br>
@@ -50,7 +50,7 @@ class BBUIHelper:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0removetid(event.pid, tid)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.failed_tasks.append( {=
 &#39;title&#39; : &quot;%s %s&quot; % (event._package, event._task)})<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif isinstance(event, bb.runqueue.runQue=
ueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.tasknumber_current =3D even=
t.stats.completed + event.stats.active + event.stats.failed + 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.tasknumber_current =3D even=
t.stats.completed + event.stats.active + event.stats.failed + event.stats.s=
etscene_active + 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.tasknumber_total =3D e=
vent.stats.total<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.needUpdate =3D True<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif isinstance(event, bb.build.TaskProgr=
ess):<br>
-- <br>
2.32.0<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000003b3bae05cc248c08--
