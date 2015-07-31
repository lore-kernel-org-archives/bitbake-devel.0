Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id EAD0A763BE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 11:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 98447181C1;
	Fri, 31 Jul 2015 13:42:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Rtf5eKhSQ0n5; Fri, 31 Jul 2015 13:42:41 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 165EF180B1;
	Fri, 31 Jul 2015 13:42:40 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id C80141246;
	Fri, 31 Jul 2015 13:42:40 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id BB76A103D;
	Fri, 31 Jul 2015 13:42:40 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id B84763E049;
	Fri, 31 Jul 2015 13:42:40 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Fri, 31 Jul 2015
	13:42:40 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 6D1A89C68B; 
	Fri, 31 Jul 2015 13:42:40 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1438336442.22462.2.camel@linuxfoundation.org>
References: <1438266455-sup-7263@axis.com>
	<1438336442.22462.2.camel@linuxfoundation.org>
Date: Fri, 31 Jul 2015 13:42:40 +0200
Message-ID: <1438336631-sup-5239@axis.com>
User-Agent: Sup/0.20.0
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Fri, 31 Jul 2015 11:42:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Excerpts from Richard Purdie's message of 2015-07-31 11:54:02 +0200:
> On Thu, 2015-07-30 at 17:03 +0200, Olof Johansson wrote:
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

Thanks. But that's not the case for us. Why is this relevant for _append
operations? The exanded variable does get the expected value (which can
be verified by uncommenting the assertFalse for the log in my unit
test).

> The fix is to ensure you only set a variable in one canonical way.

Why? For our purpose that's not ideal. We want to be able to create a
user with a common definition from a set of packages. It's not
necessarily the recipes' ${PN} package that will create such a user.

-- 
olof johansson

