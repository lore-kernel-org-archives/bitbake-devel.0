Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 9A7886B4FD
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Aug 2013 16:12:32 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id l18so1478159wgh.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Aug 2013 09:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=lzdBlZsQDS/0Q03g9W/gMwmgMRO42NIQz/cds300V6I=;
	b=loSxDietSnTUvGVF5Bq+pxrfEWJloFm0uokHLdJ01epLOaDysqm0CRvZW4O4uhCs89
	fPA8rt7VluxoLOcL81bJKKnqEsbLYKMpE7yNHaUdmV/A4YvElm9GHiXY3QA+6aBc9MRh
	4g5L3Me2u1crI+eLNlCXErZx20iQynnC0ajk7l39Uo1UgmflZ6Aj+/0jKMq9/emo9gXK
	ZIv0YJrPMxpdkmENMC5juRm9ehGkzF3wviv8vc/rVemWIto16P1K/U6tXXsBkFn9kLaa
	qkU9sfG7ZoEtDv97AjRZy3dHC+Ie+DomggBnDmXfXxSezxCHwizW+E9vUzjrdxKRU6rA
	L9zg==
X-Gm-Message-State: ALoCoQkS7HbEGxQlN80qujHdMi2i/3QaP92q0Awika/cwpsCWV/saIltXC0LHd3QGu79H5LxPmRF
X-Received: by 10.180.82.5 with SMTP id e5mr1991404wiy.15.1375719153026;
	Mon, 05 Aug 2013 09:12:33 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id
	fd3sm22434156wic.10.2013.08.05.09.12.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 05 Aug 2013 09:12:31 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Aug 2013 17:12:23 +0100
Message-Id: <8b1a3c7eb0110cbb2345d32f26d37cb7fc5e8d6e.1375718812.git.ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1375718812.git.ross.burton@intel.com>
References: <cover.1375718812.git.ross.burton@intel.com>
In-Reply-To: <cover.1375718812.git.ross.burton@intel.com>
References: <cover.1375718812.git.ross.burton@intel.com>
Subject: [PATCH 3/3] depexp: fix typo in variable name
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
X-List-Received-Date: Mon, 05 Aug 2013 16:12:33 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/depexp.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 03ed823..cbda6d5 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -154,7 +154,7 @@ class DepExplorer(gtk.Window):
 
     def on_cursor_changed(self, selection):
         (model, it) = selection.get_selected()
-        if iter is None:
+        if it is None:
             current_package = None
         else:
             current_package = model.get_value(it, COL_PKG_NAME)
-- 
1.7.10.4


