Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id E384E7BEF8;
	Mon,  7 Jan 2019 16:40:12 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id h193so1876640ita.5;
	Mon, 07 Jan 2019 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=ROVZj1lXoD4NlF2VGgjyGn9uk6MQ1G8k6NhRNmneVoc=;
	b=iUBYiS1NZqIFOl/SBmUJxz5zMSUfDHwv80uWiFxY5MWycwB0vGKMXomZCggh1G8nFT
	MtBbYphrbb4etKlNd8cxpKVNBZICUJSPQlgtWJo/MWOcXyek8EeItlaU4copk2yovYbj
	6stb/UOmFk+KSWHLpPDKTcUqQvcH8Hup6sZsY7BHMfVtnOzEWcrXvF3IVB95gj/qLrZt
	JYeNvOmzwTaNbpqzgAUTdyHALOWfsRooscPu43ue8spn7OtK05Wd5mDMeQkwzcBAHbsi
	pdY9G1XOhU2SOOQRotLZp/DVfaZ+4FXKyNQ9fTQqhHl9tb5OhecmDEzxVqryyZdY5YvU
	rnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=ROVZj1lXoD4NlF2VGgjyGn9uk6MQ1G8k6NhRNmneVoc=;
	b=ET5xgd4zvFyTtEbQGwKzgsuITCQdsRxl6dYp2iiW4lFmBYvh1u7e9qpGOwmpe64Mnr
	ISCbeGxk2fEwmybYEewTO4tX95zGiq9VlHHaee07qCEWnWS3v4NYP7gwkmQPwSg1lV2B
	MYWf+wKvl0uDofDuCYrpWJIqvxQeAGTFSLJLK7qzCyxaYYboJ3OzJbWHYhhZduQOIdfj
	Jw97+xjpiIE3/ZpGPaxm/1FvSoGcNwld413dtWlEROEkgXeN5AiKJYVNRKiJCV/5Oo2o
	bWgSdtIi4HJy6Kse0loTFL32iD76HywHdbUpDl1wtOKH2kj51UsCnbkDMZ/QBRfMPIn8
	7xMA==
X-Gm-Message-State: AJcUukck+cd3yUufPXBXaNuco7Rvb9l8+6fGQO+XYu5DWpSQWMnSKlxW
	e7VqTJ82bHREBeauv6NacVs=
X-Google-Smtp-Source: ALg8bN724xk30vDQR/y/JWKiKqYboI2bbbSVBB6LsbJrxsW1NVQz6TTGBZWmKzzyO0AnuzRkmAYuTg==
X-Received: by 2002:a24:c187:: with SMTP id e129mr8713477itg.68.1546879213877; 
	Mon, 07 Jan 2019 08:40:13 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	i135sm5121581iti.34.2019.01.07.08.40.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 07 Jan 2019 08:40:13 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <66541665b5dc05b097a58762325359ec34f225fe.camel@gmail.com>
To: akuster808 <akuster808@gmail.com>, Alejandro Hernandez
	<alejandro.enedino.hernandez-samaniego@xilinx.com>
Date: Mon, 07 Jan 2019 10:40:12 -0600
In-Reply-To: <f13165a4-016d-f2f7-7640-6716bfc9b2a8@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
	<20181219031033.28045-4-JPEWhacker@gmail.com>
	<d41b6e89-8450-58c9-13fb-6437332f3f20@xilinx.com>
	<CAJdd5Gbik0fCVCoWYzwYF7ND6G35ADeX0UdAk1_2X7k2TcnPQw@mail.gmail.com>
	<f13165a4-016d-f2f7-7640-6716bfc9b2a8@gmail.com>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
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
X-List-Received-Date: Mon, 07 Jan 2019 16:40:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-01-07 at 08:16 -0800, akuster808 wrote:
> 
> On 1/5/19 7:09 PM, Joshua Watt wrote:
> > On Sat, Jan 5, 2019 at 1:50 AM Alejandro Hernandez
> > <alejandro.enedino.hernandez-samaniego@xilinx.com> wrote:
> > > Hey Joshua,
> > > 
> > > This is breaking multiconfig builds with the following error
> > > (trimmed),
> > > I believe it is not taking into account that the Key could
> > > contain
> > > "mc:..." if it is a multiconfig build.
> > Hmm, yes that seems likely. I'll take a look, would you mind
> > opening a
> > bug in Bugzilla and assigning it to me? I'm not very familiar with
> > multiconfig, so some instructions to help reproduce would be very
> > helpful.
> > 
> > Does anyone know if mutliconfig is tested on the autobuilders?
> We don't as far as I know.
> 
> Do we need to bug this as this patch in in master.

I don't know what the exact criteria is for when a bug gets created.
Based on my (limited) previous experience, I thought it deserved a bug
because it was on master and we are past 2.7 M1.

Anyway, it's already been created: 
https://bugzilla.yoctoproject.org/show_bug.cgi?id=13124

