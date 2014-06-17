Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 33E546FFBA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jun 2014 14:16:15 +0000 (UTC)
Received: from [69.196.158.250] (port=47898 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WwuBM-0007HJ-5g for bitbake-devel@lists.openembedded.org;
	Tue, 17 Jun 2014 10:16:16 -0400
Date: Tue, 17 Jun 2014 10:12:42 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406170936190.619@localhost>
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
Subject: some questions about bitbake user manual, fetching chapter
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
X-List-Received-Date: Tue, 17 Jun 2014 14:16:25 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  working my way thru the fetching chapter, some questions:

* manual doesn't explain what happens if you don't supply *both*
checksums for downloading -- what if you supply only one? or both
and one is correct while the other is incorrect? i think this would
be useful info for the reader.

* right now, manual says FILESDIR is still "deprecated". is it just
deprecated, or is it at the point where it can be killed outright?
currently, there's nothing in the entire poky checkout that uses it.
have people been given sufficient warning at this point?

* i asked about this a long time ago -- in section 4.3.1 (local file
fetcher), there's an alleged sample line:

 SRC_URI = "file://relativefile.patch;this=ignored"

"this=ignored"? can that be replaced by, say, a sample line involving
"apply=yes" or "apply=no"? or any other relevant examples?

  i think that's it for now.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


