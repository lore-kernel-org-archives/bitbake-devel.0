Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 61FEF731BD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 16:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 3D9FE2E1AD;
	Fri, 15 Jan 2016 17:18:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id A0l7ov2VqPmR; Fri, 15 Jan 2016 17:18:54 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 383652E094;
	Fri, 15 Jan 2016 17:18:54 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id EC7661211;
	Fri, 15 Jan 2016 17:18:53 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id E009146F;
	Fri, 15 Jan 2016 17:18:53 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id DDB9F34143;
	Fri, 15 Jan 2016 17:18:53 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Fri, 15 Jan 2016
	17:18:53 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 638419C724; 
	Fri, 15 Jan 2016 17:18:53 +0100 (CET)
Date: Fri, 15 Jan 2016 17:18:53 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20160115161852.GI31212@axis.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
	<90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
	<1452785159.28375.135.camel@linuxfoundation.org>
	<CAJ86T=X9LU04NhjnaLtq+G7WSE6=9t2yiNF2MiuDrnn+M5exLQ@mail.gmail.com>
	<20160114170752.GH31212@axis.com>
	<36fc0893749647d8aeef0cc8cfd68435@XBOX02.axis.com>
	<1452870294.28375.167.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1452870294.28375.167.camel@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Fri, 15 Jan 2016 16:18:55 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 16-01-15 15:04 +0000, Richard Purdie wrote:
> I have also double checked this and I agree, the bitbucket servers do
> now seem to work as you'd expect.
> 
> I swear I had problems originally but I can't figure out what those
> were so I will revert the patch.

Thanks!

> My point about improving the selftests if there are url formats you
> depend upon stands though.

While I'm happy to contribute such a change, I'm not fond of the
structure of the bitbake tests. They are a lot of times system
tests that require access to remote servers etc.

And in this case, the manipulation happens in the git fetcher,
and it has no unit tests at all (not including indirect system
testing). E.g., the following trivial patch to the URLHandle
tests would not catch this issue:

  --- a/bitbake/lib/bb/tests/fetch.py
  +++ b/bitbake/lib/bb/tests/fetch.py
  @@ -644,7 +644,8 @@ class URLHandle(unittest.TestCase):
  ...
  -       "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'})
  +       "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
  +       "git://git.example.org:1234/bitbake" : ('git', 'git.example.org:1234', '/bitbake', '', '', {}),
  ...

I did try to add unittests for the git fetcher at one point, but
the patches were rejected because I made changes to the git
fetcher itself, in order to simplify testing. In this case, the
behavior is isolated to _get_repo_url, which is side effect free,
so again, I'm happy to try adding tests for this particular case.

Could also mention that the bb.fetch2.URI class' unittest suite
does have tests for various variations, including port numbers,
and it was designed to be side-effect free in order to make unit
testing simple. Adapting this would give some testing for free.


Anyways, I'll hopefully have a patch ready for review early next
week. Have a nice weekend :)

-- 
olofjn

