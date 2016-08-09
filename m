Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E559D73289
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 03:23:04 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 08 Aug 2016 20:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,493,1464678000"; d="scan'208";a="1022074536"
Received: from kwang27-mobl8.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.179.174])
	by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2016 20:23:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 09 Aug 2016 15:22:59 +1200
Message-ID: <11674755.DJQ5KUJ55z@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.6.4-201.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
References: <1470645281559.73326@axis.com>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 09 Aug 2016 03:23:05 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Mon, 08 Aug 2016 08:35:38 Khem Raj wrote:
> > On Aug 8, 2016, at 4:24 AM, J=C3=A9r=C3=A9my Rosen <jeremy.rosen@sm=
ile.fr> wrote:
> >=20
> > On 08/08/2016 11:55, Richard Purdie wrote:
> >> On Mon, 2016-08-08 at 08:34 +0000, Tobias Hagelborn wrote:
> >>> Change made to enable building offline also with git tag referenc=
es
> >>> in SRC_URI.
> >>>=20
> >>> If BB_NO_NETWORK is set, fallback to search for tags and revision=
s
> >>> in local DL_DIR / GITDIR in order to avoid network access.
> >>=20
> >> I'm not sure I agree with this since you'd get different build res=
ults
> >> depending on whether BB_NO_NETWORK is set or not.
> >>=20
> >> I think if BB_NO_NETWORK is set, its reasonable to assume that the=

> >> configuration should be locked down and that BB_NO_NETWORK should =
not
> >> have other side effects like this.
> >>=20
> >> It would also make it very hard to detect unlocked configurations
> >> during testing which currently are quite easily identified.
> >=20
> > To be honest, this is a real world problem I have on a regular basi=
s...
> >=20
> > The problem we have is that our customers want to keep an archive f=
or
> > (very) long term support and they test offline mode.
> >=20
> > This problem means that we have to set all our SRC_URI to git SHA i=
nstead
> > of the much more readable and easy to check git tags.
> >=20
> >=20
> > you think to assume that a reference is a branch, but the real-life=

> > problem is when reference is a tag. Tag don't move so this is a cas=
e of
> > locked configuration, but i'm not sure how to handle it.
> >=20
> > Is there a way to have the best of both world somehow ?
>=20
> Don=E2=80=99t use tags instead rely on SHA numbers in SRCREV and use
> BB_GENERATE_MIRROR_TARBALLS like mentioned here
>=20
> https://wiki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own=
_source
> _download_mirror_.3F
>=20
> tags are floating types in git, you can not use them reliably.
> You may tool in a method to automate updating the
> recipes SRCREVs if you dont want to do it by hand.
>=20
> That should help hopefully

FYI, another way to handle this is to enable buildhistory, run your bui=
ld and=20
then use the buildhistory-collect-srcrevs script. This will produce out=
put=20
that you can save to .inc file that will lock down the SRCREV values to=
 exact=20
hashes, which you can then include and commit with your sources. This a=
llows=20
you to keep your tags and even ${AUTOREV} if you want within each of yo=
ur=20
recipes and still have everything locked down for future reproducibilit=
y.

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

