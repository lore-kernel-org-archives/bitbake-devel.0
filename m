Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 580007317F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 16:15:38 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id p65so35281415wmp.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=ez0qAF5WXfTnfnT5a6w3IkeFbYJnIPvhoyo67/Rn1XY=;
	b=RVOCp7yr2jlZH6F9Wt+s5ATYq+D2w2Pqn2rH8m2xKrARDaWkvqROoEeNsa5wWKXGQZ
	1d0OLyWvSVeLO+CowdXLNa8GE8NWAnfFdfNSnv37sNZkK07H6bkJ8GzCz2T9ZjnLwqP/
	MGZgALrns0+6POSTrfz7hXl+gcygsK4Opr5tdtMLL6blC0Qpnd3OP7TnAVMe0DwOsxYn
	OFll9O+C8FARTCm39TaYoUaSgJqwlaUru/53B/Lqp6msGK65KNSmU+ukZlGKKdIuIHPR
	PLpF5C/oNgSV7FTp75Oa6KAyM96oStQH7Y+2ROKcbRqkgwCHc0p+5QATFioHTi06Y0ru
	Cslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ez0qAF5WXfTnfnT5a6w3IkeFbYJnIPvhoyo67/Rn1XY=;
	b=GQ0qVlbzBmpLQIVy3KujgQWRjYlXEU/6amkfmLasdOOrkY4Uz8HL1vVvUCmFNEo1G1
	uIJo4mpsArt1gRfNq3FoyRE7GwapKLt4QTq3I+MrABKayoYKUH2Iq/uD6WPgzTUNfRF3
	lWNZb1Kw1QtjqijXJ/v98ALYc+QwE1h4QOcf6nRChjX1UUqvZe3YuhXgksgu6jo4JIXJ
	SiuqmCTaIRkpfzWsjkWXuBqJeil5AyZdj9I5ceV2CBiUut7eHC5Lw92tv0f2hBemYkKR
	qRy9uc5hyUWfiuI8QAhB0OGKX3K82HX8XydnWktn3nDTE8G3vSJummuRN3M7i/refBHl
	R6PQ==
X-Gm-Message-State: AD7BkJKTmxHFyMB5j2KLax4VWzB1Grsh/jdmccE+K+j+cvi+l0cXaSY2LOpxsEv1IjnIMw==
X-Received: by 10.194.71.46 with SMTP id r14mr5250713wju.100.1457626539547;
	Thu, 10 Mar 2016 08:15:39 -0800 (PST)
Received: from localhost.localdomain
	(LPuteaux-656-1-252-235.w82-127.abo.wanadoo.fr. [82.127.113.235])
	by smtp.gmail.com with ESMTPSA id d2sm4188035wjf.28.2016.03.10.08.15.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Mar 2016 08:15:38 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Mar 2016 08:15:32 -0800
Message-Id: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch2: include PV in 'Unable to get checksum for SRC_URI entry' warnings
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
X-List-Received-Date: Thu, 10 Mar 2016 16:15:40 -0000

Referencing PN only is ambiguous if multiple versions of a recipe are
present.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f86014c..124420d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1102,9 +1102,9 @@ def get_checksum_file_list(d):
                 if f.startswith(dl_dir):
                     # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
                     if os.path.exists(f):
-                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
+                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('P', True), os.path.basename(f)))
                     else:
-                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
+                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('P', True), os.path.basename(f)))
                 filelist.append(f + ":" + str(os.path.exists(f)))
 
     return " ".join(filelist)
-- 
1.9.1


