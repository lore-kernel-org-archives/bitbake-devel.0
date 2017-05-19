Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 630FD77F22
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 May 2017 10:11:31 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2017 03:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,363,1491289200"; d="scan'208";a="858998838"
Received: from kanavin-desktop.fi.intel.com (HELO [10.237.68.161])
	([10.237.68.161])
	by FMSMGA003.fm.intel.com with ESMTP; 19 May 2017 03:11:31 -0700
To: Alan Levy <alan.levy@plextek.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <76e10e401a174bdca9f6a65acafbff5e@PLEXTEK-EXCH1.plextek.lan>
	<1495187311.27342.149.camel@linuxfoundation.org>
	<ef364375f4c24847ae8d5b64b1905700@PLEXTEK-EXCH1.plextek.lan>
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Message-ID: <225ccc08-9962-d92a-309a-dd9c14417928@linux.intel.com>
Date: Fri, 19 May 2017 13:09:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <ef364375f4c24847ae8d5b64b1905700@PLEXTEK-EXCH1.plextek.lan>
Subject: Re: Problem using Subversion in Pyro
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
X-List-Received-Date: Fri, 19 May 2017 10:11:32 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/19/2017 12:57 PM, Alan Levy wrote:

> I can see that you don't want to force the host system to support
> subversion and I concur that the resulting error message is
> unhelpful.
>
> However under Morty this worked just fine so Pyro breaks existing
> recipes in a way that's very hard to understand, even if the solution
> is easy once you know how.  I would suggest that as well as providing
> a helpful error message the documentation should also explain what's
> going on and how to fix it.

Alan, may I suggest that you write the necessary patches for this and 
send them in?

Thanks,
Alex

