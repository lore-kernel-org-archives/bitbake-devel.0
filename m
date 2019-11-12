Return-Path: <prvs=2122a496f=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 427 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 12 Nov 2019 07:35:48 UTC
Received: from esa6.bmw.c3s2.iphmx.com (esa6.bmw.c3s2.iphmx.com
	[68.232.139.124])
	by mail.openembedded.org (Postfix) with ESMTP id D3EF57FAB1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1573544151; x=1605080151;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=/YBBs/+eBAk69IyXSlhg5J8OQRtHV/DHzepUd2lKDwE=;
	b=DoWRcXPlpIOaaNY7F6i1ncDpZwyzbDK6jRnVEsC+olXbJ6fvOPcirFCs
	tqFlG7tvYItqQohB3aAmF5E157atSQwL4K1kOwfAztGQD3aqC4IAfulHq
	sWsMYfT9j4FaQUKLpDgzBtC6qIflUTTPB0g2qI0UCO53dHfx3X2mbfM7O Y=;
IronPort-SDR: kxGlsVWJrPJhWhdxCJPPIviSZwCxMES0RWfxDScnpHF3ShyUWYRk5zdd2M2OJ16dvQrGxXDCYx
	0mi0+C6Ab8fm5XCuSXrYP/UhHY+8bISIN6RbtoTPHZzbHSGZMbotX0ZBSiKWeNYoeuUJcjeDo6
	QCpeMeXUxTmvZm3iGwdYJmRI2Dx1iXa71JOQDZn1sPkr2Yuf4OM8M5YghkPzW0fYLbxujSDPmo
	IGTgkq48f0a45txNObMx0yIM6jyTvfdwE+OC+/8t+EvmsSD9My46jpFDQlB3NvnP0jcElyp84l
	uvY=
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
	esa6.bmw.c3s2.iphmx.com with ESMTP/TLS; 12 Nov 2019 08:28:42 +0100
Received: from esabb5.muc ([160.50.100.47])  by esagw4.muc with ESMTP/TLS;
	12 Nov 2019 08:28:41 +0100
Received: from smucm10l.bmwgroup.net (HELO smucm10l.europe.bmw.corp)
	([160.48.96.48])
	by esabb5.muc with ESMTP/TLS; 12 Nov 2019 08:28:41 +0100
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10l.europe.bmw.corp
	(160.48.96.48) with Microsoft SMTP Server (TLS;
	Tue, 12 Nov 2019 08:28:41 +0100
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1473.005;
	Tue, 12 Nov 2019 08:28:41 +0100
From: <Mikko.Rapeli@bmw.de>
To: <gavinli@thegavinli.com>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: prserv: fix ResourceWarning due
	to unclosed socket
Thread-Index: AQHVmSrO64jthHctYki6kF2vvPBNVA==
Date: Tue, 12 Nov 2019 07:28:41 +0000
Message-ID: <20191112072840.GI2398@hiutale>
References: <20191111221739.1663625-1-gavinli@thegavinli.com>
In-Reply-To: <20191111221739.1663625-1-gavinli@thegavinli.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
MIME-Version: 1.0
Cc: gavin@matician.com, bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Tue, 12 Nov 2019 07:35:49 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BA92000BD67444681920C39B80FC0B5@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2019 at 02:17:39PM -0800, gavinli@thegavinli.com wrote:
> From: Gavin Li <gavin@matician.com>
>=20
> With PRSERV_HOST =3D "localhost:0", this message would occasionally pop u=
p
> during the initial cache read:

Thanks for this fix!

It's not occasionally, it's all the time with zeus and Debian build contain=
er...

If it helps:
Tested-by: Mikko Rapeli <mikko.rapeli@bmw.de>

-Mikko

> WARNING: /home/matic/ambayocto/poky/bitbake/lib/bb/cache.py:446: Resource=
Warning: unclosed <socket.socket fd=3D10, family=3DAddressFamily.AF_INET, t=
ype=3DSocketKind.SOCK_STREAM, proto=3D0, laddr=3D('127.0.0.1', 45655)>
>   value =3D pickled.load()
>=20
> The file location stated is irrelevant; it just happens to be wherever
> CPython decides to run the garbage collector. The issue is that after we
> fork off a PRServer, self.socket is also duplicated. The parent side of
> it also needs to be closed.
>=20
> Signed-off-by: Gavin Li <gavin@matician.com>
> ---
>  bitbake/lib/prserv/serv.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> index be3acec36a..1d9148b817 100644
> --- a/bitbake/lib/prserv/serv.py
> +++ b/bitbake/lib/prserv/serv.py
> @@ -243,6 +243,7 @@ class PRServer(SimpleXMLRPCServer):
>          try:
>              pid =3D os.fork()
>              if pid > 0:
> +                self.socket.close() # avoid ResourceWarning in parent
>                  return pid
>          except OSError as e:
>              raise Exception("%s [%d]" % (e.strerror, e.errno))
> --=20
> 2.23.0
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel=

