Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UcYfD-0001jN-6o
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 May 2013 12:10:28 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 May 2013 02:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,675,1363158000"; d="scan'208";a="302738134"
Received: from adinu-vostro-460.rb.intel.com (HELO [10.237.105.143])
	([10.237.105.143])
	by azsmga001.ch.intel.com with ESMTP; 15 May 2013 02:52:12 -0700
Message-ID: <51935AF3.3060907@intel.com>
Date: Wed, 15 May 2013 12:52:51 +0300
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To: Andrei Dinu <andrei.adrianx.dinu@intel.com>
References: <1368611468-14420-1-git-send-email-andrei.adrianx.dinu@intel.com>
In-Reply-To: <1368611468-14420-1-git-send-email-andrei.adrianx.dinu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] propertydialog.py : Scrollable windows for long tooltips
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
X-List-Received-Date: Wed, 15 May 2013 10:10:30 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please ignore this patch.

Thanks.

On 05/15/2013 12:51 PM, Andrei Dinu wrote:
> In some cases, the length of the description and the brought
> in by field was too big. That led to the size of the property
> dialog exceeding Hob's size. For long tooltips we use
> scrollable windows now.
>
> [HOB #4321]
>
> Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/hig/propertydialog.py |   34 +++++++++---------------
>   1 file changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
> index 89cb3a3..5a41ae7 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
> @@ -274,24 +274,23 @@ class PropertyDialog(CrumbsDialog):
>                   binb_items_count = len(binb.split(','))
>                   binb_items = binb.split(',')
>                                  		
> -		vbox = gtk.VBox(True,spacing = 0)
> -
> +		vbox = gtk.VBox(False,spacing = 0)
> +
>                   ######################################## SUMMARY LABEL #########################################                	
>                   
>                   if summary != '':
>                           self.label_short = gtk.Label()
> -                        self.label_short.set_size_request(300,-1)
> +                        self.label_short.set_width_chars(37)
>                           self.label_short.set_selectable(True)
>                           self.label_short.set_line_wrap(True)
>                           self.label_short.set_markup("<b>" + summary + "</b>")
>                           self.label_short.set_property("xalign", 0)
>                           
> -                        self.vbox.pack_start(self.label_short, expand=False, fill=False, padding=0)
> +                        self.vbox.add(self.label_short)
>                   
>                   ########################################## NAME ROW + COL #######################################
>                                   
>                   self.label_short = gtk.Label()
> -                self.label_short.set_size_request(300,-1)
>                   self.label_short.set_selectable(True)
>                   self.label_short.set_line_wrap(True)
>                   self.label_short.set_markup("<span weight=\"bold\">Name: </span>" + name)
> @@ -302,7 +301,6 @@ class PropertyDialog(CrumbsDialog):
>                   ####################################### VERSION ROW + COL ####################################
>                   
>                   self.label_short = gtk.Label()
> -                self.label_short.set_size_request(300,-1)
>                   self.label_short.set_selectable(True)
>                   self.label_short.set_line_wrap(True)
>                   self.label_short.set_markup("<span weight=\"bold\">Version: </span>" + version)
> @@ -313,7 +311,6 @@ class PropertyDialog(CrumbsDialog):
>                   ##################################### REVISION ROW + COL #####################################
>   
>                   self.label_short = gtk.Label()
> -                self.label_short.set_size_request(300,-1)
>                   self.label_short.set_line_wrap(True)
>                   self.label_short.set_selectable(True)
>                   self.label_short.set_markup("<span weight=\"bold\">Revision: </span>" + revision)
> @@ -324,7 +321,6 @@ class PropertyDialog(CrumbsDialog):
>                   ################################## GROUP ROW + COL ############################################
>                  
>                   self.label_short = gtk.Label()
> -                self.label_short.set_size_request(300,-1)
>                   self.label_short.set_selectable(True)
>                   self.label_short.set_line_wrap(True)
>                   self.label_short.set_markup("<span weight=\"bold\">Group: </span>" + group)
> @@ -346,7 +342,6 @@ class PropertyDialog(CrumbsDialog):
>                           self.label_info.set_property("xalign", 0)
>                          
>                           self.label_short = gtk.Label()
> -                        self.label_short.set_size_request(300,-1)
>                           self.label_short.set_selectable(True)
>                           self.label_short.set_line_wrap(True)
>                           self.label_short.set_markup("<b>Homepage: </b>")
> @@ -368,7 +363,6 @@ class PropertyDialog(CrumbsDialog):
>                           self.label_info.set_property("xalign", 0)
>   
>                           self.label_short = gtk.Label()
> -                        self.label_short.set_size_request(300,-1)
>                           self.label_short.set_selectable(True)
>                           self.label_short.set_line_wrap(True)
>                           self.label_short.set_markup("<b>Bugtracker: </b>")
> @@ -380,7 +374,6 @@ class PropertyDialog(CrumbsDialog):
>                   ################################# LICENSE ROW + COL ############################################
>                   
>                   self.label_info = gtk.Label()
> -                self.label_info.set_size_request(300,-1)
>                   self.label_info.set_selectable(True)
>                   self.label_info.set_line_wrap(True)
>                   self.label_info.set_markup(license)
> @@ -403,26 +396,24 @@ class PropertyDialog(CrumbsDialog):
>                           self.label_short.set_line_wrap(True)
>                           self.label_short.set_markup("<span weight=\"bold\">Brought in by: </span>")
>                           self.label_short.set_property("xalign", 0)
> -
>                           self.vbox.add(self.label_short)
> -
>                           self.label_info = gtk.Label()
> -                        self.label_info.set_size_request(300,-1)
>                           self.label_info.set_selectable(True)
> +                        self.label_info.set_width_chars(36)
>                           if len(binb) > 200:
>                               scrolled_window = gtk.ScrolledWindow()
>                               scrolled_window.set_policy(gtk.POLICY_NEVER,gtk.POLICY_ALWAYS)
>                               scrolled_window.set_size_request(100,100)
>                               self.label_info.set_markup(binb)
> -                            self.label_info.set_property("xalign", 0)
> +                            self.label_info.set_padding(6,6)
> +                            self.label_info.set_alignment(0,0)
>                               self.label_info.set_line_wrap(True)
>                               scrolled_window.add_with_viewport(self.label_info)
>                               self.vbox.add(scrolled_window)
>                           else:
>                               self.label_info.set_markup(binb)
>                               self.label_info.set_property("xalign", 0)
> -                            self.label_info.set_line_wrap(True)
> -
> +                            self.label_info.set_line_wrap(True)
>                               self.vbox.add(self.label_info)
>   
>                   ################################ DESCRIPTION TAG ROW #################################################
> @@ -438,21 +429,22 @@ class PropertyDialog(CrumbsDialog):
>                   hbox = gtk.HBox(True,spacing = 0)
>   
>                   self.label_short = gtk.Label()
> -                self.label_short.set_size_request(300,-1)
>                   self.label_short.set_selectable(True)
> +                self.label_short.set_width_chars(36)
>                   if len(description) > 200:
>                       scrolled_window = gtk.ScrolledWindow()
>                       scrolled_window.set_policy(gtk.POLICY_NEVER,gtk.POLICY_ALWAYS)
>                       scrolled_window.set_size_request(100,100)
>                       self.label_short.set_markup(description)
> -                    self.label_short.set_property("xalign", 0)
> +                    self.label_short.set_padding(6,6)
> +                    self.label_short.set_alignment(0,0)
>                       self.label_short.set_line_wrap(True)
>                       scrolled_window.add_with_viewport(self.label_short)
>                       self.vbox.add(scrolled_window)
>                   else:
> -                    self.label_short.set_text(description)
> -                    self.label_short.set_line_wrap(True)
> +                    self.label_short.set_markup(description)
>                       self.label_short.set_property("xalign", 0)
> +                    self.label_short.set_line_wrap(True)
>                       self.vbox.add(self.label_short)
>   
>                   self.vbox.show_all()



