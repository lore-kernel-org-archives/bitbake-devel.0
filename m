Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QbStN-0005oz-Ls
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Jun 2011 09:39:30 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 Jun 2011 00:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,436,1304319600"; d="scan'208";a="21365311"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2011 00:35:46 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 28 Jun 2011 15:35:19 +0800
Received: from shsmsx502.ccr.corp.intel.com ([10.239.4.96]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi;
	Tue, 28 Jun 2011 15:35:17 +0800
From: "Cui, Dexuan" <dexuan.cui@intel.com>
To: 'Chris Larson' <clarson@kergoth.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Date: Tue, 28 Jun 2011 15:35:16 +0800
Thread-Topic: [bitbake-devel] [PATCH 1/1] die if a .bbappend file matches no
	existing .bb recipe
Thread-Index: Acw001yBBcCo1v9WTOiprSZBx39/+AAkXmZQ
Message-ID: <1865303E0DED764181A9D882DEF65FB6A167F0C710@shsmsx502.ccr.corp.intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
	<f9c4e4502da0fbb1376f987ae8a81073567143f5.1308544082.git.dexuan.cui@intel.com>
	<BANLkTinCB95DBHinewz+A1a7BHiZJzV1Mg@mail.gmail.com>
	<1865303E0DED764181A9D882DEF65FB6997B5E7675@shsmsx502.ccr.corp.intel.com>
	<BANLkTinGUdo-ar4NHN6zgfvS7Gf4F3USYQ@mail.gmail.com>
	<20110624183837.GI29476@denix.org> <1309182577.20015.233.camel@rex>
	<BANLkTin4EJ8ekJpHqpLxnO9AxZJbAibP3g@mail.gmail.com>
In-Reply-To: <BANLkTin4EJ8ekJpHqpLxnO9AxZJbAibP3g@mail.gmail.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: zh-CN, en-US
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Martin Jansa <martin.jansa@gmail.com>
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
X-List-Received-Date: Tue, 28 Jun 2011 07:39:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Chris Larson wrote:
> On Mon, Jun 27, 2011 at 6:49 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> On Fri, 2011-06-24 at 14:38 -0400, Denys Dmytriyenko wrote:
>>> On Fri, Jun 24, 2011 at 11:16:53AM -0700, Chris Larson wrote:
>>>> On Mon, Jun 20, 2011 at 12:29 AM, Cui, Dexuan
>>>> <dexuan.cui@intel.com> wrote:=20
>>>>> Martin Jansa wrote:
>>>>>> On Mon, Jun 20, 2011 at 6:34 AM, Dexuan Cui
>>>>>> <dexuan.cui@intel.com> wrote:
>>>>>>> This patch moves the logic of show_appends_with_no_recipes from
>>>>>>> bitbake-layers into bitbake, and makes the script die with a
>>>>>>> fatal error message printed.
>>>>>>=20
>>>>>> I agree that this is problem, but I'm not sure if it should be
>>>>>> fatal.=20
>>>>>>=20
>>>>>> Imagine the case when you enable some layer managed by someone
>>>>>> else (lets call it LS) and you're using different oe-core
>>>>>> revision, maybe current HEAD and that LS wasn't updated for that
>>>>>> or vice versa you're using some oe-core release version and you
>>>>>> want to reuse some recipes from LS in current version.=20
>>>>>>=20
>>>>>> I think that big fat warning that some .bbappends does not match
>>>>>> should be enough to decide if it's fatal for me (and I'll kill
>>>>>> that build) or that's fine (when I'm not interested in those
>>>>>> .bbappends from LS and I'm using only some other .bb files from
>>>>>> LS).=20
>>>>>>=20
>>>>>> If we make it fatal then I would be forced to remove unmatched
>>>>>> .bbappends from LS before build which can be difficult to share
>>>>>> (unless I create own LS branch and use it in my distro).
>>>>> Thanks a lot for the explanation!
>>>>> So looks we may as well change the "bb.fatal" to "bb.error"(that
>>>>> is not fatal and wouldn't be ignored by bitbake-layers).
>>>>> This is the new patch (on a new branch dcui/bb-v2):
>>>>> http://git.pokylinux.org/cgit/cgit.cgi/poky-contrib/commit/?h=3Ddcui/=
bb-v2&id=3D2a520959f71ec2cd80ed2088bfcf082631161a1a
>>>>=20
>>>> Are you sure this shouldn't be a warning? Remember that any error
>>>> displayed results in a non-zero exit code from bitbake.
>>>=20
>>> So, speaking of which - what is the practical use for bb.error? It
>>> gives an error message, but doesn't stop the build. Although it
>>> returns a non-zero exit code, which for most autobuilders indicate
>>> a failed build anyway... What's the point?
>>=20
>> It denotes something which the user really needs to know about and
>> fix. The sanity tests are good example and I'd really like to see
>> sanity issues becoming bb.errors in most cases.
>>=20
>> You can also think about it as being a point on the error severity
>> scale:=20
>>=20
>> Note: Information only
>> Warning: Something happened which the user likely needs to fix
>> Error: Something happened the user is strongly recommended to fix -
>> set =A0 =A0 =A0 exit code accordingly. Fatal: Something bad happened and
>> there is no hope so stop.=20
>>=20
>> I think in the scheme of different error priorities and actions, it
>> makes sense...
>=20
> I really don't think they're very useful right now. If our UIs
> actually captured the errors and summarized them at the end of the
> build, as well as had them in a global log, then I could see them
> being of use, but having an error message that might have scrolled
> past an hour ago result in a non-zero exit code is far from ideal. As
> a user, I have no idea why it seems to have failed.

I noticed in poky bb.error() doesn't cause bitbake to return a non-zero exi=
t code.

Thanks,
-- Dexuan


