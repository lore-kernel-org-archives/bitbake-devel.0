Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
	by mail.openembedded.org (Postfix) with ESMTP id 5769B6C732;
	Sat, 22 Feb 2014 12:07:08 +0000 (UTC)
Received: by mail-ee0-f45.google.com with SMTP id e53so563729eek.18
	for <multiple recipients>; Sat, 22 Feb 2014 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	bh=KrUgdiUNnsNpAsA9LTF0mAClWiasSTCNpR6+aDnlgjg=;
	b=hsem1zctXWKKHjiPN6PN45lJj06UBIGx9uLiZqGYq7MWMFogxg+2AvSKXfVBLfn4EK
	QQZlkPzYUUzzv7pqnyshCKrmmC1RkPpKU5QBR+Uwtofvy5jIH5p3HJCETRR2GircSpF4
	CdY/Xw5katJlXeATqGP4rimj5h02Y/GJW3NSKYCp+eyr9xW6PoXCI7YkJvobEwAfytWV
	dMLlADJlHN8aOwqIDOPzSShemS9Fbtb/D4uG1E5muHcej9sDZKSIWNWPrB5Qi1c0hK23
	76t3rkEMgvPLxyPHFR2hHrAHlJB/2w3hqzN70nbbVY8aCKpidkWB/ZIAtWugbARUqKdV
	k7ig==
X-Received: by 10.15.81.197 with SMTP id x45mr13550845eey.28.1393070829222;
	Sat, 22 Feb 2014 04:07:09 -0800 (PST)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	o43sm38133098eef.12.2014.02.22.04.07.05 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 22 Feb 2014 04:07:08 -0800 (PST)
Date: Sat, 22 Feb 2014 13:07:36 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Message-ID: <20140222120736.GN3854@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.5.22 (2013-10-16)
Subject: ValueError: insecure string pickle with latest bitbake
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
X-List-Received-Date: Sat, 22 Feb 2014 12:07:09 -0000
X-Groupsio-MsgNum: 4410
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
Content-Disposition: inline

--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

last couple of days many of my jenkins builds failed with exception like
this:

ERROR: An uncaught exception occured in runqueue, please see the failure be=
low:
ERROR: Running idle function
Traceback (most recent call last):
  File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/cooker.p=
y", line 1182, in buildTargetsIdle(server=3D<ProcessServer(ProcessServer-2,=
 started)>, rq=3D<bb.runqueue.RunQueue instance at 0x16a95d40>, abort=3DFal=
se):
                 try:
    >                retval =3D rq.execute_runqueue()
                 except runqueue.TaskFailure as exc:
  File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue=
=2Epy", line 1093, in RunQueue.execute_runqueue():
                 try:
    >                self.teardown_workers()
                 except:
  File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue=
=2Epy", line 925, in RunQueue.teardown_workers():
             self.workerpipe =3D None
    >        self._teardown_worker(self.fakeworker, self.fakeworkerpipe)
             self.fakeworker =3D None
  File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue=
=2Epy", line 906, in RunQueue._teardown_worker(worker=3D<subprocess.Popen o=
bject at 0xcb4e690>, workerpipe=3D<bb.runqueue.runQueuePipe instance at 0x1=
1c17710>):
             while worker.returncode is None:
    >            workerpipe.read()
                 worker.poll()
  File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue=
=2Epy", line 2095, in runQueuePipe.read():
                 while index !=3D -1 and self.queue.startswith("<event>"):
    >                event =3D pickle.loads(self.queue[7:index])
                     bb.event.fire_from_worker(event, self.d)
ValueError: insecure string pickle

and it repeats the same exception very quickly (generated 3GB log in ~ hour)

It doesn't happen always, it seems to be triggered in different places in b=
uild.

Anyone else seeing this as well?

I'll add some debug output around it and wait for it to happen again.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlMIkwgACgkQN1Ujt2V2gBy6OwCgjW/owSkcC+LIN2Yx9IE6rHn5
Jz4An1DDMeBjk71+xqMhmH/7yJom5iBF
=alFC
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
