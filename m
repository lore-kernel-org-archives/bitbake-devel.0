Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Sd0r5-0006j1-3u
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 17:12:03 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 08 Jun 2012 08:01:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="153564185"
Received: from unknown (HELO envy.home) ([10.255.12.197])
	by azsmga001.ch.intel.com with ESMTP; 08 Jun 2012 08:01:30 -0700
Message-ID: <4FD21380.7040301@linux.intel.com>
Date: Fri, 08 Jun 2012 08:00:16 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Kang Kai <kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
	<d747392a7c89b78719690974b00ec4a2d8c42fcd.1338976258.git.kai.kang@windriver.com>
In-Reply-To: <d747392a7c89b78719690974b00ec4a2d8c42fcd.1338976258.git.kai.kang@windriver.com>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: Re: [PATCH 5/6] hob2: update DeployImageDialog for seperated tool
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
X-List-Received-Date: Fri, 08 Jun 2012 15:12:03 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 06/06/2012 02:52 AM, Kang Kai wrote:
> Part of [Yocto 2388]
> 
> Update class DeployImageDialog to get ready for a standalone deploy
> image tool. The standalone tool can be run directly without hob, and
> add a button to select image file. So adjust the layout of
> DeployImageDialog.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hig.py |   43 +++++++++++++++++++++++++++++++++-----
>  1 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
> index 97a3b22..3b50f68 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -749,21 +749,28 @@ class DeployImageDialog (CrumbsDialog):
>  
>      __dummy_usb__ = "--select a usb drive--"
>  
> -    def __init__(self, title, image_path, parent, flags, buttons=None):
> +    def __init__(self, title, image_path, parent, flags, buttons=None, standalone=False):
>          super(DeployImageDialog, self).__init__(title, parent, flags, buttons)
>  
>          self.image_path = image_path
> +        self.standalone = standalone
>  
>          self.create_visual_elements()
>          self.connect("response", self.response_cb)
>  
>      def create_visual_elements(self):
> +        self.set_size_request(600, 400)
>          label = gtk.Label()
>          label.set_alignment(0.0, 0.5)
>          markup = "<span font_desc='12'>The image to be written into usb drive:</span>"
>          label.set_markup(markup)
>          self.vbox.pack_start(label, expand=False, fill=False, padding=2)
>  
> +        table = gtk.Table(2, 10, False)
> +        table.set_col_spacings(5)
> +        table.set_row_spacings(5)
> +        self.vbox.pack_start(table, expand=True, fill=True)
> +
>          scroll = gtk.ScrolledWindow()
>          scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
>          scroll.set_shadow_type(gtk.SHADOW_IN)
> @@ -771,11 +778,26 @@ class DeployImageDialog (CrumbsDialog):
>          tv.set_editable(False)
>          tv.set_wrap_mode(gtk.WRAP_WORD)
>          tv.set_cursor_visible(False)
> -        buf = gtk.TextBuffer()
> -        buf.set_text(self.image_path)
> -        tv.set_buffer(buf)
> +        self.buf = gtk.TextBuffer()
> +        self.buf.set_text(self.image_path)
> +        tv.set_buffer(self.buf)
>          scroll.add(tv)
> -        self.vbox.pack_start(scroll, expand=True, fill=True)
> +        table.attach(scroll, 0, 10, 0, 1)
> +

The following block probably warrants a comment regarding why this is
needed as it isn't obvious reading the code.

> +        if self.standalone:
> +                gobject.signal_new("select_image_clicked", self, gobject.SIGNAL_RUN_FIRST,
> +                                   gobject.TYPE_NONE, ())
> +                icon = gtk.Image()
> +                pix_buffer = gtk.gdk.pixbuf_new_from_file(hic.ICON_IMAGES_DISPLAY_FILE)
> +                icon.set_from_pixbuf(pix_buffer)
> +                button = gtk.Button("Select Image")
> +                button.set_image(icon)
> +                button.set_size_request(140, 50)
> +                table.attach(button, 9, 10, 1, 2, gtk.FILL, 0, 0, 0)
> +                button.connect("clicked", self.select_image_button_clicked_cb)
> +
> +        separator = gtk.HSeparator()
> +        self.vbox.pack_start(separator, expand=False, fill=False, padding=10)
>  
>          self.usb_desc = gtk.Label()
>          self.usb_desc.set_alignment(0.0, 0.5)
> @@ -790,7 +812,7 @@ class DeployImageDialog (CrumbsDialog):
>          for usb in self.find_all_usb_devices():
>              self.usb_combo.append_text("/dev/" + usb)
>          self.usb_combo.set_active(0)
> -        self.vbox.pack_start(self.usb_combo, expand=True, fill=True)
> +        self.vbox.pack_start(self.usb_combo, expand=False, fill=False)
>          self.vbox.pack_start(self.usb_desc, expand=False, fill=False, padding=2)
>  
>          self.progress_bar = HobProgressBar()
> @@ -801,6 +823,12 @@ class DeployImageDialog (CrumbsDialog):
>          self.vbox.show_all()
>          self.progress_bar.hide()
>  
> +    def set_image_text_buffer(self, image_path):
> +        self.buf.set_text(image_path)
> +
> +    def set_image_path(self, image_path):
> +        self.image_path = image_path
> +
>      def popen_read(self, cmd):
>          tmpout, errors = bb.process.run("%s" % cmd)
>          return tmpout.strip()
> @@ -816,6 +844,9 @@ class DeployImageDialog (CrumbsDialog):
>              (self.popen_read('cat /sys/class/block/%s/device/vendor' % dev),
>              self.popen_read('cat /sys/class/block/%s/device/model' % dev))
>  
> +    def select_image_button_clicked_cb(self, button):
> +            self.emit('select_image_clicked')
> +
>      def usb_combo_changed_cb(self, usb_combo):
>          combo_item = self.usb_combo.get_active_text()
>          if not combo_item or combo_item == self.__dummy_usb__:

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


