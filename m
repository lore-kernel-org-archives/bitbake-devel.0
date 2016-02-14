Return-Path: <mirela.rabulea@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
	(mail-db3on0056.outbound.protection.outlook.com [157.55.234.56])
	by mail.openembedded.org (Postfix) with ESMTP id 99BBF6FF23
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 22:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
	s=selector1-nxp-com;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=Rx+RAWAY2IEeK+Gv3Swf69NUTsoSV64VnrdtSd+delo=;
	b=BBOkj8xw9OFcQAdaNA3s5BsIpAdqqleuSiIgHlmmdHuRDrHeUvvVjfPDQjxReHkfP8GtFqSRD6cYWi52EWAI/0RmDiu+uVenyq6Hgij3gHAa8Yak41ybgn1uP8bfRmdErF6P5QSYNLlf7u0ymFzidOefDmUm5hszNCrkeLlhUZI=
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com (10.165.234.151) by
	VI1PR04MB0910.eurprd04.prod.outlook.com (10.161.106.18) with Microsoft
	SMTP Server (TLS) id 15.1.409.15; Sun, 14 Feb 2016 22:09:47 +0000
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) by
	VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) with
	mapi id 15.01.0409.017; Sun, 14 Feb 2016 22:09:46 +0000
From: Mirela Rabulea <mirela.rabulea@nxp.com>
To: Joshua G Lock <joshua.g.lock@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Fix bug 8940 - Alow Hob to run images on
	a custom simulator, other than qemu
Thread-Index: AdFUYtl3YI4m24hVQ1y2SKaptI//vAEqJteAAYcSAQABR/CXgAAYZWPAAE51+FAAY8Ge4A==
Date: Sun, 14 Feb 2016 22:09:46 +0000
Message-ID: <VI1PR0401MB1789BE8BA7AD90A09B2C23E18FAB0@VI1PR0401MB1789.eurprd04.prod.outlook.com>
References: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
	<1453903391.3557.42.camel@linux.intel.com>
	<VI1PR0401MB1789EE35802D99452B8F12638FD10@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<1455138641.3442.8.camel@linux.intel.com>
	<VI1PR0401MB178927E4A92EFB4DC3E706978FA80@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<VI1PR0401MB17898F62326CD302A05CD3F38FA90@VI1PR0401MB1789.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB17898F62326CD302A05CD3F38FA90@VI1PR0401MB1789.eurprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
	header.d=none; linux.intel.com;
	dmarc=none action=none header.from=nxp.com; 
x-originating-ip: [192.88.146.1]
x-microsoft-exchange-diagnostics: 1; VI1PR04MB0910;
	5:pT/noUhGSQqRrexf/UKmOpHCfWPyxoYR7oEWdABPHfHI1nBDRe4nY/zZW1UKRCjcmbTOz9BFhToRRI0HHSgBaIpXKfol3V2OaKVTAJ5y8RsNTvp6kCwhN+S3pCyxwI16BcD78xGrFnrgN0TA1uxQPA==;
	24:K5rRdbqDGdu/zqdJZz9XNRaDBMiREWNT07lmeQBfTK/zP4CYNvLM3kGEsz3tshsMWNZ5dFBZH+HjAUP0qwI6g0mxc05n2id9mmA5dEi7sOc=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB0910;
