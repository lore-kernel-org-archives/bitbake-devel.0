Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail.openembedded.org (Postfix) with ESMTP id E812B7F7A4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2019 11:53:05 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id z7so8154990wrl.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2019 03:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=uyUuGCXMWJ1uFEhZsRtXgvlXFeIrODB1bJDmEbX8zyM=;
	b=HBU7A51SahJfBZQsY8ioqlm9SFiRatlPkCyRBxvzggtDfXI7pn0+zH4x5gAIuFtJRY
	jsS1y8Uf02jFOSDcG35mZOr7qZ0OPXwlwurK7Y30+ZFju4lodmtcO8lSVNw/sE0ZcNeA
	sSgBrnaDQIlE3ro67c9NpDMrINVkefb1K2NFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uyUuGCXMWJ1uFEhZsRtXgvlXFeIrODB1bJDmEbX8zyM=;
	b=t9AoONRKABOSpg3pxvCTYuHR5O/WRcrCKVR1OKA19OsahAsnBc2c+iSdY/ZE/Ndj08
	559t90MfMtUewR0j5V14bMgwAyketKqCNas16r0jN4AaRPd+9nYLDmcRAjAc1uIZB3qR
	HFFWVhLoVadhokq+c2iT4+ubZaTT071VVdHfEIwxo/NJJHSsDdhIGaRKprwvtKluROMK
	EEgZv3y9PD37P1n6d28DY0CYNw54laS64iPzAwBkZPgB67iFBB/Zm0f6+SJf0eeVdGnK
	TXDTvlsqswJoSePsWSgjhKU/tNmKKwMLxBUC10hDWMIpDKPmfsddNBGbFZryh2JNREsq
	jVuQ==
X-Gm-Message-State: APjAAAVIYV6xsxlPYmi37P70nyVHwV/bDvminMn9/pDhgaVrj8kY0108
	+XDOxoCWwEdI2GASsmtxFkTj21MCeBA=
X-Google-Smtp-Source: APXvYqxlxs6dmxR+S61cqBCVz59WZBMaQkdfjnSXjKIS6QQIUOE86MZ9tvHG2h5h3smDfihe0WrscQ==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr3601219wro.128.1575460386268; 
	Wed, 04 Dec 2019 03:53:06 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o4sm7813059wrw.97.2019.12.04.03.53.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Dec 2019 03:53:05 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Dec 2019 11:53:01 +0000
Message-Id: <20191204115302.24692-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
References: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/4] runqueue: Add extra debugging when locked sigs mismatches occur
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
X-List-Received-Date: Wed, 04 Dec 2019 11:53:06 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a869ba527a..246a9cdb64 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2524,6 +2524,8 @@ class RunQueueExecute:
                 msg = 'Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname)
             else:
                 msg = 'Task %s.%s attempted to execute unexpectedly' % (pn, taskname)
+            for t in self.scenequeue_notcovered:
+                msg = msg + "\nTask %s, unihash %s, taskhash %s" % (t, self.rqdata.runtaskentries[t].unihash, self.rqdata.runtaskentries[t].hash)
             logger.error(msg + '\nThis is usually due to missing setscene tasks. Those missing in this build were: %s' % pprint.pformat(self.scenequeue_notcovered))
             return True
         return False
-- 
2.20.1


