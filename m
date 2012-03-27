Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCUYI-0003hc-7A
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 13:27:02 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 27 Mar 2012 04:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123752686"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 27 Mar 2012 04:17:59 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 27 Mar 2012 04:17:59 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 27 Mar 2012 19:17:57 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: =?iso-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>
Thread-Topic: [bitbake-devel] HOB2 : run image disabled
Thread-Index: AQHNCsPU/T02B9Ocp063G4FKJPOPPJZ9/z2g
Date: Tue, 27 Mar 2012 11:17:56 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AFB60A@SHSMSX102.ccr.corp.intel.com>
References: <20120325221346.0b452c4f@eb-e6520>
In-Reply-To: <20120325221346.0b452c4f@eb-e6520>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: HOB2 : run image disabled
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
X-List-Received-Date: Tue, 27 Mar 2012 11:27:02 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Eric B=E9nard wrote on=A02012-03-26:

> Hi Dongxiao,
>=20
> when the image is built (core-minimal for qemuarm machine) :
> - if I click on runimage : it ask for selecting an image
That was a bug for user experience filed in the bugzilla. https://bugzilla.=
yoctoproject.org/show_bug.cgi?id=3D2155
I have a patch submitted but not checked in yet http://git.yoctoproject.org=
/cgit/cgit.cgi/poky-contrib/commit/?h=3Dshane/hob&id=3Deee2635181e81fe8774f=
b5e1f2122e83d972b3b9. The patch is to make sure there must be an image togg=
led by default for you to run-qemu.
In your example, the "ext3" image is toggled by default.

> - if I select and image (either ext3 or tar.bz2) the "run image" link
>   is disabled.
> is that behaviour expected ?
That is not expected. Probably it is because http://git.yoctoproject.org/cg=
it/cgit.cgi/poky/commit/?id=3D5b86fb09c57d738bc4dde3e7ca6f11aafe0ccc3c was =
not checked in at the time when you tried.
Please try with the latest master, thanks.

--
Shane



