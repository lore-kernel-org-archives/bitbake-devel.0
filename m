Return-Path: <scott.m.rifenbark@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 21CCA60425
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jun 2014 12:31:15 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 26 Jun 2014 05:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,553,1400050800"; d="scan'208";a="563831191"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 26 Jun 2014 05:31:16 -0700
Received: from [10.254.114.187] (unknown [10.254.114.187])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id D55846A4007
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jun 2014 05:30:45 -0700 (PDT)
Message-ID: <53AC1290.8000302@linux.intel.com>
Date: Thu, 26 Jun 2014 05:31:12 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@linux.intel.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <alpine.LFD.2.11.1406191359260.15868@localhost>
In-Reply-To: <alpine.LFD.2.11.1406191359260.15868@localhost>
Subject: Re: couple observations on sync'ing up bitbake user manual and git.py fetcher
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
X-List-Received-Date: Thu, 26 Jun 2014 12:31:17 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


On 6/19/2014 11:03 AM, Robert P. J. Day wrote:
>    short observations someone higher up the food chain is welcome to
> resolve:
>
>    in this section:
>
> http://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.html#git-fetcher
>
> explanation of "tag" parameter refers to "revision" parameter, should
> be just "rev" parameter, no?

Correct.. I fixed this in the documentation.

>
>    and in git.py fetcher file itself, in the early self-contained
> documemntation, there is no mention of any of the "rev", "subpath" or
> "destsuffix" parameters.
>
>    that's it for now.
>
> rday
>


