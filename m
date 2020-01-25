Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
	[209.85.215.169])
	by mail.openembedded.org (Postfix) with ESMTP id 39C8D7FD6A
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 16:01:12 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id b9so2772049pgk.12
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=xM+/DSBKnfiQkHh9HWVc98yi7bosXBmvGwJqMo1uzzg=;
	b=ZDW0ICT9YA/IbR+Qy1T1OZjeAp5xWkQTQ2TJoC1LVlvA9Lj1tJf2zFhgDPrddggH10
	u0jOUh3N7/UFzCFbitMmiw3CC5UlMmfZwX/p/kD9gA2rjE5N0wSFIfbbcN1B0u+iq0aK
	esAxZX4zVZ3YdMMhY5DBl+QcXCNaMYZd6YVaARzuTyD+DTZb69o/ExGjlPT483nYzRBx
	/kRWxcHemdFlx0xcR+3qJPsu5R19Wah0PvowoQHIIMCT6+jV/OAOHAf4chDQWfh9IFDL
	0+a8jFXMcYO/RJivRsYMrlZY4kgXxCKK/rwjFLDnlnE5wArtMtXj//qXgUf+X2ZfF0VL
	pFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=xM+/DSBKnfiQkHh9HWVc98yi7bosXBmvGwJqMo1uzzg=;
	b=o/VVfqNM2okUIwJrMEDYlimC3JsfrPptoZCS7XdI3I0gUsTGD2COFoFekpu+cgr5qf
	T6TpoWALSNPrX5X6tyywM9OmGxWf+CsHkxUt0WbhkHDznjO1ue5IZwaR0vjW/dhnr13I
	yvtc31SNbGMvp3GSEe5V8z5ZBZH6jt3uZq4pfEkdctTHvuXt3WjTBDE4w5icxbTNFPLH
	63knkKOw5iTMnYjfxUi47hAViLAFT6chmnwLF3tvoMeuniMDO0qQgR68IVmuLUNJO6me
	TRTNYGBDbhAvVh+YPaUtveGdprTvC7lcsNnEKTxH0avwID53r8CHMcjRY2RBOGvABSAE
	TJyg==
X-Gm-Message-State: APjAAAVrMs5hnryqKGmk+SCcZICKtGLticK+gstGoxNxmuluao7ttms1
	MRSEFrIVVFGpiEKjkBxoS5MhNi8F
X-Google-Smtp-Source: APXvYqwRWc0eDQKJ9N9UiTZooxOR9Kq7VzA4Kymjye2Jiw/Vc6JhIcmIrfHmNVOBwyhxVOhRjeXePQ==
X-Received: by 2002:a63:4b48:: with SMTP id k8mr10279488pgl.362.1579968073987; 
	Sat, 25 Jan 2020 08:01:13 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:953f:6ade:6955:1d1c])
	by smtp.gmail.com with ESMTPSA id j9sm10291064pff.6.2020.01.25.08.01.12
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 25 Jan 2020 08:01:13 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sat, 25 Jan 2020 08:01:06 -0800
Message-Id: <b7ecb1d0232c12b8388ae516b1dbd025ad782d56.1579968003.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579968003.git.akuster808@gmail.com>
References: <cover.1579968003.git.akuster808@gmail.com>
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
X-List-Received-Date: Sat, 25 Jan 2020 16:01:13 -0000

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


