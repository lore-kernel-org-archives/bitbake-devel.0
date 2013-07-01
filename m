Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1ED656A464
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Jul 2013 18:25:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 01 Jul 2013 11:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,975,1363158000"; d="scan'208";a="358865181"
Received: from unknown (HELO helios.localnet) ([10.252.121.228])
	by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2013 11:21:27 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Mon, 01 Jul 2013 19:20:33 +0100
Message-ID: <62398305.0Uz9VVFp72@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.3 (Linux/3.8.0-25-generic; KDE/4.10.3; i686; ; )
In-Reply-To: <1372666192-31059-1-git-send-email-cristiana.voicu@intel.com>
References: <1372666192-31059-1-git-send-email-cristiana.voicu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: save button from settings called a nonexisting method
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 01 Jul 2013 18:25:42 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristiana,

On Monday 01 July 2013 11:09:52 Cristiana Voicu wrote:
> The method was removed when the process for saving configuration
> in Hob was changed. Replace the call with the right function.
> 
> [YOCTO #4793]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py         |    6 +++---
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py
> b/bitbake/lib/bb/ui/crumbs/builder.py index d5df60f..8571014 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -191,7 +191,7 @@ class Configuration:
>          self.split_proxy("socks", params["socks_proxy"])
>          self.split_proxy("cvs", params["cvs_proxy_host"] + ":" +
> params["cvs_proxy_port"])
> 
> -    def save(self, handler, template, defaults=False):
> +    def save(self, handler, defaults=False):
>          # bblayers.conf
>          handler.set_var_in_file("BBLAYERS", self.layers, "bblayers.conf")
>          # local.conf
> @@ -1229,7 +1229,7 @@ class Builder(gtk.Window):
>          settings_changed = False
>          if response == gtk.RESPONSE_YES:
>              self.configuration = dialog.configuration
> -            self.save_defaults() # remember settings
> +            self.configuration.save(self.handler, True) # remember settings
> settings_changed = dialog.settings_changed
>          dialog.destroy()
>          return response == gtk.RESPONSE_YES, settings_changed
> @@ -1257,7 +1257,7 @@ class Builder(gtk.Window):
>          settings_changed = False
>          if response == gtk.RESPONSE_YES:
>              self.configuration = dialog.configuration
> -            self.save_defaults() # remember settings
> +            self.configuration.save(self.handler, True) # remember settings
> settings_changed = dialog.settings_changed
>              if dialog.proxy_settings_changed:
>                  self.set_user_config_proxies()
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py index 1b9596f..8788083 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -146,7 +146,9 @@ class HobHandler(gobject.GObject):
>          elif next_command == self.SUB_MATCH_CLASS:
>              self.runCommand(["findFilesMatchingInDir", "rootfs_",
> "classes"]) elif next_command == self.SUB_PARSE_CONFIG:
> +            self.runCommand(["enableDataTracking"])
>              self.runCommand(["parseConfigurationFiles", "conf/.hob.conf",
> ""]) 
> +            self.runCommand(["disableDataTracking"])

This change doesn't seem to be mentioned in the commit message, is this meant 
to be part of this patch?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

