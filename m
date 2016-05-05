Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id A0E7A731D1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 May 2016 15:30:35 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id n129so25207755wmn.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 May 2016 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:subject:message-id:mime-version:content-disposition
	:user-agent; bh=M9fV7G0gFbopihSNvpPuUD/C5m9I1s4vFESiS3WjZpU=;
	b=VKKOoV1uvS/KgiYhX9Fm3RbbI3UwG5XygN06PmB9znn3pXnDN5zoo4+nPlq0L7t5tc
	BX8O9UfzKMlSa470q/luyijE4vKDklBwYEilwxWMFCO9VC6cS/cqlH6mpL934C2NxXMS
	j5xlATI7teAQcL0InDSGInhFMZ48py8/obZR3hWrEYTruU7ZLZZZ1chYnkUs27juJGBc
	EHT272qpukVjity9eLzy61eA8GsFaSizCfCCRaNnhLj+OWeFa+nXnmifoHFnKGUrcaCR
	1g7Uhfx2/uRYgJVNwcwJP81EZznvVm6UCEUHFpIWklS4O94PQcGLWqDsnV3f03RRklZV
	pgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:date:to:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=M9fV7G0gFbopihSNvpPuUD/C5m9I1s4vFESiS3WjZpU=;
	b=bSFBYPQ23j8Ks0lFC4eux6OgvbUQHfXspBZqNlVMWB/oyKGO+0bZztJiinzTuwcC+p
	hxCc9q1Sntv2YDRhtal8S/iF8vru2qqCAthC3KwZ0lhsrRcWZshtPY/QOhs99Ye1ftO/
	TmJnyuLTu3nnsPCYrI/f5Uid7PKqJpwqOhg29tsB1f1aWobdsEyPZSNFDzFp6uO+XoEE
	E2EkC59pcOjV28GLhayPuPnO6H90BZsgYImkUJIJEaSo14YXY0XxAPFNlaZIBl1xccdF
	N9eRTXIrFJn9FU6yx3JFnM+FWFjUAfTUvWfyQStAtIRlwrows4WF5Y61/O5Zn5YfLH87
	0LEg==
X-Gm-Message-State: AOPr4FVAnahJNKZhEA5OQfg4fKpJym56FG+zCfnpAWP2OSYf1zerHxirOt6SC7PvbFAusQ==
X-Received: by 10.194.11.97 with SMTP id p1mr14485329wjb.159.1462462235687;
	Thu, 05 May 2016 08:30:35 -0700 (PDT)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	d1sm10235673wjb.47.2016.05.05.08.30.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 May 2016 08:30:34 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Thu, 5 May 2016 17:31:58 +0200
To: bitbake-devel@lists.openembedded.org
Message-ID: <20160505153158.GB2562@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.6.1 (2016-04-27)
Subject: lsof fails with python exception when bitbake is finished
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
X-List-Received-Date: Thu, 05 May 2016 15:30:36 -0000
X-Groupsio-MsgNum: 7377
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I haven't checked what leads to this error, but with latest oe-core and bit=
bake
I've noticed ugly python exception after successful build with bitbake:


Summary: There were 35 WARNING messages shown.
Process ProcessServer-1:
Traceback (most recent call last):
  File "/usr/lib/python2.7/multiprocessing/process.py", line 258, in _boots=
trap
    self.run()
  File "/OE/bitbake/lib/bb/server/process.py", line 104, in run
    bb.cooker.server_main(self.cooker, self.main)
  File "/OE/bitbake/lib/bb/cooker.py", line 1692, in server_main
    cooker.post_serve()
  File "/OE/bitbake/lib/bb/cooker.py", line 1627, in post_serve
    procs =3D subprocess.check_output(["lsof", '-w', lockfile], stderr=3Dsu=
bprocess.STDOUT)
  File "/usr/lib/python2.7/subprocess.py", line 573, in check_output
    raise CalledProcessError(retcode, cmd, output=3Doutput)
CalledProcessError: Command '['lsof', '-w', '/OE/bitbake.lock']' returned n=
on-zero exit status 1
/OE/$ lsof -w /OE/bitbake.lock
/OE/$ echo $?
1
/OE/$ ls -lah bitbake.lock=20
-rw-rw-r-- 1 mjansa mjansa 0 May  5 13:19 bitbake.lock

$ lsof -v
lsof version information:
    revision: 4.86
    latest revision: ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/
    latest FAQ: ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/FAQ
    latest man page: ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/lsof_man
    constructed: Sun Dec 2 02:36:48 UTC 2012
    constructed by and on: buildd@allspice
    compiler: cc
    compiler version: 4.7.2 (Ubuntu/Linaro 4.7.2-12ubuntu1)=20
    compiler flags: -g -O2 -fPIE -fstack-protector --param=3Dssp-buffer-siz=
e=3D4 -Wformat -Werror=3Dformat-security -D_FORTIFY_SOURCE=3D2 -DLINUXV=3D3=
7000 -DGLIBCV=3D216 -DHASIPv6 -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE64_SOURC=
E -DHAS_STRFTIME -DLSOF_VSTR=3D"3.7.0" -O
    loader flags: -L./lib -llsof -Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z=
,relro -Wl,-z,now
    system info: Linux allspice 3.2.0-33-generic #52-Ubuntu SMP Thu Oct 18 =
16:29:15 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
    Anyone can list all files.
    /dev warnings are disabled.
    Kernel ID check is disabled.

Is this expected?

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlcrZzoACgkQN1Ujt2V2gBxBYwCgp7KALTmGi2sfE3uK9tnh6yyk
bloAoKQIU68hjOHUluaLijBJ6b1kZh9b
=wiAU
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
