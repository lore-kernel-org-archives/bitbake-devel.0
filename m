Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web10.11275.1619542639685811923
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Apr 2021 09:57:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 13RGv4nD001293
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 27 Apr 2021 11:57:15 -0500
Subject: Re: [bitbake-devel] [1.50][PATCH 1/5] runqueue: Fix deferred task issues
To: Anuj Mittal <anuj.mittal@intel.com>, bitbake-devel@lists.openembedded.org
References: <cover.1619407547.git.anuj.mittal@intel.com>
 <c09436f7c719c4341611bb4df91524738d272440.1619407547.git.anuj.mittal@intel.com>
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
Message-ID: <d773e5f2-947b-c1a6-f015-f465f42e207c@kernel.crashing.org>
Date: Tue, 27 Apr 2021 11:57:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <c09436f7c719c4341611bb4df91524738d272440.1619407547.git.anuj.mittal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

This change also fixes the same issue in 'gatesgarth' work as well.  Can we get
this added there as well.  (I'm happy to submit something, just wanted to check
if it was already in plan.)

On 4/25/21 10:27 PM, Anuj Mittal wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> In a multiconfig situation there are circumstances where firstly, tasks
> are deferred when they shouldn't be, then later, tasks can end up as
> both covered and not covered.
> 
> This patch fixes two related issues. Firstly, the stamp validity checking
> is done up front in the build and not reevaulated. When rebuilding the
> deferred task list after scenequeue hash change updates, we need therefore
> need to check if a task was in notcovered *or* covered when deciding to
> defer it. This avoids strange logs like:
> 
> NOTE: Running setscene task X of Y (mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch_setscene)
> NOTE: Deferring mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch after mc:host:/A/alsa-state.bb:do_deploy_source_date_epoch
> 
> where tasks have run but are then deferred.
> 
> Since we're recalculating the whole list, we also need to clear it before
> iterating to rebuild it. By ensuring covered tasks aren't added to the
> deferred queue, the covered + notcovered issue should also be avoided.
> in the task deadlock forcing code.
> 
> [YOCTO #14342]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 3c8717fb9ee1114dd80fc1ad22ee6c9e312bdac7)
> Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
> ---
>  lib/bb/runqueue.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index cd56a5547..feb42d3e6 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2845,6 +2845,7 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
>      sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False, summary=summary)
>  
>      sqdata.hashes = {}
> +    sqrq.sq_deferred = {}
>      for mc in sorted(sqdata.multiconfigs):
>          for tid in sorted(sqdata.sq_revdeps):
>              if mc_from_tid(tid) != mc:
> @@ -2857,6 +2858,9 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
>                  continue
>              if tid in sqrq.scenequeue_notcovered:
>                  continue
> +            if tid in sqrq.scenequeue_covered:
> +                continue
> +
>              sqdata.outrightfail.add(tid)
>  
>              h = pending_hash_index(tid, rqdata)
> 
> 
> 
> 
> 
