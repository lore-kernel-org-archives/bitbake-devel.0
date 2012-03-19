Received: from vms173021pub.verizon.net ([206.46.173.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1S9la0-0006R4-4T
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 00:01:32 +0100
Received: from gandalf.denix.org ([unknown] [71.178.225.66])
	by vms173021.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M15008IHJEIPE61@vms173021.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 16:51:54 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id DF3E7201C0; Mon,
	19 Mar 2012 17:51:53 -0400 (EDT)
Date: Mon, 19 Mar 2012 17:51:53 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Christopher Larson <kergoth@gmail.com>
Message-id: <20120319215153.GF15554@denix.org>
References: <1331718176.18586.15.camel@ted> <4F61926D.1060709@windriver.com>
	<4F619CD4.4090103@windriver.com> <20120315080310.GC4973@jama.jama.net>
	<4F61B1D0.2080306@windriver.com> <20120315092122.GE4973@jama.jama.net>
	<20120315181844.GE30363@denix.org>
	<20120316064152.GA3855@jama.jama.net>
	<20120319203213.GC15554@denix.org>
	<9DB46E3A8C854D2595CB6F683FB6D1D0@gmail.com>
MIME-version: 1.0
In-reply-to: <9DB46E3A8C854D2595CB6F683FB6D1D0@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Cc: philb@gnu.org, Kang Kai <Kai.Kang@windriver.com>,
	bitbake-devel@lists.openembedded.org, Martin Jansa <martin.jansa@gmail.com>
Subject: Re: How to identify WORKDIR?
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
X-List-Received-Date: Mon, 19 Mar 2012 23:01:32 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Mon, Mar 19, 2012 at 02:37:42PM -0700, Christopher Larson wrote:
> rm_old_work seems to do exactly what it sounds like. It removes *old* 
> workdirs from previous versions of the recipe to keep it from bloating 
> without bound if you retain the same tmpdir.

Correct, that's my understanding as well. But it's not meant to replace 
rm_work, as it can't save space the same way during the build - by the time 
your build is done, you are using 100% of what WORKDIR would have been w/o 
this class in the case of a clean build . It prevents the size to grow beyond 
that point though...

I was just trying to clarify this statement, suggesting they both serve the 
same purpose:

> Well it works better then rm_work with sstate

-- 
Denys


> On Monday, March 19, 2012 at 1:32 PM, Denys Dmytriyenko wrote:
> 
> > On Fri, Mar 16, 2012 at 07:41:52AM +0100, Martin Jansa wrote:
> > > On Thu, Mar 15, 2012 at 02:18:44PM -0400, Denys Dmytriyenko wrote:
> > > > On Thu, Mar 15, 2012 at 10:21:22AM +0100, Martin Jansa wrote:
> > > > > On Thu, Mar 15, 2012 at 05:09:36PM +0800, Kang Kai wrote:
> > > > > > On 2012???03???15??? 16:03, Martin Jansa wrote:
> > > > > > > On Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:
> > > > > > > > On 2012???03???15??? 14:55, Kang Kai wrote:
> > > > > > > > > On 2012???03???14??? 17:42, Richard Purdie wrote:
> > > > > > > > > > On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
> > > > > > > > > > > Hi All,
> > > > > > > > > > > 
> > > > > > > > > > > I write a script to clean up WORKDIR that remove the obsoleted
> > > > > > > > > > > packages' build directories.
> > > > > > > > > > > The script accept a argument as BUILDDIR and I use this clause to
> > > > > > > > > > > identify the WORKDIR:
> > > > > > > > > > > 
> > > > > > > > > > > workdir = os.path.join(builddir, 'tmp/work')
> > > > > > > > > > > 
> > > > > > > > > > > Then validate the workdir exists or not. It works for me but hardcode
> > > > > > > > > > > here as Richard point out.
> > > > > > > > > > > So is there a better way to get the WORKDIR here? Thanks.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > I was thinking of something like:
> > > > > > > > > > 
> > > > > > > > > > bitbake -e | grep ^WORKDIR
> > > > > > > > And the result is something like that:
> > > > > > > > WORKDIR="/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/x86_64-poky-linux/bblayers-1.0-r0"
> > > > > > > > 
> > > > > > > > Is it ok to remove 2 items seperated by slash at the end of string?
> > > > > > > > Right now is:
> > > > > > > > "/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"
> > > > > > > > 
> > > > > > > 
> > > > > > > Aren't you looking for ^TMPDIR ?
> > > > > > > 
> > > > > > 
> > > > > > 
> > > > > > If use WORKDIR = TMPDIR/"work", it is still hard coding.
> > > > > 
> > > > > Assuming 2 items at the end won't work for people using rm_old_work:
> > > > > http://git.openembedded.org/meta-micro/commit/?id=fcf525654915edb9650f1a6c2852f336366f8b2f
> > > > > or slightly different version:
> > > > > http://git.shr-project.org/git/?p=meta-smartphone.git;a=blob;f=meta-shr/classes/rm_old_work.bbclass
> > > > > 
> > > > 
> > > > 
> > > > Martin,
> > > > 
> > > > Can you please point me to more details about this class - any background or 
> > > > discussions... Thanks.
> > > > 
> > > 
> > > 
> > > Hi,
> > > 
> > > Well it works better then rm_work with sstate and the original class is
> > > from meta-micro (so maybe ask pb if you want more details, but the class
> > > is quite simple). I've just replaced last directory name because of this
> > > issue:
> > > 
> > > http://git.shr-project.org/git/?p=meta-smartphone.git;a=commit;h=0d4c17de1ba7343d82bb10c311754e29d573c485
> > 
> > Martin,
> > 
> > Hmm, my understanding those are slightly different classes - rm_work cleans 
> > WORKDIR after the build to save space, while this rm_old_work seems to clean 
> > up before the build. I tried searching for any previous discussions of this 
> > class or any other rationale, but even the commit itself doesn't provide much 
> > explanation for it...
> > 
> > Phil,
> > 
> > Do you mind giving a short description of this peculiar rm_old_work class? :) 
> > Thanks.
> > 
> > -- 
> > Denys
> > 
> > 
> > > > > And I think more people have different "tmp/" part e.g. default would be
> > > > > "tmp-eglibc/" (thanks to TCLIBCAPPEND
> > > > > meta/conf/distro/defaultsetup.conf:TMPDIR .= "${TCLIBCAPPEND}"), but "work" is 
> > > > > quite common.
> > > > > 
> > > > > meta/conf/bitbake.conf:
> > > > > WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PF}"
> > > > > meta-shr/classes/rm_old_work.bbclass:
> > > > > WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${PF}"
> > > > > meta-micro/classes/rm_old_work.bbclass:
> > > > > WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${EXTENDPE}${PV}-${PR}"
> > > > > 
> > > > > Cheers,
> > > > > 
> > > > > > 
> > > > > > > > Regards,
> > > > > > > > Kai
> > > > > > > > 
> > > > > > > > > If get WORKDIR in this way, I'll update the script with no argument
> > > > > > > > > because the argument is useless to identify the WORKDIR.
> > > > > > > > > 
> > > > > > > > > Regards,
> > > > > > > > > Kai
> > > > > > > > > > since you already call into bitbake in the script in question.
> > > > > > > > > > 
> > > > > > > > > > Cheers,
> > > > > > > > > > 
> > > > > > > > > > Richard
> > > > > > > > > 
> > > > > > > > > _______________________________________________
> > > > > > > > > bitbake-devel mailing list
> > > > > > > > > bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> > > > > > > > > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > _______________________________________________
> > > > > > > > bitbake-devel mailing list
> > > > > > > > bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> > > > > > > > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > > -- 
> > > > > Martin 'JaMa' Jansa jabber: Martin.Jansa@gmail.com (mailto:Martin.Jansa@gmail.com)
> > > > > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > > > _______________________________________________
> > > > > bitbake-devel mailing list
> > > > > bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> > > > > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > > > > 
> > > > 
> > > > 
> > > 
> > > 
> > > -- 
> > > Martin 'JaMa' Jansa jabber: Martin.Jansa@gmail.com (mailto:Martin.Jansa@gmail.com)
> > > 
> > 
> > 
> > 
> > 
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org (mailto:bitbake-devel@lists.openembedded.org)
> > http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > 
> > 
> 
> 


