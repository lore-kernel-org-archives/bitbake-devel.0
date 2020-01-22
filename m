Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
	[209.85.216.52])
	by mail.openembedded.org (Postfix) with ESMTP id CCCC27F7B1
	for <bitbake-devel@openembedded.org>;
	Wed, 22 Jan 2020 05:25:07 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id d5so2568448pjz.5
	for <bitbake-devel@openembedded.org>;
	Tue, 21 Jan 2020 21:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=xM+/DSBKnfiQkHh9HWVc98yi7bosXBmvGwJqMo1uzzg=;
	b=jIZhdi3eTCiS54XSiuKv3oEMCRfJVWNbUyfhVl10+R6TebCRn4p3ybF2PHAsyzFRde
	RJT18JpgQBTH4Z4vlZdqbx2pnN2/QTO4N79K9L+sDBnLsS8OyKkpXEdgWTfXGft7qJAK
	hLUkTvoLMfpRLzSobvvXxGA2XuJX/a51CpIyNaFF8W08vRa1cPQEvSNd2YrxFESyIHU2
	m7xW0zn2hUMPvFX2O9qd49U6sC5LEbrgiF1+eKATRrQs3nkwMaVvW0LZpgbpawVosmWl
	orKxChSoOeqF4gf1JMtnM+YeOKXGV5hUGel4MeksG/JtwkWVoP7pbz728cebjH0JkZIr
	49tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=xM+/DSBKnfiQkHh9HWVc98yi7bosXBmvGwJqMo1uzzg=;
	b=NcV4u1XqNKZAalqO6J9QyR6Dob3dRnA/3xhVtFnQxPMGqS44LzpjesHd5YxTQ1yWea
	K5xYDY0W8pXqGxoien3LuFWrPXUSVjmkyjhnY3aWpP+o4dCAUe6G5NBcOrg2GPsc2HBt
	0yMlP+7+mhcPBynUIbMIdzxIhc/kZM7Qulq47ibnoNApwMEjYFXZVZz4EwkiaoLjIu8b
	4QBhdtG/w31zreSepysQ+c1XUjtv5obbwO8yN6c2hx/4IIhvwIqsM62tbbMufw5sUZPJ
	oPgLSBxxCmvglAWtJwa7LmHNdVPpF2u53V9v5fXNiIiNc3pcJLzRuDKSB+sRH52J72hr
	OiDQ==
X-Gm-Message-State: APjAAAVKB2QjDQ1fJTZ4yoH2UY3HX10EB7MJatLsdtXqxUxlSffGp8rX
	6zU4apIY0A8LFYjjsqg5DQ5muwyQ
X-Google-Smtp-Source: APXvYqwXQqcxujnRnAUMNA41C18Af+kl1DiT5eWSoEnB3mmmwjUkja8TKVucqIlMME+0/NwVbojAKQ==
X-Received: by 2002:a17:90a:c214:: with SMTP id
	e20mr1024576pjt.98.1579670708515; 
	Tue, 21 Jan 2020 21:25:08 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:682c:76b9:6d8a:bbd2])
	by smtp.gmail.com with ESMTPSA id o7sm1228628pjs.28.2020.01.21.21.25.07
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 21 Jan 2020 21:25:08 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Tue, 21 Jan 2020 21:25:00 -0800
Message-Id: <b7ecb1d0232c12b8388ae516b1dbd025ad782d56.1579670574.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579670574.git.akuster808@gmail.com>
References: <cover.1579670574.git.akuster808@gmail.com>
Subject: [1.44 2/4] knotty: Hide the footer if a process progress bar is shown
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
X-List-Received-Date: Wed, 22 Jan 2020 05:25:07 -0000

From: Peter Kjellerstedt <pkj@axis.com>

With the introduction of the hash equivalence server, the progress bar
for "Checking sstate mirror object availability" is shown repeatedly
while the tasks are being executed. If the footer is not hidden then,
it will be moved up one line every time, creating a messy interface.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 56b5ec4c2b3e658e73ca6c3a12feeb96df0977fb)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/ui/knotty.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index bd9911cf..ddcb2148 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -477,7 +477,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if event is None:
                 if main.shutdown > 1:
                     break
-                termfilter.updateFooter()
+                if not parseprogress:
+                    termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
                 if event is None:
                     continue
@@ -539,6 +540,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     continue
                 if event.total == 0:
                     continue
+                termfilter.clearFooter()
                 parseprogress = new_progress("Parsing recipes", event.total).start()
                 continue
             if isinstance(event, bb.event.ParseProgress):
@@ -638,6 +640,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.event.ProcessStarted):
                 if params.options.quiet > 1:
                     continue
+                termfilter.clearFooter()
                 parseprogress = new_progress(event.processname, event.total)
                 parseprogress.start(False)
                 continue
-- 
2.17.1


