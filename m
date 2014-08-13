Return-Path: <info@sd-kyber.com>
X-Greylist: delayed 906 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 13 Aug 2014 18:21:17 UTC
Received: from relais.videotron.net (relais.videotron.net [24.201.245.25])
	by mail.openembedded.org (Postfix) with ESMTP id 2A75965CA8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Aug 2014 18:21:17 +0000 (UTC)
MIME-version: 1.0
Received: from [192.168.1.151]
	(modemcable250.171-70-69.static.videotron.ca [69.70.171.250])
	by VL-VM-MRA001.ip.videotron.ca
	(Oracle Communications Messaging Exchange Server 7u4-18.01 64bit (built
	Jul 15
	2010)) with ESMTPA id <0NA900LTUBMB5M20@VL-VM-MRA001.ip.videotron.ca>
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Aug 2014 14:06:12 -0400 (EDT)
From: info@sd-kyber.com
Message-id: <0D8F1464-990E-47E6-A965-C3BF6F020BE2@sd-kyber.com>
Date: Wed, 13 Aug 2014 14:06:11 -0400
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.1972.3)
Subject: bitbake debugging...
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
X-List-Received-Date: Wed, 13 Aug 2014 18:21:27 -0000
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable

Hi,
I have a question regarding the practice of debugging bitbake itself:

Is there any document, suggestion what is the best practice to trace / =
step through the bitbake  execution?=20

For example, is it possible to put =E2=80=98the break point=E2=80=99  at =
the moment the fetcher module I=E2=80=99m specifying is called?=20
If that possible =E2=80=94 and I think it is - what python environments =
are common to be used? ActiveSense, something else?=20

Is there any document describing how to set such a =E2=80=98bitbake =
development=E2=80=99 environment?

I would appreciate all advices and help.=20
(I=E2=80=99m planning to do it on Linux Machine, running Fedora).

Thanks,=20
Michael.




