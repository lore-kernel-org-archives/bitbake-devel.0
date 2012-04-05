Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1SFgKf-0000Bl-J4
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 08:38:09 +0200
Received: by wibhj13 with SMTP id hj13so872480wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Apr 2012 23:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=+rQhn6Gi+1sNNYnTQ+oeq1ZSsdCTvpaQuWz9Dka7wb4=;
	b=bc9SApUYM6Xi0qCsErONw5Y8tIemCcV6HVkv+wTmH6WcFyBaWyBvBKONodAmqtoSIY
	h4/Pk2UBnD/EUgDCjBIRylsYZhzFdMGgZPulFhL/e5OQ0EJeg2xzpaBuskwLrIcoe8xY
	j6Sylwj6aB+H3P6ufrz6OPRx04LprhXKQktk6kda/fwfEbXgFVH5xOYNkY16bTDIcvF1
	tYwTP4lB16cJDfiRGjDFt84SYAz/VhDWWlqboijqXIaaUDXFKlspZ2l0ymAGorsrkmR6
	3f2XAXf1tJHQ0FSVusVt5eT4DYWW6v6VfQbWEfmWUL7W1YYum3eDcG0xehn93MJ0mQm+
	gyeg==
Received: by 10.180.79.135 with SMTP id j7mr9840818wix.19.1333607338324;
	Wed, 04 Apr 2012 23:28:58 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id n15sm11024449wiw.6.2012.04.04.23.28.56
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 04 Apr 2012 23:28:57 -0700 (PDT)
Date: Thu, 5 Apr 2012 08:28:57 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: "Lu, Lianhao" <lianhao.lu@intel.com>
Message-ID: <20120405062857.GK4181@jama.jama.net>
References: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: bb.utils.vercmp() not consistent with debian rules
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
X-List-Received-Date: Thu, 05 Apr 2012 06:38:09 -0000
X-Groupsio-MsgNum: 1726
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEfPc/DjvCj+JzNg"
Content-Disposition: inline

--PEfPc/DjvCj+JzNg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 06:22:00AM +0000, Lu, Lianhao wrote:
> Hi guys,
>=20
> When I'm looking at the Yocto bug#2233, I find that the function bb.utils=
=2Evercmp() is not consistent with the debian packaging rules(http://www.de=
bian.org/doc/debian-policy/ch-controlfields.html#s-f-Version).=20
>=20
> According to debian rules, "r0" is earlier than "r0-dream", but the bb.ut=
ils.vercmp() thinks "r0" is later than "r0-dream".

And what about something like this:

Version: 3.2-r10
is older then
Version: 3.2-r2-oe0

At least that was what target opkg was doing for me and I had to bump PE
http://git.shr-project.org/git/?p=3Dmeta-smartphone.git;a=3Dcommit;h=3Dcb11=
9753a77208617936085100595e6343ade650

Cheers,

>=20
> A pervious patch http://cgit.openembedded.org/bitbake/commit/?id=3D727ce6=
ffe33a119cb17f7d91b173f11a055eea3c seems causing the bb.utils.vercmp to spe=
cially handle the separators of "." and "-".=20
>=20
> Is it desired to behave differently from debian rules?
>=20
> Best Regards,
> -Lianhao
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--PEfPc/DjvCj+JzNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk99O6kACgkQN1Ujt2V2gByD2gCfZ41pekiEmJVdsl7tyrosWwFF
RBkAniqZ/fwqubyq8iyedgkK0VJ+ePER
=BymT
-----END PGP SIGNATURE-----

--PEfPc/DjvCj+JzNg--
