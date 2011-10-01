Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1R9nZI-0007WX-4f
	for bitbake-devel@lists.openembedded.org;
	Sat, 01 Oct 2011 02:36:40 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Sep 2011 17:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="58770495"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by orsmga002.jf.intel.com with ESMTP; 30 Sep 2011 17:30:04 -0700
Received: from pgsmsx102.gar.corp.intel.com (10.221.44.80) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sat, 1 Oct 2011 08:30:03 +0800
Received: from shsmsx602.ccr.corp.intel.com (10.239.4.104) by
	PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server
	(TLS) id 14.1.323.3; Sat, 1 Oct 2011 08:30:03 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	SHSMSX602.ccr.corp.intel.com ([10.239.4.104]) with mapi; Sat, 1 Oct 2011
	08:30:02 +0800
From: "Yu, Ke" <ke.yu@intel.com>
To: Koen Kooi <koen@dominion.thruhere.net>, Patches and discussions about the
	oe-core layer <openembedded-core@lists.openembedded.org>
Date: Sat, 1 Oct 2011 08:30:01 +0800
Thread-Topic: [OE-core] Feedback on HOB (new image creator GUI)
Thread-Index: Acx/jqgkyQWXzyZjSU60sWNh+zeIlQAQfBBQ
Message-ID: <33AB447FBD802F4E932063B962385B3512DAF448FC@shsmsx501.ccr.corp.intel.com>
References: <4E85D3E0.7070807@intel.com> <1317397804.11645.7.camel@scimitar>
	<689D3FDE-CD3B-48CE-9426-AE59008C0609@dominion.thruhere.net>
In-Reply-To: <689D3FDE-CD3B-48CE-9426-AE59008C0609@dominion.thruhere.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Sat, 01 Oct 2011 00:36:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Koen Kooi [mailto:koen@dominion.thruhere.net]
> Sent: Saturday, October 01, 2011 12:33 AM
> To: Patches and discussions about the oe-core layer
> Cc: Yu, Ke; bitbake-devel@lists.openembedded.org; openembedded-core
> Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
>=20
>=20
>=20
> Op 30 sep. 2011 om 10:49 heeft Joshua Lock <josh@linux.intel.com> het
> volgende geschreven:
>=20
> > On Fri, 2011-09-30 at 08:36 -0600, Yu, Ke wrote:
> >> Hi,
> >>
> >> As you may already know, a new GUI has been added to bitbake
> >> recently, i.e. HOB (Human Oriented Builder).
> >
> > It's not an acronym, it's just a name - Hob.
> >
> >> It is a graphical image creator that allows user to freely choose
> >> which packages to be built in the image.
> >> The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more
> >> detail.
> >
> > I'll be changing this page and adding more user-centric info in the
> > coming weeks.
> >
> >> This email is to collect your feedback on the HOB. Current HOB is our
> >> first version, and it surely has many place to improve. We has the
> >> plan to enhance it in Yocto 1.2. So we really hope that you can use
> >> it and provide your valuable feedback . We do think user's
> >> feedback/requirement is the right way to go. Looking forward your valu=
able
> input.
> >>
> >> Best Regards
> >> Ke
> >>
> >> Ps. The simple way to run hob is:
> >> # touch conf/hob-pre.conf conf/hob-post.conf # bitbake -u hob -r
> >> conf/hob-pre.conf -R conf/hob-post.conf
> >
> > In oe-core (and therefore Poky) we have a wrapper script so from an
> > oe-init-build-env'd build directory you can just call hob.
> >
> > The script will create the required configuration files with some
> > required values.
>=20
> Can we have it use local.conf by default please? I hate having to put the=
 same
> info in multiple places

Yes, this is valid. We should be able to use local.conf as pre and post con=
f file, if they are not specified by user. Thanks for the input. I will add=
 it to my plan.

Regards
Ke


