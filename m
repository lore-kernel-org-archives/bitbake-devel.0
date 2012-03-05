Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S4WyG-0005aS-79
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Mar 2012 13:24:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id C67B831597E2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Mar 2012 13:16:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id QyOW4kfDEYzA for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Mar 2012 13:16:11 +0100 (CET)
Received: from [172.22.22.61] (drms-590cfb45.pool.mediaWays.net [89.12.251.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id E8EDC3159696
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Mar 2012 13:16:10 +0100 (CET)
Message-ID: <4F54AE8A.2070403@opendreambox.org>
Date: Mon, 05 Mar 2012 13:16:10 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1330833563.3949.1.camel@ted>
In-Reply-To: <1330833563.3949.1.camel@ted>
Subject: Re: [PATCH] bitbake: Convert getVar/getVarFlag(xxx, 1) -> (xxx, True)
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
X-List-Received-Date: Mon, 05 Mar 2012 12:24:56 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 04.03.2012 04:59, Richard Purdie wrote:
> Using "1" with getVar is bad coding style and "True" is preferred.

Slightly OT, but wouldn't it be more convenient, especially for external
callers like OE, to make True the default for getVar? This would also
make getVar somehow more symmetric to setVar.

A rough, inexact comparison between usage of True vs. False [1]:

bitbake: 214 times True, 25 times False
openembedded-core: 1143 times True, 49 times False
meta-openembedded: 93 times True, 1 time False

Regards,
Andreas

[1]: Method used to obtain the numbers:
git grep '\<getVar\>\s*([^)]\+,\s*\(True\|1\)\s*)' | wc -l
git grep '\<getVar\>\s*([^)]\+,\s*\(False\|0\)\s*)' | wc -l


