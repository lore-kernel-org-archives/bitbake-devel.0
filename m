Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3dKB-0006G5-3a
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:59:51 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="117151603"
Received: from unknown (HELO [10.255.15.107]) ([10.255.15.107])
	by orsmga002.jf.intel.com with ESMTP; 02 Mar 2012 16:51:18 -0800
Message-ID: <4F516B04.3050501@linux.intel.com>
Date: Fri, 02 Mar 2012 16:51:16 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1330734444.git.josh@linux.intel.com>
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
Subject: Re: [PATCH 0/6] Hob GUI add persistent tooltips and use custom info icon consistently
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
X-List-Received-Date: Sat, 03 Mar 2012 00:59:51 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Whoops. Forgot to hit save in my editor before sending... The message 
should be:

The following series addresses some issues I've raised with the Hob 
implementation.
Firstly it introduces two new widgets, a generic PersistentTooltip 
widget which is an implementation of a tooltip like widget that persists 
until the user explicitly dismisses it, this matches the Hob interaction 
design more closely.
The second widget is a button-like widget using the info icon from the 
visual design which, when clicked, will display a persistent tooltip.

The series then replaces all known instances of a gtk.Image containing 
the stock info item plus a standard tooltip with the new HobInfoButton.

The final patch, to ensure consistency, special cases the stock info 
icon in the CrumbsMesssageDialog so that any dialogues which show an 
info icon will display the custom icon per the visual design.

Cheers,
Joshua

Note: this is attempt two at sending this follow on, attempt one is 
stuck awaiting moderation as I tried to include screenshots....

On 02/03/12 16:39, Joshua Lock wrote:
> asldlasjd
>
> The following changes since commit 4a480a052f450c4ee061ab0e60a495a45f140cf9:
>
>    stderr would previously be appended to stdout, corrupting the result when something was outputed to stderr but exit code was still 0 (non-fatal warning messages). This commit makes the code parse only stdout, but output stderr if an error happened. (2012-03-02 16:17:43 +0000)
>
> are available in the git repository at:
>    git://github.com/incandescant/bitbake josh/hob
>    https://github.com/incandescant/bitbake/tree/josh/hob
>
> and as a poky repository at:
>    git://git.yoctoproject.org/poky-contrib josh/hob
>    http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob
>
> Joshua Lock (6):
>    crumbs/persistenttooltip: a new Gtk+ widget for use in Hob
>    ui/icons: crop the info icons
>    ui/crumbs/hobwidget: implement HobInfoButton per Hob interaction
>      design
>    ui/crumbs/imageconfigurationpage: make use of the HobInfoButton
>    ui/crumbs/hig: use HobInfoButton in place of gtk.Image with tooltip
>    ui/crumbs/hig: special case stock info icons in CrumbsMesssageDialog
>
>   lib/bb/ui/crumbs/hig.py                    |   52 +++++-------
>   lib/bb/ui/crumbs/hobwidget.py              |   49 +++++++++++
>   lib/bb/ui/crumbs/imageconfigurationpage.py |   12 +--
>   lib/bb/ui/crumbs/persistenttooltip.py      |  127 ++++++++++++++++++++++++++++
>   lib/bb/ui/icons/info/info_display.png      |  Bin 4760 ->  4558 bytes
>   lib/bb/ui/icons/info/info_hover.png        |  Bin 4847 ->  4650 bytes
>   6 files changed, 200 insertions(+), 40 deletions(-)
>   create mode 100644 lib/bb/ui/crumbs/persistenttooltip.py
>

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


