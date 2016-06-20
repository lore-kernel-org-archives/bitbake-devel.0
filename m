Return-Path: <maxin.john@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BD141731C4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 13:13:36 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Jun 2016 06:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="979616935"
Received: from mbabyjoh-desk.fi.intel.com (HELO
	mbabyjoh-desk.ger.corp.intel.com) ([10.237.72.71])
	by orsmga001.jf.intel.com with ESMTP; 20 Jun 2016 06:13:19 -0700
Date: Mon, 20 Jun 2016 16:13:20 +0300
From: "Maxin B. John" <maxin.john@intel.com>
To: Jussi Kukkonen <jussi.kukkonen@intel.com>
Message-ID: <20160620131319.GA5297@mbabyjoh-desk.ger.corp.intel.com>
References: <cover.1466424068.git.jussi.kukkonen@intel.com>
MIME-Version: 1.0
In-Reply-To: <cover.1466424068.git.jussi.kukkonen@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCHv2 0/1] depexp.py: port to gtk+3
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
X-List-Received-Date: Mon, 20 Jun 2016 13:13:38 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jussi,

On Mon, Jun 20, 2016 at 03:19:51PM +0300, Jussi Kukkonen wrote:
> This is based on Maxins patch from June 17th.
> 
> Changes since v1:
> * Bring back the progress bar
> * Call Gtk.init_check() in the correct thread
> * Handle Gtk.init_check() return value properly
> 

Thanks for fixing it properly. Works fine now.

Tested-by: Maxin B. John <maxin.john@intel.com>

> Jussi
> 
> 
> The following changes since commit 09d08340fe0fca6f551c33d2fdcafb72f52812d2:
> 
>   Revert "cmake.bbclass: set the modules directory correctly" (2016-06-20 08:40:21 +0100)
> 
> are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib jku/depexp
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=jku/depexp
> 
> Jussi Kukkonen (1):
>   bitbake: depexp.py: port to gtk+3
> 
>  bitbake/lib/bb/ui/depexp.py | 159 ++++++++++++++++++++++----------------------
>  1 file changed, 80 insertions(+), 79 deletions(-)

Best Regards,
Maxin

