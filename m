Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SjpkF-0007sI-FH; Wed, 27 Jun 2012 12:45:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RAYI0U010657;
	Wed, 27 Jun 2012 11:34:18 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06198-04; Wed, 27 Jun 2012 11:34:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RAY9dD010651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 11:34:10 +0100
Message-ID: <1340793253.23146.19.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 27 Jun 2012 11:34:13 +0100
In-Reply-To: <20120626173118.GB3169@jama.jama.net>
References: <1340289297.1640.122.camel@ted>
	<20120626173118.GB3169@jama.jama.net>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core@lists.openembedded.org
Subject: Re: (PRE)MIRRORS doesn't work with https?$:// anymore Was: [PATCH] fetch2: Add new mirror syntax to simplify mirror specifications
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
X-List-Received-Date: Wed, 27 Jun 2012 10:45:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-06-26 at 19:31 +0200, Martin Jansa wrote:
> On Thu, Jun 21, 2012 at 03:34:57PM +0100, Richard Purdie wrote:
> > When writing mirror specifications, the current regexp syntax can be awkward
> > and hard to get it to do what you want. For example, extracting the 'basename'
> > of a repository:
> > 
> > PREMIRRORS = "git://.*/([^/]+/)*([^/]*) git://somewhere.org/somedir/\\2;protocol=file"
> > 
> > can now become:
> > 
> > PREMIRRORS = "git://.*/.* git://somewhere.org/somedir/BASENAME;protocol=file"
> > 
> > which is much clearer. A MIRRORNAME substitution is also added which contains
> > an encoded form of both host and path. One of the problems with the existing
> > regexp syntax is you couldn't access HOST information from PATH and vice-versa
> > which is an issue this patch also addresses.
> 
> One of this fetch2 patches break https?:// in MIRRORS
> 
> It's used e.g in openembedded-core/meta/classes/mirrors.bbclass:
> https?$://.*/.* http://downloads.yoctoproject.org/mirror/sources/
> https?$://.*/.* http://sources.openembedded.org/
> 
> I've tested it with older bitbake in PREMIRRORS (to make log.do_fetch
> log shorter) on libcap (which doesn't exist on upstream URL).
> 
> PREMIRRORS_append () {
> cvs://.*/.* http://build.shr-project.org/sources/
> svn://.*/.* http://build.shr-project.org/sources/
> git://.*/.* http://build.shr-project.org/sources/
> hg://.*/.* http://build.shr-project.org/sources/
> bzr://.*/.* http://build.shr-project.org/sources/
> https?$://.*/.* http://build.shr-project.org/sources/
> }

This is almost certainly a result of:

http://git.openembedded.org/bitbake/commit/?id=604df1b25cf114e083f52917df2df64e01279c25

since I didn't believe anyone was using the regexp syntax in the base
url type. The bug I wanted to fix was where if you did:

https://.*/.* file:///some/path/

which seems reasonable enough, it would access:

files:///some/path/

which is clearly not what anyone would want.

I'm not sure what to do about fixing this...

Cheers,

Richard





