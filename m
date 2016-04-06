Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id BFDFD770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:14 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id v188so29613593wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=8CW+IlVpvzb+FoH1NeIxqnq9lm0ks7diy/us8OrHdik=;
	b=1lV9Xf/Z2Mp1mnRnATseHObkEnISsze8Q29FyuN/HVA2KWYuBwTFd9GfE4siifplBQ
	SH8ixbX4+ECo3yOB1/uBJbx/lhb+vyztwXGZNfxZ527levZLTSbSJSzJ3GT/3OCAFfxg
	H+W19eKZRI84Vod5DdJrtsbVkHlCD30/RLX406imSKCNs8O/s8/ppm1DPh0nytxsPnbI
	oTso/DsWoQcg/gqzSq9Ym0GfWHyseM1Qv2OgKQJWirFHiS8o+L3fP2jyIppu733vGB30
	+P9FHm9mXVvdOZMohM/sQozk4lAy8BmK0VU1psisQvjvOYVO91gvLvxsDe+1F5XBUm8V
	K/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8CW+IlVpvzb+FoH1NeIxqnq9lm0ks7diy/us8OrHdik=;
	b=TQzdrRyzPp8PFHsjmPSTiE9SKLcaV8KJK9u75pj3+/m8aoRvGB8i+26g0hb8mZXPT5
	sEaHNFwKEVC2TMolEPfGo/SipjitPJak+4VAwy9f7WMoJ9vs/fChZlrBA95NsUxXLu7y
	URcaSXokTz6lWYVUNzfjMJ3G1xGi7C9RNDI1tSArBWZ2YuHxNSou8aEKBN6V6r+n/2xU
	5ImPvPu2qF8PBQap6/inv3wh8qVioCOZir/h/PuQ5KYL/vtiNPO6xQzu4cuJ0e1rhTOl
	ffgEyPTSxy0hjsdIMEM+atQWDkYfvP2yH5t9bHR3ruI96NgVUJn9O9Wr7Q3FysdkF5un
	v2Wg==
X-Gm-Message-State: AD7BkJJJP2N8gZ+yo6ZJwz+x+G2aSh0He6qIak7NKLjZ/3uHhSq4lIoU7DfZBnOvgjjd204I
X-Received: by 10.194.123.102 with SMTP id lz6mr19114863wjb.2.1459961234787;
	Wed, 06 Apr 2016 09:47:14 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:13 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:17 +0100
Message-Id: <398bdbfb65f0944587525361802523695a5c778a.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 07/38] toasterui: fix brbe reporting
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:16 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

buildinfohelper.brbe is lost when buildinfohelper is closed.
This causes incorrect report of brbe when build is done.

Saved brbe attribute before closing buildinfohelper and used
it to report correct brbe.

Got rid of useless and confusing 'ToasterUI build done 1'
log message.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 06a5f17..39a4fe5 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -372,9 +372,9 @@ def main(server, eventHandler, params):
 
                 # update the build info helper on BuildCompleted, not on CommandXXX
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
+
+                brbe = buildinfohelper.brbe
                 buildinfohelper.close(errorcode)
-                # mark the log output; controllers may kill the toasterUI after seeing this log
-                logger.info("ToasterUI build done 1, brbe: %s", buildinfohelper.brbe )
 
                 # we start a new build info
                 logger.debug("ToasterUI prepared for new build")
@@ -383,7 +383,7 @@ def main(server, eventHandler, params):
                 taskfailures = []
                 buildinfohelper = BuildInfoHelper(server, build_history_enabled)
 
-                logger.info("ToasterUI build done 2")
+                logger.info("ToasterUI build done, brbe: %s", brbe)
                 continue
 
             if isinstance(event, (bb.command.CommandCompleted,
-- 
2.1.4


