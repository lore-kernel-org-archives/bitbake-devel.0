Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web09.37996.1614012038434438378
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Feb 2021 08:40:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=b08ekaNS;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id p2so22792783edm.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Feb 2021 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgdUr7aMHvzUpQEQhyTvXz5ybV4h1NJoT/UAseohrD8=;
        b=b08ekaNSO+glYToTjZ13j+1niFa94d27+mqBTEqAD5oGcXQw1JwBD67mRhiO2RsYwz
         FpLI8ZXl5CZD4jCbXnevcmnIx2dZl2bduZLtuOWl4loJIATV4/eTGI6qib39zUk7+z5Y
         3yZ2CelyGtNSqFd1hOtpj4FlXc9oZOAPaBbJk4Or4DM6kYbE3h/6qzfPzcBElxT1cZUd
         ZeEgkCF4O8WDmFPS+Q+8k0lTTL4aV2Vl5DOToW1SNHQL4/i8/Ae6hS2fwx272OqCJqER
         gZwfUdmaFV5JvTOKPNjFRX9J169c39gVtk13VMdCCk5sRChCFiRx9ugc61iX5lNvPYL4
         gZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgdUr7aMHvzUpQEQhyTvXz5ybV4h1NJoT/UAseohrD8=;
        b=n/Xrn1S2p0INYE509bECnx2QURgO3SlDA+dVYFXBgWPskXM6aJBhAVn6AB7rlz+AgQ
         lLTiEX11OcbWHtxAz5dvjgGwjAjuqSo899yAqynPcnwMDEf6oFILOIG/FjzUZxkL/ejD
         8XZYpQplHuKM1cVGuk49Xc46g4CN+th7jg/MXB069yeF9AnccH5Bd2KxBnFHMiPrbax3
         ALzS464rrqxxo/s983c7Zupxtp/DXpKRpMAuxwUxLvRONEyR5CPiJt5R/FK9VE9J4zuV
         l0TS8Vlaw0a9BLZsyusSbtR65evK23h1RkDi6ETM5ZBRVKYtzAqdXu6DYmJSJ9SxBvvv
         f1qA==
X-Gm-Message-State: AOAM532gSNBqGQMb6ZEdfnzEBKKulYe7bniO8BNFjPPTUNtNWklu3EaN
	3uOYtgZOEKaowMNIVnKlBj+hhOffKuplovcqFU0=
X-Google-Smtp-Source: ABdhPJwUooO2o97ZfaoKkJycD4To6hcTSRyWhNNZ94v6aRHKgMO3JvfQv5xlW3PC9wlH76jn+/vwDwku7S/wiGLhEx0=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr23797378edv.268.1614012037049;
 Mon, 22 Feb 2021 08:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20210222112400.1961-1-tomasz.dziendzielski@gmail.com> <CABcZANk4CBmtfxHdRAKsrbgHfJ8krWWvuKP2MnPnyHu8+j6VTQ@mail.gmail.com>
In-Reply-To: <CABcZANk4CBmtfxHdRAKsrbgHfJ8krWWvuKP2MnPnyHu8+j6VTQ@mail.gmail.com>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Mon, 22 Feb 2021 09:40:26 -0700
Message-ID: <CABcZANnThm0WvX3pFRT+o=G6kAzgftaEGB0kW7ovVqcJk5pV7g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] runqueue: Print pseudo.log if fakeroot task failed
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Jan Brzezanski <jan.brzezanski@gmail.com>, Paulo Neves <ptsneves@gmail.com>, 
	Mikolaj Lasota <mikolaj.lasota@protonmail.com>, Wiktor Baura <wbaura@gmail.com>, 
	Kamil Kwiek <kamil.kwiek@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000021af0305bbef760a"

--00000000000021af0305bbef760a
Content-Type: text/plain; charset="UTF-8"

I'd suggest making this more generic via a new variable specifying a
fakeroot cmd logfile, or something along those lines.

On Mon, Feb 22, 2021 at 9:39 AM Christopher Larson <kergoth@gmail.com>
wrote:

