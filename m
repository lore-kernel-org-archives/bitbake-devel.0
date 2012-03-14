Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S7y97-0000pK-Sg
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 01:02:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id 4539D315A189;
	Thu, 15 Mar 2012 00:53:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id uo3m37MBGF0G; Thu, 15 Mar 2012 00:53:28 +0100 (CET)
Received: from [172.22.22.61] (drms-590ecefe.pool.mediaWays.net
	[89.14.206.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id 5D449315A180;
	Thu, 15 Mar 2012 00:53:28 +0100 (CET)
Message-ID: <4F612F77.5040303@opendreambox.org>
Date: Thu, 15 Mar 2012 00:53:27 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Martin Jansa <martin.jansa@gmail.com>
References: <4F610F03.1070201@opendreambox.org>
	<20120314225418.GB3823@jama.jama.net>
In-Reply-To: <20120314225418.GB3823@jama.jama.net>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: PREFERRED_VERSION and wildcards
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
X-List-Received-Date: Thu, 15 Mar 2012 00:02:21 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 14.03.2012 23:54, Martin Jansa wrote:
> On Wed, Mar 14, 2012 at 10:34:59PM +0100, Andreas Oberritter wrote:
>> Hi,
>>
>> I just tried using wildcards, like it's done for gcc, e.g.:
>>
>> PREFERRED_VERSION_foo = "1.2%"
>>
>> Now, if I have two foo recipes, foo_1.2.1.bb and foo_1.2.3.bb, in the
>> same directory, then Bitbake always chooses 1.2.1 instead of the one
>> with the higher version number. Does bitbake always choose the first
>> matching version it can find? Is this a general limitation of wildcards,
>> or is this a problem that can get corrected? I'd expect it to choose the
>> highest matching version.
> 
> If you want highest then why do you specify P_V at all? or are those
> 1.2% foo with e.g. negative D_P? or is there 1.3 you don't want?

Yes, I'd like to prefer 1.2.x over higher versions, say 1.3.x, which
coexist in the same directory, i.e. prefer stable over development versions.

> It will use first provider which matches (in highest usable prio/D_P group).
> 
>     sortpkg_pn = sortPriorities(pn, dataCache, pkg_pn)
>     # Find the highest priority provider with a PREFERRED_VERSION set
>     (preferred_ver, preferred_file) = findPreferredProvider(pn, cfgData, dataCache, sortpkg_pn, item)
>     # Find the latest version of the highest priority provider
>     (latest, latest_f) = findLatestProvider(pn, cfgData, dataCache, sortpkg_pn[0])
> 
>     if preferred_file is None:
>         preferred_file = latest_f
>         preferred_ver = latest
> 
> It was added mostly to cover use case with e.g. 1.2+svnr1337 or 1.2+gitrCAFEBABE where 
> you don't care about exact revision, but you know that you want 1.2 from scm (and there
> is just one which matches).

I see. I must admit that I don't really understand how the code quoted
above works.

> See this thread for details:
> http://lists.linuxtogo.org/pipermail/bitbake-devel/2009-September/000458.html

OK, Now I understand the original intention, but its behaviour doesn't
seem to be what you'd intuitively expect. Well, at least not what I'd
expect. Would it be hard to extend the code to find the highest matching
version instead of the first one? This wouldn't have negative effects on
your use case.

Regards,
Andreas


