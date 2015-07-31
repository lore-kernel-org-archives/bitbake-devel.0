Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 22A867632C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 10:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6VA0J4Z018020; Fri, 31 Jul 2015 11:00:19 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id N9Hh3KqWJwq4; Fri, 31 Jul 2015 11:00:19 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6VA0690017996
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 31 Jul 2015 11:00:17 +0100
Message-ID: <1438336806.22462.3.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Fri, 31 Jul 2015 11:00:06 +0100
In-Reply-To: <1438336442.22462.2.camel@linuxfoundation.org>
References: <1438266455-sup-7263@axis.com>
	<1438336442.22462.2.camel@linuxfoundation.org>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Variable key replaces original warnings
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
X-List-Received-Date: Fri, 31 Jul 2015 10:00:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-07-31 at 10:54 +0100, Richard Purdie wrote:
> On Thu, 2015-07-30 at 17:03 +0200, Olof Johansson wrote:
> > Hi all,
> > 
> > We've started to see issues on master like
> > 
> >    WARNING:
> >      Variable key          USERADD_PARAM_${PN}             (; --system --home / --no-create-home --comment 'Storage manager daemon' --gid storage storage)
> >      replaces original key USERADD_PARAM_recording-indexer (--system --home / --no-create-home --comment 'apache httpd' --gid www www).
> > 
> > (my alignment...)
> > 
> > The warning happens when doing
> > 
> >  WWWUSER_PACKAGE ?= "${PN}"
> >  USERADD_PARAM_${WWWUSER_PACKAGE} := "--system --home / --no-create-home --gid www www"
> > 
> >  USERADD_PARAM_${PN}_append = "; --system --home / --no-create-home --gid username username"
> > 
> > (in reality, the first two lines are inherited from a class, and the third in
> > the recipe itself.)
> > 
> > With bitbake -e I see what looks like the expected value, with both users being
> > created. If I change USERADD_PARAM_${WWWUSER_PACKAGE} (second line) to
> > USERADD_PARAM_${PN} no warning is printed, so this only seems to be a problem
> > in cases where multiple unique non-expanded vars expand to the same expanded
> > var.
> > 
> > I made a unit test that should demonstrate the problem (I think), and it fails
> > because of the warnings:
> > 
> > diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
> > index e9aab57..e7716cc 100644
> > --- a/bitbake/lib/bb/tests/data.py
> > +++ b/bitbake/lib/bb/tests/data.py
> > @@ -386,6 +386,15 @@ class TestKeyExpansion(unittest.TestCase):
> >              self.assertTrue(logContains("Variable key VAL_${FOO} (A) replaces original key VAL_foo (B)", logs))
> >          self.assertEqual(self.d.getVar("VAL_foo", True), "A")
> >  
> > +    def test_append(self):
> > +        self.d.setVar("TEST_${BAR}", "Bar")
> > +        self.d.setVar("TEST_${FOO}_append", "Foo")
> > +        with LogRecord() as logs:
> > +            bb.data.expandKeys(self.d)
> > +            self.assertFalse(logContains("Variable key TEST_${FOO} (Foo) replaces original key TEST_foo (Bar)", logs))
> > +        self.assertEqual(self.d.getVar("TEST_${FOO}", True), "BarFoo")
> > 
> > 
> > If you have any ideas on what this issue can be or how to fix it, please
> > let me know :)
> 
> The data store changes recently caused a number of these to appear. The
> issue has always been there, as has this warning, the new datastore code
> just exposes it a bit more consistently than previously.
> 
> The reason we do this is that users with conflicting (different values)
> of the same variable name usually have a metadata issue they're unaware
> of.
> 
> The fix is to ensure you only set a variable in one canonical way.
> OE-Core did show a few of these but I fixed them before merging the data
> store changes.

The OE-Core change I made for a similar case was:

http://git.yoctoproject.org/cgit.cgi/poky/commit/meta/classes/update-rc.d.bbclass?id=3b627bb28c4ea2ea33050ad4884c6351e2d6ebad

i.e. moved to anonymous python. Not ideal, but more explicit.

Cheers,

Richard




