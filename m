Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <belen.barros.pena@intel.com>) id 1SCBXc-0000nT-Tm
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 17:09:05 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 26 Mar 2012 07:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="81701420"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by AZSMGA002.ch.intel.com with ESMTP; 26 Mar 2012 07:58:56 -0700
Received: from irsmsx152.ger.corp.intel.com (163.33.192.66) by
	IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Mon, 26 Mar 2012 15:58:49 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.70]) by
	IRSMSX152.ger.corp.intel.com ([169.254.6.86]) with mapi id
	14.01.0355.002; Mon, 26 Mar 2012 15:58:49 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>, "Wang, Shane"
	<shane.wang@intel.com>, Joshua Lock <josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 9/9] lib/bb/ui/crumbs: apply
	primary/secondary dialogue button styling
Thread-Index: AQHNC2DzOtdDdkU+VkGyH8QX+EPFpA==
Date: Mon, 26 Mar 2012 14:58:49 +0000
Message-ID: <CB96351B.B20D%belen.barros.pena@intel.com>
In-Reply-To: <1332742237.1849.74.camel@dongxiao-osel>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [10.254.234.133]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Giulia Piu <giulia@closertag.com>
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
X-List-Received-Date: Mon, 26 Mar 2012 15:09:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09809923CC36E847A8437CDEBAE880EF@intel.com>
Content-Transfer-Encoding: quoted-printable

Hi all,

Just a few comments:

>still users may miss deleted some critical layers. For example, in
>our Yocto project, users may wrongly deleted meta-yocto, which will
>cause the system reporting error like: "DISTRO poky not found. Please set
>a valid DISTRO in your local.conf"
>This is because the poky distro is defined in meta-yocto layer, and user
>deleted meta-yocto by mistake.

We designed the Layers dialog so that it is not possible to delete the
meta layer. If deleting the meta-yocto layer is also going to cause
problems that a novice might not be able to recover from, then we should
consider applying the same approach to the meta-yocto layer so that it
cannot be removed. If anybody has any reasons why this is not a good idea,
please let me know.

>I saw in the design document(Hob_1.2_screens_inventory.pdf), there are
>"save" and "cancel" button in advanced setting page.

Quoting the Gnome HIG
(http://developer.gnome.org/hig-book/3.0/windows-utility.html.en):

Do not make the user press an OK or Apply button to make the changes
happen, unless either:

* the change will take more than about one second to apply, in which case
applying the change immediately could make the system feel slow or
unresponsive, or
* the changes in the window have to be applied simultaneously to prevent
the system entering a potentially unstable state. For example, the
hostname and proxy fields in a network properties window.

The Settings dialog is so complex and edits so many different variables
that I assumed it could fall into one of the 2 points above. That's why I
designed it as an Explicit Apply window. If my assumption it's incorrect,
please go ahead and remove the Save and Cancel buttons: I'll be very happy
to see them go :) Keep in mind that we'll still need a close button to
dismiss the dialog.

>The design team wants to make few interactions and make things simple.
>The engineering team wants to give the users a chance to restore to the
>default or skip the changes he/she has made.
>What if the user removes a layer in error?

These are the reasons why we have designed the Layers dialog as an instant
apply window:

1. Because it's how the Gnome HIG recommends doing things, and we have no
evidence of any kind suggesting this is the wrong approach for the Layers
dialog.
2. Because deleting a layer by mistake constitutes an edge case: I am sure
you will agree users will probably not be deleting layers by mistake all
the time. I try not to optimise designs for edge cases, but for the main
use cases while preventing catastrophic errors (hence the decision to make
the meta layer non-removable).

Having said this, feel free to make the decision you consider appropriate
:)



>Do you think if it is reasonable to add a confirmation dialog when user
>trying to delete a layer?


I can see why you are suggesting this approach (particularly in the case
of the meta-yocto layer), but I rather not add an extra step to any
process unless it is absolutely necessary. I tend to favour providing undo
functionality instead.

I am going to copy this thread on the relevant bug to make sure we have
all our conversations in the same place. Otherwise it'll be hard to follow
and fully understand our design decisions if we need to go back to them in
the future.=20




Cheers

Belen



On 26/03/2012 07:10, "Xu, Dongxiao" <dongxiao.xu@intel.com> wrote:

