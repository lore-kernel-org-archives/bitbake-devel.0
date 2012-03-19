Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mWk-0007kh-5y
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:02:14 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Mar 2012 16:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141526334"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 16:53:21 -0700
Message-ID: <4F67C6F1.6030302@linux.intel.com>
Date: Mon, 19 Mar 2012 16:53:21 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<acd17e9087460e8e37930d98fc446fde2809e699.1331910234.git.shane.wang@intel.com>
In-Reply-To: <acd17e9087460e8e37930d98fc446fde2809e699.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 11/12] Hob: change HobNoteBook tab edge color from green to gray
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
X-List-Received-Date: Tue, 20 Mar 2012 00:02:14 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 08:10, Shane Wang wrote:
> From: Liming An<limingx.l.an@intel.com>
>
> To change the notebook tab pressed edge color from green to gray.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/hobcolor.py  |    2 ++
>   bitbake/lib/bb/ui/crumbs/hobwidget.py |   13 ++++++++-----
>   2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobcolor.py b/bitbake/lib/bb/ui/crumbs/hobcolor.py
> index 402f022..f767d22 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobcolor.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobcolor.py
> @@ -25,6 +25,8 @@ class HobColors:
>       PALE_RED     = "#ffaaaa"
>       GRAY         = "#aaaaaa"
>       LIGHT_GRAY   = "#dddddd"
> +    DEEP_GRAY    = "#7c7c77"
> +    SLIGHT_DARK  = "#5f5f5f"
>       DARK         = "#3c3b37"
>       BLACK        = "#000000"
>       LIGHT_ORANGE = "#f7a787"
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index dc0480a..d4ee94e 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -496,16 +496,19 @@ class HobTabBar(gtk.DrawingArea):
>
>           r = height / 10
>           if self.tab_pressed == True:
> -            for xoff, yoff in [(1, 0), (2, 0)]:
> -                cr.set_source_color(gtk.gdk.color_parse(HobColors.PALE_GREEN))
> +            for xoff, yoff, c1, c2 in [(1, 0, HobColors.SLIGHT_DARK, HobColors.DARK), (2, 0, HobColors.GRAY, HobColors.LIGHT_GRAY)]:
> +                cr.set_source_color(gtk.gdk.color_parse(c1))
> +                cr.move_to(x + xoff, y + height + yoff)
> +                cr.line_to(x + xoff, r + yoff)
> +                cr.arc(x + r + xoff, y + r + yoff, r, math.pi, 1.5*math.pi)
>                   cr.move_to(x + r + xoff, y + yoff)
>                   cr.line_to(x + width - r + xoff, y + yoff)
> -                cr.arc(x + width - r+ xoff, y + r + yoff, r, 1.5*math.pi, 2*math.pi)
> +                cr.arc(x + width - r + xoff, y + r + yoff, r, 1.5*math.pi, 2*math.pi)
> +                cr.stroke()
> +                cr.set_source_color(gtk.gdk.color_parse(c2))
>                   cr.move_to(x + width + xoff, r + yoff)
>                   cr.line_to(x + width + xoff, y + height + yoff)
>                   cr.line_to(x + xoff, y + height + yoff)
> -                cr.line_to(x + xoff, r + yoff)
> -                cr.arc(x + r + xoff, y + r + yoff, r, math.pi, 1.5*math.pi)
>                   cr.stroke()
>               x = x + 2
>               y = y + 2

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


