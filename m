Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTH3a-0002JX-VN for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 18:56:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pANHnnmM015325;
	Wed, 23 Nov 2011 17:49:49 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14549-10; Wed, 23 Nov 2011 17:49:44 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pANHncO1015319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Nov 2011 17:49:40 GMT
Message-ID: <1322070584.15626.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matthew McClintock <msm@freescale.com>
Date: Wed, 23 Nov 2011 17:49:44 +0000
In-Reply-To: <1322035440-8480-1-git-send-email-msm@freescale.com>
References: <1322035440-8480-1-git-send-email-msm@freescale.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] siggen.py: sort task hash depedencies with basepath
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
X-List-Received-Date: Wed, 23 Nov 2011 17:56:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-11-23 at 02:04 -0600, Matthew McClintock wrote:
> Without this patch the tash hash dependencies can be in a order
> that is dependent upon directory/filesystem layout. With this
> change the data is sorted the same regardless.
> 
> Without this the dependent hashes could be in different orders
> on different systems and consequently final md5 hash would differ
> as well even though nothing else changed.
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
>  lib/bb/siggen.py |   25 ++++++++++++++-----------
>  1 files changed, 14 insertions(+), 11 deletions(-)

Merged to master, thanks!

Richard



