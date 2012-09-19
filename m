Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TEI2I-0003lH-IL
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Sep 2012 13:01:43 +0200
Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by mga09.intel.com with ESMTP/TLS/RC4-SHA; 19 Sep 2012 03:48:48 -0700
Received: by qcad10 with SMTP id d10so710284qca.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Sep 2012 03:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type:x-gm-message-state;
	bh=kVgDBclUTKsQrfnpBoIeh3sPGiHIHgrfqRa7/mXnRfs=;
	b=GT418u9RCnhAH76vF2lXw7pyVitAXMfet2psrfVOEUSrK9x8BmvWSV4iq8fUEd13/e
	FbJ1sfisOUl+9wQ5WIfxXMpa8iE/k80yTStrZwkGaMDjKmypSIZ51bzOXEE6HcTYXILL
	Py3aQbJIC9/gEWcZnT8RAWELPsEQCQlrzlQ+CoIUhx6WZVTwQxmGWmvTixQkhZKfr6J4
	+U1Or26Tdo/b1/ZSCuw456po9bgKPpiTo29ndDQHB3Jav4ql0k0Q4a0WtSbKeqbnluhv
	yuH+yi4wqbxsDvmn5pi+rF8U4+fM6Y2GiUd33XEjjZe96yScwK51baoirVlDQ115/6cq
	UW6A==
Received: by 10.224.189.5 with SMTP id dc5mr5969725qab.89.1348051738767; Wed,
	19 Sep 2012 03:48:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.49.74.74 with HTTP; Wed, 19 Sep 2012 03:48:38 -0700 (PDT)
In-Reply-To: <1348051775-2255-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1348051775-2255-1-git-send-email-bogdan.a.marinescu@intel.com>
From: "Marinescu, Bogdan A" <bogdan.a.marinescu@intel.com>
Date: Wed, 19 Sep 2012 13:48:38 +0300
Message-ID: <CAMZjud1w4dA9QwZQzjT-WgE7DRmh+qj=ywihwKodPd-xbyZCLw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQlseOQ5Tycru+Bmk1TF15mPOoDUszm58ZZYPOII+jB9oHzuAnKknCG1ZBPpolmoMYdf5YGN
Subject: Re: [PATCH v2] [hob] Fix settings
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
X-List-Received-Date: Wed, 19 Sep 2012 11:01:43 -0000
Content-Type: multipart/alternative; boundary=20cf30363e8b072f2e04ca0bc12c

--20cf30363e8b072f2e04ca0bc12c
Content-Type: text/plain; charset=ISO-8859-1

Please merge this patch, it's blocking other people who need to work on any
settings-related issue.

Thanks,
BogdanM

On Wed, Sep 19, 2012 at 1:49 PM, Bogdan Marinescu <
bogdan.a.marinescu@intel.com> wrote:

