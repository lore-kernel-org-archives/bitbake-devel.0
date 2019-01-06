Return-Path: <jpewhacker@gmail.com>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail.openembedded.org (Postfix) with ESMTP id C14C86BC01;
	Sun,  6 Jan 2019 03:09:51 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id p6so4500319wmc.1;
	Sat, 05 Jan 2019 19:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=m8+FnwsPRWLojVwQIJivwtSWxbwA0Intp06rWDBR8cg=;
	b=uFB9CR2TG+256PgcSCLCjlKDKtUsaBdHlrkEUepmBnG14Cgn9tVrEj3RqI/YGyAYb8
	41vyIQGAhQgeZohXtpEvqBm172QRYGBfBWDe7JVYWlm4pCY3U7zxfUs8N7B5Qm8A6syE
	sNgMvqQAyKUIrFrwmbBK8LofwvAw36D+P5t7w8F9QhDTz7IBD7lhxRdVnEUmzGAETow4
	H9x+4DTgNAgifpY7ncuGBZIja7nDnStHmy9h8Qq2HHBgFmk+Y4tSW6wTU4/Bgm5X9nLh
	/Z70OxRHNKYp8NfCtvs0vsWJxZNpMrClaH+YfT2taYUEwrrmn3AOZwW/OsZSNMWdPCr1
	R9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=m8+FnwsPRWLojVwQIJivwtSWxbwA0Intp06rWDBR8cg=;
	b=uJCmvJ4Idea/0H4hzvhO7xOWD/d71+kXaNFbdSH0DV8WRu0hqr4sSQLMAR6Z/0MHDa
	RL4KiZostHfEHutJUtw8h8clprR2CgGy6q+sIOpGzJbgUKEVyFQJlOiBeEaP+9eJYuYG
	qIQSCGnylUcLkroXT86krTcaAkRTqG1pb961BQGwkskGyvLZxiK+sAsT7odsxRYB97W3
	+0/2QclgfhZgShRzgcT+hzydOaJ4fXfdQ9DaHEf58/qyaA39Wj6fjCDbcnsbjOVq4PfY
	ICBxjq0NLF+O7vXE2QfXonIfwfwHtaldayuzm0cgUDiOIkJ2h1UxjAsUYxFdoSb1dTMC
	76eA==
X-Gm-Message-State: AJcUukdHhtQuiDeb9nwUDYG8TX2DTPqVJ4Ur2UfAWN8nMOFB8MsXxLHD
	1rKG8QhD3EtcXVUMtQODuzSjwAszLffYF+ocLQw=
X-Google-Smtp-Source: ALg8bN5YJMJuvXXolwAOckHsaeXZ/l8gKFaXvAD4AQ6+TnveLVeLGW5GH08n8f/oKUqZz1CKM6bGasVodyjD3xNpFdU=
X-Received: by 2002:a1c:8095:: with SMTP id b143mr4974884wmd.63.1546744192238; 
	Sat, 05 Jan 2019 19:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
	<20181219031033.28045-4-JPEWhacker@gmail.com>
	<d41b6e89-8450-58c9-13fb-6437332f3f20@xilinx.com>
In-Reply-To: <d41b6e89-8450-58c9-13fb-6437332f3f20@xilinx.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sat, 5 Jan 2019 21:09:40 -0600
Message-ID: <CAJdd5Gbik0fCVCoWYzwYF7ND6G35ADeX0UdAk1_2X7k2TcnPQw@mail.gmail.com>
To: Alejandro Hernandez <alejandro.enedino.hernandez-samaniego@xilinx.com>
Cc: bitbake-devel@lists.openembedded.org,
	OE-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH v5 3/8] bitbake: runqueue: Track task unique hash
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
X-List-Received-Date: Sun, 06 Jan 2019 03:09:52 -0000
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 5, 2019 at 1:50 AM Alejandro Hernandez
<alejandro.enedino.hernandez-samaniego@xilinx.com> wrote:
>
> Hey Joshua,
>
> This is breaking multiconfig builds with the following error (trimmed),
> I believe it is not taking into account that the Key could contain
> "mc:..." if it is a multiconfig build.

