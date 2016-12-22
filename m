Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6D2E477502
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Dec 2016 08:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBM8xKLd013936; Thu, 22 Dec 2016 08:59:20 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oNySoZEZzfJt; Thu, 22 Dec 2016 08:59:20 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBM8xIE1013933
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Dec 2016 08:59:20 GMT
Message-ID: <1482397158.9843.130.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jianxun Zhang <jianxun.zhang@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 22 Dec 2016 08:59:18 +0000
In-Reply-To: <1482352057-26139-1-git-send-email-jianxun.zhang@linux.intel.com>
References: <1482352057-26139-1-git-send-email-jianxun.zhang@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
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
X-List-Received-Date: Thu, 22 Dec 2016 08:59:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2016-12-21 at 12:27 -0800, Jianxun Zhang wrote:
> This change significantly shortens the time on reparsing stage
> of '-S' option.
> 
> Each file is reparsed and then dumped within a dedicated
> process. The maximum number of the running processes is not
> greater than the value of BB_NUMBER_PARSE_THREADS if it is set.
> 
> The dump_sigs() in class SignatureGeneratorBasic is _replaced_
> by a new dump_sigfn() interface, so calls from the outside and
> subclasses are dispatched to the implementation in the base
> class of SignatureGeneratorBasic.
> 
> Fixes [YOCTO #10352]

Thanks, I think this is heading in the right direction. 

I am a little bit worried that this leaves OE's sstatesig.py with a
dump_sigs() function which isn't used/connected into everything else
though? Does this still write out a locked sigs file after this change?

Cheers,

Richard


> Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> ---
>  bitbake/lib/bb/runqueue.py | 32 +++++++++++++++++++++++++++-----
>  bitbake/lib/bb/siggen.py   |  4 ++--
>  2 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 2ad8aad..c7d8d53 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -36,6 +36,7 @@ from bb import msg, data, event
>  from bb import monitordisk
>  import subprocess
>  import pickle
> +from multiprocessing import Process
>  
>  bblogger = logging.getLogger("BitBake")
>  logger = logging.getLogger("BitBake.RunQueue")
> @@ -1302,15 +1303,36 @@ class RunQueue:
>          else:
>              self.rqexe.finish()
>  
> +    def rq_dump_sigfn(self, fn, options):
> +        bb_cache = bb.cache.NoCache(self.cooker.databuilder)
> +        the_data = bb_cache.loadDataFull(fn,
> self.cooker.collection.get_file_appends(fn))
> +        siggen = bb.parse.siggen
> +        dataCaches = self.rqdata.dataCaches
> +        siggen.dump_sigfn(fn, dataCaches, options)
> +
>      def dump_signatures(self, options):
> -        done = set()
> +        fns = set()
>          bb.note("Reparsing files to collect dependency data")
> -        bb_cache = bb.cache.NoCache(self.cooker.databuilder)
> +
>          for tid in self.rqdata.runtaskentries:
>              fn = fn_from_tid(tid)
> -            if fn not in done:
> -                the_data = bb_cache.loadDataFull(fn,
> self.cooker.collection.get_file_appends(fn))
> -                done.add(fn)
> +            fns.add(fn)
> +
> +        max_process =
> int(self.cfgData.getVar("BB_NUMBER_PARSE_THREADS") or os.cpu_count()
> or 1)
> +        # We cannot use the real multiprocessing.Pool easily due to
> some local data
> +        # that can't be pickled. This is a cheap multi-process
> solution.
> +        launched = []
> +        while fns:
> +            if len(launched) < max_process:
> +                p = Process(target=self.rq_dump_sigfn,
> args=(fns.pop(), options))
> +                p.start()
> +                launched.append(p)
> +            for q in launched:
> +                # The finished processes are joined when calling
> is_alive()
> +                if not q.is_alive():
> +                    launched.remove(q)
> +        for p in launched:
> +                p.join()
>  
>          bb.parse.siggen.dump_sigs(self.rqdata.dataCaches, options)
>  
> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> index b20b9cf..ae50a18 100644
> --- a/bitbake/lib/bb/siggen.py
> +++ b/bitbake/lib/bb/siggen.py
> @@ -307,8 +307,8 @@ class
> SignatureGeneratorBasic(SignatureGenerator):
>                  pass
>              raise err
>  
> -    def dump_sigs(self, dataCaches, options):
> -        for fn in self.taskdeps:
> +    def dump_sigfn(self, fn, dataCaches, options):
> +        if fn in self.taskdeps:
>              for task in self.taskdeps[fn]:
>                  tid = fn + ":" + task
>                  (mc, _, _) = bb.runqueue.split_tid(tid)
> -- 
> 2.7.4
> 

