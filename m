Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TphUb-0003Uh-1j
	for bitbake-devel@lists.openembedded.org;
	Mon, 31 Dec 2012 16:41:33 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:47324 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1TphG6-0008Qo-58; Mon, 31 Dec 2012 10:26:34 -0500
Date: Mon, 31 Dec 2012 10:26:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANm8E7MH7-RvA+ds=4w2k=9=3bhO52mFMZzVJHoP_A1b=g@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1212311025590.960@oneiric>
References: <alpine.DEB.2.02.1212301734450.20153@oneiric>
	<CABcZANmbHgbDak8-1AMinmzXp=xcqagu2kEkrkrbPsFzmo3=vQ@mail.gmail.com>
	<alpine.DEB.2.02.1212301949001.21512@oneiric>
	<CABcZANm8E7MH7-RvA+ds=4w2k=9=3bhO52mFMZzVJHoP_A1b=g@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: what means "this=ignored" in the context of SRC_URI/patch?
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
X-List-Received-Date: Mon, 31 Dec 2012 15:41:33 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1849780844-1356967593=:960"

--8323329-1849780844-1356967593=:960
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 31 Dec 2012, Chris Larson wrote:

> On Sun, Dec 30, 2012 at 5:53 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>       i notice that the value of "apply" is tested *before* the final test
>       for a valid patch suffix of {.patch,.diff}, which leaves open the
>       possibility of something weird or obscure happening there?  i have no
>       idea what that might be, i'm just observing the order of those tests.
>
> No, it just means it always obeys the value of the parameter if set,
> otherwise it goes based on the filename.

  ah, got it.  thanks.  still reading up on my python.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323329-1849780844-1356967593=:960--
