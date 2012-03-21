Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAOAU-0003LL-7H
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 17:13:46 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 Mar 2012 09:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123451695"
Received: from unknown (HELO [10.255.15.222]) ([10.255.15.222])
	by orsmga002.jf.intel.com with ESMTP; 21 Mar 2012 09:04:51 -0700
Message-ID: <4F69FC23.2060406@linux.intel.com>
Date: Wed, 21 Mar 2012 09:04:51 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
	<f7d9682327566ed5ad589ef450ef9bfdbe876bdd.1332288516.git.josh@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AF3482@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AF3482@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 5/5] ui/crumbs/persistenttooltip: fix whitespace
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
X-List-Received-Date: Wed, 21 Mar 2012 16:13:46 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/12 20:49, Wang, Shane wrote:
> Joshua Lock wrote on 2012-03-21:
>
>> We use 4 spaces, not a tab, in BitBake
>>
>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
>
> What's wrong with persistenttooltip.py?

Nothing that we aren't already tracking in Bugzilla - this change just 
sets the indentation to match the rest of BitBake.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


