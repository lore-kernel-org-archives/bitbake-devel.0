Return-Path: <rpurdie@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1D44B6FF78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 May 2016 14:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4HEq9R2028342; Tue, 17 May 2016 15:52:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vZIugIOoLACi; Tue, 17 May 2016 15:52:09 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4HEq6mk028334
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 May 2016 15:52:07 +0100
Message-ID: <1463496726.4578.17.camel@rpsys.net>
From: Richard Purdie <rpurdie@rpsys.net>
To: Christopher Larson <kergoth@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 17 May 2016 15:52:06 +0100
In-Reply-To: <1463436362.4578.4.camel@linuxfoundation.org>
References: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
	<b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
	<1463436362.4578.4.camel@linuxfoundation.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [RFC master][PATCH 4/4] bitbake-layers: convert to plugin-based
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
X-List-Received-Date: Tue, 17 May 2016 14:52:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-05-16 at 23:06 +0100, Richard Purdie wrote:
> On Sat, 2016-04-30 at 12:41 -0700, Christopher Larson wrote:
> > From: Christopher Larson <chris_larson@mentor.com>
> > 
> > This uses bb.utils.load_plugins, based on the plugin handling in
> > recipetool
> > and devtool in oe-core.
> > 
> > Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> > ---
> >  bin/bitbake-layers                 | 1065 ++----------------------
> > --
> > ----------
> >  bitbake/lib/bblayers/__init__.py   |    2 +
> >  bitbake/lib/bblayers/action.py     |  233 ++++++++
> >  bitbake/lib/bblayers/common.py     |   33 ++
> >  bitbake/lib/bblayers/layerindex.py |  270 +++++++++
> >  bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
> 
> Sorry, one other question. Did you mean to create a bitbake/lib
> within
> the bitbake repo or should this just be lib/ ? I'm guessing the
> latter
> and have queued it in -next with that.

The regression tests also found one small problem:

oe-selftest --run-tests bblayers.BitbakeLayers.test_bitbakelayers_showrecipes

======================================================================
FAIL: test_bitbakelayers_showrecipes (oeqa.selftest.bblayers.BitbakeLayers)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/media/build1/poky/meta/lib/oeqa/utils/decorators.py", line 109, in wrapped_f
    return func(*args, **kwargs)
  File "/media/build1/poky/meta/lib/oeqa/selftest/bblayers.py", line 92, in test_bitbakelayers_showrecipes
    self.assertNotEqual(result.status, 0, 'bitbake-layers show-recipes -i nonexistentclass should have failed')
AssertionError: 0 == 0 : bitbake-layers show-recipes -i nonexistentclass

$ bitbake-layers show-recipes -i nonexistentclass
Parsing recipes..done.
ERROR: No class named classes/nonexistentclass.bbclass found in BBPATH
$ echo $?
0

I've tweaked the patch to change the "return 1" to a sys.exit(1) since
I'd prefer to get this patch in to avoid more rebasing with the python3
branch.

Cheers,

Richard


