Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ryx48-0002yl-Lh; Sun, 19 Feb 2012 04:03:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1J2tedU019776;
	Sun, 19 Feb 2012 02:55:40 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18864-02; Sun, 19 Feb 2012 02:55:36 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1J2tTPl019770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 19 Feb 2012 02:55:32 GMT
Message-ID: <1329620128.7006.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 19 Feb 2012 02:55:28 +0000
In-Reply-To: <1329608182.4436.48.camel@ted>
References: <1329608182.4436.48.camel@ted>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: Bitbake Memory Usage
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
X-List-Received-Date: Sun, 19 Feb 2012 03:03:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-02-18 at 23:36 +0000, Richard Purdie wrote:
> I was looking at our process with top and sadly, this shows zero change
> in bitbake memory usage, with it being stable at 206M. What is worth
> noting is I've seen instability and had problems reproducing numbers in
> the past. It now appears the first time you edit any of bitbake's .py
> files and run it, you will get a higher memory usage (say 267M). The
> second time you run bitbake having changed none of its .py files, the
> usage will go back down. I can only assume there is some overhead in
> creating the .pyc files and this pushes the memory usage up. I'd like to
> understand that problem further.

For reference, only VSS increases and RSS does not in this case so it
looks like there are leftover memory mappings.

> So we got rid of about half the objects from memory and nearly halved
> the memory consumption. Seems a shame the overall memory usage therefore
> didn't change then? :/.

> So in summary, our fork() execution model may have some scary looking
> memory numbers but in reality the overhead is good with CoW. There are
> some puzzles remaining about how/when we can cooerce python to give
> memory back to the system. We should also look at the memory hogging
> variables identified and see if we can't do something better with them
> in the core.
> 
> I'm going to continue to look at this when I have time but I hope this
> reassures some people about the fork() overhead and enthuses some people
> to further look around bitbake's memory usage.

Digging a little deeper, it was mainly strings that we were making the
saving with. I checked and the allocator for string objects in python
will return them to the main python objector allocator, maintaining only
a small queue of 80 objects for reuse. For objects over 256 bytes in
size, the glibc malloc/free calls are used. In turn, glibc uses sbrk()
to change the data segment size if necessary for anything less that
128kb in size. The string in the caches in question are very likely to
be over 256 bytes in size but under 128kb.

The problem is then going to be memory fragmentation since whilst we can
free the memory used by the objects, its extremely unlikely everything
to the end of the data segment is likely to be free so sbrk() cannot be
rolled backwards to free memory.

So in summary its unlikely we're going to get freed memory back with
python for these kinds of caches, at least from the main server
process...

Cheers,

Richard



