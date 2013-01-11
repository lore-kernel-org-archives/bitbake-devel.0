Received: from mail-pb0-f51.google.com ([209.85.160.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1Ttgm3-0008RG-9B; Fri, 11 Jan 2013 16:44:08 +0100
Received: by mail-pb0-f51.google.com with SMTP id ro12so1008202pbb.24
	for <multiple recipients>; Fri, 11 Jan 2013 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:mime-version
	:content-type:content-disposition:user-agent;
	bh=gDNm2r7xmlaw5QklSNH1rwg/3+UNEnzWRN+5sLNEZoU=;
	b=oXAPXq7ahxBupDFEztmwICd8UKpBTMwOqtlw6A6uFUHiAyh68NFQU5HuoqTKroRJTE
	elJhzqKQHNa7HIDIh4iswMH04/3nRSXG+FaYBDIrHizkMJE6McD5RRjKcTK2/hj7HC/v
	dDIkJMKu2s8olXQIqAqmYpkAdKiprIspiclkxuICmHBHJhOOauFUsvbwCmDKeQBd1f6s
	TJMcmo8iAeO0jLnfcHG2mCjyJP4LpdbuxBP+CAQCoLP5yXBkf18ewVcbZWQWx1Zi4x59
	ZvCKYX6n4/9Dpqdi0yDhX+rhfOm9j+g9oPV7H7ikO7oDVGBoNvBC1EkAVLbgiLtZ954O
	uGXQ==
X-Received: by 10.68.253.161 with SMTP id ab1mr209805407pbd.97.1357918127406; 
	Fri, 11 Jan 2013 07:28:47 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id nm2sm2954709pbc.43.2013.01.11.07.28.44
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Fri, 11 Jan 2013 07:28:46 -0800 (PST)
Date: Fri, 11 Jan 2013 16:28:56 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: openembedded-core@lists.openembedded.org
Message-ID: <20130111152856.GC3781@jama.palm1.palmone.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: bitbake hangs forever when PR serv is enabled
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
X-List-Received-Date: Fri, 11 Jan 2013 15:44:09 -0000
X-Groupsio-MsgNum: 3098
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline

--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When building world which takes long time to finish I=20
sometimes see bitbake hanging forever. It didn't happen
until I've enabled PR Service. But maybe it's not caused=20
by PR Service and it's just coincidence.

I've to kill python processes manually and this traceback shown:
Exception in thread Thread-1:
Traceback (most recent call last):
  File "/usr/lib/python2.7/threading.py", line 551, in __bootstrap_inner
    self.run()
  File "/usr/lib/python2.7/threading.py", line 504, in run
    self.__target(*self.__args, **self.__kwargs)
  File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/prserv/serv=
=2Epy", line 173, in _work
    self.prserv.work_forever()
  File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/prserv/serv=
=2Epy", line 93, in work_forever
    self.handle_request()
  File "/usr/lib/python2.7/SocketServer.py", line 265, in handle_request
    fd_sets =3D select.select([self], [], [], timeout)
error: (4, 'Interrupted system call')

When this happens, there is only one python process doing something=20
for very long time:
29299 jenkins    20   0     0     0     0 Z  0.0  0.0 26:13.66 |  |        =
   |        `- python

and when I've tried to connect to it with strace it was looping
between 2 pipes both returning EAGAIN.

Usually last cooker output is rm_work_all in gimp, but I don't see=20
anything special in gimp recipe and it could be some other thread=20
in background.

NOTE: Running task 22874 of 23570 (ID: 996, /home/jenkins/oe/shr-core-branc=
hes/shr-core/meta-openembedded/meta-oe/recipes-graphics/gimp/gimp_2.8.2.bb,=
 do_rm_work_all)
NOTE: recipe gimp-2.8.2-r0: task do_rm_work_all: Started
NOTE: recipe gimp-2.8.2-r0: task do_rm_work_all: Succeeded
Exception in thread Thread-1:
=2E. traceback from above

Anyone seen this too? Any hints?

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlDwL7gACgkQN1Ujt2V2gBwADgCfbfybY5nlPZIuEH7PKWHswc3n
zEIAniItPgobbwXmeZ6Tm+qigumxs4+s
=SXk+
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
