Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1Tq86u-0008DW-4g
	for bitbake-devel@lists.openembedded.org;
	Tue, 01 Jan 2013 21:06:52 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([174.115.5.73]:37991 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tq7sN-0005Cd-R8; Tue, 01 Jan 2013 14:51:51 -0500
Date: Tue, 1 Jan 2013 14:51:50 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANmLcgOzqOCUrGmeFMeM=GAg5jFm7+t-opF7uxZ43c0m=A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301011448360.21012@oneiric>
References: <alpine.DEB.2.02.1301010855180.18858@oneiric>
	<CABcZANmLcgOzqOCUrGmeFMeM=GAg5jFm7+t-opF7uxZ43c0m=A@mail.gmail.com>
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
Subject: Re: still confused about _append and OVERRIDES and = and +=, argh
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
X-List-Received-Date: Tue, 01 Jan 2013 20:06:52 -0000
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1612932357-1357069910=:21012"

--8323329-1612932357-1357069910=:21012
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 1 Jan 2013, Chris Larson wrote:

>
>
> On Tue, Jan 1, 2013 at 7:12 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>         again, so far, so good -- the second override superseded the first,
>       correct?
>
>               test 4:
>
>       BLAH = "A"
>       BLAH_rday = "B"
>       BLAH_rday_append = "C"
>
>       $ bitbake-env BLAH
>       BLAH="B"
>       $
>
>          ?????  that confuses me.  according to section 2.2.1 in bitbake
>       manual (very first example): 
>
>
>       OVERRIDES = "foo"
>
>       A_foo_append = "X"
>
>       "In this case, X is unconditionally appended to the variable A_foo.
>       Since foo is an override, A_foo would then replace A."
>
>       according to that, i should expect BLAH to have the value "BC", no?
>
>
> Yeah, as far as I'm aware that's what should have happened, but as
> you noticed, this form is extremely unusual.

  now that i look at it, i don't think i know of *any* usage of the
form VAR_<override>_append.  is it actually used anywhere?  if not,
i'm just going to omit talking about it in future classes.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323329-1612932357-1357069910=:21012--
