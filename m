Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id DF5186A9FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 13:35:40 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id fb4so5014973wid.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 05:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=ac0DGUOl/vJUHXmpXYpY+0yGHzOGrdchcGTd86Tsg/M=;
	b=IdmFgMtcA0D52bnE/4SDoyk9Sj0qWoclMcEzy+glrS6hmvqONXi8nr7WwHOXbwv0/g
	L0aMrGPxm7Xfj2CDBhYRAtjvJxfE9Flfxa6tODS0qZaDgO1NMNBmDcPVbgmE5/xoYnUN
	Jxl21XjPwbuakeTWWcGPx3JEuuP3a26WeXNJdzaf4abtxn8dJN/ZuccfH1IZZQekiUGt
	5USkDd78mqJBV6MqoemsSUAWk86v4DprQ54dAQA2ZYVl/Tv4x5ajBsxuy+TWPfNFkS3r
	ItbpfTrW6ou2Z5jZXANMu8pp0kC855BwQfBEFZF4pBP0jWNkW5dN31NUQh01J9KkDDiO
	IuaA==
X-Gm-Message-State: ALoCoQniLg5Lu9fgwDVQOe0B7iJzSCCdZtFdVRlPy9KQckQBlONjkdvlBqcwUOHJpInADT0bKaLr
X-Received: by 10.180.221.201 with SMTP id qg9mr7241194wic.29.1422365740624;
	Tue, 27 Jan 2015 05:35:40 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by mx.google.com with ESMTPSA id
	mz10sm10364549wic.9.2015.01.27.05.35.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 05:35:39 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 13:33:56 +0000
Message-Id: <1422365636-7574-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake/fetch2: specify recipe name when reporting SRCREV error
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
X-List-Received-Date: Tue, 27 Jan 2015 13:35:50 -0000

The "SRCREV was used but no SCM found" error isn't that helpful when it doesn't
indicate *what* recipe does this, so add the filename to the message.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 599ea8c..a24337c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -637,7 +637,7 @@ def get_srcrev(d):
             scms.append(u)
 
     if len(scms) == 0:
-        raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
+        raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI in %s" % d.getVar("FILE"))
 
     if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
         autoinc, rev = urldata[scms[0]].method.sortable_revision(urldata[scms[0]], d, urldata[scms[0]].names[0])
-- 
1.7.10.4


