Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D8D106BC7E;
	Wed,  5 Dec 2018 22:52:23 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	wB5MqMmQ012785
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 5 Dec 2018 22:52:23 GMT
Message-ID: <5d5b3aba3171a2fc2ef94157769ec0b0e46e49f9.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>,
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 05 Dec 2018 22:52:22 +0000
In-Reply-To: <20181204034245.25461-14-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181204034245.25461-14-JPEWhacker@gmail.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.2 at dan
X-Virus-Status: Clean
Subject: Re: [OE-core][PATCH v3 13/17] bitbake: runqueue: Pass dependency ID to hash validate
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
X-List-Received-Date: Wed, 05 Dec 2018 22:52:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-12-03 at 21:42 -0600, Joshua Watt wrote:
> If the dependency ID is being used to track task dependencies, the
> hash
> validation function needs to know about it in order to properly
> validate
> the hash.
> 
> TODO: This currently isn't going to be backward compatible with older
> hashvalidate functions. Is that necessary, and if so are there any
> suggestions for a good approach?

That is necessary or bitbake and the metadata need to be in lock step.

@@ -1567,15 +1568,16 @@ class RunQueue:
>              sq_fn.append(fn)
>              sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
>              sq_hash.append(self.rqdata.runtaskentries[tid].hash)
> +            sq_depid.append(self.rqdata.runtaskentries[tid].depid)
>              sq_taskname.append(taskname)
>              sq_task.append(tid)
> -        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
> +        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "sq_depid" : sq_depid, "d" : self.cooker.data }
>          try:
> -            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=True)"
> +            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=True)"
>              valid = bb.utils.better_eval(call, locs)
>          # Handle version with no siginfo parameter
>          except TypeError:
> -            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
> +            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d)"
>              valid = bb.utils.better_eval(call, locs)
>          for v in valid:
> 

The hint on how we've handled this before is in the code, the TypeError
was the fallback code for older metadata (which you just broke!). We
may need to do something similar here.

Cheers,

Richard


