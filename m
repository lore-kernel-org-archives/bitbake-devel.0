Received: from mailout2.ltindia.com ([125.18.18.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Girija.B@lnties.com>) id 1SpHDB-0007nM-Ru
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Jul 2012 13:06:10 +0200
Received: from unknown (HELO POCITMSEXHUB01.LntUniverse.com) ([10.2.1.58])
	by mailout2.ltindia.com with ESMTP; 12 Jul 2012 16:23:58 +0530
Received: from POCITMSEXMB03.LntUniverse.com ([fe80::f495:7e6e:4c34:a3a9]) by
	POCITMSEXHUB01.LntUniverse.com ([::1]) with mapi id 14.02.0309.002;
	Thu, 12 Jul 2012 16:23:56 +0530
From: Girija B <Girija.B@lnties.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: bitbake error 
Thread-Index: AQHNYByiLSf6WCPDVUaYHvN65ohxJQ==
Date: Thu, 12 Jul 2012 10:53:56 +0000
Message-ID: <098684E1B7B2F54491C5DA349D2EF443098FD828@POCITMSEXMB03.LntUniverse.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.1.74]
MIME-Version: 1.0
Subject: bitbake error
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
X-List-Received-Date: Thu, 12 Jul 2012 11:06:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I have installed bitbake and open embedded environment , when i run the com=
mand : bitbake meta-toolchain-qte , am getting the following error :
Pseudo is not present but is required, building this first before the main =
build
ERROR: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_sr=
crev(d)} which triggered exception FetchError: Fetcher failure: Fetch comma=
nd export HOME=3D"/home/girija"; export SSH_AUTH_SOCK=3D"/tmp/keyring-vMpej=
Y/ssh"; export GIT_CONFIG=3D"/home/girija/mft/platform/build/tmp-eglibc/sys=
roots/i686-linux/etc/gitconfig"; export PATH=3D"/home/girija/mft/platform/b=
uild/tmp-eglibc/sysroots/i686-linux/usr/bin/armv5te-oe-linux-gnueabi:/home/=
girija/mft/platform/build/tmp-eglibc/sysroots/tonga2/usr/bin/crossscripts:/=
home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/sbin:/hom=
e/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/bin:/home/gi=
rija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/sbin:/home/girija/mf=
t/platform/build/tmp-eglibc/sysroots/i686-linux//bin:/home/girija/mft/platf=
orm/3rd-party/bitbake/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin=
:/sbin:/bin:/usr/games:/home/girija/mft/platform/3rd-party/openembedded-cor=
e/scripts"; git ls-remote ssh://git@savage-git:10221/var/lib/git/joule/joul=
e-test-app master could not be run:
None
ERROR: Command execution failed: Exited with 1

Summary: There were 2 ERROR messages shown, returning a non-zero exit code.



please help me in solving this

Thanks,
Girija.B
Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the inten=
ded recipient (s). If you are not the intended recipient, please do not use=
 or disseminate the information, notify the sender and delete it from your =
system.


