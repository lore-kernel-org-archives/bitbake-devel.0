Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 9A5BF7700B
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Sep 2015 17:27:16 +0000 (UTC)
Received: by wiclp12 with SMTP id lp12so26639732wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=jHLEfaY9YtiKJKUIPiEYmcMoBts1/NfNrMh5hIS47qA=;
	b=CGMCMNSrnabj4s7XiUOQpXTQYmtILlrv+uRAOfKsyUzysl7ASTgS+EteKKuuID9Lvz
	K+eQMUQxixcInoULHvPLqgsSfxnSLb3nES3u0ETgOW3zJ2cmYnG0W4TB64mMuLvRDu/T
	gqn/IfZI5NqcdmnyJaHKHYW/aGXqgIjQL7WKYy7BMHPSxABKBfP5KZZd8fKK6aKk1KXb
	+RusleBY+uae/F88W4W4CdUM0C/b39UwYfiHsw6A4e6nRIARP258zDGwndlE/G2JGMEC
	4k1nlsc9J7dZkySztzDL762ARn95E3iDmjukrsFWiCqlysddQPnH6tbdTiStmHsFJ0zx
	KvAA==
X-Received: by 10.180.21.137 with SMTP id v9mr5454806wie.8.1441214835837;
	Wed, 02 Sep 2015 10:27:15 -0700 (PDT)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id w8sm4627960wiy.10.2015.09.02.10.27.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 Sep 2015 10:27:15 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Wed, 2 Sep 2015 19:27:36 +0200
To: Saul Wold <sgw@linux.intel.com>
Message-ID: <20150902172736.GF2470@jama>
References: <1441214406-11183-1-git-send-email-sgw@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1441214406-11183-1-git-send-email-sgw@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: akuster808@gmail.com, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] prserv/serv: Improve exit handling
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
X-List-Received-Date: Wed, 02 Sep 2015 17:27:21 -0000
X-Groupsio-MsgNum: 6300
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline

--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 10:20:06AM -0700, Saul Wold wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>

The subject doesn't say for which branch this is intended.

I guess 1.24, because it's already in 1.26 and master, but it should be
specified in Subject.

>=20
> Currently, I'm not sure how the prserver managed to shut down cleanly. Th=
ese
> issues may explain some of the hangs people have reported.
>=20
> This change:
>=20
> * Ensures the connection acceptance thread monitors self.quit
> * We wait for the thread to exit before exitting
> * We sync the database when the thread exits
> * We do what the comment mentions, timeout after 30s and sync the database
>   if needed. Previously, there was no timeout (the 0.5 applies to sockets,
>   not the Queue object)
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 0926492295d485813d8a4f6b77c7b152e4c5b4c4)
> Signed-off-by: Saul Wold <sgw@linux.intel.com>
> ---
>  lib/prserv/serv.py | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 25eb46a..a7639c8 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -77,12 +77,15 @@ class PRServer(SimpleXMLRPCServer):
> =20
>          """
>          iter_count =3D 1
> -        # With 60 iterations between syncs and a 0.5 second timeout betw=
een
> -        # iterations, this will sync if dirty every ~30 seconds.
> +        # 60 iterations between syncs or sync if dirty every ~30 seconds
>          iterations_between_sync =3D 60
> =20
> -        while True:
> -            (request, client_address) =3D self.requestqueue.get()
> +        while not self.quit:
> +            try:
> +                (request, client_address) =3D self.requestqueue.get(True=
, 30)
> +            except Queue.Empty:
> +                self.table.sync_if_dirty()
> +                continue
>              try:
>                  self.finish_request(request, client_address)
>                  self.shutdown_request(request)
> @@ -93,6 +96,7 @@ class PRServer(SimpleXMLRPCServer):
>                  self.handle_error(request, client_address)
>                  self.shutdown_request(request)
>                  self.table.sync()
> +            self.table.sync_if_dirty()
> =20
>      def process_request(self, request, client_address):
>          self.requestqueue.put((request, client_address))
> @@ -137,7 +141,7 @@ class PRServer(SimpleXMLRPCServer):
>          self.handlerthread.start()
>          while not self.quit:
>              self.handle_request()
> -
> +        self.handlerthread.join()
>          self.table.sync()
>          logger.info("PRServer: stopping...")
>          self.server_close()
> --=20
> 2.1.0
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlXnMYcACgkQN1Ujt2V2gBw4HgCdHVSc9g1GT8/jZDlv8PwMEME8
RlcAn1FcQ+k6X8ZeslGeAzKHKiT/hjUJ
=2rsY
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
