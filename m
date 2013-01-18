Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwBZ1-0004Su-BP for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 14:01:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0ICjUCi008902;
	Fri, 18 Jan 2013 12:45:30 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05490-04; Fri, 18 Jan 2013 12:45:26 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0ICjMmr008896
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 12:45:23 GMT
Message-ID: <1358513122.27799.21.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tyler Hall <tylerwhall@gmail.com>
Date: Fri, 18 Jan 2013 12:45:22 +0000
In-Reply-To: <1355959610-29470-1-git-send-email-tylerwhall@gmail.com>
References: <1355959610-29470-1-git-send-email-tylerwhall@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: Sort file checksums by value, not path
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
X-List-Received-Date: Fri, 18 Jan 2013 13:01:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-12-19 at 18:26 -0500, Tyler Hall wrote:
> Changing the path to a file could change the task hash even if the file
> still has the same checksum. This occurs when the task depends on
> multiple files and the sort order of their paths changes. Usually the
> sorting is consistent because layers tend to have the same relative
> paths, but this should take care of other configuations.
> 
> The problem arose when using a .bbappend to add files to a recipe in
> another layer. If the layer is located alongside the other layers and
> their parent directory is moved, the hash does not change. However,
> moving the .bbappend layer outside of the common directory can change
> the path sort order and the task hash.
> 
> Signed-off-by: Tyler Hall <tylerwhall@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Good catch, merged to master, thanks.

Richard



