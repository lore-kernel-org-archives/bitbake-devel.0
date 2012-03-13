Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7WKx-0008L8-3U
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Mar 2012 19:20:43 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 13 Mar 2012 11:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="117340689"
Received: from unknown (HELO [10.255.15.212]) ([10.255.15.212])
	by orsmga001.jf.intel.com with ESMTP; 13 Mar 2012 11:10:36 -0700
Message-ID: <4F5F8D9C.3020007@linux.intel.com>
Date: Tue, 13 Mar 2012 11:10:36 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331558220.git.shane.wang@intel.com>
In-Reply-To: <cover.1331558220.git.shane.wang@intel.com>
Subject: Re: [PATCH 0/3][V2] Hob Notebook Implementation
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
X-List-Received-Date: Tue, 13 Mar 2012 18:20:43 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/12 06:23, Shane Wang wrote:
> This patchset is to implement Hob self-defined notebook, and use it in the build details page.

I have raised some concerns with the implementation of this series on 
each of the patches. It may seem nit-picky but we really do need to 
start paying attention to the details at this point and polishing the 
functionality and work-flow of the new Hob.

I'm torn on the series. As it stands we see errors each time we use Hob 
in master as the standard Gtk notebook doesn't support some of the API 
in the Hob notebook that is being called - errors look bad.

However this series has some poor coding style and doesn't match the 
visual design - these also look bad, though arguably less so.

I don't mind whether we merge this and iterate on the implementation or 
hold on merging until we fix the implementation but I feel we need to 
address the issues.

What are others thoughts?

Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


