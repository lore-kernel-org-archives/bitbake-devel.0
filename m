Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7878D6E7D3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Apr 2014 13:51:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 02 Apr 2014 06:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,780,1389772800"; d="scan'208";a="485722140"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
	by orsmga001.jf.intel.com with ESMTP; 02 Apr 2014 06:51:07 -0700
Received: from irsmsx153.ger.corp.intel.com (163.33.192.75) by
	IRSMSX104.ger.corp.intel.com (163.33.3.159) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Wed, 2 Apr 2014 14:51:04 +0100
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.78]) by
	IRSMSX153.ger.corp.intel.com ([169.254.9.200]) with mapi id
	14.03.0123.003; Wed, 2 Apr 2014 14:50:58 +0100
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [dylan][PATCH] hob: disable layer drag and drop outside the
	containing widget
Thread-Index: AQHPQ3hb9k3h18S4pE+b9QvlkDIfDZr+bis7
Date: Wed, 2 Apr 2014 13:50:57 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE34A53ED8@IRSMSX105.ger.corp.intel.com>
References: <1395236228-4362-1-git-send-email-cristiana.voicu@intel.com>
In-Reply-To: <1395236228-4362-1-git-send-email-cristiana.voicu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.139]
MIME-Version: 1.0
Subject: Re: [dylan][PATCH] hob: disable layer drag and drop outside the containing widget
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
X-List-Received-Date: Wed, 02 Apr 2014 13:51:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Richard,=0A=
=0A=
Can you please merge this patch on dylan?=0A=
This is already on master branch.=0A=
=0A=
Thank,=0A=
Cristiana=0A=
________________________________________=0A=
From: Voicu, Cristiana=0A=
Sent: Wednesday, March 19, 2014 3:37 PM=0A=
To: bitbake-devel@lists.openembedded.org=0A=
Cc: Voicu, Cristiana=0A=
Subject: [dylan][PATCH] hob: disable layer drag and drop outside the contai=
ning widget=0A=
=0A=
[YOCTO #6008]=0A=
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>=0A=
---=0A=
 .../lib/bb/ui/crumbs/hig/layerselectiondialog.py   |    9 +++++----=0A=
 1 file changed, 5 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py b/bitbake=
/lib/bb/ui/crumbs/hig/layerselectiondialog.py=0A=
index 783ee73..f6a4d72 100644=0A=
--- a/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py=0A=
+++ b/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py=0A=
@@ -132,12 +132,13 @@ class LayerSelectionDialog (CrumbsDialog):=0A=
         tree_selection.set_mode(gtk.SELECTION_SINGLE)=0A=
=0A=
         # Allow enable drag and drop of rows including row move=0A=
+        dnd_internal_target =3D ''=0A=
+        dnd_targets =3D [(dnd_internal_target, gtk.TARGET_SAME_WIDGET, 0)]=
=0A=
         layer_tv.enable_model_drag_source( gtk.gdk.BUTTON1_MASK,=0A=
-            self.TARGETS,=0A=
-            gtk.gdk.ACTION_DEFAULT|=0A=
+            dnd_targets,=0A=
+            gtk.gdk.ACTION_MOVE)=0A=
+        layer_tv.enable_model_drag_dest(dnd_targets,=0A=
             gtk.gdk.ACTION_MOVE)=0A=
-        layer_tv.enable_model_drag_dest(self.TARGETS,=0A=
-            gtk.gdk.ACTION_DEFAULT)=0A=
         layer_tv.connect("drag_data_get", self.drag_data_get_cb)=0A=
         layer_tv.connect("drag_data_received", self.drag_data_received_cb)=
=0A=
=0A=
--=0A=
1.7.9.5=0A=
=0A=

