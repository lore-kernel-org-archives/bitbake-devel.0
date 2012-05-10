Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SSN3i-0000xl-Ux
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 May 2012 08:41:07 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 09 May 2012 23:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="98408356"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 09 May 2012 23:31:11 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 9 May 2012 23:31:10 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.6]) with mapi id
	14.01.0355.002; Thu, 10 May 2012 14:31:08 +0800
From: "An, LimingX L" <limingx.l.an@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Joshua Lock
	<josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 0/4] Replace HobNotebook with
	gtk.Notebook, comments invited
Thread-Index: AQHNGiieDH4Zp9q4ukSMxlrwZCgkepbCt2yw
Date: Thu, 10 May 2012 06:31:07 +0000
Message-ID: <E5BAA81A5E0FB344B2B234D4FBAC45DC0FCDC64D@SHSMSX102.ccr.corp.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
	<1334398981.7309.98.camel@ted>
In-Reply-To: <1334398981.7309.98.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/4] Replace HobNotebook with gtk.Notebook, comments invited
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
X-List-Received-Date: Thu, 10 May 2012 06:41:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

There are still some issues in these patches, but I think we can check in f=
irst and I also have some fixes which depends on the check-in. I will submi=
t the patches to fix them as long as they are pulled in.

Please to review. Thanks!
--
Liming

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Richard Purdie
Sent: Saturday, April 14, 2012 6:23 PM
To: Joshua Lock
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 0/4] Replace HobNotebook with gtk.Noteb=
ook, comments invited

On Fri, 2012-04-13 at 16:24 -0700, Joshua Lock wrote:
> *** This series prevents users of distros with old Gtk+ releases using=20
> Hob ***
>=20
> This is a follow-on from my RFC of yesterday with a similar title.=20
> Sadly I hadn't realised that one of the API calls I am using is not=20
> available in the version of gtk+ shipped with CentOS 6 (gtk.Notebook.set_=
action_widget).
>=20
> This change will prevent CentOS 6 users from being able to use Hob.
>=20
> I spent some time in Gtk+ internals trying to figure out if we can=20
> emulate the behaviour on older versions but the GtkNotebook widget=20
> internals were enhanced significantly to support the set_action_widget AP=
I.
>=20
> I've submitted the change as an RFC regardless, it's ready to merge if=20
> we're willing to make the sacrifice.
>=20
> The primary motivation for making this change, and making it so late=20
> in the cycle, is maintainability. The diffstat says it all - we're=20
> replacing an ~400LOC custom widget with a ~100LOC set of 3 widgets=20
> which subclass standard toolkit widgets.
>=20
> An added benefit is that standard toolkit widgets generally integrate=20
> better into the users OS thanks to inheriting their standard theme.
>=20
> Tested on:=20
> Fedora 16 (x86_64) - PASS
> CentOS 6.2 (x86_64) - FAIL: Gtk+ version too old Ubuntu 10.04 (x86_64)=20
> - Fail: pygtk version too old Ubuntu 12.04 Beta (x86_64) - PASS
>=20
> Per the final patch in the series the changes here require gtk+-2.20=20
> or newer and pygtk 2.22 or newer.

Since we don't have a good external-python tarball solution in place yet, I=
'm going to have to hold off these patches until after the current release.

Cheers,

Richard


_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


