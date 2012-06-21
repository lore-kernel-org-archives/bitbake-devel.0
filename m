Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ShhYf-0005qi-Pt
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 15:36:26 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Jun 2012 06:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="159144315"
Received: from unknown (HELO helios.localnet) ([10.252.120.141])
	by azsmga001.ch.intel.com with ESMTP; 21 Jun 2012 06:25:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: =?ISO-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
Date: Thu, 21 Jun 2012 14:25:35 +0100
Message-ID: <4485899.BVPQboPATl@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic-pae; KDE/4.8.3; i686; ; )
In-Reply-To: <20120621122637.GF7204@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<1778547.OMx1BrFPz0@helios> <20120621122637.GF7204@giant>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: ensure -f causes dependent tasks to be re-run
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
X-List-Received-Date: Thu, 21 Jun 2012 13:36:26 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 21 June 2012 14:26:37 Bj=F6rn Stenberg wrote:
> Paul Eggleton wrote:
> > Why do you want it to be producing the same checksum for potentiall=
y
> > different contents?
>=20
> I don't. Sorry if that was unclear. I want:
>=20
> a) That we don't need an -f option at all, i.e. that we have dependen=
cy
> tracking pinned down so well that any changed input automatically cau=
ses a
> rebuild and changed hash. (A boy can dream, can't he? :-), or

If you mean inputs that come entirely from the metadata, we can do this=
=20
already (although the final pieces - namely detecting changes to local =
files=20
referred to in SRC_URI, and detecting changes to varflags - only went i=
n very=20
recently). So for most of the cases in the past where you would have ed=
ited=20
the recipe and/or files that the recipe points to and then needed to us=
e -f to=20
rebuild, now you no longer need to use -f and next time the recipe is c=
alled=20
for it will be rebuilt automatically. I think we do need to communicate=
 this=20
more effectively though.

> b) A different name for the -f option, or
>=20
> c) A clear information message when using -f, maybe something like "I=
NFO:
> Tainting the hash to force a rebuild", that alerts the user to the
> goings-on under the hood.

I think c) is reasonable. I'll put together a follow-up patch today to =
add=20
this.

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre


