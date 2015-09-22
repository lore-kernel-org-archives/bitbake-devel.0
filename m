Return-Path: <tim.jaacks@garz-fricke.com>
Received: from mailout.artfiles.de (mailout.artfiles.de [80.252.97.80])
	by mail.openembedded.org (Postfix) with ESMTP id 9742973243
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 14:35:44 +0000 (UTC)
Received: from [89.27.136.47] (helo=mail.garz-fricke.com)
	auth=mx@garz-fricke.com
	by mailout.artfiles.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80.1) id 1ZeOfX-00024C-19
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Sep 2015 16:35:43 +0200
Received: from SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7]) by
	SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7%12]) with mapi
	id 14.03.0248.002; Tue, 22 Sep 2015 16:35:39 +0200
From: Tim Jaacks <tim.jaacks@garz-fricke.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Override a "_remove" operator in bbappend file
Thread-Index: AdD1Q/NCOAnmTLXwTYOsgOYh7cn86Q==
Date: Tue, 22 Sep 2015 14:35:39 +0000
Message-ID: <32EA6B79577EEF4C84CB32305D45A059289DF453@SRV24.hamburg.garz-fricke.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.3.9]
MIME-Version: 1.0
Subject: Re: Override a "_remove" operator in bbappend file
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
X-List-Received-Date: Tue, 22 Sep 2015 14:35:46 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

thanks for your feedback. Yes, the according file is in meta-fsl-arm:

https://github.com/Freescale/meta-fsl-arm/blob/3336ef362109eef14f9e73cdeded=
b43caefedb2f/recipes-graphics/mesa/mesa_%25.bbappend

I would like to undo the first two lines.

So, this is the intended behavior, you say? Shouldn't the order of all _app=
ends, _prepends and _removes be tied to the layer priority? That's what I w=
ould expect, though.

=A0
Mit freundlichen Gr=FC=DFen / Best regards
i.A. Tim Jaacks

Software Engineering
Garz & Fricke GmbH
Tempowerkring 2, 21079 Hamburg - Germany
Amtsgericht Hamburg HRB 60514
Gesch=E4ftsf=FChrer: Manfred Garz, Matthias Fricke
Phone: +49 40 791899 - 55
Fax:=A0=A0=A0=A0 +49 40 791899 - 39
tim.jaacks@garz-fricke.com
www.garz-fricke.com

