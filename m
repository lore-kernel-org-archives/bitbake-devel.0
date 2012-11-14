Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TYeLu-0006Ay-FY for bitbake-devel@lists.openembedded.org;
	Wed, 14 Nov 2012 15:54:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAEEe8Aw020665;
	Wed, 14 Nov 2012 14:40:08 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20196-03; Wed, 14 Nov 2012 14:40:02 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAEEe0lR020648
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Nov 2012 14:40:00 GMT
Message-ID: <1352904000.15477.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Date: Wed, 14 Nov 2012 14:40:00 +0000
In-Reply-To: <1352833970-22315-1-git-send-email-kergoth@gmail.com>
References: <1352833970-22315-1-git-send-email-kergoth@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Christopher Larson <chris_larson@mentor.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] knotty: kill duplicated import of 'time'
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
X-List-Received-Date: Wed, 14 Nov 2012 14:54:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-11-13 at 12:12 -0700, Christopher Larson wrote:
> From: Christopher Larson <chris_larson@mentor.com>
> 
> The duplicated import could result in an UnboundLocalError.
> 
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/ui/knotty.py | 1 -
>  1 file changed, 1 deletion(-)

Merged to master, thanks.

Richard



