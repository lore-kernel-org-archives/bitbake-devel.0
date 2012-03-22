Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAdgu-0005Ef-15
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 09:48:16 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 22 Mar 2012 01:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="80316800"
Received: from azsmsx603.amr.corp.intel.com ([10.2.161.23])
	by AZSMGA002.ch.intel.com with ESMTP; 22 Mar 2012 01:39:20 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx603.amr.corp.intel.com (10.2.161.23) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 22 Mar 2012 01:39:20 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 22 Mar 2012 16:39:09 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 00/10] Hob GUI tweaks v2
Thread-Index: AQHNB9EGFCGF55ItEEG2LTnW8qd+oJZ1+xDg
Date: Thu, 22 Mar 2012 08:39:08 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AF612C@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 00/10] Hob GUI tweaks v2
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
X-List-Received-Date: Thu, 22 Mar 2012 08:48:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

05, I think we need more work, the label on the button is blue. I hope we c=
an make the labels colorful to highlight there is a button for click. Again=
, for "Back to XXX", the design is "<< Back to XXX". But I can ACK to check=
 in the patch first, and leave the work for future.

07, the machine combo box vertically is not in the middle of "layers" butto=
n, and it removes the hover function, that is when the mouse is over the bu=
tton, the icon will be changed. Initially we implemented that in this way, =
however it didn't look good. So, we used our specific solution. What the de=
signer expects is it becomes a button. That could be implemented.

For the rest, ACK.

Thanks.
--
Shane

Joshua Lock wrote on=A02012-03-22:

> Here are some tweaks to the Hob GUI. This series iterates on (and
> therefore makes redundant) an earlier series with the same subject.
>=20
> Changes include
>=20
> * adding a clear icon to search entries, per Gtk+ norm * changes to
> PersistentTooltip's so that the colours work better on darker themes
> (though there's still a problem with the link colour, which is
> technically a theme bug but makes our app look bad), some spacing tweaks
> and a change to reindent the file to match the rest of BitBake
> indentation style. * add a new widget, HobAltButton, for use as a
> secondary button instead of gtk.LinkButton - Belen, our interaction
> designer, informed me that the design intends them to be buttons (and
> therefore have prelight and active states matching standard buttons) but
> that they are supposed to be implemented without relief so that the user
> is guided towards primary actions. I need to develop a follow on that
> changes the colour of the secondary button text per visual design. *
> Replace HobXpmLabelButtonBox with a new HobImageButton, this is a
> HobAltButton subclass which is modelled after the buttons in
> gnome-disk-utility, where Belen informs me the buttons on the main page
> for Layers, Recipes and Packages are modelled after. * Finally I include
> a further iterated implementation of the Layer Selection dialogue which
> uses some new assets provided by the design team and the HobAltButton to
> match the visual and interation designs more closely.
>=20
> Cheers,
> Joshua
>=20
> The following changes since commit
> c5fdc6c02fe4712d3114caccfd759a626bd9677b:
>=20
>   Add bitbake-dumpsig to make it more obvious how to dump a signatures
> file (2012-03-21 17:08:08 +0000)
>=20
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> Joshua Lock (10):
>   ui/crumbs/hobwidget: add clear icon to search entries in HobNotebook
>   ui/crumbs/persistenttooltip: tweak borders
>   ui/crumbs/persistenttooltip: fix colours on darker themes
>   ui/crumbs/persistenttooltip: fix whitespace
>   lib/bb/ui/crumbs: Add HobAltButton and use it
>   lib/ui/icons: autocrop images
>   lib/bb/ui/crumbs: replace HobXpmLabelButtonBox with HobImageButton
>   lib/bb/ui/crumbs: add icons for use in the layer dialogue
>   ui/crumbs/hig: make the layer selection dialogue more closely match
>     design
>   lib/bb/ui/crumbs/hig: disable removal of meta-hob layer
>  lib/bb/ui/crumbs/builddetailspage.py          |    6 +-
>  lib/bb/ui/crumbs/hig.py                       |  129 ++++++++++----
>  lib/bb/ui/crumbs/hobwidget.py                 |  131 +++++++-------
>  lib/bb/ui/crumbs/imageconfigurationpage.py    |   52 +++---
>  lib/bb/ui/crumbs/imagedetailspage.py          |   12 +-
>  lib/bb/ui/crumbs/packageselectionpage.py      |    4 +-
>  lib/bb/ui/crumbs/persistenttooltip.py         |  244
>  +++++++++++++----------- lib/bb/ui/crumbs/recipeselectionpage.py     =20
>  |    4 +- lib/bb/ui/icons/indicators/add.png            |  Bin 0 ->
>  1176 bytes lib/bb/ui/icons/indicators/remove.png         |  Bin 0 ->
>  1971 bytes lib/bb/ui/icons/layers/layers_display.png     |  Bin 5326 ->
>  4840 bytes lib/bb/ui/icons/packages/packages_display.png |  Bin 7188 ->
>  7011 bytes lib/bb/ui/icons/recipe/recipe_display.png     |  Bin 4873 ->
>  4723 bytes 13 files changed, 334 insertions(+), 248 deletions(-) create
>  mode 100644 lib/bb/ui/icons/indicators/add.png create mode 100644
>  lib/bb/ui/icons/indicators/remove.png




