Return-Path: <lucas.dutra.nunes@gmail.com>
Received: from mail-qg0-f68.google.com (mail-qg0-f68.google.com
	[209.85.192.68])
	by mail.openembedded.org (Postfix) with ESMTP id 25C137317E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Mar 2016 13:13:46 +0000 (UTC)
Received: by mail-qg0-f68.google.com with SMTP id 14so12558583qgg.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 01 Mar 2016 05:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id;
	bh=KhtCh/2meYFqglIu4j5CWQOspsOY1D/KcUAuMQ4yBNQ=;
	b=UBJKX3hUJE77XNS89cDMkgZdD4A4NPVLbG+eLOZ+58ch4l9+6JBv+OI2VawTl2gQq5
	Vh3yK6YjmIWpb7UwC4DGTCW4TldofvmDNKjKgT2PCf959rEzNLhjOJ4ji8XhB77V92rY
	yXpVkDDti3Jk/21xrNeggNPJHJE3+OChLpRDhYEpFNfn0CT+tshADdYhxAbU7IezH+8M
	qFp+zpP6DUEAYs/9m1qQRrNW4gt3cHc4uU7z6Bnk0JMkyGc8A3BOpb7IVUieSMWzzSMg
	iBatRIPOfb9Hw1w4MJSrBclSU7gR8Euc2LHND2aYHgdeK5WJ2Rp3Hlqabga77/Etuote
	1GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
	bh=KhtCh/2meYFqglIu4j5CWQOspsOY1D/KcUAuMQ4yBNQ=;
	b=hJ/NLHNN2/3tPkXkdxNj/I3R+LFYJ91nJ1BHfn0bXzCDg58dNSRqTKR3WndLvIwO/1
	0uZ4yG9gUdOejAsEd8uQmzx/Q9kPUMTLuI3XbBldUcotxr92j5/8nfj5BiMHeJ0apgJk
	o0S/EyDI7CirGIqfHw8JamZZ82CcaAb9TRC8zfZS4Tw641glmN+DIYk3h7hhMGxbCF7a
	y7f1DRoyr0hpheGbt+gUJJtV5NH4da0d/xi85IkFmqorwRYulf6+t4iKAoXQHVkhk9Sm
	6DUkKuqGyqiJfxfKtiZTq2ZO4TdrDBSPaVS0WD50x7nja+EiepzZyWTkqYJpy6CvTfhi
	V2nw==
X-Gm-Message-State: AD7BkJK3j11XlawPJT2WraM0BYaShkmkQntqjmRgwEUyYVpE20NVfkLWGF9NXqUgkUIz/g==
X-Received: by 10.140.160.130 with SMTP id g124mr27888248qhg.88.1456838026765; 
	Tue, 01 Mar 2016 05:13:46 -0800 (PST)
Received: from ldnunes.lab.ossystems.com.br ([179.105.251.106])
	by smtp.gmail.com with ESMTPSA id
	a66sm12963385qkb.20.2016.03.01.05.13.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 01 Mar 2016 05:13:46 -0800 (PST)
Sender: Lucas Nunes <lucas.dutra.nunes@gmail.com>
From: Lucas Dutra Nunes <ldnunes@ossystems.com.br>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Mar 2016 10:13:34 -0300
Message-Id: <1456838014-9941-1-git-send-email-ldnunes@ossystems.com.br>
X-Mailer: git-send-email 2.1.4
X-Mailman-Approved-At: Mon, 07 Mar 2016 17:22:11 +0000
Cc: Lucas Dutra Nunes <ldnunes@ossystems.com.br>
Subject: [Documentation][PATCH v1] Server comm: try connecting 4 times before giving up
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
X-List-Received-Date: Tue, 01 Mar 2016 13:13:48 -0000

Instead of trying one time with a timeout of 20 seconds try 4 times with
a timeout of 5 seconds, to account for a slow server start.

Signed-off-by: Lucas Dutra Nunes <ldnunes@ossystems.com.br>
---
 lib/bb/server/process.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 1e2b824..e387b30 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -53,10 +53,12 @@ class ServerCommunicator():
         while True:
             # don't let the user ctrl-c while we're waiting for a response
             try:
-                if self.connection.poll(20):
-                    return self.connection.recv()
-                else:
-                    bb.fatal("Timeout while attempting to communicate with bitbake server")
+                for idx in range(0,4): # 0, 1, 2, 3
+                    if self.connection.poll(5):
+                        return self.connection.recv()
+                    else:
+                        bb.warn("Timeout while attempting to communicate with bitbake server")
+                bb.fatal("Gave up; Too many tries: timeout while attempting to communicate with bitbake server")
             except KeyboardInterrupt:
                 pass
 
-- 
2.1.4


