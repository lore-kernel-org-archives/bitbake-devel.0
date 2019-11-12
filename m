Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 430 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 12 Nov 2019 22:26:10 UTC
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 681847F687
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 22:26:10 +0000 (UTC)
IronPort-SDR: 5n6W2sLcHuSuEDgy3/ubj9GxJoo6zDl2LjIs3+tZTlmJi33yvL/l0PaqmUQExLNgtZh38REmmS
	O5dfsyoC6Ifm7+UdKlyY+NsyzMLrQtckTHOkrFDCDrYXWAsKHUFTojamriPduT8gf9oqnfd1A9
	Fa8G+ZlwyZmPeYZJPRuMuKu9lbT5lNH9UEWn0wVXz7rLaqwBcZ2Dx9LsUKAjm6l1uNnQQumysC
	dJOpdrr9x7S0d6q4sX3pWIOPq5Uj2t8hc0XE8KLBhLGND+h71aOADgHt4s2snvZ0jLE1AUsxtH
	5Mk=
X-IronPort-AV: E=Sophos;i="5.68,297,1569276000"; 
   d="scan'208";a="2360560"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Mikko.Rapeli@bmw.de" <Mikko.Rapeli@bmw.de>, "gavinli@thegavinli.com"
	<gavinli@thegavinli.com>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: prserv: fix ResourceWarning due
	to unclosed socket
Thread-Index: AQHVmSvaY0m43+bbfEySYKKnIg+Ld6eIGzuA
Date: Tue, 12 Nov 2019 22:19:00 +0000
Message-ID: <ba14e0f2a8514b97af6981f7d0765847@XBOX03.axis.com>
References: <20191111221739.1663625-1-gavinli@thegavinli.com>
	<20191112072840.GI2398@hiutale>
In-Reply-To: <20191112072840.GI2398@hiutale>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Cc: "gavin@matician.com" <gavin@matician.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: prserv: fix ResourceWarning due to unclosed socket
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
X-List-Received-Date: Tue, 12 Nov 2019 22:26:10 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Mikko.Rapeli@bmw.de
> Sent: den 12 november 2019 08:29
> To: gavinli@thegavinli.com
> Cc: gavin@matician.com; bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH] bitbake: prserv: fix ResourceWarning
> due to unclosed socket
>=20
> Hi,
>=20
> On Mon, Nov 11, 2019 at 02:17:39PM -0800, gavinli@thegavinli.com wrote:
> > From: Gavin Li <gavin@matician.com>
> >
> > With PRSERV_HOST =3D "localhost:0", this message would occasionally pop=
 up
> > during the initial cache read:
>=20
> Thanks for this fix!

Yes, finally! I've been hunting this for quite a while...

> It's not occasionally, it's all the time with zeus and Debian build
> container...

It is occasional for Warrior, so I guess it should be backported to=20
both Zeus and Warrior.

> If it helps:
> Tested-by: Mikko Rapeli <mikko.rapeli@bmw.de>
>=20
> -Mikko

//Peter

> > WARNING: /home/matic/ambayocto/poky/bitbake/lib/bb/cache.py:446:
> ResourceWarning: unclosed <socket.socket fd=3D10,
> family=3DAddressFamily.AF_INET, type=3DSocketKind.SOCK_STREAM, proto=3D0,
> laddr=3D('127.0.0.1', 45655)>
> >   value =3D pickled.load()
> >
> > The file location stated is irrelevant; it just happens to be wherever
> > CPython decides to run the garbage collector. The issue is that after w=
e
> > fork off a PRServer, self.socket is also duplicated. The parent side of
> > it also needs to be closed.
> >
> > Signed-off-by: Gavin Li <gavin@matician.com>
> > ---
> >  bitbake/lib/prserv/serv.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> > index be3acec36a..1d9148b817 100644
> > --- a/bitbake/lib/prserv/serv.py
> > +++ b/bitbake/lib/prserv/serv.py
> > @@ -243,6 +243,7 @@ class PRServer(SimpleXMLRPCServer):
> >          try:
> >              pid =3D os.fork()
> >              if pid > 0:
> > +                self.socket.close() # avoid ResourceWarning in parent
> >                  return pid
> >          except OSError as e:
> >              raise Exception("%s [%d]" % (e.strerror, e.errno))
> > --
> > 2.23.0


