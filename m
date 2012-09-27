Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ross.burton@intel.com>) id 1THGVc-0001Ur-7C
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 18:00:16 +0200
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by mga01.intel.com with ESMTP/TLS/RC4-SHA; 27 Sep 2012 08:47:11 -0700
Received: by weyt44 with SMTP id t44so729944wey.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Sep 2012 08:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:x-gm-message-state;
	bh=JEhoDOr4GcSsvjEkicKQriyD/vbvD/B7V1qcAOuj6UM=;
	b=N89lgYZd/gxYnCUNByCQfKuu0fHqS5X9w8jvi03s1mWFBzBWA0F0EIU2QxAYzR513F
	vXkW8xlAjwlya7TgK3RU6mtVsQApLos9lr1bJm1wGKsS+rUvNuws3XeTdlVsRlOfZ20/
	l5+vXMmJOrsp0PG5FqYcWSZae5SDZ4lQO6OocuovmZGdjZdGnDfZO2lL9deTceKZtSBN
	jIJ2Z3dzB9qlisNyKD+RnHANsvvORTzSTH06D5Ae7Vd/wHxnXMvoQ7ci7hTAnNDWznJb
	N3rznaZb4EIO9vVDcdsfDIfA21UPTZ0rw6qoCQV9S6djjer2aBxHIVB7ZwtqAL/h5iIN
	3aPg==
Received: by 10.216.123.130 with SMTP id v2mr1730372weh.117.1348760829856;
	Thu, 27 Sep 2012 08:47:09 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPS id k2sm13794052wiz.7.2012.09.27.08.47.07
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 27 Sep 2012 08:47:08 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Sep 2012 16:46:09 +0100
Message-Id: <1348760769-22726-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10
X-Gm-Message-State: ALoCoQkvX3c8ITK+H3cjelRpHhUT+DMAfvKiDLzSohDxju7spUzDmqN24RjrDIDJnRU9aK2jjn61
Subject: [PATCH] hob: set modal flag on progress dialog
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
X-List-Received-Date: Thu, 27 Sep 2012 16:00:16 -0000

The entire interface isn't usable whilst the progress dialog is up so we might
as well set the modal flag so that some WMs (such as GNOME 3) can do nice things
with the dialog (such as pin it to the titlebar).

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/depexp.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 425302e..1a716a8 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -220,7 +220,8 @@ def main(server, eventHandler):
 
     gtk.gdk.threads_enter()
     dep = DepExplorer()
-    bardialog = gtk.Dialog(parent=dep)
+    bardialog = gtk.Dialog(parent=dep,
+                           flags=gtk.DIALOG_MODAL|gtk.DIALOG_DESTROY_WITH_PARENT)
     bardialog.set_default_size(400, 50)
     pbar = HobProgressBar()
     bardialog.vbox.pack_start(pbar)
-- 
1.7.10



