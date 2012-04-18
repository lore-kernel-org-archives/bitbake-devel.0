Received: from mx4.leapfrog.com ([63.114.26.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1SKck8-0004OA-7I
	for bitbake-devel@lists.openembedded.org;
	Wed, 18 Apr 2012 23:48:52 +0200
Received: from mx4.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP id 4E7C15EB3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Apr 2012 14:21:41 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx4.leapfrog.com (Postfix) with ESMTP id 35D885E73
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Apr 2012 14:21:41 -0700 (PDT)
Received: from NAEMCASHT01.na.leapfrog.com (10.16.4.161) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Wed, 18 Apr 2012 14:21:55 -0700
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT01.na.leapfrog.com ([::1]) with mapi id 14.01.0355.002;
	Wed, 18 Apr 2012 14:21:55 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: "'bitbake-devel@lists.openembedded.org'
	(bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: python function used in variable expansion called multiple
	times per recipe
Thread-Index: Ac0dqUJmIcsujxmfQlyaUhmEaDraqQ==
Date: Wed, 18 Apr 2012 21:21:54 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.2.5]
MIME-Version: 1.0
Subject: python function used in variable expansion called multiple times per recipe
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
X-List-Received-Date: Wed, 18 Apr 2012 21:48:52 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I've been wrestling with this problem for over a day now so I figured it's =
time to call in the cavalry.
I have a class in our layer that needs to fill in a variable (EXTERNPV) wit=
h information about svn externals in a project. This process can be very ti=
me consuming and resource intensive so I would prefer that it only happen o=
nce per run. Unfortunately, it seems to run 5 times for each recipe that in=
herits the class. You can easily duplicate the behavior  I see with the fol=
lowing:

def testFunc(bb, d):
	print( bb.data.getVar("PN", d, True) )
	return "e1"

EXTERNPV =3D "${@testFunc(bb, d)}"

Am I doing something wrong? Is there some assignment operator I can use to =
ensure this only has to be done once? Or maybe a variable flag?

As always, I very much appreciate the help.

Dan Lazzari Jr.
Firmware Engineer
dlazzari@leapfrog.com



