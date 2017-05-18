Return-Path: <andy.voltz@timesys.com>
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com
	[209.85.220.172])
	by mail.openembedded.org (Postfix) with ESMTP id 4793D7807E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 May 2017 16:09:15 +0000 (UTC)
Received: by mail-qk0-f172.google.com with SMTP id k74so40031678qke.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 May 2017 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=timesys-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OW5md6xx7HdZh3tBvtICqhkfleXucUgGei9uFOVocgE=;
	b=FoEj92Kce/QjFfoLLYNR15Z8589CFlrfD7AlMiMFulsrp8rKdzvhlYw8q4EUFinCNN
	fQhjcxL2iYHvCQPYGvarYjFn72cu/onfh5O4XcBh/6B6YpPAmi9NJbcojqQ9fqcoWmrD
	3P58SahkeGPDzxLw6zchbCYFyj6Q8ucn938QII8g4r8LjzhvdtDvT/sqY6j95gmb6hMC
	evKA9mZK7RfFMFV70aPN+8IetgBAbxL50DBlZuh589FnpZ6eJE/bY4EQjzV4jqg1M51P
	MopTVNNkpk6/CgC6Fd3mcWxT7/WMVeSOqNKbbP3GaQa5YEz+0dXJCAhfLOSR9za+tc6/
	9xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OW5md6xx7HdZh3tBvtICqhkfleXucUgGei9uFOVocgE=;
	b=GbOseyJ/8VYv9Cr3QTX21fPobp91iPz2G65asjfE0HOGbBVBEEkYoyE6af33GSfCes
	CTF0djBUI9wX0FHORMEOnmRIBto+ayZuU1Fcr9kATexs6rlb9YcjiTR4+8fsG5xnxG6D
	UVaTBTs3HLd/051xcaIZGTZh1Yti12gjM7SniheaFzkBUYp8GM15qCUiH5yeytpkZdT7
	0zB5mfwxbdi6sxYNb+ynAeU7fy9vdkqmOmwiQRePyFIdsv9DE/8664SUHu4vbke0LFMM
	gYaO8VuEGkPPRPSZPCrMM+jT15WCRWxlJRkoEDE0FzlI7wibZHnP7s0zWqK3iUbI7++H
	d2ng==
X-Gm-Message-State: AODbwcCC+gyVFPpFWekgpq6Ru6W5hAUSNNUv9IHzccZr+aDD95MuBn6T
	Ruo+Vrg+q8iwVSTS
X-Received: by 10.55.165.196 with SMTP id o187mr4426545qke.88.1495123756817;
	Thu, 18 May 2017 09:09:16 -0700 (PDT)
Received: from smarf.timesys.com
	(96-94-100-129-static.hfc.comcastbusiness.net. [96.94.100.129])
	by smtp.gmail.com with ESMTPSA id
	d200sm3917151qkg.50.2017.05.18.09.09.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 May 2017 09:09:15 -0700 (PDT)
From: Andy Voltz <andy.voltz@timesys.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 May 2017 12:09:11 -0400
Message-Id: <1495123751-14886-3-git-send-email-andy.voltz@timesys.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1495123751-14886-1-git-send-email-andy.voltz@timesys.com>
References: <1495123751-14886-1-git-send-email-andy.voltz@timesys.com>
Subject: [PATCH 2/2] cooker: fix undefined dep in generatePkgDepTreeData
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
X-List-Received-Date: Thu, 18 May 2017 16:09:16 -0000

The loop for populating the depends of the tree data should use dep
instead of item.

Signed-off-by: Andy Voltz <andy.voltz@timesys.com>
---
 lib/bb/cooker.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index bc8574a..8846690 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -905,13 +905,13 @@ class BBCooker:
                 seen_fns.append(taskfn)
 
                 depend_tree["depends"][pn] = []
-                for item in taskdata[mc].depids[taskfn]:
+                for dep in taskdata[mc].depids[taskfn]:
                     pn_provider = ""
                     if dep in taskdata[mc].build_targets and taskdata[mc].build_targets[dep]:
                         fn_provider = taskdata[mc].build_targets[dep][0]
                         pn_provider = self.recipecaches[mc].pkg_fn[fn_provider]
                     else:
-                        pn_provider = item
+                        pn_provider = dep
                     pn_provider = self.add_mc_prefix(mc, pn_provider)
                     depend_tree["depends"][pn].append(pn_provider)
 
-- 
2.1.4


