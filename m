Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1StbjR-0004aW-MN for bitbake-devel@lists.openembedded.org;
	Tue, 24 Jul 2012 11:48:45 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6O9bEuF029156;
	Tue, 24 Jul 2012 10:37:14 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28802-01; Tue, 24 Jul 2012 10:37:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6O9b3Wx029150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2012 10:37:05 +0100
Message-ID: <1343122622.22222.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Ertsaas <mertsas@cisco.com>
Date: Tue, 24 Jul 2012 10:37:02 +0100
In-Reply-To: <1342697185-7332-1-git-send-email-mertsas@cisco.com>
References: <1342697185-7332-1-git-send-email-mertsas@cisco.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Change bzr fetcher to use branch instead of co. Fixes: bzr: ERROR: No pull location known or specified.
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
X-List-Received-Date: Tue, 24 Jul 2012 09:48:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-07-19 at 13:26 +0200, Martin Ertsaas wrote:
> This problem occurs when fetching a different revision of the same source. Which mean every time you update a bzr package.
> Using branch sets the pull location, and are the preferred way of cloning/branching a repository in bzr.
> 
> Signed-off-by: Martin Ertsaas <mertsas@cisco.com>
> ---
>  lib/bb/fetch2/bzr.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
> index 97daa62..58e80c8 100644
> --- a/lib/bb/fetch2/bzr.py
> +++ b/lib/bb/fetch2/bzr.py
> @@ -73,7 +73,7 @@ class Bzr(FetchMethod):
>                  options.append("-r %s" % ud.revision)
>  
>              if command == "fetch":
> -                bzrcmd = "%s co %s %s://%s" % (basecmd, " ".join(options), proto, bzrroot)
> +                bzrcmd = "%s branch %s %s://%s" % (basecmd, " ".join(options), proto, bzrroot)
>              elif command == "update":
>                  bzrcmd = "%s pull %s --overwrite" % (basecmd, " ".join(options))
>              else:

Merged to master, thanks.

Richard



