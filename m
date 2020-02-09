Return-Path: <Joao.CCabral@parceiros.nos.pt>
X-Greylist: delayed 539 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 09 Feb 2020 23:26:55 UTC
Received: from mail.nos.pt (mail.nos.pt [194.79.86.52])
	by mail.openembedded.org (Postfix) with ESMTP id D998960B0E
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Feb 2020 23:26:55 +0000 (UTC)
Received: from PO2EXC012.corporativo.pt (10.227.74.90) by
	LX3EXC012.corporativo.pt (10.228.74.239) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sun, 9 Feb 2020 23:26:56 +0000
Received: from PO2EXC013.corporativo.pt (10.227.74.91) by
	PO2EXC012.corporativo.pt (10.227.74.94) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sun, 9 Feb 2020 23:26:56 +0000
Received: from PO2EXC013.corporativo.pt ([fe80::c83:a3b7:8c1a:f0a6]) by
	PO2EXC013.corporativo.pt ([fe80::c83:a3b7:8c1a:f0a6%21]) with mapi id
	15.00.1395.000; Sun, 9 Feb 2020 23:26:55 +0000
From: "Joao Carlos Cabral (P)" <Joao.CCabral@parceiros.nos.pt>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [HELP] Create a new image recipe based on a (changed) existing
	one
Thread-Index: AQHV358opy/+hFiacEiPKhEmZbhQdqgTgT6o
Date: Sun, 9 Feb 2020 23:26:55 +0000
Message-ID: <1581290815745.54479@parceiros.nos.pt>
References: <61f1517446c596d50dfa4aa434e1b3934ab5696c.camel@parceiros.nos.pt>
In-Reply-To: <61f1517446c596d50dfa4aa434e1b3934ab5696c.camel@parceiros.nos.pt>
Accept-Language: en-US, pt-PT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.166]
x-tm-snts-smtp: 5678DCDFBAD38A154816DEB34388E5D4AA52F4E9822D681FA384C1F6FD0C1AA02000:8
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 10 Feb 2020 14:14:47 +0000
Subject: [HELP] Create a new image recipe based on a (changed) existing one
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
X-List-Received-Date: Sun, 09 Feb 2020 23:26:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=0A=
=0A=
I'm trying to create a image recipe based on a existing one.=0A=
I've searched online, and I could find such an example.=0A=
=0A=
My problem is that the image I what to serve as a base is changed in=0A=
another layer, and I want to include that changes.=0A=
=0A=
Ex:=0A=
=0A=
(tree)=0A=
=0A=
Prj_root=0A=
    -> layer1=0A=
        -> recipes-core=0A=
            -> images=0A=
                -> my-image.bb  [This is the base recipe]=0A=
    -> layer2=0A=
        -> recipes-core=0A=
            -> images=0A=
                -> my-image.bbappend [This is the changed one]=0A=
    -> layer3=0A=
        -> recipes-core=0A=
            -> images=0A=
                -> my-image-dev.bb [this is the new image, based on my-imag=
e]=0A=
=0A=
my-image.bbappend is something like this:=0A=
=0A=
--------------------- my-image.bbappend ---------=0A=
PROVIDES =3D "product"=0A=
=0A=
IMAGE_INSTALL +=3D " \=0A=
        <some_packages> \=0A=
"=0A=
IMAGE_INSTALL_remove +=3D " \=0A=
        <other-packeges>=0A=
"=0A=
=0A=
(+ other functions related with signing the image)=0A=
_________________________________________________=0A=
=0A=
The final image is created with 'bitbake product'.=0A=
And, I want to create a dev image that must be based on the current=0A=
"product" image (my-image.bb + my-image.bbappend) with some dev=0A=
packages.=0A=
So, I need to include the changes that my-image.bbapend does to this=0A=
dev image I'm trying to create.=0A=
=0A=
=0A=
Tried simple create a new image that should be a copy of the working=0A=
one, and then add the needed packages for development.=0A=
So I did the following...=0A=
=0A=
---------------- my-image-dev.bbappend ----------=0A=
=0A=
SUMMARY =3D "dev Image"=0A=
=0A=
require layer1/recipes-core/images/my-image.bb=0A=
------------------------------------------------=0A=
=0A=
I can run 'bitbake my-image-dev' and it runs, but doesn't produce the=0A=
same output as 'bitbake product'.=0A=
=0A=
Also, If I run 'bitbake my-image-dev' 1st, it finishes fine. Running=0A=
'bitbake product' after makes a bunch of other tasks and finishes fine.=0A=
Running again 'bitbake my-image-dev' finishes with an error on a=0A=
specific task. ( It shows that they are not building the same thing)=0A=
=0A=
How can I do what I need?=0A=
NOTE: I can't change anything in the layer1 and layer2.=0A=
=0A=
PS. Also tried to require the bbappend file, but bitbake fails saying=0A=
that it's not a bitbake file.=0A=
=0A=
Thanks in advanced.=0A=
=0A=
Jo=E3o Cabral=0A=

