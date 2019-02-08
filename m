Return-Path: <alex.kanavin@gmail.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id BB1747C5E3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Feb 2019 18:29:50 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id b11so4726710wmj.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Feb 2019 10:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=mU4mTJi6uS4TYn2qHnbh/sj6k6PJlHPygxC/UrhWPfI=;
	b=Um+TUKh8Kq1vxbORprWK51ycNukZ9hH0udMrs60KCKUMYiWmEsNy9ixR/FtkCr3Aoh
	Pv1RqVPzdHGWr3c5jEYNsGOoWNh0scMYXulnpboR1gVUS18tj4b2Ra0GK/xYb3+p6cq8
	b6NQNi4OHrDBFpMcqnWHCppuMlgEv026XFq1U0peM6Mhw99tLpooxDhT29nLWUHwjYla
	DLLytby/5d0NSty6MP4rr4tEPq52PCYTq4QyUkFGrTju7xDqWQWlmgg3lz4GLBuQtZ4C
	3fvLT1YRH/PnK8cyh2kTIrzUwIx/iFJiMSCAj5NtO1qLM4H6pKAtQff/PIi+bOWnUzyj
	opVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=mU4mTJi6uS4TYn2qHnbh/sj6k6PJlHPygxC/UrhWPfI=;
	b=opQqyDucGzc7IqMoJPJY73OscstfurDgSZz6TuQhzIRMbP2RRG8FTb8yy8EAyHo4+/
	z4XO/Bf7QFTQMJp64TufqStJS3S4lQxCwwLsuDBXXJMN9zR4qtNH6JAW/7F7TD+YHUi9
	O+c/BwlBmvTWkfPOTijp/JKTYl7wUFtAkD+sVrdfNhyzdG5s4F69jwB14KNG271ZasT1
	Mbn78OZgxBDCsAEQBUnBCwsAL109oGGm8+0wH1obOcrmzaCbIpTkGvC4kTtoktCxUUK2
	NVjd1mgyr0DGsSakK3V5Vs3yrZ24O314dnBatoH25GM/lNtaCiq4VyWiYeg2iofyXaff
	Gq9A==
X-Gm-Message-State: AHQUAuZG3vU31p5Zm+75KjaZN3RfcWBCPHQfAA3PE5PVjhMAO2apuVP+
	9EauNXYW7CnsuAGYQX7JbuWRD86EK6Y=
X-Google-Smtp-Source: AHgI3IYZYnxsGMauCl+qLWZEdyey3HCTHakVNh/6jcdBPDLMlpwXFKybk5i356wECqYimWtNt386eA==
X-Received: by 2002:a1c:27c6:: with SMTP id
	n189mr12391029wmn.108.1549650591174; 
	Fri, 08 Feb 2019 10:29:51 -0800 (PST)
Received: from alexander-box.luxoft.com ([62.96.135.139])
	by smtp.gmail.com with ESMTPSA id
	n11sm2590268wrw.60.2019.02.08.10.29.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 Feb 2019 10:29:50 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Feb 2019 19:29:42 +0100
Message-Id: <20190208182942.88036-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] gitsm: catch SRCPV expansion errors
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
X-List-Received-Date: Fri, 08 Feb 2019 18:29:51 -0000

SRCPV may fail to expand, for instance like this:

Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)}
which triggered exception FetchError: Fetcher failure: The SRCREV_FORMAT
variable must be set when multiple SCMs are used.

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index b21fed26690..bcd1ca7dd22 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -140,7 +140,10 @@ class GitSM(Git):
             # Workaround for issues with SRCPV/SRCREV_FORMAT errors
             # error refer to 'multiple' repositories.  Only the repository
             # in the original SRC_URI actually matters...
-            ld.setVar('SRCPV', d.getVar('SRCPV'))
+            try:
+                ld.setVar('SRCPV', d.getVar('SRCPV'))
+            except Exception as e:
+                raise bb.fetch2.UnpackError(e, url)
             ld.setVar('SRCREV_FORMAT', module)
 
             function(ud, url, module, paths[module], ld)
-- 
2.17.1


