Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id 261FD731C4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:31 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id a7so767190pax.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=RyYNxXHMQmIqXtKQ/oiQRi+AA2cbz7lgX+CbWoLSNbc=;
	b=GPGm1zEWgFohmGBEz22gpvghCcolZoRjzGqn8pPj8ndDPkEc2vP8WiKC8JX8I4dnfM
	8FiNdpnGg09mGuweQowD56abFSObrjIgtz9hKDxFG5PygAaXOqzRlJ/kY6SChty1JeEa
	duvKGw2gxTQxR1XJBuduw4PBLgnvM/V+v7daq4ve91iHp2ybiIIGun3jwAc9UxrdO4I9
	WORfU87hd4gWFl8ORlTQNFoErmoEs//tU+WqbcDfsr/vqeP6cus7JfcBkOlGnfPBVoER
	hfkNCyfU9k15jmDZYQv1HO8Hl+QetQustuSFSy2x3OqKQaqRVpPDfsoSW8qvuE+UyO7t
	PobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RyYNxXHMQmIqXtKQ/oiQRi+AA2cbz7lgX+CbWoLSNbc=;
	b=B4a4pUopw59mkSfBTyB8jZHCdhFmRxCx7AThU1G8NPyORYy48xyTS+RBFlP+6QOKwa
	lR79LJQncxVOYVuwlFjGgmgpIyyfjjqlPtVEWf9O1f+ODzzxmO2J2//HhWPXpvUEfZKz
	KzglllK0K4V1SlGGnSH/ExDCsNMps6S/Uj8cBEtAeKjyhl3b57To590UuR3GaXiu57c/
	JFoGL5uyBIlJpCWShOhV9jfemA0rk8Z3Y/O3e/f0uZHW00XF9Acb7mOrWSjNJkT6uW39
	PqbYQ3QSpXi1LOG6GE4IxKfA9j4+dUWJ31ESKY7jUYtV1QyUBPMMA5UJB8AOUhIOnrp/
	A6hg==
X-Gm-Message-State: AD7BkJLSkm/VTPjgxfC8ps+3pB77BMdswxshOXIE7arx+nBhMnhGLkozn69BxnuSmp4IiA==
X-Received: by 10.66.160.7 with SMTP id xg7mr1460519pab.10.1456987293021;
	Wed, 02 Mar 2016 22:41:33 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r62sm57476673pfr.26.2016.03.02.22.41.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:32 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:40 -0800
Message-Id: <59ecf27a090608524c5c93258400d1b49df510bf.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
References: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456987460.git.avery.brian@gmail.com>
References: <cover.1456987460.git.avery.brian@gmail.com>
Subject: [PATCH 3/7] command: make setEventMask readonly
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
X-List-Received-Date: Thu, 03 Mar 2016 06:41:32 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Executing setEventMask command when bitbake server is in readonly
mode causes runCommand to fail with the following error:
 'Not able to execute not readonly commands in readonly mode'

Set readonly attribute for setEventMask command to make it working
for Toaster UI. This should not do any harm as this command doesn't
influence cooker state.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/command.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 74106d1..0559ffc 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -279,6 +279,7 @@ class CommandsSync:
         mask = params[3]
         return bb.event.set_UIHmask(handlerNum, llevel, debug_domains, mask)
     setEventMask.needconfig = False
+    setEventMask.readonly = True
 
     def setFeatures(self, command, params):
         """
-- 
1.9.1


