Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SFPwK-00088M-6f
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 15:07:56 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 04 Apr 2012 05:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="126975382"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 04 Apr 2012 05:58:44 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 4 Apr 2012 05:58:43 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Wed, 4 Apr 2012 20:58:42 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 09/10] Hob: Change base image to
	"Create your own image" if customized
Thread-Index: AQHNEXoIc8wp/sD5qEaYN6K3+dHv+5aKnyGA
Date: Wed, 4 Apr 2012 12:58:42 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23B12025@SHSMSX102.ccr.corp.intel.com>
References: <ee2f10ed2092ed21c7f8a0798c18404fdb30063a.1333269705.git.dongxiao.xu@intel.com>
	<CBA07A25.C269%belen.barros.pena@intel.com>
In-Reply-To: <CBA07A25.C269%belen.barros.pena@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 09/10] Hob: Change base image to "Create your own image" if customized
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
X-List-Received-Date: Wed, 04 Apr 2012 13:07:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Barros Pena, Belen wrote on=A02012-04-03:

> From the design side of things, I am not sure this is a good idea. I've
> explicitly selected 'base image x'. If I then customise it, I still think
> I am working on 'base image x'. I might not understand why my selection o=
f
> base image has been changed automatically. In general, it is not a good
> idea to have software that changes things I do of its own accord. Such
> behaviours undermine the sense of control users should have when
> interacting with software.
>=20
> Cheers
>=20
> Belen
>=20

What we want is to change the item in the base image combo. The target imag=
e is still based on the base image the user selected plus delta.
We have the strict definition for the predefined base images. For instance,=
 sato includes 300 recipes.
An image including 299 recipes is not called sato but your own image (say, =
sato-minus)

The reason why we do that is because for templates, we will remember the it=
em in the image combo as the base image in some bb file, and we also rememb=
er what we selected for the recipes and the packages. However, the base ima=
ge covers all of them by default and because of that, bitbake can't recogni=
ze the delta and will include all (300 recipes), which causes the wrong beh=
avior.

--
Shane


