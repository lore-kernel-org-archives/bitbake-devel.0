Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ty2NV-0004UX-LJ for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 16:36:52 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0NFP9CU014281; Wed, 23 Jan 2013 15:25:10 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vefsKYv3IkvP; Wed, 23 Jan 2013 15:25:09 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0NFP4fM014268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Wed, 23 Jan 2013 15:25:07 GMT
Message-ID: <1358954455.6356.62.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Trung Hoang <trungiee@gmail.com>
Date: Wed, 23 Jan 2013 15:20:55 +0000
In-Reply-To: <2ABB9CD2-9E60-4E5A-A9B0-1C96F25A424B@gmail.com>
References: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
	<CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
	<50FEC2BE.3020902@windriver.com>
	<2ABB9CD2-9E60-4E5A-A9B0-1C96F25A424B@gmail.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
X-MIME-Autoconverted: from 8bit to quoted-printable by dan.rpsys.net id
	r0NFP9CU014281
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Display mode
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
X-List-Received-Date: Wed, 23 Jan 2013 15:36:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2013-01-23 at 09:21 +1100, Trung Hoang wrote:
> Ahh yes, Knotty2 rocks!=20
>=20
> For those who don't get this by default, i did this..=20
>=20
> `bitbake -u knotty2 gumstix-console-image'=20
>=20
> I do notice that sometimes the "Running task 3160 of 3162 =E2=80=A6" do=
es get buggy.. Instead of updating that line it makes a new line so i end=
 up with=E2=80=A6=20
>=20
> Running task 3160 of 3162..
> Running task 3161 of 3162..
> Running task 3162 of 3162=E2=80=A6
> 0: =E2=80=A6

There were bug fixes made before it became the default and was merged
back to "knotty" which fixed some of those issues.

Cheers,

Richard



