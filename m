Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 54FE76FFD3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 15:17:11 +0000 (UTC)
Received: by mail-pa0-f53.google.com with SMTP id oz2so6553294pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WTb2CNAD4C+AUmFhuiG3+LBEALV9YQhxBV4L+e5iq8g=;
	b=m7qHecjA+H/YStMR3VD3lsMCQ8tE9tXbzVkgaE+z6cmydBFuduq4GTjyUWl/a5Xvrl
	pQEfLDtW/3CDsYK33BIbE5CURXXHZvwDuh+Z+Li+umQ79kApUZNcH7minCsIJfpI0LVy
	UqhCAWKv6zmOubb8qVwnT/51NeDf1fnJhcKgQvB4hlfr365PnTpNMyBcAXXLPWMTzV1l
	9p2H0JtLx+xwhvblDniCy0KBZuiUD2ubAmbBKEKHrmRL+jFJOij6R7T9HTDGcaSdZZFT
	AhwXVonkadv/hHd1LwtK6ElEcrxqoXsD0bNxP2r2W9ZjY/quUCBqczl6uaYjgnYjyk+w
	SV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WTb2CNAD4C+AUmFhuiG3+LBEALV9YQhxBV4L+e5iq8g=;
	b=begCshdR+3sBSZ1nujcDHPUSBk1KfTErxi4o9VxYQE3KYR3QlKO839cSu7HEQewcae
	2MoIupN7g/H+q1eEa4UZVPvhIKutztW2zh+796sZUIS3+Se54RUS51ZKgMVSNO0xB5oe
	0aBdaO80gjUHYklCed60dd9Mt3O7JgBRZVy0nZiaO5LG6bm5+kdspjmi8O8Sny1PUHTZ
	joePcxQgeq0ZlLyC8ZKmIr6LWFtW65DIdmq0saXRbFfjfZm//PBN3H17gmEEDr1xsWgU
	hszzOn9IQaMd6o7qhVX1ok4mEUvqF6UDOwK8AXbzdgAQx0snaqUe4HT/WjKWiDVSRwnZ
	RoKQ==
X-Gm-Message-State: AE9vXwMfflNJq3copPdGDqm2bXd7Z388vo35JyyZNieQF+cX3XZ1JsoSw6PZozJURNLgyDwK
X-Received: by 10.67.5.33 with SMTP id cj1mr48401568pad.120.1474989432652;
	Tue, 27 Sep 2016 08:17:12 -0700 (PDT)
Received: from orion.ld.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	p1sm5784876pae.12.2016.09.27.08.17.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Sep 2016 08:17:12 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 16:16:56 +0100
Message-Id: <1474989416-10454-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
References: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 5/5] toaster: make error message more informative
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
X-List-Received-Date: Tue, 27 Sep 2016 15:17:11 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Error message
 ERROR: Unprocessed MetadataEvent <bb.event.MetadataEvent object at 0x7f750e671a58>
doesn't give a lot of information about the event. It just prints
event object, which is always bb.event.MetadataEvent.

Including event type into the error message should make it more
informative:
 ERROR: Unprocessed MetadataEvent TaskArtifacts

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 2bc45b6..9808f6b 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -438,7 +438,7 @@ def main(server, eventHandler, params):
                 elif event.type == "OSErrorException":
                     logger.error(event)
                 else:
-                    logger.error("Unprocessed MetadataEvent %s ", str(event))
+                    logger.error("Unprocessed MetadataEvent %s", event.type)
                 continue
 
             if isinstance(event, bb.cooker.CookerExit):
-- 
2.7.4


