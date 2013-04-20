Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1UThTw-00013r-1D; Sun, 21 Apr 2013 01:46:16 +0200
Received: by mail-pd0-f176.google.com with SMTP id r11so2839963pdi.7
	for <multiple recipients>; Sat, 20 Apr 2013 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=PKqv6y20glxxBC2/sFK5xJdFlIHMcxTJ3RoE46wdTYI=;
	b=flYi+hXKuPJ7GwIBTyqkENL6pK5zjFL03v8iOqKbt6NuzTKFdYOB7/7RaOTYSYuFlc
	at8bn/ReJsZ8+D8/t33d1aOa64ODVBeTNJczSHyha8k/4ecBa6iFhcYB9Ijahy0LCpa0
	MS+s/GjbJQSAvf5g7xo9mXLNAYSHzrvhS+Q4ZXBuptwPt61WnUZVQclXctzSUiRb+KDU
	HnlTavhMTbHjHnVsp5UADUQZF/1FyCXKubG5XiI+d3eTaxNi2c6wzCJi7t+5bZOmqcbV
	QpbOTNfM8U5Rw9EXXmHTGymgh/om7+c55MTvsq+JlA2RlqeySjCMsovuUPK+z9hiDQIt
	2uRg==
X-Received: by 10.68.189.67 with SMTP id gg3mr25671874pbc.141.1366500514402;
	Sat, 20 Apr 2013 16:28:34 -0700 (PDT)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id to7sm20447811pab.0.2013.04.20.16.28.31
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Sat, 20 Apr 2013 16:28:33 -0700 (PDT)
Date: Sun, 21 Apr 2013 01:28:35 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <20130420232835.GN2489@jama>
References: <20130420225659.GM2489@jama>
MIME-Version: 1.0
In-Reply-To: <20130420225659.GM2489@jama>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: openembedded-core@lists.openembedded.org
Subject: Re: bash-completion
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
X-List-Received-Date: Sat, 20 Apr 2013 23:46:24 -0000
X-Groupsio-MsgNum: 3392
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqN4RWvJTb9VNux/"
Content-Disposition: inline

--tqN4RWvJTb9VNux/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2013 at 12:56:59AM +0200, Martin Jansa wrote:
> There is old thread on oe-devel about it
> http://lists.linuxtogo.org/pipermail/openembedded-devel/2007-December/003=
764.html
>=20
> Is there any reason why it wasn't added to contrib yet?
>=20
> Would it be applied if I send git patch adding it and update commands to
> include cleansstate and packagedata + new options like -S and maybe
> more?

Or maybe in oe-core/contrib, as list of possible commands is not defined=20
in bitbake.
--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--tqN4RWvJTb9VNux/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFzJKMACgkQN1Ujt2V2gBzOuwCgmngM+wG7samjSD7NJi+6oCpG
Y5sAn1WVLkre5T+b4r8NxI2WYjk8JFQg
=xnRD
-----END PGP SIGNATURE-----

--tqN4RWvJTb9VNux/--
