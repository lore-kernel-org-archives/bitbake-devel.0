Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QbxxZ-0006o1-F0
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 18:49:54 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Jun 2011 09:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,444,1304319600"; d="scan'208";a="20395656"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by azsmga001.ch.intel.com with ESMTP; 29 Jun 2011 09:28:56 -0700
Received: from pgsmsx509.gar.corp.intel.com (172.30.13.17) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 30 Jun 2011 00:28:55 +0800
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 30 Jun 2011 00:28:54 +0800
Received: from shsmsx502.ccr.corp.intel.com ([10.239.4.96]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi;
	Thu, 30 Jun 2011 00:28:53 +0800
From: "Cui, Dexuan" <dexuan.cui@intel.com>
To: 'Richard Purdie' <richard.purdie@linuxfoundation.org>
Date: Thu, 30 Jun 2011 00:28:52 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] die if a .bbappend file matches no
	existing .bb recipe
Thread-Index: Acw2d8x4AksySVmHRYCu+MxVkNxMpgAAaGLw
Message-ID: <1865303E0DED764181A9D882DEF65FB6A167F0C725@shsmsx502.ccr.corp.intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<201106271406.45596.paul.eggleton@linux.intel.com>
	<1309264777.20015.280.camel@rex>
	<1865303E0DED764181A9D882DEF65FB6A167F0C723@shsmsx502.ccr.corp.intel.com>
	<1309364097.20015.414.camel@rex>
In-Reply-To: <1309364097.20015.414.camel@rex>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: zh-CN, en-US
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	'Martin Jansa' <martin.jansa@gmail.com>
Subject: Re: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Wed, 29 Jun 2011 16:49:55 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Richard Purdie wrote:
> On Thu, 2011-06-30 at 00:03 +0800, Cui, Dexuan wrote:
>> Sorry -- what's the conclusion?
>> Keeping the v2 patch
>> (http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Ddcui/bb=
-v2&id=3D2a520959f71ec2cd80ed2088bfcf082631161a1a)
>> , or changing bb.error() to bb.warn()?
>=20
> Where you have:
>=20
>   bb.error('No recipes available for:\n%s' % '\n'.join(appendlines))
>=20
> this would become something like:
>=20
>   msg =3D 'No recipes available for:\n%s' % '\n'.join(appendlines)
>   if d.getVar("BB_DANGLINGAPPENDS_WARNONLY", False):
>      bb.warn(msg)
>   else:
>      bb.fatal(msg)
>=20
> which means we can have a strong default but advanced
> users/distros/whoever can avoid this.
Hi Richard, thanks very much for the explanation!

I'll make and test a new version like this.

Thanks,
-- Dexuan=


