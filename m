Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THGQz-0000lj-7b for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 17:55:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFgYow032753;
	Thu, 27 Sep 2012 16:42:34 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32587-02; Thu, 27 Sep 2012 16:42:24 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFgMag032741
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 16:42:24 +0100
Message-ID: <1348760543.11186.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Thu, 27 Sep 2012 16:42:23 +0100
In-Reply-To: <1348582637-31533-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1348582637-31533-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] lib/bb/data.py: improve output for expansion errors
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
X-List-Received-Date: Thu, 27 Sep 2012 15:55:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-09-25 at 15:17 +0100, Paul Eggleton wrote:
> Instead of logging the function/variable separately as a NOTE when
> failing to expand, re-raise ExpansionError with more contextual
> information. This means that the full details are reported in Hob as
> well as actually reporting the original error message in any UI where
> we previously did not. For example, we used to get this with tab/space
> indentation issues in a python function:
> 
> NOTE: Error expanding variable populate_packages
> ERROR: Unable to parse /path/to/recipename.bb
> 
> Now, we will get this:
> 
> ERROR: ExpansionError during parsing /path/to/recipename.bb: Failure
>  expanding variable populate_packages: IndentationError: unindent does
>  not match any outer indentation level (<string>, line 4)
> 
> Fixes [YOCTO #3162].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/data.py       |    5 ++---
>  bitbake/lib/bb/data_smart.py |    5 ++++-
>  2 files changed, 6 insertions(+), 4 deletions(-)

Merged to master, thanks.

Richard



