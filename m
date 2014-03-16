Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
	by mail.openembedded.org (Postfix) with ESMTP id 17DDD6DC4C
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 16 Mar 2014 23:56:05 +0000 (UTC)
Received: by mail-ee0-f42.google.com with SMTP id d17so3502306eek.15
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 16 Mar 2014 16:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=rWSuyF4YKCXonokUJXZleg9RA13nYyBEnGUtSQvYbe0=;
	b=IxanWnh4jrBVCikUHdB/lVyu5JrdRnu+tvB9NIYY9XFHtzGs72PksUiDkgPPHJUC/k
	KfWIdTpaenWalgiNZq2P/HSi3CT00YcJSl8zn7um6XmWv6E3yGyW1lcuYdk/GDrwu42t
	4075G9p38CGrBgtEVPDb+vsigJztSsdnVJ9WbiHdyyvM2nSOkT+bD9GTjFAlHQ18O3J9
	3y+hBtvYmzqcjKIzy2jSqzC2dfuCaH2F+D8S6FLIEy5+t/SEBNRGH27SbmsOr2ta6oBu
	1/9GQXy1BqKCgqbWfSztf0KzFfQdYSTxo/Evfn2chu8zCJotvsrAv3VFwZsqD/L2G0Vs
	vBUg==
X-Received: by 10.14.213.135 with SMTP id a7mr20627741eep.57.1395014166560;
	Sun, 16 Mar 2014 16:56:06 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	43sm35596755eeh.13.2014.03.16.16.56.01 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 16 Mar 2014 16:56:02 -0700 (PDT)
Date: Mon, 17 Mar 2014 00:56:20 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Message-ID: <20140316235620.GC3725@jama>
References: <CAJTo0LZffXzAyhu23+phNpKTNbvRV5zYvwRQR5ssvG-t_isqnw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJTo0LZffXzAyhu23+phNpKTNbvRV5zYvwRQR5ssvG-t_isqnw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Exception on error
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
X-List-Received-Date: Sun, 16 Mar 2014 23:56:07 -0000
X-Groupsio-MsgNum: 4509
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 04:35:35PM +0000, Burton, Ross wrote:
> Hi,
>=20
> Just got this error when bitbake was shutting down after a failed parse:
>=20
> ERROR: An uncaught exception occured in runqueue, please see the failure =
below:
> ERROR: Running idle function
> Traceback (most recent call last):
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/server/process.py", line
> 128, in ProcessServer.idle_commands(delay=3D0.1, fds=3D[<read-only
> Connection, handle 4>, <read-write Connection, handle 7>, <read-write
> Connection, handle 12>]):
>                  try:
>     >                retval =3D function(self, data, False)
>                      if retval is False:
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/cooker.py", line 1171, in
> buildTargetsIdle(server=3D<ProcessServer(ProcessServer-1, started)>,
> rq=3D<bb.runqueue.RunQueue instance at 0x16b8dd40>, abort=3DFalse):
>                  try:
>     >                retval =3D rq.execute_runqueue()
>                  except runqueue.TaskFailure as exc:
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/runqueue.py", line 1122,
> in RunQueue.execute_runqueue():
>                  try:
>     >                self.teardown_workers()
>                  except:
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/runqueue.py", line 950,
> in RunQueue.teardown_workers():
>              self.teardown =3D True
>     >        signal.signal(signal.SIGCHLD, self.oldsigchld)
>              self._teardown_worker(self.worker, self.workerpipe)
> TypeError: signal handler must be signal.SIG_IGN, signal.SIG_DFL, or a
> callable object
>=20
> I can look into this maybe tomorrow but hopefully someone will
> recognise it as a simple fix and send a patch first.

I've started seeing this one today in some builds and only sometimes,

bitbake -S some-image

seems to be best reproducer here.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlMmOiQACgkQN1Ujt2V2gBwVkQCghDhQjic9dU0oWhEo7xYuduO2
ZjgAniQIuKfPH8fO4Mysmi2QztruWIkS
=7f2w
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
