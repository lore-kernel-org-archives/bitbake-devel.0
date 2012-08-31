Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T7MCX-0003Px-2X for bitbake-devel@lists.openembedded.org;
	Fri, 31 Aug 2012 10:03:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7V0hOfZ006238;
	Fri, 31 Aug 2012 01:43:24 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05772-03; Fri, 31 Aug 2012 01:43:20 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7V0hCVQ006230
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 31 Aug 2012 01:43:14 +0100
Message-ID: <1346373791.16485.21.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Thu, 30 Aug 2012 17:43:11 -0700
In-Reply-To: <1346326935-12569-1-git-send-email-cristiana.voicu@intel.com>
References: <1346326935-12569-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: Hob "Edit packages" page now restores correctly previously selected packages list upon "Back" action
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
X-List-Received-Date: Fri, 31 Aug 2012 08:03:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-08-30 at 14:42 +0300, Cristiana Voicu wrote:
> Fixes [YOCTO 2984]
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>

Could you tweak this commit message a bit please. The subject needs to
be more specific and concise including a suitable prefix about the area
being changed, something like:

"hob/packageselection: Correctly restore previously selected packages"

You then need a longer description of why the change is necessary as
well as what changed.

The correct form for the bug number is simply:

[YOCTO #2984]

I know this probably sounds picky but people do appreciate decent commit
messages when looking back in time and some simple tweaks like this can
make a big difference.

Cheers,

Richard


>  bitbake/lib/bb/ui/crumbs/builder.py              |   10 +++++++++-
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    3 +++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 7de4798..c6e0f39 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -123,6 +123,7 @@ class Configuration:
>          self.selected_image = None
>          self.selected_recipes = []
>          self.selected_packages = []
> +        self.initial_selected_packages = []
>  
>      def split_proxy(self, protocol, proxy):
>          entry = []
> @@ -519,6 +520,12 @@ class Builder(gtk.Window):
>          self.handler.reset_build()
>          self.handler.generate_packages(all_recipes, self.configuration.default_task)
>  
> +    def restore_initial_selected_packages(self):
> +        self.package_model.set_selected_packages(self.configuration.initial_selected_packages)
> +        for package in self.configuration.selected_packages:
> +            if package not in self.configuration.initial_selected_packages:
> +                self.package_model.exclude_item(self.package_model.find_path_for_item(package))
> +
>      def fast_generate_image_async(self, log = False):
>          self.switch_page(self.FAST_IMAGE_GENERATING)
>          if log:
> @@ -658,6 +665,7 @@ class Builder(gtk.Window):
>              self.build_details_page.show_page(next_step)
>  
>          elif next_step == self.PACKAGE_GENERATED:
> +            self.configuration.initial_selected_packages = self.configuration.selected_packages
>              if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
>                  self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
>              else:
> @@ -1334,4 +1342,4 @@ class Builder(gtk.Window):
>              format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
>              self.consolelog.setFormatter(format)
>  
> -            self.logger.addHandler(self.consolelog)
> \ No newline at end of file
> +            self.logger.addHandler(self.consolelog)
> diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> index 3576ed5..89bf047 100755
> --- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> @@ -192,6 +192,9 @@ class PackageSelectionPage (HobPage):
>          self.builder.build_image()
>  
>      def back_button_clicked_cb(self, button):
> +        self.builder.restore_initial_selected_packages()
> +        self.refresh_selection()
> +
>          if self.builder.current_step ==  self.builder.PACKAGE_GENERATED:
>              self.builder.show_recipes()
>          elif self.builder.previous_step ==  self.builder.IMAGE_GENERATED:




