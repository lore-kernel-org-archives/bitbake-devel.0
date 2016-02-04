Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8A45477348
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 17:56:14 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 04 Feb 2016 09:56:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,396,1449561600"; d="scan'208";a="740620420"
Received: from mwoodwar-mobl8.ger.corp.intel.com (HELO [10.252.19.30])
	([10.252.19.30])
	by orsmga003.jf.intel.com with ESMTP; 04 Feb 2016 09:56:05 -0800
User-Agent: Microsoft-MacOutlook/0.0.0.150701
Date: Thu, 04 Feb 2016 19:56:03 +0200
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Message-ID: <000A1795-92CF-47DD-90E8-DC9DA20F271C@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 2/2] data_smart: handle '\x7d' in python
	parsing
References: <1454495619-15453-1-git-send-email-markus.lehtonen@linux.intel.com>
	<1454495619-15453-3-git-send-email-markus.lehtonen@linux.intel.com>
	<1454518366.27087.204.camel@linuxfoundation.org>
	<B326458E-0A03-43FD-99B5-BFAC59933C8C@linux.intel.com>
	<1454574090.27087.232.camel@linuxfoundation.org>
In-Reply-To: <1454574090.27087.232.camel@linuxfoundation.org>
Mime-version: 1.0
Subject: Re: [PATCH 2/2] data_smart: handle '\x7d' in python parsing
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
X-List-Received-Date: Thu, 04 Feb 2016 17:56:17 -0000
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

On 04/02/16 10:21, "Richard Purdie" <richard.purdie@linuxfoundation.org> wr=
ote:

>On Thu, 2016-02-04 at 08:39 +0200, Markus Lehtonen wrote:
>> On 03/02/16 18:52, "Richard Purdie" <
>> richard.purdie@linuxfoundation.org> wrote:
>>=20
>> > On Wed, 2016-02-03 at 12:33 +0200, Markus Lehtonen wrote:
>> > > At least ncurses recipe uses a workaround (for former bitbake
>> > > python
>> > > parser) where closing curly bracket inside a python string was
>> > > replaced
>> > > by '\x7d' ascii code. The previous "curly bracket matching" patch
>> > > broke
>> > > parsing of constructs like this as bitbake wouldn't correctly
>> > > find
>> > > the
>> > > closing bracket. This patch fixes this by accepting '\x7d' as a
>> > > closing
>> > > bracket.
>> > >=20
>> > > Hopefully, this patch could be reverted (and the python regexp
>> > > thus
>> > > simplified) in the future after making sure that no recipes use
>> > > the
>> > > '\x7d' workaround, anymore.
>> > >=20
>> > > [YOCTO #8849]
>> > >=20
>> > > Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
>> > > ---
>> > >  lib/bb/data_smart.py | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > To be honest, the number of recipes which do this is hopefully very
>> > very small and we should just go and fix them now?
>>=20
>> I was pondering this, too, but tried to make sure not to break
>> anything. I can e.g. grep through the layers in git.openembedded.org
>> and git.yoctoproject.org and see if there are any other recipes like
>> this and submit patches to change those.
>
>I think that might be the better option, thanks!

You were right. At least I didn=E2=80=99t find any other problematic recipes than=
 ncurses. I sent patch for review:
http://lists.openembedded.org/pipermail/openembedded-core/2016-February/116=
904.html

That should be merged at the same time as the [1/2] bitbake patch in order =
to avoid build failure.

Cheers,
   Markus


