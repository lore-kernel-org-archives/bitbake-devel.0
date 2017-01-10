Return-Path: <jianxun.zhang@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 5D95A60851
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jan 2017 22:54:42 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga105.jf.intel.com with ESMTP; 10 Jan 2017 14:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,344,1477983600"; d="scan'208";a="52374081"
Received: from jzhang80-mac02.jf.intel.com ([10.24.8.221])
	by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2017 14:54:42 -0800
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Jianxun Zhang <jianxun.zhang@linux.intel.com>
In-Reply-To: <48AEE85D-1072-4C81-922D-D9DF9A3E4D66@linux.intel.com>
Date: Tue, 10 Jan 2017 14:54:42 -0800
Message-Id: <DA1C4B84-D5CA-4BE4-97D3-CA19F1E89C2F@linux.intel.com>
References: <1482352057-26139-1-git-send-email-jianxun.zhang@linux.intel.com>
	<1482397158.9843.130.camel@linuxfoundation.org>
	<48AEE85D-1072-4C81-922D-D9DF9A3E4D66@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3259)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] use multiple processes to dump signatures.
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
X-List-Received-Date: Tue, 10 Jan 2017 22:54:44 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi RP,
Ping~
Do you have further suggestion based on my explanation?

https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10352

Thanks

> On Dec 22, 2016, at 10:39 AM, Jianxun Zhang =
<jianxun.zhang@linux.intel.com> wrote:
>=20
>>=20
>> On Dec 22, 2016, at 12:59 AM, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>>=20
>> On Wed, 2016-12-21 at 12:27 -0800, Jianxun Zhang wrote:
>>> This change significantly shortens the time on reparsing stage
>>> of '-S' option.
>>>=20
>>> Each file is reparsed and then dumped within a dedicated
>>> process. The maximum number of the running processes is not
>>> greater than the value of BB_NUMBER_PARSE_THREADS if it is set.
>>>=20
>>> The dump_sigs() in class SignatureGeneratorBasic is _replaced_
>>> by a new dump_sigfn() interface, so calls from the outside and
>>> subclasses are dispatched to the implementation in the base
>>> class of SignatureGeneratorBasic.
>>>=20
>>> Fixes [YOCTO #10352]
>>=20
>> Thanks, I think this is heading in the right direction.=20
>>=20
>> I am a little bit worried that this leaves OE's sstatesig.py with a
>> dump_sigs() function which isn't used/connected into everything else
>> though? Does this still write out a locked sigs file after this =
change?
> I am not the expert in this area, so just share the result and my =
understanding here.
>=20
> OE=E2=80=99s dump_sigs is still connected and used. The lock-sigs.inc =
is in output and looks okay with a manual diff against one from master =
tip. This is because I still keep the calling dump_sigs() in =
dump_signatures() in runqueue.py. That line triggers OE to dump =
lock-sigs.inc.
>=20
> The instance =E2=80=9Csiggen=E2=80=9D in dump_signatures() should be =
the type of subclass in OE=E2=80=99s sstatesig.py. The dump_sigs() of OE =
class, in return, writes out the additional lock-sigs.inc and also calls =
its base class (BB) SignatureGeneratorBasic=E2=80=99s dump_sigs(), which =
is nothing now.
>=20
> This change removes dump_sigs() in SignatureGeneratorBasic=E2=80=99s =
to say "let=E2=80=99s fall back to our base class (SignatureGenerator) =
dump_sigs() since the inside of the removed dump_sigs() is replaced with =
parallel dumping". Another motivation of the removal is for code =
clarity. The loops in old dump_sigs() won=E2=80=99t work without a full =
data store. Keeping a loop in it to call new API doesn=E2=80=99t seem =
effective.
>=20
> What we miss by removing SignatureGeneratorBasic=E2=80=99s dump_sigs() =
is any existing logic/class directly calls dump_sigs() in this class =
outside of -S option path. But I don=E2=80=99t see such a case after =
some searching in BB and OE. (Another reason to remove it).
>=20
> In a short, it is a struggle between a parallelized stamp dumping and =
leaving lock-sigs.inc in a single main process. I don=E2=80=99t go =
further to parallelize writing lock-sigs.inc in OE because I think =
synchronization could be another deep hole, and this part doesn=E2=80=99t =
contribute much to perf either.
>=20
> I also ran test module sstatetest in oe-selftest and passed it.
>=20
> Feel free to let me know any better idea and improvement I should =
make.
>=20
>=20
>>=20
>> Cheers,
>>=20
>> Richard
>>=20
>>=20
>>> Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
>>> ---
>>> bitbake/lib/bb/runqueue.py | 32 +++++++++++++++++++++++++++-----
>>> bitbake/lib/bb/siggen.py   |  4 ++--
>>> 2 files changed, 29 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>>> index 2ad8aad..c7d8d53 100644
>>> --- a/bitbake/lib/bb/runqueue.py
>>> +++ b/bitbake/lib/bb/runqueue.py
>>> @@ -36,6 +36,7 @@ from bb import msg, data, event
>>> from bb import monitordisk
>>> import subprocess
>>> import pickle
>>> +from multiprocessing import Process
>>>=20
>>> bblogger =3D logging.getLogger("BitBake")
>>> logger =3D logging.getLogger("BitBake.RunQueue")
>>> @@ -1302,15 +1303,36 @@ class RunQueue:
>>>         else:
>>>             self.rqexe.finish()
>>>=20
>>> +    def rq_dump_sigfn(self, fn, options):
>>> +        bb_cache =3D bb.cache.NoCache(self.cooker.databuilder)
>>> +        the_data =3D bb_cache.loadDataFull(fn,
>>> self.cooker.collection.get_file_appends(fn))
>>> +        siggen =3D bb.parse.siggen
>>> +        dataCaches =3D self.rqdata.dataCaches
>>> +        siggen.dump_sigfn(fn, dataCaches, options)
>>> +
>>>     def dump_signatures(self, options):
>>> -        done =3D set()
>>> +        fns =3D set()
>>>         bb.note("Reparsing files to collect dependency data")
>>> -        bb_cache =3D bb.cache.NoCache(self.cooker.databuilder)
>>> +
>>>         for tid in self.rqdata.runtaskentries:
>>>             fn =3D fn_from_tid(tid)
>>> -            if fn not in done:
>>> -                the_data =3D bb_cache.loadDataFull(fn,
>>> self.cooker.collection.get_file_appends(fn))
>>> -                done.add(fn)
>>> +            fns.add(fn)
>>> +
>>> +        max_process =3D
>>> int(self.cfgData.getVar("BB_NUMBER_PARSE_THREADS") or os.cpu_count()
>>> or 1)
>>> +        # We cannot use the real multiprocessing.Pool easily due to
>>> some local data
>>> +        # that can't be pickled. This is a cheap multi-process
>>> solution.
>>> +        launched =3D []
>>> +        while fns:
>>> +            if len(launched) < max_process:
>>> +                p =3D Process(target=3Dself.rq_dump_sigfn,
>>> args=3D(fns.pop(), options))
>>> +                p.start()
>>> +                launched.append(p)
>>> +            for q in launched:
>>> +                # The finished processes are joined when calling
>>> is_alive()
>>> +                if not q.is_alive():
>>> +                    launched.remove(q)
>>> +        for p in launched:
>>> +                p.join()
>>>=20
>>>         bb.parse.siggen.dump_sigs(self.rqdata.dataCaches, options)
>>>=20
>>> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
>>> index b20b9cf..ae50a18 100644
>>> --- a/bitbake/lib/bb/siggen.py
>>> +++ b/bitbake/lib/bb/siggen.py
>>> @@ -307,8 +307,8 @@ class
>>> SignatureGeneratorBasic(SignatureGenerator):
>>>                 pass
>>>             raise err
>>>=20
>>> -    def dump_sigs(self, dataCaches, options):
>>> -        for fn in self.taskdeps:
>>> +    def dump_sigfn(self, fn, dataCaches, options):
>>> +        if fn in self.taskdeps:
>>>             for task in self.taskdeps[fn]:
>>>                 tid =3D fn + ":" + task
>>>                 (mc, _, _) =3D bb.runqueue.split_tid(tid)
>>> --=20
>>> 2.7.4
>>>=20
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


