Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBFXI-0002Cd-GD
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 02:12:52 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2012 18:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121105807"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 18:03:54 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <6343e1553553426bf83318b8d74ecb0e1de39349.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<6343e1553553426bf83318b8d74ecb0e1de39349.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 09:01:43 +0800
Message-ID: <1332550903.1849.17.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 5/9] lib/bb/ui/crumbs/hobwidget: convert button styling logic to static methods
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
X-List-Received-Date: Sat, 24 Mar 2012 01:12:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> The design calls for all buttons to match the style of either the HobButton
> or HobAltButton classes, therefore implement the styling logic as static
> methods of the implementing classes so that we can more easily set styles
> for the buttons created by a gtk.Dialog (or subclass) without having to
> modify too much of the dialog instantiation code.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/hobwidget.py |   53 +++++++++++++++++++++++++---------------
>  1 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
> index 6b8fc1b..d6ed260 100644
> --- a/lib/bb/ui/crumbs/hobwidget.py
> +++ b/lib/bb/ui/crumbs/hobwidget.py
> @@ -204,49 +204,62 @@ class HobButton(gtk.Button):
>      label: the text to display as the button's label
>      """
>      def __init__(self, label):
> -        gtk.Button.__init__(self, "<span size='x-large'><b>%s</b></span>" % gobject.markup_escape_text(label))
> -        self.child.set_use_markup(True)
> +        gtk.Button.__init__(self, label)
> +        HobButton.style_button(self)
>  
> -        style = self.get_style()
> +    @staticmethod
> +    def style_button(button):
> +        style = button.get_style()
>          button_color = gtk.gdk.Color(HobColors.ORANGE)
> -        self.modify_bg(gtk.STATE_NORMAL, button_color)
> -        self.modify_bg(gtk.STATE_PRELIGHT, button_color)
> -        self.modify_bg(gtk.STATE_SELECTED, button_color)
> +        button.modify_bg(gtk.STATE_NORMAL, button_color)
> +        button.modify_bg(gtk.STATE_PRELIGHT, button_color)
> +        button.modify_bg(gtk.STATE_SELECTED, button_color)
> +
> +        button.set_flags(gtk.CAN_DEFAULT)
> +        button.grab_default()
>  
> -        self.set_flags(gtk.CAN_DEFAULT)
> -        self.grab_default()
> +        label = "<span size='x-large'><b>%s</b></span>" % gobject.markup_escape_text(button.get_label())
> +        button.set_label(label)
> +        button.child.set_use_markup(True)
>  
>  class HobAltButton(gtk.Button):
>      """
>      A gtk.Button subclass which has no relief, and so is more discrete
>      """
>      def __init__(self, label):
> -        gtk.Button.__init__(self)
> -        self.text = label
> -        self.set_text()
> -        self.set_relief(gtk.RELIEF_NONE)
> -        self.connect("state-changed", self.desensitise_on_state_change_cb)
> +        gtk.Button.__init__(self, label)
> +        HobAltButton.style_button(self)
>  
>      """
>      A callback for the state-changed event to ensure the text is displayed
>      differently when the widget is not sensitive
>      """
> -    def desensitise_on_state_change_cb(self, widget, state):
> -        if widget.get_state() == gtk.STATE_INSENSITIVE:
> -            self.set_text(False)
> +    @staticmethod
> +    def desensitise_on_state_change_cb(button, state):
> +        if button.get_state() == gtk.STATE_INSENSITIVE:
> +            HobAltButton.set_text(button, False)
>          else:
> -            self.set_text(True)
> +            HobAltButton.set_text(button, True)
>  
>      """
>      Set the button label with an appropriate colour for the current widget state
>      """
> -    def set_text(self, sensitive=True):
> +    @staticmethod
> +    def set_text(button, sensitive=True):
>          if sensitive:
>              colour = HobColors.PALE_BLUE
>          else:
>              colour = HobColors.LIGHT_GRAY
> -        self.set_label("<span color='%s'><b>%s</b></span>" % (colour, gobject.markup_escape_text(self.text)))
> -        self.child.set_use_markup(True)
> +        button.set_label("<span color='%s'><b>%s</b></span>" % (colour, gobject.markup_escape_text(button.text)))
> +        button.child.set_use_markup(True)
> +
> +    @staticmethod
> +    def style_button(button):
> +        button.text = button.get_label()
> +        button.connect("state-changed", HobAltButton.desensitise_on_state_change_cb)
> +        HobAltButton.set_text(button)
> +        button.child.set_use_markup(True)
> +        button.set_relief(gtk.RELIEF_NONE)
>  
>  class HobImageButton(gtk.Button):
>      """
> -- 
> 1.7.7.6
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel




