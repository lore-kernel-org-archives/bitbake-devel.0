Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>)
	id 1R9nSd-0007Pa-NM; Sat, 01 Oct 2011 02:29:47 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 30 Sep 2011 17:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="57894048"
Received: from pgsmsx603.gar.corp.intel.com ([10.221.43.87])
	by orsmga001.jf.intel.com with ESMTP; 30 Sep 2011 17:23:11 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	pgsmsx603.gar.corp.intel.com (10.221.43.87) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sat, 1 Oct 2011 08:23:10 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi; Sat, 1 Oct 2011
	08:23:10 +0800
From: "Yu, Ke" <ke.yu@intel.com>
To: Gary Thomas <gary@mlbassoc.com>, Patches and discussions about the oe-core
	layer <openembedded-core@lists.openembedded.org>
Date: Sat, 1 Oct 2011 08:23:07 +0800
Thread-Topic: [OE-core] Feedback on HOB (new image creator GUI)
Thread-Index: Acx/u7wCyDF/D/FDSdqSuqcGLy6/hAAEdL/Q
Message-ID: <33AB447FBD802F4E932063B962385B3512DAF448FB@shsmsx501.ccr.corp.intel.com>
References: <4E85D3E0.7070807@intel.com> <4E863AE8.7020901@mlbassoc.com>
In-Reply-To: <4E863AE8.7020901@mlbassoc.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Cc: "Lock, Joshua" <joshua.lock@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Sat, 01 Oct 2011 00:29:48 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Gary Thomas [mailto:gary@mlbassoc.com]
> Sent: Saturday, October 01, 2011 5:56 AM
> To: Patches and discussions about the oe-core layer
> Cc: Yu, Ke; bitbake-devel@lists.openembedded.org; Lock, Joshua
> Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
>=20
> On 2011-09-30 08:36, Yu Ke wrote:
> > Hi,
> >
> > As you may already know, a new GUI has been added to bitbake recently,
> > i.e. HOB (Human Oriented Builder). It is a graphical image creator that=
 allows
> user to freely choose which packages to be built in the image. The wiki
> https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob has more detail.
> >
> > This email is to collect your feedback on the HOB. Current HOB is our
> > first version, and it surely has many place to improve. We has the plan=
 to
> enhance it in Yocto 1.2. So we really hope that you can use it and provid=
e your
> valuable feedback . We do think user's feedback/requirement is the right =
way to
> go. Looking forward your valuable input.
> >
> > Best Regards
> > Ke
> >
> > Ps. The simple way to run hob is:
> > # touch conf/hob-pre.conf conf/hob-post.conf # bitbake -u hob -r
> > conf/hob-pre.conf -R conf/hob-post.conf
> >
> > Where conf/hob-pre.conf conf/hob-post.conf is the configuration file, w=
hich
> can be empty in above case.
>=20
> I build images which are not based on any of the core-XXX images listed b=
y HOB.
> How can I get them into the drop-down base list?
> Is there a way I can filter out some of the base images?  tasks?

Gary, thanks for trying and giving out the input. It is helpful.

For the base image list, HOB generate it by searching all the task whose na=
me containing "image", and we plan to improve it in Yocto 1.2 by searching =
task who inherits image.bbclass. =20

So currently, if you name your own image with XXX-image, HOB should be able=
 to automatically add it in the drop-down list.

And yes, it is helpful to allow user adding item into base image list. it c=
an be done by adding one item in "Edit"->"Preference". I will add this requ=
irement to my plan. For base image filtering, I am not sure if it is necess=
ary, since base image list is not that long. How do you think?

Regards
Ke

>=20
> I ask these questions because in particular, I use a lot of the recipes i=
n meta and
> meta-yocto, but none of the images or tasks (because they don't really ad=
dress
> my needs, don't take offense, I just want more control than they offer)
>=20
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------


