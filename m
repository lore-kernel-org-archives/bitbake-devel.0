Return-Path: <brad@evidence.com>
Received: from email.taser.com (email.taser.com [74.206.119.92])
	by mail.openembedded.org (Postfix) with ESMTP id AB86A60CED
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Dec 2013 21:56:04 +0000 (UTC)
X-ASG-Debug-ID: 1387317365-0499bf7ce1414180001-FWLXlK
Received: from MAGNI.atmoss (magni.atmoss [10.10.20.112]) by email.taser.com
	with ESMTP id C5zS9hVj0uNqnYqO; Tue, 17 Dec 2013 14:56:05 -0700 (MST)
X-Barracuda-Envelope-From: brad@evidence.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.20.112
Received: from TI-ODIN.tasernet.com (172.16.1.112) by email.taser.com
	(10.10.20.112) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Tue, 17 Dec 2013 14:56:05 -0700
Received: from TI-THOR.tasernet.com ([fe80::7c49:ae21:6650:2789]) by
	TI-ODIN.tasernet.com ([fe80::64ff:7320:e6e7:27c8%20]) with mapi id
	14.02.0347.000; Tue, 17 Dec 2013 14:56:04 -0700
X-Barracuda-RBL-Trusted-Forwarder: 10.10.20.112
From: Brad Litterell <brad@evidence.com>
X-Barracuda-BWL-IP: fe80::7c49:ae21:6650:2789
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Thread-Topic: [bitbake-devel] Developing in Python for Bitbake
X-ASG-Orig-Subj: RE: [bitbake-devel] Developing in Python for Bitbake
Thread-Index: Ac77ZCTXIz7V07wdRpOFluYVtFjO6QAPYDyA//+iPRo=
Date: Tue, 17 Dec 2013 21:56:02 +0000
Message-ID: <E51394554A503C4E852F9BEE46B03E8D019AC8BD@TI-THOR.tasernet.com>
References: <E51394554A503C4E852F9BEE46B03E8D019AC817@TI-THOR.tasernet.com>,
	<1688455.phEaOq5Cul@helios>
In-Reply-To: <1688455.phEaOq5Cul@helios>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.103]
MIME-Version: 1.0
X-Barracuda-Connect: magni.atmoss[10.10.20.112]
X-Barracuda-Start-Time: 1387317365
X-Barracuda-URL: http://10.10.20.59:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at taser.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
	QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.143180
	Rule breakdown below
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Developing in Python for Bitbake
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
X-List-Received-Date: Tue, 17 Dec 2013 21:56:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

thanks!=0A=
________________________________________=0A=
From: Paul Eggleton [paul.eggleton@linux.intel.com]=0A=
Sent: Tuesday, December 17, 2013 12:31 PM=0A=
To: Brad Litterell=0A=
Cc: bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] Developing in Python for Bitbake=0A=
=0A=
Hi Brad,=0A=
=0A=
On Tuesday 17 December 2013 20:11:18 Brad Litterell wrote:=0A=
> I want to create a new bbclass for some internal build tooling and am fai=
rly=0A=
> new to Python, so I have a couple of (hopefully quick) questions:=0A=
>=0A=
> 1. Can you recommend an Python IDE for developing for bitbake on Linux?=
=0A=
> There seem to be several, and if there is a consensus among the bitbake=
=0A=
> developers, I thought I'd start there.=0A=
=0A=
I expect most people who work on BitBake don't use an IDE - just a text=0A=
editor, and we probably all use different ones. I myself mostly use Kate (f=
rom=0A=
KDE) which does provide syntax highlighting and completion though; at the=
=0A=
command line I also use vi.=0A=
=0A=
> 2. Is there a list of pre-defined variables?  For example, gitpkgv.bbclas=
s=0A=
> starts with def get_git_pkgv(d, use_tags):=0A=
=0A=
There's no reference for this level of things other than the code, I'm afra=
id,=0A=
but we're more than happy to answer questions if you have any.=0A=
=0A=
> "d" appears to be frequently assumed.  I'm guessing it is the same as the=
=0A=
> "D" variable in the recipes, but I am not sure whether there is a documen=
t=0A=
> that verifies this - and what else is available, or whether it is just=0A=
> tribal knowledge?=0A=
=0A=
d is the data dictionary, as defined in bitbake/lib/bb/data_smart.py. d is =
not=0A=
related to the "D" variable in OpenEmbedded (although just as with any othe=
r=0A=
variable you can of course use d.getVar('D', True) to access it).=0A=
=0A=
Cheers,=0A=
Paul=0A=
=0A=
--=0A=
=0A=
Paul Eggleton=0A=
Intel Open Source Technology Centre=0A=