Hmm, yes that seems likely. I'll take a look, would you mind opening a
bug in Bugzilla and assigning it to me? I'm not very familiar with
multiconfig, so some instructions to help reproduce would be very
helpful.

Does anyone know if mutliconfig is tested on the autobuilders?

>
>
> ERROR: Running idle function
>   File "poky/bitbake/lib/bb/runqueue.py", line 1170, in
> RunQueueData.prepare_task_hash(tid='multiconfig:x86:poky/meta/recipes-support/attr/acl_2.2.52.bb:do_fetch'):
>               self.runtaskentries[tid].hash =
> bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
>      >        self.runtaskentries[tid].unihash =
> bb.parse.siggen.get_unihash(fn + "." + taskname)
>
>    File "poky/bitbake/lib/bb/siggen.py", line 45, in
> SignatureGeneratorOEBasicHash.get_unihash(task='poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'):
>           def get_unihash(self, task):
>      >        return self.taskhash[task]
>
> KeyError: 'poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'
>
>
> Cheers,
>
> Alejandro
>
>
> On 12/18/2018 7:10 PM, Joshua Watt wrote:
> > Requests the task unique hash from siggen and tracks it
> >
> > [YOCTO #13030]
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >   bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
> >   1 file changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> > index f2b95a9829b..27b188256dd 100644
> > --- a/bitbake/lib/bb/runqueue.py
> > +++ b/bitbake/lib/bb/runqueue.py
> > @@ -346,6 +346,7 @@ class RunTaskEntry(object):
> >           self.depends = set()
> >           self.revdeps = set()
> >           self.hash = None
> > +        self.unihash = None
> >           self.task = None
> >           self.weight = 1
> >
> > @@ -385,6 +386,9 @@ class RunQueueData:
> >       def get_task_hash(self, tid):
> >           return self.runtaskentries[tid].hash
> >
> > +    def get_task_unihash(self, tid):
> > +        return self.runtaskentries[tid].unihash
> > +
> >       def get_user_idstring(self, tid, task_name_suffix = ""):
> >           return tid + task_name_suffix
> >
> > @@ -1150,18 +1154,21 @@ class RunQueueData:
> >                   if len(self.runtaskentries[tid].depends - dealtwith) == 0:
> >                       dealtwith.add(tid)
> >                       todeal.remove(tid)
> > -                    procdep = []
> > -                    for dep in self.runtaskentries[tid].depends:
> > -                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
> > -                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
> > -                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
> > -                    task = self.runtaskentries[tid].task
> > +                    self.prepare_task_hash(tid)
> >
> >           bb.parse.siggen.writeout_file_checksum_cache()
> >
> >           #self.dump_data()
> >           return len(self.runtaskentries)
> >
> > +    def prepare_task_hash(self, tid):
> > +        procdep = []
> > +        for dep in self.runtaskentries[tid].depends:
> > +            procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
> > +        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
> > +        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
> > +        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(fn + "." + taskname)
> > +
> >       def dump_data(self):
> >           """
> >           Dump some debug information on the internal data structures
> > @@ -2081,7 +2088,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
> >                   deps = self.rqdata.runtaskentries[revdep].depends
> >                   provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
> >                   taskhash = self.rqdata.runtaskentries[revdep].hash
> > -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
> > +                unihash = self.rqdata.runtaskentries[revdep].unihash
> > +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
> >                   for revdep2 in deps:
> >                       if revdep2 not in taskdepdata:
> >                           additional.append(revdep2)
> > @@ -2524,7 +2532,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
> >                   deps = getsetscenedeps(revdep)
> >                   provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
> >                   taskhash = self.rqdata.runtaskentries[revdep].hash
> > -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
> > +                unihash = self.rqdata.runtaskentries[revdep].unihash
> > +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
> >                   for revdep2 in deps:
> >                       if revdep2 not in taskdepdata:
> >                           additional.append(revdep2)