x-ms-office365-filtering-correlation-id: 826b1374-3d92-441e-e69d-08d3358b8c83
x-microsoft-antispam-prvs: <VI1PR04MB0910CCEBF9EB4D061F8FDB048FAB0@VI1PR04MB0910.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(102415293)(102615271)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);
	SRVR:VI1PR04MB0910; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB0910; 
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(6009001)(13464003)(55674003)(377454003)(5004730100002)(77096005)(66066001)(19580405001)(76576001)(54356999)(33656002)(76176999)(3900700001)(92566002)(99936001)(5890100001)(19580395003)(2501003)(5003600100002)(50986999)(40100003)(74316001)(87936001)(189998001)(102836003)(6116002)(2950100001)(5008740100001)(93886004)(122556002)(2906002)(586003)(4326007)(5002640100001)(1220700001)(5001770100001)(1096002)(5001960100002)(86362001)(3846002)(2900100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB0910;
	H:VI1PR0401MB1789.eurprd04.prod.outlook.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2016 22:09:46.0271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0910
Cc: Nicolae Manescu <nicu.manescu@nxp.com>,
	Alexandru Purice <alexandru.purice@nxp.com>, "Roman,
	Alexandru CostinX" <alexandru.costinx.roman@intel.com>,
	"Voiculescu, BogdanX A" <bogdanx.a.voiculescu@intel.com>
Subject: Re: [PATCH] Fix bug 8940 - Alow Hob to run images on a custom simulator, other than qemu
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
X-List-Received-Date: Sun, 14 Feb 2016 22:25:09 -0000
X-Groupsio-MsgNum: 7034
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_VI1PR0401MB1789BE8BA7AD90A09B2C23E18FAB0VI1PR0401MB1789_"

--_002_VI1PR0401MB1789BE8BA7AD90A09B2C23E18FAB0VI1PR0401MB1789_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,
I found one more issue with a corner case when commuting from "Run custom i=
mage" to "Deploy image". From the comments I found in the code, the case wh=
en there are both "runnable" and "deployable" present in the same build is =
not expected.
However, with the introduction of the "Run custom", I think this requires a=
 fix, so here is the v4 of the patch (squashed version attached).
If you did not get to check the v3 patch, you may skip it and check the v4.

Only the v4 fix:
From 4e6c941d74a7b1e11fbd26085a6908b746f61536 Mon Sep 17 00:00:00 2001
From: Mirela Rabulea <mirela.rabulea@nxp.com>
Date: Sun, 14 Feb 2016 23:42:32 +0200
Subject: [PATCH] Allow Hob to run images on a custom simulator, other than
 qemu Fixed bug when commuting from deploy image to run custom image.

Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/=
ui/crumbs/imagedetailspage.py
index b22cf80..32d4854 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -516,8 +516,9 @@ class ImageDetailsPage (HobPage):
         for fileitem in action_images:
             sel_btn =3D gtk.RadioButton(sel_parent_btn, fileitem['type'])
             sel_parent_btn =3D sel_btn if not sel_parent_btn else sel_pare=
nt_btn
-            if fileitem['name'] =3D=3D self.toggled_image:
+            if curr_row =3D=3D 0:
                 sel_btn.set_active(True)
+                self.toggled_image =3D fileitem['name']
             sel_btn.connect('toggled', self.table_selected_cb, fileitem)
             if curr_row < 10:
                 table.attach(sel_btn, 0, 4, curr_row, curr_row + 1, xpaddi=
ng=3D24)
--=20
1.9.1


> -----Original Message-----
> From: Mirela Rabulea
> Sent: Saturday, February 13, 2016 12:44 AM
> To: Mirela Rabulea <mirela.rabulea@nxp.com>; Joshua G Lock
> <joshua.g.lock@linux.intel.com>; bitbake-devel@lists.openembedded.org
> Cc: Nicolae Manescu <nicu.manescu@nxp.com>; Alexandru Purice
> <alexandru.purice@nxp.com>; Roman, Alexandru CostinX
> <alexandru.costinx.roman@intel.com>; Voiculescu, BogdanX A
> <bogdanx.a.voiculescu@intel.com>; Barros Pena, Belen
> <belen.barros.pena@intel.com>
> Subject: RE: [bitbake-devel] [PATCH] Fix bug 8940 - Alow Hob to run image=
s
> on a custom simulator, other than qemu
>=20
> Hi Joshua,
> I got my own core-image-minimal for non-qemu machine (genericx86-64)
> and I can reproduce the same behavior you saw, please see more explaining
> below.
> I have made a v3 patch to fix this, only v3 changes at the end of email, =
for
> easier review.
> The squashed version of the patch is attached (initial changes+v2+v3), wi=
th
> updated comment:
> 	"Note: in case there is more than one toggled image (qemu runnable
> or deployable), when the user clicks the "Run custom image" button, a dia=
log
> will be presented, allowing to choose between any of the existing images.=
"
>=20
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Mirela Rabulea
> > Sent: Thursday, February 11, 2016 1:19 PM
> > To: Joshua G Lock <joshua.g.lock@linux.intel.com>; bitbake-
> > devel@lists.openembedded.org
> > Cc: Nicolae Manescu <nicu.manescu@nxp.com>; Alexandru Purice
> > <alexandru.purice@nxp.com>; Roman, Alexandru CostinX
> > <alexandru.costinx.roman@intel.com>; Voiculescu, BogdanX A
> > <bogdanx.a.voiculescu@intel.com>
> > Subject: Re: [bitbake-devel] [PATCH] Fix bug 8940 - Alow Hob to run
> > images on a custom simulator, other than qemu
> >
> >
> > > but when I click 'Run custom image' I get a dialogue asking to
> > > 'Select the image file you want to run:' with 'Cancel' and 'Run
> > > image' buttons but nothing listing selectable images (I even tried
> > > resizing the dialogue, to no avail). If I proceed to click 'Run
> > > image' button the 'Usb
> > image maker'
> > > dialogue is presented.
> > >
> >
> > That must come from poky\bitbake\lib\bb\ui\crumbs\imagedetailspage.py,
> > show_builded_images_dialog(). I'm not sure how I can reproduce this
> > without waiting a day to build another image, and without some tens of
> > GB which I don't know if I have. I will try it but it will take a
> > while. In the meantime, if you still have the environment, could you
> > add this print in your imagedetailspage.py, it will let us see how
> > many toggled images you have (I suspect is more than 1), and which
> > ones (it shows up in the terminal where hob was started):
> >             self.image_store.append({'name': image_name,
> >                                     'type': image_type,
> >                                     'size': image_size,
> >                                     'is_toggled': is_toggled,
> >                                     'action_attr': image_attr,})
> >
> >             print "image_store.append(image_name=3D", image_name, "
> > image_type=3D", image_type, " image_size=3D", image_size, " is_toggled=
=3D",
> > is_toggled, " image_attr=3D", image_attr, ")"
> >
>=20
> So this was happening not only after the image build is done, but also af=
ter
> the same image was loaded. It depends on what types of files are created =
for
> the image. In the case of  core-image-minimal/genericx86-64, 4 files were
> created, 2 of them with the attribute "deploy" and the other 2 nor runnab=
le
> (qemu way) or deployable. The 2 deployable files got marked as toggled, b=
ut
> since no runnable image was toggled, when the "Run custom image" button
> was pressed, no available file was presented. This issue was manifesting =
only
> when there was more than one toggled image, and I did not see this case
> with the images I had built so far, so thanks a lot for this testcase. Th=
e v3
> patch that I made is fixing show_builded_images_dialog(), allowing the us=
er
> to choose for custom run any of the existing files.
>=20
>=20
> And here's the v3 patch:
> From b6534c8b9166c4ba6f005df252cdb7c491fd1ee3 Mon Sep 17 00:00:00
> 2001
> From: Mirela Rabulea <mirela.rabulea@nxp.com>
> Date: Fri, 12 Feb 2016 23:37:28 +0200
> Subject: [PATCH] Allow Hob to run images on a custom simulator, other tha=
n
> qemu - review feedback no. 2 Note: in case there is more than one toggled
> image (qemu runnable or deployable), when the user clicks the "Run custom
> image" button, a dialog will be presented, allowing to choose between any
> of  the existing images.
>=20
> [YOCTO #8940]
>=20
> Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> index 6cce8a1..b22cf80 100755
> --- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
> @@ -284,8 +284,6 @@ class ImageDetailsPage (HobPage):
>              if not self.toggled_image:
>                  if i =3D=3D (len(image_names) - 1):
>                      is_toggled =3D True
> -                    # if there was no qemu runable image, let one image =
be custom
> run
> -                    image_attr =3D "run_custom"
>                  if is_toggled:
>                      default_image_size =3D image_size
>                      self.toggled_image =3D image_name @@ -501,7 +499,9 @=
@ class
> ImageDetailsPage (HobPage):
>              if  (action_attr =3D=3D 'run' and primary_action =3D=3D "Run=
 image") \
>               or (action_attr =3D=3D 'deploy' and primary_action =3D=3D "=
Deploy image"):
>                  action_images.append(fileitem)
> -
> +        if  (len(action_images) =3D=3D 0 and primary_action =3D=3D "Run =
image"):
> +            # if there are no qemu runnable images, let the user choose =
any of
> the existing images for custom run
> +            action_images =3D self.image_store
>          # pack the corresponding 'runnable' or 'deploy' radio_buttons, i=
f there
> has no more than one file.
>          # assume that there does not both have 'deploy' and 'runnable' f=
iles in
> the same building result
>          # in possible as design.
> @@ -516,7 +516,8 @@ class ImageDetailsPage (HobPage):
>          for fileitem in action_images:
>              sel_btn =3D gtk.RadioButton(sel_parent_btn, fileitem['type']=
)
>              sel_parent_btn =3D sel_btn if not sel_parent_btn else sel_pa=
rent_btn
> -            sel_btn.set_active(fileitem['is_toggled'])
> +            if fileitem['name'] =3D=3D self.toggled_image:
> +                sel_btn.set_active(True)
>              sel_btn.connect('toggled', self.table_selected_cb, fileitem)
>              if curr_row < 10:
>                  table.attach(sel_btn, 0, 4, curr_row, curr_row + 1, xpad=
ding=3D24)
> @@ -540,15 +541,15 @@ class ImageDetailsPage (HobPage):
>=20
>          if response !=3D gtk.RESPONSE_YES:
>              return
> -
> +        # perform the primary action on the image selected by the user
>          for fileitem in self.image_store:
> -            if fileitem['is_toggled']:
> -                if fileitem['action_attr'] =3D=3D 'run':
> +            if fileitem['name'] =3D=3D self.toggled_image:
> +                if (fileitem['action_attr'] =3D=3D 'run' and primary_act=
ion =3D=3D "Run
> image"):
>                      self.builder.runqemu_image(fileitem['name'], self.se=
l_kernel)
> -                elif fileitem['action_attr'] =3D=3D 'run_custom':
> -                    self.builder.run_custom_image(fileitem['name'],
> self.run_script_path)
> -                elif fileitem['action_attr'] =3D=3D 'deploy':
> +                elif (fileitem['action_attr'] =3D=3D 'deploy' and primar=
y_action =3D=3D
> "Deploy image"):
>                      self.builder.deploy_image(fileitem['name'])
> +                elif (primary_action =3D=3D "Run image"):
> +                    self.builder.run_custom_image(fileitem['name'],
> + self.run_script_path)
>=20
>      def table_selected_cb(self, tbutton, image):
>          image['is_toggled'] =3D tbutton.get_active()
> --
> 1.9.1
>=20


--_002_VI1PR0401MB1789BE8BA7AD90A09B2C23E18FAB0VI1PR0401MB1789_
Content-Type: application/octet-stream; name="bug_8940_squashed_v4.patch"
Content-Description: bug_8940_squashed_v4.patch
Content-Disposition: attachment; filename="bug_8940_squashed_v4.patch";
	size=13119; creation-date="Sun, 14 Feb 2016 21:58:55 GMT";
	modification-date="Sun, 14 Feb 2016 21:47:54 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwOGI2OWE1NzZhZWVlOGQwZjk4M2M5YzZlOGM5NTUzZDI2NDM0OWNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaXJlbGEgUmFidWxlYSA8bWlyZWxhLnJhYnVsZWFAbnhwLmNv
bT4KRGF0ZTogVHVlLCAxOSBKYW4gMjAxNiAxNjozMTozOCArMDIwMApTdWJqZWN0OiBbUEFUQ0gg
djRdIEFsbG93IEhvYiB0byBydW4gaW1hZ2VzIG9uIGEgY3VzdG9tIHNpbXVsYXRvciwgb3RoZXIg
dGhhbgogcWVtdQoKVGhlIGN1cnJlbnQgYmVoYXZpb3Igb2YgSG9iIGlzIHRoYXQgdGhlcmUgaXMg
YSAiUnVuIEltYWdlIiBidXR0b24gd2hpY2ggYmVjb21lcyB2aXNpYmxlIG9ubHkgZm9yIHFlbXUg
aW1hZ2VzLgoKTXkgc3VnZ2VzdGVkIGNoYW5nZSBpczoKLSBpZiBhbiBpbWFnZSBpcyBzZWxlY3Rl
ZCBhbmQgaXQgaXMgcWVtdS1jb21wYXRpYmxlLCBsZXQgdGhlICJSdW4gaW1hZ2UiIGJ1dHRvbiBi
ZSBuYW1lZCAiUnVuIHFlbXUgaW1hZ2UiCi0gaWYgYW4gaW1hZ2UgaXMgc2VsZWN0ZWQgYW5kIGl0
IGlzIG5vdCBxZW11LWNvbXBhdGlibGUsIGxldCB0aGUgc2FtZSBidXR0b24gc2hvdyB1cCB3aXRo
IHRoZSBuYW1lICJSdW4gY3VzdG9tIGltYWdlIiwgYW5kIGJlc2lkZXMgdGhhdCwgYW4gb3B0aW9u
IHNob3dzLXVwIHRvIGFsbG93IHRoZSBzZWxlY3Rpb24gb2YgdGhlIGN1c3RvbSBzY3JpcHQgKGJ5
IGRlZmF1bHQgaXQgcG9pbnRzIG91dCB0byBydW5xZW11IHNjcmlwdCkgdG8gYmUgdXNlZCBmb3Ig
bGF1bmNoaW5nIHRoaXMgY3VzdG9tIGltYWdlCgpOb3RlOiBpbiBjYXNlIHRoZXJlIGlzIG1vcmUg
dGhhbiBvbmUgdG9nZ2xlZCBpbWFnZSAocWVtdSBydW5uYWJsZSBvciBkZXBsb3lhYmxlKSwgd2hl
biB0aGUgdXNlciBjbGlja3MgdGhlICJSdW4gY3VzdG9tIGltYWdlIiBidXR0b24sIGEgZGlhbG9n
IHdpbGwgYmUgcHJlc2VudGVkLCBhbGxvd2luZyB0byBjaG9vc2UgYmV0d2VlbiBhbnkgb2YgdGhl
IGV4aXN0aW5nIGltYWdlcy4KCltZT0NUTyAjODk0MF0KClNpZ25lZC1vZmYtYnk6IE1pcmVsYSBS
YWJ1bGVhIDxtaXJlbGEucmFidWxlYUBueHAuY29tPgotLS0KIGJpdGJha2UvbGliL2JiL3VpL2Ny
dW1icy9idWlsZGVyLnB5ICAgICAgICAgIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKysKIGJp
dGJha2UvbGliL2JiL3VpL2NydW1icy9pbWFnZWRldGFpbHNwYWdlLnB5IHwgNzIgKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMTMgaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYml0YmFrZS9saWIvYmIvdWkvY3J1bWJzL2J1
aWxkZXIucHkgYi9iaXRiYWtlL2xpYi9iYi91aS9jcnVtYnMvYnVpbGRlci5weQppbmRleCBkY2M0
MTA0Li40NTdjYWRjIDEwMDc1NQotLS0gYS9iaXRiYWtlL2xpYi9iYi91aS9jcnVtYnMvYnVpbGRl
ci5weQorKysgYi9iaXRiYWtlL2xpYi9iYi91aS9jcnVtYnMvYnVpbGRlci5weQpAQCAtMTM1OSw2
ICsxMzU5LDI1IEBAIGNsYXNzIEJ1aWxkZXIoZ3RrLldpbmRvdyk6CiAKICAgICAgICAgcmV0dXJu
IGtlcm5lbF9wYXRoCiAKKyAgICBkZWYgc2hvd19sb2FkX3J1bl9zY3JpcHRfZGlhbG9nKHNlbGYp
OgorICAgICAgICBkaWFsb2cgPSBndGsuRmlsZUNob29zZXJEaWFsb2coIlNlbGVjdCBSdW4gU2Ny
aXB0Iiwgc2VsZiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGd0ay5G
SUxFX0NIT09TRVJfQUNUSU9OX09QRU4pCisgICAgICAgIGJ1dHRvbiA9IGRpYWxvZy5hZGRfYnV0
dG9uKCJDYW5jZWwiLCBndGsuUkVTUE9OU0VfTk8pCisgICAgICAgIEhvYkFsdEJ1dHRvbi5zdHls
ZV9idXR0b24oYnV0dG9uKQorICAgICAgICBidXR0b24gPSBkaWFsb2cuYWRkX2J1dHRvbigiU2Vs
ZWN0IiwgZ3RrLlJFU1BPTlNFX1lFUykKKyAgICAgICAgSG9iQnV0dG9uLnN0eWxlX2J1dHRvbihi
dXR0b24pCisKKyAgICAgICAgZGlhbG9nLnNldF9jdXJyZW50X2ZvbGRlcihzZWxmLnBhcmFtZXRl
cnMuaW1hZ2VfYWRkcikKKworICAgICAgICByZXNwb25zZSA9IGRpYWxvZy5ydW4oKQorICAgICAg
ICBydW5fc2NyaXB0X3BhdGggPSAiIgorICAgICAgICBpZiByZXNwb25zZSA9PSBndGsuUkVTUE9O
U0VfWUVTOgorICAgICAgICAgICAgcnVuX3NjcmlwdF9wYXRoID0gZGlhbG9nLmdldF9maWxlbmFt
ZSgpCisKKyAgICAgICAgZGlhbG9nLmRlc3Ryb3koKQorCisgICAgICAgIHJldHVybiBydW5fc2Ny
aXB0X3BhdGgKKwogICAgIGRlZiBydW5xZW11X2ltYWdlKHNlbGYsIGltYWdlX25hbWUsIGtlcm5l
bF9uYW1lKToKICAgICAgICAgaWYgbm90IGltYWdlX25hbWUgb3Igbm90IGtlcm5lbF9uYW1lOgog
ICAgICAgICAgICAgbGJsID0gIjxiPlBsZWFzZSBzZWxlY3QgJXMgdG8gbGF1bmNoIGluIFFFTVUu
PC9iPiIgJSAoImEga2VybmVsIiBpZiBpbWFnZV9uYW1lIGVsc2UgImFuIGltYWdlIikKQEAgLTEz
OTcsNiArMTQxNiw0NiBAQCBjbGFzcyBCdWlsZGVyKGd0ay5XaW5kb3cpOgogICAgICAgICAgICAg
ZGlhbG9nLnJ1bigpCiAgICAgICAgICAgICBkaWFsb2cuZGVzdHJveSgpCiAKKyAgICBkZWYgcnVu
X2N1c3RvbV9pbWFnZShzZWxmLCBpbWFnZV9uYW1lLCBjdXN0b21fc2ltX3BhdGgpOgorICAgICAg
ICBpZiBub3QgaW1hZ2VfbmFtZSBvciBub3QgY3VzdG9tX3NpbV9wYXRoOgorICAgICAgICAgICAg
aWYgbm90IGltYWdlX25hbWU6CisgICAgICAgICAgICAgICAgbGJsID0gIjxiPlBsZWFzZSBzZWxl
Y3QgYW4gaW1hZ2UgdG8gbGF1bmNoIGluIHRoZSBjdXN0b20gc2ltdWxhdG9yLjwvYj4iCisgICAg
ICAgICAgICBlbHNlOgorICAgICAgICAgICAgICAgIGxibCA9ICI8Yj5QbGVhc2Ugc2VsZWN0IGEg
Y3VzdG9tIHNpbXVsYXRvciBmb3IgbGF1bmNoaW5nIHRoZSBzZWxlY3RlZCBpbWFnZS48L2I+Igor
ICAgICAgICAgICAgZGlhbG9nID0gQ3J1bWJzTWVzc2FnZURpYWxvZyhzZWxmLCBsYmwsIGd0ay5N
RVNTQUdFX0lORk8pCisgICAgICAgICAgICBidXR0b24gPSBkaWFsb2cuYWRkX2J1dHRvbigiQ2xv
c2UiLCBndGsuUkVTUE9OU0VfT0spCisgICAgICAgICAgICBIb2JCdXR0b24uc3R5bGVfYnV0dG9u
KGJ1dHRvbikKKyAgICAgICAgICAgIGRpYWxvZy5ydW4oKQorICAgICAgICAgICAgZGlhbG9nLmRl
c3Ryb3koKQorICAgICAgICAgICAgcmV0dXJuCisKKyAgICAgICAgaW1hZ2VfcGF0aCA9IG9zLnBh
dGguam9pbihzZWxmLnBhcmFtZXRlcnMuaW1hZ2VfYWRkciwgaW1hZ2VfbmFtZSkKKworICAgICAg
ICBzb3VyY2VfZW52X3BhdGggPSBvcy5wYXRoLmpvaW4oc2VsZi5wYXJhbWV0ZXJzLmNvcmVfYmFz
ZSwgIm9lLWluaXQtYnVpbGQtZW52IikKKyAgICAgICAgdG1wX3BhdGggPSBzZWxmLnBhcmFtZXRl
cnMudG1wZGlyCisgICAgICAgIGNtZGxpbmUgPSBiYi51aS5jcnVtYnMudXRpbHMud2hpY2hfdGVy
bWluYWwoKQorICAgICAgICBpZiBvcy5wYXRoLmV4aXN0cyhpbWFnZV9wYXRoKSBhbmQgb3MucGF0
aC5leGlzdHMoY3VzdG9tX3NpbV9wYXRoKSBcCisgICAgICAgICAgIGFuZCBvcy5wYXRoLmV4aXN0
cyhzb3VyY2VfZW52X3BhdGgpIGFuZCBvcy5wYXRoLmV4aXN0cyh0bXBfcGF0aCkgXAorICAgICAg
ICAgICBhbmQgY21kbGluZToKKyAgICAgICAgICAgIGNtZGxpbmUgKz0gIlwnIGJhc2ggLWMgXCJl
eHBvcnQgT0VfVE1QRElSPSIgKyB0bXBfcGF0aCArICI7ICIKKyAgICAgICAgICAgIGNtZGxpbmUg
Kz0gInNvdXJjZSAiICsgc291cmNlX2Vudl9wYXRoICsgIiAiICsgb3MuZ2V0Y3dkKCkgKyAiOyAi
CisgICAgICAgICAgICBjbWRsaW5lICs9IGN1c3RvbV9zaW1fcGF0aCArICIgIiArIGltYWdlX3Bh
dGggKyAiXCJcJyIKKyAgICAgICAgICAgIHN1YnByb2Nlc3MuUG9wZW4oc2hsZXguc3BsaXQoY21k
bGluZSkpCisgICAgICAgIGVsc2U6CisgICAgICAgICAgICBsYmwgPSAiPGI+UGF0aCBlcnJvcjwv
Yj4iCisgICAgICAgICAgICBtc2cgPSAiT25lIG9mIHlvdXIgcGF0aHMgaXMgd3JvbmcsIgorICAg
ICAgICAgICAgbXNnID0gbXNnICsgIiBwbGVhc2UgbWFrZSBzdXJlIHRoZSBmb2xsb3dpbmcgcGF0
aHMgZXhpc3Q6XG4iCisgICAgICAgICAgICBtc2cgPSBtc2cgKyAiaW1hZ2UgcGF0aDoiICsgaW1h
Z2VfcGF0aCArICJcbiIKKyAgICAgICAgICAgIG1zZyA9IG1zZyArICJjdXN0b20gc2ltdWxhdG9y
IHBhdGg6IiArIGN1c3RvbV9zaW1fcGF0aCArICJcbiIKKyAgICAgICAgICAgIG1zZyA9IG1zZyAr
ICJzb3VyY2UgZW52aXJvbm1lbnQgcGF0aDoiICsgc291cmNlX2Vudl9wYXRoICsgIlxuIgorICAg
ICAgICAgICAgbXNnID0gbXNnICsgInRtcCBwYXRoOiAiICsgdG1wX3BhdGggKyAiLiIKKyAgICAg
ICAgICAgIG1zZyA9IG1zZyArICJZb3UgbWF5IGJlIG1pc3NpbmcgZWl0aGVyIHh0ZXJtIG9yIHZ0
ZSBmb3IgdGVybWluYWwgc2VydmljZXMuIgorICAgICAgICAgICAgZGlhbG9nID0gQ3J1bWJzTWVz
c2FnZURpYWxvZyhzZWxmLCBsYmwsIGd0ay5NRVNTQUdFX0VSUk9SLCBtc2cpCisgICAgICAgICAg
ICBidXR0b24gPSBkaWFsb2cuYWRkX2J1dHRvbigiQ2xvc2UiLCBndGsuUkVTUE9OU0VfT0spCisg
ICAgICAgICAgICBIb2JCdXR0b24uc3R5bGVfYnV0dG9uKGJ1dHRvbikKKyAgICAgICAgICAgIGRp
YWxvZy5ydW4oKQorICAgICAgICAgICAgZGlhbG9nLmRlc3Ryb3koKQorCiAgICAgZGVmIHNob3df
cGFja2FnZXMoc2VsZik6CiAgICAgICAgIHNlbGYucGFja2FnZV9kZXRhaWxzX3BhZ2UucmVmcmVz
aF90YWJsZXMoKQogICAgICAgICBzZWxmLnN3aXRjaF9wYWdlKHNlbGYuUEFDS0FHRV9TRUxFQ1RJ
T04pCmRpZmYgLS1naXQgYS9iaXRiYWtlL2xpYi9iYi91aS9jcnVtYnMvaW1hZ2VkZXRhaWxzcGFn
ZS5weSBiL2JpdGJha2UvbGliL2JiL3VpL2NydW1icy9pbWFnZWRldGFpbHNwYWdlLnB5CmluZGV4
IDM1MmU5NDguLjMyZDQ4NTQgMTAwNzU1Ci0tLSBhL2JpdGJha2UvbGliL2JiL3VpL2NydW1icy9p
bWFnZWRldGFpbHNwYWdlLnB5CisrKyBiL2JpdGJha2UvbGliL2JiL3VpL2NydW1icy9pbWFnZWRl
dGFpbHNwYWdlLnB5CkBAIC0zMDMsNyArMzAzLDcgQEAgY2xhc3MgSW1hZ2VEZXRhaWxzUGFnZSAo
SG9iUGFnZSk6CiAgICAgICAgICAgICBpID0gaSArIDEKICAgICAgICAgICAgIHNlbGYubnVtX3Rv
Z2dsZWQgKz0gaXNfdG9nZ2xlZAogCi0gICAgICAgIGlzX3J1bm5hYmxlID0gc2VsZi5jcmVhdGVf
Ym90dG9tX2J1dHRvbnMoc2VsZi5idXR0b25saXN0LCBzZWxmLnRvZ2dsZWRfaW1hZ2UpCisgICAg
ICAgIHNlbGYuaXNfcnVubmFibGUgPSBzZWxmLmNyZWF0ZV9ib3R0b21fYnV0dG9ucyhzZWxmLmJ1
dHRvbmxpc3QsIHNlbGYudG9nZ2xlZF9pbWFnZSkKIAogICAgICAgICAjIEdlbmVyYXRlZCBpbWFn
ZSBmaWxlcyBpbmZvCiAgICAgICAgIHZhcmxpc3QgPSBbIk5hbWU6ICIsICJGaWxlcyBjcmVhdGVk
OiAiLCAiRGlyZWN0b3J5OiAiXQpAQCAtMzI0LDEwICszMjQsMjMgQEAgY2xhc3MgSW1hZ2VEZXRh
aWxzUGFnZSAoSG9iUGFnZSk6CiAgICAgICAgIHNlbGYuaW1hZ2VfZGV0YWlsID0gc2VsZi5EZXRh
aWxCb3godmFybGlzdD12YXJsaXN0LCB2YWxsaXN0PXZhbGxpc3QsIGJ1dHRvbj12aWV3X2ZpbGVz
X2J1dHRvbiwgYnV0dG9uMj1vcGVuX2xvZ19idXR0b24pCiAgICAgICAgIHNlbGYuYm94X2dyb3Vw
X2FyZWEucGFja19zdGFydChzZWxmLmltYWdlX2RldGFpbCwgZXhwYW5kPUZhbHNlLCBmaWxsPVRy
dWUpCiAKKyAgICAgICAgIyBUaGUgZGVmYXVsdCBzY3JpcHQgcGF0aCB0byBydW4gdGhlIGltYWdl
IChydW5xZW11KQorICAgICAgICBzZWxmLnJ1bl9zY3JpcHRfcGF0aCA9IG9zLnBhdGguam9pbihz
ZWxmLmJ1aWxkZXIucGFyYW1ldGVycy5jb3JlX2Jhc2UsICJzY3JpcHRzL3J1bnFlbXUiKQorICAg
ICAgICBzZWxmLnJ1bl9zY3JpcHRfZGV0YWlsID0gTm9uZQorICAgICAgICB2YXJsaXN0ID0gWyJS
dW4gc2NyaXB0OiAiXQorICAgICAgICB2YWxsaXN0ID0gW10KKyAgICAgICAgdmFsbGlzdC5hcHBl
bmQoc2VsZi5ydW5fc2NyaXB0X3BhdGgpCisKKyAgICAgICAgY2hhbmdlX3J1bl9zY3JpcHRfYnV0
dG9uID0gSG9iQWx0QnV0dG9uKCJDaGFuZ2UiKQorICAgICAgICBjaGFuZ2VfcnVuX3NjcmlwdF9i
dXR0b24uY29ubmVjdCgiY2xpY2tlZCIsIHNlbGYuY2hhbmdlX3J1bl9zY3JpcHRfY2IpCisgICAg
ICAgIGNoYW5nZV9ydW5fc2NyaXB0X2J1dHRvbi5zZXRfdG9vbHRpcF90ZXh0KCJDaGFuZ2UgcnVu
IHNjcmlwdCIpCisgICAgICAgIHNlbGYucnVuX3NjcmlwdF9kZXRhaWwgPSBzZWxmLkRldGFpbEJv
eCh2YXJsaXN0PXZhcmxpc3QsIHZhbGxpc3Q9dmFsbGlzdCwgYnV0dG9uPWNoYW5nZV9ydW5fc2Ny
aXB0X2J1dHRvbikKKyAgICAgICAgc2VsZi5ib3hfZ3JvdXBfYXJlYS5wYWNrX3N0YXJ0KHNlbGYu
cnVuX3NjcmlwdF9kZXRhaWwsIGV4cGFuZD1GYWxzZSwgZmlsbD1UcnVlKQorCiAgICAgICAgICMg
VGhlIGRlZmF1bHQga2VybmVsIGJveCBmb3IgdGhlIHFlbXUgaW1hZ2VzCiAgICAgICAgIHNlbGYu
c2VsX2tlcm5lbCA9ICIiCiAgICAgICAgIHNlbGYua2VybmVsX2RldGFpbCA9IE5vbmUKLSAgICAg
ICAgaWYgJ3FlbXUnIGluIGltYWdlX25hbWU6CisgICAgICAgIGlmIHNlbGYudGVzdF9tYWNoX3J1
bm5hYmxlKGltYWdlX25hbWUpOgogICAgICAgICAgICAgc2VsZi5zZWxfa2VybmVsID0gc2VsZi5n
ZXRfa2VybmVsX2ZpbGVfbmFtZSgpCiAKICAgICAgICAgIyAgICB2YXJsaXN0ID0gWyJLZXJuZWw6
ICJdCkBAIC00MDEsOCArNDE0LDEwIEBAIGNsYXNzIEltYWdlRGV0YWlsc1BhZ2UgKEhvYlBhZ2Up
OgogICAgICAgICAgICAgc2VsZi5ib3hfZ3JvdXBfYXJlYS5wYWNrX3N0YXJ0KHNlbGYuZGV0YWls
c19ib3R0b21fYnV0dG9ucywgZXhwYW5kPUZhbHNlLCBmaWxsPUZhbHNlKQogCiAgICAgICAgIHNl
bGYuc2hvd19hbGwoKQotICAgICAgICBpZiBzZWxmLmtlcm5lbF9kZXRhaWwgYW5kIChub3QgaXNf
cnVubmFibGUpOgorICAgICAgICBpZiBzZWxmLmtlcm5lbF9kZXRhaWwgYW5kIChub3Qgc2VsZi5p
c19ydW5uYWJsZSk6CiAgICAgICAgICAgICBzZWxmLmtlcm5lbF9kZXRhaWwuaGlkZSgpCisgICAg
ICAgIGlmIHNlbGYucnVuX3NjcmlwdF9kZXRhaWwgYW5kIHNlbGYuaXNfcnVubmFibGU6CisgICAg
ICAgICAgICBzZWxmLnJ1bl9zY3JpcHRfZGV0YWlsLmhpZGUoKQogICAgICAgICBzZWxmLmltYWdl
X3NhdmVkID0gRmFsc2UKIAogICAgIGRlZiB2aWV3X2ZpbGVzX2NsaWNrZWRfY2Ioc2VsZiwgYnV0
dG9uLCBpbWFnZV9hZGRyKToKQEAgLTQ4NCw3ICs0OTksOSBAQCBjbGFzcyBJbWFnZURldGFpbHNQ
YWdlIChIb2JQYWdlKToKICAgICAgICAgICAgIGlmICAoYWN0aW9uX2F0dHIgPT0gJ3J1bicgYW5k
IHByaW1hcnlfYWN0aW9uID09ICJSdW4gaW1hZ2UiKSBcCiAgICAgICAgICAgICAgb3IgKGFjdGlv
bl9hdHRyID09ICdkZXBsb3knIGFuZCBwcmltYXJ5X2FjdGlvbiA9PSAiRGVwbG95IGltYWdlIik6
CiAgICAgICAgICAgICAgICAgYWN0aW9uX2ltYWdlcy5hcHBlbmQoZmlsZWl0ZW0pCi0KKyAgICAg
ICAgaWYgIChsZW4oYWN0aW9uX2ltYWdlcykgPT0gMCBhbmQgcHJpbWFyeV9hY3Rpb24gPT0gIlJ1
biBpbWFnZSIpOgorICAgICAgICAgICAgIyBpZiB0aGVyZSBhcmUgbm8gcWVtdSBydW5uYWJsZSBp
bWFnZXMsIGxldCB0aGUgdXNlciBjaG9vc2UgYW55IG9mIHRoZSBleGlzdGluZyBpbWFnZXMgZm9y
IGN1c3RvbSBydW4KKyAgICAgICAgICAgIGFjdGlvbl9pbWFnZXMgPSBzZWxmLmltYWdlX3N0b3Jl
CiAgICAgICAgICMgcGFjayB0aGUgY29ycmVzcG9uZGluZyAncnVubmFibGUnIG9yICdkZXBsb3kn
IHJhZGlvX2J1dHRvbnMsIGlmIHRoZXJlIGhhcyBubyBtb3JlIHRoYW4gb25lIGZpbGUuCiAgICAg
ICAgICMgYXNzdW1lIHRoYXQgdGhlcmUgZG9lcyBub3QgYm90aCBoYXZlICdkZXBsb3knIGFuZCAn
cnVubmFibGUnIGZpbGVzIGluIHRoZSBzYW1lIGJ1aWxkaW5nIHJlc3VsdAogICAgICAgICAjIGlu
IHBvc3NpYmxlIGFzIGRlc2lnbi4KQEAgLTQ5OSw3ICs1MTYsOSBAQCBjbGFzcyBJbWFnZURldGFp
bHNQYWdlIChIb2JQYWdlKToKICAgICAgICAgZm9yIGZpbGVpdGVtIGluIGFjdGlvbl9pbWFnZXM6
CiAgICAgICAgICAgICBzZWxfYnRuID0gZ3RrLlJhZGlvQnV0dG9uKHNlbF9wYXJlbnRfYnRuLCBm
aWxlaXRlbVsndHlwZSddKQogICAgICAgICAgICAgc2VsX3BhcmVudF9idG4gPSBzZWxfYnRuIGlm
IG5vdCBzZWxfcGFyZW50X2J0biBlbHNlIHNlbF9wYXJlbnRfYnRuCi0gICAgICAgICAgICBzZWxf
YnRuLnNldF9hY3RpdmUoZmlsZWl0ZW1bJ2lzX3RvZ2dsZWQnXSkKKyAgICAgICAgICAgIGlmIGN1
cnJfcm93ID09IDA6CisgICAgICAgICAgICAgICAgc2VsX2J0bi5zZXRfYWN0aXZlKFRydWUpCisg
ICAgICAgICAgICAgICAgc2VsZi50b2dnbGVkX2ltYWdlID0gZmlsZWl0ZW1bJ25hbWUnXQogICAg
ICAgICAgICAgc2VsX2J0bi5jb25uZWN0KCd0b2dnbGVkJywgc2VsZi50YWJsZV9zZWxlY3RlZF9j
YiwgZmlsZWl0ZW0pCiAgICAgICAgICAgICBpZiBjdXJyX3JvdyA8IDEwOgogICAgICAgICAgICAg
ICAgIHRhYmxlLmF0dGFjaChzZWxfYnRuLCAwLCA0LCBjdXJyX3JvdywgY3Vycl9yb3cgKyAxLCB4
cGFkZGluZz0yNCkKQEAgLTUyMywxMyArNTQyLDE1IEBAIGNsYXNzIEltYWdlRGV0YWlsc1BhZ2Ug
KEhvYlBhZ2UpOgogCiAgICAgICAgIGlmIHJlc3BvbnNlICE9IGd0ay5SRVNQT05TRV9ZRVM6CiAg
ICAgICAgICAgICByZXR1cm4KLQorICAgICAgICAjIHBlcmZvcm0gdGhlIHByaW1hcnkgYWN0aW9u
IG9uIHRoZSBpbWFnZSBzZWxlY3RlZCBieSB0aGUgdXNlcgogICAgICAgICBmb3IgZmlsZWl0ZW0g
aW4gc2VsZi5pbWFnZV9zdG9yZToKLSAgICAgICAgICAgIGlmIGZpbGVpdGVtWydpc190b2dnbGVk
J106Ci0gICAgICAgICAgICAgICAgaWYgZmlsZWl0ZW1bJ2FjdGlvbl9hdHRyJ10gPT0gJ3J1bic6
CisgICAgICAgICAgICBpZiBmaWxlaXRlbVsnbmFtZSddID09IHNlbGYudG9nZ2xlZF9pbWFnZToK
KyAgICAgICAgICAgICAgICBpZiAoZmlsZWl0ZW1bJ2FjdGlvbl9hdHRyJ10gPT0gJ3J1bicgYW5k
IHByaW1hcnlfYWN0aW9uID09ICJSdW4gaW1hZ2UiKToKICAgICAgICAgICAgICAgICAgICAgc2Vs
Zi5idWlsZGVyLnJ1bnFlbXVfaW1hZ2UoZmlsZWl0ZW1bJ25hbWUnXSwgc2VsZi5zZWxfa2VybmVs
KQotICAgICAgICAgICAgICAgIGVsaWYgZmlsZWl0ZW1bJ2FjdGlvbl9hdHRyJ10gPT0gJ2RlcGxv
eSc6CisgICAgICAgICAgICAgICAgZWxpZiAoZmlsZWl0ZW1bJ2FjdGlvbl9hdHRyJ10gPT0gJ2Rl
cGxveScgYW5kIHByaW1hcnlfYWN0aW9uID09ICJEZXBsb3kgaW1hZ2UiKToKICAgICAgICAgICAg
ICAgICAgICAgc2VsZi5idWlsZGVyLmRlcGxveV9pbWFnZShmaWxlaXRlbVsnbmFtZSddKQorICAg
ICAgICAgICAgICAgIGVsaWYgKHByaW1hcnlfYWN0aW9uID09ICJSdW4gaW1hZ2UiKToKKyAgICAg
ICAgICAgICAgICAgICAgc2VsZi5idWlsZGVyLnJ1bl9jdXN0b21faW1hZ2UoZmlsZWl0ZW1bJ25h
bWUnXSwgc2VsZi5ydW5fc2NyaXB0X3BhdGgpCiAKICAgICBkZWYgdGFibGVfc2VsZWN0ZWRfY2Io
c2VsZiwgdGJ1dHRvbiwgaW1hZ2UpOgogICAgICAgICBpbWFnZVsnaXNfdG9nZ2xlZCddID0gdGJ1
dHRvbi5nZXRfYWN0aXZlKCkKQEAgLTU0MSw5ICs1NjIsMTQgQEAgY2xhc3MgSW1hZ2VEZXRhaWxz
UGFnZSAoSG9iUGFnZSk6CiAgICAgICAgIGlmIGtlcm5lbF9wYXRoIGFuZCBzZWxmLmtlcm5lbF9k
ZXRhaWw6CiAgICAgICAgICAgICBpbXBvcnQgb3MucGF0aAogICAgICAgICAgICAgc2VsZi5zZWxf
a2VybmVsID0gb3MucGF0aC5iYXNlbmFtZShrZXJuZWxfcGF0aCkKLSAgICAgICAgICAgIG1hcmt1
cCA9IHNlbGYua2VybmVsX2RldGFpbC5mb3JtYXRfbGluZSgiS2VybmVsOiAiLCBzZWxmLnNlbF9r
ZXJuZWwpCi0gICAgICAgICAgICBsYWJlbCA9ICgoc2VsZi5rZXJuZWxfZGV0YWlsLmdldF9jaGls
ZHJlbigpWzBdKS5nZXRfY2hpbGRyZW4oKVswXSkuZ2V0X2NoaWxkcmVuKClbMF0KLSAgICAgICAg
ICAgIGxhYmVsLnNldF9tYXJrdXAobWFya3VwKQorICAgICAgICAgICAgc2VsZi5rZXJuZWxfZGV0
YWlsLnVwZGF0ZV9saW5lX3dpZGdldHMoIktlcm5lbDogIiwgc2VsZi5zZWxfa2VybmVsKTsKKwor
ICAgIGRlZiBjaGFuZ2VfcnVuX3NjcmlwdF9jYihzZWxmLCB3aWRnZXQpOgorICAgICAgICBzZWxm
LnJ1bl9zY3JpcHRfcGF0aCA9IHNlbGYuYnVpbGRlci5zaG93X2xvYWRfcnVuX3NjcmlwdF9kaWFs
b2coKQorICAgICAgICBpZiBzZWxmLnJ1bl9zY3JpcHRfcGF0aCBhbmQgc2VsZi5ydW5fc2NyaXB0
X2RldGFpbDoKKyAgICAgICAgICAgIGltcG9ydCBvcy5wYXRoCisgICAgICAgICAgICBzZWxmLnNl
bF9ydW5fc2NyaXB0ID0gb3MucGF0aC5iYXNlbmFtZShzZWxmLnJ1bl9zY3JpcHRfcGF0aCkKKyAg
ICAgICAgICAgIHNlbGYucnVuX3NjcmlwdF9kZXRhaWwudXBkYXRlX2xpbmVfd2lkZ2V0cygiUnVu
IHNjcmlwdDogIiwgc2VsZi5ydW5fc2NyaXB0X3BhdGgpCiAKICAgICBkZWYgY3JlYXRlX2JvdHRv
bV9idXR0b25zKHNlbGYsIGJ1dHRvbmxpc3QsIGltYWdlX25hbWUpOgogICAgICAgICAjIENyZWF0
ZSB0aGUgYnV0dG9ucyBhdCB0aGUgYm90dG9tCkBAIC01NjYsMjYgKzU5MiwzMyBAQCBjbGFzcyBJ
bWFnZURldGFpbHNQYWdlIChIb2JQYWdlKToKICAgICAgICAgICAgIHBhY2tlZCA9IFRydWUKIAog
ICAgICAgICBuYW1lID0gIlJ1biBpbWFnZSIKLSAgICAgICAgaWYgbmFtZSBpbiBidXR0b25saXN0
IGFuZCBzZWxmLnRlc3RfdHlwZV9ydW5uYWJsZShpbWFnZV9uYW1lKSBhbmQgc2VsZi50ZXN0X21h
Y2hfcnVubmFibGUoaW1hZ2VfbmFtZSk6CisgICAgICAgIGlmIG5hbWUgaW4gYnV0dG9ubGlzdDoK
KyAgICAgICAgICAgIG5hbWUgPSAiUnVuIHFlbXUgaW1hZ2UiCisgICAgICAgICAgICBpc19ydW5u
YWJsZSA9IFRydWUKKyAgICAgICAgICAgIGlmIG5vdCAoc2VsZi50ZXN0X3R5cGVfcnVubmFibGUo
aW1hZ2VfbmFtZSkgYW5kIHNlbGYudGVzdF9tYWNoX3J1bm5hYmxlKGltYWdlX25hbWUpKToKKyAg
ICAgICAgICAgICAgICBuYW1lID0gIlJ1biBjdXN0b20gaW1hZ2UiCisgICAgICAgICAgICAgICAg
aXNfcnVubmFibGUgPSBGYWxzZQogICAgICAgICAgICAgaWYgY3JlYXRlZCA9PSBUcnVlOgogICAg
ICAgICAgICAgICAgICMgc2VwYXJhdG9yCiAgICAgICAgICAgICAgICAgI2xhYmVsID0gZ3RrLkxh
YmVsKCIgb3IgIikKICAgICAgICAgICAgICAgICAjc2VsZi5kZXRhaWxzX2JvdHRvbV9idXR0b25z
LnBhY2tfZW5kKGxhYmVsLCBleHBhbmQ9RmFsc2UsIGZpbGw9RmFsc2UpCiAKICAgICAgICAgICAg
ICAgICAjIGNyZWF0ZSBidXR0b24gIlJ1biBpbWFnZSIKLSAgICAgICAgICAgICAgICBydW5fYnV0
dG9uID0gSG9iQWx0QnV0dG9uKCJSdW4gaW1hZ2UiKQorICAgICAgICAgICAgICAgIHJ1bl9idXR0
b24gPSBIb2JBbHRCdXR0b24obmFtZSkKICAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAg
ICAgIyBjcmVhdGUgYnV0dG9uICJSdW4gaW1hZ2UiIGFzIHRoZSBwcmltYXJ5IGJ1dHRvbgotICAg
ICAgICAgICAgICAgIHJ1bl9idXR0b24gPSBIb2JCdXR0b24oIlJ1biBpbWFnZSIpCisgICAgICAg
ICAgICAgICAgcnVuX2J1dHRvbiA9IEhvYkJ1dHRvbihuYW1lKQogICAgICAgICAgICAgICAgICNy
dW5fYnV0dG9uLnNldF9zaXplX3JlcXVlc3QoMjA1LCA0OSkKICAgICAgICAgICAgICAgICBydW5f
YnV0dG9uLnNldF9mbGFncyhndGsuQ0FOX0RFRkFVTFQpCiAgICAgICAgICAgICAgICAgcGFja2Vk
ID0gVHJ1ZQotICAgICAgICAgICAgcnVuX2J1dHRvbi5zZXRfdG9vbHRpcF90ZXh0KCJTdGFydCB1
cCBhbiBpbWFnZSB3aXRoIHFlbXUgZW11bGF0b3IiKQorICAgICAgICAgICAgaWYgaXNfcnVubmFi
bGU6CisgICAgICAgICAgICAgICAgcnVuX2J1dHRvbi5zZXRfdG9vbHRpcF90ZXh0KCJTdGFydCB1
cCBhbiBpbWFnZSB3aXRoIHFlbXUgZW11bGF0b3IiKQorICAgICAgICAgICAgZWxzZToKKyAgICAg
ICAgICAgICAgICBydW5fYnV0dG9uLnNldF90b29sdGlwX3RleHQoIlN0YXJ0IHVwIGFuIGltYWdl
IHdpdGggY3VzdG9tIHNpbXVsYXRvciIpCiAgICAgICAgICAgICBidXR0b25faWQgPSBydW5fYnV0
dG9uLmNvbm5lY3QoImNsaWNrZWQiLCBzZWxmLnJ1bl9idXR0b25fY2xpY2tlZF9jYikKICAgICAg
ICAgICAgIHNlbGYuYnV0dG9uX2lkc1tidXR0b25faWRdID0gcnVuX2J1dHRvbgogICAgICAgICAg
ICAgc2VsZi5kZXRhaWxzX2JvdHRvbV9idXR0b25zLnBhY2tfZW5kKHJ1bl9idXR0b24sIGV4cGFu
ZD1GYWxzZSwgZmlsbD1GYWxzZSkKICAgICAgICAgICAgIGNyZWF0ZWQgPSBUcnVlCi0gICAgICAg
ICAgICBpc19ydW5uYWJsZSA9IFRydWUKIAogICAgICAgICBuYW1lID0gIlNhdmUgaW1hZ2UgcmVj
aXBlIgogICAgICAgICBpZiBuYW1lIGluIGJ1dHRvbmxpc3QgYW5kIHNlbGYuYnVpbGRlci5yZWNp
cGVfbW9kZWwuaXNfY3VzdG9tX2ltYWdlKCk6CkBAIC02MjgsNyArNjYxLDEwIEBAIGNsYXNzIElt
YWdlRGV0YWlsc1BhZ2UgKEhvYlBhZ2UpOgogICAgICAgICAgICAgICAgIHNlbGYuc2hvd19idWls
ZGVkX2ltYWdlc19kaWFsb2coTm9uZSwgIlJ1biBpbWFnZSIpCiAgICAgICAgICAgICAgICAgc2Vs
Zi5zZXRfc2Vuc2l0aXZlKFRydWUpCiAgICAgICAgICAgICBlbHNlOgotICAgICAgICAgICAgICAg
IHNlbGYuYnVpbGRlci5ydW5xZW11X2ltYWdlKHNlbGYudG9nZ2xlZF9pbWFnZSwgc2VsZi5zZWxf
a2VybmVsKQorICAgICAgICAgICAgICAgIGlmIHNlbGYuaXNfcnVubmFibGU6CisgICAgICAgICAg
ICAgICAgICAgIHNlbGYuYnVpbGRlci5ydW5xZW11X2ltYWdlKHNlbGYudG9nZ2xlZF9pbWFnZSwg
c2VsZi5zZWxfa2VybmVsKQorICAgICAgICAgICAgICAgIGVsc2U6CisgICAgICAgICAgICAgICAg
ICAgIHNlbGYuYnVpbGRlci5ydW5fY3VzdG9tX2ltYWdlKHNlbGYudG9nZ2xlZF9pbWFnZSwgc2Vs
Zi5ydW5fc2NyaXB0X3BhdGgpCiAKICAgICBkZWYgc2F2ZV9idXR0b25fY2xpY2tlZF9jYihzZWxm
LCBidXR0b24pOgogICAgICAgICB0b3BkaXIgPSBzZWxmLmJ1aWxkZXIuZ2V0X3RvcGRpcigpCi0t
IAoxLjkuMQoK

--_002_VI1PR0401MB1789BE8BA7AD90A09B2C23E18FAB0VI1PR0401MB1789_--
