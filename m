Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Sd0nW-0005vW-56
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 17:08:22 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 Jun 2012 07:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="162897277"
Received: from unknown (HELO envy.home) ([10.255.12.197])
	by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2012 07:57:50 -0700
Message-ID: <4FD212A8.6080401@linux.intel.com>
Date: Fri, 08 Jun 2012 07:56:40 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Kang Kai <kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
	<bda43415c8822a6a47f955a7df6b382db29f7b33.1338976258.git.kai.kang@windriver.com>
In-Reply-To: <bda43415c8822a6a47f955a7df6b382db29f7b33.1338976258.git.kai.kang@windriver.com>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: Re: [PATCH 4/6] ui/crumbs/hig.py: check deploy process return value
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
X-List-Received-Date: Fri, 08 Jun 2012 15:08:22 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Kang,

A couple comments below...

On 06/06/2012 02:52 AM, Kang Kai wrote:
> Update function response_cb of DeployImageDialog to get deploy process
> return value. According the return value tell user that deploy image
> successfully or not.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hig.py |   32 +++++++++++++++++++++++++++++---
>  1 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
> index cf73145..97a3b22 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -827,12 +827,38 @@ class DeployImageDialog (CrumbsDialog):
>  
>      def response_cb(self, dialog, response_id):
>          if response_id == gtk.RESPONSE_YES:
> +            lbl = ''
>              combo_item = self.usb_combo.get_active_text()
> -            if combo_item and combo_item != self.__dummy_usb__:
> +            if combo_item and combo_item != self.__dummy_usb__ and self.image_path:
>                  cmdline = bb.ui.crumbs.utils.which_terminal()
>                  if cmdline:
> -                    cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
> -                    bb.process.Popen(shlex.split(cmdline))

This should be subprocess.call()

http://docs.python.org/library/subprocess.html

> +                    tmpname = os.tmpnam()
> +                    cmdline += "\"sudo dd if=" + self.image_path + \
> +                                " of=" + combo_item + "; echo $? > " + tmpname + "\""
> +                    deploy_process = bb.process.Popen(shlex.split(cmdline))
> +                    deploy_process.wait()
> +
> +                    # if file tmpname not exists, that means there is something wrong with xterm
> +                    # user can get the error message from xterm so no more warning need.
> +                    if os.path.exists(tmpname):
> +                        tmpfile = open(tmpname)
> +                        if int(tmpfile.readline().strip()) == 0:
> +                            lbl = "<b>Deploy image successfully</b>"

"<b>Deployed image successfully.</b>"

> +                        else:
> +                            lbl = "<b>Deploy image failed</b>\nPlease try again."

"<b>Failed to deploy image.</b>"

As to "Please try again." Why would the user have any expectation of a
different result? Is there something we can tell them about the reason
for the failure?

> +                        tmpfile.close()
> +                        os.remove(tmpname)
> +            else:
> +                if not self.image_path:
> +                    lbl = "<b>No selection made</b>\nYou have not selected an image to deploy"

Missing periods.

> +                else:
> +                    lbl = "<b>No selection made</b>\nYou have not selected USB device"

Missing periods. Missing article:

"<b>No selection made.</b>\nYou have not selected a USB device."


> +            if len(lbl):
> +                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> +                button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
> +                HobButton.style_button(button)
> +                crumbs_dialog.run()
> +                crumbs_dialog.destroy()
>  
>      def update_progress_bar(self, title, fraction, status=None):
>          self.progress_bar.update(fraction)

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


