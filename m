Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id AE2647D9AE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 11:19:01 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id a9so24270729wrp.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=PShI1e/BYXl3tuzMjQgvlpcGJYhpiXieIgzFO0p+RIA=;
	b=XssaiYG+aBg7951e5lfWzBw6Diq3Loeu1bzC8+XEHvTRuFC4lQ14WmuArivxHwneHp
	7ZU4ZcVPctiaecAClY05n0MPP2nXWzkbf5chejHRk1VFpyU6bEopwAvQiKBjbayMN78G
	pZWsfsyAwBCNPMHlM12k8eSyvRObyNmfaY+iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PShI1e/BYXl3tuzMjQgvlpcGJYhpiXieIgzFO0p+RIA=;
	b=W6NbGA3KHbS9Ez26pBpjRspg/ks9YhEA85RwQVvqulDEFyZZC2rC8Hf9FnV7YRUJOF
	LXfGzPiMuRaXXbG+NOQ6dORdaIFW9+V3QLG/xQLEPGAOtdF5q6zbgcTobXHLAFP29f0T
	aFeSc8wGp+1xyQ4Ygv00XUrRL5yqNI8KlGGslySU1VRvymMYQRH7NpkC0vl1raGVnBLF
	ne7OysfDFGp2Fprs6jKYQwyboc3RGn9eh8xSZZl70hs7HGmBKo7Dpjr5kZrektczbNEs
	7asgy1dI1X09K54gyPZUfwbAe5RQaUlhJEgAOst051Hc+d7/la5II5SGPW+gcOwuJmFt
	JsaQ==
X-Gm-Message-State: APjAAAXLFASHheMWgsNcC+24DFojQcIkK0pCUb11M4xYhPRFy3ReuZhq
	NIuSGt4aA31XT0Ba2Du2Ni5mobPVMF8=
X-Google-Smtp-Source: APXvYqyMujcKC67BJLu7hMRYpZg44XMdosnBEI9fI+vZYbzU+pknT60meNoXdgAt8zIrEf+8hMTPHg==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr2796779wrw.1.1556709542170;
	Wed, 01 May 2019 04:19:02 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j10sm3494597wrb.0.2019.05.01.04.19.01
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 04:19:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 May 2019 12:18:55 +0100
Message-Id: <20190501111859.5699-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
References: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/6] build: Ensure warning for invalid task dependencies is useful
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
X-List-Received-Date: Wed, 01 May 2019 11:19:02 -0000
Content-Transfer-Encoding: 8bit

WARNING: elfutils: dependent task do_rm_work does not exist

is much less useful than

WARNING: elfutils: dependent task do_rm_work for do_deploy does not exist

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index da592e6d84..8ad9f5de2a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -819,7 +819,7 @@ def add_tasks(tasklist, d):
             for dep in flags['deps']:
                 # Check and warn for "addtask task after foo" while foo does not exist
                 if not dep in tasklist:
-                    bb.warn('%s: dependent task %s does not exist' % (d.getVar('PN'), dep))
+                    bb.warn('%s: dependent task %s for %s does not exist' % (d.getVar('PN'), dep, task))
                 dep = d.expand(dep)
                 task_deps['parents'][task].append(dep)
 
-- 
2.20.1


