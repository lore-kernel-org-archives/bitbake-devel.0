Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 1795B758E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:03 +0000 (UTC)
Received: by wiga1 with SMTP id a1so160170335wig.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=lvWfKfmG7UGhF5dVB8RA8d8z2Vcblu1qOvhTp/GJ8gA=;
	b=O46r4y+861+GCMG/t0+Fzj/UeKq+0yQLhmseCI0E3X0xUT0jD82BEgwlP1FfRR/yhn
	KLBA3FuA8vNdqbWwBSfAST+oRhXaTE7+pebSkSHJt8fxdE1TzaaB/sbCJjqA5juS3h35
	ZTkr9SpoqEK381Md3nA9A6FIaw9ZVULb82H1/P1cC6rFu7kYeOv6bdxBKaQcDUoQPsGr
	nSdySvtyuKSxf+WCsGdPk8p+rulcoxtMfhC1ltrp+LxBpj0u71ASCIXh8bcw432XbAij
	GDWlUZjbMUCChlg/JLGtWsgFo7HAKbOAmZ+dLe0k+HACkc0i2O7tXaa50rM800C/ipX8
	g5SQ==
X-Gm-Message-State: ALoCoQk7iSk1BZBGvD2lK5EoSMfmt9KzbSq2O8EbkjMC4jMivkA+ZlfteGgo52BEYCllXMpCPUpQ
X-Received: by 10.180.23.66 with SMTP id k2mr4472549wif.85.1435228444601;
	Thu, 25 Jun 2015 03:34:04 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id s8sm6934040wik.5.2015.06.25.03.34.03
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:03 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BB5E8561ED3; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:40 +0100
Message-Id: <3928dc93188880386588fe3f440cd0aaa83d22de.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 03/23] toastergui: enable strict variable checking
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:04 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In order to make sure we don't use undefined variables in the
templates, we enforce strict variable checking in the templating
engine.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 3c7cb3b..141ad08 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -386,3 +386,10 @@ connection_created.connect(activate_synchronous_off)
 #
 
 
+class InvalidString(str):
+    def __mod__(self, other):
+        from django.template.base import TemplateSyntaxError
+        raise TemplateSyntaxError(
+            "Undefined variable or unknown value for: \"%s\"" % other)
+
+TEMPLATE_STRING_IF_INVALID = InvalidString("%s")
-- 
1.9.1


