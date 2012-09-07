Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T9wt4-0003tu-JH for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 13:38:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87BPkrY028501;
	Fri, 7 Sep 2012 12:25:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27749-08; Fri,  7 Sep 2012 12:25:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87BPdl1028495
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Sep 2012 12:25:40 +0100
Message-ID: <1347017140.7493.56.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Liming An <limingx.l.an@intel.com>
Date: Fri, 07 Sep 2012 12:25:40 +0100
In-Reply-To: <302f1088dbc5d678b309a5bc766afbb414de9e81.1346842933.git.limingx.l.an@intel.com>
References: <cover.1346842933.git.limingx.l.an@intel.com>
	<302f1088dbc5d678b309a5bc766afbb414de9e81.1346842933.git.limingx.l.an@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] Hob: change view of 'recipes' and 'packages' tables as ui design
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
X-List-Received-Date: Fri, 07 Sep 2012 11:38:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-05 at 19:13 +0800, Liming An wrote:
> changed the order of task tables,
> cancel the 'description' column,
> add the binb total number indicator, and so on
> 
> [YOCTO 2195]
> 
> Signed-off-by: Liming An <limingx.l.an@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    9 ++++-
>  bitbake/lib/bb/ui/crumbs/hobwidget.py            |    7 +++-
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   48 +++++----------------
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   37 +++++++----------
>  4 files changed, 41 insertions(+), 60 deletions(-)

Merged to master, thanks.

Richard



