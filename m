Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U3bam-00072B-3G for bitbake-devel@lists.openembedded.org;
	Fri, 08 Feb 2013 01:13:33 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1802uGA009379; Fri, 8 Feb 2013 00:02:57 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c-WtWp4AZK-t; Fri,  8 Feb 2013 00:02:56 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1802nP7009374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 8 Feb 2013 00:02:52 GMT
Message-ID: <1360281435.10722.69.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 07 Feb 2013 23:57:15 +0000
In-Reply-To: <20130206233031.GG3271@jama>
References: <20130206233031.GG3271@jama>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake cache broken today
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
X-List-Received-Date: Fri, 08 Feb 2013 00:13:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-02-07 at 00:30 +0100, Martin Jansa wrote:
> Very likely by this patch:
> cooker/utils: Drop custom 'interactive' variables list and store environment in BB_ORIGENV instead
> http://git.openembedded.org/bitbake/commit/?id=0a99563a4ea270594fd9a61da46f9387fb79dc66
> 
> $ bitbake -p > test1.cache
> $ bitbake -p > test2.cache
> 
> $ grep "^Parsing of" test*
> test1.cache:Parsing of 773 .bb files complete (0 cached, 773 parsed). 1079 targets, 43 skipped, 0 masked, 0 errors.
> test2.cache:Parsing of 773 .bb files complete (0 cached, 773 parsed). 1079 targets, 43 skipped, 0 masked, 0 errors.

Thanks for reporting, this is fixed in master of OE-Core. We've been
able to spring clean some of the environment handling although we still
have too many hard-coded lists for my liking.

Cheers,

Richard



