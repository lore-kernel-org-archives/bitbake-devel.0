Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QYYzf-0003zr-RD
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Jun 2011 09:34:00 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 20 Jun 2011 00:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,392,1304319600"; d="scan'208";a="15794168"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by orsmga002.jf.intel.com with ESMTP; 20 Jun 2011 00:30:26 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 20 Jun 2011 15:29:49 +0800
Received: from shsmsx502.ccr.corp.intel.com ([10.239.4.96]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi;
	Mon, 20 Jun 2011 15:29:48 +0800
From: "Cui, Dexuan" <dexuan.cui@intel.com>
To: 'Martin Jansa' <martin.jansa@gmail.com>
Date: Mon, 20 Jun 2011 15:29:47 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] die if a .bbappend file matches no
	existing .bb recipe
Thread-Index: AcwvFXqS+C9WAHBUQlOnxfRDhOw/SQAAoFmQ
Message-ID: <1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<f9c4e4502da0fbb1376f987ae8a81073567143f5.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
In-Reply-To: <BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: zh-CN, en-US
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 20 Jun 2011 07:34:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Martin Jansa wrote:
> On Mon, Jun 20, 2011 at 6:34 AM, Dexuan Cui <dexuan.cui@intel.com>
> wrote:=20
>> This patch moves the logic of show_appends_with_no_recipes from
>> bitbake-layers into bitbake, and makes the script die with a fatal
>> error message printed.=20
>=20
> I agree that this is problem, but I'm not sure if it should be fatal.
>=20
> Imagine the case when you enable some layer managed by someone else
> (lets call it LS) and you're using different oe-core revision, maybe
> current HEAD and that LS wasn't updated for that or vice versa you're
> using some oe-core release version and you want to reuse some recipes
> from LS in current version.
>=20
> I think that big fat warning that some .bbappends does not match
> should be enough to decide if it's fatal for me (and I'll kill that
> build) or that's fine (when I'm not interested in those .bbappends
> from LS and I'm using only some other .bb files from LS).
>=20
> If we make it fatal then I would be forced to remove unmatched
> .bbappends from LS before build which can be difficult to share
> (unless I create own LS branch and use it in my distro).
Thanks a lot for the explanation!=20
So looks we may as well change the "bb.fatal" to "bb.error"(that is not fat=
al and wouldn't be ignored by bitbake-layers).
This is the new patch (on a new branch dcui/bb-v2):
http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Ddcui/bb-v2&=
id=3D2a520959f71ec2cd80ed2088bfcf082631161a1a

Thanks,
-- Dexuan=


