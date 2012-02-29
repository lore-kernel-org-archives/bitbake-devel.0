Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDg-0003MQ-29
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:37:56 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979778"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:28 -0800
Message-ID: <4F4E98B8.1020601@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:28 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<d676659c5d1004ab527f343bc0d757ed61bd6c3f.1330523904.git.shane.wang@intel.com>
In-Reply-To: <d676659c5d1004ab527f343bc0d757ed61bd6c3f.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 29/32] Hob(crumbs/builder.py): adjust the main window's position and ignore the case lower than 1024x768.
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
X-List-Received-Date: Wed, 29 Feb 2012 21:37:56 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 06:15, Shane Wang wrote:
> * don't set the position of the main window to the center always
> * don't show the message to users if their screen dimensions are lower than 1024x768
>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>

Thanks!

Joshua

> ---
>   bitbake/lib/bb/ui/crumbs/builder.py |    8 --------
>   1 files changed, 0 insertions(+), 8 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index e9853f2..f41b6a4 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -229,20 +229,12 @@ class Builder(gtk.Window):
>       def create_visual_elements(self):
>           self.set_title("Hob - Image Creator")
>           self.set_icon_name("applications-development")
> -        self.set_position(gtk.WIN_POS_CENTER_ALWAYS)
>           self.set_resizable(True)
>           window_width = self.get_screen().get_width()
>           window_height = self.get_screen().get_height()
>           if window_width>= hwc.MAIN_WIN_WIDTH:
>               window_width = hwc.MAIN_WIN_WIDTH
>               window_height = hwc.MAIN_WIN_HEIGHT
> -        else:
> -            lbl = "<b>Screen dimension mismatched</b>\nfor better usability and visual effects,"
> -            lbl = lbl + " the screen dimension should be 1024x768 or above."
> -            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> -            dialog.run()
> -            dialog.destroy()
>           self.set_size_request(window_width, window_height)
>
>           self.vbox = gtk.VBox(False, 0)

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


