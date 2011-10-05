Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RBRXb-0006BM-9v for bitbake-devel@lists.openembedded.org;
	Wed, 05 Oct 2011 15:29:43 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p95DUZ34022217; Wed, 5 Oct 2011 14:30:36 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aBuCrNEluI0z; Wed,  5 Oct 2011 14:30:35 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p95DUSH4022197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Oct 2011 14:30:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matthew McClintock <msm@freescale.com>
Date: Wed, 05 Oct 2011 14:23:58 +0100
In-Reply-To: <1317755317-14911-1-git-send-email-msm@freescale.com>
References: <1317755317-14911-1-git-send-email-msm@freescale.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1317821046.14671.151.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Export additional variables to the fetchers
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
X-List-Received-Date: Wed, 05 Oct 2011 13:29:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-10-04 at 14:08 -0500, Matthew McClintock wrote:
> git could need these environment variables when working behind
> a proxy
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
>  lib/bb/fetch2/__init__.py |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



