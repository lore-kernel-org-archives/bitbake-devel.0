Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 3301F65CE6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jul 2014 10:05:46 +0000 (UTC)
Received: from [69.196.158.250] (port=44177 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X5BEY-00038X-C0; Thu, 10 Jul 2014 06:05:46 -0400
Date: Thu, 10 Jul 2014 06:05:38 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB812B@ORSMSX101.amr.corp.intel.com>
Message-ID: <alpine.LFD.2.11.1407100604260.31336@localhost>
References: <alpine.LFD.2.11.1407090819380.6147@localhost>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB812B@ORSMSX101.amr.corp.intel.com>
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
Subject: Re: [PATCH] Documentation: Add a couple examples to conditional data.
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
X-List-Received-Date: Thu, 10 Jul 2014 10:05:48 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 10 Jul 2014, Rifenbark, Scott M wrote:

> Applied.  I added some wording to call out the examples as being
> OpenEmbedded metadata-based examples.  I am assuming the examples
> were pulled from the poky area.  For the BB manual, we want to try
> to keep the manual isolated as much as possible from YP.  This is
> difficult but that is the intent.

  i know, but every so often, a concept cries out for an actual
example from the code base. i'll try to keep it to a minimum. :-)


> Also, for future patches, I use a 5-space indentation convention for
> any code examples between the <literallayout> and </literallayout>
> tags.

  oh, for some reason, i thought it was four. my apologies.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

