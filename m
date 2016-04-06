Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 667DD7716D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:39 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id n3so71356055wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=+oKNYBNif6cUTzhX7xbljOCJWDQJshKJ3bhSOfAx9k0=;
	b=qhDRi3RLcqE/tbpx2OflchYSDuZ6l8SWMYzqRFa6gsX2xSdvVED9YZVQxyERpU8tk+
	445Z8VcdWWuCfXuLD08QbrL/mQK44DT5BgdVrQh1xjxQ7gcfWq7HU/Dksf2adXzAcjDc
	9eNArko1cxrrBs0mNBb9+kvKFQXIajvUl0Hp8ns2Nxf0Eeb8IESjino5MwcJSorqIzVV
	QStqyIKbeuGRiJUF9HUmWqdyY+xOlBl5XYWlfMk0q5h8L9Fpt/FomXCrcxbAsMIU9yMa
	oIRSBKh9ja3lCgMJRjurQYvZsjnO661JnvAcME1rL9QgMV6txfYMYJadGBNpTo1JWw/p
	mW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+oKNYBNif6cUTzhX7xbljOCJWDQJshKJ3bhSOfAx9k0=;
	b=L5xyjNtFwknHEPl0SxPoMjlaqhT2yYs9MMwJ9GMn2rFnWpjqgd9owWqxfk79W70Qdu
	nZ+Hhc/Xcxb2uzZC7RFD6IuWcqFsWi+BMLf+nTe9WjO9f3h5tFNWF6Xzacu/+QFsXtbn
	PNb7GyML0abuNFGUI2KldNZV7RmkOnVI3GwlodpGjBjcFkToNr3GeV72iQIQYAMHgLzq
	aWCyvdnfCUC5aPHb/Zztox4eIIzUJY46HmW4b8fvLUvbfS4rujsvyHlfZFGyXWXUlM9S
	NF7sR6QvCfa20J+rnkpcEuLIOuExNKvl3nfHz2v+xmZQ0wCCpqsg/8U0DgwbTlIdQM+N
	6N9A==
X-Gm-Message-State: AD7BkJKEic5FeQR4C1plkSpKpUJ+6xAlQV0KpeY2O9rmTf0ZbmGzkrXdUzIf2DUML9ih3awX
X-Received: by 10.194.157.65 with SMTP id wk1mr17781582wjb.83.1459961259596;
	Wed, 06 Apr 2016 09:47:39 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:38 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:45 +0100
Message-Id: <d69333e044461c315c46fbaa78c82003e0e49b0d.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 35/38] toaster: export BBBASEDIR variable
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:39 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This variable will be used in localhost controller code
to determine correct bitbake location, so it has to be
exported.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index dfaff2e..70c66d2 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -101,6 +101,7 @@ stop_system()
     unset TOASTER_CONF
     unset TOASTER_DIR
     unset BITBAKE_UI
+    unset BBBASEDIR
     trap - SIGHUP
     #trap - SIGCHLD
     INSTOPSYSTEM=0
@@ -131,7 +132,7 @@ else
     TOASTER=$0
 fi
 
-BBBASEDIR=`dirname $TOASTER`/..
+export BBBASEDIR=`dirname $TOASTER`/..
 MANAGE=$BBBASEDIR/lib/toaster/manage.py
 OEROOT=`dirname $TOASTER`/../..
 
-- 
2.1.4


