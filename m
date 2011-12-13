Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RaagW-0002O3-8j
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 23:18:52 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 13 Dec 2011 14:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="101851605"
Received: from unknown (HELO [10.255.12.215]) ([10.255.12.215])
	by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2011 14:11:55 -0800
Message-ID: <4EE7CDAB.2050509@linux.intel.com>
Date: Tue, 13 Dec 2011 14:11:55 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:8.0) Gecko/20111115 Thunderbird/8.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <20111206100603.GB5456@jama.jama.net>
In-Reply-To: <20111206100603.GB5456@jama.jama.net>
Subject: Re: [PATCH] fetch2: fix Exception parameters when BB_STRICT_CHECKSUM enabled
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
X-List-Received-Date: Tue, 13 Dec 2011 22:18:52 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 06/12/11 02:06, Martin Jansa wrote:
> With today's master I'm still getting rather long error message when just checksums are wrong.
> Do I have something wrong in my configuration?

You don't, for better or worse BitBake appears to dump the tasks log
when the task fails. Unfortunately this means we usually have to scroll
back to see the suggestion of how to rectify the issue.

> 
> NOTE: Running task 1 of 12 (ID: 4, openembedded-core/meta/recipes-devtools/subversion/subversion_1.7.2.bb, do_fetch)
> NOTE: package subversion-1.7.2-r0: task do_fetch: Started
> WARNING: Fetcher failure for URL: 'http://archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2'. Checksum mismatch!
> File: '/OE/shr-core/downloads/subversion-1.7.2.tar.bz2' has md5 checksum 1e5dfffd27be080672e5a042564368a8 when 8a4fa74385df85a9702141b6b68b8307 was expected (from URL: 'http://archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2')
> File: '/OE/shr-core/downloads/subversion-1.7.2.tar.bz2' has sha256 checksum 7eb3e1ae2b0385e1cc20ca9e1839e0ef0ac98a7455dc52ba4cdf567547bfc517 when d34bde626fac1aa553f5c9aeedf961999a77cc31540ace18da5aeacdd03d6608 was expected (from URL: 'h
> ttp://archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2')
> ERROR: Function 'Fetcher failure for URL: 'http://archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2'. Unable to fetch URL http://archive.apache.org/dist/subversion/subversion-1.7.2.tar.bz2 from any source.' failed
> ERROR: Logfile of failure stored in: /OE/shr-core/tmp-eglibc/work/armv5te-oe-linux-gnueabi/subversion-1.7.2-r0/temp/log.do_fetch.17472
> Log data follows:
<snip>
> NOTE: package subversion-1.7.2-r0: task do_fetch: Failed
> ERROR: Task 4 (openembedded-core/meta/recipes-devtools/subversion/subversion_1.7.2.bb, do_fetch) failed with exit code '1'
> ERROR: 'openembedded-core/meta/recipes-devtools/subversion/subversion_1.7.2.bb' failed

I agree this is a rather obnoxious error, it'll be a few days or so
before I get round to looking at it so I filed a bug to ensure it
doesn't get forgotten.

http://bugzilla.pokylinux.org/show_bug.cgi?id=1832

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre


