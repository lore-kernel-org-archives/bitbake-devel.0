Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDV-0003Hu-8n
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:37:45 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979670"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:17 -0800
Message-ID: <4F4E98AD.6080008@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:17 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<36bbfae6e2a84015b39e4a7fa4ed6e0aff5036c0.1330523904.git.shane.wang@intel.com>
In-Reply-To: <36bbfae6e2a84015b39e4a7fa4ed6e0aff5036c0.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 10/32] Hob: add ignore_all_errors to avoid showing error dialog multiple times
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
X-List-Received-Date: Wed, 29 Feb 2012 21:37:45 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 29/02/12 06:15, Shane Wang wrote:
> when parsing recipes, if there are some errors, the error dialog will be shown again and again for each error, add "Ignore All" to allow users to ignore those errors.

I'm not so sure about this. I don't think ignoring all parse errors is 
the right thing, collecting them up into one dialogue seems like a 
better first step.

What if I add some layers which introduce different parsing errors after 
I've clicked 'Ignore All' once?

Cheers,
Joshua

>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/builder.py |   20 ++++++++++++++------
>   1 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 819b79f..fc231ef 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -178,6 +178,8 @@ class Builder(gtk.Window):
>
>           self.template = None
>
> +        self.ignore_all_errors = False
> +
>           # settings
>           params = self.handler.get_parameters()
>           self.configuration = Configuration(params)
> @@ -315,6 +317,8 @@ class Builder(gtk.Window):
>
>           elif next_step == self.RCPPKGINFO_POPULATING:
>               # MACHINE CHANGED action or SETTINGS CHANGED
> +            # reset the "ignore all errors" var
> +            self.ignore_all_errors = False
>               # show the progress bar
>               self.image_configuration_page.show_info_populating()
>               self.generate_recipes()
> @@ -440,12 +444,16 @@ class Builder(gtk.Window):
>                   self.switch_page(self.IMAGE_GENERATED)
>
>       def handler_command_failed_cb(self, handler, msg):
> -        lbl = "<b>Error</b>\n"
> -        lbl = lbl + "%s\n\n" % msg
> -        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
> -        dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> -        response = dialog.run()
> -        dialog.destroy()
> +        if self.ignore_all_errors == False:
> +            lbl = "<b>Error</b>\n"
> +            lbl = lbl + "%s\n\n" % msg
> +            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
> +            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> +            dialog.add_button("Ignore All", gtk.RESPONSE_REJECT)
> +            response = dialog.run()
> +            if response == gtk.RESPONSE_REJECT:
> +                self.ignore_all_errors = True
> +            dialog.destroy()
>           self.handler.clear_busy()
>           self.configuration.curr_mach = None
>           self.image_configuration_page.switch_machine_combo()

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


