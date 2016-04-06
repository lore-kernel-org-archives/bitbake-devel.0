Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id A2B2B7710D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:32 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id v188so29621700wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=gWLU725fO+RASdn23n8PwQXBinTeeY0z4kibPs+GHy4=;
	b=E9TUpio+dhLIBU1u+mO+3YQ2AIM7O64hdmO+Cx0Jv0XIl6+gG96HqRZ1vgJ2JpXlrS
	Qq0G+JfSvfyAE5NcPm1nS4na6pqoHPhzT81gu/sCufovIZGJInaftwOSUe6hxJaqJGzP
	+gLcEarFQq4yZ2YfQm+PFmWoZlcmghoX0ONOJ7V2o0BAUdyl+d+Idu0+D+mX4KPP1pv7
	oCbBwT4nZT11K439aLvQJ69Ohxw7UPLqk1DaQZfUcqR7FOdSi0SNHx5m3DiSf/p5j/4i
	4u07XXlI2UFja5RTo2T6H5Z8v9zHpPgPcllO0w65YCRM54BzeRqrQchLUd+y03YSrnRO
	pcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=gWLU725fO+RASdn23n8PwQXBinTeeY0z4kibPs+GHy4=;
	b=cr23syfoGllATWAuHIOqIBkCRVZZEEa79f/+uT0PqsYmPtJtCIezLSv9zVmaso7fT1
	e8aUJb2XVuvT00xyBIdGu4ZGBe2uAFQqMuB4CeFYOEHdJJJhqdsYXCYVTPvkFBxR8gEn
	+UNVDhxJaYfLZgShy95CUqFNSmvPM7F7+wl3Wn3CJaOV4hO8IY9IqU9uRoVT+L3AhQPO
	uon6qILWYNwn34idCOP/5bxvzhFc0EpCamIjreZXdT8QgHFQfheEOx4Fz9verFtqAqm0
	VduSWGdYVenZqg+d4V1VxmWru8tAKqUetr+TS2xkrIfSInEa/wduxZfguwBv8n66NpmR
	R84A==
X-Gm-Message-State: AD7BkJLNbe1XbgGVl+PE74wJoOMGDqN/ovWx3nVi69olAeEGixNRBzuORMyvc8cC4XKb5oFk
X-Received: by 10.28.100.132 with SMTP id y126mr21270263wmb.91.1459961252687; 
	Wed, 06 Apr 2016 09:47:32 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:32 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:37 +0100
Message-Id: <7fb92158b24e185f6a268d01a18e79900e40e7a1.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 27/38] toaster: tables BuildsTable exclude cancelled builds
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:33 -0000

From: Sujith H <sujith.h@gmail.com>

Exclude cancelled builds from showing in the builds table

[YOCTO #6787]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tables.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 3340e05..2cc2f4e 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -1086,8 +1086,9 @@ class BuildsTable(ToasterTable):
         """
         queryset = self.get_builds()
 
-        # don't include in progress builds
-        queryset = queryset.exclude(outcome=Build.IN_PROGRESS)
+        # Don't include in progress builds pr cancelled builds
+        queryset = queryset.exclude(Q(outcome=Build.IN_PROGRESS) |
+                                    Q(outcome=Build.CANCELLED))
 
         # sort
         queryset = queryset.order_by(self.default_orderby)
-- 
2.1.4


