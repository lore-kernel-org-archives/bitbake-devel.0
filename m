Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBFoU-0002Uw-5Z
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 02:30:38 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 23 Mar 2012 18:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="122666159"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 23 Mar 2012 18:21:39 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F6D1E3D.60205@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<9b9c960eca1213d2f60f499278fba368e3e0e16d.1332545580.git.josh@linux.intel.com>
	<1332550859.1849.16.camel@dongxiao-osel>
	<4F6D1E3D.60205@linux.intel.com>
Date: Sat, 24 Mar 2012 09:19:29 +0800
Message-ID: <1332551969.1849.28.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org, Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 9/9] lib/bb/ui/crumbs: apply primary/secondary dialogue button styling
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
X-List-Received-Date: Sat, 24 Mar 2012 01:30:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 18:07 -0700, Joshua Lock wrote:
> On 23/03/12 18:00, Xu, Dongxiao wrote:
> > On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> >> The design calls for primary buttons which are orange and large and
> >> secondary buttons which are subtle with pale blue text. This is so that the
> >> user is drawn towards the primary action and their use of the application
> >> is more guided.
> >>
> >> This patch uses HobButton and HobAltButton classes to style all dialogue
> >> buttons accordingly.
> >>
> >> Fixes [YOCTO #2125]
> >>
> >> Signed-off-by: Joshua Lock<josh@linux.intel.com>
> >> ---
> >>   lib/bb/ui/crumbs/builder.py |  106 +++++++++++++++++++++++++++----------------
> >>   lib/bb/ui/crumbs/hig.py     |   34 ++++++++------
> >>   2 files changed, 87 insertions(+), 53 deletions(-)
> >>
> >> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> >> index 4eb374c..e27a239 100755
> >> --- a/lib/bb/ui/crumbs/builder.py
> >> +++ b/lib/bb/ui/crumbs/builder.py
> >> @@ -32,7 +32,7 @@ from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
> >>   from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
> >>   from bb.ui.crumbs.builddetailspage import BuildDetailsPage
> >>   from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
> >> -from bb.ui.crumbs.hobwidget import hwc
> >> +from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
> >>   from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
> >>                                AdvancedSettingDialog, LayerSelectionDialog, \
> >>                                DeployImageDialog
> >> @@ -435,7 +435,8 @@ class Builder(gtk.Window):
> >>               lbl = "<b>Error</b>\n"
> >>               lbl = lbl + "%s\n\n" % msg
> >>               dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
> >> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> +            HobButton.style_button(button)
> >>               response = dialog.run()
> >>               dialog.destroy()
> >>           self.handler.clear_busy()
> >> @@ -608,8 +609,10 @@ class Builder(gtk.Window):
> >>       def destroy_window_cb(self, widget, event):
> >>           lbl = "<b>Do you really want to exit the Hob image creator?</b>"
> >>           dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> >> -        dialog.add_button("Keep using Hob", gtk.RESPONSE_NO)
> >> -        dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
> >> +        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
> >> +        HobAltButton.style_button(button)
> >> +        button = dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
> >> +        HobButton.style_button(button)
> >>           dialog.set_default_response(gtk.RESPONSE_YES)
> >>           response = dialog.run()
> >>           dialog.destroy()
> >> @@ -625,7 +628,8 @@ class Builder(gtk.Window):
> >>               lbl = "<b>No selections made</b>\nYou have not made any selections"
> >>               lbl = lbl + " so there isn't anything to bake at this time."
> >>               dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> >> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> +            HobButton.style_button(button)
> >>               dialog.run()
> >>               dialog.destroy()
> >>               return
> >> @@ -637,7 +641,8 @@ class Builder(gtk.Window):
> >>               lbl = "<b>No selections made</b>\nYou have not made any selections"
> >>               lbl = lbl + " so there isn't anything to bake at this time."
> >>               dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> >> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> +            HobButton.style_button(button)
> >>               dialog.run()
> >>               dialog.destroy()
> >>               return
> >> @@ -652,7 +657,8 @@ class Builder(gtk.Window):
> >>               lbl = "<b>No selections made</b>\nYou have not made any selections"
> >>               lbl = lbl + " so there isn't anything to bake at this time."
> >>               dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> >> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> +            HobButton.style_button(button)
> >>               dialog.run()
> >>               dialog.destroy()
> >>               return
> >> @@ -672,8 +678,9 @@ class Builder(gtk.Window):
> >>                        parent = self,
> >>                        flags = gtk.DIALOG_MODAL
> >>                            | gtk.DIALOG_DESTROY_WITH_PARENT
> >> -                         | gtk.DIALOG_NO_SEPARATOR,
> >> -                     buttons = (gtk.STOCK_CLOSE, gtk.RESPONSE_YES))
> >> +                         | gtk.DIALOG_NO_SEPARATOR)
> >> +        button = dialog.add_button("Close", gtk.RESPONSE_YES)
> >> +        HobButton.style_button(button)
> >>           response = dialog.run()
> >>           if response == gtk.RESPONSE_YES:
> >>               self.configuration.layers = dialog.layers
> >
> > As my previous point, I still strongly suggest we keep the "cancel"
> > button in the layer selection and advanced setting dialog to avoid
> > user's wrong operation. Need Belen or Giulia's input.
> 
> They both responded via Bugzilla, I mistakenly thought you were on CC - 
> apologies.
> 
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=2083

Thanks for the information.

For Layer, I accept design team's idea to remove save and cancel button.
But still users may miss deleted some critical layers. For example, in
our Yocto project, users may wrongly deleted meta-yocto, which will
cause the system reporting error like:

"DISTRO poky not found. Please set a valid DISTRO in your local.conf"

This is because the poky distro is defined in meta-yocto layer, and user
deleted meta-yocto by mistake.

Do you think if it is reasonable to add a confirmation dialog when user
trying to delete a layer?

What about the save/cancel buttons in advanced setting dialog? Now I
only saw a "close" button there. What can we do if user miss configured
something that he/she doesn't want to save?

Thanks,
Dongxiao

> 
> Cheers,
> Joshua




