Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 1E06C6D37F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 21:37:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAILau3Y019828; Mon, 18 Nov 2013 21:36:56 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2L-14JIJWEfI; Mon, 18 Nov 2013 21:36:56 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAILapmp019824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 18 Nov 2013 21:36:52 GMT
Message-ID: <1384810607.6460.274.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 18 Nov 2013 21:36:47 +0000
In-Reply-To: <20131118183213.GI3727@jama>
References: <1384795036.6460.247.camel@ted> <20131118183213.GI3727@jama>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] git: Use merge-base instead of log for testing if a commit is present
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
X-List-Received-Date: Mon, 18 Nov 2013 21:37:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-11-18 at 19:32 +0100, Martin Jansa wrote:
> On Mon, Nov 18, 2013 at 05:17:16PM +0000, Richard Purdie wrote:
> > The current use of git log to check if a given revision is present can be
> > a little fragile.
> > 
> > For example if revision X was on branch A, and then later added to branch
> > B, the update checks would not notice this since they just check for X
> > being in the repository.
> > 
> > We also had some autobuilder corruption where an older packed-refs file
> > was copied over a new repository containing newer pack files. There
> > was no update to the refs file since the revision was present but
> > not accessible in any branch.
> > 
> > The correct fix is to check that the required revisions are present
> > on the specific branches. This patch does this using merge-base.
> 
> I guess that merge-base is probably faster or easier to use, but did you
> consider using git branch --contains?
> 
> e.g. checking if selected branch is in
> git branch --contains ud.revisions[name]
> 
> I'm asking only because I'm using "git branch --contains" in some
> scripts and maybe there is good reason I should rewrite them to use git
> merge-base instead.

git branch --contains gives you a branch list back which you'd have to
then parse to see if branch X was listed. git merge-base is faster and
we can directly ask what we need with an exit code. There is no more
deeply technical reason than that, was just neater.

Cheers,

Richard






