Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SCL0k-00028c-9g
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 03:15:46 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 26 Mar 2012 18:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121975962"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 26 Mar 2012 18:06:44 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>
In-Reply-To: <40776A41FC278F40B59438AD47D147A90FCFE9B5@SHSMSX102.ccr.corp.intel.com>
References: <1332742237.1849.74.camel@dongxiao-osel>
	<CB96351B.B20D%belen.barros.pena@intel.com>
	<40776A41FC278F40B59438AD47D147A90FCFE9B5@SHSMSX102.ccr.corp.intel.com>
Date: Tue, 27 Mar 2012 09:04:28 +0800
Message-ID: <1332810268.1849.89.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: FW: [PATCH 9/9] lib/bb/ui/crumbs: apply primary/secondary dialogue button styling
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
X-List-Received-Date: Tue, 27 Mar 2012 01:15:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Barros Pena, Belen 
> Sent: Monday, March 26, 2012 10:59 PM
> To: Xu, Dongxiao; Wang, Shane; Joshua Lock
> Cc: bitbake-devel@lists.openembedded.org; Giulia Piu
> Subject: Re: [bitbake-devel] [PATCH 9/9] lib/bb/ui/crumbs: apply primary/secondary dialogue button styling
> 
> Hi all,
> 
> Just a few comments:
> 
> >still users may miss deleted some critical layers. For example, in our 
> >Yocto project, users may wrongly deleted meta-yocto, which will cause 
> >the system reporting error like: "DISTRO poky not found. Please set a 
> >valid DISTRO in your local.conf"
> >This is because the poky distro is defined in meta-yocto layer, and 
> >user deleted meta-yocto by mistake.
> 
> We designed the Layers dialog so that it is not possible to delete the meta layer. If deleting the meta-yocto layer is also going to cause problems that a novice might not be able to recover from, then we should consider applying the same approach to the meta-yocto layer so that it cannot be removed. If anybody has any reasons why this is not a good idea, please let me know.

meta-yocto layer COULD be removed, the reason that users could see error
by removing that layer is because "local.conf" defaultly set "poky" as
the DISTRO, which is defined in meta-yocto layer. But anyway, we can
remove that layer.

> 
> >I saw in the design document(Hob_1.2_screens_inventory.pdf), there are 
> >"save" and "cancel" button in advanced setting page.
> 
> Quoting the Gnome HIG
> (http://developer.gnome.org/hig-book/3.0/windows-utility.html.en):
> 
> Do not make the user press an OK or Apply button to make the changes happen, unless either:
> 
> * the change will take more than about one second to apply, in which case applying the change immediately could make the system feel slow or unresponsive, or
> * the changes in the window have to be applied simultaneously to prevent the system entering a potentially unstable state. For example, the hostname and proxy fields in a network properties window.
> 
> The Settings dialog is so complex and edits so many different variables that I assumed it could fall into one of the 2 points above. That's why I designed it as an Explicit Apply window. If my assumption it's incorrect, please go ahead and remove the Save and Cancel buttons: I'll be very happy to see them go :) Keep in mind that we'll still need a close button to dismiss the dialog.

Thanks for the explanation. I think we have an agreement here that we
SHOULD have "cancel" and "save" button for advanced setting page.

But why we still need a close button? Is "cancel" not enough for that?

> 
> >The design team wants to make few interactions and make things simple.
> >The engineering team wants to give the users a chance to restore to the 
> >default or skip the changes he/she has made.
> >What if the user removes a layer in error?
> 
> These are the reasons why we have designed the Layers dialog as an instant apply window:
> 
> 1. Because it's how the Gnome HIG recommends doing things, and we have no evidence of any kind suggesting this is the wrong approach for the Layers dialog.
> 2. Because deleting a layer by mistake constitutes an edge case: I am sure you will agree users will probably not be deleting layers by mistake all the time. I try not to optimise designs for edge cases, but for the main use cases while preventing catastrophic errors (hence the decision to make the meta layer non-removable).
> 
> Having said this, feel free to make the decision you consider appropriate
> :)

