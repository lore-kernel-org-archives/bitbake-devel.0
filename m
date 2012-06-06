Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sc6ej-00084x-Dm
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 05:11:33 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q56316Xh022776
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 5 Jun 2012 20:01:06 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 5 Jun 2012 20:01:05 -0700
Message-ID: <4FCEC80C.4040209@windriver.com>
Date: Wed, 6 Jun 2012 11:01:32 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<bbe60345d083624fd2fd6bc4a60c2cb948fe2993.1338866958.git.kai.kang@windriver.com>
	<4FCE4403.6090701@linux.intel.com> <4FCEC15E.30701@windriver.com>
In-Reply-To: <4FCEC15E.30701@windriver.com>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q56316Xh022776
Subject: Re: [PATCH 1/2] hob2: update DeployImageDialog for seperated tool
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
X-List-Received-Date: Wed, 06 Jun 2012 03:11:33 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B406=E6=9C=8806=E6=97=A5 10:33, Kang Kai wrote:
> On 2012=E5=B9=B406=E6=9C=8806=E6=97=A5 01:38, Darren Hart wrote:
>>
>> On 06/04/2012 08:37 PM, Kang Kai wrote:
>>> Part of [Yocto 2388]
>>>
>>> Update class DeployImageDialog that could be used by a standalone
>>> deploy image tool.
>>>
>>> Update the method to get all usb device to avoid runtime error, and
>>> get the deploy image process exit status then give user a information
>>> dialog.
>
> Hi Darren,
>
> Thanks a lot for your detail comments.
>
> One thing I want to address that the difference between standaonle=20
> widget and called by hob is that the standalone widget add a image=20
> selection button.
> Maybe I use the wrong word "singleton" but that why I update the=20
> deploy image dialog layout.
>
>> These are functionally different tasks that should probably broken up
>> into a couple patches. This allows us to revert one while maintaining
>> the other should a problem arise. It also makes reviewing the code=20
>> easier.
> Ok, I'll break up it.
>
>>
>>> Remove some extra spaces at same time.
>>>
>>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>>> ---
>>>   bitbake/lib/bb/ui/crumbs/hig.py |   82=20
>>> ++++++++++++++++++++++++++++++++-------
>>>   1 files changed, 68 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py=20
>>> b/bitbake/lib/bb/ui/crumbs/hig.py
>>> index 7c9e73f..7d8daad 100644
>>> --- a/bitbake/lib/bb/ui/crumbs/hig.py
>>> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
>>> @@ -20,6 +20,7 @@
>>>   # with this program; if not, write to the Free Software=20
>>> Foundation, Inc.,
>>>   # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>>
>>> +import glob
>>>   import gtk
>>>   import gobject
>>>   import hashlib
>>> @@ -63,7 +64,7 @@ class CrumbsMessageDialog(CrumbsDialog):
>>>       """
>>>       def __init__(self, parent=3DNone, label=3D"", icon=3Dgtk.STOCK_=
INFO):
>>>           super(CrumbsMessageDialog, self).__init__("", parent,=20
>>> gtk.DIALOG_DESTROY_WITH_PARENT)
>>> -
>>> +
>>>           self.set_border_width(6)
>>>           self.vbox.set_property("spacing", 12)
>>>           self.action_area.set_property("spacing", 12)
>>> @@ -748,21 +749,28 @@ class DeployImageDialog (CrumbsDialog):
>>>
>>>       __dummy_usb__ =3D "--select a usb drive--"
>>>
>>> -    def __init__(self, title, image_path, parent, flags,=20
>>> buttons=3DNone):
>>> +    def __init__(self, title, image_path, parent, flags,=20
>>> buttons=3DNone, singleton=3DFalse):
>>>           super(DeployImageDialog, self).__init__(title, parent,=20
>>> flags, buttons)
>>>
>>>           self.image_path =3D image_path
>>> +        self.singleton =3D singleton
>>>
>>>           self.create_visual_elements()
>>>           self.connect("response", self.response_cb)
>>>
>>>       def create_visual_elements(self):
>>> +        self.set_size_request(600, 400)
>>>           label =3D gtk.Label()
>>>           label.set_alignment(0.0, 0.5)
>>>           markup =3D "<span font_desc=3D'12'>The image to be written=20
>>> into usb drive:</span>"
>>>           label.set_markup(markup)
>>>           self.vbox.pack_start(label, expand=3DFalse, fill=3DFalse,=20
>>> padding=3D2)
>>>
>>> +        table =3D gtk.Table(2, 10, False)
>>> +        table.set_col_spacings(5)
>>> +        table.set_row_spacings(5)
>>> +        self.vbox.pack_start(table, expand=3DTrue, fill=3DTrue)
>>> +
>>
>> It isn't obvious to me why things like setting the size request and
>> creating a new table are required to make this stand alone. Do these
>> changes fit under the "Update class DeployImageDialog that could be us=
ed
>> by a standalone deploy image tool." ? If so, fine. If not, they might =
be
>> better done in a separate patch.
>
> Without set the size request, the scroll bar doesn't show the text=20
> when the deploy dialog shows.
> It is ok to a separate patch.
>
>>
>>
>>>           scroll =3D gtk.ScrolledWindow()
>>>           scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
>>>           scroll.set_shadow_type(gtk.SHADOW_IN)
>>> @@ -770,11 +778,26 @@ class DeployImageDialog (CrumbsDialog):
>>>           tv.set_editable(False)
>>>           tv.set_wrap_mode(gtk.WRAP_WORD)
>>>           tv.set_cursor_visible(False)
>>> -        buf =3D gtk.TextBuffer()
>>> -        buf.set_text(self.image_path)
>>> -        tv.set_buffer(buf)
>>> +        self.buf =3D gtk.TextBuffer()
>>> +        self.buf.set_text(self.image_path)
>>> +        tv.set_buffer(self.buf)
>>>           scroll.add(tv)
>>> -        self.vbox.pack_start(scroll, expand=3DTrue, fill=3DTrue)
>>> +        table.attach(scroll, 0, 10, 0, 1)
>>> +
>>> +        if self.singleton:
>>> +                gobject.signal_new("select_image_clicked", self,=20
>>> gobject.SIGNAL_RUN_FIRST,
>>> +                                   gobject.TYPE_NONE, ())
>>> +                icon =3D gtk.Image()
>>> +                pix_buffer =3D=20
>>> gtk.gdk.pixbuf_new_from_file(hic.ICON_IMAGES_DISPLAY_FILE)
>>> +                icon.set_from_pixbuf(pix_buffer)
>>> +                button =3D gtk.Button("Select Image")
>>> +                button.set_image(icon)
>>> +                button.set_size_request(140, 50)
>>> +                table.attach(button, 9, 10, 1, 2, gtk.FILL, 0, 0, 0)
>>> +                button.connect("clicked",=20
>>> self.select_image_button_clicked_cb)
>>> +
>>> +        separator =3D gtk.HSeparator()
>>> +        self.vbox.pack_start(separator, expand=3DFalse, fill=3DFalse=
,=20
>>> padding=3D10)
>> What does the self.singleton indicate? How is it related to running
>> stand-alone or within Hob?
>
> As I mentioned above, I just add a image selection button when the=20
> tool is run separately. It is convenience So I need to adjust the layou=
t.
>
>
>>
>>>           self.usb_desc =3D gtk.Label()
>>>           self.usb_desc.set_alignment(0.0, 0.5)
>>> @@ -789,7 +812,7 @@ class DeployImageDialog (CrumbsDialog):
>>>           for usb in self.find_all_usb_devices():
>>>               self.usb_combo.append_text("/dev/" + usb)
>>>           self.usb_combo.set_active(0)
>>> -        self.vbox.pack_start(self.usb_combo, expand=3DTrue, fill=3DT=
rue)
>>> +        self.vbox.pack_start(self.usb_combo, expand=3DFalse, fill=3D=
False)
>> This would appear to be a superfluous layout change unrelated to the
>> patch topic...
>>
>>>           self.vbox.pack_start(self.usb_desc, expand=3DFalse,=20
>>> fill=3DFalse, padding=3D2)
>>>
>>>           self.progress_bar =3D HobProgressBar()
>>> @@ -800,13 +823,19 @@ class DeployImageDialog (CrumbsDialog):
>>>           self.vbox.show_all()
>>>           self.progress_bar.hide()
>>>
>>> +    def set_image_text_buffer(self, image_path):
>>> +        self.buf.set_text(image_path)
>>> +
>>> +    def set_image_path(self, image_path):
>>> +        self.image_path =3D image_path
>>> +
>>>       def popen_read(self, cmd):
>>>           tmpout, errors =3D bb.process.run("%s" % cmd)
>>>           return tmpout.strip()
>>>
>>>       def find_all_usb_devices(self):
>>>           usb_devs =3D [ os.readlink(u)
>>> -            for u in self.popen_read('ls=20
>>> /dev/disk/by-id/usb*').split()
>>> +            for u in glob.glob('/dev/disk/by-id/usb*')
>> Secondary to the goal of the patch, but why are we restricting ourselv=
es
>> to sub drives? Why not read /proc/partitions and omit a configurable
>> blacklist of devices (like /dev/sda for example). Again, secondary to
>> this patch series.
>
> This update just to fix runtime error after commit=20
> 094742bed2fc01d55f572da946fcfa7a48521401 when there is no USB device=20
> then the program crashes.
> If we want to deploy to other device, I'll update it.
>
>>
>>>               if not re.search(r'part\d+', u) ]
>>>           return [ '%s' % u[u.rfind('/')+1:] for u in usb_devs ]
>>>
>>> @@ -815,6 +844,9 @@ class DeployImageDialog (CrumbsDialog):
>>>               (self.popen_read('cat=20
>>> /sys/class/block/%s/device/vendor' % dev),
>>>               self.popen_read('cat /sys/class/block/%s/device/model'=20
>>> % dev))
>>>
>>> +    def select_image_button_clicked_cb(self, button):
>>> +            self.emit('select_image_clicked')
>>> +
>>>       def usb_combo_changed_cb(self, usb_combo):
>>>           combo_item =3D self.usb_combo.get_active_text()
>>>           if not combo_item or combo_item =3D=3D self.__dummy_usb__:
>>> @@ -826,12 +858,34 @@ class DeployImageDialog (CrumbsDialog):
>>>
>>>       def response_cb(self, dialog, response_id):
>>>           if response_id =3D=3D gtk.RESPONSE_YES:
>>> +            lbl =3D ''
>>>               combo_item =3D self.usb_combo.get_active_text()
>>> -            if combo_item and combo_item !=3D self.__dummy_usb__:
>>> +            if combo_item and combo_item !=3D self.__dummy_usb__ and=
=20
>>> self.image_path:
>>>                   cmdline =3D bb.ui.crumbs.utils.which_terminal()
>>>                   if cmdline:
>>> -                    cmdline +=3D "\"sudo dd if=3D" + self.image_path=
 +=20
>>> " of=3D" + combo_item + "\""
>>> -                    bb.process.Popen(shlex.split(cmdline))
>>> +                    tmpname =3D os.tmpnam()
>>> +                    cmdline +=3D "\"sudo dd if=3D" + self.image_path=
 +=20
>>> " of=3D" + combo_item + "; echo $?>  " + tmpname + "\""
>>> +                    deploy_process =3D=20
>>> bb.process.Popen(shlex.split(cmdline))
>>> +                    deploy_process.wait()
>>> +                    tmpfile =3D open(tmpname)
>>> +                    if int(tmpfile.readline().strip()) =3D=3D 0:
>>> +                        lbl =3D "<b>Deploy image successfully</b>"
>>> +                    else:
>>> +                        lbl =3D "<b>Deploy image failed</b>\nPlease=20
>>> try again"
>>> +                    tmpfile.close()
>>> +                    os.remove(tmpname)
>>> +
>>> +            else:
>>> +                if not self.image_path:
>>> +                    lbl =3D "<b>No selection made</b>\nYou have not=20
>>> selected image to deploy"
>> "<b>No selection made.</b>\nPlease select an image."
>>
>> Is<br>  appropriate here instead of \n?
>
> Ok, thanks.

I am afraid the <br> is not supported here. It obeys pango markup=20
language and <br> is not  supported.

Regards,
Kai
>
>>
>>> +                else:
>>> +                    lbl =3D "<b>No selection made</b>\nYou have not=20
>>> selected USB device"
>> "<b>No selection made.</b>\nPlease select a device."
>>
>> Again, why are we limiting devices to USB devices?
> Fine, if need I would update this part.
>
> Regards,
> Kai
>>
>>> +            if len(lbl):
>>> +                crumbs_dialog =3D CrumbsMessageDialog(self, lbl,=20
>>> gtk.STOCK_DIALOG_INFO)
>>> +                button =3D crumbs_dialog.add_button("Close",=20
>>> gtk.RESPONSE_OK)
>>> +                HobButton.style_button(button)
>>> +                crumbs_dialog.run()
>>> +                crumbs_dialog.destroy()
>>>
>>>       def update_progress_bar(self, title, fraction, status=3DNone):
>>>           self.progress_bar.update(fraction)
>>> @@ -1035,7 +1089,7 @@ class LayerSelectionDialog (CrumbsDialog):
>>>           # create visual elements on the dialog
>>>           self.create_visual_elements()
>>>           self.connect("response", self.response_cb)
>>> -
>>> +
>>>       def create_visual_elements(self):
>>>           layer_widget, self.layer_store =3D=20
>>> self.gen_layer_widget(self.layers, self.all_layers, self, None)
>>>           layer_widget.set_size_request(450, 250)
>>> @@ -1210,7 +1264,7 @@ class ImageSelectionDialog (CrumbsDialog):
>>>                           if f.endswith('.' + real_image_type):
>>>                               imageset.add(f.rsplit('.' +=20
>>> real_image_type)[0].rsplit('.rootfs')[0])
>>>                               self.image_list.append(f)
>>> -
>>> +
>>>           for image in imageset:
>>>               self.image_store.set(self.image_store.append(), 0,=20
>>> image, 1, False)
>>>
>>> @@ -1226,7 +1280,7 @@ class ImageSelectionDialog (CrumbsDialog):
>>>                       for f in self.image_list:
>>>                           if f.startswith(self.image_store[path][0]=20
>>> + '.'):
>>>                               self.image_names.append(f)
>>> -                    break
>>> +                    break
>>>                   iter =3D self.image_store.iter_next(iter)
>>>
>>>   class ProxyDetailsDialog (CrumbsDialog):
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



