Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UHxKv-0001qo-PA for bitbake-devel@lists.openembedded.org;
	Tue, 19 Mar 2013 15:16:23 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JE8Vs8009749; Tue, 19 Mar 2013 14:08:32 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IdoSAVxA50sC; Tue, 19 Mar 2013 14:08:31 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JE8P61009741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 19 Mar 2013 14:08:28 GMT
Message-ID: <1363701547.16482.105.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Tue, 19 Mar 2013 13:59:07 +0000
In-Reply-To: <1363173908-11342-1-git-send-email-cristiana.voicu@intel.com>
References: <1363173908-11342-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: implementation of search functionality in Hob
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
X-List-Received-Date: Tue, 19 Mar 2013 14:16:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-03-13 at 13:25 +0200, Cristiana Voicu wrote:
> Implemented the search functionality for recipes and packages using
> filters on the listmodel. I have used the design which can be found in
> bugzilla.
> 
> [YOCTO #3529]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |  119 ++++++++++++++++------
>  bitbake/lib/bb/ui/crumbs/hobwidget.py            |   77 ++++++++++----
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   57 ++++++++---
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   68 +++++++++----
>  4 files changed, 236 insertions(+), 85 deletions(-)

This conflicts with other changes that have merged, could you rebase and
resend it please?

Thanks,

Richard



