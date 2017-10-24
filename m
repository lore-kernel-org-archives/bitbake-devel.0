Return-Path: <andr2000@gmail.com>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
	[209.85.215.65])
	by mail.openembedded.org (Postfix) with ESMTP id A9B1071974
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 11:35:52 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id a2so1522169lfh.11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4UWAwH/oSnQoNIQHcPeIH84UGfTzhd4FI8hrnmUJdRQ=;
	b=hzRxZqrHnVpo8KMEDBSHzSYQ92OGSNxYY9cWMyXPR6ExWlfMySewsigdaJgbmJCnij
	8V0KhqbPcyqY6YQAaf+jtEQ3MDF4SLWSq3PifTutRlFPoC0Cerbp4++p6O4c0VbABIXP
	QQ9pJLT23v6Z3qE5I6iXgWQMNuXFZAFEGgWPodkQ4OBSk/GR/BDAk/CftJZ4c+kQPMWb
	pYey9DsG21WOLQ3TYxO5UaIc8hGE++hxKOA0xyH2EWoj/SHn/JuOTy854SkMge+G6j+Y
	YE65GJpKMcpYVBE8VW2NvXHE8dtxggrzT9pOZQUY66OneYnME6/8voohPwd2Tg+oBxyI
	FOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4UWAwH/oSnQoNIQHcPeIH84UGfTzhd4FI8hrnmUJdRQ=;
	b=YgWq6niQDYFeI7okDZ9wH0zAvumspq0Twu8fQ20lFc5eCVLsAWqwvMpSINLN4ySf0j
	WGPHwg8Uk/rPjL6s2u6wh81lchYO+OKmphM46zgtaeZN6zJ74sQ1xLnWNE8jeAV8RlFy
	2V8uKalg0N8pgi1m94nsST4f1PrLvoK7bD0CLod40610S0AtOUOfincEZ72769nVXRXK
	5dwN2UwxrdRuD9jsLKgFtl+XAhlStzBEXtVAZ3qnPR1xQ0ctnAj+xRTDECb7S49c1mYE
	8v2x9fMl3hZa+Npc5mb+JWyUz7uOM5j6uz3g/TLhHT9IwPMBHq97crnK0Ts5v5FkKMS2
	7k7Q==
X-Gm-Message-State: AMCzsaXjLLD8mGnEhBupzq+Ihd2yOMlu+qIjtCD2OvxT5AwyvyRd3GKx
	cSp53YzTR47kJCObFk2OSZtlgA==
X-Google-Smtp-Source: ABhQp+TXZVvPW0DJKtin4jV0Bd8R8WEdVLFd3YwSXI91VWP/lKV8K9Kbc99sGV4hMwyk9wPmh9931g==
X-Received: by 10.25.151.206 with SMTP id z197mr5341337lfd.3.1508844952790;
	Tue, 24 Oct 2017 04:35:52 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com
	(ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
	by smtp.gmail.com with ESMTPSA id h82sm18166lfb.21.2017.10.24.04.35.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 24 Oct 2017 04:35:51 -0700 (PDT)
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Oct 2017 14:35:42 +0300
Message-Id: <1508844944-5761-3-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
References: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
X-Mailman-Approved-At: Fri, 27 Oct 2017 14:42:08 +0000
Cc: andr2000@gmail.com,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 2/4] fetch2/repo: Always check if branch is correct
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
X-List-Received-Date: Tue, 24 Oct 2017 11:35:52 -0000

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Current implementation doesn't pay attention if
the same repository is used for manifest, but different
branch, e.g. existing cached repository is not checked
if the branch is correct. Fix this by always running
repo init/sync.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 lib/bb/fetch2/repo.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index c22d9b5578eb..861437dd22b2 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -71,9 +71,8 @@ class Repo(FetchMethod):
 
         repodir = os.path.join(codir, "repo")
         bb.utils.mkdirhier(repodir)
-        if not os.path.exists(os.path.join(repodir, ".repo")):
-            bb.fetch2.check_network_access(d, "repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
-            runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
+        bb.fetch2.check_network_access(d, "repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
+        runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
 
         bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
         runfetchcmd("repo sync", d, workdir=repodir)
-- 
2.7.4


