Received: from vms173001pub.verizon.net ([206.46.173.1])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1S9kEL-00047H-S4
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 22:35:06 +0100
Received: from gandalf.denix.org ([unknown] [71.178.225.66])
	by vms173001.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M150080RFEIISJ0@vms173001.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 15:25:31 -0500 (CDT)
Received: by gandalf.denix.org (Postfix, from userid 1000)	id 9E7B12018B; Mon,
	19 Mar 2012 16:25:30 -0400 (EDT)
Date: Mon, 19 Mar 2012 16:25:30 -0400
From: Denys Dmytriyenko <denis@denix.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-id: <20120319202530.GB15554@denix.org>
References: <alpine.DEB.2.02.1203190857360.26126@oneiric>
MIME-version: 1.0
In-reply-to: <alpine.DEB.2.02.1203190857360.26126@oneiric>
User-Agent: Mutt/1.5.20 (2009-06-14)
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: wanting to verify best way to set up a local source mirror
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
X-List-Received-Date: Mon, 19 Mar 2012 21:35:06 -0000
Content-type: text/plain; charset=us-ascii
Content-disposition: inline

On Mon, Mar 19, 2012 at 09:18:56AM -0400, Robert P. J. Day wrote:
> 
>   we had a recent discussion on the yocto ML about this and i'd like
> to confirm the best way to define a local source mirror.
> 
>   currently, the bitbake manual (chapter 3), discusses how to set up
> something like that,
> 
> PREMIRRORS ?= "\
> bzr://.*/.*   http://somemirror.org/sources/ \n \
> cvs://.*/.*   http://somemirror.org/sources/ \n \
> git://.*/.*   http://somemirror.org/sources/ \n \
> hg://.*/.*    http://somemirror.org/sources/ \n \
> osc://.*/.*   http://somemirror.org/sources/ \n \
> p4://.*/.*    http://somemirror.org/sources/ \n \
> svk://.*/.*   http://somemirror.org/sources/ \n \
> svn://.*/.*   http://somemirror.org/sources/ \n"
> 
>   in my case, i have a directory of tarballs i've collected over the
> years that i want to take advantage of, and i was using this in my
> local.conf file:
> 
> PREMIRRORS_prepend = "\
> git://.*/.* file:///home/rpjday/dl/ \n \
> svn://.*/.* file:///home/rpjday/dl/ \n \
> cvs://.*/.* file:///home/rpjday/dl/ \n \
> ftp://.*/.* file:///home/rpjday/dl/ \n \
> http://.*/.* file:///home/rpjday/dl/ \n \
> https://.*/.* file:///home/rpjday/dl/ \n"
> 
> which was kind of tedious but it seemed to work fine.
> 
>   however, gary thomas suggested the following instead (which is way
> nicer):
> 
> SOURCE_MIRROR_URL ?= "file:///home/rpjday/dl/"
> INHERIT += "own-mirrors"
> BB_GENERATE_MIRROR_TARBALLS = "1"
> # BB_NO_NETWORK = "1"
> 
> which makes sense given this from meta/classes/own-mirrors.bbclass in
> oe-core:
> 
> REMIRRORS() {
> cvs://.*/.*     ${SOURCE_MIRROR_URL}
> svn://.*/.*     ${SOURCE_MIRROR_URL}
> git://.*/.*     ${SOURCE_MIRROR_URL}
> hg://.*/.*      ${SOURCE_MIRROR_URL}
> bzr://.*/.*     ${SOURCE_MIRROR_URL}
> svk://.*/.*     ${SOURCE_MIRROR_URL}
> p4://.*/.*      ${SOURCE_MIRROR_URL}
> osc://.*/.*     ${SOURCE_MIRROR_URL}
> https?$://.*/.* ${SOURCE_MIRROR_URL}
> ftp://.*/.*     ${SOURCE_MIRROR_URL}
> }
> 
> so i would think that the bitbake manual could be updated to refer to
> this cleaner solution, as long as it works the way i think it does.
> is there anything else that could be said about using the own-mirrors
> class that a reader might want to know?

You are confusing bibbake manual with metadata - bitbake doesn't come with 
own-mirrors class.

-- 
Denys


