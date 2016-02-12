Return-Path: <mirela.rabulea@nxp.com>
X-Greylist: delayed 845 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 12 Feb 2016 22:58:03 UTC
Received: from emea01-am1-obe.outbound.protection.outlook.com
	(mail-am1on0090.outbound.protection.outlook.com [157.56.112.90])
	by mail.openembedded.org (Postfix) with ESMTP id 63C54731D8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Feb 2016 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
	s=selector1-nxp-com;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=RQgakkj1GQc+a2s8YONSna3Ko4I5JqFephV6VL7rnM4=;
	b=mgzUlbYibwInxDBiKcDQVUHWZaVZaV/YqqPfaN8EltHrqfKETPksDWm+N55SWY0yqgpx5+HlM1eDicZPs9qmkH5GUUrhS5+ULhjusfIw3ptkyF80Gmuy/rmm2k16rzQnTEYH0SuEU0LAMK1AG+1grT1ETwPV8eEYlcvD1G5gdiM=
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com (10.165.234.151) by
	VI1PR0401MB1791.eurprd04.prod.outlook.com (10.165.234.153) with
	Microsoft
	SMTP Server (TLS) id 15.1.409.15; Fri, 12 Feb 2016 22:43:58 +0000
Received: from VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) by
	VI1PR0401MB1789.eurprd04.prod.outlook.com ([10.165.234.151]) with
	mapi id 15.01.0409.017; Fri, 12 Feb 2016 22:43:58 +0000
From: Mirela Rabulea <mirela.rabulea@nxp.com>
To: Mirela Rabulea <mirela.rabulea@nxp.com>, Joshua G Lock
	<joshua.g.lock@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Fix bug 8940 - Alow Hob to run images on
	a custom simulator, other than qemu
Thread-Index: AdFUYtl3YI4m24hVQ1y2SKaptI//vAEqJteAAYcSAQABR/CXgAAYZWPAAE51+FA=
Date: Fri, 12 Feb 2016 22:43:57 +0000
Message-ID: <VI1PR0401MB17898F62326CD302A05CD3F38FA90@VI1PR0401MB1789.eurprd04.prod.outlook.com>
References: <AM4PR0401MB1778CA63CBE3FE654CB9EDC78FC30@AM4PR0401MB1778.eurprd04.prod.outlook.com>
	<1453903391.3557.42.camel@linux.intel.com>
	<VI1PR0401MB1789EE35802D99452B8F12638FD10@VI1PR0401MB1789.eurprd04.prod.outlook.com>
	<1455138641.3442.8.camel@linux.intel.com>
	<VI1PR0401MB178927E4A92EFB4DC3E706978FA80@VI1PR0401MB1789.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB178927E4A92EFB4DC3E706978FA80@VI1PR0401MB1789.eurprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
	header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [192.88.146.1]
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB1791;
	5:JiGVKKgi9j1IP5X0dd9AmpxOBGtQ9SJFsoNMmLLtLZf24wWXvTSImbXEXepHnE1HFtwhvBlLLbAf26YXwskN93gAYugCUI0OFM/qQApn5TAub7gjx/wyNMmprPADBxSJA2yhlrHSeJhmoszVbU64Ng==;
	24:VVOw2Ym6jLk1ntmOSjuZFQp+r9tsy01Ris80dpYxXiPEer9+TqxDwpJIhHiZcH6T5Vxnf2MgUqUGxQnhE4MGRVwzA/vyHFgPtEsQ45reOF0=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB1791;