> 
> - armin
> > > ERROR: Running idle function
> > >   File "poky/bitbake/lib/bb/runqueue.py", line 1170, in
> > > RunQueueData.prepare_task_hash(tid='multiconfig:x86:poky/meta/rec
> > > ipes-support/attr/acl_2.2.52.bb:do_fetch'):
> > >               self.runtaskentries[tid].hash =
> > > bb.parse.siggen.get_taskhash(taskfn, taskname, procdep,
> > > self.dataCaches[mc])
> > >      >        self.runtaskentries[tid].unihash =
> > > bb.parse.siggen.get_unihash(fn + "." + taskname)
> > > 
> > >    File "poky/bitbake/lib/bb/siggen.py", line 45, in
> > > SignatureGeneratorOEBasicHash.get_unihash(task='poky/meta/recipes
> > > -support/attr/acl_2.2.52.bb.do_fetch'):
> > >           def get_unihash(self, task):
> > >      >        return self.taskhash[task]
> > > 
> > > KeyError: 'poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'
> > > 
> > > 
> > > Cheers,
> > > 
> > > Alejandro
> > > 
> > > 
> > > On 12/18/2018 7:10 PM, Joshua Watt wrote:
> > > > Requests the task unique hash from siggen and tracks it
> > > > 
> > > > [YOCTO #13030]
> > > > 
> > > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > > ---
> > > >   bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
> > > >   1 file changed, 17 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/bitbake/lib/bb/runqueue.py
> > > > b/bitbake/lib/bb/runqueue.py
> > > > index f2b95a9829b..27b188256dd 100644
> > > > --- a/bitbake/lib/bb/runqueue.py
> > > > +++ b/bitbake/lib/bb/runqueue.py
> > > > @@ -346,6 +346,7 @@ class RunTaskEntry(object):
> > > >           self.depends = set()
> > > >           self.revdeps = set()
> > > >           self.hash = None
> > > > +        self.unihash = None
> > > >           self.task = None
> > > >           self.weight = 1
> > > > 
> > > > @@ -385,6 +386,9 @@ class RunQueueData:
> > > >       def get_task_hash(self, tid):
> > > >           return self.runtaskentries[tid].hash
> > > > 
> > > > +    def get_task_unihash(self, tid):
> > > > +        return self.runtaskentries[tid].unihash
> > > > +
> > > >       def get_user_idstring(self, tid, task_name_suffix = ""):
> > > >           return tid + task_name_suffix
> > > > 
> > > > @@ -1150,18 +1154,21 @@ class RunQueueData:
> > > >                   if len(self.runtaskentries[tid].depends -
> > > > dealtwith) == 0:
> > > >                       dealtwith.add(tid)
> > > >                       todeal.remove(tid)
> > > > -                    procdep = []
> > > > -                    for dep in
> > > > self.runtaskentries[tid].depends:
> > > > -                        procdep.append(fn_from_tid(dep) + "."
> > > > + taskname_from_tid(dep))
> > > > -                    (mc, fn, taskname, taskfn) =
> > > > split_tid_mcfn(tid)
> > > > -                    self.runtaskentries[tid].hash =
> > > > bb.parse.siggen.get_taskhash(taskfn, taskname, procdep,
> > > > self.dataCaches[mc])
> > > > -                    task = self.runtaskentries[tid].task
> > > > +                    self.prepare_task_hash(tid)
> > > > 
> > > >           bb.parse.siggen.writeout_file_checksum_cache()
> > > > 
> > > >           #self.dump_data()
> > > >           return len(self.runtaskentries)
> > > > 
> > > > +    def prepare_task_hash(self, tid):
> > > > +        procdep = []
> > > > +        for dep in self.runtaskentries[tid].depends:
> > > > +            procdep.append(fn_from_tid(dep) + "." +
> > > > taskname_from_tid(dep))
> > > > +        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
> > > > +        self.runtaskentries[tid].hash =
> > > > bb.parse.siggen.get_taskhash(taskfn, taskname, procdep,
> > > > self.dataCaches[mc])
> > > > +        self.runtaskentries[tid].unihash =
> > > > bb.parse.siggen.get_unihash(fn + "." + taskname)
> > > > +
> > > >       def dump_data(self):
> > > >           """
> > > >           Dump some debug information on the internal data
> > > > structures
> > > > @@ -2081,7 +2088,8 @@ class
> > > > RunQueueExecuteTasks(RunQueueExecute):
> > > >                   deps =
> > > > self.rqdata.runtaskentries[revdep].depends
> > > >                   provides =
> > > > self.rqdata.dataCaches[mc].fn_provides[taskfn]
> > > >                   taskhash =
> > > > self.rqdata.runtaskentries[revdep].hash
> > > > -                taskdepdata[revdep] = [pn, taskname, fn, deps,
> > > > provides, taskhash]
> > > > +                unihash =
> > > > self.rqdata.runtaskentries[revdep].unihash
> > > > +                taskdepdata[revdep] = [pn, taskname, fn, deps,
> > > > provides, taskhash, unihash]
> > > >                   for revdep2 in deps:
> > > >                       if revdep2 not in taskdepdata:
> > > >                           additional.append(revdep2)
> > > > @@ -2524,7 +2532,8 @@ class
> > > > RunQueueExecuteScenequeue(RunQueueExecute):
> > > >                   deps = getsetscenedeps(revdep)
> > > >                   provides =
> > > > self.rqdata.dataCaches[mc].fn_provides[taskfn]
> > > >                   taskhash =
> > > > self.rqdata.runtaskentries[revdep].hash
> > > > -                taskdepdata[revdep] = [pn, taskname, fn, deps,
> > > > provides, taskhash]
> > > > +                unihash =
> > > > self.rqdata.runtaskentries[revdep].unihash
> > > > +                taskdepdata[revdep] = [pn, taskname, fn, deps,
> > > > provides, taskhash, unihash]
> > > >                   for revdep2 in deps:
> > > >                       if revdep2 not in taskdepdata:
> > > >                           additional.append(revdep2)
-- 
Joshua Watt <JPEWhacker@gmail.com>


