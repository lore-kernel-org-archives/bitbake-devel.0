Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
	[209.85.214.49])
	by mail.openembedded.org (Postfix) with ESMTP id A4C2978145
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 13:56:34 +0000 (UTC)
Received: by mail-it0-f49.google.com with SMTP id x129so14439782ite.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Jun 2017 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QHNIKALmdUD/AtfNuAKx9hTBUF1k61m5teW8ePNklUI=;
	b=173IaVKjBymRBufHJdDiGKrm212r26Tw5QzDk6H5hZYKBTqGxzZPniTE4Ias7mk20+
	sVoR+rioRSQLUmzTtX/ddbtYJcGG6PR5XGHk52ooZuiZIRUrHpQXjk36DxBEdAObnipN
	Nz7PvFa/mnKoVgwljWOJZ0I0rzhKLN29jIXRckZMh5tevU4YJzmqX2iFtSYy431mkDj/
	Z87oRVV+52i3+3SDJJsPSqoRHOEOEHKyer7e1gSpSBcmr96aFo12iQmhHW1Cd4Zsw+E+
	9Nxt+f+U+pnEBy3BkpDFH+c0O6AeXwyMKChmwizDCklRmElNFTSJKBz9ea0zIEIn5IX9
	VR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QHNIKALmdUD/AtfNuAKx9hTBUF1k61m5teW8ePNklUI=;
	b=Tg1eR46tEUsHGOWJkksnb2B/mSz0c79JjmngEaC7wsqSXgTaQHhTF+iKiHcoVco3J8
	LCzLnaFyIxu45b7QbfuPI69DnWasxlqXiHkB7R/gf6iBPl9AwbiewWZCNwBCpoIa3RHd
	39RwxlhNGXqoK5h+rf5hshPOM03e11HqvTtKbgSBMTiO2+Ac+npJj1M48u/G0sSRI7o1
	kjAL4JbdFJfmbZokilVrTfS3q6fnsxME3zdui7g48SsLycvYT+JdM3UVdceDPF3SjlyJ
	qTQSiZwa/pCmo3Tal786RVmCc5flD+XZ6EyjzGKoob4HJKUKNlV2f7maeIpI/HHKR5T4
	inig==
X-Gm-Message-State: AODbwcB4Y/18g4poCQdRHPLu0G649X+577PBDDHGG3APvklbIPUPHfMT
	5Hqwbl4xRMLf6BvrtBg=
X-Received: by 10.36.0.9 with SMTP id 9mr1977378ita.108.1496843795418;
	Wed, 07 Jun 2017 06:56:35 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8FFF1.dip0.t-ipconnect.de.
	[93.232.255.241]) by smtp.gmail.com with ESMTPSA id
	e32sm1065133itd.18.2017.06.07.06.56.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 07 Jun 2017 06:56:34 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 15:56:24 +0200
Message-Id: <c05bcbe8dd83f969f56e7ef93a2ea545fab4cf2c.1496843701.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
References: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
Subject: [PATCH 1/2] ConfHandler.py: allow inherit or include without parameter
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
X-List-Received-Date: Wed, 07 Jun 2017 13:56:34 -0000

Writing .bbappends that only have an effect when some configuration
variable like DISTRO_FEATURES is changed becomes easier when allowing
"inherit" or "require" without a parameter. The same was already
allowed for "inherit".

Then one can write in a .bbappend:

  require ${@bb.utils.contains('DISTRO_FEATURES', 'foo', 'bar.inc', '', d)}

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/parse/parse_py/ConfHandler.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index bf7e985..b006d06 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -81,6 +81,10 @@ def include(parentfn, fn, lineno, data, error_out):
     fn = data.expand(fn)
     parentfn = data.expand(parentfn)
 
+    if not fn:
+        # "include" or "require" without parameter is fine, just return.
+        return
+
     if not os.path.isabs(fn):
         dname = os.path.dirname(parentfn)
         bbpath = "%s:%s" % (dname, data.getVar("BBPATH"))
-- 
git-series 0.9.1

