Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S5QpR-0001ue-5y
	for bitbake-devel@lists.openembedded.org;
	Thu, 08 Mar 2012 01:03:34 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 07 Mar 2012 15:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="126362164"
Received: from unknown (HELO [10.255.15.51]) ([10.255.15.51])
	by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2012 15:54:53 -0800
Message-ID: <4F57F54D.10504@linux.intel.com>
Date: Wed, 07 Mar 2012 15:54:53 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
	<8bd3c205e17913dd3fe85e95d9ef2f28a01f123e.1330734444.git.josh@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AE1B57@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AE1B57@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/6] crumbs/persistenttooltip: a new Gtk+ widget for use in Hob
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
X-List-Received-Date: Thu, 08 Mar 2012 00:03:34 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/12 14:29, Wang, Shane wrote:
> ACK the rest except one comment below.
>
> --
> Shane
>
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org
>> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of
>> Joshua Lock
>> Sent: Friday, March 02, 2012 4:39 PM
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCH 1/6] crumbs/persistenttooltip: a new Gtk+
>> widget for use in Hob
>>
>> The Hob interaction design calls for a top level widget which shows a
>> persistent tooltip. This tooltip will not disappear until the user
>> explicitly closes it.
>>
>> This allows us to provide clickable hyperlinks, longer instructions and
>> deeper information in the tooltips.
>>
>> Note: by design the tooltip should dismiss when the user clicks off it,
>> this implementation does include that functionality. It's a to do item.
>>
>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
>> ---
>>   lib/bb/ui/crumbs/persistenttooltip.py |  127
>> +++++++++++++++++++++++++++++++++
>>   1 files changed, 127 insertions(+), 0 deletions(-)
>>   create mode 100644 lib/bb/ui/crumbs/persistenttooltip.py
>>
>> diff --git a/lib/bb/ui/crumbs/persistenttooltip.py
>> b/lib/bb/ui/crumbs/persistenttooltip.py
>> new file mode 100644
>> index 0000000..f3f55b1
>> --- /dev/null
>> +++ b/lib/bb/ui/crumbs/persistenttooltip.py
>> @@ -0,0 +1,127 @@
>> +#
>> +# BitBake Graphical GTK User Interface
>> +#
>> +# Copyright (C) 2012   Intel Corporation
>> +#
>> +# Authored by Joshua Lock<josh@linux.intel.com>
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License version 2 as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License along
>> +# with this program; if not, write to the Free Software Foundation, Inc.,
>> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> +
>> +import gobject
>> +import gtk
>> +
>> +class PersistentTooltip(gtk.Window):
>> +	"""
>> +	A tooltip which persists once shown until the user dismisses it with the
>> Esc
>> +	key or by clicking the close button.
>> +
>> +	# FIXME: the PersistentTooltip should be disabled when the user clicks
>> anywhere off
>> +	# it. We can't do this with focus-out-event becuase modal ensures we
>> have focus?
>> +
>> +	markup: some Pango text markup to display in the tooltip
>> +	"""
>> +	def __init__(self, markup):
>> +		gtk.Window.__init__(self, gtk.WINDOW_POPUP)
>> +
>> +		# We need to ensure we're only shown once
>> +		self.shown = False
>> +
>> +		# We don't want any WM decorations
>> +		self.set_decorated(False)
>> +		# We don't want to show in the taskbar or window switcher
>> +		self.set_skip_pager_hint(True)
>> +		self.set_skip_taskbar_hint(True)
>> +		# We must be modal to ensure we grab focus when presented from
>> a gtk.Dialog
>> +		self.set_modal(True)
>> +
>> +		self.set_border_width(6)
>> +		self.set_position(gtk.WIN_POS_MOUSE)
>> +		self.set_opacity(0.95)
>> +
>> +		# Draw our label and close buttons
>> +		hbox = gtk.HBox(False, 0)
>> +		hbox.show()
>> +		vbox = gtk.VBox(False, 0)
>> +		vbox.show()
>> +		vbox.pack_start(hbox, True, True, 0)
>> +
>> +		img = gtk.Image()
>> +		img.set_from_stock(gtk.STOCK_CLOSE, gtk.ICON_SIZE_BUTTON)
>> +
>> +		self.button = gtk.Button()
>> +		self.button.set_image(img)
>> +		self.button.connect("clicked", self._dismiss_cb)
>> +		self.button.set_can_default(True)
>> +		self.button.grab_focus()
>> +		self.button.show()
>> +		hbox.pack_end(self.button, False, False, 0)
>> +
>> +		self.set_default(self.button)
>> +
>> +		self.label = gtk.Label()
>> +		self.label.set_markup(markup)
>> +		self.label.show()
>> +		vbox.pack_end(self.label, True, True, 6)
>> +
>> +		self.connect("key-press-event", self._catch_esc_cb)
>> +
>> +		# Inherit the system theme for a tooltip
>> +		style = gtk.rc_get_style_by_paths(gtk.settings_get_default(),
>> +			'gtk-tooltip', 'gtk-tooltip', gobject.TYPE_NONE)
>> +		self.set_style(style)
>> +
>> +		self.add(vbox)
>> +
>> +	"""
>> +	Modify the displayed message once the PersistentTooltip has been
>> created.
>> +
>> +	markup: the Pango Markup of the new message
>> +	"""
>> +	def set_tooltip(self, markup):
>> +		self.label.set_markup(markup)
> I haven't seen this is used. Can we remove it?

Good catch. I've removed this method in the bitbake and poky branches.

Cheers,
Joshua
-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


