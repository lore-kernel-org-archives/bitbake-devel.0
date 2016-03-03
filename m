Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 4185E731BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:35 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id q129so803159pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=BzGKEdIjF1MNa2Gtg+jeudrK73Pe2gzmisF88ASy9FY=;
	b=SKpi2kNt7s8fnyQf60ABgs87OINYhX35qGtZR5abRsQFB2RXOJ0ElfF2ftL9CEALEu
	kHMQ7WpPvOFLeZZ92JsENcvGp3SKoWTIwG/b7tu95TTYl8u5HaheLCRV63x8YNVqUF5I
	kunZ/pKW7QZsufNg+pnYptBsl2g73sAxlUunm51wg/mKmdR2uXxs57dDhZ1t8pHhXwWd
	mlR/F9mVk3sY7gWcZSdp2P27ZjwgHpJp6ZVgFWqfpxAFJY9xEg2uxwPs1xnlI4XG83No
	dY5XYPBfDywQqf7/B1zkaZxrxgvELr7b07WPwtsm9dCtDEd/P3/AzBshtVJRf9CNu8Wp
	6tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=BzGKEdIjF1MNa2Gtg+jeudrK73Pe2gzmisF88ASy9FY=;
	b=eRbzX8lBGrux81dbUHkp/njbuaVTNBpRnG36chNbPLgYu5mg9bNZRK2MSk5bIOtx2F
	/cn2gxXFgIwns4yOyvRuAgYqkDRZtjYk33Izp8UKNHm5FXIqMWXSur79VIOz0qsQtdxx
	ijAeiH3cfkPWF8eDiULua8+EcOAs6UOfRsSMY9xtTHVkndV0K+szaWYIMYwjBbLrhytY
	DHCdM1npeOTFrHh3T5yWM07oDlmRQBKqRoiDjU/GJ1lpgM83KSC3Rv8W+v3v7fgzriPE
	SwgM/K87UfjiKmzZaqk3ib7W0amrhwevYFxjsUjrgIW+f4XswJtDu3BWizNFeCywVF/F
	1WWQ==
X-Gm-Message-State: AD7BkJJKnMTV5P/KOctd1yYfHL5JkwJXvMBPy3P1D3Lv8KKV1++NsT/uAiIwR5eNQXbudQ==
X-Received: by 10.98.11.88 with SMTP id t85mr1442356pfi.98.1456987296903;
	Wed, 02 Mar 2016 22:41:36 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r62sm57476673pfr.26.2016.03.02.22.41.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:36 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:44 -0800
Message-Id: <743453a7908d1fd344ccb66db3da50d3f3abd7f6.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
References: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456987460.git.avery.brian@gmail.com>
References: <cover.1456987460.git.avery.brian@gmail.com>
Subject: [PATCH 7/7] toasterui: fix warning 'Unknown event'
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
X-List-Received-Date: Thu, 03 Mar 2016 06:41:36 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Continue after processing BuildStarted event to fix
WARNING: Unknown event: <bb.event.BuildStarted object at 0x2554150>

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 728803d..eee8d14 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -244,6 +244,7 @@ def main(server, eventHandler, params):
                     build_log, build_log_file_path = _open_build_log(log_dir)
 
                 buildinfohelper.store_started_build(event, build_log_file_path)
+                continue
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
-- 
1.9.1


