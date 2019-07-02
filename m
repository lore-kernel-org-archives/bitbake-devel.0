Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5F5007EBC2
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jul 2019 11:05:40 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id p11so17301107wre.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Jul 2019 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=FBO83pLlrCmzqqEi2SG1lW5sQBoSTnHY9BKasqvtMe8=;
	b=Y+NvTM78Gr8EbkI6pn/HqW2bc6p33geEoUAgTCAtFf2vFh3sanUOVWPzaauMpjqO59
	rwBYOA6nKd0+MRo3eLUWEIguMU+EoQweYWp0FcppgDL1awUnLjjpYc80kVrCgTqgRS5d
	teRea8B8ZIYTx33XDQYheiZzG6JWkdDtagzII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FBO83pLlrCmzqqEi2SG1lW5sQBoSTnHY9BKasqvtMe8=;
	b=mv9I4R/sSACqS2UzKERoND7idFAf6n8l29/sfry+o2pkwWdlHta5KaRwIblhDwqLOj
	AyywANwsLTowmMO5ez4ICQSCLtW0lJLGVBGvLTg1aOfWrdZfa2Sd6S3jLsVbfH7J8sbj
	1EhPc6VBpXIUU6dB3gNraRA6Fo/QBtcS/JGZ5GhLG3QBY2mYk3BTh383mlpf6ateyyXP
	9KVhV5gBjjsUwMflnlPJCrZjSCZAw9Tc5NCnsNCie1M62XF7sR6r1DqLZz+t09dWQKPo
	6erlbOCMd1wf84rsI0CHg8yZ+xa3hXioBmxCFCYcyK3VFA9dzIb2sQllW3cUhwz/LUOX
	jxVA==
X-Gm-Message-State: APjAAAXv9EuF0c/XShZQEqDF7XXdHOruVXZDG2w8FLdn/EH1hhjquxgZ
	AOc/ozUZDkg5PAHgt8d6h1hVPEzz65w=
X-Google-Smtp-Source: APXvYqxdtKVfJeiXhbRDNfBAzXg8CllzTsBOKFMzNqX1XwCCxzBSKDp4y7uPLu2mwsl4kAqfeC/uDw==
X-Received: by 2002:a5d:4849:: with SMTP id n9mr23032719wrs.139.1562065540880; 
	Tue, 02 Jul 2019 04:05:40 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm2801068wrw.23.2019.07.02.04.05.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 02 Jul 2019 04:05:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Jul 2019 12:05:37 +0100
Message-Id: <20190702110537.13349-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702110537.13349-1-richard.purdie@linuxfoundation.org>
References: <20190702110537.13349-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/3] main: Alter EOFError handling
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
X-List-Received-Date: Tue, 02 Jul 2019 11:05:40 -0000
Content-Transfer-Encoding: 8bit

If the server shuts down 'cleanly' due to some issue, the socket will close.
A recently reported example was an invalid PRSERV being set. Doing this silently
and without changing the retries count will case the server startup to loop
infinitely.

Change the code so it triggers the usual retries note messages and times
out eventually pointing the user at the cooker log file.

[YOCTO #12984]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index a1226886c0..3071141b55 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -447,12 +447,7 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                             bb.utils.unlockfile(lock)
                         raise bb.server.process.ProcessTimeout("Bitbake still shutting down as socket exists but no lock?")
                 if not configParams.server_only:
-                    try:
-                        server_connection = bb.server.process.connectProcessServer(sockname, featureset)
-                    except EOFError:
-                        # The server may have been shutting down but not closed the socket yet. If that happened,
-                        # ignore it.
-                        pass
+                    server_connection = bb.server.process.connectProcessServer(sockname, featureset)
 
                 if server_connection or configParams.server_only:
                     break
@@ -463,7 +458,7 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                     raise
                 retries -= 1
                 tryno = 8 - retries
-                if isinstance(e, (bb.server.process.ProcessTimeout, BrokenPipeError)):
+                if isinstance(e, (bb.server.process.ProcessTimeout, BrokenPipeError, EOFError)):
                     logger.info("Retrying server connection (#%d)..." % tryno)
                 else:
                     logger.info("Retrying server connection (#%d)... (%s)" % (tryno, traceback.format_exc()))
-- 
2.20.1


