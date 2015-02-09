Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 6F64A732A4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:00 +0000 (UTC)
Received: by pdbfp1 with SMTP id fp1so2149101pdb.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FYBnBX3pdv9CZRLbPx31v6XI0YZ4ky+4eQDsLzol25E=;
	b=XDQoD3dksNANv1zGWLRJUvUrWhGfB5bpTfH2Kr7ZXGFALy/cJIoJFAriCk7BJKvAof
	+ve2HdF+T6Zg6Qq+5ilQ80rJShJiVs/8yTJx7frDhb/JWQGcP7snskeBvwK1a3GnYcX5
	uQ9hTlePr6XQq6qmwAXzgY43ytefPLfZQFutzkTpKoZTcZBZovWpQFYKbhHJUqlBaF/3
	vXB8YPeXZ6qOAaz9jkcEHZEsRN6u2vYRyoLaDENNzJoDCsmD3DxTsmiocV5PsJzPVIv/
	ipVoH1Mtg6Ukw11MolNpOpPGitOpkhSahUSv7UaaHq5bdLgRO7X/PX0fxqZcZ316n0FN
	SDLw==
X-Gm-Message-State: ALoCoQlPI2YhPcY9I80C21YgHHlerQHR+lbyrZH0rln560D8aZU49RTiFDK1IvVzd9OWFyFk5JFX
X-Received: by 10.70.43.201 with SMTP id y9mr7051755pdl.4.1423504922022;
	Mon, 09 Feb 2015 10:02:02 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	bc1sm17121478pad.12.2015.02.09.10.02.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:01 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4A22756618E; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:33 +0000
Message-Id: <f28fb3d660d8726b75e6c31fa36bc22b54e1bca7.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 03/27] toaster: correct typo in toaster script
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:05 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

A small typo slipped in the message included in
the fix for [YOCTO #6023].

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 bin/toaster | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 85a2575..6f7c6f0 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -242,8 +242,8 @@ if [ ${CMD} == "start" ] && [ $lock -eq 0 ]; then
 fi
 
 if [ ${CMD} == "start" ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
-    echo "Error: bitbake appears to be dead, but the webserver is alive. Something fishy is going on." 1>&2
-    echo "Cleaning up the web server at to start a clean slate."
+    echo "Warning: bitbake appears to be dead, but the Toaster web server is running. Something fishy is going on." 1>&2
+    echo "Cleaning up the web server to start from a clean slate."
     webserverKillAll
 fi
 
-- 
1.9.1


