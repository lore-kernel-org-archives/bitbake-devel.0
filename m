Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1RXs1J-00063f-4R
	for bitbake-devel@lists.openembedded.org;
	Tue, 06 Dec 2011 11:13:05 +0100
Received: by eaac1 with SMTP id c1so1381336eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Dec 2011 02:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	bh=IoGJ7uYatgPCDDXdfLyU2WXEjTwoicuH4zTne9MIk5A=;
	b=DrdUBdAu5gQTmGUWMIhzCEL08M/hLLeqT3neL5gvXoR4hJCuXWvOxiKrHZ0wEDOcsL
	QZPlOmaw7MIlihudwbqRSCtYYk6dF+BVNUffZPtWN6zcluV1tTnzuMdsBIiggruAv+KB
	N5DJv53OLA/P6H8XGuoZN5yJUvmRO8zfhY0Xw=
Received: by 10.213.35.16 with SMTP id n16mr2191326ebd.59.1323165978095;
	Tue, 06 Dec 2011 02:06:18 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id a60sm69397901eeb.4.2011.12.06.02.06.15
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 06 Dec 2011 02:06:16 -0800 (PST)
Date: Tue, 6 Dec 2011 11:06:04 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20111206100603.GB5456@jama.jama.net>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [PATCH] fetch2: fix Exception parameters when BB_STRICT_CHECKSUM enabled
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
X-List-Received-Date: Tue, 06 Dec 2011 10:13:05 -0000
X-Groupsio-MsgNum: 683
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline

--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With today's master I'm still getting rather long error message when just c=
hecksums are wrong.
Do I have something wrong in my configuration?

