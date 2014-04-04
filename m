Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 2A4426EDF9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:11:00 +0000 (UTC)
Received: by mail-wg0-f50.google.com with SMTP id x13so3484312wgg.21
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RmOICc00sxWpch5AcA+OSi8cTHR70n2I+fmBlZin0g4=;
	b=BUpy6wkYuKgSLQVDSovlshistXvQ9rwFplBlKIiDKL95tmSqkNBN3RWwyc46ljXp9m
	HE82AnjsHuyhpZx3J2ZIPm6aESuY1SQM2X3slXH/RW1MQjGrNKpWunSkWU4ldsVrhZ+9
	sos4Yvxe+aWuJuOM00ZA66S74YC40UnxTHtr5eHQpabGjHUGQIOaN0jqY29nWpI91px3
	uAPvt3cUgo0UwEajfkPhQIYiBUIATqyMiyxfFZzMOt+uR1xbzfV7vrP0/Ot1QcxXPyVY
	BaHg9c7rIoaYPRzKt9Hf3B01lhDuuNG3m2/A/eusCyGrNRA/A50GjLAQkvml2x4eix0R
	8O8A==
X-Gm-Message-State: ALoCoQkJnrMQk4YMEtLo3DsizmJVBwKBBnmRzyk1zrmdwzc6AwKR/y8QQf/J6jyOv7IuO0EnGqqq
X-Received: by 10.194.192.132 with SMTP id hg4mr20459664wjc.28.1396620660901; 
	Fri, 04 Apr 2014 07:11:00 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hi1sm12623212wjb.17.2014.04.04.07.10.57 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 939005609CB; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:50 +0100
Message-Id: <dc171602d99b180b49ed1e6c34a0409c005bc8c4.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Subject: [PATCH 11/14] toaster: Make tables happy in Chrome
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
X-List-Received-Date: Fri, 04 Apr 2014 14:11:00 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

There is a known layout issue with Bootstrap tables in
Chrome. This change applies a css fix for it, and changes
the span classes in the variables table to improve
formatting.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 3 +++
 lib/toaster/toastergui/views.py               | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index b4345da..baf70fb 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -109,6 +109,9 @@ select { width: auto; }
 .hero-unit > .close { font-size:40px; }
 .hero-actions { margin-top: 30px; }
 
+/* make tables Chrome-happy (me, not so much) */
+#otable { table-layout: fixed; word-wrap: break-word; }
+
 
 
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index ba69dd8..e346ac4 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1142,7 +1142,6 @@ def configvars(request, build_id):
                 'tablecols' : [
                 {'name': 'Variable',
                  'qhelp': "BitBake is a generic task executor that considers a list of tasks with dependencies and handles metadata that consists of variables in a certain format that get passed to the tasks",
-                 'dclass' : "span3",
                  'orderfield': _get_toggle_order(request, "variable_name"),
                  'ordericon':_get_toggle_order_icon(request, "variable_name"),
                 },
@@ -1153,7 +1152,6 @@ def configvars(request, build_id):
                 {'name': 'Set in file',
                  'qhelp': "The last configuration file that touched the variable value",
                  'clclass': 'file', 'hidden' : 0,
-                 'dclass': "span6",
                  'filter' : {
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
@@ -1169,7 +1167,7 @@ def configvars(request, build_id):
                 {'name': 'Description',
                  'qhelp': "A brief explanation of the variable",
                  'clclass': 'description', 'hidden' : 0,
-                 'dclass': "span5",
+                 'dclass': "span4",
                  'filter' : {
                     'class' : 'description',
                     'label': 'Show:',
-- 
1.9.1


