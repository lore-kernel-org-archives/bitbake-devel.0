Return-Path: <valentin.popa@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 74DA76B05F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2014 15:55:40 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Jan 2014 07:51:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,713,1384329600"; d="scan'208";a="471921623"
Received: from vpopa-desktop.rb.intel.com (HELO [10.237.105.47])
	([10.237.105.47])
	by orsmga002.jf.intel.com with ESMTP; 24 Jan 2014 07:55:12 -0800
Message-ID: <52E28CF1.8090206@intel.com>
Date: Fri, 24 Jan 2014 17:55:29 +0200
From: Valentin Popa <valentin.popa@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Irina Patru <irina.patru@intel.com>, bitbake-devel@lists.openembedded.org
References: <y> <1390319978-31756-1-git-send-email-irina.patru@intel.com>
	<1390319978-31756-3-git-send-email-irina.patru@intel.com>
In-Reply-To: <1390319978-31756-3-git-send-email-irina.patru@intel.com>
Subject: Re: [PATCH 3/4] hob: unsetting busy cursor after hitting Stop button
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
X-List-Received-Date: Fri, 24 Jan 2014 15:55:40 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/21/2014 05:59 PM, Irina Patru wrote:
> The busy cursor would never change after pressing Stop button.
> It should be set after the possible return inside machine_combo_changed_cb()
> method.
>
> Signed-off-by: Irina Patru <irina.patru@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> index 79709d0..6372592 100644
> --- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -304,14 +304,15 @@ class ImageConfigurationPage (HobPage):
>           self.builder.window.set_cursor(None)
>   
>       def machine_combo_changed_cb(self, machine_combo):
> -        self.builder.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
> -        self.builder.wait(0.1) #wait for combo and cursor to update
>           self.stopping = False
>           self.builder.parsing_warnings = []
>           combo_item = machine_combo.get_active_text()
>           if not combo_item or combo_item == self.__dummy_machine__:
>               return
>   
> +        self.builder.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
> +        self.builder.wait(0.1) #wait for combo and cursor to update
> +
>           # remove __dummy_machine__ item from the store list after first user selection
>           # because it is no longer valid
>           combo_store = machine_combo.get_model()

Looks good to me.

