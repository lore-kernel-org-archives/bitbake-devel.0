Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Sh8Ma-0001M5-Vf
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 02:01:37 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 19 Jun 2012 16:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="155719023"
Received: from unknown (HELO helios.localnet) ([10.252.120.138])
	by orsmga001.jf.intel.com with ESMTP; 19 Jun 2012 16:50:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: =?ISO-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
Date: Wed, 20 Jun 2012 00:50:46 +0100
Message-ID: <4368013.N53ZsVQnoH@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic-pae; KDE/4.8.3; i686; ; )
In-Reply-To: <20120619193539.GA2530@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<dcf1fb0acb4bd3424cbb5f48cd62f4f994896c20.1340034255.git.paul.eggleton@linux.intel.com>
	<20120619193539.GA2530@giant>
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
X-List-Received-Date: Wed, 20 Jun 2012 00:01:37 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 19 June 2012 21:35:39 Bj=F6rn Stenberg wrote:
> Paul Eggleton wrote:
> > If -f is specified, force dependent tasks to be re-run next time. T=
his
> > works by changing the force behaviour so that instead of deleting t=
he
> > task's stamp, we write a "taint" file into the stamps directory, wh=
ich
> > will alter the taskhash randomly and thus trigger the task to re-ru=
n
>=20
> I'm concerned about calling this -f/--force. I don't think I'm alone =
in
> interpreting -f / --force as "run all commands, even if the dependenc=
ies
> say we don't need to".

Well, what it used to do was just cause the specified task to be run ev=
en if=20
there is a stamp recording that it was already done; dependencies don't=
 come=20
into it (although perhaps you meant stamps?)

> I would expect the same output as the first time,
> with the same sstate checksum.

So my assumption is -f is most often used for the purpose of manually f=
orcing=20
a recompile after you have made modifications to the already extracted =
source=20
code under the workdir. If that is the case, there are two consequences=
 as I=20
see it:

 * When Bitbake next checks whether you want to run dependent tasks, gi=
ven=20
that the output of the task almost certainly changed due to your modifi=
cations,=20
you would want those dependent tasks to be re-run again also. i.e. if y=
ou've=20
forced a compile, you would expect for the results to be installed and=20=

packaged when you next ask for the do_install / do_package tasks to run=
.

 * You don't really want those modifications going into the sstate pack=
age that=20
effectively claims to be produced from inputs that only come from the m=
etadata.=20
Now, obviously it doesn't physically prevent you from ever getting modi=
fied=20
data into an sstate package with the same signature, but it makes it le=
ss=20
likely.

My question would be, are you using -f for something different or do yo=
u=20
disagree with one or both of the consequences above?

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre


