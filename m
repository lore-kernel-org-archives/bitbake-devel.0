Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id D31FA61005
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2013 10:36:17 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 27 Sep 2013 03:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,991,1371106800"; d="scan'208";a="366383119"
Received: from cvoicu-vostro-460.rb.intel.com (HELO [10.237.105.65])
	([10.237.105.65])
	by azsmga001.ch.intel.com with ESMTP; 27 Sep 2013 03:36:18 -0700
Message-ID: <524560A0.8050307@intel.com>
Date: Fri, 27 Sep 2013 13:40:32 +0300
From: "cristiana.voicu" <cristiana.voicu@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130804 Thunderbird/17.0.8
MIME-Version: 1.0
To: Valentin Popa <valentin.popa@intel.com>
References: <1378817932-5304-1-git-send-email-valentin.popa@intel.com>
In-Reply-To: <1378817932-5304-1-git-send-email-valentin.popa@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] HOB: Busy cursor when saving configuration
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
X-List-Received-Date: Fri, 27 Sep 2013 10:36:18 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2013 03:58 PM, Valentin Popa wrote:
> Display a busy cursor while the configuration is saved.
>
> [YOCTO #4846]
> Signed-off-by: Valentin Popa <valentin.popa@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/builder.py                |  8 ++++++++
>   bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py | 10 ++++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 86fdbfe..8292813 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -31,6 +31,7 @@ import re
>   import logging
>   import sys
>   import signal
> +import time
>   from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
>   from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
>   from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
> @@ -1466,3 +1467,10 @@ class Builder(gtk.Window):
>   
>       def get_topdir(self):
>           return self.handler.get_topdir()
> +
> +    def wait(self, delay):
> +        time_start = time.time()
> +        time_end = time_start + delay
> +        while time_end > time.time():
> +            while gtk.events_pending():
> +                gtk.main_iteration()
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> index 3babc8e..79709d0 100644
> --- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -300,7 +300,12 @@ class ImageConfigurationPage (HobPage):
>       def view_warnings_button_clicked_cb(self, button):
>           self.builder.show_warning_dialog()
>   
> +    def machine_combo_changed_idle_cb(self):
> +        self.builder.window.set_cursor(None)
> +
>       def machine_combo_changed_cb(self, machine_combo):
> +        self.builder.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
> +        self.builder.wait(0.1) #wait for combo and cursor to update
>           self.stopping = False
>           self.builder.parsing_warnings = []
>           combo_item = machine_combo.get_active_text()
> @@ -324,6 +329,8 @@ class ImageConfigurationPage (HobPage):
>           # Do reparse recipes
>           self.builder.populate_recipe_package_info_async()
>   
> +        glib.idle_add(self.machine_combo_changed_idle_cb)
> +
>       def update_machine_combo(self):
>           self.disable_warnings_bar()
>           all_machines = [self.__dummy_machine__] + self.builder.parameters.all_machines
> @@ -527,7 +534,10 @@ class ImageConfigurationPage (HobPage):
>           if not response:
>               return
>           if settings_changed:
> +            self.builder.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
> +            self.builder.wait(0.1) #wait for adv_settings_dialog to terminate
>               self.builder.reparse_post_adv_settings()
> +            self.builder.window.set_cursor(None)
>   
>       def just_bake_button_clicked_cb(self, button):
>           self.builder.parsing_warnings = []
Hi Richard,
I think this patch was forgotten. Can you please merge it?
Thanks!