>On Mon, 2012-03-26 at 12:07 +0800, Wang, Shane wrote:
>> That is really conflict.
>>=20
>> The design team wants to make few interactions and make things simple.
>> The engineering team wants to give the users a chance to restore to the
>>default or skip the changes he/she has made.
>>=20
>> The previous solution with "Save" and "Cancel" is an option.
>> The current solution with "Close" is an option. What if the user
>>removes a layer in error?
>> What Dongxiao suggested to ask users to confirm is also an option. But
>>what if there are a lot of layers to remove and a lot of confirmation
>>dialogs for impatient users?
>>=20
>> I also have a bug filed by Josh to remember settings between Hob
>>sessions. QA raised an issue today that in Hob 1.1, when the user
>>changes some settings and save, which is supposed to cause an error and
>>make Hob not runable. Then, QA doesn't have any chance to initiate a
>>clean running, unless the build directory is deleted and "source" to
>>another directory.
>>=20
>> Comments?
>
>I saw in the design document(Hob_1.2_screens_inventory.pdf), there are
>"save" and "cancel" button in advanced setting page.
>
>I still for the layer dialog, the question is still open. I think my
>point of view is similar with Shane's, that is to allow users have the
>chance to ignore the change that he/she made in mistake.
>
>Thanks,
>Dongxiao
>
>>=20
>> --
>> Shane
>>=20
>> Xu, Dongxiao wrote on 2012-03-24:
>>=20
>> > On Fri, 2012-03-23 at 18:07 -0700, Joshua Lock wrote:
>> >> On 23/03/12 18:00, Xu, Dongxiao wrote:
>> >>> On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
>> >>>> The design calls for primary buttons which are orange and large and
>> >>>> secondary buttons which are subtle with pale blue text. This is so
>> >>>> that the user is drawn towards the primary action and their use of
>> >>>> the application is more guided.
>> >>>>=20
>> >>>> This patch uses HobButton and HobAltButton classes to style all
>>dialogue
>> >>>> buttons accordingly.
>> >>>>=20
>> >>>> Fixes [YOCTO #2125]
>> >>>>=20
>> >>>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
>> >>>> ---
>> >>>>   lib/bb/ui/crumbs/builder.py |  106
>> >>>>   +++++++++++++++++++++++++++----------------
>>lib/bb/ui/crumbs/hig.py
>> >>>>       |   34 ++++++++------ 2 files changed, 87 insertions(+), 53
>> >>>>   deletions(-)
>> >>>> diff --git a/lib/bb/ui/crumbs/builder.py
>>b/lib/bb/ui/crumbs/builder.py
>> >>>> index 4eb374c..e27a239 100755
>> >>>> --- a/lib/bb/ui/crumbs/builder.py
>> >>>> +++ b/lib/bb/ui/crumbs/builder.py
>> >>>> @@ -32,7 +32,7 @@ from bb.ui.crumbs.recipeselectionpage import
>> > RecipeSelectionPage
>> >>>>   from bb.ui.crumbs.packageselectionpage import
>>PackageSelectionPage
>> >>>>   from bb.ui.crumbs.builddetailspage import BuildDetailsPage from
>> >>>>   bb.ui.crumbs.imagedetailspage import ImageDetailsPage
>> >>>> -from bb.ui.crumbs.hobwidget import hwc
>> >>>> +from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
>> >>>>   from bb.ui.crumbs.hig import CrumbsMessageDialog,
>> > ImageSelectionDialog, \
>> >>>>                                AdvancedSettingDialog,
>> >>>>                                LayerSelectionDialog, \
>> >>>>                                DeployImageDialog
>> >>>> @@ -435,7 +435,8 @@ class Builder(gtk.Window):
>> >>>>               lbl =3D "<b>Error</b>\n"
>> >>>>               lbl =3D lbl + "%s\n\n" % msg
>> >>>>               dialog =3D CrumbsMessageDialog(self, lbl,
>> > gtk.STOCK_DIALOG_WARNING)
>> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>> >>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>> >>>> +            HobButton.style_button(button)
>> >>>>               response =3D dialog.run()
>> >>>>               dialog.destroy()
>> >>>>           self.handler.clear_busy()
>> >>>> @@ -608,8 +609,10 @@ class Builder(gtk.Window):
>> >>>>       def destroy_window_cb(self, widget, event):
>> >>>>           lbl =3D "<b>Do you really want to exit the Hob image
>> >>>>           creator?</b>" dialog =3D CrumbsMessageDialog(self, lbl,
>> > gtk.STOCK_DIALOG_INFO)
>> >>>> -        dialog.add_button("Keep using Hob", gtk.RESPONSE_NO)
>> >>>> -        dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
>> >>>> +        button =3D dialog.add_button("Cancel", gtk.RESPONSE_NO)
>> >>>> +        HobAltButton.style_button(button)
>> >>>> +        button =3D dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
>> >>>> +        HobButton.style_button(button)
>> >>>>           dialog.set_default_response(gtk.RESPONSE_YES)
>> >>>>           response =3D dialog.run()
>> >>>>           dialog.destroy()
>> >>>> @@ -625,7 +628,8 @@ class Builder(gtk.Window):
>> >>>>               lbl =3D "<b>No selections made</b>\nYou have not made
>>any
>> >>>>               selections" lbl =3D lbl + " so there isn't anything to
>> >>>>               bake at this time." dialog =3D
>>CrumbsMessageDialog(self,
>> >>>>               lbl,
>> > gtk.STOCK_DIALOG_INFO)
>> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>> >>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>> >>>> +            HobButton.style_button(button)
>> >>>>               dialog.run() dialog.destroy() return @@ -637,7 +641,8
>> >>>>               @@ class Builder(gtk.Window): lbl =3D "<b>No selectio=
ns
>> >>>>               made</b>\nYou have not made any selections" lbl =3D
>>lbl +
>> >>>>               " so there isn't anything to bake at this time."
>>dialog
>> >>>>               =3D CrumbsMessageDialog(self, lbl,
>> > gtk.STOCK_DIALOG_INFO)
>> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>> >>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>> >>>> +            HobButton.style_button(button)
>> >>>>               dialog.run() dialog.destroy() return @@ -652,7 +657,8
>> >>>>               @@ class Builder(gtk.Window): lbl =3D "<b>No selectio=
ns
>> >>>>               made</b>\nYou have not made any selections" lbl =3D
>>lbl +
>> >>>>               " so there isn't anything to bake at this time."
>>dialog
>> >>>>               =3D CrumbsMessageDialog(self, lbl,
>> > gtk.STOCK_DIALOG_INFO)
>> >>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>> >>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>> >>>> +            HobButton.style_button(button)
>> >>>>               dialog.run()
>> >>>>               dialog.destroy()
>> >>>>               return
>> >>>> @@ -672,8 +678,9 @@ class Builder(gtk.Window):
>> >>>>                        parent =3D self,
>> >>>>                        flags =3D gtk.DIALOG_MODAL
>> >>>>                            |
>> > gtk.DIALOG_DESTROY_WITH_PARENT
>> >>>> -                         | gtk.DIALOG_NO_SEPARATOR, -
>> =20
>> >>>>      buttons =3D (gtk.STOCK_CLOSE, gtk.RESPONSE_YES)) +
>> =20
>> >>>>         | gtk.DIALOG_NO_SEPARATOR) +        button =3D
>> >>>> dialog.add_button("Close", gtk.RESPONSE_YES) +
>> >>>> HobButton.style_button(button)
>> >>>>           response =3D dialog.run()
>> >>>>           if response =3D=3D gtk.RESPONSE_YES:
>> >>>>               self.configuration.layers =3D dialog.layers
>> >>>=20
>> >>> As my previous point, I still strongly suggest we keep the "cancel"
>> >>> button in the layer selection and advanced setting dialog to avoid
>> >>> user's wrong operation. Need Belen or Giulia's input.
>> >>=20
>> >> They both responded via Bugzilla, I mistakenly thought you were on
>>CC -
>> >> apologies.
>> >>=20
>> >> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D2083
>> >=20
>> > Thanks for the information.
>> >=20
>> > For Layer, I accept design team's idea to remove save and cancel
>>button.
>> > But still users may miss deleted some critical layers. For example, in
>> > our Yocto project, users may wrongly deleted meta-yocto, which will
>> > cause the system reporting error like:
>> >=20
>> > "DISTRO poky not found. Please set a valid DISTRO in your local.conf"
>> >=20
>> > This is because the poky distro is defined in meta-yocto layer, and
>>user
>> > deleted meta-yocto by mistake.
>> >=20
>> > Do you think if it is reasonable to add a confirmation dialog when
>>user
>> > trying to delete a layer?
>> >=20
>> > What about the save/cancel buttons in advanced setting dialog? Now I
>> > only saw a "close" button there. What can we do if user miss
>>configured
>> > something that he/she doesn't want to save?
>> >=20
>> > Thanks,
>> > Dongxiao
>> >=20
>> >>=20
>> >> Cheers,
>> >> Joshua
>> >=20
>> >=20
>> >=20
>> > _______________________________________________
>> > bitbake-devel mailing list
>> > bitbake-devel@lists.openembedded.org
>> > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>>=20
>>=20
>
>
>
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