> Fix some issues with the settings dialog that were introduced as
> a result of merging the fix for #2162.
> The second version of the patch removes a stray "distro" combobox
> from simple settings.
>
> [YOCTO #3117]
>
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hig.py              |  228
> ++++++++++++--------------
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 +-
>  2 files changed, 110 insertions(+), 120 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py
> b/bitbake/lib/bb/ui/crumbs/hig.py
> index ff0ad17..f304a68 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -195,7 +195,6 @@ class SimpleSettingsDialog (CrumbsDialog,
> SettingsUIHelper):
>          self.max_threads = max_threads
>
>          # class members for internal use
> -        self.distro_combo = None
>          self.dldir_text = None
>          self.sstatedir_text = None
>          self.sstatemirror_text = None
> @@ -330,7 +329,6 @@ class SimpleSettingsDialog (CrumbsDialog,
> SettingsUIHelper):
>          self.refresh_proxy_components()
>
>      def response_cb(self, dialog, response_id):
> -        #self.configuration.curr_distro =
> self.distro_combo.get_active_text()
>          self.configuration.dldir = self.dldir_text.get_text()
>          self.configuration.sstatedir = self.sstatedir_text.get_text()
>          self.configuration.sstatemirror =
> self.sstatemirror_text.get_text()
> @@ -352,6 +350,115 @@ class SimpleSettingsDialog (CrumbsDialog,
> SettingsUIHelper):
>          md5 = self.config_md5()
>          self.settings_changed = (self.md5 != md5)
>
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
> proxies used when fetching source code</span>")
> +        tooltip = "Set the proxies used when fetching source code.  A
> blank field uses a direct internet connection."
> +        info = HobInfoButton(tooltip, self)
> +        hbox = gtk.HBox(False, 12)
> +        hbox.pack_start(label, expand=True, fill=True)
> +        hbox.pack_start(info, expand=False, fill=False)
> +        sub_vbox.pack_start(hbox, expand=False, fill=False)
> +
> +        self.direct_checkbox = gtk.RadioButton(None, "Direct internet
> connection")
> +        self.direct_checkbox.set_tooltip_text("Check this box to use a
> direct internet connection with no proxy")
> +        self.direct_checkbox.set_active(not
> self.configuration.enable_proxy)
> +        sub_vbox.pack_start(self.direct_checkbox, expand=False,
> fill=False)
> +
> +        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox,
> "Manual proxy configuration")
> +        self.proxy_checkbox.set_tooltip_text("Check this box to manually
> set up a specific proxy")
> +        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
> +        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
> +
> +        self.same_checkbox = gtk.CheckButton("Use the same proxy for all
> protocols")
> +        self.same_checkbox.set_tooltip_text("Check this box to use the
> HTTP proxy for all five proxies")
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
> +
> +        self.direct_checkbox.connect("toggled",
> self.proxy_checkbox_toggled_cb)
> +        self.proxy_checkbox.connect("toggled",
> self.proxy_checkbox_toggled_cb)
> +        self.same_checkbox.connect("toggled",
> self.same_checkbox_toggled_cb)
> +
> +        self.refresh_proxy_components()
> +        return advanced_vbox
> +
> +
>      def create_visual_elements(self):
>          self.nb = gtk.Notebook()
>          self.nb.set_show_tabs(True)
> @@ -364,7 +471,6 @@ class SimpleSettingsDialog (CrumbsDialog,
> SettingsUIHelper):
>          self.show_all()
>
>
> -
>  #
>  # AdvancedSettings Dialog
>  #
> @@ -685,122 +791,6 @@ class AdvancedSettingDialog (CrumbsDialog,
> SettingsUIHelper):
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
> proxies used when fetching source code</span>")
> -        tooltip = "Set the proxies used when fetching source code.  A
> blank field uses a direct internet connection."
> -        info = HobInfoButton(tooltip, self)
> -        hbox = gtk.HBox(False, 12)
> -        hbox.pack_start(label, expand=True, fill=True)
> -        hbox.pack_start(info, expand=False, fill=False)
> -        sub_vbox.pack_start(hbox, expand=False, fill=False)
> -
> -        self.direct_checkbox = gtk.RadioButton(None, "Direct internet
> connection")
> -        self.direct_checkbox.set_tooltip_text("Check this box to use a
> direct internet connection with no proxy")
> -        self.direct_checkbox.set_active(not
> self.configuration.enable_proxy)
> -        sub_vbox.pack_start(self.direct_checkbox, expand=False,
> fill=False)
> -
> -        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox,
> "Manual proxy configuration")
> -        self.proxy_checkbox.set_tooltip_text("Check this box to manually
> set up a specific proxy")
> -        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
> -        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
> -
> -        self.same_checkbox = gtk.CheckButton("Use the same proxy for all
> protocols")
> -        self.same_checkbox.set_tooltip_text("Check this box to use the
> HTTP proxy for all five proxies")
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
>      def create_others_page(self):
>          advanced_vbox = gtk.VBox(False, 6)
>          advanced_vbox.set_border_width(6)
> diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> index ed8c7ac..5a6cb21 100755
> --- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> @@ -587,7 +587,7 @@ class ImageDetailsPage (HobPage):
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

--20cf30363e8b072f2e04ca0bc12c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Please merge this patch, it&#39;s blocking other people who need to work on=
 any settings-related issue.<div><br></div><div>Thanks,</div><div>BogdanM<b=
r><br><div class=3D"gmail_quote">On Wed, Sep 19, 2012 at 1:49 PM, Bogdan Ma=
rinescu <span dir=3D"ltr">&lt;<a href=3D"mailto:bogdan.a.marinescu@intel.co=
m" target=3D"_blank">bogdan.a.marinescu@intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Fix some issues with the settings dialog tha=
t were introduced as<br>
a result of merging the fix for #2162.<br>
The second version of the patch removes a stray &quot;distro&quot; combobox=
<br>
from simple settings.<br>
<br>
[YOCTO #3117]<br>
<br>
Signed-off-by: Bogdan Marinescu &lt;<a href=3D"mailto:bogdan.a.marinescu@in=
tel.com">bogdan.a.marinescu@intel.com</a>&gt;<br>
---<br>
=A0bitbake/lib/bb/ui/crumbs/hig.py =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0228 ++++=
++++++++--------------<br>
=A0bitbake/lib/bb/ui/crumbs/imagedetailspage.py | =A0 =A02 +-<br>
=A02 files changed, 110 insertions(+), 120 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig=
.py<br>
index ff0ad17..f304a68 100644<br>
--- a/bitbake/lib/bb/ui/crumbs/hig.py<br>
+++ b/bitbake/lib/bb/ui/crumbs/hig.py<br>
@@ -195,7 +195,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHel=
per):<br>
=A0 =A0 =A0 =A0 =A0self.max_threads =3D max_threads<br>
<br>
=A0 =A0 =A0 =A0 =A0# class members for internal use<br>
- =A0 =A0 =A0 =A0self.distro_combo =3D None<br>
=A0 =A0 =A0 =A0 =A0self.dldir_text =3D None<br>
=A0 =A0 =A0 =A0 =A0self.sstatedir_text =3D None<br>
=A0 =A0 =A0 =A0 =A0self.sstatemirror_text =3D None<br>
@@ -330,7 +329,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHel=
per):<br>
=A0 =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
<br>
=A0 =A0 =A0def response_cb(self, dialog, response_id):<br>
- =A0 =A0 =A0 =A0#self.configuration.curr_distro =3D self.distro_combo.get_=
active_text()<br>
=A0 =A0 =A0 =A0 =A0self.configuration.dldir =3D self.dldir_text.get_text()<=
br>
=A0 =A0 =A0 =A0 =A0self.configuration.sstatedir =3D self.sstatedir_text.get=
_text()<br>
=A0 =A0 =A0 =A0 =A0self.configuration.sstatemirror =3D self.sstatemirror_te=
xt.get_text()<br>
@@ -352,6 +350,115 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIH=
elper):<br>
=A0 =A0 =A0 =A0 =A0md5 =3D self.config_md5()<br>
=A0 =A0 =A0 =A0 =A0self.settings_changed =3D (self.md5 !=3D md5)<br>
<br>
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
quot;bold\&quot;&gt;Set the proxies used when fetching source code&lt;/span=
&gt;&quot;)<br>
+ =A0 =A0 =A0 =A0tooltip =3D &quot;Set the proxies used when fetching sourc=
e code. =A0A blank field uses a direct internet connection.&quot;<br>
+ =A0 =A0 =A0 =A0info =3D HobInfoButton(tooltip, self)<br>
+ =A0 =A0 =A0 =A0hbox =3D gtk.HBox(False, 12)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(label, expand=3DTrue, fill=3DTrue)<br>
+ =A0 =A0 =A0 =A0hbox.pack_start(info, expand=3DFalse, fill=3DFalse)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(hbox, expand=3DFalse, fill=3DFalse)<br=
>
+<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox =3D gtk.RadioButton(None, &quot;Direc=
t internet connection&quot;)<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox.set_tooltip_text(&quot;Check this box=
 to use a direct internet connection with no proxy&quot;)<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox.set_active(not self.configuration.ena=
ble_proxy)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(self.direct_checkbox, expand=3DFalse, =
fill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox =3D gtk.RadioButton(self.direct_checkb=
ox, &quot;Manual proxy configuration&quot;)<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox.set_tooltip_text(&quot;Check this box =
to manually set up a specific proxy&quot;)<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox.set_active(self.configuration.enable_p=
roxy)<br>
+ =A0 =A0 =A0 =A0sub_vbox.pack_start(self.proxy_checkbox, expand=3DFalse, f=
ill=3DFalse)<br>
+<br>
+ =A0 =A0 =A0 =A0self.same_checkbox =3D gtk.CheckButton(&quot;Use the same =
proxy for all protocols&quot;)<br>
+ =A0 =A0 =A0 =A0self.same_checkbox.set_tooltip_text(&quot;Check this box t=
o use the HTTP proxy for all five proxies&quot;)<br>
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
+<br>
+ =A0 =A0 =A0 =A0self.direct_checkbox.connect(&quot;toggled&quot;, self.pro=
xy_checkbox_toggled_cb)<br>
+ =A0 =A0 =A0 =A0self.proxy_checkbox.connect(&quot;toggled&quot;, self.prox=
y_checkbox_toggled_cb)<br>
+ =A0 =A0 =A0 =A0self.same_checkbox.connect(&quot;toggled&quot;, self.same_=
checkbox_toggled_cb)<br>
+<br>
+ =A0 =A0 =A0 =A0self.refresh_proxy_components()<br>
+ =A0 =A0 =A0 =A0return advanced_vbox<br>
+<br>
+<br>
=A0 =A0 =A0def create_visual_elements(self):<br>
=A0 =A0 =A0 =A0 =A0self.nb =3D gtk.Notebook()<br>
=A0 =A0 =A0 =A0 =A0self.nb.set_show_tabs(True)<br>
@@ -364,7 +471,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHel=
per):<br>
=A0 =A0 =A0 =A0 =A0self.show_all()<br>
<br>
<br>
-<br>
=A0#<br>
=A0# AdvancedSettings Dialog<br>
=A0#<br>
@@ -685,122 +791,6 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUI=
Helper):<br>
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
quot;bold\&quot;&gt;Set the proxies used when fetching source code&lt;/span=
&gt;&quot;)<br>
- =A0 =A0 =A0 =A0tooltip =3D &quot;Set the proxies used when fetching sourc=
e code. =A0A blank field uses a direct internet connection.&quot;<br>
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
 to use a direct internet connection with no proxy&quot;)<br>
- =A0 =A0 =A0 =A0self.direct_checkbox.set_active(not self.configuration.ena=
ble_proxy)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(self.direct_checkbox, expand=3DFalse, =
fill=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0self.proxy_checkbox =3D gtk.RadioButton(self.direct_checkb=
ox, &quot;Manual proxy configuration&quot;)<br>
- =A0 =A0 =A0 =A0self.proxy_checkbox.set_tooltip_text(&quot;Check this box =
to manually set up a specific proxy&quot;)<br>
- =A0 =A0 =A0 =A0self.proxy_checkbox.set_active(self.configuration.enable_p=
roxy)<br>
- =A0 =A0 =A0 =A0sub_vbox.pack_start(self.proxy_checkbox, expand=3DFalse, f=
ill=3DFalse)<br>
-<br>
- =A0 =A0 =A0 =A0self.same_checkbox =3D gtk.CheckButton(&quot;Use the same =
proxy for all protocols&quot;)<br>
- =A0 =A0 =A0 =A0self.same_checkbox.set_tooltip_text(&quot;Check this box t=
o use the HTTP proxy for all five proxies&quot;)<br>
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
=A0 =A0 =A0def create_others_page(self):<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox =3D gtk.VBox(False, 6)<br>
=A0 =A0 =A0 =A0 =A0advanced_vbox.set_border_width(6)<br>
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/=
ui/crumbs/imagedetailspage.py<br>
index ed8c7ac..5a6cb21 100755<br>
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py<br>
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py<br>
@@ -587,7 +587,7 @@ class ImageDetailsPage (HobPage):<br>
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
</font></span></blockquote></div><br></div>

--20cf30363e8b072f2e04ca0bc12c--
