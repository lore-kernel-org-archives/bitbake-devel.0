Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 650666BD85
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Sep 2013 12:56:03 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 04 Sep 2013 05:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,1021,1367996400"; d="scan'208";a="398065146"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by orsmga002.jf.intel.com with ESMTP; 04 Sep 2013 05:55:47 -0700
Received: from irsmsx106.ger.corp.intel.com (163.33.3.31) by
	IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Wed, 4 Sep 2013 13:55:47 +0100
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.64]) by
	IRSMSX106.ger.corp.intel.com ([169.254.8.233]) with mapi id
	14.03.0123.003; Wed, 4 Sep 2013 13:55:47 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] hob: limit the description size when a custom image is
	saved
Thread-Index: AQHOqUe2uaBvF1TKdk+JsJd5AxUgWJm1iUzw
Date: Wed, 4 Sep 2013 12:55:46 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E86170B@IRSMSX105.ger.corp.intel.com>
References: <1378283075-18080-1-git-send-email-cristiana.voicu@intel.com>
In-Reply-To: <1378283075-18080-1-git-send-email-cristiana.voicu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
MIME-Version: 1.0
Subject: Re: [PATCH] hob: limit the description size when a custom image is saved
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
X-List-Received-Date: Wed, 04 Sep 2013 12:56:04 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please do not consider this patch. I will send a new version for it.
Thanks,
Cristiana

-----Original Message-----
From: Voicu, Cristiana=20
Sent: Wednesday, September 04, 2013 11:25 AM
To: bitbake-devel@lists.openembedded.org
Cc: Voicu, Cristiana
Subject: [PATCH] hob: limit the description size when a custom image is sav=
ed

[YOCTO #5003]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/=
bb/ui/crumbs/hig/saveimagedialog.py
index 56c00bb..42a4f5b 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -70,7 +70,9 @@ class SaveImageDialog (CrumbsDialog):
         sub_label.set_alignment(0, 0)
         sub_label.set_markup("The description should be less than 150 char=
acters long.")
         self.description_entry =3D gtk.TextView()
-        self.description_entry.get_buffer().set_text(self.description_fiel=
d)
+        description_buffer =3D self.description_entry.get_buffer()
+        description_buffer.set_text(self.description_field)
+        description_buffer.connect("insert-text",=20
+ self.limit_description_length)
         self.description_entry.set_wrap_mode(gtk.WRAP_WORD)
         self.description_entry.set_size_request(350,150)
         sub_vbox.pack_start(label, expand=3DFalse, fill=3DFalse) @@ -108,6=
 +110,13 @@ class SaveImageDialog (CrumbsDialog):
=20
         self.show_all()
=20
+    def limit_description_length(self, textbuffer, iter, text, length):
+        buffer_bounds =3D textbuffer.get_bounds()
+        entire_text =3D textbuffer.get_text(*buffer_bounds)
+        entire_text +=3D text
+        if len(entire_text)>150:
+            textbuffer.emit_stop_by_name("insert-text")
+
     def name_entry_changed(self, entry):
         text =3D entry.get_text()
         if text =3D=3D '':
--
1.7.9.5


