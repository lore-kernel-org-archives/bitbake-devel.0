Received: from vms173003pub.verizon.net ([206.46.173.3])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1S8GLB-0003Uk-S7
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 20:28:02 +0100
Received: from gandalf.denix.org ([unknown] [71.178.225.66])
	by vms173003.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M0X005YVUV9YCF1@vms173003.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 13:18:46 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id 2549A201AC; Thu,
	15 Mar 2012 14:18:44 -0400 (EDT)
Date: Thu, 15 Mar 2012 14:18:44 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Martin Jansa <martin.jansa@gmail.com>
Message-id: <20120315181844.GE30363@denix.org>
References: <4F605E85.7070904@windriver.com> <1331718176.18586.15.camel@ted>
	<4F61926D.1060709@windriver.com> <4F619CD4.4090103@windriver.com>
	<20120315080310.GC4973@jama.jama.net> <4F61B1D0.2080306@windriver.com>
	<20120315092122.GE4973@jama.jama.net>
MIME-version: 1.0
In-reply-to: <20120315092122.GE4973@jama.jama.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Cc: Kang Kai <Kai.Kang@windriver.com>, bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 15 Mar 2012 19:28:02 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Thu, Mar 15, 2012 at 10:21:22AM +0100, Martin Jansa wrote:
> On Thu, Mar 15, 2012 at 05:09:36PM +0800, Kang Kai wrote:
> > On 2012???03???15??? 16:03, Martin Jansa wrote:
> > > On Thu, Mar 15, 2012 at 03:40:04PM +0800, Kang Kai wrote:
> > >> On 2012???03???15??? 14:55, Kang Kai wrote:
> > >>> On 2012???03???14??? 17:42, Richard Purdie wrote:
> > >>>> On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
> > >>>>> Hi All,
> > >>>>>
> > >>>>> I write a script to clean up WORKDIR that remove the obsoleted
> > >>>>> packages' build directories.
> > >>>>> The script accept a argument as BUILDDIR and I use this clause to
> > >>>>> identify the WORKDIR:
> > >>>>>
> > >>>>>        workdir = os.path.join(builddir, 'tmp/work')
> > >>>>>
> > >>>>> Then validate the workdir exists or not. It works for me but hardcode
> > >>>>> here as Richard point out.
> > >>>>> So is there  a better way to get the WORKDIR here? Thanks.
> > >>>> I was thinking of something like:
> > >>>>
> > >>>> bitbake -e | grep ^WORKDIR
> > >> And the result is something like that:
> > >> WORKDIR="/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/x86_64-poky-linux/bblayers-1.0-r0"
> > >>
> > >> Is it ok to remove 2 items seperated by slash at the end of string?
> > >> Right now is:
> > >> "/mnt/sda10/poky-all-platform/build-qemux86_64/tmp/work/"
> > > Aren't you looking for ^TMPDIR ?
> > 
> > If use WORKDIR = TMPDIR/"work", it is still hard coding.
> 
> Assuming 2 items at the end won't work for people using rm_old_work:
> http://git.openembedded.org/meta-micro/commit/?id=fcf525654915edb9650f1a6c2852f336366f8b2f
> or slightly different version:
> http://git.shr-project.org/git/?p=meta-smartphone.git;a=blob;f=meta-shr/classes/rm_old_work.bbclass

Martin,

Can you please point me to more details about this class - any background or 
discussions... Thanks.

-- 
Denys


> And I think more people have different "tmp/" part e.g. default would be
> "tmp-eglibc/" (thanks to TCLIBCAPPEND
> meta/conf/distro/defaultsetup.conf:TMPDIR .= "${TCLIBCAPPEND}"), but "work" is 
> quite common.
> 
> meta/conf/bitbake.conf:
> WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PF}"
> meta-shr/classes/rm_old_work.bbclass:
> WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${PF}"
> meta-micro/classes/rm_old_work.bbclass:
> WORKDIR = "${TMPDIR}/work/${MULTIMACH_TARGET_SYS}/${PN}/${EXTENDPE}${PV}-${PR}"
> 
> Cheers,
> 
> > 
> > >> Regards,
> > >> Kai
> > >>
> > >>> If get WORKDIR in this way, I'll update the script with no argument
> > >>> because the argument is useless to identify the WORKDIR.
> > >>>
> > >>> Regards,
> > >>> Kai
> > >>>> since you already call into bitbake in the script in question.
> > >>>>
> > >>>> Cheers,
> > >>>>
> > >>>> Richard
> > >>>>
> > >>>>
> > >>>
> > >>> _______________________________________________
> > >>> bitbake-devel mailing list
> > >>> bitbake-devel@lists.openembedded.org
> > >>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > >>
> > >> _______________________________________________
> > >> bitbake-devel mailing list
> > >> bitbake-devel@lists.openembedded.org
> > >> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> > 
> 
> -- 
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com



> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