From importance point of view, I think layer selection is the most
fundamental thing to build an customized image, and I think it is more
critical than "advanced setting".

From other point of view, the change of layers will definitely cost more
than one second to happen. There are two cases:

1) Change the layer when MACHINE is not selected.
This process contains: init_cooker() --> set_layer() --> parse_config()
--> get available machine/distro/sdk list, etc.
The above process costs about 1~2 seconds.

2) Change the layer when MACHINE is already selected.
This process contains: init_cooker() --> set_layer() --> parse_config()
--> get available machine/distro/sdk list. --> Parse BB files
The above process costs about 10~30 seconds, depending on the existing
parsing cache.

Therefore I think if we follow the HIG standard, we may also need a
"save" and "cancel" button for the layer selection.

> 
> 
> 
> >Do you think if it is reasonable to add a confirmation dialog when user 
> >trying to delete a layer?
> 
> 
> I can see why you are suggesting this approach (particularly in the case of the meta-yocto layer), but I rather not add an extra step to any process unless it is absolutely necessary. I tend to favour providing undo functionality instead.
> 
> I am going to copy this thread on the relevant bug to make sure we have all our conversations in the same place. Otherwise it'll be hard to follow and fully understand our design decisions if we need to go back to them in the future. 
> 
> 

Yes, I agree. Please ignore this comment from me.

Thanks,
Dongxiao

