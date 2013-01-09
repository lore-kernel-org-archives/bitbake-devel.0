Received: from mail-da0-f52.google.com ([209.85.210.52])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1Tt2bt-0007MG-PB
	for bitbake-devel@lists.openembedded.org;
	Wed, 09 Jan 2013 21:51:00 +0100
Received: by mail-da0-f52.google.com with SMTP id f10so917706dak.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jan 2013 12:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=ScJvIV7K4plw1HMGd+mX4II9VM6rR2bipx/l4MYuZxw=;
	b=YLjmqF3pOq0wvLoZ22N9N8SqbTkQgWF3DjlI0eSYdpOjpnXqBbM0Ruobh2aaz1p6cg
	tP85JlYaHK0qBbMpB0RIRvUjtR/e32Q2vyr5O1i++cFFdDFPosqmmSSK0IA7949gT+sN
	YMpIJSGssTSll3HeOQkDal2Jw9AFqv1ewe6vUZWNZVo8hLak4hZZTaRYyKvGwAntl2Mo
	9juEZ5UpURhL++U4xeVq1N+2TG5EhAI0h9Z41BUxqnyQg+P5HX6xtRtvMHZC7bydFCxh
	te5bV2fQRjmnShyQKeOpYnX23FsCt8AnW7q20shHnP264cLO3PpXCdvMvkMsezBtqRg7
	zqcA==
X-Received: by 10.68.134.232 with SMTP id pn8mr210705861pbb.47.1357763740747; 
	Wed, 09 Jan 2013 12:35:40 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id x6sm43387527pav.29.2013.01.09.12.35.37
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 09 Jan 2013 12:35:39 -0800 (PST)
Date: Wed, 9 Jan 2013 21:35:44 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Peter Seebach <peter.seebach@windriver.com>
Message-ID: <20130109203544.GR3722@jama.palm1.palmone.com>
References: <20130109122757.5c134665@e6410-2>
MIME-Version: 1.0
In-Reply-To: <20130109122757.5c134665@e6410-2>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Variable tracking...
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
X-List-Received-Date: Wed, 09 Jan 2013 20:51:02 -0000
X-Groupsio-MsgNum: 3088
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="soWJpSPh+l8Y6Fy7"
Content-Disposition: inline

--soWJpSPh+l8Y6Fy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2013 at 12:27:57PM -0600, Peter Seebach wrote:
> So, I sent some variable-tracking patches a while back that had been
> cleaned up in response to various feedback. And I don't think I heard
> back anything about problems with them, but I don't think I heard
> anything positive.
>=20
> Is anyone still interested in the variable-assignment-tracking stuff,
> other than me? I maintain that it is REALLY useful when trying to track
> down variables getting the wrong values.

I didn't look at the implementation, but I also find this feature very
usefull.

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--soWJpSPh+l8Y6Fy7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlDt1KAACgkQN1Ujt2V2gByj0ACgtIFbcN8LrKJASxNlEvUuv0/O
i+cAnA1sjU5Rb3r8RQEoObGjrVN4M1Yx
=roEt
-----END PGP SIGNATURE-----

--soWJpSPh+l8Y6Fy7--
