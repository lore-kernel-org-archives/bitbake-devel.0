Return-Path: <stevenrwalter@gmail.com>
Received: from mail-yw1-f65.google.com (mail-yw1-f65.google.com
	[209.85.161.65])
	by mail.openembedded.org (Postfix) with ESMTP id 787D77FA18
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jan 2020 22:15:40 +0000 (UTC)
Received: by mail-yw1-f65.google.com with SMTP id 192so10151211ywy.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jan 2020 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=PafM3le3UIvkAHBQrd889FJ0OdF5YEYf3qeWe3aDv8M=;
	b=KYPerDqhE5SOBgmG+M2kXzmmr4IvRbVSI6mBxqWHb4QBCf+QcY/3UF8NjtOVeN2vw/
	UVAdL2UNRxYk4E3gAaGZRRx6DVHY31xL2OX8SZZ6iXnTaGDGDBszmM82xQZFbKzhQytr
	M4eYLYAHtuworm/1u19QKkaXlEroQsWJj3T76X1QzpTcEgTk0dp3vDx6257xvZjpl11Y
	NqXk/WO1x5TbkCWsrk3YACUCAvOFDnPDxDyDgK5lQCIQd6o4EryrvgL4OvvinlyljeOP
	sFgJ2E7BJrg30SJEVlxfV47SUNeuLoR4oqderNxqqHd9P0lu8tW0KdjnFrknwaQilnAh
	0Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=PafM3le3UIvkAHBQrd889FJ0OdF5YEYf3qeWe3aDv8M=;
	b=N3239ioDdprx8co9JkSYPnDJjyuWJIPoAFJxgbFgVOI6WgBTOqGDw3whSDchmqrpZU
	eDwwFAR4knUosAarW+Xf++yvHRSi86gWNXz+N3mUCrbIUpSLYuNdQOKqVQJq7DrcpBhB
	bNNc9KhkksiDeig2mVttwTrNe4CiOlXZ22qhp2P+XqboYDux+ZPTSC+29gnlk7dNg44u
	9E/qDdkkqmQr7ahOtaTV5F3BrEr48Ecebe+Fx/REgKPnam6o85TkKs1c7Yym9L/ibS+P
	BZJnbc8qKOaCb+oALFGvfn1gdL8ajF7HAAHlVjLOCWlxb5CN2dM+ShpZxe/yt7oGay5P
	E3fw==
X-Gm-Message-State: APjAAAWqXUbx01SWA//Ud2ngwzOC3RExZIb/vW1Mkhjt81f+IryaonMX
	7UDXmuR8pqDqZi5xKt5QB9IdJP7Q2bw=
X-Google-Smtp-Source: APXvYqzey/tu3YSr28LA47UJNSnf1z2YN/Ytq+hlZk9eQkJJXev1gTWALVg8s9faUaTsNWHqWJGiIw==
X-Received: by 2002:a81:8350:: with SMTP id t77mr14624676ywf.442.1579040141134;
	Tue, 14 Jan 2020 14:15:41 -0800 (PST)
Received: from brock.localdomain ([2605:a000:1707:25a:1de4:eabf:e8ce:977a])
	by smtp.gmail.com with ESMTPSA id
	h193sm7151148ywc.88.2020.01.14.14.15.40
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 14 Jan 2020 14:15:40 -0800 (PST)
From: Steven Walter <stevenrwalter@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jan 2020 17:15:36 -0500
Message-Id: <20200114221536.5647-1-stevenrwalter@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH 1/2] Allow original $GPG_AGENT_INFO into do_fetch
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
X-List-Received-Date: Tue, 14 Jan 2020 22:15:40 -0000
Content-Transfer-Encoding: 8bit

subversion 1.9 uses gpg to encrypt authentication details that are
stored in ~/.subversion.  This means that GPG_AGENT_INFO needs to be
available when svn is run by do_fetch, or else svn will not be able to
authenticate to the remote server.  Treat GPG_AGENT_INFO like
SSH_AUTH_SOCK, including it in the fetch environment and BB_ENV_EXTRAWHITE

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 07de6c2693..e920d5f491 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -819,6 +819,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
                   'GIT_SSL_CAINFO',
                   'GIT_SMART_HTTP',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
+                  'GPG_AGENT_INFO',
                   'SOCKS5_USER', 'SOCKS5_PASSWD',
                   'DBUS_SESSION_BUS_ADDRESS',
                   'P4CONFIG']
-- 
2.24.1