NOTE: Running task 1 of 12 (ID: 4, openembedded-core/meta/recipes-devtools/=
subversion/subversion_1.7.2.bb, do_fetch)
NOTE: package subversion-1.7.2-r0: task do_fetch: Started
WARNING: Fetcher failure for URL: 'http://archive.apache.org/dist/subversio=
n/subversion-1.7.2.tar.bz2'. Checksum mismatch!
File: '/OE/shr-core/downloads/subversion-1.7.2.tar.bz2' has md5 checksum 1e=
5dfffd27be080672e5a042564368a8 when 8a4fa74385df85a9702141b6b68b8307 was ex=
pected (from URL: 'http://archive.apache.org/dist/subversion/subversion-1.7=
=2E2.tar.bz2')
File: '/OE/shr-core/downloads/subversion-1.7.2.tar.bz2' has sha256 checksum=
 7eb3e1ae2b0385e1cc20ca9e1839e0ef0ac98a7455dc52ba4cdf567547bfc517 when d34b=
de626fac1aa553f5c9aeedf961999a77cc31540ace18da5aeacdd03d6608 was expected (=
=66rom URL: 'h
ttp://archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2')
ERROR: Function 'Fetcher failure for URL: 'http://archive.apache.org/dist/s=
ubversion/subversion-1.7.2.tar.bz2'. Unable to fetch URL http://archive.apa=
che.org/dist/subversion/subversion-1.7.2.tar.bz2 from any source.' failed
ERROR: Logfile of failure stored in: /OE/shr-core/tmp-eglibc/work/armv5te-o=
e-linux-gnueabi/subversion-1.7.2-r0/temp/log.do_fetch.17472
Log data follows:
| DEBUG: Trying PREMIRRORS
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['cvs', '.*', '/.*', '', '', {}] to=
 ['http', 'build.shr-project.org', '/sources/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['svn', '.*', '/.*', '', '', {}] to=
 ['http', 'build.shr-project.org', '/sources/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['git', '.*', '/.*', '', '', {}] to=
 ['http', 'build.shr-project.org', '/sources/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['hg', '.*', '/.*', '', '', {}] to =
['http', 'build.shr-project.org', '/sources/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['bzr', '.*', '/.*', '', '', {}] to=
 ['http', 'build.shr-project.org', '/sources/', '', '', {}]
| DEBUG: Trying Upstream
| NOTE: fetch http://archive.apache.org/dist/subversion/subversion-1.7.2.ta=
r.bz2
| DEBUG: executing /usr/bin/env wget -t 5 -q --passive-ftp --no-check-certi=
ficate -P /OE/shr-core/downloads 'http://archive.apache.org/dist/subversion=
/subversion-1.7.2.tar.bz2'
| DEBUG: Fetcher accessed the network with the command /usr/bin/env wget -t=
 5 -q --passive-ftp --no-check-certificate -P /OE/shr-core/downloads 'http:=
//archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2'
| DEBUG: Running export HOME=3D"/OE"; export GIT_CONFIG=3D"/OE/shr-core/tmp=
-eglibc/sysroots/x86_64-linux/usr/etc/gitconfig"; export PATH=3D"/OE/shr-co=
re/tmp-eglibc/sysroots/x86_64-linux/usr/bin/armv5te-oe-linux-gnueabi:/OE/sh=
r-core/tmp-eglibc/
sysroots/spitz/usr/bin/crossscripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64=
-linux/usr/sbin:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin:/OE/s=
hr-core/tmp-eglibc/sysroots/x86_64-linux/sbin:/OE/shr-core/tmp-eglibc/sysro=
ots/x86_64-l
inux//bin:/OE/shr-core/openembedded-core/scripts:/OE/bin:/usr/local/bin:/us=
r/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.6.2:/OE/shr-core/ope=
nembedded-core/scripts/:/OE/shr-core/openembedded-core/scripts"; /usr/bin/e=
nv wget -t 5
 -q --passive-ftp --no-check-certificate -P /OE/shr-core/downloads 'http://=
archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2'
| WARNING: Fetcher failure for URL: 'http://archive.apache.org/dist/subvers=
ion/subversion-1.7.2.tar.bz2'. Checksum mismatch!
| File: '/OE/shr-core/downloads/subversion-1.7.2.tar.bz2' has md5 checksum =
1e5dfffd27be080672e5a042564368a8 when 8a4fa74385df85a9702141b6b68b8307 was =
expected (from URL: 'http://archive.apache.org/dist/subversion/subversion-1=
=2E7.2.tar.bz2
')
| File: '/OE/shr-core/downloads/subversion-1.7.2.tar.bz2' has sha256 checks=
um 7eb3e1ae2b0385e1cc20ca9e1839e0ef0ac98a7455dc52ba4cdf567547bfc517 when d3=
4bde626fac1aa553f5c9aeedf961999a77cc31540ace18da5aeacdd03d6608 was expected=
 (from URL:
'http://archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2')
| DEBUG: Trying MIRRORS
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool/main', '', '', {}] to ['http', 'snapshot.debian.net', '/archive/pool',=
 '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.de.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.au.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.cl.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.hr.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.fi.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.hk.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.hu.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.ie.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.it.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.jp.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.no.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.pl.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.ro.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.si.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.es.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.se.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.debian.org', '/debian/=
pool', '', '', {}] to ['ftp', 'ftp.tr.debian.org', '/debian/pool', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnu.org', '/gnu', '', =
'', {}] to ['ftp', 'mirrors.kernel.org', '/gnu', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnu.org', '/gnu', '', =
'', {}] to ['ftp', 'ftp.matrix.com.br', '/pub/gnu', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnu.org', '/gnu', '', =
'', {}] to ['ftp', 'ftp.cs.ubc.ca', '/mirror2/gnu', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnu.org', '/gnu', '', =
'', {}] to ['ftp', 'sunsite.ust.hk', '/pub/gnu', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnu.org', '/gnu', '', =
'', {}] to ['ftp', 'ftp.ayamura.org', '/pub/gnu', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'kernel.org', '/pub', '', =
'', {}] to ['http', 'www.kernel.org', '/pub', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'kernel.org', '/pub', '', =
'', {}] to ['ftp', 'ftp.us.kernel.org', '/pub', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'kernel.org', '/pub', '', =
'', {}] to ['ftp', 'ftp.uk.kernel.org', '/pub', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'kernel.org', '/pub', '', =
'', {}] to ['ftp', 'ftp.hk.kernel.org', '/pub', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'kernel.org', '/pub', '', =
'', {}] to ['ftp', 'ftp.au.kernel.org', '/pub', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'kernel.org', '/pub', '', =
'', {}] to ['ftp', 'ftp.jp.kernel.org', '/pub', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnupg.org', '/gcrypt/'=
, '', '', {}] to ['ftp', 'ftp.franken.de', '/pub/crypt/mirror/ftp.gnupg.org=
/gcrypt/', '
', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnupg.org', '/gcrypt/'=
, '', '', {}] to ['ftp', 'ftp.surfnet.nl', '/pub/security/gnupg/', '', '', =
{}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnupg.org', '/gcrypt/'=
, '', '', {}] to ['http', 'gulus.USherbrooke.ca', '/pub/appl/GnuPG/', '', '=
', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'dante.ctan.org', '/tex-arc=
hive', '', '', {}] to ['ftp', 'ftp.fu-berlin.de', '/tex/CTAN', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'dante.ctan.org', '/tex-arc=
hive', '', '', {}] to ['http', 'sunsite.sut.ac.jp', '/pub/archives/ctan/', =
'', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'dante.ctan.org', '/tex-arc=
hive', '', '', {}] to ['http', 'ctan.unsw.edu.au', '/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnutls.org', '/pub/gnu=
tls', '', '', {}] to ['ftp', 'ftp.gnutls.org', '/pub/gnutls/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnutls.org', '/pub/gnu=
tls', '', '', {}] to ['ftp', 'ftp.gnupg.org', '/gcrypt/gnutls/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnutls.org', '/pub/gnu=
tls', '', '', {}] to ['http', 'www.mirrors.wiretapped.net', '/security/netw=
ork-security
/gnutls/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnutls.org', '/pub/gnu=
tls', '', '', {}] to ['ftp', 'ftp.mirrors.wiretapped.net', '/pub/security/n=
etwork-secur
ity/gnutls/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'ftp.gnutls.org', '/pub/gnu=
tls', '', '', {}] to ['http', 'josefsson.org', '/gnutls/releases/', '', '',=
 {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'ftp.info-zip.org', '/pub/=
infozip/src/', '', '', {}] to ['http', 'mirror.switch.ch', '/ftp/mirror/inf=
ozip/src/',
'', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'ftp.info-zip.org', '/pub/=
infozip/src/', '', '', {}] to ['ftp', 'sunsite.icm.edu.pl', '/pub/unix/arch=
iving/info-z
ip/src/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'ftp.cerias.purdue.edu', '/pub=
/tools/unix/
sysutils/lsof/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'ftp.tau.ac.il', '/pub/unix/ad=
min/', '', '
', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'ftp.cert.dfn.de', '/pub/tools=
/admin/lsof/
', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'ftp.fu-berlin.de', '/pub/unix=
/tools/lsof/
', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'ftp.kaizo.org', '/pub/lsof/',=
 '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'ftp.tu-darmstadt.de', '/pub/s=
ysadmin/lsof
/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'ftp.tux.org', '/pub/sites/vic=
=2Ecc.purdue.e
du/tools/unix/lsof/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'gd.tuwien.ac.at', '/utils/adm=
in-tools/lso
f/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'sunsite.ualberta.ca', '/pub/M=
irror/lsof/'
, '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', 'lsof.itap.purdue.edu', '/p=
ub/tools/unix/lsof/', '', '', {}] to ['ftp', 'the.wiretapped.net', '/pub/se=
curity/host-
security/lsof/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['http', 'www.apache.org', '/dist',=
 '', '', {}] to ['http', 'archive.apache.org', '/dist', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['ftp', '.*', '/.*', '', '', {}] to=
 ['http', 'build.shr-project.org', '/sources/', '', '', {}]
| DEBUG: For url ['http', 'archive.apache.org', '/dist/subversion/subversio=
n-1.7.2.tar.bz2', '', '', {}] comparing ['https?$', '.*', '/.*', '', '', {}=
] to ['http', 'build.shr-project.org', '/sources/', '', '', {}]
| DEBUG: For url http://archive.apache.org/dist/subversion/subversion-1.7.2=
=2Etar.bz2 returning http://build.shr-project.org/sources/subversion-1.7.2.=
tar.bz2
| NOTE: fetch http://build.shr-project.org/sources/subversion-1.7.2.tar.bz2
| DEBUG: executing /usr/bin/env wget -t 5 -q --passive-ftp --no-check-certi=
ficate -P /OE/shr-core/downloads 'http://build.shr-project.org/sources/subv=
ersion-1.7.2.tar.bz2'
| DEBUG: Fetcher accessed the network with the command /usr/bin/env wget -t=
 5 -q --passive-ftp --no-check-certificate -P /OE/shr-core/downloads 'http:=
//build.shr-project.org/sources/subversion-1.7.2.tar.bz2'
| DEBUG: Running export HOME=3D"/OE"; export GIT_CONFIG=3D"/OE/shr-core/tmp=
-eglibc/sysroots/x86_64-linux/usr/etc/gitconfig"; export PATH=3D"/OE/shr-co=
re/tmp-eglibc/sysroots/x86_64-linux/usr/bin/armv5te-oe-linux-gnueabi:/OE/sh=
r-core/tmp-eglibc/
sysroots/spitz/usr/bin/crossscripts:/OE/shr-core/tmp-eglibc/sysroots/x86_64=
-linux/usr/sbin:/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/bin:/OE/s=
hr-core/tmp-eglibc/sysroots/x86_64-linux/sbin:/OE/shr-core/tmp-eglibc/sysro=
ots/x86_64-l
inux//bin:/OE/shr-core/openembedded-core/scripts:/OE/bin:/usr/local/bin:/us=
r/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.6.2:/OE/shr-core/ope=
nembedded-core/scripts/:/OE/shr-core/openembedded-core/scripts"; /usr/bin/e=
nv wget -t 5
 -q --passive-ftp --no-check-certificate -P /OE/shr-core/downloads 'http://=
build.shr-project.org/sources/subversion-1.7.2.tar.bz2'
| DEBUG: Mirror fetch failure for url http://build.shr-project.org/sources/=
subversion-1.7.2.tar.bz2 (original url: http://archive.apache.org/dist/subv=
ersion/subversion-1.7.2.tar.bz2)
| DEBUG: Fetcher failure for URL: 'None'. Fetch command export HOME=3D"/OE"=
; export GIT_CONFIG=3D"/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/et=
c/gitconfig"; export PATH=3D"/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/=
usr/bin/armv5te-oe
-linux-gnueabi:/OE/shr-core/tmp-eglibc/sysroots/spitz/usr/bin/crossscripts:=
/OE/shr-core/tmp-eglibc/sysroots/x86_64-linux/usr/sbin:/OE/shr-core/tmp-egl=
ibc/sysroots/x86_64-linux/usr/bin:/OE/shr-core/tmp-eglibc/sysroots/x86_64-l=
inux/sbin:/O
E/shr-core/tmp-eglibc/sysroots/x86_64-linux//bin:/OE/shr-core/openembedded-=
core/scripts:/OE/bin:/usr/local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-l=
inux-gnu/gcc-bin/4.6.2:/OE/shr-core/openembedded-core/scripts/:/OE/shr-core=
/openembedde
d-core/scripts"; /usr/bin/env wget -t 5 -q --passive-ftp --no-check-certifi=
cate -P /OE/shr-core/downloads 'http://build.shr-project.org/sources/subver=
sion-1.7.2.tar.bz2' failed with signal 8, output:
|
| ERROR: Function 'Fetcher failure for URL: 'http://archive.apache.org/dist=
/subversion/subversion-1.7.2.tar.bz2'. Unable to fetch URL http://archive.a=
pache.org/dist/subversion/subversion-1.7.2.tar.bz2 from any source.' failed
NOTE: package subversion-1.7.2-r0: task do_fetch: Failed
ERROR: Task 4 (openembedded-core/meta/recipes-devtools/subversion/subversio=
n_1.7.2.bb, do_fetch) failed with exit code '1'
ERROR: 'openembedded-core/meta/recipes-devtools/subversion/subversion_1.7.2=
=2Ebb' failed

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk7d6QsACgkQN1Ujt2V2gBwSpQCeOLsH2XDiWFH+JTYhWUL1URyE
ArIAoI2VfOuoLOncRsy4n8tdMBN7ZPA2
=muxQ
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
