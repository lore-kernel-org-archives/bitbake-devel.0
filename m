Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Shhzr-0002El-Bk
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 16:04:31 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 21 Jun 2012 06:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="183237218"
Received: from unknown (HELO helios.localnet) ([10.252.120.141])
	by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2012 06:52:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: =?ISO-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
Date: Thu, 21 Jun 2012 14:52:20 +0100
Message-ID: <1750781.s4FxKVuW1N@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic-pae; KDE/4.8.3; i686; ; )
In-Reply-To: <20120621134140.GH7204@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<20120621122637.GF7204@giant> <20120621134140.GH7204@giant>
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
X-List-Received-Date: Thu, 21 Jun 2012 14:04:31 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 21 June 2012 15:41:40 Bj=F6rn Stenberg wrote:
> Bj=F6rn Stenberg wrote:
> > c) A clear information message when using -f, maybe something like =
"INFO:
> > Tainting the hash to force a rebuild", that alerts the user to the
> > goings-on under the hood.
>=20
> Another thing: How will bitbake-diffsigs show a tainted build vs the
> untained version? It would be very nice if that could be shown clearl=
y.

It reports that the taint changed from None to the taint value (or vice=
=20
versa). Right now the taint value is not particularly useful - it's a r=
andom=20
UUID; however in future it's possible we might set the taint to somethi=
ng non-
random for other purposes. In any case, if a signature is tainted both=20=

bitbake-diffsigs and bitbake-dumpsig will report it.

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre


