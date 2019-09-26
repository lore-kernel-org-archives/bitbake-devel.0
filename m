Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id BABFF7E21C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 17:51:47 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id j4so8756005iog.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LopHDrZdmn9ebaSxr+E+aQTVNo5tIgNteaubhC2T1U0=;
	b=dpbw5aK+ebn8Cm4brDxwy6gD3BOYGpn+TK30W/aWn40Pk5qlzF8C/05DP5zpJewTaM
	pkrxOOqUnOmVbvBIJX13HLPLMNaAggwV+kMynTJHGysQ2VF21fCZ72a/SVqkE7HV7YHW
	c+XR72q9dlgyC4+P5C/10jQhC7i844WU0a7Rf+F10IZ2CfZkPVv7COho1x3nGwXqgr4R
	/Z20ebJLlpNe5NuSBTA0oI2VBtkCkkU9qDRhVc7vb+Qn3ArvY/4n6D7yoV/SEQZlFDtj
	jHpza+KNjbWexN1AGLIllYIlf2lPiHQpsGUqiiV8fBvIJWtlgfCeZrGSHXbRq83lgXvc
	EORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LopHDrZdmn9ebaSxr+E+aQTVNo5tIgNteaubhC2T1U0=;
	b=K8gw8Rtm9bgueZuW1QTB2TKoGdgGSgbZY9YbDMSN3u2JmPa2d/UgGjKtlbYsDcO74O
	FoYVhBTpdIMRrlNbrJqMsQCKguB//1MlfySO3vRktl5hzmluPnzO/qvPzv2I3IWTRGQO
	oM9WGKit0KRCcj7gYfhySArs/px2hFry5UMQwkJSQugx93ozINuoVJi20QXjSDN2lNVO
	5xDKos2YsPVb1tZ2OmyiWjJQUL0PCAQeDLeHpKEUB6GzYUylnxKaDCiwDPj23l5tDfAy
	dkCOAKeYu3v/HzNCobT/bvTyl7lD1Bq+TwHc75HhFBfJ/7yu4rbUWN29OMzu0ksK+r90
	NeIA==
X-Gm-Message-State: APjAAAX9aw6U+K5cWyTObgcDPHhePEn6gcOjszc0gN44X4xcBRb66+Nx
	7tVnI4O5UoHRU0l3+Wwe/j6N08jA
X-Google-Smtp-Source: APXvYqw9XY0KJJjUm+sZ0BCZdVasJjKQeIw4t/T8gxVroWigtF+vUbBlCP18OxVy9TKtgHK49CZxYw==
X-Received: by 2002:a02:55c4:: with SMTP id e187mr4690707jab.32.1569520308316; 
	Thu, 26 Sep 2019 10:51:48 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	f12sm1261469iob.58.2019.09.26.10.51.47
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 26 Sep 2019 10:51:47 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Sep 2019 12:51:45 -0500
Message-Id: <20190926175145.11356-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] hashserve: Add missing import
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
X-List-Received-Date: Thu, 26 Sep 2019 17:51:48 -0000
Content-Transfer-Encoding: 8bit

The os module is required to connect to a unix domain socket

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 2559bbb3fb2..f65956617b9 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -7,6 +7,7 @@ from contextlib import closing
 import json
 import logging
 import socket
+import os
 
 
 logger = logging.getLogger('hashserv.client')
-- 
2.21.0


