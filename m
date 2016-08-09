Return-Path: <tobias.hagelborn@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 131C565CC2
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 09:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 043692E220;
	Tue,  9 Aug 2016 11:49:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id SPyOGM6-AH2B; Tue,  9 Aug 2016 11:49:53 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 652502E179;
	Tue,  9 Aug 2016 11:49:53 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 4EEBB1888;
	Tue,  9 Aug 2016 11:49:53 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 437D917D8;
	Tue,  9 Aug 2016 11:49:53 +0200 (CEST)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by thoth.se.axis.com (Postfix) with ESMTP id 417E6303;
	Tue,  9 Aug 2016 11:49:53 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Tue, 9 Aug 2016 11:49:52 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Tue, 9 Aug 2016 11:49:53 +0200
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] BB_NO_NETWORK: Fallback to local source
	for git lsremote
Thread-Index: AQHR8e1Z+cp/NFJAmUGN9HEw0ymq/KBAYS6k
Date: Tue, 9 Aug 2016 09:49:52 +0000
Message-ID: <1470736192773.38584@axis.com>
References: <1470645281559.73326@axis.com>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>,
	<11674755.DJQ5KUJ55z@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <11674755.DJQ5KUJ55z@peggleto-mobl.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
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
X-List-Received-Date: Tue, 09 Aug 2016 09:50:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Thanks for the tip Paul,=0A=
=0A=
I was not aware of this support-script.=0A=
This is a good workaround in the current Bitbake environment.=0A=
=0A=
We strive to make it easier for our users to continue building if going off=
line and as such a step, I will submit a new patchset with some optional fl=
ag to use local tags (so that no unexpected side-effect is default in a-act=
ion). This since it would be a little less overhead/steps to take when buil=
ding offline.=0A=
=0A=
Cheers,=0A=
Tobias=0A=
=0A=
=0A=
________________________________________=0A=
From: Paul Eggleton <paul.eggleton@linux.intel.com>=0A=
Sent: Tuesday, August 9, 2016 5:22 AM=0A=
To: bitbake-devel@lists.openembedded.org=0A=
Cc: Khem Raj; J=E9r=E9my Rosen; Tobias Hagelborn; Richard Purdie=0A=
Subject: Re: [bitbake-devel] [PATCH] BB_NO_NETWORK: Fallback to local sourc=
e for git lsremote=0A=
=0A=
On Mon, 08 Aug 2016 08:35:38 Khem Raj wrote:=0A=
> > On Aug 8, 2016, at 4:24 AM, J=E9r=E9my Rosen <jeremy.rosen@smile.fr> wr=
ote:=0A=
> >=0A=
> > On 08/08/2016 11:55, Richard Purdie wrote:=0A=
> >> On Mon, 2016-08-08 at 08:34 +0000, Tobias Hagelborn wrote:=0A=
> >>> Change made to enable building offline also with git tag references=
=0A=
> >>> in SRC_URI.=0A=
> >>>=0A=
> >>> If BB_NO_NETWORK is set, fallback to search for tags and revisions=0A=
> >>> in local DL_DIR / GITDIR in order to avoid network access.=0A=
> >>=0A=
> >> I'm not sure I agree with this since you'd get different build results=
=0A=
> >> depending on whether BB_NO_NETWORK is set or not.=0A=
> >>=0A=
> >> I think if BB_NO_NETWORK is set, its reasonable to assume that the=0A=
> >> configuration should be locked down and that BB_NO_NETWORK should not=
=0A=
> >> have other side effects like this.=0A=
> >>=0A=
> >> It would also make it very hard to detect unlocked configurations=0A=
> >> during testing which currently are quite easily identified.=0A=
> >=0A=
> > To be honest, this is a real world problem I have on a regular basis...=
=0A=
> >=0A=
> > The problem we have is that our customers want to keep an archive for=
=0A=
> > (very) long term support and they test offline mode.=0A=
> >=0A=
> > This problem means that we have to set all our SRC_URI to git SHA inste=
ad=0A=
> > of the much more readable and easy to check git tags.=0A=
> >=0A=
> >=0A=
> > you think to assume that a reference is a branch, but the real-life=0A=
> > problem is when reference is a tag. Tag don't move so this is a case of=
=0A=
> > locked configuration, but i'm not sure how to handle it.=0A=
> >=0A=
> > Is there a way to have the best of both world somehow ?=0A=
>=0A=
> Don=92t use tags instead rely on SHA numbers in SRCREV and use=0A=
> BB_GENERATE_MIRROR_TARBALLS like mentioned here=0A=
>=0A=
> https://wiki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own_sou=
rce=0A=
> _download_mirror_.3F=0A=
>=0A=
> tags are floating types in git, you can not use them reliably.=0A=
> You may tool in a method to automate updating the=0A=
> recipes SRCREVs if you dont want to do it by hand.=0A=
>=0A=
> That should help hopefully=0A=
=0A=
FYI, another way to handle this is to enable buildhistory, run your build a=
nd=0A=
then use the buildhistory-collect-srcrevs script. This will produce output=
=0A=
that you can save to .inc file that will lock down the SRCREV values to exa=
ct=0A=
hashes, which you can then include and commit with your sources. This allow=
s=0A=
you to keep your tags and even ${AUTOREV} if you want within each of your=
=0A=
recipes and still have everything locked down for future reproducibility.=
=0A=
=0A=
Cheers,=0A=
Paul=0A=
=0A=
--=0A=
=0A=
Paul Eggleton=0A=
Intel Open Source Technology Centre=0A=

