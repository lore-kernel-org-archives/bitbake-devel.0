Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7XSX-0001Di-Gk
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Mar 2012 20:32:37 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Mar 2012 12:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128575524"
Received: from unknown (HELO [10.255.15.212]) ([10.255.15.212])
	by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2012 12:23:52 -0700
Message-ID: <4F5F9EC7.3040006@linux.intel.com>
Date: Tue, 13 Mar 2012 12:23:51 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: Oren Leaffer <oren@ephemeron-labs.com>
References: <cover.1331558220.git.shane.wang@intel.com>
	<a5a40bda286914ab82e99d22da1e39e63ccace31.1331558221.git.shane.wang@intel.com>
	<4F5F8D0F.4010607@linux.intel.com>
	<CALvD2LhvZB_ESbLp9s6Xa0w0WcEJWUG4v1gkh5sSYbfKBYBGEA@mail.gmail.com>
In-Reply-To: <CALvD2LhvZB_ESbLp9s6Xa0w0WcEJWUG4v1gkh5sSYbfKBYBGEA@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] Hob: implement a self-defined notebook visual component for Hob
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
X-List-Received-Date: Tue, 13 Mar 2012 19:32:37 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/03/12 12:08, Oren Leaffer wrote:
>> 1) We're doing the range dance rather than just doing the Pythonic thing and
>> iterating over the sequence with "for x in y".
>> http://python.net/~goodger/projects/pycon/2007/idiomatic/handout.html#use-in-where-possible-1
>>
>> I understand its desirable to have the index in some places, but where it
>> isn't we should use the standard pattern. This is good coding practice.
>
> I think I pointed it out before, but it was on a Friday, so I might as
> well repeat -
>
> If you need the index you can replace something like this:
>    for i in range(len(self.children)): # ugly
> With:
>    for i,child in enumerate(self.children): # less ugly!

Indeed, I'd be happy to see more of that.

Thanks for pointing that out Oren!

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


