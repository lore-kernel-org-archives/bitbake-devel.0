Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SC1Lq-0006PB-OX
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 06:16:15 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 25 Mar 2012 21:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="81525634"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 25 Mar 2012 21:07:13 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sun, 25 Mar 2012 21:07:13 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Mon, 26 Mar 2012 12:07:11 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>, Joshua Lock <josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 9/9] lib/bb/ui/crumbs: apply
	primary/secondary dialogue button styling
Thread-Index: AQHNCVnrgowbkwVYOkuv+HM/VCqg0ZZ4HA+AgAADcoCAA8ZYoA==
Date: Mon, 26 Mar 2012 04:07:10 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AF91F7@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<9b9c960eca1213d2f60f499278fba368e3e0e16d.1332545580.git.josh@linux.intel.com>
	<1332550859.1849.16.camel@dongxiao-osel>	<4F6D1E3D.60205@linux.intel.com>
	<1332551969.1849.28.camel@dongxiao-osel>
In-Reply-To: <1332551969.1849.28.camel@dongxiao-osel>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
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
X-List-Received-Date: Mon, 26 Mar 2012 04:16:15 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

That is really conflict.

The design team wants to make few interactions and make things simple.
The engineering team wants to give the users a chance to restore to the def=
ault or skip the changes he/she has made.

The previous solution with "Save" and "Cancel" is an option.
The current solution with "Close" is an option. What if the user removes a =
layer in error?
What Dongxiao suggested to ask users to confirm is also an option. But what=
 if there are a lot of layers to remove and a lot of confirmation dialogs f=
or impatient users?

I also have a bug filed by Josh to remember settings between Hob sessions. =
QA raised an issue today that in Hob 1.1, when the user changes some settin=
gs and save, which is supposed to cause an error and make Hob not runable. =
Then, QA doesn't have any chance to initiate a clean running, unless the bu=
ild directory is deleted and "source" to another directory.

Comments?

--
Shane

Xu, Dongxiao wrote on=A02012-03-24:

