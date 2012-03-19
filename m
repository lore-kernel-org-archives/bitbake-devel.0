Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mVa-0007io-EC
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:01:02 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 19 Mar 2012 16:52:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120838494"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 16:52:09 -0700
Message-ID: <4F67C6A9.1070902@linux.intel.com>
Date: Mon, 19 Mar 2012 16:52:09 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<3b656a55355058a1b845b675150b0e76ab83c1b2.1331910234.git.shane.wang@intel.com>
In-Reply-To: <3b656a55355058a1b845b675150b0e76ab83c1b2.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 09/12] Hob: fix static variable "self.search" to parameter "search" in signal callback function
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
X-List-Received-Date: Tue, 20 Mar 2012 00:01:02 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 08:10, Shane Wang wrote:
> From: Liming An<limingx.l.an@intel.com>
>
> To fix the signal callback function code, and make the temp parameter to replaced the static global variable, as required.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/hobwidget.py |   31 ++++++++++++++-----------------
>   1 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index 2afa975..e580d50 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -658,20 +658,17 @@ class HobNotebook(gtk.VBox):
>
>       def blank_area_resize_cb(self, widget, request_x, request_y, request_width, request_height):
>           self.search.set_size_request(request_width, request_height)
> -        widget.modify_bg(gtk.STATE_SELECTED, gtk.gdk.color_parse(HobColors.YELLOW))
> -
> -    def set_search_entry_editable_cb(self, widget, event):
> -        if self.search:
> -            self.search.set_editable(True)
> -            self.search.set_text("")
> -            style = self.search.get_style()
> -            style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
> -            self.search.set_style(style)
> -
> -    def set_search_entry_reset_cb(self, widget, event):
> -        if self.search:
> -            style = self.search.get_style()
> -            style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
> -            self.search.set_style(style)
> -            self.search.set_text(self.search_name)
> -            self.search.set_editable(False)
> +
> +    def set_search_entry_editable_cb(self, search, event):
> +        search.set_editable(True)
> +        search.set_text("")
> +        style = self.search.get_style()
> +        style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
> +        search.set_style(style)
> +
> +    def set_search_entry_reset_cb(self, search, event):
> +        style = search.get_style()
> +        style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
> +        search.set_style(style)
> +        search.set_text(self.search_name)
> +        search.set_editable(False)

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


