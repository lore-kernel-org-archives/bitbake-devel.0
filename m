Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2023D60781
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 May 2014 20:47:11 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s46Kl6mj000515; Tue, 6 May 2014 21:47:06 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id X5Jo9f7arf71; Tue,  6 May 2014 21:47:06 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s46Kl2d0000488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 21:47:04 +0100
Message-ID: <1399409216.31891.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Tue, 06 May 2014 21:46:56 +0100
In-Reply-To: <53651583.5000708@windriver.com>
References: <1399112321.12731.101.camel@ted> <53651583.5000708@windriver.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] prserv/db: Avoid fsync() calls
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
X-List-Received-Date: Tue, 06 May 2014 20:47:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2014-05-03 at 09:12 -0700, Mark Hatle wrote:
> On 5/3/14, 3:18 AM, Richard Purdie wrote:
> > If the power were to fail, it doesn't matter to us much if the data
> > makes it to disk or not, we'd have other problems. However an fsync()
> > call on a multi build autobuilder is painful so lets avoid them.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
> > index 86eafe3..49f36da 100644
> > --- a/bitbake/lib/prserv/db.py
> > +++ b/bitbake/lib/prserv/db.py
> > @@ -220,6 +220,7 @@ class PRData(object):
> >                   raise e
> >           self.connection=sqlite3.connect(self.filename, isolation_level="EXCLUSIVE", check_same_thread = False)
> >           self.connection.row_factory=sqlite3.Row
> > +        self.connection.execute("pragma synchronous = off;")
> >           self._tables={}
> >
> >       def __del__(self):
> >
> >
> 
> Does the prserver make any noticeable difference?  This may be the one case 
> where I could see an fsync being desired.  If you are serving remote machines, 
> once you've requested a PR, the number should be stored to disk so that it will 
> be the same one that comes back again.  ... but I can easily see that in the 
> middle of a build, when the PR server is on the same machine (and not shared) 
> this could cause enough slow down to justify turning off the fsync.

Our default use case is that of the same machine and yes, these fsyncs
do made a difference in that workload for things like UI interaction
too. I stumbled into this wondering why my build wasn't starting and the
IO maxed out which made me look further.

I understand the issue of the remote server needing to write to disk
however even if its not on disk, it will be in sync with any other
questions due to the locking so it is just a power interruption issue
and I'm therefore less worried about it in most of the use cases we see
this used in.

Cheers,

Richard



