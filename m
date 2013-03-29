Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ULX79-0003nY-KL for bitbake-devel@lists.openembedded.org;
	Fri, 29 Mar 2013 12:04:56 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2TAvnHQ024565; Fri, 29 Mar 2013 10:57:50 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3P1ycZIxVLoJ; Fri, 29 Mar 2013 10:57:49 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2TAvgqs024526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 29 Mar 2013 10:57:44 GMT
Message-ID: <1364554049.28471.184.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Dinu <andrei.adrianx.dinu@intel.com>
Date: Fri, 29 Mar 2013 10:47:29 +0000
In-Reply-To: <1364471013-6273-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364471013-6273-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Removed popup when including a package
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
X-List-Received-Date: Fri, 29 Mar 2013 11:05:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-03-28 at 13:43 +0200, Andrei Dinu wrote:
> Fixed the functionality which made an information
> dialog pop up when including any package.
> 
> [HOB #4138]
> 
> Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Please rebase this on master and your other patch set.

I'd also like to suggest you and Cristiana jointly start generating pull
requests based on a git tree alongside the patches, based on the bitbake
repository. This will make is easier and faster for me to merge changes.

Cheers,

Richard





