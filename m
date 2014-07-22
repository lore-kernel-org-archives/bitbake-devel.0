Return-Path: <martin.jansa@gmail.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id 2E91C65C83
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 14:45:53 +0000 (UTC)
Received: by mail-we0-f171.google.com with SMTP id p10so9344778wes.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=zB+Ivcg4VzNs9w5BZh8nj4R0wq5ijPd0HW8y62VbGeU=;
	b=T3Z4zH7i/+ntgDxVK5FO5RnCJku/7DGoIy7tQXegahax6hZY3kzA1V1jfObxIAt3A/
	Qr2EYlPF4//25nVmclegGeXfLboruOyl7C0H9z6/3f7Hj4RlKkrrP4bSI0eycQNDFJ3B
	YRvcExI3Gg0X8vuN0Uhef2BMCp1FezxZLcpOmm5ycnn9pgHnztrawwtLRer1v6Y5Wboo
	Zb7m+x3UHJXoZjQD7Uo7Mi9C5fV5tQ5K4Yw9IYSe4Q9lTIDKQtr1tSZg2UOUeyAKDh9c
	BEa1VJWOAcb8/RL4+H8LiqM3sPKH0JU9PhWv4ayduuUlhVMprnTvBEvm1DIWtnavXA08
	cKww==
X-Received: by 10.180.73.115 with SMTP id k19mr7266201wiv.35.1406040351165;
	Tue, 22 Jul 2014 07:45:51 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	es1sm3400052wib.16.2014.07.22.07.45.49 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 22 Jul 2014 07:45:49 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 22 Jul 2014 16:46:05 +0200
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140722144605.GT22875@jama>
References: <1405931753.22985.93.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1405931753.22985.93.camel@ted>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] command/runqueue: Fix shutdown logic
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
X-List-Received-Date: Tue, 22 Jul 2014 14:46:04 -0000
X-Groupsio-MsgNum: 4932
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhxWStFQ84VXWhXs"
Content-Disposition: inline

--FhxWStFQ84VXWhXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 09:35:53AM +0100, Richard Purdie wrote:
> If you hit Ctrl+C at the right point, the system processes the request
> but merrily continues building. It turns out finish_runqueue() is called
> but this doesn't stop the later generation and execution of the
> runqueue.
>=20
> This patch adjusts some of the conditionals to ensure the build really
> does stop.

Great, I've included this change in my world builds to see if it fixes
bitbake still running after jenkins job is aborted.

I don't think it's caused by this change and I don't know how much we
can do about it, but today I was testing snort build (which eats all
memory in m4 call until OOMK kills it) and when I wanted to interrupt
the build it failed with 2 tracebacks:

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: Running task 569 of 610 (ID: 5, /OE/build/oe-core/meta-openembedded/m=
eta-networking/recipes-connectivity/snort/snort_2.9.6.0.bb, do_configure)
NOTE: recipe snort-2.9.6.0-r0: task do_configure: Started
^C^C^C^C^C^C^C^C^C^C^C^C^C^CTraceback (most recent call last):
  File "/OE/build/oe-core/bitbake/bin/bitbake", line 382, in <module>
    ret =3D main()
  File "/OE/build/oe-core/bitbake/bin/bitbake", line 372, in main
    bb.event.ui_queue =3D []
KeyboardInterrupt
^CException KeyboardInterrupt in <module 'threading' from '/usr/lib64/pytho=
n2.7/threading.pyc'> ignored

^CError in atexit._run_exitfuncs:
^CError in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib64/python2.7/atexit.py", line 30, in _run_exitfuncs
    traceback.print_exc()
  File "/usr/lib64/python2.7/traceback.py", line 233, in print_exc
    print_exception(etype, value, tb, limit, file)
  File "/usr/lib64/python2.7/traceback.py", line 110, in print_exception
    def print_exception(etype, value, tb, limit=3DNone, file=3DNone):
KeyboardInterrupt

There was also about 5 minute delay between first 2 Ctrl+C and actual
exit, but that could be caused by huge load caused by that faulty m4.

Regards,

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 84fcdf9..d797fcf 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -86,7 +86,7 @@ class Command:
> =20
>      def runAsyncCommand(self):
>          try:
> -            if self.cooker.state =3D=3D bb.cooker.state.error:
> +            if self.cooker.state in (bb.cooker.state.error, bb.cooker.st=
ate.shutdown, bb.cooker.state.forceshutdown):
>                  return False
>              if self.currentAsyncCommand is not None:
>                  (command, options) =3D self.currentAsyncCommand
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 4ea4970..f68a11d 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1065,7 +1065,7 @@ class RunQueue:
>          if self.state is runQueueCleanUp:
>             self.rqexe.finish()
> =20
> -        if self.state is runQueueComplete or self.state is runQueueFaile=
d:
> +        if (self.state is runQueueComplete or self.state is runQueueFail=
ed) and self.rqexe:
>              self.teardown_workers()
>              if self.rqexe.stats.failed:
>                  logger.info("Tasks Summary: Attempted %d tasks of which =
%d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + se=
lf.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
> @@ -1106,6 +1106,7 @@ class RunQueue:
> =20
>      def finish_runqueue(self, now =3D False):
>          if not self.rqexe:
> +            self.state =3D runQueueComplete
>              return
> =20
>          if now:
> --=20
> cgit v0.10.1
>=20
>=20
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--FhxWStFQ84VXWhXs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlPOeS0ACgkQN1Ujt2V2gByEmQCfSeVFeuKnuJ8P6YIzWHuabnQr
7aAAn10xaJTkprxAS0HONHUMIZao94TR
=oXe5
-----END PGP SIGNATURE-----

--FhxWStFQ84VXWhXs--
