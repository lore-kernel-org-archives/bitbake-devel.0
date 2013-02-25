Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1UA3LJ-0004Uy-G5
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 20:04:08 +0100
Received: by mail-pa0-f51.google.com with SMTP id hz1so1897572pad.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Feb 2013 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=i7f7KfreApEFqHNtlkO4D9RvfNJD3PinKrz2qRCDuJA=;
	b=UQWxPy+5sc9JdWaumcaF+LfnHHx/v2WcBq1j81vV/+H4uKMmUyOHZV6zKtnF1Fbn+N
	njvveb+siHkeG8EokqSHJvJD3wylAosX+nDq+VYYYXCVw2AOLwoeVa/A2rG3Zfd+X3lb
	N8Kn6PWokCJComBPDPgGCDwux/EH9jSnFL7ZgYiqZnLLhv70DIFqt0k/mZg2jlxopZEx
	xFJ14JpzhlMiCR7O8mST+OhbSyarRIC+lAX1P2IjR7JibT0EKDkaslpTnl3cdI9QyjSJ
	s2kyzLyB6uzETmAHv5aD8NoA0vwaJE0AkAbhJUi6/LDS8eb1o/z4NY1v1UJQdISO8Dew
	hd3Q==
X-Received: by 10.66.102.73 with SMTP id fm9mr19975775pab.195.1361818066698;
	Mon, 25 Feb 2013 10:47:46 -0800 (PST)
Received: from precise64.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id hp7sm13543205pbc.8.2013.02.25.10.47.43
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 25 Feb 2013 10:47:45 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Feb 2013 11:48:00 -0700
Message-Id: <1361818080-5758-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.8.1.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] cooker: now that we use a Pool, raise the exceptions
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
X-List-Received-Date: Mon, 25 Feb 2013 19:04:09 -0000

From: Christopher Larson <chris_larson@mentor.com>

Multiprocessing catches these and handles passing them between processes
itself, we don't need to do it ourselves anymore.

[YOCTO #3926]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 bitbake/lib/bb/cooker.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9f7121f..1b84e86 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1563,12 +1563,12 @@ def parse_file((filename, appends, caches_array)):
         tb = sys.exc_info()[2]
         exc.recipe = filename
         exc.traceback = list(bb.exceptions.extract_traceback(tb, context=3))
-        return True, exc
+        raise
     # Need to turn BaseExceptions into Exceptions here so we gracefully shutdown
     # and for example a worker thread doesn't just exit on its own in response to
     # a SystemExit event for example.
     except BaseException as exc:
-        return True, ParsingFailure(exc, filename)
+        raise ParsingFailure(exc, filename)
 
 class CookerParser(object):
     def __init__(self, cooker, filelist, masked):
-- 
1.8.1.1



