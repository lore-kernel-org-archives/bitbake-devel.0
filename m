Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAI-0003eB-3i
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:18 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044698"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:37:35 -0700
Message-ID: <4F60F37E.2050607@linux.intel.com>
Date: Wed, 14 Mar 2012 12:37:34 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<b98ff9b3ffbb6e3e3a5a1fa7eb9f3b170d27e33e.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <b98ff9b3ffbb6e3e3a5a1fa7eb9f3b170d27e33e.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 09/11] Hob: Emit command-failed signal even if error msg is None
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
X-List-Received-Date: Wed, 14 Mar 2012 19:47:18 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 02:26, Dongxiao Xu wrote:
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/builder.py         |   13 +++++++------
>   lib/bb/ui/crumbs/hobeventhandler.py |    5 ++---
>   2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> index f52b475..1363475 100755
> --- a/lib/bb/ui/crumbs/builder.py
> +++ b/lib/bb/ui/crumbs/builder.py
> @@ -430,12 +430,13 @@ class Builder(gtk.Window):
>                   self.switch_page(self.IMAGE_GENERATED)
>
>       def handler_command_failed_cb(self, handler, msg):
> -        lbl = "<b>Error</b>\n"
> -        lbl = lbl + "%s\n\n" % msg
> -        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
> -        dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> -        response = dialog.run()
> -        dialog.destroy()
> +        if msg:
> +            lbl = "<b>Error</b>\n"
> +            lbl = lbl + "%s\n\n" % msg
> +            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
> +            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> +            response = dialog.run()
> +            dialog.destroy()
>           self.handler.clear_busy()
>           self.configuration.curr_mach = None
>           self.image_configuration_page.switch_machine_combo()
> diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
> index 9c82bfe..cd25754 100644
> --- a/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -238,9 +238,8 @@ class HobHandler(gobject.GObject):
>
>           elif isinstance(event, bb.command.CommandFailed):
>               self.commands_async = []
> -            if self.error_msg:
> -                self.emit("command-failed", self.error_msg)
> -                self.error_msg = ""
> +            self.emit("command-failed", self.error_msg)
> +            self.error_msg = ""
>           elif isinstance(event, (bb.event.ParseStarted,
>                    bb.event.CacheLoadStarted,
>                    bb.event.TreeDataPreparationStarted,

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


