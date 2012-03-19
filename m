Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mW1-0007jq-6r
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:01:29 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 19 Mar 2012 16:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120838656"
Received: from unknown (HELO [10.255.15.181]) ([10.255.15.181])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 16:52:36 -0700
Message-ID: <4F67C6C4.2030909@linux.intel.com>
Date: Mon, 19 Mar 2012 16:52:36 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<5898048e599d44215245bd1a7231662618875f08.1331910234.git.shane.wang@intel.com>
In-Reply-To: <5898048e599d44215245bd1a7231662618875f08.1331910234.git.shane.wang@intel.com>
Subject: Re: [PATCH 10/12] Hob: add auto adjust background area function for long issue text
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
X-List-Received-Date: Tue, 20 Mar 2012 00:01:29 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 08:10, Shane Wang wrote:
> From: Liming An<limingx.l.an@intel.com>
>
> To add auto expand the background area function for long issue text input.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/hobwidget.py |   30 +++++++++++++++++++++---------
>   1 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index e580d50..dc0480a 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -521,26 +521,38 @@ class HobTabBar(gtk.DrawingArea):
>           cr.fill()
>
>       def draw_indicator(self, cr, child):
> +        text = ("%d" % child["indicator_number"])
> +        layout = self.create_pango_layout(text)
> +        layout.set_font_description(self.font)
> +        textw, texth = layout.get_pixel_size()
> +        # draw the back round area
>           tab_x = child["x"]
>           tab_y = child["y"]
> -        number = child["indicator_number"]
>           dest_w = int(32 * self.tab_w_ratio)
>           dest_h = int(32 * self.tab_h_ratio)
>           if dest_h<  self.tab_height:
>               dest_w = dest_h
> -
>           # x position is offset(tab_width*3/4 - icon_width/2) + start_pos(tab_x)
>           x = tab_x + self.tab_width * 3/4 - dest_w/2
>           y = tab_y + self.tab_height/2 - dest_h/2
> +
>           r = min(dest_w, dest_h)/2
>           color = cr.set_source_color(gtk.gdk.color_parse(HobColors.ORANGE))
> -        cr.arc(x + r, y + r, r, 0, 2*math.pi)
> -        cr.fill()
> -
> -        text = ("%d" % number)
> -        layout = self.create_pango_layout(text)
> -        layout.set_font_description(self.font)
> -        textw, texth = layout.get_pixel_size()
> +        # check round back area can contain the text or not
> +        back_round_can_contain_width = float(2 * r * 0.707)
> +        if float(textw)>  back_round_can_contain_width:
> +            xoff = (textw - int(back_round_can_contain_width)) / 2
> +            cr.move_to(x + r - xoff, y + r + r)
> +            cr.arc((x + r - xoff), (y + r), r, 0.5*math.pi, 1.5*math.pi)
> +            cr.fill() # left half round
> +            cr.rectangle((x + r - xoff), y, 2 * xoff, 2 * r)
> +            cr.fill() # center rectangle
> +            cr.arc((x + r + xoff), (y + r), r, 1.5*math.pi, 0.5*math.pi)
> +            cr.fill() # right half round
> +        else:
> +            cr.arc((x + r), (y + r), r, 0, 2*math.pi)
> +            cr.fill()
> +        # draw the number text
>           x = x + (dest_w/2)-(textw/2)
>           y = y + (dest_h/2) - (texth/2)
>           cr.move_to(x, y)

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


