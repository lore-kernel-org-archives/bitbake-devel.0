Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S1izt-0000tG-Kq
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 19:39:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id 5B4F43159688;
	Sun, 26 Feb 2012 19:30:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id J0WvMcTczeyy; Sun, 26 Feb 2012 19:30:31 +0100 (CET)
Received: from [172.22.22.61] (drms-590ed5c2.pool.mediaWays.net
	[89.14.213.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id D683F3159687;
	Sun, 26 Feb 2012 19:30:30 +0100 (CET)
Message-ID: <4F4A7A46.9060104@opendreambox.org>
Date: Sun, 26 Feb 2012 19:30:30 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
References: <4F48217F.6040406@opendreambox.org>
	<1330153006.1957.10.camel@dongxiao-osel>
In-Reply-To: <1330153006.1957.10.camel@dongxiao-osel>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: cache broken in master
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
X-List-Received-Date: Sun, 26 Feb 2012 18:39:01 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Dongxiao,

On 25.02.2012 07:56, Xu, Dongxiao wrote:
> On Sat, 2012-02-25 at 00:47 +0100, Andreas Oberritter wrote:
>> Hi,
>>
>> commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
>> dependency cache for me, i.e. it parses all recipes on every invocation
>> and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache didn't
>> help. Reverting this commit restores the functionality.
> 
> Hi Andreas,
> 
> Sorry for the inconvenience that this commit brought to you.
> 
> Could you help to try the following and send me your "/tmp/1.log
> and /tmp/2.log"?
> 
> 1) apply the attached "cache_debug.patch"
> 2) remove tmp/cache
> 3) bitbake -p &> /tmp/1.log
> 4) bitbake -p &> /tmp/2.log
> 
> Besides, you can have a try of the attached cache_whitelist.patch to see
> if it fixes your problem.

your patch cache_whitelist.patch fixes the problem. Thanks!

Regards,
Andreas


