Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S3MiL-0000iC-N0
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 08:15:41 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 01 Mar 2012 23:07:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="113693350"
Received: from pgsmsx509.gar.corp.intel.com ([172.30.13.17])
	by azsmga001.ch.intel.com with ESMTP; 01 Mar 2012 23:07:09 -0800
Received: from pgsmsx151.gar.corp.intel.com (172.30.236.41) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Fri, 2 Mar 2012 15:06:52 +0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX151.gar.corp.intel.com (172.30.236.41) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 2 Mar 2012 15:06:52 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Fri, 2 Mar 2012 15:06:51 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 06/32] Hob: implement a self-defined
	notebook visual component for Hob
Thread-Index: AQHM9ykUBDpstlC8iEOAvd8XBG9JqpZWk42g
Date: Fri, 2 Mar 2012 07:06:51 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFCDD@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<0079cc38920b78e36e2371fb34bcffd12883da5f.1330523904.git.shane.wang@intel.com>
	<4F4E985B.1070606@linux.intel.com>
In-Reply-To: <4F4E985B.1070606@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 06/32] Hob: implement a self-defined notebook visual component for Hob
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
X-List-Received-Date: Fri, 02 Mar 2012 07:15:42 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-01:

>=20
>=20
> On 29/02/12 06:15, Shane Wang wrote:
>> In recipe selection page, package selection page, and build details page=
,
> etc, there is a notebook component which is not gtk.Notebook in the desig=
n
> video.
>> We implement the visual component with a drawing area, and use it to
> replace the old notebook in recipe selection page and package selection
> page.
>>=20
>> Signed-off-by: Liming An<limingx.l.an@intel.com>
>> Signed-off-by: Shane Wang<shane.wang@intel.com>
>=20
> Code style comments below.
>=20
> More importantly, have we made sure we can't use the stock notebook
> before we've implemented our own? The commit log tells me that we aren't
> using gtk.Notebook but doesn't tell me why?
1) General speaking, gtk.Notebook doesn't look like the design Belen worked=
 out.
2) And we all agree Belen's design looks better, for example, there is an i=
ndicator to show how many recipes or packages are included, and how many is=
sues happened when building? Very straightforward.
But technically, gtk.Notebook can't implement that. As far as we know, it c=
an't.

3) Moreover, there is an entry for "search recipes", and "search packages".=
 How to make it horizontal to the tabs is a problem to us.
Regarding those, we give up gtk.Notebook and use our own.

>=20
> The implemented notebook is a reasonable start but it needs a lot of
> polish before I'd want to see it shipped.
> i.e. the green flashed border around the selected tabs is strange, the
> drawing looks a little jaggy, especially the orange circle (not a
> graphics guy so I don't know the right term) and I'm pretty certain the
> number in the circle isn't centred. Finally (for now) once I get to
> three digits the numbers don't fit in the circle.
I agree we also have some to improve our Notebook, say, the border and the =
circle.
If there is a jaggy, we can make it a rectangle instead of circle.
But to be frank, I don't think gtk.Notebook looks better.

>=20
> I think the rationale would be useful as a comment in the class file too.
>=20
> Cheers,
> Joshua

> +            # check which tab be clicked
> Why don't we just iterate the list here?
>	for child in self.children:
>			if child["x"] < x and etc.

Because we have
    self.current_child =3D i

Or we can do self.current_child =3D child (to an object)? Do you like this =
more?

--
Shane


