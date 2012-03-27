Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SCbUg-0005wD-Gs
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:51:46 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 27 Mar 2012 11:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146420703"
Received: from unknown (HELO [10.255.12.96]) ([10.255.12.96])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2012 11:42:37 -0700
Message-ID: <4F720A1D.5080006@linux.intel.com>
Date: Tue, 27 Mar 2012 11:42:37 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120316 Thunderbird/11.0
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AFB733@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AFB733@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/4] More Hob tweaks
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
X-List-Received-Date: Tue, 27 Mar 2012 18:51:46 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/03/12 07:14, Wang, Shane wrote:
> ACK.
>
> But I also persist in my opinion for the fix that there would be only one button "Close" for layer dialog;-)

You mean the using Cancel/Save on the layer dialogue? It seems there's a 
consensus for that approach and I'm planning on submitting a follow on.

I'm hoping to only submit small patches with minor tweaks now that we're 
in the stabilisation phase and the dialogue buttons patch was getting 
large enough that I would like to see it merged asap and not have to 
churn on it any more.

Thanks for the ack, expect more patches in a few hours.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


