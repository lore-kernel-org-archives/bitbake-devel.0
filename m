Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail.openembedded.org (Postfix) with ESMTP id 04DD871979
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Nov 2016 09:39:11 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id b123so21621804itb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Nov 2016 01:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=Ncf7tOAGjhKZLUhN+jedzMkw3E1yiE8pO18tZJZDYKc=;
	b=rKUSzGbxt2UIdV87q1LePNunEMUpsMSz10E02EDercqNCqQBn8127ZHHweNZRcHKH9
	+HC++VoO9DwNhMFjJIb9dFo7ubur0YJD36hWCz0d03MH/aV8fZw9ABdhtFVI+bAWTtlo
	HwAy0XongSMMrFGAPXu6/fREnoAAJWxKqgZGtQW234PRHrF80aweEtciQcKLoGWcnsE+
	0S/mTkvZFtMu08JiFqSCtD6unQIZ/ovlfYb2uTlmzXgAj8Grq5xCS+f1BAUznWoPXwWG
	PkM29HJ2uC7/evg1Z6YpAZN69KpDk9N5PfaO0hbFde9bMxMA3C9R9og9nX7Qklan2t9H
	ofaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Ncf7tOAGjhKZLUhN+jedzMkw3E1yiE8pO18tZJZDYKc=;
	b=Vs6GHelcUU9wGpJiySr58/gw7+0PmNfp/jZAQ8IGOCdVpFq8zJSB2LaodrmWtIiAgv
	CTwLB01xVc2gphlPTJmskLndX7V3HjHcaxLymplNsM2nSxbGR88XaYEOoKozRVFBOAnJ
	X8a2Z+lzCRmXgMllAMzELAcv42ltXv+51zglq0+ulBHZBYI94/6Rg+7ad8SLjXBcFQuU
	D9ySCygwTtHaod9p2pGBlZMetpt+13ZU+HeoaAWznqCLe2eKj7MIkuDY8RgY/Qi/KMxl
	cJHC1SPUzdueFUqwB840DWB++xGt2otPT226PRctRTcdl7hId1woLYah9NilQWIHl/9B
	WdAQ==
X-Gm-Message-State: ABUngvf7lqdQeuuSy5CU8vdvtestBxIk4lp9TcxIZP5XhgKoqzVUXK4VPPPfcp8JGMKrWzQT
X-Received: by 10.36.95.140 with SMTP id r134mr5243899itb.76.1479116350415;
	Mon, 14 Nov 2016 01:39:10 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8FC67.dip0.t-ipconnect.de.
	[93.232.252.103])
	by smtp.gmail.com with ESMTPSA id 22sm9021286iog.28.2016.11.14.01.39.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 14 Nov 2016 01:39:09 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 Nov 2016 10:39:00 +0100
Message-Id: <1479116340-4996-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] data_smart.py: don't reorder internal bitbake variables when calculating hash
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
X-List-Received-Date: Mon, 14 Nov 2016 09:39:12 -0000

Commit 260ced745 added __BBTASKS, __BBANONFUNCS, __BBHANDLERS to the
data that gets hashed, but only after reordering these lists. The
intention probably was to make the hash deterministic, but that's
unnecessary (the content of the variables should already be
deterministic) and hides potential reasons that might require
re-parsing.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/data_smart.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index f100446..b35ee9b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -956,7 +956,6 @@ class DataSmart(MutableMapping):
 
         for key in ["__BBTASKS", "__BBANONFUNCS", "__BBHANDLERS"]:
             bb_list = d.getVar(key, False) or []
-            bb_list.sort()
             data.update({key:str(bb_list)})
 
             if key == "__BBANONFUNCS":
-- 
2.1.4


