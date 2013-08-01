Return-Path: <joe@deserted.net>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
	[209.85.216.178])
	by mail.openembedded.org (Postfix) with ESMTP id B15BB61883
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Aug 2013 14:19:54 +0000 (UTC)
Received: by mail-qc0-f178.google.com with SMTP id s1so1110413qcw.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Aug 2013 07:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:x-gm-message-state;
	bh=Nta2a/KjGp3Fq02UwI1YDWeap747RR7O1JlpljWsPTM=;
	b=c6Iu8FkdRgmwCP3qxBLdHBR0uf/angvEXZ6W+thfsEEhuj3oNOzz48yWu0A/HbnW6x
	WRyy2S501NbGnKC0gun8hyVVKvZiK2tzbE/XIHjoyw5/2ZjNI1OYDiXNkTC9uw+d23kv
	El2D2GNfWgTBy8Fw/i2+lufLnqrPn9hzsBaqMAcdl9M434VH2rRFEQCeYQRxWO86k4C6
	wyOzVHTnGBpbwiggOA3cyVQ4ls9Q43PavuIa1b0V9d0/4MBAeB5FWGWq5nfgs9cozZoB
	0gSuQzS1h95RegFgHFtzzqLH2xuPLvbgtynyR/UUQ5Ix25x+kYlJtN37mOGqirsa7tRo
	vasw==
X-Received: by 10.49.109.72 with SMTP id hq8mr2429946qeb.38.1375366794918;
	Thu, 01 Aug 2013 07:19:54 -0700 (PDT)
Received: from burninator.wrs.com ([128.224.252.2])
	by mx.google.com with ESMTPSA id y1sm5356394qaj.2.2013.08.01.07.19.53
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 01 Aug 2013 07:19:54 -0700 (PDT)
From: joe@deserted.net
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Aug 2013 10:19:46 -0400
Message-Id: <1375366786-16892-1-git-send-email-joe@deserted.net>
X-Mailer: git-send-email 1.7.10.4
X-Gm-Message-State: ALoCoQlmJ8qhX6Lcvru+zTIVEXTGZJ+fXKslomxjvxwOdH4FeT/IhDA9wRnoJdpZSI2MuNiTDd46
X-Mailman-Approved-At: Fri, 02 Aug 2013 18:11:14 +0000
Subject: [PATCH] bitbake: enable pdb tracing
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 01 Aug 2013 14:19:55 -0000

From: Joe MacDonald <joe@deserted.net>

Based on:

   http://blog.devork.be/2009/07/how-to-bring-running-python-program.html

register a signal handler to dynamically start pdb tracing on receiving
SIGUSR1.

Signed-off-by: Joe MacDonald <joe@deserted.net>
---

I've been spending the last week or so looking at some perplexing hangs
(for lack of a more descriptive word) with bitbake.  The behaviour is
difficult to characterize and even harder to reproduce, but over the
course of a day with a dozen machines or so doing various builds maybe a
dozen times we'll get in a scenario where bitbake itself appears to be
completely idle and waiting on something.  Occasionally it's been when
doing a 'bitbake -g' or 'bitbake -e', most recently I saw this on a
'bitbake core-image-minimal'.

Given the difficulty I've had in actually making the hang occur in
controlled circumstances, I can't say for certain, but it appears that
enabling any level of debugging makes the problem disappear.  So I've been
watching for it to happen then attaching gdb and investigating that way.

That's when it occurred to me that it might actually be useful to others
to have pdb available as an option, rather than needing to resort to
attaching gdb/python and debugging that way.

I did a quick search of the mailing list archives and didn't see this
discussed before, but if it has been and dismissed, sorry.

 -J.

 bitbake/bin/bitbake |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 60c4b96..e40fe28 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -24,6 +24,7 @@
 
 import os
 import sys, logging
+import signal
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
                                 'lib'))
 
@@ -57,6 +58,13 @@ try:
 except:
     pass
 
+# start pdb tracing if we receive SIGUSR1.
+def handle_pdb(sig, frame):
+    try:
+        import pdb
+        pdb.Pdb().set_trace(frame)
+    except ImportError:
+        logger.debug(2, 'Unable to import pdb module, interactive debugging of bitbake will not be possible')
 
 def get_ui(config):
     if not config.ui:
@@ -338,6 +346,7 @@ def main():
 
 if __name__ == "__main__":
     try:
+        signal.signal(signal.SIGUSR1, handle_pdb)
         ret = main()
     except Exception:
         ret = 1
-- 
1.7.10.4


