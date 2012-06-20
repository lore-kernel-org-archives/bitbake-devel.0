Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ShGcz-0006WC-ET
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 10:51:05 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 20 Jun 2012 01:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="182595098"
Received: from unknown (HELO helios.localnet) ([10.252.120.173])
	by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2012 01:40:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: =?ISO-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
Date: Wed, 20 Jun 2012 09:40:16 +0100
Message-ID: <1756623.6zWylpP7a0@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic-pae; KDE/4.8.3; i686; ; )
In-Reply-To: <20120620075504.GB22538@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<4368013.N53ZsVQnoH@helios> <20120620075504.GB22538@giant>
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
X-List-Received-Date: Wed, 20 Jun 2012 08:51:05 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 20 June 2012 09:55:04 Bj=F6rn Stenberg wrote:
> Paul Eggleton wrote:
> > So my assumption is -f is most often used for the purpose of manual=
ly
> > forcing a recompile after you have made modifications to the alread=
y
> > extracted source code under the workdir.
>=20
> I agree with that.
>=20
> My concern is based on the fact that people (including myself) don't =
fully
> know all the details of how bitbake works, and tend to make assumptio=
ns
> based on other build systems they know, such as simple Makefiles.
>=20
> I think the fact that bitbake sometime works differently means we sho=
uld be
> extra careful about not playing into devlelopers' assumptions. The bi=
tbake
> option --force sounds rather similar to make's --always-make, especia=
lly
> when it is described as: "force run of specified cmd, regardless of s=
tamp
> status".=20

I've not used this option with make before, so I tried it with the foll=
owing=20
trivial Makefile:

------------- snip --------------
b:
        touch b

a: b
        touch a
------------- snip --------------

If I run "make a" it of course runs "touch b" then "touch a". Then I ru=
n "make=20
--always-make b", it runs "touch b" which is what you expect. However, =
if I=20
subsequently run "make a" it does a "touch a" again - the dependency b =
has=20
changed, so it recognises it needs to rebuild a. This looks to me to be=
=20
exactly the same as the new proposed behaviour of -f in bitbake. The on=
ly=20
wrinkle in external behaviour is that "make --always-make a" runs both =
"touch=20
b" and "touch a"; this would be difficult for us to replicate in bitbak=
e and I'm=20
not sure it would be particularly useful. In any case it appears to me =
that if=20
we're moving anywhere, we're at least moving in the direction of behavi=
ng more=20
like make rather than less like it, would you agree?

> If we were to call it something different instead, like -t/--taint, t=
his
> would avoid some assumptions about its behaviour and make it more cle=
ar
> that the output will be different even if the input is the same.
>=20
> Sure, it's not a major issue. But I'm fairly confident that if we kee=
p the
> option name but change its behaviour, I am going to have to explain m=
ore
> than once to developers not following this list or the commit logs wh=
y -f
> does not do what they think (even though one can argue it never did).=
 I'd
> rather they discover up front that -f is deprecated and that they sho=
uld
> look up a new option instead.

This is a change in established behaviour, yes, and all changes in beha=
viour=20
of existing functionality come with a potential cost in terms of breaki=
ng=20
existing user assumptions. It's worth pointing out though that bitbake'=
s=20
behaviour with regard to how it handles building after changes have bee=
n made=20
has already changed quite significantly recently with the introduction =
and=20
extension of shared state - it is now the case that if you make almost =
any=20
change to the recipe and/or files it points to, the sstate signature ch=
anges=20
and the task (plus all dependent tasks) will be rebuilt if called for. =
IMHO,=20
this makes the change to -f make more sense - we're remaining consisten=
t with=20
the way the rest of the build system now works.

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre


