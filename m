Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mVB-0007gw-Io
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:00:37 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 19 Mar 2012 16:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120838390"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 16:51:47 -0700
Message-ID: <4F67C693.7010804@linux.intel.com>
Date: Mon, 19 Mar 2012 16:51:47 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<b22b81f849a14cf8f01c796bfaf7bfca1e0f2462.1331910234.git.shane.wang@intel.com>
In-Reply-To: <b22b81f849a14cf8f01c796bfaf7bfca1e0f2462.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 07/12] Hob: remove the invalid code in hobwidget.py
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
X-List-Received-Date: Tue, 20 Mar 2012 00:00:37 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 08:10, Shane Wang wrote:
> From: Liming An<limingx.l.an@intel.com>
>
> To delete some code which is not used
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/hobwidget.py |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index f0d9cbc..71f0629 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -516,7 +516,6 @@ class HobTabBar(gtk.DrawingArea):
>           cr.fill()
>
>       def draw_indicator(self, cr, i):
> -        style = self.get_style()
>           tab_x = self.children[i]["x"]
>           tab_y = self.children[i]["y"]
>           number = self.children[i]["indicator_number"]
> @@ -528,7 +527,6 @@ class HobTabBar(gtk.DrawingArea):
>           # x position is offset(tab_width*3/4 - icon_width/2) + start_pos(tab_x)
>           x = tab_x + self.tab_width * 3/4 - dest_w/2
>           y = tab_y + self.tab_height/2 - dest_h/2
> -        cr.move_to(tab_x, tab_y)
>           r = min(dest_w, dest_h)/2
>           color = cr.set_source_color(gtk.gdk.color_parse(HobColors.ORANGE))
>           cr.arc(x + r, y + r, r, 0, 2*math.pi)

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


