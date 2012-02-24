Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0yKG-0005di-Ox for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 17:48:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1OGeXcG008899;
	Fri, 24 Feb 2012 16:40:33 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08819-01; Fri, 24 Feb 2012 16:40:29 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1OGePUI008893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Feb 2012 16:40:26 GMT
Message-ID: <1330101626.5477.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bruce Ashfield <bruce.ashfield@windriver.com>
Date: Fri, 24 Feb 2012 16:40:26 +0000
In-Reply-To: <1330031322-22689-2-git-send-email-bruce.ashfield@windriver.com>
References: <1330031322-22689-1-git-send-email-bruce.ashfield@windriver.com>
	<1330031322-22689-2-git-send-email-bruce.ashfield@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/git: create bareclone option
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
X-List-Received-Date: Fri, 24 Feb 2012 16:48:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-02-23 at 16:08 -0500, Bruce Ashfield wrote:
> For similar reasons as the nocheckout option, packages that need
> enhanced control over the checkout and branch creation on a repository
> may want a complete mirror/bareclone created of the repository when
> performing the unpack.
> 
> This is useful/required when a local respository is being used, but
> local tracking branches have not been created for all branches that
> a given recipe needs to manipulate. The standard git clone operations
> will create remote branches for the branches that are local to the
> source repository, but branches that are remote do not translate to
> the destination repository. Doing a mirror/bare clone of the source,
> makes all branches available to the repository.
> 
> This is a particular use case, but the ability to do a bare clone
> creates great flexibility in recipe space, with no impact to recipes
> that don't need this functionality.
> 
> To implement this, a new option 'bareclone' is craeted which creates
> a mirror copy of the repository and leaves it bare in the unpacking
> phase. A recipe that uses this option must both checkout and debare
> the repository itself.
> 
> Signed-off-by: Bruce Ashfield <bruce.ashfield@windriver.com>
> ---
>  lib/bb/fetch2/git.py |   17 ++++++++++++++++-
>  1 files changed, 16 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



