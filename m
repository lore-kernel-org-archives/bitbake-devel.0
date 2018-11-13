Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id DDDCD6C348
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 22:59:48 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id p4so5988686wrt.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 14:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=jQP9C1w+j/DIpdchyWHs7uHTk5jDc6NZkrTDrCpCmqg=;
	b=WTAKR90XbMnQpd9hgfpl1hXOozu58q26IyIPxz0wht9yFdgh0B5YAY9eyZN5IW1PDS
	tE1Pe+L0eEvwBFNY54sHS0Y+DWWUEfQfEmY/gc87EWolPmcXj5omKZKpjTBkg66XY8Xw
	jeCpNkdchcqJE+FoDJ3ZoRT3PG3yEWhFg4IgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=jQP9C1w+j/DIpdchyWHs7uHTk5jDc6NZkrTDrCpCmqg=;
	b=dDan/nE/CZQZdzic1noSKX54X1TJHq5kvrWKU1O1NoFuEiKZ27+CAb4lNHg/Jml5us
	aB1vm6TDw8HwN1uboatFHbDjl8zn/mqvDUrxAz5046c4YvibtaS0R4WyK+US8+H9bMh3
	oO8ijW61lKRNAbfV6iNdFJHG19Hb/HKvD5Wo4MZNhRraD47TC+Rh9UaVkUXqbrhnKjL1
	HVwBdz9CEAzqAWmIKaTlsAjmWxovRiOwr0WR/8GOrdMVNdHKbAxtyNi7eMC94G2ysO/K
	Qodnst5XQXjW8aORl4BErd5DqkbVb2AXBhOXgVOWQkDEfpMuBV/DyTFC2PZUUGGNQ69c
	iYlw==
X-Gm-Message-State: AGRZ1gL1m9MqqA3ZUxoLAO6Z2BryK0MlKM7e2vvGQsewM897O7VH8wnj
	L+pVm/QVZ12OTHiRAdVlJD0oV7PPqE8=
X-Google-Smtp-Source: AJdET5cIv5vnUhQxMxjFxraZ+qB8488bKBzYXCkgDzsqyJfivUvHRLvUfEkFRd/OTUWrEXprnTEXcw==
X-Received: by 2002:adf:b50a:: with SMTP id
	a10-v6mr6349383wrd.273.1542149989074; 
	Tue, 13 Nov 2018 14:59:49 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r1sm22417109wrx.15.2018.11.13.14.59.48
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Nov 2018 14:59:48 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Nov 2018 22:59:46 +0000
Message-Id: <20181113225946.17829-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113225946.17829-1-richard.purdie@linuxfoundation.org>
References: <20181113225946.17829-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/2] utils: Avoid regex value escape warnings
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
X-List-Received-Date: Tue, 13 Nov 2018 22:59:49 -0000

Avoid warnings such as:
bitbake/lib/bb/utils.py:72: DeprecationWarning: invalid escape sequence \d
  numeric_regexp = re.compile('^(\d+)(.*)$')
bitbake/lib/bb/utils.py:1165: DeprecationWarning: invalid escape sequence \(
  var_res[var] = re.compile('^(%s%s)[ \\t]*\([ \\t]*\)[ \\t]*{' % (var[:-2].rstrip(), override_re))

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1cadbc5bcd..59013d243d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -68,8 +68,8 @@ class VersionStringException(Exception):
 
 def explode_version(s):
     r = []
-    alpha_regexp = re.compile('^([a-zA-Z]+)(.*)$')
-    numeric_regexp = re.compile('^(\d+)(.*)$')
+    alpha_regexp = re.compile(r'^([a-zA-Z]+)(.*)$')
+    numeric_regexp = re.compile(r'^(\d+)(.*)$')
     while (s != ''):
         if s[0] in string.digits:
             m = numeric_regexp.match(s)
@@ -1157,14 +1157,14 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
 
     var_res = {}
     if match_overrides:
-        override_re = '(_[a-zA-Z0-9-_$(){}]+)?'
+        override_re = r'(_[a-zA-Z0-9-_$(){}]+)?'
     else:
         override_re = ''
     for var in variables:
         if var.endswith('()'):
-            var_res[var] = re.compile('^(%s%s)[ \\t]*\([ \\t]*\)[ \\t]*{' % (var[:-2].rstrip(), override_re))
+            var_res[var] = re.compile(r'^(%s%s)[ \\t]*\([ \\t]*\)[ \\t]*{' % (var[:-2].rstrip(), override_re))
         else:
-            var_res[var] = re.compile('^(%s%s)[ \\t]*[?+:.]*=[+.]*[ \\t]*(["\'])' % (var, override_re))
+            var_res[var] = re.compile(r'^(%s%s)[ \\t]*[?+:.]*=[+.]*[ \\t]*(["\'])' % (var, override_re))
 
     updated = False
     varset_start = ''
-- 
2.17.1


