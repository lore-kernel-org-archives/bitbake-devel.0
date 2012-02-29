Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDe-0003MQ-JW
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:37:55 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979729"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:24 -0800
Message-ID: <4F4E98B4.70303@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:24 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<0e99d291a8d3e9ad49ba82d5c30591322e958511.1330523904.git.shane.wang@intel.com>
In-Reply-To: <0e99d291a8d3e9ad49ba82d5c30591322e958511.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 28/32] Hob: allow users to setup the proxy
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
X-List-Received-Date: Wed, 29 Feb 2012 21:37:55 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 06:15, Shane Wang wrote:
> This patch is to set os.environ to allow users to set the environment variables for http_proxy, https_proxy and ftp_proxy.

I think this needs more work, I have a text entry with an attached 
button that spawns a file chooser. What file would I choose here?

What about if my http, ftp and socks proxy are different?

Cheers,
Joshua

> Signed-off-by: Shane Wang<shane.wang@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/builder.py |   23 +++++++++++++++++++++++
>   bitbake/lib/bb/ui/crumbs/hig.py     |   26 +++++++++++++++++++++++++-
>   2 files changed, 48 insertions(+), 1 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 0d7f1c1..e9853f2 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -116,6 +116,7 @@ class Configuration:
>
>   class Parameters:
>       '''Represents other variables like available machines, etc.'''
> +    __dummy_proxy__ = "myproxy.example.com:8010"
>
>       def __init__(self, params):
>           # Variables
> @@ -129,6 +130,8 @@ class Parameters:
>           self.image_names = []
>           self.image_addr = params["image_addr"]
>           self.image_types = params["image_types"].split()
> +        self.proxy = self.__dummy_proxy__
> +        self.enable_proxy = False
>
>   class Builder(gtk.Window):
>
> @@ -727,6 +730,19 @@ class Builder(gtk.Window):
>
>           dialog.destroy()
>
> +    def _setup_proxy(self):
> +        if self.parameters.proxy == Parameters.__dummy_proxy__ or self.parameters.proxy.lstrip() == "":
> +            if "http_proxy" in os.environ.keys():
> +                del os.environ["http_proxy"]
> +            if "https_proxy" in os.environ.keys():
> +                del os.environ["https_proxy"]
> +            if "ftp_proxy" in os.environ.keys():
> +                del os.environ["ftp_proxy"]
> +        else:
> +            os.environ["http_proxy"] = self.parameters.proxy
> +            os.environ["https_proxy"] = self.parameters.proxy
> +            os.environ["ftp_proxy"] = self.parameters.proxy
> +
>       def show_adv_settings_dialog(self):
>           dialog = AdvancedSettingDialog(title = "Settings",
>               configuration = copy.deepcopy(self.configuration),
> @@ -735,6 +751,8 @@ class Builder(gtk.Window):
>               all_distros = self.parameters.all_distros,
>               all_sdk_machines = self.parameters.all_sdk_machines,
>               max_threads = self.parameters.max_threads,
> +            proxy = self.parameters.proxy,
> +            enable_proxy = self.parameters.enable_proxy,
>               split_model = self.get_split_model(),
>               parent = self,
>               flags = gtk.DIALOG_MODAL
> @@ -745,6 +763,11 @@ class Builder(gtk.Window):
>           response = dialog.run()
>           if response == gtk.RESPONSE_YES:
>               self.configuration = dialog.configuration
> +            # setup the proxy
> +            self.parameters.enable_proxy = dialog.enable_proxy
> +            if self.parameters.enable_proxy == True:
> +                self.parameters.proxy = dialog.proxy
> +                self._setup_proxy()
>               # DO reparse recipes
>               if dialog.settings_changed:
>                   if self.configuration.curr_mach == "":
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
> index 20585b7..7e1c1ff 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -428,7 +428,7 @@ class AdvancedSettingDialog (CrumbsDialog):
>
>       def __init__(self, title, configuration, all_image_types,
>               all_package_formats, all_distros, all_sdk_machines,
> -            max_threads, split_model, parent, flags, buttons):
> +            max_threads, proxy, enable_proxy, split_model, parent, flags, buttons):
>           super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
>
>           # class members from other objects
> @@ -439,6 +439,8 @@ class AdvancedSettingDialog (CrumbsDialog):
>           self.all_distros = all_distros
>           self.all_sdk_machines = all_sdk_machines
>           self.max_threads = max_threads
> +        self.enable_proxy = enable_proxy
> +        self.proxy = proxy
>           self.split_model = split_model
>
>           # class members for internal use
> @@ -614,6 +616,21 @@ class AdvancedSettingDialog (CrumbsDialog):
>           sub_vbox.pack_start(label, expand=False, fill=False)
>           sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
>
> +        sub_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> +        self.proxy_checkbox = gtk.CheckButton("Enable Proxy")
> +        self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
> +        self.proxy_checkbox.set_active(self.enable_proxy)
> +        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
> +        label = self.gen_label_widget("<span weight=\"bold\">Select Proxy:</span>")
> +        tooltip = "Select the proxy that will be used in do_fetch() source code"
> +        proxy_widget, self.proxy_text = self.gen_entry_widget(self.split_model, self.proxy, self, tooltip)
> +        self.proxy_text.set_editable(self.enable_proxy)
> +        self.proxy_text.set_sensitive(self.enable_proxy)
> +        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
> +        sub_vbox.pack_start(label, expand=False, fill=False)
> +        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> +
>           return advanced_vbox
>
>       def create_others_page(self):
> @@ -630,6 +647,11 @@ class AdvancedSettingDialog (CrumbsDialog):
>
>           return advanced_vbox
>
> +    def proxy_checkbox_toggled_cb(self, button):
> +        self.enable_proxy = self.proxy_checkbox.get_active()
> +        self.proxy_text.set_editable(self.enable_proxy)
> +        self.proxy_text.set_sensitive(self.enable_proxy)
> +
>       def response_cb(self, dialog, response_id):
>           self.variables = {}
>
> @@ -679,6 +701,8 @@ class AdvancedSettingDialog (CrumbsDialog):
>               self.variables[key] = value
>               it = self.setting_store.iter_next(it)
>
> +        self.proxy = self.proxy_text.get_text()
> +
>           md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
>           self.settings_changed = (self.md5 != md5)
>

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


