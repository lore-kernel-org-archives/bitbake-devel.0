Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 444 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 14 Jul 2016 02:47:22 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id CF1896067C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jul 2016 02:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 22D24181A3;
	Thu, 14 Jul 2016 04:39:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id snT7E02350oq; Thu, 14 Jul 2016 04:39:56 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id D79A418198;
	Thu, 14 Jul 2016 04:39:55 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 596FB19C9;
	Thu, 14 Jul 2016 04:39:55 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 4E856188B;
	Thu, 14 Jul 2016 04:39:55 +0200 (CEST)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
	by seth.se.axis.com (Postfix) with ESMTP id 4AA7A39C;
	Thu, 14 Jul 2016 04:39:55 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX04.axis.com (10.0.5.18) with
	Microsoft SMTP Server (TLS) id 15.0.1156.6;
	Thu, 14 Jul 2016 04:39:55 +0200
Received: from XBOX02.axis.com ([fe80::d00f:cb52:1b56:20d]) by XBOX02.axis.com
	([fe80::d00f:cb52:1b56:20d%21]) with mapi id 15.00.1156.000;
	Thu, 14 Jul 2016 04:39:55 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Analyzing dependencies
Thread-Index: AQHRlUqFa3tXFlX13EiUl5EbyqsGh5+HSbKAgAADYwCAkBbiAIAAXI7g
Date: Thu, 14 Jul 2016 02:39:54 +0000
Message-ID: <7476b09f96bf4d1fbaf28fd2e0639bbd@XBOX02.axis.com>
References: <570DE199.3010802@mlbassoc.com>
	<CAMKF1soC0Yy13GyVVoe3KY3SjP26MvrHSbr3WS6x=dRW0uy=0Q@mail.gmail.com>
	<570DE536.9020701@mlbassoc.com>
	<3820835.WMpdxrdKEt@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <3820835.WMpdxrdKEt@peggleto-mobl.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Cc: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Analyzing dependencies
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
X-List-Received-Date: Thu, 14 Jul 2016 02:47:25 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Paul Eggleton
> Sent: den 14 juli 2016 00:44
> To: bitbake-devel@lists.openembedded.org
> Cc: Gary Thomas
> Subject: Re: [bitbake-devel] Analyzing dependencies
>=20
> On Wed, 13 Apr 2016 08:20:38 Gary Thomas wrote:
> > On 2016-04-13 08:08, Khem Raj wrote:
> > > Use any program that reads dotty files
> >
> > Know of any interactive ones that let you explore like the 'depexp'?
>=20
> It's not quite like that but FYI I have found "xdot" useful for viewing
> dot files - it performs well with reasonably large graphs (though still
> struggles with the bitbake -g task graph unfortunately).
>=20
>   https://github.com/jrfonseca/xdot.py
>=20
> Cheers,
> Paul
>=20
> --
>=20
> Paul Eggleton
> Intel Open Source Technology Centre

To make it possible to view the BitBake graphs in a sane way, I recommend=20
to use gvpr and tred (from graphviz) to filter them.

Here is an example filter for gvpr that I have used to filter out native=20
recipes. It also changes the labels for each node to only be the recipe=20
name. To use it, first run "bitbake -g <recipe>" for the recipe you are=20
interested in, e.g., core-image-minimal. Then run=20
"gvpr -i -f filter_non-native.txt pn-depends.dot | tred | xdot.py&".

---- 8< -------- filter_non-native.txt ---------------------------------
N[match(label, "/meta") !=3D -1 &&
  match(label, "virtual:native:") =3D=3D -1 &&
  match(name, "-native") =3D=3D -1]

N {
	label =3D gsub(label, ' *');
}
---- >8 -------- filter_non-native.txt ---------------------------------

//Peter


