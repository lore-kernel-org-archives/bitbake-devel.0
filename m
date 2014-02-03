Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 48C236E885
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Feb 2014 23:44:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s13Nhxw0013188; Mon, 3 Feb 2014 23:43:59 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id l2Xdiz3QZt7O; Mon,  3 Feb 2014 23:43:59 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s13NhrCe013181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Feb 2014 23:43:55 GMT
Message-ID: <1391471027.3330.78.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Mon, 03 Feb 2014 23:43:47 +0000
In-Reply-To: <20140203221120.GA13798@nbbrfq.cc.univie.ac.at>
References: <1390231273.874.36.camel@ted> <1390250850.874.43.camel@ted>
	<20140203221120.GA13798@nbbrfq.cc.univie.ac.at>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] fetch2/git: Dereference unresolved names with ls-remote
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
X-List-Received-Date: Mon, 03 Feb 2014 23:44:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2014-02-03 at 23:11 +0100, Bernhard Reutner-Fischer wrote:
> On Mon, Jan 20, 2014 at 08:47:30PM +0000, Richard Purdie wrote:
> > We need to deference tags when trying to map them to commit IDs with
> > ls-remote. If we don't do this, a given commit might not show up
> > later in a specific branch. There appears to be no good reason not
> > to do this.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > 
> > v2: Only apply ^{} to tags, not heads
> > 
> > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> > index d73f0cb..f7c26b3 100644
> > --- a/bitbake/lib/bb/fetch2/git.py
> > +++ b/bitbake/lib/bb/fetch2/git.py
> > @@ -326,7 +326,7 @@ class Git(FetchMethod):
> >          else:
> >              username = ""
> >  
> > -        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s" % \
> > +        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s^{}" % \
> >                (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name], ud.unresolvedrev[name])
> >          if ud.proto.lower() != 'file':
> >              bb.fetch2.check_network_access(d, cmd)
> 
> Hi Richard,
> 
> This and the previous df2e0972cd1db7abd5ec8b7cb295fb0c42e284a4 are very
> inconvenient for my workflow (¹).
> I usually have the toolchain locally for hacking, so my gcc,
> binutils-gdb, uClibc and selected apps etc look like e.g.:
> 
> $ egrep "SRC(REV|PV|_URI )" meta/recipes-devtools/gcc/gcc-4.9.inc
> SRCREV = "HEAD"
> PV = "4.9.0+git${SRCPV}"
> SRC_URI = "git:///scratch/src/gcc-4.9.mine/;branch=fixups-rtl;protocol=file;rebaseable=1"
> 
> This worked fine until your abovementioned changes. Can you advise how
> my SRC_URI should look like so i am able to keep developing and
> test changes now with the lot of oe-core and meta-openembedded as
> checks?
> 
> thanks,
> 
> To reproduce:
> $ git init /tmp/yuck
> Initialized empty Git repository in /tmp/yuck/.git/
> $ cd !$
> $ echo | tee a > b
> $ git add a
> $ git commit -q -m '1c' a
> $ git ls-remote file:///tmp/yuck/ HEAD
> 7532c4dab272c062c117b731e97889122dc10e67	HEAD
> $ git ls-remote file:///tmp/yuck/ refs/heads/HEAD refs/tags/HEAD^{}
> $
> 
> ¹) think http://xkcd.com/1172/ but IMHO a tad less obscure since i'm
> affected ;)

The xkcd link made me smile :).

There may be a case here for adding in a conditional on a local repo
(file:// type) and the revision being HEAD. It is a pretty special case
but one we can probably accommodate relatively easily...

Cheers,

Richard



