Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QbxIZ-0004EF-OO
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 18:07:32 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Jun 2011 09:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,443,1304319600"; d="scan'208";a="19738191"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by orsmga002.jf.intel.com with ESMTP; 29 Jun 2011 09:03:47 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.239.4.104) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Thu, 30 Jun 2011 00:03:45 +0800
Received: from shsmsx502.ccr.corp.intel.com ([10.239.4.96]) by
	SHSMSX602.ccr.corp.intel.com ([10.239.4.104]) with mapi;
	Thu, 30 Jun 2011 00:03:44 +0800
From: "Cui, Dexuan" <dexuan.cui@intel.com>
To: 'Richard Purdie' <richard.purdie@linuxfoundation.org>, Paul Eggleton
	<paul.eggleton@linux.intel.com>
Date: Thu, 30 Jun 2011 00:03:43 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] die if a .bbappend file matches no
	existing .bb recipe
Thread-Index: Acw1kKF1+bOKdrLfTHCvs2Rq2T3mqwA5Lp6Q
Message-ID: <1865303E0DED764181A9D882DEF65FB6A167F0C723@shsmsx502.ccr.corp.intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<201106271406.45596.paul.eggleton@linux.intel.com>
	<1309264777.20015.280.camel@rex>
In-Reply-To: <1309264777.20015.280.camel@rex>
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
X-List-Received-Date: Wed, 29 Jun 2011 16:07:32 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Richard Purdie wrote:
> On Mon, 2011-06-27 at 14:06 +0100, Paul Eggleton wrote:
>> Martin Jansa wrote:
>>> Imagine the case when you enable some layer managed by someone else
>>> (lets call it LS) and you're using different oe-core revision, maybe
>>> current HEAD and that LS wasn't updated for that or vice versa
>>> you're using some oe-core release version and you want to reuse
>>> some recipes from LS in current version.=20
>>>=20
>>> I think that big fat warning that some .bbappends does not match
>>> should be enough to decide if it's fatal for me (and I'll kill that
>>> build) or that's fine (when I'm not interested in those .bbappends
>>> from LS and I'm using only some other .bb files from LS).
>>>=20
>>> If we make it fatal then I would be forced to remove unmatched
>>> .bbappends from LS before build which can be difficult to share
>>> (unless I create own LS branch and use it in my distro).
>>=20
>> I see what you're saying, but I'm worried about the visiblity (or
>> lack thereof) of these warnings.  If you start a build, go off
>> somewhere and come back when the build is part way through or
>> finished, you may be oblivious to the fact that there might be a
>> serious problem - i.e. the customisations you expected to be applied
>> haven't been.=20
>>=20
>> It all depends on whether the bbappends are supposed to apply to
>> recipes that are to be used in the build you're doing - if they are,
>> then IMHO the error should be fatal. I wonder if it's practical to
>> make it work that way...?=20
>=20
> I think it should be fatal by default but have some kind of variable
> we can set to disable it...

Sorry -- what's the conclusion?
Keeping the v2 patch(http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/co=
mmit/?h=3Ddcui/bb-v2&id=3D2a520959f71ec2cd80ed2088bfcf082631161a1a), or cha=
nging bb.error() to bb.warn()?

Thanks,
-- Dexuan


