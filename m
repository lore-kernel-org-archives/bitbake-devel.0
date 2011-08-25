Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1QwhTp-00086Q-Im; Thu, 25 Aug 2011 23:28:53 +0200
Received: by fxg11 with SMTP id 11so2225056fxg.6
	for <multiple recipients>; Thu, 25 Aug 2011 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=xB1HWYae1eqTi2bbEs0JNQLD4IQLp6MpWTtPjerfopc=;
	b=ioZtiKv5kUx6mwhEFgueGBYfdQl0fiKHO28T0PVfkJaVQRv/zDSoFdgtVTz82ux7K4
	O0coEdtHdNgzdESekLk8QXuwWbGufUCkbTuNAnm2snKe4NZzdlBPqfnKdWRLScqoTE1x
	8/nV+iFU8gIX0xLyMHGykifg72ACmOPuWZNtc=
Received: by 10.223.22.8 with SMTP id l8mr327914fab.105.1314307445719;
	Thu, 25 Aug 2011 14:24:05 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id c18sm797307fah.15.2011.08.25.14.24.03
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 25 Aug 2011 14:24:04 -0700 (PDT)
Date: Thu, 25 Aug 2011 23:23:56 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Message-ID: <20110825212356.GD5081@jama.jama.net>
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<201108251150.01236.paul.eggleton@linux.intel.com>
	<CAMKF1spSE=nuQ1LGOmub3XaH-z+6oJT+n5hC7LdKvdKeScLWNw@mail.gmail.com>
	<201108251758.23451.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <201108251758.23451.paul.eggleton@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Layer priorities influencing default version selection
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
X-List-Received-Date: Thu, 25 Aug 2011 21:28:53 -0000
X-Groupsio-MsgNum: 430
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline

--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2011 at 05:58:23PM +0100, Paul Eggleton wrote:
> On Thursday 25 August 2011 16:56:28 you wrote:
> > with layers we dont control policies of all the layers that may be used=
 on
> > top so fixing meta-oe does not solve problem completely and we can not =
ask
> > for exclusive  recipes. People would want to override the recipes from =
other
> > layers.
>=20
> Generally, the less duplication we have across layers the better; if a=20
> maintainer is duplicating a recipe they should have a very good reason to=
 do=20
> so. We can avoid some of this duplication by making it easier to figure o=
ut=20
> where the right place for recipes is and doing everything we can encourag=
e=20
> people to get stuff merged there. I'm not convinced we are doing very wel=
l on=20
> either count yet, but I expect this will improve over time.
>=20
> > bitbake could report the layer the recipe comes from which can make it
> > evident or may be special command to inform the layer priorities. This =
will
> > guide the users to diagnose the problems quickly and help developers to
> > identify the issues faster. There could be a complete bill of recipes
> > printed for a given target as well so if someone wants to check all
> > the recipes that were built.
>=20
> I had not considered BitBake itself reporting these, that might be useful=
=20
> especially in the case of errors (although the full path to the recipe is=
=20
> already reported during the build, so you should be able to tell in most =
cases=20
> from that if you need to). Outputting a specific report of parsed recipes=
 and=20
> bbappends as part of the build also might be useful.
>=20
> FYI, bitbake-layers exists as a separate utility to answer a lot of these=
=20
> kinds of questions, and recently has become a lot more powerful - I would=
=20
> strongly recommend everyone check it out and if it's not able to report w=
hat=20
> you want then please tell me and I'll try to make it do so. I already hav=
e a=20
> few ideas for future improvements there which I will hopefully get time t=
o=20
> look into in the Yocto 1.2 cycle.
>=20
> > In any case I agree that problems should be fixed. However this does
> > not scale to all layers and we can not police all the layers and we sho=
uld
> > not. We should try to make it possible for people to glue layers togeth=
er
> > without  issues.
>=20
> How does merely being able to alter the priorities help here though? I co=
uld=20
> begin to understand if you were asking for some way to blacklist individu=
al=20
> recipes in individual layers, but moving the priority of an entire layer =
is=20
> likely to have much more of an effect than just obscuring a few errant re=
cipes=20
> that you don't want.

Well in this I agree with khem that it would be more consistent to use
priority from bblayers.conf. You're right that changing priority of an
entire layer is having too big impact, but whoever is writing his
bblayers.conf has better information about what he needs/wants from
particular layer then layer maintainer who has no clue in which layer
stack his layer will end up.

> We can't "police" all the layers, no. But if those who maintain that laye=
r=20
> can't respond to and resolve problems then they shouldn't be maintainers =
or=20
> those layers can't be considered well-maintained. When you add a layer to=
 your=20
> build you are placing some trust in the maintainer of that layer; it is u=
p to=20
> the maintainer to make sure they don't abuse that trust.

And with priority in bblayers.conf I can say how much I trust him.

my 2c

Regards,
--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk5WvWwACgkQN1Ujt2V2gByg0QCfV2XvODs6glHtbIscOiLkUWDq
KoQAn39CQeIqzFdMkLv4HM8GzxSUu5mo
=povR
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
