Subject: bbappend SRC_URI restriction request
To: bitbake-devel@lists.openembedded.org
From: jared_terry@dell.com
X-Originating-Location: Cedar Park, Texas, US (70.124.160.59)
X-Originating-Platform: Windows Chrome 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 15 Jul 2021 16:03:48 -0700
Message-ID: <89xC.1626390228088042584.TYTM@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="R5DIniy3QN9N9zYmqcV7"

--R5DIniy3QN9N9zYmqcV7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I'm building in Yocto 3.1.3 with bitbake 1.46.0 and I had a co-worker do a =
bbappend with this in it

PV =3D "231"
SRC_URI =3D "https://github.com/systemd/systemd-bootchart/releases/downloa=
d/v${PV}/${PN}-${PV}.tar.xz"

now the hard part is this is a append applying over the top of systemd-boo=
tchart_233.bb and since the SRC_URI =3D is a complete wipe of the value in =
the bb file its basically doing a forced override.

is it possible to set it up so this throws a warning?=C2=A0 This is someth=
ing I would think would be very bad in a bbappend file and basically bypass=
es the bitbake-layers show-overlayed I've been using to detect who has forc=
ed an override of whats in poky.

--R5DIniy3QN9N9zYmqcV7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I'm building in Yocto 3.1.3 with bitbake 1.46.0 and I had a co-worker do a =
bbappend with this in it<br /><br />
<div>PV =3D "231"</div>
<div>SRC_URI =3D "https://github.com/systemd/systemd-bootchart/releases/do=
wnload/v${PV}/${PN}-${PV}.tar.xz"<br /><br />now the hard part is this is a=
 append applying over the top of systemd-bootchart_233.bb and since the SRC=
_URI =3D is a complete wipe of the value in the bb file its basically doing=
 a forced override.<br /><br />is it possible to set it up so this throws a=
 warning?&nbsp; This is something I would think would be very bad in a bbap=
pend file and basically bypasses the&nbsp;<span style=3D"color: #172b4d; fo=
nt-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, U=
buntu, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;">bitbake-la=
yers show-overlayed I've been using to detect who has forced an override of=
 whats in poky.</span></div>

--R5DIniy3QN9N9zYmqcV7--
