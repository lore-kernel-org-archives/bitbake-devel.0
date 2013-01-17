Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1Tvnx4-0005Tf-41; Thu, 17 Jan 2013 12:48:13 +0100
Received: by mail-pa0-f51.google.com with SMTP id fb11so1416408pad.38
	for <multiple recipients>; Thu, 17 Jan 2013 03:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=UBUS4RqG1cEb9g6Tjb/rCA50tZ7EaKdei7o7/PKVxF8=;
	b=eiCHgGWF6zhpSHNJb81X63yO7H+PIMPbOY+CwiiOEJ08pgtrmIQZzTKfROOcioZoot
	hslbuSLLOOj3sNPp8XsizwSW/OHltALNL4J/Uu5atxhk4fCwVoXMGCCZvhV9BqCFhNAG
	cSdUgR68RpGUAOJh3/ypVA/yeK+GzF1QPjR5LBIynQvuYTRyeNsMXk7eyJgl6lPK6oKj
	7hwASh5Nf5w4tHpSW9JOn+psSQzwfMvD5gg6eHTbjclnZ5RsDHJ2Ylbk+z4G4B6LZmai
	xCTic8DoZaUuVXa1Kyj3PXeuSacl0FgnvRnc2QPInUkBD2dxE4aWiUgJ2hMuALjSWmrE
	CWcg==
X-Received: by 10.68.217.104 with SMTP id ox8mr12226616pbc.105.1358422365876; 
	Thu, 17 Jan 2013 03:32:45 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id s5sm1182106pay.31.2013.01.17.03.32.43
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Thu, 17 Jan 2013 03:32:44 -0800 (PST)
Date: Thu, 17 Jan 2013 12:32:39 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: openembedded-core@lists.openembedded.org
Message-ID: <20130117113239.GC3067@jama>
References: <20130111152856.GC3781@jama.palm1.palmone.com>
MIME-Version: 1.0
In-Reply-To: <20130111152856.GC3781@jama.palm1.palmone.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake hangs forever when PR serv is enabled
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
X-List-Received-Date: Thu, 17 Jan 2013 11:48:26 -0000
X-Groupsio-MsgNum: 3117
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline

--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2013 at 04:28:56PM +0100, Martin Jansa wrote:
> When building world which takes long time to finish I=20
> sometimes see bitbake hanging forever. It didn't happen
> until I've enabled PR Service. But maybe it's not caused=20
> by PR Service and it's just coincidence.
>=20
> I've to kill python processes manually and this traceback shown:
> Exception in thread Thread-1:
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/threading.py", line 551, in __bootstrap_inner
>     self.run()
>   File "/usr/lib/python2.7/threading.py", line 504, in run
>     self.__target(*self.__args, **self.__kwargs)
>   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/prserv/se=
rv.py", line 173, in _work
>     self.prserv.work_forever()
>   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/prserv/se=
rv.py", line 93, in work_forever
>     self.handle_request()
>   File "/usr/lib/python2.7/SocketServer.py", line 265, in handle_request
>     fd_sets =3D select.select([self], [], [], timeout)
> error: (4, 'Interrupted system call')
>=20
> When this happens, there is only one python process doing something=20
> for very long time:
> 29299 jenkins    20   0     0     0     0 Z  0.0  0.0 26:13.66 |  |      =
     |        `- python
>=20
> and when I've tried to connect to it with strace it was looping
> between 2 pipes both returning EAGAIN.
>=20
> Usually last cooker output is rm_work_all in gimp, but I don't see=20
> anything special in gimp recipe and it could be some other thread=20
> in background.
>=20
> NOTE: Running task 22874 of 23570 (ID: 996, /home/jenkins/oe/shr-core-bra=
nches/shr-core/meta-openembedded/meta-oe/recipes-graphics/gimp/gimp_2.8.2.b=
b, do_rm_work_all)
> NOTE: recipe gimp-2.8.2-r0: task do_rm_work_all: Started
> NOTE: recipe gimp-2.8.2-r0: task do_rm_work_all: Succeeded
> Exception in thread Thread-1:
> .. traceback from above
>=20
> Anyone seen this too? Any hints?

More info in https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D3742

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlD34VcACgkQN1Ujt2V2gBzqOACbBL+rjW49lFJzC84XnpSxKUmF
Ha0AoLkmTd3QlEondSKPMjINC1y9Mv8A
=mOBT
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