x-ms-office365-filtering-correlation-id: d1ff127b-2c3b-482f-5aa3-08d333fdfea6
x-microsoft-antispam-prvs: <VI1PR0401MB1791D817B02FB2E6AA7447EA8FA90@VI1PR0401MB1791.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(102415293)(102615271)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);
	SRVR:VI1PR0401MB1791; BCL:0; PCL:0; RULEID:;
	SRVR:VI1PR0401MB1791; 
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(6009001)(13464003)(377454003)(5001960100002)(74316001)(54356999)(3660700001)(10400500002)(87936001)(5008740100001)(40100003)(3280700002)(33656002)(122556002)(99936001)(50986999)(3846002)(11100500001)(92566002)(5002640100001)(76176999)(2501003)(5890100001)(77096005)(76576001)(5003600100002)(5001770100001)(86362001)(19580395003)(19580405001)(2906002)(5004730100002)(93886004)(586003)(2900100001)(66066001)(4326007)(1220700001)(1096002)(6116002)(2950100001)(102836003)(189998001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB1791;
	H:VI1PR0401MB1789.eurprd04.prod.outlook.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2016 22:43:57.9241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1791
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
X-List-Received-Date: Fri, 12 Feb 2016 22:58:07 -0000
X-Groupsio-MsgNum: 7028
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_VI1PR0401MB17898F62326CD302A05CD3F38FA90VI1PR0401MB1789_"

--_002_VI1PR0401MB17898F62326CD302A05CD3F38FA90VI1PR0401MB1789_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,
I got my own core-image-minimal for non-qemu machine (genericx86-64) and I =
can reproduce the same behavior you saw, please see more explaining below.
I have made a v3 patch to fix this, only v3 changes at the end of email, fo=
r easier review.
The squashed version of the patch is attached (initial changes+v2+v3), with=
 updated comment:
	"Note: in case there is more than one toggled image (qemu runnable or depl=
oyable), when the user clicks the "Run custom image" button, a dialog will =
be presented, allowing to choose between any of the existing images."

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Mirela Rabulea
> Sent: Thursday, February 11, 2016 1:19 PM
> To: Joshua G Lock <joshua.g.lock@linux.intel.com>; bitbake-
> devel@lists.openembedded.org
> Cc: Nicolae Manescu <nicu.manescu@nxp.com>; Alexandru Purice
> <alexandru.purice@nxp.com>; Roman, Alexandru CostinX
> <alexandru.costinx.roman@intel.com>; Voiculescu, BogdanX A
> <bogdanx.a.voiculescu@intel.com>
> Subject: Re: [bitbake-devel] [PATCH] Fix bug 8940 - Alow Hob to run image=
s
> on a custom simulator, other than qemu
>=20
>=20
> > but when I click 'Run custom image' I get a dialogue asking to 'Select
> > the image file you want to run:' with 'Cancel' and 'Run image' buttons
> > but nothing listing selectable images (I even tried resizing the
> > dialogue, to no avail). If I proceed to click 'Run image' button the 'U=
sb
> image maker'
> > dialogue is presented.
> >
>=20
> That must come from poky\bitbake\lib\bb\ui\crumbs\imagedetailspage.py,
> show_builded_images_dialog(). I'm not sure how I can reproduce this
> without waiting a day to build another image, and without some tens of GB
> which I don't know if I have. I will try it but it will take a while. In =
the
> meantime, if you still have the environment, could you add this print in =
your
> imagedetailspage.py, it will let us see how many toggled images you have =
(I
> suspect is more than 1), and which ones (it shows up in the terminal wher=
e
> hob was started):
>             self.image_store.append({'name': image_name,
>                                     'type': image_type,
>                                     'size': image_size,
>                                     'is_toggled': is_toggled,
>                                     'action_attr': image_attr,})
>=20
>             print "image_store.append(image_name=3D", image_name, "
> image_type=3D", image_type, " image_size=3D", image_size, " is_toggled=3D=
",
> is_toggled, " image_attr=3D", image_attr, ")"
>=20

So this was happening not only after the image build is done, but also afte=
r the same image was loaded. It depends on what types of files are created =
for the image. In the case of  core-image-minimal/genericx86-64, 4 files we=
re created, 2 of them with the attribute "deploy" and the other 2 nor runna=
ble (qemu way) or deployable. The 2 deployable files got marked as toggled,=
 but since no runnable image was toggled, when the "Run custom image" butto=
n was pressed, no available file was presented. This issue was manifesting =
only when there was more than one toggled image, and I did not see this cas=
e with the images I had built so far, so thanks a lot for this testcase. Th=
e v3 patch that I made is fixing show_builded_images_dialog(), allowing the=
 user to choose for custom run any of the existing files.


And here's the v3 patch:
From b6534c8b9166c4ba6f005df252cdb7c491fd1ee3 Mon Sep 17 00:00:00 2001
From: Mirela Rabulea <mirela.rabulea@nxp.com>
Date: Fri, 12 Feb 2016 23:37:28 +0200
Subject: [PATCH] Allow Hob to run images on a custom simulator, other than
 qemu - review feedback no. 2 Note: in case there is more than one toggled
 image (qemu runnable or deployable), when the user clicks the "Run custom
 image" button, a dialog will be presented, allowing to choose between any =
