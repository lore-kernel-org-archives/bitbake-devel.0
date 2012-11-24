Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TcH9P-0006vb-Cm
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Nov 2012 15:56:11 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:36546 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1TcGvj-0007TX-RJ for bitbake-devel@lists.openembedded.org;
	Sat, 24 Nov 2012 09:42:03 -0500
Date: Sat, 24 Nov 2012 09:42:01 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
In-Reply-To: <alpine.DEB.2.02.1211240910580.934@oneiric>
Message-ID: <alpine.DEB.2.02.1211240938390.1166@oneiric>
References: <alpine.DEB.2.02.1211240910580.934@oneiric>
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
Subject: Re: wanting clarification on overrides, _append, += and combinations of those
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
X-List-Received-Date: Sat, 24 Nov 2012 14:56:11 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  one more question, if i might ...

On Sat, 24 Nov 2012, Robert P. J. Day wrote:

> RDEPENDS_python-smartpm_append = " python-smartpm-backend-rpm python-codecs python-textutils python-xml"
> RDEPENDS_python-smartpm_append += " python-fcntl python-pickle python-crypt python-compression python-shell"
> RDEPENDS_python-smartpm_append += " python-resource python-netclient python-threading python-unixadmin"

  is there a reason the above couldn't have been written as something
like:

RDEPENDS_python-smartpm += "python-fcntl python-pickle python-crypt python-compression python-shell"
RDEPENDS_python-smartpm += "python-resource python-netclient python-threading python-unixadmin"

  as i understand it, the purpose of "_append" is to give the
developer control over being able to append something at the very end
of the processing -- in other words, it's used when ordering is
important.

  but is there any ordering issue when simply creating the value of
RDEPENDS?  does it matter how the items are ordered there?  if not,
then using "_append" seems like overkill.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================



