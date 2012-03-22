Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAWgJ-0007ii-Vi
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 02:19:12 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Mar 2012 18:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121740572"
Received: from unknown (HELO [10.255.15.222]) ([10.255.15.222])
	by azsmga001.ch.intel.com with ESMTP; 21 Mar 2012 18:10:16 -0700
Message-ID: <4F6A7BF8.7050904@linux.intel.com>
Date: Wed, 21 Mar 2012 18:10:16 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1332344691-24973-1-git-send-email-eric@eukrea.com>
In-Reply-To: <1332344691-24973-1-git-send-email-eric@eukrea.com>
Subject: Re: [PATCH] runningbuild.py: fix goggle ui
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 22 Mar 2012 01:19:12 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/03/12 08:44, Eric Bénard wrote:
> without this fix I get the following error once the build is finished :
> Traceback (most recent call last):
>    File ".../bitbake/lib/bb/ui/goggle.py", line 35, in event_handle_idle_func
>      build.handle_event (event, pbar)
>    File ".../bitbake/lib/bb/ui/crumbs/runningbuild.py", line 287, in handle_event
>      pbar.set_text(event.msg)
> AttributeError: 'ProgressBar' object has no attribute 'set_text'
>
> Signed-off-by: Eric Bénard<eric@eukrea.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/runningbuild.py |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
> index 4c3fe2c..343eac9 100644
> --- a/lib/bb/ui/crumbs/runningbuild.py
> +++ b/lib/bb/ui/crumbs/runningbuild.py
> @@ -284,7 +284,7 @@ class RunningBuild (gobject.GObject):
>               # handle when the build is finished
>               self.emit("build-complete")
>               if pbar:
> -                pbar.set_text(event.msg)
> +                pbar.set_title(event.msg)
>
>           elif isinstance(event, bb.command.CommandFailed):
>               if event.error.startswith("Exited with"):

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


