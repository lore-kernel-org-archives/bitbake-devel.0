Received: from mga10.intel.com ([192.55.52.92] helo=fmsmga102.fm.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1T9e6X-0004bM-Ow
	for bitbake-devel@lists.openembedded.org;
	Thu, 06 Sep 2012 17:34:54 +0200
Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by mga11.intel.com with ESMTP/TLS/RC4-SHA; 06 Sep 2012 08:21:22 -0700
Received: by qadc11 with SMTP id c11so7016392qad.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Sep 2012 08:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type:x-gm-message-state;
	bh=/uxDwrm4bxWaY8e9VD+LrFTm/hIftot8f2Qy9tQnVTM=;
	b=R8RrYr16WXfOa0pP5Ok8vPO0NqGcj149MLXw4vQk5xh/G1IZaEfeqILGzRQ+eKeBzi
	EiaD0HNci0eK1ZVKM4xG0k/2QtyUafrM+0CvVp2R5a1QjEkoZ1xOVx/kjkDOc9fjri3A
	l439OS3f123StBvTEg/q0ascJZ9dk+WBxW3IP1wN8jtUgGQP2x2O9YIqFJMr1UikMRUM
	452D9NimWKHGmgvvAwtrwpu6bvZSE9K6PRSfeLBF3pYSr6x2qjUlfPIkV9miCkN+o0DZ
	GloIVLKy2hv06ei3SzKju4lf8VVSg7bElEvKMHSKAHNO9+qeJwaYVMaCEmYO7tbG7UiR
	i6XA==
Received: by 10.224.45.4 with SMTP id c4mr4617878qaf.29.1346944881743; Thu, 06
	Sep 2012 08:21:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.49.74.74 with HTTP; Thu, 6 Sep 2012 08:21:01 -0700 (PDT)
In-Reply-To: <1346683014-2845-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1346683014-2845-1-git-send-email-bogdan.a.marinescu@intel.com>
From: "Marinescu, Bogdan A" <bogdan.a.marinescu@intel.com>
Date: Thu, 6 Sep 2012 18:21:01 +0300
Message-ID: <CAMZjud2Jk99-wntGzk4Fr-_1Db7kmhkAjx7t2LzLZ=bvD9TvNg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQmmzmhmJHBAg49JoMO8lkEEroC8j1tLRqMxCQEV91yhzq1icg2eHIx6s3SilObBn3QXxwjZ
X-Mailman-Approved-At: Sat, 08 Sep 2012 13:03:29 +0200
Subject: Re: [PATCH] Implement 'settings' dialog as designed
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
X-List-Received-Date: Thu, 06 Sep 2012 15:34:54 -0000
Content-Type: multipart/alternative; boundary=20cf3074b38635559b04c90a0b04

--20cf3074b38635559b04c90a0b04
Content-Type: text/plain; charset=ISO-8859-1

Sorry for the double post. The two patches in my messages are exactly the
same.

Thanks,
Bogdan

On Mon, Sep 3, 2012 at 5:36 PM, Bogdan Marinescu <
bogdan.a.marinescu@intel.com> wrote:

> From: Valentin Popa <valentin.popa@intel.com>
>
> [YOCTO #2162]
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py                |   34 +-
>  bitbake/lib/bb/ui/crumbs/hig.py                    |  664
> ++++++++++++--------
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   23 +-
>  3 files changed, 435 insertions(+), 286 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py
> b/bitbake/lib/bb/ui/crumbs/builder.py
> index 7de4798..e3bc9df 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -36,8 +36,8 @@ from bb.ui.crumbs.builddetailspage import
> BuildDetailsPage
>  from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
>  from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton, hcc
>  from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
> -                             AdvancedSettingDialog, LayerSelectionDialog,
> \
> -                             DeployImageDialog
> +                             AdvancedSettingDialog, SimpleSettingsDialog,
> \
> +                             LayerSelectionDialog, DeployImageDialog
>  from bb.ui.crumbs.persistenttooltip import PersistentTooltip
>  import bb.ui.crumbs.utils
>
> @@ -793,6 +793,7 @@ class Builder(gtk.Window):
>
>  self.image_configuration_page.layer_button.set_sensitive(sensitive)
>
>  self.image_configuration_page.layer_info_icon.set_sensitive(sensitive)
>          self.image_configuration_page.toolbar.set_sensitive(sensitive)
> +
>  self.image_configuration_page.view_adv_configuration_button.set_sensitive(sensitive)
>
>  self.image_configuration_page.config_build_button.set_sensitive(sensitive)
>
>          self.recipe_details_page.set_sensitive(sensitive)
> @@ -1141,7 +1142,32 @@ class Builder(gtk.Window):
>          dialog.destroy()
>
>      def show_adv_settings_dialog(self):
> -        dialog = AdvancedSettingDialog(title = "Settings",
> +        dialog = AdvancedSettingDialog(title = "Advanced configuration",
> +            configuration = copy.deepcopy(self.configuration),
> +            all_image_types = self.parameters.image_types,
> +            all_package_formats = self.parameters.all_package_formats,
> +            all_distros = self.parameters.all_distros,
> +            all_sdk_machines = self.parameters.all_sdk_machines,
> +            max_threads = self.parameters.max_threads,
> +            parent = self,
> +            flags = gtk.DIALOG_MODAL
> +                    | gtk.DIALOG_DESTROY_WITH_PARENT
> +                    | gtk.DIALOG_NO_SEPARATOR)
> +        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
> +        HobAltButton.style_button(button)
> +        button = dialog.add_button("Save", gtk.RESPONSE_YES)
> +        HobButton.style_button(button)
> +        response = dialog.run()
> +        settings_changed = False
> +        if response == gtk.RESPONSE_YES:
> +            self.configuration = dialog.configuration
> +            self.save_defaults() # remember settings
> +            settings_changed = dialog.settings_changed
> +        dialog.destroy()
> +        return response == gtk.RESPONSE_YES, settings_changed
> +
> +    def show_simple_settings_dialog(self):
> +        dialog = SimpleSettingsDialog(title = "Settings",
>              configuration = copy.deepcopy(self.configuration),
>              all_image_types = self.parameters.image_types,
>              all_package_formats = self.parameters.all_package_formats,
> @@ -1334,4 +1360,4 @@ class Builder(gtk.Window):
>              format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
>              self.consolelog.setFormatter(format)
>
> -            self.logger.addHandler(self.consolelog)
> \ No newline at end of file
> +            self.logger.addHandler(self.consolelog)
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py
> b/bitbake/lib/bb/ui/crumbs/hig.py
> index 2001ff4..2c77bf7 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -41,6 +41,88 @@ BitBake GUI's
>  In summary: spacing = 12px, border-width = 6px
>  """
>
> +
> +class SettingsUIHelper():
> +
> +    def gen_label_widget(self, content):
> +        label = gtk.Label()
> +        label.set_alignment(0, 0)
> +        label.set_markup(content)
> +        label.show()
> +        return label
> +
> +    def gen_spinner_widget(self, content, lower, upper, tooltip=""):
> +        hbox = gtk.HBox(False, 12)
> +        adjust = gtk.Adjustment(value=content, lower=lower, upper=upper,
> step_incr=1)
> +        spinner = gtk.SpinButton(adjustment=adjust, climb_rate=1,
> digits=0)
> +
> +        spinner.set_value(content)
> +        hbox.pack_start(spinner, expand=False, fill=False)
> +
> +        info = HobInfoButton(tooltip, self)
> +        hbox.pack_start(info, expand=False, fill=False)
> +
> +        hbox.show_all()
> +        return hbox, spinner
> +
> +    def gen_combo_widget(self, curr_item, all_item, tooltip=""):
> +        hbox = gtk.HBox(False, 12)
> +        combo = gtk.combo_box_new_text()
> +        hbox.pack_start(combo, expand=False, fill=False)
> +
> +        index = 0
> +        for item in all_item or []:
> +            combo.append_text(item)
> +            if item == curr_item:
> +                combo.set_active(index)
> +            index += 1
> +
> +        info = HobInfoButton(tooltip, self)
> +        hbox.pack_start(info, expand=False, fill=False)
> +
> +        hbox.show_all()
> +        return hbox, combo
> +
> +    def entry_widget_select_path_cb(self, action, parent, entry):
> +        dialog = gtk.FileChooserDialog("", parent,
> +
> gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
> +        text = entry.get_text()
> +        dialog.set_current_folder(text if len(text) > 0 else os.getcwd())
> +        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
> +        HobAltButton.style_button(button)
> +        button = dialog.add_button("Open", gtk.RESPONSE_YES)
> +        HobButton.style_button(button)
> +        response = dialog.run()
> +        if response == gtk.RESPONSE_YES:
> +            path = dialog.get_filename()
> +            entry.set_text(path)
> +
> +        dialog.destroy()
> +
> +    def gen_entry_widget(self, content, parent, tooltip="",
> need_button=True):
> +        hbox = gtk.HBox(False, 12)
> +        entry = gtk.Entry()
> +        entry.set_text(content)
> +
> +        if need_button:
> +            table = gtk.Table(1, 10, True)
> +            hbox.pack_start(table, expand=True, fill=True)
> +            table.attach(entry, 0, 9, 0, 1)
> +            image = gtk.Image()
> +            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
> +            open_button = gtk.Button()
> +            open_button.set_image(image)
> +            open_button.connect("clicked",
> self.entry_widget_select_path_cb, parent, entry)
> +            table.attach(open_button, 9, 10, 0, 1)
> +        else:
> +            hbox.pack_start(entry, expand=True, fill=True)
> +
> +        info = HobInfoButton(tooltip, self)
> +        hbox.pack_start(info, expand=False, fill=False)
> +
> +        hbox.show_all()
> +        return hbox, entry
> +
>  #
>  # CrumbsDialog
>  #
> @@ -94,89 +176,309 @@ class CrumbsMessageDialog(CrumbsDialog):
>          first_row.add(self.label)
>
>  #
> -# AdvancedSettings Dialog
> +# SimpleSettings Dialog
>  #
> -class AdvancedSettingDialog (CrumbsDialog):
> +class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
>
> -    def gen_label_widget(self, content):
> -        label = gtk.Label()
> -        label.set_alignment(0, 0)
> -        label.set_markup(content)
> -        label.show()
> -        return label
> +    def __init__(self, title, configuration, all_image_types,
> +            all_package_formats, all_distros, all_sdk_machines,
> +            max_threads, parent, flags, buttons=None):
> +        super(SimpleSettingsDialog, self).__init__(title, parent, flags,
> buttons)
>
> -    def gen_spinner_widget(self, content, lower, upper, tooltip=""):
> +        # class members from other objects
> +        # bitbake settings from Builder.Configuration
> +        self.configuration = configuration
> +        self.image_types = all_image_types
> +        self.all_package_formats = all_package_formats
> +        self.all_distros = all_distros
> +        self.all_sdk_machines = all_sdk_machines
> +        self.max_threads = max_threads
> +
> +        # class members for internal use
> +        self.distro_combo = None
> +        self.dldir_text = None
> +        self.sstatedir_text = None
> +        self.sstatemirror_text = None
> +        self.bb_spinner = None
> +        self.pmake_spinner = None
> +        self.rootfs_size_spinner = None
> +        self.extra_size_spinner = None
> +        self.gplv3_checkbox = None
> +        self.toolchain_checkbox = None
> +        self.setting_store = None
> +        self.image_types_checkbuttons = {}
> +
> +        self.md5 = self.config_md5()
> +        self.settings_changed = False
> +
> +        # create visual elements on the dialog
> +        self.create_visual_elements()
> +        self.connect("response", self.response_cb)
> +
> +    def _get_sorted_value(self, var):
> +        return " ".join(sorted(str(var).split())) + "\n"
> +
> +    def config_md5(self):
> +        data = ""
> +        data += ("PACKAGE_CLASSES: "      +
> self.configuration.curr_package_format + '\n')
> +        data += ("DISTRO: "               +
> self._get_sorted_value(self.configuration.curr_distro))
> +        data += ("IMAGE_ROOTFS_SIZE: "    +
> self._get_sorted_value(self.configuration.image_rootfs_size))
> +        data += ("IMAGE_EXTRA_SIZE: "     +
> self._get_sorted_value(self.configuration.image_extra_size))
> +        data += ("INCOMPATIBLE_LICENSE: " +
> self._get_sorted_value(self.configuration.incompat_license))
> +        data += ("SDK_MACHINE: "          +
> self._get_sorted_value(self.configuration.curr_sdk_machine))
> +        data += ("TOOLCHAIN_BUILD: "      +
> self._get_sorted_value(self.configuration.toolchain_build))
> +        data += ("IMAGE_FSTYPES: "        +
> self._get_sorted_value(self.configuration.image_fstypes))
> +        data += ("ENABLE_PROXY: "         +
> self._get_sorted_value(self.configuration.enable_proxy))
> +        if self.configuration.enable_proxy:
> +            for protocol in self.configuration.proxies.keys():
> +                data += (protocol + ": " +
> self._get_sorted_value(self.configuration.combine_proxy(protocol)))
> +        for key in self.configuration.extra_setting.keys():
> +            data += (key + ": " +
> self._get_sorted_value(self.configuration.extra_setting[key]))
> +        return hashlib.md5(data).hexdigest()
> +
> +    def details_cb(self, button, parent, protocol):
> +        dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy
> Details",
> +            user = self.configuration.proxies[protocol][1],
> +            passwd = self.configuration.proxies[protocol][2],
> +            parent = parent,
> +            flags = gtk.DIALOG_MODAL
> +                    | gtk.DIALOG_DESTROY_WITH_PARENT
> +                    | gtk.DIALOG_NO_SEPARATOR)
> +        dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
> +        response = dialog.run()
> +        if response == gtk.RESPONSE_OK:
> +            self.configuration.proxies[protocol][1] = dialog.user
> +            self.configuration.proxies[protocol][2] = dialog.passwd
> +            self.refresh_proxy_components()
> +        dialog.destroy()
> +
> +    def gen_proxy_entry_widget(self, protocol, parent, need_button=True):
>          hbox = gtk.HBox(False, 12)
> -        adjust = gtk.Adjustment(value=content, lower=lower, upper=upper,
> step_incr=1)
> -        spinner = gtk.SpinButton(adjustment=adjust, climb_rate=1,
> digits=0)
>
> -        spinner.set_value(content)
> -        hbox.pack_start(spinner, expand=False, fill=False)
> +        label = gtk.Label(protocol.upper() + " proxy")
> +        hbox.pack_start(label, expand=True, fill=False, padding=24)
>
> -        info = HobInfoButton(tooltip, self)
> -        hbox.pack_start(info, expand=False, fill=False)
> +        proxy_entry = gtk.Entry()
> +        proxy_entry.set_size_request(300, -1)
> +        hbox.pack_start(proxy_entry, expand=False, fill=False)
> +
> +        hbox.pack_start(gtk.Label(":"), expand=False, fill=False)
> +
> +        port_entry = gtk.Entry()
> +        port_entry.set_size_request(60, -1)
> +        hbox.pack_start(port_entry, expand=False, fill=False)
> +
> +        details_button = HobAltButton("Details")
> +        details_button.connect("clicked", self.details_cb, parent,
> protocol)
> +        hbox.pack_start(details_button, expand=False, fill=False)
>
>          hbox.show_all()
> -        return hbox, spinner
> +        return hbox, proxy_entry, port_entry, details_button
>
> -    def gen_combo_widget(self, curr_item, all_item, tooltip=""):
> -        hbox = gtk.HBox(False, 12)
> -        combo = gtk.combo_box_new_text()
> -        hbox.pack_start(combo, expand=False, fill=False)
> +    def refresh_proxy_components(self):
> +        self.same_checkbox.set_sensitive(self.configuration.enable_proxy)
>
> -        index = 0
> -        for item in all_item or []:
> -            combo.append_text(item)
> -            if item == curr_item:
> -                combo.set_active(index)
> -            index += 1
> +
>  self.http_proxy.set_text(self.configuration.combine_host_only("http"))
> +        self.http_proxy.set_editable(self.configuration.enable_proxy)
> +        self.http_proxy.set_sensitive(self.configuration.enable_proxy)
> +
>  self.http_proxy_port.set_text(self.configuration.combine_port_only("http"))
> +        self.http_proxy_port.set_editable(self.configuration.enable_proxy)
> +
>  self.http_proxy_port.set_sensitive(self.configuration.enable_proxy)
> +
>  self.http_proxy_details.set_sensitive(self.configuration.enable_proxy)
> +
> +
>  self.https_proxy.set_text(self.configuration.combine_host_only("https"))
> +        self.https_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +        self.https_proxy.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> +
>  self.https_proxy_port.set_text(self.configuration.combine_port_only("https"))
> +
>  self.https_proxy_port.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
>  self.https_proxy_port.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
>  self.https_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
> +
>  self.ftp_proxy.set_text(self.configuration.combine_host_only("ftp"))
> +        self.ftp_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +        self.ftp_proxy.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
>  self.ftp_proxy_port.set_text(self.configuration.combine_port_only("ftp"))
> +        self.ftp_proxy_port.set_editable(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> +        self.ftp_proxy_port.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> +
>  self.ftp_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
> +
>  self.git_proxy.set_text(self.configuration.combine_host_only("git"))
> +        self.git_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +        self.git_proxy.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
>  self.git_proxy_port.set_text(self.configuration.combine_port_only("git"))
> +        self.git_proxy_port.set_editable(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> +        self.git_proxy_port.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> +
>  self.git_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
> +
>  self.cvs_proxy.set_text(self.configuration.combine_host_only("cvs"))
> +        self.cvs_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +        self.cvs_proxy.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> +
>  self.cvs_proxy_port.set_text(self.configuration.combine_port_only("cvs"))
> +        self.cvs_proxy_port.set_editable(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> +        self.cvs_proxy_port.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> +
>  self.cvs_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
>
> +    def proxy_checkbox_toggled_cb(self, button):
> +        self.configuration.enable_proxy = self.proxy_checkbox.get_active()
> +        if not self.configuration.enable_proxy:
> +            self.configuration.same_proxy = False
> +            self.same_checkbox.set_active(self.configuration.same_proxy)
> +        self.refresh_proxy_components()
> +
> +    def same_checkbox_toggled_cb(self, button):
> +        self.configuration.same_proxy = self.same_checkbox.get_active()
> +        self.refresh_proxy_components()
> +
> +    def response_cb(self, dialog, response_id):
> +        #self.configuration.curr_distro =
> self.distro_combo.get_active_text()
> +        self.configuration.dldir = self.dldir_text.get_text()
> +        self.configuration.sstatedir = self.sstatedir_text.get_text()
> +        self.configuration.sstatemirror =
> self.sstatemirror_text.get_text()
> +        self.configuration.bbthread = self.bb_spinner.get_value_as_int()
> +        self.configuration.pmake = self.pmake_spinner.get_value_as_int()
> +
> +        self.configuration.split_proxy("http", self.http_proxy.get_text()
> + ":" + self.http_proxy_port.get_text())
> +        if self.configuration.same_proxy:
> +            self.configuration.split_proxy("https",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> +            self.configuration.split_proxy("ftp",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> +            self.configuration.split_proxy("git",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> +            self.configuration.split_proxy("cvs",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> +        else:
> +            self.configuration.split_proxy("https",
> self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
> +            self.configuration.split_proxy("ftp",
> self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
> +            self.configuration.split_proxy("git",
> self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
> +            self.configuration.split_proxy("cvs",
> self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
> +
> +        md5 = self.config_md5()
> +        self.settings_changed = (self.md5 != md5)
> +
> +    def create_build_environment_page(self):
> +        advanced_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.set_border_width(6)
> +
> +        sub_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> +        label = self.gen_label_widget("<span weight=\"bold\">BB number
> threads:</span>")
> +        tooltip = "Sets the number of threads that BitBake tasks can
> simultaneously run. See the <a href=\""
> +        tooltip += "
> http://www.yoctoproject.org/docs/current/poky-ref-manual/"
> +        tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky
> reference manual</a> for information"
> +        bbthread_widget, self.bb_spinner =
> self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads,
> tooltip)
> +        sub_vbox.pack_start(label, expand=False, fill=False)
> +        sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
> +
> +        sub_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> +        label = self.gen_label_widget("<span weight=\"bold\">Parallel
> make:</span>")
> +        tooltip = "Sets the maximum number of threads the host can use
> during the build. See the <a href=\""
> +        tooltip += "
> http://www.yoctoproject.org/docs/current/poky-ref-manual/"
> +        tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky
> reference manual</a> for information"
> +        pmake_widget, self.pmake_spinner =
> self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads,
> tooltip)
> +        sub_vbox.pack_start(label, expand=False, fill=False)
> +        sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
> +
> +        sub_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> +        label = self.gen_label_widget("<span weight=\"bold\">Select
> download directory:</span>")
> +        tooltip = "Select a folder that caches the upstream project
> source code"
> +        dldir_widget, self.dldir_text =
> self.gen_entry_widget(self.configuration.dldir, self, tooltip)
> +        sub_vbox.pack_start(label, expand=False, fill=False)
> +        sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
> +
> +        sub_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> +        label = self.gen_label_widget("<span weight=\"bold\">Select
> SSTATE directory:</span>")
> +        tooltip = "Select a folder that caches your prebuilt results"
> +        sstatedir_widget, self.sstatedir_text =
> self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
> +        sub_vbox.pack_start(label, expand=False, fill=False)
> +        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
> +
> +        sub_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> +        label = self.gen_label_widget("<span weight=\"bold\">Select
> SSTATE mirror:</span>")
> +        tooltip = "Select the pre-built mirror that will speed your build"
> +        sstatemirror_widget, self.sstatemirror_text =
> self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
> +        sub_vbox.pack_start(label, expand=False, fill=False)
> +        sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
> +
> +        return advanced_vbox
> +
> +    def create_proxy_page(self):
> +        advanced_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.set_border_width(6)
> +
> +        sub_vbox = gtk.VBox(False, 6)
> +        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> +        label = self.gen_label_widget("<span weight=\"bold\">Set the
> proxies that will be used during fetching source code</span>")
> +        tooltip = "Set the proxies that will be used during fetching
> source code or set none for direct the Internet connection"
>          info = HobInfoButton(tooltip, self)
> +        hbox = gtk.HBox(False, 12)
> +        hbox.pack_start(label, expand=True, fill=True)
>          hbox.pack_start(info, expand=False, fill=False)
> +        sub_vbox.pack_start(hbox, expand=False, fill=False)
>
> -        hbox.show_all()
> -        return hbox, combo
> +        self.direct_checkbox = gtk.RadioButton(None, "Direct internet
> connection")
> +        self.direct_checkbox.set_tooltip_text("Check this box to connect
> the Internet directly without any proxy")
> +        self.direct_checkbox.set_active(not
> self.configuration.enable_proxy)
> +        sub_vbox.pack_start(self.direct_checkbox, expand=False,
> fill=False)
>
> -    def entry_widget_select_path_cb(self, action, parent, entry):
> -        dialog = gtk.FileChooserDialog("", parent,
> -
> gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
> -        text = entry.get_text()
> -        dialog.set_current_folder(text if len(text) > 0 else os.getcwd())
> -        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
> -        HobAltButton.style_button(button)
> -        button = dialog.add_button("Open", gtk.RESPONSE_YES)
> -        HobButton.style_button(button)
> -        response = dialog.run()
> -        if response == gtk.RESPONSE_YES:
> -            path = dialog.get_filename()
> -            entry.set_text(path)
> +        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox,
> "Manual proxy configuration")
> +        self.proxy_checkbox.set_tooltip_text("Check this box to setup the
> proxy you specified")
> +        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
> +        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
> +
> +        self.same_checkbox = gtk.CheckButton("Use the same proxy for all
> protocols")
> +        self.same_checkbox.set_tooltip_text("Use the same proxy as the
> first proxy i.e. http proxy for all protocols")
> +        self.same_checkbox.set_active(self.configuration.same_proxy)
> +        hbox = gtk.HBox(False, 12)
> +        hbox.pack_start(self.same_checkbox, expand=False, fill=False,
> padding=24)
> +        sub_vbox.pack_start(hbox, expand=False, fill=False)
> +
> +        proxy_widget, self.http_proxy, self.http_proxy_port,
> self.http_proxy_details = self.gen_proxy_entry_widget(
> +            "http", self, True)
> +        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> +
> +        proxy_widget, self.https_proxy, self.https_proxy_port,
> self.https_proxy_details = self.gen_proxy_entry_widget(
> +            "https", self, True)
> +        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> +
> +        proxy_widget, self.ftp_proxy, self.ftp_proxy_port,
> self.ftp_proxy_details = self.gen_proxy_entry_widget(
> +            "ftp", self, True)
> +        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> +
> +        proxy_widget, self.git_proxy, self.git_proxy_port,
> self.git_proxy_details = self.gen_proxy_entry_widget(
> +            "git", self, True)
> +        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> +
> +        proxy_widget, self.cvs_proxy, self.cvs_proxy_port,
> self.cvs_proxy_details = self.gen_proxy_entry_widget(
> +            "cvs", self, True)
> +        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
>
> -        dialog.destroy()
> +        self.direct_checkbox.connect("toggled",
> self.proxy_checkbox_toggled_cb)
> +        self.proxy_checkbox.connect("toggled",
> self.proxy_checkbox_toggled_cb)
> +        self.same_checkbox.connect("toggled",
> self.same_checkbox_toggled_cb)
>
> -    def gen_entry_widget(self, content, parent, tooltip="",
> need_button=True):
> -        hbox = gtk.HBox(False, 12)
> -        entry = gtk.Entry()
> -        entry.set_text(content)
> +        self.refresh_proxy_components()
> +        return advanced_vbox
>
> -        if need_button:
> -            table = gtk.Table(1, 10, True)
> -            hbox.pack_start(table, expand=True, fill=True)
> -            table.attach(entry, 0, 9, 0, 1)
> -            image = gtk.Image()
> -            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
> -            open_button = gtk.Button()
> -            open_button.set_image(image)
> -            open_button.connect("clicked",
> self.entry_widget_select_path_cb, parent, entry)
> -            table.attach(open_button, 9, 10, 0, 1)
> -        else:
> -            hbox.pack_start(entry, expand=True, fill=True)
>
> -        info = HobInfoButton(tooltip, self)
> -        hbox.pack_start(info, expand=False, fill=False)
> +    def create_visual_elements(self):
> +        self.nb = gtk.Notebook()
> +        self.nb.set_show_tabs(True)
> +        self.nb.append_page(self.create_build_environment_page(),
> gtk.Label("Build environment"))
> +        self.nb.append_page(self.create_proxy_page(),
> gtk.Label("Proxies"))
> +        self.nb.set_current_page(0)
> +        self.vbox.pack_start(self.nb, expand=True, fill=True)
> +        self.vbox.pack_end(gtk.HSeparator(), expand=True, fill=True)
> +
> +        self.show_all()
>
> -        hbox.show_all()
> -        return hbox, entry
>
> +
> +#
> +# AdvancedSettings Dialog
> +#
> +class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
> +
>      def details_cb(self, button, parent, protocol):
>          dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy
> Details",
>              user = self.configuration.proxies[protocol][1],
> @@ -191,30 +493,7 @@ class AdvancedSettingDialog (CrumbsDialog):
>              self.configuration.proxies[protocol][1] = dialog.user
>              self.configuration.proxies[protocol][2] = dialog.passwd
>              self.refresh_proxy_components()
> -        dialog.destroy()
> -
> -    def gen_proxy_entry_widget(self, protocol, parent, need_button=True):
> -        hbox = gtk.HBox(False, 12)
> -
> -        label = gtk.Label(protocol.upper() + " proxy")
> -        hbox.pack_start(label, expand=True, fill=False, padding=24)
> -
> -        proxy_entry = gtk.Entry()
> -        proxy_entry.set_size_request(300, -1)
> -        hbox.pack_start(proxy_entry, expand=False, fill=False)
> -
> -        hbox.pack_start(gtk.Label(":"), expand=False, fill=False)
> -
> -        port_entry = gtk.Entry()
> -        port_entry.set_size_request(60, -1)
> -        hbox.pack_start(port_entry, expand=False, fill=False)
> -
> -        details_button = HobAltButton("Details")
> -        details_button.connect("clicked", self.details_cb, parent,
> protocol)
> -        hbox.pack_start(details_button, expand=False, fill=False)
> -
> -        hbox.show_all()
> -        return hbox, proxy_entry, port_entry, details_button
> +        dialog.destroy()
>
>      def rootfs_combo_changed_cb(self, rootfs_combo, all_package_format,
> check_hbox):
>          combo_item = self.rootfs_combo.get_active_text()
> @@ -412,8 +691,6 @@ class AdvancedSettingDialog (CrumbsDialog):
>          self.nb.set_show_tabs(True)
>          self.nb.append_page(self.create_image_types_page(),
> gtk.Label("Image types"))
>          self.nb.append_page(self.create_output_page(),
> gtk.Label("Output"))
> -        self.nb.append_page(self.create_build_environment_page(),
> gtk.Label("Build environment"))
> -        self.nb.append_page(self.create_proxy_page(),
> gtk.Label("Proxies"))
>          self.nb.append_page(self.create_others_page(),
> gtk.Label("Others"))
>          self.nb.set_current_page(0)
>          self.vbox.pack_start(self.nb, expand=True, fill=True)
> @@ -422,10 +699,22 @@ class AdvancedSettingDialog (CrumbsDialog):
>          self.show_all()
>
>      def create_image_types_page(self):
> +        main_vbox = gtk.VBox(False, 16)
> +        main_vbox.set_border_width(6)
> +
>          advanced_vbox = gtk.VBox(False, 6)
>          advanced_vbox.set_border_width(6)
>
> -        rows = (len(self.image_types)+1)/2
> +        distro_vbox = gtk.VBox(False, 6)
> +        label = self.gen_label_widget("<span
> weight=\"bold\">Distro:</span>")
> +        tooltip = "Selects the Yocto Project distribution you want"
> +        distro_widget, self.distro_combo =
> self.gen_combo_widget(self.configuration.curr_distro, self.all_distros,
> tooltip)
> +        distro_vbox.pack_start(label, expand=False, fill=False)
> +        distro_vbox.pack_start(distro_widget, expand=False, fill=False)
> +        main_vbox.pack_start(distro_vbox, expand=False, fill=False)
> +
> +
> +        rows = (len(self.image_types)+1)/3
>          table = gtk.Table(rows + 1, 10, True)
>          advanced_vbox.pack_start(table, expand=False, fill=False)
>
> @@ -451,7 +740,9 @@ class AdvancedSettingDialog (CrumbsDialog):
>                  i = 1
>                  j = j + 4
>
> -        return advanced_vbox
> +        main_vbox.pack_start(advanced_vbox, expand=False, fill=False)
> +
> +        return main_vbox
>
>      def create_output_page(self):
>          advanced_vbox = gtk.VBox(False, 6)
> @@ -503,122 +794,7 @@ class AdvancedSettingDialog (CrumbsDialog):
>
>          return advanced_vbox
>
> -    def create_build_environment_page(self):
> -        advanced_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.set_border_width(6)
> -
> -        sub_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> -        label = self.gen_label_widget("<span weight=\"bold\">Select
> distro:</span>")
> -        tooltip = "Selects the Yocto Project distribution you want"
> -        distro_widget, self.distro_combo =
> self.gen_combo_widget(self.configuration.curr_distro, self.all_distros,
> tooltip)
> -        sub_vbox.pack_start(label, expand=False, fill=False)
> -        sub_vbox.pack_start(distro_widget, expand=False, fill=False)
> -
> -        sub_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> -        label = self.gen_label_widget("<span weight=\"bold\">BB number
> threads:</span>")
> -        tooltip = "Sets the number of threads that BitBake tasks can
> simultaneously run. See the <a href=\""
> -        tooltip += "
> http://www.yoctoproject.org/docs/current/poky-ref-manual/"
> -        tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky
> reference manual</a> for information"
> -        bbthread_widget, self.bb_spinner =
> self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads,
> tooltip)
> -        sub_vbox.pack_start(label, expand=False, fill=False)
> -        sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
> -
> -        sub_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> -        label = self.gen_label_widget("<span weight=\"bold\">Parallel
> make:</span>")
> -        tooltip = "Sets the maximum number of threads the host can use
> during the build. See the <a href=\""
> -        tooltip += "
> http://www.yoctoproject.org/docs/current/poky-ref-manual/"
> -        tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky
> reference manual</a> for information"
> -        pmake_widget, self.pmake_spinner =
> self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads,
> tooltip)
> -        sub_vbox.pack_start(label, expand=False, fill=False)
> -        sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
> -
> -        sub_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> -        label = self.gen_label_widget("<span weight=\"bold\">Select
> download directory:</span>")
> -        tooltip = "Select a folder that caches the upstream project
> source code"
> -        dldir_widget, self.dldir_text =
> self.gen_entry_widget(self.configuration.dldir, self, tooltip)
> -        sub_vbox.pack_start(label, expand=False, fill=False)
> -        sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
> -
> -        sub_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> -        label = self.gen_label_widget("<span weight=\"bold\">Select
> SSTATE directory:</span>")
> -        tooltip = "Select a folder that caches your prebuilt results"
> -        sstatedir_widget, self.sstatedir_text =
> self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
> -        sub_vbox.pack_start(label, expand=False, fill=False)
> -        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
> -
> -        sub_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> -        label = self.gen_label_widget("<span weight=\"bold\">Select
> SSTATE mirror:</span>")
> -        tooltip = "Select the pre-built mirror that will speed your build"
> -        sstatemirror_widget, self.sstatemirror_text =
> self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
> -        sub_vbox.pack_start(label, expand=False, fill=False)
> -        sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
> -
> -        return advanced_vbox
> -
> -    def create_proxy_page(self):
> -        advanced_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.set_border_width(6)
> -
> -        sub_vbox = gtk.VBox(False, 6)
> -        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
> -        label = self.gen_label_widget("<span weight=\"bold\">Set the
> proxies that will be used during fetching source code</span>")
> -        tooltip = "Set the proxies that will be used during fetching
> source code or set none for direct the Internet connection"
> -        info = HobInfoButton(tooltip, self)
> -        hbox = gtk.HBox(False, 12)
> -        hbox.pack_start(label, expand=True, fill=True)
> -        hbox.pack_start(info, expand=False, fill=False)
> -        sub_vbox.pack_start(hbox, expand=False, fill=False)
> -
> -        self.direct_checkbox = gtk.RadioButton(None, "Direct internet
> connection")
> -        self.direct_checkbox.set_tooltip_text("Check this box to connect
> the Internet directly without any proxy")
> -        self.direct_checkbox.set_active(not
> self.configuration.enable_proxy)
> -        sub_vbox.pack_start(self.direct_checkbox, expand=False,
> fill=False)
> -
> -        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox,
> "Manual proxy configuration")
> -        self.proxy_checkbox.set_tooltip_text("Check this box to setup the
> proxy you specified")
> -        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
> -        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
> -
> -        self.same_checkbox = gtk.CheckButton("Use the same proxy for all
> protocols")
> -        self.same_checkbox.set_tooltip_text("Use the same proxy as the
> first proxy i.e. http proxy for all protocols")
> -        self.same_checkbox.set_active(self.configuration.same_proxy)
> -        hbox = gtk.HBox(False, 12)
> -        hbox.pack_start(self.same_checkbox, expand=False, fill=False,
> padding=24)
> -        sub_vbox.pack_start(hbox, expand=False, fill=False)
> -
> -        proxy_widget, self.http_proxy, self.http_proxy_port,
> self.http_proxy_details = self.gen_proxy_entry_widget(
> -            "http", self, True)
> -        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> -
> -        proxy_widget, self.https_proxy, self.https_proxy_port,
> self.https_proxy_details = self.gen_proxy_entry_widget(
> -            "https", self, True)
> -        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> -
> -        proxy_widget, self.ftp_proxy, self.ftp_proxy_port,
> self.ftp_proxy_details = self.gen_proxy_entry_widget(
> -            "ftp", self, True)
> -        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> -
> -        proxy_widget, self.git_proxy, self.git_proxy_port,
> self.git_proxy_details = self.gen_proxy_entry_widget(
> -            "git", self, True)
> -        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> -
> -        proxy_widget, self.cvs_proxy, self.cvs_proxy_port,
> self.cvs_proxy_details = self.gen_proxy_entry_widget(
> -            "cvs", self, True)
> -        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
> -
> -        self.direct_checkbox.connect("toggled",
> self.proxy_checkbox_toggled_cb)
> -        self.proxy_checkbox.connect("toggled",
> self.proxy_checkbox_toggled_cb)
> -        self.same_checkbox.connect("toggled",
> self.same_checkbox_toggled_cb)
> -
> -        self.refresh_proxy_components()
> -        return advanced_vbox
> -
> +
>      def create_others_page(self):
>          advanced_vbox = gtk.VBox(False, 6)
>          advanced_vbox.set_border_width(6)
> @@ -633,60 +809,7 @@ class AdvancedSettingDialog (CrumbsDialog):
>
>          return advanced_vbox
>
> -    def refresh_proxy_components(self):
> -        self.same_checkbox.set_sensitive(self.configuration.enable_proxy)
> -
> -
>  self.http_proxy.set_text(self.configuration.combine_host_only("http"))
> -        self.http_proxy.set_editable(self.configuration.enable_proxy)
> -        self.http_proxy.set_sensitive(self.configuration.enable_proxy)
> -
>  self.http_proxy_port.set_text(self.configuration.combine_port_only("http"))
> -        self.http_proxy_port.set_editable(self.configuration.enable_proxy)
> -
>  self.http_proxy_port.set_sensitive(self.configuration.enable_proxy)
> -
>  self.http_proxy_details.set_sensitive(self.configuration.enable_proxy)
> -
> -
>  self.https_proxy.set_text(self.configuration.combine_host_only("https"))
> -        self.https_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -        self.https_proxy.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> -
>  self.https_proxy_port.set_text(self.configuration.combine_port_only("https"))
> -
>  self.https_proxy_port.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
>  self.https_proxy_port.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
>  self.https_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
> -
>  self.ftp_proxy.set_text(self.configuration.combine_host_only("ftp"))
> -        self.ftp_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -        self.ftp_proxy.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
>  self.ftp_proxy_port.set_text(self.configuration.combine_port_only("ftp"))
> -        self.ftp_proxy_port.set_editable(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> -        self.ftp_proxy_port.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> -
>  self.ftp_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
> -
>  self.git_proxy.set_text(self.configuration.combine_host_only("git"))
> -        self.git_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -        self.git_proxy.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
>  self.git_proxy_port.set_text(self.configuration.combine_port_only("git"))
> -        self.git_proxy_port.set_editable(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> -        self.git_proxy_port.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> -
>  self.git_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
> -
>  self.cvs_proxy.set_text(self.configuration.combine_host_only("cvs"))
> -        self.cvs_proxy.set_editable(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -        self.cvs_proxy.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
>  self.cvs_proxy_port.set_text(self.configuration.combine_port_only("cvs"))
> -        self.cvs_proxy_port.set_editable(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> -        self.cvs_proxy_port.set_sensitive(self.configuration.enable_proxy
> and (not self.configuration.same_proxy))
> -
>  self.cvs_proxy_details.set_sensitive(self.configuration.enable_proxy and
> (not self.configuration.same_proxy))
> -
> -    def proxy_checkbox_toggled_cb(self, button):
> -        self.configuration.enable_proxy = self.proxy_checkbox.get_active()
> -        if not self.configuration.enable_proxy:
> -            self.configuration.same_proxy = False
> -            self.same_checkbox.set_active(self.configuration.same_proxy)
> -        self.refresh_proxy_components()
> -
> -    def same_checkbox_toggled_cb(self, button):
> -        self.configuration.same_proxy = self.same_checkbox.get_active()
> -        self.refresh_proxy_components()
> -
> +
>      def response_cb(self, dialog, response_id):
>          package_format = []
>          package_format.append(self.rootfs_combo.get_active_text())
> @@ -695,12 +818,7 @@ class AdvancedSettingDialog (CrumbsDialog):
>                  package_format.append(child.get_label())
>          self.configuration.curr_package_format = " ".join(package_format)
>
> -        self.configuration.curr_distro =
> self.distro_combo.get_active_text()
> -        self.configuration.dldir = self.dldir_text.get_text()
> -        self.configuration.sstatedir = self.sstatedir_text.get_text()
> -        self.configuration.sstatemirror =
> self.sstatemirror_text.get_text()
> -        self.configuration.bbthread = self.bb_spinner.get_value_as_int()
> -        self.configuration.pmake = self.pmake_spinner.get_value_as_int()
> +        self.configuration.curr_distro =
> self.distro_combo.get_active_text()
>          self.configuration.image_rootfs_size =
> self.rootfs_size_spinner.get_value_as_int() * 1024
>          self.configuration.image_extra_size =
> self.extra_size_spinner.get_value_as_int() * 1024
>
> @@ -727,19 +845,7 @@ class AdvancedSettingDialog (CrumbsDialog):
>              key = self.setting_store.get_value(it, 0)
>              value = self.setting_store.get_value(it, 1)
>              self.configuration.extra_setting[key] = value
> -            it = self.setting_store.iter_next(it)
> -
> -        self.configuration.split_proxy("http", self.http_proxy.get_text()
> + ":" + self.http_proxy_port.get_text())
> -        if self.configuration.same_proxy:
> -            self.configuration.split_proxy("https",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> -            self.configuration.split_proxy("ftp",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> -            self.configuration.split_proxy("git",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> -            self.configuration.split_proxy("cvs",
> self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
> -        else:
> -            self.configuration.split_proxy("https",
> self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
> -            self.configuration.split_proxy("ftp",
> self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
> -            self.configuration.split_proxy("git",
> self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
> -            self.configuration.split_proxy("cvs",
> self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
> +            it = self.setting_store.iter_next(it)
>
>          md5 = self.config_md5()
>          self.settings_changed = (self.md5 != md5)
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> index 6aeb6dc..e665f38 100644
> --- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -205,17 +205,26 @@ class ImageConfigurationPage (HobPage):
>
>          self.image_desc = gtk.Label()
>          self.image_desc.set_alignment(0.0, 0.5)
> -        self.image_desc.set_size_request(360, -1)
> +        self.image_desc.set_size_request(256, -1)
>          self.image_desc.set_justify(gtk.JUSTIFY_LEFT)
>          self.image_desc.set_line_wrap(True)
>
> +        # button to view recipes
> +        icon_file = hic.ICON_RCIPE_DISPLAY_FILE
> +        hover_file = hic.ICON_RCIPE_HOVER_FILE
> +        self.view_adv_configuration_button = HobImageButton("Advanced
> configuration",
> +                                                                 "Select
> image types, package formats, etc",
> +
> icon_file, hover_file)
> +        self.view_adv_configuration_button.connect("clicked",
> self.view_adv_configuration_button_clicked_cb)
> +
>          self.image_separator = gtk.HSeparator()
>
>      def set_config_baseimg_layout(self):
>          self.gtable.attach(self.image_title, 0, 40, 15, 17)
>          self.gtable.attach(self.image_title_desc, 0, 40, 18, 22)
>          self.gtable.attach(self.image_combo, 0, 12, 23, 26)
> -        self.gtable.attach(self.image_desc, 13, 38, 23, 28)
> +        self.gtable.attach(self.image_desc, 0, 12, 27, 33)
> +        self.gtable.attach(self.view_adv_configuration_button, 14, 36,
> 23, 28)
>          self.gtable.attach(self.image_separator, 0, 40, 35, 36)
>
>      def create_config_build_button(self):
> @@ -413,6 +422,14 @@ class ImageConfigurationPage (HobPage):
>      def layer_button_clicked_cb(self, button):
>          # Create a layer selection dialog
>          self.builder.show_layer_selection_dialog()
> +
> +    def view_adv_configuration_button_clicked_cb(self, button):
> +        # Create an advanced settings dialog
> +        response, settings_changed =
> self.builder.show_adv_settings_dialog()
> +        if not response:
> +            return
> +        if settings_changed:
> +            self.builder.reparse_post_adv_settings()
>
>      def just_bake_button_clicked_cb(self, button):
>          self.builder.just_bake()
> @@ -432,7 +449,7 @@ class ImageConfigurationPage (HobPage):
>
>      def settings_button_clicked_cb(self, button):
>          # Create an advanced settings dialog
> -        response, settings_changed =
> self.builder.show_adv_settings_dialog()
> +        response, settings_changed =
> self.builder.show_simple_settings_dialog()
>          if not response:
>              return
>          if settings_changed:
> --
> 1.7.9.5
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>

--20cf3074b38635559b04c90a0b04
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry for the double post. The two patches in my messages are exactly the s=
ame.<div><br></div><div>Thanks,</div><div>Bogdan<br><br><div class=3D"gmail=
_quote">On Mon, Sep 3, 2012 at 5:36 PM, Bogdan Marinescu <span dir=3D"ltr">=
&lt;<a href=3D"mailto:bogdan.a.marinescu@intel.com" target=3D"_blank">bogda=
n.a.marinescu@intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">From: Valentin Popa &lt;<a href=3D"mailto:va=
lentin.popa@intel.com">valentin.popa@intel.com</a>&gt;<br>
<br>
[YOCTO #2162]<br>
---<br>
=A0bitbake/lib/bb/ui/crumbs/builder.py =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 34 +-<br>
=A0bitbake/lib/bb/ui/crumbs/hig.py =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0664 ++++++++++++--------<br>
=A0bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py | =A0 23 +-<br>
=A03 files changed, 435 insertions(+), 286 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs=
/builder.py<br>
index 7de4798..e3bc9df 100755<br>
--- a/bitbake/lib/bb/ui/crumbs/builder.py<br>
+++ b/bitbake/lib/bb/ui/crumbs/builder.py<br>
@@ -36,8 +36,8 @@ from bb.ui.crumbs.builddetailspage import BuildDetailsPag=
e<br>
=A0from bb.ui.crumbs.imagedetailspage import ImageDetailsPage<br>
=A0from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton, hcc<br>
=A0from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, =
\<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AdvancedSettingDi=
alog, LayerSelectionDialog, \<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DeployImageDialog=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AdvancedSettingDi=
alog, SimpleSettingsDialog, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LayerSelectionDia=
log, DeployImageDialog<br>
=A0from bb.ui.crumbs.persistenttooltip import PersistentTooltip<br>
=A0import bb.ui.crumbs.utils<br>
<br>
@@ -793,6 +793,7 @@ class Builder(gtk.Window):<br>
=A0 =A0 =A0 =A0 =A0self.image_configuration_page.layer_button.set_sensitive=
(sensitive)<br>
=A0 =A0 =A0 =A0 =A0self.image_configuration_page.layer_info_icon.set_sensit=
ive(sensitive)<br>
=A0 =A0 =A0 =A0 =A0self.image_configuration_page.toolbar.set_sensitive(sens=
itive)<br>
+ =A0 =A0 =A0 =A0self.image_configuration_page.view_adv_configuration_butto=
n.set_sensitive(sensitive)<br>
=A0 =A0 =A0 =A0 =A0self.image_configuration_page.config_build_button.set_se=
nsitive(sensitive)<br>
<br>
=A0 =A0 =A0 =A0 =A0self.recipe_details_page.set_sensitive(sensitive)<br>
@@ -1141,7 +1142,32 @@ class Builder(gtk.Window):<br>
=A0 =A0 =A0 =A0 =A0dialog.destroy()<br>
<br>
=A0 =A0 =A0def show_adv_settings_dialog(self):<br>
- =A0 =A0 =A0 =A0dialog =3D AdvancedSettingDialog(title =3D &quot;Settings&=
quot;,<br>
+ =A0 =A0 =A0 =A0dialog =3D AdvancedSettingDialog(title =3D &quot;Advanced =
configuration&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0configuration =3D copy.deepcopy(self.configuration=
),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0all_image_types =3D self.parameters.image_types,<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0all_package_formats =3D self.parameters.all_packag=
e_formats,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0all_distros =3D self.parameters.all_distros,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0all_sdk_machines =3D self.parameters.all_sdk_machi=
nes,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0max_threads =3D self.parameters.max_threads,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0parent =3D self,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0flags =3D gtk.DIALOG_MODAL<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| gtk.DIALOG_DESTROY_WITH_PARENT<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| gtk.DIALOG_NO_SEPARATOR)<br>
+ =A0 =A0 =A0 =A0button =3D dialog.add_button(&quot;Cancel&quot;, gtk.RESPO=
NSE_NO)<br>
+ =A0 =A0 =A0 =A0HobAltButton.style_button(button)<br>
+ =A0 =A0 =A0 =A0button =3D dialog.add_button(&quot;Save&quot;, gtk.RESPONS=
E_YES)<br>
+ =A0 =A0 =A0 =A0HobButton.style_button(button)<br>
+ =A0 =A0 =A0 =A0response =3D dialog.run()<br>
+ =A0 =A0 =A0 =A0settings_changed =3D False<br>
+ =A0 =A0 =A0 =A0if response =3D=3D gtk.RESPONSE_YES:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration =3D dialog.configuration<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.save_defaults() # remember settings<br>
+ =A0 =A0 =A0 =A0 =A0 =A0settings_changed =3D dialog.settings_changed<br>
+ =A0 =A0 =A0 =A0dialog.destroy()<br>
+ =A0 =A0 =A0 =A0return response =3D=3D gtk.RESPONSE_YES, settings_changed<=
br>
+<br>
+ =A0 =A0def show_simple_settings_dialog(self):<br>
+ =A0 =A0 =A0 =A0dialog =3D SimpleSettingsDialog(title =3D &quot;Settings&q=
uot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0configuration =3D copy.deepcopy(self.configurati=
on),<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0all_image_types =3D self.parameters.image_types,=
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0all_package_formats =3D self.parameters.all_pack=
age_formats,<br>
@@ -1334,4 +1360,4 @@ class Builder(gtk.Window):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0format =3D bb.msg.BBLogFormatter(&quot;%(levelna=
me)s: %(message)s&quot;)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0self.consolelog.setFormatter(format)<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.logger.addHandler(self.consolelog)<br>
\ No newline at end of file<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.logger.addHandler(self.consolelog)<br>
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig=
.py<br>
index 2001ff4..2c77bf7 100644<br>
--- a/bitbake/lib/bb/ui/crumbs/hig.py<br>
+++ b/bitbake/lib/bb/ui/crumbs/hig.py<br>
@@ -41,6 +41,88 @@ BitBake GUI&#39;s<br>
=A0In summary: spacing =3D 12px, border-width =3D 6px<br>
=A0&quot;&quot;&quot;<br>
<br>
+<br>
+class SettingsUIHelper():<br>
+<br>
+ =A0 =A0def gen_label_widget(self, content):<br>
+ =A0 =A0 =A0 =A0label =3D gtk.Label()<br>
+ =A0 =A0 =A0 =A0label.set_alignment(0, 0)<br>
+ =A0 =A0 =A0 =A0label.set_markup(content)<br>
+ =A0 =A0 =A0 =A0label.show()<br>
+ =A0 =A0 =A0 =A0return label<br>
+<br>
+ =A0 =A0def gen_spinner_widget(self, content, lower, upper, tooltip=3D&quo=
t;&quot;):<br>
+ =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
+ =A0 =A0 =A0 =A0adjust =3D gtk.Adjustment(value=3Dcontent, lower=3Dlower, =
upper=3Dupper, step_incr=3D1)<br>
+ =A0 =A0 =A0 =A0spinner =3D gtk.SpinButton(adjustment=3Dadjust, climb_rate=
=3D1, digits=3D0)<br>
+<br>
+ =A0 =A0 =A0 =A0spinner.set_value(content)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(spinner, expand=3DFalse, fill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0hbox.show_all()<br>
+ =A0 =A0 =A0 =A0return hbox, spinner<br>
+<br>
+ =A0 =A0def gen_combo_widget(self, curr_item, all_item, tooltip=3D&quot;&q=
uot;):<br>
+ =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
+ =A0 =A0 =A0 =A0combo =3D gtk.combo_box_new_text()<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(combo, expand=3DFalse, fill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0index =3D 0<br>
+ =A0 =A0 =A0 =A0for item in all_item or []:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0combo.append_text(item)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0if item =3D=3D curr_item:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0combo.set_active(index)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0index +=3D 1<br>
+<br>
+ =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0hbox.show_all()<br>
+ =A0 =A0 =A0 =A0return hbox, combo<br>
+<br>
+ =A0 =A0def entry_widget_select_path_cb(self, action, parent, entry):<br>
+ =A0 =A0 =A0 =A0dialog =3D gtk.FileChooserDialog(&quot;&quot;, parent,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)<br>
+ =A0 =A0 =A0 =A0text =3D entry.get_text()<br>
+ =A0 =A0 =A0 =A0dialog.set_current_folder(text if len(text) &gt; 0 else os=
.getcwd())<br>
+ =A0 =A0 =A0 =A0button =3D dialog.add_button(&quot;Cancel&quot;, gtk.RESPO=
NSE_NO)<br>
+ =A0 =A0 =A0 =A0HobAltButton.style_button(button)<br>
+ =A0 =A0 =A0 =A0button =3D dialog.add_button(&quot;Open&quot;, gtk.RESPONS=
E_YES)<br>
+ =A0 =A0 =A0 =A0HobButton.style_button(button)<br>
+ =A0 =A0 =A0 =A0response =3D dialog.run()<br>
+ =A0 =A0 =A0 =A0if response =3D=3D gtk.RESPONSE_YES:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0path =3D dialog.get_filename()<br>
+ =A0 =A0 =A0 =A0 =A0 =A0entry.set_text(path)<br>
+<br>
+ =A0 =A0 =A0 =A0dialog.destroy()<br>
+<br>
+ =A0 =A0def gen_entry_widget(self, content, parent, tooltip=3D&quot;&quot;=
, need_button=3DTrue):<br>
+ =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
+ =A0 =A0 =A0 =A0entry =3D gtk.Entry()<br>
+ =A0 =A0 =A0 =A0entry.set_text(content)<br>
+<br>
+ =A0 =A0 =A0 =A0if need_button:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0table =3D gtk.Table(1, 10, True)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0hbox.pack_start(table, expand=3DTrue, fill=3DTrue)=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0table.attach(entry, 0, 9, 0, 1)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0image =3D gtk.Image()<br>
+ =A0 =A0 =A0 =A0 =A0 =A0image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_=
BUTTON)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0open_button =3D gtk.Button()<br>
+ =A0 =A0 =A0 =A0 =A0 =A0open_button.set_image(image)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0open_button.connect(&quot;clicked&quot;, self.entr=
y_widget_select_path_cb, parent, entry)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0table.attach(open_button, 9, 10, 0, 1)<br>
+ =A0 =A0 =A0 =A0else:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0hbox.pack_start(entry, expand=3DTrue, fill=3DTrue)=
<br>
+<br>
+ =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0hbox.show_all()<br>
+ =A0 =A0 =A0 =A0return hbox, entry<br>
+<br>
=A0#<br>
=A0# CrumbsDialog<br>
=A0#<br>
@@ -94,89 +176,309 @@ class CrumbsMessageDialog(CrumbsDialog):<br>
=A0 =A0 =A0 =A0 =A0first_row.add(self.label)<br>
<br>
=A0#<br>
-# AdvancedSettings Dialog<br>
+# SimpleSettings Dialog<br>
=A0#<br>
-class AdvancedSettingDialog (CrumbsDialog):<br>
+class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):<br>
<br>
- =A0 =A0def gen_label_widget(self, content):<br>
- =A0 =A0 =A0 =A0label =3D gtk.Label()<br>
- =A0 =A0 =A0 =A0label.set_alignment(0, 0)<br>
- =A0 =A0 =A0 =A0label.set_markup(content)<br>
- =A0 =A0 =A0 =A0label.show()<br>
- =A0 =A0 =A0 =A0return label<br>
+ =A0 =A0def __init__(self, title, configuration, all_image_types,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0all_package_formats, all_distros, all_sdk_machines=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0max_threads, parent, flags, buttons=3DNone):<br>
+ =A0 =A0 =A0 =A0super(SimpleSettingsDialog, self).__init__(title, parent, =
flags, buttons)<br>
<br>
- =A0 =A0def gen_spinner_widget(self, content, lower, upper, tooltip=3D&quo=
t;&quot;):<br>
+ =A0 =A0 =A0 =A0# class members from other objects<br>
+ =A0 =A0 =A0 =A0# bitbake settings from Builder.Configuration<br>
+ =A0 =A0 =A0 =A0self.configuration =3D configuration<br>
+ =A0 =A0 =A0 =A0self.image_types =3D all_image_types<br>
+ =A0 =A0 =A0 =A0self.all_package_formats =3D all_package_formats<br>
+ =A0 =A0 =A0 =A0self.all_distros =3D all_distros<br>
+ =A0 =A0 =A0 =A0self.all_sdk_machines =3D all_sdk_machines<br>
+ =A0 =A0 =A0 =A0self.max_threads =3D max_threads<br>
+<br>
+ =A0 =A0 =A0 =A0# class members for internal use<br>
+ =A0 =A0 =A0 =A0self.distro_combo =3D None<br>
+ =A0 =A0 =A0 =A0self.dldir_text =3D None<br>
+ =A0 =A0 =A0 =A0self.sstatedir_text =3D None<br>
+ =A0 =A0 =A0 =A0self.sstatemirror_text =3D None<br>
+ =A0 =A0 =A0 =A0self.bb_spinner =3D None<br>
+ =A0 =A0 =A0 =A0self.pmake_spinner =3D None<br>
+ =A0 =A0 =A0 =A0self.rootfs_size_spinner =3D None<br>
+ =A0 =A0 =A0 =A0self.extra_size_spinner =3D None<br>
+ =A0 =A0 =A0 =A0self.gplv3_checkbox =3D None<br>
+ =A0 =A0 =A0 =A0self.toolchain_checkbox =3D None<br>
+ =A0 =A0 =A0 =A0self.setting_store =3D None<br>
+ =A0 =A0 =A0 =A0self.image_types_checkbuttons =3D {}<br>
+<br>
+ =A0 =A0 =A0 =A0self.md5 =3D self.config_md5()<br>
+ =A0 =A0 =A0 =A0self.settings_changed =3D False<br>
+<br>
+ =A0 =A0 =A0 =A0# create visual elements on the dialog<br>
+ =A0 =A0 =A0 =A0self.create_visual_elements()<br>
+ =A0 =A0 =A0 =A0self.connect(&quot;response&quot;, self.response_cb)<br>
+<br>
+ =A0 =A0def _get_sorted_value(self, var):<br>
+ =A0 =A0 =A0 =A0return &quot; &quot;.join(sorted(str(var).split())) + &quo=
t;\n&quot;<br>
+<br>
+ =A0 =A0def config_md5(self):<br>
+ =A0 =A0 =A0 =A0data =3D &quot;&quot;<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;PACKAGE_CLASSES: &quot; =A0 =A0 =A0+ self=
.configuration.curr_package_format + &#39;\n&#39;)<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;DISTRO: &quot; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 + self._get_sorted_value(self.configuration.curr_distro))<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;IMAGE_ROOTFS_SIZE: &quot; =A0 =A0+ self._=
get_sorted_value(self.configuration.image_rootfs_size))<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;IMAGE_EXTRA_SIZE: &quot; =A0 =A0 + self._=
get_sorted_value(self.configuration.image_extra_size))<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;INCOMPATIBLE_LICENSE: &quot; + self._get_=
sorted_value(self.configuration.incompat_license))<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;SDK_MACHINE: &quot; =A0 =A0 =A0 =A0 =A0+ =
self._get_sorted_value(self.configuration.curr_sdk_machine))<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;TOOLCHAIN_BUILD: &quot; =A0 =A0 =A0+ self=
._get_sorted_value(self.configuration.toolchain_build))<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;IMAGE_FSTYPES: &quot; =A0 =A0 =A0 =A0+ se=
lf._get_sorted_value(self.configuration.image_fstypes))<br>
+ =A0 =A0 =A0 =A0data +=3D (&quot;ENABLE_PROXY: &quot; =A0 =A0 =A0 =A0 + se=
lf._get_sorted_value(self.configuration.enable_proxy))<br>
+ =A0 =A0 =A0 =A0if self.configuration.enable_proxy:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0for protocol in self.configuration.proxies.keys():=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data +=3D (protocol + &quot;: &quot; + sel=
f._get_sorted_value(self.configuration.combine_proxy(protocol)))<br>
+ =A0 =A0 =A0 =A0for key in self.configuration.extra_setting.keys():<br>
+ =A0 =A0 =A0 =A0 =A0 =A0data +=3D (key + &quot;: &quot; + self._get_sorted=
_value(self.configuration.extra_setting[key]))<br>
+ =A0 =A0 =A0 =A0return hashlib.md5(data).hexdigest()<br>
+<br>
+ =A0 =A0def details_cb(self, button, parent, protocol):<br>
+ =A0 =A0 =A0 =A0dialog =3D ProxyDetailsDialog(title =3D protocol.upper() +=
 &quot; Proxy Details&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0user =3D self.configuration.proxies[protocol][1],<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0passwd =3D self.configuration.proxies[protocol][2]=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0parent =3D parent,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0flags =3D gtk.DIALOG_MODAL<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| gtk.DIALOG_DESTROY_WITH_PARENT<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| gtk.DIALOG_NO_SEPARATOR)<br>
+ =A0 =A0 =A0 =A0dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)<br>
+ =A0 =A0 =A0 =A0response =3D dialog.run()<br>
+ =A0 =A0 =A0 =A0if response =3D=3D gtk.RESPONSE_OK:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.proxies[protocol][1] =3D dialog=
.user<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.proxies[protocol][2] =3D dialog=
.passwd<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
+ =A0 =A0 =A0 =A0dialog.destroy()<br>
+<br>
+ =A0 =A0def gen_proxy_entry_widget(self, protocol, parent, need_button=3DT=
rue):<br>
=A0 =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
- =A0 =A0 =A0 =A0adjust =3D gtk.Adjustment(value=3Dcontent, lower=3Dlower, =
upper=3Dupper, step_incr=3D1)<br>
- =A0 =A0 =A0 =A0spinner =3D gtk.SpinButton(adjustment=3Dadjust, climb_rate=
=3D1, digits=3D0)<br>
<br>
- =A0 =A0 =A0 =A0spinner.set_value(content)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(spinner, expand=3DFalse, fill=3DFalse)<br>
+ =A0 =A0 =A0 =A0label =3D gtk.Label(protocol.upper() + &quot; proxy&quot;)=
<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(label, expand=3DTrue, fill=3DFalse, paddin=
g=3D24)<br>
<br>
- =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
+ =A0 =A0 =A0 =A0proxy_entry =3D gtk.Entry()<br>
+ =A0 =A0 =A0 =A0proxy_entry.set_size_request(300, -1)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(proxy_entry, expand=3DFalse, fill=3DFalse)=
<br>
+<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(gtk.Label(&quot;:&quot;), expand=3DFalse, =
fill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0port_entry =3D gtk.Entry()<br>
+ =A0 =A0 =A0 =A0port_entry.set_size_request(60, -1)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(port_entry, expand=3DFalse, fill=3DFalse)<=
br>
+<br>
+ =A0 =A0 =A0 =A0details_button =3D HobAltButton(&quot;Details&quot;)<br>
+ =A0 =A0 =A0 =A0details_button.connect(&quot;clicked&quot;, self.details_c=
b, parent, protocol)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(details_button, expand=3DFalse, fill=3DFal=
se)<br>
<br>
=A0 =A0 =A0 =A0 =A0hbox.show_all()<br>
- =A0 =A0 =A0 =A0return hbox, spinner<br>
+ =A0 =A0 =A0 =A0return hbox, proxy_entry, port_entry, details_button<br>
<br>
- =A0 =A0def gen_combo_widget(self, curr_item, all_item, tooltip=3D&quot;&q=
uot;):<br>
- =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
- =A0 =A0 =A0 =A0combo =3D gtk.combo_box_new_text()<br>
- =A0 =A0 =A0 =A0hbox.pack_start(combo, expand=3DFalse, fill=3DFalse)<br>
+ =A0 =A0def refresh_proxy_components(self):<br>
+ =A0 =A0 =A0 =A0self.same_checkbox.set_sensitive(self.configuration.enable=
_proxy)<br>
<br>
- =A0 =A0 =A0 =A0index =3D 0<br>
- =A0 =A0 =A0 =A0for item in all_item or []:<br>
- =A0 =A0 =A0 =A0 =A0 =A0combo.append_text(item)<br>
- =A0 =A0 =A0 =A0 =A0 =A0if item =3D=3D curr_item:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0combo.set_active(index)<br>
- =A0 =A0 =A0 =A0 =A0 =A0index +=3D 1<br>
+ =A0 =A0 =A0 =A0self.http_proxy.set_text(self.configuration.combine_host_o=
nly(&quot;http&quot;))<br>
+ =A0 =A0 =A0 =A0self.http_proxy.set_editable(self.configuration.enable_pro=
xy)<br>
+ =A0 =A0 =A0 =A0self.http_proxy.set_sensitive(self.configuration.enable_pr=
oxy)<br>
+ =A0 =A0 =A0 =A0self.http_proxy_port.set_text(self.configuration.combine_p=
ort_only(&quot;http&quot;))<br>
+ =A0 =A0 =A0 =A0self.http_proxy_port.set_editable(self.configuration.enabl=
e_proxy)<br>
+ =A0 =A0 =A0 =A0self.http_proxy_port.set_sensitive(self.configuration.enab=
le_proxy)<br>
+ =A0 =A0 =A0 =A0self.http_proxy_details.set_sensitive(self.configuration.e=
nable_proxy)<br>
+<br>
+ =A0 =A0 =A0 =A0self.https_proxy.set_text(self.configuration.combine_host_=
only(&quot;https&quot;))<br>
+ =A0 =A0 =A0 =A0self.https_proxy.set_editable(self.configuration.enable_pr=
oxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.https_proxy.set_sensitive(self.configuration.enable_p=
roxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.https_proxy_port.set_text(self.configuration.combine_=
port_only(&quot;https&quot;))<br>
+ =A0 =A0 =A0 =A0self.https_proxy_port.set_editable(self.configuration.enab=
le_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.https_proxy_port.set_sensitive(self.configuration.ena=
ble_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.https_proxy_details.set_sensitive(self.configuration.=
enable_proxy and (not self.configuration.same_proxy))<br>
+<br>
+ =A0 =A0 =A0 =A0self.ftp_proxy.set_text(self.configuration.combine_host_on=
ly(&quot;ftp&quot;))<br>
+ =A0 =A0 =A0 =A0self.ftp_proxy.set_editable(self.configuration.enable_prox=
y and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.ftp_proxy.set_sensitive(self.configuration.enable_pro=
xy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.ftp_proxy_port.set_text(self.configuration.combine_po=
rt_only(&quot;ftp&quot;))<br>
+ =A0 =A0 =A0 =A0self.ftp_proxy_port.set_editable(self.configuration.enable=
_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.ftp_proxy_port.set_sensitive(self.configuration.enabl=
e_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.ftp_proxy_details.set_sensitive(self.configuration.en=
able_proxy and (not self.configuration.same_proxy))<br>
+<br>
+ =A0 =A0 =A0 =A0self.git_proxy.set_text(self.configuration.combine_host_on=
ly(&quot;git&quot;))<br>
+ =A0 =A0 =A0 =A0self.git_proxy.set_editable(self.configuration.enable_prox=
y and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.git_proxy.set_sensitive(self.configuration.enable_pro=
xy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.git_proxy_port.set_text(self.configuration.combine_po=
rt_only(&quot;git&quot;))<br>
+ =A0 =A0 =A0 =A0self.git_proxy_port.set_editable(self.configuration.enable=
_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.git_proxy_port.set_sensitive(self.configuration.enabl=
e_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.git_proxy_details.set_sensitive(self.configuration.en=
able_proxy and (not self.configuration.same_proxy))<br>
+<br>
+ =A0 =A0 =A0 =A0self.cvs_proxy.set_text(self.configuration.combine_host_on=
ly(&quot;cvs&quot;))<br>
+ =A0 =A0 =A0 =A0self.cvs_proxy.set_editable(self.configuration.enable_prox=
y and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.cvs_proxy.set_sensitive(self.configuration.enable_pro=
xy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.cvs_proxy_port.set_text(self.configuration.combine_po=
rt_only(&quot;cvs&quot;))<br>
+ =A0 =A0 =A0 =A0self.cvs_proxy_port.set_editable(self.configuration.enable=
_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.cvs_proxy_port.set_sensitive(self.configuration.enabl=
e_proxy and (not self.configuration.same_proxy))<br>
+ =A0 =A0 =A0 =A0self.cvs_proxy_details.set_sensitive(self.configuration.en=
able_proxy and (not self.configuration.same_proxy))<br>
<br>
+ =A0 =A0def proxy_checkbox_toggled_cb(self, button):<br>
+ =A0 =A0 =A0 =A0self.configuration.enable_proxy =3D self.proxy_checkbox.ge=
t_active()<br>
+ =A0 =A0 =A0 =A0if not self.configuration.enable_proxy:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.same_proxy =3D False<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.same_checkbox.set_active(self.configuration.s=
ame_proxy)<br>
+ =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
+<br>
+ =A0 =A0def same_checkbox_toggled_cb(self, button):<br>
+ =A0 =A0 =A0 =A0self.configuration.same_proxy =3D self.same_checkbox.get_a=
ctive()<br>
+ =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
+<br>
+ =A0 =A0def response_cb(self, dialog, response_id):<br>
+ =A0 =A0 =A0 =A0#self.configuration.curr_distro =3D self.distro_combo.get_=
active_text()<br>
+ =A0 =A0 =A0 =A0self.configuration.dldir =3D self.dldir_text.get_text()<br=
>
+ =A0 =A0 =A0 =A0self.configuration.sstatedir =3D self.sstatedir_text.get_t=
ext()<br>
+ =A0 =A0 =A0 =A0self.configuration.sstatemirror =3D self.sstatemirror_text=
.get_text()<br>
+ =A0 =A0 =A0 =A0self.configuration.bbthread =3D self.bb_spinner.get_value_=
as_int()<br>
+ =A0 =A0 =A0 =A0self.configuration.pmake =3D self.pmake_spinner.get_value_=
as_int()<br>
+<br>
+ =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;http&quot;, self.http=
_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())<br>
+ =A0 =A0 =A0 =A0if self.configuration.same_proxy:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;https&quot;, =
self.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text(=
))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;ftp&quot;, se=
lf.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;git&quot;, se=
lf.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;cvs&quot;, se=
lf.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())=
<br>
+ =A0 =A0 =A0 =A0else:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;https&quot;, =
self.https_proxy.get_text() + &quot;:&quot; + self.https_proxy_port.get_tex=
t())<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;ftp&quot;, se=
lf.ftp_proxy.get_text() + &quot;:&quot; + self.ftp_proxy_port.get_text())<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;git&quot;, se=
lf.git_proxy.get_text() + &quot;:&quot; + self.git_proxy_port.get_text())<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;cvs&quot;, se=
lf.cvs_proxy.get_text() + &quot;:&quot; + self.cvs_proxy_port.get_text())<b=
r>
+<br>
+ =A0 =A0 =A0 =A0md5 =3D self.config_md5()<br>
+ =A0 =A0 =A0 =A0self.settings_changed =3D (self.md5 !=3D md5)<br>
+<br>
+ =A0 =A0def create_build_environment_page(self):<br>
+ =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.set_border_width(6)<br>
+<br>
+ =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
+ =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;BB number threads:&lt;/span&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Sets the number of threads that BitBake =
tasks can simultaneously run. See the &lt;a href=3D\&quot;&quot;<br>
+ =A0 =A0 =A0 =A0tooltip +=3D &quot;<a href=3D"http://www.yoctoproject.org/=
docs/current/poky-ref-manual/" target=3D"_blank">http://www.yoctoproject.or=
g/docs/current/poky-ref-manual/</a>&quot;<br>
+ =A0 =A0 =A0 =A0tooltip +=3D &quot;poky-ref-manual.html#var-BB_NUMBER_THRE=
ADS\&quot;&gt;Poky reference manual&lt;/a&gt; for information&quot;<br>
+ =A0 =A0 =A0 =A0bbthread_widget, self.bb_spinner =3D self.gen_spinner_widg=
et(self.configuration.bbthread, 1, self.max_threads, tooltip)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(bbthread_widget, expand=3DFalse, fill=
=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
+ =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Parallel make:&lt;/span&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Sets the maximum number of threads the h=
ost can use during the build. See the &lt;a href=3D\&quot;&quot;<br>
+ =A0 =A0 =A0 =A0tooltip +=3D &quot;<a href=3D"http://www.yoctoproject.org/=
docs/current/poky-ref-manual/" target=3D"_blank">http://www.yoctoproject.or=
g/docs/current/poky-ref-manual/</a>&quot;<br>
+ =A0 =A0 =A0 =A0tooltip +=3D &quot;poky-ref-manual.html#var-PARALLEL_MAKE\=
&quot;&gt;Poky reference manual&lt;/a&gt; for information&quot;<br>
+ =A0 =A0 =A0 =A0pmake_widget, self.pmake_spinner =3D self.gen_spinner_widg=
et(self.configuration.pmake, 1, self.max_threads, tooltip)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(pmake_widget, expand=3DFalse, fill=3DF=
alse)<br>
+<br>
+ =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
+ =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Select download directory:&lt;/span&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Select a folder that caches the upstream=
 project source code&quot;<br>
+ =A0 =A0 =A0 =A0dldir_widget, self.dldir_text =3D self.gen_entry_widget(se=
lf.configuration.dldir, self, tooltip)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(dldir_widget, expand=3DFalse, fill=3DF=
alse)<br>
+<br>
+ =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
+ =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Select SSTATE directory:&lt;/span&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Select a folder that caches your prebuil=
t results&quot;<br>
+ =A0 =A0 =A0 =A0sstatedir_widget, self.sstatedir_text =3D self.gen_entry_w=
idget(self.configuration.sstatedir, self, tooltip)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(sstatedir_widget, expand=3DFalse, fill=
=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
+ =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Select SSTATE mirror:&lt;/span&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Select the pre-built mirror that will sp=
eed your build&quot;<br>
+ =A0 =A0 =A0 =A0sstatemirror_widget, self.sstatemirror_text =3D self.gen_e=
ntry_widget(self.configuration.sstatemirror, self, tooltip)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(sstatemirror_widget, expand=3DFalse, f=
ill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0return advanced_vbox<br>
+<br>
+ =A0 =A0def create_proxy_page(self):<br>
+ =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.set_border_width(6)<br>
+<br>
+ =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
+ =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Set the proxies that will be used during fetching sourc=
e code&lt;/span&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Set the proxies that will be used during=
 fetching source code or set none for direct the Internet connection&quot;<=
br>
=A0 =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
+ =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(label, expand=3DTrue, fill=3DTrue)<br>
=A0 =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)<br=
>
<br>
- =A0 =A0 =A0 =A0hbox.show_all()<br>
- =A0 =A0 =A0 =A0return hbox, combo<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox =3D gtk.RadioButton(None, &quot;Direc=
t internet connection&quot;)<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox.set_tooltip_text(&quot;Check this box=
 to connect the Internet directly without any proxy&quot;)<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox.set_active(not self.configuration.ena=
ble_proxy)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(self.direct_checkbox, expand=3DFalse, =
fill=3DFalse)<br>
<br>
- =A0 =A0def entry_widget_select_path_cb(self, action, parent, entry):<br>
- =A0 =A0 =A0 =A0dialog =3D gtk.FileChooserDialog(&quot;&quot;, parent,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)<br>
- =A0 =A0 =A0 =A0text =3D entry.get_text()<br>
- =A0 =A0 =A0 =A0dialog.set_current_folder(text if len(text) &gt; 0 else os=
.getcwd())<br>
- =A0 =A0 =A0 =A0button =3D dialog.add_button(&quot;Cancel&quot;, gtk.RESPO=
NSE_NO)<br>
- =A0 =A0 =A0 =A0HobAltButton.style_button(button)<br>
- =A0 =A0 =A0 =A0button =3D dialog.add_button(&quot;Open&quot;, gtk.RESPONS=
E_YES)<br>
- =A0 =A0 =A0 =A0HobButton.style_button(button)<br>
- =A0 =A0 =A0 =A0response =3D dialog.run()<br>
- =A0 =A0 =A0 =A0if response =3D=3D gtk.RESPONSE_YES:<br>
- =A0 =A0 =A0 =A0 =A0 =A0path =3D dialog.get_filename()<br>
- =A0 =A0 =A0 =A0 =A0 =A0entry.set_text(path)<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox =3D gtk.RadioButton(self.direct_checkb=
ox, &quot;Manual proxy configuration&quot;)<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox.set_tooltip_text(&quot;Check this box =
to setup the proxy you specified&quot;)<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox.set_active(self.configuration.enable_p=
roxy)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(self.proxy_checkbox, expand=3DFalse, f=
ill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0self.same_checkbox =3D gtk.CheckButton(&quot;Use the same =
proxy for all protocols&quot;)<br>
+ =A0 =A0 =A0 =A0self.same_checkbox.set_tooltip_text(&quot;Use the same pro=
xy as the first proxy i.e. http proxy for all protocols&quot;)<br>
+ =A0 =A0 =A0 =A0self.same_checkbox.set_active(self.configuration.same_prox=
y)<br>
+ =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(self.same_checkbox, expand=3DFalse, fill=
=3DFalse, padding=3D24)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)<br=
>
+<br>
+ =A0 =A0 =A0 =A0proxy_widget, self.http_proxy, self.http_proxy_port, self.=
http_proxy_details =3D self.gen_proxy_entry_widget(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&quot;http&quot;, self, True)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
+<br>
+ =A0 =A0 =A0 =A0proxy_widget, self.https_proxy, self.https_proxy_port, sel=
f.https_proxy_details =3D self.gen_proxy_entry_widget(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&quot;https&quot;, self, True)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
+<br>
+ =A0 =A0 =A0 =A0proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ft=
p_proxy_details =3D self.gen_proxy_entry_widget(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&quot;ftp&quot;, self, True)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
+<br>
+ =A0 =A0 =A0 =A0proxy_widget, self.git_proxy, self.git_proxy_port, self.gi=
t_proxy_details =3D self.gen_proxy_entry_widget(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&quot;git&quot;, self, True)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
+<br>
+ =A0 =A0 =A0 =A0proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cv=
s_proxy_details =3D self.gen_proxy_entry_widget(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&quot;cvs&quot;, self, True)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
<br>
- =A0 =A0 =A0 =A0dialog.destroy()<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox.connect(&quot;toggled&quot;, self.pro=
xy_checkbox_toggled_cb)<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox.connect(&quot;toggled&quot;, self.prox=
y_checkbox_toggled_cb)<br>
+ =A0 =A0 =A0 =A0self.same_checkbox.connect(&quot;toggled&quot;, self.same_=
checkbox_toggled_cb)<br>
<br>
- =A0 =A0def gen_entry_widget(self, content, parent, tooltip=3D&quot;&quot;=
, need_button=3DTrue):<br>
- =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
- =A0 =A0 =A0 =A0entry =3D gtk.Entry()<br>
- =A0 =A0 =A0 =A0entry.set_text(content)<br>
+ =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
+ =A0 =A0 =A0 =A0return advanced_vbox<br>
<br>
- =A0 =A0 =A0 =A0if need_button:<br>
- =A0 =A0 =A0 =A0 =A0 =A0table =3D gtk.Table(1, 10, True)<br>
- =A0 =A0 =A0 =A0 =A0 =A0hbox.pack_start(table, expand=3DTrue, fill=3DTrue)=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0table.attach(entry, 0, 9, 0, 1)<br>
- =A0 =A0 =A0 =A0 =A0 =A0image =3D gtk.Image()<br>
- =A0 =A0 =A0 =A0 =A0 =A0image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_=
BUTTON)<br>
- =A0 =A0 =A0 =A0 =A0 =A0open_button =3D gtk.Button()<br>
- =A0 =A0 =A0 =A0 =A0 =A0open_button.set_image(image)<br>
- =A0 =A0 =A0 =A0 =A0 =A0open_button.connect(&quot;clicked&quot;, self.entr=
y_widget_select_path_cb, parent, entry)<br>
- =A0 =A0 =A0 =A0 =A0 =A0table.attach(open_button, 9, 10, 0, 1)<br>
- =A0 =A0 =A0 =A0else:<br>
- =A0 =A0 =A0 =A0 =A0 =A0hbox.pack_start(entry, expand=3DTrue, fill=3DTrue)=
<br>
<br>
- =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
+ =A0 =A0def create_visual_elements(self):<br>
+ =A0 =A0 =A0 =A0self.nb =3D gtk.Notebook()<br>
+ =A0 =A0 =A0 =A0self.nb.set_show_tabs(True)<br>
+ =A0 =A0 =A0 =A0self.nb.append_page(self.create_build_environment_page(), =
gtk.Label(&quot;Build environment&quot;))<br>
+ =A0 =A0 =A0 =A0self.nb.append_page(self.create_proxy_page(), gtk.Label(&q=
uot;Proxies&quot;))<br>
+ =A0 =A0 =A0 =A0self.nb.set_current_page(0)<br>
+ =A0 =A0 =A0 =A0self.vbox.pack_start(self.nb, expand=3DTrue, fill=3DTrue)<=
br>
+ =A0 =A0 =A0 =A0self.vbox.pack_end(gtk.HSeparator(), expand=3DTrue, fill=
=3DTrue)<br>
+<br>
+ =A0 =A0 =A0 =A0self.show_all()<br>
<br>
- =A0 =A0 =A0 =A0hbox.show_all()<br>
- =A0 =A0 =A0 =A0return hbox, entry<br>
<br>
+<br>
+#<br>
+# AdvancedSettings Dialog<br>
+#<br>
+class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):<br>
+<br>
=A0 =A0 =A0def details_cb(self, button, parent, protocol):<br>
=A0 =A0 =A0 =A0 =A0dialog =3D ProxyDetailsDialog(title =3D protocol.upper()=
 + &quot; Proxy Details&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0user =3D self.configuration.proxies[protocol][1]=
,<br>
@@ -191,30 +493,7 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0self.configuration.proxies[protocol][1] =3D dial=
og.user<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0self.configuration.proxies[protocol][2] =3D dial=
og.passwd<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
- =A0 =A0 =A0 =A0dialog.destroy()<br>
-<br>
- =A0 =A0def gen_proxy_entry_widget(self, protocol, parent, need_button=3DT=
rue):<br>
- =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
-<br>
- =A0 =A0 =A0 =A0label =3D gtk.Label(protocol.upper() + &quot; proxy&quot;)=
<br>
- =A0 =A0 =A0 =A0hbox.pack_start(label, expand=3DTrue, fill=3DFalse, paddin=
g=3D24)<br>
-<br>
- =A0 =A0 =A0 =A0proxy_entry =3D gtk.Entry()<br>
- =A0 =A0 =A0 =A0proxy_entry.set_size_request(300, -1)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(proxy_entry, expand=3DFalse, fill=3DFalse)=
<br>
-<br>
- =A0 =A0 =A0 =A0hbox.pack_start(gtk.Label(&quot;:&quot;), expand=3DFalse, =
fill=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0port_entry =3D gtk.Entry()<br>
- =A0 =A0 =A0 =A0port_entry.set_size_request(60, -1)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(port_entry, expand=3DFalse, fill=3DFalse)<=
br>
-<br>
- =A0 =A0 =A0 =A0details_button =3D HobAltButton(&quot;Details&quot;)<br>
- =A0 =A0 =A0 =A0details_button.connect(&quot;clicked&quot;, self.details_c=
b, parent, protocol)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(details_button, expand=3DFalse, fill=3DFal=
se)<br>
-<br>
- =A0 =A0 =A0 =A0hbox.show_all()<br>
- =A0 =A0 =A0 =A0return hbox, proxy_entry, port_entry, details_button<br>
+ =A0 =A0 =A0 =A0dialog.destroy()<br>
<br>
=A0 =A0 =A0def rootfs_combo_changed_cb(self, rootfs_combo, all_package_form=
at, check_hbox):<br>
=A0 =A0 =A0 =A0 =A0combo_item =3D self.rootfs_combo.get_active_text()<br>
@@ -412,8 +691,6 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
=A0 =A0 =A0 =A0 =A0self.nb.set_show_tabs(True)<br>
=A0 =A0 =A0 =A0 =A0self.nb.append_page(self.create_image_types_page(), gtk.=
Label(&quot;Image types&quot;))<br>
=A0 =A0 =A0 =A0 =A0self.nb.append_page(self.create_output_page(), gtk.Label=
(&quot;Output&quot;))<br>
- =A0 =A0 =A0 =A0self.nb.append_page(self.create_build_environment_page(), =
gtk.Label(&quot;Build environment&quot;))<br>
- =A0 =A0 =A0 =A0self.nb.append_page(self.create_proxy_page(), gtk.Label(&q=
uot;Proxies&quot;))<br>
=A0 =A0 =A0 =A0 =A0self.nb.append_page(self.create_others_page(), gtk.Label=
(&quot;Others&quot;))<br>
=A0 =A0 =A0 =A0 =A0self.nb.set_current_page(0)<br>
=A0 =A0 =A0 =A0 =A0self.vbox.pack_start(self.nb, expand=3DTrue, fill=3DTrue=
)<br>
@@ -422,10 +699,22 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
=A0 =A0 =A0 =A0 =A0self.show_all()<br>
<br>
=A0 =A0 =A0def create_image_types_page(self):<br>
+ =A0 =A0 =A0 =A0main_vbox =3D gtk.VBox(False, 16)<br>
+ =A0 =A0 =A0 =A0main_vbox.set_border_width(6)<br>
+<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox.set_border_width(6)<br>
<br>
- =A0 =A0 =A0 =A0rows =3D (len(self.image_types)+1)/2<br>
+ =A0 =A0 =A0 =A0distro_vbox =3D gtk.VBox(False, 6)<br>
+ =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Distro:&lt;/span&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Selects the Yocto Project distribution y=
ou want&quot;<br>
+ =A0 =A0 =A0 =A0distro_widget, self.distro_combo =3D self.gen_combo_widget=
(self.configuration.curr_distro, self.all_distros, tooltip)<br>
+ =A0 =A0 =A0 =A0distro_vbox.pack_start(label, expand=3DFalse, fill=3DFalse=
)<br>
+ =A0 =A0 =A0 =A0distro_vbox.pack_start(distro_widget, expand=3DFalse, fill=
=3DFalse)<br>
+ =A0 =A0 =A0 =A0main_vbox.pack_start(distro_vbox, expand=3DFalse, fill=3DF=
alse)<br>
+<br>
+<br>
+ =A0 =A0 =A0 =A0rows =3D (len(self.image_types)+1)/3<br>
=A0 =A0 =A0 =A0 =A0table =3D gtk.Table(rows + 1, 10, True)<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox.pack_start(table, expand=3DFalse, fill=3DF=
alse)<br>
<br>
@@ -451,7 +740,9 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i =3D 1<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0j =3D j + 4<br>
<br>
- =A0 =A0 =A0 =A0return advanced_vbox<br>
+ =A0 =A0 =A0 =A0main_vbox.pack_start(advanced_vbox, expand=3DFalse, fill=
=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0return main_vbox<br>
<br>
=A0 =A0 =A0def create_output_page(self):<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
@@ -503,122 +794,7 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
<br>
=A0 =A0 =A0 =A0 =A0return advanced_vbox<br>
<br>
- =A0 =A0def create_build_environment_page(self):<br>
- =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.set_border_width(6)<br>
-<br>
- =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
- =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Select distro:&lt;/span&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Selects the Yocto Project distribution y=
ou want&quot;<br>
- =A0 =A0 =A0 =A0distro_widget, self.distro_combo =3D self.gen_combo_widget=
(self.configuration.curr_distro, self.all_distros, tooltip)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(distro_widget, expand=3DFalse, fill=3D=
False)<br>
-<br>
- =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
- =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;BB number threads:&lt;/span&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Sets the number of threads that BitBake =
tasks can simultaneously run. See the &lt;a href=3D\&quot;&quot;<br>
- =A0 =A0 =A0 =A0tooltip +=3D &quot;<a href=3D"http://www.yoctoproject.org/=
docs/current/poky-ref-manual/" target=3D"_blank">http://www.yoctoproject.or=
g/docs/current/poky-ref-manual/</a>&quot;<br>
- =A0 =A0 =A0 =A0tooltip +=3D &quot;poky-ref-manual.html#var-BB_NUMBER_THRE=
ADS\&quot;&gt;Poky reference manual&lt;/a&gt; for information&quot;<br>
- =A0 =A0 =A0 =A0bbthread_widget, self.bb_spinner =3D self.gen_spinner_widg=
et(self.configuration.bbthread, 1, self.max_threads, tooltip)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(bbthread_widget, expand=3DFalse, fill=
=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
- =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Parallel make:&lt;/span&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Sets the maximum number of threads the h=
ost can use during the build. See the &lt;a href=3D\&quot;&quot;<br>
- =A0 =A0 =A0 =A0tooltip +=3D &quot;<a href=3D"http://www.yoctoproject.org/=
docs/current/poky-ref-manual/" target=3D"_blank">http://www.yoctoproject.or=
g/docs/current/poky-ref-manual/</a>&quot;<br>
- =A0 =A0 =A0 =A0tooltip +=3D &quot;poky-ref-manual.html#var-PARALLEL_MAKE\=
&quot;&gt;Poky reference manual&lt;/a&gt; for information&quot;<br>
- =A0 =A0 =A0 =A0pmake_widget, self.pmake_spinner =3D self.gen_spinner_widg=
et(self.configuration.pmake, 1, self.max_threads, tooltip)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(pmake_widget, expand=3DFalse, fill=3DF=
alse)<br>
-<br>
- =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
- =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Select download directory:&lt;/span&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Select a folder that caches the upstream=
 project source code&quot;<br>
- =A0 =A0 =A0 =A0dldir_widget, self.dldir_text =3D self.gen_entry_widget(se=
lf.configuration.dldir, self, tooltip)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(dldir_widget, expand=3DFalse, fill=3DF=
alse)<br>
-<br>
- =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
- =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Select SSTATE directory:&lt;/span&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Select a folder that caches your prebuil=
t results&quot;<br>
- =A0 =A0 =A0 =A0sstatedir_widget, self.sstatedir_text =3D self.gen_entry_w=
idget(self.configuration.sstatedir, self, tooltip)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(sstatedir_widget, expand=3DFalse, fill=
=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
- =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Select SSTATE mirror:&lt;/span&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Select the pre-built mirror that will sp=
eed your build&quot;<br>
- =A0 =A0 =A0 =A0sstatemirror_widget, self.sstatemirror_text =3D self.gen_e=
ntry_widget(self.configuration.sstatemirror, self, tooltip)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse)<b=
r>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(sstatemirror_widget, expand=3DFalse, f=
ill=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0return advanced_vbox<br>
-<br>
- =A0 =A0def create_proxy_page(self):<br>
- =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.set_border_width(6)<br>
-<br>
- =A0 =A0 =A0 =A0sub_vbox =3D gtk.VBox(False, 6)<br>
- =A0 =A0 =A0 =A0advanced_vbox.pack_start(sub_vbox, expand=3DFalse, fill=3D=
False)<br>
- =A0 =A0 =A0 =A0label =3D self.gen_label_widget(&quot;&lt;span weight=3D\&=
quot;bold\&quot;&gt;Set the proxies that will be used during fetching sourc=
e code&lt;/span&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Set the proxies that will be used during=
 fetching source code or set none for direct the Internet connection&quot;<=
br>
- =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
- =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(label, expand=3DTrue, fill=3DTrue)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)<br=
>
-<br>
- =A0 =A0 =A0 =A0self.direct_checkbox =3D gtk.RadioButton(None, &quot;Direc=
t internet connection&quot;)<br>
- =A0 =A0 =A0 =A0self.direct_checkbox.set_tooltip_text(&quot;Check this box=
 to connect the Internet directly without any proxy&quot;)<br>
- =A0 =A0 =A0 =A0self.direct_checkbox.set_active(not self.configuration.ena=
ble_proxy)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(self.direct_checkbox, expand=3DFalse, =
fill=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0self.proxy_checkbox =3D gtk.RadioButton(self.direct_checkb=
ox, &quot;Manual proxy configuration&quot;)<br>
- =A0 =A0 =A0 =A0self.proxy_checkbox.set_tooltip_text(&quot;Check this box =
to setup the proxy you specified&quot;)<br>
- =A0 =A0 =A0 =A0self.proxy_checkbox.set_active(self.configuration.enable_p=
roxy)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(self.proxy_checkbox, expand=3DFalse, f=
ill=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0self.same_checkbox =3D gtk.CheckButton(&quot;Use the same =
proxy for all protocols&quot;)<br>
- =A0 =A0 =A0 =A0self.same_checkbox.set_tooltip_text(&quot;Use the same pro=
xy as the first proxy i.e. http proxy for all protocols&quot;)<br>
- =A0 =A0 =A0 =A0self.same_checkbox.set_active(self.configuration.same_prox=
y)<br>
- =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
- =A0 =A0 =A0 =A0hbox.pack_start(self.same_checkbox, expand=3DFalse, fill=
=3DFalse, padding=3D24)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)<br=
>
-<br>
- =A0 =A0 =A0 =A0proxy_widget, self.http_proxy, self.http_proxy_port, self.=
http_proxy_details =3D self.gen_proxy_entry_widget(<br>
- =A0 =A0 =A0 =A0 =A0 =A0&quot;http&quot;, self, True)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
-<br>
- =A0 =A0 =A0 =A0proxy_widget, self.https_proxy, self.https_proxy_port, sel=
f.https_proxy_details =3D self.gen_proxy_entry_widget(<br>
- =A0 =A0 =A0 =A0 =A0 =A0&quot;https&quot;, self, True)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
-<br>
- =A0 =A0 =A0 =A0proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ft=
p_proxy_details =3D self.gen_proxy_entry_widget(<br>
- =A0 =A0 =A0 =A0 =A0 =A0&quot;ftp&quot;, self, True)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
-<br>
- =A0 =A0 =A0 =A0proxy_widget, self.git_proxy, self.git_proxy_port, self.gi=
t_proxy_details =3D self.gen_proxy_entry_widget(<br>
- =A0 =A0 =A0 =A0 =A0 =A0&quot;git&quot;, self, True)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
-<br>
- =A0 =A0 =A0 =A0proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cv=
s_proxy_details =3D self.gen_proxy_entry_widget(<br>
- =A0 =A0 =A0 =A0 =A0 =A0&quot;cvs&quot;, self, True)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(proxy_widget, expand=3DFalse, fill=3DF=
alse)<br>
-<br>
- =A0 =A0 =A0 =A0self.direct_checkbox.connect(&quot;toggled&quot;, self.pro=
xy_checkbox_toggled_cb)<br>
- =A0 =A0 =A0 =A0self.proxy_checkbox.connect(&quot;toggled&quot;, self.prox=
y_checkbox_toggled_cb)<br>
- =A0 =A0 =A0 =A0self.same_checkbox.connect(&quot;toggled&quot;, self.same_=
checkbox_toggled_cb)<br>
-<br>
- =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
- =A0 =A0 =A0 =A0return advanced_vbox<br>
-<br>
+<br>
=A0 =A0 =A0def create_others_page(self):<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox.set_border_width(6)<br>
@@ -633,60 +809,7 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
<br>
=A0 =A0 =A0 =A0 =A0return advanced_vbox<br>
<br>
- =A0 =A0def refresh_proxy_components(self):<br>
- =A0 =A0 =A0 =A0self.same_checkbox.set_sensitive(self.configuration.enable=
_proxy)<br>
-<br>
- =A0 =A0 =A0 =A0self.http_proxy.set_text(self.configuration.combine_host_o=
nly(&quot;http&quot;))<br>
- =A0 =A0 =A0 =A0self.http_proxy.set_editable(self.configuration.enable_pro=
xy)<br>
- =A0 =A0 =A0 =A0self.http_proxy.set_sensitive(self.configuration.enable_pr=
oxy)<br>
- =A0 =A0 =A0 =A0self.http_proxy_port.set_text(self.configuration.combine_p=
ort_only(&quot;http&quot;))<br>
- =A0 =A0 =A0 =A0self.http_proxy_port.set_editable(self.configuration.enabl=
e_proxy)<br>
- =A0 =A0 =A0 =A0self.http_proxy_port.set_sensitive(self.configuration.enab=
le_proxy)<br>
- =A0 =A0 =A0 =A0self.http_proxy_details.set_sensitive(self.configuration.e=
nable_proxy)<br>
-<br>
- =A0 =A0 =A0 =A0self.https_proxy.set_text(self.configuration.combine_host_=
only(&quot;https&quot;))<br>
- =A0 =A0 =A0 =A0self.https_proxy.set_editable(self.configuration.enable_pr=
oxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.https_proxy.set_sensitive(self.configuration.enable_p=
roxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.https_proxy_port.set_text(self.configuration.combine_=
port_only(&quot;https&quot;))<br>
- =A0 =A0 =A0 =A0self.https_proxy_port.set_editable(self.configuration.enab=
le_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.https_proxy_port.set_sensitive(self.configuration.ena=
ble_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.https_proxy_details.set_sensitive(self.configuration.=
enable_proxy and (not self.configuration.same_proxy))<br>
-<br>
- =A0 =A0 =A0 =A0self.ftp_proxy.set_text(self.configuration.combine_host_on=
ly(&quot;ftp&quot;))<br>
- =A0 =A0 =A0 =A0self.ftp_proxy.set_editable(self.configuration.enable_prox=
y and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.ftp_proxy.set_sensitive(self.configuration.enable_pro=
xy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.ftp_proxy_port.set_text(self.configuration.combine_po=
rt_only(&quot;ftp&quot;))<br>
- =A0 =A0 =A0 =A0self.ftp_proxy_port.set_editable(self.configuration.enable=
_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.ftp_proxy_port.set_sensitive(self.configuration.enabl=
e_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.ftp_proxy_details.set_sensitive(self.configuration.en=
able_proxy and (not self.configuration.same_proxy))<br>
-<br>
- =A0 =A0 =A0 =A0self.git_proxy.set_text(self.configuration.combine_host_on=
ly(&quot;git&quot;))<br>
- =A0 =A0 =A0 =A0self.git_proxy.set_editable(self.configuration.enable_prox=
y and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.git_proxy.set_sensitive(self.configuration.enable_pro=
xy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.git_proxy_port.set_text(self.configuration.combine_po=
rt_only(&quot;git&quot;))<br>
- =A0 =A0 =A0 =A0self.git_proxy_port.set_editable(self.configuration.enable=
_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.git_proxy_port.set_sensitive(self.configuration.enabl=
e_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.git_proxy_details.set_sensitive(self.configuration.en=
able_proxy and (not self.configuration.same_proxy))<br>
-<br>
- =A0 =A0 =A0 =A0self.cvs_proxy.set_text(self.configuration.combine_host_on=
ly(&quot;cvs&quot;))<br>
- =A0 =A0 =A0 =A0self.cvs_proxy.set_editable(self.configuration.enable_prox=
y and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.cvs_proxy.set_sensitive(self.configuration.enable_pro=
xy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.cvs_proxy_port.set_text(self.configuration.combine_po=
rt_only(&quot;cvs&quot;))<br>
- =A0 =A0 =A0 =A0self.cvs_proxy_port.set_editable(self.configuration.enable=
_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.cvs_proxy_port.set_sensitive(self.configuration.enabl=
e_proxy and (not self.configuration.same_proxy))<br>
- =A0 =A0 =A0 =A0self.cvs_proxy_details.set_sensitive(self.configuration.en=
able_proxy and (not self.configuration.same_proxy))<br>
-<br>
- =A0 =A0def proxy_checkbox_toggled_cb(self, button):<br>
- =A0 =A0 =A0 =A0self.configuration.enable_proxy =3D self.proxy_checkbox.ge=
t_active()<br>
- =A0 =A0 =A0 =A0if not self.configuration.enable_proxy:<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.same_proxy =3D False<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.same_checkbox.set_active(self.configuration.s=
ame_proxy)<br>
- =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
-<br>
- =A0 =A0def same_checkbox_toggled_cb(self, button):<br>
- =A0 =A0 =A0 =A0self.configuration.same_proxy =3D self.same_checkbox.get_a=
ctive()<br>
- =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
-<br>
+<br>
=A0 =A0 =A0def response_cb(self, dialog, response_id):<br>
=A0 =A0 =A0 =A0 =A0package_format =3D []<br>
=A0 =A0 =A0 =A0 =A0package_format.append(self.rootfs_combo.get_active_text(=
))<br>
@@ -695,12 +818,7 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0package_format.append(child.get_label())=
<br>
=A0 =A0 =A0 =A0 =A0self.configuration.curr_package_format =3D &quot; &quot;=
.join(package_format)<br>
<br>
- =A0 =A0 =A0 =A0self.configuration.curr_distro =3D self.distro_combo.get_a=
ctive_text()<br>
- =A0 =A0 =A0 =A0self.configuration.dldir =3D self.dldir_text.get_text()<br=
>
- =A0 =A0 =A0 =A0self.configuration.sstatedir =3D self.sstatedir_text.get_t=
ext()<br>
- =A0 =A0 =A0 =A0self.configuration.sstatemirror =3D self.sstatemirror_text=
.get_text()<br>
- =A0 =A0 =A0 =A0self.configuration.bbthread =3D self.bb_spinner.get_value_=
as_int()<br>
- =A0 =A0 =A0 =A0self.configuration.pmake =3D self.pmake_spinner.get_value_=
as_int()<br>
+ =A0 =A0 =A0 =A0self.configuration.curr_distro =3D self.distro_combo.get_a=
ctive_text()<br>
=A0 =A0 =A0 =A0 =A0self.configuration.image_rootfs_size =3D self.rootfs_siz=
e_spinner.get_value_as_int() * 1024<br>
=A0 =A0 =A0 =A0 =A0self.configuration.image_extra_size =3D self.extra_size_=
spinner.get_value_as_int() * 1024<br>
<br>
@@ -727,19 +845,7 @@ class AdvancedSettingDialog (CrumbsDialog):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0key =3D self.setting_store.get_value(it, 0)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0value =3D self.setting_store.get_value(it, 1)<br=
>
=A0 =A0 =A0 =A0 =A0 =A0 =A0self.configuration.extra_setting[key] =3D value<=
br>
- =A0 =A0 =A0 =A0 =A0 =A0it =3D self.setting_store.iter_next(it)<br>
-<br>
- =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;http&quot;, self.http=
_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())<br>
- =A0 =A0 =A0 =A0if self.configuration.same_proxy:<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;https&quot;, =
self.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text(=
))<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;ftp&quot;, se=
lf.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;git&quot;, se=
lf.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;cvs&quot;, se=
lf.http_proxy.get_text() + &quot;:&quot; + self.http_proxy_port.get_text())=
<br>
- =A0 =A0 =A0 =A0else:<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;https&quot;, =
self.https_proxy.get_text() + &quot;:&quot; + self.https_proxy_port.get_tex=
t())<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;ftp&quot;, se=
lf.ftp_proxy.get_text() + &quot;:&quot; + self.ftp_proxy_port.get_text())<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;git&quot;, se=
lf.git_proxy.get_text() + &quot;:&quot; + self.git_proxy_port.get_text())<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0self.configuration.split_proxy(&quot;cvs&quot;, se=
lf.cvs_proxy.get_text() + &quot;:&quot; + self.cvs_proxy_port.get_text())<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0it =3D self.setting_store.iter_next(it)<br>
<br>
=A0 =A0 =A0 =A0 =A0md5 =3D self.config_md5()<br>
=A0 =A0 =A0 =A0 =A0self.settings_changed =3D (self.md5 !=3D md5)<br>
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/l=
ib/bb/ui/crumbs/imageconfigurationpage.py<br>
index 6aeb6dc..e665f38 100644<br>
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py<br>
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py<br>
@@ -205,17 +205,26 @@ class ImageConfigurationPage (HobPage):<br>
<br>
=A0 =A0 =A0 =A0 =A0self.image_desc =3D gtk.Label()<br>
=A0 =A0 =A0 =A0 =A0self.image_desc.set_alignment(0.0, 0.5)<br>
- =A0 =A0 =A0 =A0self.image_desc.set_size_request(360, -1)<br>
+ =A0 =A0 =A0 =A0self.image_desc.set_size_request(256, -1)<br>
=A0 =A0 =A0 =A0 =A0self.image_desc.set_justify(gtk.JUSTIFY_LEFT)<br>
=A0 =A0 =A0 =A0 =A0self.image_desc.set_line_wrap(True)<br>
<br>
+ =A0 =A0 =A0 =A0# button to view recipes<br>
+ =A0 =A0 =A0 =A0icon_file =3D hic.ICON_RCIPE_DISPLAY_FILE<br>
+ =A0 =A0 =A0 =A0hover_file =3D hic.ICON_RCIPE_HOVER_FILE<br>
+ =A0 =A0 =A0 =A0self.view_adv_configuration_button =3D HobImageButton(&quo=
t;Advanced configuration&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Select image =
types, package formats, etc&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 icon_file, hover_fi=
le)<br>
+ =A0 =A0 =A0 =A0self.view_adv_configuration_button.connect(&quot;clicked&q=
uot;, self.view_adv_configuration_button_clicked_cb)<br>
+<br>
=A0 =A0 =A0 =A0 =A0self.image_separator =3D gtk.HSeparator()<br>
<br>
=A0 =A0 =A0def set_config_baseimg_layout(self):<br>
=A0 =A0 =A0 =A0 =A0self.gtable.attach(self.image_title, 0, 40, 15, 17)<br>
=A0 =A0 =A0 =A0 =A0self.gtable.attach(self.image_title_desc, 0, 40, 18, 22)=
<br>
=A0 =A0 =A0 =A0 =A0self.gtable.attach(self.image_combo, 0, 12, 23, 26)<br>
- =A0 =A0 =A0 =A0self.gtable.attach(self.image_desc, 13, 38, 23, 28)<br>
+ =A0 =A0 =A0 =A0self.gtable.attach(self.image_desc, 0, 12, 27, 33)<br>
+ =A0 =A0 =A0 =A0self.gtable.attach(self.view_adv_configuration_button, 14,=
 36, 23, 28)<br>
=A0 =A0 =A0 =A0 =A0self.gtable.attach(self.image_separator, 0, 40, 35, 36)<=
br>
<br>
=A0 =A0 =A0def create_config_build_button(self):<br>
@@ -413,6 +422,14 @@ class ImageConfigurationPage (HobPage):<br>
=A0 =A0 =A0def layer_button_clicked_cb(self, button):<br>
=A0 =A0 =A0 =A0 =A0# Create a layer selection dialog<br>
=A0 =A0 =A0 =A0 =A0self.builder.show_layer_selection_dialog()<br>
+<br>
+ =A0 =A0def view_adv_configuration_button_clicked_cb(self, button):<br>
+ =A0 =A0 =A0 =A0# Create an advanced settings dialog<br>
+ =A0 =A0 =A0 =A0response, settings_changed =3D self.builder.show_adv_setti=
ngs_dialog()<br>
+ =A0 =A0 =A0 =A0if not response:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0return<br>
+ =A0 =A0 =A0 =A0if settings_changed:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0self.builder.reparse_post_adv_settings()<br>
<br>
=A0 =A0 =A0def just_bake_button_clicked_cb(self, button):<br>
=A0 =A0 =A0 =A0 =A0self.builder.just_bake()<br>
@@ -432,7 +449,7 @@ class ImageConfigurationPage (HobPage):<br>
<br>
=A0 =A0 =A0def settings_button_clicked_cb(self, button):<br>
=A0 =A0 =A0 =A0 =A0# Create an advanced settings dialog<br>
- =A0 =A0 =A0 =A0response, settings_changed =3D self.builder.show_adv_setti=
ngs_dialog()<br>
+ =A0 =A0 =A0 =A0response, settings_changed =3D self.builder.show_simple_se=
ttings_dialog()<br>
=A0 =A0 =A0 =A0 =A0if not response:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0return<br>
=A0 =A0 =A0 =A0 =A0if settings_changed:<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.5<br>
<br>
<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-deve=
l" target=3D"_blank">http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bi=
tbake-devel</a><br>
</font></span></blockquote></div><br></div>

--20cf3074b38635559b04c90a0b04--
