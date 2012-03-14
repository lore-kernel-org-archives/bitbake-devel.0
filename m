Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAL-0003eY-Bw
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:21 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044758"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:37:59 -0700
Message-ID: <4F60F395.9080502@linux.intel.com>
Date: Wed, 14 Mar 2012 12:37:57 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<42a098d7aa3f119f3f6735be07da727591ef8118.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <42a098d7aa3f119f3f6735be07da727591ef8118.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 02/11] Hob: Disable the handling of "NoProvider" event
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
X-List-Received-Date: Wed, 14 Mar 2012 19:47:22 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 02:26, Dongxiao Xu wrote:
> Currently for non-x86 architecture, there are un-resolved dependency
> issue when generate universe dependency tree. Therefore disable the
> handling of "NoProvider" event in Hob to enable the build for non-x86
> architectures. After we resolved the dependency for universe, we still
> need to handle this event in Hob.

I'm not sure we'll ever be able to strongly guarantee that NoProvider 
issues won't creep in. Would we better off coming up with a more tenable 
long term solution?

>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

This is a reasonable short-term solution

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/hobeventhandler.py |   37 ++++++++++++++++++----------------
>   1 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
> index 6c109fc..9c82bfe 100644
> --- a/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -215,23 +215,26 @@ class HobHandler(gobject.GObject):
>           elif isinstance(event, bb.command.CommandCompleted):
>               self.current_phase = None
>               self.run_next_command()
> -
> -        elif isinstance(event, bb.event.NoProvider):
> -            if event._runtime:
> -                r = "R"
> -            else:
> -                r = ""
> -            if event._dependees:
> -                self.error_msg += " Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
> -            else:
> -                self.error_msg += " Nothing %sPROVIDES '%s'" % (r, event._item)
> -            if event._reasons:
> -                for reason in event._reasons:
> -                    self.error_msg += " %s" % reason
> -
> -            self.commands_async = []
> -            self.emit("command-failed", self.error_msg)
> -            self.error_msg = ""
> +        # TODO: Currently there are NoProvider issues when generate
> +        # universe tree dependency for non-x86 architecture.
> +        # Comment the follow code to enable the build of non-x86
> +        # architectures in Hob.
> +        #elif isinstance(event, bb.event.NoProvider):
> +        #    if event._runtime:
> +        #        r = "R"
> +        #    else:
> +        #        r = ""
> +        #    if event._dependees:
> +        #        self.error_msg += " Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
> +        #    else:
> +        #        self.error_msg += " Nothing %sPROVIDES '%s'" % (r, event._item)
> +        #    if event._reasons:
> +        #        for reason in event._reasons:
> +        #            self.error_msg += " %s" % reason
> +
> +        #    self.commands_async = []
> +        #    self.emit("command-failed", self.error_msg)
> +        #    self.error_msg = ""
>
>           elif isinstance(event, bb.command.CommandFailed):
>               self.commands_async = []

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


