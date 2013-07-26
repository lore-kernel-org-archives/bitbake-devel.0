Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id D362A601AF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 14:35:45 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 26 Jul 2013 07:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,751,1367996400"; d="scan'208";a="273752175"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by AZSMGA002.ch.intel.com with ESMTP; 26 Jul 2013 07:35:45 -0700
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.64]) by
	IRSMSX101.ger.corp.intel.com ([169.254.1.83]) with mapi id
	14.03.0123.003; Fri, 26 Jul 2013 15:35:39 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH_V2 06/16] hob & bitbake: append a value
	to a variable from hob throught bitbake
Thread-Index: AQHOiSvMrDtXu77VnECfZyQyA4buuJl289iAgAATm5A=
Date: Fri, 26 Jul 2013 14:35:38 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E7F4270@IRSMSX105.ger.corp.intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<1374752549-29471-7-git-send-email-cristiana.voicu@intel.com>
	<49104416.fdFscICMXV@helios>
In-Reply-To: <49104416.fdFscICMXV@helios>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH_V2 06/16] hob & bitbake: append a value to a variable from hob throught bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 26 Jul 2013 14:35:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

I have implemented this way because Hob receives BB_FILES already expanded,=
 when it uses getVariable() method.
Also I chose to save it hardcoded (using TOPDIR), to be more general in loc=
al.conf (in case the local.conf is moved)
Thanks,
Cristiana=20


-----Original Message-----
From: Paul Eggleton [mailto:paul.eggleton@linux.intel.com]=20
Sent: Friday, July 26, 2013 5:22 PM
To: Voicu, Cristiana
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH_V2 06/16] hob & bitbake: append a value=
 to a variable from hob throught bitbake

Hi Cristiana,

On Thursday 25 July 2013 14:42:19 Cristiana Voicu wrote:
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -440,6 +440,7 @@ class Builder(gtk.Window):
>          self.handler.connect("recipe-populated",       =20
> self.handler_recipe_populated_cb) self.handler.connect("package-populated=
",
>        self.handler_package_populated_cb)
>=20
> +       =20
> + self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/*bb")

Shoudn't this be /*.bb ?


>          self.initiate_new_build_async()
>=20
>          signal.signal(signal.SIGINT, self.event_handle_SIGINT) diff=20
> --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py index 42fd0b9..e13ebe7=20
> 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -471,9 +471,22 @@ class HobHandler(gobject.GObject):
>=20
>      def set_var_in_file(self, var, val, default_file=3DNone):
>          self.runCommand(["enableDataTracking"])
> -        self.server.runCommand(["setVarFile", var, val, default_file])
> +        self.server.runCommand(["setVarFile", var, val, default_file,
> "set"]) self.runCommand(["disableDataTracking"])
>=20
> +    def append_var_in_file(self, var, val, default_file=3DNone):
> +        self.server.runCommand(["setVarFile", var, val, default_file,
> "append"]) +
> +    def append_to_bbfiles(self, val):
> +        bbfiles =3D self.runCommand(["getVariable", "BBFILES"]) or ""
> +        bbfiles =3D bbfiles.split()
> +        # replace TOPDIR in val, if necessary
> +        if "${TOPDIR}" in val:
> +            topdir =3D self.get_topdir()
> +            val =3D val.replace("${TOPDIR}", topdir)
> +        if val not in bbfiles:
> +            self.append_var_in_file("BBFILES",
> "${TOPDIR}/recipes/images/*bb", "local.conf") +

1) We should not be expanding ${TOPDIR} using direct string replacement. Do=
 we even need to do this?

2) In any case it appears to be using a hardcoded value instead of val when=
 it calls append_var_in_file()

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

