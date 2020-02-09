Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
	[209.85.215.171])
	by mail.openembedded.org (Postfix) with ESMTP id 4A81E6080B
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:19 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id d9so2529940pgu.3
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=hPVe+HGI+fHTsR8FunkMSIaclgqSck7cOqdYvkNTv9s=;
	b=ZQoSfsojs1smiyEsAnvHb93Q34+Ye43PbQRQRIdL24uAI0ICjPI0BkxbMpbtPOscz0
	tugC6YwJZql9Q3KFDa2Dm+ahgFKJoWKH7naZ/o9RUQ9q7oNiP/UwZ1/HnpWUEF0DN/x9
	oTTGJn9bS77HgGA5gtB4l8v/TOLIwO5vfngOTbfmHEXw+X6W01sJN+NfX129Ov9qQ7/g
	Kil/IUFjAQlMajledRT9jLigivHAOjTJNgutFSuULNPHp+8o3vvQrgKnplzQpW6iNVtY
	uaJ+RhFzoCcv45OjV/KorAqOlqpH88oDKcluiHBH3uXlaeAoTEbd44zOEpa1qrNyWmci
	Xxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=hPVe+HGI+fHTsR8FunkMSIaclgqSck7cOqdYvkNTv9s=;
	b=R4EBIUgwuK5P2jGj+q+tcnJUuf5Y8njxOVdbyJMjF3TGHCNt4evhpH5nz09TZFH8gL
	uQb3xDg9ZIHNsC/sIejb4bpH4PuNPdU4wScpL+SWEF7oe8OI4XcJu12j+zInkHX3GoHS
	Cb6YXwB1sCczkVBw1acjNPj/ZFyB4Eqd1cVTeOya4RV1x0rC4QC4QBBobg7ecdAHJnjm
	pDolzUDxVcsfSok/blxu8EV/AvFTR8PGJOIJEUKSPjP/PCLCKl0CJqn+zuPZJZ0uJ/OF
	RI9X8sq/Lvrbb6ez+Frmx0L3OS9dbKZj0Zes7nTVXtqJ75XZ2fdaBT63K2dxwW2LbWIE
	6eXg==
X-Gm-Message-State: APjAAAWYQlSDzHQFJn1NOXzJo4dG+tKZBPbDPiQ/s7pwci6c2DG53egi
	owNUtDtu/RhXK0nAaLWHRzOxNSng
X-Google-Smtp-Source: APXvYqwfmA1pIBWEbtfJJy9Q8STDSg0ww80dpeirnwP74u0jbkmzqBAADp/FfJQy2GhhGMm5BWvT8g==
X-Received: by 2002:a63:5220:: with SMTP id g32mr9715260pgb.116.1581264200434; 
	Sun, 09 Feb 2020 08:03:20 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.19
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:19 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:10 -0800
Message-Id: <716cdf737bc536f84ed1254d464c9f286e0d5a9a.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1581264053.git.akuster808@gmail.com>
References: <cover.1581264053.git.akuster808@gmail.com>
Subject: [1.44 2/7] fetch2/git: _revision_key: collapse adjacent slashes
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
X-List-Received-Date: Sun, 09 Feb 2020 16:03:20 -0000

From: Chris Laplante <chris.laplante@agilent.com>

From a SRCREV caching point of view, there is no reason to treat the
following upstreams as different:

    SRC_URI = "git://github.com/file/file.git"
    SRC_URI = "git://github.com//file/file.git"

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 425e21c14955dd38868c6e97637df3bbe0f89fac)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index fa41b078..9ba9cdcc 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -594,7 +594,9 @@ class Git(FetchMethod):
         """
         Return a unique key for the url
         """
-        return "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]
+        # Collapse adjacent slashes
+        slash_re = re.compile(r"/+")
+        return "git:" + ud.host + slash_re.sub(".", ud.path) + ud.unresolvedrev[name]
 
     def _lsremote(self, ud, d, search):
         """
-- 
2.17.1


