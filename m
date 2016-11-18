Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
	[209.85.214.52])
	by mail.openembedded.org (Postfix) with ESMTP id 2B2486078D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Nov 2016 15:23:30 +0000 (UTC)
Received: by mail-it0-f52.google.com with SMTP id y23so36644149itc.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Nov 2016 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2nn+e6lM6bolr21XFZXGsleBrcCuL0sT7DXR7E7MPQQ=;
	b=ZX4AFzOnkV2KdnhFMm3M253DbGSVvKujGlXqlnaQIXJ0npIRUAj6zD0jSkRupqwLHT
	GfkOnBExme3dyHw68tijyTJwe5podQ+ffxXkZVyS/ym9danTm5shuzr81IRei1mf/5vI
	9qjpg59p/VJMdw+gnhfRUtXKHP2Z8Xs/16A/c3dyt4yU9OSSm6fp3w18emtQhLuOzgWd
	bwTuKQLBML5Tn70a/WGdwxr8apVelTYKZ89OIpruyCPle5le1uirBBmuaufCMm92MNtO
	+bhf9wKLYGuCNnK5EodfcQqCwgY/+nhHwd9Vma4iDVJv1WbjOEnErQ7I23GDPoPX92Ix
	wkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2nn+e6lM6bolr21XFZXGsleBrcCuL0sT7DXR7E7MPQQ=;
	b=C+X40DPBm2i6sy7YOb32KSuLHyLQph1hQBLtz4rXMkWLqp18mTY9ht1YYCSClYo4Na
	NhjSYdjXN0nCW/szZCdCV51lYZfobIP7FaT0pKUVLOgggsGaZdM5inlz0ncK+ClfKdcp
	ihXu1MEhsMiy45bt/ymInC77pYtN0JPt01BMcAjUlP/Xb5YzCY5W+qcNOL2hyr4eRuLK
	pROWAAUzjerBaUWpxxRrNVaH9YDE9bXJP4A1MIEtLC/edBydOxbVxTLpoBSYLA6eRbAX
	QnjkF8SPNkK6hl7hclF23gxK3g2lb8twIXujXukoPVYV7K8ggY58ZYUkQeI0+MdtH9AG
	D0Ow==
X-Gm-Message-State: AKaTC01HieZhr7gjFy66L2yXAFaseipcOVojlJltoPGaXKNzaxHpJ/Q75VdtaAJEmNTjeC9d
X-Received: by 10.107.169.221 with SMTP id f90mr183718ioj.107.1479482611988;
	Fri, 18 Nov 2016 07:23:31 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8EE38.dip0.t-ipconnect.de.
	[93.232.238.56]) by smtp.gmail.com with ESMTPSA id
	g127sm1143229itc.7.2016.11.18.07.23.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Nov 2016 07:23:30 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 18 Nov 2016 16:23:22 +0100
Message-Id: <1479482602-9750-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1479482529.27625.76.camel@intel.com>
References: <1479482529.27625.76.camel@intel.com>
Subject: [PATCH] codeparser.py: support deeply nested tokens
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
X-List-Received-Date: Fri, 18 Nov 2016 15:23:31 -0000

For shell constructs like
   echo hello & wait $!
the process_tokens() method ended up with a situation where "token"
in the "name, value = token" assignment was a list of tuples
and not the expected tuple, causing the assignment to fail.

There were already two for loops (one in _parse_shell(), one in
process_tokens()) which iterated over token lists. Apparently the
actual nesting can also be deeper.

Now there is just one such loop in process_token_list() which calls
itself recursively when it detects that a list entry is another list.

As a side effect (improvement?!) of the loop removal in
_parse_shell(), the local function definitions in process_tokens() get
executed less often.

Fixes: [YOCTO #10668]

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/codeparser.py | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 25938d6..5d2d440 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -342,8 +342,7 @@ class ShellParser():
         except pyshlex.NeedMore:
             raise sherrors.ShellSyntaxError("Unexpected EOF")
 
-        for token in tokens:
-            self.process_tokens(token)
+        self.process_tokens(tokens)
 
     def process_tokens(self, tokens):
         """Process a supplied portion of the syntax tree as returned by
@@ -389,18 +388,24 @@ class ShellParser():
             "case_clause": case_clause,
         }
 
-        for token in tokens:
-            name, value = token
-            try:
-                more_tokens, words = token_handlers[name](value)
-            except KeyError:
-                raise NotImplementedError("Unsupported token type " + name)
+        def process_token_list(tokens):
+            for token in tokens:
+                if isinstance(token, list):
+                    process_token_list(token)
+                    continue
+                name, value = token
+                try:
+                    more_tokens, words = token_handlers[name](value)
+                except KeyError:
+                    raise NotImplementedError("Unsupported token type " + name)
+
+                if more_tokens:
+                    self.process_tokens(more_tokens)
 
-            if more_tokens:
-                self.process_tokens(more_tokens)
+                if words:
+                    self.process_words(words)
 
-            if words:
-                self.process_words(words)
+        process_token_list(tokens)
 
     def process_words(self, words):
         """Process a set of 'words' in pyshyacc parlance, which includes
-- 
2.1.4


