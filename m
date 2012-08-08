Received: from mx4.leapfrog.com ([63.114.26.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1SyuvS-000062-4E
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Aug 2012 03:19:06 +0200
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx4.leapfrog.com (Postfix) with ESMTP id 2C9AD5EA6
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Aug 2012 17:43:50 -0700 (PDT)
Received: from NAEMCASHT01.na.leapfrog.com (10.16.4.161) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 7 Aug 2012 17:44:48 -0700
Received: from naemmail02.na.leapfrog.com ([fe80::ad94:5dcc:6325:ef50]) by
	NAEMCASHT01.na.leapfrog.com ([::1]) with mapi id 14.01.0355.002;
	Tue, 7 Aug 2012 17:44:48 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: "'bitbake-devel@lists.openembedded.org'
	(bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Making a noexec task executable again
Thread-Index: Ac10/wK56xnEDy3/RluNmfNX4LwVBQ==
Date: Wed, 8 Aug 2012 00:44:48 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0FB5B1F2A8@NAEMMAIL02.na.leapfrog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.2.5]
MIME-Version: 1.0
Subject: Making a noexec task executable again
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
X-List-Received-Date: Wed, 08 Aug 2012 01:19:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I ran across an interesting challenge today. One of our old image recipes i=
s being ported into denzil and needs to fetch a file to do some whitelist p=
rocessing. Unfortunately, in denzil, the image class has

do_fetch[noexec] =3D "1"

which stops the fetch task from running. How can I get it to run again? I t=
ried

do_fetch[noexec] =3D "0"

and

do_fetch[noexec] =3D ""

to no avail.

Dan Lazzari Jr.
Firmware Engineer
dlazzari@leapfrog.com



