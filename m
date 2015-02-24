Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 14EB971633
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:03 +0000 (UTC)
Received: by pablf10 with SMTP id lf10so37426797pab.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lerzhFAS98ZRh+45IonhhZljdwaeFpz5/jhjnqqB2ho=;
	b=FD2t7pVjb9XNmjh8uSyGpC5jLnwM01afHKMLlRdXRet5r3O173yxxu9r2WoinoG1WT
	GUDMg+0WQimGi+mBWDyHs0i49jPajQrGgdQdz5fT/S7QLDCy4chKQ5Zu0xt4MfRlfxoz
	EIk5n3SEq6Znx9d0++YkhQL1e17QatGT6ICg4PSYUOPAyc6WM/isYIHb6yPqmXT18SbA
	QO5Z2uHkYqD4obYWR0VE06LHL89/Kzxtld/kbpiIFpGoyVFvGnZiYK8euUB03ebtMMaL
	mbcWTSCxD/NbNfzk9qaccoa65KZeM3IDTBGmmESo0m1EkiUEYQlv7qPCWMYHyl6GM1zl
	Cgag==
X-Gm-Message-State: ALoCoQn44ub/qHTH3dKv9dPbi/MspFTU55Oo6W+/4bbp7J+Ss7vSW1QF+u3Xx07n8NV1l/OGh6Qs
X-Received: by 10.66.159.138 with SMTP id xc10mr30479847pab.141.1424798465026; 
	Tue, 24 Feb 2015 09:21:05 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qc8sm39519366pdb.86.2015.02.24.09.21.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:04 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 8F5935616E7; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:49 +0000
Message-Id: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 01/12] toastergui: fix spacing and input field sizes
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:04 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The revision label was missing the projec-form class (which
controls the spacing in the form), and the revision text
field was a bit too long, so changed it from span4 to
span3.
---
 lib/toaster/toastergui/templates/importlayer.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 1196e0c..19d2fc4 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -75,11 +75,11 @@
                         <input type="text"  id="layer-subdir">
 
                           <div class="control-group" id="layer-revision-ctrl">
-                            <label class="control-label" for="layer-git-ref">Revision
+                            <label class="control-label project-form" for="layer-git-ref">Revision
                               <span class="icon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"></span>
                             </label>
                             <div class="controls">
-                              <input type="text" class="span4" id="layer-git-ref" required>
+                              <input type="text" class="span3" id="layer-git-ref" required>
                                 <span class="help-inline" style="diaply:none;" id="invalid-layer-revision-hint"></span>
                             </div>
                           </div>
-- 
1.9.1


