Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.671.1794930581520379227
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 07:49:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AHFnd6r3683979;
	Tue, 17 Nov 2026 09:49:39 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AHFncUS012459;
	Tue, 17 Nov 2026 09:49:38 -0600
Message-ID: <14f29a56-d2cf-482b-a1ed-f1871791fb71@kernel.crashing.org>
Date: Tue, 17 Nov 2026 09:49:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/2] runqueue: Improve deferred task
 sorting
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <20261117114550.2306278-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20261117114550.2306278-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 15:49:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20450

Verified this set resolves the problems I was seeing.

If we can, I would love it to be backported to 2.18 (wrynose) where I've also 
seen the problem a lot.

Thanks for all of the help.

--Mark

On 11/17/26 5:45 AM, Richard Purdie via bitbake-devel wrote:
> Whilst looking for other problems, I noticed the sorting used for deferring
> tasks isn't always consistent. It needs to be so that same multiconfig is
> always preferred over the others, which gives a much lower chance of
> deadlocking.
> 
> Add a helper sorting function and use it in all the locations we need this
> sorting.
> 
> That means we can remove the weird looking looping code from the locations
> which did get this right.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/runqueue.py | 42 +++++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 63615ac6c92..4f80f1fde21 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -85,6 +85,13 @@ def build_tid(mc, fn, taskname):
>           return "mc:" + mc + ":" + fn + ":" + taskname
>       return fn + ":" + taskname
>   
> +def sort_tids_by_mc(tids, multiconfigs):
> +    """
> +    Return tids grouped by multiconfig, with the groups in sorted mc order
> +    and the tids sorted within each group.
> +    """
> +    return [tid for _, tid in sorted(((mc_from_tid(tid), tid) for tid in tids))]
> +
>   # Index used to pair up potentially matching multiconfig tasks
>   # We match on PN, taskname and hash being equal
>   def pending_hash_index(tid, rqdata):
> @@ -2109,7 +2116,7 @@ class RunQueueExecute:
>                   logger.debug("Marking task %s as buildable", revdep)
>   
>           found = None
> -        for t in sorted(self.sq_deferred.copy()):
> +        for t in sort_tids_by_mc(self.sq_deferred.copy(), self.sqdata.multiconfigs):
>               if self.sq_deferred[t] == task:
>                   # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
>                   # We shouldn't allow all to run at once as it is prone to races.
> @@ -2738,14 +2745,11 @@ class RunQueueExecute:
>   
>           if update_tasks2:
>               self.sqdone = False
> -            for mc in sorted(self.sqdata.multiconfigs):
> -                for tid in sorted([t[0] for t in update_tasks2]):
> -                    if mc_from_tid(tid) != mc:
> -                        continue
> -                    h = pending_hash_index(tid, self.rqdata)
> -                    if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
> -                        self.sq_deferred[tid] = self.sqdata.hashes[h]
> -                        bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
> +            for tid in sort_tids_by_mc([t[0] for t in update_tasks2], self.sqdata.multiconfigs):
> +                h = pending_hash_index(tid, self.rqdata)
> +                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
> +                    self.sq_deferred[tid] = self.sqdata.hashes[h]
> +                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
>               update_scenequeue_data([t[0] for t in update_tasks2], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
>   
>           for (tid, harddepfail, origvalid) in update_tasks2:
> @@ -3101,6 +3105,9 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
>           if not sqdata.sq_revdeps[tid]:
>               sqrq.sq_buildable.add(tid)
>   
> +    # Fix the ordering for determinism, sets are unordered
> +    sqdata.multiconfigs = sorted(sqdata.multiconfigs)
> +
>       rqdata.init_progress_reporter.next_stage()
>   
>       sqdata.noexec = set()
> @@ -3109,16 +3116,13 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
>   
>       sqdata.hashes = {}
>       sqrq.sq_deferred = {}
> -    for mc in sorted(sqdata.multiconfigs):
> -        for tid in sorted(sqdata.sq_revdeps):
> -            if mc_from_tid(tid) != mc:
> -                continue
> -            h = pending_hash_index(tid, rqdata)
> -            if h not in sqdata.hashes:
> -                sqdata.hashes[h] = tid
> -            else:
> -                sqrq.sq_deferred[tid] = sqdata.hashes[h]
> -                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
> +    for tid in sort_tids_by_mc(sqdata.sq_revdeps, sqdata.multiconfigs):
> +        h = pending_hash_index(tid, rqdata)
> +        if h not in sqdata.hashes:
> +            sqdata.hashes[h] = tid
> +        else:
> +            sqrq.sq_deferred[tid] = sqdata.hashes[h]
> +            bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
>   
>   def check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=False):
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20445): https://lists.openembedded.org/g/bitbake-devel/message/20445
> Mute This Topic: https://lists.openembedded.org/mt/122311783/3616948
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
