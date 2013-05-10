Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UammD-0004Y5-A3 for bitbake-devel@lists.openembedded.org;
	Fri, 10 May 2013 14:50:21 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4ACYjIY032183; Fri, 10 May 2013 13:34:45 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8qpJSi8-Wl7u; Fri, 10 May 2013 13:34:45 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4ACYeVE032168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 10 May 2013 13:34:41 +0100
Message-ID: <1368189120.11129.31.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 10 May 2013 13:32:00 +0100
In-Reply-To: <20130510093535.GH3188@jama>
References: <20732985.qIsTObyanK@helios>
	<1367944760-16756-1-git-send-email-Martin.Jansa@gmail.com>
	<20130507215108.GA3188@jama> <20130510093535.GH3188@jama>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCHv3] git: remove symling before updating mirror tarball
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
X-List-Received-Date: Fri, 10 May 2013 12:50:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-05-10 at 11:35 +0200, Martin Jansa wrote:
> On Tue, May 07, 2013 at 11:51:08PM +0200, Martin Jansa wrote:
> > On Tue, May 07, 2013 at 06:39:20PM +0200, Martin Jansa wrote:
> > > * with read-only PREMIRROR (e.g. mounted over NFS or CIFS
> > >   and referenced as file:///mnt/premirror) we cannot use
> > >   BB_GENERATE_MIRROR_TARBALLS because all git2_abc.git.tar.gz
> > >   files later became just symlinks to read-only location in PREMIRROR
> > >   (it works fine on first build and for new components, because
> > >   at that time there isn't tarball on PREMIRROR yet).
> > > 
> > >   ERROR: Fetcher failure: Fetch command failed with exit code 141, output:
> > >   tar (child): /build/downloads/git2_abc.git.tar.gz: Cannot open: Read-only file system
> > >   tar (child): Error is not recoverable: exiting now
> > 
> > This one is tested and I would like to get it also in 1.16 and 1.18
> 
> cherry-picking 3627b02f77c78beedadadd77c619b9e5edaae076 works fine for
> both, do you prefer to send patches with [1.16]/[1.18] in subject or
> should I just wait a bit more with patch in master and then ping you
> later?

Just give this a short while, then we can backport. I don't like
instantly backporting to other releases...

Cheers,

Richard



