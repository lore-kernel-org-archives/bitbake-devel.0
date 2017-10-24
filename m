Return-Path: <andr2000@gmail.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id 211B46093B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 11:35:50 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id p184so23560707lfe.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ULquoSWLd81vbINWi46tULf0aQOZh85X8eAv65fhrXA=;
	b=cJIsaJGQWmLxEmW7V16GEGU/F6+W9G2yrJJ4/NHdQ2PtOc8JQCeIAykRfgsFSN1Fan
	Xu7s/c2lxdntg/HFMvkQQZNtUR7bC1PpVQy0Jlt4QJasClsY8V8NmTVcMljI11nugzAc
	8G+YnRgslK/qbnrGtr4Uo+Dd8t3mz+fSnGPzJMWORGdUm8Oodl0KbIozDMQ8pmBxc/Bk
	cLxKwmzgVo5GVOV++CYJXMiZz5h3SfomK3puLcJ88+LJuaB1D///rlwiMJigMZ8QP8KR
	3S99Hy7LCHPgoJp9uDvBz4leLlFjjUtv7gG6nE8nAHwd4A5ek2mMMtPPO7vwqEYsGJNL
	Cakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ULquoSWLd81vbINWi46tULf0aQOZh85X8eAv65fhrXA=;
	b=avJwiNN21ztMjVg7M8+5qIXa5ztuJocGErMz4+hSOlV+kdButdpr5A16yxKhVZjn8b
	apuCM5EeHiovdWAWbo3/5tOgm8mGd0e8HsVI74zFa7WZ5Y+EiT+FgmraelhpMLep4/FQ
	A12/1HKESbkKTmZ9Up6F038OPYqtrZ5H6A3ZM1CA3F5iwaT1wQ3NgEeQ/RcsTUMFKqMX
	83TijMgFycYXOvUYzVZp2tEt/d/NdEsMbeceUzSd00ZmJoY15WZrZHcNRlSwyBrbcimK
	Dg4LPlFRrdOnHYdFtkGWEqUsF+Ds9LoYMJ5MwCSmnwOq95vYwmFRNRDJlHhWeb0XEtsP
	OKUg==
X-Gm-Message-State: AMCzsaUAH3si5j7jv/F7fsGttLL4MeM8PIiqh+liqOYZVsIRbcqgURBh
	VMHqnAys/JWn8mbJ4/2R66lLPQ==
X-Google-Smtp-Source: ABhQp+QmHBxelnFFfK/wz8u2kuv+u7zTCjknAPxvGLmnjpOS15+HpasFdvsn4Un4tAfHARG1h8w7aQ==
X-Received: by 10.25.67.30 with SMTP id q30mr5311741lfa.118.1508844951367;
	Tue, 24 Oct 2017 04:35:51 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com
	(ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
	by smtp.gmail.com with ESMTPSA id h82sm18166lfb.21.2017.10.24.04.35.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 24 Oct 2017 04:35:50 -0700 (PDT)
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Oct 2017 14:35:41 +0300
Message-Id: <1508844944-5761-2-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
References: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
X-Mailman-Approved-At: Fri, 27 Oct 2017 14:42:08 +0000
Cc: andr2000@gmail.com,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 1/4] fetch2/repo: Fix missing logger import in repo fetcher
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
X-List-Received-Date: Tue, 24 Oct 2017 11:35:51 -0000

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

After cleaning deprecated API usage repo fetcher is missing
logger as it was indirectly imported via deprecated bb.data.
Fix this by importing logger directly.

Fixes: 9752fd1c10b8 ("fetch2: don't use deprecated bb.data APIs")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 lib/bb/fetch2/repo.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 1be91cc698e3..c22d9b5578eb 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -27,6 +27,7 @@ import os
 import bb
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import logger
 
 class Repo(FetchMethod):
     """Class to fetch a module or modules from repo (git) repositories"""
-- 
2.7.4


