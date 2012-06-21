Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ShgP3-0001b4-C0
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 14:22:25 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Jun 2012 05:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="160642913"
Received: from unknown (HELO helios.localnet) ([10.252.120.141])
	by orsmga002.jf.intel.com with ESMTP; 21 Jun 2012 05:10:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: =?ISO-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
Date: Thu, 21 Jun 2012 13:10:33 +0100
Message-ID: <1778547.OMx1BrFPz0@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic-pae; KDE/4.8.3; i686; ; )
In-Reply-To: <20120621112555.GD7204@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<1756623.6zWylpP7a0@helios> <20120621112555.GD7204@giant>
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
X-List-Received-Date: Thu, 21 Jun 2012 12:22:25 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 21 June 2012 13:25:55 Bj=F6rn Stenberg wrote:
> Paul Eggleton wrote:
> > In any case it appears to me that if we're moving anywhere, we're a=
t least
> > moving in the direction of behaving more like make rather than less=
 like
> > it, would you agree?
>=20
> Yes, in terms of which commands are being ran. No, in terms of the re=
sulting
> output.

The resulting output is only different in terms of what the user has ch=
anged in=20
the sources (if anything) and the sstate checksum. Why do you want it t=
o be=20
producing the same checksum for potentially different contents?

> -f intentionally produces different output. I think this will confuse=

> people, and that we should therefore be extra careful in informing th=
e
> user.

It intentionally changes the checksum yes, and as Richard said we shoul=
d=20
probably mention this in the help text. I will produce a v2 of this ser=
ies=20
that does that.

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre


