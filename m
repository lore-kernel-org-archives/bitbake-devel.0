Return-Path: <cristian.iorga@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 609D960CFC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Nov 2014 06:01:00 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 23 Nov 2014 22:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,447,1413270000"; d="scan'208";a="637000174"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
	by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2014 22:01:00 -0800
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.144]) by
	IRSMSX154.ger.corp.intel.com ([169.254.12.166]) with mapi id
	14.03.0195.001; Mon, 24 Nov 2014 06:01:00 +0000
From: "Iorga, Cristian" <cristian.iorga@intel.com>
To: Nishanth S <Nishanth.S@altiux.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] how to update a package on yocto project
Thread-Index: AQHQB2jFTicI7alinkq+GZivd1400JxvSAyw
Date: Mon, 24 Nov 2014 06:00:59 +0000
Message-ID: <969F26A8BAB325438E7EB80D3C3134FB2F3BE1B7@IRSMSX105.ger.corp.intel.com>
References: <546AE780.7070208@altiux.com>
In-Reply-To: <546AE780.7070208@altiux.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.181]
MIME-Version: 1.0
Subject: Re: how to update a package on yocto project
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
X-List-Received-Date: Mon, 24 Nov 2014 06:01:02 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please note that the right list to ask this question would be:
yocto@yoctoproject.org and/or openembedded-issues@lists.openembedded.org

Regards,
Cristian Iorga
Yocto Project
Intel Corporation

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Nishanth S
Sent: Tuesday, November 18, 2014 8:30 AM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] how to update a package on yocto project

Hi

board : Intel Galileo Gen 1

I use yocto project for build image/tarball for the board.

How to update a existing package???

I mean, I use openjdk-6 on my board.

But I need to change it to openjdk-7.

I edited local.conf by adding following line.

preferred_version_openjdkXXXX =3D XXXX


--=20
Regards,
Nishanth.S

--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