> 
> 
> Cheers
> 
> Belen
> 
> 
> 
> On 26/03/2012 07:10, "Xu, Dongxiao" <dongxiao.xu@intel.com> wrote:
> 
> >On Mon, 2012-03-26 at 12:07 +0800, Wang, Shane wrote:
> >> That is really conflict.
> >> 
> >> The design team wants to make few interactions and make things simple.
> >> The engineering team wants to give the users a chance to restore to 
> >>the default or skip the changes he/she has made.
> >> 
> >> The previous solution with "Save" and "Cancel" is an option.
> >> The current solution with "Close" is an option. What if the user 
> >>removes a layer in error?
> >> What Dongxiao suggested to ask users to confirm is also an option. 
> >>But what if there are a lot of layers to remove and a lot of 
> >>confirmation dialogs for impatient users?
> >> 
> >> I also have a bug filed by Josh to remember settings between Hob 
> >>sessions. QA raised an issue today that in Hob 1.1, when the user 
> >>changes some settings and save, which is supposed to cause an error 
> >>and make Hob not runable. Then, QA doesn't have any chance to initiate 
> >>a clean running, unless the build directory is deleted and "source" to 
> >>another directory.
> >> 
> >> Comments?
> >
> >I saw in the design document(Hob_1.2_screens_inventory.pdf), there are 
> >"save" and "cancel" button in advanced setting page.
> >
> >I still for the layer dialog, the question is still open. I think my 
> >point of view is similar with Shane's, that is to allow users have the 
> >chance to ignore the change that he/she made in mistake.
> >
> >Thanks,
> >Dongxiao
> >
> >> 
> >> --
> >> Shane
> >> 
> >> Xu, Dongxiao wrote on 2012-03-24:
> >> 
> >> > On Fri, 2012-03-23 at 18:07 -0700, Joshua Lock wrote:
> >> >> On 23/03/12 18:00, Xu, Dongxiao wrote:
> >> >>> On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> >> >>>> The design calls for primary buttons which are orange and large 
> >> >>>> and secondary buttons which are subtle with pale blue text. This 
> >> >>>> is so that the user is drawn towards the primary action and 
> >> >>>> their use of the application is more guided.
> >> >>>> 
> >> >>>> This patch uses HobButton and HobAltButton classes to style all
> >>dialogue
> >> >>>> buttons accordingly.
> >> >>>> 
> >> >>>> Fixes [YOCTO #2125]
> >> >>>> 
> >> >>>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
> >> >>>> ---
> >> >>>>   lib/bb/ui/crumbs/builder.py |  106
> >> >>>>   +++++++++++++++++++++++++++----------------
> >>lib/bb/ui/crumbs/hig.py
> >> >>>>       |   34 ++++++++------ 2 files changed, 87 insertions(+), 53
> >> >>>>   deletions(-)
> >> >>>> diff --git a/lib/bb/ui/crumbs/builder.py
> >>b/lib/bb/ui/crumbs/builder.py
> >> >>>> index 4eb374c..e27a239 100755
> >> >>>> --- a/lib/bb/ui/crumbs/builder.py
> >> >>>> +++ b/lib/bb/ui/crumbs/builder.py
> >> >>>> @@ -32,7 +32,7 @@ from bb.ui.crumbs.recipeselectionpage import
> >> > RecipeSelectionPage
> >> >>>>   from bb.ui.crumbs.packageselectionpage import
> >>PackageSelectionPage
> >> >>>>   from bb.ui.crumbs.builddetailspage import BuildDetailsPage from
> >> >>>>   bb.ui.crumbs.imagedetailspage import ImageDetailsPage -from 
> >> >>>> bb.ui.crumbs.hobwidget import hwc
> >> >>>> +from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
> >> >>>>   from bb.ui.crumbs.hig import CrumbsMessageDialog,
> >> > ImageSelectionDialog, \
> >> >>>>                                AdvancedSettingDialog,
> >> >>>>                                LayerSelectionDialog, \
> >> >>>>                                DeployImageDialog @@ -435,7 
> >> >>>> +435,8 @@ class Builder(gtk.Window):
> >> >>>>               lbl = "<b>Error</b>\n"
> >> >>>>               lbl = lbl + "%s\n\n" % msg
> >> >>>>               dialog = CrumbsMessageDialog(self, lbl,
> >> > gtk.STOCK_DIALOG_WARNING)
> >> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> >>>> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> >>>> +            HobButton.style_button(button)
> >> >>>>               response = dialog.run()
> >> >>>>               dialog.destroy()
> >> >>>>           self.handler.clear_busy() @@ -608,8 +609,10 @@ class 
> >> >>>> Builder(gtk.Window):
> >> >>>>       def destroy_window_cb(self, widget, event):
> >> >>>>           lbl = "<b>Do you really want to exit the Hob image
> >> >>>>           creator?</b>" dialog = CrumbsMessageDialog(self, lbl,
> >> > gtk.STOCK_DIALOG_INFO)
> >> >>>> -        dialog.add_button("Keep using Hob", gtk.RESPONSE_NO)
> >> >>>> -        dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
> >> >>>> +        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
> >> >>>> +        HobAltButton.style_button(button)
> >> >>>> +        button = dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
> >> >>>> +        HobButton.style_button(button)
> >> >>>>           dialog.set_default_response(gtk.RESPONSE_YES)
> >> >>>>           response = dialog.run()
> >> >>>>           dialog.destroy()
> >> >>>> @@ -625,7 +628,8 @@ class Builder(gtk.Window):
> >> >>>>               lbl = "<b>No selections made</b>\nYou have not 
> >> >>>> made
> >>any
> >> >>>>               selections" lbl = lbl + " so there isn't anything to
> >> >>>>               bake at this time." dialog =
> >>CrumbsMessageDialog(self,
> >> >>>>               lbl,
> >> > gtk.STOCK_DIALOG_INFO)
> >> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> >>>> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> >>>> +            HobButton.style_button(button)
> >> >>>>               dialog.run() dialog.destroy() return @@ -637,7 +641,8
> >> >>>>               @@ class Builder(gtk.Window): lbl = "<b>No selections
> >> >>>>               made</b>\nYou have not made any selections" lbl =
> >>lbl +
> >> >>>>               " so there isn't anything to bake at this time."
> >>dialog
> >> >>>>               = CrumbsMessageDialog(self, lbl,
> >> > gtk.STOCK_DIALOG_INFO)
> >> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> >>>> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> >>>> +            HobButton.style_button(button)
> >> >>>>               dialog.run() dialog.destroy() return @@ -652,7 +657,8
> >> >>>>               @@ class Builder(gtk.Window): lbl = "<b>No selections
> >> >>>>               made</b>\nYou have not made any selections" lbl =
> >>lbl +
> >> >>>>               " so there isn't anything to bake at this time."
> >>dialog
> >> >>>>               = CrumbsMessageDialog(self, lbl,
> >> > gtk.STOCK_DIALOG_INFO)
> >> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
> >> >>>> +            button = dialog.add_button("Close", gtk.RESPONSE_OK)
> >> >>>> +            HobButton.style_button(button)
> >> >>>>               dialog.run()
> >> >>>>               dialog.destroy()
> >> >>>>               return
> >> >>>> @@ -672,8 +678,9 @@ class Builder(gtk.Window):
> >> >>>>                        parent = self,
> >> >>>>                        flags = gtk.DIALOG_MODAL
> >> >>>>                            |
> >> > gtk.DIALOG_DESTROY_WITH_PARENT
> >> >>>> -                         | gtk.DIALOG_NO_SEPARATOR, -
> >>  
> >> >>>>      buttons = (gtk.STOCK_CLOSE, gtk.RESPONSE_YES)) +
> >>  
> >> >>>>         | gtk.DIALOG_NO_SEPARATOR) +        button =
> >> >>>> dialog.add_button("Close", gtk.RESPONSE_YES) +
> >> >>>> HobButton.style_button(button)
> >> >>>>           response = dialog.run()
> >> >>>>           if response == gtk.RESPONSE_YES:
> >> >>>>               self.configuration.layers = dialog.layers
> >> >>> 
> >> >>> As my previous point, I still strongly suggest we keep the "cancel"
> >> >>> button in the layer selection and advanced setting dialog to 
> >> >>> avoid user's wrong operation. Need Belen or Giulia's input.
> >> >> 
> >> >> They both responded via Bugzilla, I mistakenly thought you were on
> >>CC -
> >> >> apologies.
> >> >> 
> >> >> https://bugzilla.yoctoproject.org/show_bug.cgi?id=2083
> >> > 
> >> > Thanks for the information.
> >> > 
> >> > For Layer, I accept design team's idea to remove save and cancel
> >>button.
> >> > But still users may miss deleted some critical layers. For example, 
> >> > in our Yocto project, users may wrongly deleted meta-yocto, which 
> >> > will cause the system reporting error like:
> >> > 
> >> > "DISTRO poky not found. Please set a valid DISTRO in your local.conf"
> >> > 
> >> > This is because the poky distro is defined in meta-yocto layer, and
> >>user
> >> > deleted meta-yocto by mistake.
> >> > 
> >> > Do you think if it is reasonable to add a confirmation dialog when
> >>user
> >> > trying to delete a layer?
> >> > 
> >> > What about the save/cancel buttons in advanced setting dialog? Now 
> >> > I only saw a "close" button there. What can we do if user miss
> >>configured
> >> > something that he/she doesn't want to save?
> >> > 
> >> > Thanks,
> >> > Dongxiao
> >> > 
> >> >> 
> >> >> Cheers,
> >> >> Joshua
> >> > 
> >> > 
> >> > 
> >> > _______________________________________________
> >> > bitbake-devel mailing list
> >> > bitbake-devel@lists.openembedded.org
> >> > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> >> 
> >> 
> >
> >
> >
> >_______________________________________________
> >bitbake-devel mailing list
> >bitbake-devel@lists.openembedded.org
> >http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> 




