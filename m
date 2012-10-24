Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TR7UU-00013p-Bh for bitbake-devel@lists.openembedded.org;
	Wed, 24 Oct 2012 22:23:50 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKAHQP007322;
	Wed, 24 Oct 2012 21:10:17 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06617-02; Wed, 24 Oct 2012 21:10:13 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKA94H007316
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2012 21:10:11 +0100
Message-ID: <1351109409.22340.124.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Dinu <andrei.adrianx.dinu@intel.com>
Date: Wed, 24 Oct 2012 21:10:09 +0100
In-Reply-To: <1350032783-18499-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1350032783-18499-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: image size displayed wrong size in edit packages screen
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
X-List-Received-Date: Wed, 24 Oct 2012 20:23:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-10-12 at 12:06 +0300, Andrei Dinu wrote:
> size_str = '%.1f' % (size*1.0/(1024*1024)) + ' MB'
>     from /bitbake/lib/bb/ui/crumbs/hobpages.py file transformed
>     the size in MB. In our file it was again multiplied by 1024
>     instead of doing a division by 1024, which brought a faulty size on
>     the edit packages screen.
> 
> Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged to master, thanks.

Richard



