Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SB0RV-0005is-Gx
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 10:05:53 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 23 Mar 2012 01:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="80772969"
Received: from azsmsx603.amr.corp.intel.com ([10.2.161.23])
	by AZSMGA002.ch.intel.com with ESMTP; 23 Mar 2012 01:56:56 -0700
Received: from azsmsx604.amr.corp.intel.com (10.2.161.34) by
	azsmsx603.amr.corp.intel.com (10.2.161.23) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 23 Mar 2012 01:56:56 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx604.amr.corp.intel.com (10.2.161.34) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 23 Mar 2012 01:56:56 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.142]) with mapi id
	14.01.0355.002; Fri, 23 Mar 2012 16:56:54 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/9] Hob changes to match visual design
Thread-Index: AQHNCIPvY3uFYVTnoUW2FiNL8lMDyJZ3kmhQ
Date: Fri, 23 Mar 2012 08:56:53 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AF73EC@SHSMSX102.ccr.corp.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/9] Hob changes to match visual design
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
X-List-Received-Date: Fri, 23 Mar 2012 09:05:53 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ACK.

If the texts on the buttons "Layers", "View Recipes" and "View Packages" ca=
n be larger and their layouts can be looser (see the visual design), that w=
ould be better. Leave it to the future.

But, anyway, ACK all.

--
Shane

Joshua Lock wrote on=A02012-03-23:

> Here's another set of patches to move Hob closer to the proposed design.
>=20
> * Replace HobXpmLabelButtonBox with a new HobImageButton, this is a
> gtk.Button subclass which is modelled after the buttons in
> gnome-disk-utility, where Belen informs me the buttons on the main page
> for Layers, Recipes and Packages are modelled after. Since the first
> submission of this patch I've also ensured the buttons use an
> alternative icon for the hover state per Shane's suggestion.
>=20
> * Various tweaks to the LayerSelectionDialog per feedback from design:
>   - title is Layers
>   - add hover state icon to add button
>   - follow Gnome HIG and only use a close button
> * Per feedback on my last pull request and the design document changes
> to the HobAltButton
>   - bold text which uses a pale blue colour per visual design
>   - modified 'Back to image configuration' buttons to have << prefix
> * Unify implementation of the primary action button as a shared widget
> HobButton and make use of it where we currently set up an orange button
> (this class should be used for all primary buttons in a future patch).
>=20
> Cheers,
> Joshua
>=20
> The following changes since commit
> 96e235a151fa04f5a15cd8b46f50a5852e2ba739:
>=20
>   Hob: Revert interfaces of callbacks for layer_button, view_recipes_butt=
on,
> and view_packages_button. (2012-03-22 14:36:04 +0000)
>=20
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
>   git://git.yoctoproject.org/poky-contrib josh/hob
>   http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Djosh/ho=
b
> Joshua Lock (9):
>   lib/bb/ui/icons: add new icons for use in Hob, autocrop some existing
>     ones
>   lib/bb/ui/crumbs: replace HobXpmLabelButtonBox with HobImageButton
>   lib/bb/ui/crumbs/builder: only show a close button on the Layer
>     Selector
>   lib/bb/ui/crumbs/hig: tweak 'Add Layer' button per visual design
>   lib/bb/ui/crumbs: add colour for HobAltButton per visual design
>   lib/bb/ui/crumbs: fix 'Back to image configuration' alt button text
>   lib/bb/ui/crumbs/hobwidget: add HobButton widget for the primary
>     action lib/bb/ui/crumbs: make use of HobButton for existing primary
>     action buttons
>   lib/bb/ui/crumbs/builder: change dialogue title to Layers
>  lib/bb/ui/crumbs/builder.py                 |    5 +-
>  lib/bb/ui/crumbs/hig.py                     |   27 +++--
>  lib/bb/ui/crumbs/hobcolor.py                |    1 +
>  lib/bb/ui/crumbs/hobwidget.py               |  148
>  ++++++++++++++++----------- lib/bb/ui/crumbs/imageconfigurationpage.py=20
>  |   52 ++++------ lib/bb/ui/crumbs/imagedetailspage.py        |   11
>  +-- lib/bb/ui/crumbs/packageselectionpage.py    |   13 +--
>  lib/bb/ui/crumbs/recipeselectionpage.py     |   13 +--
>  lib/bb/ui/icons/indicators/add-hover.png    |  Bin 0 -> 1212 bytes
>  lib/bb/ui/icons/indicators/remove-hover.png |  Bin 0 -> 2809 bytes
>  lib/bb/ui/icons/layers/layers_hover.png     |  Bin 5390 -> 5257 bytes
>  lib/bb/ui/icons/packages/packages_hover.png |  Bin 7308 -> 7121 bytes
>  lib/bb/ui/icons/recipe/recipe_hover.png     |  Bin 5003 -> 4866 bytes
>  13 files changed, 136 insertions(+), 134 deletions(-) create mode
>  100644 lib/bb/ui/icons/indicators/add-hover.png create mode 100644
>  lib/bb/ui/icons/indicators/remove-hover.png




