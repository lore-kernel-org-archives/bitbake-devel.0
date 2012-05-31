Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Sa9je-0004zl-0v
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 May 2012 20:04:34 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 31 May 2012 10:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="106377187"
Received: from shamshir.jf.intel.com (HELO [10.24.157.181]) ([10.24.157.181])
	by AZSMGA002.ch.intel.com with ESMTP; 31 May 2012 10:54:12 -0700
Message-ID: <4FC7B040.4050106@linux.intel.com>
Date: Thu, 31 May 2012 10:54:08 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: McClintock Matthew-B29882 <B29882@freescale.com>
References: <cover.1326686612.git.lianhao.lu@intel.com>
	<554ae4c9ee0ac70254c6ca6a5ba44db844cf86b3.1326686612.git.lianhao.lu@intel.com>
	<CAEsOVNeBNFH6KbbCUHqEhEjx0dGwzeZ2qCiRc6UirbE_X=1yfQ@mail.gmail.com>
In-Reply-To: <CAEsOVNeBNFH6KbbCUHqEhEjx0dGwzeZ2qCiRc6UirbE_X=1yfQ@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake/persist_data: Reconnect when DB is locked
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
X-List-Received-Date: Thu, 31 May 2012 18:04:34 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 30/05/12 17:33, McClintock Matthew-B29882 wrote:
> This needs to be in edison-next. It cherry-pick's cleanly as an added
> plus (doing more testing now). Seems like it's already in denzil-next

cherry-picked to my josh/edison branch on poky-contrib - I will try and 
ensure it makes it into the edison branch of the main repository promptly.

Cheers,
Joshua
-- 
Joshua Lock
         Yocto Project
         Intel Open Source Technology Centre


