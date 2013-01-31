Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <wmat@alphatroop.com>) id 1U0y7C-0004AU-43
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 18:39:58 +0100
Received: by mail-ie0-f173.google.com with SMTP id 9so2599057iec.32
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Jan 2013 09:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references:x-gm-message-state;
	bh=u+rcxHlPT0aneL/TkYqBaNF6hasVFzQIq7wIdh5VYkM=;
	b=QRlBHq61iCkV56ZbXa5w+7VvWzF10Z0A4NmPIPfsN5ozk7zbJZpivoGqyFQgmjFC+5
	DLtrA77vdlvUGjw2SjGpg48+GCNpzKnBhR4jqWUA/MpH5l1kFArkpLX9ZPuwTsbCP4hv
	GSmEoE4jN9ZzrF3RvPWn3l5mHPanGz7R70rPPEk7VTACtjFCZ2RYLxtJJ4aVS1gcJS2j
	gjnFwz1TyYM62lmJMqwQdCfMaT91eJNdMme0XtZ7y0gbkqI2+7KPdTchP92uRc6OK+pF
	E/E1H+MNMn9X9/LAo7Qr4d10vUV/Xjzfw35yNIkqXRvy/a59ENFS/JVcV0CFOcFIhMw2
	SDtA==
X-Received: by 10.42.180.65 with SMTP id bt1mr7511233icb.41.1359653054453;
	Thu, 31 Jan 2013 09:24:14 -0800 (PST)
Received: from univac.naoi.ca ([24.246.30.132])
	by mx.google.com with ESMTPS id x7sm7129118igk.8.2013.01.31.09.24.13
	(version=TLSv1 cipher=RC4-SHA bits=128/128);
	Thu, 31 Jan 2013 09:24:13 -0800 (PST)
From: Bill Traynor <wmat@alphatroop.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Jan 2013 12:24:08 -0500
Message-Id: <1359653048-4965-1-git-send-email-wmat@alphatroop.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <y>
References: <y>
X-Gm-Message-State: ALoCoQl5OPn/sZfeyPBi8axrKGmqr5BCPX1oLarfgi0B/6+6/cWIL0sGDGVDTqaxWIs8EA0e1Leu
Subject: [PATCH] setup.py: Set the 'url' in setup.py to the OE BitBake page.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 31 Jan 2013 17:40:00 -0000

Removed the old berlios BitBake project page and inserted
the BitBake page from the OE project:
http://www.openembedded.org/wiki/BitBake

Signed-off-by: Bill Traynor <wmat@alphatroop.com>
---
 setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.py b/setup.py
index d5c70bc..8c26a9b 100755
--- a/setup.py
+++ b/setup.py
@@ -65,7 +65,7 @@ setup(name='bitbake',
       },
 
       license = 'GPLv2',
-      url = 'http://developer.berlios.de/projects/bitbake/',
+      url = 'http://www.openembedded.org/wiki/BitBake',
       description = 'BitBake build tool',
       long_description = 'BitBake is a simple tool for the execution of tasks. It is derived from Portage, which is the package management system used by the Gentoo Linux distribution. It is most commonly used to build packages, as it can easily use its rudimentary inheritance to abstract common operations, such as fetching sources, unpacking them, patching them, compiling them, and so on.  It is the basis of the OpenEmbedded project, which is being used for OpenZaurus, Familiar, and a number of other Linux distributions.',
       author = 'BitBake Development Team',
-- 
1.7.11.7



