Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R6McD-0006Bx-Jt for bitbake-devel@lists.openembedded.org;
	Wed, 21 Sep 2011 15:13:29 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8LDENQE001488; Wed, 21 Sep 2011 14:14:23 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dJPSBL32qfF4; Wed, 21 Sep 2011 14:14:23 +0100 (BST)
Received: from [192.168.250.158] ([116.246.20.131]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8LDEDwL001484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 21 Sep 2011 14:14:16 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Julian Pidancet <julian.pidancet@gmail.com>
Date: Wed, 21 Sep 2011 14:08:00 +0100
In-Reply-To: <1316567694-22600-1-git-send-email-julian.pidancet@gmail.com>
References: <1316567694-22600-1-git-send-email-julian.pidancet@gmail.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316610485.13085.46.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Fix mercurial fetcher in fetch2
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
X-List-Received-Date: Wed, 21 Sep 2011 13:13:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-09-21 at 02:14 +0100, Julian Pidancet wrote:
> The _build_revision method in Hg class gets called with the wrong number
> of arguments. This tiny patch adds a 5th argument to the method
> declaration to prevent python from throwing an exception.
> 
> Signed-off-by: Julian Pidancet <julian.pidancet@gmail.com>

Merged to master, thanks.

Richard



