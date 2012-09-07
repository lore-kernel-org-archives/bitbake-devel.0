Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T9wdK-0003kr-7h for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 13:21:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87B9Udr028385;
	Fri, 7 Sep 2012 12:09:30 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27778-07; Fri,  7 Sep 2012 12:09:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87B9Oep028379
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Sep 2012 12:09:24 +0100
Message-ID: <1347016165.7493.55.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 07 Sep 2012 12:09:25 +0100
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Refactoring + improve bitbake-diffsigs
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
X-List-Received-Date: Fri, 07 Sep 2012 11:21:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-08-27 at 21:44 +0100, Paul Eggleton wrote:
> Refactor out a class which can be used as the basis for bitbake-based
> utilities, and use it to improve bitbake-diffsigs to enable easily
> specifying a recipe and task and determine what the difference was in
> the signature data between the last two executions.
> 
> This change requires some support code within the metadata (since
> BitBake itself knows nothing about the implementation of shared state);
> a patch to implement this in OE-Core has been sent to the OE-Core
> mailing list.
> 
> Note that this is similar in spirit but does not directly overlap with
> Robert's bitbake-whatchanged script - that allows you to determine what
> will be done before it happens, whereas this tool is useful for
> determining why a rebuild occurred afterwards.
> 
> 
> The following changes (against poky, but apply cleanly with -p2 against 
> bitbake master) are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib paule/bbdiffsigs
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bbdiffsigs
> 
> Paul Eggleton (5):
>   tinfoil: create simple interface for bitbake-based utilities
>   lib/bb/siggen: replace tabs with spaces
>   lib/bb/siggen.py: insert a colon between class and recipe name
>   lib/bb/siggen.py: make signature dump/compare functions return a list
>   bitbake-diffsigs: allow specifying task & follow deps recursively

Merged to master, thanks.

Nice to have this working better :)

Cheers,

Richard



