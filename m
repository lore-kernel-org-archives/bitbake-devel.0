Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDL-0003Hu-Ty
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:37:36 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979615"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:07 -0800
Message-ID: <4F4E98A3.20501@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:07 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<01a2bab8db48a197f25682f9a5673a399e20be7d.1330523904.git.shane.wang@intel.com>
In-Reply-To: <01a2bab8db48a197f25682f9a5673a399e20be7d.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 11/32] Hob: make the image configuration page not to flash the progress bar
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
X-List-Received-Date: Wed, 29 Feb 2012 21:37:36 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 06:15, Shane Wang wrote:
> Sometimes the image configuration page flashes the progress bar, that is because we show_all() and then hide() the progress bar. For this case, the patch doesn't add the progress bar onto the gtable. Then, it will not be flashed any more.
>
> Signed-off-by: Shane Wang<shane.wang@intel.com>

I'm not a fan of show_all() but this looks fine:

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   30 +++++++++----------
>   1 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> index cd86606..db54d79 100644
> --- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -84,21 +84,20 @@ class ImageConfigurationPage (HobPage):
>           for child in children:
>               self.remove(child)
>
> -    def _pack_components(self):
> +    def _pack_components(self, pack_config_build_button = False):
>           self._remove_all_widget()
>           self.pack_start(self.config_top_button, expand=False, fill=False)
>           self.pack_start(self.group_align, expand=True, fill=True)
>
>           self.box_group_area.pack_start(self.gtable, expand=True, fill=True)
> -        self.box_group_area.pack_end(self.config_build_button, expand=False, fill=False)
> +        if pack_config_build_button == True:
> +            self.box_group_area.pack_end(self.config_build_button, expand=False, fill=False)
>
>       def show_machine(self):
> -        self._pack_components()
> -        self.set_config_machine_layout()
> -        self.show_all()
>           self.progress_bar.reset()
> -        self.progress_bar.hide()
> -        self.config_build_button.hide_all()
> +        self._pack_components(pack_config_build_button = False)
> +        self.set_config_machine_layout(show_progress_bar = False)
> +        self.show_all()
>
>       def update_progress_bar(self, title, fraction, status=True):
>           self.progress_bar.update(fraction)
> @@ -106,18 +105,16 @@ class ImageConfigurationPage (HobPage):
>           self.progress_bar.set_rcstyle(status)
>
>       def show_info_populating(self):
> -        self._pack_components()
> -        self.set_config_machine_layout()
> +        self._pack_components(pack_config_build_button = False)
> +        self.set_config_machine_layout(show_progress_bar = True)
>           self.show_all()
> -        self.config_build_button.hide_all()
>
>       def show_info_populated(self):
> -        self._pack_components()
> -        self.set_config_machine_layout()
> +        self.progress_bar.reset()
> +        self._pack_components(pack_config_build_button = True)
> +        self.set_config_machine_layout(show_progress_bar = False)
>           self.set_config_baseimg_layout()
>           self.show_all()
> -        self.progress_bar.reset()
> -        self.progress_bar.hide()
>
>       def create_config_machine(self):
>           self.machine_title = gtk.Label()
> @@ -154,13 +151,14 @@ class ImageConfigurationPage (HobPage):
>           self.progress_bar = HobProgressBar()
>           self.machine_separator = gtk.HSeparator()
>
> -    def set_config_machine_layout(self):
> +    def set_config_machine_layout(self, show_progress_bar = False):
>           self.gtable.attach(self.machine_title, 0, 40, 0, 4)
>           self.gtable.attach(self.machine_title_desc, 0, 40, 4, 6)
>           self.gtable.attach(self.machine_combo, 0, 12, 6, 9)
>           self.gtable.attach(self.layer_button, 12, 36, 6, 10)
>           self.gtable.attach(self.layer_info_icon, 36, 40, 6, 9)
> -        self.gtable.attach(self.progress_bar, 0, 40, 13, 17)
> +        if show_progress_bar == True:
> +            self.gtable.attach(self.progress_bar, 0, 40, 13, 17)
>           self.gtable.attach(self.machine_separator, 0, 40, 12, 13)
>
>       def create_config_baseimg(self):

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