> On Fri, 2012-03-23 at 18:07 -0700, Joshua Lock wrote:
>> On 23/03/12 18:00, Xu, Dongxiao wrote:
>>> On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
>>>> The design calls for primary buttons which are orange and large and
>>>> secondary buttons which are subtle with pale blue text. This is so
>>>> that the user is drawn towards the primary action and their use of
>>>> the application is more guided.
>>>>=20
>>>> This patch uses HobButton and HobAltButton classes to style all dialog=
ue
>>>> buttons accordingly.
>>>>=20
>>>> Fixes [YOCTO #2125]
>>>>=20
>>>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
>>>> ---
>>>>   lib/bb/ui/crumbs/builder.py |  106
>>>>   +++++++++++++++++++++++++++---------------- lib/bb/ui/crumbs/hig.py
>>>>       |   34 ++++++++------ 2 files changed, 87 insertions(+), 53
>>>>   deletions(-)
>>>> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
>>>> index 4eb374c..e27a239 100755
>>>> --- a/lib/bb/ui/crumbs/builder.py
>>>> +++ b/lib/bb/ui/crumbs/builder.py
>>>> @@ -32,7 +32,7 @@ from bb.ui.crumbs.recipeselectionpage import
> RecipeSelectionPage
>>>>   from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
>>>>   from bb.ui.crumbs.builddetailspage import BuildDetailsPage from
>>>>   bb.ui.crumbs.imagedetailspage import ImageDetailsPage
>>>> -from bb.ui.crumbs.hobwidget import hwc
>>>> +from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
>>>>   from bb.ui.crumbs.hig import CrumbsMessageDialog,
> ImageSelectionDialog, \
>>>>                                AdvancedSettingDialog,
>>>>                                LayerSelectionDialog, \
>>>>                                DeployImageDialog
>>>> @@ -435,7 +435,8 @@ class Builder(gtk.Window):
>>>>               lbl =3D "<b>Error</b>\n"
>>>>               lbl =3D lbl + "%s\n\n" % msg
>>>>               dialog =3D CrumbsMessageDialog(self, lbl,
> gtk.STOCK_DIALOG_WARNING)
>>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>>>> +            HobButton.style_button(button)
>>>>               response =3D dialog.run()
>>>>               dialog.destroy()
>>>>           self.handler.clear_busy()
>>>> @@ -608,8 +609,10 @@ class Builder(gtk.Window):
>>>>       def destroy_window_cb(self, widget, event):
>>>>           lbl =3D "<b>Do you really want to exit the Hob image
>>>>           creator?</b>" dialog =3D CrumbsMessageDialog(self, lbl,
> gtk.STOCK_DIALOG_INFO)
>>>> -        dialog.add_button("Keep using Hob", gtk.RESPONSE_NO)
>>>> -        dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
>>>> +        button =3D dialog.add_button("Cancel", gtk.RESPONSE_NO)
>>>> +        HobAltButton.style_button(button)
>>>> +        button =3D dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
>>>> +        HobButton.style_button(button)
>>>>           dialog.set_default_response(gtk.RESPONSE_YES)
>>>>           response =3D dialog.run()
>>>>           dialog.destroy()
>>>> @@ -625,7 +628,8 @@ class Builder(gtk.Window):
>>>>               lbl =3D "<b>No selections made</b>\nYou have not made an=
y
>>>>               selections" lbl =3D lbl + " so there isn't anything to
>>>>               bake at this time." dialog =3D CrumbsMessageDialog(self,
>>>>               lbl,
> gtk.STOCK_DIALOG_INFO)
>>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>>>> +            HobButton.style_button(button)
>>>>               dialog.run() dialog.destroy() return @@ -637,7 +641,8
>>>>               @@ class Builder(gtk.Window): lbl =3D "<b>No selections
>>>>               made</b>\nYou have not made any selections" lbl =3D lbl =
+
>>>>               " so there isn't anything to bake at this time." dialog
>>>>               =3D CrumbsMessageDialog(self, lbl,
> gtk.STOCK_DIALOG_INFO)
>>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>>>> +            HobButton.style_button(button)
>>>>               dialog.run() dialog.destroy() return @@ -652,7 +657,8
>>>>               @@ class Builder(gtk.Window): lbl =3D "<b>No selections
>>>>               made</b>\nYou have not made any selections" lbl =3D lbl =
+
>>>>               " so there isn't anything to bake at this time." dialog
>>>>               =3D CrumbsMessageDialog(self, lbl,
> gtk.STOCK_DIALOG_INFO)
>>>> -            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
>>>> +            button =3D dialog.add_button("Close", gtk.RESPONSE_OK)
>>>> +            HobButton.style_button(button)
>>>>               dialog.run()
>>>>               dialog.destroy()
>>>>               return
>>>> @@ -672,8 +678,9 @@ class Builder(gtk.Window):
>>>>                        parent =3D self,
>>>>                        flags =3D gtk.DIALOG_MODAL
>>>>                            |
> gtk.DIALOG_DESTROY_WITH_PARENT
>>>> -                         | gtk.DIALOG_NO_SEPARATOR, -              =20
>>>>      buttons =3D (gtk.STOCK_CLOSE, gtk.RESPONSE_YES)) +               =
=20
>>>>         | gtk.DIALOG_NO_SEPARATOR) +        button =3D
>>>> dialog.add_button("Close", gtk.RESPONSE_YES) +      =20
>>>> HobButton.style_button(button)
>>>>           response =3D dialog.run()
>>>>           if response =3D=3D gtk.RESPONSE_YES:
>>>>               self.configuration.layers =3D dialog.layers
>>>=20
>>> As my previous point, I still strongly suggest we keep the "cancel"
>>> button in the layer selection and advanced setting dialog to avoid
>>> user's wrong operation. Need Belen or Giulia's input.
>>=20
>> They both responded via Bugzilla, I mistakenly thought you were on CC -
>> apologies.
>>=20
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D2083
>=20
> Thanks for the information.
>=20
> For Layer, I accept design team's idea to remove save and cancel button.
> But still users may miss deleted some critical layers. For example, in
> our Yocto project, users may wrongly deleted meta-yocto, which will
> cause the system reporting error like:
>=20
> "DISTRO poky not found. Please set a valid DISTRO in your local.conf"
>=20
> This is because the poky distro is defined in meta-yocto layer, and user
> deleted meta-yocto by mistake.
>=20
> Do you think if it is reasonable to add a confirmation dialog when user
> trying to delete a layer?
>=20
> What about the save/cancel buttons in advanced setting dialog? Now I
> only saw a "close" button there. What can we do if user miss configured
> something that he/she doesn't want to save?
>=20
> Thanks,
> Dongxiao
>=20
>>=20
>> Cheers,
>> Joshua
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel




