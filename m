Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TvXXS-0001aK-Sh
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 Jan 2013 19:16:39 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r0GI1BTK020930
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 16 Jan 2013 10:01:12 -0800 (PST)
Received: from e6410-2 (172.25.40.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Wed, 16 Jan 2013 10:01:11 -0800
Date: Wed, 16 Jan 2013 12:01:04 -0600
From: Peter Seebach <peter.seebach@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20130116120104.1d40cced@e6410-2>
In-Reply-To: <1358358898.24249.8.camel@ted>
References: <cover.1357954043.git.peter.seebach@windriver.com>
	<1358358898.24249.8.camel@ted>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Variable tracking: Cleaned up and rebased.
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
X-List-Received-Date: Wed, 16 Jan 2013 18:16:40 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Wed, 16 Jan 2013 17:54:58 +0000
Richard Purdie <richard.purdie@linuxfoundation.org> wrote:

> I *really* want to take these, however I did want to check
> performance:

Oh, good thought.

> $ time bitbake core-image-sato -e
> real	0m8.034s
> $ time bitbake -p
> real	0m12.220s
> user	3m3.887s
 
> After:
 
> $ time bitbake core-image-sato -e
> real	0m50.267s
> $ time bitbake -p
> real	0m14.607s
> user	3m55.179s

Hmm. That doesn't totally surprise me.
 
> The 50s seems a touch excessive and it looks like a 20% parsing hit
> even when unused :(. Note the overall parsing times on this machine
> are fast as its running 24 in parallel. I'm going to try and figure
> out what is going on tomorrow as I've fixed a lot of this kind of
> thing in the past but wanted to mention it...

The 50s seems... not entirely surprsing. I don't know that much about
how Python does stuff, but in practice we end up with a LOT of deep
copies of structures floating around because there are a ton of data
copies; without these, finalize information gets duplicated and things
go pretty wrong.

My intuition is that the stack backtrace thing is probably expensive,
and might be noticably reduced by manually passing in the
likely-missing values in cases where we know what they are, so it's
less likely that any backtracing has to happen.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.


