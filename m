Return-Path: <jianxun.zhang@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id D04506B6EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 19:33:07 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP; 12 Jan 2017 11:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,219,1477983600"; d="scan'208";a="212677364"
Received: from ashah-mobl3.amr.corp.intel.com ([10.252.134.16])
	by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2017 11:33:08 -0800
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Jianxun Zhang <jianxun.zhang@linux.intel.com>
In-Reply-To: <1484242870.4367.219.camel@linuxfoundation.org>
Date: Thu, 12 Jan 2017 11:33:11 -0800
Message-Id: <2A86F721-051E-4344-AC93-362DB2E4EF56@linux.intel.com>
References: <1482352057-26139-1-git-send-email-jianxun.zhang@linux.intel.com>
	<1482397158.9843.130.camel@linuxfoundation.org>
	<48AEE85D-1072-4C81-922D-D9DF9A3E4D66@linux.intel.com>
	<DA1C4B84-D5CA-4BE4-97D3-CA19F1E89C2F@linux.intel.com>
	<1484242870.4367.219.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3259)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] use multiple processes to dump signatures.
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
X-List-Received-Date: Thu, 12 Jan 2017 19:33:09 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

RP,
I appreciate your multiple hints on the road for this issue! I do _feel_ =
this patch needs some improvement or tests, but I cannot identify them =
in my sight. Well, things shouldn=E2=80=99t be such easy with a V1 due =
to the complexity.

That=E2=80=99s why I have to hand over the burden to you. :-) Feel free =
to let me know any new possibilities.

I am actually interested in the data you shared. I improved my =
sig-dumping over 10 times (14.4 sec to 1 sec). Your test should covers =
other steps, so the improvement on sig dumping is less significant, =
325.08 to 93.93 sec.

Maybe we should find some time to investigate any room to speed up the =
rest in test suite...

Thanks

> On Jan 12, 2017, at 9:41 AM, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
> Hi,
>=20
> On Tue, 2017-01-10 at 14:54 -0800, Jianxun Zhang wrote:
>> Do you have further suggestion based on my explanation?
>>=20
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10352
>=20
> I needed to sit and look at that patch for a while to check a few
> things but I think you have it right. I've been doing some local
> testing and its now queued in -next, thanks!
>=20
> Just out of interest, before:
>=20
> oe-selftest -r =
sstatetests.SStateTests.test_sstate_allarch_samesigs_multilib
>=20
> 2017-01-12 17:06:18 -   test_sstate_allarch_samesigs_multilib =
(oeqa.selftest.sstatetests.SStateTests) ... OK (325.084s)
>=20
> and after:
>=20
> 2017-01-12 16:58:59 -   test_sstate_allarch_samesigs_multilib =
(oeqa.selftest.sstatetests.SStateTests) ... OK (93.926s)
>=20
> and this change should help multiple tests so its a nice improvement!
>=20
> Cheers,
>=20
> Richard


