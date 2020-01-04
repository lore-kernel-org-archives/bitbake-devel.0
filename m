Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
	[209.85.214.175])
	by mail.openembedded.org (Postfix) with ESMTP id 603EF7FA28
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:32 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id g6so16708236plp.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=IvhnibPf7wk7NMAZFV7DWk1mZ2+rPRNABc7gaTRrVq8=;
	b=qgsumRKLyEarCBZnq/43y61ARw3/FCluG6NTssjsQdWpIC9HIjc5BMlrx4fwRFWIMi
	kGz4N5W3W+M3dS8Mdu7evjuRD4AYIIwulyH7iPyCIVqHCXXKAQfl448GDrRZMhP/CVdF
	l00OqqhXBG0psua/uoAxu+kusABZI97R9C8bXVimwRmS71KR/mrydJrg4+QtZT3ykAee
	FQuiPqzqoQc+ik97GytNIwUnBTlSXwHzm7fleMxbDcZpHFV0pH1fbNP6SU50npNZTJL2
	/uhFIrrQJKiZjBYX2b1JZxV96CMwN+JwjADcgkFSLjndoCOt6B5fkpTdevQN9AVyFLXw
	ubmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=IvhnibPf7wk7NMAZFV7DWk1mZ2+rPRNABc7gaTRrVq8=;
	b=ZM/EJaj+7GGBGz3XMnxkufCGl7wgBiZTNeM8dyOCuzgNeo0nfegHO2GQnAmZR/Axis
	T1rxE5WKWcveS/VwyPFpxBmI/BLHVU3nMqQGPmDmRPw4sqBwpRA+dKNfiCyrBrUxSjT/
	ORLCpvZfIyrHSTaCUg89CpAYvK7LEwNik9JencQLRl30JpMcfBki5BuVebcC2Ps6AP4I
	HX2epg29lM26tKKksiUuO8Zh7yA9aXDMOTCKtth2PP2yGeTM/HJ100qpnLYAiX3ijal0
	Nqy9klpoEE8h4c0rHVUdNoU7ZWNyAW3Hg81IPKql6U9l2YgUwkvR1ClvPpE6CO8BZ7y2
	Ffng==
X-Gm-Message-State: APjAAAXxnnNyACfvmgh7H12yibRc7CfpdNrXwGyGHFmuXWdtd585G1Ut
	nT/aWDNb59FNv3lCwC4YE72lfabNWPA=
X-Google-Smtp-Source: APXvYqwBNb9F20aQ2s5gOATf3Xf5i/52RC3yynha7Ih3ELRPGo0tKjT2CzgLvJPSt86hxJBvOQSSXA==
X-Received: by 2002:a17:90a:fa05:: with SMTP id
	cm5mr29021412pjb.141.1578104613366; 
	Fri, 03 Jan 2020 18:23:33 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.32
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:32 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:06 -0800
Message-Id: <10058fe590c56ee3b4d2136b6e247c2d29ae47e6.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 21/25] runqueue: Fix equiv hash handling build failures
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:32 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Regardless of whether we remapped the hash on the server or not, we need
to have bitbake work as if we did as we need to match how the stamp files
look.

This change resolves build failures where tasks were rerunning when they
shouldn't.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 40928f6991436cf687821015324483b205abfcb1)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 729439ef..f8279980 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2302,8 +2302,9 @@ class RunQueueExecute:
                     remapped = True
                 elif tid in self.scenequeue_covered or tid in self.sq_live:
                     # Already ran this setscene task or it running. Report the new taskhash
-                    remapped = bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
+                    bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
                     logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
+                    remapped = True
 
                 if not remapped:
                     #logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
-- 
2.17.1


