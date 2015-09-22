Return-Path: <tim.jaacks@garz-fricke.com>
X-Greylist: delayed 1574 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 22 Sep 2015 14:07:05 UTC
Received: from mailout.artfiles.de (mailout.artfiles.de [80.252.97.80])
	by mail.openembedded.org (Postfix) with ESMTP id 1E26A73243
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 14:07:05 +0000 (UTC)
Received: from [89.27.136.47] (helo=mail.garz-fricke.com)
	auth=mx@garz-fricke.com
	by mailout.artfiles.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80.1) id 1ZeNoQ-0003yd-N5
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Sep 2015 15:40:50 +0200
Received: from SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7]) by
	SRV24.hamburg.garz-fricke.de ([fe80::b591:975a:1787:bdd7%12]) with mapi
	id 14.03.0248.002; Tue, 22 Sep 2015 15:40:49 +0200
From: Tim Jaacks <tim.jaacks@garz-fricke.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Override a "_remove" operator in bbappend file
Thread-Index: AdD1OldU5KlABcjSR8OvzOgPm4u4KA==
Date: Tue, 22 Sep 2015 13:40:49 +0000
Message-ID: <32EA6B79577EEF4C84CB32305D45A059289DF200@SRV24.hamburg.garz-fricke.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.3.9]
MIME-Version: 1.0
Subject: Override a "_remove" operator in bbappend file
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
X-List-Received-Date: Tue, 22 Sep 2015 14:07:11 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I have a problem with bitbake's "_remove" operator. Perhaps someone can hel=
p me out.

Suppose I have three layers:
 - meta-1
 - meta-2
 - meta-3

In meta-1, there is a recipe "foo.bb", containing a variable:
FOO =3D "bar baz"

In meta-2, there is an append file "foo.bbappend", which changes the variab=
le using the "_remove" operator:
FOO_remove =3D "bar"

The resulting value of the FOO variable is " baz".

Now I want to re-add "bar" to the FOO variable in meta-3, without changing =
the other layers. How is that possible?

I tried everything I could think of, including several combinations of "_ap=
pend", "_prepend", machine-specific overrides, "_forcevariable" or setting =
the variable to a hard-coded value. Nothing could bring back "bar". It seem=
s as if the "_remove" operator is always executed at the very end of the va=
riable calculation, come what may. The layer priority seems to not have any=
 impact on this.

Is this a design fault? Or am I missing something?
Any hints on this would be helpful, thanks in advance.

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

