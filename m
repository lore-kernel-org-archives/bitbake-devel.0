Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id C5D9570101
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 16:01:23 +0000 (UTC)
Received: from [69.196.158.250] (port=40012 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxIId-0002xs-5f; Wed, 18 Jun 2014 12:01:23 -0400
Date: Wed, 18 Jun 2014 11:57:40 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1403106727.2104.72.camel@ted>
Message-ID: <alpine.LFD.2.11.1406181156520.29963@localhost>
References: <alpine.LFD.2.11.1406181120030.29194@localhost>
	<1403106727.2104.72.camel@ted>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
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
Subject: Re: [PATCH] bitbake-user-manual-execution.xml: Update parallelization note.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 18 Jun 2014 16:01:25 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 18 Jun 2014, Richard Purdie wrote:

> On Wed, 2014-06-18 at 11:22 -0400, Robert P. J. Day wrote:
> > Update the note to explain that current versions of BitBake
> > automatically calculate the proper values for BB_NUMBER_THREADS
>
> The current version of bitbake doesn't though.
>
> There is an *OE* helper function which the default local.conf files use.

  ack, you're right, i was just looking at my generated local.conf
file and assuming those values were coming from bitbake. my mistake.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

