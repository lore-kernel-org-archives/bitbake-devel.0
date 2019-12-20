Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id ECDB86011A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2019 17:22:27 +0000 (UTC)
IronPort-SDR: RwQfAX0vvog1ojpFMtlBRwbWVlBdLy0j1+jh8MvVJM6mWS+0HTJCxxEWUKE7adv1hJ3nuOf/8g
	Ym5iVT1AChyB/X3uDBl0IJY46Q62rwAK4Gzvv8V898H3uTlYiFSprG14TzXx0fy+G7B9g16/a7
	h0qcT7CrNvKK3W88EU5LP46RxP7bz/H5JdmQt2sVl2OOnDJ/w3VVQKiYe8NlUnbDxYSIOGiou/
	bE89neaEd23pnV/lym88p3mzxN0H4OhnjPcJsbwqp2b58+wl+jgdp3BuSjbVI43oGUSvcxB15q
	Sow=
X-IronPort-AV: E=Sophos;i="5.69,336,1571695200"; 
   d="scan'208";a="3815983"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Ola x Nilsson <Ola.x.Nilsson@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: prserv/serv: Use with while
	reading pidfile
Thread-Index: AQHVt0IZbLc9zLhLlkCY/JpmjdqcT6fDRI+Q
Date: Fri, 20 Dec 2019 17:22:28 +0000
Message-ID: <e512728a2ecb4ba68e0cbd3005596a99@XBOX03.axis.com>
References: <20191220142320.17724-1-olani@axis.com>
In-Reply-To: <20191220142320.17724-1-olani@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bitbake: prserv/serv: Use with while	reading pidfile
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 20 Dec 2019 17:22:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Ola x Nilsson
> Sent: den 20 december 2019 15:23
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/2] bitbake: prserv/serv: Use with while
> reading pidfile
>=20
> Signed-off-by: Ola x Nilsson <olani@axis.com>
> ---
>  lib/prserv/serv.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 3124b079..708b2e0a 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -353,9 +353,8 @@ def start_daemon(dbfile, host, port, logfile):
>      ip =3D socket.gethostbyname(host)
>      pidfile =3D PIDPREFIX % (ip, port)
>      try:
> -        pf =3D open(pidfile,'r')
> -        pid =3D int(pf.readline().strip())
> -        pf.close()
> +        with open(pidfile) as pf:
> +            pid =3D int(pf.readline().strip())
>      except IOError:
>          pid =3D None
>=20
> --
> 2.11.0

This only half the patch. Please add the following:

@@ -292,10 +292,9 @@ class PRServer(SimpleXMLRPCServer):
         logger.addHandler(streamhandler)
=20
         # write pidfile
-        pid =3D str(os.getpid())=20
-        pf =3D open(self.pidfile, 'w')
-        pf.write("%s\n" % pid)
-        pf.close()
+        pid =3D str(os.getpid())
+        with open(self.pidfile, 'w') as pf:
+            pf.write("%s\n" % pid)
=20
         self.work_forever()
         self.delpid()

//Peter


