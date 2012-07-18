Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SrUH0-00043e-T3 for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jul 2012 15:26:39 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6IDFHva025107;
	Wed, 18 Jul 2012 14:15:17 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24227-07; Wed, 18 Jul 2012 14:15:11 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6IDFAXF025100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 14:15:11 +0100
Message-ID: <1342617314.30680.29.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <Kai.Kang@windriver.com>
Date: Wed, 18 Jul 2012 14:15:14 +0100
In-Reply-To: <500629E5.5000202@windriver.com>
References: <cover.1342495796.git.kai.kang@windriver.com>
	<97edd3e3b004e658241e3b3fc759837686deff74.1342495796.git.kai.kang@windriver.com>
	<1342518777.10484.2.camel@ted> <500629E5.5000202@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q6IDFHva025107
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] hob2: add elf to hcc supported image types
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
X-List-Received-Date: Wed, 18 Jul 2012 13:26:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-07-18 at 11:13 +0800, Kang Kai wrote:
> On 2012=E5=B9=B407=E6=9C=8817=E6=97=A5 17:52, Richard Purdie wrote:
> > On Tue, 2012-07-17 at 14:58 +0800, Kang Kai wrote:
> >> [Yocto #2709]
> >>
> >> OE Core Commit c9b01af84b64edba056f959c349895e0698324e6 add elf imag=
e
> >> type. This will cause hob build image failed.
> >> Add elf to hcc supoorted image types to fix this issue.
> >>
> >> Signed-off-by: Kang Kai<kai.kang@windriver.com>
> >> ---
> >>   bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 +
> >>   1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/=
ui/crumbs/hobwidget.py
> >> index dba278c..d10c56b 100644
> >> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> >> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> >> @@ -89,6 +89,7 @@ class hcc:
> >>           "cpio.xz"       : ["cpio.xz"],
> >>           "vmdk"          : ["vmdk"],
> >>           "cpio.lzma"     : ["cpio.lzma"],
> >> +        "elf"           : ["elf"],
> >>       }
> >>
> >>   class HobViewTable (gtk.VBox):
>=20
> Hi Richard,
>=20
> Thanks.
>=20
> > Why do we have a hardcoded list here and why do new image types cause
> > builds to fail?
> After build the image, Hob trys to get list of created images. It needs=
=20
> a map from image type to real image file's extend name, such as "live"=20
> --> "hddimg" and "iso".
> then search the image output dir to get the list.
> >
> > We need to rewrite this code so this does not happen and the user at
> > least gets a sensible error message. Hardcoded lists are bad...
>=20
> For the current, only image type 'live' need this map. So I can remove=20
> the list and check the image type is whether 'live' or not.
> But for the future, if a new image type added and need this kind of map=
,=20
> new check for the single type is needed. I think for this scenario the=20
> list is better.

Well, I *hate* the concept that if you add a new image type, the UI has
to be changed.

Ideally, we need to add something to the metadata that explains this
mapping to the UI. I want to see the hardcoded list removed from the UI,
one way or another.

Cheers,

Richard



