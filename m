Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 4EF6F6D746
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 11:36:58 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 15 Nov 2013 03:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="435755484"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
	by orsmga002.jf.intel.com with ESMTP; 15 Nov 2013 03:36:26 -0800
Received: from irsmsx152.ger.corp.intel.com (163.33.192.66) by
	IRSMSX104.ger.corp.intel.com (163.33.3.159) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Fri, 15 Nov 2013 11:36:25 +0000
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.215]) by
	IRSMSX152.ger.corp.intel.com ([169.254.6.169]) with mapi id
	14.03.0123.003; Fri, 15 Nov 2013 11:36:25 +0000
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: "Voicu, Cristiana" <cristiana.voicu@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] hob/hoblistmodel: check if vals of packages/recipes
	names are not None
Thread-Index: AQHOuE0aDakXE9clOk6R//Ln4CGo65omfOOw
Date: Fri, 15 Nov 2013 11:36:24 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E8B0B3D@IRSMSX105.ger.corp.intel.com>
References: <1379934668-4626-1-git-send-email-cristiana.voicu@intel.com>
In-Reply-To: <1379934668-4626-1-git-send-email-cristiana.voicu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.181]
MIME-Version: 1.0
Subject: Re: [PATCH] hob/hoblistmodel: check if vals of packages/recipes names are not None
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
X-List-Received-Date: Fri, 15 Nov 2013 11:36:58 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I think this was forgotten.
Cristiana

-----Original Message-----
From: Voicu, Cristiana=20
Sent: Monday, September 23, 2013 2:11 PM
To: bitbake-devel@lists.openembedded.org
Cc: Voicu, Cristiana
Subject: [PATCH] hob/hoblistmodel: check if vals of packages/recipes names =
are not None

[YOCTO #5053]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/c=
rumbs/hoblistmodel.py
index b4d2a62..79e909c 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -199,7 +199,9 @@ class PackageListModel(gtk.ListStore):
         return self.cmp_vals(val1, val2, user_data)
=20
     def cmp_vals(self, val1, val2, user_data):
-        if val1.startswith(user_data) and not val2.startswith(user_data):
+        if val1 is None or val2 is None:
+            return 0
+        elif val1.startswith(user_data) and not val2.startswith(user_data)=
:
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data)=
:
             return 1
@@ -575,7 +577,9 @@ class RecipeListModel(gtk.ListStore):
         return self.cmp_vals(val1, val2, user_data)
=20
     def cmp_vals(self, val1, val2, user_data):
-        if val1.startswith(user_data) and not val2.startswith(user_data):
+        if val1 is None or val2 is None:
+            return 0
+        elif val1.startswith(user_data) and not val2.startswith(user_data)=
:
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data)=
:
             return 1
--=20
1.7.9.5