of
 the existing images.

[YOCTO #8940]

Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/=
ui/crumbs/imagedetailspage.py
index 6cce8a1..b22cf80 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -284,8 +284,6 @@ class ImageDetailsPage (HobPage):
             if not self.toggled_image:
                 if i =3D=3D (len(image_names) - 1):
                     is_toggled =3D True
-                    # if there was no qemu runable image, let one image be=
 custom run
-                    image_attr =3D "run_custom"
                 if is_toggled:
                     default_image_size =3D image_size
                     self.toggled_image =3D image_name
@@ -501,7 +499,9 @@ class ImageDetailsPage (HobPage):
             if  (action_attr =3D=3D 'run' and primary_action =3D=3D "Run i=
mage") \
              or (action_attr =3D=3D 'deploy' and primary_action =3D=3D "De=
ploy image"):
                 action_images.append(fileitem)
-
+        if  (len(action_images) =3D=3D 0 and primary_action =3D=3D "Run im=
age"):
+            # if there are no qemu runnable images, let the user choose an=
y of the existing images for custom run
+            action_images =3D self.image_store
         # pack the corresponding 'runnable' or 'deploy' radio_buttons, if =
there has no more than one file.
         # assume that there does not both have 'deploy' and 'runnable' fil=
es in the same building result
         # in possible as design.
@@ -516,7 +516,8 @@ class ImageDetailsPage (HobPage):
         for fileitem in action_images:
             sel_btn =3D gtk.RadioButton(sel_parent_btn, fileitem['type'])
             sel_parent_btn =3D sel_btn if not sel_parent_btn else sel_pare=
nt_btn
-            sel_btn.set_active(fileitem['is_toggled'])
+            if fileitem['name'] =3D=3D self.toggled_image:
+                sel_btn.set_active(True)
             sel_btn.connect('toggled', self.table_selected_cb, fileitem)
             if curr_row < 10:
                 table.attach(sel_btn, 0, 4, curr_row, curr_row + 1, xpaddi=
ng=3D24)
@@ -540,15 +541,15 @@ class ImageDetailsPage (HobPage):
=20
         if response !=3D gtk.RESPONSE_YES:
             return
-
+        # perform the primary action on the image selected by the user
         for fileitem in self.image_store:
-            if fileitem['is_toggled']:
-                if fileitem['action_attr'] =3D=3D 'run':
+            if fileitem['name'] =3D=3D self.toggled_image:
+                if (fileitem['action_attr'] =3D=3D 'run' and primary_actio=
n =3D=3D "Run image"):
                     self.builder.runqemu_image(fileitem['name'], self.sel_=
kernel)
-                elif fileitem['action_attr'] =3D=3D 'run_custom':
-                    self.builder.run_custom_image(fileitem['name'], self.r=
un_script_path)
-                elif fileitem['action_attr'] =3D=3D 'deploy':
+                elif (fileitem['action_attr'] =3D=3D 'deploy' and primary_=
action =3D=3D "Deploy image"):
                     self.builder.deploy_image(fileitem['name'])
+                elif (primary_action =3D=3D "Run image"):
+                    self.builder.run_custom_image(fileitem['name'], self.r=
un_script_path)
=20
     def table_selected_cb(self, tbutton, image):
         image['is_toggled'] =3D tbutton.get_active()
--=20
1.9.1



--_002_VI1PR0401MB17898F62326CD302A05CD3F38FA90VI1PR0401MB1789_
Content-Type: application/octet-stream; name="bug_8940_squashed_v3.patch"
Content-Description: bug_8940_squashed_v3.patch
Content-Disposition: attachment; filename="bug_8940_squashed_v3.patch";
	size=13089; creation-date="Fri, 12 Feb 2016 22:37:50 GMT";
	modification-date="Fri, 12 Feb 2016 22:01:28 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmMWQyMzFkMmNmODhlNWJmNzA3OThhY2ZjNzg3MTQ5NGEzMDc5ZDU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaXJlbGEgUmFidWxlYSA8bWlyZWxhLnJhYnVsZWFAbnhwLmNv
bT4KRGF0ZTogVHVlLCAxOSBKYW4gMjAxNiAxNjozMTozOCArMDIwMApTdWJqZWN0OiBbUEFUQ0gg
djNdIEFsbG93IEhvYiB0byBydW4gaW1hZ2VzIG9uIGEgY3VzdG9tIHNpbXVsYXRvciwgb3RoZXIg
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
dGJha2UvbGliL2JiL3VpL2NydW1icy9pbWFnZWRldGFpbHNwYWdlLnB5IHwgNzEgKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMTIgaW5zZXJ0aW9ucygrKSwg
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
IDM1MmU5NDguLmIyMmNmODAgMTAwNzU1Ci0tLSBhL2JpdGJha2UvbGliL2JiL3VpL2NydW1icy9p
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
IHBvc3NpYmxlIGFzIGRlc2lnbi4KQEAgLTQ5OSw3ICs1MTYsOCBAQCBjbGFzcyBJbWFnZURldGFp
bHNQYWdlIChIb2JQYWdlKToKICAgICAgICAgZm9yIGZpbGVpdGVtIGluIGFjdGlvbl9pbWFnZXM6
CiAgICAgICAgICAgICBzZWxfYnRuID0gZ3RrLlJhZGlvQnV0dG9uKHNlbF9wYXJlbnRfYnRuLCBm
aWxlaXRlbVsndHlwZSddKQogICAgICAgICAgICAgc2VsX3BhcmVudF9idG4gPSBzZWxfYnRuIGlm
IG5vdCBzZWxfcGFyZW50X2J0biBlbHNlIHNlbF9wYXJlbnRfYnRuCi0gICAgICAgICAgICBzZWxf
YnRuLnNldF9hY3RpdmUoZmlsZWl0ZW1bJ2lzX3RvZ2dsZWQnXSkKKyAgICAgICAgICAgIGlmIGZp
bGVpdGVtWyduYW1lJ10gPT0gc2VsZi50b2dnbGVkX2ltYWdlOgorICAgICAgICAgICAgICAgIHNl
bF9idG4uc2V0X2FjdGl2ZShUcnVlKQogICAgICAgICAgICAgc2VsX2J0bi5jb25uZWN0KCd0b2dn
bGVkJywgc2VsZi50YWJsZV9zZWxlY3RlZF9jYiwgZmlsZWl0ZW0pCiAgICAgICAgICAgICBpZiBj
dXJyX3JvdyA8IDEwOgogICAgICAgICAgICAgICAgIHRhYmxlLmF0dGFjaChzZWxfYnRuLCAwLCA0
LCBjdXJyX3JvdywgY3Vycl9yb3cgKyAxLCB4cGFkZGluZz0yNCkKQEAgLTUyMywxMyArNTQxLDE1
IEBAIGNsYXNzIEltYWdlRGV0YWlsc1BhZ2UgKEhvYlBhZ2UpOgogCiAgICAgICAgIGlmIHJlc3Bv
bnNlICE9IGd0ay5SRVNQT05TRV9ZRVM6CiAgICAgICAgICAgICByZXR1cm4KLQorICAgICAgICAj
IHBlcmZvcm0gdGhlIHByaW1hcnkgYWN0aW9uIG9uIHRoZSBpbWFnZSBzZWxlY3RlZCBieSB0aGUg
dXNlcgogICAgICAgICBmb3IgZmlsZWl0ZW0gaW4gc2VsZi5pbWFnZV9zdG9yZToKLSAgICAgICAg
ICAgIGlmIGZpbGVpdGVtWydpc190b2dnbGVkJ106Ci0gICAgICAgICAgICAgICAgaWYgZmlsZWl0
ZW1bJ2FjdGlvbl9hdHRyJ10gPT0gJ3J1bic6CisgICAgICAgICAgICBpZiBmaWxlaXRlbVsnbmFt
ZSddID09IHNlbGYudG9nZ2xlZF9pbWFnZToKKyAgICAgICAgICAgICAgICBpZiAoZmlsZWl0ZW1b
J2FjdGlvbl9hdHRyJ10gPT0gJ3J1bicgYW5kIHByaW1hcnlfYWN0aW9uID09ICJSdW4gaW1hZ2Ui
KToKICAgICAgICAgICAgICAgICAgICAgc2VsZi5idWlsZGVyLnJ1bnFlbXVfaW1hZ2UoZmlsZWl0
ZW1bJ25hbWUnXSwgc2VsZi5zZWxfa2VybmVsKQotICAgICAgICAgICAgICAgIGVsaWYgZmlsZWl0
ZW1bJ2FjdGlvbl9hdHRyJ10gPT0gJ2RlcGxveSc6CisgICAgICAgICAgICAgICAgZWxpZiAoZmls
ZWl0ZW1bJ2FjdGlvbl9hdHRyJ10gPT0gJ2RlcGxveScgYW5kIHByaW1hcnlfYWN0aW9uID09ICJE
ZXBsb3kgaW1hZ2UiKToKICAgICAgICAgICAgICAgICAgICAgc2VsZi5idWlsZGVyLmRlcGxveV9p
bWFnZShmaWxlaXRlbVsnbmFtZSddKQorICAgICAgICAgICAgICAgIGVsaWYgKHByaW1hcnlfYWN0
aW9uID09ICJSdW4gaW1hZ2UiKToKKyAgICAgICAgICAgICAgICAgICAgc2VsZi5idWlsZGVyLnJ1
bl9jdXN0b21faW1hZ2UoZmlsZWl0ZW1bJ25hbWUnXSwgc2VsZi5ydW5fc2NyaXB0X3BhdGgpCiAK
ICAgICBkZWYgdGFibGVfc2VsZWN0ZWRfY2Ioc2VsZiwgdGJ1dHRvbiwgaW1hZ2UpOgogICAgICAg
ICBpbWFnZVsnaXNfdG9nZ2xlZCddID0gdGJ1dHRvbi5nZXRfYWN0aXZlKCkKQEAgLTU0MSw5ICs1
NjEsMTQgQEAgY2xhc3MgSW1hZ2VEZXRhaWxzUGFnZSAoSG9iUGFnZSk6CiAgICAgICAgIGlmIGtl
cm5lbF9wYXRoIGFuZCBzZWxmLmtlcm5lbF9kZXRhaWw6CiAgICAgICAgICAgICBpbXBvcnQgb3Mu
cGF0aAogICAgICAgICAgICAgc2VsZi5zZWxfa2VybmVsID0gb3MucGF0aC5iYXNlbmFtZShrZXJu
ZWxfcGF0aCkKLSAgICAgICAgICAgIG1hcmt1cCA9IHNlbGYua2VybmVsX2RldGFpbC5mb3JtYXRf
bGluZSgiS2VybmVsOiAiLCBzZWxmLnNlbF9rZXJuZWwpCi0gICAgICAgICAgICBsYWJlbCA9ICgo
c2VsZi5rZXJuZWxfZGV0YWlsLmdldF9jaGlsZHJlbigpWzBdKS5nZXRfY2hpbGRyZW4oKVswXSku
Z2V0X2NoaWxkcmVuKClbMF0KLSAgICAgICAgICAgIGxhYmVsLnNldF9tYXJrdXAobWFya3VwKQor
ICAgICAgICAgICAgc2VsZi5rZXJuZWxfZGV0YWlsLnVwZGF0ZV9saW5lX3dpZGdldHMoIktlcm5l
bDogIiwgc2VsZi5zZWxfa2VybmVsKTsKKworICAgIGRlZiBjaGFuZ2VfcnVuX3NjcmlwdF9jYihz
ZWxmLCB3aWRnZXQpOgorICAgICAgICBzZWxmLnJ1bl9zY3JpcHRfcGF0aCA9IHNlbGYuYnVpbGRl
ci5zaG93X2xvYWRfcnVuX3NjcmlwdF9kaWFsb2coKQorICAgICAgICBpZiBzZWxmLnJ1bl9zY3Jp
cHRfcGF0aCBhbmQgc2VsZi5ydW5fc2NyaXB0X2RldGFpbDoKKyAgICAgICAgICAgIGltcG9ydCBv
cy5wYXRoCisgICAgICAgICAgICBzZWxmLnNlbF9ydW5fc2NyaXB0ID0gb3MucGF0aC5iYXNlbmFt
ZShzZWxmLnJ1bl9zY3JpcHRfcGF0aCkKKyAgICAgICAgICAgIHNlbGYucnVuX3NjcmlwdF9kZXRh
aWwudXBkYXRlX2xpbmVfd2lkZ2V0cygiUnVuIHNjcmlwdDogIiwgc2VsZi5ydW5fc2NyaXB0X3Bh
dGgpCiAKICAgICBkZWYgY3JlYXRlX2JvdHRvbV9idXR0b25zKHNlbGYsIGJ1dHRvbmxpc3QsIGlt
YWdlX25hbWUpOgogICAgICAgICAjIENyZWF0ZSB0aGUgYnV0dG9ucyBhdCB0aGUgYm90dG9tCkBA
IC01NjYsMjYgKzU5MSwzMyBAQCBjbGFzcyBJbWFnZURldGFpbHNQYWdlIChIb2JQYWdlKToKICAg
ICAgICAgICAgIHBhY2tlZCA9IFRydWUKIAogICAgICAgICBuYW1lID0gIlJ1biBpbWFnZSIKLSAg
ICAgICAgaWYgbmFtZSBpbiBidXR0b25saXN0IGFuZCBzZWxmLnRlc3RfdHlwZV9ydW5uYWJsZShp
bWFnZV9uYW1lKSBhbmQgc2VsZi50ZXN0X21hY2hfcnVubmFibGUoaW1hZ2VfbmFtZSk6CisgICAg
ICAgIGlmIG5hbWUgaW4gYnV0dG9ubGlzdDoKKyAgICAgICAgICAgIG5hbWUgPSAiUnVuIHFlbXUg
aW1hZ2UiCisgICAgICAgICAgICBpc19ydW5uYWJsZSA9IFRydWUKKyAgICAgICAgICAgIGlmIG5v
dCAoc2VsZi50ZXN0X3R5cGVfcnVubmFibGUoaW1hZ2VfbmFtZSkgYW5kIHNlbGYudGVzdF9tYWNo
X3J1bm5hYmxlKGltYWdlX25hbWUpKToKKyAgICAgICAgICAgICAgICBuYW1lID0gIlJ1biBjdXN0
b20gaW1hZ2UiCisgICAgICAgICAgICAgICAgaXNfcnVubmFibGUgPSBGYWxzZQogICAgICAgICAg
ICAgaWYgY3JlYXRlZCA9PSBUcnVlOgogICAgICAgICAgICAgICAgICMgc2VwYXJhdG9yCiAgICAg
ICAgICAgICAgICAgI2xhYmVsID0gZ3RrLkxhYmVsKCIgb3IgIikKICAgICAgICAgICAgICAgICAj
c2VsZi5kZXRhaWxzX2JvdHRvbV9idXR0b25zLnBhY2tfZW5kKGxhYmVsLCBleHBhbmQ9RmFsc2Us
IGZpbGw9RmFsc2UpCiAKICAgICAgICAgICAgICAgICAjIGNyZWF0ZSBidXR0b24gIlJ1biBpbWFn
ZSIKLSAgICAgICAgICAgICAgICBydW5fYnV0dG9uID0gSG9iQWx0QnV0dG9uKCJSdW4gaW1hZ2Ui
KQorICAgICAgICAgICAgICAgIHJ1bl9idXR0b24gPSBIb2JBbHRCdXR0b24obmFtZSkKICAgICAg
ICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICAgIyBjcmVhdGUgYnV0dG9uICJSdW4gaW1hZ2Ui
IGFzIHRoZSBwcmltYXJ5IGJ1dHRvbgotICAgICAgICAgICAgICAgIHJ1bl9idXR0b24gPSBIb2JC
dXR0b24oIlJ1biBpbWFnZSIpCisgICAgICAgICAgICAgICAgcnVuX2J1dHRvbiA9IEhvYkJ1dHRv
bihuYW1lKQogICAgICAgICAgICAgICAgICNydW5fYnV0dG9uLnNldF9zaXplX3JlcXVlc3QoMjA1
LCA0OSkKICAgICAgICAgICAgICAgICBydW5fYnV0dG9uLnNldF9mbGFncyhndGsuQ0FOX0RFRkFV
TFQpCiAgICAgICAgICAgICAgICAgcGFja2VkID0gVHJ1ZQotICAgICAgICAgICAgcnVuX2J1dHRv
bi5zZXRfdG9vbHRpcF90ZXh0KCJTdGFydCB1cCBhbiBpbWFnZSB3aXRoIHFlbXUgZW11bGF0b3Ii
KQorICAgICAgICAgICAgaWYgaXNfcnVubmFibGU6CisgICAgICAgICAgICAgICAgcnVuX2J1dHRv
bi5zZXRfdG9vbHRpcF90ZXh0KCJTdGFydCB1cCBhbiBpbWFnZSB3aXRoIHFlbXUgZW11bGF0b3Ii
KQorICAgICAgICAgICAgZWxzZToKKyAgICAgICAgICAgICAgICBydW5fYnV0dG9uLnNldF90b29s
dGlwX3RleHQoIlN0YXJ0IHVwIGFuIGltYWdlIHdpdGggY3VzdG9tIHNpbXVsYXRvciIpCiAgICAg
ICAgICAgICBidXR0b25faWQgPSBydW5fYnV0dG9uLmNvbm5lY3QoImNsaWNrZWQiLCBzZWxmLnJ1
bl9idXR0b25fY2xpY2tlZF9jYikKICAgICAgICAgICAgIHNlbGYuYnV0dG9uX2lkc1tidXR0b25f
aWRdID0gcnVuX2J1dHRvbgogICAgICAgICAgICAgc2VsZi5kZXRhaWxzX2JvdHRvbV9idXR0b25z
LnBhY2tfZW5kKHJ1bl9idXR0b24sIGV4cGFuZD1GYWxzZSwgZmlsbD1GYWxzZSkKICAgICAgICAg
ICAgIGNyZWF0ZWQgPSBUcnVlCi0gICAgICAgICAgICBpc19ydW5uYWJsZSA9IFRydWUKIAogICAg
ICAgICBuYW1lID0gIlNhdmUgaW1hZ2UgcmVjaXBlIgogICAgICAgICBpZiBuYW1lIGluIGJ1dHRv
bmxpc3QgYW5kIHNlbGYuYnVpbGRlci5yZWNpcGVfbW9kZWwuaXNfY3VzdG9tX2ltYWdlKCk6CkBA
IC02MjgsNyArNjYwLDEwIEBAIGNsYXNzIEltYWdlRGV0YWlsc1BhZ2UgKEhvYlBhZ2UpOgogICAg
ICAgICAgICAgICAgIHNlbGYuc2hvd19idWlsZGVkX2ltYWdlc19kaWFsb2coTm9uZSwgIlJ1biBp
bWFnZSIpCiAgICAgICAgICAgICAgICAgc2VsZi5zZXRfc2Vuc2l0aXZlKFRydWUpCiAgICAgICAg
ICAgICBlbHNlOgotICAgICAgICAgICAgICAgIHNlbGYuYnVpbGRlci5ydW5xZW11X2ltYWdlKHNl
bGYudG9nZ2xlZF9pbWFnZSwgc2VsZi5zZWxfa2VybmVsKQorICAgICAgICAgICAgICAgIGlmIHNl
bGYuaXNfcnVubmFibGU6CisgICAgICAgICAgICAgICAgICAgIHNlbGYuYnVpbGRlci5ydW5xZW11
X2ltYWdlKHNlbGYudG9nZ2xlZF9pbWFnZSwgc2VsZi5zZWxfa2VybmVsKQorICAgICAgICAgICAg
ICAgIGVsc2U6CisgICAgICAgICAgICAgICAgICAgIHNlbGYuYnVpbGRlci5ydW5fY3VzdG9tX2lt
YWdlKHNlbGYudG9nZ2xlZF9pbWFnZSwgc2VsZi5ydW5fc2NyaXB0X3BhdGgpCiAKICAgICBkZWYg
c2F2ZV9idXR0b25fY2xpY2tlZF9jYihzZWxmLCBidXR0b24pOgogICAgICAgICB0b3BkaXIgPSBz
ZWxmLmJ1aWxkZXIuZ2V0X3RvcGRpcigpCi0tIAoxLjkuMQoK

--_002_VI1PR0401MB17898F62326CD302A05CD3F38FA90VI1PR0401MB1789_--