> I can see the usability value here, but this violates a bitbake/oe-core
> boundary. bitbake doesn't hardcode knowledge of use of pseudo anywhere else
> but tests and bitbake.conf example currently, the fakeroot cmd used is
> defined in the *metadata*, not bitbake itself.
>
> On Mon, Feb 22, 2021 at 4:21 AM Tomasz Dziendzielski <
> tomasz.dziendzielski@gmail.com> wrote:
>
>> Currently if pseudo fails we can only see the path to pseudo.log. If we
>> have no access to server and can only rely on bitbake log then debugging
>> becomes impossible. This printing needs to be added in runqueue level,
>> not inside task execution, because in some cases task fails with pseudo
>> abort really early and we don't even see any log.
>>
>> In this change I'm adding pseudo log printing in every fakeroot task
>> failure that logged `mismatch`, `error` or `fatal` to logfile, because
>> we have no other way to communicate with pseudo if it failed or not.
>> Only lines from last pseudo server execution will be printed.
>>
>> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
>> Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
>> Signed-off-by: Adrian Walag
>> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>> Signed-off-by: Mikolaj Lasota <mikolaj.lasota@protonmail.com>
>> Signed-off-by: Wiktor Baura <wbaura@gmail.com>
>> Signed-off-by: Kamil Kwiek <kamil.kwiek@gmail.com>
>>
>> --- v2 Pass taskfn in all start_fakeworker execution
>> ---
>>  lib/bb/runqueue.py | 54 ++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 40 insertions(+), 14 deletions(-)
>>
>> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>> index 54ef245a..aa06d706 100644
>> --- a/lib/bb/runqueue.py
>> +++ b/lib/bb/runqueue.py
>> @@ -1237,11 +1237,12 @@ class RunQueue:
>>          self.worker = {}
>>          self.fakeworker = {}
>>
>> -    def _start_worker(self, mc, fakeroot = False, rqexec = None):
>> +    def _start_worker(self, mc, fakeroot = False, rqexec = None,
>> taskfn=None):
>>          logger.debug("Starting bitbake-worker")
>>          magic = "decafbad"
>>          if self.cooker.configuration.profile:
>>              magic = "decafbadbad"
>> +        fakerootdir = None
>>          if fakeroot:
>>              magic = magic + "beef"
>>              mcdata = self.cooker.databuilder.mcdata[mc]
>> @@ -1251,10 +1252,12 @@ class RunQueue:
>>              for key, value in (var.split('=') for var in fakerootenv):
>>                  env[key] = value
>>              worker = subprocess.Popen(fakerootcmd + ["bitbake-worker",
>> magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
>> +            if taskfn and taskfn in
>> self.rqdata.dataCaches[mc].fakerootdirs:
>> +                fakerootdir =
>> self.rqdata.dataCaches[mc].fakerootdirs[taskfn]
>>          else:
>>              worker = subprocess.Popen(["bitbake-worker", magic],
>> stdout=subprocess.PIPE, stdin=subprocess.PIPE)
>>          bb.utils.nonblockingfd(worker.stdout)
>> -        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData,
>> self, rqexec)
>> +        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData,
>> self, rqexec, fakerootdir=fakerootdir)
>>
>>          workerdata = {
>>              "taskdeps" : self.rqdata.dataCaches[mc].task_deps,
>> @@ -1305,9 +1308,9 @@ class RunQueue:
>>          for mc in self.rqdata.dataCaches:
>>              self.worker[mc] = self._start_worker(mc)
>>
>> -    def start_fakeworker(self, rqexec, mc):
>> +    def start_fakeworker(self, rqexec, mc, taskfn=None):
>>          if not mc in self.fakeworker:
>> -            self.fakeworker[mc] = self._start_worker(mc, True, rqexec)
>> +            self.fakeworker[mc] = self._start_worker(mc, True, rqexec,
>> taskfn=taskfn)
>>
>>      def teardown_workers(self):
>>          self.teardown = True
>> @@ -1772,7 +1775,7 @@ class RunQueueExecute:
>>          self.sqdata = SQData()
>>          build_scenequeue_data(self.sqdata, self.rqdata, self.rq,
>> self.cooker, self.stampcache, self)
>>
>> -    def runqueue_process_waitpid(self, task, status):
>> +    def runqueue_process_waitpid(self, task, status, fakerootdir=None):
>>
>>          # self.build_stamps[pid] may not exist when use shared work
>> directory.
>>          if task in self.build_stamps:
>> @@ -1787,7 +1790,7 @@ class RunQueueExecute:
>>              self.sq_live.remove(task)
>>          else:
>>              if status != 0:
>> -                self.task_fail(task, status)
>> +                self.task_fail(task, status, fakerootdir=fakerootdir)
>>              else:
>>                  self.task_complete(task)
>>          return True
>> @@ -1908,14 +1911,32 @@ class RunQueueExecute:
>>          self.task_completeoutright(task)
>>          self.runq_tasksrun.add(task)
>>
>> -    def task_fail(self, task, exitcode):
>> +    def task_fail(self, task, exitcode, fakerootdir=None):
>>          """
>>          Called when a task has failed
>>          Updates the state engine with the failure
>>          """
>>          self.stats.taskFailed()
>>          self.failed_tids.append(task)
>> -        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode,
>> self.rq), self.cfgData)
>> +
>> +        pseudo_log = ""
>> +        if fakerootdir and os.path.exists(os.path.join(fakerootdir,
>> "pseudo.log")):
>> +            with open(os.path.join(fakerootdir, "pseudo.log")) as
>> pseudo_log_file:
>> +
>> +                pseudo_failed = False
>> +                for line in reversed(pseudo_log_file.readlines()):
>> +                    for pseudo_error in ['mismatch', 'error', 'fatal']:
>> +                        if pseudo_error in line.lower():
>> +                            pseudo_failed = True
>> +                    if 'doing new pid setup and server start' in line:
>> +                        break
>> +                    pseudo_log = line + pseudo_log
>> +
>> +            if not pseudo_failed:
>> +                pseudo_log = None
>> +
>> +        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode,
>> self.rq, pseudo_log=pseudo_log), self.cfgData)
>> +
>>          if self.rqdata.taskData[''].abort:
>>              self.rq.state = runQueueCleanUp
>>
>> @@ -2050,7 +2071,7 @@ class RunQueueExecute:
>>              unihash = self.rqdata.get_task_unihash(task)
>>              if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']
>> and not self.cooker.configuration.dry_run:
>>                  if not mc in self.rq.fakeworker:
>> -                    self.rq.start_fakeworker(self, mc)
>> +                    self.rq.start_fakeworker(self, mc, taskfn=taskfn)
>>                  self.rq.fakeworker[mc].process.stdin.write(b"<runtask>"
>> + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True,
>> self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False))
>> + b"</runtask>")
>>                  self.rq.fakeworker[mc].process.stdin.flush()
>>              else:
>> @@ -2132,7 +2153,7 @@ class RunQueueExecute:
>>              if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']
>> and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
>>                  if not mc in self.rq.fakeworker:
>>                      try:
>> -                        self.rq.start_fakeworker(self, mc)
>> +                        self.rq.start_fakeworker(self, mc, taskfn=taskfn)
>>                      except OSError as exc:
>>                          logger.critical("Failed to spawn fakeroot worker
>> to run %s: %s" % (task, str(exc)))
>>                          self.rq.state = runQueueFailed
>> @@ -2876,12 +2897,16 @@ class runQueueTaskFailed(runQueueEvent):
>>      """
>>      Event notifying a task failed
>>      """
>> -    def __init__(self, task, stats, exitcode, rq):
>> +    def __init__(self, task, stats, exitcode, rq, pseudo_log=None):
>>          runQueueEvent.__init__(self, task, stats, rq)
>>          self.exitcode = exitcode
>> +        self.pseudo_log = pseudo_log
>>
>>      def __str__(self):
>> -        return "Task (%s) failed with exit code '%s'" %
>> (self.taskstring, self.exitcode)
>> +        if self.pseudo_log:
>> +            return "Task (%s) failed with exit code '%s' \nPseudo
>> log:\n%s" % (self.taskstring, self.exitcode, self.pseudo_log)
>> +        else:
>> +            return "Task (%s) failed with exit code '%s'" %
>> (self.taskstring, self.exitcode)
>>
>>  class sceneQueueTaskFailed(sceneQueueEvent):
>>      """
>> @@ -2933,7 +2958,7 @@ class runQueuePipe():
>>      """
>>      Abstraction for a pipe between a worker thread and the server
>>      """
>> -    def __init__(self, pipein, pipeout, d, rq, rqexec):
>> +    def __init__(self, pipein, pipeout, d, rq, rqexec, fakerootdir=None):
>>          self.input = pipein
>>          if pipeout:
>>              pipeout.close()
>> @@ -2942,6 +2967,7 @@ class runQueuePipe():
>>          self.d = d
>>          self.rq = rq
>>          self.rqexec = rqexec
>> +        self.fakerootdir = fakerootdir
>>
>>      def setrunqueueexec(self, rqexec):
>>          self.rqexec = rqexec
>> @@ -2987,7 +3013,7 @@ class runQueuePipe():
>>                      task, status = pickle.loads(self.queue[10:index])
>>                  except (ValueError, pickle.UnpicklingError,
>> AttributeError, IndexError) as e:
>>                      bb.msg.fatal("RunQueue", "failed load pickle '%s':
>> '%s'" % (e, self.queue[10:index]))
>> -                self.rqexec.runqueue_process_waitpid(task, status)
>> +                self.rqexec.runqueue_process_waitpid(task, status,
>> fakerootdir=self.fakerootdir)
>>                  found = True
>>                  self.queue = self.queue[index+11:]
>>                  index = self.queue.find(b"</exitcode>")
>> --
>> 2.30.1
>>
>>
>> 
>>
>>
>
> --
> Christopher Larson
> kergoth at gmail dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Senior Software Engineer, Mentor Graphics
>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--00000000000021af0305bbef760a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;d suggest making this more generic via a new variabl=
e specifying a fakeroot cmd logfile, or something along those lines.</div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Feb 22, 2021 at 9:39 AM Christopher Larson &lt;<a href=3D"mailto:kergoth@g=
mail.com">kergoth@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">I can see the usability value h=
ere, but this violates a bitbake/oe-core boundary. bitbake doesn&#39;t hard=
code knowledge of use of pseudo anywhere else but tests and bitbake.conf ex=
ample currently, the fakeroot cmd used is defined in the *metadata*, not bi=
tbake itself.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Feb 22, 2021 at 4:21 AM Tomasz Dziendzielski &lt;<a hr=
ef=3D"mailto:tomasz.dziendzielski@gmail.com" target=3D"_blank">tomasz.dzien=
dzielski@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Currently if pseudo fails we can only see the path to pse=
udo.log. If we<br>
have no access to server and can only rely on bitbake log then debugging<b=
r>
becomes impossible. This printing needs to be added in runqueue level,<br>
not inside task execution, because in some cases task fails with pseudo<br=
>
abort really early and we don&#39;t even see any log.<br>
<br>
In this change I&#39;m adding pseudo log printing in every fakeroot task<b=
r>
failure that logged `mismatch`, `error` or `fatal` to logfile, because<br>
we have no other way to communicate with pseudo if it failed or not.<br>
Only lines from last pseudo server execution will be printed.<br>
<br>
Signed-off-by: Tomasz Dziendzielski &lt;<a href=3D"mailto:tomasz.dziendzie=
lski@gmail.com" target=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt;<br=
>
Signed-off-by: Jan Brzezanski &lt;<a href=3D"mailto:jan.brzezanski@gmail.c=
om" target=3D"_blank">jan.brzezanski@gmail.com</a>&gt;<br>
Signed-off-by: Adrian Walag<br>
Signed-off-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" targe=
t=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
Signed-off-by: Mikolaj Lasota &lt;<a href=3D"mailto:mikolaj.lasota@protonm=
ail.com" target=3D"_blank">mikolaj.lasota@protonmail.com</a>&gt;<br>
Signed-off-by: Wiktor Baura &lt;<a href=3D"mailto:wbaura@gmail.com" target=
=
=3D"_blank">wbaura@gmail.com</a>&gt;<br>
Signed-off-by: Kamil Kwiek &lt;<a href=3D"mailto:kamil.kwiek@gmail.com" ta=
rget=3D"_blank">kamil.kwiek@gmail.com</a>&gt;<br>
<br>
--- v2 Pass taskfn in all start_fakeworker execution<br>
---<br>
=C2=A0lib/bb/runqueue.py | 54 ++++++++++++++++++++++++++++++++++----------=
--<br>
=C2=A01 file changed, 40 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py<br>
index 54ef245a..aa06d706 100644<br>
--- a/lib/bb/runqueue.py<br>
+++ b/lib/bb/runqueue.py<br>
@@ -1237,11 +1237,12 @@ class RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.worker =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fakeworker =3D {}<br>
<br>
-=C2=A0 =C2=A0 def _start_worker(self, mc, fakeroot =3D False, rqexec =3D =
None):<br>
+=C2=A0 =C2=A0 def _start_worker(self, mc, fakeroot =3D False, rqexec =3D =
None, taskfn=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(&quot;Starting bitbake-work=
er&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0magic =3D &quot;decafbad&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.cooker.configuration.profile:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0magic =3D &quot;decafbadba=
d&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fakerootdir =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fakeroot:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0magic =3D magic + &quot;be=
ef&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mcdata =3D self.cooker.dat=
abuilder.mcdata[mc]<br>
@@ -1251,10 +1252,12 @@ class RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for key, value in (var.spl=
it(&#39;=3D&#39;) for var in fakerootenv):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env[key] =3D=
 value<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker =3D subprocess.Pope=
n(fakerootcmd + [&quot;bitbake-worker&quot;, magic], stdout=3Dsubprocess.PI=
PE, stdin=3Dsubprocess.PIPE, env=3Denv)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if taskfn and taskfn in self.rq=
data.dataCaches[mc].fakerootdirs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fakerootdir =3D s=
elf.rqdata.dataCaches[mc].fakerootdirs[taskfn]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker =3D subprocess.Pope=
n([&quot;bitbake-worker&quot;, magic], stdout=3Dsubprocess.PIPE, stdin=3Dsu=
bprocess.PIPE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.nonblockingfd(worker.stdout)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 workerpipe =3D runQueuePipe(worker.stdout, No=
ne, self.cfgData, self, rqexec)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 workerpipe =3D runQueuePipe(worker.stdout, No=
ne, self.cfgData, self, rqexec, fakerootdir=3Dfakerootdir)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workerdata =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;taskdeps&quot; : sel=
f.rqdata.dataCaches[mc].task_deps,<br>
@@ -1305,9 +1308,9 @@ class RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in self.rqdata.dataCaches:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.worker[mc] =3D self._=
start_worker(mc)<br>
<br>
-=C2=A0 =C2=A0 def start_fakeworker(self, rqexec, mc):<br>
+=C2=A0 =C2=A0 def start_fakeworker(self, rqexec, mc, taskfn=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not mc in self.fakeworker:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fakeworker[mc] =3D self._s=
tart_worker(mc, True, rqexec)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fakeworker[mc] =3D self._s=
tart_worker(mc, True, rqexec, taskfn=3Dtaskfn)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def teardown_workers(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.teardown =3D True<br>
@@ -1772,7 +1775,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sqdata =3D SQData()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_scenequeue_data(self.sqdata, self.=
rqdata, self.rq, self.cooker, self.stampcache, self)<br>
<br>
-=C2=A0 =C2=A0 def runqueue_process_waitpid(self, task, status):<br>
+=C2=A0 =C2=A0 def runqueue_process_waitpid(self, task, status, fakerootdi=
r=3DNone):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# self.build_stamps[pid] may not exist w=
hen use shared work directory.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if task in self.build_stamps:<br>
@@ -1787,7 +1790,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sq_live.remove(task)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status !=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.task_fail(ta=
sk, status)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.task_fail(ta=
sk, status, fakerootdir=3Dfakerootdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_co=
mplete(task)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
@@ -1908,14 +1911,32 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.task_completeoutright(task)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.runq_tasksrun.add(task)<br>
<br>
-=C2=A0 =C2=A0 def task_fail(self, task, exitcode):<br>
+=C2=A0 =C2=A0 def task_fail(self, task, exitcode, fakerootdir=3DNone):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Called when a task has failed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Updates the state engine with the failur=
e<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stats.taskFailed()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.failed_tids.append(task)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.event.fire(runQueueTaskFailed(task, self.s=
tats, exitcode, self.rq), self.cfgData)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pseudo_log =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if fakerootdir and os.path.exists(os.path.joi=
n(fakerootdir, &quot;pseudo.log&quot;)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(fakeroot=
dir, &quot;pseudo.log&quot;)) as pseudo_log_file:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pseudo_failed =3D=
 False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in rever=
sed(pseudo_log_file.readlines()):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for=
 pseudo_error in [&#39;mismatch&#39;, &#39;error&#39;, &#39;fatal&#39;]:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 =C2=A0 if pseudo_error in line.lower():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 =C2=A0 =C2=A0 =C2=A0 pseudo_failed =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
&#39;doing new pid setup and server start&#39; in line:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pse=
udo_log =3D line + pseudo_log<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not pseudo_failed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pseudo_log =3D No=
ne<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.event.fire(runQueueTaskFailed(task, self.s=
tats, exitcode, self.rq, pseudo_log=3Dpseudo_log), self.cfgData)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.rqdata.taskData[&#39;&#39;].abor=
t:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.state =3D runQueue=
CleanUp<br>
<br>
@@ -2050,7 +2071,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unihash =3D self.rqdata.ge=
t_task_unihash(task)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;fakeroot&#39; in t=
askdep and taskname in taskdep[&#39;fakeroot&#39;] and not self.cooker.conf=
iguration.dry_run:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not mc in=
 self.rq.fakeworker:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel=
f.rq.start_fakeworker(self, mc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel=
f.rq.start_fakeworker(self, mc, taskfn=3Dtaskfn)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.fake=
worker[mc].process.stdin.write(b&quot;&lt;runtask&gt;&quot; + pickle.dumps(=
(taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[m=
c].get_file_appends(taskfn), taskdepdata, False)) + b&quot;&lt;/runtask&gt;=
&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq.fake=
worker[mc].process.stdin.flush()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
@@ -2132,7 +2153,7 @@ class RunQueueExecute:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;fakeroot&#39; in t=
askdep and taskname in taskdep[&#39;fakeroot&#39;] and not (self.cooker.con=
figuration.dry_run or self.rqdata.setscene_enforce):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not mc in=
 self.rq.fakeworker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 =C2=A0 self.rq.start_fakeworker(self, mc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 =C2=A0 self.rq.start_fakeworker(self, mc, taskfn=3Dtaskfn)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0except OSError as exc:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0logger.critical(&quot;Failed to spawn fakeroot worker to =
run %s: %s&quot; % (task, str(exc)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0self.rq.state =3D runQueueFailed<br>
@@ -2876,12 +2897,16 @@ class runQueueTaskFailed(runQueueEvent):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0Event notifying a task failed<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 def __init__(self, task, stats, exitcode, rq):<br>
+=C2=A0 =C2=A0 def __init__(self, task, stats, exitcode, rq, pseudo_log=3D=
None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runQueueEvent.__init__(self, task, stats=
, rq)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.exitcode =3D exitcode<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pseudo_log =3D pseudo_log<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __str__(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;Task (%s) failed with exit code =
&#39;%s&#39;&quot; % (self.taskstring, self.exitcode)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.pseudo_log:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;Task (%s) failed w=
ith exit code &#39;%s&#39; \nPseudo log:\n%s&quot; % (self.taskstring, self=
.exitcode, self.pseudo_log)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;Task (%s) failed w=
ith exit code &#39;%s&#39;&quot; % (self.taskstring, self.exitcode)<br>
<br>
=C2=A0class sceneQueueTaskFailed(sceneQueueEvent):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -2933,7 +2958,7 @@ class runQueuePipe():<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0Abstraction for a pipe between a worker thread and the=
 server<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 def __init__(self, pipein, pipeout, d, rq, rqexec):<br>
+=C2=A0 =C2=A0 def __init__(self, pipein, pipeout, d, rq, rqexec, fakeroot=
dir=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.input =3D pipein<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if pipeout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipeout.close()<br>
@@ -2942,6 +2967,7 @@ class runQueuePipe():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d =3D d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rq =3D rq<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rqexec =3D rqexec<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fakerootdir =3D fakerootdir<br>
<br>
=C2=A0 =C2=A0 =C2=A0def setrunqueueexec(self, rqexec):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.rqexec =3D rqexec<br>
@@ -2987,7 +3013,7 @@ class runQueuePipe():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0task, status =3D pickle.loads(self.queue[10:index])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (Valu=
eError, pickle.UnpicklingError, AttributeError, IndexError) as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bb.msg.fatal(&quot;RunQueue&quot;, &quot;failed load pickle &#39;%s&#39=
;: &#39;%s&#39;&quot; % (e, self.queue[10:index]))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rqexec.runqu=
eue_process_waitpid(task, status)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.rqexec.runqu=
eue_process_waitpid(task, status, fakerootdir=3Dself.fakerootdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D Tr=
ue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.queue =
=3D self.queue[index+11:]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D se=
lf.queue.find(b&quot;&lt;/exitcode&gt;&quot;)<br>
-- <br>
2.30.1<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
"><div dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at g=
mail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Softw=
are Engineer, Mentor Graphics</div></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christop=
her Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, =
OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></=
div>

--00000000000021af0305bbef760a--
