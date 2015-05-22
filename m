Return-Path: <ashcharles@gmail.com>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
	[209.85.223.180])
	by mail.openembedded.org (Postfix) with ESMTP id D4E9A6AC95;
	Fri, 22 May 2015 15:39:32 +0000 (UTC)
Received: by iesa3 with SMTP id a3so34060256ies.2;
	Fri, 22 May 2015 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding;
	bh=FbaxDOpmlj00536lGn911q+JUYzVs86ffvz7txDSNU4=;
	b=V12rI+N1J7Y6/kL3TfFrZiLPbTtOUnImY2RsDiqfmXWIC+ue0ILAqPdH9H6kC6h2qZ
	QEw9DxdQS100CF7ahqw+MpcWp8TYMLVzIolPkC3+CS8N8YMcsOuKa6ZN3NmW6lhAyVW+
	8XgRPJGQKdRhQBQ0uyjisFoCt7L52wFc/wmpx//J4tsK7vPRzTZzaHuhSgBdvORW0di9
	Pxo0fLvxWCn3iddiYtL/nkYsbrwQjjOVPUyj74cjG1YfDQPBsbDQHudc2clB9mxAB35d
	oy14mgW06MSAaCAKGkwq8+vdW3wWlpdY5f4ndyrWGwHZQAtrAAYoc9x2h2oqIQ35AHr3
	Ej2Q==
X-Received: by 10.42.119.2 with SMTP id z2mr9834051icq.1.1432309173352;
	Fri, 22 May 2015 08:39:33 -0700 (PDT)
Received: from gumstux.mystix.com (s206-116-3-180.bc.hsia.telus.net.
	[206.116.3.180]) by mx.google.com with ESMTPSA id
	z195sm2014466iod.33.2015.05.22.08.39.31
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 22 May 2015 08:39:32 -0700 (PDT)
From: Ash Charles <ashcharles@gmail.com>
To: openembedded-devel@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Fri, 22 May 2015 08:39:30 -0700
Message-Id: <1432309170-5575-1-git-send-email-ashcharles@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20150427105100.GB2379@jama>
References: <20150427105100.GB2379@jama>
MIME-Version: 1.0
Cc: funman@videolan.org
Subject: [PATCH] fetch/hg: Disable checksums for archived downloads
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
X-List-Received-Date: Fri, 22 May 2015 15:39:34 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Like the Git fetcher, the Mercurial fetcher shouldn't expect recipes to
provide a checksum.  As described [1], recipes using a mercurial
fetcher that don't provide a checksum will fail in a the repository has
previously been downloaded and archived.

Credit to Rafaël Carré for figuring out the bug.

[1] https://www.mail-archive.com/openembedded-devel@lists.openembedded.org/msg41328.html

Signed-off-by: Ash Charles <ashcharles@gmail.com>
---
 bitbake/lib/bb/fetch2/hg.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 81592f6..cab371f 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -43,6 +43,13 @@ class Hg(FetchMethod):
         """
         return ud.type in ['hg']
 
+    def supports_checksum(self, urldata):
+        """
+        Don't require checksums for local archives created from
+        repository checkouts.
+        """ 
+        return False
+
     def urldata_init(self, ud, d):
         """
         init hg specific variable within url data
-- 
2.1.4


