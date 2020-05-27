Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web11.160.1590608906216826985
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 12:48:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 04RJmNov011547
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 27 May 2020 14:48:24 -0500
Subject: Re: [bitbake-devel] Backtrace in bitbake with OE archiver
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org,
        Patches and discussions about the oe-core layer
 <openembedded-core@lists.openembedded.org>
References: <1612FA2EB600CD59.21972@lists.openembedded.org>
Message-ID: <52105f31-e452-f00e-5019-db5987b58c47@kernel.crashing.org>
Date: Wed, 27 May 2020 14:48:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1612FA2EB600CD59.21972@lists.openembedded.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

One more note.. Adding the following and then it works fine:

INITRAMFS_IMAGE = "core-image-minimal"

I suspect it works simply because the task processing order has changed in some
way..

On 5/27/20 2:44 PM, Mark Hatle wrote:
> Cross posting cause I'm not sure where the bug is, I suspect bitbake -- but it
> could be in OE's archiver class.  I have been able to reproduce this in both
> Zeus and master.
> 
> When I start a new project, and add the following to the local.conf:
> 
> INHERIT += "archiver"
> ARCHIVER_MODE[src] = "original"
> COPYLEFT_LICENSE_INCLUDE = ""
> COPYLEFT_LICENSE_EXCLUDE = ""
> 
> 
> Then I run it with:
> 
> bitbake core-image-minimal --runall=deploy_archives
> 
> 
> and I get a backtrace in bitbake:
> 
> ERROR: Running idle function
> Traceback (most recent call last):
>   File "/scratch1/fray/poky/bitbake/lib/bb/runqueue.py", line 1527, in
> RunQueue.execute_runqueue():
>              try:
>     >            return self._execute_runqueue()
>              except bb.runqueue.TaskFailure:
>   File "/scratch1/fray/poky/bitbake/lib/bb/runqueue.py", line 1444, in
> RunQueue._execute_runqueue():
>                                                                  [43, 967, 4, 3,
> 1, 5, 3, 7, 13, 1, 2, 1, 1, 246, 35, 1, 38, 1, 35, 2, 338, 204, 142, 3, 3, 37, 244])
>     >            if self.rqdata.prepare() == 0:
>                      self.state = runQueueComplete
>   File "/scratch1/fray/poky/bitbake/lib/bb/runqueue.py", line 935, in
> RunQueueData.prepare():
>                      for tid in list(runall_tids):
>     >                    mark_active(tid,1)
>                          if self.cooker.configuration.force:
>   File "/scratch1/fray/poky/bitbake/lib/bb/runqueue.py", line 850, in
> mark_active(tid='/scratch1/fray/poky/meta/recipes-core/images/core-image-minimal.bb:do_deploy_archives',
> depth=1):
>                  for depend in depends:
>     >                mark_active(depend, depth+1)
> 
>   File "/scratch1/fray/poky/bitbake/lib/bb/runqueue.py", line 848, in
> mark_active(tid='/scratch1/fray/poky/meta/recipes-core/images/core-image-minimal.bb:do_ar_original',
> depth=2):
> 
>     >            depends = self.runtaskentries[tid].depends
>                  for depend in depends:
> KeyError:
> '/scratch1/fray/poky/meta/recipes-core/images/core-image-minimal.bb:do_ar_original'
> 
> 
> As you see above the system in the mark_active function of runqueue.py is trying
> to reference the key of the task core-image-minimal:do_ar_original, and it can't
> find it and crashes out.
> 
> 
> 
> 
