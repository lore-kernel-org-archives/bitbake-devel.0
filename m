Return-Path: <liu.ming50@gmail.com>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
	[209.85.215.41])
	by mail.openembedded.org (Postfix) with ESMTP id 6EABB75894
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 13:11:53 +0000 (UTC)
Received: by laclj5 with SMTP id lj5so65458403lac.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=fT6z+tyxnkqS8DQTVcMuegv34OBt1RtZ8zpQhH/rHzM=;
	b=xVk8EjliQenw2dXr25O1gYxHFbGZTRLx1TCp4x5w6hNgM6mshfu+6rCYbguia7mwUA
	VuZUNHGqok4CBs8zsOtXtr/wx/vZIywcLUWl+kB1CFupFkKWO50OSPLQF87lGQXPbtGI
	zz8++/ZbktYJExFiA+gBf0eSbA5DTFi3q/xLNhtuN9JwxfJZ2juxSXuhZoDR4LM/5TJ/
	mU4m2PTonvb60oU0GLOq1ZNMZIgXVOASJQFMxZp1cM6X5fTGApfch4g4pswYdL/Wl0jX
	j3RY1syur5vXCQSzjRLUJcoaN8SkiEfvQDr03i13NFfikx3XH7S/KvJRIIkH8t7uVbHJ
	K5mg==
X-Received: by 10.152.6.162 with SMTP id c2mr5462072laa.26.1443445912559;
	Mon, 28 Sep 2015 06:11:52 -0700 (PDT)
Received: from localhost.localdomain (m77-218-242-218.cust.tele2.se.
	[77.218.242.218])
	by smtp.gmail.com with ESMTPSA id j2sm2115183lag.9.2015.09.28.06.11.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 06:11:52 -0700 (PDT)
From: Ming Liu <liu.ming50@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 15:11:42 +0200
Message-Id: <1443445902-32608-1-git-send-email-liu.ming50@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Fri, 02 Oct 2015 23:09:12 +0000
Cc: Peter Liu <peter.x.liu@external.atlascopco.com>
Subject: [OE-core] [PATCH] bitbake: fetch: Extend subdir unpack parameter to local folder
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
X-List-Received-Date: Mon, 28 Sep 2015 13:11:54 -0000

From: Peter Liu <peter.x.liu@external.atlascopco.com>

This fixes urls of the form file://some/path/file;subdir=b. When
the file is a folder.

Signed-off-by: Peter Liu <peter.x.liu@external.atlascopco.com>
---
 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 288a1c8..3a425aa 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1423,6 +1423,8 @@ class FetchMethod(object):
                     if basepath and basepath.find("/") != -1:
                         destdir = basepath[:basepath.rfind('/')]
                         destdir = destdir.strip('/')
+                    if urldata.parm.get('subdir') != None:
+                        destdir = urldata.parm.get('subdir') + "/" + destdir
                     if destdir != "." and not os.access("%s/%s" % (rootdir, destdir), os.F_OK):
                         os.makedirs("%s/%s" % (rootdir, destdir))
                     cmd = 'cp -fpPR %s %s/%s/' % (file, rootdir, destdir)
-- 
1.9.1


