Received: from vms173015pub.verizon.net ([206.46.173.15])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>)
	id 1SDW5E-0005hJ-7j; Fri, 30 Mar 2012 09:17:16 +0200
Received: from gandalf.denix.org ([unknown] [71.178.225.66])
	by vms173015.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009))
	with ESMTPA id <0M1O0098WRTMOM51@vms173015.mailsrvcs.net>; Fri,
	30 Mar 2012 02:08:11 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id C9D52201AE; Fri,
	30 Mar 2012 03:08:10 -0400 (EDT)
Date: Fri, 30 Mar 2012 03:08:10 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: Oren Leaffer <oren@ephemeron-labs.com>
Message-id: <20120330070810.GA5488@denix.org>
References: <CALvD2Lj2HbbAmfsaQyiifz5DLe+3-ewX7TPBAkFGJRxSp2_P5w@mail.gmail.com>
MIME-version: 1.0
In-reply-to: <CALvD2Lj2HbbAmfsaQyiifz5DLe+3-ewX7TPBAkFGJRxSp2_P5w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Cc: meta-ti@yoctoproject.org, bitbake-devel@lists.openembedded.org,
	angstrom-distro-devel@linuxtogo.org,
	openembedded-core@lists.openembedded.org
Subject: Re: do_rootfs failed ... bug in log_check?
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
X-List-Received-Date: Fri, 30 Mar 2012 07:17:16 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Fri, Mar 30, 2012 at 02:27:13AM -0400, Oren Leaffer wrote:
> Hi,
> 
> I'm getting the following failure on "bitbake -v -D -D -D systemd-image":
> ERROR: Task 8 (/home/ol/setup-scripts/sources/meta-angstrom/recipes-images/angstrom/systemd-image.bb,
> do_rootfs) failed with exit code '1'
> NOTE: Tasks Summary: Attempted 3283 tasks of which 3282 didn't need to
> be rerun and 1 failed.
> + cd /home/ol/setup-scripts/build/tmp-angstrom_2010_x-eglibc/work/armv7a-angstrom-linux-gnueabi/bblayers-1.0-r0/bblayers-1.0
> + buildhistory_commit
> + '[' '!' -d /home/ol/setup-scripts/build/tmp-angstrom_2010_x-eglibc/buildhistory
> ']'
> + cd /home/ol/setup-scripts/build/tmp-angstrom_2010_x-eglibc/buildhistory/
> + '[' '!' -d .git ']'
> ++ git status --porcelain
> + repostatus=
> + '[' '' '!=' '' ']'

We have been discussing this topic past couple days here:
http://thread.gmane.org/gmane.linux.distributions.angstrom.devel/6260/focus=6274

Moreover, bitbake-devel is probably the wrongest list for this discussion or 
patch. I'm copying other related lists, but probably the main one should be 
openembedded-core, as the patch tries to fix it's package_ipk class...


> From what I can tell, this is caused because the log_check command in
> setup-scripts/sources/openembedded-core/meta/classes/package_ipk.class
> matches on line 177 to
> 
> file://3.2.1/0042-xhci-Properly-handle-COMP_2ND_BW_ERR.patch
> 
> and to
> 
> file://3.2.6/0072-target-Fail-INQUIRY-commands-with-EVPD-0-but-PAGE-CO.patch

And your analysis seems correct, as the grep matches the patch names of 
beaglebone kernel from meta-ti.


> It occurs to me that this might be a result of the level of
> verbosity/debugging that I specified.

Actually, it does not depend on the verbosity/debug level, as it controls the 
output on the console and not in the log.do_rootfs file.


> Attached is my patch that does two things:
> 1) makes the error message from log_check slightly more informative

I don't think this part is really necessary - you always know which packaging 
system you use, so ipk/deb/rpm_log_check is rather easily identifiable...


> 2) changes the text that log_check is using to identify errors to
> incorporate regular expressions

So, this changes the regular expression to look for ^ERR and ^Fail at the 
beginning of the line...


> This makes it less likely to issue false positives, I hope that it
> doesn't increase the changes of false negatives, but I'm a rank
> amateur at this, so I wouldn't bet on it.

While the change should fix this particular issue, I'm also worried about 
increasing chances of missing the actual errors when they don't start with ERR 
and Fail at the beginning of the line.

Either way, you may want to resubmit the cleaned up patch to openembedded-core 
list for other to comment.

P.S. Sorry for somewhat excessive cross-posting.

-- 
Denys


