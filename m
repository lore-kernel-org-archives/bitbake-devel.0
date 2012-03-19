Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1S9ccu-0002wQ-Gm
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 14:27:56 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1S9cUM-0008Pb-JC for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 09:19:06 -0400
Date: Mon, 19 Mar 2012 09:18:56 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1203190857360.26126@oneiric>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: wanting to verify best way to set up a local source mirror
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
X-List-Received-Date: Mon, 19 Mar 2012 13:27:57 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  we had a recent discussion on the yocto ML about this and i'd like
to confirm the best way to define a local source mirror.

  currently, the bitbake manual (chapter 3), discusses how to set up
something like that,

PREMIRRORS ?= "\
bzr://.*/.*   http://somemirror.org/sources/ \n \
cvs://.*/.*   http://somemirror.org/sources/ \n \
git://.*/.*   http://somemirror.org/sources/ \n \
hg://.*/.*    http://somemirror.org/sources/ \n \
osc://.*/.*   http://somemirror.org/sources/ \n \
p4://.*/.*    http://somemirror.org/sources/ \n \
svk://.*/.*   http://somemirror.org/sources/ \n \
svn://.*/.*   http://somemirror.org/sources/ \n"

  in my case, i have a directory of tarballs i've collected over the
years that i want to take advantage of, and i was using this in my
local.conf file:

PREMIRRORS_prepend = "\
git://.*/.* file:///home/rpjday/dl/ \n \
svn://.*/.* file:///home/rpjday/dl/ \n \
cvs://.*/.* file:///home/rpjday/dl/ \n \
ftp://.*/.* file:///home/rpjday/dl/ \n \
http://.*/.* file:///home/rpjday/dl/ \n \
https://.*/.* file:///home/rpjday/dl/ \n"

which was kind of tedious but it seemed to work fine.

  however, gary thomas suggested the following instead (which is way
nicer):

SOURCE_MIRROR_URL ?= "file:///home/rpjday/dl/"
INHERIT += "own-mirrors"
BB_GENERATE_MIRROR_TARBALLS = "1"
# BB_NO_NETWORK = "1"

which makes sense given this from meta/classes/own-mirrors.bbclass in
oe-core:

REMIRRORS() {
cvs://.*/.*     ${SOURCE_MIRROR_URL}
svn://.*/.*     ${SOURCE_MIRROR_URL}
git://.*/.*     ${SOURCE_MIRROR_URL}
hg://.*/.*      ${SOURCE_MIRROR_URL}
bzr://.*/.*     ${SOURCE_MIRROR_URL}
svk://.*/.*     ${SOURCE_MIRROR_URL}
p4://.*/.*      ${SOURCE_MIRROR_URL}
osc://.*/.*     ${SOURCE_MIRROR_URL}
https?$://.*/.* ${SOURCE_MIRROR_URL}
ftp://.*/.*     ${SOURCE_MIRROR_URL}
}

so i would think that the bitbake manual could be updated to refer to
this cleaner solution, as long as it works the way i think it does.
is there anything else that could be said about using the own-mirrors
class that a reader might want to know?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================



