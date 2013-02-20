Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U847D-0002dP-Gj for bitbake-devel@lists.openembedded.org;
	Wed, 20 Feb 2013 08:29:19 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1K7JZGL011339; Wed, 20 Feb 2013 07:19:35 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jqU7ob+CjDIW; Wed, 20 Feb 2013 07:19:35 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1K7J6xo011307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Wed, 20 Feb 2013 07:19:26 GMT
Message-ID: <1361344340.13247.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Tue, 19 Feb 2013 23:12:20 -0800
In-Reply-To: <1359445811-6394-5-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
	<1359445811-6394-5-git-send-email-olof.johansson@axis.com>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2 4/6] fetch2: Adapt encode/decode url to use URI class
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
X-List-Received-Date: Wed, 20 Feb 2013 07:29:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-01-29 at 08:50 +0100, Olof Johansson wrote:
> Signed-off-by: Olof Johansson <olof.johansson@axis.com>
> ---
>  lib/bb/fetch2/__init__.py |   66 ++++++++++++---------------------------------
>  1 file changed, 17 insertions(+), 49 deletions(-)

I've had to revert this since it simply doesn't work. bitbake-selftest
fails all the tests with this applied, we also saw multiple failures in
other places where things should work :(

Cheers,

Richard



